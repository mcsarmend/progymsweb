<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;

class reconocimientosController extends Controller
{
    public function reconocimientos()
    {
        $type = $this->gettype();

        return view('reconocimientos.reconocimientos', ['type' => $type]);
    }
    public function nuevoreconocimiento()
    {
        $type = $this->gettype();

        return view('reconocimientos.nuevo', ['type' => $type]);
    }
    public function gettype()
    {
        if (Auth::check()) {
            $type = Auth::user()->role;
        }
        return $type;
    }
}
