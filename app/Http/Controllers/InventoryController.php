<?php

namespace App\Http\Controllers;

use App\Models\Inventory;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class InventoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): Response
    {
        $inventory = Inventory::with('product')->get();
        return response()->json($inventory, Response::HTTP_OK);
    }

    public function show($productId): Response
    {
        $inventory = Inventory::where('product_id', $productId)->first();
        if (!$inventory) {
            return response()->json(['message' => 'Inventory not found'], 404);
        }
        return response()->json($inventory, Response::HTTP_OK);
    }

    public function update(Request $request, $productId): Response
    {
        $inventory = Inventory::where('product_id', $productId)->first();
        if (!$inventory) {
            return response()->json(['message' => 'Inventory not found'], 404);
        }

        $validated = $request->validate([
            'count' => 'required|integer|min:0',
            'low_stock_threshold' => 'required|integer|min:0'
        ]);

        $inventory->update($validated);
        return response()->json($inventory, Response::HTTP_OK);
    }
}
