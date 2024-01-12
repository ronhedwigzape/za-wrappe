<?php

use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
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


Route::get('/login', function () {
    if (Auth::check()) {
        return Redirect::route('dashboard');
    }
    return Inertia::render('Auth/Login');
})->name('login');

Route::get('/register', function () {
    if (Auth::check()) {
        return Redirect::route('dashboard');
    }
    return Inertia::render('Auth/Register');
})->name('register');

Route::get('/', function () {
    if (Auth::check()) {
        return Redirect::route('dashboard');
    }
    return Inertia::render('Welcome');
});

Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {
    Route::get('/dashboard', function () {
        return Inertia::render('Dashboard');
    })->name('dashboard');
});
