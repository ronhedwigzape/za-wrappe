<?php

namespace App\Http\Controllers;

use App\Models\CustomerVerification;
use App\Models\Inventory;
use App\Models\Notification;
use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class OrderController extends Controller
{
    public function fetchOrderSummary($orderId): JsonResponse
    {
        $order = Order::with(['orderItems.product', 'orderItems.product.inventory'])
            ->find($orderId);

        if (!$order) {
            return response()->json(['message' => 'Order not found.'], 404);
        }

        return response()->json($order);
    }

    public function initializeOrder(Request $request): JsonResponse
    {
        $customerId = $request->input('customer_id');

        $order = Order::where('customer_id', $customerId)
            ->where('status', 'Initializing')
            ->first();

        if (!$order) {
            $order = Order::create([
                'customer_id' => $customerId,
                'status' => 'Initializing',
                // fields
            ]);
        }

        return response()->json($order);
    }

    public function addItemToOrder(Request $request, Order $order): JsonResponse
    {
        $validated = $request->validate([
            'product_id' => 'required|exists:products,id',
            'quantity' => 'required|integer|min:1',
            'customizations' => 'sometimes|string',
        ]);

        $orderItem = new OrderItem($validated);
        $order->orderItems()->save($orderItem);

        return response()->json($orderItem, 201);
    }

    public function ordersReadyForPreparation(): JsonResponse
    {
        $orders = Order::where('status', 'Awaiting Preparation')->get();

        return response()->json($orders);
    }

    public function updateOrderItemStatus(Request $request, OrderItem $orderItem): JsonResponse
    {
        $validated = $request->validate([
            'status' => 'required|string',
        ]);

        $orderItem->update($validated);

        return response()->json(['message' => 'Order item status updated successfully.']);
    }

    public function updateOrder(Request $request, $orderId, $itemId): JsonResponse
    {
        $validated = $request->validate([
            'quantity' => 'required|integer|min:1',
        ]);

        $item = OrderItem::where('id', $itemId)
            ->where('order_id', $orderId)
            ->first();

        if (!$item) {
            return response()->json(['message' => 'Order item not found or does not belong to the provided order.'], 404);
        }

        $item->update($validated);

        return response()->json(['message' => 'Order item updated successfully.']);
    }

    public function cancelOrder(Request $request): JsonResponse
    {
        DB::beginTransaction();
        try {
            $orderId = $request->user()->current_order_id;
            $order = Order::find($orderId);

            if (!$order) {
                DB::rollBack();
                return response()->json(['message' => 'Order not found.'], 404);
            }

            $order->status = 'canceled';
            $order->save();

            foreach ($order->orderItems as $item) {
                $inventory = $item->product->inventory;
                if ($inventory) {
                    $inventory->count += $item->quantity;
                    $inventory->save();
                }
            }

            DB::commit();
            return response()->json(['message' => 'Order canceled successfully.']);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Failed to cancel order.', 'error' => $e->getMessage()], 500);
        }
    }

    public function setAwaitingPayment($orderId): JsonResponse
    {
        $order = Order::find($orderId);
        if ($order) {
            $order->update(['status' => 'Awaiting Payment']);
            return response()->json(['message' => 'Order status updated to awaiting payment', 'order' => $order]);
        }

        return response()->json(['message' => 'Order not found'], 404);
    }

    public function createOrder(Request $request): JsonResponse
    {
        DB::beginTransaction();
        try {
            $order = new Order();
            $order->status = 'Awaiting Payment';
            $order->save();

            foreach ($request->items as $itemData) {
                $inventory = Inventory::where('product_id', $itemData['product_id'])->first();

                if ($inventory->count < $itemData['quantity']) {
                    throw new \Exception("Product {$inventory->product_id} is out of stock.");
                }

                $orderItem = new OrderItem([
                    'order_id' => $order->id,
                    'product_id' => $itemData['product_id'],
                    'quantity' => $itemData['quantity'],
                    'subtotal' => $itemData['subtotal'],
                ]);
                $orderItem->save();

                // Update inventory
                $inventory->decrement('count', $itemData['quantity']);
            }

            // Initiate customer verification process
            $verificationCode = "/* Generate verification code */";
            CustomerVerification::create([
                'order_id' => $order->id,
                'customer_contact' => $order->customer_contact,
                'verification_code' => $verificationCode,
            ]);

            // Send notification
            Notification::create([
                'type' => 'new_order',
                'related_id' => $order->id,
                'message' => "New order #{$order->id} has been placed.",
            ]);

            DB::commit();

            return response()->json(['message' => 'Order created successfully.', 'order_id' => $order->id], 201);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Failed to create order. ' . $e->getMessage()], 500);
        }
    }

    public function fetchOrder($orderId): JsonResponse
    {
        $order = Order::with(['orderItems', 'customerVerification', 'transactionSlip'])
            ->find($orderId);

        if (!$order) {
            return response()->json(['message' => 'Order not found'], 404);
        }

        return response()->json($order);
    }

    public function confirmPayment(Request $request): JsonResponse
    {
        $orderId = $request->input('order_id');
        $order = Order::find($orderId);
        if ($order) {
            $order->update([
                'status' => 'Payment Received',
                'payment_status' => 'Completed'
            ]);
            return response()->json(['message' => 'Payment confirmed', 'order' => $order]);
        }

        return response()->json(['message' => 'Order not found'], 404);
    }

    public function setOrderReadyForPickup(Order $order): JsonResponse
    {
        $order->update(['status' => 'Ready for Pickup']);

        return response()->json(['message' => 'Order is ready for pickup.']);
    }
}
