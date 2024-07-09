<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\productwarehouse;
use App\Models\warehouse;
use App\Models\clients;
use App\Models\prices;
use App\Models\product;
use App\Models\productprice;
use App\Models\referrals;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use DateTime;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;


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


        $timezone = 'America/Mexico_City';
        $hoy = Carbon::today($timezone);

        $remisiones = referrals::whereDate('fecha', $hoy)
            ->leftJoin('warehouse as w', 'referrals.almacen', '=', 'w.id')
            ->leftJoin('users as u', 'referrals.vendedor', '=', 'u.id')
            ->select(
                'referrals.id',
                'referrals.fecha',
                DB::raw('IFNULL(referrals.nota, "SIN NOTA") as nota'),
                'referrals.forma_pago',
                'referrals.cliente',
                'referrals.productos',
                'referrals.total',
                'w.nombre as almacen',
                'u.name as vendedor',
                'referrals.estatus'
            )
            ->get();


        $type = $this->gettype();

        return view('ventas.remisiones', ['type' => $type, 'remisiones' => $remisiones]);
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
        $idsucursal = $request->almacen;

        // Validar existencias en sucursal
        $validarCantidad = productwarehouse::where('idproducto', '=', $idproducto)
            ->where('idwarehouse', '=', $idsucursal)
            ->value('existencias');
        if ($validarCantidad == null) {

            return response()->json([
                'error' => 'No hay existencias suficientes. Cuentas con: 0'
            ], 500);
        } else {

            if ($cantidad > $validarCantidad) {
                return response()->json([
                    'error' => 'No hay existencias suficientes. Cuentas con: ' . $validarCantidad
                ], 500);
            } else {
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


        }




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

    public function validarremision(Request $request)
    {
        try {
            // Crear una nueva instancia del modelo referrals
            $remision = new referrals();
            $date = DateTime::createFromFormat('j/n/Y, H:i:s', $request->fecha);
            $fechaMysql = $date->format('Y-m-d H:i:s');
            $remision->fecha = $fechaMysql;
            $remision->nota = $request->nota;
            $remision->forma_pago = $request->forma_pago;
            $remision->vendedor = $request->vendedor;
            $remision->cliente = $request->cliente;
            $almacen = $request->almacen;
            $remision->almacen = $almacen;
            $remision->total = $request->total;
            $remision->estatus = "emitida";


            $productos = json_decode($request->productos);
            $remision->productos = json_encode($productos); // Convertir el array de productos a JSON




            foreach ($productos as $producto) {

                $idproducto = $producto->Codigo;

                $existenciasActual = productwarehouse::select('existencias')
                    ->where('idproducto', intVal($idproducto))
                    ->where('idwarehouse', intVal($almacen))
                    ->first();

                $CantidadDescontar = $producto->Cantidad;
                $nuevaexistencia = $existenciasActual->existencias - intVal($CantidadDescontar);


                productwarehouse::where('idproducto', intVal($idproducto))
                    ->where('idwarehouse', intVal($almacen))
                    ->update([
                        'existencias' => $nuevaexistencia
                    ]);
            }

            // Guardar la remisión en la base de datos
            $remision->save();

            // Obtener el ID recién creado
            $idCreado = $remision->id;

            // Devolver una respuesta de éxito con el ID
            return response()->json(['message' => 'Remisión creada correctamente', 'id' => $idCreado], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al realizar remisión' . $th->getMessage()], 500);
        }
    }

    public function verproductosremision(Request $request)
    {
        $idremision = $request->id;
        $remision = referrals::find($idremision);
        $productos = json_decode($remision->productos);

        return response()->json(['productos' => $productos], 200);
    }

    public function cancelarremision(Request $request)
    {
        try {
            $idremision = $request->id;
            $remision = referrals::find($idremision);
            $remision->estatus = "cancelada";
            $almacen = $remision->almacen;
            $productos = $remision->productos;

            $productos = json_decode($productos);
            foreach ($productos as $producto) {

                $idproducto = $producto->Codigo;

                $existenciasActual = productwarehouse::select('existencias')
                    ->where('idproducto', intVal($idproducto))
                    ->where('idwarehouse', intVal($almacen))
                    ->first();

                $CantidadSumar = $producto->Cantidad;
                $nuevaexistencia = $existenciasActual->existencias + intVal($CantidadSumar);


                productwarehouse::where('idproducto', intVal($idproducto))
                    ->where('idwarehouse', intVal($almacen))
                    ->update([
                        'existencias' => $nuevaexistencia
                    ]);
            }



            $idremision = $request->id;
            $remision = referrals::find($idremision);
            $remision->estatus = "cancelada";
            $remision->save();




            return response()->json(['message' => 'Remisión cancelada correctamente'], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Error al cenlar la remision' . $th->getMessage()], 200);
        }


    }

    public function reporteremisiones(Request $request)
    {
        try {
            $dateStart = Carbon::parse($request->dateStart)->startOfDay();
            $dateEnd = Carbon::parse($request->dateEnd)->endOfDay();

            // Obtener remisiones en el rango de fechas
            $remisiones = referrals::whereBetween('fecha', [$dateStart, $dateEnd])->get();

            $remisiones = referrals::whereBetween('fecha', [$dateStart, $dateEnd])
                ->leftJoin('warehouse as w', 'referrals.almacen', '=', 'w.id')
                ->leftJoin('users as u', 'referrals.vendedor', '=', 'u.id')
                ->select(
                    'referrals.id',
                    'referrals.fecha',
                    DB::raw('IFNULL(referrals.nota, "SIN NOTA") as nota'),
                    'referrals.forma_pago',
                    'referrals.cliente',
                    'referrals.productos',
                    'referrals.total',
                    'w.nombre as almacen',
                    'u.name as vendedor',
                    'referrals.estatus'
                )
                ->get();
            return response()->json(['message' => 'Reporte Generado Correctamente', 'remisiones' => $remisiones], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al generar el reporte' . $th->getMessage()], 500);
        }


    }
    public function gettype()
    {
        if (Auth::check()) {
            $type = Auth::user()->role;
        }
        return $type;
    }
}
