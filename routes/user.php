<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CustomerController;
use App\Http\Controllers\LoanController;

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

// UNAUTH API FOR USE LOGIN
Route::post('customer/register', [CustomerController::class, 'customerRegister'])->name('customer.register');
Route::post('customer/login',[CustomerController::class, 'customerLogin'])->name('customer.login');

// AUTHENTICATION API FOR USE
Route::group( ['prefix' => 'customer','middleware' => ['auth:user-api','scopes:user'] ],function(){
    Route::post('loan-request', [LoanController::class, 'loanRequest']);
    Route::get('view-loan', [LoanController::class, 'viewLoan']);
    Route::get('view-estimated-loan-term', [LoanController::class, 'viewEstimatedLoanTerm']);
    Route::post('repayment', [LoanController::class, 'repaymentLoan']);
}); 
