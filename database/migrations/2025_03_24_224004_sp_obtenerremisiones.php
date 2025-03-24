<?php

use Illuminate\Database\Migrations\Migration;

class SpObtenerremisiones extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $procedure = "DROP PROCEDURE IF EXISTS obtenerremisiones;  -- Elimina el procedimiento si ya existe

CREATE PROCEDURE obtenerremisiones(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    IN p_iduser INT
)
BEGIN
    SELECT
        r.id,
        r.fecha,
        IFNULL(r.nota, 'SIN NOTA') AS nota,
        r.forma_pago,
        r.cliente,
        r.productos,
        r.total,
        w.nombre AS almacen,
        u.name AS vendedor,
        r.estatus,
        p.nombre AS precio
    FROM referrals r
    LEFT JOIN warehouse w ON r.almacen = w.id
    LEFT JOIN users u ON r.vendedor = u.id
    LEFT JOIN prices p ON p.id = r.tipo_de_precio
    WHERE r.fecha BETWEEN CONCAT(p_fecha_inicio, ' 00:00:00') AND CONCAT(p_fecha_fin, ' 23:59:59')
    AND (u.id = p_iduser OR p_iduser IS NULL);
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
