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
begin
	    SELECT
        p.id AS codigo,
        p.nombre AS producto,
        b.nombre AS marca,
        c.nombre AS categoria,
         coalesce (SUM(pw.existencias),0) AS totales,
        coalesce(pwap.existencias,0) AS almacen_principal,
        coalesce(pwv.existencias,0) as viveros,
        coalesce(pwtw.existencias,0) as towncenter,
        coalesce(pwc.existencias,0) as coacalco,
        coalesce(pwvi.existencias,0) as villas,
        coalesce(pwn.existencias,0) as naucalpan
    FROM
        product p
    LEFT JOIN brand b ON p.marca = b.id
    LEFT JOIN category c ON p.categoria = c.id
    LEFT JOIN product_warehouse as pw ON pw.idproducto = p.id
    left join product_warehouse as pwap on pwap.idproducto = p.id and pwap.idwarehouse = 1
    left join product_warehouse as pwv on pwv.idproducto = p.id and pwv.idwarehouse = 2
    left join product_warehouse as pwtw on pwtw.idproducto = p.id and pwtw.idwarehouse = 3
    left join product_warehouse as pwc on pwc.idproducto = p.id and pwc.idwarehouse = 4
    left join product_warehouse as pwvi on pwvi.idproducto = p.id and pwvi.idwarehouse = 6
    left join product_warehouse as pwn on pwn.idproducto = p.id and pwn.idwarehouse = 7
    GROUP BY
        p.id, p.nombre, b.nombre, c.nombre, almacen_principal,viveros,towncenter,coacalco,villas,naucalpan;
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
