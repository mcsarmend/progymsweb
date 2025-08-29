<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

class CreateSpGetAsistenciasYAusenciasIndividual extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
public function up()
    {
        $procedure = <<<SQL
            DROP PROCEDURE IF EXISTS sp_get_asistencias_y_ausencias_individual;
            CREATE PROCEDURE sp_get_asistencias_y_ausencias_individual(
                IN id_user INT,
                IN fecha_inicio DATE,
                IN fecha_fin DATE
            )
            BEGIN
                SELECT
                    fecha,
                    users.name AS vendedor,
                    SUM(CASE WHEN evento = 'ENTRANCE' THEN 1 ELSE 0 END) AS entrada,
                    SUM(CASE WHEN evento = 'EXIT' THEN 1 ELSE 0 END) AS salida,
                    SUM(
                        CASE
                            WHEN evento = 'ENTRANCE'
                            AND CAST(fecha_hora AS TIME) > DATE_ADD(users.hora_entrada, INTERVAL 15 MINUTE)
                            THEN 1 ELSE 0
                        END
                    ) AS incidencia,
                    MAX(CASE WHEN evento = 'ENTRANCE' THEN CAST(fecha_hora AS TIME) END) AS hora_entrada,
                    MAX(CASE WHEN evento = 'EXIT' THEN CAST(fecha_hora AS TIME) END) AS hora_salida
                FROM attendance
                LEFT JOIN users ON users.id = attendance.id_user
                WHERE
                    fecha BETWEEN fecha_inicio AND fecha_fin
                    AND (id_user IS NULL OR attendance.id_user = id_user)
                GROUP BY
                    fecha, users.id, users.name, users.hora_entrada
                ORDER BY fecha;
            END



        SQL;

        DB::unprepared($procedure);
    }
    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('sp_get_asistencias_y_ausencias_individual');
    }
}
