<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Http\JsonResponse;

class CategoryController extends Controller
{
    public function index(): JsonResponse
    {
        $categories = Category::all();
        return response()->json($categories, Response::HTTP_OK);
    }

    public function show($categoryId): JsonResponse
    {
        $category = Category::find($categoryId);
        if (!$category) {
            return response()->json(['message' => 'Category not found'], 404);
        }
        return response()->json($category, Response::HTTP_OK);
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'image_url' => 'nullable|string'
        ]);

        $category = Category::create($validated);
        return response()->json($category, Response::HTTP_CREATED);
    }

    public function update(Request $request, $categoryId): JsonResponse
    {
        $category = Category::find($categoryId);
        if (!$category) {
            return response()->json(['message' => 'Category not found'], 404);
        }

        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'image_url' => 'nullable|string'
        ]);

        $category->update($validated);
        return response()->json($category, Response::HTTP_OK);
    }

    public function destroy($categoryId): JsonResponse
    {
        $category = Category::find($categoryId);
        if (!$category) {
            return response()->json(['message' => 'Category not found'], 404);
        }

        $category->delete();
        return response()->json(['message' => 'Category deleted successfully'], Response::HTTP_OK);
    }

    public function flavors(Category $categoryId) {
        return $categoryId->flavors;
    }

    public function addOns(Category $categoryId) {
        return $categoryId->addOns;
    }
}
