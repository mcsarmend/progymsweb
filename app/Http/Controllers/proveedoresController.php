<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\supplier;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Crypt;

class proveedoresController extends Controller
{
    public function altaproveedores()
    {
        $type = $this->gettype();
        return view('proveedores.alta', ['type' => $type]);
    }
    public function bajaproveedores()
    {
        $type = $this->gettype();
        $proveedores = supplier::all();
        return view('proveedores.baja', ['type' => $type, 'suppliers' => $proveedores]);
    }
    public function edicionproveedores()
    {
        $proveedores = supplier::all();
        $type = $this->gettype();
        return view('proveedores.edicion', ['type' => $type, 'suppliers' => $proveedores]);
    }
    public function proveedores()
    {
        $proveedores = supplier::all();
        $type = $this->gettype();
        return view('proveedores.proveedores', ['type' => $type, 'suppliers' => $proveedores]);
    }

    public function crearproveedor(Request $request)
    {
        try {
            // Crear una nueva instancia del modelo Usuario
            $proveedor = new supplier();
            $proveedor->nombre = $request->proveedor;
            $proveedor->telefono = $request->telefono;
            $proveedor->clave = $request->clave;
            // Guardar el usuario en la base de datos
            $proveedor->save();
            // Devolver una respuesta de éxito
            return response()->json(['message' => 'Proveedor creado correctamente'], 200);
        } catch (\Throwable $e) {
            // Devolver una respuesta de error
            return response()->json(['message' => 'Error al crear el proveedor'], 500);
        }
    }
    public function editarproveedor(Request $request)
    {
        try {
            $idproveedor = intval(Crypt::decrypt($request->id));
            $nuevo_nombre = $request->nombre;
            $telefono = $request->telefono;
            supplier::where('id', $idproveedor)
                ->update([
                    'nombre' => $nuevo_nombre,
                    'telefono' => $telefono,
                ]);
            return response()->json(['message' => "Proveedor actualizado correctamente"], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => $th->getMessage()], 500);
        }
    }
    public function eliminarproveedor(Request $request)
    {
        try {
            // Encuentra el usuario por su ID
            $id = $request->id;

            $productid = Crypt::decrypt($id);
            supplier::findOrFail($productid)->delete();
            return response()->json(['message' => 'Proveedor eliminado correctamente'], 200);
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
