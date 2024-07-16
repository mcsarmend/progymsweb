<?php

namespace App\Http\Controllers;

use App\Models\clients;
use App\Models\referrals;
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
    public function reporteinventariolistaprecios()
    {
        $type = $this->gettype();
        return view('reportes.inventario.listaprecios', ['type' => $type]);
    }
    public function reporteinventarioexistenciascostos()
    {
        $type = $this->gettype();
        return view('reportes.inventario.existencias', ['type' => $type]);
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
        return view('reportes.proveedores.lista', ['type' => $type, 'suppliers' => $proveedores]);
    }

    public function generarreporteremisiones(Request $request)
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
