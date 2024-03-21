<?php

use App\Http\Controllers\AddOnController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\FlavorController;
use App\Http\Controllers\HelpController;
use App\Http\Controllers\MenuController;
use App\Http\Controllers\ProductController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// Fetch menu items
Route::get('/menu', [MenuController::class, 'index']);

// Fetch categories for the menu
Route::get('/categories', [CategoryController::class, 'index']);

// Fetch all products by category
Route::get('/products/{categoryId}', [ProductController::class, 'showByCategory']);

// Get help information
Route::get('/help', [HelpController::class, 'index']);

// Get all flavors by category
Route::get('/categories/{category}/flavors', [CategoryController::class, 'flavors']);

// Get all add-ons by category
Route::get('/categories/{category}/add-ons', [CategoryController::class, 'addOns']);

