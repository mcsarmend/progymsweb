<?php

use Illuminate\Database\Migrations\Migration;

class SpGetAsistenciasYAusencias extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $procedure = "DROP PROCEDURE IF EXISTS `sp_get_asistencias_y_ausencias`;
CREATE PROCEDURE sp_get_asistencias_y_ausencias()
begin
	SELECT
    fecha,
    users.name as vendedor,
    SUM(CASE WHEN EVENTO = 'ENTRANCE' THEN 1 ELSE 0 END) AS entrada,
    SUM(CASE WHEN EVENTO = 'EXIT' THEN 1 ELSE 0 END) AS salida,
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
    YEAR(FECHA) = YEAR(CURRENT_DATE) AND MONTH(FECHA) = MONTH(CURRENT_DATE)
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
