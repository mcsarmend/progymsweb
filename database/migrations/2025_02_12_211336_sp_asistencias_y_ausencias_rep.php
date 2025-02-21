<?php

use Illuminate\Database\Migrations\Migration;

class SpAsistenciasYAusenciasRep extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $procedure = "DROP PROCEDURE IF EXISTS `sp_asistencias_y_ausencias_rep`;
CREATE PROCEDURE sp_asistencias_y_ausencias_rep()
begin
	SELECT
    fecha,
    users.name AS vendedor,
    MIN(CASE WHEN evento = 'ENTRANCE' THEN CAST(hora AS TIME) END) AS hora_entrada,
    MAX(CASE WHEN evento = 'EXIT' THEN CAST(hora AS TIME) END) AS hora_salida,
    SUM(CASE
        WHEN evento = 'ENTRANCE' AND CAST(hora AS TIME) > DATE_ADD(users.hora_entrada, INTERVAL 15 MINUTE)
        THEN 1
        ELSE 0
    END) AS incidencia

FROM
    attendance
LEFT JOIN
    users ON users.id = attendance.id_user
WHERE
    YEAR(fecha) = YEAR(CURRENT_DATE)
    AND MONTH(fecha) = MONTH(CURRENT_DATE)
GROUP BY
    fecha, users.name
ORDER BY
    fecha;
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
