<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class SpMultialmacen extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $procedure = "DROP PROCEDURE IF EXISTS reportecortecaja;  -- Elimina el procedimiento si ya existe

CREATE PROCEDURE laravel.sp_multialmacen()
begin
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
    almacen_principal, viveros, towncenter, coacalco, villas, naucalpan;
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
