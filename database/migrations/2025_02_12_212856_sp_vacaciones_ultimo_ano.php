<?php

use Illuminate\Database\Migrations\Migration;

class SpVacacionesUltimoAno extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $procedure = "DROP PROCEDURE IF EXISTS `sp_vacaciones_ultimo_ano`;
CREATE PROCEDURE sp_vacaciones_ultimo_ano(IN iduser INT,fecha_inicio_ultimo_ano DATE)
begin
	        SELECT
            v.id AS IdVacacion,
            v.fecha AS FechaVacacion,
            v.no_vacacion AS NoVacacion
        FROM
            vacation v
        WHERE
            v.id_user = iduser
            AND v.fecha >= fecha_inicio_ultimo_ano
        ORDER BY
            v.fecha;
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
