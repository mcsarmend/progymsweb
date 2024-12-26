<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\clients;
use App\Models\product;
use App\Models\warehouse;
use Illuminate\Support\Facades\Auth;

class cuentasController extends Controller
{
    public function cxccliente()
    {
        $idsucursal = Auth::user()->warehouse;
        $vendedor = Auth::user()->name;
        $idvendedor = Auth::user()->id;
        $nombresucursal = warehouse::select('nombre')
            ->where('id', '=', $idsucursal)
            ->first();
        $idssucursales = warehouse::select('id', 'nombre')
            ->get();

        $clientes = clients::all();
        $type = $this->gettype();
        $productos = product::all();
        return view('cuentas.cxccliente', ['type' => $type, 'idssucursales' => $idssucursales, 'idsucursal' => $idsucursal, 'nombresucursal' => $nombresucursal, 'idvendedor' => $idvendedor, 'vendedor' => $vendedor, 'clientes' => $clientes, 'productos' => $productos]);
    }
    public function gettype()
    {
        if (Auth::check()) {
            $type = Auth::user()->role;
        }
        return $type;
    }
}
