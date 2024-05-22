<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class multialmacenController extends Controller
{
    public function altalmacen()
    {
        $type = $this->gettype();
        return view('almacen.alta', ['type'=>$type]);
    }
    public function bajaalmacen()
    {
        $type = $this->gettype();
        return view('almacen.baja', ['type'=>$type]);
    }
    public function edicionalmacen()
    {
        $type = $this->gettype();
        return view('almacen.edicion', ['type'=>$type]);
    }

    public function traspasos()
    {
        $type = $this->gettype();
        return view('almacen.traspaso', ['type'=>$type]);
    }
    public function gettype(){
        if (Auth::check()) {
            $type = Auth::user()->type;
        }
        return $type;
    }
}
