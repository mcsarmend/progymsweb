<?php
namespace App\Http\Controllers;

use App\Models\category;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;

class categoriasController extends Controller
{
    public function altacategoria()
    {
        $type = $this->gettype();
        return view('categorias.alta', ['type' => $type]);
    }
    public function bajacategoria()
    {
        $categories = category::all();
        $type   = $this->gettype();
        return view('categorias.baja', ['type' => $type, 'categorias' => $categories]);
    }
    public function categorias()
    {
        $type   = $this->gettype();
        $categories = category::select('category.id', 'category.nombre')
            ->get();

        return view('categorias.categorias', ['type' => $type, 'categorias' => $categories]);
    }
    public function edicioncategoria()
    {
        $type   = $this->gettype();
        $categories = category::all();

        return view('categorias.edicion', ['type' => $type, 'categorias' => $categories]);
    }


     public function crearcategoria(Request $request)
    {

        try {

            // Crear una nueva instancia del modelo Usuario
            $categoria = new category();
            $categoria->nombre = $request->categoria;
            $categoria->save();

            // Devolver una respuesta de éxito
            return response()->json(['message' => 'Categoria creada correctamente'], 200);
        } catch (\Throwable $e) {
            // Devolver una respuesta de error
            return response()->json(['message' => 'Error al crear la categoria: ' . $e->getMessage()], 500);
        }
    }

    public function eliminarcategoria(Request $request)
    {
        try {
            // Encuentra el usuario por su ID
            $id = $request->categorias;

            category::findOrFail($id)->delete();
            return response()->json(['message' => 'categoria eliminada correctamente'], 200);
        } catch (\Throwable $e) {
            // Devolver una respuesta de error
            return response()->json(['message' => $e->getMessage()], 500);
        }
    }

    public function editarcategoria(Request $request)
    {
        try {
            $idcategoria = $request->categoria;
            $nuevo_nombre = $request->nombre;
            $categoria = category::find($idcategoria);
            $categoria->nombre = $nuevo_nombre;
            $categoria->save();

            return response()->json(['message' => "Categoria actualizada correctamente"], 200);
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
