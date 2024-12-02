<?php

namespace App\Http\Controllers;

use App\Models\attendance;
use App\Models\incidents;
use App\Models\User;
use App\Models\vacation;
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
        $totalEmpleados = User::whereIn('role', [3, 4])->count();

        $type = $this->gettype();

        return response()->view('asistencias.asistenciageneral', ['type' => $type, 'entradasysalidas' => $entradasysalidas, 'totalempleados' => $totalEmpleados, 'tendencias' => $tendencias, 'empleados' => $empleados, 'reporte' => $reporte]);
    }
    public function calendario()
    {
        $mes = Carbon::now()->month;
        $anio = Carbon::now()->year;
        $incidencias = DB::select('CALL sp_incidencias_por_mes(?, ?)', [$mes, $anio]);

        $type = $this->gettype();
        $empleados = User::select('id', 'name as nombre')->get();

        return response()->view('asistencias.calendario', ['type' => $type, 'empleados' => $empleados, 'incidencias' => $incidencias]);
    }
    public function vacaciones()
    {

        $vacaciones = DB::select('CALL obtener_vacaciones_restantes()');

        $type = $this->gettype();
        $empleados = User::select('id', 'name as nombre')->get();

        return response()->view('asistencias.vacaciones', ['type' => $type, 'empleados' => $empleados, 'vacaciones' => $vacaciones]);
    }
    public function getvacaciones(Request $request)
    {

        try {
            $id = $request->id;
            $id_empleado = Crypt::decrypt($id);

            $fechas = User::select('id', 'fecha_ingreso',
                DB::raw("DATE_ADD(fecha_ingreso, INTERVAL CASE
                            WHEN YEAR(fecha_ingreso) < YEAR(CURDATE())
                            THEN YEAR(CURDATE()) - YEAR(fecha_ingreso)
                            ELSE 0
                         END YEAR) AS fecha_resultante")
            )
                ->get();
            $fechaResultante = collect($fechas)->firstWhere('id', $id_empleado)['fecha_resultante'];

            $vacacionesFechas = DB::select('CALL sp_vacaciones_ultimo_ano(?, ?)', [$id_empleado, $fechaResultante]);

            return response()->json(['vacacionesFechas' => $vacacionesFechas], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Error al reporte: ' . $th->getMessage()], 500);
        }

    }
    public function calendarioincidencias(Request $request)
    {

        $mes = $request->mes;
        $anio = $request->anio;
        $incidencias = DB::select('CALL sp_incidencias_por_mes(?, ?)', [$mes, $anio]);

        if ($incidencias == []) {
            $message = "Sin información en este mes";
        } else {
            $message = "Reporte generado correctamente";

        }

        return response()->json(['message' => $message, 'incidencias' => $incidencias], 200);

    }
    public function obtenerincidencia(Request $request)
    {
        $id = $request->id;

        $incidencias = DB::table('incidents')
            ->leftJoin('users', 'incidents.iduser', '=', 'users.id')
            ->select('users.name as nombre', 'incidents.*')
            ->where('users.id', $id)
            ->get();

        return response()->json($incidencias);
    }
    public function cancelarincidencia(Request $request)
    {

        try {
            $id = $request->id;

            $incident = incidents::where("id", $id)->get();

            if ($incident[0]->tipo == "VACACION") {

                vacation::where('id_user', $id)
                    ->where('fecha', $incident[0]->fecha)
                    ->delete();
            }

            incidents::findOrFail($id)->delete();
            return response()->json(['message' => 'La incidencia ha sido eliminada correctamente'], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Error al reporte: ' . $th->getMessage()], 500);
        }
    }
    public function marcarincidencia(Request $request)
    {

        try {
            $incident = new incidents();
            $incident->iduser = $request->iduser;
            $incident->fecha = $request->fecha;
            $incident->tipo = $request->tipo;
            $incident->descripcion = $request->descripcion;

            $incident->save();

            if ($request->tipo == "VACACION") {
                $vacation = new vacation();
                $id_empleado = $request->iduser;
                $fechas = User::select('id', 'fecha_ingreso',
                    DB::raw("DATE_ADD(fecha_ingreso, INTERVAL CASE
                            WHEN YEAR(fecha_ingreso) < YEAR(CURDATE())
                            THEN YEAR(CURDATE()) - YEAR(fecha_ingreso)
                            ELSE 0
                         END YEAR) AS fecha_resultante")
                )
                    ->get();
                $fechaResultante = collect($fechas)->firstWhere('id', $id_empleado)['fecha_resultante'];

                $vacacionesFechas = DB::select('CALL sp_vacaciones_ultimo_ano(?, ?)', [$id_empleado, $fechaResultante]);

                if ($vacacionesFechas == []) {

                    $vacation->id_user = $id_empleado;
                    $vacation->fecha = $request->fecha;
                    $vacation->no_vacacion = 1;
                } else {
                    $vacacionesFechasJson = $vacacionesFechas["vacacionesFechas"];
                    // Ordenar la colección por fecha de forma descendente
                    $vacacionReciente = $vacacionesFechasJson->sortByDesc(function ($vacacion) {
                        return strtotime($vacacion['FechaVacacion']);
                    })->first();

                    // Obtener la fecha más reciente y el NoVacacion
                    $fechaMasReciente = $vacacionReciente['FechaVacacion'];
                    $noVacacion = $vacacionReciente['NoVacacion'];

                    $vacation->id_user = $id_empleado;
                    $vacation->fecha = $request->fecha;
                    $vacation->no_vacacion = $noVacacion + 1;

                }

                $vacation->save();
            }

            return response()->json(['message' => 'La incidencia ha sido marcada correctamente'], 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Error al reporte: ' . $th->getMessage()], 500);
        }

    }

    public function asistencia_graficas(Request $request)
    {
        $id_empleado = $request["id_empleado"];
        if ($id_empleado != "0") {
            $id_empleado = Crypt::decrypt($id_empleado);
        }

        $fecha_inicio = $request->fecha_inicio;
        $fecha_fin = $request->fecha_fin;
        $reporte = [];

        try {
            $asistencia = [];
            $asistencia_semana = [];

            if ($id_empleado == "0") {

                $asistencia = DB::select('CALL sp_get_asistencias_y_ausencias_general(?, ?)', [$fecha_inicio, $fecha_fin]);
                $asistencia_semana = DB::select('CALL sp_get_asistencias_y_ausencias_por_semana_general(?, ?)', [$fecha_inicio, $fecha_fin]);
                $reporte = DB::select('CALL sp_asistencias_y_ausencias_rep_general(?, ?)', [$fecha_inicio, $fecha_fin]);

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

            $diaActual = date('j'); // Día actual del mes sin ceros iniciales
            $mesActual = date('m'); // Mes actual con ceros iniciales
            $anioActual = date('Y'); // Año actual

            $fechaInicio = date('');
            $fechaFin = date('');

            if ($diaActual <= 15) {
                // Si el día es menor o igual a 15, obtenemos del primer día al 15
                $fechaInicio = "$anioActual-$mesActual-01";
                $fechaFin = "$anioActual-$mesActual-15";
            } else {
                // Si el día es mayor a 15, obtenemos del 16 al último día del mes
                $fechaInicio = "$anioActual-$mesActual-16";
                $fechaFin = date("Y-m-t"); // Obtiene el último día del mes
            }

            $cantidadIncidencias = DB::select('CALL sp_get_incidencias_individual(?, ?, ?)', [$id, $fechaInicio, $fechaFin]);

            $attendance->save();

            $message = "Registro realizado correctamente a las: " . $attendance->hora . ". Recuerda que llevas: ***  " . $cantidadIncidencias[0]->total_incidencias . " *** incidencias en esta quincena";
            $cantidadDeIncidencias = intval($cantidadIncidencias[0]->total_incidencias);

            // Devolver una respuesta de éxito
            return response()->json(['message' => $message, "cantidadIncidencias" => $cantidadDeIncidencias], 200);
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
