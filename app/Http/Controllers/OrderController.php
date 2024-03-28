<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\OrderItem;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function fetchOrderSummary(Request $request): JsonResponse
    {
        $orderId = $request->user()->order_id;
        $order = Order::with('order_items.product')->find($orderId);

        return response()->json($order);
    }

    public function updateOrder(Request $request, $itemId): JsonResponse
    {
        $item = OrderItem::find($itemId);
        $item->update([
            'quantity' => $request->quantity,
            // 'order_id' => $request->order,
            // other attributes
        ]);
        return response()->json(['message' => 'Order item updated successfully.']);
    }

    public function cancelOrder(Request $request): JsonResponse
    {
        $orderId = $request->user()->current_order_id;
        $order = Order::find($orderId);
        return response()->json(['message' => 'Order canceled successfully.']);
    }

}
