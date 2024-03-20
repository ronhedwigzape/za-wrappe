<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Symfony\Component\HttpFoundation\Response;

class ProductController extends Controller
{
    public function showByCategory($categoryId): Response
    {
        $products = Product::where('category_id', $categoryId)->where('active', true)->get();
        return response()->json($products, Response::HTTP_OK);
    }
}
