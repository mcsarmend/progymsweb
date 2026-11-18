<?php
namespace App\Http\Controllers;

use App\Models\creditors;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Crypt;

class acreedoresController extends Controller
{
    public function altaacreedores()
    {
        $type = $this->gettype();
        return view('acreedores.alta', ['type' => $type]);
    }
    public function bajaacreedores()
    {
        $type       = $this->gettype();
        $acreedores = creditors::all();
        return view('acreedores.baja', ['type' => $type, 'creditors' => $acreedores]);
    }
    public function edicionacreedores()
    {
        $acreedores = creditors::all();
        $type       = $this->gettype();
        return view('acreedores.edicion', ['type' => $type, 'creditors' => $acreedores]);
    }
    public function acreedores()
    {
        $acreedores = creditors::all();
        $type       = $this->gettype();
        return view('acreedores.acreedores', ['type' => $type, 'creditors' => $acreedores]);
    }

    public function crearacreedor(Request $request)
    {
        try {
            // Crear una nueva instancia del modelo Usuario
            $acreedor           = new creditors();
            $acreedor->nombre   = $request->acreedor;
            $acreedor->telefono = $request->telefono;
            // Guardar el usuario en la base de datos
            $acreedor->save();
            // Devolver una respuesta de éxito
            return response()->json(['message' => 'acreedor creado correctamente'], 200);
        } catch (\Throwable $e) {
            // Devolver una respuesta de error
            return response()->json(['message' => 'Error al crear el acreedor' . $e->getMessage()], 500);
        }
    }
    public function editaracreedor(Request $request)
    {
        try {
            $idacreedor   = intval(Crypt::decrypt($request->id));
            $nuevo_nombre = $request->nombre;
            $telefono     = $request->telefono;
            creditors::where('id', $idacreedor)
                ->update([
                    'nombre'   => $nuevo_nombre,
                    'telefono' => $telefono,
                ]);
            return response()->json(['message' => "acreedor actualizado correctamente"], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => $th->getMessage()], 500);
        }
    }
    public function eliminaracreedor(Request $request)
    {
        try {
            // Encuentra el usuario por su ID
            $id = $request->id;

            $productid = Crypt::decrypt($id);
            creditors::findOrFail($productid)->delete();
            return response()->json(['message' => 'acreedor eliminado correctamente'], 200);
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
