<?php

use Illuminate\Database\Migrations\Migration;

class SpObtenerVacacionesRestantes extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $procedure = "DROP PROCEDURE IF EXISTS `obtener_vacaciones_restantes`;
CREATE PROCEDURE obtener_vacaciones_restantes()
begin


	    -- Eliminamos la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS vacaciones_calculadas;

    -- Creamos una tabla temporal para calcular los días de vacaciones disponibles
    CREATE TEMPORARY TABLE vacaciones_calculadas AS
    SELECT
        u.id as id_user,
        u.name AS empleado,
        CASE
            WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365*1 AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365*2 THEN 12
            WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365*2 AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365*3 THEN 14
            WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365*3 AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365*4 THEN 16
            WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365*4 AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365*5 THEN 18
            WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365*5 AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365*6 THEN 20
            WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365*6 AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365*10 THEN 22
            WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365*10 AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365*15 THEN 24
            WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365*15 AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365*20 THEN 26
            WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365*20 AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365*25 THEN 28
            WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365*25 AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365*30 THEN 30
            WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365*30 THEN 32
            ELSE 0 -- Si tiene menos de 1 año, no tiene derecho a vacaciones
        END AS vacaciones_totales
    FROM users u;

    -- Unimos con la tabla de vacaciones para contar las usadas y calcular las restantes
    SELECT
        vc.empleado,
        (vc.vacaciones_totales - COALESCE(COUNT(v.id), 0)) AS vacaciones_restantes
    FROM
        vacaciones_calculadas vc
    LEFT JOIN
        vacation v ON vc.id_user = v.id_user
    GROUP BY
        vc.id_user, vc.empleado, vc.vacaciones_totales;

    -- Eliminamos la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS vacaciones_calculadas;


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
