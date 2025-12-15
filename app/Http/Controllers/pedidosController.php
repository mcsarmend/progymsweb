<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User;

class pedidosController extends Controller
{
    public function pedidosnuevo()
    {
        $type = $this->gettype();
        return view('ventas.pedidos.nuevo', ['type' => $type]);

    }
    public function pedidosseleccionar()
    {
        $type = $this->gettype();
        return view('ventas.pedidos.seleccion', ['type' => $type]);

    }
    public function pedidosver()
    {
        $type = $this->gettype();
        return view('ventas.pedidos.ver', ['type' => $type]);

    }
    public function pedidosruta()
    {
        $type = $this->gettype();
        return view('ventas.pedidos.ruta', ['type' => $type]);

    }
    public function pedidosreporte()
    {
        $type = $this->gettype();
        return view('ventas.pedidos.reporte', ['type' => $type]);

    }
    public function pedidoscancelar()
    {
        $type = $this->gettype();
        return view('ventas.pedidos.cancelar', ['type' => $type]);

    }
    public function pedidosremisionar()
    {
        $type = $this->gettype();
        return view('ventas.pedidos.remisionar', ['type' => $type]);

    }
    public function gettype()
    {
        if (Auth::check()) {
            $type = Auth::user()->role;
        }
        return $type;
    }
}
