<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class pedidosController extends Controller
{
    public function altapedidos(){
        $type = $this->gettype();
        return view('pedidos.alta', ['type'=>$type]);

    }
    public function gettype(){
        if (Auth::check()) {
            $type = Auth::user()->type;
        }
        return $type;
    }
}
