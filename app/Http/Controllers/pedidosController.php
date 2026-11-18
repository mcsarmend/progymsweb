<?php
namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\address;
use App\Models\clients;
use App\Models\orders;
use App\Models\product;
use App\Models\stockMovements;
use App\Models\warehouse;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class pedidosController extends Controller
{
    public function pedidosnuevo()
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
            ->where('status', 1)
            ->get();
        $productos = Product::leftjoin('brand as b', 'product.marca', '=', 'b.id')
            ->select('product.*', 'b.nombre as nombre_marca')
            ->where('product.estatus', '=', '1')
            ->get();

        return view('ventas.pedidos.nuevo', ['type' => $type, 'idsucursal' => $idsucursal, 'nombresucursal' => $nombresucursal, 'idvendedor' => $idvendedor, 'vendedor' => $vendedor, 'clientes' => $clientes, 'productos' => $productos, 'vendedores' => $vendedores, 'idssucursales' => $idssucursales]);

    }
    public function pedidosestatus()
    {
        $type    = $this->gettype();
        $pedidos = orders::leftJoin('users', 'orders.vendedor', '=', 'users.id')
            ->leftJoin('clients', 'orders.cliente', '=', 'clients.id')
            ->leftjoin('users as repartidores', 'orders.repartidor', '=', 'repartidores.id')
            ->select(
                'orders.*',
                'users.name as vendedor_nombre',
                'clients.nombre as cliente_nombre',
                'repartidores.name as repartidor_nombre'
            )
            ->get();
        $repartidores = DB::table('users')
            ->select('id', 'name')
            ->where('status', '1') // Filtrar por el rol de repartidor
            ->get();

        return view('ventas.pedidos.estatus', ['type' => $type, 'pedidos' => $pedidos, 'repartidores' => $repartidores]);

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

    public function verubicacioncliente(Request $request)
    {
        $cliente   = clients::find($request->id);
        $idcliente = $cliente->id;
        $ubicacion = address::where('idcliente', $idcliente)->first();

        return response()->json([
            'cliente'   => $cliente->nombre,
            'direccion' => $ubicacion->direccion,
            'lat'       => $ubicacion->latitud,
            'lng'       => $ubicacion->longitud,
        ]);
    }

    public function crearnuevopedido(Request $request)
    {
        date_default_timezone_set('America/Mexico_City');
        try {
            $productosNuevoPedido   = 0;
            $almacen_origen         = 8;  // almacen bodega
            $almacen_destino        = 10; // almacen pedidos
            $movimiento             = new stockMovements();
            $movimiento->movimiento = $request->movimiento;
            $movimiento->movimiento = "ORDER";
            $autor                  = Auth::user()->id;
            $movimiento->autor      = $autor;
            $productos              = $request->productos;
            $documento              = date('dmyHis') . 'ORDER';
            $movimiento->documento  = $documento;
            $movimiento->importe    = $request->total;
            $now                    = new DateTime();
            $fdate                  = $now->format('Y-m-d H:i:s');
            $fechaMysql             = $fdate;
            $movimiento->fecha      = $fechaMysql;
            $productos              = json_decode($request->productos);
            $movimiento->productos  = json_encode($productos); // Convertir el array de productos a JSON
            $movimiento->save();

            // CREAR PEDIDO
            $orden = new orders();

            $orden->fecha     = $fechaMysql;
            $orden->nota      = $request->nota ?? null;
            $orden->vendedor  = Auth::user()->id;
            $orden->cliente   = $this->extraerNumeroInicial($request->cliente);
            $orden->total     = $request->total;
            $orden->estatus   = "CREADO";
            $productos        = json_decode($request->productos, true);
            $orden->productos = json_encode($productos);

            $orden->save();

            return response()->json(['message' => "Pedido creado de manera exitosa"], 200);
        } catch (\Throwable $th) {
            return response()->json(['error' => "Error: " . $th->getMessage()], 500);
        }

    }

    public function cambiarEstadoPedido(Request $request)
    {
        $id           = $request->id;
        $nuevoEstatus = $request->nuevoEstatus;
        $repartidorId = $request->repartidor_id; // Nuevo campo

        try {
            $pedido = orders::find($id);

            if (! $pedido) {
                return response()->json(['error' => 'Pedido no encontrado'], 404);
            }

            // Actualizar el estado
            $pedido->estatus = $nuevoEstatus;

            // Si se asignó un repartidor, guardarlo
            if ($repartidorId) {
                $pedido->repartidor = $repartidorId; // Asegúrate de que el campo exista en tu tabla
            }

            $pedido->save();

            return response()->json(['success' => true]);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function extraerNumeroInicial($cadena)
    {
        if (preg_match('/^(\d+)-/', $cadena, $matches)) {
            return (int) $matches[1]; // Convertimos a entero
        }
        return null; // Si no encuentra el patrón
    }

    public function verproductospedidos(Request $request)
    {
        $idorder   = $request->id;
        $order     = orders::find($idorder);
        $productos = json_decode($order->productos);

        return response()->json(['productos' => $productos], 200);
    }

    // En tu pedidosController.php

    public function pedidosrepartidor(Request $request)
    {
        try {
            $request->validate([
                'id' => 'required|integer|exists:users,id',
            ]);

            $pedidos = DB::table('orders as o')
                ->leftJoin('clients as c', 'c.id', '=', 'o.cliente')
                ->leftJoin('address as a', 'c.id', '=', 'a.idcliente')
                ->leftJoin('users as u', 'u.id', '=', 'o.repartidor')
                ->select(
                    'o.id',
                    'o.fecha',
                    'o.nota',
                    'o.vendedor',
                    'o.cliente',
                    'o.productos',
                    'o.total',
                    'o.estatus',
                    'o.metodo_pago',
                    'o.repartidor',
                    'c.nombre as cliente_nombre',
                    'c.sucursal as cliente_sucursal',
                    'c.telefono as cliente_telefono',
                    'c.precio as cliente_precio',
                    'c.ejecutivo as cliente_ejecutivo',
                    'c.estatus as cliente_estatus',
                    'a.direccion',
                    'a.latitud',
                    'a.longitud',
                    'u.name as repartidor_nombre'
                )
                ->where('o.repartidor', $request->id)
                ->whereIn('o.estatus', [
                    'SURTIDO',
                    'REVISADO',
                    'EN RUTA',
                    'ENTREGADO',
                    'CANCELADO',
                    'FINALIZADO',
                ])
                ->orderBy('o.id', 'desc')
                ->get();

            if ($pedidos->isEmpty()) {
                return response()->json([
                    'success' => true,
                    'data'    => [],
                    'message' => 'No se encontraron pedidos para este repartidor',
                ], 200);
            }

            $pedidosFormateados = $pedidos->map(function ($pedido) {
                return [
                    'id'                => $pedido->id,
                    'fecha'             => $pedido->fecha,
                    'nota'              => $pedido->nota,
                    'vendedor'          => $pedido->vendedor,
                    'cliente'           => $pedido->cliente,
                    'total'             => $pedido->total,
                    'estatus'           => $pedido->estatus,
                    'metodo_pago'       => $pedido->metodo_pago,
                    'repartidor'        => $pedido->repartidor,
                    'repartidor_nombre' => $pedido->repartidor_nombre,
                    'cliente_nombre'    => $pedido->cliente_nombre,
                    'cliente_sucursal'  => $pedido->cliente_sucursal,
                    'cliente_telefono'  => $pedido->cliente_telefono,
                    'cliente_precio'    => $pedido->cliente_precio,
                    'cliente_ejecutivo' => $pedido->cliente_ejecutivo,
                    'cliente_estatus'   => $pedido->cliente_estatus,
                    'direccion'         => $pedido->direccion,
                    'latitud'           => $pedido->latitud,
                    'longitud'          => $pedido->longitud,
                    'productos'         => json_decode($pedido->productos, true),
                ];
            });

            return response()->json([
                'success' => true,
                'data'    => $pedidosFormateados,
                'count'   => $pedidos->count(),
                'message' => 'Pedidos obtenidos correctamente',
            ], 200);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error de validación',
                'errors'  => $e->errors(),
            ], 422);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener los pedidos: ' . $e->getMessage(),
            ], 500);
        }
    }
    public function pedidoscambiarestado(Request $request)
    {
        try {
            $request->validate([
                'id'           => 'required|integer|exists:orders,id',
                'nuevoEstatus' => 'required|string|in:CREADO,SURTIDO,REVISADO,EN RUTA,ENTREGADO,CANCELADO,FINALIZADO',
            ]);

            $pedido = orders::find($request->id);

            if (! $pedido) {
                return response()->json([
                    'success' => false,
                    'message' => 'Pedido no encontrado',
                ], 404);
            }

            // Actualizar el estado
            $pedido->estatus = $request->nuevoEstatus;
            $pedido->save();

            return response()->json([
                'success' => true,
                'data'    => [
                    'id'         => $pedido->id,
                    'estatus'    => $pedido->estatus,
                    'updated_at' => $pedido->updated_at,
                ],
                'message' => 'Estado actualizado correctamente',
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al actualizar el estado: ' . $e->getMessage(),
            ], 500);
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
