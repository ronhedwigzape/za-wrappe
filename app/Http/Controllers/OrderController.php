<?php

namespace App\Http\Controllers;

use App\Models\AddOn;
use App\Models\CustomerVerification;
use App\Models\Inventory;
use App\Models\Notification;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Product;
use App\Models\TransactionSlip;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class OrderController extends Controller
{

    public function fetchOrder($orderId): JsonResponse
    {
        $order = Order::with([
            'orderItems.product',
            'orderItems.product.inventory',
            'customerVerification',
            'transactionSlip'
        ])->find($orderId);

        if (!$order) {
            return response()->json(['message' => 'Order not found'], 404);
        }

        $orderData = [
            'id' => $order->id,
            'status' => $order->status,
            'customer_contact' => $order->customer_contact,
            'total_price' => $order->total_price,
            'verification_code' => $order->verification_code,
            'payment_status' => $order->payment_status,
            'created_at' => $order->created_at,
            'updated_at' => $order->updated_at,
            'order_items' => $order->orderItems->map(function ($item) {
                return [
                    'id' => $item->id,
                    'order_id' => $item->order_id,
                    'product_id' => $item->product_id,
                    'quantity' => $item->quantity,
                    'subtotal' => $item->subtotal,
                    'add_on_ids' => $item->add_on_ids,
                    'flavor_id' => $item->flavor_id,
                    'product' => [
                        'id' => $item->product->id,
                        'name' => $item->product->name,
                        'category_id' => $item->product->category_id,
                        'description' => $item->product->description,
                        'price' => $item->product->price,
                        'image_url' => $item->product->image_url,
                        'active' => $item->product->active,
                        'created_at' => $item->product->created_at,
                        'updated_at' => $item->product->updated_at,
                    ],
                    'inventory' => [
                        'id' => $item->product->inventory->id,
                        'count' => $item->product->inventory->count,
                        'product_id' => $item->product->inventory->product_id,
                        'low_stock_threshold' => $item->product->inventory->low_stock_threshold,
                        'created_at' => $item->product->inventory->created_at,
                        'updated_at' => $item->product->inventory->updated_at,
                    ],
                ];
            })->toArray(),
            'customer_verification' => $order->customerVerification ? [
                'id' => $order->customerVerification->id,
                'order_id' => $order->customerVerification->order_id,
                'customer_contact' => $order->customerVerification->customer_contact,
                'verification_code' => $order->customerVerification->verification_code,
                'verified_at' => $order->customerVerification->verified_at,
                'attempts' => $order->customerVerification->attempts,
                'created_at' => $order->customerVerification->created_at,
                'updated_at' => $order->customerVerification->updated_at,
            ] : null,
            'transaction_slip' => $order->transactionSlip ? [
                'id' => $order->transactionSlip->id,
                'order_id' => $order->transactionSlip->order_id,
                'issued_at' => $order->transactionSlip->issued_at,
                'code' => $order->transactionSlip->code,
                'created_at' => $order->transactionSlip->created_at,
                'updated_at' => $order->transactionSlip->updated_at,
            ] : null,
        ];

        return response()->json($orderData);
    }

    public function createOrder(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'customer_contact' => 'required|string',
            'items' => 'required|array',
            'items.*.product_id' => 'required|exists:products,id',
            'items.*.quantity' => 'required|integer|min:1',
            'items.*.add_ons' => 'sometimes|array',
            'items.*.add_ons.*' => 'exists:add_ons,id',
            'items.*.flavor_id' => 'sometimes|exists:flavors,id',
        ]);

        DB::beginTransaction();

        try {
            $totalPrice = 0;

            foreach ($validated['items'] as $itemData) {
                $product = Product::findOrFail($itemData['product_id']);
                $subtotal = $product->price * $itemData['quantity'];

                $addOnsPrice = 0;
                if (!empty($itemData['add_ons'])) {
                    $addOns = AddOn::whereIn('id', $itemData['add_ons'])->get();
                    foreach ($addOns as $addOn) {
                        $addOnsPrice += $addOn->price * $itemData['quantity'];
                    }
                }

                $itemTotalPrice = $subtotal + $addOnsPrice;
                $totalPrice += $itemTotalPrice;
            }

            $order = new Order([
                'customer_contact' => $validated['customer_contact'],
                'status' => 'Awaiting Payment',
                'payment_status' => 'Pending',
                'verification_code' => Str::random(10),
                'total_price' => $totalPrice,
            ]);
            $order->save();

            foreach ($validated['items'] as $itemData) {
                $orderItem = new OrderItem([
                    'order_id' => $order->id,
                    'product_id' => $itemData['product_id'],
                    'quantity' => $itemData['quantity'],
                    'subtotal' => $product->price * $itemData['quantity'],
                    'flavor_id' => $itemData['flavor_id'] ?? null,
                    'add_on_ids' => json_encode($itemData['add_ons'] ?? []),
                ]);
                $orderItem->save();

                // Update inventory
                $inventory = Inventory::where('product_id', $itemData['product_id'])->firstOrFail();
                $inventory->decrement('count', $itemData['quantity']);
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

            // Create transaction slip
            TransactionSlip::create([
                'order_id' => $order->id,
                'issued_at' => now(),
                'code' => Str::random(20)
            ]);

            DB::commit();

            return response()->json([
                'message' => 'Order created successfully.',
                'order_id' => $order->id,
                'total_price' => $totalPrice,
                'verification_code' => $order->verification_code,
            ], 201);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Failed to create order. ' . $e->getMessage()], 500);
        }
    }

    public function updateOrder(Request $request, $orderId): JsonResponse
    {
        $validated = $request->validate([
            'items' => 'required|array',
            'items.*.order_item_id' => 'required|exists:order_items,id',
            'items.*.quantity' => 'required|integer|min:1',
            'items.*.add_ons' => 'sometimes|array',
            'items.*.add_ons.*' => 'exists:add_ons,id',
            'items.*.flavor_id' => 'sometimes|exists:flavors,id',
        ]);

        $order = Order::find($orderId);

        if (!$order) {
            return response()->json(['message' => 'Order not found.'], 404);
        }

        DB::beginTransaction();

        try {
            $totalPrice = 0;

            foreach ($validated['items'] as $itemData) {
                $orderItem = OrderItem::findOrFail($itemData['order_item_id']);

                if ($orderItem->order_id != $order->id) {
                    throw new \Exception("Order item {$orderItem->id} does not belong to order {$order->id}.");
                }

                $product = Product::findOrFail($orderItem->product_id);
                $subtotal = $product->price * $itemData['quantity'];

                $addOnsPrice = 0;
                if (!empty($itemData['add_ons'])) {
                    $addOns = AddOn::whereIn('id', $itemData['add_ons'])->get();
                    foreach ($addOns as $addOn) {
                        $addOnsPrice += $addOn->price * $itemData['quantity'];
                    }
                }

                $itemTotalPrice = $subtotal + $addOnsPrice;
                $totalPrice += $itemTotalPrice;

                // Update order item details
                $orderItem->update([
                    'quantity' => $itemData['quantity'],
                    'subtotal' => $itemTotalPrice,
                    'add_on_ids' => json_encode($itemData['add_ons'] ?? []),
                    'flavor_id' => $itemData['flavor_id'] ?? $orderItem->flavor_id,
                ]);

                // Update inventory
                $inventory = Inventory::where('product_id', $orderItem->product_id)->firstOrFail();
                $inventory->decrement('count', $itemData['quantity'] - $orderItem->quantity);
            }

            // Recalculate total price for the order
            $order->update(['total_price' => $totalPrice]);

            DB::commit();

            return response()->json([
                'message' => 'Order updated successfully.',
                'order_id' => $order->id,
                'total_price' => $totalPrice,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Failed to update order. ' . $e->getMessage()], 500);
        }
    }

    public function cancelOrder(Request $request, $orderId): JsonResponse
    {
        $order = Order::find($orderId);

        if (!$order) {
            return response()->json(['message' => 'Order not found.'], 404);
        }

        DB::beginTransaction();

        try {
            // Revert inventory quantities
            foreach ($order->orderItems as $item) {
                $inventory = Inventory::where('product_id', $item->product_id)->first();
                if ($inventory) {
                    $inventory->increment('count', $item->quantity);
                }
            }

            $order->status = 'Canceled';
            $order->save();

            DB::commit();
            return response()->json(['message' => 'Order canceled successfully.']);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Failed to cancel order.', 'error' => $e->getMessage()], 500);
        }
    }

    public function addItemToOrder(Request $request, $orderId): JsonResponse
    {
        $validated = $request->validate([
            'product_id' => 'required|exists:products,id',
            'quantity' => 'required|integer|min:1',
            'add_ons' => 'sometimes|array',
            'add_ons.*' => 'exists:add_ons,id',
            'flavor_id' => 'sometimes|exists:flavors,id',
        ]);

        $order = Order::find($orderId);
        if (!$order) {
            return response()->json(['message' => 'Order not found'], 404);
        }

        $product = Product::findOrFail($validated['product_id']);
        $subtotal = $product->price * $validated['quantity'];

        $addOnsPrice = 0;
        if (isset($validated['add_ons'])) {
            foreach ($validated['add_ons'] as $addOnId) {
                $addOn = AddOn::findOrFail($addOnId);
                $addOnsPrice += $addOn->price * $validated['quantity'];
            }
        }

        $totalItemPrice = $subtotal + $addOnsPrice;

        $orderItem = new OrderItem([
            'order_id' => $order->id,
            'product_id' => $validated['product_id'],
            'quantity' => $validated['quantity'],
            'subtotal' => $totalItemPrice,
            'add_on_ids' => $validated['add_ons'] ?? [],
            'flavor_id' => $validated['flavor_id'] ?? null,
        ]);
        $orderItem->save();

        // Update Order Total Price
        $order->total_price += $totalItemPrice;
        $order->save();

        return response()->json(['message' => 'Item added to order successfully', 'order_item' => $orderItem], 201);
    }

    public function updateItemToOrder(Request $request, $orderId, $orderItemId): JsonResponse
    {
        $validated = $request->validate([
            'quantity' => 'required|integer|min:1',
            'add_ons' => 'sometimes|array',
            'add_ons.*' => 'exists:add_ons,id',
            'flavor_id' => 'sometimes|exists:flavors,id',
        ]);

        DB::beginTransaction();

        try {
            $order = Order::findOrFail($orderId);
            $orderItem = $order->orderItems()->findOrFail($orderItemId);
            $product = Product::findOrFail($orderItem->product_id);

            // Recalculate subtotal for the item
            $addOnsPrice = AddOn::whereIn('id', $validated['add_ons'] ?? [])->sum('price') * $validated['quantity'];
            $itemSubtotal = ($product->price * $validated['quantity']) + $addOnsPrice;

            // Update inventory
            $inventoryAdjustment = $validated['quantity'] - $orderItem->quantity;
            $inventory = Inventory::where('product_id', $orderItem->product_id)->firstOrFail();
            if ($inventory->count < $inventoryAdjustment) {
                return response()->json(['message' => 'Insufficient inventory for product.'], 400);
            }
            $inventory->decrement('count', $inventoryAdjustment);

            // Update order item
            $orderItem->update([
                'quantity' => $validated['quantity'],
                'subtotal' => $itemSubtotal,
                'add_on_ids' => $validated['add_ons'] ?? [],
                'flavor_id' => $validated['flavor_id'] ?? $orderItem->flavor_id,
            ]);

            // Recalculate total price of the order
            $order->total_price = $order->orderItems->sum('subtotal');
            $order->save();

            DB::commit();
            return response()->json(['message' => 'Order item updated successfully.']);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Failed to update order item.', 'error' => $e->getMessage()], 500);
        }
    }

    public function deleteItemToOrder(Request $request, $orderId, $orderItemId): JsonResponse
    {
        DB::beginTransaction();

        try {
            $order = Order::findOrFail($orderId);
            $orderItem = $order->orderItems()->findOrFail($orderItemId);

            // Update inventory
            $inventory = Inventory::where('product_id', $orderItem->product_id)->firstOrFail();
            $inventory->increment('count', $orderItem->quantity);

            // Remove order item
            $orderItem->delete();

            // Recalculate total price of the order
            $order->total_price = $order->orderItems->sum('subtotal');
            $order->save();

            DB::commit();
            return response()->json(['message' => 'Order item deleted successfully.']);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Failed to delete order item.', 'error' => $e->getMessage()], 500);
        }
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

    public function setAwaitingPayment($orderId): JsonResponse
    {
        $order = Order::find($orderId);
        if ($order) {
            $order->update(['status' => 'Awaiting Payment']);
            return response()->json(['message' => 'Order status updated to awaiting payment', 'order' => $order]);
        }

        return response()->json(['message' => 'Order not found'], 404);
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
