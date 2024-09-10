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
        $now = Carbon::now();
        $id = Auth::user()->id;
        $attendances = DB::table(DB::raw('(
            SELECT
                CAST(fecha_hora AS DATE) AS fecha,
                users.name AS vendedor,
                MIN(CASE WHEN evento = "ENTRANCE" THEN CAST(fecha_hora AS TIME) END) AS hora_entrada,
                MAX(CASE WHEN evento = "EXIT" THEN CAST(fecha_hora AS TIME) END) AS hora_salida,
                users.hora_entrada AS user_hora_entrada
            FROM attendance
            LEFT JOIN users ON users.id = attendance.id_user
            WHERE evento IN ("ENTRANCE", "EXIT")
            AND users.id = ' . $id . '
            AND MONTH(fecha_hora) = ?
            AND YEAR(fecha_hora) = ?
            GROUP BY CAST(fecha_hora AS DATE), users.id, users.name, users.hora_entrada
        ) AS subquery'))
            ->select([
                'fecha',
                'vendedor',
                'hora_entrada',
                'hora_salida',
                DB::raw('CASE WHEN hora_entrada > DATE_ADD(user_hora_entrada, INTERVAL 15 MINUTE) THEN "SI" ELSE "NO" END AS incidencia_entrada'),
            ])
            ->setBindings([$now->month, $now->year])
            ->orderBy('fecha', 'asc')
            ->orderBy('vendedor', 'asc')
            ->get();

        $type = $this->gettype();

        return response()->view('asistencias.asistenciapersonal', ['type' => $type, 'asistencias' => $attendances], 200);

    }

    public function asistenciageneral()
    {
        $now = Carbon::now();

        $attendances = DB::table(DB::raw('(
            SELECT
                CAST(fecha_hora AS DATE) AS fecha,
                users.name AS vendedor,
                MIN(CASE WHEN evento = "ENTRANCE" THEN CAST(fecha_hora AS TIME) END) AS hora_entrada,
                MAX(CASE WHEN evento = "EXIT" THEN CAST(fecha_hora AS TIME) END) AS hora_salida,
                users.hora_entrada AS user_hora_entrada
            FROM attendance
            LEFT JOIN users ON users.id = attendance.id_user
            WHERE evento IN ("ENTRANCE", "EXIT")
            AND MONTH(fecha_hora) = ?
            AND YEAR(fecha_hora) = ?
            GROUP BY CAST(fecha_hora AS DATE), users.id, users.name, users.hora_entrada
        ) AS subquery'))
            ->select([
                'fecha',
                'vendedor',
                'hora_entrada',
                'hora_salida',
                DB::raw('CASE WHEN hora_entrada > DATE_ADD(user_hora_entrada, INTERVAL 15 MINUTE) THEN "SI" ELSE "NO" END AS incidencia_entrada'),
            ])
            ->setBindings([$now->month, $now->year])
            ->orderBy('fecha', 'asc')
            ->orderBy('vendedor', 'asc')
            ->get();

        $type = $this->gettype();

        return response()->view('asistencias.asistenciageneral', ['type' => $type, 'asistencias' => $attendances]);
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
