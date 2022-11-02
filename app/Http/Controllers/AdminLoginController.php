<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Validator;
use Auth;
use App\Models\Admin;

class AdminLoginController extends Controller
{
    public function adminLogin(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if($validator->fails()){

            return response()->json(['error' => $validator->errors()->all()]);
        }

        if(Auth::guard('admin')->attempt(['email' => $request->email, 'password' => $request->password])){

            config(['auth.guards.api.provider' => 'admin']);
            
            $token = Auth::guard('admin')->user()->createToken('MyApp',['admin'])->accessToken;
            
            return response()->json(['token' => $token], 200);

        }else{ 

            return response()->json(['error' => ['Email and Password are Wrong.']], 200);
        }
    }
}
