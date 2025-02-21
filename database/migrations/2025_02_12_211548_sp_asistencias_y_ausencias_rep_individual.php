<?php

use Illuminate\Database\Migrations\Migration;

class SpAsistenciasYAusenciasRepIndividual extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $procedure = "DROP PROCEDURE IF EXISTS `sp_asistencias_y_ausencias_rep_individual`;
CREATE PROCEDURE sp_asistencias_y_ausencias_rep_individual(	IN fecha_inicio DATE,IN fecha_fin DATE, in id_user int)
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
        fecha BETWEEN fecha_inicio AND fecha_fin
        and users.id = id_user
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
