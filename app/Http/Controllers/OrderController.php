<?php

namespace App\Http\Controllers;

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
}
