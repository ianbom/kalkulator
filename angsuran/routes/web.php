<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\KreditController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;

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
    return view('welcome');
});

Route::get('/simulasi-kredit', [KreditController::class, 'create'])->name('simulasi-kredit.create');
Route::post('/simulasi-kredit', [KreditController::class, 'store'])->name('simulasi-kredit.store');
Route::get('/history', [KreditController::class, 'index'])->name('history.index');
Route::get('/simulasi-kredit/{id}', [KreditController::class, 'show'])->name('simulasi-kredit.show');
Route::delete('/kredit/delete/{id}',[KreditController::class, 'destroy'])->name('kredit-delete');


Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('/register', [AuthController::class, 'Register']);
Route::post('/login', [AuthController::class, 'login']);
