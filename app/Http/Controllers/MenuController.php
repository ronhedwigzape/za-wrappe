<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

class MenuController extends Controller
{
    public function index(): JsonResponse
    {
        $menuItems = Product::with('category')->active()->get();
        return response()->json($menuItems, Response::HTTP_OK);
    }
}
