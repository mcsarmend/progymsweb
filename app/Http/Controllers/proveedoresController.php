<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class proveedoresController extends Controller
{
    public function altaproveedores()
    {
        $type = $this->gettype();
        return view('proveedores.alta', ['type'=>$type]);
    }
    public function bajaproveedores()
    {
        $type = $this->gettype();
        return view('proveedores.baja', ['type'=>$type]);
    }
    public function edicionproveedores()
    {
        $type = $this->gettype();
        return view('proveedores.edicion',['type'=>$type]);
    }
    public function gettype(){
        if (Auth::check()) {
            $type = Auth::user()->type;
        }
        return $type;
    }

}
