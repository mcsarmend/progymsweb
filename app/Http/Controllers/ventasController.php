<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
class ventasController extends Controller
{
    public function remisionar(){
        $type = $this->gettype();
        return view('ventas.remisionar', ['type'=>$type]);
    }
    public function remisiones(){
        $type = $this->gettype();
        return view('ventas.remisiones', ['type'=>$type]);
    }
    public function ventasreportes(){
        $type = $this->gettype();
        return view('ventas.reportes', ['type'=>$type]);
    }

    public function gettype(){
        if (Auth::check()) {
            $type = Auth::user()->type;
        }
        return $type;
    }
}
