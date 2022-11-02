<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
use Validator;
use App\Models\User;


class CustomerController extends Controller
{

    public function customerRegister(Request $request)
    {
        try {
            $rules = [
                'name' => 'required',
                'email' => 'required|unique:users,email',
                'password' => 'required'
            ];
            $messages = [
                'name.required' => 'Name is required',
                'email.required' => 'Email is required',
                'password.required'  => 'Password is required'
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

            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => \Hash::make($request->password),
            ]);
            $token =  $user->createToken('Token')->accessToken;
            return response()->json([
                'status' => 200,
                'message' => 'Ragistration successfully',
                'success' => 'Ragistration successfully'
            ], 200);
        } catch (Exception $ex) {
            return response()->json(
                [
                    'status' => 404,
                    'message' => 'Somthing went wrong',
                    'errors' => 'Somthing went wrong'
                ]
            );
        }
    }




    public function customerLogin(Request $request)
    {
        try {

            $validator = Validator::make($request->all(), [
                'email' => 'required|email',
                'password' => 'required',
            ]);

            if ($validator->fails()) {

                return response()->json(['error' => $validator->errors()->all()]);
            }

            if (Auth::guard('user')->attempt(['email' => $request->email, 'password' => $request->password])) {

                config(['auth.guards.api.provider' => 'user']);

                $token = Auth::guard('user')->user()->createToken('MyApp', ['user'])->accessToken;

                return response()->json(['token' => $token], 200);
            } else {

                return response()->json(['error' => ['Email and Password are Wrong.']], 200);
            }
        } catch (Exception $ex) {
            return response()->json(
                [
                    'status' => 404,
                    'message' => 'Somthing went wrong',
                    'errors' => 'Somthing went wrong'
                ]
            );
        }
    }
}
