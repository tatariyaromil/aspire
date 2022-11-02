<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Loan;


class AdminLoanController extends Controller
{

    /* Check how much loan are pending for approved and reject by admin */
    public function pendingLoan()
    {
        $pendingLoanData = Loan::where('request_status', 'Pending')->get();

        if ($pendingLoanData->count() > 0) {
            return response()->json(['pendingLoanData' => $pendingLoanData], 200);
        } else {
            return response()->json([
                'status' => 200,
                'message' => "No data found",
                'success' => 'No data found'
            ]);
        }
    }


    /* Admin can approved or reject customer load reuqest */
    public function updateLoanStatus(Request $request)
    {

        $rules = [
            'id' => 'required',
            'request_status' => 'required|in:Approved,Rejected'
        ];
        $messages = [
            'id.required' => 'Id is required',
            'request_status.required' => 'Request status is required',
        ];
        $validator = Validator::make($request->all(), $rules, $messages);

        if ($validator->fails()) {
            $error_messages = [];
            $errors = $validator->errors();
            foreach ($errors->getMessages() as $key => $error) {
                $error_messages[$key] = $error[0];
            }
            return response()->json([
                'status' => 400,
                'message' => $errors->first(),
                'errors' => $error_messages
            ]);
        }

        $loanObj = Loan::where('id', $request->id)->first();
        $loanObj->request_status = $request->request_status;
        if ($loanObj->save()) {
            return response()->json(
                [
                    'status' => 200,
                    'success' => 'Status update successfully.'
                ],
            );
        }
    }
}
