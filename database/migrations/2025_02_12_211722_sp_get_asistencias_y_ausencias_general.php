<?php

use Illuminate\Database\Migrations\Migration;

class SpGetAsistenciasYAusenciasGeneral extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $procedure = "DROP PROCEDURE IF EXISTS `sp_get_asistencias_y_ausencias_general`;
CREATE PROCEDURE sp_get_asistencias_y_ausencias_general(IN fecha_inicio DATE, IN fecha_fin DATE)
begin

	SELECT
        fecha,
        SUM(CASE WHEN EVENTO = 'ENTRANCE' THEN 1 ELSE 0 END) AS entrada,
        SUM(CASE WHEN EVENTO = 'EXIT' THEN 1 ELSE 0 END) AS salida,
        SUM(CASE
            WHEN evento = 'ENTRANCE' AND CAST(fecha_hora AS TIME) > DATE_ADD(users.hora_entrada, INTERVAL 15 MINUTE)
            THEN 1
            ELSE 0
        END) AS incidencia
    FROM
        attendance
    LEFT JOIN users ON users.id = attendance.id_user
    WHERE
        fecha BETWEEN fecha_inicio AND fecha_fin
    GROUP BY
        FECHA
    ORDER BY
        FECHA;
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
