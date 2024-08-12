<?php

namespace App\Http\Controllers;

use App\Models\attendance;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class asistenciasController extends Controller
{
    public function registroentrada()
    {

        $type = $this->gettype();
        return view('asistencias.registroentrada', ['type' => $type]);
    }
    public function registrosalida()
    {

        $type = $this->gettype();
        return view('asistencias.registrosalida', ['type' => $type]);
    }
    public function asistenciapersonal()
    {
        $startOfMonth = Carbon::now()->startOfMonth()->toDateString();
        $endOfMonth = Carbon::now()->endOfMonth()->toDateString();

        $attendances = DB::table('attendance as a')
            ->select(
                DB::raw('DATE(a.fecha_hora) as fecha'),
                DB::raw('MAX(CASE WHEN a.evento = "ENTRANCE" THEN TIME(a.hora) ELSE NULL END) as hora_entrada'),
                DB::raw('MAX(CASE WHEN a.evento = "EXIT" THEN TIME(a.hora) ELSE NULL END) as hora_salida')
            )
            ->whereBetween('a.fecha', [$startOfMonth, $endOfMonth])
            ->groupBy(DB::raw('DATE(a.fecha_hora)'))
            ->get();
        $type = $this->gettype();

        return response()->view('asistencias.asistenciapersonal', ['type' => $type, 'asistencias' => $attendances], 200);

    }
    public function registrarentrada(Request $request)
    {
        try {
            $attendance = new Attendance();
            $id = Auth::user()->id;

            // Configurar la zona horaria a México
            $now = Carbon::now('America/Mexico_City');
            $fechaMysql = $now->format('Y-m-d H:i:s');
            $dispositivo = substr($request->device["userAgent"], 0, 50);
            $evento = "ENTRANCE";

            // Verificar si ya existe un registro para el usuario en la misma fecha
            $exists = Attendance::where('id_user', $id)
                ->whereDate('fecha', $now->format('Y-m-d'))
                ->where('evento', "ENTRANCE")
                ->exists();

            if ($exists) {
                return response()->json(['message' => 'Ya existe un registro para el usuario en esta fecha.'], 409); // Código de estado HTTP 409 Conflict
            }

            $attendance->id_user = $id;
            $attendance->fecha = $now->format('Y-m-d');
            $attendance->hora = $now->format('H:i:s');
            $attendance->fecha_hora = $fechaMysql;
            $attendance->dispositivo = $dispositivo;
            $attendance->evento = $evento;
            $attendance->save();

            // Devolver una respuesta de éxito
            return response()->json(['message' => 'Registro de entrada realizado correctamente'], 200);
        } catch (\Throwable $e) {
            // Devolver una respuesta de error
            return response()->json(['message' => 'Error al registrar entrada: ' . $e->getMessage()], 500);
        }
    }
    public function registrarsalida(Request $request)
    {
        try {
            $attendance = new Attendance();
            $id = Auth::user()->id;

            // Configurar la zona horaria a México
            $now = Carbon::now('America/Mexico_City');
            $fechaMysql = $now->format('Y-m-d H:i:s');
            $dispositivo = substr($request->device["userAgent"], 0, 50);
            $evento = "EXIT";

            // Verificar si ya existe un registro para el usuario en la misma fecha
            $exists = Attendance::where('id_user', $id)
                ->whereDate('fecha', $now->format('Y-m-d'))
                ->where('evento', "EXIT")
                ->exists();

            if ($exists) {
                return response()->json(['message' => 'Ya existe un registro para el usuario en esta fecha.'], 409); // Código de estado HTTP 409 Conflict
            }

            $attendance->id_user = $id;
            $attendance->fecha = $now->format('Y-m-d');
            $attendance->hora = $now->format('H:i:s');
            $attendance->fecha_hora = $fechaMysql;
            $attendance->dispositivo = $dispositivo;
            $attendance->evento = $evento;
            $attendance->save();

            // Devolver una respuesta de éxito
            return response()->json(['message' => 'Registro de entrada realizado correctamente'], 200);
        } catch (\Throwable $e) {
            // Devolver una respuesta de error
            return response()->json(['message' => 'Error al registrar entrada: ' . $e->getMessage()], 500);
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
