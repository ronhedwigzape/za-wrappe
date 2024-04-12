<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class ProductController extends Controller
{
    public function index(): Response
    {
        $products = Product::with('category')->get();
        return response()->json($products, Response::HTTP_OK);
    }

    public function show($productId): Response
    {
        $product = Product::with('category', 'inventory')->find($productId);
        if (!$product) {
            return response()->json(['message' => 'Product not found'], 404);
        }
        return response()->json($product, Response::HTTP_OK);
    }

    public function store(Request $request): Response
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'category_id' => 'required|exists:categories,id',
            'price' => 'required|numeric',
            'description' => 'nullable|string',
            'image_url' => 'nullable|url',
            'active' => 'required|boolean'
        ]);

        $product = Product::create($validated);
        return response()->json($product, Response::HTTP_CREATED);
    }

    public function update(Request $request, $productId): Response
    {
        $product = Product::find($productId);
        if (!$product) {
            return response()->json(['message' => 'Product not found'], 404);
        }

        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'category_id' => 'required|exists:categories,id',
            'price' => 'required|numeric',
            'description' => 'nullable|string',
            'image_url' => 'nullable|url',
            'active' => 'required|boolean'
        ]);

        $product->update($validated);
        return response()->json($product, Response::HTTP_OK);
    }

    public function destroy($productId): Response
    {
        $product = Product::find($productId);
        if (!$product) {
            return response()->json(['message' => 'Product not found'], 404);
        }

        $product->delete();
        return response()->json(['message' => 'Product deleted successfully'], Response::HTTP_OK);
    }

    public function showByCategory($productId): Response
    {
        $products = Product::where('category_id', $productId)->where('active', true)->get();
        return response()->json($products, Response::HTTP_OK);
    }
}
