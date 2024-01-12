<?php

use App\Http\Controllers\LinkController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PaymentController;
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

// Checkout Session Resource
Route::post('/checkout-sessions', [PaymentController::class, 'createCheckoutSession']);
Route::get('/checkout-sessions/{id}', [PaymentController::class, 'retrieveCheckout']);
Route::post('/checkout-sessions/{id}/expire', [PaymentController::class, 'expireCheckoutSession']);

// Payment Intent Resource
Route::post('/payment-intents', [PaymentController::class, 'createPaymentIntent']);
Route::get('/payment-intents/{id}', [PaymentController::class, 'retrievePaymentIntent']);
Route::post('/payment-intents/{id}/attach', [PaymentController::class, 'attachToPaymentIntent']);

// Payment Method Resource
Route::get('/payment-methods', [PaymentController::class, 'retrieveMerchantPaymentMethods']);
Route::post('/payment-methods', [PaymentController::class, 'createPaymentMethod']);
Route::get('/payment-methods/{id}', [PaymentController::class, 'retrievePaymentMethod']);
Route::put('/payment-methods/{id}', [PaymentController::class, 'updatePaymentMethod']);

// Payment Resource
Route::post('/payments', [PaymentController::class, 'createPayment']);
Route::get('/payments', [PaymentController::class, 'listAllPayments']);
Route::get('/payments/{id}', [PaymentController::class, 'retrievePayment']);

// Links API
Route::post('/links', [PaymentController::class, 'createLink']);
Route::get('/links/{id}', [PaymentController::class, 'retrieveLink']);
Route::get('/links/reference/{reference}', [PaymentController::class, 'getLinkByReferenceNumber']);
Route::post('/links/{id}/archive', [PaymentController::class, 'archiveLink']);
Route::post('/links/{id}/unarchive', [PaymentController::class, 'unarchiveLink']);

// Webhooks
Route::post('/webhooks', [PaymentController::class, 'createWebhook']);
Route::get('/webhooks', [PaymentController::class, 'listAllWebhooks']);
Route::get('/webhooks/{id}', [PaymentController::class, 'retrieveWebhook']);
Route::post('/webhooks/{id}/disable', [PaymentController::class, 'disableWebhook']);
Route::post('/webhooks/{id}/enable', [PaymentController::class, 'enableWebhook']);
Route::put('/webhooks/{id}', [PaymentController::class, 'updateWebhook']);

// Refunds
Route::post('/refunds', [PaymentController::class, 'createRefund']);
Route::get('/refunds/{id}', [PaymentController::class, 'retrieveRefund']);
Route::get('/refunds', [PaymentController::class, 'listAllRefunds']);

// Customers
Route::post('/customers', [PaymentController::class, 'createCustomer']);
Route::get('/customers/{id}', [PaymentController::class, 'retrieveCustomer']);
Route::put('/customers/{id}', [PaymentController::class, 'editCustomer']);
Route::delete('/customers/{id}', [PaymentController::class, 'deleteCustomer']);
Route::get('/customers/{id}/payment-methods', [PaymentController::class, 'retrieveCustomerPaymentMethods']);
Route::delete('/customers/{id}/payment-methods/{paymentMethodId}', [PaymentController::class, 'deleteCustomerPaymentMethod']);

// Pre-Authorization and Capture
Route::post('/payments/{id}/capture', [PaymentController::class, 'capturePayment']);
Route::post('/payments/{id}/cancel', [PaymentController::class, 'cancelPayment']);

// Generate payment link for users
Route::post('/users/{user}/generate-link', [LinkController::class, 'generateLinkForUser']);

// Users
Route::get('/users', [UserController::class, 'index']);

