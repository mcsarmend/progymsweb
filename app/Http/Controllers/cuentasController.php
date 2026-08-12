<?php
namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\accounts_payable;
use App\Models\accounts_payable_payments;
use App\Models\accounts_receivable;
use App\Models\account_payment;
use App\Models\creditors;
use App\Models\supplier;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class cuentasController extends Controller
{
    public function crearcxc()
    {
        $type = $this->gettype();
        return view('cuentas.crearcxc', ['type' => $type]);
    }
    public function crearcxcevento(Request $request)
    {
        try {
            $remisionId = $request->remision;
            $cxc        = accounts_receivable::where('remision_id', $remisionId)->first();
            if ($cxc) {
                return response()->json([
                    'success' => false,
                    'message' => 'Ya existe una cuenta por cobrar para esta remisión',
                ], 422);
            }

            $account                 = new accounts_receivable();
            $account->cliente_id     = $request->idcliente;
            $account->remision_id    = $request->remision;
            $account->vendedor_id    = Auth::user()->id;
            $account->fecha          = now()->format('Y-m-d H:i:s');
            $account->monto          = $request->total;
            $account->saldo_restante = $request->total;
            $account->estado         = 'Pendiente';

            $account->save();

            return response()->json([
                'success' => true,
                'data'    => $account,
                'message' => 'Cuenta por cobrar creada exitosamente',
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al crear la cuenta por cobrar: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function abonocxc()
    {
        $type = $this->gettype();
        return view('cuentas.abonocxc', ['type' => $type]);
    }
    public function abonocxcevento(Request $request)
    {

        try {
            $remisionId = $request->remision;

            $cxc   = accounts_receivable::where('remision_id', $remisionId)->first();
            $idcxc = $cxc->id;
            if (! $idcxc) {
                return response()->json([
                    'success' => false,
                    'message' => 'No existe una cuenta por cobrar para esta remisión',
                ], 422);
            }

            $account_payment              = new account_payment();
            $account_payment->cliente_id  = $request->cliente_id;
            $account_payment->cxc_id      = $idcxc;
            $account_payment->fecha       = now()->format('Y-m-d H:i:s'); // Formato MySQL
            $account_payment->monto       = $request->monto;
            $account_payment->metodo_pago = $request->metodo_pago;

            // Actualizar la cuenta por cobrar

            $saldo_restante = intval($cxc->saldo_restante);
            $monto_abono    = intval($request->monto);

            $nuevosaldo = $saldo_restante - $monto_abono;
            if ($nuevosaldo < 0) {
                return response()->json([
                    'success' => false,
                    'message' => 'El monto excede el saldo pendiente ($' . number_format($saldo_restante, 2) . ')',
                ], 422);
            }

            $cxc->saldo_restante -= $request->monto;

            $cxc->estado = ($cxc->saldo_restante <= 0) ? 'Pagada' : 'Pendiente';

            $account_payment->save();
            $cxc->save();

            return response()->json(['message' => 'Cuenta por Cobrar actualizada correctamente'], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Error al actualizar la CxC: ' . $th->getMessage()], 500);
        }
    }
    public function reportecxc()
    {
        $type = $this->gettype();

        // Obtener cada cuenta por cobrar individualmente con sus detalles
        $cuentasPorCobrar = accounts_receivable::select(
            'accounts_receivable.*',
            'clients.nombre as cliente_nombre'
        )
            ->leftJoin('clients', 'accounts_receivable.cliente_id', '=', 'clients.id')
            ->orderBy('accounts_receivable.id', 'desc')
            ->get();

        // Resumen por cliente (opcional, para estadísticas)
        $resumenPorCliente = \App\Models\Clients::select('clients.id', 'clients.nombre')
            ->selectRaw('
            SUM(accounts_receivable.saldo_restante) as saldo_total,
            SUM(accounts_receivable.monto) as monto_total,
            COUNT(accounts_receivable.id) as total_cuentas
        ')
            ->leftJoin('accounts_receivable', 'clients.id', '=', 'accounts_receivable.cliente_id')
            ->groupBy('clients.id', 'clients.nombre')
            ->get();

        // Totales generales
        $totalesGenerales = [
            'total_cuentas'  => $cuentasPorCobrar->count(),
            'total_monto'    => $cuentasPorCobrar->sum('monto'),
            'total_saldo'    => $cuentasPorCobrar->sum('saldo_restante'),
            'total_clientes' => $resumenPorCliente->count(),
        ];

        return view('cuentas.reportecxc', [
            'type'              => $type,
            'cuentasPorCobrar'  => $cuentasPorCobrar,
            'resumenPorCliente' => $resumenPorCliente,
            'totalesGenerales'  => $totalesGenerales,
        ]);
    }
    public function obtenercxc($clienteId)
    {
        try {
            $cuentas = accounts_receivable::select([
                'remision_id',
                DB::raw("DATE_FORMAT(fecha, '%d/%m/%Y') as fecha"),
                'monto',
                'saldo_restante',
                DB::raw("CASE WHEN saldo_restante > 0 THEN 'Pendiente' ELSE 'Pagado' END as estado"),
            ])
                ->where('cliente_id', $clienteId)
                ->orderBy('fecha', 'desc')
                ->get();

            return response()->json([
                'cuentas' => $cuentas,
            ]);
        } catch (\Throwable $th) {
            //throw $th;
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener las cuentas por cobrar: ' . $th->getMessage(),
            ], 500);
        }

    }

    public function obtenerpagoscxc($cuentaId)
    {
        try {
            $pagos = DB::table('account_payments as p')
                ->leftJoin('accounts_receivable as c', 'p.cxc_id', '=', 'c.id')
                ->select([
                    'p.id',
                    'c.remision_id',
                    DB::raw("DATE_FORMAT(p.fecha, '%d/%m/%Y') as fecha"),
                    'p.monto',
                    'p.metodo_pago',
                    DB::raw("COALESCE(c.id, 'N/A') as cxc_id"),
                ])
                ->where('p.cxc_id', $cuentaId) // Cambiado de cliente_id a cxc_id
                ->orderByDesc('p.fecha')
                ->get();

            return response()->json($pagos);
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener los pagos: ' . $th->getMessage(),
            ], 500);
        }
    }

    public function crearcxp()
    {
        $type = $this->gettype();

                                                         // Obtener proveedores y acreedores
        $proveedores = supplier::get(['id', 'nombre']);  // Ajusta según tu modelo
        $acreedores  = creditors::get(['id', 'nombre']); // Ajusta según tu modelo

        return view('cuentas.crearcxp', [
            'type'        => $type,
            'proveedores' => $proveedores,
            'acreedores'  => $acreedores,
        ]);
    }
    public function crearcxpevento(Request $request)
    {
        try {
            // Validar los datos
            $request->validate([
                'tipo_persona' => 'required|in:supplier,creditor',
                'persona_id'   => 'required|string',
                'monto'        => 'required|numeric|min:0.01',
                'fecha'        => 'required|date',
                'concepto'     => 'required|string|max:500',
            ]);

            // Desencriptar el ID de la persona
            $personaId = decrypt($request->persona_id);

            // Crear la cuenta por pagar
            $account = new accounts_payable();

            // Asignar según el tipo
            if ($request->tipo_persona === 'supplier') {
                $account->proveedor_id = $personaId;
                $account->acreedor_id  = null;
            } else {
                $account->acreedor_id  = $personaId;
                $account->proveedor_id = null;
            }

            // Asignar campos comunes
            $account->fecha          = $request->fecha;
            $account->monto          = $request->monto;
            $account->saldo_restante = $request->monto;
            $account->estado         = 'Pendiente';
            $account->concepto       = $request->concepto;

            $account->save();

            return response()->json([
                'success' => true,
                'data'    => $account,
                'message' => 'Cuenta por pagar creada exitosamente',
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al crear la cuenta por pagar: ' . $e->getMessage(),
            ], 500);
        }
    }

    public function abonocxp()
    {
        $type = $this->gettype();
        return view('cuentas.abonocxp', ['type' => $type]);
    }
    public function abonocxpevento(Request $request)
    {
        try {
            // Validar los datos
            $request->validate([
                'cuenta_id'   => 'required|integer|exists:accounts_payable,id',
                'monto'       => 'required|numeric|min:0.01',
                'metodo_pago' => 'required|string',
                'fecha_pago'  => 'required|date',
            ]);

            // Buscar la cuenta por pagar
            $cxp = accounts_payable::where('id', $request->cuenta_id)->first();

            if (! $cxp) {
                return response()->json([
                    'success' => false,
                    'message' => 'No existe la cuenta por pagar',
                ], 422);
            }

            // Validar que la cuenta esté pendiente
            if ($cxp->estado === 'Pagada' || $cxp->estado === 'Cancelada') {
                return response()->json([
                    'success' => false,
                    'message' => 'Esta cuenta ya está ' . $cxp->estado,
                ], 422);
            }

            // Validar que el monto no exceda el saldo
            $saldo_restante = floatval($cxp->saldo_restante);
            $monto_abono    = floatval($request->monto);

            if ($monto_abono > $saldo_restante) {
                return response()->json([
                    'success' => false,
                    'message' => 'El monto excede el saldo pendiente ($' . number_format($saldo_restante, 2) . ')',
                ], 422);
            }

            // Crear el registro de pago
            $account_payment               = new accounts_payable_payments();
            $account_payment->cxp_id       = $cxp->id;
            $account_payment->proveedor_id = $cxp->proveedor_id;
            $account_payment->acreedor_id  = $cxp->acreedor_id;
            $account_payment->fecha        = $request->fecha_pago;
            $account_payment->monto        = $request->monto;
            $account_payment->metodo_pago  = $request->metodo_pago;

            // Actualizar el saldo de la cuenta
            $cxp->saldo_restante = $saldo_restante - $monto_abono;

            // Actualizar estado
            if ($cxp->saldo_restante <= 0) {
                $cxp->estado         = 'Pagada';
                $cxp->saldo_restante = 0;
            } else {
                $cxp->estado = 'Pendiente';
            }

            // Guardar ambos registros
            $account_payment->save();
            $cxp->save();

            return response()->json([
                'success' => true,
                'message' => 'Abono registrado correctamente',
                'data'    => [
                    'nuevo_saldo' => $cxp->saldo_restante,
                    'estado'      => $cxp->estado,
                ],
            ], 200);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error de validación',
                'errors'  => $e->errors(),
            ], 422);
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'message' => 'Error al registrar el abono: ' . $th->getMessage(),
            ], 500);
        }
    }

    public function reportecxp()
    {
        $type = $this->gettype();

        // Obtener cuentas por pagar con JOIN manual
        $cuentasPorPagar = DB::table('accounts_payable')
            ->leftJoin('supplier', 'accounts_payable.proveedor_id', '=', 'supplier.id')
            ->leftJoin('creditors', 'accounts_payable.acreedor_id', '=', 'creditors.id')
            ->select(
                'accounts_payable.*',
                'supplier.nombre as proveedor_nombre',
                'creditors.nombre as acreedor_nombre'
            )
            ->orderBy('accounts_payable.id', 'desc')
            ->get();

        // Si quieres ver qué datos están llegando (para depurar)
        // dd($cuentasPorPagar);

        // Resumen por proveedor
        $resumenProveedores = DB::table('accounts_payable')
            ->join('supplier', 'accounts_payable.proveedor_id', '=', 'supplier.id')
            ->select(
                'supplier.id',
                'supplier.nombre',
                DB::raw("'Proveedor' as tipo"),
                DB::raw('SUM(accounts_payable.monto) as monto_total'),
                DB::raw('SUM(accounts_payable.saldo_restante) as saldo_total'),
                DB::raw('COUNT(accounts_payable.id) as total_cuentas')
            )
            ->whereNotNull('accounts_payable.proveedor_id')
            ->groupBy('supplier.id', 'supplier.nombre')
            ->get();

        // Resumen por acreedor
        $resumenAcreedores = DB::table('accounts_payable')
            ->join('creditors', 'accounts_payable.acreedor_id', '=', 'creditors.id')
            ->select(
                'creditors.id',
                'creditors.nombre',
                DB::raw("'Acreedor' as tipo"),
                DB::raw('SUM(accounts_payable.monto) as monto_total'),
                DB::raw('SUM(accounts_payable.saldo_restante) as saldo_total'),
                DB::raw('COUNT(accounts_payable.id) as total_cuentas')
            )
            ->whereNotNull('accounts_payable.acreedor_id')
            ->groupBy('creditors.id', 'creditors.nombre')
            ->get();

        // Combinar y ordenar resúmenes
        $resumenPorPersona = $resumenProveedores->concat($resumenAcreedores)
            ->sortBy('nombre');

        // Totales generales
        $totalesGenerales = [
            'total_cuentas'     => $cuentasPorPagar->count(),
            'total_monto'       => $cuentasPorPagar->sum('monto'),
            'total_saldo'       => $cuentasPorPagar->sum('saldo_restante'),
            'total_pendientes'  => $cuentasPorPagar->where('estado', 'Pendiente')->count(),
            'total_pagadas'     => $cuentasPorPagar->where('estado', 'Pagada')->count(),
            'total_canceladas'  => $cuentasPorPagar->where('estado', 'Cancelada')->count(),
            'total_proveedores' => $resumenProveedores->count(),
            'total_acreedores'  => $resumenAcreedores->count(),
        ];

        return view('cuentas.reportecxp', [
            'type'              => $type,
            'cuentasPorPagar'   => $cuentasPorPagar,
            'resumenPorPersona' => $resumenPorPersona,
            'totalesGenerales'  => $totalesGenerales,
        ]);
    }

    public function obtenercxp($cxpId)
    {
        try {
            $cuenta = accounts_payable::select([
                'id',
                'fecha',
                'monto',
                'saldo_restante',
                'estado',
                'proveedor_id',
                'acreedor_id',
                DB::raw("DATE_FORMAT(fecha, '%d/%m/%Y') as fecha_formateada"),
                DB::raw("CONCAT('$', FORMAT(monto, 2)) as monto_formateado"),
                DB::raw("CONCAT('$', FORMAT(saldo_restante, 2)) as saldo_formateado"),
            ])
                ->where('id', $cxpId)
                ->first();

            if (! $cuenta) {
                return response()->json([
                    'success' => false,
                    'message' => 'No se encontró la cuenta por pagar',
                ], 404);
            }

            // Agregar información de la persona (proveedor o acreedor)
            if ($cuenta->proveedor_id) {
                $proveedor              = Supplier::find($cuenta->proveedor_id);
                $cuenta->nombre_persona = $proveedor ? $proveedor->nombre : 'Proveedor eliminado';
                $cuenta->tipo_persona   = 'Proveedor';
                $cuenta->persona_id     = $cuenta->proveedor_id;
            } else if ($cuenta->acreedor_id) {
                $acreedor               = creditors::find($cuenta->acreedor_id);
                $cuenta->nombre_persona = $acreedor ? $acreedor->nombre : 'Acreedor eliminado';
                $cuenta->tipo_persona   = 'Acreedor';
                $cuenta->persona_id     = $cuenta->acreedor_id;
            } else {
                $cuenta->nombre_persona = 'No especificado';
                $cuenta->tipo_persona   = 'Desconocido';
                $cuenta->persona_id     = null;
            }

            return response()->json([
                'success' => true,
                'data'    => $cuenta,
            ]);
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener la cuenta por pagar: ' . $th->getMessage(),
            ], 500);
        }
    }
    public function obtenerPagosCxp($cuentaId)
    {
        try {
            $pagos = DB::table('accounts_payable_payments')
                ->where('cxp_id', $cuentaId)
                ->select(
                    'id',
                    'fecha',
                    'monto',
                    'metodo_pago',
                    'proveedor_id',
                    'acreedor_id'
                )
                ->orderBy('fecha', 'desc')
                ->get();

            // Formatear datos
            $pagos->map(function ($pago) {
                $pago->fecha            = date('d/m/Y', strtotime($pago->fecha));
                $pago->monto_formateado = '$' . number_format($pago->monto, 2);

                // Formatear método de pago
                $metodos = [
                    'efectivo'      => 'Efectivo',
                    'transferencia' => 'Transferencia',
                    'terminal'      => 'Terminal',
                    'clip'          => 'Clip',
                    'mercado_pago'  => 'Mercado Pago',
                    'vales'         => 'Vales',
                    'cheque'        => 'Cheque',
                ];
                $pago->metodo_pago_nombre = $metodos[$pago->metodo_pago] ?? $pago->metodo_pago;

                return $pago;
            });

            return response()->json([
                'success' => true,
                'data'    => $pagos,
            ]);
        } catch (\Throwable $th) {
            return response()->json([
                'success' => false,
                'message' => 'Error al obtener los pagos: ' . $th->getMessage(),
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
