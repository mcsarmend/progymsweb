<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;
class CreateSpIncidenciasPorMesProcedure extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
  public function up()
    {
        $procedure = <<<SQL
            DROP PROCEDURE IF EXISTS `sp_incidencias_por_mes`;
            CREATE PROCEDURE laravel.sp_incidencias_por_mes(IN mes int,IN anio int)
            begin
                    SELECT
                    users.name AS nombre,
                    incidents.*
                FROM
                    incidents
                JOIN
                    users ON incidents.iduser = users.id
                WHERE
                    MONTH(incidents.fecha) = mes
                    AND YEAR(incidents.fecha) = anio
                ORDER BY
                    incidents.iduser;
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
        Schema::dropIfExists('sp_incidencias_por_mes_procedure');
    }
}
