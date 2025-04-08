<?php
namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\accounts_receivable;
use App\Models\referrals;
use App\Models\total_accounts_receivable;
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
            $referral       = referrals::find($request->remision);
            $referral->isar = true;
            $referral->save();

            return response()->json(['message' => 'Cuenta por Cobrar creada correctamente'], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al crear la CxC' . $th->getMessage()], 500);
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
            // Crear registro en accounts_receivable
            $account = accounts_receivable::create([
                'remision'    => $request->remision,
                'abono'       => $request->abono,
                'fecha_abono' => now()->format('Y-m-d H:i:s'), // Formato MySQL
                'forma_pago'  => $request->metodo_pago,
                'iduser'      => Auth::user()->id,
            ]);

            // Sumar columnas abono y saldo_restante
            $totalAbono    = accounts_receivable::where('remision', $request->remision)->sum('abono');
            $totalRestante = total_accounts_receivable::where('idcliente', $request->remision)->value('total') ?? 0;

            // Actualizar saldo restante en total_accounts_receivable
            total_accounts_receivable::updateOrCreate(
                ['idcliente' => $request->remision],
                [
                    'total'               => $totalRestante + $totalAbono,
                    'fecha_actualizacion' => now()->format('Y-m-d H:i:s'), // Formato MySQL
                ]
            );

            return response()->json(['message' => 'Cuenta por Cobrar actualizada correctamente'], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Error al actualizar la CxC: ' . $th->getMessage()], 500);
        }
    }
    public function reportecxc()
    {
        $type = $this->gettype();
        return view('cuentas.reportecxc', ['type' => $type]);
    }
    public function gettype()
    {
        if (Auth::check()) {
            $type = Auth::user()->role;
        }
        return $type;
    }
}
