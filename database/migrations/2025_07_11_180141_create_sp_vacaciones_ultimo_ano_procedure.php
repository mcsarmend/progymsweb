<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;
class CreateSpVacacionesUltimoAnoProcedure extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
  public function up()
    {
        $procedure = <<<SQL

            DROP PROCEDURE IF EXISTS `sp_vacaciones_ultimo_ano`;
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
        Schema::dropIfExists('sp_vacaciones_ultimo_ano_procedure');
    }
}
