<?php

use Illuminate\Database\Migrations\Migration;

class SpGetIncidenciasIndividual extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $procedure = "DROP PROCEDURE IF EXISTS `sp_get_incidencias_individual`;
CREATE PROCEDURE sp_get_incidencias_individual(IN id_user INT,IN fecha_inicio DATE,IN fecha_fin DATE)
begin
	SELECT
    SUM(incidencia) AS total_incidencias
FROM (
    SELECT

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
        AND (id_user IS NULL OR attendance.id_user = id_user)
    GROUP BY
        fecha
) AS subquery;

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
