<?php

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Route::get('/', function () {
    if (Auth::check()) {
        return redirect()->route('dashboard');
    }
    return Inertia::render('Auth/Login', [
        'canLogin' => Route::has('login'),
    ]);
})->name('welcome');

// Authenticate customer, merchant or admin users
Route::middleware(['auth:sanctum', config('jetstream.auth_session'), 'verified',])->group(function () {

    Route::get('/dashboard', function () {
        return Inertia::render('Dashboard');
    })->name('dashboard');

    Route::get('/initialize', function() {
        return Inertia::render('Customer/Order/Initialize');
    })->name('initialize');

    Route::get('/order', function() {
        return Inertia::render('Customer/Order/Create');
    })->name('order');

    Route::get('/order-summary', function() {
        return Inertia::render('Customer/Order/Summary');
    })->name('order-summary');

});
