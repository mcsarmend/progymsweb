<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class SpListaExistenciasActivas extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $procedure = "CREATE PROCEDURE laravel.lista_existencias_activas()
BEGIN
    SELECT
        p.id AS codigo,
        p.nombre AS producto,
        b.nombre AS marca,
        c.nombre AS categoria,
        COALESCE(SUM(pw.existencias), 0) AS totales,
        COALESCE(SUM(CASE WHEN pw.idwarehouse = 1 THEN pw.existencias ELSE 0 END), 0) AS almacen_principal,
        COALESCE(SUM(CASE WHEN pw.idwarehouse = 2 THEN pw.existencias ELSE 0 END), 0) AS viveros,
        COALESCE(SUM(CASE WHEN pw.idwarehouse = 3 THEN pw.existencias ELSE 0 END), 0) AS towncenter,
        COALESCE(SUM(CASE WHEN pw.idwarehouse = 4 THEN pw.existencias ELSE 0 END), 0) AS coacalco,
        COALESCE(SUM(CASE WHEN pw.idwarehouse = 6 THEN pw.existencias ELSE 0 END), 0) AS villas,
        COALESCE(SUM(CASE WHEN pw.idwarehouse = 7 THEN pw.existencias ELSE 0 END), 0) AS naucalpan
    FROM
        product p
    LEFT JOIN brand b ON p.marca = b.id
    LEFT JOIN category c ON p.categoria = c.id
    LEFT JOIN product_warehouse pw ON pw.idproducto = p.id
    GROUP BY
        p.id, p.nombre, b.nombre, c.nombre;

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
