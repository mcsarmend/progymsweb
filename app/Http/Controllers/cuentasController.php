<?php
namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\accounts_receivable;
use App\Models\account_payment;
use App\Models\clients;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

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

        $clientesConSaldo = clients::select('clients.id', 'clients.nombre')
            ->selectRaw('SUM(accounts_receivable.saldo_restante) as saldo_total')
            ->leftJoin('accounts_receivable', 'clients.id', '=', 'accounts_receivable.cliente_id')
            ->where('accounts_receivable.estado', 'pendiente') // Opcional: filtrar solo cuentas pendientes
            ->groupBy('clients.id', 'clients.nombre')
            ->get();

        return view('cuentas.reportecxc', ['type' => $type, 'clientesConSaldo' => $clientesConSaldo]);
    }
    public function gettype()
    {
        if (Auth::check()) {
            $type = Auth::user()->role;
        }
        return $type;
    }
}
