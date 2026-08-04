<?php

use App\Http\Controllers\authController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Public routes
Route::post('/register', [authController::class, 'register']);
Route::post('/login', [authController::class, 'login']);

Route::post('/drop', [authController::class, 'drop']);

// Protected Routes
Route::group(['middleware' => ['auth:sanctum']], function () {

    // User
    Route::get('/user', [authController::class, 'user']);
    Route::put('/user', [authController::class, 'update']);
    Route::post('/logout', [authController::class, 'logout']);

});
