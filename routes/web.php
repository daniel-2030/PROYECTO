<?php

use Illuminate\Support\Facades\Route;
use App\Http\Cancha\CanchaController;

Route::get('/', function () {
    return view('welcome');
});

Route::middleware(['auth:sanctum', config('jetstream.auth_session'),'verified'])
->resource('cancha',CanchaController::class)
->names('cancha');
;

Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {
    Route::get('/dashboard', function () {
        return view('dashboard');
    })->name('dashboard');
});
