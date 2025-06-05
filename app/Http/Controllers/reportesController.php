<?php
namespace App\Http\Controllers;

use App\Models\clients;
use App\Models\stockMovements;
use App\Models\supplier;
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
        $type = $this->gettype();
        return view('reportes.remisiones.remisiones', ['type' => $type]);
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
        $type = $this->gettype();

        $products = DB::select('CALL lista_existencias_activas()');
        return view('reportes.inventario.existencias', ['type' => $type, 'products' => $products]);
    }
public function reporteimagendealmacen(){
         $type = $this->gettype();
        return view('reportes.inventario.imagendeinventario', ['type' => $type]);
}
    public function reporteclienteslista()
    {
        $type = $this->gettype();
        $type = $this->gettype();
        $clients = clients::select('clients.nombre', 'clients.telefono', 'warehouse.nombre as sucursal', 'prices.nombre as precio')
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
        $type = $this->gettype();
        return view('proveedores.proveedores', ['type' => $type, 'suppliers' => $proveedores]);
    }

    public function generarreporteremisiones(Request $request)
    {
        try {
            $timezone = 'America/Mexico_City';
            $hoy_inicio = Carbon::today($timezone)->startOfDay()->toDateTimeString(); // '2024-12-10 00:00:00'
            $hoy_fin = Carbon::today($timezone)->endOfDay()->toDateTimeString();   // '2024-12-10 23:59:59'
            $id = Auth::user()->id;
            $query = 'CALL obtenerremisiones("' . $hoy_inicio . '","' . $hoy_fin . '",NULL)';

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
            $hoy_fin = $request->dateEnd . " 23:59:59";

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
            $dateEnd = Carbon::parse($request->dateEnd)->endOfDay();

            $compras = stockMovements::whereBetween('fecha', [$dateStart, $dateEnd])
                ->leftJoin('stock_movements.id as id','users as u', 'stock_movements.autor', '=', 'u.id')
                ->select('stock_movements.fecha as fecha', 'stock_movements.movimiento as movimiento', 'stock_movements.documento as documento', 'stock_movements.productos as productos', 'u.name as autor')
                ->where('movimiento', 'PURCHASE')
                ->get();

            return response()->json(['message' => 'Reporte Generado Correctamente', 'compras' => $compras], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al generar el reporte' . $th->getMessage()], 500);
        }
    }
    public function generarreportetraspasos(Request $request)
    {
        try {
            $dateStart = Carbon::parse($request->dateStart)->startOfDay();
            $dateEnd = Carbon::parse($request->dateEnd)->endOfDay();

            $traspasos = stockMovements::whereBetween('fecha', [$dateStart, $dateEnd])
                ->leftJoin('stock_movements.id as id','users as u', 'stock_movements.autor', '=', 'u.id')
                ->select('stock_movements.fecha as fecha', 'stock_movements.movimiento as movimiento', 'stock_movements.documento as documento', 'stock_movements.productos as productos', 'u.name as autor')
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
            $dateEnd = Carbon::parse($request->dateEnd)->endOfDay();

            $mermas = stockMovements::whereBetween('fecha', [$dateStart, $dateEnd])
                ->leftJoin('users as u', 'stock_movements.autor', '=', 'u.id')
                ->select('stock_movements.id as id','stock_movements.fecha as fecha', 'stock_movements.movimiento as movimiento', 'stock_movements.documento as documento', 'stock_movements.productos as productos', 'u.name as autor')
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
            $dateEnd = Carbon::parse($request->dateEnd)->endOfDay();

           $entradas = stockMovements::whereBetween('fecha', ['2025-06-01 00:00:00', '2025-06-02 23:59:59'])
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
            $dateEnd = Carbon::parse($request->dateEnd)->endOfDay();

            $salidas = stockMovements::whereBetween('fecha', [$dateStart, $dateEnd])
                ->leftJoin('users as u', 'stock_movements.autor', '=', 'u.id')
                ->select('stock_movements.id as id','stock_movements.fecha as fecha', 'stock_movements.movimiento as movimiento', 'stock_movements.documento as documento', 'stock_movements.productos as productos', 'u.name as autor')
                ->where('movimiento', 'EXITMERCH')
                ->get();

            return response()->json(['message' => 'Reporte Generado Correctamente', 'salidas' => $salidas], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al generar el reporte' . $th->getMessage()], 500);
        }
    }

    public function verproductosmovimiento(Request $request)
    {
        $id = $request->id;
        $movimiento = stockMovements::find($id);
        $productos = json_decode($movimiento->productos);

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
