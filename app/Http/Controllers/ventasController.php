<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\warehouse;
use App\Models\clients;
use App\Models\prices;
use App\Models\product;
use App\Models\productprice;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Log;

class ventasController extends Controller
{
    public function remisionar()
    {
        $idsucursal = Auth::user()->warehouse;
        $vendedor = Auth::user()->name;
        $idvendedor = Auth::user()->id;
        $nombresucursal = warehouse::select('nombre')
            ->where('id', '=', $idsucursal)
            ->first();
        $clientes = clients::all();
        $type = $this->gettype();
        $productos = product::all();
        return view('ventas.remisionar', ['type' => $type, 'idsucursal' => $idsucursal, 'nombresucursal' => $nombresucursal, 'idvendedor' => $idvendedor, 'vendedor' => $vendedor, 'clientes' => $clientes, 'productos' => $productos]);
    }
    public function remisiones()
    {
        $type = $this->gettype();
        return view('ventas.remisiones', ['type' => $type]);
    }
    public function ventasreportes()
    {
        $type = $this->gettype();
        return view('ventas.reportes', ['type' => $type]);
    }

    public function buscarprecio(Request $request)
    {
        $idproducto = $request->id_producto;
        $cantidad = $request->cantidad;
        $idcliente = $request->idcliente;
        $idprice = clients::where('id', '=', $idcliente)->value('precio');
        $nombre = product::where('id', '=', $idproducto)->value('nombre');
        $precio = productprice::where('idproducto', '=', $idproducto)
            ->where('idprice', '=', $idprice)
            ->value('price');
        $subtotal = intval($precio) * intval($cantidad);
        return response()->json([
            'idproducto' => $idproducto,
            'precio' => $precio,
            'subtotal' => $subtotal,
            'nombre' => $nombre,
            'cantidad' => $cantidad
        ]);
    }
    public function buscaridprecio(Request $request)
    {

        $idcliente = $request->idcliente;
        $idprice = clients::where('id', '=', $idcliente)->value('precio');
        $precio = prices::where('id', '=', $idprice)
            ->value('nombre');

        return response()->json([
            'nombreprecio' => $precio,
            'cantidad' => $request->cantidad
        ]);
    }


    public function gettype()
    {
        if (Auth::check()) {
            $type = Auth::user()->type;
        }
        return $type;
    }
}
