
<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AdminLoginController;
use App\Http\Controllers\AdminLoanController;

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

Route::post('admin/login', [AdminLoginController::class, 'adminLogin'])->name('admin.login');
Route::group(['prefix' => 'admin', 'middleware' => ['auth:admin-api', 'scopes:admin']], function () {
    Route::get('pending-loan', [AdminLoanController::class, 'pendingLoan']);
    Route::post('update-loan-status', [AdminLoanController::class, 'updateLoanStatus']);
});

Route::any('{any}', function () {
    return response()->json([
        'status'    => false,
        'message'   => 'Page Not Found.',
    ], 404);
})->where('any', '.*');
