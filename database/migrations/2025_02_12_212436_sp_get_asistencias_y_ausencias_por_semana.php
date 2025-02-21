<?php

use Illuminate\Database\Migrations\Migration;

class SpGetAsistenciasYAusenciasPorSemana extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $procedure = "DROP PROCEDURE IF EXISTS `sp_get_asistencias_y_ausencias_por_semana`;
CREATE PROCEDURE sp_get_asistencias_y_ausencias_por_semana()
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
        YEAR(fecha) = YEAR(CURRENT_DATE)
        AND MONTH(fecha) = MONTH(CURRENT_DATE)  -- Filtrar por mes en curso
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
