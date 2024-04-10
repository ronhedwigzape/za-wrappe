<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use App\Http\Controllers\{
    CategoryController, MenuController, ProductController, HelpController, OrderController, FeedbackController, ReportController
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
| Menu and Categories Routes
|--------------------------------------------------------------------------
*/
Route::get('/menu', [MenuController::class, 'index'])->name('menu.index');
Route::get('/categories', [CategoryController::class, 'index'])->name('categories.index');
Route::get('/categories/{categoryId}', [ProductController::class, 'showByCategory'])->name('categories.showByCategory');
Route::get('/categories/{categoryId}/flavors', [CategoryController::class, 'flavors'])->name('categories.flavors');
Route::get('/categories/{categoryId}/add-ons', [CategoryController::class, 'addOns'])->name('categories.addOns');

/*
|--------------------------------------------------------------------------
| Order Management Routes
|--------------------------------------------------------------------------
*/

Route::get('/orders/{orderId}', [OrderController::class, 'fetchOrder'])->name('orders.fetchOrder');
Route::get('/orders/{orderId}/summary', [OrderController::class, 'fetchOrderSummary'])->name('order.fetchOrderSummary');
Route::get('/orders/ready-for-preparation', [OrderController::class, 'ordersReadyForPreparation'])->name('orders.ordersReadyForPreparation');

Route::middleware(['auth:sanctum', 'throttle:60,1'])->group(function () {
    Route::post('/order/create', [OrderController::class, 'createOrder'])->name('orders.createOrder');
    Route::post('/order/update', [OrderController::class, 'updateOrder'])->name('order.updateOrder');
    Route::post('/order/cancel', [OrderController::class, 'cancelOrder'])->name('order.cancelOrder');
    Route::post('/orders/{orderId}/awaiting-payment', [OrderController::class, 'setAwaitingPayment'])->name('orders.setAwaitingPayment');
    Route::post('/orders/{order}/addItem', [OrderController::class, 'addItemToOrder'])->name('orders.addItemToOrder');
    Route::post('/order-items/{orderItem}/update-status', [OrderController::class, 'updateOrderItemStatus'])->name('orders.updateOrderItemStatus');
    Route::post('/orders/{order}/ready-for-pickup', [OrderController::class, 'setOrderReadyForPickup'])->name('orders.setOrderReadyForPickup');
    Route::post('/payments/confirm', [OrderController::class, 'confirmPayment'])->name('payments.confirmPayment');
});

/*
|--------------------------------------------------------------------------
| Feedback Routes
|--------------------------------------------------------------------------
*/
Route::get('/feedbacks', [FeedbackController::class, 'index'])->name('feedbacks.index');
Route::post('/feedbacks/respond', [FeedbackController::class, 'respondToFeedback'])->name('feedbacks.respond');

/*
|--------------------------------------------------------------------------
| Reporting Routes
|--------------------------------------------------------------------------
*/
Route::get('/reports/sales', [ReportController::class, 'salesReport'])->name('reports.salesReport');
Route::get('/reports/financial', [ReportController::class, 'financialReport'])->name('reports.financialReport');

/*
|--------------------------------------------------------------------------
| Miscellaneous Routes
|--------------------------------------------------------------------------
*/
Route::get('/help', [HelpController::class, 'index'])->name('help.index');
