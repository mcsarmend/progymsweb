<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;
class CreateSpReportecortecajaProcedure extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
  public function up()
    {
        $procedure = <<<SQL
            DROP PROCEDURE IF EXISTS reportecortecaja;

            CREATE PROCEDURE `reportecortecaja` (
            IN p_fecha_inicio DATE,
            IN p_fecha_fin DATE

            ) BEGIN
            select
                c.total_general,
                c.total_efectivo_entregar,
                c.formas_pago,
                c.inputs_adicionales,
                u.name as vendedor,
                c.fecha_cierre as fecha,
                c.observaciones
            from
                cash_closure as c
                left join users as u on u.id = c.vendedor
            WHERE
                C.fecha_cierre BETWEEN CONCAT(p_fecha_inicio, ' 00:00:00')
                AND CONCAT(p_fecha_fin, ' 23:59:59');

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
        Schema::dropIfExists('sp_reportecortecaja_procedure');
    }
}
