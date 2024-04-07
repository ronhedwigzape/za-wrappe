<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Http\JsonResponse;

class CategoryController extends Controller
{
    public function index(): JsonResponse
    {
        $categories = Category::all();
        return response()->json($categories, Response::HTTP_OK);
    }

    public function flavors(Category $categoryId) {
        return $categoryId->flavors;
    }

    public function addOns(Category $categoryId) {
        return $categoryId->addOns;
    }
}
