<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\seller;
use App\Models\warehouse;
use Illuminate\Foundation\Auth\User;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Auth;

class vendedorController extends Controller
{

    public function altavendedores()
    {
        $type = $this->gettype();
        return view('vendedores.alta', ['type' => $type]);
    }
    public function bajavendedores()
    {
        $type = $this->gettype();
        $vendedores = seller::all();
        return view('vendedores.baja', ['type' => $type, 'seller' => $vendedores]);
    }
    public function edicionvendedores()
    {
        $users = User::all();
        $type = $this->gettype();
        $warehouses = warehouse::all();
        return view('vendedores.edicion', ['type' => $type, 'users' => $users, 'warehouses' => $warehouses]);
    }
    public function vendedores()
    {
        $users = User::select('users.name as nombre', 'users.email as correo', 'users.pass as contrasena', 'users.phone as telefono', 'users.role as rol', 'warehouse.nombre as sucursal')
            ->leftJoin('warehouse', 'users.warehouse', '=', 'warehouse.id')
            ->get();
        $type = $this->gettype();
        return view('vendedores.vendedores', ['type' => $type, 'users' => $users]);
    }

    public function crearvendedor(Request $request)
    {
        try {
            // Crear una nueva instancia del modelo Usuario
            $seller = new seller();
            $seller->nombre = $request->nombre;
            // Guardar el usuario en la base de datos
            $seller->save();
            // Devolver una respuesta de éxito
            return response()->json(['message' => 'vendedor creado correctamente'], 200);
        } catch (\Throwable $e) {
            // Devolver una respuesta de error
            return response()->json(['message' => 'Error al crear el vendedor: ' . $e->getMessage()], 500);
        }
    }
    public function editarvendedor(Request $request)
    {
        try {
            $idvendedor = intval(Crypt::decrypt($request->id));
            $sucursal = intval(Crypt::decrypt($request->sucursal));

            User::where('id', $idvendedor)
                ->update([
                    'warehouse' => $sucursal,

                ]);
            return response()->json(['message' => "Vendedor actualizado correctamente"], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => $th->getMessage()], 500);
        }
    }
    public function eliminarvendedor(Request $request)
    {
        try {
            // Encuentra el usuario por su ID
            $id = $request->id;


            $productid = Crypt::decrypt($id);
            seller::findOrFail($productid)->delete();
            return response()->json(['message' => 'vendedor eliminado correctamente'], 200);
        } catch (\Throwable $e) {
            // Devolver una respuesta de error
            return response()->json(['message' => $e->getMessage()], 500);
        }
    }




    public function gettype()
    {
        if (Auth::check()) {
            $type = Auth::user()->role;
        }
        return $type;
    }
}
