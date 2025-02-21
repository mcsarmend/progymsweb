<?php

use Illuminate\Database\Migrations\Migration;

class SpListaPreciosActivos extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $procedure = "DROP PROCEDURE IF EXISTS `lista_precios_activos`;
        CREATE PROCEDURE lista_precios_activos()
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
        coalesce (SUM(pw.existencias),0) AS existencias
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
    LEFT JOIN product_warehouse pw
        ON pw.idproducto = p.id
    GROUP BY
        p.id, p.nombre, b.nombre, c.nombre, precio_publico.price, precio_frecuente.price,precio_mayoreo.price, precio_distribuidor.price;
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
