<?php

use Illuminate\Database\Migrations\Migration;

class SpGetAsistenciasYAusenciasPorSemanaIndividual extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $procedure = "DROP PROCEDURE IF EXISTS `sp_get_asistencias_y_ausencias_por_semana_individual`;
CREATE PROCEDURE sp_get_asistencias_y_ausencias_por_semana_individual(IN id_user INT,IN fecha_inicio DATE,IN fecha_fin DATE)
begin

	    SELECT
        WEEK(fecha, 3) AS semana,  -- Agrupa por semana usando el modo 3 (ISO semanales)
        SUM(CASE WHEN evento = 'ENTRANCE' THEN 1 ELSE 0 END) AS entrada,
        SUM(CASE WHEN evento = 'EXIT' THEN 1 ELSE 0 END) AS salida,
        SUM(CASE
            WHEN evento = 'ENTRANCE' AND CAST(fecha_hora AS TIME) > DATE_ADD(users.hora_entrada, INTERVAL 15 MINUTE)
            THEN 1
            ELSE 0
        END) AS incidencia
    FROM
        attendance
    LEFT JOIN
        users ON users.id = attendance.id_user
    WHERE
        fecha BETWEEN fecha_inicio AND fecha_fin  -- Filtrar por el rango de fechas
        AND (id_user IS NULL OR attendance.id_user = id_user)  -- Filtrar por usuario si no es NULL
    GROUP BY
        WEEK(fecha, 3)  -- Agrupar por semana
    ORDER BY
        semana;
END";
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
