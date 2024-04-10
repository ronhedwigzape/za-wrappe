<?php

namespace App\Http\Controllers;

use App\Models\CustomerVerification;
use App\Models\Inventory;
use App\Models\Notification;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

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
        $validated = $request->validate([
            'customer_contact' => 'required|string',
            'items' => 'required|array',
            'items.*.product_id' => 'required|exists:products,id',
            'items.*.quantity' => 'required|integer|min:1',
        ]);

        DB::beginTransaction();
        try {
            $totalPrice = 0;

            // Prepare the order
            $order = new Order();
            $order->status = 'Awaiting Payment';
            $order->customer_contact = $validated['customer_contact'];
            $order->payment_status = 'Pending';
            $order->verification_code = Str::random(10);

            foreach ($validated['items'] as $itemData) {
                $product = Product::findOrFail($itemData['product_id']);
                $subtotal = $product->price * $itemData['quantity'];
                $totalPrice += $subtotal;

                // Check inventory before creating an order item
                $inventory = Inventory::where('product_id', $itemData['product_id'])->firstOrFail();
                if ($inventory->count < $itemData['quantity']) {
                    throw new \Exception("Insufficient inventory for product {$product->id}.");
                }

                // Deduct the ordered quantity from the inventory
                $inventory->decrement('count', $itemData['quantity']);
            }

            $order->total_price = $totalPrice;
            $order->save();

            foreach ($validated['items'] as $itemData) {
                $orderItem = new OrderItem([
                    'order_id' => $order->id,
                    'product_id' => $itemData['product_id'],
                    'quantity' => $itemData['quantity'],
                    'subtotal' => Product::findOrFail($itemData['product_id'])->price * $itemData['quantity'],
                ]);
                $orderItem->save();
            }

            // Initiate customer verification process
            CustomerVerification::create([
                'order_id' => $order->id,
                'customer_contact' => $order->customer_contact,
                'verification_code' => $order->verification_code,
                'attempts' => 0,
            ]);

            // Send notification
            Notification::create([
                'type' => 'new_order',
                'related_id' => $order->id,
                'message' => "New order #{$order->id} has been placed.",
                'status' => 'pending'
            ]);

            DB::commit();

            return response()->json([
                'message' => 'Order created successfully.',
                'order_id' => $order->id,
                'total_price' => $totalPrice,
                'verification_code' => $order->verification_code
            ]);

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
