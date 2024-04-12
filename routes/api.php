<?php

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use App\Http\Controllers\{
    CategoryController,
    InventoryController,
    MenuController,
    ProductController,
    HelpController,
    OrderController,
    FeedbackController,
    ReportController
};

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


/*
|--------------------------------------------------------------------------
| API Routes for General User Operations
|--------------------------------------------------------------------------
*/
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

/*
|--------------------------------------------------------------------------
| Menu and Categories, Products, Inventory Routes
|--------------------------------------------------------------------------
*/
Route::middleware(['auth:sanctum', 'throttle:60,1'])->group(function () {
    Route::get('/menu', [MenuController::class, 'index'])->name('menu.index');
    Route::get('/categories', [CategoryController::class, 'index'])->name('categories.index');
    Route::post('/categories', [CategoryController::class, 'store'])->name('categories.store');
    Route::get('/categories/{categoryId}', [CategoryController::class, 'show'])->name('categories.show');
    Route::put('/categories/{categoryId}', [CategoryController::class, 'update'])->name('categories.update');
    Route::delete('/categories/{categoryId}', [CategoryController::class, 'destroy'])->name('categories.destroy');
    Route::get('/categories/{categoryId}/flavors', [CategoryController::class, 'flavors'])->name('categories.flavors');
    Route::get('/categories/{categoryId}/add-ons', [CategoryController::class, 'addOns'])->name('categories.addOns');
    Route::get('/products', [ProductController::class, 'index'])->name('products.index');
    Route::post('/products', [ProductController::class, 'store'])->name('products.store');
    Route::get('/products/{productId}', [ProductController::class, 'showByCategory'])->name('categories.showByCategory');
    Route::put('/products/{productId}', [ProductController::class, 'update'])->name('products.update');
    Route::delete('/products/{productId}', [ProductController::class, 'destroy'])->name('products.destroy');
    Route::get('/inventory', [InventoryController::class, 'index'])->name('inventory.index');
    Route::get('/inventory/{productId}', [InventoryController::class, 'show'])->name('inventory.show');
    Route::put('/inventory/{productId}', [InventoryController::class, 'update'])->name('inventory.update');
});

/*
|--------------------------------------------------------------------------
| Order Management Routes
|--------------------------------------------------------------------------
*/
Route::middleware(['auth:sanctum', 'throttle:60,1'])->group(function () {
    Route::get('/orders/{orderId}', [OrderController::class, 'fetchOrder'])->name('orders.fetchOrder');
    Route::get('/orders/ready-for-preparation', [OrderController::class, 'ordersReadyForPreparation'])->name('orders.ordersReadyForPreparation');
    Route::post('/orders/create', [OrderController::class, 'createOrder'])->name('orders.createOrder');
    Route::post('/orders/{orderId}/update', [OrderController::class, 'updateOrder'])->name('order.updateOrder');
    Route::post('/orders/{orderId}/cancel', [OrderController::class, 'cancelOrder'])->name('order.cancelOrder');
    Route::post('/orders/{orderId}/add', [OrderController::class, 'addItemToOrder'])->name('orders.addItemToOrder');
    Route::post('/orders/{orderId}/item/{orderItemId}/update', [OrderController::class, 'updateItemToOrder'])->name('orders.updateItemToOrder');
    Route::post('/orders/{orderId}/item/{orderItemId}/delete', [OrderController::class, 'deleteItemToOrder'])->name('orders.deleteItemToOrder');
    Route::post('/orders/{orderId}/awaiting-payment', [OrderController::class, 'setAwaitingPayment'])->name('orders.setAwaitingPayment');
    Route::post('/orders/{order}/ready-for-pickup', [OrderController::class, 'setOrderReadyForPickup'])->name('orders.setOrderReadyForPickup');
    Route::post('/order-items/{orderItem}/update-status', [OrderController::class, 'updateOrderItemStatus'])->name('orders.updateOrderItemStatus');
    Route::post('/payments/confirm', [OrderController::class, 'confirmPayment'])->name('payments.confirmPayment');
});

/*
|--------------------------------------------------------------------------
| Feedback Routes
|--------------------------------------------------------------------------
*/
Route::middleware(['auth:sanctum', 'throttle:60,1'])->group(function () {
    Route::get('/feedbacks', [FeedbackController::class, 'index'])->name('feedbacks.index');
    Route::post('/feedbacks/respond', [FeedbackController::class, 'respondToFeedback'])->name('feedbacks.respond');
});

/*
|--------------------------------------------------------------------------
| Reporting Routes
|--------------------------------------------------------------------------
*/
Route::middleware(['auth:sanctum', 'throttle:60,1'])->group(function () {
    Route::get('/reports/sales', [ReportController::class, 'salesReport'])->name('reports.salesReport');
    Route::get('/reports/financial', [ReportController::class, 'financialReport'])->name('reports.financialReport');
});

/*
|--------------------------------------------------------------------------
| Miscellaneous Routes
|--------------------------------------------------------------------------
*/
Route::get('/help', [HelpController::class, 'index'])->name('help.index');

/*
|--------------------------------------------------------------------------
| User Login - Test API Purposes only
|--------------------------------------------------------------------------
*/
Route::post('/login', function (Request $request) {
    $credentials = $request->validate([
        'email' => 'required|email',
        'password' => 'required',
    ]);

    if (Auth::attempt($credentials)) {
        $user = Auth::user();
        $token = $user->createToken('API Token')->plainTextToken;

        return response()->json(['token' => $token]);
    }

    return response()->json(['error' => 'Unauthorized'], 401);
});
