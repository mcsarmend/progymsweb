<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
class clientesController extends Controller
{
    public function altacliente()
    {
        $type = $this->gettype();
        return view('clientes.alta', ['type'=>$type]);
    }
    public function bajacliente()
    {
        $type = $this->gettype();
        return view('clientes.baja', ['type'=>$type]);
    }
    public function edicioncliente()
    {
        $type = $this->gettype();
        return view('clientes.edicion', ['type'=>$type]);
    }
    public function gettype(){
        if (Auth::check()) {
            $type = Auth::user()->type;
        }
        return $type;
    }
    
}
