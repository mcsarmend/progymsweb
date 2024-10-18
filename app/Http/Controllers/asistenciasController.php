<?php

namespace App\Http\Controllers;

use App\Models\attendance;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Crypt;
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

        $entradasysalidas = DB::select('CALL sp_get_asistencias_y_ausencias()');
        $tendencias = DB::select('CALL sp_get_asistencias_y_ausencias_por_semana()');
        $reporte = DB::select('CALL sp_asistencias_y_ausencias_rep()');
        $empleados = User::select('users.id as id', 'users.name as nombre', 'users.email as correo', 'users.pass as contrasena', 'users.phone as telefono', 'users.role as rol', 'warehouse.nombre as sucursal')
            ->leftJoin('warehouse', 'users.warehouse', '=', 'warehouse.id')
            ->get();
        $totalEmpleados = \App\Models\User::whereIn('role', [3, 4])->count();

        $type = $this->gettype();

        return response()->view('asistencias.asistenciageneral', ['type' => $type, 'entradasysalidas' => $entradasysalidas, 'totalempleados' => $totalEmpleados, 'tendencias' => $tendencias, 'empleados' => $empleados, 'reporte' => $reporte]);
    }

    public function asistencia_graficas(Request $request)
    {

        $id_empleado = Crypt::decrypt($request["id_empleado"]);

        $fecha_inicio = $request->fecha_inicio;
        $fecha_fin = $request->fecha_fin;
        $reporte = [];

        try {
            $asistencia = [];
            $asistencia_semana = [];
            if ($id_empleado == "0") {
                $asistencia = DB::select('CALL sp_get_asistencias_y_ausencias_general(?, ?, ?)', [$id_empleado, $fecha_inicio, $fecha_fin]);
                $asistencia_semana = DB::select('CALL sp_get_asistencias_y_ausencias_por_semana_general(?, ?, ?)', [$id_empleado, $fecha_inicio, $fecha_fin]);
                $reporte = DB::select('CALL sdp_asistencias_y_ausencias_rep_general(?, ?, ?)', [$fecha_inicio, $fecha_fin]);
            } else {
                $asistencia = DB::select('CALL sp_get_asistencias_y_ausencias_individual(?, ?, ?)', [$id_empleado, $fecha_inicio, $fecha_fin]);
                $asistencia_semana = DB::select('CALL sp_get_asistencias_y_ausencias_por_semana_individual(?, ?, ?)', [$id_empleado, $fecha_inicio, $fecha_fin]);
                $reporte = DB::select('CALL sp_asistencias_y_ausencias_rep_individual(?, ?, ?)', [$fecha_inicio, $fecha_fin, $id_empleado]);
            }
            return response()->json(['message' => 'Reporte generado correctamente ', 'asistencia' => $asistencia, 'asistencia_semana' => $asistencia_semana, 'reporte' => $reporte], 200);
        } catch (\Throwable $th) {

            return response()->json(['message' => 'Error al reporte: ' . $th->getMessage()], 500);
        }

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
