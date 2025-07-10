<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

class CreateSpReporteexistenciasProcedure extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $procedure = <<<SQL
    CREATE PROCEDURE sp_reporteexistencias(IN sucursal INT)
    BEGIN
         IF sucursal = 0 THEN

        SELECT
            p.id AS codigo,
            p.nombre AS producto,
            b.nombre AS marca,
            c.nombre AS categoria,
            precio_publico.price AS publico,
            precio_frecuente.price AS frecuente,
            precio_mayoreo.price AS mayoreo,
            precio_distribuidor.price AS distribuidor,
            COALESCE(SUM(pw.existencias), 0) AS totales,
            COALESCE(pwap.existencias, 0) AS almacen_principal,
            COALESCE(pwv.existencias, 0) AS viveros,
            COALESCE(pwtw.existencias, 0) AS towncenter,
            COALESCE(pwc.existencias, 0) AS coacalco,
            COALESCE(pwvi.existencias, 0) AS villas,
            COALESCE(pwn.existencias, 0) AS naucalpan
        FROM
            product p
        LEFT JOIN brand b ON p.marca = b.id
        LEFT JOIN category c ON p.categoria = c.id
        LEFT JOIN product_price precio_publico
            ON p.id = precio_publico.idproducto AND precio_publico.idprice = 1
        LEFT JOIN product_price precio_frecuente
            ON p.id = precio_frecuente.idproducto AND precio_frecuente.idprice = 2
        LEFT JOIN product_price precio_mayoreo
            ON p.id = precio_mayoreo.idproducto AND precio_mayoreo.idprice = 3
        LEFT JOIN product_price precio_distribuidor
            ON p.id = precio_distribuidor.idproducto AND precio_distribuidor.idprice = 4
        LEFT JOIN product_warehouse AS pw ON pw.idproducto = p.id
        LEFT JOIN product_warehouse AS pwap ON pwap.idproducto = p.id AND pwap.idwarehouse = 1
        LEFT JOIN product_warehouse AS pwv ON pwv.idproducto = p.id AND pwv.idwarehouse = 2
        LEFT JOIN product_warehouse AS pwtw ON pwtw.idproducto = p.id AND pwtw.idwarehouse = 3
        LEFT JOIN product_warehouse AS pwc ON pwc.idproducto = p.id AND pwc.idwarehouse = 4
        LEFT JOIN product_warehouse AS pwvi ON pwvi.idproducto = p.id AND pwvi.idwarehouse = 6
        LEFT JOIN product_warehouse AS pwn ON pwn.idproducto = p.id AND pwn.idwarehouse = 7
        GROUP BY
            p.id, p.nombre, b.nombre, c.nombre,
            precio_publico.price, precio_frecuente.price, precio_mayoreo.price, precio_distribuidor.price,
            almacen_principal, viveros, towncenter, coacalco, villas, naucalpan
        HAVING totales > 0;
    ELSE
        -- Consulta para un almacén específico
        SELECT
            p.id AS codigo,
            p.nombre AS producto,
            b.nombre AS marca,
            c.nombre AS categoria,
            precio_publico.price AS publico,
            precio_frecuente.price AS frecuente,
            precio_mayoreo.price AS mayoreo,
            precio_distribuidor.price AS distribuidor,
            COALESCE(pw.existencias, 0) AS totales,
            CASE WHEN 1 = sucursal THEN COALESCE(pw.existencias, 0) ELSE 0 END AS almacen_principal,
            CASE WHEN 2 = sucursal THEN COALESCE(pw.existencias, 0) ELSE 0 END AS viveros,
            CASE WHEN 3 = sucursal THEN COALESCE(pw.existencias, 0) ELSE 0 END AS towncenter,
            CASE WHEN 4 = sucursal THEN COALESCE(pw.existencias, 0) ELSE 0 END AS coacalco,
            CASE WHEN 6 = sucursal THEN COALESCE(pw.existencias, 0) ELSE 0 END AS villas,
            CASE WHEN 7 = sucursal THEN COALESCE(pw.existencias, 0) ELSE 0 END AS naucalpan
        FROM
            product p
        LEFT JOIN brand b ON p.marca = b.id
        LEFT JOIN category c ON p.categoria = c.id
        LEFT JOIN product_price precio_publico
            ON p.id = precio_publico.idproducto AND precio_publico.idprice = 1
        LEFT JOIN product_price precio_frecuente
            ON p.id = precio_frecuente.idproducto AND precio_frecuente.idprice = 2
        LEFT JOIN product_price precio_mayoreo
            ON p.id = precio_mayoreo.idproducto AND precio_mayoreo.idprice = 3
        LEFT JOIN product_price precio_distribuidor
            ON p.id = precio_distribuidor.idproducto AND precio_distribuidor.idprice = 4
        LEFT JOIN product_warehouse AS pw ON pw.idproducto = p.id AND pw.idwarehouse = sucursal
        WHERE
            pw.existencias > 0;
    END IF;
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
        Schema::dropIfExists('sp_reporteexistencias_procedure');
    }
}
