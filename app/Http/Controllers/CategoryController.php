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

    public function flavors(Category $category) {
        return $category->flavors;
    }

    public function addOns(Category $category) {
        return $category->addOns;
    }
}
