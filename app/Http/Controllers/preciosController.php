<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Auth;
use App\Models\prices;

class preciosController extends Controller
{
    public function altaprecios()
    {
        $type = $this->gettype();
        return view('precios.alta', ['type' => $type]);
    }
    public function bajaprecios()
    {
        $type = $this->gettype();
        $precios = prices::all();
        return view('precios.baja', ['type' => $type, 'prices' => $precios]);
    }
    public function edicionprecios()
    {
        $precios = prices::all();
        $type = $this->gettype();
        return view('precios.edicion', ['type' => $type, 'prices' => $precios]);
    }
    public function precios()
    {
        $precios = prices::all();
        $type = $this->gettype();
        return view('precios.precios', ['type' => $type, 'prices' => $precios]);
    }

    public function crearprecio(Request $request)
    {
        try {
            // Crear una nueva instancia del modelo Usuario
            $prices = new prices();
            $prices->nombre = $request->nombre;
            // Guardar el usuario en la base de datos
            $prices->save();
            // Devolver una respuesta de éxito
            return response()->json(['message' => 'precio creado correctamente'], 200);
        } catch (\Throwable $e) {
            // Devolver una respuesta de error
            return response()->json(['message' => 'Error al crear el precio: ' . $e->getMessage()], 500);
        }
    }
    public function editarprecio(Request $request)
    {

        try {
            $idprecio = intval(Crypt::decrypt($request->id));
            $nuevo_nombre = $request->nombre;

            prices::where('id', $idprecio)
                ->update([
                    'nombre' => $nuevo_nombre,

                ]);
            return response()->json(['message' => "precio actualizado correctamente"], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => $th->getMessage()], 500);
        }
    }
    public function eliminarprecio(Request $request)
    {
        try {
            // Encuentra el usuario por su ID
            $id = $request->id;


            $productid = Crypt::decrypt($id);
            prices::findOrFail($productid)->delete();
            return response()->json(['message' => 'precio eliminado correctamente'], 200);
        } catch (\Throwable $e) {
            // Devolver una respuesta de error
            return response()->json(['message' => $e->getMessage()], 500);
        }
    }




    public function gettype()
    {
        if (Auth::check()) {
            $type = Auth::user()->type;
        }
        return $type;
    }
}
