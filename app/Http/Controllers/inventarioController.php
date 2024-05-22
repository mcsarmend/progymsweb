<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\brand;
use App\Models\category;

class inventarioController extends Controller
{
    public function ingresoinventario()
    {
        $type = $this->gettype();
        $marcas = Brand::select('id', 'nombre')
        ->orderBy('nombre', 'asc')
        ->get();
        $categorias = category::select('id', 'nombre')
        ->orderBy('nombre', 'asc')
        ->get();

        return view('inventario.ingreso', ['type'=>$type,'marcas'=>$marcas,'categorias'=>$categorias]);
    }
    public function multiingresoinventario()
    {
        $type = $this->gettype();
        return view('inventario.multiingreso', ['type'=>$type]);
    }
    public function bajainventario()
    {
        $type = $this->gettype();
        return view('inventario.baja', ['type'=>$type]);
    }

    public function edicioninventario()
    {
        $type = $this->gettype();
        return view('inventario.edicion', ['type'=>$type]);
    }

    public function gettype(){
        if (Auth::check()) {
            $type = Auth::user()->type;
        }
        return $type;
    }
}
