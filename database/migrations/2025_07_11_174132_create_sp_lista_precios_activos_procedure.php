<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class CreateSpListaPreciosActivosProcedure extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $procedure = <<<SQL
            DROP PROCEDURE IF EXISTS `lista_precios_activos`;
            CREATE PROCEDURE lista_precios_activos()
            BEGIN
            SELECT
                p.id AS codigo,
                p.nombre AS producto,
                b.nombre AS marca,
                b.id as idmarca,
                c.nombre AS categoria,
                precio_publico.price AS publico,
                precio_frecuente.price AS frecuente,
                precio_mayoreo.price AS mayoreo,
                precio_distribuidor.price AS distribuidor,
                precio_platinum.price AS platinum,
                COALESCE(SUM(pw.existencias), 0) AS totales,
                COALESCE(pwtw.existencias, 0) AS towncenter,
                COALESCE(pwc.existencias, 0) AS coacalco,
                COALESCE(pwn.existencias, 0) AS naucalpan,
                COALESCE(pwb.existencias, 0) AS bodega,
                COALESCE(pwtp.existencias, 0) AS tienda_piso,
                COALESCE(pwp.existencias, 0) AS pedidos,
                COALESCE(pwpm.existencias, 0) AS promotoria

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
                        LEFT JOIN product_price precio_black
                        ON p.id = precio_black.idproducto AND precio_black.idprice = 5
                    LEFT JOIN product_price precio_platinum
                        ON p.id = precio_platinum.idproducto AND precio_platinum.idprice = 6
            LEFT JOIN product_warehouse AS pw ON pw.idproducto = p.id
            LEFT JOIN product_warehouse AS pwtw ON pwtw.idproducto = p.id AND pwtw.idwarehouse = 3
            LEFT JOIN product_warehouse AS pwc ON pwc.idproducto = p.id AND pwc.idwarehouse = 4
            LEFT JOIN product_warehouse AS pwn ON pwn.idproducto = p.id AND pwn.idwarehouse = 7
            LEFT JOIN product_warehouse AS pwb ON pwb.idproducto = p.id AND pwb.idwarehouse = 8
            LEFT JOIN product_warehouse AS pwtp ON pwtp.idproducto = p.id AND pwtp.idwarehouse = 9
            LEFT JOIN product_warehouse AS pwp ON pwp.idproducto = p.id AND pwp.idwarehouse = 10
            LEFT JOIN product_warehouse AS pwpm ON pwpm.idproducto = p.id AND pwpm.idwarehouse = 11
            WHERE p.estatus = 1
            GROUP BY
                p.id, p.nombre, b.nombre, c.nombre,
                precio_publico.price, precio_frecuente.price, precio_mayoreo.price, precio_distribuidor.price, precio_platinum.price,
                towncenter, coacalco, naucalpan, bodega, tienda_piso, pedidos, promotoria order by marca;
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
        Schema::dropIfExists('sp_lista_precios_activos_procedure');
    }
}
