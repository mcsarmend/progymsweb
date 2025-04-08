<?php
namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\accounts_receivable;
use App\Models\clients;
use App\Models\prices;
use App\Models\product;
use App\Models\productprice;
use App\Models\productwarehouse;
use App\Models\referrals;
use App\Models\stockMovements;
use App\Models\user;
use App\Models\warehouse;
use Carbon\Carbon;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ventasController extends Controller
{
    public function remisionar()
    {
        $idsucursal     = Auth::user()->warehouse;
        $vendedor       = Auth::user()->name;
        $idvendedor     = Auth::user()->id;
        $nombresucursal = warehouse::select('nombre')
            ->where('id', '=', $idsucursal)
            ->first();
        $idssucursales = warehouse::select('id', 'nombre')
            ->get();

        $clientes   = clients::all();
        $type       = $this->gettype();
        $vendedores = DB::table('users')
            ->select('id', 'name')
            ->get();
        $productos = Product::leftJoin('product_warehouse', 'product.id', '=', 'product_warehouse.idproducto')
            ->where('product_warehouse.idwarehouse', $idsucursal)
            ->select('product.*') // Selecciona las columnas de la tabla principal
            ->get();

        return view('ventas.remisionar', ['type' => $type, 'idssucursales' => $idssucursales, 'idsucursal' => $idsucursal, 'nombresucursal' => $nombresucursal, 'idvendedor' => $idvendedor, 'vendedor' => $vendedor, 'clientes' => $clientes, 'productos' => $productos, 'vendedores' => $vendedores]);
    }
    public function remisionarlista()
    {
        $idsucursal     = Auth::user()->warehouse;
        $vendedor       = Auth::user()->name;
        $idvendedor     = Auth::user()->id;
        $nombresucursal = warehouse::select('nombre')
            ->where('id', '=', $idsucursal)
            ->first();
        $idssucursales = warehouse::select('id', 'nombre')
            ->get();
        $vendedores = user::all();

        $clientes  = clients::all();
        $type      = $this->gettype();
        $productos = Product::leftJoin('product_warehouse', 'product.id', '=', 'product_warehouse.idproducto')
            ->leftJoin('product_price', 'product.id', '=', 'product_price.idproducto') // Relación correcta
            ->where('product_warehouse.idwarehouse', $idsucursal)
            ->where('product_price.idprice', 6) // Filtro adicional (si es necesario)
            ->select('product.*', 'product_price.price as precio')
            ->get();

        return view('ventas.remisionarlista', ['type' => $type, 'idssucursales'        => $idssucursales, 'idsucursal' => $idsucursal,
            'nombresucursal'                              => $nombresucursal, 'idvendedor' => $idvendedor, 'vendedor'      => $vendedor, 'clientes' => $clientes, 'productos' => $productos, 'vendedores' => $vendedores]);
    }
    public function remisiones()
    {

        $timezone   = 'America/Mexico_City';
        $hoy_inicio = Carbon::today($timezone)->startOfDay()->toDateTimeString(); // '2024-12-10 00:00:00'
        $hoy_fin    = Carbon::today($timezone)->endOfDay()->toDateTimeString();   // '2024-12-10 23:59:59'
        $id         = Auth::user()->id;
        $query      = 'CALL obtenerremisiones("' . $hoy_inicio . '","' . $hoy_fin . '",' . $id . ')';

        $remisiones = DB::select($query);

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
        $cantidad   = $request->cantidad;
        $idcliente  = $request->idcliente;
        $idprice    = $request->id_precio;
        $nombre     = product::where('id', '=', $idproducto)->value('nombre');
        $idsucursal = $request->sucursal;

        // Validar existencias en sucursal
        $validarCantidad = productwarehouse::where('idproducto', '=', $idproducto)
            ->where('idwarehouse', '=', $idsucursal)
            ->value('existencias');
        if ($validarCantidad == null) {

            return response()->json([
                'error' => 'No hay existencias suficientes. Cuentas con: 0',
            ], 500);
        } else {

            if ($cantidad > $validarCantidad) {
                return response()->json([
                    'error' => 'No hay existencias suficientes. Cuentas con: ' . $validarCantidad,
                ], 500);
            } else {
                $precio = productprice::where('idproducto', '=', $idproducto)
                    ->where('idprice', '=', $idprice)
                    ->value('price');
                $subtotal = intval($precio) * intval($cantidad);
                return response()->json([
                    'idproducto' => $idproducto,
                    'precio'     => $precio,
                    'subtotal'   => $subtotal,
                    'nombre'     => $nombre,
                    'cantidad'   => $cantidad,
                ]);
            }

        }

    }
    public function buscaridprecio(Request $request)
    {

        $idcliente = $request->idcliente;
        $idprice   = clients::where('id', '=', $idcliente)->value('precio');
        $precio    = prices::where('id', '=', $idprice)
            ->value('nombre');

        return response()->json([
            'nombreprecio' => $precio,
            'idprecio'     => $idprice,
        ]);
    }

    public function validarremision(Request $request)
    {
        try {
            // Crear una nueva instancia del modelo referrals
            $remision                 = new referrals();
            $date                     = DateTime::createFromFormat('j/n/Y, H:i:s', $request->fecha);
            $fechaMysql               = $date->format('Y-m-d H:i:s');
            $remision->fecha          = $fechaMysql;
            $remision->nota           = $request->nota;
            $remision->forma_pago     = $request->forma_pago;
            $remision->vendedor       = $request->vendedor;
            $remision->cliente        = $request->cliente;
            $almacen                  = $request->almacen;
            $remision->almacen        = $almacen;
            $remision->total          = $request->total;
            $remision->estatus        = "emitida";
            $remision->tipo_de_precio = $request->tipo_precio;
            if ($request->reparto == null) {
                $remision->reparto = 0;

            } else {
                $remision->reparto          = $request->reparto;
                $remision->vendedor_reparto = $request->vendedor_reparto;
            }

            $productos           = json_decode($request->productos);
            $remision->productos = json_encode($productos); // Convertir el array de productos a JSON

            foreach ($productos as $producto) {

                $idproducto = $producto->Codigo;

                $existenciasActual = productwarehouse::select('existencias')
                    ->where('idproducto', intVal($idproducto))
                    ->where('idwarehouse', intVal($almacen))
                    ->first();

                $CantidadDescontar = $producto->Cantidad;
                $nuevaexistencia   = $existenciasActual->existencias - intVal($CantidadDescontar);

                productwarehouse::where('idproducto', intVal($idproducto))
                    ->where('idwarehouse', intVal($almacen))
                    ->update([
                        'existencias' => $nuevaexistencia,
                    ]);
            }

            // Guardar la remisión en la base de datos
            $remision->save();

            // Obtener el ID recién creado
            $idCreado = $remision->id;

            // REGISTRAR EL MOVIMIENTO

            $movimiento             = new stockMovements();
            $movimiento->movimiento = "REMISSIONISSUED";
            $autor                  = Auth::user()->id;
            $movimiento->autor      = $autor;
            $movimiento->productos  = $productos;
            $movimiento->documento  = "REMISS" . $idCreado;
            $movimiento->importe    = $request->importe;
            $now                    = new DateTime();
            $fdate                  = $now->format('Y-m-d H:i:s');
            $fechaMysql             = $fdate;
            $movimiento->fecha      = $fechaMysql;
            $productos              = json_decode($request->productos);
            $movimiento->productos  = json_encode($productos); // Convertir el array de productos a JSON
            $movimiento->importe    = $request->total;
            $movimiento->save();

            // Devolver una respuesta de éxito con el ID
            return response()->json(['message' => 'Remisión creada correctamente', 'id' => $idCreado], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al realizar remisión' . $th->getMessage()], 500);
        }
    }

    public function verproductosremision(Request $request)
    {
        $idremision = $request->id;
        $remision   = referrals::find($idremision);
        $productos  = json_decode($remision->productos);

        return response()->json(['productos' => $productos], 200);
    }

    public function buscarremision(Request $request)
    {

        $remision = $request->numero_remision;

        try {
            $data     = [];
            $referral = referrals::select([
                'r.id',
                'r.fecha',
                'r.nota',
                'r.forma_pago',
                'w.nombre as almacen',
                'u.name as vendedor',
                'r.cliente',
                'r.productos',
                'r.total',
                'r.estatus',
                'p.nombre as tipo_de_precio',
                'r.total',
            ])
                ->from('referrals as r')
                ->leftJoin('users as u', 'r.vendedor', '=', 'u.id')
                ->leftJoin('warehouse as w', 'r.almacen', '=', 'w.id')
                ->leftJoin('prices as p', 'r.tipo_de_precio', '=', 'p.id')
                ->where('r.id', $remision)
                ->first();
            $datos              = json_decode($referral, true);
            $datos['productos'] = json_decode($datos['productos'], true);

            $accounts_receivable = accounts_receivable::select(['*'])
                ->from('accounts_receivable as ar')
                ->where('ar.remision', $remision)
                ->first();

            $datos["cxc"] = json_decode($accounts_receivable, true);

            $respuesta = ['data' => $datos];

            return response()->json([
                'success' => true,
                'message' => 'Remisión encontrada',
                'data'    => $respuesta,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al buscar remisión: ' . $e->getMessage(),
                'data'    => null,
            ], 500);
        }

    }

    public function cortedecaja()
    {
        $type       = $this->gettype();
        $timezone   = 'America/Mexico_City';
        $hoy_inicio = Carbon::today($timezone)->startOfDay()->toDateTimeString();
        $hoy_fin    = Carbon::today($timezone)->endOfDay()->toDateTimeString();
        $id         = Auth::user()->id;

        $remisiones = collect(DB::select('CALL obtenerremisiones(?, ?, ?)', [$hoy_inicio, $hoy_fin, $id]));

        // Define las formas de pago que siempre quieres mostrar
        $formas_pago_base = ['efectivo', 'transferencia', 'terminal', 'clip', 'mercado_pago', 'vales'];

        // Agrupar remisiones por forma de pago
        $remisiones_por_pago = $remisiones->groupBy('forma_pago');

        // Añadir formas de pago sin datos (si no existen en los resultados)
        foreach ($formas_pago_base as $forma_pago) {
            if (! $remisiones_por_pago->has($forma_pago)) {
                $remisiones_por_pago[$forma_pago] = collect(); // Agregar un grupo vacío
            }
        }

        // Calcular totales por forma de pago
        $totales_por_pago = $remisiones_por_pago->map(function ($items) {
            return $items->sum('total');
        });

        // Calcular el total general
        $total_general = $totales_por_pago->sum();

        return view('ventas.cortedecaja', [
            'type'                => $type,
            'remisiones_por_pago' => $remisiones_por_pago,
            'totales_por_pago'    => $totales_por_pago,
            'total_general'       => $total_general,
        ]);
    }
    public function enviarinfocortecaja(Request $request)
    {
        return $request;
    }
    public function cancelarremision(Request $request)
    {
        try {
            $idremision        = $request->id;
            $remision          = referrals::find($idremision);
            $remision->estatus = "cancelada";
            $almacen           = $remision->almacen;
            $productos         = $remision->productos;

            $productos = json_decode($productos);
            foreach ($productos as $producto) {

                $idproducto = $producto->Codigo;

                $existenciasActual = productwarehouse::select('existencias')
                    ->where('idproducto', intVal($idproducto))
                    ->where('idwarehouse', intVal($almacen))
                    ->first();

                $CantidadSumar   = $producto->Cantidad;
                $nuevaexistencia = $existenciasActual->existencias + intVal($CantidadSumar);

                productwarehouse::where('idproducto', intVal($idproducto))
                    ->where('idwarehouse', intVal($almacen))
                    ->update([
                        'existencias' => $nuevaexistencia,
                    ]);
            }

            $idremision        = $request->id;
            $remision          = referrals::find($idremision);
            $importe           = $remision->total;
            $productos         = $remision->productos;
            $remision->estatus = "cancelada";
            $remision->save();

            // REGISTRAR EL MOVIMIENTO

            $movimiento             = new stockMovements();
            $movimiento->movimiento = "REMISSIONCANCELED";
            $autor                  = Auth::user()->id;
            $movimiento->autor      = $autor;
            $movimiento->productos  = $productos;
            $movimiento->documento  = "REMISSCANC" . $idremision;
            $movimiento->importe    = $importe;
            $now                    = new DateTime();
            $fdate                  = $now->format('Y-m-d H:i:s');
            $fechaMysql             = $fdate;
            $movimiento->fecha      = $fechaMysql;
            $productos              = json_decode($request->productos);
            $movimiento->productos  = json_encode($productos); // Convertir el array de productos a JSON

            $movimiento->save();

            return response()->json(['message' => 'Remisión cancelada correctamente'], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Error al cenlar la remision' . $th->getMessage()], 200);
        }

    }

    public function reporteremisiones(Request $request)
    {
        try {
            $dateStart = Carbon::parse($request->dateStart)->startOfDay();
            $dateEnd   = Carbon::parse($request->dateEnd)->endOfDay();

            // Obtener remisiones en el rango de fechas

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
