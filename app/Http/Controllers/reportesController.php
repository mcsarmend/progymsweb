<?php
namespace App\Http\Controllers;

use App\Models\brand;
use App\Models\category;
use App\Models\clients;
use App\Models\product;
use App\Models\stockMovements;
use App\Models\supplier;
use App\Models\warehouse;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class reportesController extends Controller
{

    public function reportemovimientoscompras()
    {
        $type = $this->gettype();
        return view('reportes.movimientos.compras', ['type' => $type]);
    }
    public function reportemovimientosentradas()
    {
        $type = $this->gettype();
        return view('reportes.movimientos.entradas', ['type' => $type]);
    }
    public function reportemovimientossalidas()
    {
        $type = $this->gettype();
        return view('reportes.movimientos.salidas', ['type' => $type]);
    }
    public function reportemovimientostraspasos()
    {
        $type = $this->gettype();
        return view('reportes.movimientos.traspasos', ['type' => $type]);
    }
    public function reportemovimientosmermas()
    {
        $type = $this->gettype();
        return view('reportes.movimientos.mermas', ['type' => $type]);
    }
    public function reporteremisiones()
    {
        $type       = $this->gettype();
        $sucursales = warehouse::all();
        return view('reportes.remisiones.remisiones', ['type' => $type, 'sucursales' => $sucursales]);
    }
    public function reportecortecaja()
    {
        $type = $this->gettype();
        return view('reportes.remisiones.cortecaja', ['type' => $type]);
    }
    public function reporteinventariolistaprecios()
    {
        $type = $this->gettype();

        $products = DB::select('CALL lista_precios_activos()');

        return view('reportes.inventario.listaprecios', ['type' => $type, 'products' => $products]);
    }
    public function reporteinventarioexistenciascostos()
    {
        $type      = $this->gettype();
        $almacenes = warehouse::all();
        $products  = DB::select('CALL sp_reporteexistencias(0)');

        $total_costos = array_reduce($products, function ($carry, $item) {
            return $carry + ($item->costo * intval($item->totales));
        }, 0);

        return view('reportes.inventario.existencias', ['type' => $type, 'products' => $products, 'almacenes' => $almacenes, 'total_costos' => $total_costos]);
    }
    public function productomovimiento()
    {
        $type      = $this->gettype();
        $productos = product::all();
        return view('reportes.inventario.productomovimiento', ['type' => $type, 'productos' => $productos]);
    }
    public function resumenventas()
    {
        $type      = $this->gettype();
        $almacenes = warehouse::all();
        $products  = DB::select('CALL sp_reporteexistencias(0)');
        return view('reportes.remisiones.resumenventas', ['type' => $type, 'products' => $products, 'almacenes' => $almacenes]);
    }
    public function ventascliente()
    {
        $type     = $this->gettype();
        $clientes = clients::select('clients.id', 'clients.nombre', 'clients.telefono', 'prices.nombre as precio')
            ->leftJoin('prices', 'clients.precio', '=', 'prices.id')
            ->get();

        return view('reportes.remisiones.ventascliente', ['type' => $type, 'clientes' => $clientes]);
    }
    public function ventasproducto()
    {
        $type       = $this->gettype();
        $categorias = category::all();
        $marcas     = brand::all();

        return view('reportes.remisiones.ventasproducto', ['type' => $type, 'categorias' => $categorias, 'marcas' => $marcas]);
    }

    public function reporteclienteslista()
    {
        $type    = $this->gettype();
        $type    = $this->gettype();
        $clients = clients::select('clients.id', 'clients.nombre', 'clients.telefono', 'warehouse.nombre as sucursal', 'prices.nombre as precio')
            ->leftJoin('warehouse', 'clients.sucursal', '=', 'warehouse.id')
            ->leftJoin('prices', 'clients.precio', '=', 'prices.id')
            ->get();
        return view('reportes.clientes.lista', ['type' => $type, 'clients' => $clients]);
    }

    public function reporteclientescompras()
    {
        $type = $this->gettype();
        return view('reportes.clientes.compras', ['type' => $type]);
    }
    public function reporteproveedoreslista()
    {
        $proveedores = supplier::all();
        $type        = $this->gettype();
        return view('proveedores.proveedores', ['type' => $type, 'suppliers' => $proveedores]);
    }

    public function generarreporteventascliente(Request $request)
    {
        try {
            $idcliente   = $request->idcliente ?? 0;
            $fechainicio = $request->fechainicio ?? null;
            $fechafin    = $request->fechafin ?? null;

            $query = DB::table('referrals as r')
                ->select(
                    'r.fecha',
                    'r.forma_pago',
                    'r.total',
                    'p.nombre as tipo_de_precio',
                    'r.reparto',
                    'c.nombre',
                    'r.id'
                )
                ->leftJoin('clients as c', 'r.cliente', '=', 'c.id')
                ->leftJoin('prices as p', 'r.tipo_de_precio', '=', 'p.id')
                ->where('c.id', $idcliente);

            if ($fechainicio) {
                $query->where('r.fecha', '>=', $fechainicio);
            }
            if ($fechafin) {
                $query->where('r.fecha', '<=', $fechafin);
            }

            $remisiones = $query->get();

            // ===================================================
            // ================ ESTADÍSTICAS ======================
            // ===================================================

            // TOTAL VENDIDO
            $total_vendido = $remisiones->sum('total');

            // CANTIDAD DE REMISIONES
            $cantidad_remisiones = $remisiones->count();

            // VENTAS POR DÍA
            $cantidadesPorDia = $remisiones->groupBy('fecha')->map(function ($grupo) {
                return [
                    'cantidad' => $grupo->count(),
                    'total'    => $grupo->sum('total'),
                ];
            });

            return response()->json([
                'message'             => 'Reporte Generado Correctamente',
                'remisiones'          => $remisiones,
                'total_vendido'       => $total_vendido,
                'cantidad_remisiones' => $cantidad_remisiones,
                'cantidadesPorDia'    => $cantidadesPorDia,
            ], 200);

        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al generar el reporte: ' . $th->getMessage()], 500);
        }
    }

    public function generarreporteventasproducto(Request $request)
    {
        try {

            $fechainicio = $request->fechainicio ?? null;
            $fechafin    = $request->fechafin ?? null;
            $marca       = $request->marcas ? strtok($request->marcas, ' ') : null;
            $categoria   = $request->categorias ? strtok($request->categorias, ' ') : null;

            // ===================== CONSULTA BASE =====================
            $query = DB::table('referrals as r')
                ->select(
                    'r.fecha',
                    'r.forma_pago',
                    'r.total',
                    'p.nombre as tipo_de_precio',
                    'r.reparto',
                    'r.id',
                    'w.nombre as almacen_nombre', // ← CAMBIO
                    'r.productos'
                )
                ->leftJoin('prices as p', 'r.tipo_de_precio', '=', 'p.id')
                ->leftJoin('warehouse as w', 'r.almacen', '=', 'w.id');

            if ($fechainicio) {
                $query->where('r.fecha', '>=', $fechainicio);
            }
            if ($fechafin) {
                $query->where('r.fecha', '<=', $fechafin);
            }

            $remisiones = $query->get();

            // ==========================================================
            //           ARMAR PRODUCTOS GLOBALES
            // ==========================================================

            $productosGlobal = [];

            foreach ($remisiones as $r) {

                $items = json_decode($r->productos, true);

                if (! $items) {
                    continue;
                }

                foreach ($items as $prod) {

                    $codigo   = $prod["Codigo"];
                    $cantidad = (int) $prod["Cantidad"];
                    $nombre   = $prod["Nombre"];
                    $almacen  = $r->almacen_nombre; // ← CAMBIO


                    // Crear si no existe
                    if (! isset($productosGlobal[$codigo])) {
                        $productosGlobal[$codigo] = [
                            "codigo"         => $codigo,
                            "nombre"         => $nombre,
                            "cantidad_total" => 0,
                            "almacenes"      => [], // almacén => cantidad
                        ];
                    }

                    // Total global
                    $productosGlobal[$codigo]["cantidad_total"] += $cantidad;

                    // Cantidad por almacén
                    if ($almacen) {
                        $productosGlobal[$codigo]["almacenes"][$almacen] =
                            ($productosGlobal[$codigo]["almacenes"][$almacen] ?? 0) + $cantidad;
                    }


                }
            }


            // Agregar marca y categoría a cada producto
            foreach ($productosGlobal as $codigo => &$p) {
                $producto = product::where('id', $codigo)->first();
                if ($producto) {
                    $p['marca']     = $producto->marca;
                    $p['categoria'] = $producto->categoria;
                } else {
                    $p['marca']     = 'Desconocida';
                    $p['categoria'] = 'Desconocida';
                }
            }
            unset($p); // Romper referencia


            //Aplicar filtros de marca y categoría
            if ($marca) {
                $productosGlobal = array_filter($productosGlobal, function ($p) use ($marca) {
                    return $p['marca'] == $marca;
                });
            }

            if ($categoria) {
                $productosGlobal = array_filter($productosGlobal, function ($p) use ($categoria) {
                    return $p['categoria'] == $categoria;
                });
            }


            // ==========================================================
            //      TOP 10 PRODUCTOS MÁS VENDIDOS
            // ==========================================================

            usort($productosGlobal, fn($a, $b) =>
                $b["cantidad_total"] <=> $a["cantidad_total"]
            );

            $top10 = array_slice($productosGlobal, 0, 10);

            // ==========================================================
            //    LISTA DE ALMACENES ÚNICOS PARA LA GRÁFICA
            // ==========================================================

            $almacenes_unicos = [];

            foreach ($top10 as $p) {
                foreach ($p["almacenes"] as $alm => $cant) {
                    $almacenes_unicos[$alm] = true;
                }
            }

            $almacenes_unicos = array_keys($almacenes_unicos);

            // ==========================================================
            //   SERIES PARA HIGHCHARTS (UN PRODUCTO = UNA LÍNEA)
            // ==========================================================

            $series = [];

            foreach ($top10 as $p) {

                $serie = [
                    "name" => $p["nombre"],
                    "data" => [],
                ];

                // ordenar cifras según orden de almacenes
                foreach ($almacenes_unicos as $alm) {
                    $serie["data"][] = $p["almacenes"][$alm] ?? 0;
                }

                $series[] = $serie;
            }

            // ==========================================================
            //     DATOS FINALES PARA EL BLADE
            // ==========================================================

            return response()->json([
                'message'   => 'Reporte Generado Correctamente',
                'top10'     => $top10,
                'almacenes' => $almacenes_unicos,
                'series'    => $series,
                'productos' => $productosGlobal,
            ], 200);

        } catch (\Throwable $th) {

            return response()->json([
                'message' => 'Error al generar el reporte: ' . $th->getMessage(),
            ], 500);
        }
    }

    public function reportesoloexistencias(Request $request)
    {

        try {
            $sucursal = $request->sucursal ?? 0; // Default to 0 if not provided

            $query = 'CALL sp_reporteexistencias(' . $sucursal . ')';

            $products = DB::select($query);

            return response()->json(['message' => 'Reporte Generado Correctamente', 'products' => $products], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al generar el reporte' . $th->getMessage()], 500);
        }
    }

    public function reporteresumenventas(Request $request)
    {
        try {

            $dateStart = Carbon::parse($request->fechainicio)->startOfDay();
            $dateEnd   = Carbon::parse($request->fechafin)->endOfDay();
            $sucursal  = $request->sucursal;

            $query = DB::table('referrals as r')
                ->select(
                    'r.fecha',
                    'r.forma_pago',
                    'u.name as vendedor',
                    'ur.name as vendedor_reparto',
                    'r.total as total',
                    'p.nombre as tipo_de_precio',
                    'r.reparto'
                )
                ->leftJoin('users as u', 'r.vendedor', '=', 'u.id')
                ->leftJoin('users as ur', 'r.vendedor_reparto', '=', 'ur.id')
                ->leftJoin('warehouse as w', 'w.id', '=', 'r.almacen')
                ->leftJoin('prices as p', 'p.id', '=', 'r.tipo_de_precio')
                ->where('r.estatus', 'emitida')
                ->whereBetween('r.fecha', [$dateStart, $dateEnd]);

            if ($sucursal != 0) {
                $query->where('r.almacen', $sucursal);
            }

            /* 1. Total Vendido */
            $total_vendido = $query->sum('r.total');

            /* Cantidad de remisiones */
            $cantidad_remisiones = $query->count();

            /* 2. Métodos de pago */
            $metodosBrutos = (clone $query)
                ->select(
                    'r.forma_pago',
                    DB::raw('COUNT(*) as cantidad'),
                    DB::raw('SUM(r.total) as total')
                )
                ->groupBy('r.forma_pago')
                ->get()
                ->keyBy('forma_pago')
                ->toArray();

            /* 3. Métodos de pago */
            $cantidadesPorDia = (clone $query)
                ->select(
                    DB::raw("DATE(r.fecha) as fecha"),
                    DB::raw("COUNT(*) as cantidad"),
                    DB::raw("SUM(r.total) as total")
                )
                ->groupBy(DB::raw("DATE(r.fecha)"))
                ->orderBy(DB::raw("DATE(r.fecha)"))
                ->get()
                ->keyBy('fecha')
                ->toArray();

            $metodos = [
                'efectivo'      => $metodosBrutos['efectivo'] ?? 0,
                'terminal'      => $metodosBrutos['terminal'] ?? 0,
                'mercado_pago'  => $metodosBrutos['mercado_pago'] ?? 0,
                'clip'          => $metodosBrutos['clip'] ?? 0,
                'vales'         => $metodosBrutos['vales'] ?? 0,
                'transferencia' => $metodosBrutos['transferencia'] ?? 0,
            ];

            /* 4. Tipos de precio */
            $tipos_precio = (clone $query)
                ->select(
                    'p.nombre as tipo_de_precio',
                    DB::raw('COUNT(*) as cantidad'),
                    DB::raw('SUM(r.total) as total')
                )
                ->groupBy('p.nombre')
                ->get()
                ->keyBy('tipo_de_precio') // ← ESTE es el correcto
                ->toArray();

            /* 5. REPARTO Y MOSTRADOR*/
            $tipos_remision = (clone $query)
                ->select(
                    DB::raw("CASE WHEN r.reparto = 1 THEN 'REPARTO' ELSE 'MOSTRADOR' END AS tipo_remision"),
                    DB::raw('COUNT(*) as cantidad'),
                    DB::raw('SUM(r.total) as total')
                )
                ->groupBy('tipo_remision')
                ->get()
                ->keyBy('tipo_remision')
                ->toArray();

            return response()->json([
                'message'             => 'Reporte generado correctamente.',
                'total_vendido'       => $total_vendido,
                'metodos'             => $metodos,
                'cantidadesPorDia'    => $cantidadesPorDia,
                'tipos_precio'        => $tipos_precio,
                'tipos_remision'      => $tipos_remision,
                'metodosBrutos'       => $metodosBrutos,
                'cantidad_remisiones' => $cantidad_remisiones,
                'query'               => $query->get(),
            ], 200);

        } catch (\Throwable $th) {
            return response()->json([
                'message' => 'Error: ' . $th->getMessage(),
            ], 500);
        }
    }

    public function generarreporteremisiones(Request $request)
    {
        try {

            $timezone   = 'America/Mexico_City';
            $hoy_inicio = $request->dateStart . " 00:00:00"; // '2024-12-10 00:00:00'
            $hoy_fin    = $request->dateEnd . " 23:59:59";   // '2024-12-10 23:59:59'
            $id         = Auth::user()->id;
            $almacen    = $request->id_sucursal ?? 0;
            if ($almacen != 0) {
                $query = "
                            SELECT
                                r.id,
                                r.fecha,
                                IFNULL(r.nota, 'SIN NOTA') AS nota,
                                r.forma_pago,
                                c.nombre as cliente,
                                r.productos,
                                r.total,
                                w.nombre AS almacen,
                                u.name AS vendedor,
                                r.estatus,
                                p.nombre AS precio,
                                CASE
                                    WHEN r.reparto = 1 THEN 'Sí'
                                    WHEN r.reparto = 0 THEN 'No'
                                    ELSE 'No definido'
                                END AS reparto,
                                COALESCE(us.name, 'No asignado') AS vendedor_reparto
                            FROM referrals r
                            LEFT JOIN warehouse w ON r.almacen = w.id
                            LEFT JOIN users u ON r.vendedor = u.id
                            LEFT JOIN prices p ON p.id = r.tipo_de_precio
                            LEFT JOIN users us ON us.id = r.vendedor_reparto
                            LEFT JOIN clients c ON c.id = r.cliente
                            WHERE r.fecha BETWEEN '" . $hoy_inicio . "' AND '" . $hoy_fin . "'
                            AND w.id = " . $almacen . "
                        ";
            } else {
                $query = 'CALL obtenerremisiones("' . $hoy_inicio . '","' . $hoy_fin . '",NULL)';
            }

            $remisiones = DB::select($query);

            return response()->json(['message' => 'Reporte Generado Correctamente', 'remisiones' => $remisiones], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al generar el reporte' . $th->getMessage()], 500);
        }
    }
    public function generarreportecortecaja(Request $request)
    {
        try {
            $timezone = 'America/Mexico_City';

            $hoy_inicio = $request->dateStart . " 00:00:00";
            $hoy_fin    = $request->dateEnd . " 23:59:59";

            $query = 'CALL reportecortecaja("' . $hoy_inicio . '","' . $hoy_fin . '")';

            $cortecaja = DB::select($query);

            return response()->json(['message' => 'Reporte Generado Correctamente', 'cortecaja' => $cortecaja], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al generar el reporte' . $th->getMessage()], 500);
        }
    }
    public function generarreportecompras(Request $request)
    {
        try {
            $dateStart = Carbon::parse($request->dateStart)->startOfDay();
            $dateEnd   = Carbon::parse($request->dateEnd)->endOfDay();

            $compras = stockMovements::whereBetween('fecha', [$dateStart, $dateEnd])
                ->leftJoin('users as u', 'stock_movements.autor', '=', 'u.id')
                ->select(
                    'stock_movements.id as id',
                    'stock_movements.fecha as fecha',
                    'stock_movements.movimiento as movimiento',
                    'stock_movements.documento as documento',
                    'stock_movements.productos as productos',
                    'u.name as autor'
                )
                ->where('movimiento', 'PURCHASE')
                ->get();

            return response()->json(['message' => 'Reporte Generado Correctamente', 'compras' => $compras], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al generar el reporte' . $th->getMessage()], 500);
        }
    }

    public function buscarproductomovimiento(Request $request)
    {
        try {
            $producto  = $request->producto;
            $dateStart = Carbon::parse($request->fechainicio)->startOfDay();
            $dateEnd   = Carbon::parse($request->fechafin)->endOfDay();

            $movimientos = stockMovements::where('stock_movements.productos', 'like', '%' . $producto . '%')
                ->leftJoin('users as u', 'stock_movements.autor', '=', 'u.id')
                ->select(
                    'stock_movements.id as id',
                    'stock_movements.fecha as fecha',
                    DB::raw("CASE
                                        WHEN stock_movements.movimiento = 'PURCHASE' THEN 'COMPRA'
                                        WHEN stock_movements.movimiento = 'TRANSFER' THEN 'TRASPASO'
                                        WHEN stock_movements.movimiento = 'ENTRANCEMERCH' THEN 'ENTRADA'
                                        WHEN stock_movements.movimiento = 'REMISSIONISSUED' THEN 'REMISION'
                                        WHEN stock_movements.movimiento = 'EXITMERCH' THEN 'SALIDA'
                                        ELSE stock_movements.movimiento
                                    END as movimiento"),
                    'stock_movements.documento as documento',
                    'stock_movements.productos as productos',
                    'u.name as autor'
                )
                ->whereBetween('fecha', [$dateStart, $dateEnd])
                ->get();

            return response()->json(['message' => 'Reporte Generado Correctamente', 'movimientos' => $movimientos], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al generar el reporte' . $th->getMessage()], 500);
        }
    }

    public function generarreportetraspasos(Request $request)
    {
        try {
            $dateStart = Carbon::parse($request->dateStart)->startOfDay();
            $dateEnd   = Carbon::parse($request->dateEnd)->endOfDay();

            $traspasos = StockMovements::whereBetween('fecha', [$dateStart, $dateEnd])
                ->leftJoin('users as u', 'stock_movements.autor', '=', 'u.id')
                ->select(
                    'stock_movements.id as id',
                    'stock_movements.fecha as fecha',
                    'stock_movements.movimiento as movimiento',
                    'stock_movements.documento as documento',
                    'stock_movements.productos as productos',
                    'u.name as autor'
                )
                ->where('movimiento', 'TRANSFER')
                ->get();

            return response()->json(['message' => 'Reporte Generado Correctamente', 'traspasos' => $traspasos], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al generar el reporte' . $th->getMessage()], 500);
        }
    }
    public function generarreportemermas(Request $request)
    {
        try {
            $dateStart = Carbon::parse($request->dateStart)->startOfDay();
            $dateEnd   = Carbon::parse($request->dateEnd)->endOfDay();

            $mermas = stockMovements::whereBetween('fecha', [$dateStart, $dateEnd])
                ->leftJoin('users as u', 'stock_movements.autor', '=', 'u.id')
                ->select('stock_movements.id as id', 'stock_movements.fecha as fecha', 'stock_movements.movimiento as movimiento', 'stock_movements.documento as documento', 'stock_movements.productos as productos', 'u.name as autor')
                ->where('movimiento', 'DECREASE')
                ->get();

            return response()->json(['message' => 'Reporte Generado Correctamente', 'mermas' => $mermas], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al generar el reporte' . $th->getMessage()], 500);
        }
    }
    public function generarreporteentradas(Request $request)
    {
        try {
            $dateStart = Carbon::parse($request->dateStart)->startOfDay();
            $dateEnd   = Carbon::parse($request->dateEnd)->endOfDay();

            $entradas = stockMovements::whereBetween('fecha', [$dateStart, $dateEnd])
                ->leftJoin('users as u', 'stock_movements.autor', '=', 'u.id')
                ->select(
                    'stock_movements.id as id',
                    'stock_movements.fecha as fecha',
                    'stock_movements.movimiento as movimiento',
                    'stock_movements.documento as documento',
                    'stock_movements.productos as productos',
                    'u.name as autor'
                )
                ->where('movimiento', 'ENTRANCEMERCH')
                ->get();

            return response()->json(['message' => 'Reporte Generado Correctamente', 'entradas' => $entradas], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al generar el reporte' . $th->getMessage()], 500);
        }
    }
    public function generarreportesalidas(Request $request)
    {
        try {
            $dateStart = Carbon::parse($request->dateStart)->startOfDay();
            $dateEnd   = Carbon::parse($request->dateEnd)->endOfDay();

            $salidas = stockMovements::whereBetween('fecha', [$dateStart, $dateEnd])
                ->leftJoin('users as u', 'stock_movements.autor', '=', 'u.id')
                ->select('stock_movements.id as id', 'stock_movements.fecha as fecha', 'stock_movements.movimiento as movimiento', 'stock_movements.documento as documento', 'stock_movements.productos as productos', 'u.name as autor')
                ->where('movimiento', 'EXITMERCH')
                ->get();

            return response()->json(['message' => 'Reporte Generado Correctamente', 'salidas' => $salidas], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al generar el reporte' . $th->getMessage()], 500);
        }
    }

    public function verproductosmovimiento(Request $request)
    {
        try {

            $id         = $request->id;
            $movimiento = stockMovements::find($id);

            $productos = json_decode($movimiento->productos);

            return response()->json(['productos' => $productos, 'movimiento' => $movimiento], 200);
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
