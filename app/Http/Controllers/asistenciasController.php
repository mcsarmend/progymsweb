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
        $now         = Carbon::now();
        $id          = Auth::user()->id;
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

        // Consulta única: por fecha + usuario (detallado)
        $asistencias = DB::table('attendance as a')
            ->leftJoin('users as u', 'u.id', '=', 'a.id_user')
            ->select(
                'a.fecha',
                'u.id as usuario_id',
                'u.name as vendedor',
                DB::raw("SUM(CASE WHEN a.evento = 'ENTRANCE' THEN 1 ELSE 0 END) AS entrada"),
                DB::raw("SUM(CASE WHEN a.evento = 'EXIT' THEN 1 ELSE 0 END) AS salida"),
                DB::raw("
                                    SUM(
                                        CASE
                                            WHEN a.evento = 'ENTRANCE'
                                            AND TIME(a.fecha_hora) > DATE_ADD(u.hora_entrada, INTERVAL 15 MINUTE)
                                            THEN 1 ELSE 0
                                        END
                                    ) AS incidencia
                                "),
                DB::raw("MIN(CASE WHEN a.evento = 'ENTRANCE' THEN a.hora END) AS hora_entrada"),
                DB::raw("MAX(CASE WHEN a.evento = 'EXIT' THEN a.hora END) AS hora_salida"),
                DB::raw("
                                    CASE
                                        WHEN a.dispositivo LIKE '%Windows NT%' THEN 'Computadora'
                                        WHEN a.dispositivo LIKE '%Android%' THEN 'Celular'
                                        ELSE 'Otro'
                                    END AS medio
                                ")
            )
            ->whereYear('a.fecha', $now->year)
            ->whereMonth('a.fecha', $now->month)
            ->whereNotNull('u.id')
            ->groupBy('a.fecha', 'u.id', 'u.name','a.dispositivo')
            ->orderBy('a.fecha')
            ->get(); // Collection de stdClass

        // ---- Agrupar y sumar por fecha para las gráficas (totales por día) ----
        // $asistencias es una Collection, usamos groupBy + map para obtener totales por fecha
        $totalesPorFecha = $asistencias
            ->groupBy('fecha')
            ->map(function ($rows, $fecha) {
                // $rows es una Collection de filas (stdClass) que comparten la misma fecha
                return (object) [
                    'fecha'      => $fecha,
                    'entrada'    => (int) $rows->sum(function ($r) {return (int) $r->entrada;}),
                    'salida'     => (int) $rows->sum(function ($r) {return (int) $r->salida;}),
                    'incidencia' => (int) $rows->sum(function ($r) {return (int) $r->incidencia;}),
                ];
            })
            ->values(); // reindexar

        // Empleados (igual que antes)
        $empleados = User::select('users.id as id', 'users.name as nombre')
            ->where('users.status', 1)
            ->whereIn('users.role', [3, 4])
            ->get();

        $totalEmpleados = User::whereIn('role', [3, 4])
            ->where('status', 1)
            ->count();

        $type = $this->gettype();

        // Enviamos:
        // - 'entradasysalidas' = totales por fecha (para Highcharts)
        // - 'reporte' = detallado por fecha+usuario (para DataTable)
        return view('asistencias.asistenciageneral', [
            'type'             => $type,
            'entradasysalidas' => $totalesPorFecha,
            'totalempleados'   => $totalEmpleados,
            'tendencias'       => collect(), // si ya no usas tendencias, envía colección vacía o remueve
            'empleados'        => $empleados,
            'reporte'          => $asistencias,
        ]);
    }

    public function calendario()
    {
        $mes         = Carbon::now()->month;
        $anio        = Carbon::now()->year;
        $incidencias = DB::select('CALL sp_incidencias_por_mes(?, ?)', [$mes, $anio]);

        $type      = $this->gettype();
        $empleados = User::select('id', 'name as nombre')
            ->where('status', 1)
            ->get();

        return response()->view('asistencias.calendario', ['type' => $type, 'empleados' => $empleados, 'incidencias' => $incidencias]);
    }
    public function vacaciones()
    {

        $vacaciones = DB::select('CALL obtener_vacaciones_restantes()');

        $type      = $this->gettype();
        $empleados = User::select('id', 'name as nombre')
            ->where('status', 1)
            ->get();

        return response()->view('asistencias.vacaciones', ['type' => $type, 'empleados' => $empleados, 'vacaciones' => $vacaciones]);
    }
    public function getvacaciones(Request $request)
    {

        try {
            $id          = $request->id;
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

        $mes         = $request->mes;
        $anio        = $request->anio;
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
            $incident              = new incidents();
            $incident->iduser      = $request->iduser;
            $incident->fecha       = $request->fecha;
            $incident->tipo        = $request->tipo;
            $incident->descripcion = $request->descripcion;

            $incident->save();

            if ($request->tipo == "VACACION") {
                $vacation    = new vacation();
                $id_empleado = $request->iduser;
                $fechas      = User::select('id', 'fecha_ingreso',
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

                    $vacation->id_user     = $id_empleado;
                    $vacation->fecha       = $request->fecha;
                    $vacation->no_vacacion = 1;
                } else {
                    $vacacionesFechasJson = $vacacionesFechas["vacacionesFechas"];
                    // Ordenar la colección por fecha de forma descendente
                    $vacacionReciente = $vacacionesFechasJson->sortByDesc(function ($vacacion) {
                        return strtotime($vacacion['FechaVacacion']);
                    })->first();

                    // Obtener la fecha más reciente y el NoVacacion
                    $fechaMasReciente = $vacacionReciente['FechaVacacion'];
                    $noVacacion       = $vacacionReciente['NoVacacion'];

                    $vacation->id_user     = $id_empleado;
                    $vacation->fecha       = $request->fecha;
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
        try {
            $id_empleado = $request->id_empleado;

            if ($id_empleado != "0") {
                $id_empleado = Crypt::decrypt($id_empleado);
            } else {
                $id_empleado = null; // TODOS
            }

            $fecha_inicio = $request->fecha_inicio;
            $fecha_fin    = $request->fecha_fin;

            // ---------------------------------------------------------
            // CONSULTA ÚNICA (como asistenciageneral)
            // ---------------------------------------------------------
            $asistencias = DB::table('attendance as a')
                ->leftJoin('users as u', 'u.id', '=', 'a.id_user')
                ->select(
                    'a.fecha',
                    'u.id as usuario_id',
                    'u.name as vendedor',

                    DB::raw("SUM(CASE WHEN a.evento = 'ENTRANCE' THEN 1 ELSE 0 END) AS entrada"),
                    DB::raw("SUM(CASE WHEN a.evento = 'EXIT' THEN 1 ELSE 0 END) AS salida"),

                    DB::raw("
                    SUM(
                        CASE
                            WHEN a.evento = 'ENTRANCE'
                             AND TIME(a.fecha_hora) > DATE_ADD(u.hora_entrada, INTERVAL 15 MINUTE)
                            THEN 1 ELSE 0
                        END
                    ) AS incidencia
                "),

                    DB::raw("MIN(CASE WHEN a.evento = 'ENTRANCE' THEN a.hora END) AS hora_entrada"),
                    DB::raw("MAX(CASE WHEN a.evento = 'EXIT' THEN a.hora END) AS hora_salida")
                )
                ->whereBetween('a.fecha', [$fecha_inicio, $fecha_fin])
                ->when($id_empleado, function ($q) use ($id_empleado) {
                    return $q->where('u.id', $id_empleado);
                })
                ->whereNotNull('u.id')
                ->groupBy('a.fecha', 'u.id', 'u.name')
                ->orderBy('a.fecha')
                ->get();

            // ---------------------------------------------------------
            // SUMAR POR FECHA → (Highcharts)
            // ---------------------------------------------------------
            $totalesPorFecha = $asistencias
                ->groupBy('fecha')
                ->map(function ($rows, $fecha) {
                    return (object) [
                        'fecha'      => $fecha,
                        'entrada'    => (int) $rows->sum('entrada'),
                        'salida'     => (int) $rows->sum('salida'),
                        'incidencia' => (int) $rows->sum('incidencia'),
                    ];
                })
                ->values();

            // Esto se llama "entradasysalidas" en tu JS
            $asistencia = $totalesPorFecha;

            // Detalle por empleado+fecha (tu DataTable)
            $reporte = $asistencias;

            return response()->json([
                'message'    => 'Reporte generado correctamente',
                'asistencia' => $asistencia, // para Highcharts
                'reporte'    => $reporte,    // para tabla
            ], 200);

        } catch (\Throwable $th) {

            return response()->json([
                'message' => 'Error al generar reporte: ' . $th->getMessage(),
            ], 500);
        }
    }

    public function registrarentrada(Request $request)
    {
        try {
            $attendance = new Attendance();
            $id         = Auth::user()->id;

            // Configurar la zona horaria a México
            $now         = Carbon::now('America/Mexico_City');
            $fechaMysql  = $now->format('Y-m-d H:i:s');
            $dispositivo = substr($request->device["userAgent"], 0, 50);
            $evento      = "ENTRANCE";

            // Verificar si ya existe un registro para el usuario en la misma fecha
            $exists = Attendance::where('id_user', $id)
                ->whereDate('fecha', $now->format('Y-m-d'))
                ->where('evento', "ENTRANCE")
                ->exists();

            if ($exists) {
                return response()->json(['message' => 'Ya existe un registro para el usuario en esta fecha.'], 409); // Código de estado HTTP 409 Conflict
            }

            $attendance->id_user     = $id;
            $attendance->fecha       = $now->format('Y-m-d');
            $attendance->hora        = $now->format('H:i:s');
            $attendance->fecha_hora  = $fechaMysql;
            $attendance->dispositivo = $dispositivo;
            $attendance->evento      = $evento;

            $diaActual  = date('j'); // Día actual del mes sin ceros iniciales
            $mesActual  = date('m'); // Mes actual con ceros iniciales
            $anioActual = date('Y'); // Año actual

            $fechaInicio = date('');
            $fechaFin    = date('');

            if ($diaActual <= 15) {
                // Si el día es menor o igual a 15, obtenemos del primer día al 15
                $fechaInicio = "$anioActual-$mesActual-01";
                $fechaFin    = "$anioActual-$mesActual-15";
            } else {
                // Si el día es mayor a 15, obtenemos del 16 al último día del mes
                $fechaInicio = "$anioActual-$mesActual-16";
                $fechaFin    = date("Y-m-t"); // Obtiene el último día del mes
            }

            $cantidadIncidencias = DB::select('CALL sp_get_incidencias_individual(?, ?, ?)', [$id, $fechaInicio, $fechaFin]);

            $attendance->save();

            $message               = "Registro realizado correctamente a las: " . $attendance->hora . ". Recuerda que llevas: ***  " . $cantidadIncidencias[0]->total_incidencias . " *** incidencias en esta quincena";
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
            $id         = Auth::user()->id;

            // Configurar la zona horaria a México
            $now         = Carbon::now('America/Mexico_City');
            $fechaMysql  = $now->format('Y-m-d H:i:s');
            $dispositivo = substr($request->device["userAgent"], 0, 50);
            $evento      = "EXIT";

            // Verificar si ya existe un registro para el usuario en la misma fecha
            $exists = Attendance::where('id_user', $id)
                ->whereDate('fecha', $now->format('Y-m-d'))
                ->where('evento', "EXIT")
                ->exists();

            if ($exists) {
                return response()->json(['message' => 'Ya existe un registro para el usuario en esta fecha.'], 409); // Código de estado HTTP 409 Conflict
            }

            $attendance->id_user     = $id;
            $attendance->fecha       = $now->format('Y-m-d');
            $attendance->hora        = $now->format('H:i:s');
            $attendance->fecha_hora  = $fechaMysql;
            $attendance->dispositivo = $dispositivo;
            $attendance->evento      = $evento;
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
