<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;


class comprasController extends Controller
{
    public function altacompras()
    {
        $type = $this->gettype();
        return view('compras.alta', ['type'=>$type]);
    }
    public function bajacompras()
    {
        $type = $this->gettype();
        return view('compras.baja', ['type'=>$type]);
    }
    public function edicioncompras()
    {
        $type = $this->gettype();
        return view('compras.edicion', ['type'=>$type]);
    }
    public function gettype(){
        if (Auth::check()) {
            $type = Auth::user()->type;
        }
        return $type;
    }

}
