<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\KreditController;
use App\Http\Controllers\TabunganController;
use App\Http\Controllers\DepositoController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
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

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/simulasi-kredit', [KreditController::class, 'create'])->name('simulasi-kredit.create');
Route::post('/simulasi-kredit', [KreditController::class, 'store'])->name('simulasi-kredit.store');
Route::post('/simulasi-kredit2', [KreditController::class, 'store2'])->name('simulasi-kredit.store');

Route::put('/simulasi-kredit/update/{$id}', [KreditController::class, 'update'])->name('simulasi-kredit.update');

Route::get('/history', [KreditController::class, 'index'])->name('history.index');
Route::get('/simulasi-kredit/{id}', [KreditController::class, 'show'])->name('simulasi-kredit.show');
Route::delete('/kredit/delete/{id}',[KreditController::class, 'destroy'])->name('simulasi-delete');

Route::get('/kredit/delete/{id}',[KreditController::class, 'destroy'])->name('simulasi-delete');


Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('/register', [AuthController::class, 'Register']);
Route::post('/login', [AuthController::class, 'login']);
Route::put('/user/{id}', [AuthController::class, 'Edit']);


Route::get('/tabungan', [TabunganController::class, 'create'])->name('tabungan.create');
Route::post('/tabungan', [TabunganController::class, 'store'])->name('tabungan.store');
Route::get('/tabungan-index', [TabunganController::class, 'index'])->name('tabungan.index');
Route::get('/tabungan-show/{id}', [TabunganController::class, 'show'])->name('tabungan.show');
Route::delete('/tabungan/delete/{id}',[TabunganController::class, 'destroy'])->name('tabungan-delete');
Route::get('/tabungan/delete/{id}',[TabunganController::class, 'destroy'])->name('tabungan-delete');

Route::get('/deposito', [DepositoController::class, 'create'])->name('deposito.create');
Route::post('/deposito', [DepositoController::class, 'store'])->name('deposito.store');
Route::get('/deposito-index', [DepositoController::class, 'index'])->name('deposito.index');
Route::get('/deposito-show/{id}', [DepositoController::class, 'show'])->name('deposito.show');
Route::delete('/deposito/delete/{id}',[DepositoController::class, 'destroy'])->name('deposito-delete');
Route::get('/deposito/delete/{id}',[DepositoController::class, 'destroy'])->name('deposito-delete');
