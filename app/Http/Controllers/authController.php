<?php
namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class authController extends Controller
{
    //Register user
    public function register(Request $request)
    {

        //validate fields
        $attrs = $request->validate([
            'name'     => 'required|string',
            'email'    => 'required|email|unique:users,email',
            'number'   => 'required|string',
            'pass'     => 'required|string',
            'type'     => 'required|string',
            'password' => 'required|min:6|confirmed',
        ]);

        //create user
        $user = User::create([
            'name'     => $attrs['name'],
            'email'    => $attrs['email'],
            'number'   => $attrs['number'],
            'pass'     => $attrs['pass'],
            'type'     => $attrs['type'],
            'password' => bcrypt($attrs['password']),
        ]);

        //return user & token in response
        /** @var \App\Models\User $user */
        return response([
            'user'  => $user,
            'token' => $user->createToken('api')->plainTextToken,
        ], 200);
    }

    // login user
    public function login(Request $request)
    {
        //validate fields
        $attrs = $request->validate([
            'email'    => 'required|email',
            'password' => 'required|min:6',
        ]);

        // attempt login
        if (! Auth::attempt($attrs)) {
            return response([
                'message' => 'Invalid credentials.',
            ], 403);
        }

        //return user & token in response
        /** @var \App\Models\User $user */
        $user = auth()->user();
        return response([
            'user'  => $user,
            'token' => $user->createToken('secret')->plainTextToken,
        ], 200);
    }

    // logout user
    public function logout()
    {
        // If Sanctum/Passport tokens relationship isn't available on the User model
        // delete tokens directly from the personal_access_tokens table for this user
        if (auth()->check()) {
            DB::table('personal_access_tokens')->where('tokenable_id', auth()->id())->delete();
        }
        return response([
            'message' => 'Logout success.',
        ], 200);
    }

    // get user details
    public function user()
    {
        return response([
            'user' => auth()->user(),
        ], 200);
    }

    // update user
    public function update(Request $request)
    {
        $attrs = $request->validate([
            'name'   => 'required|string',
            'email'  => 'required|string',
            'image'  => 'string',
            'number' => 'required|string',
        ]);

        $image = $this->saveImage($request->image, 'profiles');

        // Ensure we have an Eloquent User instance to call update on
        $user = User::find(auth()->id());
        if ($user) {
            $user->update([
                'name'   => $attrs['name'],
                'email'  => $attrs['email'],
                'number' => $attrs['number'],
                'image'  => $image,
            ]);
        }

        return response([
            'message' => 'User updated.',
            'user'    => auth()->user(),
        ], 200);
    }

    public function drop(Request $request)
    {
        try {
            // eliminar cuenta
            DB::table('users')->where('id', $request->id)->delete();
            return response()->json([
                "success" => "Registro eliminado correctamente",
            ]);
        } catch (\Exception $e) {
            return response()->json([
                "error" => "No se pudo eliminar el registro:" . $e->getMessage(),
            ]);

        }
    }
}
