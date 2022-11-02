<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Loan;
use App\Models\LoanTerm;
use App\Models\EstimatedLoanTerm;
use Auth;

class LoanController extends Controller
{
    /* function for loan request by customer */
    public function loanRequest(Request $request)
    {

        try {
            $rules = [
                'amount' => 'required|numeric',
                'term' => 'required|integer',
                'date' => 'required|date|after_or_equal:now'
            ];
            $messages = [
                'amount.required' => 'Amount is required',
                'term.required' => 'Term is required',
                'term.integer' => 'Please enter valid term',
                'date.required'  => 'Date is required'
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
                ], 200);
            }

            $user_id =  Auth::guard('user-api')->user()->id;

            $termPayAmount =  $this->calculateAmount($request->amount, $request->term, $request->date);

            $loanObj = new Loan();
            $loanObj->user_id = $user_id;
            $loanObj->amount = $request->amount;
            $loanObj->term = $request->term;
            $loanObj->term_amount = $termPayAmount[0]['termAmount'];
            $loanObj->date =  date('Y-m-d', strtotime($request->date));;
            if ($loanObj->save()) {

                foreach ($termPayAmount as $_termPayAmount) {
                    $estimatedLoanTermObj = new EstimatedLoanTerm();
                    $estimatedLoanTermObj->loan_id = $loanObj->id;
                    $estimatedLoanTermObj->date = $_termPayAmount['installmentDate'];
                    $estimatedLoanTermObj->amount = $_termPayAmount['termAmount'];
                    $estimatedLoanTermObj->save();
                }
                return response()->json(
                    [
                        'status' => 200,
                        'message' => 'Your Request was successfully processed',
                        'success' => 'Your Request was successfully processed'
                    ],
                    200
                );
            }
        } catch (Exception $ex) {
            return response()->json(
                [
                    'status' => 404,
                    'message' => 'Somthing went wrong',
                    'errors' => 'Somthing went wrong'
                ],
                $this->successStatus
            );
        }
    }

    public function calculateAmount($amount, $term, $date)
    {
        $installment = array();
        $termAmount = $amount / $term;

        for ($i = 1; $i <= $term; $i++) {
            $days = $i * 7;
            $installmentDate  = date('Y-m-d', strtotime($date . ' + ' . $days . 'days'));
            $installment[] = ['installmentDate' => $installmentDate, 'termAmount' => $termAmount];
        }
        return $installment;
    }


    /* Paid load term by customer   */
    public function viewLoan()
    {
        $user_id =  Auth::guard('user-api')->user()->id;
        $loanData = Loan::with('loanTerm')->where('user_id', $user_id)->orderBy('id', 'DESC')->get();
        return response()->json(['loanData' => $loanData], 200);
    }

    /* Estimated loan term */
    public function viewEstimatedLoanTerm()
    {
        $user_id =  Auth::guard('user-api')->user()->id;
        $loanData = Loan::with('EstimatedLoanTerm')->where('user_id', $user_id)->orderBy('id', 'DESC')->get();
        return response()->json(['loanData' => $loanData], 200);
    }

    /* function for Repayment Load  */
    public function repaymentLoan(Request $request)
    {
        $rules = [
            'id' => 'required',
            'amount' => 'required|numeric'
        ];
        $messages = [
            'id.required' => 'Id is required',
            'amount.required' => 'Amount is required',
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

        $totalPaidAmount = LoanTerm::where('loan_id', $request->id)->sum('amount');
        $loanDetailsObj =  Loan::where('id', $request->id)->first();

        if (isset($loanDetailsObj) && !empty($loanDetailsObj)) {
            $reminingAmount =   $loanDetailsObj->amount - $totalPaidAmount;

            if ($loanDetailsObj->loan_status == 'Paid') {
                return response()->json(
                    [
                        'status' => 200,
                        'success' => 'Loan has been already paid.'
                    ],
                );
            }

            if ($loanDetailsObj->amount < $request->amount) {
                return response()->json(
                    [
                        'status' => 400,
                        'success' => 'Repayment amount is greater than your loan amount. Please enter amount  $' . $loanDetailsObj->amount . ' or less than it.'
                    ],
                );
            }

            if ($loanDetailsObj->term_amount > $request->amount) {
                return response()->json(
                    [
                        'status' => 400,
                        'success' => 'Repayment amount is less than your loan amount. Please enter amount $' . $loanDetailsObj->term_amount . ' or greater than it.'
                    ],
                );
            }

            if ($reminingAmount < $request->amount) {
                return response()->json(
                    [
                        'status' => 400,
                        'success' => 'Repayment amount is less than your loan amount. Please enter amount $' . $loanDetailsObj->term_amount . ' or greater than it.'
                    ],
                );
            }
        }

        $loanTermObj = new LoanTerm();
        $loanTermObj->loan_id = $loanDetailsObj->id;
        $loanTermObj->date = date('Y-m-d');
        $loanTermObj->amount = $request->amount;
        $loanTermObj->loan_status = 'Paid';

        if ($loanTermObj->save()) {
            $totalPaidLoanTerm =  LoanTerm::where('loan_id', $loanDetailsObj->id)->where('loan_status', 'Paid')->get()->count();
            $totalLoanTerm =  $loanDetailsObj->term;

            if ($request->amount > $loanDetailsObj->term_amount) {
                $newAmount = $loanDetailsObj->amount - $request->amount;
                $newTerm = $loanDetailsObj->term - $totalPaidLoanTerm;
                $newTermAmout =  $this->calculateAmount($newAmount, $newTerm, $loanDetailsObj->date);
                $loanDetailsObj->term_amount = $newTermAmout[0]['termAmount'];
                $loanDetailsObj->save();
            }

            if ($totalLoanTerm == $totalPaidLoanTerm) {
                $loanDetailsObj->loan_status = 'Paid';
                $loanDetailsObj->save();
                // We can also manage history here but due to sort time i will not able to achive this
            }
            return response()->json(
                [
                    'status' => 200,
                    'success' => 'Payment update successfully.'
                ],
            );
        }
    }
}
