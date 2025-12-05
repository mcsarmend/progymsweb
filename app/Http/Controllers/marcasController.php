<?php

namespace App\Http\Controllers;
use App\Models\prices;
use App\Models\warehouse;
use App\Models\brand;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class marcasController extends Controller
{
    public function altamarca()
    {
        $type = $this->gettype();
        return view('marcas.alta', ['type' => $type]);
    }
    public function bajamarca()
    {
        $brands = brand::all();
        $type = $this->gettype();
        return view('marcas.baja', ['type' => $type, 'marcas' => $brands]);
    }
    public function marcas()
    {
        $type = $this->gettype();
        $brands = brand::select('brand.id', 'brand.nombre')
        ->get();

        return view('marcas.marcas', ['type' => $type, 'marcas' => $brands]);
    }
    public function edicionmarca()
    {
        $type = $this->gettype();
        $brands = brand::all();

        return view('marcas.edicion', ['type' => $type, 'marcas' => $brands]);
    }


     public function crearmarca(Request $request)
    {

        try {

            // Crear una nueva instancia del modelo Usuario
            $marca = new brand();
            $marca->nombre = $request->marca;
            $marca->save();

            // Devolver una respuesta de éxito
            return response()->json(['message' => 'Marca creada correctamente'], 200);
        } catch (\Throwable $e) {
            // Devolver una respuesta de error
            return response()->json(['message' => 'Error al crear la marca: ' . $e->getMessage()], 500);
        }
    }

    public function eliminarmarca(Request $request)
    {
        try {
            // Encuentra el usuario por su ID
            $id = $request->id;
            brand::findOrFail($id)->delete();
            return response()->json(['message' => 'marca eliminada correctamente'], 200);
        } catch (\Throwable $e) {
            // Devolver una respuesta de error
            return response()->json(['message' => $e->getMessage()], 500);
        }
    }

    public function editarmarca(Request $request)
    {
        try {
            $idmarca = $request->marca;
            $nuevo_nombre = $request->nombre;
            $marca = brand::find($idmarca);
            $marca->nombre = $nuevo_nombre;
            $marca->save();

            return response()->json(['message' => "Marca actualizada correctamente"], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => $th->getMessage()], 500);
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
