<?php
namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\address;
use App\Models\clients;
use App\Models\orders;
use App\Models\product;
use App\Models\productwarehouse;
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
        $idsucursal     = 8;
        $vendedor       = Auth::user()->name;
        $idvendedor     = Auth::user()->id;
        $nombresucursal = warehouse::select('nombre')
            ->where('id', '=', $idsucursal)
            ->first();

        $clientes   = clients::all();
        $type       = $this->gettype();
        $vendedores = DB::table('users')
            ->select('id', 'name')
            ->where('status', 1)
            ->get();
        $productos = Product::leftJoin('product_warehouse', 'product.id', '=', 'product_warehouse.idproducto')
            ->leftJoin('brand', 'product.marca', '=', 'brand.id')
            ->where('product_warehouse.idwarehouse', $idsucursal)
            ->select('product.*', 'brand.nombre as nombre_marca')
            ->get();

        return view('ventas.pedidos.nuevo', ['type' => $type, 'idsucursal' => $idsucursal, 'nombresucursal' => $nombresucursal, 'idvendedor' => $idvendedor, 'vendedor' => $vendedor, 'clientes' => $clientes, 'productos' => $productos, 'vendedores' => $vendedores]);

    }
    public function pedidosestatus()
    {
        $type    = $this->gettype();
        $pedidos = orders::leftJoin('users', 'orders.vendedor', '=', 'users.id')
            ->leftJoin('clients', 'orders.cliente', '=', 'clients.id')
            ->select(
                'orders.*',
                'users.name as vendedor_nombre',
                'clients.nombre as cliente_nombre'
            )
            ->get();

        return view('ventas.pedidos.estatus', ['type' => $type, 'pedidos' => $pedidos]);

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
        $ubicacion = address::find($request->id);
        $cliente   = clients::find($request->id);

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

            foreach ($productos as $producto) {
                $idproducto = $producto->Codigo;
                $cantidad   = $producto->Cantidad;
                // ACUTALIZAR ALMACEN ORIGEN
                $existencias_origen = productwarehouse::select('existencias')
                    ->where('idproducto', 'like', '%' . $idproducto . '%')
                    ->where('idwarehouse', 'like', '%' . $almacen_origen . '%')
                    ->get();

                if ($existencias_origen != '[]') {
                    $ExisOr                = $existencias_origen[0]["existencias"];
                    $nuevaExistenciaOrigen = $ExisOr - intval($cantidad);
                    ProductWarehouse::where('idproducto', 'like', '%' . $idproducto . '%')
                        ->where('idwarehouse', 'like', '%' . $almacen_origen . '%')
                        ->update(['existencias' => $nuevaExistenciaOrigen]);

                    // ACTUALIZAR ALMACEN DESTINO
                    $existencias_destino = productwarehouse::select('existencias')
                        ->where('idproducto', 'like', '%' . $idproducto . '%')
                        ->where('idwarehouse', 'like', '%' . $almacen_destino . '%')
                        ->get();

                    if ($existencias_destino != '[]') {
                        $ExisDest               = $existencias_destino[0]["existencias"];
                        $nuevaExistenciaDestino = $ExisDest + intval($cantidad);
                        ProductWarehouse::where('idproducto', 'like', '%' . $idproducto . '%')
                            ->where('idwarehouse', 'like', '%' . $almacen_destino . '%')
                            ->update(['existencias' => $nuevaExistenciaDestino]);
                    } else {
                        $nueva_existencia_destino              = new ProductWarehouse();
                        $nueva_existencia_destino->idproducto  = $idproducto;
                        $nueva_existencia_destino->idwarehouse = $almacen_destino;
                        $nueva_existencia_destino->existencias = $cantidad;
                        $nueva_existencia_destino->save();
                        $productosNuevoPedido++;
                    }
                } else {
                    return response()->json(['message' => "No cuentas con unidades en el almacen origen"], 500);
                    $prodcutosNoTraspaso++;
                }

            }

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

    public function gettype()
    {
        if (Auth::check()) {
            $type = Auth::user()->role;
        }
        return $type;
    }
}
