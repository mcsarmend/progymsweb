<?php
namespace App\Http\Controllers;

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
        return view('reportes.inventario.existencias', ['type' => $type, 'products' => $products, 'almacenes' => $almacenes]);
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
    public function

    generarreportecortecaja(Request $request) {
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
