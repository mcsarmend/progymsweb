-- Eliminar tablas en orden inverso para evitar problemas de dependencias
DROP TABLE IF EXISTS `account_payment`;

DROP TABLE IF EXISTS `accounts_receivable`;

DROP TABLE IF EXISTS `address`;

DROP TABLE IF EXISTS `attendance`;

DROP TABLE IF EXISTS `product_price`;

DROP TABLE IF EXISTS `product_warehouse`;

DROP TABLE IF EXISTS `product`;

DROP TABLE IF EXISTS `referrals`;

DROP TABLE IF EXISTS `stock_movements`;

DROP TABLE IF EXISTS `task`;

DROP TABLE IF EXISTS `total_accounts_receivable`;

DROP TABLE IF EXISTS `vacation`;

DROP TABLE IF EXISTS `clients`;

DROP TABLE IF EXISTS `seller`;

DROP TABLE IF EXISTS `users`;

DROP TABLE IF EXISTS `warehouse`;

DROP TABLE IF EXISTS `prices`;

DROP TABLE IF EXISTS `category`;

DROP TABLE IF EXISTS `brand`;

DROP TABLE IF EXISTS `failed_jobs`;

DROP TABLE IF EXISTS `jobs`;

DROP TABLE IF EXISTS `cache`;

DROP TABLE IF EXISTS `cache_locks`;

DROP TABLE IF EXISTS `migrations`;

DROP TABLE IF EXISTS `password_reset_tokens`;

DROP TABLE IF EXISTS `sessions`;

DROP TABLE IF EXISTS `supplier`;

-- Tablas básicas sin dependencias
CREATE TABLE `brand` (
    `id` int NOT NULL AUTO_INCREMENT,
    `nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `category` (
    `id` int NOT NULL AUTO_INCREMENT,
    `nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `prices` (
    `id` int NOT NULL AUTO_INCREMENT,
    `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `warehouse` (
    `id` int NOT NULL AUTO_INCREMENT,
    `nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `supplier` (
    `id` int NOT NULL AUTO_INCREMENT,
    `nombre` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `telefono` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `clave` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de usuarios
CREATE TABLE `users` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `email_verified_at` timestamp NULL DEFAULT NULL,
    `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    `updated_at` timestamp NULL DEFAULT NULL,
    `role` int DEFAULT NULL,
    `pass` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `phone` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `warehouse` int DEFAULT NULL,
    `hora_entrada` time DEFAULT NULL,
    `hora_salida` time DEFAULT NULL,
    `fecha_ingreso` date DEFAULT NULL,
    `status` tinyint(1) DEFAULT '1',
    PRIMARY KEY (`id`),
    UNIQUE KEY `users_email_unique` (`email`),
    KEY `users_warehouse_foreign` (`warehouse`),
    CONSTRAINT `users_warehouse_foreign` FOREIGN KEY (`warehouse`) REFERENCES `warehouse` (`id`) ON DELETE
    SET
        NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de vendedores
CREATE TABLE `seller` (
    `id` int NOT NULL AUTO_INCREMENT,
    `nombre` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `sucursal` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `telefono` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de clientes
CREATE TABLE `clients` (
    `id` int NOT NULL AUTO_INCREMENT,
    `nombre` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `sucursal` int DEFAULT NULL,
    `telefono` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `precio` int DEFAULT NULL,
    `ejecutivo` int DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `clients_precio_foreign` (`precio`),
    KEY `clients_ejecutivo_foreign` (`ejecutivo`),
    CONSTRAINT `clients_ejecutivo_foreign` FOREIGN KEY (`ejecutivo`) REFERENCES `users` (`id`) ON DELETE
    SET
        NULL,
        CONSTRAINT `clients_precio_foreign` FOREIGN KEY (`precio`) REFERENCES `prices` (`id`) ON DELETE
    SET
        NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de direcciones
CREATE TABLE `address` (
    `id` int NOT NULL AUTO_INCREMENT,
    `direccion` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `latitud` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `longitud` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `idcliente` int DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `address_idcliente_foreign` (`idcliente`),
    CONSTRAINT `address_idcliente_foreign` FOREIGN KEY (`idcliente`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de productos
CREATE TABLE IF NOT EXISTS `product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marca` int DEFAULT NULL,  -- Cambiado a int para coincidir con brand.id
  `categoria` int DEFAULT NULL,  -- Cambiado a int para coincidir con category.id
  `costo` int DEFAULT NULL,
  `imagenid` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_marca_foreign` (`marca`),
  KEY `product_categoria_foreign` (`categoria`),
  CONSTRAINT `product_categoria_foreign` FOREIGN KEY (`categoria`)
    REFERENCES `category` (`id`) ON DELETE SET NULL,
  CONSTRAINT `product_marca_foreign` FOREIGN KEY (`marca`)
    REFERENCES `brand` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- Tabla de precios de productos
CREATE TABLE `product_price` (
    `idproducto` bigint DEFAULT NULL,
    `idprice` int DEFAULT NULL,
    `price` float(11, 0) DEFAULT NULL,
    KEY `product_price_idproducto_foreign` (`idproducto`),
    KEY `product_price_idprice_foreign` (`idprice`),
    CONSTRAINT `product_price_idprice_foreign` FOREIGN KEY (`idprice`) REFERENCES `prices` (`id`) ON DELETE CASCADE,
    CONSTRAINT `product_price_idproducto_foreign` FOREIGN KEY (`idproducto`) REFERENCES `product` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de inventario
CREATE TABLE `product_warehouse` (
    `idproducto` bigint DEFAULT NULL,
    `idwarehouse` int DEFAULT NULL,
    `existencias` int DEFAULT NULL,
    KEY `product_warehouse_idproducto_foreign` (`idproducto`),
    KEY `product_warehouse_idwarehouse_foreign` (`idwarehouse`),
    CONSTRAINT `product_warehouse_idproducto_foreign` FOREIGN KEY (`idproducto`) REFERENCES `product` (`id`) ON DELETE CASCADE,
    CONSTRAINT `product_warehouse_idwarehouse_foreign` FOREIGN KEY (`idwarehouse`) REFERENCES `warehouse` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de remisiones
CREATE TABLE IF NOT EXISTS `referrals` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `nota` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `forma_pago` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `almacen` int DEFAULT NULL,  -- Cambiado a int para coincidir con warehouse.id
  `vendedor` int DEFAULT NULL,  -- Cambiado a int para coincidir con users.id
  `cliente` int DEFAULT NULL,  -- Cambiado a int para coincidir con clients.id
  `productos` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` int DEFAULT NULL,
  `estatus` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo_de_precio` int DEFAULT NULL,  -- Cambiado a int para coincidir con prices.id
  `isar` tinyint(1) DEFAULT '0',
  `reparto` tinyint(1) DEFAULT '0',
  `vendedor_reparto` int DEFAULT NULL,  -- Cambiado a int para coincidir con users.id
  PRIMARY KEY (`id`),
  KEY `referrals_almacen_foreign` (`almacen`),
  KEY `referrals_vendedor_foreign` (`vendedor`),
  KEY `referrals_cliente_foreign` (`cliente`),
  KEY `referrals_tipo_de_precio_foreign` (`tipo_de_precio`),
  KEY `referrals_vendedor_reparto_foreign` (`vendedor_reparto`),
  CONSTRAINT `referrals_almacen_foreign` FOREIGN KEY (`almacen`)
    REFERENCES `warehouse` (`id`) ON DELETE SET NULL,
  CONSTRAINT `referrals_cliente_foreign` FOREIGN KEY (`cliente`)
    REFERENCES `clients` (`id`) ON DELETE SET NULL,
  CONSTRAINT `referrals_tipo_de_precio_foreign` FOREIGN KEY (`tipo_de_precio`)
    REFERENCES `prices` (`id`) ON DELETE SET NULL,
  CONSTRAINT `referrals_vendedor_foreign` FOREIGN KEY (`vendedor`)
    REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `referrals_vendedor_reparto_foreign` FOREIGN KEY (`vendedor_reparto`)
    REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Tabla de cuentas por cobrar
CREATE TABLE `accounts_receivable` (
    `id` int NOT NULL AUTO_INCREMENT,
    `cliente_id` int NOT NULL,
    `remision_id` int DEFAULT NULL,
    `vendedor_id` int DEFAULT NULL,
    `fecha` date NOT NULL,
    `monto` decimal(12, 2) NOT NULL,
    `saldo_restante` decimal(12, 2) NOT NULL,
    `estado` enum('Pendiente', 'Pagada', 'Cancelada') DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `accounts_receivable_cliente_id_foreign` (`cliente_id`),
    KEY `accounts_receivable_remision_id_foreign` (`remision_id`),
    KEY `accounts_receivable_vendedor_id_foreign` (`vendedor_id`),
    CONSTRAINT `accounts_receivable_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE,
    CONSTRAINT `accounts_receivable_remision_id_foreign` FOREIGN KEY (`remision_id`) REFERENCES `referrals` (`id`) ON DELETE
    SET
        NULL,
        CONSTRAINT `accounts_receivable_vendedor_id_foreign` FOREIGN KEY (`vendedor_id`) REFERENCES `users` (`id`) ON DELETE
    SET
        NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de pagos
CREATE TABLE IF NOT EXISTS `account_payment` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,  -- Cambiado a int para coincidir con clients.id
  `cxc_id` int NOT NULL,      -- Cambiado a int para coincidir con accounts_receivable.id
  `fecha` date NOT NULL,
  `monto` int NOT NULL,
  `metodo_pago` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_payment_cliente_id_foreign` (`cliente_id`),
  KEY `account_payment_cxc_id_foreign` (`cxc_id`),
  CONSTRAINT `account_payment_cliente_id_foreign` FOREIGN KEY (`cliente_id`)
    REFERENCES `clients` (`id`) ON DELETE CASCADE,
  CONSTRAINT `account_payment_cxc_id_foreign` FOREIGN KEY (`cxc_id`)
    REFERENCES `accounts_receivable` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de movimientos de inventario
CREATE TABLE IF NOT EXISTS `stock_movements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `movimiento` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `autor` int DEFAULT NULL,  -- Cambiado de varchar(100) a int para que coincida con users.id
  `productos` varchar(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `documento` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `importe` decimal(10, 0) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_movements_autor_foreign` (`autor`),
  CONSTRAINT `stock_movements_autor_foreign` FOREIGN KEY (`autor`)
    REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de tareas
CREATE TABLE `task` (
    `id` int NOT NULL AUTO_INCREMENT,
    `fechainicio` date DEFAULT NULL,
    `fechafin` date DEFAULT NULL,
    `asunto` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `descripcion` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `autor` int DEFAULT NULL,
    `objetivo` int DEFAULT NULL,
    `fechaaccion` datetime DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `task_autor_foreign` (`autor`),
    KEY `task_objetivo_foreign` (`objetivo`),
    CONSTRAINT `task_autor_foreign` FOREIGN KEY (`autor`) REFERENCES `users` (`id`) ON DELETE
    SET
        NULL,
        CONSTRAINT `task_objetivo_foreign` FOREIGN KEY (`objetivo`) REFERENCES `users` (`id`) ON DELETE
    SET
        NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de total de cuentas por cobrar
CREATE TABLE `total_accounts_receivable` (
    `id` int NOT NULL AUTO_INCREMENT,
    `idcliente` int NOT NULL,
    `total` decimal(10, 2) NOT NULL,
    `fecha_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `idcliente_2` (`idcliente`),
    KEY `idcliente` (`idcliente`),
    CONSTRAINT `total_accounts_receivable_idcliente_foreign` FOREIGN KEY (`idcliente`) REFERENCES `clients` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de asistencias
CREATE TABLE `attendance` (
    `id` int NOT NULL AUTO_INCREMENT,
    `id_user` int DEFAULT NULL,
    `fecha` date DEFAULT NULL,
    `hora` time DEFAULT NULL,
    `dispositivo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `fecha_hora` datetime DEFAULT NULL,
    `evento` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `attendance_id_user_foreign` (`id_user`),
    CONSTRAINT `attendance_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de vacaciones
CREATE TABLE `vacation` (
    `id` int NOT NULL AUTO_INCREMENT,
    `id_user` int DEFAULT NULL,
    `fecha` date DEFAULT NULL,
    `no_vacacion` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `vacation_id_user_foreign` (`id_user`),
    CONSTRAINT `vacation_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tablas del sistema (sin relaciones)
CREATE TABLE `cache` (
    `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
    `expiration` int NOT NULL,
    PRIMARY KEY (`key`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `cache_locks` (
    `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `expiration` int NOT NULL,
    PRIMARY KEY (`key`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `failed_jobs` (
    `id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
    `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
    `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
    `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
    `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `jobs` (
    `id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
    `attempts` tinyint unsigned NOT NULL,
    `reserved_at` int unsigned DEFAULT NULL,
    `available_at` int unsigned NOT NULL,
    `created_at` int unsigned NOT NULL,
    PRIMARY KEY (`id`),
    KEY `jobs_queue_index` (`queue`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `migrations` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `batch` int NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `password_reset_tokens` (
    `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `created_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`email`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE `sessions` (
    `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
    `user_id` bigint unsigned DEFAULT NULL,
    `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `user_agent` text COLLATE utf8mb4_unicode_ci,
    `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
    `last_activity` int NOT NULL,
    PRIMARY KEY (`id`),
    KEY `sessions_user_id_index` (`user_id`),
    KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Aquí irían los stored procedures (los mismos que proporcionaste)
--------------------------- STORED PROCEDURES ---------------------------
DROP PROCEDURE IF EXISTS `lista_precios_activos` ;
CREATE PROCEDURE `lista_precios_activos` ()
begin
SELECT
    p.id AS codigo,
    p.nombre AS producto,
    b.nombre AS marca,
    c.nombre AS categoria,
    coalesce (precio_publico.price, "NO DISPONIBLE") AS publico,
    coalesce (precio_frecuente.price, "NO DISPONIBLE") AS frecuente,
    coalesce (precio_mayoreo.price, "NO DISPONIBLE") AS mayoreo,
    coalesce (precio_distribuidor.price, "NO DISPONIBLE") AS distribuidor,
    coalesce (SUM(pw.existencias), 0) AS existencias
FROM
    product p
    LEFT JOIN brand b ON p.marca = b.id
    LEFT JOIN category c ON p.categoria = c.id
    LEFT JOIN product_price precio_publico ON p.id = precio_publico.idproducto
    AND precio_publico.idprice = 1
    LEFT JOIN product_price precio_frecuente ON p.id = precio_frecuente.idproducto
    AND precio_frecuente.idprice = 2
    LEFT JOIN product_price precio_mayoreo ON p.id = precio_mayoreo.idproducto
    AND precio_mayoreo.idprice = 3
    LEFT JOIN product_price precio_distribuidor ON p.id = precio_distribuidor.idproducto
    AND precio_distribuidor.idprice = 4
    LEFT JOIN product_warehouse pw ON pw.idproducto = p.id
GROUP BY
    p.id,
    p.nombre,
    b.nombre,
    c.nombre,
    precio_publico.price,
    precio_frecuente.price,
    precio_mayoreo.price,
    precio_distribuidor.price;

END;

DROP PROCEDURE IF EXISTS `reportecortecaja` ;
CREATE PROCEDURE `reportecortecaja` (IN `p_fecha_inicio` DATE, IN `p_fecha_fin` DATE)
BEGIN
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

END;

DROP PROCEDURE IF EXISTS `obtener_vacaciones_restantes`;

CREATE PROCEDURE obtener_vacaciones_restantes()
begin -- Eliminamos la tabla temporal
DROP TEMPORARY TABLE IF EXISTS vacaciones_calculadas;

-- Creamos una tabla temporal para calcular los días de vacaciones disponibles
CREATE TEMPORARY TABLE vacaciones_calculadas AS
SELECT
    u.id as id_user,
    u.name AS empleado,
    CASE
        WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365 * 1
        AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365 * 2 THEN 12
        WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365 * 2
        AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365 * 3 THEN 14
        WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365 * 3
        AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365 * 4 THEN 16
        WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365 * 4
        AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365 * 5 THEN 18
        WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365 * 5
        AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365 * 6 THEN 20
        WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365 * 6
        AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365 * 10 THEN 22
        WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365 * 10
        AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365 * 15 THEN 24
        WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365 * 15
        AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365 * 20 THEN 26
        WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365 * 20
        AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365 * 25 THEN 28
        WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365 * 25
        AND DATEDIFF(CURDATE(), u.fecha_ingreso) < 365 * 30 THEN 30
        WHEN DATEDIFF(CURDATE(), u.fecha_ingreso) >= 365 * 30 THEN 32
        ELSE 0 -- Si tiene menos de 1 año, no tiene derecho a vacaciones
    END AS vacaciones_totales
FROM
    users u;

-- Unimos con la tabla de vacaciones para contar las usadas y calcular las restantes
SELECT
    vc.empleado,
    (vc.vacaciones_totales - COALESCE(COUNT(v.id), 0)) AS vacaciones_restantes
FROM
    vacaciones_calculadas vc
    LEFT JOIN vacation v ON vc.id_user = v.id_user
GROUP BY
    vc.id_user,
    vc.empleado,
    vc.vacaciones_totales;

-- Eliminamos la tabla temporal
DROP TEMPORARY TABLE IF EXISTS vacaciones_calculadas;

END;

DROP PROCEDURE IF EXISTS `sp_asistencias_y_ausencias_rep`;

CREATE PROCEDURE sp_asistencias_y_ausencias_rep() begin
SELECT
    fecha,
    users.name AS vendedor,
    MIN(
        CASE
            WHEN evento = 'ENTRANCE' THEN CAST(hora AS TIME)
        END
    ) AS hora_entrada,
    MAX(
        CASE
            WHEN evento = 'EXIT' THEN CAST(hora AS TIME)
        END
    ) AS hora_salida,
    SUM(
        CASE
            WHEN evento = 'ENTRANCE'
            AND CAST(hora AS TIME) > DATE_ADD(users.hora_entrada, INTERVAL 15 MINUTE) THEN 1
            ELSE 0
        END
    ) AS incidencia
FROM
    attendance
    LEFT JOIN users ON users.id = attendance.id_user
WHERE
    YEAR(fecha) = YEAR(CURRENT_DATE)
    AND MONTH(fecha) = MONTH(CURRENT_DATE)
GROUP BY
    fecha,
    users.name
ORDER BY
    fecha;

END;

DROP PROCEDURE IF EXISTS `sp_asistencias_y_ausencias_rep_general`;

CREATE PROCEDURE sp_asistencias_y_ausencias_rep_general(IN fecha_inicio DATE, IN fecha_fin DATE) begin
SELECT
    fecha,
    users.name AS vendedor,
    MIN(
        CASE
            WHEN evento = 'ENTRANCE' THEN CAST(hora AS TIME)
        END
    ) AS hora_entrada,
    MAX(
        CASE
            WHEN evento = 'EXIT' THEN CAST(hora AS TIME)
        END
    ) AS hora_salida,
    SUM(
        CASE
            WHEN evento = 'ENTRANCE'
            AND CAST(hora AS TIME) > DATE_ADD(users.hora_entrada, INTERVAL 15 MINUTE) THEN 1
            ELSE 0
        END
    ) AS incidencia
FROM
    attendance
    LEFT JOIN users ON users.id = attendance.id_user
WHERE
    fecha BETWEEN fecha_inicio
    AND fecha_fin
GROUP BY
    FECHA,
    users.name
ORDER BY
    FECHA,
    users.name;

END;

DROP PROCEDURE IF EXISTS `sp_asistencias_y_ausencias_rep_individual`;

CREATE PROCEDURE sp_asistencias_y_ausencias_rep_individual(
    IN fecha_inicio DATE,
    IN fecha_fin DATE,
    in id_user int
) begin
SELECT
    fecha,
    users.name AS vendedor,
    MIN(
        CASE
            WHEN evento = 'ENTRANCE' THEN CAST(hora AS TIME)
        END
    ) AS hora_entrada,
    MAX(
        CASE
            WHEN evento = 'EXIT' THEN CAST(hora AS TIME)
        END
    ) AS hora_salida,
    SUM(
        CASE
            WHEN evento = 'ENTRANCE'
            AND CAST(hora AS TIME) > DATE_ADD(users.hora_entrada, INTERVAL 15 MINUTE) THEN 1
            ELSE 0
        END
    ) AS incidencia
FROM
    attendance
    LEFT JOIN users ON users.id = attendance.id_user
WHERE
    fecha BETWEEN fecha_inicio
    AND fecha_fin
    and users.id = id_user
GROUP BY
    FECHA
ORDER BY
    FECHA;

END;

DROP PROCEDURE IF EXISTS `sp_get_asistencias_y_ausencias`;

CREATE PROCEDURE sp_get_asistencias_y_ausencias() begin
SELECT
    fecha,
    users.name as vendedor,
    SUM(
        CASE
            WHEN EVENTO = 'ENTRANCE' THEN 1
            ELSE 0
        END
    ) AS entrada,
    SUM(
        CASE
            WHEN EVENTO = 'EXIT' THEN 1
            ELSE 0
        END
    ) AS salida,
    SUM(
        CASE
            WHEN evento = 'ENTRANCE'
            AND CAST(fecha_hora AS TIME) > DATE_ADD(users.hora_entrada, INTERVAL 15 MINUTE) THEN 1
            ELSE 0
        END
    ) AS incidencia
FROM
    attendance
    LEFT JOIN users ON users.id = attendance.id_user
WHERE
    YEAR(FECHA) = YEAR(CURRENT_DATE)
    AND MONTH(FECHA) = MONTH(CURRENT_DATE)
GROUP BY
    FECHA
ORDER BY
    FECHA;

END;

DROP PROCEDURE IF EXISTS `sp_get_asistencias_y_ausencias_general`;

CREATE PROCEDURE sp_get_asistencias_y_ausencias_general(IN fecha_inicio DATE, IN fecha_fin DATE) begin
SELECT
    fecha,
    SUM(
        CASE
            WHEN EVENTO = 'ENTRANCE' THEN 1
            ELSE 0
        END
    ) AS entrada,
    SUM(
        CASE
            WHEN EVENTO = 'EXIT' THEN 1
            ELSE 0
        END
    ) AS salida,
    SUM(
        CASE
            WHEN evento = 'ENTRANCE'
            AND CAST(fecha_hora AS TIME) > DATE_ADD(users.hora_entrada, INTERVAL 15 MINUTE) THEN 1
            ELSE 0
        END
    ) AS incidencia
FROM
    attendance
    LEFT JOIN users ON users.id = attendance.id_user
WHERE
    fecha BETWEEN fecha_inicio
    AND fecha_fin
GROUP BY
    FECHA
ORDER BY
    FECHA;

END;

DROP PROCEDURE IF EXISTS `sp_get_asistencias_y_ausencias_por_semana`;

CREATE PROCEDURE sp_get_asistencias_y_ausencias_individual(
    IN id_user INT,
    IN fecha_inicio DATE,
    IN fecha_fin DATE
) begin
SELECT
    fecha,
    SUM(
        CASE
            WHEN evento = 'ENTRANCE' THEN 1
            ELSE 0
        END
    ) AS entrada,
    SUM(
        CASE
            WHEN evento = 'EXIT' THEN 1
            ELSE 0
        END
    ) AS salida,
    SUM(
        CASE
            WHEN evento = 'ENTRANCE'
            AND CAST(fecha_hora AS TIME) > DATE_ADD(users.hora_entrada, INTERVAL 15 MINUTE) THEN 1
            ELSE 0
        END
    ) AS incidencia,
    MAX(
        CASE
            WHEN evento = 'ENTRANCE' THEN CAST(fecha_hora AS TIME)
        END
    ) AS hora_entrada,
    MAX(
        CASE
            WHEN evento = 'EXIT' THEN CAST(fecha_hora AS TIME)
        END
    ) AS hora_salida
FROM
    attendance
    LEFT JOIN users ON users.id = attendance.id_user
WHERE
    fecha BETWEEN fecha_inicio
    AND fecha_fin
    AND (
        id_user IS NULL
        OR attendance.id_user = id_user
    )
GROUP BY
    fecha
ORDER BY
    fecha;

END;

DROP PROCEDURE IF EXISTS `sp_get_asistencias_y_ausencias_por_semana`;

CREATE PROCEDURE sp_get_asistencias_y_ausencias_por_semana() begin
SELECT
    WEEK(fecha, 3) AS semana,
    -- Agrupa por semana usando el modo 3 (ISO semanales)
    SUM(
        CASE
            WHEN evento = 'ENTRANCE' THEN 1
            ELSE 0
        END
    ) AS entrada,
    SUM(
        CASE
            WHEN evento = 'EXIT' THEN 1
            ELSE 0
        END
    ) AS salida,
    SUM(
        CASE
            WHEN evento = 'ENTRANCE'
            AND CAST(fecha_hora AS TIME) > DATE_ADD(users.hora_entrada, INTERVAL 15 MINUTE) THEN 1
            ELSE 0
        END
    ) AS incidencia
FROM
    attendance
    LEFT JOIN users ON users.id = attendance.id_user
WHERE
    YEAR(fecha) = YEAR(CURRENT_DATE)
    AND MONTH(fecha) = MONTH(CURRENT_DATE) -- Filtrar por mes en curso
GROUP BY
    WEEK(fecha, 3) -- Agrupar por semana
ORDER BY
    semana;

END;

DROP PROCEDURE IF EXISTS `sp_get_asistencias_y_ausencias_por_semana_general`;

CREATE PROCEDURE sp_get_asistencias_y_ausencias_por_semana_general(IN fecha_inicio DATE, IN fecha_fin DATE) begin
SELECT
    WEEK(fecha, 3) AS semana,
    -- Agrupa por semana usando el modo 3 (ISO semanales)
    SUM(
        CASE
            WHEN evento = 'ENTRANCE' THEN 1
            ELSE 0
        END
    ) AS entrada,
    SUM(
        CASE
            WHEN evento = 'EXIT' THEN 1
            ELSE 0
        END
    ) AS salida,
    SUM(
        CASE
            WHEN evento = 'ENTRANCE'
            AND CAST(fecha_hora AS TIME) > DATE_ADD(users.hora_entrada, INTERVAL 15 MINUTE) THEN 1
            ELSE 0
        END
    ) AS incidencia
FROM
    attendance
    LEFT JOIN users ON users.id = attendance.id_user
WHERE
    fecha BETWEEN fecha_inicio
    AND fecha_fin -- Filtrar por el rango de fechas
GROUP BY
    WEEK(fecha, 3) -- Agrupar por semana
ORDER BY
    semana;

END;

DROP PROCEDURE IF EXISTS `sp_get_asistencias_y_ausencias_por_semana_individual`;

CREATE PROCEDURE sp_get_asistencias_y_ausencias_por_semana_individual(
    IN id_user INT,
    IN fecha_inicio DATE,
    IN fecha_fin DATE
) begin
SELECT
    WEEK(fecha, 3) AS semana,
    -- Agrupa por semana usando el modo 3 (ISO semanales)
    SUM(
        CASE
            WHEN evento = 'ENTRANCE' THEN 1
            ELSE 0
        END
    ) AS entrada,
    SUM(
        CASE
            WHEN evento = 'EXIT' THEN 1
            ELSE 0
        END
    ) AS salida,
    SUM(
        CASE
            WHEN evento = 'ENTRANCE'
            AND CAST(fecha_hora AS TIME) > DATE_ADD(users.hora_entrada, INTERVAL 15 MINUTE) THEN 1
            ELSE 0
        END
    ) AS incidencia
FROM
    attendance
    LEFT JOIN users ON users.id = attendance.id_user
WHERE
    fecha BETWEEN fecha_inicio
    AND fecha_fin -- Filtrar por el rango de fechas
    AND (
        id_user IS NULL
        OR attendance.id_user = id_user
    ) -- Filtrar por usuario si no es NULL
GROUP BY
    WEEK(fecha, 3) -- Agrupar por semana
ORDER BY
    semana;

END;

DROP PROCEDURE IF EXISTS `sp_get_incidencias_individual`;

CREATE PROCEDURE sp_get_incidencias_individual(
    IN id_user INT,
    IN fecha_inicio DATE,
    IN fecha_fin DATE
) begin
SELECT
    SUM(incidencia) AS total_incidencias
FROM
    (
        SELECT
            SUM(
                CASE
                    WHEN evento = 'ENTRANCE'
                    AND CAST(fecha_hora AS TIME) > DATE_ADD(users.hora_entrada, INTERVAL 15 MINUTE) THEN 1
                    ELSE 0
                END
            ) AS incidencia
        FROM
            attendance
            LEFT JOIN users ON users.id = attendance.id_user
        WHERE
            fecha BETWEEN fecha_inicio
            AND fecha_fin
            AND (
                id_user IS NULL
                OR attendance.id_user = id_user
            )
        GROUP BY
            fecha
    ) AS subquery;

END;

DROP PROCEDURE IF EXISTS `sp_incidencias_por_mes`;

CREATE PROCEDURE laravel.sp_incidencias_por_mes(IN mes int, IN anio int) begin
SELECT
    users.name AS nombre,
    incidents.*
FROM
    incidents
    JOIN users ON incidents.iduser = users.id
WHERE
    MONTH(incidents.fecha) = mes
    AND YEAR(incidents.fecha) = anio
ORDER BY
    incidents.iduser;

END;

DROP PROCEDURE IF EXISTS `sp_vacaciones_ultimo_ano`;

CREATE PROCEDURE sp_vacaciones_ultimo_ano(IN iduser INT, fecha_inicio_ultimo_ano DATE) begin
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

END;

DROP PROCEDURE IF EXISTS obtenerremisiones;

-- Elimina el procedimiento si ya existe
CREATE PROCEDURE `obtenerremisiones` (
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    IN p_iduser INT
) BEGIN
SELECT
    r.id,
    r.fecha,
    IFNULL(r.nota, 'SIN NOTA') AS nota,
    r.forma_pago,
    c.nombre as cliente,
    r.productos,
    r.total,
    w.nombre AS almacen,
    u.name AS vendedor,
    r.estatus,
    p.nombre AS precio,
    CASE
        WHEN r.reparto = 1 THEN 'Sí'
        WHEN r.reparto = 0 THEN 'No'
        ELSE 'No definido'
    END AS reparto,
    COALESCE(us.name, 'No asignado') AS vendedor_reparto
FROM
    referrals r
    LEFT JOIN warehouse w ON r.almacen = w.id
    LEFT JOIN users u ON r.vendedor = u.id
    LEFT JOIN prices p ON p.id = r.tipo_de_precio
    LEFT JOIN users us ON us.id = r.vendedor_reparto
    left join clients as c on c.id = r.cliente
WHERE
    r.fecha BETWEEN CONCAT(p_fecha_inicio, ' 00:00:00')
    AND CONCAT(p_fecha_fin, ' 23:59:59')
    AND (
        p_iduser IS NULL
        OR u.id = p_iduser
    );

END;

----------------------------- INSERTAR DATOS EN LAS TABLAS -----------------------------


INSERT INTO `warehouse` VALUES (1,'Almacén Principal'),(2,'Viveros'),(3,'Towncenter Nicolas Romero'),(4,'Coacalco'),(5,'Queretaro'),(6,'Villas de la Hacienda'),(7,'Naucalpan');
INSERT INTO `users` VALUES (25,'OSCAR GARCIA','oscar.garcia@progyms.com',NULL,'$2y$10$Xe/SKzBpHTlJTXe8BHmEIecBUiiTYpsZSN7uPLfh7uOZoWvUePS.a',NULL,'2024-09-07 05:18:00','2024-09-07 05:18:00',1,'y!rXZ5ZV','5544604588',2,'09:00:00','18:00:00','2024-01-01',1),(26,'LIZBETH VARGAS','lizbeth.vargas@progyms.com',NULL,'$2y$10$S0THp3iJADYvkUaAY/ehOOjMV9MMg.Gh84zYIwLtVsb2baOzqF2jS',NULL,'2024-09-07 05:18:42','2024-09-07 05:18:42',2,'jg&k4ZzU','5584542783',2,'09:00:00','18:00:00','2024-01-01',1),(27,'JUAN REYES','juan.reyes@progyms.com',NULL,'$2y$10$m3JEAbNtfc98XRVaBTEt.O2qmagV8hs08s5HheXeQ0Av4OmgcziIG',NULL,'2024-09-07 05:19:10','2025-01-13 21:37:26',3,'lzxPbxX3','5537490177',2,'09:00:00','18:00:00','2022-02-22',1),(28,'MONTSERRAT GARCIA','montserrat.garcia@progyms.com',NULL,'$2y$10$NIPjgwjq1FSaFVJkLbApq.F43SikfJBrAT1oFIiY0BjuUtl8EBfvy',NULL,'2024-09-07 05:19:35','2025-01-29 22:28:40',3,'lachica22','5581353400',2,'09:00:00','18:00:00','2022-03-22',1),(29,'MONICA NAVARRETE','monica.navarrete@progyms.com',NULL,'$2y$10$0mKY/TPmdHhQKRIG6QViWeSarmO/2H33BSibxu5NSXmOkAxCZAvBO',NULL,'2024-09-07 05:20:06','2024-09-07 05:20:06',4,'XLU&Ch3Q','5521963915',7,'09:00:00','18:00:00','2023-10-05',1),(30,'KALID MILLA','kalid.milla@progyms.com',NULL,'$2y$10$CzQYucyc38zD8pvoJEdkGefmuDHUFagrAMREl//RjZbi5VBKiwzTG',NULL,'2024-09-07 05:20:42','2024-09-07 05:20:42',4,'l6YbYHmT','5610628453',6,'09:00:00','19:00:00','2024-08-28',1),(31,'KEVIN NAVARRETE','kevin.navarrete@progyms.com',NULL,'$2y$10$8hOS16Q7UBTJyK46/R3EaOiyzNs9btRP.bpcMSyl.MiocP9MlRcOi',NULL,'2024-09-07 05:21:08','2024-09-07 05:21:08',4,'XtRb%Vd1','5564739411',7,'14:01:00','19:00:00','2024-02-10',0),(32,'YOLANDA SOTO','yolanda.soto@progyms.com',NULL,'$2y$10$NMaUozkZXy0ILzcIcLmdXuNVSugpD2da7RyDmUnfYpEutIeXKarCO',NULL,'2024-09-07 05:21:35','2024-09-07 05:21:35',4,'L&dNu#Zt','5531216226',4,'11:00:00','19:00:00','2021-08-01',1),(33,'MIRIAM ORTIZ','miriam.sanchez@progyms.com',NULL,'$2y$10$MTsyVc.FG5XLFUoOr6g1weV4ubOrNgJjmsO7TKkYMBx6H4bQLSkhC',NULL,'2024-09-07 05:21:55','2024-09-07 05:21:55',4,'b4Cmko&*','5626001825',4,'10:00:00','19:00:00','2024-01-01',1),(34,'CLEMENTE ZARRAGA','clemente.zarraga@progyms.com',NULL,'$2y$10$A5xO1jr7szt1YLHEloBzoeJbx5Ovtb456I2mumS3H3uaL7l8jT9qa',NULL,'2024-09-07 05:22:24','2025-01-11 00:19:54',1,'Sg&)xagP','5533668907',2,'09:00:00','18:00:00','2024-08-25',1),(36,'LEONARDO GARCIA','leonardo.garcia@progyms.com',NULL,'$2y$10$Qe3QwTBXBWZpgXPtudLPGOMTJbwgdt8xrqtl.Y6dlTAmdm3BI3zVK',NULL,'2024-09-07 05:23:58','2024-09-07 05:23:58',4,'@1ykPWSo','5576869984',2,'09:00:00','18:00:00','2024-01-01',1),(37,'EDILBERTO SANCHEZ','ediberto.sanchez@progyms.com',NULL,'$2y$10$XRYuUlDqeo5s9E4KrvDm.eNpnAt8siFMb/M.E9Us5O1tWY/Czo6aq',NULL,'2024-09-07 05:24:54','2024-09-07 05:24:54',4,')NmDpAB)','5518198468',3,'11:00:00','20:00:00','2024-08-25',0),(38,'ANGEL BAZAN','ANGEL.BAZAN@PROGYMS.COM',NULL,'$2y$10$Eln4wDS1hbHZADCGwOyy9uglsb6swtmHPSbi5gV19vJ01qBdoyTLy',NULL,'2024-09-23 20:58:51','2024-09-23 20:58:51',4,'23ut$(9n',NULL,2,'09:00:00','18:00:00','2024-09-23',1),(39,'SANDRA MIRELLA ALONSO GARCIA','sandra.alonso@progyms.com',NULL,'$2y$10$f4pcJ6pKBug1nEU6YHh0U.XGsYKyLvIlvmd6xYX.rPf4lHWm1NyD6',NULL,'2025-01-30 01:35:51','2025-01-30 01:35:51',4,'U0&js*4b',NULL,3,'11:00:00','20:00:00','2025-02-03',1),(40,'JOSE DE JESUS PASCACIO REYES','jose.pascacio@progyms.com',NULL,'$2y$10$xrEuMIKwMamvslzRZLC3MO2ngWT75w2IJdpXn3LZrGiM5nIi9iV9i',NULL,'2025-02-12 23:09:48','2025-02-12 23:09:48',1,'zKIO5&b5',NULL,1,'11:00:00','20:00:00','2025-02-16',1),(41,'KEVIN JONATHAN LOPEZ PALOMINO','kevin.lopez@progyms.com',NULL,'$2y$10$SKM3xUV.hwqxl8LgDzs/d.Q4S8GxxqfmXWvQIVBTq2Yc9rR1paca.',NULL,'2025-03-13 02:43:28','2025-03-13 02:43:28',4,'PU*zyeDd',NULL,3,'11:00:00','20:00:00',NULL,1);




INSERT INTO
    `attendance`
VALUES
    (
        12,
        10,
        '2024-07-31',
        '17:12:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-07-31 17:12:04',
        'ENTRANCE'
    ),
(
        13,
        10,
        '2024-07-31',
        '17:13:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-07-31 17:13:14',
        'EXIT'
    ),
(
        14,
        2,
        '2024-08-13',
        '10:08:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-08-13 10:08:10',
        'ENTRANCE'
    ),
(
        15,
        34,
        '2024-09-11',
        '09:02:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-11 09:02:12',
        'ENTRANCE'
    ),
(
        16,
        27,
        '2024-09-11',
        '09:04:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-11 09:04:42',
        'ENTRANCE'
    ),
(
        17,
        28,
        '2024-09-11',
        '08:55:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-11 08:55:06',
        'ENTRANCE'
    ),
(
        18,
        36,
        '2024-09-11',
        '08:59:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-11 08:59:41',
        'ENTRANCE'
    ),
(
        19,
        32,
        '2024-09-11',
        '10:58:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-11 10:58:00',
        'ENTRANCE'
    ),
(
        20,
        27,
        '2024-09-11',
        '18:01:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-11 18:01:36',
        'EXIT'
    ),
(
        21,
        34,
        '2024-09-11',
        '18:07:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-11 18:07:11',
        'EXIT'
    ),
(
        22,
        36,
        '2024-09-11',
        '18:07:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-11 18:07:41',
        'EXIT'
    ),
(
        23,
        28,
        '2024-09-11',
        '18:09:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-11 18:09:42',
        'EXIT'
    ),
(
        24,
        32,
        '2024-09-11',
        '19:00:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-11 19:00:20',
        'EXIT'
    ),
(
        25,
        28,
        '2024-09-12',
        '08:54:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-12 08:54:28',
        'ENTRANCE'
    ),
(
        26,
        34,
        '2024-09-12',
        '08:58:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-12 08:58:03',
        'ENTRANCE'
    ),
(
        27,
        27,
        '2024-09-12',
        '09:04:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-12 09:04:42',
        'ENTRANCE'
    ),
(
        28,
        35,
        '2024-09-12',
        '09:05:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-12 09:05:02',
        'ENTRANCE'
    ),
(
        29,
        32,
        '2024-09-12',
        '11:11:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-12 11:11:03',
        'ENTRANCE'
    ),
(
        30,
        27,
        '2024-09-12',
        '18:00:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-12 18:00:41',
        'EXIT'
    ),
(
        31,
        35,
        '2024-09-12',
        '18:04:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-12 18:04:04',
        'EXIT'
    ),
(
        32,
        34,
        '2024-09-12',
        '18:04:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-12 18:04:41',
        'EXIT'
    ),
(
        33,
        28,
        '2024-09-12',
        '18:08:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-12 18:08:10',
        'EXIT'
    ),
(
        34,
        32,
        '2024-09-12',
        '19:00:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-12 19:00:55',
        'EXIT'
    ),
(
        35,
        27,
        '2024-09-13',
        '09:09:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-13 09:09:54',
        'ENTRANCE'
    ),
(
        36,
        34,
        '2024-09-13',
        '09:11:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-13 09:11:05',
        'ENTRANCE'
    ),
(
        37,
        28,
        '2024-09-13',
        '09:02:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-13 09:02:42',
        'ENTRANCE'
    ),
(
        38,
        32,
        '2024-09-13',
        '11:13:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-13 11:13:08',
        'ENTRANCE'
    ),
(
        39,
        36,
        '2024-09-13',
        '11:14:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-13 11:14:20',
        'ENTRANCE'
    ),
(
        40,
        32,
        '2024-09-13',
        '19:00:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-13 19:00:46',
        'EXIT'
    ),
(
        41,
        35,
        '2024-09-14',
        '08:59:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-14 08:59:22',
        'ENTRANCE'
    ),
(
        42,
        28,
        '2024-09-14',
        '09:01:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-14 09:01:56',
        'ENTRANCE'
    ),
(
        43,
        27,
        '2024-09-14',
        '09:13:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-14 09:13:25',
        'ENTRANCE'
    ),
(
        44,
        36,
        '2024-09-14',
        '09:40:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-14 09:40:58',
        'ENTRANCE'
    ),
(
        45,
        32,
        '2024-09-14',
        '11:14:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-14 11:14:32',
        'ENTRANCE'
    ),
(
        46,
        35,
        '2024-09-14',
        '15:08:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-14 15:08:07',
        'EXIT'
    ),
(
        47,
        36,
        '2024-09-14',
        '15:08:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-14 15:08:43',
        'EXIT'
    ),
(
        48,
        28,
        '2024-09-14',
        '15:15:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-14 15:15:56',
        'EXIT'
    ),
(
        49,
        32,
        '2024-09-14',
        '18:55:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-14 18:55:37',
        'EXIT'
    ),
(
        50,
        34,
        '2024-09-17',
        '09:03:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-17 09:03:00',
        'ENTRANCE'
    ),
(
        51,
        35,
        '2024-09-17',
        '09:09:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-17 09:09:45',
        'ENTRANCE'
    ),
(
        52,
        27,
        '2024-09-17',
        '09:23:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-17 09:23:43',
        'ENTRANCE'
    ),
(
        53,
        28,
        '2024-09-17',
        '09:39:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-17 09:39:28',
        'ENTRANCE'
    ),
(
        54,
        36,
        '2024-09-17',
        '09:51:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-17 09:51:33',
        'ENTRANCE'
    ),
(
        55,
        34,
        '2024-09-17',
        '18:11:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-17 18:11:28',
        'EXIT'
    ),
(
        56,
        35,
        '2024-09-17',
        '18:11:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-17 18:11:53',
        'EXIT'
    ),
(
        57,
        34,
        '2024-09-18',
        '08:48:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-18 08:48:50',
        'ENTRANCE'
    ),
(
        58,
        35,
        '2024-09-18',
        '09:03:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-18 09:03:13',
        'ENTRANCE'
    ),
(
        59,
        27,
        '2024-09-18',
        '09:06:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-18 09:06:29',
        'ENTRANCE'
    ),
(
        60,
        35,
        '2024-09-18',
        '19:01:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-18 19:01:35',
        'EXIT'
    ),
(
        61,
        35,
        '2024-09-19',
        '09:01:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-19 09:01:22',
        'ENTRANCE'
    ),
(
        62,
        34,
        '2024-09-19',
        '09:07:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-19 09:07:54',
        'ENTRANCE'
    ),
(
        63,
        28,
        '2024-09-19',
        '09:12:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-19 09:12:23',
        'ENTRANCE'
    ),
(
        64,
        29,
        '2024-09-19',
        '10:34:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-19 10:34:19',
        'ENTRANCE'
    ),
(
        65,
        29,
        '2024-09-19',
        '18:00:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-19 18:00:25',
        'EXIT'
    ),
(
        66,
        36,
        '2024-09-20',
        '09:04:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-20 09:04:21',
        'ENTRANCE'
    ),
(
        67,
        34,
        '2024-09-20',
        '09:05:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-20 09:05:49',
        'ENTRANCE'
    ),
(
        68,
        28,
        '2024-09-20',
        '09:06:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-20 09:06:31',
        'ENTRANCE'
    ),
(
        69,
        27,
        '2024-09-20',
        '09:11:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-20 09:11:47',
        'ENTRANCE'
    ),
(
        70,
        31,
        '2024-09-20',
        '12:09:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-20 12:09:17',
        'ENTRANCE'
    ),
(
        71,
        31,
        '2024-09-20',
        '18:57:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-20 18:57:16',
        'EXIT'
    ),
(
        72,
        27,
        '2024-09-21',
        '09:07:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-21 09:07:45',
        'ENTRANCE'
    ),
(
        73,
        35,
        '2024-09-21',
        '09:13:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-21 09:13:06',
        'ENTRANCE'
    ),
(
        74,
        28,
        '2024-09-21',
        '09:21:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-21 09:21:04',
        'ENTRANCE'
    ),
(
        75,
        29,
        '2024-09-21',
        '10:05:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-21 10:05:16',
        'ENTRANCE'
    ),
(
        76,
        31,
        '2024-09-21',
        '14:10:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-21 14:10:32',
        'ENTRANCE'
    ),
(
        77,
        31,
        '2024-09-21',
        '18:50:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-21 18:50:02',
        'EXIT'
    ),
(
        78,
        29,
        '2024-09-21',
        '18:50:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-21 18:50:52',
        'EXIT'
    ),
(
        79,
        29,
        '2024-09-22',
        '10:14:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-22 10:14:06',
        'ENTRANCE'
    ),
(
        80,
        31,
        '2024-09-22',
        '14:09:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-22 14:09:51',
        'ENTRANCE'
    ),
(
        81,
        31,
        '2024-09-22',
        '18:51:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-22 18:51:37',
        'EXIT'
    ),
(
        82,
        29,
        '2024-09-22',
        '18:52:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-22 18:52:12',
        'EXIT'
    ),
(
        83,
        34,
        '2024-09-23',
        '08:49:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-23 08:49:43',
        'ENTRANCE'
    ),
(
        84,
        28,
        '2024-09-23',
        '08:57:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-23 08:57:18',
        'ENTRANCE'
    ),
(
        85,
        38,
        '2024-09-23',
        '09:07:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-23 09:07:32',
        'ENTRANCE'
    ),
(
        86,
        27,
        '2024-09-23',
        '09:08:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-23 09:08:31',
        'ENTRANCE'
    ),
(
        87,
        29,
        '2024-09-23',
        '10:07:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-23 10:07:20',
        'ENTRANCE'
    ),
(
        88,
        32,
        '2024-09-23',
        '11:19:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-23 11:19:08',
        'ENTRANCE'
    ),
(
        89,
        36,
        '2024-09-23',
        '11:34:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-23 11:34:51',
        'ENTRANCE'
    ),
(
        90,
        31,
        '2024-09-23',
        '14:09:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-23 14:09:55',
        'ENTRANCE'
    ),
(
        91,
        36,
        '2024-09-23',
        '16:59:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-23 16:59:46',
        'EXIT'
    ),
(
        92,
        27,
        '2024-09-23',
        '18:04:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-23 18:04:17',
        'EXIT'
    ),
(
        93,
        35,
        '2024-09-23',
        '18:06:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-23 18:06:54',
        'EXIT'
    ),
(
        94,
        38,
        '2024-09-23',
        '18:09:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-23 18:09:00',
        'EXIT'
    ),
(
        95,
        28,
        '2024-09-23',
        '18:10:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-23 18:10:40',
        'EXIT'
    ),
(
        96,
        31,
        '2024-09-23',
        '18:58:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-23 18:58:43',
        'EXIT'
    ),
(
        97,
        29,
        '2024-09-23',
        '18:59:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-23 18:59:03',
        'EXIT'
    ),
(
        98,
        32,
        '2024-09-23',
        '19:00:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-23 19:00:56',
        'EXIT'
    ),
(
        99,
        38,
        '2024-09-24',
        '08:50:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-24 08:50:14',
        'ENTRANCE'
    ),
(
        100,
        36,
        '2024-09-24',
        '09:00:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-24 09:00:53',
        'ENTRANCE'
    ),
(
        101,
        28,
        '2024-09-24',
        '09:01:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-24 09:01:17',
        'ENTRANCE'
    ),
(
        102,
        34,
        '2024-09-24',
        '09:09:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-24 09:09:51',
        'ENTRANCE'
    ),
(
        103,
        35,
        '2024-09-24',
        '09:10:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-24 09:10:33',
        'ENTRANCE'
    ),
(
        104,
        27,
        '2024-09-24',
        '09:25:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-24 09:25:34',
        'ENTRANCE'
    ),
(
        105,
        29,
        '2024-09-24',
        '10:47:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-24 10:47:11',
        'ENTRANCE'
    ),
(
        106,
        32,
        '2024-09-24',
        '11:08:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-24 11:08:26',
        'ENTRANCE'
    ),
(
        107,
        31,
        '2024-09-24',
        '14:10:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-24 14:10:50',
        'ENTRANCE'
    ),
(
        108,
        38,
        '2024-09-24',
        '18:15:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-24 18:15:47',
        'EXIT'
    ),
(
        109,
        35,
        '2024-09-24',
        '18:18:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-24 18:18:17',
        'EXIT'
    ),
(
        110,
        31,
        '2024-09-24',
        '18:51:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-24 18:51:41',
        'EXIT'
    ),
(
        111,
        29,
        '2024-09-24',
        '18:51:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-24 18:51:59',
        'EXIT'
    ),
(
        112,
        32,
        '2024-09-24',
        '18:59:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-24 18:59:39',
        'EXIT'
    ),
(
        113,
        34,
        '2024-09-25',
        '08:47:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-25 08:47:42',
        'ENTRANCE'
    ),
(
        114,
        38,
        '2024-09-25',
        '08:48:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-25 08:48:22',
        'ENTRANCE'
    ),
(
        115,
        28,
        '2024-09-25',
        '08:58:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-25 08:58:46',
        'ENTRANCE'
    ),
(
        116,
        27,
        '2024-09-25',
        '09:07:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-25 09:07:39',
        'ENTRANCE'
    ),
(
        117,
        29,
        '2024-09-25',
        '10:10:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-25 10:10:10',
        'ENTRANCE'
    ),
(
        118,
        32,
        '2024-09-25',
        '11:13:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-25 11:13:16',
        'ENTRANCE'
    ),
(
        119,
        31,
        '2024-09-25',
        '14:12:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-25 14:12:29',
        'ENTRANCE'
    ),
(
        120,
        38,
        '2024-09-25',
        '18:08:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-25 18:08:57',
        'EXIT'
    ),
(
        121,
        36,
        '2024-09-25',
        '18:09:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-25 18:09:30',
        'EXIT'
    ),
(
        122,
        29,
        '2024-09-25',
        '18:51:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-25 18:51:03',
        'EXIT'
    ),
(
        123,
        32,
        '2024-09-25',
        '18:58:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-25 18:58:54',
        'EXIT'
    ),
(
        124,
        28,
        '2024-09-26',
        '08:54:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-26 08:54:39',
        'ENTRANCE'
    ),
(
        125,
        38,
        '2024-09-26',
        '08:58:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-26 08:58:37',
        'ENTRANCE'
    ),
(
        126,
        35,
        '2024-09-26',
        '08:59:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-26 08:59:28',
        'ENTRANCE'
    ),
(
        127,
        34,
        '2024-09-26',
        '09:02:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-26 09:02:03',
        'ENTRANCE'
    ),
(
        128,
        27,
        '2024-09-26',
        '09:22:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-26 09:22:04',
        'ENTRANCE'
    ),
(
        129,
        29,
        '2024-09-26',
        '10:12:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-26 10:12:15',
        'ENTRANCE'
    ),
(
        130,
        32,
        '2024-09-26',
        '11:07:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-26 11:07:02',
        'ENTRANCE'
    ),
(
        131,
        36,
        '2024-09-26',
        '11:26:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-26 11:26:29',
        'ENTRANCE'
    ),
(
        132,
        28,
        '2024-09-26',
        '18:20:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-26 18:20:54',
        'EXIT'
    ),
(
        133,
        35,
        '2024-09-26',
        '18:20:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-26 18:20:57',
        'EXIT'
    ),
(
        134,
        29,
        '2024-09-26',
        '18:31:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-26 18:31:49',
        'EXIT'
    ),
(
        135,
        32,
        '2024-09-26',
        '19:04:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-26 19:04:41',
        'EXIT'
    ),
(
        136,
        38,
        '2024-09-26',
        '19:15:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-26 19:15:50',
        'EXIT'
    ),
(
        137,
        34,
        '2024-09-26',
        '19:15:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-26 19:15:52',
        'EXIT'
    ),
(
        138,
        38,
        '2024-09-27',
        '09:08:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-27 09:08:48',
        'ENTRANCE'
    ),
(
        139,
        28,
        '2024-09-27',
        '09:11:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-27 09:11:29',
        'ENTRANCE'
    ),
(
        140,
        35,
        '2024-09-27',
        '09:11:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-27 09:11:45',
        'ENTRANCE'
    ),
(
        141,
        27,
        '2024-09-27',
        '09:15:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-27 09:15:48',
        'ENTRANCE'
    ),
(
        142,
        36,
        '2024-09-27',
        '09:28:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-27 09:28:46',
        'ENTRANCE'
    ),
(
        143,
        31,
        '2024-09-27',
        '12:16:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-27 12:16:06',
        'ENTRANCE'
    ),
(
        144,
        38,
        '2024-09-27',
        '16:50:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-27 16:50:50',
        'EXIT'
    ),
(
        145,
        35,
        '2024-09-27',
        '17:31:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-27 17:31:32',
        'EXIT'
    ),
(
        146,
        31,
        '2024-09-27',
        '18:53:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-27 18:53:15',
        'EXIT'
    ),
(
        147,
        32,
        '2024-09-27',
        '19:00:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-27 19:00:21',
        'EXIT'
    ),
(
        148,
        38,
        '2024-09-28',
        '09:06:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-28 09:06:40',
        'ENTRANCE'
    ),
(
        149,
        28,
        '2024-09-28',
        '09:10:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-28 09:10:37',
        'ENTRANCE'
    ),
(
        150,
        27,
        '2024-09-28',
        '09:10:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-28 09:10:54',
        'ENTRANCE'
    ),
(
        151,
        35,
        '2024-09-28',
        '09:17:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-28 09:17:21',
        'ENTRANCE'
    ),
(
        152,
        36,
        '2024-09-28',
        '09:17:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-28 09:17:57',
        'ENTRANCE'
    ),
(
        153,
        34,
        '2024-09-28',
        '09:23:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-28 09:23:40',
        'ENTRANCE'
    ),
(
        154,
        29,
        '2024-09-28',
        '10:14:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-28 10:14:50',
        'ENTRANCE'
    ),
(
        155,
        32,
        '2024-09-28',
        '11:02:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-28 11:02:48',
        'ENTRANCE'
    ),
(
        156,
        31,
        '2024-09-28',
        '14:12:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-28 14:12:12',
        'EXIT'
    ),
(
        157,
        31,
        '2024-09-28',
        '14:12:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-28 14:12:17',
        'ENTRANCE'
    ),
(
        158,
        28,
        '2024-09-28',
        '14:51:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-28 14:51:37',
        'EXIT'
    ),
(
        159,
        38,
        '2024-09-28',
        '15:01:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-28 15:01:41',
        'EXIT'
    ),
(
        160,
        36,
        '2024-09-28',
        '15:09:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-28 15:09:45',
        'EXIT'
    ),
(
        161,
        29,
        '2024-09-28',
        '18:50:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-28 18:50:29',
        'EXIT'
    ),
(
        162,
        32,
        '2024-09-28',
        '19:01:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-28 19:01:06',
        'EXIT'
    ),
(
        163,
        29,
        '2024-09-29',
        '10:19:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-29 10:19:31',
        'ENTRANCE'
    ),
(
        164,
        31,
        '2024-09-29',
        '14:07:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-29 14:07:15',
        'ENTRANCE'
    ),
(
        165,
        31,
        '2024-09-29',
        '18:51:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-29 18:51:08',
        'EXIT'
    ),
(
        166,
        29,
        '2024-09-29',
        '18:51:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-29 18:51:37',
        'EXIT'
    ),
(
        167,
        38,
        '2024-09-30',
        '09:01:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-30 09:01:20',
        'ENTRANCE'
    ),
(
        168,
        28,
        '2024-09-30',
        '09:05:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-30 09:05:22',
        'ENTRANCE'
    ),
(
        169,
        27,
        '2024-09-30',
        '09:15:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-30 09:15:27',
        'ENTRANCE'
    ),
(
        170,
        35,
        '2024-09-30',
        '09:32:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-30 09:32:10',
        'ENTRANCE'
    ),
(
        171,
        29,
        '2024-09-30',
        '10:16:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-30 10:16:45',
        'ENTRANCE'
    ),
(
        172,
        32,
        '2024-09-30',
        '11:14:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-30 11:14:00',
        'ENTRANCE'
    ),
(
        173,
        36,
        '2024-09-30',
        '11:37:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-30 11:37:13',
        'ENTRANCE'
    ),
(
        174,
        31,
        '2024-09-30',
        '14:09:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-30 14:09:42',
        'ENTRANCE'
    ),
(
        175,
        31,
        '2024-09-30',
        '18:54:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-30 18:54:58',
        'EXIT'
    ),
(
        176,
        29,
        '2024-09-30',
        '18:56:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-30 18:56:22',
        'EXIT'
    ),
(
        177,
        38,
        '2024-09-30',
        '18:58:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-30 18:58:04',
        'EXIT'
    ),
(
        178,
        35,
        '2024-09-30',
        '18:58:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-30 18:58:35',
        'EXIT'
    ),
(
        179,
        32,
        '2024-09-30',
        '19:05:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-09-30 19:05:29',
        'EXIT'
    ),
(
        180,
        29,
        '2024-10-01',
        '10:07:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-01 10:07:44',
        'ENTRANCE'
    ),
(
        181,
        32,
        '2024-10-01',
        '11:14:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-01 11:14:57',
        'ENTRANCE'
    ),
(
        182,
        31,
        '2024-10-01',
        '14:13:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-01 14:13:50',
        'ENTRANCE'
    ),
(
        183,
        31,
        '2024-10-01',
        '18:52:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-01 18:52:04',
        'EXIT'
    ),
(
        184,
        29,
        '2024-10-01',
        '18:52:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-01 18:52:44',
        'EXIT'
    ),
(
        185,
        32,
        '2024-10-01',
        '18:55:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-01 18:55:01',
        'EXIT'
    ),
(
        186,
        38,
        '2024-10-02',
        '09:01:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-02 09:01:53',
        'ENTRANCE'
    ),
(
        187,
        34,
        '2024-10-02',
        '09:02:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-02 09:02:09',
        'ENTRANCE'
    ),
(
        188,
        28,
        '2024-10-02',
        '09:06:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-02 09:06:45',
        'ENTRANCE'
    ),
(
        189,
        36,
        '2024-10-02',
        '09:07:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-02 09:07:04',
        'ENTRANCE'
    ),
(
        190,
        27,
        '2024-10-02',
        '09:13:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-02 09:13:19',
        'ENTRANCE'
    ),
(
        191,
        29,
        '2024-10-02',
        '10:13:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-02 10:13:32',
        'ENTRANCE'
    ),
(
        192,
        32,
        '2024-10-02',
        '11:19:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-02 11:19:59',
        'ENTRANCE'
    ),
(
        193,
        31,
        '2024-10-02',
        '14:05:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-02 14:05:21',
        'ENTRANCE'
    ),
(
        194,
        38,
        '2024-10-02',
        '18:21:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-02 18:21:01',
        'EXIT'
    ),
(
        195,
        31,
        '2024-10-02',
        '18:52:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-02 18:52:32',
        'EXIT'
    ),
(
        196,
        29,
        '2024-10-02',
        '18:52:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-02 18:52:47',
        'EXIT'
    ),
(
        197,
        32,
        '2024-10-02',
        '18:56:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-02 18:56:17',
        'EXIT'
    ),
(
        198,
        38,
        '2024-10-03',
        '08:54:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-03 08:54:34',
        'ENTRANCE'
    ),
(
        199,
        28,
        '2024-10-03',
        '09:18:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-03 09:18:25',
        'ENTRANCE'
    ),
(
        200,
        34,
        '2024-10-03',
        '09:20:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-03 09:20:03',
        'ENTRANCE'
    ),
(
        201,
        27,
        '2024-10-03',
        '09:23:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-03 09:23:58',
        'ENTRANCE'
    ),
(
        202,
        29,
        '2024-10-03',
        '10:10:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-03 10:10:41',
        'ENTRANCE'
    ),
(
        203,
        32,
        '2024-10-03',
        '11:10:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-03 11:10:14',
        'ENTRANCE'
    ),
(
        204,
        36,
        '2024-10-03',
        '11:41:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-03 11:41:53',
        'ENTRANCE'
    ),
(
        205,
        38,
        '2024-10-03',
        '18:00:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-03 18:00:44',
        'EXIT'
    ),
(
        206,
        32,
        '2024-10-03',
        '18:56:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-03 18:56:48',
        'EXIT'
    ),
(
        207,
        38,
        '2024-10-04',
        '09:02:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-04 09:02:12',
        'ENTRANCE'
    ),
(
        208,
        35,
        '2024-10-04',
        '09:02:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-04 09:02:41',
        'ENTRANCE'
    ),
(
        209,
        28,
        '2024-10-04',
        '09:14:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-04 09:14:07',
        'ENTRANCE'
    ),
(
        210,
        27,
        '2024-10-04',
        '09:14:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-04 09:14:21',
        'ENTRANCE'
    ),
(
        211,
        36,
        '2024-10-04',
        '09:44:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-04 09:44:44',
        'ENTRANCE'
    ),
(
        212,
        30,
        '2024-10-04',
        '10:57:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-04 10:57:23',
        'ENTRANCE'
    ),
(
        213,
        32,
        '2024-10-04',
        '11:12:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-04 11:12:15',
        'ENTRANCE'
    ),
(
        214,
        37,
        '2024-10-04',
        '11:55:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-04 11:55:17',
        'ENTRANCE'
    ),
(
        215,
        31,
        '2024-10-04',
        '12:34:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-04 12:34:25',
        'ENTRANCE'
    ),
(
        216,
        34,
        '2024-10-04',
        '18:05:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-04 18:05:53',
        'EXIT'
    ),
(
        217,
        38,
        '2024-10-04',
        '18:05:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-04 18:05:56',
        'EXIT'
    ),
(
        218,
        35,
        '2024-10-04',
        '18:06:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-04 18:06:54',
        'EXIT'
    ),
(
        219,
        31,
        '2024-10-04',
        '19:00:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-04 19:00:59',
        'EXIT'
    ),
(
        220,
        32,
        '2024-10-04',
        '19:01:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-04 19:01:43',
        'EXIT'
    ),
(
        221,
        35,
        '2024-10-05',
        '09:25:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-05 09:25:33',
        'ENTRANCE'
    ),
(
        222,
        38,
        '2024-10-05',
        '09:25:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-05 09:25:51',
        'ENTRANCE'
    ),
(
        223,
        27,
        '2024-10-05',
        '09:26:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-05 09:26:16',
        'ENTRANCE'
    ),
(
        224,
        30,
        '2024-10-05',
        '09:39:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-05 09:39:44',
        'ENTRANCE'
    ),
(
        225,
        29,
        '2024-10-05',
        '10:15:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-05 10:15:50',
        'ENTRANCE'
    ),
(
        226,
        32,
        '2024-10-05',
        '11:25:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-05 11:25:36',
        'ENTRANCE'
    ),
(
        227,
        31,
        '2024-10-05',
        '14:16:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-05 14:16:35',
        'ENTRANCE'
    ),
(
        228,
        38,
        '2024-10-05',
        '14:21:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-05 14:21:09',
        'EXIT'
    ),
(
        229,
        35,
        '2024-10-05',
        '15:16:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-05 15:16:08',
        'EXIT'
    ),
(
        230,
        31,
        '2024-10-05',
        '18:50:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-05 18:50:56',
        'EXIT'
    ),
(
        231,
        29,
        '2024-10-05',
        '18:51:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-05 18:51:13',
        'EXIT'
    ),
(
        232,
        32,
        '2024-10-05',
        '19:01:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-05 19:01:54',
        'EXIT'
    ),
(
        233,
        29,
        '2024-10-06',
        '10:13:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-06 10:13:31',
        'ENTRANCE'
    ),
(
        234,
        30,
        '2024-10-06',
        '11:47:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-06 11:47:55',
        'ENTRANCE'
    ),
(
        235,
        31,
        '2024-10-06',
        '14:06:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-06 14:06:24',
        'ENTRANCE'
    ),
(
        236,
        31,
        '2024-10-06',
        '18:51:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-06 18:51:13',
        'EXIT'
    ),
(
        237,
        29,
        '2024-10-06',
        '18:53:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-06 18:53:08',
        'EXIT'
    ),
(
        238,
        30,
        '2024-10-07',
        '08:21:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-07 08:21:33',
        'ENTRANCE'
    ),
(
        239,
        38,
        '2024-10-07',
        '08:58:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-07 08:58:28',
        'ENTRANCE'
    ),
(
        240,
        27,
        '2024-10-07',
        '09:31:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-07 09:31:49',
        'ENTRANCE'
    ),
(
        241,
        29,
        '2024-10-07',
        '10:20:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-07 10:20:07',
        'ENTRANCE'
    ),
(
        242,
        36,
        '2024-10-07',
        '11:18:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-07 11:18:03',
        'ENTRANCE'
    ),
(
        243,
        31,
        '2024-10-07',
        '14:24:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-07 14:24:53',
        'ENTRANCE'
    ),
(
        244,
        31,
        '2024-10-07',
        '15:21:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-07 15:21:03',
        'EXIT'
    ),
(
        245,
        38,
        '2024-10-07',
        '17:40:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-07 17:40:51',
        'EXIT'
    ),
(
        246,
        29,
        '2024-10-07',
        '18:48:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-07 18:48:18',
        'EXIT'
    ),
(
        247,
        30,
        '2024-10-08',
        '07:58:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-08 07:58:04',
        'ENTRANCE'
    ),
(
        248,
        38,
        '2024-10-08',
        '08:49:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-08 08:49:59',
        'ENTRANCE'
    ),
(
        249,
        35,
        '2024-10-08',
        '09:07:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-08 09:07:58',
        'ENTRANCE'
    ),
(
        250,
        34,
        '2024-10-08',
        '09:08:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-08 09:08:31',
        'ENTRANCE'
    ),
(
        251,
        36,
        '2024-10-08',
        '09:10:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-08 09:10:18',
        'ENTRANCE'
    ),
(
        252,
        28,
        '2024-10-08',
        '09:43:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-08 09:43:09',
        'ENTRANCE'
    ),
(
        253,
        29,
        '2024-10-08',
        '10:25:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-08 10:25:01',
        'ENTRANCE'
    ),
(
        254,
        32,
        '2024-10-08',
        '11:14:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-08 11:14:10',
        'ENTRANCE'
    ),
(
        255,
        31,
        '2024-10-08',
        '14:16:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-08 14:16:28',
        'ENTRANCE'
    ),
(
        256,
        38,
        '2024-10-08',
        '17:59:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-08 17:59:09',
        'EXIT'
    ),
(
        257,
        31,
        '2024-10-08',
        '18:50:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-08 18:50:17',
        'EXIT'
    ),
(
        258,
        29,
        '2024-10-08',
        '18:51:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-08 18:51:19',
        'EXIT'
    ),
(
        259,
        32,
        '2024-10-08',
        '19:00:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-08 19:00:14',
        'EXIT'
    ),
(
        260,
        30,
        '2024-10-09',
        '07:57:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-09 07:57:28',
        'ENTRANCE'
    ),
(
        261,
        34,
        '2024-10-09',
        '08:56:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-09 08:56:35',
        'ENTRANCE'
    ),
(
        262,
        28,
        '2024-10-09',
        '08:59:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-09 08:59:35',
        'ENTRANCE'
    ),
(
        263,
        38,
        '2024-10-09',
        '09:05:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-09 09:05:26',
        'ENTRANCE'
    ),
(
        264,
        36,
        '2024-10-09',
        '09:05:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-09 09:05:49',
        'ENTRANCE'
    ),
(
        265,
        27,
        '2024-10-09',
        '09:15:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-09 09:15:53',
        'ENTRANCE'
    ),
(
        266,
        29,
        '2024-10-09',
        '10:25:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-09 10:25:56',
        'ENTRANCE'
    ),
(
        267,
        31,
        '2024-10-09',
        '14:09:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-09 14:09:27',
        'ENTRANCE'
    ),
(
        268,
        38,
        '2024-10-09',
        '17:47:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-09 17:47:08',
        'EXIT'
    ),
(
        269,
        28,
        '2024-10-09',
        '17:59:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-09 17:59:04',
        'EXIT'
    ),
(
        270,
        30,
        '2024-10-09',
        '18:30:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-09 18:30:23',
        'EXIT'
    ),
(
        271,
        31,
        '2024-10-09',
        '18:50:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-09 18:50:59',
        'EXIT'
    ),
(
        272,
        29,
        '2024-10-09',
        '18:52:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-09 18:52:39',
        'EXIT'
    ),
(
        273,
        38,
        '2024-10-10',
        '08:50:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-10 08:50:08',
        'ENTRANCE'
    ),
(
        274,
        34,
        '2024-10-10',
        '08:51:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-10 08:51:46',
        'ENTRANCE'
    ),
(
        275,
        35,
        '2024-10-10',
        '08:56:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-10 08:56:17',
        'ENTRANCE'
    ),
(
        276,
        32,
        '2024-10-10',
        '11:21:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-10 11:21:42',
        'ENTRANCE'
    ),
(
        277,
        31,
        '2024-10-10',
        '12:15:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-10 12:15:15',
        'ENTRANCE'
    ),
(
        278,
        38,
        '2024-10-10',
        '17:54:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-10 17:54:24',
        'EXIT'
    ),
(
        279,
        31,
        '2024-10-10',
        '18:51:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-10 18:51:50',
        'EXIT'
    ),
(
        280,
        30,
        '2024-10-11',
        '08:56:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-11 08:56:46',
        'ENTRANCE'
    ),
(
        281,
        28,
        '2024-10-11',
        '08:58:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-11 08:58:21',
        'ENTRANCE'
    ),
(
        282,
        38,
        '2024-10-11',
        '08:59:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-11 08:59:21',
        'ENTRANCE'
    ),
(
        283,
        35,
        '2024-10-11',
        '09:02:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-11 09:02:41',
        'ENTRANCE'
    ),
(
        284,
        27,
        '2024-10-11',
        '09:13:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-11 09:13:08',
        'ENTRANCE'
    ),
(
        285,
        29,
        '2024-10-11',
        '10:10:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-11 10:10:12',
        'ENTRANCE'
    ),
(
        286,
        38,
        '2024-10-11',
        '18:00:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-11 18:00:59',
        'EXIT'
    ),
(
        287,
        28,
        '2024-10-11',
        '18:05:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-11 18:05:10',
        'EXIT'
    ),
(
        288,
        29,
        '2024-10-11',
        '18:08:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-11 18:08:18',
        'EXIT'
    ),
(
        289,
        28,
        '2024-10-12',
        '08:52:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-12 08:52:31',
        'ENTRANCE'
    ),
(
        290,
        30,
        '2024-10-12',
        '08:53:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-12 08:53:35',
        'ENTRANCE'
    ),
(
        291,
        38,
        '2024-10-12',
        '09:02:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-12 09:02:05',
        'ENTRANCE'
    ),
(
        292,
        35,
        '2024-10-12',
        '09:05:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-12 09:05:59',
        'ENTRANCE'
    ),
(
        293,
        29,
        '2024-10-12',
        '10:14:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-12 10:14:39',
        'ENTRANCE'
    ),
(
        294,
        31,
        '2024-10-12',
        '14:46:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-12 14:46:51',
        'ENTRANCE'
    ),
(
        295,
        38,
        '2024-10-12',
        '15:04:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-12 15:04:06',
        'EXIT'
    ),
(
        296,
        28,
        '2024-10-12',
        '15:06:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-12 15:06:30',
        'EXIT'
    ),
(
        297,
        31,
        '2024-10-12',
        '18:50:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-12 18:50:26',
        'EXIT'
    ),
(
        298,
        29,
        '2024-10-12',
        '18:50:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-12 18:50:42',
        'EXIT'
    ),
(
        299,
        30,
        '2024-10-13',
        '08:47:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-13 08:47:27',
        'ENTRANCE'
    ),
(
        300,
        29,
        '2024-10-13',
        '10:16:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-13 10:16:47',
        'ENTRANCE'
    ),
(
        301,
        31,
        '2024-10-13',
        '14:21:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-13 14:21:33',
        'ENTRANCE'
    ),
(
        302,
        31,
        '2024-10-13',
        '18:49:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-13 18:49:24',
        'EXIT'
    ),
(
        303,
        29,
        '2024-10-13',
        '18:50:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-13 18:50:49',
        'EXIT'
    ),
(
        304,
        28,
        '2024-10-14',
        '08:51:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-14 08:51:08',
        'ENTRANCE'
    ),
(
        305,
        38,
        '2024-10-14',
        '08:51:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-14 08:51:44',
        'ENTRANCE'
    ),
(
        306,
        29,
        '2024-10-14',
        '11:28:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-14 11:28:45',
        'ENTRANCE'
    ),
(
        307,
        31,
        '2024-10-14',
        '14:05:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-14 14:05:29',
        'ENTRANCE'
    ),
(
        308,
        30,
        '2024-10-14',
        '17:59:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-14 17:59:18',
        'EXIT'
    ),
(
        309,
        38,
        '2024-10-14',
        '18:00:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-14 18:00:38',
        'EXIT'
    ),
(
        310,
        34,
        '2024-10-14',
        '18:00:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-14 18:00:51',
        'ENTRANCE'
    ),
(
        311,
        34,
        '2024-10-14',
        '18:01:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-14 18:01:03',
        'EXIT'
    ),
(
        312,
        28,
        '2024-10-14',
        '18:05:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-14 18:05:11',
        'EXIT'
    ),
(
        313,
        31,
        '2024-10-14',
        '18:50:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-14 18:50:11',
        'EXIT'
    ),
(
        314,
        29,
        '2024-10-14',
        '18:51:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-14 18:51:39',
        'EXIT'
    ),
(
        315,
        30,
        '2024-10-15',
        '08:21:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-15 08:21:07',
        'ENTRANCE'
    ),
(
        316,
        38,
        '2024-10-15',
        '08:42:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-15 08:42:56',
        'ENTRANCE'
    ),
(
        317,
        34,
        '2024-10-15',
        '08:43:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-15 08:43:32',
        'ENTRANCE'
    ),
(
        318,
        28,
        '2024-10-15',
        '08:59:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-15 08:59:40',
        'ENTRANCE'
    ),
(
        319,
        27,
        '2024-10-15',
        '09:25:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-15 09:25:24',
        'ENTRANCE'
    ),
(
        320,
        29,
        '2024-10-15',
        '10:25:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-15 10:25:51',
        'ENTRANCE'
    ),
(
        321,
        31,
        '2024-10-15',
        '14:05:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-15 14:05:02',
        'ENTRANCE'
    ),
(
        322,
        38,
        '2024-10-15',
        '17:52:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-15 17:52:27',
        'EXIT'
    ),
(
        323,
        28,
        '2024-10-15',
        '18:02:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-15 18:02:21',
        'EXIT'
    ),
(
        324,
        31,
        '2024-10-15',
        '18:50:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-15 18:50:49',
        'EXIT'
    ),
(
        325,
        29,
        '2024-10-15',
        '18:51:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-15 18:51:10',
        'EXIT'
    ),
(
        326,
        32,
        '2024-10-15',
        '19:00:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-15 19:00:26',
        'EXIT'
    ),
(
        327,
        30,
        '2024-10-16',
        '08:56:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-16 08:56:01',
        'ENTRANCE'
    ),
(
        328,
        34,
        '2024-10-16',
        '08:59:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-16 08:59:44',
        'ENTRANCE'
    ),
(
        329,
        38,
        '2024-10-16',
        '09:00:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-16 09:00:20',
        'ENTRANCE'
    ),
(
        330,
        27,
        '2024-10-16',
        '09:12:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-16 09:12:37',
        'ENTRANCE'
    ),
(
        331,
        28,
        '2024-10-16',
        '09:15:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-16 09:15:27',
        'ENTRANCE'
    ),
(
        332,
        29,
        '2024-10-16',
        '10:14:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-16 10:14:51',
        'ENTRANCE'
    ),
(
        333,
        37,
        '2024-10-16',
        '10:36:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-16 10:36:38',
        'ENTRANCE'
    ),
(
        334,
        31,
        '2024-10-16',
        '14:17:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-16 14:17:47',
        'ENTRANCE'
    ),
(
        335,
        28,
        '2024-10-16',
        '18:06:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-16 18:06:10',
        'EXIT'
    ),
(
        336,
        31,
        '2024-10-16',
        '18:59:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-16 18:59:56',
        'EXIT'
    ),
(
        337,
        32,
        '2024-10-16',
        '19:00:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-16 19:00:10',
        'EXIT'
    ),
(
        338,
        29,
        '2024-10-16',
        '19:00:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-16 19:00:14',
        'EXIT'
    ),
(
        339,
        37,
        '2024-10-16',
        '20:17:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-16 20:17:23',
        'EXIT'
    ),
(
        340,
        34,
        '2024-10-17',
        '08:53:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-17 08:53:28',
        'ENTRANCE'
    ),
(
        341,
        38,
        '2024-10-17',
        '08:53:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-17 08:53:29',
        'ENTRANCE'
    ),
(
        342,
        28,
        '2024-10-17',
        '09:25:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-17 09:25:51',
        'ENTRANCE'
    ),
(
        343,
        29,
        '2024-10-17',
        '10:22:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-17 10:22:42',
        'ENTRANCE'
    ),
(
        344,
        37,
        '2024-10-17',
        '11:00:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-17 11:00:51',
        'ENTRANCE'
    ),
(
        345,
        36,
        '2024-10-17',
        '11:53:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-17 11:53:28',
        'ENTRANCE'
    ),
(
        346,
        29,
        '2024-10-17',
        '17:50:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-17 17:50:42',
        'EXIT'
    ),
(
        347,
        38,
        '2024-10-17',
        '18:16:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-17 18:16:03',
        'EXIT'
    ),
(
        348,
        37,
        '2024-10-17',
        '19:59:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-17 19:59:59',
        'EXIT'
    ),
(
        349,
        38,
        '2024-10-18',
        '08:56:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-18 08:56:12',
        'ENTRANCE'
    ),
(
        350,
        27,
        '2024-10-18',
        '08:58:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-18 08:58:39',
        'ENTRANCE'
    ),
(
        351,
        30,
        '2024-10-18',
        '08:59:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-18 08:59:07',
        'ENTRANCE'
    ),
(
        352,
        28,
        '2024-10-18',
        '09:10:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-18 09:10:05',
        'ENTRANCE'
    ),
(
        353,
        34,
        '2024-10-18',
        '09:10:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-18 09:10:47',
        'ENTRANCE'
    ),
(
        354,
        36,
        '2024-10-18',
        '09:38:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-18 09:38:11',
        'ENTRANCE'
    ),
(
        355,
        37,
        '2024-10-18',
        '11:05:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-18 11:05:12',
        'ENTRANCE'
    ),
(
        356,
        31,
        '2024-10-18',
        '12:17:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-18 12:17:10',
        'ENTRANCE'
    ),
(
        357,
        30,
        '2024-10-18',
        '18:02:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-18 18:02:38',
        'EXIT'
    ),
(
        358,
        38,
        '2024-10-18',
        '18:22:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-18 18:22:51',
        'EXIT'
    ),
(
        359,
        31,
        '2024-10-18',
        '18:50:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-18 18:50:25',
        'EXIT'
    ),
(
        360,
        28,
        '2024-10-19',
        '08:50:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-19 08:50:07',
        'ENTRANCE'
    ),
(
        361,
        38,
        '2024-10-19',
        '08:53:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-19 08:53:41',
        'ENTRANCE'
    ),
(
        362,
        30,
        '2024-10-19',
        '09:34:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-19 09:34:10',
        'ENTRANCE'
    ),
(
        363,
        29,
        '2024-10-19',
        '10:16:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-19 10:16:13',
        'ENTRANCE'
    ),
(
        364,
        37,
        '2024-10-19',
        '10:57:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-19 10:57:18',
        'ENTRANCE'
    ),
(
        365,
        34,
        '2024-10-19',
        '12:32:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-19 12:32:14',
        'ENTRANCE'
    ),
(
        366,
        31,
        '2024-10-19',
        '14:14:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-19 14:14:13',
        'ENTRANCE'
    ),
(
        367,
        28,
        '2024-10-19',
        '14:46:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-19 14:46:25',
        'EXIT'
    ),
(
        368,
        38,
        '2024-10-19',
        '15:03:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-19 15:03:50',
        'EXIT'
    ),
(
        369,
        31,
        '2024-10-19',
        '18:49:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-19 18:49:09',
        'EXIT'
    ),
(
        370,
        29,
        '2024-10-19',
        '18:49:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-19 18:49:25',
        'EXIT'
    ),
(
        371,
        30,
        '2024-10-20',
        '09:58:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-20 09:58:40',
        'ENTRANCE'
    ),
(
        372,
        29,
        '2024-10-20',
        '10:27:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-20 10:27:18',
        'ENTRANCE'
    ),
(
        373,
        37,
        '2024-10-20',
        '11:01:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-20 11:01:45',
        'ENTRANCE'
    ),
(
        374,
        31,
        '2024-10-20',
        '14:24:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-20 14:24:06',
        'ENTRANCE'
    ),
(
        375,
        31,
        '2024-10-20',
        '18:50:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-20 18:50:31',
        'EXIT'
    ),
(
        376,
        29,
        '2024-10-20',
        '18:50:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-20 18:50:53',
        'EXIT'
    ),
(
        377,
        34,
        '2024-10-21',
        '08:43:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-21 08:43:33',
        'ENTRANCE'
    ),
(
        378,
        30,
        '2024-10-21',
        '08:53:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-21 08:53:09',
        'ENTRANCE'
    ),
(
        379,
        38,
        '2024-10-21',
        '09:00:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-21 09:00:35',
        'ENTRANCE'
    ),
(
        380,
        27,
        '2024-10-21',
        '09:23:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-21 09:23:12',
        'ENTRANCE'
    ),
(
        381,
        35,
        '2024-10-21',
        '09:25:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-21 09:25:20',
        'ENTRANCE'
    ),
(
        382,
        28,
        '2024-10-21',
        '09:36:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-21 09:36:30',
        'ENTRANCE'
    ),
(
        383,
        29,
        '2024-10-21',
        '10:21:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-21 10:21:39',
        'ENTRANCE'
    ),
(
        384,
        37,
        '2024-10-21',
        '10:53:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-21 10:53:08',
        'ENTRANCE'
    ),
(
        385,
        31,
        '2024-10-21',
        '14:16:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-21 14:16:43',
        'ENTRANCE'
    ),
(
        386,
        30,
        '2024-10-21',
        '17:58:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-21 17:58:50',
        'EXIT'
    ),
(
        387,
        28,
        '2024-10-21',
        '18:03:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-21 18:03:51',
        'EXIT'
    ),
(
        388,
        38,
        '2024-10-21',
        '18:09:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-21 18:09:16',
        'EXIT'
    ),
(
        389,
        31,
        '2024-10-21',
        '18:49:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-21 18:49:52',
        'EXIT'
    ),
(
        390,
        29,
        '2024-10-21',
        '18:50:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-21 18:50:10',
        'EXIT'
    ),
(
        391,
        37,
        '2024-10-21',
        '19:54:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-21 19:54:39',
        'EXIT'
    ),
(
        392,
        28,
        '2024-10-22',
        '17:52:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-22 17:52:25',
        'EXIT'
    ),
(
        393,
        34,
        '2024-10-23',
        '08:45:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-23 08:45:42',
        'ENTRANCE'
    ),
(
        394,
        38,
        '2024-10-23',
        '09:00:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-23 09:00:17',
        'ENTRANCE'
    ),
(
        395,
        27,
        '2024-10-23',
        '09:11:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-23 09:11:44',
        'ENTRANCE'
    ),
(
        396,
        28,
        '2024-10-23',
        '09:14:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-23 09:14:18',
        'ENTRANCE'
    ),
(
        397,
        26,
        '2024-10-23',
        '09:23:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-23 09:23:43',
        'ENTRANCE'
    ),
(
        398,
        30,
        '2024-10-23',
        '17:58:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-23 17:58:10',
        'EXIT'
    ),
(
        399,
        38,
        '2024-10-23',
        '18:09:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-23 18:09:50',
        'EXIT'
    ),
(
        400,
        28,
        '2024-10-24',
        '09:00:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-24 09:00:22',
        'ENTRANCE'
    ),
(
        401,
        34,
        '2024-10-24',
        '09:00:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-24 09:00:27',
        'ENTRANCE'
    ),
(
        402,
        38,
        '2024-10-24',
        '09:00:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-24 09:00:45',
        'ENTRANCE'
    ),
(
        403,
        27,
        '2024-10-24',
        '09:11:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-24 09:11:42',
        'ENTRANCE'
    ),
(
        404,
        28,
        '2024-10-24',
        '18:38:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-24 18:38:57',
        'EXIT'
    ),
(
        405,
        38,
        '2024-10-24',
        '18:39:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-24 18:39:27',
        'EXIT'
    ),
(
        406,
        34,
        '2024-10-24',
        '18:52:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-24 18:52:06',
        'EXIT'
    ),
(
        407,
        28,
        '2024-10-25',
        '08:53:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-25 08:53:46',
        'ENTRANCE'
    ),
(
        408,
        38,
        '2024-10-25',
        '08:58:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-25 08:58:53',
        'ENTRANCE'
    ),
(
        409,
        34,
        '2024-10-25',
        '08:59:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-25 08:59:10',
        'ENTRANCE'
    ),
(
        410,
        30,
        '2024-10-25',
        '09:10:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-25 09:10:39',
        'ENTRANCE'
    ),
(
        411,
        27,
        '2024-10-25',
        '09:17:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-25 09:17:47',
        'ENTRANCE'
    ),
(
        412,
        38,
        '2024-10-25',
        '17:23:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-25 17:23:08',
        'EXIT'
    ),
(
        413,
        30,
        '2024-10-25',
        '18:00:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-25 18:00:32',
        'EXIT'
    ),
(
        414,
        28,
        '2024-10-26',
        '08:57:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-26 08:57:26',
        'ENTRANCE'
    ),
(
        415,
        38,
        '2024-10-26',
        '09:03:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-26 09:03:40',
        'ENTRANCE'
    ),
(
        416,
        27,
        '2024-10-26',
        '09:21:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-26 09:21:44',
        'ENTRANCE'
    ),
(
        417,
        30,
        '2024-10-26',
        '09:27:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-26 09:27:24',
        'ENTRANCE'
    ),
(
        418,
        28,
        '2024-10-26',
        '14:55:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-26 14:55:48',
        'EXIT'
    ),
(
        419,
        38,
        '2024-10-26',
        '15:08:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-26 15:08:38',
        'EXIT'
    ),
(
        420,
        30,
        '2024-10-27',
        '09:14:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-27 09:14:26',
        'ENTRANCE'
    ),
(
        421,
        29,
        '2024-10-27',
        '11:07:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-27 11:07:11',
        'ENTRANCE'
    ),
(
        422,
        33,
        '2024-10-27',
        '13:54:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-27 13:54:37',
        'ENTRANCE'
    ),
(
        423,
        31,
        '2024-10-27',
        '14:19:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-27 14:19:38',
        'ENTRANCE'
    ),
(
        424,
        29,
        '2024-10-27',
        '18:50:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-27 18:50:13',
        'EXIT'
    ),
(
        425,
        31,
        '2024-10-27',
        '18:50:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-27 18:50:37',
        'EXIT'
    ),
(
        426,
        33,
        '2024-10-27',
        '19:07:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-27 19:07:21',
        'EXIT'
    ),
(
        427,
        30,
        '2024-10-28',
        '08:27:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-28 08:27:12',
        'ENTRANCE'
    ),
(
        428,
        28,
        '2024-10-28',
        '08:53:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-28 08:53:55',
        'ENTRANCE'
    ),
(
        429,
        34,
        '2024-10-28',
        '09:15:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-28 09:15:03',
        'ENTRANCE'
    ),
(
        430,
        38,
        '2024-10-28',
        '09:23:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-28 09:23:33',
        'ENTRANCE'
    ),
(
        431,
        27,
        '2024-10-28',
        '09:26:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-28 09:26:03',
        'ENTRANCE'
    ),
(
        432,
        29,
        '2024-10-28',
        '09:54:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-28 09:54:49',
        'ENTRANCE'
    ),
(
        433,
        31,
        '2024-10-28',
        '14:10:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-28 14:10:16',
        'ENTRANCE'
    ),
(
        434,
        38,
        '2024-10-28',
        '18:08:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-28 18:08:36',
        'EXIT'
    ),
(
        435,
        30,
        '2024-10-28',
        '18:19:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-28 18:19:10',
        'EXIT'
    ),
(
        436,
        28,
        '2024-10-29',
        '08:50:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-29 08:50:41',
        'ENTRANCE'
    ),
(
        437,
        30,
        '2024-10-29',
        '09:03:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-29 09:03:43',
        'ENTRANCE'
    ),
(
        438,
        38,
        '2024-10-29',
        '09:06:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-29 09:06:02',
        'ENTRANCE'
    ),
(
        439,
        36,
        '2024-10-29',
        '09:07:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-29 09:07:23',
        'ENTRANCE'
    ),
(
        440,
        34,
        '2024-10-29',
        '09:10:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-29 09:10:21',
        'ENTRANCE'
    ),
(
        441,
        27,
        '2024-10-29',
        '09:16:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-29 09:16:11',
        'ENTRANCE'
    ),
(
        442,
        29,
        '2024-10-29',
        '09:37:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-29 09:37:22',
        'ENTRANCE'
    ),
(
        443,
        31,
        '2024-10-29',
        '14:08:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-29 14:08:04',
        'ENTRANCE'
    ),
(
        444,
        30,
        '2024-10-29',
        '18:09:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-29 18:09:14',
        'EXIT'
    ),
(
        445,
        38,
        '2024-10-29',
        '18:30:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-29 18:30:29',
        'EXIT'
    ),
(
        446,
        31,
        '2024-10-29',
        '18:50:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-29 18:50:45',
        'EXIT'
    ),
(
        447,
        29,
        '2024-10-29',
        '18:52:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-29 18:52:21',
        'EXIT'
    ),
(
        448,
        30,
        '2024-10-30',
        '08:07:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-30 08:07:15',
        'ENTRANCE'
    ),
(
        449,
        28,
        '2024-10-30',
        '08:55:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-30 08:55:22',
        'ENTRANCE'
    ),
(
        450,
        38,
        '2024-10-30',
        '08:57:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-30 08:57:08',
        'ENTRANCE'
    ),
(
        451,
        34,
        '2024-10-30',
        '09:11:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-30 09:11:17',
        'ENTRANCE'
    ),
(
        452,
        27,
        '2024-10-30',
        '09:29:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-30 09:29:30',
        'ENTRANCE'
    ),
(
        453,
        29,
        '2024-10-30',
        '10:09:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-30 10:09:31',
        'ENTRANCE'
    ),
(
        454,
        31,
        '2024-10-30',
        '14:09:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-30 14:09:31',
        'ENTRANCE'
    ),
(
        455,
        38,
        '2024-10-30',
        '18:03:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-30 18:03:21',
        'EXIT'
    ),
(
        456,
        27,
        '2024-10-30',
        '18:05:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-30 18:05:41',
        'EXIT'
    ),
(
        457,
        28,
        '2024-10-30',
        '18:05:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-30 18:05:58',
        'EXIT'
    ),
(
        458,
        30,
        '2024-10-30',
        '18:14:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-30 18:14:54',
        'EXIT'
    ),
(
        459,
        31,
        '2024-10-30',
        '18:45:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-30 18:45:23',
        'EXIT'
    ),
(
        460,
        29,
        '2024-10-30',
        '18:46:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-30 18:46:38',
        'EXIT'
    ),
(
        461,
        28,
        '2024-10-31',
        '08:49:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-31 08:49:55',
        'ENTRANCE'
    ),
(
        462,
        38,
        '2024-10-31',
        '08:50:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-31 08:50:16',
        'ENTRANCE'
    ),
(
        463,
        34,
        '2024-10-31',
        '08:55:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-31 08:55:28',
        'ENTRANCE'
    ),
(
        464,
        27,
        '2024-10-31',
        '09:11:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-31 09:11:52',
        'ENTRANCE'
    ),
(
        465,
        29,
        '2024-10-31',
        '10:21:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-31 10:21:40',
        'ENTRANCE'
    ),
(
        466,
        28,
        '2024-10-31',
        '17:55:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-31 17:55:45',
        'EXIT'
    ),
(
        467,
        38,
        '2024-10-31',
        '17:56:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-31 17:56:59',
        'EXIT'
    ),
(
        468,
        29,
        '2024-10-31',
        '17:57:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-10-31 17:57:53',
        'EXIT'
    ),
(
        469,
        28,
        '2024-11-01',
        '08:54:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-01 08:54:29',
        'ENTRANCE'
    ),
(
        470,
        38,
        '2024-11-01',
        '09:10:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-01 09:10:50',
        'ENTRANCE'
    ),
(
        471,
        34,
        '2024-11-01',
        '09:12:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-01 09:12:09',
        'ENTRANCE'
    ),
(
        472,
        27,
        '2024-11-01',
        '10:03:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-01 10:03:46',
        'ENTRANCE'
    ),
(
        473,
        31,
        '2024-11-01',
        '18:45:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-01 18:45:46',
        'EXIT'
    ),
(
        474,
        28,
        '2024-11-02',
        '08:45:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-02 08:45:03',
        'ENTRANCE'
    ),
(
        475,
        38,
        '2024-11-02',
        '09:14:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-02 09:14:06',
        'ENTRANCE'
    ),
(
        476,
        27,
        '2024-11-02',
        '09:30:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-02 09:30:50',
        'ENTRANCE'
    ),
(
        477,
        29,
        '2024-11-02',
        '10:17:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-02 10:17:30',
        'ENTRANCE'
    ),
(
        478,
        31,
        '2024-11-02',
        '14:10:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-02 14:10:51',
        'ENTRANCE'
    ),
(
        479,
        38,
        '2024-11-02',
        '14:57:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-02 14:57:54',
        'EXIT'
    ),
(
        480,
        30,
        '2024-11-02',
        '17:44:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-02 17:44:31',
        'EXIT'
    ),
(
        481,
        29,
        '2024-11-02',
        '18:45:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-02 18:45:37',
        'EXIT'
    ),
(
        482,
        31,
        '2024-11-02',
        '18:45:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-02 18:45:57',
        'EXIT'
    ),
(
        483,
        30,
        '2024-11-03',
        '09:35:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-03 09:35:49',
        'ENTRANCE'
    ),
(
        484,
        29,
        '2024-11-03',
        '10:20:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-03 10:20:55',
        'ENTRANCE'
    ),
(
        485,
        33,
        '2024-11-03',
        '10:50:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-03 10:50:23',
        'ENTRANCE'
    ),
(
        486,
        31,
        '2024-11-03',
        '14:13:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-03 14:13:16',
        'ENTRANCE'
    ),
(
        487,
        29,
        '2024-11-03',
        '18:47:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-03 18:47:39',
        'EXIT'
    ),
(
        488,
        31,
        '2024-11-03',
        '18:48:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-03 18:48:05',
        'EXIT'
    ),
(
        489,
        33,
        '2024-11-03',
        '19:03:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-03 19:03:27',
        'EXIT'
    ),
(
        490,
        34,
        '2024-11-04',
        '08:46:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-04 08:46:03',
        'ENTRANCE'
    ),
(
        491,
        38,
        '2024-11-04',
        '08:47:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-04 08:47:15',
        'ENTRANCE'
    ),
(
        492,
        27,
        '2024-11-04',
        '09:13:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-04 09:13:18',
        'ENTRANCE'
    ),
(
        493,
        30,
        '2024-11-04',
        '09:16:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-04 09:16:01',
        'ENTRANCE'
    ),
(
        494,
        28,
        '2024-11-04',
        '09:36:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-04 09:36:45',
        'ENTRANCE'
    ),
(
        495,
        29,
        '2024-11-04',
        '10:17:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-04 10:17:37',
        'ENTRANCE'
    ),
(
        496,
        31,
        '2024-11-04',
        '14:05:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-04 14:05:41',
        'ENTRANCE'
    ),
(
        497,
        28,
        '2024-11-04',
        '17:54:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-04 17:54:58',
        'EXIT'
    ),
(
        498,
        38,
        '2024-11-04',
        '17:55:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-04 17:55:17',
        'EXIT'
    ),
(
        499,
        31,
        '2024-11-04',
        '18:46:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-04 18:46:14',
        'EXIT'
    ),
(
        500,
        29,
        '2024-11-04',
        '18:46:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-04 18:46:31',
        'EXIT'
    ),
(
        501,
        28,
        '2024-11-05',
        '08:47:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-05 08:47:19',
        'ENTRANCE'
    ),
(
        502,
        34,
        '2024-11-05',
        '08:48:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-05 08:48:28',
        'ENTRANCE'
    ),
(
        503,
        38,
        '2024-11-05',
        '08:52:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-05 08:52:57',
        'ENTRANCE'
    ),
(
        504,
        30,
        '2024-11-05',
        '09:21:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-05 09:21:52',
        'ENTRANCE'
    ),
(
        505,
        27,
        '2024-11-05',
        '09:22:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-05 09:22:15',
        'ENTRANCE'
    ),
(
        506,
        29,
        '2024-11-05',
        '10:13:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-05 10:13:43',
        'ENTRANCE'
    ),
(
        507,
        31,
        '2024-11-05',
        '14:10:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-05 14:10:54',
        'ENTRANCE'
    ),
(
        508,
        28,
        '2024-11-05',
        '17:46:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-05 17:46:33',
        'EXIT'
    ),
(
        509,
        30,
        '2024-11-05',
        '18:00:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-05 18:00:05',
        'EXIT'
    ),
(
        510,
        38,
        '2024-11-05',
        '18:09:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-05 18:09:52',
        'EXIT'
    ),
(
        511,
        31,
        '2024-11-05',
        '18:44:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-05 18:44:06',
        'EXIT'
    ),
(
        512,
        29,
        '2024-11-05',
        '18:44:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-05 18:44:23',
        'EXIT'
    ),
(
        513,
        38,
        '2024-11-06',
        '08:49:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-06 08:49:03',
        'ENTRANCE'
    ),
(
        514,
        28,
        '2024-11-06',
        '08:50:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-06 08:50:22',
        'ENTRANCE'
    ),
(
        515,
        30,
        '2024-11-06',
        '08:51:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-06 08:51:04',
        'ENTRANCE'
    ),
(
        516,
        27,
        '2024-11-06',
        '09:15:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-06 09:15:19',
        'ENTRANCE'
    ),
(
        517,
        29,
        '2024-11-06',
        '09:58:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-06 09:58:11',
        'ENTRANCE'
    ),
(
        518,
        30,
        '2024-11-06',
        '17:57:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-06 17:57:59',
        'EXIT'
    ),
(
        519,
        28,
        '2024-11-06',
        '17:59:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-06 17:59:34',
        'EXIT'
    ),
(
        520,
        38,
        '2024-11-06',
        '18:02:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-06 18:02:17',
        'EXIT'
    ),
(
        521,
        29,
        '2024-11-06',
        '18:46:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-06 18:46:24',
        'EXIT'
    ),
(
        522,
        31,
        '2024-11-06',
        '18:46:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-06 18:46:54',
        'EXIT'
    ),
(
        523,
        28,
        '2024-11-07',
        '08:56:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-07 08:56:27',
        'ENTRANCE'
    ),
(
        524,
        38,
        '2024-11-07',
        '08:56:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-07 08:56:38',
        'ENTRANCE'
    ),
(
        525,
        34,
        '2024-11-07',
        '09:05:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-07 09:05:38',
        'ENTRANCE'
    ),
(
        526,
        27,
        '2024-11-07',
        '09:17:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-07 09:17:03',
        'ENTRANCE'
    ),
(
        527,
        29,
        '2024-11-07',
        '09:54:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-07 09:54:48',
        'ENTRANCE'
    ),
(
        528,
        28,
        '2024-11-07',
        '17:41:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-07 17:41:59',
        'EXIT'
    ),
(
        529,
        29,
        '2024-11-07',
        '18:10:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-07 18:10:12',
        'EXIT'
    ),
(
        530,
        38,
        '2024-11-07',
        '18:55:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-07 18:55:37',
        'EXIT'
    ),
(
        531,
        34,
        '2024-11-08',
        '08:58:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-08 08:58:51',
        'ENTRANCE'
    ),
(
        532,
        30,
        '2024-11-08',
        '08:59:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-08 08:59:31',
        'ENTRANCE'
    ),
(
        533,
        38,
        '2024-11-08',
        '09:19:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-08 09:19:03',
        'ENTRANCE'
    ),
(
        534,
        27,
        '2024-11-08',
        '09:19:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-08 09:19:35',
        'ENTRANCE'
    ),
(
        535,
        38,
        '2024-11-08',
        '17:55:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-08 17:55:44',
        'EXIT'
    ),
(
        536,
        30,
        '2024-11-08',
        '17:59:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-08 17:59:08',
        'EXIT'
    ),
(
        537,
        31,
        '2024-11-08',
        '18:45:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-08 18:45:23',
        'EXIT'
    ),
(
        538,
        34,
        '2024-11-09',
        '09:53:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-09 09:53:50',
        'ENTRANCE'
    ),
(
        539,
        38,
        '2024-11-09',
        '09:01:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-09 09:01:35',
        'ENTRANCE'
    ),
(
        540,
        29,
        '2024-11-09',
        '09:59:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-09 09:59:05',
        'ENTRANCE'
    ),
(
        541,
        28,
        '2024-11-09',
        '08:51:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-09 08:51:48',
        'ENTRANCE'
    ),
(
        542,
        27,
        '2024-11-09',
        '09:10:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-09 09:10:19',
        'ENTRANCE'
    ),
(
        543,
        31,
        '2024-11-09',
        '14:20:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-09 14:20:57',
        'ENTRANCE'
    ),
(
        544,
        38,
        '2024-11-09',
        '15:05:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-09 15:05:03',
        'EXIT'
    ),
(
        545,
        31,
        '2024-11-09',
        '18:44:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-09 18:44:30',
        'EXIT'
    ),
(
        546,
        29,
        '2024-11-09',
        '18:44:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-09 18:44:45',
        'EXIT'
    ),
(
        547,
        30,
        '2024-11-09',
        '18:53:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-09 18:53:42',
        'EXIT'
    ),
(
        548,
        30,
        '2024-11-10',
        '09:11:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-10 09:11:55',
        'ENTRANCE'
    ),
(
        549,
        29,
        '2024-11-10',
        '10:16:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-10 10:16:39',
        'ENTRANCE'
    ),
(
        550,
        33,
        '2024-11-10',
        '10:47:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-10 10:47:49',
        'ENTRANCE'
    ),
(
        551,
        31,
        '2024-11-10',
        '14:08:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-10 14:08:56',
        'ENTRANCE'
    ),
(
        552,
        30,
        '2024-11-10',
        '17:58:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-10 17:58:32',
        'EXIT'
    ),
(
        553,
        31,
        '2024-11-10',
        '18:48:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-10 18:48:03',
        'EXIT'
    ),
(
        554,
        29,
        '2024-11-10',
        '18:48:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-10 18:48:27',
        'EXIT'
    ),
(
        555,
        33,
        '2024-11-10',
        '19:01:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-10 19:01:03',
        'EXIT'
    ),
(
        556,
        38,
        '2024-11-11',
        '08:54:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-11 08:54:48',
        'ENTRANCE'
    ),
(
        557,
        34,
        '2024-11-11',
        '08:57:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-11 08:57:29',
        'ENTRANCE'
    ),
(
        558,
        30,
        '2024-11-11',
        '09:06:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-11 09:06:31',
        'ENTRANCE'
    ),
(
        559,
        27,
        '2024-11-11',
        '09:13:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-11 09:13:56',
        'ENTRANCE'
    ),
(
        560,
        28,
        '2024-11-11',
        '09:14:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-11 09:14:49',
        'ENTRANCE'
    ),
(
        561,
        29,
        '2024-11-11',
        '10:08:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-11 10:08:33',
        'ENTRANCE'
    ),
(
        562,
        31,
        '2024-11-11',
        '14:19:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-11 14:19:22',
        'ENTRANCE'
    ),
(
        563,
        38,
        '2024-11-11',
        '18:03:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-11 18:03:54',
        'EXIT'
    ),
(
        564,
        30,
        '2024-11-11',
        '18:19:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-11 18:19:58',
        'EXIT'
    ),
(
        565,
        31,
        '2024-11-11',
        '18:44:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-11 18:44:46',
        'EXIT'
    ),
(
        566,
        29,
        '2024-11-11',
        '18:45:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-11 18:45:04',
        'EXIT'
    ),
(
        567,
        28,
        '2024-11-12',
        '08:50:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-12 08:50:14',
        'ENTRANCE'
    ),
(
        568,
        34,
        '2024-11-12',
        '08:55:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-12 08:55:36',
        'ENTRANCE'
    ),
(
        569,
        38,
        '2024-11-12',
        '08:57:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-12 08:57:56',
        'ENTRANCE'
    ),
(
        570,
        30,
        '2024-11-12',
        '09:04:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-12 09:04:55',
        'ENTRANCE'
    ),
(
        571,
        27,
        '2024-11-12',
        '09:17:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-12 09:17:21',
        'ENTRANCE'
    ),
(
        572,
        36,
        '2024-11-12',
        '09:28:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-12 09:28:42',
        'ENTRANCE'
    ),
(
        573,
        29,
        '2024-11-12',
        '09:40:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-12 09:40:46',
        'ENTRANCE'
    ),
(
        574,
        31,
        '2024-11-12',
        '14:03:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-12 14:03:19',
        'ENTRANCE'
    ),
(
        575,
        38,
        '2024-11-12',
        '17:29:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-12 17:29:07',
        'EXIT'
    ),
(
        576,
        30,
        '2024-11-12',
        '17:58:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-12 17:58:12',
        'EXIT'
    ),
(
        577,
        31,
        '2024-11-12',
        '18:44:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-12 18:44:38',
        'EXIT'
    ),
(
        578,
        29,
        '2024-11-12',
        '18:44:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-12 18:44:53',
        'EXIT'
    ),
(
        579,
        34,
        '2024-11-13',
        '08:42:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-13 08:42:06',
        'ENTRANCE'
    ),
(
        580,
        30,
        '2024-11-13',
        '08:59:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-13 08:59:18',
        'ENTRANCE'
    ),
(
        581,
        38,
        '2024-11-13',
        '09:00:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-13 09:00:04',
        'ENTRANCE'
    ),
(
        582,
        27,
        '2024-11-13',
        '09:07:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-13 09:07:07',
        'ENTRANCE'
    ),
(
        583,
        28,
        '2024-11-13',
        '09:20:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-13 09:20:15',
        'ENTRANCE'
    ),
(
        584,
        29,
        '2024-11-13',
        '09:52:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-13 09:52:14',
        'ENTRANCE'
    ),
(
        585,
        31,
        '2024-11-13',
        '14:09:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-13 14:09:53',
        'ENTRANCE'
    ),
(
        586,
        30,
        '2024-11-13',
        '17:59:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-13 17:59:22',
        'EXIT'
    ),
(
        587,
        38,
        '2024-11-13',
        '18:38:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-13 18:38:58',
        'EXIT'
    ),
(
        588,
        31,
        '2024-11-13',
        '18:46:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-13 18:46:34',
        'EXIT'
    ),
(
        589,
        29,
        '2024-11-13',
        '18:46:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-13 18:46:54',
        'EXIT'
    ),
(
        590,
        30,
        '2024-11-14',
        '08:25:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-14 08:25:02',
        'ENTRANCE'
    ),
(
        591,
        34,
        '2024-11-14',
        '08:36:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-14 08:36:25',
        'ENTRANCE'
    ),
(
        592,
        38,
        '2024-11-14',
        '08:57:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-14 08:57:40',
        'ENTRANCE'
    ),
(
        593,
        28,
        '2024-11-14',
        '09:04:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-14 09:04:47',
        'ENTRANCE'
    ),
(
        594,
        27,
        '2024-11-14',
        '09:16:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-14 09:16:12',
        'ENTRANCE'
    ),
(
        595,
        29,
        '2024-11-14',
        '09:59:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-14 09:59:40',
        'ENTRANCE'
    ),
(
        596,
        28,
        '2024-11-14',
        '17:57:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-14 17:57:20',
        'EXIT'
    ),
(
        597,
        30,
        '2024-11-14',
        '18:00:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-14 18:00:57',
        'EXIT'
    ),
(
        598,
        29,
        '2024-11-14',
        '18:02:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-14 18:02:56',
        'EXIT'
    ),
(
        599,
        38,
        '2024-11-14',
        '18:15:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-14 18:15:31',
        'EXIT'
    ),
(
        600,
        30,
        '2024-11-15',
        '08:15:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-15 08:15:16',
        'ENTRANCE'
    ),
(
        601,
        38,
        '2024-11-15',
        '08:52:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-15 08:52:29',
        'ENTRANCE'
    ),
(
        602,
        34,
        '2024-11-15',
        '09:02:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-15 09:02:18',
        'ENTRANCE'
    ),
(
        603,
        28,
        '2024-11-15',
        '09:03:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-15 09:03:49',
        'ENTRANCE'
    ),
(
        604,
        27,
        '2024-11-15',
        '09:12:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-15 09:12:05',
        'ENTRANCE'
    ),
(
        605,
        38,
        '2024-11-15',
        '18:02:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-15 18:02:07',
        'EXIT'
    ),
(
        606,
        30,
        '2024-11-15',
        '18:02:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-15 18:02:18',
        'EXIT'
    ),
(
        607,
        31,
        '2024-11-15',
        '18:47:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-15 18:47:07',
        'EXIT'
    ),
(
        608,
        38,
        '2024-11-16',
        '09:14:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-16 09:14:29',
        'ENTRANCE'
    ),
(
        609,
        28,
        '2024-11-16',
        '09:12:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-16 09:12:48',
        'ENTRANCE'
    ),
(
        610,
        27,
        '2024-11-16',
        '09:10:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-16 09:10:13',
        'ENTRANCE'
    ),
(
        611,
        34,
        '2024-11-16',
        '09:11:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-16 09:11:30',
        'ENTRANCE'
    ),
(
        612,
        29,
        '2024-11-16',
        '09:48:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-16 09:48:02',
        'ENTRANCE'
    ),
(
        613,
        33,
        '2024-11-16',
        '10:59:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-16 10:59:34',
        'ENTRANCE'
    ),
(
        614,
        31,
        '2024-11-16',
        '14:05:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-16 14:05:59',
        'ENTRANCE'
    ),
(
        615,
        38,
        '2024-11-16',
        '15:08:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-16 15:08:26',
        'EXIT'
    ),
(
        616,
        28,
        '2024-11-16',
        '15:10:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-16 15:10:46',
        'EXIT'
    ),
(
        617,
        31,
        '2024-11-16',
        '18:44:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-16 18:44:24',
        'EXIT'
    ),
(
        618,
        29,
        '2024-11-16',
        '18:44:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-16 18:44:42',
        'EXIT'
    ),
(
        619,
        33,
        '2024-11-16',
        '19:02:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-16 19:02:52',
        'EXIT'
    ),
(
        620,
        30,
        '2024-11-17',
        '09:40:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-17 09:40:14',
        'ENTRANCE'
    ),
(
        621,
        29,
        '2024-11-17',
        '10:03:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-17 10:03:50',
        'ENTRANCE'
    ),
(
        622,
        33,
        '2024-11-17',
        '11:10:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-17 11:10:25',
        'ENTRANCE'
    ),
(
        623,
        31,
        '2024-11-17',
        '14:07:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-17 14:07:12',
        'ENTRANCE'
    ),
(
        624,
        31,
        '2024-11-17',
        '18:47:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-17 18:47:46',
        'EXIT'
    ),
(
        625,
        29,
        '2024-11-17',
        '18:48:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-17 18:48:09',
        'EXIT'
    ),
(
        626,
        33,
        '2024-11-17',
        '19:04:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-17 19:04:25',
        'EXIT'
    ),
(
        627,
        30,
        '2024-11-18',
        '09:45:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-18 09:45:29',
        'ENTRANCE'
    ),
(
        628,
        29,
        '2024-11-18',
        '10:14:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-18 10:14:18',
        'ENTRANCE'
    ),
(
        629,
        33,
        '2024-11-18',
        '11:21:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-18 11:21:40',
        'ENTRANCE'
    ),
(
        630,
        31,
        '2024-11-18',
        '14:07:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-18 14:07:37',
        'ENTRANCE'
    ),
(
        631,
        31,
        '2024-11-18',
        '18:50:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-18 18:50:59',
        'EXIT'
    ),
(
        632,
        29,
        '2024-11-18',
        '18:51:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-18 18:51:15',
        'EXIT'
    ),
(
        633,
        33,
        '2024-11-18',
        '19:17:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-18 19:17:31',
        'EXIT'
    ),
(
        634,
        28,
        '2024-11-19',
        '08:32:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-19 08:32:00',
        'ENTRANCE'
    ),
(
        635,
        38,
        '2024-11-19',
        '09:00:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-19 09:00:21',
        'ENTRANCE'
    ),
(
        636,
        30,
        '2024-11-19',
        '09:03:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-19 09:03:05',
        'ENTRANCE'
    ),
(
        637,
        34,
        '2024-11-19',
        '09:05:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-19 09:05:40',
        'ENTRANCE'
    ),
(
        638,
        27,
        '2024-11-19',
        '09:20:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-19 09:20:05',
        'ENTRANCE'
    ),
(
        639,
        29,
        '2024-11-19',
        '10:02:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-19 10:02:56',
        'ENTRANCE'
    ),
(
        640,
        33,
        '2024-11-19',
        '11:01:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-19 11:01:54',
        'ENTRANCE'
    ),
(
        641,
        31,
        '2024-11-19',
        '14:10:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-19 14:10:42',
        'ENTRANCE'
    ),
(
        642,
        38,
        '2024-11-19',
        '18:18:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-19 18:18:28',
        'EXIT'
    ),
(
        643,
        28,
        '2024-11-19',
        '18:21:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-19 18:21:52',
        'EXIT'
    ),
(
        644,
        34,
        '2024-11-20',
        '08:34:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-20 08:34:55',
        'ENTRANCE'
    ),
(
        645,
        38,
        '2024-11-20',
        '09:00:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-20 09:00:14',
        'ENTRANCE'
    ),
(
        646,
        27,
        '2024-11-20',
        '09:08:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-20 09:08:43',
        'ENTRANCE'
    ),
(
        647,
        33,
        '2024-11-23',
        '11:01:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-23 11:01:47',
        'ENTRANCE'
    ),
(
        648,
        31,
        '2024-11-23',
        '15:20:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-23 15:20:03',
        'ENTRANCE'
    ),
(
        649,
        29,
        '2024-11-23',
        '15:20:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-23 15:20:33',
        'ENTRANCE'
    ),
(
        650,
        30,
        '2024-11-23',
        '09:00:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-23 09:00:01',
        'ENTRANCE'
    ),
(
        651,
        29,
        '2024-11-23',
        '18:42:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-23 18:42:24',
        'EXIT'
    ),
(
        652,
        31,
        '2024-11-23',
        '18:42:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-23 18:42:40',
        'EXIT'
    ),
(
        653,
        33,
        '2024-11-23',
        '19:06:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-23 19:06:46',
        'EXIT'
    ),
(
        654,
        30,
        '2024-11-24',
        '09:21:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-24 09:21:29',
        'ENTRANCE'
    ),
(
        655,
        29,
        '2024-11-24',
        '10:13:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-24 10:13:25',
        'ENTRANCE'
    ),
(
        656,
        33,
        '2024-11-24',
        '10:54:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-24 10:54:05',
        'ENTRANCE'
    ),
(
        657,
        37,
        '2024-11-24',
        '11:07:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-24 11:07:26',
        'ENTRANCE'
    ),
(
        658,
        31,
        '2024-11-24',
        '14:12:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-24 14:12:32',
        'ENTRANCE'
    ),
(
        659,
        31,
        '2024-11-24',
        '18:43:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-24 18:43:40',
        'EXIT'
    ),
(
        660,
        29,
        '2024-11-24',
        '18:43:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-24 18:43:58',
        'EXIT'
    ),
(
        661,
        33,
        '2024-11-24',
        '19:05:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-24 19:05:08',
        'EXIT'
    ),
(
        662,
        34,
        '2024-11-25',
        '08:36:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-25 08:36:32',
        'ENTRANCE'
    ),
(
        663,
        38,
        '2024-11-25',
        '08:59:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-25 08:59:47',
        'ENTRANCE'
    ),
(
        664,
        30,
        '2024-11-25',
        '09:08:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-25 09:08:53',
        'ENTRANCE'
    ),
(
        665,
        27,
        '2024-11-25',
        '09:13:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-25 09:13:06',
        'ENTRANCE'
    ),
(
        666,
        29,
        '2024-11-25',
        '10:05:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-25 10:05:37',
        'ENTRANCE'
    ),
(
        667,
        32,
        '2024-11-25',
        '11:16:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-25 11:16:18',
        'ENTRANCE'
    ),
(
        668,
        31,
        '2024-11-25',
        '14:07:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-25 14:07:02',
        'ENTRANCE'
    ),
(
        669,
        31,
        '2024-11-20',
        '14:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-20 14:00:00',
        'ENTRANCE'
    ),
(
        670,
        31,
        '2024-11-22',
        '14:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x66) AppleWeb',
        '2024-11-22 14:00:00',
        'ENTRANCE'
    ),
(
        671,
        31,
        '2024-11-23',
        '14:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x67) AppleWeb',
        '2024-11-23 14:00:00',
        'ENTRANCE'
    ),
(
        672,
        31,
        '2024-11-24',
        '14:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x68) AppleWeb',
        '2024-11-24 14:00:00',
        'ENTRANCE'
    ),
(
        673,
        29,
        '2024-11-20',
        '10:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-20 10:00:00',
        'ENTRANCE'
    ),
(
        674,
        29,
        '2024-11-21',
        '10:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x65) AppleWeb',
        '2024-11-21 10:00:00',
        'ENTRANCE'
    ),
(
        675,
        29,
        '2024-11-23',
        '10:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x67) AppleWeb',
        '2024-11-23 10:00:00',
        'ENTRANCE'
    ),
(
        676,
        29,
        '2024-11-24',
        '10:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x68) AppleWeb',
        '2024-11-24 10:00:00',
        'ENTRANCE'
    ),
(
        677,
        30,
        '2024-11-20',
        '09:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-20 09:00:00',
        'ENTRANCE'
    ),
(
        678,
        30,
        '2024-11-20',
        '09:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-20 09:00:00',
        'ENTRANCE'
    ),
(
        679,
        30,
        '2024-11-22',
        '09:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x66) AppleWeb',
        '2024-11-22 09:00:00',
        'ENTRANCE'
    ),
(
        680,
        30,
        '2024-11-25',
        '18:01:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-25 18:01:17',
        'EXIT'
    ),
(
        681,
        27,
        '2024-11-20',
        '09:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-20 09:00:00',
        'ENTRANCE'
    ),
(
        682,
        27,
        '2024-11-21',
        '09:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x65) AppleWeb',
        '2024-11-21 09:00:00',
        'ENTRANCE'
    ),
(
        683,
        27,
        '2024-11-22',
        '09:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x66) AppleWeb',
        '2024-11-22 09:00:00',
        'ENTRANCE'
    ),
(
        684,
        27,
        '2024-11-23',
        '09:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x67) AppleWeb',
        '2024-11-23 09:00:00',
        'ENTRANCE'
    ),
(
        685,
        38,
        '2024-11-21',
        '09:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x65) AppleWeb',
        '2024-11-21 09:00:00',
        'ENTRANCE'
    ),
(
        686,
        38,
        '2024-11-22',
        '09:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x66) AppleWeb',
        '2024-11-22 09:00:00',
        'ENTRANCE'
    ),
(
        687,
        38,
        '2024-11-23',
        '09:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x67) AppleWeb',
        '2024-11-23 09:00:00',
        'ENTRANCE'
    ),
(
        688,
        34,
        '2024-11-21',
        '09:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x65) AppleWeb',
        '2024-11-21 09:00:00',
        'ENTRANCE'
    ),
(
        689,
        34,
        '2024-11-22',
        '09:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x66) AppleWeb',
        '2024-11-22 09:00:00',
        'ENTRANCE'
    ),
(
        690,
        34,
        '2024-11-23',
        '09:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x67) AppleWeb',
        '2024-11-23 09:00:00',
        'ENTRANCE'
    ),
(
        691,
        38,
        '2024-11-25',
        '18:23:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-25 18:23:41',
        'EXIT'
    ),
(
        692,
        31,
        '2024-11-25',
        '18:43:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-25 18:43:28',
        'EXIT'
    ),
(
        693,
        29,
        '2024-11-25',
        '18:43:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-25 18:43:50',
        'EXIT'
    ),
(
        694,
        32,
        '2024-11-25',
        '19:07:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-25 19:07:25',
        'EXIT'
    ),
(
        695,
        34,
        '2024-11-26',
        '08:48:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-26 08:48:07',
        'ENTRANCE'
    ),
(
        696,
        38,
        '2024-11-26',
        '09:05:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-26 09:05:07',
        'ENTRANCE'
    ),
(
        697,
        30,
        '2024-11-26',
        '09:05:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-26 09:05:18',
        'ENTRANCE'
    ),
(
        698,
        27,
        '2024-11-26',
        '09:09:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-26 09:09:30',
        'ENTRANCE'
    ),
(
        699,
        28,
        '2024-11-26',
        '09:10:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-26 09:10:16',
        'ENTRANCE'
    ),
(
        700,
        36,
        '2024-11-26',
        '09:19:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-26 09:19:46',
        'ENTRANCE'
    ),
(
        701,
        29,
        '2024-11-26',
        '09:55:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-26 09:55:50',
        'ENTRANCE'
    ),
(
        702,
        37,
        '2024-11-26',
        '10:41:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-26 10:41:25',
        'ENTRANCE'
    ),
(
        703,
        33,
        '2024-11-26',
        '10:49:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-26 10:49:35',
        'ENTRANCE'
    ),
(
        704,
        28,
        '2024-11-26',
        '17:58:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-26 17:58:59',
        'EXIT'
    ),
(
        705,
        30,
        '2024-11-26',
        '17:59:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-26 17:59:59',
        'EXIT'
    ),
(
        706,
        31,
        '2024-11-26',
        '18:43:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-26 18:43:23',
        'EXIT'
    ),
(
        707,
        29,
        '2024-11-26',
        '18:44:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-26 18:44:01',
        'EXIT'
    ),
(
        708,
        33,
        '2024-11-26',
        '19:08:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-26 19:08:02',
        'EXIT'
    ),
(
        709,
        34,
        '2024-11-27',
        '08:54:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-27 08:54:16',
        'ENTRANCE'
    ),
(
        710,
        38,
        '2024-11-27',
        '08:59:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-27 08:59:14',
        'ENTRANCE'
    ),
(
        711,
        30,
        '2024-11-27',
        '09:08:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-27 09:08:50',
        'ENTRANCE'
    ),
(
        712,
        27,
        '2024-11-27',
        '09:14:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-27 09:14:05',
        'ENTRANCE'
    ),
(
        713,
        28,
        '2024-11-27',
        '09:15:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-27 09:15:53',
        'ENTRANCE'
    ),
(
        714,
        29,
        '2024-11-27',
        '10:09:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-27 10:09:32',
        'ENTRANCE'
    ),
(
        715,
        32,
        '2024-11-27',
        '11:09:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-27 11:09:38',
        'ENTRANCE'
    ),
(
        716,
        37,
        '2024-11-27',
        '11:23:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-27 11:23:41',
        'ENTRANCE'
    ),
(
        717,
        31,
        '2024-11-27',
        '14:17:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-27 14:17:30',
        'ENTRANCE'
    ),
(
        718,
        38,
        '2024-11-27',
        '18:24:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-27 18:24:11',
        'EXIT'
    ),
(
        719,
        30,
        '2024-11-27',
        '18:31:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-27 18:31:58',
        'EXIT'
    ),
(
        720,
        31,
        '2024-11-27',
        '18:45:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-27 18:45:01',
        'EXIT'
    ),
(
        721,
        29,
        '2024-11-27',
        '18:45:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-27 18:45:28',
        'EXIT'
    ),
(
        722,
        32,
        '2024-11-27',
        '18:59:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-27 18:59:53',
        'EXIT'
    ),
(
        723,
        38,
        '2024-11-28',
        '09:01:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-28 09:01:17',
        'ENTRANCE'
    ),
(
        724,
        34,
        '2024-11-28',
        '09:02:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-28 09:02:44',
        'ENTRANCE'
    ),
(
        725,
        28,
        '2024-11-28',
        '09:10:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-28 09:10:58',
        'ENTRANCE'
    ),
(
        726,
        29,
        '2024-11-28',
        '10:22:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-28 10:22:05',
        'ENTRANCE'
    ),
(
        727,
        32,
        '2024-11-28',
        '11:09:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-28 11:09:38',
        'ENTRANCE'
    ),
(
        728,
        37,
        '2024-11-28',
        '11:15:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-28 11:15:43',
        'ENTRANCE'
    ),
(
        729,
        29,
        '2024-11-28',
        '17:57:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-28 17:57:33',
        'EXIT'
    ),
(
        730,
        32,
        '2024-11-28',
        '19:00:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-28 19:00:55',
        'EXIT'
    ),
(
        731,
        34,
        '2024-11-29',
        '08:36:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-29 08:36:46',
        'ENTRANCE'
    ),
(
        732,
        38,
        '2024-11-29',
        '09:06:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-29 09:06:49',
        'ENTRANCE'
    ),
(
        733,
        27,
        '2024-11-29',
        '09:07:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-29 09:07:11',
        'ENTRANCE'
    ),
(
        734,
        28,
        '2024-11-29',
        '09:18:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-29 09:18:04',
        'ENTRANCE'
    ),
(
        735,
        37,
        '2024-11-29',
        '11:03:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-29 11:03:54',
        'ENTRANCE'
    ),
(
        736,
        32,
        '2024-11-29',
        '11:13:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-29 11:13:03',
        'ENTRANCE'
    ),
(
        737,
        31,
        '2024-11-29',
        '12:19:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-29 12:19:14',
        'ENTRANCE'
    ),
(
        738,
        30,
        '2024-11-29',
        '18:00:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-29 18:00:50',
        'EXIT'
    ),
(
        739,
        38,
        '2024-11-29',
        '18:04:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-29 18:04:10',
        'EXIT'
    ),
(
        740,
        31,
        '2024-11-29',
        '18:43:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-29 18:43:02',
        'EXIT'
    ),
(
        741,
        32,
        '2024-11-29',
        '18:57:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-29 18:57:29',
        'EXIT'
    ),
(
        742,
        38,
        '2024-11-30',
        '08:46:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-30 08:46:40',
        'ENTRANCE'
    ),
(
        743,
        28,
        '2024-11-30',
        '08:47:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-30 08:47:03',
        'ENTRANCE'
    ),
(
        744,
        30,
        '2024-11-30',
        '09:31:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-30 09:31:30',
        'ENTRANCE'
    ),
(
        745,
        27,
        '2024-11-30',
        '09:33:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-30 09:33:11',
        'ENTRANCE'
    ),
(
        746,
        34,
        '2024-11-30',
        '09:39:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-30 09:39:52',
        'ENTRANCE'
    ),
(
        747,
        29,
        '2024-11-30',
        '10:23:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-30 10:23:13',
        'ENTRANCE'
    ),
(
        748,
        32,
        '2024-11-30',
        '11:02:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-30 11:02:54',
        'ENTRANCE'
    ),
(
        749,
        37,
        '2024-11-30',
        '11:03:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-30 11:03:40',
        'ENTRANCE'
    ),
(
        750,
        31,
        '2024-11-30',
        '13:50:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-30 13:50:27',
        'ENTRANCE'
    ),
(
        751,
        28,
        '2024-11-30',
        '14:58:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-30 14:58:08',
        'EXIT'
    ),
(
        752,
        38,
        '2024-11-30',
        '14:58:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-30 14:58:30',
        'EXIT'
    ),
(
        753,
        27,
        '2024-11-30',
        '14:58:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-30 14:58:49',
        'EXIT'
    ),
(
        754,
        31,
        '2024-11-30',
        '18:44:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-30 18:44:42',
        'EXIT'
    ),
(
        755,
        29,
        '2024-11-30',
        '18:45:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-30 18:45:32',
        'EXIT'
    ),
(
        756,
        32,
        '2024-11-30',
        '18:58:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-11-30 18:58:58',
        'EXIT'
    ),
(
        757,
        30,
        '2024-12-01',
        '09:12:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-01 09:12:40',
        'ENTRANCE'
    ),
(
        758,
        29,
        '2024-12-01',
        '10:16:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-01 10:16:29',
        'ENTRANCE'
    ),
(
        759,
        33,
        '2024-12-01',
        '11:12:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-01 11:12:12',
        'ENTRANCE'
    ),
(
        760,
        31,
        '2024-12-01',
        '14:08:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-01 14:08:19',
        'ENTRANCE'
    ),
(
        761,
        31,
        '2024-12-01',
        '18:44:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-01 18:44:28',
        'EXIT'
    ),
(
        762,
        29,
        '2024-12-01',
        '18:45:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-01 18:45:23',
        'EXIT'
    ),
(
        763,
        33,
        '2024-12-01',
        '19:00:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-01 19:00:53',
        'EXIT'
    ),
(
        764,
        30,
        '2024-12-02',
        '08:59:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-02 08:59:49',
        'ENTRANCE'
    ),
(
        765,
        34,
        '2024-12-02',
        '09:03:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-02 09:03:52',
        'ENTRANCE'
    ),
(
        766,
        28,
        '2024-12-02',
        '09:10:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-02 09:10:25',
        'ENTRANCE'
    ),
(
        767,
        38,
        '2024-12-02',
        '09:16:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-02 09:16:00',
        'ENTRANCE'
    ),
(
        768,
        27,
        '2024-12-02',
        '09:22:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-02 09:22:34',
        'ENTRANCE'
    ),
(
        769,
        29,
        '2024-12-02',
        '10:06:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-02 10:06:53',
        'ENTRANCE'
    ),
(
        770,
        37,
        '2024-12-02',
        '10:53:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-02 10:53:13',
        'ENTRANCE'
    ),
(
        771,
        31,
        '2024-12-02',
        '14:07:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-02 14:07:42',
        'ENTRANCE'
    ),
(
        772,
        38,
        '2024-12-02',
        '17:32:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-02 17:32:05',
        'EXIT'
    ),
(
        773,
        28,
        '2024-12-02',
        '17:56:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-02 17:56:04',
        'EXIT'
    ),
(
        774,
        31,
        '2024-12-02',
        '18:43:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-02 18:43:01',
        'EXIT'
    ),
(
        775,
        29,
        '2024-12-02',
        '18:43:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-02 18:43:20',
        'EXIT'
    ),
(
        776,
        32,
        '2024-12-02',
        '19:03:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-02 19:03:00',
        'EXIT'
    ),
(
        777,
        28,
        '2024-12-03',
        '08:20:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-03 08:20:20',
        'ENTRANCE'
    ),
(
        778,
        30,
        '2024-12-03',
        '09:04:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-03 09:04:59',
        'ENTRANCE'
    ),
(
        779,
        34,
        '2024-12-03',
        '09:12:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-03 09:12:14',
        'ENTRANCE'
    ),
(
        780,
        27,
        '2024-12-03',
        '09:24:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-03 09:24:40',
        'ENTRANCE'
    ),
(
        781,
        29,
        '2024-12-03',
        '10:14:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-03 10:14:01',
        'ENTRANCE'
    ),
(
        782,
        37,
        '2024-12-03',
        '10:48:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-03 10:48:10',
        'ENTRANCE'
    ),
(
        783,
        38,
        '2024-12-03',
        '11:39:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-03 11:39:36',
        'ENTRANCE'
    ),
(
        784,
        31,
        '2024-12-03',
        '14:13:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-03 14:13:33',
        'ENTRANCE'
    ),
(
        785,
        30,
        '2024-12-03',
        '18:00:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-03 18:00:06',
        'EXIT'
    ),
(
        786,
        38,
        '2024-12-03',
        '18:01:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-03 18:01:31',
        'EXIT'
    ),
(
        787,
        31,
        '2024-12-03',
        '18:42:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-03 18:42:21',
        'EXIT'
    ),
(
        788,
        29,
        '2024-12-03',
        '18:42:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-03 18:42:42',
        'EXIT'
    ),
(
        789,
        38,
        '2024-12-04',
        '08:44:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-04 08:44:32',
        'ENTRANCE'
    ),
(
        790,
        34,
        '2024-12-04',
        '08:58:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-04 08:58:32',
        'ENTRANCE'
    ),
(
        791,
        30,
        '2024-12-04',
        '09:02:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-04 09:02:14',
        'ENTRANCE'
    ),
(
        792,
        27,
        '2024-12-04',
        '09:20:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-04 09:20:05',
        'ENTRANCE'
    ),
(
        793,
        29,
        '2024-12-04',
        '09:54:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-04 09:54:57',
        'ENTRANCE'
    ),
(
        794,
        32,
        '2024-12-04',
        '11:08:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-04 11:08:24',
        'ENTRANCE'
    ),
(
        795,
        31,
        '2024-12-04',
        '14:10:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-04 14:10:55',
        'ENTRANCE'
    ),
(
        796,
        30,
        '2024-12-04',
        '18:20:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-04 18:20:11',
        'EXIT'
    ),
(
        797,
        38,
        '2024-12-04',
        '18:32:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-04 18:32:04',
        'EXIT'
    ),
(
        798,
        31,
        '2024-12-04',
        '18:44:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-04 18:44:08',
        'EXIT'
    ),
(
        799,
        29,
        '2024-12-04',
        '18:44:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-04 18:44:23',
        'EXIT'
    ),
(
        800,
        32,
        '2024-12-04',
        '18:58:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-04 18:58:19',
        'EXIT'
    ),
(
        801,
        34,
        '2024-12-05',
        '08:35:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-05 08:35:16',
        'ENTRANCE'
    ),
(
        802,
        38,
        '2024-12-05',
        '08:58:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-05 08:58:39',
        'ENTRANCE'
    ),
(
        803,
        28,
        '2024-12-05',
        '09:08:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-05 09:08:53',
        'ENTRANCE'
    ),
(
        804,
        37,
        '2024-12-05',
        '09:59:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-05 09:59:12',
        'ENTRANCE'
    ),
(
        805,
        29,
        '2024-12-05',
        '10:14:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-05 10:14:33',
        'ENTRANCE'
    ),
(
        806,
        32,
        '2024-12-05',
        '11:24:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-05 11:24:01',
        'ENTRANCE'
    ),
(
        807,
        38,
        '2024-12-05',
        '18:05:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-05 18:05:10',
        'EXIT'
    ),
(
        808,
        28,
        '2024-12-05',
        '18:14:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-05 18:14:53',
        'EXIT'
    ),
(
        809,
        32,
        '2024-12-05',
        '18:56:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-05 18:56:01',
        'EXIT'
    ),
(
        810,
        34,
        '2024-12-06',
        '08:28:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-06 08:28:50',
        'ENTRANCE'
    ),
(
        811,
        38,
        '2024-12-06',
        '08:51:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-06 08:51:32',
        'ENTRANCE'
    ),
(
        812,
        28,
        '2024-12-06',
        '08:58:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-06 08:58:01',
        'ENTRANCE'
    ),
(
        813,
        30,
        '2024-12-06',
        '09:05:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-06 09:05:54',
        'ENTRANCE'
    ),
(
        814,
        33,
        '2024-12-06',
        '10:59:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-06 10:59:52',
        'ENTRANCE'
    ),
(
        815,
        37,
        '2024-12-06',
        '11:03:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-06 11:03:40',
        'ENTRANCE'
    ),
(
        816,
        30,
        '2024-12-06',
        '17:59:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-06 17:59:53',
        'EXIT'
    ),
(
        817,
        31,
        '2024-12-06',
        '18:43:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-06 18:43:31',
        'EXIT'
    ),
(
        818,
        33,
        '2024-12-06',
        '19:08:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-06 19:08:29',
        'EXIT'
    ),
(
        819,
        28,
        '2024-12-07',
        '08:53:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-07 08:53:08',
        'ENTRANCE'
    ),
(
        820,
        38,
        '2024-12-07',
        '09:01:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-07 09:01:03',
        'ENTRANCE'
    ),
(
        821,
        27,
        '2024-12-07',
        '09:12:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-07 09:12:21',
        'ENTRANCE'
    ),
(
        822,
        34,
        '2024-12-07',
        '09:27:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-07 09:27:09',
        'ENTRANCE'
    ),
(
        823,
        29,
        '2024-12-07',
        '10:16:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-07 10:16:24',
        'ENTRANCE'
    ),
(
        824,
        37,
        '2024-12-07',
        '10:45:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-07 10:45:28',
        'ENTRANCE'
    ),
(
        825,
        33,
        '2024-12-07',
        '10:50:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-07 10:50:45',
        'ENTRANCE'
    ),
(
        826,
        28,
        '2024-12-07',
        '15:01:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-07 15:01:39',
        'EXIT'
    ),
(
        827,
        38,
        '2024-12-07',
        '15:32:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-07 15:32:01',
        'EXIT'
    ),
(
        828,
        31,
        '2024-12-07',
        '18:41:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-07 18:41:51',
        'EXIT'
    ),
(
        829,
        33,
        '2024-12-07',
        '18:57:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-07 18:57:55',
        'EXIT'
    ),
(
        830,
        29,
        '2024-12-08',
        '10:28:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-08 10:28:47',
        'ENTRANCE'
    ),
(
        831,
        37,
        '2024-12-08',
        '10:52:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-08 10:52:24',
        'ENTRANCE'
    ),
(
        832,
        33,
        '2024-12-08',
        '11:26:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-08 11:26:15',
        'ENTRANCE'
    ),
(
        833,
        31,
        '2024-12-08',
        '14:09:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-08 14:09:48',
        'ENTRANCE'
    ),
(
        834,
        31,
        '2024-12-08',
        '18:44:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-08 18:44:15',
        'EXIT'
    ),
(
        835,
        29,
        '2024-12-08',
        '18:44:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-08 18:44:30',
        'EXIT'
    ),
(
        836,
        33,
        '2024-12-08',
        '19:45:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-08 19:45:29',
        'EXIT'
    ),
(
        837,
        30,
        '2024-12-10',
        '09:08:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-10 09:08:58',
        'ENTRANCE'
    ),
(
        838,
        38,
        '2024-12-10',
        '09:29:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-10 09:29:45',
        'ENTRANCE'
    ),
(
        839,
        34,
        '2024-12-10',
        '09:35:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-10 09:35:02',
        'ENTRANCE'
    ),
(
        840,
        27,
        '2024-12-10',
        '09:14:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-10 09:14:47',
        'ENTRANCE'
    ),
(
        841,
        29,
        '2024-12-10',
        '10:18:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-10 10:18:32',
        'ENTRANCE'
    ),
(
        842,
        37,
        '2024-12-10',
        '11:07:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-10 11:07:55',
        'ENTRANCE'
    ),
(
        843,
        31,
        '2024-12-10',
        '14:06:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-10 14:06:38',
        'ENTRANCE'
    ),
(
        844,
        28,
        '2024-12-10',
        '17:28:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-10 17:28:35',
        'EXIT'
    ),
(
        845,
        30,
        '2024-12-10',
        '18:00:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-10 18:00:06',
        'EXIT'
    ),
(
        846,
        38,
        '2024-12-10',
        '18:07:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-10 18:07:51',
        'EXIT'
    ),
(
        847,
        31,
        '2024-12-10',
        '18:41:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-10 18:41:29',
        'EXIT'
    ),
(
        848,
        29,
        '2024-12-10',
        '18:41:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-10 18:41:43',
        'EXIT'
    ),
(
        849,
        30,
        '2024-12-11',
        '08:11:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-11 08:11:56',
        'ENTRANCE'
    ),
(
        850,
        34,
        '2024-12-11',
        '08:39:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-11 08:39:10',
        'ENTRANCE'
    ),
(
        851,
        38,
        '2024-12-11',
        '08:59:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-11 08:59:07',
        'ENTRANCE'
    ),
(
        852,
        29,
        '2024-12-11',
        '10:14:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-11 10:14:58',
        'ENTRANCE'
    ),
(
        853,
        37,
        '2024-12-11',
        '11:12:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-11 11:12:04',
        'ENTRANCE'
    ),
(
        854,
        31,
        '2024-12-11',
        '14:07:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-11 14:07:28',
        'ENTRANCE'
    ),
(
        855,
        38,
        '2024-12-11',
        '17:42:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-11 17:42:51',
        'EXIT'
    ),
(
        856,
        30,
        '2024-12-11',
        '18:17:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-11 18:17:00',
        'EXIT'
    ),
(
        857,
        31,
        '2024-12-11',
        '18:41:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-11 18:41:26',
        'EXIT'
    ),
(
        858,
        29,
        '2024-12-11',
        '18:41:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-11 18:41:40',
        'EXIT'
    ),
(
        859,
        28,
        '2024-12-12',
        '08:51:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-12 08:51:17',
        'ENTRANCE'
    ),
(
        860,
        38,
        '2024-12-12',
        '08:57:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-12 08:57:37',
        'ENTRANCE'
    ),
(
        861,
        34,
        '2024-12-12',
        '09:05:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-12 09:05:37',
        'ENTRANCE'
    ),
(
        862,
        29,
        '2024-12-12',
        '10:58:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-12 10:58:37',
        'ENTRANCE'
    ),
(
        863,
        37,
        '2024-12-12',
        '11:03:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-12 11:03:07',
        'ENTRANCE'
    ),
(
        864,
        38,
        '2024-12-12',
        '18:13:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-12 18:13:28',
        'EXIT'
    ),
(
        865,
        28,
        '2024-12-12',
        '18:20:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-12 18:20:02',
        'EXIT'
    ),
(
        866,
        37,
        '2024-12-12',
        '19:55:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-12 19:55:41',
        'EXIT'
    ),
(
        867,
        30,
        '2024-12-13',
        '08:22:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-13 08:22:39',
        'ENTRANCE'
    ),
(
        868,
        38,
        '2024-12-13',
        '09:03:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-13 09:03:27',
        'ENTRANCE'
    ),
(
        869,
        27,
        '2024-12-13',
        '09:14:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-13 09:14:58',
        'ENTRANCE'
    ),
(
        870,
        28,
        '2024-12-13',
        '09:26:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-13 09:26:23',
        'ENTRANCE'
    ),
(
        871,
        34,
        '2024-12-13',
        '09:44:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-13 09:44:28',
        'ENTRANCE'
    ),
(
        872,
        37,
        '2024-12-13',
        '11:07:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-13 11:07:02',
        'ENTRANCE'
    ),
(
        873,
        31,
        '2024-12-13',
        '12:15:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-13 12:15:07',
        'ENTRANCE'
    ),
(
        874,
        30,
        '2024-12-13',
        '18:06:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-13 18:06:06',
        'EXIT'
    ),
(
        875,
        28,
        '2024-12-13',
        '18:10:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-13 18:10:03',
        'EXIT'
    ),
(
        876,
        38,
        '2024-12-13',
        '18:27:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-13 18:27:21',
        'EXIT'
    ),
(
        877,
        31,
        '2024-12-13',
        '18:40:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-13 18:40:53',
        'EXIT'
    ),
(
        878,
        28,
        '2024-12-14',
        '08:54:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-14 08:54:36',
        'ENTRANCE'
    ),
(
        879,
        38,
        '2024-12-14',
        '09:05:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-14 09:05:57',
        'ENTRANCE'
    ),
(
        880,
        30,
        '2024-12-14',
        '09:25:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-14 09:25:57',
        'ENTRANCE'
    ),
(
        881,
        27,
        '2024-12-14',
        '09:10:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-14 09:10:56',
        'ENTRANCE'
    ),
(
        882,
        29,
        '2024-12-14',
        '10:21:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-14 10:21:00',
        'ENTRANCE'
    ),
(
        883,
        31,
        '2024-12-14',
        '14:08:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-14 14:08:39',
        'ENTRANCE'
    ),
(
        884,
        38,
        '2024-12-14',
        '15:06:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-14 15:06:44',
        'EXIT'
    ),
(
        885,
        28,
        '2024-12-14',
        '15:08:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-14 15:08:22',
        'EXIT'
    ),
(
        886,
        31,
        '2024-12-14',
        '18:40:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-14 18:40:48',
        'EXIT'
    ),
(
        887,
        29,
        '2024-12-14',
        '18:41:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-14 18:41:07',
        'EXIT'
    ),
(
        888,
        30,
        '2024-12-15',
        '09:23:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-15 09:23:40',
        'ENTRANCE'
    ),
(
        889,
        29,
        '2024-12-15',
        '10:09:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-15 10:09:58',
        'ENTRANCE'
    ),
(
        890,
        37,
        '2024-12-15',
        '10:59:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-15 10:59:58',
        'ENTRANCE'
    ),
(
        891,
        33,
        '2024-12-15',
        '11:09:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-15 11:09:02',
        'ENTRANCE'
    ),
(
        892,
        31,
        '2024-12-15',
        '14:05:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-15 14:05:41',
        'ENTRANCE'
    ),
(
        893,
        31,
        '2024-12-15',
        '18:44:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-15 18:44:24',
        'EXIT'
    ),
(
        894,
        29,
        '2024-12-15',
        '18:44:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-15 18:44:44',
        'EXIT'
    ),
(
        895,
        33,
        '2024-12-15',
        '19:20:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-15 19:20:25',
        'EXIT'
    ),
(
        896,
        34,
        '2024-12-16',
        '08:43:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 08:43:15',
        'ENTRANCE'
    ),
(
        897,
        38,
        '2024-12-16',
        '08:44:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 08:44:20',
        'ENTRANCE'
    ),
(
        898,
        28,
        '2024-12-16',
        '09:00:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 09:00:51',
        'ENTRANCE'
    ),
(
        899,
        30,
        '2024-12-16',
        '09:10:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 09:10:00',
        'ENTRANCE'
    ),
(
        900,
        27,
        '2024-12-16',
        '09:11:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 09:11:55',
        'ENTRANCE'
    ),
(
        901,
        29,
        '2024-12-16',
        '10:06:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 10:06:34',
        'ENTRANCE'
    ),
(
        902,
        37,
        '2024-12-16',
        '11:09:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 11:09:46',
        'ENTRANCE'
    ),
(
        903,
        32,
        '2024-12-16',
        '11:10:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 11:10:04',
        'ENTRANCE'
    ),
(
        904,
        31,
        '2024-12-16',
        '14:06:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 14:06:39',
        'ENTRANCE'
    ),
(
        905,
        30,
        '2024-12-16',
        '18:00:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 18:00:08',
        'EXIT'
    ),
(
        906,
        28,
        '2024-12-16',
        '18:07:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 18:07:45',
        'EXIT'
    ),
(
        907,
        31,
        '2024-12-16',
        '18:40:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 18:40:50',
        'EXIT'
    ),
(
        908,
        29,
        '2024-12-16',
        '18:41:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 18:41:04',
        'EXIT'
    ),
(
        909,
        27,
        '2024-12-16',
        '18:53:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 18:53:29',
        'EXIT'
    ),
(
        910,
        34,
        '2024-12-16',
        '18:54:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 18:54:20',
        'EXIT'
    ),
(
        911,
        38,
        '2024-12-16',
        '18:57:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 18:57:16',
        'EXIT'
    ),
(
        912,
        32,
        '2024-12-16',
        '19:11:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-16 19:11:21',
        'EXIT'
    ),
(
        913,
        34,
        '2024-12-17',
        '08:42:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-17 08:42:50',
        'ENTRANCE'
    ),
(
        914,
        28,
        '2024-12-17',
        '08:43:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-17 08:43:48',
        'ENTRANCE'
    ),
(
        915,
        30,
        '2024-12-17',
        '09:06:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-17 09:06:09',
        'ENTRANCE'
    ),
(
        916,
        38,
        '2024-12-17',
        '09:11:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-17 09:11:32',
        'ENTRANCE'
    ),
(
        917,
        29,
        '2024-12-17',
        '10:37:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-17 10:37:07',
        'ENTRANCE'
    ),
(
        918,
        37,
        '2024-12-17',
        '10:55:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-17 10:55:40',
        'ENTRANCE'
    ),
(
        919,
        32,
        '2024-12-17',
        '11:17:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-17 11:17:39',
        'ENTRANCE'
    ),
(
        920,
        31,
        '2024-12-17',
        '14:23:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-17 14:23:22',
        'ENTRANCE'
    ),
(
        921,
        30,
        '2024-12-17',
        '18:01:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-17 18:01:04',
        'EXIT'
    ),
(
        922,
        34,
        '2024-12-17',
        '18:20:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-17 18:20:06',
        'EXIT'
    ),
(
        923,
        38,
        '2024-12-17',
        '18:22:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-17 18:22:23',
        'EXIT'
    ),
(
        924,
        28,
        '2024-12-17',
        '18:26:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-17 18:26:59',
        'EXIT'
    ),
(
        925,
        31,
        '2024-12-17',
        '18:43:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-17 18:43:04',
        'EXIT'
    ),
(
        926,
        29,
        '2024-12-17',
        '18:43:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-17 18:43:21',
        'EXIT'
    ),
(
        927,
        32,
        '2024-12-17',
        '19:01:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-17 19:01:36',
        'EXIT'
    ),
(
        928,
        34,
        '2024-12-18',
        '08:36:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-18 08:36:56',
        'ENTRANCE'
    ),
(
        929,
        27,
        '2024-12-18',
        '09:09:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-18 09:09:41',
        'ENTRANCE'
    ),
(
        930,
        30,
        '2024-12-18',
        '09:10:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-18 09:10:22',
        'ENTRANCE'
    ),
(
        931,
        38,
        '2024-12-18',
        '09:33:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-18 09:33:09',
        'ENTRANCE'
    ),
(
        932,
        29,
        '2024-12-18',
        '10:15:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-18 10:15:45',
        'ENTRANCE'
    ),
(
        933,
        32,
        '2024-12-18',
        '11:14:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-18 11:14:00',
        'ENTRANCE'
    ),
(
        934,
        28,
        '2024-12-18',
        '10:51:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-18 10:51:38',
        'ENTRANCE'
    ),
(
        935,
        31,
        '2024-12-18',
        '14:05:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-18 14:05:45',
        'ENTRANCE'
    ),
(
        936,
        30,
        '2024-12-18',
        '18:02:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-18 18:02:32',
        'EXIT'
    ),
(
        937,
        38,
        '2024-12-18',
        '18:10:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-18 18:10:52',
        'EXIT'
    ),
(
        938,
        34,
        '2024-12-18',
        '18:17:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-18 18:17:24',
        'EXIT'
    ),
(
        939,
        31,
        '2024-12-18',
        '18:40:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-18 18:40:30',
        'EXIT'
    ),
(
        940,
        29,
        '2024-12-18',
        '18:40:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-18 18:40:49',
        'EXIT'
    ),
(
        941,
        32,
        '2024-12-18',
        '19:01:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-18 19:01:08',
        'EXIT'
    ),
(
        942,
        38,
        '2024-12-19',
        '08:37:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-19 08:37:05',
        'ENTRANCE'
    ),
(
        943,
        34,
        '2024-12-19',
        '08:45:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-19 08:45:46',
        'ENTRANCE'
    ),
(
        944,
        28,
        '2024-12-19',
        '09:00:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-19 09:00:16',
        'ENTRANCE'
    ),
(
        945,
        29,
        '2024-12-19',
        '10:15:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-19 10:15:55',
        'ENTRANCE'
    ),
(
        946,
        32,
        '2024-12-19',
        '10:50:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-19 10:50:57',
        'ENTRANCE'
    ),
(
        947,
        37,
        '2024-12-19',
        '10:30:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-19 10:30:10',
        'ENTRANCE'
    ),
(
        948,
        28,
        '2024-12-19',
        '17:41:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-19 17:41:19',
        'EXIT'
    ),
(
        949,
        38,
        '2024-12-19',
        '17:47:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-19 17:47:22',
        'EXIT'
    ),
(
        950,
        29,
        '2024-12-19',
        '17:53:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-19 17:53:54',
        'EXIT'
    ),
(
        951,
        32,
        '2024-12-19',
        '18:57:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-19 18:57:41',
        'EXIT'
    ),
(
        952,
        34,
        '2024-12-20',
        '08:41:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-20 08:41:47',
        'ENTRANCE'
    ),
(
        953,
        38,
        '2024-12-20',
        '08:42:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-20 08:42:21',
        'ENTRANCE'
    ),
(
        954,
        28,
        '2024-12-20',
        '08:59:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-20 08:59:15',
        'ENTRANCE'
    ),
(
        955,
        27,
        '2024-12-20',
        '09:16:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-20 09:16:21',
        'ENTRANCE'
    ),
(
        956,
        30,
        '2024-12-20',
        '09:29:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-20 09:29:31',
        'ENTRANCE'
    ),
(
        957,
        37,
        '2024-12-20',
        '11:03:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-20 11:03:37',
        'ENTRANCE'
    ),
(
        958,
        32,
        '2024-12-20',
        '11:16:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-20 11:16:02',
        'ENTRANCE'
    ),
(
        959,
        30,
        '2024-12-20',
        '18:00:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-20 18:00:07',
        'EXIT'
    ),
(
        960,
        38,
        '2024-12-20',
        '18:12:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-20 18:12:54',
        'EXIT'
    ),
(
        961,
        34,
        '2024-12-20',
        '18:23:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-20 18:23:39',
        'EXIT'
    ),
(
        962,
        31,
        '2024-12-20',
        '18:49:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-20 18:49:10',
        'EXIT'
    ),
(
        963,
        32,
        '2024-12-20',
        '18:58:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-20 18:58:27',
        'EXIT'
    ),
(
        964,
        28,
        '2024-12-21',
        '08:45:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-21 08:45:45',
        'ENTRANCE'
    ),
(
        965,
        38,
        '2024-12-21',
        '09:06:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-21 09:06:30',
        'ENTRANCE'
    ),
(
        966,
        34,
        '2024-12-21',
        '09:08:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-21 09:08:20',
        'ENTRANCE'
    ),
(
        967,
        27,
        '2024-12-21',
        '09:11:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-21 09:11:04',
        'ENTRANCE'
    ),
(
        968,
        30,
        '2024-12-21',
        '09:42:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-21 09:42:18',
        'ENTRANCE'
    ),
(
        969,
        29,
        '2024-12-21',
        '10:16:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-21 10:16:40',
        'ENTRANCE'
    ),
(
        970,
        32,
        '2024-12-21',
        '11:10:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-21 11:10:23',
        'ENTRANCE'
    ),
(
        971,
        37,
        '2024-12-21',
        '11:12:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-21 11:12:32',
        'ENTRANCE'
    ),
(
        972,
        38,
        '2024-12-21',
        '15:09:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-21 15:09:41',
        'EXIT'
    ),
(
        973,
        29,
        '2024-12-21',
        '18:35:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-21 18:35:13',
        'EXIT'
    ),
(
        974,
        31,
        '2024-12-21',
        '18:35:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-21 18:35:28',
        'EXIT'
    ),
(
        975,
        32,
        '2024-12-21',
        '19:05:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-21 19:05:37',
        'EXIT'
    ),
(
        976,
        30,
        '2024-12-22',
        '10:07:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-22 10:07:35',
        'ENTRANCE'
    ),
(
        977,
        31,
        '2024-12-22',
        '10:20:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-22 10:20:24',
        'ENTRANCE'
    ),
(
        978,
        29,
        '2024-12-22',
        '10:22:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-22 10:22:02',
        'ENTRANCE'
    ),
(
        979,
        37,
        '2024-12-22',
        '10:43:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-22 10:43:07',
        'ENTRANCE'
    ),
(
        980,
        33,
        '2024-12-22',
        '11:11:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-22 11:11:41',
        'ENTRANCE'
    ),
(
        981,
        30,
        '2024-12-22',
        '18:00:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-22 18:00:04',
        'EXIT'
    ),
(
        982,
        31,
        '2024-12-22',
        '18:44:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-22 18:44:06',
        'EXIT'
    ),
(
        983,
        29,
        '2024-12-22',
        '18:44:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-22 18:44:21',
        'EXIT'
    ),
(
        984,
        33,
        '2024-12-22',
        '19:01:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-22 19:01:17',
        'EXIT'
    ),
(
        985,
        28,
        '2024-12-23',
        '08:54:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-23 08:54:57',
        'ENTRANCE'
    ),
(
        986,
        34,
        '2024-12-23',
        '08:57:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-23 08:57:49',
        'ENTRANCE'
    ),
(
        987,
        38,
        '2024-12-23',
        '09:01:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-23 09:01:22',
        'ENTRANCE'
    ),
(
        988,
        27,
        '2024-12-23',
        '09:04:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-23 09:04:28',
        'ENTRANCE'
    ),
(
        989,
        30,
        '2024-12-23',
        '09:58:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-23 09:58:46',
        'ENTRANCE'
    ),
(
        990,
        37,
        '2024-12-23',
        '11:00:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-23 11:00:02',
        'ENTRANCE'
    ),
(
        991,
        32,
        '2024-12-23',
        '11:15:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-23 11:15:42',
        'ENTRANCE'
    ),
(
        992,
        30,
        '2024-12-23',
        '18:00:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-23 18:00:31',
        'EXIT'
    ),
(
        993,
        28,
        '2024-12-23',
        '18:14:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-23 18:14:46',
        'EXIT'
    ),
(
        994,
        38,
        '2024-12-23',
        '18:33:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-23 18:33:12',
        'EXIT'
    ),
(
        995,
        32,
        '2024-12-23',
        '19:00:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-23 19:00:09',
        'EXIT'
    ),
(
        996,
        28,
        '2024-12-24',
        '08:40:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-24 08:40:07',
        'ENTRANCE'
    ),
(
        997,
        34,
        '2024-12-24',
        '08:59:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-24 08:59:58',
        'ENTRANCE'
    ),
(
        998,
        27,
        '2024-12-24',
        '09:19:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-24 09:19:37',
        'ENTRANCE'
    ),
(
        999,
        37,
        '2024-12-24',
        '09:52:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-24 09:52:09',
        'ENTRANCE'
    ),
(
        1000,
        38,
        '2024-12-24',
        '09:53:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-24 09:53:13',
        'ENTRANCE'
    ),
(
        1001,
        30,
        '2024-12-24',
        '10:05:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-24 10:05:28',
        'ENTRANCE'
    ),
(
        1002,
        32,
        '2024-12-24',
        '10:14:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-24 10:14:32',
        'ENTRANCE'
    ),
(
        1003,
        34,
        '2024-12-24',
        '14:05:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-24 14:05:40',
        'EXIT'
    ),
(
        1004,
        38,
        '2024-12-24',
        '14:28:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-24 14:28:28',
        'EXIT'
    ),
(
        1005,
        28,
        '2024-12-24',
        '14:28:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-24 14:28:44',
        'EXIT'
    ),
(
        1006,
        32,
        '2024-12-24',
        '14:59:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-24 14:59:37',
        'EXIT'
    ),
(
        1007,
        30,
        '2024-12-24',
        '15:00:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-24 15:00:01',
        'EXIT'
    ),
(
        1008,
        28,
        '2024-12-26',
        '08:45:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-26 08:45:58',
        'ENTRANCE'
    ),
(
        1009,
        38,
        '2024-12-26',
        '08:55:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-26 08:55:23',
        'ENTRANCE'
    ),
(
        1010,
        34,
        '2024-12-26',
        '09:02:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-26 09:02:58',
        'ENTRANCE'
    ),
(
        1011,
        27,
        '2024-12-26',
        '09:14:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-26 09:14:27',
        'ENTRANCE'
    ),
(
        1012,
        37,
        '2024-12-26',
        '11:05:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-26 11:05:41',
        'ENTRANCE'
    ),
(
        1013,
        32,
        '2024-12-26',
        '11:16:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-26 11:16:28',
        'ENTRANCE'
    ),
(
        1014,
        38,
        '2024-12-26',
        '18:08:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-26 18:08:45',
        'EXIT'
    ),
(
        1015,
        28,
        '2024-12-26',
        '18:12:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-26 18:12:10',
        'EXIT'
    ),
(
        1016,
        34,
        '2024-12-26',
        '18:13:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-26 18:13:57',
        'EXIT'
    ),
(
        1017,
        32,
        '2024-12-26',
        '18:57:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-26 18:57:28',
        'EXIT'
    ),
(
        1018,
        38,
        '2024-12-27',
        '08:54:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-27 08:54:52',
        'ENTRANCE'
    ),
(
        1019,
        28,
        '2024-12-27',
        '08:54:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-27 08:54:56',
        'ENTRANCE'
    ),
(
        1020,
        27,
        '2024-12-27',
        '09:04:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-27 09:04:46',
        'ENTRANCE'
    ),
(
        1021,
        34,
        '2024-12-27',
        '09:17:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-27 09:17:43',
        'ENTRANCE'
    ),
(
        1022,
        36,
        '2024-12-27',
        '09:33:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-27 09:33:23',
        'ENTRANCE'
    ),
(
        1023,
        32,
        '2024-12-27',
        '11:10:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-27 11:10:20',
        'ENTRANCE'
    ),
(
        1024,
        37,
        '2024-12-27',
        '11:14:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-27 11:14:52',
        'ENTRANCE'
    ),
(
        1025,
        28,
        '2024-12-27',
        '18:05:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-27 18:05:15',
        'EXIT'
    ),
(
        1026,
        30,
        '2024-12-27',
        '18:09:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-27 18:09:46',
        'EXIT'
    ),
(
        1027,
        34,
        '2024-12-27',
        '18:10:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-27 18:10:02',
        'EXIT'
    ),
(
        1028,
        38,
        '2024-12-27',
        '18:11:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-27 18:11:49',
        'EXIT'
    ),
(
        1029,
        32,
        '2024-12-27',
        '18:59:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-27 18:59:51',
        'EXIT'
    ),
(
        1030,
        38,
        '2024-12-28',
        '08:56:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-28 08:56:02',
        'ENTRANCE'
    ),
(
        1031,
        28,
        '2024-12-28',
        '08:56:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-28 08:56:08',
        'ENTRANCE'
    ),
(
        1032,
        34,
        '2024-12-28',
        '09:08:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-28 09:08:15',
        'ENTRANCE'
    ),
(
        1033,
        27,
        '2024-12-28',
        '09:12:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-28 09:12:42',
        'ENTRANCE'
    ),
(
        1034,
        30,
        '2024-12-28',
        '09:43:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-28 09:43:27',
        'ENTRANCE'
    ),
(
        1035,
        32,
        '2024-12-28',
        '11:31:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-28 11:31:22',
        'ENTRANCE'
    ),
(
        1036,
        34,
        '2024-12-28',
        '14:52:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-28 14:52:14',
        'EXIT'
    ),
(
        1037,
        28,
        '2024-12-28',
        '15:16:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-28 15:16:54',
        'EXIT'
    ),
(
        1038,
        38,
        '2024-12-28',
        '15:17:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-28 15:17:21',
        'EXIT'
    ),
(
        1039,
        32,
        '2024-12-28',
        '18:59:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-28 18:59:45',
        'EXIT'
    ),
(
        1040,
        30,
        '2024-12-29',
        '09:19:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-29 09:19:11',
        'ENTRANCE'
    ),
(
        1041,
        33,
        '2024-12-29',
        '11:18:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-29 11:18:30',
        'ENTRANCE'
    ),
(
        1042,
        33,
        '2024-12-29',
        '19:17:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-29 19:17:53',
        'EXIT'
    ),
(
        1043,
        28,
        '2024-12-30',
        '09:09:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-30 09:09:37',
        'ENTRANCE'
    ),
(
        1044,
        38,
        '2024-12-30',
        '09:09:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-30 09:09:58',
        'ENTRANCE'
    ),
(
        1045,
        34,
        '2024-12-30',
        '09:11:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-30 09:11:10',
        'ENTRANCE'
    ),
(
        1046,
        27,
        '2024-12-30',
        '09:26:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-30 09:26:01',
        'ENTRANCE'
    ),
(
        1047,
        30,
        '2024-12-30',
        '09:44:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-30 09:44:07',
        'ENTRANCE'
    ),
(
        1048,
        37,
        '2024-12-30',
        '10:59:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-30 10:59:22',
        'ENTRANCE'
    ),
(
        1049,
        29,
        '2024-12-30',
        '11:33:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-30 11:33:57',
        'ENTRANCE'
    ),
(
        1050,
        30,
        '2024-12-30',
        '18:00:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-30 18:00:06',
        'EXIT'
    ),
(
        1051,
        38,
        '2024-12-30',
        '18:19:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-30 18:19:27',
        'EXIT'
    ),
(
        1052,
        28,
        '2024-12-30',
        '18:40:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-30 18:40:11',
        'EXIT'
    ),
(
        1053,
        29,
        '2024-12-30',
        '18:41:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-30 18:41:04',
        'EXIT'
    ),
(
        1054,
        28,
        '2024-12-31',
        '08:48:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-31 08:48:04',
        'ENTRANCE'
    ),
(
        1055,
        38,
        '2024-12-31',
        '08:48:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-31 08:48:17',
        'ENTRANCE'
    ),
(
        1056,
        30,
        '2024-12-31',
        '09:17:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-31 09:17:16',
        'ENTRANCE'
    ),
(
        1057,
        37,
        '2024-12-31',
        '10:04:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-31 10:04:46',
        'ENTRANCE'
    ),
(
        1058,
        29,
        '2024-12-31',
        '10:17:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-31 10:17:03',
        'ENTRANCE'
    ),
(
        1059,
        38,
        '2024-12-31',
        '14:10:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-31 14:10:41',
        'EXIT'
    ),
(
        1060,
        29,
        '2024-12-31',
        '14:54:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-31 14:54:28',
        'EXIT'
    ),
(
        1061,
        30,
        '2024-12-31',
        '15:00:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-31 15:00:05',
        'EXIT'
    ),
(
        1062,
        28,
        '2024-12-31',
        '15:20:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2024-12-31 15:20:32',
        'EXIT'
    ),
(
        1063,
        30,
        '2025-01-06',
        '17:00:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-06 17:00:58',
        'ENTRANCE'
    ),
(
        1064,
        30,
        '2025-01-06',
        '18:02:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-06 18:02:04',
        'EXIT'
    ),
(
        1065,
        28,
        '2025-01-06',
        '18:36:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-06 18:36:56',
        'EXIT'
    ),
(
        1066,
        29,
        '2025-01-06',
        '18:40:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-06 18:40:22',
        'EXIT'
    ),
(
        1067,
        38,
        '2025-01-06',
        '18:41:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-06 18:41:02',
        'EXIT'
    ),
(
        1068,
        32,
        '2025-01-06',
        '19:00:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-06 19:00:20',
        'EXIT'
    ),
(
        1069,
        34,
        '2025-01-07',
        '08:21:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-07 08:21:13',
        'ENTRANCE'
    ),
(
        1070,
        38,
        '2025-01-07',
        '08:49:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-07 08:49:11',
        'ENTRANCE'
    ),
(
        1071,
        28,
        '2025-01-07',
        '08:53:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-07 08:53:10',
        'ENTRANCE'
    ),
(
        1072,
        30,
        '2025-01-07',
        '10:02:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-07 10:02:31',
        'ENTRANCE'
    ),
(
        1073,
        29,
        '2025-01-07',
        '10:19:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-07 10:19:24',
        'ENTRANCE'
    ),
(
        1074,
        37,
        '2025-01-07',
        '11:27:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-07 11:27:32',
        'ENTRANCE'
    ),
(
        1075,
        30,
        '2025-01-07',
        '18:00:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-07 18:00:16',
        'EXIT'
    ),
(
        1076,
        34,
        '2025-01-07',
        '18:03:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-07 18:03:17',
        'EXIT'
    ),
(
        1077,
        38,
        '2025-01-07',
        '18:16:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-07 18:16:27',
        'EXIT'
    ),
(
        1078,
        28,
        '2025-01-07',
        '18:16:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-07 18:16:41',
        'EXIT'
    ),
(
        1079,
        29,
        '2025-01-07',
        '18:42:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-07 18:42:46',
        'EXIT'
    ),
(
        1080,
        34,
        '2025-01-08',
        '08:38:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-08 08:38:46',
        'ENTRANCE'
    ),
(
        1081,
        38,
        '2025-01-08',
        '08:51:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-08 08:51:04',
        'ENTRANCE'
    ),
(
        1082,
        28,
        '2025-01-08',
        '08:59:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-08 08:59:14',
        'ENTRANCE'
    ),
(
        1083,
        27,
        '2025-01-08',
        '09:33:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-08 09:33:37',
        'ENTRANCE'
    ),
(
        1084,
        30,
        '2025-01-08',
        '09:42:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-08 09:42:41',
        'ENTRANCE'
    ),
(
        1085,
        29,
        '2025-01-08',
        '10:18:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-08 10:18:48',
        'ENTRANCE'
    ),
(
        1086,
        32,
        '2025-01-08',
        '11:34:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-08 11:34:23',
        'ENTRANCE'
    ),
(
        1087,
        30,
        '2025-01-08',
        '18:00:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-08 18:00:56',
        'EXIT'
    ),
(
        1088,
        34,
        '2025-01-08',
        '18:08:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-08 18:08:47',
        'EXIT'
    ),
(
        1089,
        38,
        '2025-01-08',
        '18:23:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-08 18:23:32',
        'EXIT'
    ),
(
        1090,
        28,
        '2025-01-08',
        '18:41:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-08 18:41:36',
        'EXIT'
    ),
(
        1091,
        29,
        '2025-01-08',
        '18:45:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-08 18:45:32',
        'EXIT'
    ),
(
        1092,
        32,
        '2025-01-08',
        '19:00:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-08 19:00:40',
        'EXIT'
    ),
(
        1093,
        34,
        '2025-01-09',
        '08:33:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-09 08:33:21',
        'ENTRANCE'
    ),
(
        1094,
        38,
        '2025-01-09',
        '09:04:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-09 09:04:59',
        'ENTRANCE'
    ),
(
        1095,
        29,
        '2025-01-09',
        '10:20:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-09 10:20:40',
        'ENTRANCE'
    ),
(
        1096,
        32,
        '2025-01-09',
        '11:13:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-09 11:13:15',
        'ENTRANCE'
    ),
(
        1097,
        38,
        '2025-01-09',
        '18:14:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-09 18:14:17',
        'EXIT'
    ),
(
        1098,
        29,
        '2025-01-09',
        '18:19:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-09 18:19:52',
        'EXIT'
    ),
(
        1099,
        32,
        '2025-01-09',
        '19:06:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-09 19:06:09',
        'EXIT'
    ),
(
        1100,
        34,
        '2025-01-10',
        '08:39:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-10 08:39:57',
        'ENTRANCE'
    ),
(
        1101,
        28,
        '2025-01-10',
        '09:00:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-10 09:00:25',
        'ENTRANCE'
    ),
(
        1102,
        38,
        '2025-01-10',
        '10:22:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-10 10:22:23',
        'ENTRANCE'
    ),
(
        1103,
        30,
        '2025-01-10',
        '10:51:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-10 10:51:24',
        'ENTRANCE'
    ),
(
        1104,
        32,
        '2025-01-10',
        '11:12:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-10 11:12:41',
        'ENTRANCE'
    ),
(
        1105,
        30,
        '2025-01-10',
        '18:00:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-10 18:00:14',
        'EXIT'
    ),
(
        1106,
        38,
        '2025-01-10',
        '18:16:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-10 18:16:27',
        'EXIT'
    ),
(
        1107,
        32,
        '2025-01-10',
        '18:57:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-10 18:57:04',
        'EXIT'
    ),
(
        1108,
        38,
        '2025-01-11',
        '09:01:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-11 09:01:50',
        'ENTRANCE'
    ),
(
        1109,
        28,
        '2025-01-11',
        '09:02:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-11 09:02:04',
        'ENTRANCE'
    ),
(
        1110,
        27,
        '2025-01-11',
        '09:20:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-11 09:20:33',
        'ENTRANCE'
    ),
(
        1111,
        34,
        '2025-01-11',
        '09:25:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-11 09:25:41',
        'ENTRANCE'
    ),
(
        1112,
        30,
        '2025-01-11',
        '10:12:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-11 10:12:51',
        'ENTRANCE'
    ),
(
        1113,
        29,
        '2025-01-11',
        '10:18:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-11 10:18:27',
        'ENTRANCE'
    ),
(
        1114,
        32,
        '2025-01-11',
        '11:01:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-11 11:01:09',
        'ENTRANCE'
    ),
(
        1115,
        38,
        '2025-01-11',
        '15:30:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-11 15:30:51',
        'EXIT'
    ),
(
        1116,
        30,
        '2025-01-11',
        '18:01:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-11 18:01:23',
        'EXIT'
    ),
(
        1117,
        29,
        '2025-01-11',
        '18:46:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-11 18:46:56',
        'EXIT'
    ),
(
        1118,
        32,
        '2025-01-11',
        '19:01:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-11 19:01:21',
        'EXIT'
    ),
(
        1119,
        30,
        '2025-01-12',
        '10:04:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-12 10:04:50',
        'ENTRANCE'
    ),
(
        1120,
        29,
        '2025-01-12',
        '10:32:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-12 10:32:45',
        'ENTRANCE'
    ),
(
        1121,
        33,
        '2025-01-12',
        '13:59:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-12 13:59:51',
        'ENTRANCE'
    ),
(
        1122,
        29,
        '2025-01-12',
        '18:41:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-12 18:41:54',
        'EXIT'
    ),
(
        1123,
        33,
        '2025-01-12',
        '19:00:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-12 19:00:43',
        'EXIT'
    ),
(
        1124,
        34,
        '2025-01-13',
        '08:43:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-13 08:43:54',
        'ENTRANCE'
    ),
(
        1125,
        28,
        '2025-01-13',
        '08:58:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-13 08:58:03',
        'ENTRANCE'
    ),
(
        1126,
        38,
        '2025-01-13',
        '09:02:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-13 09:02:29',
        'ENTRANCE'
    ),
(
        1127,
        27,
        '2025-01-13',
        '09:18:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-13 09:18:33',
        'ENTRANCE'
    ),
(
        1128,
        30,
        '2025-01-13',
        '09:30:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-13 09:30:10',
        'ENTRANCE'
    ),
(
        1129,
        29,
        '2025-01-13',
        '10:11:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-13 10:11:19',
        'ENTRANCE'
    ),
(
        1130,
        32,
        '2025-01-13',
        '11:13:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-13 11:13:36',
        'ENTRANCE'
    ),
(
        1131,
        30,
        '2025-01-13',
        '18:00:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-13 18:00:06',
        'EXIT'
    ),
(
        1132,
        30,
        '2025-01-13',
        '18:00:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-13 18:00:06',
        'EXIT'
    ),
(
        1133,
        28,
        '2025-01-13',
        '18:07:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-13 18:07:54',
        'EXIT'
    ),
(
        1134,
        38,
        '2025-01-13',
        '18:08:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-13 18:08:08',
        'EXIT'
    ),
(
        1135,
        34,
        '2025-01-13',
        '18:13:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-13 18:13:42',
        'EXIT'
    ),
(
        1136,
        29,
        '2025-01-13',
        '18:42:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-13 18:42:53',
        'EXIT'
    ),
(
        1137,
        32,
        '2025-01-13',
        '18:59:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-13 18:59:30',
        'EXIT'
    ),
(
        1138,
        34,
        '2025-01-14',
        '08:39:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-14 08:39:09',
        'ENTRANCE'
    ),
(
        1139,
        28,
        '2025-01-14',
        '08:52:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-14 08:52:16',
        'ENTRANCE'
    ),
(
        1140,
        30,
        '2025-01-14',
        '08:52:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-14 08:52:50',
        'ENTRANCE'
    ),
(
        1141,
        38,
        '2025-01-14',
        '09:02:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-14 09:02:14',
        'ENTRANCE'
    ),
(
        1142,
        27,
        '2025-01-14',
        '09:03:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-14 09:03:29',
        'ENTRANCE'
    ),
(
        1143,
        29,
        '2025-01-14',
        '10:12:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-14 10:30:12',
        'ENTRANCE'
    ),
(
        1144,
        32,
        '2025-01-14',
        '11:12:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-14 11:12:21',
        'ENTRANCE'
    ),
(
        1145,
        36,
        '2025-01-14',
        '11:37:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-14 11:37:42',
        'ENTRANCE'
    ),
(
        1146,
        30,
        '2025-01-14',
        '18:09:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-14 18:09:36',
        'EXIT'
    ),
(
        1147,
        34,
        '2025-01-14',
        '18:50:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-14 18:50:13',
        'EXIT'
    ),
(
        1148,
        29,
        '2025-01-14',
        '18:56:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-14 18:56:48',
        'EXIT'
    ),
(
        1149,
        32,
        '2025-01-14',
        '19:00:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-14 19:00:22',
        'EXIT'
    ),
(
        1150,
        36,
        '2025-01-14',
        '19:58:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-14 19:58:33',
        'EXIT'
    ),
(
        1151,
        27,
        '2025-01-15',
        '08:24:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-15 08:24:11',
        'ENTRANCE'
    ),
(
        1152,
        34,
        '2025-01-15',
        '08:40:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-15 08:40:56',
        'ENTRANCE'
    ),
(
        1153,
        30,
        '2025-01-15',
        '08:49:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-15 08:49:37',
        'ENTRANCE'
    ),
(
        1154,
        38,
        '2025-01-15',
        '09:05:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-15 09:05:50',
        'ENTRANCE'
    ),
(
        1155,
        28,
        '2025-01-15',
        '09:28:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-15 09:28:29',
        'ENTRANCE'
    ),
(
        1156,
        29,
        '2025-01-15',
        '10:19:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-15 10:19:02',
        'ENTRANCE'
    ),
(
        1157,
        36,
        '2025-01-15',
        '11:20:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-15 11:20:14',
        'ENTRANCE'
    ),
(
        1158,
        30,
        '2025-01-15',
        '18:00:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-15 18:00:02',
        'EXIT'
    ),
(
        1159,
        28,
        '2025-01-15',
        '18:10:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-15 18:10:13',
        'EXIT'
    ),
(
        1160,
        38,
        '2025-01-15',
        '18:11:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-15 18:11:45',
        'EXIT'
    ),
(
        1161,
        34,
        '2025-01-15',
        '18:11:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-15 18:11:45',
        'EXIT'
    ),
(
        1162,
        29,
        '2025-01-15',
        '18:44:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-15 18:44:45',
        'EXIT'
    ),
(
        1163,
        36,
        '2025-01-15',
        '19:56:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-15 19:56:30',
        'EXIT'
    ),
(
        1164,
        34,
        '2025-01-16',
        '08:32:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-16 08:32:36',
        'ENTRANCE'
    ),
(
        1165,
        28,
        '2025-01-16',
        '08:40:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-16 08:40:11',
        'ENTRANCE'
    ),
(
        1166,
        38,
        '2025-01-16',
        '09:02:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-16 09:02:14',
        'ENTRANCE'
    ),
(
        1167,
        27,
        '2025-01-16',
        '09:03:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-16 09:03:13',
        'ENTRANCE'
    ),
(
        1168,
        29,
        '2025-01-16',
        '09:52:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-16 09:52:53',
        'ENTRANCE'
    ),
(
        1169,
        29,
        '2025-01-16',
        '17:56:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-16 17:56:59',
        'EXIT'
    ),
(
        1170,
        34,
        '2025-01-16',
        '18:28:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-16 18:28:30',
        'EXIT'
    ),
(
        1171,
        38,
        '2025-01-16',
        '18:33:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-16 18:33:23',
        'EXIT'
    ),
(
        1172,
        28,
        '2025-01-16',
        '18:39:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-16 18:39:16',
        'EXIT'
    ),
(
        1173,
        32,
        '2025-01-16',
        '19:02:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-16 19:02:02',
        'EXIT'
    ),
(
        1174,
        34,
        '2025-01-17',
        '08:08:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-17 08:08:42',
        'ENTRANCE'
    ),
(
        1175,
        27,
        '2025-01-17',
        '08:08:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-17 08:08:59',
        'ENTRANCE'
    ),
(
        1176,
        30,
        '2025-01-17',
        '08:11:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-17 08:11:19',
        'ENTRANCE'
    ),
(
        1177,
        28,
        '2025-01-17',
        '08:40:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-17 08:40:50',
        'ENTRANCE'
    ),
(
        1178,
        38,
        '2025-01-17',
        '09:01:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-17 09:01:09',
        'ENTRANCE'
    ),
(
        1179,
        32,
        '2025-01-17',
        '11:05:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-17 11:05:52',
        'ENTRANCE'
    ),
(
        1180,
        36,
        '2025-01-17',
        '12:21:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-17 12:21:41',
        'ENTRANCE'
    ),
(
        1181,
        28,
        '2025-01-17',
        '18:39:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-17 18:39:00',
        'EXIT'
    ),
(
        1182,
        32,
        '2025-01-17',
        '19:00:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-17 19:00:08',
        'EXIT'
    ),
(
        1183,
        28,
        '2025-01-18',
        '09:04:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-18 09:04:10',
        'ENTRANCE'
    ),
(
        1184,
        38,
        '2025-01-18',
        '09:04:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-18 09:04:31',
        'ENTRANCE'
    ),
(
        1185,
        34,
        '2025-01-18',
        '09:06:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-18 09:06:28',
        'ENTRANCE'
    ),
(
        1186,
        27,
        '2025-01-18',
        '09:17:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-18 09:17:06',
        'ENTRANCE'
    ),
(
        1187,
        29,
        '2025-01-18',
        '10:30:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-18 10:30:24',
        'ENTRANCE'
    ),
(
        1188,
        32,
        '2025-01-18',
        '11:06:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-18 11:06:40',
        'ENTRANCE'
    ),
(
        1189,
        38,
        '2025-01-18',
        '15:23:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-18 15:23:46',
        'EXIT'
    ),
(
        1190,
        28,
        '2025-01-18',
        '16:02:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-18 16:02:50',
        'EXIT'
    ),
(
        1191,
        30,
        '2025-01-18',
        '18:02:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-18 18:02:58',
        'EXIT'
    ),
(
        1192,
        29,
        '2025-01-18',
        '18:37:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-18 18:37:11',
        'EXIT'
    ),
(
        1193,
        32,
        '2025-01-18',
        '18:58:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-18 18:58:48',
        'EXIT'
    ),
(
        1194,
        30,
        '2025-01-19',
        '09:23:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-19 09:23:19',
        'ENTRANCE'
    ),
(
        1195,
        29,
        '2025-01-19',
        '10:26:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-19 10:26:13',
        'ENTRANCE'
    ),
(
        1196,
        33,
        '2025-01-19',
        '12:00:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-19 12:00:02',
        'ENTRANCE'
    ),
(
        1197,
        30,
        '2025-01-19',
        '18:09:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-19 18:09:05',
        'EXIT'
    ),
(
        1198,
        29,
        '2025-01-19',
        '18:38:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-19 18:38:12',
        'EXIT'
    ),
(
        1199,
        27,
        '2025-01-20',
        '08:22:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-20 08:22:13',
        'ENTRANCE'
    ),
(
        1200,
        34,
        '2025-01-20',
        '08:23:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-20 08:23:04',
        'ENTRANCE'
    ),
(
        1201,
        28,
        '2025-01-20',
        '08:42:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-20 08:42:45',
        'ENTRANCE'
    ),
(
        1202,
        30,
        '2025-01-20',
        '09:00:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-20 09:00:32',
        'ENTRANCE'
    ),
(
        1203,
        38,
        '2025-01-20',
        '09:02:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-20 09:02:00',
        'ENTRANCE'
    ),
(
        1204,
        29,
        '2025-01-20',
        '10:17:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-20 10:17:54',
        'ENTRANCE'
    ),
(
        1205,
        33,
        '2025-01-20',
        '11:26:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-20 11:26:20',
        'ENTRANCE'
    ),
(
        1206,
        30,
        '2025-01-20',
        '18:10:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-20 18:10:53',
        'EXIT'
    ),
(
        1207,
        38,
        '2025-01-20',
        '18:12:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-20 18:12:40',
        'EXIT'
    ),
(
        1208,
        29,
        '2025-01-20',
        '18:37:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-20 18:37:30',
        'EXIT'
    ),
(
        1209,
        28,
        '2025-01-20',
        '18:40:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-20 18:40:29',
        'EXIT'
    ),
(
        1210,
        34,
        '2025-01-20',
        '19:05:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-20 19:05:57',
        'EXIT'
    ),
(
        1211,
        34,
        '2025-01-21',
        '07:33:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-21 07:33:21',
        'ENTRANCE'
    ),
(
        1212,
        27,
        '2025-01-21',
        '08:40:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-21 08:40:48',
        'ENTRANCE'
    ),
(
        1213,
        30,
        '2025-01-21',
        '09:01:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-21 09:01:21',
        'ENTRANCE'
    ),
(
        1214,
        38,
        '2025-01-21',
        '09:07:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-21 09:07:21',
        'ENTRANCE'
    ),
(
        1215,
        28,
        '2025-01-21',
        '09:19:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-21 09:19:24',
        'ENTRANCE'
    ),
(
        1216,
        29,
        '2025-01-21',
        '09:55:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-21 09:55:00',
        'ENTRANCE'
    ),
(
        1217,
        33,
        '2025-01-21',
        '12:12:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-21 12:12:29',
        'ENTRANCE'
    ),
(
        1218,
        30,
        '2025-01-21',
        '18:03:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-21 18:03:04',
        'EXIT'
    ),
(
        1219,
        28,
        '2025-01-21',
        '18:15:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-21 18:15:11',
        'EXIT'
    ),
(
        1220,
        38,
        '2025-01-21',
        '18:15:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-21 18:15:26',
        'EXIT'
    ),
(
        1221,
        27,
        '2025-01-21',
        '18:17:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-21 18:17:42',
        'EXIT'
    ),
(
        1222,
        29,
        '2025-01-21',
        '18:44:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-21 18:44:30',
        'EXIT'
    ),
(
        1223,
        34,
        '2025-01-22',
        '08:22:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-22 08:22:56',
        'ENTRANCE'
    ),
(
        1224,
        28,
        '2025-01-22',
        '08:40:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-22 08:40:11',
        'ENTRANCE'
    ),
(
        1225,
        38,
        '2025-01-22',
        '08:56:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-22 08:56:39',
        'ENTRANCE'
    ),
(
        1226,
        30,
        '2025-01-22',
        '09:05:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-22 09:05:38',
        'ENTRANCE'
    ),
(
        1227,
        29,
        '2025-01-22',
        '10:26:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-22 10:26:03',
        'ENTRANCE'
    ),
(
        1228,
        32,
        '2025-01-22',
        '11:26:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-22 11:26:29',
        'ENTRANCE'
    ),
(
        1229,
        30,
        '2025-01-22',
        '18:04:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-22 18:04:48',
        'EXIT'
    ),
(
        1230,
        29,
        '2025-01-22',
        '18:39:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-22 18:39:31',
        'EXIT'
    ),
(
        1231,
        28,
        '2025-01-22',
        '18:45:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-22 18:45:21',
        'EXIT'
    ),
(
        1232,
        38,
        '2025-01-22',
        '18:45:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-22 18:45:48',
        'EXIT'
    ),
(
        1233,
        32,
        '2025-01-22',
        '18:59:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-22 18:59:12',
        'EXIT'
    ),
(
        1234,
        32,
        '2025-01-22',
        '18:59:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-22 18:59:12',
        'EXIT'
    ),
(
        1235,
        32,
        '2025-01-22',
        '18:59:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-22 18:59:12',
        'EXIT'
    ),
(
        1236,
        34,
        '2025-01-22',
        '19:18:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-22 19:18:16',
        'EXIT'
    ),
(
        1237,
        28,
        '2025-01-23',
        '08:23:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-23 08:23:18',
        'ENTRANCE'
    ),
(
        1238,
        34,
        '2025-01-23',
        '09:00:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-23 09:00:56',
        'ENTRANCE'
    ),
(
        1239,
        38,
        '2025-01-23',
        '09:05:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-23 09:05:04',
        'ENTRANCE'
    ),
(
        1240,
        29,
        '2025-01-23',
        '10:17:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-23 10:17:58',
        'ENTRANCE'
    ),
(
        1241,
        32,
        '2025-01-23',
        '13:15:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-23 13:15:48',
        'ENTRANCE'
    ),
(
        1242,
        29,
        '2025-01-23',
        '17:44:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-23 17:44:10',
        'EXIT'
    ),
(
        1243,
        38,
        '2025-01-23',
        '18:19:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-23 18:19:15',
        'EXIT'
    ),
(
        1244,
        32,
        '2025-01-23',
        '19:07:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-23 19:07:38',
        'EXIT'
    ),
(
        1245,
        30,
        '2025-01-24',
        '08:11:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-24 08:11:43',
        'ENTRANCE'
    ),
(
        1246,
        27,
        '2025-01-24',
        '08:19:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-24 08:19:19',
        'ENTRANCE'
    ),
(
        1247,
        34,
        '2025-01-24',
        '08:26:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-24 08:26:50',
        'ENTRANCE'
    ),
(
        1248,
        28,
        '2025-01-24',
        '08:43:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-24 08:43:34',
        'ENTRANCE'
    ),
(
        1249,
        38,
        '2025-01-24',
        '09:19:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-24 09:19:10',
        'ENTRANCE'
    ),
(
        1250,
        32,
        '2025-01-24',
        '11:09:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-24 11:09:02',
        'ENTRANCE'
    ),
(
        1251,
        30,
        '2025-01-24',
        '18:04:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-24 18:04:52',
        'EXIT'
    ),
(
        1252,
        38,
        '2025-01-24',
        '18:33:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-24 18:33:20',
        'EXIT'
    ),
(
        1253,
        28,
        '2025-01-24',
        '18:40:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-24 18:40:58',
        'EXIT'
    ),
(
        1254,
        32,
        '2025-01-24',
        '19:00:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-24 19:00:03',
        'EXIT'
    ),
(
        1255,
        27,
        '2025-01-25',
        '08:59:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-25 08:59:59',
        'ENTRANCE'
    ),
(
        1256,
        38,
        '2025-01-25',
        '09:06:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-25 09:06:12',
        'ENTRANCE'
    ),
(
        1257,
        30,
        '2025-01-25',
        '09:28:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-25 09:28:42',
        'ENTRANCE'
    ),
(
        1258,
        34,
        '2025-01-25',
        '09:41:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-25 09:41:49',
        'ENTRANCE'
    ),
(
        1259,
        28,
        '2025-01-25',
        '09:42:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-25 09:42:19',
        'ENTRANCE'
    ),
(
        1260,
        29,
        '2025-01-25',
        '10:37:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-25 10:37:04',
        'ENTRANCE'
    ),
(
        1261,
        32,
        '2025-01-25',
        '11:08:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-25 11:08:12',
        'ENTRANCE'
    ),
(
        1262,
        38,
        '2025-01-25',
        '15:07:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-25 15:07:31',
        'EXIT'
    ),
(
        1263,
        29,
        '2025-01-25',
        '18:23:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-25 18:23:32',
        'EXIT'
    ),
(
        1264,
        29,
        '2025-01-25',
        '18:23:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-25 18:23:32',
        'EXIT'
    ),
(
        1265,
        32,
        '2025-01-25',
        '19:05:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-25 19:05:45',
        'EXIT'
    ),
(
        1266,
        30,
        '2025-01-26',
        '09:21:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-26 09:21:46',
        'ENTRANCE'
    ),
(
        1267,
        29,
        '2025-01-26',
        '10:20:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-26 10:20:49',
        'ENTRANCE'
    ),
(
        1268,
        33,
        '2025-01-26',
        '11:23:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-26 11:23:30',
        'ENTRANCE'
    ),
(
        1269,
        30,
        '2025-01-26',
        '17:59:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-26 17:59:30',
        'EXIT'
    ),
(
        1270,
        29,
        '2025-01-26',
        '18:39:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-26 18:39:33',
        'EXIT'
    ),
(
        1271,
        34,
        '2025-01-27',
        '08:40:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-27 08:40:08',
        'ENTRANCE'
    ),
(
        1272,
        38,
        '2025-01-27',
        '09:06:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-27 09:06:18',
        'ENTRANCE'
    ),
(
        1273,
        30,
        '2025-01-27',
        '09:09:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-27 09:09:09',
        'ENTRANCE'
    ),
(
        1274,
        27,
        '2025-01-27',
        '09:22:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-27 09:22:17',
        'ENTRANCE'
    ),
(
        1275,
        29,
        '2025-01-27',
        '10:12:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-27 10:12:05',
        'ENTRANCE'
    ),
(
        1276,
        28,
        '2025-01-27',
        '10:26:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-27 10:26:18',
        'ENTRANCE'
    ),
(
        1277,
        38,
        '2025-01-17',
        '18:23:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-17 18:23:24',
        'EXIT'
    ),
(
        1278,
        32,
        '2025-01-27',
        '11:11:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-27 11:11:37',
        'ENTRANCE'
    ),
(
        1279,
        27,
        '2025-01-22',
        '08:15:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-22 08:15:56',
        'ENTRANCE'
    ),
(
        1280,
        27,
        '2025-01-23',
        '08:11:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-23 08:11:51',
        'ENTRANCE'
    ),
(
        1281,
        30,
        '2025-01-27',
        '18:00:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-27 18:00:11',
        'EXIT'
    ),
(
        1282,
        38,
        '2025-01-27',
        '18:01:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-27 18:01:04',
        'EXIT'
    ),
(
        1283,
        34,
        '2025-01-27',
        '18:01:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-27 18:01:49',
        'EXIT'
    ),
(
        1284,
        27,
        '2025-01-27',
        '18:02:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-27 18:02:01',
        'EXIT'
    ),
(
        1285,
        29,
        '2025-01-27',
        '18:57:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-27 18:57:11',
        'EXIT'
    ),
(
        1286,
        32,
        '2025-01-27',
        '19:00:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-27 19:00:11',
        'EXIT'
    ),
(
        1287,
        27,
        '2025-01-28',
        '08:31:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-28 08:31:10',
        'ENTRANCE'
    ),
(
        1288,
        34,
        '2025-01-28',
        '08:31:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-28 08:31:46',
        'ENTRANCE'
    ),
(
        1289,
        38,
        '2025-01-28',
        '08:58:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-28 08:58:16',
        'ENTRANCE'
    ),
(
        1290,
        30,
        '2025-01-28',
        '09:03:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-28 09:03:26',
        'ENTRANCE'
    ),
(
        1291,
        28,
        '2025-01-28',
        '09:04:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-28 09:04:54',
        'ENTRANCE'
    ),
(
        1292,
        29,
        '2025-01-28',
        '09:07:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-28 09:07:06',
        'ENTRANCE'
    ),
(
        1293,
        32,
        '2025-01-28',
        '11:17:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-28 11:17:03',
        'ENTRANCE'
    ),
(
        1294,
        29,
        '2025-01-28',
        '17:56:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-28 17:56:20',
        'EXIT'
    ),
(
        1295,
        30,
        '2025-01-28',
        '18:00:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-28 18:00:29',
        'EXIT'
    ),
(
        1296,
        28,
        '2025-01-27',
        '18:16:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-27 18:16:21',
        'EXIT'
    ),
(
        1297,
        27,
        '2025-01-28',
        '18:03:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-28 18:03:33',
        'EXIT'
    ),
(
        1298,
        38,
        '2025-01-28',
        '18:03:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-28 18:03:47',
        'EXIT'
    ),
(
        1299,
        28,
        '2025-01-28',
        '18:50:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-28 18:50:11',
        'EXIT'
    ),
(
        1300,
        32,
        '2025-01-28',
        '19:04:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-28 19:04:18',
        'EXIT'
    ),
(
        1301,
        34,
        '2025-01-29',
        '08:35:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-29 08:35:54',
        'ENTRANCE'
    ),
(
        1302,
        27,
        '2025-01-29',
        '08:36:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-29 08:36:08',
        'ENTRANCE'
    ),
(
        1303,
        38,
        '2025-01-29',
        '08:59:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-29 08:59:32',
        'ENTRANCE'
    ),
(
        1304,
        30,
        '2025-01-29',
        '09:07:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-29 09:07:54',
        'ENTRANCE'
    ),
(
        1305,
        29,
        '2025-01-29',
        '09:55:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-29 09:55:19',
        'ENTRANCE'
    ),
(
        1306,
        28,
        '2025-01-29',
        '11:09:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-29 11:09:39',
        'ENTRANCE'
    ),
(
        1307,
        32,
        '2025-01-29',
        '11:14:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-29 11:14:21',
        'ENTRANCE'
    ),
(
        1308,
        30,
        '2025-01-29',
        '18:00:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-29 18:00:05',
        'EXIT'
    ),
(
        1309,
        38,
        '2025-01-29',
        '18:43:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-29 18:43:35',
        'EXIT'
    ),
(
        1310,
        27,
        '2025-01-29',
        '18:44:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-29 18:44:38',
        'EXIT'
    ),
(
        1311,
        29,
        '2025-01-29',
        '18:54:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-29 18:54:34',
        'EXIT'
    ),
(
        1312,
        32,
        '2025-01-29',
        '19:00:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-29 19:00:25',
        'EXIT'
    ),
(
        1313,
        34,
        '2025-01-29',
        '19:03:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-29 19:03:01',
        'EXIT'
    ),
(
        1314,
        28,
        '2025-01-30',
        '08:36:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-30 08:36:49',
        'ENTRANCE'
    ),
(
        1315,
        34,
        '2025-01-30',
        '08:51:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-30 08:51:13',
        'ENTRANCE'
    ),
(
        1316,
        38,
        '2025-01-30',
        '08:59:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-30 08:59:49',
        'ENTRANCE'
    ),
(
        1317,
        29,
        '2025-01-30',
        '09:57:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-30 09:57:57',
        'ENTRANCE'
    ),
(
        1318,
        27,
        '2025-01-30',
        '11:00:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-30 11:00:26',
        'ENTRANCE'
    ),
(
        1319,
        32,
        '2025-01-30',
        '11:10:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-30 11:10:13',
        'ENTRANCE'
    ),
(
        1320,
        38,
        '2025-01-30',
        '17:58:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-30 17:58:10',
        'EXIT'
    ),
(
        1321,
        34,
        '2025-01-30',
        '17:58:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-30 17:58:29',
        'EXIT'
    ),
(
        1322,
        28,
        '2025-01-30',
        '18:23:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-30 18:23:15',
        'EXIT'
    ),
(
        1323,
        29,
        '2025-01-30',
        '18:55:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-30 18:55:02',
        'EXIT'
    ),
(
        1324,
        32,
        '2025-01-30',
        '19:00:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-30 19:00:02',
        'EXIT'
    ),
(
        1325,
        30,
        '2025-01-31',
        '08:16:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-31 08:16:28',
        'ENTRANCE'
    ),
(
        1326,
        34,
        '2025-01-31',
        '08:20:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-31 08:20:59',
        'ENTRANCE'
    ),
(
        1327,
        28,
        '2025-01-31',
        '08:53:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-31 08:53:47',
        'ENTRANCE'
    ),
(
        1328,
        38,
        '2025-01-31',
        '09:02:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-31 09:02:26',
        'ENTRANCE'
    ),
(
        1329,
        33,
        '2025-01-31',
        '11:00:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-31 11:00:47',
        'ENTRANCE'
    ),
(
        1330,
        27,
        '2025-01-31',
        '11:02:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-31 11:02:19',
        'ENTRANCE'
    ),
(
        1331,
        28,
        '2025-01-31',
        '17:35:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-31 17:35:12',
        'EXIT'
    ),
(
        1332,
        30,
        '2025-01-31',
        '18:00:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-31 18:00:12',
        'EXIT'
    ),
(
        1333,
        38,
        '2025-02-01',
        '09:04:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-01 09:04:48',
        'ENTRANCE'
    ),
(
        1334,
        34,
        '2025-02-01',
        '09:11:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-01 09:11:42',
        'ENTRANCE'
    ),
(
        1335,
        29,
        '2025-02-01',
        '10:08:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-01 10:08:01',
        'ENTRANCE'
    ),
(
        1336,
        27,
        '2025-02-01',
        '11:04:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-01 11:04:24',
        'ENTRANCE'
    ),
(
        1337,
        33,
        '2025-02-01',
        '11:23:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-01 11:23:47',
        'ENTRANCE'
    ),
(
        1338,
        27,
        '2025-01-30',
        '20:02:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb\r\n2',
        '2025-01-30 20:02:06',
        'EXIT'
    ),
(
        1339,
        27,
        '2025-01-31',
        '20:03:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-01-31 20:03:08',
        'EXIT'
    ),
(
        1340,
        38,
        '2025-02-01',
        '15:32:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-01 15:32:09',
        'EXIT'
    ),
(
        1341,
        29,
        '2025-02-01',
        '18:52:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-01 18:52:26',
        'EXIT'
    ),
(
        1342,
        29,
        '2025-02-02',
        '10:04:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-02 10:04:42',
        'ENTRANCE'
    ),
(
        1343,
        28,
        '2025-02-02',
        '10:48:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-02 10:48:50',
        'ENTRANCE'
    ),
(
        1344,
        33,
        '2025-02-02',
        '11:03:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-02 11:03:48',
        'ENTRANCE'
    ),
(
        1345,
        29,
        '2025-02-02',
        '18:53:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-02 18:53:26',
        'EXIT'
    ),
(
        1346,
        33,
        '2025-02-02',
        '19:07:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-02 19:07:37',
        'EXIT'
    ),
(
        1347,
        28,
        '2025-02-02',
        '20:03:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-02 20:03:27',
        'EXIT'
    ),
(
        1348,
        29,
        '2025-02-03',
        '09:04:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-03 09:04:07',
        'ENTRANCE'
    ),
(
        1349,
        33,
        '2025-02-03',
        '11:26:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-03 11:26:47',
        'ENTRANCE'
    ),
(
        1350,
        39,
        '2025-02-03',
        '12:04:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-03 12:04:44',
        'ENTRANCE'
    ),
(
        1351,
        29,
        '2025-02-03',
        '17:59:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-03 17:59:51',
        'EXIT'
    ),
(
        1352,
        33,
        '2025-02-03',
        '19:06:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-03 19:06:07',
        'EXIT'
    ),
(
        1353,
        27,
        '2025-02-04',
        '08:07:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-04 08:07:58',
        'ENTRANCE'
    ),
(
        1354,
        34,
        '2025-02-04',
        '08:26:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-04 08:26:48',
        'ENTRANCE'
    ),
(
        1355,
        28,
        '2025-02-04',
        '08:47:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-04 08:47:33',
        'ENTRANCE'
    ),
(
        1356,
        38,
        '2025-02-04',
        '08:47:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-04 08:47:43',
        'ENTRANCE'
    ),
(
        1357,
        29,
        '2025-02-04',
        '09:17:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-04 09:17:22',
        'ENTRANCE'
    ),
(
        1358,
        32,
        '2025-02-04',
        '11:09:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-04 11:09:03',
        'ENTRANCE'
    ),
(
        1359,
        39,
        '2025-02-04',
        '11:29:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-04 11:29:58',
        'ENTRANCE'
    ),
(
        1360,
        29,
        '2025-02-04',
        '18:02:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-04 18:02:02',
        'EXIT'
    ),
(
        1361,
        38,
        '2025-02-04',
        '18:15:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-04 18:15:59',
        'EXIT'
    ),
(
        1362,
        28,
        '2025-02-04',
        '18:27:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-04 18:27:58',
        'EXIT'
    ),
(
        1363,
        32,
        '2025-02-04',
        '19:00:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-04 19:00:07',
        'EXIT'
    ),
(
        1364,
        30,
        '2025-02-05',
        '08:15:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-05 08:15:55',
        'ENTRANCE'
    ),
(
        1365,
        27,
        '2025-02-05',
        '08:20:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-05 08:20:09',
        'ENTRANCE'
    ),
(
        1366,
        34,
        '2025-02-05',
        '08:34:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-05 08:34:46',
        'ENTRANCE'
    ),
(
        1367,
        28,
        '2025-02-05',
        '08:48:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-05 08:48:35',
        'ENTRANCE'
    ),
(
        1368,
        38,
        '2025-02-05',
        '08:57:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-05 08:57:54',
        'ENTRANCE'
    ),
(
        1369,
        29,
        '2025-02-05',
        '09:00:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-05 09:00:43',
        'ENTRANCE'
    ),
(
        1370,
        32,
        '2025-02-05',
        '11:14:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-05 11:14:17',
        'ENTRANCE'
    ),
(
        1371,
        29,
        '2025-02-05',
        '17:56:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-05 17:56:35',
        'EXIT'
    ),
(
        1372,
        27,
        '2025-02-05',
        '17:59:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-05 17:59:58',
        'EXIT'
    ),
(
        1373,
        30,
        '2025-02-05',
        '18:00:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-05 18:00:23',
        'EXIT'
    ),
(
        1374,
        38,
        '2025-02-05',
        '18:07:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-05 18:07:57',
        'EXIT'
    ),
(
        1375,
        28,
        '2025-02-05',
        '18:13:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-05 18:13:00',
        'EXIT'
    ),
(
        1376,
        34,
        '2025-02-05',
        '18:20:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-05 18:20:36',
        'EXIT'
    ),
(
        1377,
        32,
        '2025-02-05',
        '19:00:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-05 19:00:23',
        'EXIT'
    ),
(
        1378,
        27,
        '2025-02-06',
        '08:29:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-06 08:29:51',
        'ENTRANCE'
    ),
(
        1379,
        34,
        '2025-02-06',
        '08:41:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-06 08:41:00',
        'ENTRANCE'
    ),
(
        1380,
        38,
        '2025-02-06',
        '09:02:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-06 09:02:39',
        'ENTRANCE'
    ),
(
        1381,
        28,
        '2025-02-06',
        '09:04:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-06 09:04:13',
        'ENTRANCE'
    ),
(
        1382,
        29,
        '2025-02-06',
        '09:11:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-06 09:11:31',
        'ENTRANCE'
    ),
(
        1383,
        32,
        '2025-02-06',
        '11:10:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-06 11:10:31',
        'ENTRANCE'
    ),
(
        1384,
        39,
        '2025-02-06',
        '11:28:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-06 11:28:24',
        'ENTRANCE'
    ),
(
        1385,
        29,
        '2025-02-06',
        '17:53:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-06 17:53:48',
        'EXIT'
    ),
(
        1386,
        38,
        '2025-02-06',
        '18:13:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-06 18:13:49',
        'EXIT'
    ),
(
        1387,
        28,
        '2025-02-06',
        '18:27:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-06 18:27:48',
        'EXIT'
    ),
(
        1388,
        34,
        '2025-02-06',
        '18:58:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-06 18:58:27',
        'EXIT'
    ),
(
        1389,
        32,
        '2025-02-06',
        '19:00:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-06 19:00:26',
        'EXIT'
    ),
(
        1390,
        28,
        '2025-02-07',
        '08:33:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-07 08:33:09',
        'ENTRANCE'
    ),
(
        1391,
        27,
        '2025-02-07',
        '08:34:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-07 08:34:46',
        'ENTRANCE'
    ),
(
        1392,
        34,
        '2025-02-07',
        '08:39:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-07 08:39:05',
        'ENTRANCE'
    ),
(
        1393,
        38,
        '2025-02-07',
        '09:01:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-07 09:01:49',
        'ENTRANCE'
    ),
(
        1394,
        30,
        '2025-02-07',
        '09:27:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-07 09:27:54',
        'ENTRANCE'
    ),
(
        1395,
        32,
        '2025-02-07',
        '11:14:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-07 11:14:01',
        'ENTRANCE'
    ),
(
        1396,
        39,
        '2025-02-07',
        '11:15:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-07 11:15:19',
        'ENTRANCE'
    ),
(
        1397,
        30,
        '2025-02-07',
        '18:00:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-07 18:00:03',
        'EXIT'
    ),
(
        1398,
        27,
        '2025-02-07',
        '18:04:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-07 18:04:15',
        'EXIT'
    ),
(
        1399,
        38,
        '2025-02-07',
        '18:05:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-07 18:05:10',
        'EXIT'
    ),
(
        1400,
        34,
        '2025-02-07',
        '18:07:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-07 18:07:46',
        'EXIT'
    ),
(
        1401,
        28,
        '2025-02-07',
        '18:11:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-07 18:11:34',
        'EXIT'
    ),
(
        1402,
        32,
        '2025-02-07',
        '19:08:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-07 19:08:18',
        'EXIT'
    ),
(
        1403,
        28,
        '2025-02-08',
        '08:30:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-08 08:30:45',
        'ENTRANCE'
    ),
(
        1404,
        34,
        '2025-02-08',
        '09:05:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-08 09:05:02',
        'ENTRANCE'
    ),
(
        1405,
        38,
        '2025-02-08',
        '09:06:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-08 09:06:26',
        'ENTRANCE'
    ),
(
        1406,
        27,
        '2025-02-08',
        '09:06:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-08 09:06:38',
        'ENTRANCE'
    ),
(
        1407,
        29,
        '2025-02-08',
        '09:10:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-08 09:10:03',
        'ENTRANCE'
    ),
(
        1408,
        27,
        '2025-02-01',
        '20:03:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-01 22:03:01',
        'EXIT'
    ),
(
        1409,
        27,
        '2025-02-04',
        '18:08:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-04 18:08:25',
        'EXIT'
    ),
(
        1410,
        27,
        '2025-02-06',
        '18:10:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-06 18:10:41',
        'EXIT'
    ),
(
        1411,
        30,
        '2025-02-08',
        '09:38:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-08 09:38:46',
        'ENTRANCE'
    ),
(
        1412,
        33,
        '2025-02-08',
        '11:08:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-08 11:08:35',
        'ENTRANCE'
    ),
(
        1413,
        39,
        '2025-02-08',
        '11:23:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-08 11:23:37',
        'ENTRANCE'
    ),
(
        1414,
        38,
        '2025-02-08',
        '15:07:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-08 15:07:09',
        'EXIT'
    ),
(
        1415,
        27,
        '2025-02-08',
        '15:07:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-08 15:07:25',
        'EXIT'
    ),
(
        1416,
        28,
        '2025-02-08',
        '15:22:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-08 15:22:39',
        'EXIT'
    ),
(
        1417,
        29,
        '2025-02-08',
        '17:56:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-08 17:56:36',
        'EXIT'
    ),
(
        1418,
        30,
        '2025-02-08',
        '18:00:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-08 18:00:33',
        'EXIT'
    ),
(
        1419,
        33,
        '2025-02-08',
        '19:03:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-08 19:03:16',
        'EXIT'
    ),
(
        1420,
        29,
        '2025-02-09',
        '09:12:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-09 09:12:01',
        'ENTRANCE'
    ),
(
        1421,
        30,
        '2025-02-09',
        '09:27:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-09 09:27:37',
        'ENTRANCE'
    ),
(
        1422,
        33,
        '2025-02-09',
        '10:47:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-09 10:47:41',
        'ENTRANCE'
    ),
(
        1423,
        39,
        '2025-02-09',
        '11:32:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-09 11:32:19',
        'ENTRANCE'
    ),
(
        1424,
        29,
        '2025-02-09',
        '17:54:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-09 17:54:41',
        'EXIT'
    ),
(
        1425,
        30,
        '2025-02-09',
        '18:00:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-09 18:00:02',
        'EXIT'
    ),
(
        1426,
        27,
        '2025-02-10',
        '08:26:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-10 08:26:49',
        'ENTRANCE'
    ),
(
        1427,
        34,
        '2025-02-10',
        '08:30:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-10 08:30:13',
        'ENTRANCE'
    ),
(
        1428,
        28,
        '2025-02-10',
        '08:44:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-10 08:44:55',
        'ENTRANCE'
    ),
(
        1429,
        38,
        '2025-02-10',
        '08:45:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-10 08:45:41',
        'ENTRANCE'
    ),
(
        1430,
        30,
        '2025-02-10',
        '09:02:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-10 09:02:33',
        'ENTRANCE'
    ),
(
        1431,
        29,
        '2025-02-10',
        '09:06:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-10 09:06:44',
        'ENTRANCE'
    ),
(
        1432,
        39,
        '2025-02-10',
        '11:18:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-10 11:18:41',
        'ENTRANCE'
    ),
(
        1433,
        32,
        '2025-02-10',
        '11:27:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-10 11:27:48',
        'ENTRANCE'
    ),
(
        1434,
        29,
        '2025-02-10',
        '17:54:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-10 17:54:50',
        'EXIT'
    ),
(
        1435,
        38,
        '2025-02-10',
        '17:55:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-10 17:55:12',
        'EXIT'
    ),
(
        1436,
        27,
        '2025-02-10',
        '17:58:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-10 17:58:11',
        'EXIT'
    ),
(
        1437,
        30,
        '2025-02-10',
        '18:00:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-10 18:00:13',
        'EXIT'
    ),
(
        1438,
        28,
        '2025-02-10',
        '18:07:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-10 18:07:57',
        'EXIT'
    ),
(
        1439,
        34,
        '2025-02-10',
        '18:45:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-10 18:45:44',
        'EXIT'
    ),
(
        1440,
        32,
        '2025-02-10',
        '19:00:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-10 19:00:24',
        'EXIT'
    ),
(
        1441,
        28,
        '2025-02-11',
        '08:56:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-11 08:56:42',
        'ENTRANCE'
    ),
(
        1442,
        38,
        '2025-02-11',
        '09:10:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-11 09:10:21',
        'ENTRANCE'
    ),
(
        1443,
        27,
        '2025-02-11',
        '09:10:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-11 09:10:55',
        'ENTRANCE'
    ),
(
        1444,
        29,
        '2025-02-11',
        '09:12:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-11 09:12:03',
        'ENTRANCE'
    ),
(
        1445,
        30,
        '2025-02-11',
        '09:29:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-11 09:29:27',
        'ENTRANCE'
    ),
(
        1446,
        39,
        '2025-02-11',
        '10:15:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-11 10:15:10',
        'ENTRANCE'
    ),
(
        1447,
        32,
        '2025-02-11',
        '11:15:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-11 11:15:51',
        'ENTRANCE'
    ),
(
        1448,
        29,
        '2025-02-11',
        '17:52:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-11 17:52:32',
        'EXIT'
    ),
(
        1449,
        30,
        '2025-02-11',
        '18:00:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-11 18:00:04',
        'EXIT'
    ),
(
        1450,
        38,
        '2025-02-11',
        '18:02:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-11 18:02:11',
        'EXIT'
    ),
(
        1451,
        27,
        '2025-02-11',
        '18:02:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-11 18:02:47',
        'EXIT'
    ),
(
        1452,
        34,
        '2025-02-11',
        '18:04:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-11 18:04:40',
        'ENTRANCE'
    ),
(
        1453,
        34,
        '2025-02-11',
        '18:04:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-11 18:04:48',
        'EXIT'
    ),
(
        1454,
        28,
        '2025-02-11',
        '18:07:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-11 18:07:25',
        'EXIT'
    ),
(
        1455,
        32,
        '2025-02-11',
        '19:00:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-11 19:00:05',
        'EXIT'
    ),
(
        1456,
        27,
        '2025-02-12',
        '08:25:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-12 08:25:54',
        'ENTRANCE'
    ),
(
        1457,
        34,
        '2025-02-12',
        '08:31:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-12 08:31:04',
        'ENTRANCE'
    ),
(
        1458,
        28,
        '2025-02-12',
        '08:59:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-12 08:59:04',
        'ENTRANCE'
    ),
(
        1459,
        30,
        '2025-02-12',
        '09:04:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-12 09:04:57',
        'ENTRANCE'
    ),
(
        1460,
        38,
        '2025-02-12',
        '09:05:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-12 09:05:25',
        'ENTRANCE'
    ),
(
        1461,
        29,
        '2025-02-12',
        '09:25:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-12 09:25:36',
        'ENTRANCE'
    ),
(
        1462,
        40,
        '2025-02-12',
        '11:22:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-12 11:22:24',
        'ENTRANCE'
    ),
(
        1463,
        32,
        '2025-02-12',
        '11:25:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-12 11:25:25',
        'ENTRANCE'
    ),
(
        1464,
        28,
        '2025-02-12',
        '17:26:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-12 17:26:17',
        'EXIT'
    ),
(
        1465,
        29,
        '2025-02-12',
        '17:55:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-12 17:55:49',
        'EXIT'
    ),
(
        1466,
        30,
        '2025-02-12',
        '18:03:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-12 18:03:55',
        'EXIT'
    ),
(
        1467,
        38,
        '2025-02-12',
        '18:11:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-12 18:11:27',
        'EXIT'
    ),
(
        1468,
        27,
        '2025-02-12',
        '18:12:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-12 18:12:48',
        'EXIT'
    ),
(
        1469,
        32,
        '2025-02-12',
        '19:00:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-12 19:00:17',
        'EXIT'
    ),
(
        1470,
        40,
        '2025-02-12',
        '20:21:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-12 20:21:28',
        'EXIT'
    ),
(
        1471,
        27,
        '2025-02-13',
        '08:29:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-13 08:29:29',
        'ENTRANCE'
    ),
(
        1472,
        38,
        '2025-02-13',
        '08:56:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-13 08:56:00',
        'ENTRANCE'
    ),
(
        1473,
        34,
        '2025-02-13',
        '08:59:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-13 08:59:33',
        'ENTRANCE'
    ),
(
        1474,
        28,
        '2025-02-13',
        '09:09:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-13 09:09:10',
        'ENTRANCE'
    ),
(
        1475,
        29,
        '2025-02-13',
        '09:11:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-13 09:11:47',
        'ENTRANCE'
    ),
(
        1476,
        32,
        '2025-02-13',
        '11:22:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-13 11:22:51',
        'ENTRANCE'
    ),
(
        1477,
        29,
        '2025-02-13',
        '18:00:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-13 18:00:50',
        'EXIT'
    ),
(
        1478,
        38,
        '2025-02-13',
        '18:09:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-13 18:09:32',
        'EXIT'
    ),
(
        1479,
        28,
        '2025-02-13',
        '18:33:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-13 18:33:14',
        'EXIT'
    ),
(
        1480,
        32,
        '2025-02-13',
        '19:00:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-13 19:00:04',
        'EXIT'
    ),
(
        1481,
        30,
        '2025-02-14',
        '08:20:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-14 08:20:24',
        'ENTRANCE'
    ),
(
        1482,
        34,
        '2025-02-14',
        '08:41:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-14 08:41:50',
        'ENTRANCE'
    ),
(
        1483,
        38,
        '2025-02-14',
        '09:17:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-14 09:17:01',
        'ENTRANCE'
    ),
(
        1484,
        28,
        '2025-02-14',
        '09:18:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-14 09:18:18',
        'ENTRANCE'
    ),
(
        1485,
        32,
        '2025-02-14',
        '11:18:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-14 11:18:46',
        'ENTRANCE'
    ),
(
        1486,
        40,
        '2025-02-14',
        '11:21:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-14 11:21:13',
        'ENTRANCE'
    ),
(
        1487,
        30,
        '2025-02-14',
        '18:02:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-14 18:02:35',
        'EXIT'
    ),
(
        1488,
        38,
        '2025-02-14',
        '18:09:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-14 18:09:02',
        'EXIT'
    ),
(
        1489,
        28,
        '2025-02-14',
        '18:14:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-14 18:14:24',
        'EXIT'
    ),
(
        1490,
        34,
        '2025-02-14',
        '18:16:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-14 18:16:35',
        'EXIT'
    ),
(
        1491,
        27,
        '2025-02-14',
        '18:16:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-14 18:16:51',
        'EXIT'
    ),
(
        1492,
        32,
        '2025-02-14',
        '19:00:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-14 19:00:03',
        'EXIT'
    ),
(
        1493,
        27,
        '2025-02-15',
        '08:21:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-15 08:21:45',
        'ENTRANCE'
    ),
(
        1494,
        34,
        '2025-02-15',
        '08:21:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-15 08:21:55',
        'ENTRANCE'
    ),
(
        1495,
        28,
        '2025-02-15',
        '08:24:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-15 08:24:02',
        'ENTRANCE'
    ),
(
        1496,
        30,
        '2025-02-15',
        '09:09:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-15 09:09:21',
        'ENTRANCE'
    ),
(
        1497,
        38,
        '2025-02-15',
        '09:14:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-15 09:14:23',
        'ENTRANCE'
    ),
(
        1498,
        29,
        '2025-02-15',
        '09:35:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-15 09:35:35',
        'ENTRANCE'
    ),
(
        1499,
        32,
        '2025-02-15',
        '11:12:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-15 11:12:09',
        'ENTRANCE'
    ),
(
        1500,
        40,
        '2025-02-15',
        '11:16:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-15 11:16:07',
        'ENTRANCE'
    ),
(
        1501,
        27,
        '2025-02-15',
        '15:04:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-15 15:04:13',
        'EXIT'
    ),
(
        1502,
        38,
        '2025-02-15',
        '15:04:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-15 15:04:27',
        'EXIT'
    ),
(
        1503,
        32,
        '2025-02-15',
        '16:57:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-15 16:57:55',
        'EXIT'
    ),
(
        1504,
        29,
        '2025-02-15',
        '17:54:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-15 17:54:21',
        'EXIT'
    ),
(
        1505,
        30,
        '2025-02-15',
        '18:00:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-15 18:00:17',
        'EXIT'
    ),
(
        1506,
        30,
        '2025-02-15',
        '18:00:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-15 18:00:17',
        'EXIT'
    ),
(
        1507,
        29,
        '2025-02-16',
        '09:33:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-16 09:33:08',
        'ENTRANCE'
    ),
(
        1508,
        40,
        '2025-02-16',
        '11:02:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-16 11:02:44',
        'ENTRANCE'
    ),
(
        1509,
        33,
        '2025-02-16',
        '11:06:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-16 11:06:54',
        'ENTRANCE'
    ),
(
        1510,
        29,
        '2025-02-16',
        '18:00:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-16 18:00:27',
        'EXIT'
    ),
(
        1511,
        40,
        '2025-02-16',
        '20:28:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-16 20:28:31',
        'EXIT'
    ),
(
        1512,
        27,
        '2025-02-17',
        '08:18:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-17 08:18:32',
        'ENTRANCE'
    ),
(
        1513,
        34,
        '2025-02-17',
        '08:29:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-17 08:29:13',
        'ENTRANCE'
    ),
(
        1514,
        28,
        '2025-02-17',
        '08:41:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-17 08:41:59',
        'ENTRANCE'
    ),
(
        1515,
        38,
        '2025-02-17',
        '09:04:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-17 09:04:14',
        'ENTRANCE'
    ),
(
        1516,
        29,
        '2025-02-17',
        '09:05:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-17 09:05:07',
        'ENTRANCE'
    ),
(
        1517,
        30,
        '2025-02-17',
        '09:22:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-17 09:22:43',
        'ENTRANCE'
    ),
(
        1518,
        40,
        '2025-02-17',
        '11:09:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-17 11:09:22',
        'ENTRANCE'
    ),
(
        1519,
        33,
        '2025-02-17',
        '11:26:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-17 11:26:35',
        'ENTRANCE'
    ),
(
        1520,
        29,
        '2025-02-17',
        '17:51:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-17 17:51:12',
        'EXIT'
    ),
(
        1521,
        28,
        '2025-02-17',
        '18:13:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-17 18:13:07',
        'EXIT'
    ),
(
        1522,
        38,
        '2025-02-17',
        '18:13:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-17 18:13:19',
        'EXIT'
    ),
(
        1523,
        40,
        '2025-02-17',
        '20:16:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-17 20:16:10',
        'EXIT'
    ),
(
        1524,
        28,
        '2025-02-18',
        '08:19:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-18 08:19:47',
        'ENTRANCE'
    ),
(
        1525,
        34,
        '2025-02-18',
        '08:37:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-18 08:37:18',
        'ENTRANCE'
    ),
(
        1526,
        27,
        '2025-02-18',
        '09:01:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-18 09:01:28',
        'ENTRANCE'
    ),
(
        1527,
        38,
        '2025-02-18',
        '09:01:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-18 09:01:46',
        'ENTRANCE'
    ),
(
        1528,
        30,
        '2025-02-18',
        '09:04:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-18 09:04:40',
        'ENTRANCE'
    ),
(
        1529,
        29,
        '2025-02-18',
        '09:06:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-18 09:06:09',
        'ENTRANCE'
    ),
(
        1530,
        40,
        '2025-02-18',
        '11:04:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-18 11:04:45',
        'ENTRANCE'
    ),
(
        1531,
        32,
        '2025-02-18',
        '11:13:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-18 11:13:48',
        'ENTRANCE'
    ),
(
        1532,
        29,
        '2025-02-18',
        '18:00:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-18 18:00:04',
        'EXIT'
    ),
(
        1533,
        30,
        '2025-02-18',
        '18:00:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-18 18:00:13',
        'EXIT'
    ),
(
        1534,
        38,
        '2025-02-18',
        '18:16:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-18 18:16:35',
        'EXIT'
    ),
(
        1535,
        28,
        '2025-02-18',
        '18:26:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-18 18:26:48',
        'EXIT'
    ),
(
        1536,
        32,
        '2025-02-18',
        '19:06:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-18 19:06:34',
        'EXIT'
    ),
(
        1537,
        40,
        '2025-02-18',
        '20:04:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-18 20:04:24',
        'EXIT'
    ),
(
        1538,
        28,
        '2025-02-19',
        '07:48:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-19 07:48:38',
        'ENTRANCE'
    ),
(
        1539,
        27,
        '2025-02-19',
        '08:16:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-19 08:16:20',
        'ENTRANCE'
    ),
(
        1540,
        38,
        '2025-02-19',
        '09:00:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-19 09:00:08',
        'ENTRANCE'
    ),
(
        1541,
        34,
        '2025-02-19',
        '09:00:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-19 09:00:18',
        'ENTRANCE'
    ),
(
        1542,
        30,
        '2025-02-19',
        '09:04:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-19 09:04:09',
        'ENTRANCE'
    ),
(
        1543,
        29,
        '2025-02-19',
        '09:38:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-19 09:38:41',
        'ENTRANCE'
    ),
(
        1544,
        40,
        '2025-02-19',
        '11:10:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-19 11:10:48',
        'ENTRANCE'
    ),
(
        1545,
        29,
        '2025-02-19',
        '17:52:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-19 17:52:54',
        'EXIT'
    ),
(
        1546,
        38,
        '2025-02-19',
        '18:13:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-19 18:13:05',
        'EXIT'
    ),
(
        1547,
        27,
        '2025-02-19',
        '18:18:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-19 18:18:08',
        'EXIT'
    ),
(
        1548,
        34,
        '2025-02-19',
        '18:18:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-19 18:18:21',
        'EXIT'
    ),
(
        1549,
        30,
        '2025-02-19',
        '18:25:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-19 18:25:25',
        'EXIT'
    ),
(
        1550,
        28,
        '2025-02-19',
        '18:28:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-19 18:28:25',
        'EXIT'
    ),
(
        1551,
        32,
        '2025-02-19',
        '19:03:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-19 19:03:16',
        'EXIT'
    ),
(
        1552,
        40,
        '2025-02-19',
        '20:01:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-19 20:01:36',
        'EXIT'
    ),
(
        1553,
        34,
        '2025-02-20',
        '08:13:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-20 08:13:38',
        'ENTRANCE'
    ),
(
        1554,
        28,
        '2025-02-20',
        '08:31:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-20 08:31:03',
        'ENTRANCE'
    ),
(
        1555,
        29,
        '2025-02-20',
        '09:06:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-20 09:06:33',
        'ENTRANCE'
    ),
(
        1556,
        38,
        '2025-02-20',
        '09:25:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-20 09:25:03',
        'ENTRANCE'
    ),
(
        1557,
        27,
        '2025-02-20',
        '09:25:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-20 09:25:36',
        'ENTRANCE'
    ),
(
        1558,
        40,
        '2025-02-20',
        '11:09:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-20 11:09:21',
        'ENTRANCE'
    ),
(
        1559,
        33,
        '2025-02-20',
        '11:25:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-20 11:25:12',
        'ENTRANCE'
    ),
(
        1560,
        29,
        '2025-02-20',
        '17:56:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-20 17:56:54',
        'EXIT'
    ),
(
        1561,
        27,
        '2025-02-20',
        '18:16:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-20 18:16:41',
        'EXIT'
    ),
(
        1562,
        38,
        '2025-02-20',
        '18:17:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-20 18:17:14',
        'EXIT'
    ),
(
        1563,
        28,
        '2025-02-20',
        '18:25:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-20 18:25:53',
        'EXIT'
    ),
(
        1564,
        40,
        '2025-02-20',
        '20:01:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-20 20:01:17',
        'EXIT'
    ),
(
        1565,
        27,
        '2025-02-21',
        '08:19:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-21 08:19:10',
        'ENTRANCE'
    ),
(
        1566,
        34,
        '2025-02-21',
        '08:24:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-21 08:24:24',
        'ENTRANCE'
    ),
(
        1567,
        30,
        '2025-02-21',
        '08:48:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-21 08:48:17',
        'ENTRANCE'
    ),
(
        1568,
        28,
        '2025-02-21',
        '08:54:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-21 08:54:40',
        'ENTRANCE'
    ),
(
        1569,
        38,
        '2025-02-21',
        '09:03:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-21 09:03:14',
        'ENTRANCE'
    ),
(
        1570,
        32,
        '2025-02-21',
        '11:15:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-21 11:15:46',
        'ENTRANCE'
    ),
(
        1571,
        40,
        '2025-02-21',
        '11:17:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-21 11:17:00',
        'ENTRANCE'
    ),
(
        1572,
        30,
        '2025-02-21',
        '18:00:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-21 18:00:21',
        'EXIT'
    ),
(
        1573,
        28,
        '2025-02-21',
        '18:09:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-21 18:09:32',
        'EXIT'
    ),
(
        1574,
        38,
        '2025-02-21',
        '18:17:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-21 18:17:37',
        'EXIT'
    ),
(
        1575,
        32,
        '2025-02-21',
        '18:59:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-21 18:59:42',
        'EXIT'
    ),
(
        1576,
        40,
        '2025-02-21',
        '20:06:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-21 20:06:18',
        'EXIT'
    ),
(
        1577,
        28,
        '2025-02-22',
        '08:13:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-22 08:13:05',
        'ENTRANCE'
    ),
(
        1578,
        27,
        '2025-02-22',
        '09:02:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-22 09:02:27',
        'ENTRANCE'
    ),
(
        1579,
        38,
        '2025-02-22',
        '09:02:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-22 09:02:41',
        'ENTRANCE'
    ),
(
        1580,
        34,
        '2025-02-22',
        '09:16:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-22 09:16:49',
        'ENTRANCE'
    ),
(
        1581,
        30,
        '2025-02-22',
        '09:21:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-22 09:21:10',
        'ENTRANCE'
    ),
(
        1582,
        29,
        '2025-02-22',
        '09:43:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-22 09:43:10',
        'ENTRANCE'
    ),
(
        1583,
        33,
        '2025-02-22',
        '11:30:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-22 11:30:17',
        'ENTRANCE'
    ),
(
        1584,
        38,
        '2025-02-22',
        '15:05:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-22 15:05:53',
        'EXIT'
    ),
(
        1585,
        27,
        '2025-02-22',
        '15:06:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-22 15:06:36',
        'EXIT'
    ),
(
        1586,
        28,
        '2025-02-22',
        '15:45:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-22 15:45:54',
        'EXIT'
    ),
(
        1587,
        29,
        '2025-02-22',
        '17:53:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-22 17:53:29',
        'EXIT'
    ),
(
        1588,
        30,
        '2025-02-22',
        '18:00:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-22 18:00:52',
        'EXIT'
    ),
(
        1589,
        30,
        '2025-02-23',
        '09:06:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-23 09:06:53',
        'ENTRANCE'
    ),
(
        1590,
        29,
        '2025-02-23',
        '09:16:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-23 09:16:45',
        'ENTRANCE'
    ),
(
        1591,
        33,
        '2025-02-23',
        '11:17:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-23 11:17:54',
        'ENTRANCE'
    ),
(
        1592,
        40,
        '2025-02-23',
        '11:21:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-23 11:21:42',
        'ENTRANCE'
    ),
(
        1593,
        29,
        '2025-02-23',
        '18:05:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-23 18:05:12',
        'EXIT'
    ),
(
        1594,
        30,
        '2025-02-23',
        '18:14:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-23 18:14:16',
        'EXIT'
    ),
(
        1595,
        33,
        '2025-02-23',
        '19:04:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-23 19:04:27',
        'EXIT'
    ),
(
        1596,
        40,
        '2025-02-23',
        '20:02:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-23 20:02:46',
        'EXIT'
    ),
(
        1597,
        27,
        '2025-02-24',
        '08:15:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-24 08:15:51',
        'ENTRANCE'
    ),
(
        1598,
        30,
        '2025-02-24',
        '08:16:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-24 08:16:39',
        'ENTRANCE'
    ),
(
        1599,
        34,
        '2025-02-24',
        '08:22:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-24 08:22:29',
        'ENTRANCE'
    ),
(
        1600,
        38,
        '2025-02-24',
        '08:53:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-24 08:53:50',
        'ENTRANCE'
    ),
(
        1601,
        28,
        '2025-02-24',
        '08:56:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-24 08:56:37',
        'ENTRANCE'
    ),
(
        1602,
        29,
        '2025-02-24',
        '09:11:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-24 09:11:43',
        'ENTRANCE'
    ),
(
        1603,
        40,
        '2025-02-24',
        '11:19:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-24 11:19:28',
        'ENTRANCE'
    ),
(
        1604,
        32,
        '2025-02-24',
        '11:23:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-24 11:23:17',
        'ENTRANCE'
    ),
(
        1605,
        27,
        '0000-00-00',
        '00:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '0000-00-00 00:00:00',
        'EXIT'
    ),
(
        1606,
        27,
        '0000-00-00',
        '18:17:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '0000-00-00 00:00:00',
        'EXIT'
    ),
(
        1607,
        27,
        '2025-02-17',
        '18:17:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-17 18:17:05',
        'EXIT'
    ),
(
        1608,
        27,
        '2025-02-18',
        '18:11:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-18 18:11:05',
        'EXIT'
    ),
(
        1609,
        27,
        '2025-02-21',
        '18:09:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-21 18:09:11',
        'EXIT'
    ),
(
        1610,
        29,
        '2025-02-24',
        '17:53:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-24 17:53:05',
        'EXIT'
    ),
(
        1611,
        30,
        '2025-02-24',
        '18:00:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-24 18:00:22',
        'EXIT'
    ),
(
        1612,
        34,
        '2025-02-24',
        '18:02:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-24 18:02:13',
        'EXIT'
    ),
(
        1613,
        28,
        '2025-02-24',
        '18:02:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-24 18:02:35',
        'EXIT'
    ),
(
        1614,
        38,
        '2025-02-24',
        '18:03:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-24 18:03:49',
        'EXIT'
    ),
(
        1615,
        32,
        '2025-02-24',
        '19:03:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-24 19:03:53',
        'EXIT'
    ),
(
        1616,
        40,
        '2025-02-24',
        '20:02:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-24 20:02:02',
        'EXIT'
    ),
(
        1617,
        27,
        '2025-02-25',
        '08:10:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-25 08:10:33',
        'ENTRANCE'
    ),
(
        1618,
        34,
        '2025-02-25',
        '08:34:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-25 08:34:04',
        'ENTRANCE'
    ),
(
        1619,
        38,
        '2025-02-25',
        '08:59:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-25 08:59:55',
        'ENTRANCE'
    ),
(
        1620,
        30,
        '2025-02-25',
        '09:00:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-25 09:00:32',
        'ENTRANCE'
    ),
(
        1621,
        28,
        '2025-02-25',
        '09:05:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-25 09:05:17',
        'ENTRANCE'
    ),
(
        1622,
        29,
        '2025-02-25',
        '09:09:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-25 09:09:47',
        'ENTRANCE'
    ),
(
        1623,
        32,
        '2025-02-25',
        '11:13:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-25 11:13:49',
        'ENTRANCE'
    ),
(
        1624,
        40,
        '2025-02-25',
        '11:15:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-25 11:15:12',
        'ENTRANCE'
    ),
(
        1625,
        30,
        '2025-02-25',
        '18:01:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-25 18:01:10',
        'EXIT'
    ),
(
        1626,
        29,
        '2025-02-25',
        '18:04:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-25 18:04:59',
        'EXIT'
    ),
(
        1627,
        38,
        '2025-02-25',
        '18:17:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-25 18:17:41',
        'EXIT'
    ),
(
        1628,
        27,
        '2025-02-25',
        '18:18:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-25 18:18:48',
        'EXIT'
    ),
(
        1629,
        28,
        '2025-02-25',
        '18:19:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-25 18:19:14',
        'EXIT'
    ),
(
        1630,
        40,
        '2025-02-25',
        '18:30:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-25 18:30:57',
        'EXIT'
    ),
(
        1631,
        32,
        '2025-02-25',
        '19:00:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-25 19:00:15',
        'EXIT'
    ),
(
        1632,
        27,
        '2025-02-26',
        '08:07:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-26 08:07:43',
        'ENTRANCE'
    ),
(
        1633,
        34,
        '2025-02-26',
        '08:27:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-26 08:27:41',
        'ENTRANCE'
    ),
(
        1634,
        28,
        '2025-02-26',
        '08:53:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-26 08:53:50',
        'ENTRANCE'
    ),
(
        1635,
        30,
        '2025-02-26',
        '09:05:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-26 09:05:00',
        'ENTRANCE'
    ),
(
        1636,
        38,
        '2025-02-26',
        '09:07:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-26 09:07:39',
        'ENTRANCE'
    ),
(
        1637,
        29,
        '2025-02-26',
        '09:21:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-26 09:21:27',
        'ENTRANCE'
    ),
(
        1638,
        40,
        '2025-02-26',
        '11:04:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-26 11:04:54',
        'ENTRANCE'
    ),
(
        1639,
        29,
        '2025-02-26',
        '17:56:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-26 17:56:43',
        'EXIT'
    ),
(
        1640,
        30,
        '2025-02-26',
        '18:01:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-26 18:01:05',
        'EXIT'
    ),
(
        1641,
        34,
        '2025-02-26',
        '18:48:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-26 18:48:16',
        'EXIT'
    ),
(
        1642,
        32,
        '2025-02-26',
        '19:00:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-26 19:00:04',
        'EXIT'
    ),
(
        1643,
        40,
        '2025-02-26',
        '20:01:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-26 20:01:06',
        'EXIT'
    ),
(
        1644,
        30,
        '2025-02-27',
        '07:56:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-27 07:56:39',
        'ENTRANCE'
    ),
(
        1645,
        34,
        '2025-02-27',
        '08:22:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-27 08:22:17',
        'ENTRANCE'
    ),
(
        1646,
        28,
        '2025-02-27',
        '08:41:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-27 08:41:44',
        'ENTRANCE'
    ),
(
        1647,
        38,
        '2025-02-27',
        '09:13:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-27 09:13:12',
        'ENTRANCE'
    ),
(
        1648,
        29,
        '2025-02-27',
        '09:14:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-27 09:14:36',
        'ENTRANCE'
    ),
(
        1649,
        32,
        '2025-02-27',
        '11:14:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-27 11:14:50',
        'ENTRANCE'
    ),
(
        1650,
        38,
        '0000-00-00',
        '18:30:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '0000-00-00 00:00:00',
        'EXIT'
    ),
(
        1652,
        38,
        '2025-02-26',
        '18:30:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-26 18:30:15',
        'EXIT'
    ),
(
        1653,
        27,
        '2025-02-24',
        '18:30:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-24 18:30:15',
        'EXIT'
    ),
(
        1654,
        27,
        '2025-02-26',
        '18:14:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-26 18:14:15',
        'EXIT'
    ),
(
        1655,
        30,
        '2025-02-27',
        '18:00:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-27 18:00:05',
        'EXIT'
    ),
(
        1656,
        27,
        '2025-02-27',
        '08:05:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-27 08:05:10',
        'ENTRANCE'
    ),
(
        1657,
        29,
        '2025-02-27',
        '18:00:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-27 18:00:39',
        'EXIT'
    ),
(
        1658,
        27,
        '2025-02-27',
        '18:00:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-27 18:00:40',
        'EXIT'
    ),
(
        1659,
        38,
        '2025-02-27',
        '18:00:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-27 18:00:52',
        'EXIT'
    ),
(
        1660,
        32,
        '2025-02-27',
        '19:01:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-27 19:01:12',
        'EXIT'
    ),
(
        1661,
        30,
        '2025-02-28',
        '07:57:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-28 07:57:19',
        'ENTRANCE'
    ),
(
        1662,
        28,
        '2025-02-28',
        '08:31:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-28 08:31:04',
        'ENTRANCE'
    ),
(
        1663,
        34,
        '2025-02-28',
        '08:39:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-28 08:39:28',
        'ENTRANCE'
    ),
(
        1664,
        27,
        '2025-02-28',
        '08:54:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-28 08:54:36',
        'ENTRANCE'
    ),
(
        1665,
        38,
        '2025-02-28',
        '08:54:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-28 08:54:46',
        'ENTRANCE'
    ),
(
        1666,
        40,
        '2025-02-28',
        '11:07:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-28 11:07:14',
        'ENTRANCE'
    ),
(
        1667,
        32,
        '2025-02-28',
        '11:12:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-28 11:12:46',
        'ENTRANCE'
    ),
(
        1668,
        30,
        '2025-02-28',
        '18:00:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-28 18:00:06',
        'EXIT'
    ),
(
        1669,
        30,
        '2025-02-28',
        '18:00:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-28 18:00:06',
        'EXIT'
    ),
(
        1670,
        34,
        '2025-02-28',
        '18:33:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-28 18:33:17',
        'EXIT'
    ),
(
        1671,
        38,
        '2025-02-28',
        '18:33:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-28 18:33:33',
        'EXIT'
    ),
(
        1672,
        27,
        '2025-02-28',
        '18:33:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-28 18:33:43',
        'EXIT'
    ),
(
        1673,
        28,
        '2025-02-28',
        '18:41:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-28 18:41:34',
        'EXIT'
    ),
(
        1674,
        32,
        '2025-02-28',
        '19:02:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-28 19:02:51',
        'EXIT'
    ),
(
        1675,
        40,
        '2025-02-28',
        '20:10:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-02-28 20:10:47',
        'EXIT'
    ),
(
        1676,
        28,
        '2025-03-01',
        '07:56:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-01 07:56:49',
        'ENTRANCE'
    ),
(
        1677,
        34,
        '2025-03-01',
        '08:43:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-01 08:43:00',
        'ENTRANCE'
    ),
(
        1678,
        30,
        '2025-03-01',
        '08:56:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-01 08:56:50',
        'ENTRANCE'
    ),
(
        1679,
        38,
        '2025-03-01',
        '09:06:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-01 09:06:10',
        'ENTRANCE'
    ),
(
        1680,
        29,
        '2025-03-01',
        '09:19:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-01 09:19:41',
        'ENTRANCE'
    ),
(
        1681,
        40,
        '2025-03-01',
        '11:08:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-01 11:08:05',
        'ENTRANCE'
    ),
(
        1682,
        28,
        '2025-03-01',
        '15:43:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-01 15:43:14',
        'EXIT'
    ),
(
        1683,
        29,
        '2025-03-01',
        '17:51:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-01 17:51:31',
        'EXIT'
    ),
(
        1684,
        30,
        '2025-03-01',
        '18:01:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-01 18:01:16',
        'EXIT'
    ),
(
        1685,
        32,
        '2025-03-01',
        '19:18:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-01 19:18:05',
        'EXIT'
    ),
(
        1686,
        40,
        '2025-03-01',
        '20:05:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-01 20:05:31',
        'EXIT'
    ),
(
        1687,
        29,
        '2025-03-02',
        '09:18:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-02 09:18:12',
        'ENTRANCE'
    ),
(
        1688,
        40,
        '2025-03-02',
        '11:06:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-02 11:06:33',
        'ENTRANCE'
    ),
(
        1689,
        33,
        '2025-03-02',
        '11:27:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-02 11:27:42',
        'ENTRANCE'
    ),
(
        1690,
        29,
        '2025-03-02',
        '17:49:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-02 17:49:45',
        'EXIT'
    ),
(
        1691,
        33,
        '2025-03-02',
        '19:01:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-02 19:01:15',
        'EXIT'
    ),
(
        1692,
        40,
        '2025-03-02',
        '20:38:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-02 20:38:43',
        'EXIT'
    ),
(
        1693,
        34,
        '2025-03-03',
        '08:28:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-03 08:28:08',
        'ENTRANCE'
    ),
(
        1694,
        27,
        '2025-03-03',
        '08:28:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-03 08:28:21',
        'ENTRANCE'
    ),
(
        1695,
        28,
        '2025-03-03',
        '08:53:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-03 08:53:07',
        'ENTRANCE'
    ),
(
        1696,
        30,
        '2025-03-03',
        '09:03:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-03 09:03:12',
        'ENTRANCE'
    ),
(
        1697,
        38,
        '2025-03-03',
        '09:05:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-03 09:05:32',
        'ENTRANCE'
    ),
(
        1698,
        29,
        '2025-03-03',
        '09:09:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-03 09:09:07',
        'ENTRANCE'
    ),
(
        1700,
        38,
        '2025-03-01',
        '15:15:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-01 15:15:15',
        'EXIT'
    ),
(
        1701,
        27,
        '2025-03-01',
        '09:07:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-01 09:07:03',
        'ENTRANCE'
    ),
(
        1702,
        27,
        '2025-03-01',
        '15:43:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-01 15:43:18',
        'EXIT'
    ),
(
        1703,
        32,
        '2025-03-03',
        '11:15:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-03 11:15:02',
        'ENTRANCE'
    ),
(
        1704,
        29,
        '2025-03-03',
        '17:53:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-03 17:53:43',
        'EXIT'
    ),
(
        1705,
        30,
        '2025-03-03',
        '18:07:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-03 18:07:47',
        'EXIT'
    ),
(
        1706,
        38,
        '2025-03-03',
        '18:11:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-03 18:11:15',
        'EXIT'
    ),
(
        1707,
        28,
        '2025-03-03',
        '18:30:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-03 18:30:51',
        'EXIT'
    ),
(
        1708,
        32,
        '2025-03-03',
        '19:00:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-03 19:00:06',
        'EXIT'
    ),
(
        1709,
        30,
        '2025-03-04',
        '09:03:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 09:03:31',
        'ENTRANCE'
    ),
(
        1710,
        27,
        '2025-03-04',
        '09:04:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 09:04:09',
        'ENTRANCE'
    ),
(
        1711,
        38,
        '2025-03-04',
        '09:04:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 09:04:22',
        'ENTRANCE'
    ),
(
        1712,
        34,
        '2025-03-04',
        '09:07:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 09:07:54',
        'ENTRANCE'
    ),
(
        1713,
        28,
        '2025-03-04',
        '09:08:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 09:08:09',
        'ENTRANCE'
    ),
(
        1714,
        29,
        '2025-03-04',
        '09:18:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 09:18:16',
        'ENTRANCE'
    ),
(
        1715,
        40,
        '2025-03-04',
        '11:06:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 11:06:34',
        'ENTRANCE'
    ),
(
        1716,
        32,
        '2025-03-04',
        '11:12:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 11:12:47',
        'ENTRANCE'
    ),
(
        1717,
        29,
        '2025-03-04',
        '17:55:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 17:55:03',
        'EXIT'
    ),
(
        1718,
        30,
        '2025-03-04',
        '18:01:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 18:01:12',
        'EXIT'
    ),
(
        1719,
        38,
        '2025-03-04',
        '18:12:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 18:12:12',
        'EXIT'
    ),
(
        1720,
        28,
        '2025-03-04',
        '18:37:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 18:37:58',
        'EXIT'
    ),
(
        1721,
        32,
        '2025-03-04',
        '19:00:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 19:00:03',
        'EXIT'
    ),
(
        1722,
        40,
        '2025-03-04',
        '20:02:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 20:02:52',
        'EXIT'
    ),
(
        1723,
        30,
        '2025-03-05',
        '08:02:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-05 08:02:08',
        'ENTRANCE'
    ),
(
        1724,
        34,
        '2025-03-05',
        '08:19:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-05 08:19:31',
        'ENTRANCE'
    ),
(
        1725,
        27,
        '2025-03-05',
        '08:19:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-05 08:19:45',
        'ENTRANCE'
    ),
(
        1726,
        28,
        '2025-03-05',
        '08:47:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-05 08:47:31',
        'ENTRANCE'
    ),
(
        1727,
        38,
        '2025-03-05',
        '09:10:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-05 09:10:20',
        'ENTRANCE'
    ),
(
        1728,
        29,
        '2025-03-05',
        '09:13:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-05 09:13:09',
        'ENTRANCE'
    ),
(
        1729,
        40,
        '2025-03-05',
        '10:57:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-05 10:57:59',
        'ENTRANCE'
    ),
(
        1730,
        32,
        '2025-03-05',
        '11:26:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-05 11:26:22',
        'ENTRANCE'
    ),
(
        1731,
        29,
        '2025-03-05',
        '17:53:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-05 17:53:19',
        'EXIT'
    ),
(
        1732,
        30,
        '2025-03-05',
        '18:00:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-05 18:00:13',
        'EXIT'
    ),
(
        1733,
        38,
        '2025-03-05',
        '18:04:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-05 18:04:51',
        'EXIT'
    ),
(
        1734,
        28,
        '2025-03-05',
        '18:09:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-05 18:09:54',
        'EXIT'
    ),
(
        1735,
        32,
        '2025-03-05',
        '19:22:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-05 19:22:08',
        'EXIT'
    ),
(
        1736,
        40,
        '2025-03-05',
        '20:05:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-05 20:05:42',
        'EXIT'
    ),
(
        1737,
        28,
        '2025-03-06',
        '08:44:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-06 08:44:34',
        'ENTRANCE'
    ),
(
        1738,
        30,
        '2025-03-06',
        '09:05:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-06 09:05:21',
        'ENTRANCE'
    ),
(
        1739,
        38,
        '2025-03-06',
        '09:07:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-06 09:07:22',
        'ENTRANCE'
    ),
(
        1740,
        29,
        '2025-03-06',
        '09:16:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-06 09:16:04',
        'ENTRANCE'
    ),
(
        1741,
        27,
        '2025-03-06',
        '11:09:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-06 11:09:40',
        'ENTRANCE'
    ),
(
        1742,
        32,
        '2025-03-06',
        '11:41:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-06 11:41:35',
        'ENTRANCE'
    ),
(
        1743,
        29,
        '2025-03-06',
        '17:55:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-06 17:55:55',
        'EXIT'
    ),
(
        1744,
        30,
        '2025-03-06',
        '18:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-06 18:00:00',
        'EXIT'
    ),
(
        1745,
        38,
        '2025-03-06',
        '18:02:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-06 18:02:38',
        'EXIT'
    ),
(
        1746,
        28,
        '2025-03-06',
        '18:21:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-06 18:21:52',
        'EXIT'
    ),
(
        1747,
        32,
        '2025-03-06',
        '19:01:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-06 19:01:49',
        'EXIT'
    ),
(
        1748,
        30,
        '2025-03-07',
        '08:01:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-07 08:01:29',
        'ENTRANCE'
    ),
(
        1749,
        28,
        '2025-03-07',
        '08:20:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-07 08:20:22',
        'ENTRANCE'
    ),
(
        1750,
        38,
        '2025-03-07',
        '09:05:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-07 09:05:56',
        'ENTRANCE'
    ),
(
        1751,
        27,
        '2025-03-07',
        '09:08:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-07 09:08:57',
        'ENTRANCE'
    ),
(
        1752,
        34,
        '2025-03-07',
        '09:09:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-07 09:09:08',
        'ENTRANCE'
    ),
(
        1753,
        32,
        '2025-03-07',
        '11:17:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-07 11:17:37',
        'ENTRANCE'
    ),
(
        1754,
        40,
        '2025-03-07',
        '11:25:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-07 11:25:59',
        'ENTRANCE'
    ),
(
        1755,
        34,
        '2025-03-07',
        '18:04:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-07 18:04:17',
        'EXIT'
    ),
(
        1756,
        28,
        '2025-03-07',
        '18:04:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-07 18:04:23',
        'EXIT'
    ),
(
        1757,
        38,
        '2025-03-07',
        '18:04:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-07 18:04:31',
        'EXIT'
    ),
(
        1758,
        27,
        '2025-03-07',
        '18:04:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-07 18:04:46',
        'EXIT'
    ),
(
        1759,
        30,
        '2025-03-07',
        '18:13:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-07 18:13:54',
        'EXIT'
    ),
(
        1760,
        32,
        '2025-03-07',
        '18:57:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-07 18:57:32',
        'EXIT'
    ),
(
        1761,
        40,
        '2025-03-07',
        '20:20:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-07 20:20:27',
        'EXIT'
    ),
(
        1762,
        29,
        '2025-03-08',
        '09:10:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-08 09:10:37',
        'ENTRANCE'
    ),
(
        1763,
        30,
        '2025-03-08',
        '09:23:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-08 09:23:30',
        'ENTRANCE'
    ),
(
        1764,
        32,
        '2025-03-08',
        '11:14:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-08 11:14:03',
        'ENTRANCE'
    ),
(
        1765,
        40,
        '2025-03-08',
        '11:14:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-08 11:14:56',
        'ENTRANCE'
    ),
(
        1766,
        29,
        '2025-03-08',
        '17:50:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-08 17:50:44',
        'EXIT'
    ),
(
        1767,
        30,
        '2025-03-08',
        '18:04:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-08 18:04:39',
        'EXIT'
    ),
(
        1768,
        32,
        '2025-03-08',
        '19:00:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-08 19:00:59',
        'EXIT'
    ),
(
        1769,
        40,
        '2025-03-08',
        '20:10:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-08 20:10:09',
        'EXIT'
    ),
(
        1770,
        29,
        '2025-03-09',
        '09:24:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-09 09:24:21',
        'ENTRANCE'
    ),
(
        1771,
        40,
        '2025-03-09',
        '11:05:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-09 11:05:56',
        'ENTRANCE'
    ),
(
        1772,
        33,
        '2025-03-09',
        '11:21:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-09 11:21:14',
        'ENTRANCE'
    ),
(
        1773,
        29,
        '2025-03-09',
        '17:53:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-09 17:53:02',
        'EXIT'
    ),
(
        1774,
        33,
        '2025-03-09',
        '19:13:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-09 19:13:24',
        'EXIT'
    ),
(
        1775,
        40,
        '2025-03-09',
        '20:03:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-09 20:03:19',
        'EXIT'
    ),
(
        1776,
        28,
        '2025-03-10',
        '08:17:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 08:17:31',
        'ENTRANCE'
    ),
(
        1777,
        27,
        '2025-03-10',
        '08:58:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 08:58:20',
        'ENTRANCE'
    ),
(
        1778,
        38,
        '2025-03-10',
        '08:58:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 08:58:43',
        'ENTRANCE'
    ),
(
        1779,
        29,
        '2025-03-10',
        '09:05:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 09:05:24',
        'ENTRANCE'
    ),
(
        1780,
        30,
        '2025-03-10',
        '09:05:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 09:05:37',
        'ENTRANCE'
    ),
(
        1781,
        34,
        '2025-03-10',
        '09:09:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 09:09:06',
        'ENTRANCE'
    ),
(
        1782,
        40,
        '2025-03-10',
        '11:15:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 11:15:45',
        'ENTRANCE'
    ),
(
        1783,
        32,
        '2025-03-10',
        '11:17:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 11:17:14',
        'ENTRANCE'
    ),
(
        1784,
        29,
        '2025-03-10',
        '18:01:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 18:01:41',
        'EXIT'
    ),
(
        1785,
        30,
        '2025-03-10',
        '18:02:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 18:02:12',
        'EXIT'
    ),
(
        1786,
        32,
        '2025-03-10',
        '19:00:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 19:00:30',
        'EXIT'
    ),
(
        1787,
        40,
        '2025-03-10',
        '20:00:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 20:00:11',
        'EXIT'
    ),
(
        1788,
        34,
        '2025-03-11',
        '08:40:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-11 08:40:27',
        'ENTRANCE'
    ),
(
        1789,
        28,
        '2025-03-11',
        '08:40:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-11 08:40:39',
        'ENTRANCE'
    ),
(
        1790,
        27,
        '2025-03-11',
        '08:40:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-11 08:40:51',
        'ENTRANCE'
    ),
(
        1791,
        30,
        '2025-03-11',
        '08:58:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-11 08:58:16',
        'ENTRANCE'
    ),
(
        1792,
        38,
        '2025-03-11',
        '08:59:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-11 08:59:05',
        'ENTRANCE'
    ),
(
        1793,
        29,
        '2025-03-11',
        '09:14:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-11 09:14:04',
        'ENTRANCE'
    ),
(
        1794,
        40,
        '2025-03-11',
        '11:12:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-11 11:12:37',
        'ENTRANCE'
    ),
(
        1795,
        32,
        '2025-03-11',
        '11:16:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-11 11:16:51',
        'ENTRANCE'
    ),
(
        1796,
        28,
        '2025-03-11',
        '18:14:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-11 18:14:48',
        'EXIT'
    ),
(
        1797,
        30,
        '2025-03-11',
        '18:15:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-11 18:15:24',
        'EXIT'
    ),
(
        1798,
        32,
        '2025-03-11',
        '18:59:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-11 18:59:56',
        'EXIT'
    ),
(
        1799,
        40,
        '2025-03-11',
        '20:13:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-11 20:13:54',
        'EXIT'
    ),
(
        1800,
        34,
        '2025-03-12',
        '08:38:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-12 08:38:02',
        'ENTRANCE'
    ),
(
        1801,
        27,
        '2025-03-12',
        '08:38:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-12 08:38:20',
        'ENTRANCE'
    ),
(
        1802,
        28,
        '2025-03-12',
        '08:53:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-12 08:53:57',
        'ENTRANCE'
    ),
(
        1803,
        30,
        '2025-03-12',
        '08:59:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-12 08:59:46',
        'ENTRANCE'
    ),
(
        1804,
        38,
        '2025-03-12',
        '09:05:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-12 09:05:29',
        'ENTRANCE'
    ),
(
        1805,
        38,
        '2025-03-10',
        '18:08:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 18:08:22',
        'EXIT'
    ),
(
        1806,
        38,
        '2025-03-11',
        '18:11:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 18:11:17',
        'EXIT'
    ),
(
        1807,
        38,
        '2025-03-11',
        '18:11:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-11 18:11:17',
        'EXIT'
    ),
(
        1808,
        27,
        '2025-03-03',
        '18:02:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-03 18:02:12',
        'EXIT'
    ),
(
        1809,
        27,
        '2025-03-04',
        '18:01:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 18:01:41',
        'EXIT'
    ),
(
        1810,
        27,
        '2025-03-05',
        '18:04:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 18:04:39',
        'EXIT'
    ),
(
        1811,
        27,
        '2025-03-06',
        '18:13:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-06 18:13:54',
        'EXIT'
    ),
(
        1812,
        32,
        '2025-03-12',
        '11:10:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-12 11:10:36',
        'ENTRANCE'
    ),
(
        1813,
        40,
        '2025-03-12',
        '11:11:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-12 11:11:24',
        'ENTRANCE'
    ),
(
        1814,
        27,
        '2025-03-05',
        '18:57:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-05 18:57:32',
        'EXIT'
    ),
(
        1815,
        27,
        '2025-03-11',
        '18:13:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-11 18:13:54',
        'EXIT'
    ),
(
        1816,
        27,
        '2025-03-10',
        '18:09:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 18:09:54',
        'EXIT'
    ),
(
        1817,
        28,
        '2025-03-10',
        '18:09:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 18:09:54',
        'EXIT'
    ),
(
        1818,
        34,
        '2025-03-10',
        '18:09:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 18:09:54',
        'EXIT'
    ),
(
        1819,
        34,
        '2025-03-10',
        '18:13:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-10 18:13:54',
        'EXIT'
    ),
(
        1820,
        34,
        '2025-03-11',
        '18:57:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-11 18:57:32',
        'EXIT'
    ),
(
        1821,
        34,
        '2025-03-05',
        '18:06:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-05 18:06:39',
        'EXIT'
    ),
(
        1822,
        34,
        '2025-03-04',
        '18:01:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-04 18:01:41',
        'EXIT'
    ),
(
        1823,
        34,
        '2025-03-03',
        '18:02:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-03 18:02:12',
        'EXIT'
    ),
(
        1824,
        34,
        '2025-03-01',
        '18:10:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-01 18:10:40',
        'EXIT'
    ),
(
        1825,
        30,
        '2025-03-12',
        '18:00:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-12 18:00:51',
        'EXIT'
    ),
(
        1826,
        28,
        '2025-03-12',
        '18:01:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-12 18:01:42',
        'EXIT'
    ),
(
        1827,
        29,
        '2025-03-12',
        '18:01:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-12 18:01:56',
        'EXIT'
    ),
(
        1828,
        38,
        '2025-03-12',
        '18:06:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-12 18:06:11',
        'EXIT'
    ),
(
        1829,
        32,
        '2025-03-12',
        '19:00:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-12 19:00:11',
        'EXIT'
    ),
(
        1830,
        40,
        '2025-03-12',
        '20:08:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-12 20:08:10',
        'EXIT'
    ),
(
        1831,
        28,
        '2025-03-13',
        '08:55:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-13 08:55:22',
        'ENTRANCE'
    ),
(
        1832,
        30,
        '2025-03-13',
        '09:02:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-13 09:02:07',
        'ENTRANCE'
    ),
(
        1833,
        34,
        '2025-03-13',
        '09:02:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-13 09:02:11',
        'ENTRANCE'
    ),
(
        1834,
        27,
        '2025-03-13',
        '09:02:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-13 09:02:24',
        'ENTRANCE'
    ),
(
        1835,
        38,
        '2025-03-13',
        '09:05:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-13 09:05:24',
        'ENTRANCE'
    ),
(
        1836,
        29,
        '2025-03-13',
        '09:29:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-13 09:29:12',
        'ENTRANCE'
    ),
(
        1837,
        29,
        '2025-03-12',
        '08:59:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-12 08:59:46',
        'ENTRANCE'
    ),
(
        1838,
        41,
        '2025-03-13',
        '11:11:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-13 11:11:12',
        'ENTRANCE'
    ),
(
        1839,
        29,
        '2025-03-11',
        '18:30:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-11 18:30:46',
        'EXIT'
    ),
(
        1840,
        32,
        '2025-03-13',
        '11:10:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-13 11:10:12',
        'ENTRANCE'
    ),
(
        1841,
        29,
        '2025-03-13',
        '17:56:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-13 17:56:15',
        'EXIT'
    ),
(
        1842,
        38,
        '2025-03-13',
        '18:05:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-13 18:05:15',
        'EXIT'
    ),
(
        1843,
        27,
        '2025-03-13',
        '18:05:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-13 18:05:27',
        'EXIT'
    ),
(
        1844,
        34,
        '2025-03-13',
        '18:05:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-13 18:05:38',
        'EXIT'
    ),
(
        1845,
        30,
        '2025-03-13',
        '18:07:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-13 18:07:53',
        'EXIT'
    ),
(
        1846,
        28,
        '2025-03-13',
        '18:27:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-13 18:27:35',
        'EXIT'
    ),
(
        1847,
        32,
        '2025-03-13',
        '19:00:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-13 19:00:09',
        'EXIT'
    ),
(
        1848,
        34,
        '2025-03-14',
        '07:48:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-14 07:48:20',
        'ENTRANCE'
    ),
(
        1849,
        27,
        '2025-03-14',
        '08:18:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-14 08:18:42',
        'ENTRANCE'
    ),
(
        1850,
        28,
        '2025-03-14',
        '08:39:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-14 08:39:43',
        'ENTRANCE'
    ),
(
        1851,
        30,
        '2025-03-14',
        '08:51:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-14 08:51:31',
        'ENTRANCE'
    ),
(
        1852,
        38,
        '2025-03-14',
        '09:07:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-14 09:07:05',
        'ENTRANCE'
    ),
(
        1853,
        40,
        '2025-03-14',
        '11:09:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-14 11:09:07',
        'ENTRANCE'
    ),
(
        1854,
        32,
        '2025-03-14',
        '11:40:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-14 11:40:58',
        'ENTRANCE'
    ),
(
        1855,
        38,
        '2025-03-14',
        '18:07:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-14 18:07:23',
        'EXIT'
    ),
(
        1856,
        30,
        '2025-03-14',
        '18:23:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-14 18:23:54',
        'EXIT'
    ),
(
        1857,
        32,
        '2025-03-14',
        '18:44:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-14 18:44:14',
        'EXIT'
    ),
(
        1858,
        40,
        '2025-03-14',
        '20:07:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-14 20:07:46',
        'EXIT'
    ),
(
        1859,
        38,
        '2025-03-15',
        '08:58:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-15 08:58:44',
        'ENTRANCE'
    ),
(
        1860,
        27,
        '2025-03-15',
        '08:59:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-15 08:59:11',
        'ENTRANCE'
    ),
(
        1861,
        30,
        '2025-03-15',
        '09:07:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-15 09:07:50',
        'ENTRANCE'
    ),
(
        1862,
        29,
        '2025-03-15',
        '09:22:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-15 09:22:17',
        'ENTRANCE'
    ),
(
        1863,
        34,
        '2025-03-15',
        '10:05:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-15 10:05:59',
        'ENTRANCE'
    ),
(
        1864,
        40,
        '2025-03-15',
        '11:09:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-15 11:09:11',
        'ENTRANCE'
    ),
(
        1865,
        38,
        '2025-03-15',
        '15:07:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-15 15:07:23',
        'EXIT'
    ),
(
        1866,
        29,
        '2025-03-15',
        '17:55:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-15 17:55:45',
        'EXIT'
    ),
(
        1867,
        30,
        '2025-03-15',
        '18:03:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-15 18:03:07',
        'EXIT'
    ),
(
        1868,
        29,
        '2025-03-16',
        '09:18:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-16 09:18:00',
        'ENTRANCE'
    ),
(
        1869,
        40,
        '2025-03-16',
        '11:17:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-16 11:17:39',
        'ENTRANCE'
    ),
(
        1870,
        41,
        '2025-03-16',
        '15:54:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-16 15:54:09',
        'ENTRANCE'
    ),
(
        1871,
        29,
        '2025-03-16',
        '17:48:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-16 17:48:26',
        'EXIT'
    ),
(
        1872,
        40,
        '2025-03-16',
        '19:56:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-16 19:56:09',
        'EXIT'
    ),
(
        1873,
        41,
        '2025-03-16',
        '19:56:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-16 19:56:47',
        'EXIT'
    ),
(
        1874,
        30,
        '2025-03-17',
        '09:07:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-17 09:07:46',
        'ENTRANCE'
    ),
(
        1875,
        29,
        '2025-03-17',
        '09:13:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-17 09:13:52',
        'ENTRANCE'
    ),
(
        1876,
        41,
        '2025-03-17',
        '11:01:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-17 11:01:19',
        'ENTRANCE'
    ),
(
        1877,
        32,
        '2025-03-17',
        '11:12:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-17 11:12:45',
        'ENTRANCE'
    ),
(
        1878,
        40,
        '2025-03-17',
        '12:55:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-17 12:55:07',
        'ENTRANCE'
    ),
(
        1879,
        41,
        '2025-03-17',
        '15:02:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-17 15:02:46',
        'EXIT'
    ),
(
        1880,
        29,
        '2025-03-17',
        '17:52:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-17 17:52:50',
        'EXIT'
    ),
(
        1881,
        30,
        '2025-03-17',
        '18:05:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-17 18:05:27',
        'EXIT'
    ),
(
        1882,
        32,
        '2025-03-17',
        '19:01:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-17 19:01:06',
        'EXIT'
    ),
(
        1883,
        40,
        '2025-03-17',
        '20:02:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-17 20:02:34',
        'EXIT'
    ),
(
        1884,
        30,
        '2025-03-18',
        '08:05:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-18 08:05:27',
        'ENTRANCE'
    ),
(
        1885,
        34,
        '2025-03-18',
        '08:50:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-18 08:50:49',
        'ENTRANCE'
    ),
(
        1886,
        28,
        '2025-03-18',
        '09:06:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-18 09:06:10',
        'ENTRANCE'
    ),
(
        1887,
        38,
        '2025-03-18',
        '09:06:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-18 09:06:43',
        'ENTRANCE'
    ),
(
        1888,
        29,
        '2025-03-18',
        '09:28:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-18 09:28:17',
        'ENTRANCE'
    ),
(
        1889,
        40,
        '2025-03-18',
        '11:08:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-18 11:08:24',
        'ENTRANCE'
    ),
(
        1890,
        32,
        '2025-03-18',
        '11:20:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-18 11:20:41',
        'ENTRANCE'
    ),
(
        1891,
        29,
        '2025-03-18',
        '17:52:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-18 17:52:25',
        'EXIT'
    ),
(
        1892,
        30,
        '2025-03-18',
        '18:00:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-18 18:00:46',
        'EXIT'
    ),
(
        1893,
        28,
        '2025-03-18',
        '18:16:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-18 18:16:57',
        'EXIT'
    ),
(
        1894,
        38,
        '2025-03-18',
        '18:17:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-18 18:17:20',
        'EXIT'
    ),
(
        1895,
        34,
        '2025-03-18',
        '18:17:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-18 18:17:31',
        'EXIT'
    ),
(
        1896,
        32,
        '2025-03-18',
        '19:00:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-18 19:00:35',
        'EXIT'
    ),
(
        1897,
        40,
        '2025-03-18',
        '19:31:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-18 19:31:17',
        'EXIT'
    ),
(
        1898,
        34,
        '2025-03-19',
        '08:29:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-19 08:29:16',
        'ENTRANCE'
    ),
(
        1899,
        30,
        '2025-03-19',
        '08:29:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-19 08:29:33',
        'ENTRANCE'
    ),
(
        1900,
        28,
        '2025-03-19',
        '08:52:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-19 08:52:06',
        'ENTRANCE'
    ),
(
        1901,
        29,
        '2025-03-19',
        '09:08:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-19 09:08:03',
        'ENTRANCE'
    ),
(
        1902,
        38,
        '2025-03-19',
        '09:16:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-19 09:16:29',
        'ENTRANCE'
    ),
(
        1903,
        32,
        '2025-03-19',
        '11:14:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-19 11:14:49',
        'ENTRANCE'
    ),
(
        1904,
        40,
        '2025-03-19',
        '11:17:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-19 11:17:20',
        'ENTRANCE'
    ),
(
        1905,
        41,
        '2025-03-19',
        '16:03:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-19 16:03:39',
        'ENTRANCE'
    ),
(
        1906,
        29,
        '2025-03-19',
        '18:02:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-19 18:02:30',
        'EXIT'
    ),
(
        1907,
        38,
        '2025-03-19',
        '18:35:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-19 18:35:10',
        'EXIT'
    ),
(
        1908,
        34,
        '2025-03-19',
        '18:35:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-19 18:35:25',
        'EXIT'
    ),
(
        1909,
        28,
        '2025-03-19',
        '18:39:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-19 18:39:56',
        'EXIT'
    ),
(
        1910,
        32,
        '2025-03-19',
        '19:01:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-19 19:01:55',
        'EXIT'
    ),
(
        1911,
        40,
        '2025-03-19',
        '20:02:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-19 20:02:43',
        'EXIT'
    ),
(
        1912,
        41,
        '2025-03-19',
        '20:03:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-19 20:03:02',
        'EXIT'
    ),
(
        1913,
        34,
        '2025-03-20',
        '08:32:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-20 08:32:38',
        'ENTRANCE'
    ),
(
        1914,
        28,
        '2025-03-20',
        '08:39:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-20 08:39:43',
        'ENTRANCE'
    ),
(
        1915,
        30,
        '2025-03-20',
        '09:03:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-20 09:03:51',
        'ENTRANCE'
    ),
(
        1916,
        38,
        '2025-03-20',
        '09:12:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-20 09:12:38',
        'ENTRANCE'
    ),
(
        1917,
        29,
        '2025-03-20',
        '09:17:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-20 09:17:47',
        'ENTRANCE'
    ),
(
        1918,
        41,
        '2025-03-20',
        '11:05:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-20 11:05:43',
        'ENTRANCE'
    ),
(
        1919,
        32,
        '2025-03-20',
        '11:23:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-20 11:23:18',
        'ENTRANCE'
    ),
(
        1920,
        29,
        '2025-03-20',
        '17:50:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-20 17:50:20',
        'EXIT'
    ),
(
        1921,
        38,
        '2025-03-20',
        '18:00:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-20 18:00:34',
        'EXIT'
    ),
(
        1922,
        28,
        '2025-03-20',
        '18:01:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-20 18:01:08',
        'EXIT'
    ),
(
        1923,
        34,
        '2025-03-20',
        '18:02:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-20 18:02:21',
        'EXIT'
    ),
(
        1924,
        30,
        '2025-03-20',
        '18:02:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-20 18:02:58',
        'EXIT'
    ),
(
        1925,
        32,
        '2025-03-20',
        '19:01:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-20 19:01:06',
        'EXIT'
    ),
(
        1926,
        41,
        '2025-03-20',
        '20:02:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-20 20:02:09',
        'EXIT'
    ),
(
        1927,
        28,
        '2025-03-21',
        '08:34:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-21 08:34:41',
        'ENTRANCE'
    ),
(
        1928,
        34,
        '2025-03-21',
        '08:35:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-21 08:35:51',
        'ENTRANCE'
    ),
(
        1929,
        30,
        '2025-03-21',
        '08:57:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-21 08:57:10',
        'ENTRANCE'
    ),
(
        1930,
        40,
        '2025-03-21',
        '11:10:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-21 11:10:27',
        'ENTRANCE'
    ),
(
        1931,
        41,
        '2025-03-21',
        '16:11:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-21 16:11:34',
        'ENTRANCE'
    ),
(
        1932,
        28,
        '2025-03-21',
        '18:02:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-21 18:02:51',
        'EXIT'
    ),
(
        1933,
        38,
        '2025-03-21',
        '18:05:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-21 18:05:04',
        'EXIT'
    ),
(
        1934,
        34,
        '2025-03-21',
        '18:05:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-21 18:05:21',
        'EXIT'
    ),
(
        1935,
        28,
        '2025-03-22',
        '09:09:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-22 09:09:53',
        'ENTRANCE'
    ),
(
        1936,
        30,
        '2025-03-22',
        '09:12:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-22 09:12:06',
        'ENTRANCE'
    ),
(
        1937,
        29,
        '2025-03-22',
        '09:14:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-22 09:14:36',
        'ENTRANCE'
    ),
(
        1938,
        34,
        '2025-03-22',
        '09:18:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-22 09:18:59',
        'ENTRANCE'
    ),
(
        1939,
        38,
        '2025-03-22',
        '09:19:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-22 09:19:51',
        'ENTRANCE'
    ),
(
        1940,
        40,
        '2025-03-22',
        '11:25:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-22 11:25:22',
        'ENTRANCE'
    ),
(
        1941,
        28,
        '2025-03-22',
        '15:09:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-22 15:09:54',
        'EXIT'
    ),
(
        1942,
        38,
        '2025-03-22',
        '15:16:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-22 15:16:03',
        'EXIT'
    ),
(
        1943,
        38,
        '2025-03-22',
        '15:16:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-22 15:16:03',
        'EXIT'
    ),
(
        1944,
        34,
        '2025-03-22',
        '15:22:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-22 15:22:07',
        'EXIT'
    ),
(
        1945,
        29,
        '2025-03-22',
        '17:57:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-22 17:57:41',
        'EXIT'
    ),
(
        1946,
        30,
        '2025-03-22',
        '18:01:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-22 18:01:11',
        'EXIT'
    ),
(
        1947,
        32,
        '2025-03-22',
        '19:00:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-22 19:00:11',
        'EXIT'
    ),
(
        1948,
        40,
        '2025-03-22',
        '19:58:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-22 19:58:32',
        'EXIT'
    ),
(
        1949,
        29,
        '2025-03-23',
        '09:11:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 09:11:17',
        'ENTRANCE'
    ),
(
        1950,
        40,
        '2025-03-23',
        '11:11:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-23 11:11:02',
        'ENTRANCE'
    ),
(
        1951,
        33,
        '2025-03-23',
        '11:29:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-23 11:29:58',
        'ENTRANCE'
    ),
(
        1952,
        41,
        '2025-03-23',
        '15:45:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-23 15:45:50',
        'ENTRANCE'
    ),
(
        1953,
        29,
        '2025-03-23',
        '17:51:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-23 17:51:44',
        'EXIT'
    ),
(
        1954,
        41,
        '2025-03-23',
        '20:02:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-23 20:02:37',
        'EXIT'
    ),
(
        1955,
        40,
        '2025-03-23',
        '20:03:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-23 20:03:06',
        'EXIT'
    ),
(
        1956,
        30,
        '2025-03-24',
        '08:03:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 08:03:42',
        'ENTRANCE'
    ),
(
        1957,
        34,
        '2025-03-24',
        '08:10:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 08:10:01',
        'ENTRANCE'
    ),
(
        1958,
        27,
        '2025-03-24',
        '08:10:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 08:10:59',
        'ENTRANCE'
    ),
(
        1959,
        28,
        '2025-03-24',
        '09:07:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 09:07:26',
        'ENTRANCE'
    ),
(
        1960,
        38,
        '2025-03-24',
        '09:15:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 09:15:07',
        'ENTRANCE'
    ),
(
        1961,
        29,
        '2025-03-24',
        '09:13:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 09:13:12',
        'ENTRANCE'
    ),
(
        1962,
        40,
        '2025-03-24',
        '11:11:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 11:11:21',
        'ENTRANCE'
    ),
(
        1963,
        32,
        '2025-03-24',
        '11:50:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 11:50:58',
        'ENTRANCE'
    ),
(
        1964,
        41,
        '2025-03-24',
        '16:16:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 16:16:52',
        'ENTRANCE'
    ),
(
        1965,
        29,
        '2025-03-24',
        '17:55:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 17:55:41',
        'EXIT'
    ),
(
        1966,
        28,
        '2025-03-24',
        '17:57:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 17:57:36',
        'EXIT'
    ),
(
        1967,
        38,
        '2025-03-24',
        '17:59:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 17:59:25',
        'EXIT'
    ),
(
        1968,
        30,
        '2025-03-24',
        '18:00:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 18:00:05',
        'EXIT'
    ),
(
        1969,
        32,
        '2025-03-24',
        '19:02:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 19:02:08',
        'EXIT'
    ),
(
        1970,
        41,
        '2025-03-24',
        '20:13:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 20:13:41',
        'EXIT'
    ),
(
        1971,
        40,
        '2025-03-24',
        '20:14:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 20:14:11',
        'EXIT'
    ),
(
        1972,
        30,
        '2025-03-25',
        '08:12:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-25 08:12:44',
        'ENTRANCE'
    ),
(
        1973,
        28,
        '2025-03-25',
        '09:01:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-25 09:01:39',
        'ENTRANCE'
    ),
(
        1974,
        38,
        '2025-03-25',
        '09:16:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-25 09:16:53',
        'ENTRANCE'
    ),
(
        1975,
        29,
        '2025-03-25',
        '09:12:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-25 09:12:47',
        'ENTRANCE'
    ),
(
        1976,
        32,
        '2025-03-25',
        '11:16:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-25 11:16:21',
        'ENTRANCE'
    ),
(
        1977,
        40,
        '2025-03-25',
        '11:16:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-25 11:16:41',
        'ENTRANCE'
    ),
(
        1978,
        29,
        '2025-03-25',
        '17:51:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-25 17:51:47',
        'EXIT'
    ),
(
        1979,
        30,
        '2025-03-25',
        '18:00:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-25 18:00:16',
        'EXIT'
    ),
(
        1980,
        38,
        '2025-03-25',
        '18:10:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-25 18:10:23',
        'EXIT'
    ),
(
        1981,
        28,
        '2025-03-25',
        '18:17:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-25 18:17:40',
        'EXIT'
    ),
(
        1982,
        32,
        '2025-03-25',
        '19:00:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-25 19:00:54',
        'EXIT'
    ),
(
        1983,
        40,
        '2025-03-25',
        '20:05:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-25 20:05:50',
        'EXIT'
    ),
(
        1984,
        30,
        '2025-03-26',
        '08:15:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 08:15:22',
        'ENTRANCE'
    ),
(
        1985,
        28,
        '2025-03-26',
        '08:52:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 08:52:01',
        'ENTRANCE'
    ),
(
        1986,
        38,
        '2025-03-26',
        '09:08:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 09:08:49',
        'ENTRANCE'
    ),
(
        1987,
        34,
        '2025-03-26',
        '09:09:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 09:09:09',
        'ENTRANCE'
    ),
(
        1988,
        38,
        '2025-03-21',
        '08:59:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-21 08:59:46',
        'ENTRANCE'
    ),
(
        1989,
        29,
        '2025-03-26',
        '09:14:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 09:14:51',
        'ENTRANCE'
    ),
(
        1990,
        40,
        '2025-03-26',
        '11:06:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 11:06:54',
        'ENTRANCE'
    ),
(
        1991,
        32,
        '2025-03-26',
        '11:15:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 11:15:23',
        'ENTRANCE'
    ),
(
        1992,
        41,
        '2025-03-26',
        '15:59:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 15:59:35',
        'ENTRANCE'
    ),
(
        1993,
        29,
        '2025-03-26',
        '17:51:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 17:51:23',
        'EXIT'
    ),
(
        1994,
        30,
        '2025-03-26',
        '18:00:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 18:00:09',
        'EXIT'
    ),
(
        1995,
        28,
        '2025-03-26',
        '18:05:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 18:05:34',
        'EXIT'
    ),
(
        1996,
        38,
        '2025-03-26',
        '18:09:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 18:09:22',
        'EXIT'
    ),
(
        1997,
        32,
        '2025-03-26',
        '18:55:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 18:55:05',
        'EXIT'
    ),
(
        1998,
        41,
        '2025-03-26',
        '19:55:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 19:55:04',
        'EXIT'
    ),
(
        1999,
        40,
        '2025-03-26',
        '20:00:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 20:00:16',
        'EXIT'
    ),
(
        2000,
        34,
        '2025-03-27',
        '08:41:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-27 08:41:11',
        'ENTRANCE'
    ),
(
        2001,
        28,
        '2025-03-27',
        '08:51:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-27 08:51:02',
        'ENTRANCE'
    ),
(
        2002,
        27,
        '2025-03-27',
        '08:52:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-27 08:52:47',
        'ENTRANCE'
    ),
(
        2003,
        27,
        '2025-03-24',
        '18:13:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-24 18:13:46',
        'EXIT'
    ),
(
        2004,
        27,
        '2025-03-25',
        '18:09:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-25 18:09:15',
        'EXIT'
    ),
(
        2005,
        27,
        '2025-03-25',
        '08:18:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-25 08:18:22',
        'ENTRANCE'
    ),
(
        2006,
        27,
        '2025-03-26',
        '08:16:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 08:16:34',
        'ENTRANCE'
    ),
(
        2007,
        30,
        '2025-03-27',
        '09:00:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-27 09:00:22',
        'ENTRANCE'
    ),
(
        2008,
        27,
        '2025-03-26',
        '18:01:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-26 18:01:14',
        'EXIT'
    ),
(
        2009,
        38,
        '2025-03-27',
        '09:15:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-27 09:15:46',
        'ENTRANCE'
    ),
(
        2010,
        29,
        '2025-03-27',
        '09:05:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-27 09:05:01',
        'ENTRANCE'
    ),
(
        2011,
        29,
        '2025-03-23',
        '08:59:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-23 08:59:46',
        'ENTRANCE'
    ),
(
        2012,
        32,
        '2025-03-27',
        '11:25:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-27 11:25:14',
        'ENTRANCE'
    ),
(
        2013,
        41,
        '2025-03-27',
        '12:08:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-27 12:08:54',
        'ENTRANCE'
    ),
(
        2014,
        29,
        '2025-03-27',
        '17:55:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-27 17:55:31',
        'EXIT'
    ),
(
        2015,
        30,
        '2025-03-27',
        '18:00:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-27 18:00:12',
        'EXIT'
    ),
(
        2016,
        38,
        '2025-03-27',
        '18:09:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-27 18:09:42',
        'EXIT'
    ),
(
        2017,
        27,
        '2025-03-27',
        '18:09:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-27 18:09:53',
        'EXIT'
    ),
(
        2018,
        28,
        '2025-03-27',
        '18:11:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-27 18:11:00',
        'EXIT'
    ),
(
        2019,
        32,
        '2025-03-27',
        '19:00:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-27 19:00:50',
        'EXIT'
    ),
(
        2020,
        41,
        '2025-03-27',
        '20:00:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-27 20:00:00',
        'EXIT'
    ),
(
        2021,
        30,
        '2025-03-28',
        '09:01:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-28 09:01:57',
        'ENTRANCE'
    ),
(
        2022,
        28,
        '2025-03-28',
        '09:05:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-28 09:05:40',
        'ENTRANCE'
    ),
(
        2023,
        38,
        '2025-03-28',
        '09:05:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-28 09:05:55',
        'ENTRANCE'
    ),
(
        2024,
        34,
        '2025-03-28',
        '09:06:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-28 09:06:09',
        'ENTRANCE'
    ),
(
        2025,
        27,
        '2025-03-28',
        '09:06:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-28 09:06:36',
        'ENTRANCE'
    ),
(
        2026,
        40,
        '2025-03-28',
        '11:11:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-28 11:11:04',
        'ENTRANCE'
    ),
(
        2027,
        32,
        '2025-03-28',
        '11:20:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-28 11:20:54',
        'ENTRANCE'
    ),
(
        2028,
        41,
        '2025-03-28',
        '15:56:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-28 15:56:34',
        'ENTRANCE'
    ),
(
        2029,
        38,
        '2025-03-28',
        '18:05:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-28 18:05:12',
        'EXIT'
    ),
(
        2030,
        30,
        '2025-03-28',
        '18:21:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-28 18:21:51',
        'EXIT'
    ),
(
        2031,
        28,
        '2025-03-28',
        '18:42:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-28 18:42:58',
        'EXIT'
    ),
(
        2032,
        32,
        '2025-03-28',
        '19:03:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-28 19:03:31',
        'EXIT'
    ),
(
        2033,
        41,
        '2025-03-28',
        '20:03:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-28 20:03:51',
        'EXIT'
    ),
(
        2034,
        40,
        '2025-03-28',
        '20:04:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-28 20:04:35',
        'EXIT'
    ),
(
        2035,
        30,
        '2025-03-29',
        '09:02:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-29 09:02:43',
        'ENTRANCE'
    ),
(
        2036,
        28,
        '2025-03-29',
        '09:10:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-29 09:10:01',
        'ENTRANCE'
    ),
(
        2037,
        27,
        '2025-03-29',
        '09:11:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-29 09:11:58',
        'ENTRANCE'
    ),
(
        2038,
        38,
        '2025-03-29',
        '09:16:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-29 09:16:27',
        'ENTRANCE'
    ),
(
        2039,
        41,
        '2025-03-29',
        '11:12:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-29 11:12:36',
        'ENTRANCE'
    ),
(
        2040,
        40,
        '2025-03-29',
        '12:09:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-29 12:09:22',
        'ENTRANCE'
    ),
(
        2041,
        38,
        '2025-03-29',
        '14:31:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-29 14:31:36',
        'EXIT'
    ),
(
        2042,
        41,
        '2025-03-29',
        '14:58:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-29 14:58:59',
        'EXIT'
    ),
(
        2043,
        28,
        '2025-03-29',
        '15:04:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-29 15:04:16',
        'EXIT'
    ),
(
        2044,
        40,
        '2025-03-29',
        '20:07:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-29 20:07:27',
        'EXIT'
    ),
(
        2045,
        29,
        '2025-03-30',
        '09:06:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-30 09:06:53',
        'ENTRANCE'
    ),
(
        2046,
        40,
        '2025-03-30',
        '11:08:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-30 11:08:29',
        'ENTRANCE'
    ),
(
        2047,
        33,
        '2025-03-30',
        '11:27:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-30 11:27:50',
        'ENTRANCE'
    ),
(
        2048,
        41,
        '2025-03-30',
        '16:04:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-30 16:04:46',
        'ENTRANCE'
    ),
(
        2049,
        29,
        '2025-03-30',
        '17:51:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-30 17:51:16',
        'EXIT'
    ),
(
        2050,
        33,
        '2025-03-30',
        '19:03:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-30 19:03:23',
        'EXIT'
    ),
(
        2051,
        41,
        '2025-03-30',
        '20:04:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-30 20:04:01',
        'EXIT'
    ),
(
        2052,
        40,
        '2025-03-30',
        '20:04:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-30 20:04:36',
        'EXIT'
    ),
(
        2053,
        29,
        '2025-03-31',
        '09:06:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-31 09:06:57',
        'ENTRANCE'
    ),
(
        2054,
        34,
        '2025-03-31',
        '09:07:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-31 09:07:11',
        'ENTRANCE'
    ),
(
        2055,
        38,
        '2025-03-31',
        '09:07:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-31 09:07:22',
        'ENTRANCE'
    ),
(
        2056,
        30,
        '2025-03-31',
        '09:11:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-31 09:11:28',
        'ENTRANCE'
    ),
(
        2057,
        27,
        '2025-03-31',
        '09:25:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-31 09:25:22',
        'ENTRANCE'
    ),
(
        2058,
        28,
        '2025-03-31',
        '09:30:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-31 09:30:12',
        'ENTRANCE'
    ),
(
        2059,
        32,
        '2025-03-31',
        '11:16:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-31 11:16:53',
        'ENTRANCE'
    ),
(
        2060,
        40,
        '2025-03-31',
        '12:20:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-31 12:20:40',
        'ENTRANCE'
    ),
(
        2061,
        29,
        '2025-03-31',
        '17:55:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-31 17:55:40',
        'EXIT'
    ),
(
        2062,
        30,
        '2025-03-31',
        '18:00:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-31 18:00:16',
        'EXIT'
    ),
(
        2063,
        28,
        '2025-03-31',
        '18:14:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-31 18:14:59',
        'EXIT'
    ),
(
        2064,
        32,
        '2025-03-31',
        '19:06:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-31 19:06:10',
        'EXIT'
    ),
(
        2065,
        40,
        '2025-03-31',
        '20:03:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-31 20:03:31',
        'EXIT'
    ),
(
        2066,
        41,
        '2025-03-31',
        '20:03:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-03-31 20:03:49',
        'EXIT'
    ),
(
        2067,
        28,
        '2025-04-01',
        '08:50:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 08:50:04',
        'ENTRANCE'
    ),
(
        2068,
        30,
        '2025-04-01',
        '08:55:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 08:55:52',
        'ENTRANCE'
    ),
(
        2069,
        34,
        '2025-04-01',
        '09:07:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 09:07:25',
        'ENTRANCE'
    ),
(
        2070,
        27,
        '2025-04-01',
        '09:12:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 09:12:33',
        'ENTRANCE'
    ),
(
        2071,
        29,
        '2025-04-01',
        '09:14:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 09:14:59',
        'ENTRANCE'
    ),
(
        2072,
        38,
        '2025-04-01',
        '09:23:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 09:23:01',
        'ENTRANCE'
    ),
(
        2073,
        40,
        '2025-04-01',
        '11:11:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 11:11:58',
        'ENTRANCE'
    ),
(
        2074,
        32,
        '2025-04-01',
        '11:19:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 11:19:50',
        'ENTRANCE'
    ),
(
        2075,
        29,
        '2025-04-01',
        '17:52:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 17:52:24',
        'EXIT'
    ),
(
        2076,
        30,
        '2025-04-01',
        '18:00:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 18:00:25',
        'EXIT'
    ),
(
        2077,
        38,
        '2025-04-01',
        '18:12:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 18:12:20',
        'EXIT'
    ),
(
        2078,
        34,
        '2025-04-01',
        '18:12:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 18:12:30',
        'EXIT'
    ),
(
        2079,
        27,
        '2025-04-01',
        '18:14:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 18:14:15',
        'EXIT'
    ),
(
        2080,
        32,
        '2025-04-01',
        '19:00:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 19:00:25',
        'EXIT'
    ),
(
        2081,
        40,
        '2025-04-01',
        '20:07:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 20:07:23',
        'EXIT'
    ),
(
        2082,
        27,
        '2025-04-02',
        '08:05:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-02 08:05:37',
        'ENTRANCE'
    ),
(
        2083,
        28,
        '2025-04-02',
        '08:39:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-02 08:39:56',
        'ENTRANCE'
    ),
(
        2084,
        30,
        '2025-04-02',
        '08:57:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-02 08:57:17',
        'ENTRANCE'
    ),
(
        2085,
        38,
        '2025-04-02',
        '09:06:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-02 09:06:10',
        'ENTRANCE'
    ),
(
        2086,
        34,
        '2025-04-02',
        '09:10:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-02 09:10:13',
        'ENTRANCE'
    ),
(
        2087,
        29,
        '2025-04-02',
        '09:12:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-02 09:12:47',
        'ENTRANCE'
    ),
(
        2088,
        40,
        '2025-04-02',
        '10:59:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-02 10:59:21',
        'ENTRANCE'
    ),
(
        2089,
        32,
        '2025-04-02',
        '11:27:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-02 11:27:25',
        'ENTRANCE'
    ),
(
        2090,
        41,
        '2025-04-02',
        '16:15:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-02 16:15:27',
        'ENTRANCE'
    ),
(
        2091,
        29,
        '2025-04-02',
        '17:52:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-02 17:52:56',
        'EXIT'
    ),
(
        2092,
        30,
        '2025-04-02',
        '18:03:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-02 18:03:57',
        'EXIT'
    ),
(
        2093,
        28,
        '2025-04-02',
        '18:07:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-02 18:07:04',
        'EXIT'
    ),
(
        2094,
        32,
        '2025-04-02',
        '19:06:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-02 19:06:06',
        'EXIT'
    ),
(
        2095,
        41,
        '2025-04-02',
        '19:57:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-02 19:57:12',
        'EXIT'
    ),
(
        2096,
        40,
        '2025-04-02',
        '20:01:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-02 20:01:05',
        'EXIT'
    ),
(
        2097,
        34,
        '2025-04-03',
        '08:01:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-03 08:01:03',
        'ENTRANCE'
    ),
(
        2098,
        30,
        '2025-04-03',
        '08:55:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-03 08:55:13',
        'ENTRANCE'
    ),
(
        2099,
        28,
        '2025-04-03',
        '09:04:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-03 09:04:23',
        'ENTRANCE'
    ),
(
        2100,
        38,
        '2025-04-03',
        '09:06:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-03 09:06:14',
        'ENTRANCE'
    ),
(
        2101,
        29,
        '2025-04-03',
        '09:11:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-03 09:11:36',
        'ENTRANCE'
    ),
(
        2102,
        41,
        '2025-04-03',
        '10:57:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-03 10:57:22',
        'ENTRANCE'
    ),
(
        2103,
        32,
        '2025-04-03',
        '11:15:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-03 11:15:23',
        'ENTRANCE'
    ),
(
        2104,
        29,
        '2025-04-03',
        '17:50:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-03 17:50:20',
        'EXIT'
    ),
(
        2105,
        30,
        '2025-04-03',
        '18:00:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-03 18:00:36',
        'EXIT'
    ),
(
        2106,
        38,
        '2025-04-03',
        '18:05:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-03 18:05:05',
        'EXIT'
    ),
(
        2107,
        28,
        '2025-04-03',
        '18:09:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-03 18:09:27',
        'EXIT'
    ),
(
        2108,
        41,
        '2025-04-03',
        '19:52:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-03 19:52:00',
        'EXIT'
    ),
(
        2109,
        28,
        '2025-04-04',
        '08:48:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-04 08:48:43',
        'ENTRANCE'
    ),
(
        2110,
        34,
        '2025-04-04',
        '08:50:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-04 08:50:26',
        'ENTRANCE'
    ),
(
        2111,
        30,
        '2025-04-04',
        '09:02:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-04 09:02:35',
        'ENTRANCE'
    ),
(
        2112,
        27,
        '2025-04-04',
        '09:04:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-04 09:04:15',
        'ENTRANCE'
    ),
(
        2113,
        38,
        '2025-04-04',
        '09:13:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-04 09:13:41',
        'ENTRANCE'
    ),
(
        2114,
        40,
        '2025-04-04',
        '11:07:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-04 11:07:01',
        'ENTRANCE'
    ),
(
        2115,
        32,
        '2025-04-04',
        '11:15:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-04 11:15:27',
        'ENTRANCE'
    ),
(
        2116,
        41,
        '2025-04-04',
        '16:13:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-04 16:13:47',
        'ENTRANCE'
    ),
(
        2117,
        28,
        '2025-04-04',
        '18:31:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-04 18:31:47',
        'EXIT'
    ),
(
        2118,
        38,
        '2025-04-04',
        '18:35:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-04 18:35:23',
        'EXIT'
    ),
(
        2119,
        32,
        '2025-04-04',
        '18:57:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-04 18:57:06',
        'EXIT'
    ),
(
        2120,
        41,
        '2025-04-04',
        '19:59:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-04 19:59:18',
        'EXIT'
    ),
(
        2121,
        40,
        '2025-04-04',
        '19:59:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-04 19:59:34',
        'EXIT'
    ),
(
        2122,
        28,
        '2025-04-05',
        '08:31:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-05 08:31:17',
        'ENTRANCE'
    ),
(
        2123,
        38,
        '2025-04-05',
        '08:56:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-05 08:56:20',
        'ENTRANCE'
    ),
(
        2124,
        27,
        '2025-04-05',
        '09:21:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-05 09:21:50',
        'ENTRANCE'
    ),
(
        2125,
        40,
        '2025-04-05',
        '11:07:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-05 11:07:28',
        'ENTRANCE'
    ),
(
        2126,
        28,
        '2025-04-05',
        '15:04:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-05 15:04:56',
        'EXIT'
    ),
(
        2127,
        41,
        '2025-04-05',
        '16:28:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-05 16:28:06',
        'ENTRANCE'
    ),
(
        2128,
        32,
        '2025-04-05',
        '18:58:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-05 18:58:25',
        'EXIT'
    ),
(
        2129,
        41,
        '2025-04-05',
        '19:59:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-05 19:59:48',
        'EXIT'
    ),
(
        2130,
        40,
        '2025-04-05',
        '20:01:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-05 20:01:05',
        'EXIT'
    ),
(
        2131,
        29,
        '2025-04-06',
        '09:30:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-06 09:30:12',
        'ENTRANCE'
    ),
(
        2132,
        40,
        '2025-04-06',
        '11:10:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-06 11:10:35',
        'ENTRANCE'
    ),
(
        2133,
        33,
        '2025-04-06',
        '11:28:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-06 11:28:54',
        'ENTRANCE'
    ),
(
        2134,
        41,
        '2025-04-06',
        '16:08:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-06 16:08:08',
        'ENTRANCE'
    ),
(
        2135,
        29,
        '2025-04-06',
        '17:46:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-06 17:46:30',
        'EXIT'
    ),
(
        2136,
        41,
        '2025-04-06',
        '19:55:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-06 19:55:38',
        'EXIT'
    ),
(
        2137,
        40,
        '2025-04-06',
        '19:56:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-06 19:56:27',
        'EXIT'
    ),
(
        2138,
        34,
        '2025-04-07',
        '08:27:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 08:27:54',
        'ENTRANCE'
    ),
(
        2139,
        27,
        '2025-04-07',
        '08:29:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 08:29:29',
        'ENTRANCE'
    ),
(
        2140,
        28,
        '2025-04-07',
        '08:40:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 08:40:46',
        'ENTRANCE'
    ),
(
        2141,
        30,
        '2025-04-07',
        '09:04:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 09:04:01',
        'ENTRANCE'
    ),
(
        2142,
        29,
        '2025-04-07',
        '09:16:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 09:16:35',
        'ENTRANCE'
    ),
(
        2143,
        38,
        '2025-04-07',
        '09:28:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 09:28:48',
        'ENTRANCE'
    ),
(
        2144,
        40,
        '2025-04-07',
        '11:04:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 11:04:56',
        'ENTRANCE'
    ),
(
        2145,
        33,
        '2025-04-07',
        '11:16:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 11:16:06',
        'ENTRANCE'
    ),
(
        2146,
        41,
        '2025-04-07',
        '16:30:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 16:30:05',
        'ENTRANCE'
    ),
(
        2147,
        30,
        '2025-04-07',
        '18:00:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 18:00:14',
        'EXIT'
    ),
(
        2148,
        34,
        '2025-04-07',
        '18:02:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 18:02:59',
        'EXIT'
    ),
(
        2149,
        38,
        '2025-04-07',
        '18:03:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 18:03:11',
        'EXIT'
    ),
(
        2150,
        27,
        '2025-04-07',
        '18:03:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 18:03:24',
        'EXIT'
    ),
(
        2151,
        29,
        '2025-04-07',
        '18:04:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 18:04:09',
        'EXIT'
    ),
(
        2152,
        32,
        '2025-04-07',
        '19:00:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 19:00:03',
        'EXIT'
    ),
(
        2153,
        41,
        '2025-04-07',
        '20:09:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 20:09:22',
        'EXIT'
    ),
(
        2154,
        40,
        '2025-04-07',
        '20:10:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 20:10:00',
        'EXIT'
    ),
(
        2155,
        28,
        '2025-04-08',
        '09:04:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-08 09:04:37',
        'ENTRANCE'
    ),
(
        2156,
        30,
        '2025-04-08',
        '09:05:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-08 09:05:47',
        'ENTRANCE'
    ),
(
        2157,
        29,
        '2025-04-08',
        '09:11:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-08 09:11:31',
        'ENTRANCE'
    ),
(
        2158,
        27,
        '2025-04-08',
        '08:17:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-08 09:17:46',
        'ENTRANCE'
    ),
(
        2159,
        38,
        '2025-04-08',
        '09:10:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-08 09:10:08',
        'ENTRANCE'
    ),
(
        2160,
        34,
        '2025-04-08',
        '08:15:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-08 08:15:47',
        'ENTRANCE'
    ),
(
        2161,
        40,
        '2025-04-08',
        '11:03:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-08 11:03:19',
        'ENTRANCE'
    ),
(
        2162,
        32,
        '2025-04-08',
        '11:29:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-08 11:29:32',
        'ENTRANCE'
    ),
(
        2163,
        29,
        '2025-04-08',
        '17:53:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-08 17:53:18',
        'EXIT'
    ),
(
        2164,
        30,
        '2025-04-08',
        '18:00:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-08 18:00:28',
        'EXIT'
    ),
(
        2165,
        28,
        '2025-04-08',
        '18:23:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-08 18:23:32',
        'EXIT'
    ),
(
        2166,
        32,
        '2025-04-08',
        '19:00:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-08 19:00:12',
        'EXIT'
    ),
(
        2167,
        40,
        '2025-04-08',
        '20:02:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-08 20:02:51',
        'EXIT'
    ),
(
        2168,
        30,
        '2025-04-09',
        '09:03:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-09 09:03:27',
        'ENTRANCE'
    ),
(
        2169,
        38,
        '2025-04-09',
        '09:05:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-09 09:05:37',
        'ENTRANCE'
    ),
(
        2170,
        34,
        '2025-04-09',
        '09:06:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-09 09:06:06',
        'ENTRANCE'
    ),
(
        2171,
        27,
        '2025-04-09',
        '09:06:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-09 09:06:19',
        'ENTRANCE'
    ),
(
        2172,
        28,
        '2025-04-09',
        '09:06:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-09 09:06:31',
        'ENTRANCE'
    ),
(
        2173,
        29,
        '2025-04-09',
        '09:21:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-09 09:21:46',
        'ENTRANCE'
    ),
(
        2174,
        40,
        '2025-04-09',
        '11:07:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-09 11:07:26',
        'ENTRANCE'
    ),
(
        2175,
        32,
        '2025-04-09',
        '11:16:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-09 11:16:35',
        'ENTRANCE'
    ),
(
        2176,
        41,
        '2025-04-09',
        '16:23:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-09 16:23:05',
        'ENTRANCE'
    ),
(
        2177,
        29,
        '2025-04-09',
        '17:58:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-09 17:58:57',
        'EXIT'
    ),
(
        2178,
        30,
        '2025-04-09',
        '18:00:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-09 18:00:11',
        'EXIT'
    ),
(
        2179,
        38,
        '2025-04-09',
        '18:07:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-09 18:07:41',
        'EXIT'
    ),
(
        2180,
        28,
        '2025-04-09',
        '18:09:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-09 18:09:14',
        'EXIT'
    ),
(
        2181,
        29,
        '2025-04-01',
        '18:22:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 18:22:46',
        'EXIT'
    ),
(
        2182,
        29,
        '2025-04-07',
        '18:12:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 18:12:16',
        'EXIT'
    ),
(
        2183,
        28,
        '2025-04-07',
        '18:12:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-07 18:12:16',
        'EXIT'
    ),
(
        2184,
        28,
        '2025-04-01',
        '18:22:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-01 18:22:46',
        'EXIT'
    ),
(
        2185,
        32,
        '2025-04-09',
        '19:00:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-09 19:00:03',
        'EXIT'
    ),
(
        2186,
        41,
        '2025-04-09',
        '19:53:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-09 19:53:51',
        'EXIT'
    ),
(
        2187,
        40,
        '2025-04-09',
        '19:55:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-09 19:55:27',
        'EXIT'
    ),
(
        2188,
        30,
        '2025-04-10',
        '09:08:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-10 09:08:59',
        'ENTRANCE'
    ),
(
        2189,
        28,
        '2025-04-10',
        '09:19:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-10 09:19:48',
        'ENTRANCE'
    ),
(
        2190,
        34,
        '2025-04-10',
        '08:25:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-10 08:25:57',
        'ENTRANCE'
    ),
(
        2191,
        27,
        '2025-04-10',
        '09:11:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-10 09:11:56',
        'ENTRANCE'
    ),
(
        2192,
        38,
        '2025-04-10',
        '09:21:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-10 09:21:06',
        'ENTRANCE'
    ),
(
        2193,
        29,
        '2025-04-10',
        '09:14:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-10 09:14:05',
        'ENTRANCE'
    ),
(
        2194,
        32,
        '2025-04-10',
        '11:21:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-10 11:21:00',
        'ENTRANCE'
    ),
(
        2195,
        29,
        '2025-04-10',
        '17:57:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-10 17:57:10',
        'EXIT'
    ),
(
        2196,
        28,
        '2025-04-10',
        '18:07:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-10 18:07:54',
        'EXIT'
    ),
(
        2197,
        30,
        '2025-04-10',
        '18:11:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-10 18:11:34',
        'EXIT'
    ),
(
        2198,
        32,
        '2025-04-10',
        '19:00:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-10 19:00:10',
        'EXIT'
    ),
(
        2199,
        34,
        '2025-04-11',
        '08:43:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-11 08:43:46',
        'ENTRANCE'
    ),
(
        2200,
        27,
        '2025-04-11',
        '08:43:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-11 08:43:58',
        'ENTRANCE'
    ),
(
        2201,
        38,
        '2025-04-11',
        '08:44:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-11 08:44:09',
        'ENTRANCE'
    ),
(
        2202,
        28,
        '2025-04-11',
        '08:49:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-11 08:49:36',
        'ENTRANCE'
    ),
(
        2203,
        30,
        '2025-04-11',
        '09:13:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-11 09:13:00',
        'ENTRANCE'
    ),
(
        2204,
        40,
        '2025-04-11',
        '11:14:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-11 11:14:07',
        'ENTRANCE'
    ),
(
        2205,
        32,
        '2025-04-11',
        '11:41:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-11 11:41:27',
        'ENTRANCE'
    ),
(
        2206,
        30,
        '2025-04-11',
        '18:00:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-11 18:00:36',
        'EXIT'
    ),
(
        2207,
        28,
        '2025-04-11',
        '18:25:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-11 18:25:09',
        'EXIT'
    ),
(
        2208,
        40,
        '2025-04-11',
        '20:00:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-11 20:00:40',
        'EXIT'
    ),
(
        2209,
        28,
        '2025-04-12',
        '08:42:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-12 08:42:20',
        'ENTRANCE'
    ),
(
        2210,
        34,
        '2025-04-12',
        '08:50:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-12 08:50:59',
        'ENTRANCE'
    ),
(
        2211,
        27,
        '2025-04-12',
        '08:51:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-12 08:51:12',
        'ENTRANCE'
    ),
(
        2212,
        38,
        '2025-04-12',
        '08:55:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-12 08:55:09',
        'ENTRANCE'
    ),
(
        2213,
        30,
        '2025-04-12',
        '09:04:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-12 09:04:35',
        'ENTRANCE'
    ),
(
        2214,
        29,
        '2025-04-12',
        '09:18:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-12 09:18:53',
        'ENTRANCE'
    ),
(
        2215,
        40,
        '2025-04-12',
        '11:09:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-12 11:09:06',
        'ENTRANCE'
    ),
(
        2216,
        32,
        '2025-04-12',
        '11:12:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-12 11:12:15',
        'ENTRANCE'
    ),
(
        2217,
        28,
        '2025-04-12',
        '15:07:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-12 15:07:06',
        'EXIT'
    ),
(
        2218,
        41,
        '2025-04-12',
        '15:54:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-12 15:54:44',
        'ENTRANCE'
    ),
(
        2219,
        29,
        '2025-04-12',
        '17:49:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-12 17:49:34',
        'EXIT'
    ),
(
        2220,
        30,
        '2025-04-12',
        '18:00:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-12 18:00:57',
        'EXIT'
    ),
(
        2221,
        40,
        '2025-04-12',
        '18:55:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-12 18:55:51',
        'EXIT'
    ),
(
        2222,
        32,
        '2025-04-12',
        '19:00:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-12 19:00:02',
        'EXIT'
    ),
(
        2223,
        41,
        '2025-04-12',
        '19:57:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-12 19:57:04',
        'EXIT'
    ),
(
        2224,
        29,
        '2025-04-13',
        '09:13:38',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-13 09:13:38',
        'ENTRANCE'
    ),
(
        2225,
        40,
        '2025-04-13',
        '11:07:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-13 11:07:47',
        'ENTRANCE'
    ),
(
        2226,
        33,
        '2025-04-13',
        '11:15:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-13 11:15:45',
        'ENTRANCE'
    ),
(
        2227,
        41,
        '2025-04-13',
        '15:52:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-13 15:52:57',
        'ENTRANCE'
    ),
(
        2228,
        29,
        '2025-04-13',
        '17:51:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-13 17:51:48',
        'EXIT'
    ),
(
        2229,
        33,
        '2025-04-13',
        '19:08:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-13 19:08:53',
        'EXIT'
    ),
(
        2230,
        40,
        '2025-04-13',
        '19:54:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-13 19:54:34',
        'EXIT'
    ),
(
        2231,
        41,
        '2025-04-13',
        '19:54:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-13 19:54:52',
        'EXIT'
    ),
(
        2232,
        34,
        '2025-04-14',
        '08:29:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-14 08:29:49',
        'ENTRANCE'
    ),
(
        2233,
        38,
        '2025-04-14',
        '08:47:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-14 08:47:18',
        'ENTRANCE'
    ),
(
        2234,
        27,
        '2025-04-14',
        '08:53:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-14 08:53:17',
        'ENTRANCE'
    ),
(
        2235,
        38,
        '2025-04-02',
        '18:15:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-02 18:15:46',
        'EXIT'
    ),
(
        2236,
        38,
        '2025-04-05',
        '15:14:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-05 15:14:46',
        'EXIT'
    ),
(
        2237,
        38,
        '2025-04-08',
        '18:10:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-08 18:10:10',
        'EXIT'
    ),
(
        2238,
        38,
        '2025-04-11',
        '18:09:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-11 18:11:10',
        'EXIT'
    ),
(
        2239,
        38,
        '2025-04-10',
        '18:18:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-10 18:18:40',
        'EXIT'
    ),
(
        2240,
        38,
        '2025-04-12',
        '18:11:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-12 18:11:14',
        'EXIT'
    ),
(
        2241,
        29,
        '2025-04-14',
        '09:04:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-14 09:04:11',
        'ENTRANCE'
    ),
(
        2242,
        30,
        '2025-04-14',
        '09:05:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-14 09:05:17',
        'ENTRANCE'
    ),
(
        2243,
        28,
        '2025-04-14',
        '09:07:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-14 09:07:19',
        'ENTRANCE'
    ),
(
        2244,
        33,
        '2025-04-14',
        '11:16:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-14 11:16:48',
        'ENTRANCE'
    ),
(
        2245,
        40,
        '2025-04-14',
        '11:31:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-14 11:31:14',
        'ENTRANCE'
    ),
(
        2246,
        41,
        '2025-04-14',
        '16:47:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-14 16:47:53',
        'ENTRANCE'
    ),
(
        2247,
        29,
        '2025-04-14',
        '17:54:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-14 17:54:26',
        'EXIT'
    ),
(
        2248,
        30,
        '2025-04-14',
        '18:00:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-14 18:00:57',
        'EXIT'
    ),
(
        2249,
        38,
        '2025-04-14',
        '18:13:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-14 18:13:29',
        'EXIT'
    ),
(
        2250,
        28,
        '2025-04-14',
        '18:17:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-14 18:17:46',
        'EXIT'
    ),
(
        2251,
        33,
        '2025-04-14',
        '19:00:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-14 19:00:30',
        'EXIT'
    ),
(
        2252,
        41,
        '2025-04-14',
        '19:58:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-14 19:58:45',
        'EXIT'
    ),
(
        2253,
        40,
        '2025-04-14',
        '19:59:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-14 19:59:04',
        'EXIT'
    ),
(
        2254,
        34,
        '2025-04-15',
        '08:31:54',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 08:31:54',
        'ENTRANCE'
    ),
(
        2255,
        28,
        '2025-04-15',
        '08:40:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 08:40:34',
        'ENTRANCE'
    ),
(
        2256,
        38,
        '2025-04-15',
        '09:00:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 09:00:07',
        'ENTRANCE'
    ),
(
        2257,
        27,
        '2025-04-15',
        '09:01:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 09:01:47',
        'ENTRANCE'
    ),
(
        2258,
        30,
        '2025-04-15',
        '09:08:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 09:08:16',
        'ENTRANCE'
    ),
(
        2259,
        29,
        '2025-04-15',
        '09:20:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 09:20:39',
        'ENTRANCE'
    ),
(
        2260,
        40,
        '2025-04-15',
        '11:15:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 11:15:24',
        'ENTRANCE'
    ),
(
        2261,
        33,
        '2025-04-15',
        '11:34:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 11:34:24',
        'ENTRANCE'
    ),
(
        2262,
        41,
        '2025-04-15',
        '15:49:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 15:49:09',
        'ENTRANCE'
    ),
(
        2263,
        29,
        '2025-04-15',
        '17:51:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 17:51:40',
        'EXIT'
    ),
(
        2264,
        30,
        '2025-04-15',
        '18:02:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 18:02:13',
        'EXIT'
    ),
(
        2265,
        28,
        '2025-04-15',
        '18:04:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 18:04:56',
        'EXIT'
    ),
(
        2266,
        34,
        '2025-04-15',
        '18:06:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 18:06:00',
        'EXIT'
    ),
(
        2267,
        27,
        '2025-04-15',
        '18:06:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 18:06:11',
        'EXIT'
    ),
(
        2268,
        38,
        '2025-04-15',
        '18:06:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 18:06:21',
        'EXIT'
    ),
(
        2269,
        41,
        '2025-04-15',
        '19:59:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 19:59:09',
        'EXIT'
    ),
(
        2270,
        40,
        '2025-04-15',
        '19:59:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-15 19:59:29',
        'EXIT'
    ),
(
        2271,
        30,
        '2025-04-16',
        '08:09:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 08:09:06',
        'ENTRANCE'
    ),
(
        2272,
        28,
        '2025-04-16',
        '08:39:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 08:39:13',
        'ENTRANCE'
    ),
(
        2273,
        38,
        '2025-04-16',
        '08:44:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 08:44:08',
        'ENTRANCE'
    ),
(
        2274,
        34,
        '2025-04-16',
        '08:44:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 08:44:18',
        'ENTRANCE'
    ),
(
        2275,
        27,
        '2025-04-16',
        '08:44:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 08:44:43',
        'ENTRANCE'
    ),
(
        2276,
        29,
        '2025-04-16',
        '09:11:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 09:11:25',
        'ENTRANCE'
    ),
(
        2277,
        33,
        '2025-04-16',
        '11:12:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 11:12:17',
        'ENTRANCE'
    ),
(
        2278,
        40,
        '2025-04-16',
        '11:28:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 11:28:04',
        'ENTRANCE'
    ),
(
        2279,
        41,
        '2025-04-16',
        '16:03:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 16:03:17',
        'ENTRANCE'
    ),
(
        2280,
        30,
        '2025-04-16',
        '18:00:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 18:00:27',
        'EXIT'
    ),
(
        2281,
        29,
        '2025-04-16',
        '18:09:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 18:09:21',
        'EXIT'
    ),
(
        2282,
        28,
        '2025-04-16',
        '18:30:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 18:30:17',
        'EXIT'
    ),
(
        2283,
        27,
        '2025-04-16',
        '18:46:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 18:46:42',
        'EXIT'
    ),
(
        2284,
        38,
        '2025-04-16',
        '18:47:01',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 18:47:01',
        'EXIT'
    ),
(
        2285,
        34,
        '2025-04-16',
        '18:47:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 18:47:18',
        'EXIT'
    ),
(
        2286,
        41,
        '2025-04-16',
        '20:04:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 20:04:21',
        'EXIT'
    ),
(
        2287,
        40,
        '2025-04-16',
        '20:05:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-16 20:05:02',
        'EXIT'
    ),
(
        2288,
        34,
        '2025-04-17',
        '08:13:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-17 08:13:55',
        'ENTRANCE'
    ),
(
        2289,
        27,
        '2025-04-17',
        '08:14:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-17 08:14:11',
        'ENTRANCE'
    ),
(
        2290,
        38,
        '2025-04-17',
        '08:59:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-17 08:59:17',
        'ENTRANCE'
    ),
(
        2291,
        30,
        '2025-04-17',
        '09:00:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-17 09:00:11',
        'ENTRANCE'
    ),
(
        2292,
        29,
        '2025-04-17',
        '09:09:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-17 09:09:57',
        'ENTRANCE'
    ),
(
        2293,
        33,
        '2025-04-17',
        '11:07:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-17 11:07:40',
        'ENTRANCE'
    ),
(
        2294,
        40,
        '2025-04-17',
        '11:14:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-17 11:14:03',
        'ENTRANCE'
    ),
(
        2295,
        41,
        '2025-04-17',
        '15:57:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-17 15:57:12',
        'ENTRANCE'
    ),
(
        2296,
        30,
        '2025-04-17',
        '18:00:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-17 18:00:48',
        'EXIT'
    ),
(
        2297,
        29,
        '2025-04-17',
        '18:04:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-17 18:04:26',
        'EXIT'
    ),
(
        2298,
        38,
        '2025-04-17',
        '18:08:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-17 18:08:33',
        'EXIT'
    ),
(
        2299,
        33,
        '2025-04-17',
        '19:03:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-17 19:03:21',
        'EXIT'
    ),
(
        2300,
        41,
        '2025-04-17',
        '19:56:21',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-17 19:56:21',
        'EXIT'
    ),
(
        2301,
        40,
        '2025-04-17',
        '19:59:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-17 19:59:16',
        'EXIT'
    ),
(
        2302,
        27,
        '2025-04-18',
        '08:18:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-18 08:18:16',
        'ENTRANCE'
    ),
(
        2303,
        34,
        '2025-04-18',
        '08:18:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-18 08:18:32',
        'ENTRANCE'
    ),
(
        2304,
        30,
        '2025-04-18',
        '09:01:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-18 09:01:53',
        'ENTRANCE'
    ),
(
        2305,
        38,
        '2025-04-18',
        '09:03:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-18 09:03:39',
        'ENTRANCE'
    ),
(
        2306,
        29,
        '2025-04-18',
        '09:11:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-18 09:11:13',
        'ENTRANCE'
    ),
(
        2307,
        40,
        '2025-04-18',
        '11:11:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-18 11:11:13',
        'ENTRANCE'
    ),
(
        2308,
        41,
        '2025-04-18',
        '11:11:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-18 11:11:32',
        'ENTRANCE'
    ),
(
        2309,
        33,
        '2025-04-18',
        '11:15:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-18 11:15:51',
        'ENTRANCE'
    ),
(
        2310,
        29,
        '2025-04-18',
        '14:55:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-18 14:55:27',
        'EXIT'
    ),
(
        2311,
        41,
        '2025-04-18',
        '15:01:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-18 15:01:44',
        'EXIT'
    ),
(
        2312,
        40,
        '2025-04-18',
        '15:02:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-18 15:02:04',
        'EXIT'
    ),
(
        2313,
        38,
        '2025-04-18',
        '15:10:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-18 15:10:48',
        'EXIT'
    ),
(
        2314,
        30,
        '2025-04-18',
        '15:12:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-18 15:12:34',
        'EXIT'
    ),
(
        2315,
        30,
        '2025-04-20',
        '09:11:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-20 09:11:32',
        'ENTRANCE'
    ),
(
        2316,
        29,
        '2025-04-20',
        '09:26:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-20 09:26:24',
        'ENTRANCE'
    ),
(
        2317,
        33,
        '2025-04-20',
        '10:46:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-20 10:46:20',
        'ENTRANCE'
    ),
(
        2318,
        40,
        '2025-04-20',
        '11:14:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-20 11:14:45',
        'ENTRANCE'
    ),
(
        2319,
        41,
        '2025-04-20',
        '16:01:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-20 16:01:02',
        'ENTRANCE'
    ),
(
        2320,
        29,
        '2025-04-20',
        '18:00:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-20 18:00:59',
        'EXIT'
    ),
(
        2321,
        30,
        '2025-04-20',
        '18:28:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-20 18:28:46',
        'EXIT'
    ),
(
        2322,
        34,
        '2025-04-21',
        '08:33:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-21 08:33:26',
        'ENTRANCE'
    ),
(
        2323,
        27,
        '2025-04-21',
        '08:33:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-21 08:33:37',
        'ENTRANCE'
    ),
(
        2324,
        28,
        '2025-04-21',
        '08:57:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-21 08:57:32',
        'ENTRANCE'
    ),
(
        2325,
        30,
        '2025-04-21',
        '09:10:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-21 09:10:36',
        'ENTRANCE'
    ),
(
        2326,
        29,
        '2025-04-21',
        '09:14:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-21 09:14:05',
        'ENTRANCE'
    ),
(
        2327,
        38,
        '2025-04-21',
        '09:17:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-21 09:17:29',
        'ENTRANCE'
    ),
(
        2328,
        33,
        '2025-04-21',
        '11:20:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-21 11:20:55',
        'ENTRANCE'
    ),
(
        2329,
        40,
        '2025-04-21',
        '11:50:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-21 11:50:34',
        'ENTRANCE'
    ),
(
        2330,
        41,
        '2025-04-21',
        '16:31:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-21 16:31:24',
        'ENTRANCE'
    ),
(
        2331,
        29,
        '2025-04-21',
        '17:52:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-21 17:52:28',
        'EXIT'
    ),
(
        2332,
        30,
        '2025-04-21',
        '18:09:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-21 18:09:07',
        'EXIT'
    ),
(
        2333,
        38,
        '2025-04-21',
        '18:17:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-21 18:17:04',
        'EXIT'
    ),
(
        2334,
        28,
        '2025-04-21',
        '18:31:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-21 18:31:06',
        'EXIT'
    ),
(
        2335,
        41,
        '2025-04-21',
        '19:55:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-21 19:55:28',
        'EXIT'
    ),
(
        2336,
        40,
        '2025-04-21',
        '19:59:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-21 19:59:31',
        'EXIT'
    ),
(
        2337,
        28,
        '2025-04-22',
        '08:43:30',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-22 08:43:30',
        'ENTRANCE'
    ),
(
        2338,
        34,
        '2025-04-22',
        '08:43:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-22 08:43:51',
        'ENTRANCE'
    ),
(
        2339,
        38,
        '2025-04-22',
        '08:44:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-22 08:44:03',
        'ENTRANCE'
    ),
(
        2340,
        27,
        '2025-04-22',
        '08:44:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-22 08:44:15',
        'ENTRANCE'
    ),
(
        2341,
        29,
        '2025-04-22',
        '09:13:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-22 09:13:42',
        'ENTRANCE'
    ),
(
        2342,
        40,
        '2025-04-22',
        '11:18:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-22 11:18:40',
        'ENTRANCE'
    ),
(
        2343,
        33,
        '2025-04-22',
        '11:22:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-22 11:22:15',
        'ENTRANCE'
    ),
(
        2344,
        29,
        '2025-04-22',
        '17:50:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-22 17:50:37',
        'EXIT'
    ),
(
        2345,
        30,
        '2025-04-22',
        '18:19:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-22 18:19:32',
        'EXIT'
    ),
(
        2346,
        28,
        '2025-04-22',
        '18:24:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-22 18:24:12',
        'EXIT'
    ),
(
        2347,
        38,
        '2025-04-22',
        '18:27:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-22 18:27:36',
        'EXIT'
    ),
(
        2348,
        33,
        '2025-04-22',
        '18:58:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-22 18:58:03',
        'EXIT'
    ),
(
        2349,
        40,
        '2025-04-22',
        '20:07:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-22 20:07:47',
        'EXIT'
    ),
(
        2350,
        34,
        '2025-04-23',
        '08:34:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 08:34:06',
        'ENTRANCE'
    ),
(
        2351,
        27,
        '2025-04-23',
        '08:34:22',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 08:34:22',
        'ENTRANCE'
    ),
(
        2352,
        38,
        '2025-04-23',
        '08:58:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 08:58:02',
        'ENTRANCE'
    ),
(
        2353,
        28,
        '2025-04-23',
        '09:06:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 09:06:12',
        'ENTRANCE'
    ),
(
        2354,
        30,
        '2025-04-23',
        '09:09:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 09:09:13',
        'ENTRANCE'
    ),
(
        2355,
        29,
        '2025-04-23',
        '09:16:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 09:16:40',
        'ENTRANCE'
    ),
(
        2356,
        33,
        '2025-04-23',
        '11:14:50',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 11:14:50',
        'ENTRANCE'
    ),
(
        2357,
        40,
        '2025-04-23',
        '11:22:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 11:22:49',
        'ENTRANCE'
    ),
(
        2358,
        41,
        '2025-04-23',
        '16:54:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 16:54:57',
        'ENTRANCE'
    ),
(
        2359,
        28,
        '2025-04-23',
        '17:15:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 17:15:00',
        'EXIT'
    ),
(
        2360,
        29,
        '2025-04-23',
        '17:51:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 17:51:48',
        'EXIT'
    ),
(
        2361,
        30,
        '2025-04-23',
        '18:00:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 18:00:26',
        'EXIT'
    ),
(
        2362,
        38,
        '2025-04-23',
        '18:01:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 18:01:13',
        'EXIT'
    ),
(
        2363,
        33,
        '2025-04-23',
        '19:00:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 19:00:49',
        'EXIT'
    ),
(
        2364,
        40,
        '2025-04-23',
        '19:56:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 19:56:44',
        'EXIT'
    ),
(
        2365,
        41,
        '2025-04-23',
        '19:58:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 19:58:59',
        'EXIT'
    ),
(
        2366,
        30,
        '2025-04-24',
        '07:51:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-24 07:51:55',
        'ENTRANCE'
    ),
(
        2367,
        34,
        '2025-04-24',
        '08:21:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-24 08:21:33',
        'ENTRANCE'
    ),
(
        2368,
        27,
        '2025-04-24',
        '08:21:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-24 08:21:47',
        'ENTRANCE'
    ),
(
        2369,
        28,
        '2025-04-24',
        '08:57:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-24 08:57:46',
        'ENTRANCE'
    ),
(
        2370,
        38,
        '2025-04-24',
        '09:12:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-24 09:12:34',
        'ENTRANCE'
    ),
(
        2371,
        29,
        '2025-04-24',
        '09:11:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-24 09:11:59',
        'ENTRANCE'
    ),
(
        2372,
        41,
        '2025-04-24',
        '11:00:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-24 11:00:31',
        'ENTRANCE'
    ),
(
        2373,
        33,
        '2025-04-24',
        '11:28:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-24 11:28:13',
        'ENTRANCE'
    ),
(
        2374,
        29,
        '2025-04-24',
        '17:54:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-24 17:54:05',
        'EXIT'
    ),
(
        2375,
        38,
        '2025-04-24',
        '17:58:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-24 17:58:12',
        'EXIT'
    ),
(
        2376,
        28,
        '2025-04-24',
        '17:59:31',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-24 17:59:31',
        'EXIT'
    ),
(
        2377,
        30,
        '2025-04-24',
        '18:01:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-24 18:01:52',
        'EXIT'
    ),
(
        2378,
        33,
        '2025-04-24',
        '19:10:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-24 19:10:32',
        'EXIT'
    ),
(
        2379,
        27,
        '2025-04-25',
        '08:14:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-25 08:14:04',
        'ENTRANCE'
    ),
(
        2380,
        34,
        '2025-04-25',
        '08:38:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-25 08:38:20',
        'ENTRANCE'
    ),
(
        2381,
        28,
        '2025-04-25',
        '08:53:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-25 08:53:27',
        'ENTRANCE'
    ),
(
        2382,
        30,
        '2025-04-25',
        '09:07:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-25 09:07:18',
        'ENTRANCE'
    ),
(
        2383,
        38,
        '2025-04-25',
        '09:18:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-25 09:18:25',
        'ENTRANCE'
    ),
(
        2384,
        33,
        '2025-04-25',
        '11:25:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-25 11:25:52',
        'ENTRANCE'
    ),
(
        2385,
        40,
        '2025-04-25',
        '11:35:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-25 11:35:28',
        'ENTRANCE'
    ),
(
        2386,
        41,
        '2025-04-25',
        '16:20:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-25 16:20:44',
        'ENTRANCE'
    ),
(
        2387,
        30,
        '2025-04-25',
        '18:02:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-25 18:02:20',
        'EXIT'
    ),
(
        2388,
        38,
        '2025-04-25',
        '18:06:56',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-25 18:06:56',
        'EXIT'
    ),
(
        2389,
        28,
        '2025-04-25',
        '18:09:15',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-25 18:09:15',
        'EXIT'
    ),
(
        2390,
        33,
        '2025-04-25',
        '19:17:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-25 19:17:58',
        'EXIT'
    ),
(
        2391,
        41,
        '2025-04-25',
        '20:00:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-25 20:00:13',
        'EXIT'
    ),
(
        2392,
        40,
        '2025-04-25',
        '20:00:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-25 20:00:53',
        'EXIT'
    ),
(
        2393,
        27,
        '2025-04-26',
        '08:03:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-26 08:03:42',
        'ENTRANCE'
    ),
(
        2394,
        28,
        '2025-04-26',
        '08:52:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-26 08:52:49',
        'ENTRANCE'
    ),
(
        2395,
        38,
        '2025-04-26',
        '09:07:19',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-26 09:07:19',
        'ENTRANCE'
    ),
(
        2396,
        30,
        '2025-04-26',
        '09:07:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-26 09:07:25',
        'ENTRANCE'
    ),
(
        2397,
        29,
        '2025-04-26',
        '09:11:46',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-26 09:01:46',
        'ENTRANCE'
    ),
(
        2398,
        33,
        '2025-04-26',
        '11:27:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-26 11:27:08',
        'ENTRANCE'
    ),
(
        2399,
        38,
        '2025-04-26',
        '15:00:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-26 15:00:32',
        'EXIT'
    ),
(
        2400,
        28,
        '2025-04-26',
        '15:04:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-26 15:04:35',
        'EXIT'
    ),
(
        2401,
        40,
        '2025-04-26',
        '16:12:05',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-26 16:12:05',
        'ENTRANCE'
    ),
(
        2402,
        29,
        '2025-04-26',
        '17:50:26',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-26 17:50:26',
        'EXIT'
    ),
(
        2403,
        30,
        '2025-04-26',
        '18:03:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-26 18:03:13',
        'EXIT'
    ),
(
        2404,
        33,
        '2025-04-26',
        '19:33:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-26 19:33:29',
        'EXIT'
    ),
(
        2405,
        40,
        '2025-04-26',
        '19:58:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-26 19:58:12',
        'EXIT'
    ),
(
        2406,
        29,
        '2025-04-27',
        '09:13:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-27 09:13:39',
        'ENTRANCE'
    ),
(
        2407,
        40,
        '2025-04-27',
        '11:27:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-27 11:27:48',
        'ENTRANCE'
    ),
(
        2408,
        33,
        '2025-04-27',
        '11:40:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-27 11:40:37',
        'ENTRANCE'
    ),
(
        2409,
        29,
        '2025-04-27',
        '17:48:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-27 17:48:39',
        'EXIT'
    ),
(
        2410,
        33,
        '2025-04-27',
        '19:22:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-27 19:22:00',
        'EXIT'
    ),
(
        2411,
        40,
        '2025-04-27',
        '20:02:44',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-27 20:02:44',
        'EXIT'
    ),
(
        2412,
        34,
        '2025-04-28',
        '08:34:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 08:34:25',
        'ENTRANCE'
    ),
(
        2413,
        27,
        '2025-04-28',
        '08:34:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 08:34:37',
        'ENTRANCE'
    ),
(
        2414,
        28,
        '2025-04-28',
        '08:59:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 08:59:36',
        'ENTRANCE'
    ),
(
        2415,
        30,
        '2025-04-28',
        '09:03:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 09:03:28',
        'ENTRANCE'
    ),
(
        2416,
        38,
        '2025-04-28',
        '09:05:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 09:05:23',
        'ENTRANCE'
    ),
(
        2417,
        29,
        '2025-04-28',
        '09:12:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 09:12:53',
        'ENTRANCE'
    ),
(
        2418,
        40,
        '2025-04-28',
        '11:21:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 11:21:03',
        'ENTRANCE'
    ),
(
        2419,
        32,
        '2025-04-28',
        '11:36:49',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 11:36:49',
        'ENTRANCE'
    ),
(
        2420,
        29,
        '2025-04-28',
        '17:55:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 17:55:39',
        'EXIT'
    ),
(
        2421,
        29,
        '2025-04-28',
        '17:55:39',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 17:55:39',
        'EXIT'
    ),
(
        2422,
        34,
        '2025-04-28',
        '18:06:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 18:06:47',
        'EXIT'
    ),
(
        2423,
        27,
        '2025-04-28',
        '18:06:57',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 18:06:57',
        'EXIT'
    ),
(
        2424,
        38,
        '2025-04-28',
        '18:13:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 18:13:55',
        'EXIT'
    ),
(
        2425,
        28,
        '2025-04-28',
        '18:22:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 18:22:28',
        'EXIT'
    ),
(
        2426,
        32,
        '2025-04-28',
        '19:00:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 19:00:02',
        'EXIT'
    ),
(
        2427,
        40,
        '2025-04-28',
        '19:38:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 19:38:00',
        'EXIT'
    ),
(
        2428,
        27,
        '2025-04-29',
        '08:10:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-29 08:10:48',
        'ENTRANCE'
    ),
(
        2429,
        34,
        '2025-04-29',
        '08:21:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-29 08:21:20',
        'ENTRANCE'
    ),
(
        2430,
        30,
        '2025-04-29',
        '09:06:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-29 09:06:13',
        'ENTRANCE'
    ),
(
        2431,
        28,
        '2025-04-29',
        '09:08:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-29 09:08:40',
        'ENTRANCE'
    ),
(
        2432,
        29,
        '2025-04-29',
        '09:17:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-29 09:17:09',
        'ENTRANCE'
    ),
(
        2433,
        38,
        '2025-04-29',
        '09:17:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-29 09:17:47',
        'ENTRANCE'
    ),
(
        2434,
        40,
        '2025-04-29',
        '11:21:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-29 11:21:12',
        'ENTRANCE'
    ),
(
        2435,
        32,
        '2025-04-29',
        '11:23:09',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-29 11:23:09',
        'ENTRANCE'
    ),
(
        2436,
        27,
        '2025-04-17',
        '18:12:23',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-17 18:12:23',
        'EXIT'
    ),
(
        2437,
        27,
        '2025-04-18',
        '18:25:47',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-18 18:25:47',
        'EXIT'
    ),
(
        2438,
        27,
        '2025-04-19',
        '09:01:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-19 09:01:12',
        'ENTRANCE'
    ),
(
        2439,
        27,
        '2025-04-21',
        '18:19:32',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-21 18:19:32',
        'EXIT'
    ),
(
        2440,
        27,
        '2025-04-23',
        '18:27:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-23 18:27:41',
        'EXIT'
    ),
(
        2441,
        27,
        '2025-04-24',
        '18:14:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-24 18:14:06',
        'EXIT'
    ),
(
        2442,
        27,
        '2025-04-26',
        '18:09:45',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-26 18:09:45',
        'EXIT'
    ),
(
        2443,
        27,
        '2025-04-28',
        '18:16:37',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-28 18:16:37',
        'EXIT'
    ),
(
        2444,
        27,
        '2025-04-29',
        '18:23:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-29 18:23:11',
        'EXIT'
    ),
(
        2445,
        29,
        '2025-04-29',
        '17:51:04',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-29 17:51:04',
        'EXIT'
    ),
(
        2446,
        34,
        '2025-04-29',
        '17:51:28',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-29 17:51:28',
        'EXIT'
    ),
(
        2447,
        38,
        '2025-04-29',
        '17:58:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-29 17:58:52',
        'EXIT'
    ),
(
        2448,
        28,
        '2025-04-29',
        '17:59:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-29 17:59:18',
        'EXIT'
    ),
(
        2449,
        30,
        '2025-04-29',
        '18:01:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-29 18:01:42',
        'EXIT'
    ),
(
        2450,
        32,
        '2025-04-29',
        '19:03:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-29 19:03:00',
        'EXIT'
    ),
(
        2451,
        40,
        '2025-04-29',
        '20:00:17',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-29 20:00:17',
        'EXIT'
    ),
(
        2452,
        27,
        '2025-04-30',
        '08:22:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-30 08:22:58',
        'ENTRANCE'
    ),
(
        2453,
        34,
        '2025-04-30',
        '08:39:27',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-30 08:39:27',
        'ENTRANCE'
    ),
(
        2454,
        38,
        '2025-04-30',
        '09:09:00',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-30 09:09:00',
        'ENTRANCE'
    ),
(
        2455,
        30,
        '2025-04-30',
        '09:09:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-30 09:09:13',
        'ENTRANCE'
    ),
(
        2456,
        29,
        '2025-04-30',
        '09:06:48',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-30 09:06:48',
        'ENTRANCE'
    ),
(
        2457,
        32,
        '2025-04-30',
        '11:13:07',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-30 11:13:07',
        'ENTRANCE'
    ),
(
        2458,
        29,
        '2025-04-30',
        '17:54:36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-30 17:54:36',
        'EXIT'
    ),
(
        2459,
        30,
        '2025-04-30',
        '18:00:40',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-30 18:00:40',
        'EXIT'
    ),
(
        2460,
        38,
        '2025-04-30',
        '18:42:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-04-30 18:42:13',
        'EXIT'
    ),
(
        2461,
        30,
        '2025-05-01',
        '09:14:02',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-01 09:14:02',
        'ENTRANCE'
    ),
(
        2462,
        29,
        '2025-05-01',
        '09:18:35',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-01 09:18:35',
        'ENTRANCE'
    ),
(
        2463,
        32,
        '2025-05-01',
        '11:20:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-01 11:20:42',
        'ENTRANCE'
    ),
(
        2464,
        29,
        '2025-05-01',
        '18:00:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-01 18:00:34',
        'EXIT'
    ),
(
        2465,
        30,
        '2025-05-01',
        '18:01:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-01 18:01:41',
        'EXIT'
    ),
(
        2466,
        32,
        '2025-05-01',
        '18:59:08',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-01 18:59:08',
        'EXIT'
    ),
(
        2467,
        27,
        '2025-05-02',
        '08:36:34',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-02 08:36:34',
        'ENTRANCE'
    ),
(
        2468,
        28,
        '2025-05-02',
        '08:50:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-02 08:50:03',
        'ENTRANCE'
    ),
(
        2469,
        38,
        '2025-05-02',
        '09:14:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-02 09:14:55',
        'ENTRANCE'
    ),
(
        2470,
        32,
        '2025-05-02',
        '11:22:14',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-02 11:22:14',
        'ENTRANCE'
    ),
(
        2471,
        40,
        '2025-05-02',
        '11:33:16',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-02 11:33:16',
        'ENTRANCE'
    ),
(
        2472,
        28,
        '2025-05-02',
        '18:09:53',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-02 18:09:53',
        'EXIT'
    ),
(
        2473,
        38,
        '2025-05-02',
        '18:10:20',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-02 18:10:20',
        'EXIT'
    ),
(
        2474,
        32,
        '2025-05-02',
        '18:59:42',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-02 18:59:42',
        'EXIT'
    ),
(
        2475,
        40,
        '2025-05-02',
        '19:57:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-02 19:57:12',
        'EXIT'
    ),
(
        2476,
        27,
        '2025-05-03',
        '08:36:25',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-03 08:36:25',
        'ENTRANCE'
    ),
(
        2477,
        38,
        '2025-05-03',
        '09:17:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-03 09:17:52',
        'ENTRANCE'
    ),
(
        2478,
        28,
        '2025-05-03',
        '09:18:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-03 09:18:06',
        'ENTRANCE'
    ),
(
        2479,
        29,
        '2025-05-03',
        '09:14:03',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-03 09:14:03',
        'ENTRANCE'
    ),
(
        2480,
        40,
        '2025-05-03',
        '11:19:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-03 11:19:58',
        'ENTRANCE'
    ),
(
        2481,
        32,
        '2025-05-03',
        '11:23:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-03 11:23:10',
        'ENTRANCE'
    ),
(
        2482,
        28,
        '2025-05-03',
        '14:51:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-03 14:51:06',
        'EXIT'
    ),
(
        2483,
        38,
        '2025-05-03',
        '14:55:11',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-03 14:55:11',
        'EXIT'
    ),
(
        2484,
        29,
        '2025-05-03',
        '17:53:10',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-03 17:53:10',
        'EXIT'
    ),
(
        2485,
        32,
        '2025-05-03',
        '19:02:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-03 19:02:43',
        'EXIT'
    ),
(
        2486,
        40,
        '2025-05-03',
        '20:01:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-03 20:01:43',
        'EXIT'
    ),
(
        2487,
        29,
        '2025-05-04',
        '09:12:24',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-04 09:12:24',
        'ENTRANCE'
    ),
(
        2488,
        40,
        '2025-05-04',
        '11:23:33',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-04 11:23:33',
        'ENTRANCE'
    ),
(
        2489,
        33,
        '2025-05-04',
        '11:35:18',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-04 11:35:18',
        'ENTRANCE'
    ),
(
        2490,
        29,
        '2025-05-04',
        '17:54:13',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-04 17:54:13',
        'EXIT'
    ),
(
        2491,
        40,
        '2025-05-04',
        '19:50:55',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-04 19:50:55',
        'EXIT'
    ),
(
        2492,
        27,
        '2025-05-05',
        '08:28:06',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-05 08:28:06',
        'ENTRANCE'
    ),
(
        2493,
        34,
        '2025-05-05',
        '08:29:29',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-05 08:29:29',
        'ENTRANCE'
    ),
(
        2494,
        38,
        '2025-05-05',
        '09:15:43',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-05 09:15:43',
        'ENTRANCE'
    ),
(
        2495,
        29,
        '2025-05-05',
        '09:23:59',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-05 09:23:59',
        'ENTRANCE'
    ),
(
        2496,
        28,
        '2025-05-05',
        '09:21:41',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-05 09:21:41',
        'ENTRANCE'
    ),
(
        2497,
        36,
        '2025-05-05',
        '09:26:12',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-05 09:26:12',
        'ENTRANCE'
    ),
(
        2498,
        30,
        '2025-05-05',
        '09:50:52',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-05 09:50:52',
        'ENTRANCE'
    ),
(
        2499,
        33,
        '2025-05-05',
        '11:12:51',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-05 11:12:51',
        'ENTRANCE'
    ),
(
        2500,
        40,
        '2025-05-05',
        '11:31:58',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWeb',
        '2025-05-05 11:31:58',
        'ENTRANCE'
    );

;

INSERT INTO
    `brand`
VALUES
    (1, 'BODYS'),
(2, 'CARPO'),
(3, 'ELIOT'),
(4, 'NACIO'),
(5, 'ADX'),
(6, 'NIKE'),
(7, 'PROSU'),
(8, 'UNSPO'),
(9, 'REDCO'),
(10, 'WILSO'),
(11, 'ADDIC'),
(12, 'PLEDC'),
(13, 'IMPOR'),
(14, '4ALMT'),
(15, 'COOLG'),
(16, 'MAYOR'),
(17, 'ADNBI'),
(18, 'PROMO'),
(19, 'LIQUI'),
(20, 'FFERR'),
(21, 'LANDE'),
(22, 'EURO'),
(23, 'NVE'),
(24, 'XTLAB'),
(25, 'PFIZE'),
(26, 'ROTTE'),
(27, 'SMART'),
(28, 'BIOPH'),
(29, 'GERMA'),
(30, 'MESOF'),
(31, 'MESO1'),
(32, 'OUTLE'),
(33, 'MT'),
(34, '4DIME'),
(35, '43SUP'),
(36, 'ACTIO'),
(37, 'ACID'),
(38, 'ADVAN'),
(39, 'ALKAV'),
(40, 'ALLMA'),
(41, 'ALPHA'),
(42, 'ANSPE'),
(43, 'ARMAD'),
(44, 'ANS'),
(45, 'BAG B'),
(46, 'BABA'),
(47, 'BATTL'),
(48, 'BEAST'),
(49, 'BETAN'),
(50, 'BUNKE'),
(52, 'BHP'),
(53, 'BIRMA'),
(54, 'BLUE'),
(55, 'BPI'),
(56, 'BSN'),
(57, 'CELLL'),
(58, 'CELLU'),
(59, 'CHUKY'),
(60, 'CICLO'),
(61, 'CLOMA'),
(62, 'COBRA'),
(63, 'CUTLE'),
(64, 'CYTOS'),
(65, 'DYNAS'),
(66, 'DRAGO'),
(67, 'DYMAT'),
(68, 'EN'),
(69, 'EUPHO'),
(70, 'EVOLU'),
(71, 'EVOGE'),
(72, 'FESQ'),
(73, 'FREGR'),
(74, 'FL24'),
(75, 'FINAF'),
(76, 'FITMI'),
(77, 'FREAK'),
(78, 'GASPA'),
(79, 'GAT'),
(80, 'GHOST'),
(81, 'GLAMO'),
(82, 'GLAXS'),
(83, 'GORIL'),
(84, 'GRENA'),
(85, 'GRUPO'),
(86, 'HALLO'),
(87, 'HYSTE'),
(88, 'HYDRO'),
(89, 'HI-TE'),
(90, 'HURAC'),
(91, 'INNER'),
(92, 'INNOV'),
(93, 'INSAN'),
(94, 'KILLE'),
(95, 'KINGN'),
(96, 'LABRA'),
(97, 'LEVEL'),
(98, 'LIMIT'),
(99, 'L&L'),
(100, 'LUXOR'),
(101, 'MAN'),
(102, 'MADNE'),
(103, 'MACHE'),
(104, 'MDN'),
(105, 'MAXLE'),
(106, 'METAN'),
(107, 'MET-R'),
(108, 'MHP'),
(109, 'MIDWA'),
(110, 'MP'),
(111, 'MPB'),
(112, 'MM'),
(113, 'M FIT'),
(114, 'MUSCL'),
(115, 'MUNCH'),
(116, 'MUSCB'),
(117, 'MUTAN'),
(118, 'MYOGE'),
(119, 'NATUG'),
(120, 'NATUR'),
(121, 'NST'),
(122, 'NUCLE'),
(123, 'NUBRE'),
(124, 'NUTRE'),
(125, 'NUCNU'),
(126, 'OBVI'),
(127, 'ON'),
(128, 'PHADV'),
(129, 'PHARM'),
(130, 'PERFE'),
(131, 'PRIMA'),
(132, 'PERFO'),
(133, 'POWER'),
(134, 'PRIME'),
(135, 'PTECH'),
(136, 'PRIOR'),
(137, 'PROW'),
(138, 'PSY'),
(139, 'PURO'),
(140, 'PURUS'),
(141, 'RAW'),
(142, 'REDGO'),
(143, 'RED L'),
(144, 'RONNI'),
(145, 'RSP'),
(146, 'RYSE'),
(147, 'SAN'),
(148, 'SCULP'),
(149, 'SD NU'),
(150, 'SUBZE'),
(151, 'SIXPA'),
(152, 'SHEFI'),
(153, 'SLABS'),
(154, 'STEEL'),
(155, 'SPART'),
(156, 'SCIV'),
(157, 'TOND'),
(158, 'TORNA'),
(159, 'SWAN'),
(160, 'SYNTR'),
(161, 'TERRO'),
(162, 'TITAN'),
(163, 'ULTIM'),
(164, 'UNIVE'),
(165, 'UN'),
(166, 'USN'),
(167, 'USP L'),
(168, 'VEGNU'),
(169, 'VICTO'),
(170, 'VPX'),
(171, 'VITAS'),
(172, 'WHP'),
(173, 'XENAD'),
(174, 'XP SP'),
(175, 'YPENZ'),
(176, 'ZOMBI'),
(177, 'ZOOMA'),
(178, 'BATID'),
(179, 'GENERIC'),
(180, 'GENP'),
(181, 'GALLO'),
(182, 'NEXA'),
(183, 'MAD'),
(184, 'MEXA'),
(185, 'IFA'),
(186, 'MAMMOTH'),
(187, 'A&S'),
(188, 'RICHP'),
(189, 'PANDA');




INSERT INTO `category` VALUES (1,'Preentreno'),(2,'Proteina'),(3,'Multivitaminico'),(4,'Precursores de testosterona'),(5,'Aminoacidos'),(6,'Quemadores'),(7,'Accesorios'),(8,'Suplementos'),(9,'Shakers'),(10,'Snacks'),(11,'Farmaco'),(12,'Estimulantes'),(13,'Mesoterapia'),(14,'Creatina'),(15,'Promos'),(16,'Varios');

INSERT INTO `clients` VALUES (1,'Clemente Armando Zarraga Cruz',1,'5533668907',1,NULL),(3,'Oscar Hazael Garcia',1,'5533668908',1,NULL),(4,'Martin Camacho',7,'123456789',1,10),(5,'Samuel rocha',3,'123654789',3,10),(6,'DAVID ZALDIVAR SOLACHE',1,'SN',1,25),(7,'*MARIANA GOMEZ',1,'SN',1,25),(8,'ALAN GARCIA INSTRUCTOR CESAR',1,'SN',3,25),(9,'ALBERTO',1,'SN',1,25),(10,'ALEJANDRO HERNANDEZ',1,'SN',1,25),(11,'Alfredo Smart',1,'SN',1,25),(12,'ALVARO GARCIA CORONA',1,'SN',1,25),(13,'ANGEL BALLESTEROS',1,'SN',1,25),(14,'ANGEL RIVERA',1,'SN',1,25),(15,'ANTONIO DIAZ',1,'SN',1,25),(16,'ANTONIO L',1,'SN',1,25),(17,'ANTONIO RAMIREZ',1,'SN',1,25),(18,'ANTONIO RUED',1,'SN',1,25),(19,'ANTONIO SANTIAGO',1,'SN',1,25),(20,'ARTURO ROMERO',1,'SN',1,25),(21,'ARTURO RONQUILLO',1,'SN',1,25),(22,'CALETT MEDINA',1,'SN',4,25),(23,'CARLOS ANDRES GARCIA MAR',1,'SN',1,25),(24,'CARLOS PAUL CASTILLO',1,'SN',1,25),(25,'CESAR ESCARRGA',1,'SN',1,25),(26,'CESAR HUMBERTO SUAREZ',1,'SN',1,25),(27,'CRISTIAN ARENAS',1,'SN',1,25),(28,'CRISTIAN RESENDIZ',1,'SN',1,25),(29,'D',1,'SN',1,25),(30,'DANIEL RAMIREZ',1,'SN',1,25),(31,'DAVID GONZALEZ',1,'SN',1,25),(32,'DAVID MENDOZA',1,'SN',1,25),(33,'DIANA CERVANTES  LOPEZ',1,'SN',1,25),(34,'diego hernandez',1,'SN',1,25),(35,'DIEGO IVAN CARDENAS',1,'SN',1,25),(36,'Dilan Mendoza',1,'SN',1,25),(37,'duplicado',1,'SN',1,25),(38,'EDGAR DANIEL',1,'SN',1,25),(39,'edilbverto',1,'SN',1,25),(40,'EDUARDO AGUILERA',1,'SN',1,25),(41,'EDUARDO LUNA',1,'SN',1,25),(42,'EMILIANO MONROY',1,'SN',1,25),(43,'EMILIO VA',1,'SN',1,25),(44,'emmanuel camacho 01',1,'SN',1,25),(45,'enrique gordillo',1,'SN',4,25),(46,'ENRIQUE REYES',1,'SN',1,25),(47,'ERIKA VALERIA TORRES CASTRO',1,'SN',1,25),(48,'FERNANDO LUNA',1,'SN',4,25),(49,'FERNANDO MANDUJANO',1,'SN',1,25),(50,'FRANCHISC',1,'SN',1,25),(51,'GABRIEL ALVAREZ ESQUIVEL',1,'SN',1,25),(52,'GABRIEL FLORES',1,'SN',1,25),(53,'GIOVANY ARRAZOLA',1,'SN',1,25),(54,'GUADALUPE RIVERA',1,'SN',4,25),(55,'ISAAC MARQUEZ',1,'SN',3,25),(56,'ISMAEL CARMONA',1,'SN',1,25),(57,'ISRAEL REYES',1,'SN',1,25),(58,'ISRAEL VEGA',1,'SN',1,25),(59,'JESUS GARCIA',1,'SN',1,25),(60,'JESUS GUTIERREZ',1,'SN',1,25),(61,'JOEL FUENTES',1,'SN',4,25),(62,'jonathan sergio ruiz mercado',1,'SN',1,25),(63,'JORGE ALBERTO SANCHEZ',1,'SN',1,25),(64,'JOSE ANGEL BERNAL',1,'SN',1,25),(65,'jose armando carrilo rico',1,'SN',1,25),(66,'JOSE ELIAS MORENO QUINTERO',1,'SN',1,25),(67,'JOSE LUIS MEDINA',1,'SN',1,25),(68,'JOSUE RODRIGUEZ',1,'SN',1,25),(69,'juan carlos escalone',1,'SN',1,25),(70,'JUAN CARLOS GYM QUIROZ',1,'SN',1,25),(71,'JULIO CESAR DURAN',1,'SN',1,25),(72,'LAURA LOPEZ 01',1,'SN',1,25),(73,'LEONARDO AGUAYO MARTINEZ 01',1,'SN',1,25),(74,'LEONARDO DAVID MENDEZ',1,'SN',1,25),(75,'LETY RODRIGUEZ',1,'SN',1,25),(76,'LIZBETH VARGAS TORRES',1,'SN',4,25),(77,'LUIS ALONSO ROMERO',1,'SN',1,25),(78,'LUIS ARTURO MARTINEZ',1,'SN',1,25),(79,'Luis Mejía',1,'SN',3,25),(80,'LUIS OMAR RANGEL',1,'SN',1,25),(81,'MARCO ANTONIO GOMEZ ROMERO',1,'SN',1,25),(82,'MARCO ANTONIO NAMBO RAMIREZ',1,'SN',1,25),(83,'MARCO CABRERA',1,'SN',1,25),(84,'MARCO GOMEZ',1,'SN',1,25),(85,'MARIA DE LOURDES RAMOS',1,'SN',1,25),(86,'MARIA GUADALUPE',1,'SN',1,25),(87,'MARIANA BARCENA GYM HONDURAS',1,'SN',1,25),(88,'MARIANA GUERRERO',1,'SN',1,25),(89,'MARTIN HERNANDEZ FRAGOSO',1,'SN',1,25),(90,'MICHELLE LEON',1,'SN',1,25),(91,'MIRIAM F',1,'SN',1,25),(92,'MOISES CURVA',1,'SN',4,25),(93,'MOISES FLORES RUBIO',1,'SN',1,25),(94,'MONICA CRUZ',1,'SN',1,25),(95,'NEREA GODINEZ',1,'SN',1,25),(96,'NORMA ESCALONA',1,'SN',1,25),(97,'OMAR RIVERA CASTELLANOS',1,'SN',1,25),(98,'OSCAR ALEJANDRO GALINDO',1,'SN',1,25),(99,'pedro',1,'SN',1,25),(100,'PEDRO MARTINEZ SAENZ',1,'SN',1,25),(101,'PERLA ALEJANDRA SANCHEZ',1,'SN',1,25),(102,'RAMIRO ZAYAGO PEDRAZA',1,'SN',1,25),(103,'RAMSES MARQUEZ',1,'SN',1,25),(104,'RODRIGO',1,'SN',1,25),(105,'RODRIGO ABUNDES',1,'SN',1,25),(106,'RODRIGO SALINAS',1,'SN',1,25),(107,'SANDRA RIOS',1,'SN',1,25),(108,'TAURINO NARES',1,'SN',3,25),(109,'Vicotor Alexis',1,'SN',1,25),(110,'VICTOR ESCOBAR',1,'SN',1,25),(111,'WENDY GUEVARA 1',1,'SN',1,25),(112,'YAIR LOPEZ SUCURSAL PERINORTE',1,'SN',4,25),(113,'YANETH',1,'SN',1,25),(114,'EDDER ASHLEY SANCHEZ',1,'2211909894',1,25),(115,'DAVID CABRERA',1,'2223358800',1,25),(116,'miguel alfonso de gante',1,'2381912942',1,25),(117,'elizabet sanchez',1,'3328341387',1,25),(118,'RODRIGO RIVERA',1,'SN',1,25),(119,'Jose Luis',1,'4272445937',1,25),(120,'DANIEL GONZALEZ CHARNICHAR',1,'4291366402',1,25),(121,'hector miguel rodriguez',1,'4522194528',1,25),(122,'Luis Gonzales',1,'4621101570',1,25),(123,'elikad may',1,'4623217529',1,25),(124,'MARIO BONILLA GUZMAN',2,'5561919250',3,25),(125,'CARLOS RAMIREZ PEREZ',1,'55 68840443',1,25),(126,'RICARDO ROSALES',1,'5510044891',3,25),(127,'JESUS GALLARDO GONZALEZ',1,'5510072461',1,25),(128,'SERGIO BALLESTEROS',1,'5510097771',1,25),(129,'Marco Flores',1,'5510599221',1,25),(130,'Jose Torres',1,'5510696839',1,25),(131,'Alberto Cruz Monroy',1,'5510700823',1,25),(132,'JAVIER SANCHEZ TINOCO',1,'5510790304',1,25),(133,'JOSE ROBERTO URUES',1,'5510859633',4,25),(134,'YANET BAHENA FLORES',1,'55111309874',1,25),(135,'LIDIA LOPEZ AGUILAR',1,'5511293573',1,25),(136,'laura lugo',1,'5511320514',1,25),(137,'BLANCA ESTELA',1,'5511874722',1,25),(138,'FERNANDO SOLANO SAVEDRA',1,'5512189841',1,25),(139,'ENRIQUE MONTERUBIO',1,'5512284637',1,25),(140,'Emilio Gil',1,'5512292489',1,25),(141,'ANTONIO R',1,'5512415377',1,25),(142,'ROGELIO GONZALEZ',1,'5512883784',4,25),(143,'JACOB ZULETA',1,'5512956250',3,25),(144,'GERMAN PEREZ 01',1,'5513115594',1,25),(145,'ARLEEN DOMINGUEZ LOPEZ',1,'5513358935',1,25),(146,'Juan Morales',1,'5513385895',1,25),(147,'LUIS PEREZ',1,'5513408315',1,25),(148,'FERNANDO SANCHEZ',1,'5513429682',1,25),(149,'Ayala Raymundo',1,'5513588486',1,25),(150,'LORENA RUIZ VELAZCO',1,'5513816667',3,25),(151,'DANIEL CAMARGO ORTIZ 01',1,'5513847566',1,25),(152,'ALEJANDRO CANO OROZCO',1,'5513979778',1,25),(153,'Alejandro Hernandez',1,'5514035380',1,25),(154,'BRANDON DAVID HERNANDEZ SAM PABLO',1,'5514633524',3,25),(155,'MILTON CARLOS RODRIGUEZ VAZQUEZ',1,'5514656786',1,25),(156,'MARIBEL MENDEZ',1,'5514814964',1,25),(157,'MIGUEL EDUARDO GALEOTE HERNANDEZ',1,'5514820115',1,25),(158,'RODRIGO CALZADA',1,'5514826517',1,25),(159,'SERGIO SANCHEZ TREJO',1,'5514845492',1,25),(160,'carlos eduardo hernandez',1,'5515048244',1,25),(161,'fernando noriega',1,'5515066865',4,25),(162,'LIUBER DE LEON',1,'5515261664',1,25),(163,'DANIELA MENDEZ',1,'5516222064',1,25),(164,'Angel Coria',1,'5516358308',1,25),(165,'RAFAEL GUTIERREZ VAZQUEZ',1,'5516410773',4,25),(166,'RAFALE GUTIERRES',1,'5516410773',4,25),(167,'Yahir Rodriguez',1,'5516445707',1,25),(168,'GUSTAVO DAVID BAUTISTA HERNANDEZ',1,'5516527569',1,25),(169,'ONEIDA DURAN HERNANDEZ',1,'5516529398',3,25),(170,'Armando Guijosa',1,'5516777322',1,25),(171,'JONATHAN ORDOÑEZ ROMERO',1,'5517632195',4,25),(172,'Lesly Paola Velazquez',1,'5517636340',1,25),(173,'Nayeli Torres',1,'5517897170',1,25),(174,'JAIME GARCIA',1,'5517957629',1,25),(175,'MANUEL OCAMPO ROJAS',1,'5518021577',1,25),(176,'HECTOR HERNANDEZ',1,'5518045707',1,25),(177,'JORGE RODRIGUEZ',1,'5518090790',1,25),(178,'ELIAS BAUTISTA 01',1,'5518119913',1,25),(179,'Eleazar Ramirez',1,'5518123084',1,25),(180,'AGUSTIN PEREZ LUEVANO',1,'5518185014',1,25),(181,'YOLANDA SOTO PEREZ',1,'5518199488',4,25),(182,'MARCO LAFUENTE TOSTADO',1,'5518494718',1,25),(183,'ANTONIO DURANTES PUBLICO',1,'5518725301',1,25),(184,'ANTONIO DURANTES PUBLICO',1,'5518725301',1,25),(185,'ENRIQUE BIVRANO ESCOBAR',1,'5518769376',1,25),(186,'GUSTAVO AGUILAR NIÑO',1,'5519034346',1,25),(187,'Hugo Vargas',1,'5519035184',1,25),(188,'GABRIELA DIAZ HERNANDEZ',1,'5519208997',1,25),(189,'TERESA SALDAÑA CARBAJAL',1,'5519241592',1,25),(190,'GERARO GUERRERO LUI',1,'5519507199',1,25),(191,'RICARDO HERNANDEZ RAMIREZ',1,'5519590424',1,25),(192,'NANCY BRETON',1,'5519593481',1,25),(193,'MAYA MEJIA 01',1,'5519620892',1,25),(194,'Soledad Antonio',1,'5519644728',1,25),(195,'Jonathan Diaz Martinez',1,'5519668996',1,25),(196,'GERARDO MACIAS',1,'5519671998',1,25),(197,'LUIS ANTONIO HERNANDEZ',1,'5519774544',1,25),(198,'David Martinez',1,'5519810785',1,25),(199,'FREDY DANIEL ROCHA MARTINEZ',1,'5519896622',3,25),(200,'Yuma Rosete',1,'5520301539',1,25),(201,'RINO GYM',1,'5520454896',4,25),(202,'MANUEL MOZZOCO',1,'5520923037',4,25),(203,'ALEJANDRA PEREZ',1,'5521079583',1,25),(204,'BEATRIS ADRIANA FRANSISCO',1,'5521313845',1,25),(205,'DANIEL ZABALETA TORRES',1,'5521326437',1,25),(206,'HUGO LOPEZ BARAJAS',1,'5521385230',1,25),(207,'RICARDO CABRERA MARTINEZ',1,'5521650897',1,25),(208,'ELUE DOMINGUEZ',1,'5521684407',1,25),(209,'Viridiana Salinas',1,'5521765550',1,25),(210,'JESUS ADOLFO VALENCIA',1,'5521919699',3,25),(211,'GYM HELL',1,'5521927980',4,25),(212,'KAREN GUADALUPE MALDONADO RIOS',1,'5522163036',1,25),(213,'TOMAS NAVARRO',1,'5522335142',1,25),(214,'Miriam Esteban',1,'5522428904',1,25),(215,'ERICA VELAZQUEZ GOMEZ',1,'5522694605',1,25),(216,'Annete',1,'5522700525',1,25),(217,'HUGO ALEXANDER',1,'5522776463',1,25),(218,'luis herrera',1,'5522990933',1,25),(219,'Laura Cardenas',1,'5523012276',1,25),(220,'LEONARDO GIL VERGARA',1,'5523123483',1,25),(221,'YAEL FERIA',1,'5523299748',1,25),(222,'EMILIANO RIVERA',1,'5523310512',1,25),(223,'IVONE MI TAQUITO VISTAHERMOZA',1,'5523396749',4,25),(224,'CRISTEL MARTINEZ HERNANDEZ',1,'5523403341',1,25),(225,'GUILLERMO ALDERETE CASTAÑEDA',1,'5523407061',1,25),(226,'Gerardo Jimenez',1,'5523421379',1,25),(227,'BERNA MARTINEZ 01',1,'5523656520',1,25),(228,'DAVID MARTINEZ VAZQUEZ',1,'5524094471',1,25),(229,'Cesar Garcia',1,'5524509351',1,25),(230,'MIGUEL MORALES BARRERA',1,'5524961169',3,25),(231,'OSVALDO VAZQUEZ JUAREZ',1,'5525109912',1,25),(232,'Rafael Cervantes',1,'5525199610',1,25),(233,'JOEL ATLANTE SPORT GYM',1,'5525358153',4,25),(234,'Ruben Francisco',1,'5525396963',1,25),(235,'JULIO ONOFRE HERNANDEZ',1,'5527173026',1,25),(236,'JEANNETE FLORES GUTIERREZ',1,'5527410826',1,25),(237,'Francisco Casas',1,'5527587853',1,25),(238,'RAUL RIVERA MARTINEZ',1,'5527740781',1,25),(239,'ELI HUMBERTO',1,'5527975924',1,25),(240,'Josue Morales',1,'5528451580',1,25),(241,'MARIANA ALVARADO',1,'5528562716',1,25),(242,'Jose Angel Reyes',1,'5528702964',1,25),(243,'HAZAEL CAMERO GARCIA',1,'5528959557',1,25),(244,'ENRIQUE BARON RODRIGUEZ',1,'5528997531',1,25),(245,'Heriberto Paredes',1,'5529186941',1,25),(246,'LUIS ANGEL SANCHEZ PESINA',1,'5529290551',1,25),(247,'LIDIA GARRIDO',1,'5529379837',4,25),(248,'VERONICA VELAZCO',1,'5529479122',1,25),(249,'LEOPOLDO AYALA',1,'5529601364',1,25),(250,'Salgado Leon',1,'5529765074',1,25),(251,'ANTONIO BECERRIL MATTA',1,'5529806702',3,25),(252,'Victor Villaseñor',1,'5529975079',1,25),(253,'MAX TORRES JASSO',1,'5530050483',1,25),(254,'ARTURO ISAAC DELFIN GARCIA',1,'5530161982',1,25),(255,'MIGUEL ULISES PEREZ MONTIEL',1,'5530496825',1,25),(256,'REYMUNDO GARCIA',1,'5530655516',1,25),(257,'ARMANDO AGUILAR LOPEZ',1,'5530852470',1,25),(258,'ALEJANDRO GACIA',1,'5530878290',1,25),(259,'SILVERIO MENDOZA TREJO',1,'5531126871',1,25),(260,'JORGE DÍAZ',1,'5531281480',1,25),(261,'ANGEL RESENDIZ RUIZ',1,'5531286162',1,25),(262,'FERNANDO AGUILAR',1,'5531422283',1,25),(263,'ADAN RODRIGUEZ',1,'5531489380',1,25),(264,'ERIC SANTOS DEL PRADO',1,'5532076914',3,25),(265,'GABRIEL MACHORRO',1,'5532147139',1,25),(266,'FRANCISCO MARTINEZ HOW GYM',1,'5532269662',4,25),(267,'Victor Fuentes',1,'5532405482',1,25),(268,'JHOENNYS ARCAYA',1,'5532451656',1,25),(269,'ELOY HERNANDEZ SANCHEZ',1,'5532503408',1,25),(270,'EDUARDO AGUILERA GONZALEZ',1,'5532622752',4,25),(271,'Eduardo Romero',1,'5532729070',1,25),(272,'Alejandro Salinas',1,'5532970167',1,25),(273,'Cristian Martinez',1,'5533096683',1,25),(274,'Angel Lopez',1,'5533335308',1,25),(275,'DIANA MARICELA CORTEZ RAMIREZ',1,'5533434031',1,25),(276,'TANIA ELIZABETH VERA REGIS',1,'5533638431',1,25),(277,'VICTOR NANDER',1,'5533970665',1,25),(278,'DIEGO QUINTOS ESPINOZA',1,'5534014777',1,25),(279,'KARLA DOMINGUEZ',1,'5534207941',1,25),(280,'Benita Osnaya Flores',1,'5534260869',1,25),(281,'FABIAN MORENO',1,'5534493191',1,25),(282,'Jessica Rodriguez',1,'5534580812',1,25),(283,'Salvador Segundo',1,'5534976963',1,25),(284,'DAFNE SANCHEZ',1,'5535246434',1,25),(285,'DAFNE SANCHEZ ALVAREZ',1,'5535246434',1,25),(286,'ARMANDO ABRAHAM MURGIA GOMEZ',1,'5535620240',4,25),(287,'DANIEL GALLEGOS',1,'5535740652',1,25),(288,'MIGUEL ANGEL VEGA GYM INSTRUCTR',1,'5535961018',4,25),(289,'Artemio Dominguez Lucas',1,'5536099746',1,25),(290,'Gabino Perez',1,'5536198319',1,25),(291,'JESSICA GARCIA BRAVO',1,'5536309593',3,25),(292,'FRANCISCO JAVIER FABELA',1,'5536368313',1,25),(293,'Marco Antonio Espindola',1,'5536411953',1,25),(294,'JONATHAN VILLAR',1,'5536600554',1,25),(295,'URIEL AGUIRRE',1,'5537071869',1,25),(296,'TONY NERY DE LA ROSA',1,'5537121416',1,25),(297,'VICTOR ALFONSO REYES',1,'5537211631',1,25),(298,'JOSE ANTONIO SALAS CALDERON',1,'5537212326',1,25),(299,'ANTONIO ENRIQUE HERNANDEZ',1,'5537215208',1,25),(300,'Mauricio Alcantara',1,'5537257319',1,25),(301,'SARA HERNANDEZ',1,'5537283958',1,25),(302,'JOSE GRABRIEL MARTINEZ',1,'5537314946',1,25),(303,'Jose Martin',1,'5537705630',1,25),(304,'juan ortiz 01',1,'5537947396',1,25),(305,'Ricardo Muñiz',1,'5538878801',1,25),(306,'BRUNO SALAS ANGELES',1,'5538895147',1,25),(307,'ELIZA PACHECO',1,'5538966936',1,25),(308,'PEDRO CRUZ',1,'5539007783',1,25),(309,'ESMERALDA MERCEDES PACHECO AGUILAR',1,'5539079776',1,25),(310,'ADRIANA GONZALEZ',1,'5539236707',1,25),(311,'ISAID GALICIA',1,'5539259315',1,25),(312,'ITZEL PEREZ ZUÑIGA',1,'5539464443',1,25),(313,'MARIANA SIMON CARREÑO',1,'5539498701',1,25),(314,'ELVIA SANDOVAL',1,'5539524760',1,25),(315,'LEONOR HERNANDEZ GARCIA',1,'5539910974',1,25),(316,'Fabian Rivera',1,'5539976185',1,25),(317,'Diego Guerrero',1,'5540070476',1,25),(318,'carlos urquieta espinoza (instructor)',1,'5540146877',4,25),(319,'gustabo gonzalez severo',1,'5540200225',1,25),(320,'DANIELA URBINA SOLIS',1,'5540245958',1,25),(321,'GIL VELAZQUEZ MARTINEZ',1,'5540268226',1,25),(322,'CHRISTOFF SILVA FELICIANO',1,'5540786017',1,25),(323,'edwin puga ramirez',1,'5540810567',1,25),(324,'Edy Maldonado',1,'5540905307',1,25),(325,'FERNANDO FLORES',1,'5541094835',1,25),(326,'OCTAV1O V1LLEGAS VELAZQUEZ',1,'5541123622',1,25),(327,'PATRICIA CHABOLLA',1,'5541179405',1,25),(328,'Arturo Nuñez',1,'5541290928',1,25),(329,'FERNANDO CORDOVA',1,'5541393390',1,25),(330,'DILAN LOPEZ BENITEZ',1,'5541741699',1,25),(331,'MARISELA SANDOVAL',1,'5541880019',1,25),(332,'francisco villafranca garcia',1,'5542703748',1,25),(333,'Luis Antonio Garcia',1,'5543138424',1,25),(334,'HUGO PUERTO',1,'5543411223',1,25),(335,'NARCISO AQUINO VAZQUEZ',1,'5543456716',1,25),(336,'DANIEL SEVILLA',1,'5543532038',1,25),(337,'EVA ADRIANA SERNA CARRANO',1,'5543579719',1,25),(338,'Celia Garcia',1,'5543684001',1,25),(339,'ENRIQUE ORTIZ LOPEZ',1,'5543861628',1,25),(340,'ENRQUE ORTZ LOPEZ',1,'5543861628',3,25),(341,'Ruben Laguna',1,'5543951897',1,25),(342,'FLAVIO DAVID CRUZ',1,'5544049919',1,25),(343,'ARMANDO SAMPERIO',1,'5544481938',3,25),(344,'Francisco Ivan Hernandez',1,'5544593232',1,25),(345,'Patricia Carrillo',1,'5544816149',1,25),(346,'ANAIS GARCIA ORDOÑEZ',1,'5545037106',1,25),(347,'LESLY RAMOS 01',1,'5545152662',1,25),(348,'CRISTINO BERNARDINO EUTIQUIO',1,'5545333899',1,25),(349,'TONATIUH GUERRERO',1,'5545408595',1,25),(350,'MONTSERRATH OSORIO',1,'5545578673',1,25),(351,'antonio maciel lopez',1,'5545717169',1,25),(352,'Michelle Rocha Garcia',1,'5545815824',1,25),(353,'Debora Muñoz',1,'5545864001',3,25),(354,'CARLOS RODRIGUEZ GALVAN',1,'5546803418',1,25),(355,'MARIA GUADALUPE MENDOZA BENITEZ',1,'5546999426',4,25),(356,'RICARDO TREJO CALZADA',1,'5547112722',1,25),(357,'EDUARDO STUDER',1,'5547647584',1,25),(358,'URIEL GUILLERMO GODINEZ MENDOZA',1,'5548045257',1,25),(359,'GABRIEL CAMARILLO CRUZ',1,'5548329101',1,25),(360,'JESSICA MENDOZA CORREA 1',1,'5548386585',1,25),(361,'JAVIER ESTRADA',1,'5548555117',3,25),(362,'RODRIGO RIVERA 01',1,'5548693085',1,25),(363,'Luis Enrique',1,'5548996234',1,25),(364,'Joania Padilla',1,'5549135142',1,25),(365,'NAYELI BETEL VELAZQUEZ ORTIZ',1,'5549181452',1,25),(366,'Alfredo Garcia',1,'5549227016',1,25),(367,'Martinez Alonso Sandra',1,'5549375453',1,25),(368,'DIEGO ALBA',1,'5549501377',1,25),(369,'IVAN ALVAREZ 01',1,'5549507489',1,25),(370,'Paulina Perez',1,'5549590728',1,25),(371,'CARLOS DANIEL',1,'5549696058',1,25),(372,'JESUS VERA',1,'5549802183',1,25),(373,'OSCAR LAGUNA',1,'5549953271',1,25),(374,'FERNANDO ALVAREZ',1,'5550501335',1,25),(375,'Alvaro',1,'5550506082',1,25),(376,'CARLOS ALBERTO PINEDA CUEVAS',1,'5550640312',1,25),(377,'JONATAN LUNA',1,'5550698843',1,25),(378,'CLAUDIA BOSQUES SORIA',1,'5551028410',1,25),(379,'Fernando Gomez',1,'5551275560',1,25),(380,'jorge pulido',1,'5551591478',1,25),(381,'ALMA ORTEGA CRUZ',1,'5551631643',4,25),(382,'HACTOR PONCE',1,'5551679392',1,25),(383,'JUAN PABLO CRUZ 01',1,'5551918983',1,25),(384,'Victor Hernández',1,'5552481769',1,25),(385,'Karina Chávez Mondragón',1,'5552526457',1,25),(386,'EDUARDO QUIROZ',1,'5552953520',1,25),(387,'CRISTIAN ANGEL MORALES',1,'5553375520',1,25),(388,'DANIEL ALVARADO',1,'5554658140',4,25),(389,'KARINA ORTIZ',1,'5554718285',4,25),(390,'Mireya Smart',1,'5554745033',1,25),(391,'LUIS QUINTANAR',1,'555540088626',4,25),(392,'DAVID VERDUZCO GUERRERO',1,'55555555',4,25),(393,'ELIZABETH RODRIGUEZ',1,'5558337790',3,25),(394,'ARTURO SANCHEZ 01',1,'55587750169',1,25),(395,'VICTOR MANUEL OTERO',1,'5559308148',1,25),(396,'HEBER HAI RAMIREZ CASTRO',1,'5559915442',1,25),(397,'LETICIA DOMINGUEZ RAMIREZ',1,'5560209811',1,25),(398,'ALEJANDRA CASTAÑEDA 01',1,'5560258490',1,25),(399,'Fernando Sanchez',1,'5560665887',1,25),(400,'JULIO CESAR HERNANDEZ GAYTAN',1,'5560687539',1,25),(401,'gerardo lopez martinez',1,'5560830732',1,25),(402,'DAVID VILLARINO MARTINEZ',1,'5560918952',1,25),(403,'Rosa Maria',1,'5561000790',1,25),(404,'GUADALUPE HERNANDEZ',1,'5561072117',1,25),(405,'carlos cuellar',1,'5561072247',1,25),(406,'Alier Ordoñez',1,'5561208943',1,25),(407,'RICARDO RINCON TORRALES',1,'5561224639',3,25),(408,'Luis Hernandez',1,'5561227755',1,25),(409,'KARLA MARTINEZ',1,'556125111',1,25),(410,'NAYELI MERCADO GUZMAN',1,'5561271515',1,25),(411,'EDUARDO SAGRERA',1,'5561337145',1,25),(412,'CARLOS SANCHEZ GARCIA',1,'5561370002',1,25),(413,'ALEXIS OLVERA GONZALES 01',1,'5561403115',1,25),(414,'VICTOR MENDOZA',1,'5561496413',1,25),(415,'ALEJANDRO ROA',1,'5561753419',1,25),(416,'DIEGO CHAVEZ ARELLANO',1,'5561753914',1,25),(417,'MAURICIO MORA OLVERA',1,'5561760682',3,25),(418,'RUBEN CUBILLOS HEREDIA',1,'5562121246',1,25),(419,'Abel Cruz García',1,'5562148383',1,25),(420,'DANIEL HERNANDEZ LEON',1,'5562224705',3,25),(421,'Diana Diaz',1,'5562232980',1,25),(422,'ALEXIS VILLANUEVA',1,'5562259623',1,25),(423,'Melina Noemi',1,'5562521573',1,25),(424,'FRANCISCO ROJAS',1,'5562550605',1,25),(425,'JORGE CARBALLO',1,'5562876214',1,25),(426,'MARCO ANTONIO AYALA',1,'5563171587',1,25),(427,'Ismael Navarrete',1,'5563251044',1,25),(428,'MARCO ANTONIO AVENDAÑO FLORES',1,'5563498277',1,25),(429,'PAOLA LOPEZ ARELLANO',1,'5563582812',1,25),(430,'EDUARDO SANTIAGO',1,'5563583143',1,25),(431,'Miguel Cordero',1,'5563599146',1,25),(432,'JESUS VASQUEZ',1,'5563740908',1,25),(433,'ALEXIS PEÑA TRUJANO',1,'5563752872',1,25),(434,'Erwin Dziatzko',1,'5564004991',1,25),(435,'RICARDO GARCIA ARREOLA',1,'5564208210',4,25),(436,'FREDY LUJAN FUENTES',1,'5564309308',1,25),(437,'Milton Aquino',1,'5564635919',1,25),(438,'JULIETA CASO',1,'5564841647',1,25),(439,'JESSICALOPEZ GUZMAN',1,'5564900195',1,25),(440,'LUIS ANGEL RAMOS HUIDOBRO',1,'5565003734',3,25),(441,'DIEGOSARRO 01',1,'5565017874',1,25),(442,'David Silva',1,'5565149495',1,25),(443,'Gerardo Arroyo.',1,'5565308885',1,25),(444,'Rosa Aydee',1,'5565769956',1,25),(445,'DONOVAN AGUAYO NAVA',1,'5566652200',4,25),(446,'Jose Bartolo',1,'5566767761',1,25),(447,'ALBERTO MIRANDA OLMOS',1,'5566981721',3,25),(448,'DANIEL GARCIA HERNANDEZ',1,'5567274081',4,25),(449,'LEONARDO CRUZ',1,'5567417238',1,25),(450,'Lizeth Falcon',1,'5567525446',1,25),(451,'ARTURO BERNAL BETANZOS',1,'5567876884',4,25),(452,'CESAR CERVANTES 01',1,'5567919447',1,25),(453,'PAULINA CORDERO ESTRADA',1,'5568093861',1,25),(454,'EDUARDO ALCARAZ ORTEGA',1,'5568536383',2,25),(455,'VICTOR HUGO MARTINEZGOMEZ 1',1,'5568581191',1,25),(456,'Arturo Mendoza',1,'5568631008',1,25),(457,'ITZEL RANGEL 01',1,'5568740752',1,25),(458,'pablo perez ramirez',1,'5568840443',1,25),(459,'Monserrat Guzman',1,'5569012113',1,25),(460,'ALAIN BARRERA DIAZ',1,'5569632263',1,25),(461,'Ricardo Zavala',1,'5569687888',1,25),(462,'TONATIHU LOPEZ',1,'5569726381',3,25),(463,'GABRIEL MILLAN TAPIA',1,'5569740383',4,25),(464,'EDUARDO BELTRAN CARREON',1,'5570614266',3,25),(465,'JORGE LUNA',1,'5571805555',4,25),(466,'Esteban Mina',1,'5572276547',1,25),(467,'ISAC SORIA',1,'5572344475',3,25),(468,'sergio torrez 01',1,'5572698905',1,25),(469,'Abelardo Velasquez',1,'5573367755',1,25),(470,'EMILIANO JUSTO',1,'5573564741',1,25),(471,'MANUELA VILLATORO',1,'5573604296',3,25),(472,'Arturo Flores',1,'5573722630',1,25),(473,'SAMUEL SALAZAR',1,'5573808482',1,25),(474,'Jonathan terraza',1,'5574000338',3,25),(475,'CARINA PONSO',1,'5574192423',1,25),(476,'Eduardo Melchor Mateos',1,'5574325928',1,25),(477,'Rosalino Hernandez De La Cruz',1,'5574346698',1,25),(478,'ULISES ALDAPE FUNES',1,'5574462470',1,25),(479,'Obed Nevares',1,'5574666041',1,25),(480,'Mari Paz',1,'5574704313',1,25),(481,'Rafael Figueroa',1,'5574748184',1,25),(482,'ALEXIS IVAN VARGAS RAMIREZ',1,'5574803902',1,25),(483,'MIGUEL ANGEL GUTIERREZ ARAUJO',1,'5574834863',1,25),(484,'Sandra Ledezma',1,'5574848707',1,25),(485,'Irving Arrazola',1,'5574890155',1,25),(486,'DAN ABDIEL GARCIA DE LEON',1,'5574892237',1,25),(487,'VIRGINIA CASARRUBIAS MORALES',1,'5574928563',1,25),(488,'LUCIO JARDON 01',1,'5575329633',1,25),(489,'Adrian Cardenas',1,'5576375076',1,25),(490,'BRENDA ROSALES 01',1,'5576613232',1,25),(491,'JESUS ALEXIS ALVAREZ',1,'5577282019',1,25),(492,'ANA KAREN RIOS RODRIGUEZ',1,'5577456681',1,25),(493,'PATRICIA VAZQUEZ DIONICIO',1,'5577591253',1,25),(494,'CESAR EVANGELISTA LOPEZ',1,'5578026316',1,25),(495,'LAURA IBARRA',1,'5578063172',1,25),(496,'ADRIAN ACEVES',1,'5578460680',1,25),(497,'Brayan Santiago',1,'5578641079',1,25),(498,'Orlando Quintanar',1,'5578915488',1,25),(499,'ERIKA HERNANDEZ HERNANDEZ',1,'5578936301',1,25),(500,'erick gonzalez valdez 4',1,'5579179476',1,25),(501,'Genaro Leyva',1,'5579490981',1,25),(502,'RICARDO SAUL GARCIA',1,'5579504441',1,25),(503,'ALBERTO RIVERA HERNANDEZ',1,'5579776397',1,25),(504,'ANA KAREN LOPEZ SALAZAR',1,'5579817151',1,25),(505,'LUIS SERGIO TINOCO',1,'5580036577',1,25),(506,'CARLOS ISRAEL SANCHEZ CASTAÑON',1,'5580236422',1,25),(507,'FERNANDO ORDOÑEZ MARTINEZ',1,'5580323643',1,25),(508,'Daniel Mendoza',1,'5580367458',1,25),(509,'YAZMIN QUINTANA',1,'5580376115',4,25),(510,'IRVING MORALES',1,'5580706716',1,25),(511,'ELVIA SANTIAGO 01',1,'5580802564',1,25),(512,'Elizabeth Avalos',1,'5580807017',1,25),(513,'JORGE JAVIER VARGAS GALLARDO',1,'5580856964',1,25),(514,'SANTOS HERRERA JESUS',1,'5581002347',1,25),(515,'leopoldo gil',1,'5581007055',1,25),(516,'Vale Rubi',1,'5581089898',1,25),(517,'VANESA ALVAREZ LEGUIZAMO',1,'5581853259',4,25),(518,'HECTOR PEREZ VALCAZAR',1,'5582002283',1,25),(519,'MARCO ANTONIO REYEZ',1,'5582032389',1,25),(520,'Rogelio Lázaro Ortiz',1,'5582221690',1,25),(521,'Fabiola Sanchez',1,'5582771468',1,25),(522,'luis daniel arr',1,'5582954040',4,25),(523,'SERGIO SALAZAR MANZANERO',1,'5583305364',1,25),(524,'LUIS ANGEL GARCIA',1,'5583943262',1,25),(525,'Vania Marban',1,'5584114833',1,25),(526,'CARLOS RODEA',1,'5584241823',1,25),(527,'Daniela Padilla',1,'5584540991',1,25),(528,'Donovan Guzman',1,'5585073345',1,25),(529,'jose calderon',1,'5585498350',1,25),(530,'ALEJANDRO MENDEZ ALCANTARA',1,'5585500384',1,25),(531,'Yahir Estacionamiento',1,'5585682302',1,25),(532,'LIDIA GOMEZ HERNANDEZ',1,'5585855177',1,25),(533,'ALBERTO TREJO MARTINEZ',1,'5586080937',1,25),(534,'Fawzi Albarran',1,'5587049020',1,25),(535,'MIGUEL ANGEL BAZAN',1,'5587349403',1,25),(536,'Wilder Javier',1,'5587600381',1,25),(537,'Brandon Mendoza',1,'5587707888',1,25),(538,'JULIO CESAR JIMENEZ CONCHILLOS',1,'5587944303',1,25),(539,'Moises Peñaloza',1,'5588121370',1,25),(540,'LUIS ANTONINO',1,'5588217738',1,25),(541,'Alejandro Aviles',1,'5591103044',1,25),(542,'ARTURO HERNANDEZ MANGE',1,'5591211352',1,25),(543,'BRANDON BALDERAS',1,'5591397220',1,25),(544,'OSVAKDO MARRON',1,'5591903729',1,25),(545,'VIRIDIANA MENDOZA VILLASANA',1,'5591907459',1,25),(546,'PATRICIA ABASOLO',1,'5591914633',1,25),(547,'KEVIN GOMEZ',1,'5591948936',1,25),(548,'LIZBETH HERNANDEZ',1,'5591981788',3,25),(549,'WENDY JIMENEZ',1,'5610048247',1,25),(550,'MARTIN REZA',1,'5610100260',1,25),(551,'Jonathan Duarte',1,'5610177333',1,25),(552,'ELADIO OMAR RUIZ MANCILLA',1,'5610386800',1,25),(553,'KEVIN CASANOVA',1,'5610452487',1,25),(554,'ANGEL EDUARDO RAMIREZ FLORES',1,'5610525374',1,25),(555,'ANGEL RAMIREZ',1,'5610525374',1,25),(556,'ADRIANA APOLINAR TORIS',1,'5611219309',1,25),(557,'Derik Carmona',1,'5611698300',1,25),(558,'David Navarro',1,'5611714771',1,25),(559,'paola torres',1,'5611721122',1,25),(560,'DANIEL ESPINOZA PUBLICO',1,'5611730512',1,25),(561,'ANTONIO REA AGUIRRE',1,'5611880585',1,25),(562,'CESAR HERMOSILLO VILCHIS',1,'5611891523',1,25),(563,'Gerardo Sampeiro',1,'5612587038',1,25),(564,'TIFANY CINTHYA',1,'5612719550',1,25),(565,'EVELIN HERNANDEZ',1,'5613375597',1,25),(566,'JENNYFER PATIÑO',1,'5614013751',1,25),(567,'CARLOS AGUILAR GYM STONE MONSTER',1,'5614184789',4,25),(568,'FERNANDA VALDIVIA',1,'5614336421',1,25),(569,'Ayde Jimenez',1,'5614380233',1,25),(570,'BRANDON BLANCO',1,'5614771505',1,25),(571,'RAFAEL MARTINEZ PIÑON',1,'5615163669',1,25),(572,'JONATHAN VEGA',1,'5615209598',1,25),(573,'Saul Valarez',1,'5615423795',1,25),(574,'OMAR MORALES',1,'5615587682',4,25),(575,'OMAR MORALES GYM SAN RAFA',1,'5615587682',1,25),(576,'Jaquelin Fernandez',1,'5615753571',1,25),(577,'DIANA VAZQUEZ',1,'5616822317',1,25),(578,'GRISELDA HERNANDEZ',1,'5617159150',1,25),(579,'IMPERIA ROA HERNANDEZ',1,'5617189149',3,25),(580,'ERICK ORTIZ',1,'5617209394',1,25),(581,'JORGE ORTIZ',1,'5617435502',1,25),(582,'Jorge del Valle',1,'5617580257',1,25),(583,'alexis emmanuel sandoval balderas 01',1,'5617746521',1,25),(584,'BENJAMIN PADILLA',1,'5617790812',1,25),(585,'KEVIN COLIN',1,'5617795394',1,25),(586,'Armando Dorante',1,'5617885593',1,25),(587,'marco yael lopez',1,'5617950146',3,25),(588,'Samuel Alonso',1,'5618078682',1,25),(589,'JOVANI PUBLICO',1,'5618103968',1,25),(590,'mauricio maldonado',1,'5618425142',1,25),(591,'Ximena Vigueras',1,'5618826350',1,25),(592,'Jose Alfredo Lopez',1,'5619117843',1,25),(593,'MARIA FERNANDA RAMIREZ',1,'5619873810',3,25),(594,'Natali Villa',1,'5620263456',1,25),(595,'Raymundo Morales',1,'5620532126',1,25),(596,'arturo ituarte españa',1,'5620799970',4,25),(597,'JULIO ADRIAN RIOS',1,'5621325113',1,25),(598,'MONICA CRUZ MEJIA',1,'5621400273',1,25),(599,'ROGELIO SOLIS',1,'5621451589',1,25),(600,'MAYRA GARCIA',1,'5621589178',1,25),(601,'El Morris',1,'5621971071',1,25),(602,'NANCY GONAZALES 01',1,'5621989559',1,25),(603,'GUADALUPE PAREDES RIVERA',1,'5622076558',1,25),(604,'Eliud Saenz',1,'5623750775',1,25),(605,'Fernando Ortiz Glan',1,'5623782618',1,25),(606,'CHRISTIAN NAVA',1,'5623930429',1,25),(607,'DANIEL VELAZQUEZ',1,'5624006014',1,25),(608,'Carlos Castillo',1,'5624543887',1,25),(609,'LZBETH MARTINEZ',1,'5624713092',1,25),(610,'LUIS ROMERO GYM',1,'5625834293',4,25),(611,'JUAN CARLOS GONZALEZ',1,'5625921373',3,25),(612,'Tony',1,'5626043233',1,25),(613,'Bernardo Ortiz',1,'5626971844',1,25),(614,'VIANEY SALGADO',1,'5627609730',1,25),(615,'NORBARTO CASTRO VALLEJO',1,'5630642438',1,25),(616,'HECTOR RODRIGO GARCIA',1,'5631255532',3,25),(617,'CARLOS MANUEL GARCIA RODEA',1,'5631267879',1,25),(618,'HUGO CESAR',1,'5631305816',1,25),(619,'IAN CARLO REYES',1,'5632516503',1,25),(620,'enrique martinez 01',1,'5632538402',1,25),(621,'CAROLINA HERRERA',1,'5633151446',1,25),(622,'PEDRO EDUARDO SALAZAR',1,'5633261480',3,25),(623,'YANET BASTIDA CARBAJAL',1,'5633693179',1,25),(624,'LEONARDO BRAVO CRUZ',1,'5635288991',1,25),(625,'JOSE MANUEL CASTILLO',1,'5636011666',1,25),(626,'alejandro ramirez',1,'5636327590',1,25),(627,'SERGIO LOARCA',1,'5636489070',1,25),(628,'OSCAR GARCIA LOPEZ',1,'5637168236',1,25),(629,'DANIEL GONZALES 01',1,'5637729597',1,25),(630,'WILLIAN VIGUERAS',1,'5640001641',1,25),(631,'LIZA CORONEL',1,'5647799597',1,25),(632,'ANDRES VELAZQUES TAPIA 01',1,'5655356772',1,25),(633,'Karla Montserrat',1,'5971234392',1,25),(634,'gonzales portilla alexis',1,'7202467175',1,25),(635,'Guadalupe Yuliet',1,'7223434862',1,25),(636,'SARAI ARELLANO ATLETIC GYM',1,'7293569872',4,25),(637,'VICTOR GYM HONDURS',1,'7295589168',1,25),(638,'JONATHAN SPORT NUTRITION',1,'7296122255',1,25),(639,'carmen ariely lopez vargaz',1,'7296308109',1,25),(640,'YANET ANTONIO HERNANDEZ',1,'7298141498',1,25),(641,'MARIO ALBERTO MOTA',1,'7298161633',1,25),(642,'JANELLY OCAMPO RIVERA',1,'7341313917',1,25),(643,'anay flores',1,'7352876730',1,25),(644,'JONATHAN ISAAC ORTEGA',1,'8135783935',1,25),(645,'Lorena Ruiz',1,'9211186141',1,25),(646,'CAROLINA LOPEZTOWN CENTER',1,'9626246969',1,25),(647,'JESUS JOATAHM FUENTES COPCA',2,'5544887012',3,25),(648,'ALEJANDRO GIL',2,'5573705325',1,25),(649,'ALEJANDRO IVAN ALMARAZ',2,'5566206993',4,25),(650,'ANGEL LOYOLA',2,'SN',1,25),(651,'ARIANNA DIAZ FITNESS ON',2,'5514283840',4,25),(652,'ARMANDO ART GYM',2,'SN',4,25),(653,'ARMANDO CASTILLO ENERGY GYM',2,'SN',4,25),(654,'ARMANDO DIAZ',2,'SN',4,25),(655,'CARLOS ROSAS LOPEZ INSTRUCTOR',2,'SN',4,25),(656,'ERICK ENERGY CENTER',2,'5549446117',4,25),(657,'ERICK GIL SALAZAR',2,'5620230694',1,25),(658,'FABIOLA ABIGAIL HERNANDEZ',2,'5636652175',1,25),(659,'IVAN ENERGY GYM',2,'SN',4,25),(660,'JAVIER VELAZQUEZ',2,'5523807799',1,25),(661,'JOSUE RAUL VERGARA',2,'5568643568',4,25),(662,'MAYTE ARCK GYM',2,'5624005793',4,25),(663,'NELLY CAMARGO ADMON VILLAS HDA',2,'5558871327',4,25),(664,'OSCAR GIOVANNI PEREGRINO',2,'5561711893',1,25),(665,'PAVEL ALCANTARA',2,'5516823934',4,25),(666,'YAEL DIAZ',2,'5519812538',1,25),(667,'DIEGO GARCIA',2,'5585841087',4,25),(668,'KALETH MEDINA',2,'SN',4,25),(669,'CALUMA GYM',2,'7772946281',4,25),(670,'ALEJANDRO ALMAZAN',2,'SN',3,25),(671,'CELESTE NAVARRO',2,'5567830900',3,25),(672,'ERICK RODRIGUEZ XAHUNTITLA',2,'5524118838',4,25),(673,'PEDRO GARCIA',2,'5548971667',1,25),(674,'RUBEN SILVA',2,'4426082069',4,25),(675,'JOSE APOLINAR CABRERA GUDIÑO GYM',2,'5569130306',4,25),(676,'OSCAR NAVA',2,'SN',4,25),(677,'ARTURO CRUZ IBAÑES',2,'5511169101',1,25),(678,'MANUEL HERNANDEZ',2,'5511322774',4,25),(679,'HECTOR GONZALES INSTRUCTOR',2,'58634752233',4,25),(680,'JOSE MIGUEL CAMPOS GUERRERO',2,'5513552438',3,25),(681,'SHARON REYNA',2,'5580653409',1,25),(682,'TONATIHU ARZATE CRUZ',3,'5543387494',4,37),(683,'PABLO VILLALBA MR. MEXICO',2,'5549206360',4,25),(684,'JORGE DANIEL MORALES',7,'7228467641',3,29),(685,'JOSE ANTONIO HERNANDEZ VELOZ',7,'5519245704',1,29),(686,'JOSE RAMON PEREZ INOSTROSA',7,'5539288160',4,29),(687,'ANGEL ROSALES',2,'5567922720',1,25),(688,'MIGUEL DE BARRON',3,'SN',4,37),(689,'TANIA PEREZ',2,'5513218179',4,25),(690,'SANDRA ALEJANDRA APAZA',2,'5530458526',4,25),(691,'ALMA PAOLA BARRERA RODROGUEZ',2,'5567929634',4,25),(692,'OSCAR VEGA (ALBA GYM)',3,'SN',3,37),(693,'GUSTAVO ENRIQUEZJUAREZ ALONZO',2,'5536990844',1,25),(694,'ALONSO REYES',3,'SN',3,37),(695,'HECTOR DELGADO ECHAVARRIA',3,'7411167968',4,37),(696,'ABDIEL HERNANDEZ CORONA GYM',3,'5562537543',4,37),(697,'JOSE ANDRES GONZALEZ GARCIA \"HEALTH GYM\"',3,'5527163408',4,37),(698,'MIGUEL ANGEL ATIZAPAN',2,'SN',4,25),(699,'LEONEL GYM BETTER BODY',3,'SN',4,37),(700,'ABNER ARRIOLA',4,'SN',4,32),(701,'ANGEL MANUEL GASCA GOMEZ',4,'8127577779',1,32),(702,'JESUS SALVADOR VENTURA',4,'5538972128',1,32),(703,'ABIGAIL SANCHEZ',4,'5535553923',1,32),(704,'ABRAHAM ANAYA',4,'5573692699',1,32),(705,'ABRAHAM MUÑOZ BECERRIL',4,'5626463300',1,32),(706,'ABRAHAM ODED RANGEL',4,'4531372684',1,32),(707,'ABRIL DEL RIO',4,'5588091118',1,32),(708,'ADOLFO RAMIREZ VEGA',4,'5614270713',1,32),(709,'ADRIAN ESPINOZA',4,'5515732125',1,32),(710,'ADRIAN ROCHA',4,'5635283624',3,32),(711,'ADRIAN ROSA',4,'5568162841',1,32),(712,'ADRIANA NAJERA',4,'5541502017',1,32),(713,'ADRIANA TORRES ALVAREZ',4,'5539368319',1,32),(714,'ADRIEL ALEJANDRO AGUILAR MEDRANO',4,'5624042932',1,32),(715,'AGUSTIN RODRIGUEZ',4,'5539979530',3,32),(716,'ALAN DAVID',4,'5585918595',1,32),(717,'ALAN DAVID RAMIREZ VAZQUEZ',4,'5576273763',1,32),(718,'ALAN GONZALEZ CASTILLO',4,'5541412802',4,32),(719,'ALBERTO',4,'5534442107',1,32),(720,'ALBERTO CARDENAS',4,'5615135902',3,32),(721,'ALBERTO HERNANDEZ LOCATARIO',4,'5587765064',3,32),(722,'ALBERTO LOPEZ PEREZ',4,'5574976263',1,32),(723,'ALBERTO MOLINA',4,'5614049530',1,32),(724,'ALBERTO PEREZ NUÑEZ',4,'5534442107',1,32),(725,'ALBERTO SANTOS LIRA',4,'5531702309',3,32),(726,'ALBERTO SOLANO',4,'5520527849',1,32),(727,'ALBETO ORTEGA',4,'5551059671',1,32),(728,'ALDAIR VARGAS',4,'SN',1,32),(729,'ALDO ISAIT ABURTO',4,'5548863018',1,32),(730,'ALDRICH YAEL PETRICIOLI',4,'5562183877',1,32),(731,'ALEJANDRA GARCIA NUÑEZ',4,'5575150338',1,32),(732,'ALEJANDRA OLMOS',4,'5615632645',1,32),(733,'ALEJANDRO ALMARAZ',4,'5540286997',1,32),(734,'ALEJANDRO CABRERA',4,'5554736326',1,32),(735,'ALEJANDRO CASTELLANOS MARTINEZ',4,'5574593150',1,32),(736,'ALEJANDRO ENRIQUE LARGO',4,'5581104101',1,32),(737,'ALEJANDRO GARRIDO',4,'5525840206',1,32),(738,'ALEJANDRO GONZALEZ ACUÑA',4,'5511230744',1,32),(739,'ALEJANDRO GONZALEZ SANTIAGO',4,'5532214395',1,32),(740,'ALEJANDRO HERNANDEZ LIRA',4,'5531703836',1,32),(741,'ALEJANDRO PALE AGUILAR',4,'5534447684',1,32),(742,'ALEJANDRO PEREZ',4,'5574241316',1,32),(743,'ALEJANDRO RIVAS',4,'5633613857',4,32),(744,'ALEJANDRO RIVAS',4,'5633613857',4,32),(745,'ALEJANDRO SOSA LEON',4,'5519763752',1,32),(746,'ALENXANDER GONZALEZ',4,'5612863228',4,32),(747,'ALEX LOPEZ',4,'5511428540',1,32),(748,'ALEXANDER GONZALEZ',4,'5612863228',1,32),(749,'ALEXANDER OSWALDO JIMENEZ',4,'5573372718',1,32),(750,'ALEXANDRA GARCIA',4,'5575150339',1,32),(751,'ALEXIS ORTIZ',4,'5612975301',1,32),(752,'ALEXIS REBOLLADO',4,'5576648636',1,32),(753,'ALEXIS ROMERO OLARDE',4,'5584716956',4,32),(754,'ALFONSO DIAZ',4,'5534915167',1,32),(755,'ALFONSO ESQUIVEL GONZALEZ',4,'5512274035',1,32),(756,'ALFREDO CASTILLO',4,'5582479377',1,32),(757,'ALFREDO ZUÑIGA IZUNZA',4,'5539901254',1,32),(758,'ALICIA CARREÑO RAMIREZ',4,'5516523972',4,32),(759,'ALVARO GARCIA CORONA',4,'5540558957',1,32),(760,'ALVARO GARCIA GUEVARA',4,'5519287513',1,32),(761,'AMADO HERNANDEZ',4,'5565296536',1,32),(762,'AMERICA DENISE MEDINA',4,'5576901393',1,32),(763,'ANA CORNEJO',4,'5514675950',1,32),(764,'ANA KAREN CANO ALVAREZ',4,'5560781795',1,32),(765,'ANA LUISA DE LA CRUZ',4,'5510792107',1,32),(766,'ANA LUISA GONZALEZ',4,'5618398605',1,32),(767,'ANA SPORT',4,'5635230709',4,32),(768,'ANAHI ROMERO',4,'5532106916',4,32),(769,'ANAYELI MARTINEZ',4,'5535192002',1,32),(770,'ANDREA ALCALA',4,'5547609178',1,32),(771,'ANDREA BARRAGAN',4,'5534510990',1,32),(772,'ANDREA FLORES',4,'5530815610',1,32),(773,'ANDREA MERCADO',4,'5528202876',1,32),(774,'ANDRES DIAZ',4,'5634606909',1,32),(775,'ANDRES OLIVERA',4,'SN',1,32),(776,'ANDRES ORTIZ GLZ',4,'5531139870',1,32),(777,'ANDRES PEREZ',4,'5561951091',1,32),(778,'ANEL ORTIZ GARCIA',4,'5542132745',1,32),(779,'ANEL SHARAIAN',4,'5542132745',1,32),(780,'ANGEL ALEMAN',4,'5546181750',1,32),(781,'ANGEL BARUSH ROMAN',4,'5540300839',4,32),(782,'ANGEL EDUARDO PACHECO',4,'5539536208',1,32),(783,'ANGEL ESTRADA',4,'5562119091',1,32),(784,'ANGEL ESTRDA',4,'5562119091',1,32),(785,'ANGEL MANUEL GASCA GOMEZ',4,'8127577779',1,32),(786,'ANGEL OCHOA VILLANUEVA',4,'5572924776',1,32),(787,'ANGEL PERALTA',4,'5510592220',4,32),(788,'ANGEL SAUL GERMAN SORIANO',4,'5618745569',3,32),(789,'ANGEL TOVAR RAMIREZ',4,'5580761312',1,32),(790,'ANGEL VALENCIA CAMACHO',4,'5630485330',1,32),(791,'ANGELICA CUELLAR MUÑOZ',4,'5529266444',4,32),(792,'ANGELICA DELGADO',4,'5532463514',1,32),(793,'ANGELICA DURAN',4,'5531139870',1,32),(794,'ANGELICA SEMILLA DAVILA',4,'5525023562',3,32),(795,'ANGIE HERNANDEZ',4,'5591704641',1,32),(796,'ANNI GARCIA',4,'5575541871',1,32),(797,'ANTONIO DE JESUS',4,'5618852728',1,32),(798,'ANTONIO DIAZ',4,'5620353906',1,32),(799,'ANTONIO SALAS',4,'551172673',3,32),(800,'ARACELI MENDOZA MONDRAGON',4,'5511529689',1,32),(801,'ARACELI VARGAS PEREZ',4,'5612634165',1,32),(802,'ARAH DE LA CRUZ',4,'5550649519',1,32),(803,'ARAT AGUILAR',4,'5522058963',1,32),(804,'ARAT GUERRERO',4,'5622058963',4,32),(805,'ARATH FLORES HERNANDEZ',4,'5523446085',1,32),(806,'ARIAN YAIR MAYA ESTRADA',4,'5576971854',1,32),(807,'ARIANA LOPEZ',4,'5613186265',1,32),(808,'ARLEN CAMPOS SERNA',4,'5578604698',1,32),(809,'ARMANDO GONZALEZ RAMIREZ',4,'5547691296',1,32),(810,'ARMANDO MORALES',4,'5634305819',1,32),(811,'ARMANDO RAMIREZ DURAN',4,'5583005656',1,32),(812,'ARMANDO TORRES',4,'7711786021',1,32),(813,'armando torres',4,'SN',1,32),(814,'ARMANDO URIEL ROMERO',4,'5626557888',1,32),(815,'ARON DIAZ GOMEZ',4,'5543376633',1,32),(816,'ARTURO FRAUSTO AVILA',4,'5580372262',3,32),(817,'ARTURO MARTINEZ VIAZCAN',4,'5511398205',1,32),(818,'ARTURO MONTIEL',4,'5515050152',1,32),(819,'ARTURO RAMIREZ',4,'5613926883',1,32),(820,'ARTURO VALDEZ',4,'5526594196',1,32),(821,'ATANASIO MARTINEZ',4,'5543469103',4,32),(822,'AXEL LUGO CONTRERAS',4,'5613746956',1,32),(823,'AXEL MORENO',4,'5535336971',1,32),(824,'AXEL PEREZ',4,'5571409131',1,32),(825,'AXEL REYES',4,'5524319692',1,32),(826,'AXEL VELAZQUEZ SILVA',4,'5519620062',1,32),(827,'BEATRIZ DIAZ',4,'5529082302',1,32),(828,'BENEDICTO MELGUEREJO DIAZ',4,'5544603836',1,32),(829,'BENNYACUT LOPEZ',4,'5527405842',4,32),(830,'BERENICE ALEGRIA',4,'5568891862',1,32),(831,'BERENICE CID',4,'5613662510',1,32),(832,'BETZA RENE GONZALEZ SANCHEZ',4,'5584925543',1,32),(833,'BIANCA VICTORIA DONAJI',4,'5610593237',3,32),(834,'BRANDON ALBERTO ALVAREZ GARCIA',4,'5549081431',1,32),(835,'BRANDON ARAIZA ALVAREZ',4,'5565195500',1,32),(836,'BRANDON AVILA',4,'5620597168',1,32),(837,'BRANDON DIAZ',4,'5528925098',1,32),(838,'BRANDON ROQUE',4,'56247727413',1,32),(839,'BRAULIO CABALLERO',4,'5624073143',4,32),(840,'BRAYAN CRUZ RUEDA',4,'5531991994',1,32),(841,'BRENDA CASTILLO',4,'5548960316',1,32),(842,'BRENDA COLIN',4,'5514593244',1,32),(843,'BRIAN ARGUS REYES',4,'5518155887',1,32),(844,'BRIAN RODRIGUEZ IBARRA',4,'5528959074',1,32),(845,'BRISNA ZARATE',4,'5531308064',1,32),(846,'BRUNO GARCIA SOSA',4,'5547794382',1,32),(847,'BRYAN LUCERO PEREZ',4,'5572939141',1,32),(848,'BRYAN RIVERA MEZA',4,'5514839572',1,32),(849,'CARLOS DANIEL NARANJO',4,'5568660017',1,32),(850,'CARLOS DE AQUINO',4,'5545317706',1,32),(851,'CARLOS ESTRADA HERNANDEZ',4,'5552484597',1,32),(852,'CARLOS GALEANA',4,'5546789586',4,32),(853,'CARLOS GONZALEZ',4,'5548157303',1,32),(854,'CARLOS GUERRERO LAGUNA',4,'5554350998',1,32),(855,'CARLOS LARA HDZ',4,'5515887093',1,32),(856,'CARLOS LEYVA',4,'5576673938',4,32),(857,'CARLOS LOPEZ VITE',4,'5520906272',1,32),(858,'CARLOS MENDIETA MARIN',4,'SN',1,32),(859,'CARLOS MONTES',4,'5582498004',1,32),(860,'CARLOS OMAR SEGOVIANO',4,'6645167543',1,32),(861,'CARLOS SANCHEZ MERAZ',4,'5528534580',1,32),(862,'CARLOS SAUZA',4,'5538965572',1,32),(863,'CARLOS VELAZQUEZ CALDERON',4,'5570075335',1,32),(864,'CARLOS VERGARA',4,'5579198155',3,32),(865,'CAROLINA POZOS',4,'5537738317',1,32),(866,'CAROLINA VALDES GONZALEZ',4,'5525896314',1,32),(867,'CASIEL GARCIA',4,'5637148401',1,32),(868,'CECILIA MENDEZ',4,'5524399651',1,32),(869,'CESAR BECERRIL VARGAS',4,'5614288211',1,32),(870,'CESAR BOLAÑOS',4,'5567885634',1,32),(871,'CESAR DEGANTE',4,'5511486579',1,32),(872,'CESAR EDUARDO GONZALEZ',4,'5546484958',1,32),(873,'CESAR PEREZ HERNANDEZ',4,'5526058811',1,32),(874,'CESAR RUBIO',4,'5513067593',1,32),(875,'CESAR SALGADO',4,'5535251735',1,32),(876,'CESAR TADEO ROSA SEGOVIA',4,'5611759836',1,32),(877,'CESAR VERDUGO',4,'5539921057',1,32),(878,'CHRISTIAN ERNESTO LOPEZ GARDUÑO',4,'5534002924',1,32),(879,'CINTHIA VERONICA IZQUIERDO',4,'55730108/97',1,32),(880,'CINTHYA REYES',4,'5511423275',1,32),(881,'CRISTIAN ALEXIS SILVA LOPEZ',4,'5527733570',3,32),(882,'CRISTIAN CABALLERO',4,'SN',3,32),(883,'CRISTIAN DAVID RODRIGUEZ',4,'5546439906',3,32),(884,'CRISTIAN REYES GUTIERREZ',4,'5522173338',1,32),(885,'CRISTIAN SERRANO',4,'5573409765',4,32),(886,'CRISTOBAL BAUTISTA',4,'5535151235',1,32),(887,'CRISTOFER ORIZ',4,'5584006667',1,32),(888,'CUAUTEMOC SUAREZ',4,'5610436912',4,32),(889,'DAFNE QUEVEDO',4,'5568160211',1,32),(890,'DALIA ROJAS',4,'5568002589',4,32),(891,'DAMIAN ARBIZU',4,'5539325174',1,32),(892,'DANIEL ALEJANDRO HORTA SANCHEZ',4,'5631351890',4,32),(893,'DANIEL ANTONIO ELIZALDE ARZOLA',4,'5543930071',1,32),(894,'DANIEL CEBRERO GARCIA',4,'5568839894',4,32),(895,'DANIEL CORDERO',4,'5624297577',1,32),(896,'DANIEL CUELLAR',4,'5578176449',1,32),(897,'DANIEL HERNANDEZ TORRES',4,'5573735074',1,32),(898,'DANIEL OLIVO',4,'5634480638',1,32),(899,'DANIEL OTILIO VAZQUEZ',4,'5587948316',1,32),(900,'DANIEL RAMIREZ CARVAJAL',4,'5543486878',1,32),(901,'DANIEL RODRIGUEZ RAMOS',4,'5569633000',1,32),(902,'DANIEL TORRES',4,'5540977813',1,32),(903,'DANIEL URQUIETA',4,'5584473232',1,32),(904,'DANIEL VALENCIA',4,'5545628758',1,32),(905,'DANIELA ALMANZA',4,'5547957241',1,32),(906,'DANIELA BAUTISTA GONZALEZ',4,'5534974269',1,32),(907,'DANIELA GARCIA RAMOS',4,'5588250623',1,32),(908,'DANIELA LIZETH ZUÑIGA',4,'5549022350',1,32),(909,'DANIELA MENDOZA FLORES',4,'5516469897',1,32),(910,'DANILO PEREZ LOPEZ',4,'5621538522',1,32),(911,'DARIO RODRIGUEZ',4,'5511895177',1,32),(912,'DAVID ARIAS OSORIO',4,'5532006387',1,32),(913,'DAVID ARZATE GONZALEZ',4,'5563023741',1,32),(914,'DAVID GARCIA PAREDES',4,'5563552857',1,32),(915,'DAVID GONZALEZ',4,'5572776998',1,32),(916,'DAVID LOPEZ LOPEZ',4,'5566931241',1,32),(917,'DAVID ROMERO',4,'5540054926',1,32),(918,'DAVID ROMERO ZEPEDA',4,'5518603745',1,32),(919,'DAVID TORIZ',4,'5568074281',1,32),(920,'DAVID VAZQUEZ',4,'5585918596',1,32),(921,'DAYANA ARBISO SALGADO',4,'5621322983',1,32),(922,'DEMETRIO SOLIS',4,'5540625302',1,32),(923,'DIANA AURORA MENDOZA',4,'5583876300',1,32),(924,'DIANA BURGOA',4,'5552853144',1,32),(925,'DIANA CERVANTES LOPEZ',4,'5537180524',1,32),(926,'DIANA ESCALANTE',4,'5570583424',3,32),(927,'DIANA GARCIA ADMINISTRACION',4,'4425103826',3,32),(928,'DIANA KAREN PABELLO SANCHEZ',4,'5573336324',1,32),(929,'DIEGO ADRIAN ALVAREZ ARREDONDO',4,'5623994679',1,32),(930,'DIEGO CRUZ GUERRERO',4,'5536988926',1,32),(931,'DIEGO DELGADO FRAGOSO',4,'5532244835',4,32),(932,'DIEGO EDUARDO HERNANDEZ MARTINEZ',4,'5614776184',1,32),(933,'DIEGO GAEL CARVAJAL',4,'5525118140',4,32),(934,'DIEGO ISLAS SANCHEZ',4,'5610068418',4,32),(935,'DIEGO IVAN PICHARDO HERNANDEZ',4,'5571832696',1,32),(936,'DIEGO JIMENEZ PEREZ',4,'5620333983',1,32),(937,'DIEGO SANCHEZ',4,'5610068418',4,32),(938,'DILAN EMMANUEL MENDEZ',4,'5613257744',1,32),(939,'DULCE GARCIA',4,'5535144477',4,32),(940,'EDGAR ALEJANDRO REYES ABAD',4,'5539676393',1,32),(941,'EDGAR ARMANDO PEREZ MONRREAL',4,'5583518094',1,32),(942,'EDGAR BADILLO',4,'5518197534',3,32),(943,'EDGAR CABRERA',4,'5554736326',1,32),(944,'EDGAR CASTELLANOS SALGADO',4,'5534775365',1,32),(945,'EDGAR CONDE ISLAS',4,'5531827553',3,32),(946,'EDGAR GRANADOS',4,'5585811063',3,32),(947,'EDGAR HERNANDEZ',4,'5541742676',1,32),(948,'EDGAR ISRAEL RAMIREZ DE LA VEGA',4,'5539547258',4,32),(949,'EDGAR JAVIER MORALES LOPEZ',4,'5580194811',1,32),(950,'EDGAR LARA RAMIREZ',4,'5537368602',1,32),(951,'EDGAR MARQUEZ CHAVEZ',4,'5511865947',1,32),(952,'EDITH MUÑOZ',4,'5537346218',1,32),(953,'EDSON SAID IMBERT CRUZ',4,'5543288973',1,32),(954,'EDUARDO CAMACHO',4,'5519502995',4,32),(955,'EDUARDO CORNEJO',4,'5543560192',1,32),(956,'EDUARDO DURAN FLORES',4,'5520860263',1,32),(957,'EDUARDO FLORES HERNANDEZ',4,'5510012901',4,32),(958,'EDUARDO GUERRERO',4,'5541812668',1,32),(959,'EDUARDO HERNANDEZ',4,'5518782498',1,32),(960,'EDUARDO LIMON',4,'5562325304',1,32),(961,'EDUARDO LOPEZ',4,'5563234278',1,32),(962,'EDUARDO MARTINEZ',4,'5566309596',1,32),(963,'EDUARDO PEREZ',4,'5532274149',1,32),(964,'EDUARDO SANCHEZ',4,'5569153037',1,32),(965,'EDUARDO SPORTICA',4,'5512375317',4,32),(966,'EDUARDO VILLALPANDO',4,'2226511633',1,32),(967,'EDWIN HERNANDEZ GARCIA',4,'5539191257',4,32),(968,'ELEXANDER GONZALEZ DE LA PAZ',4,'5512863228',4,32),(969,'ELIZA ENTRENADORA',4,'5574719549',4,32),(970,'ELIZABETH CORONA',4,'5633586017',4,32),(971,'elizabeth feliciano yañez',4,'5551449201',1,32),(972,'ELOY MUSLERA BAEZ',4,'5583307291',1,32),(973,'EMILI ROSALES',4,'5542583266',1,32),(974,'EMILIANO CASTAÑEDA GONZALEZ',4,'5586002582',1,32),(975,'EMILIANO HERNANDEZ',4,'5561743297',1,32),(976,'EMILIO GUARNEROS',4,'5539904887',1,32),(977,'EMILIO MONDRAGON',4,'5551595327',1,32),(978,'EMMANUEL MONTOYA DIAZ',4,'5618448423',1,32),(979,'EMMANUEL MORALES',4,'5560661259',1,32),(980,'EMMANUEL ORDUÑA',4,'SN',1,32),(981,'EMMANUEL ORTIZ SANCHEZ',4,'5577553865',1,32),(982,'ENRIQUE CHAGOYA',4,'5545790783',3,32),(983,'ENRIQUE ESCALANTE',4,'5563579617',4,32),(984,'ENRIQUE RODRIGUEZ',4,'5627175720',1,32),(985,'ENRIQUE RODRIGUEZ SANCHEZ',4,'5586060608',1,32),(986,'ENRIQUE ROSAS',4,'5537763748',1,32),(987,'ENRIQUEE CHAGOYA',4,'5545790783',4,32),(988,'ERASMO CASTRO GUTIERREZ',4,'5543466599',1,32),(989,'ERENDIRA NATURAL GYM',4,'5535754340',4,32),(990,'ERICK ALAN',4,'5584847811',1,32),(991,'ERICK ALVAREZ',4,'5561904961',1,32),(992,'ERICK AVILA RAMIREZ',4,'5633730771',1,32),(993,'ERICK BORJES',4,'5522817086',1,32),(994,'ERICK COSTAS',4,'5517806133',4,32),(995,'ERICK COSTAS',4,'5517806133',4,32),(996,'ERICK JESUS ROMO VERA',4,'5540279380',1,32),(997,'ERICK JOSAFAT DURAN QUINTERO',4,'5678963679',4,32),(998,'ERICK RODRIGUEZ GARCIA',4,'4461511041',1,32),(999,'ERICK ROMERO',4,'5541922707',1,32),(1000,'ERIK ALAN HERNANDEZ LARA',4,'5584847811',1,32),(1001,'ERIK ALEJANDRO CARMONA',4,'5541892571',4,32),(1002,'ERIK ARTURO RENDON',4,'5576151203',1,32),(1003,'ERIK DANIEL FLORES VELAZQUEZ',4,'5521014665',1,32),(1004,'ERIKA GUZMAN',4,'5559625774',1,32),(1005,'ERIKA PALACIOS',4,'5518103730',1,32),(1006,'ERNESTO SANCHEZ',4,'5519715630',1,32),(1007,'ESMERALDA COBIAN ALEGRE',4,'3521324805',1,32),(1008,'ESPERANZA ROJAS',4,'5573706096',1,32),(1009,'ESTEBAN CANTU PALACIO',4,'5519638451',4,32),(1010,'ESTEBAN ZARRAGA',4,'5561364809',1,32),(1011,'ETELVINA  RIVERA SANTOS',4,'5626985730',4,32),(1012,'ETNA GARCIA',4,'5522168378',1,32),(1013,'ETNA GARCIA',4,'5522168378',1,32),(1014,'EVELYN FLORES',4,'5571720481',1,32),(1015,'EZRY',4,'5624076916',1,32),(1016,'FABIAN ARAGON',4,'5585108278',3,32),(1017,'FABIOLA CORREA',4,'5611355646',4,32),(1018,'FABIOLA SANCHEZ DIAZ',4,'5628099739',1,32),(1019,'FABRITZIO REYES',4,'5544795801',4,32),(1020,'FANNY MATA',4,'5525235159',1,32),(1021,'FELIPE DOMINGUEZ',4,'5614949590',1,32),(1022,'FELIPE HERNANDEZ',4,'5568595972',1,32),(1023,'FERNANDA ALVAREZ ROJO',4,'5533250028',1,32),(1024,'FERNANDO CHAVIRA',4,'5516833595',1,32),(1025,'FERNANDO CORTEZ',4,'5539568745',1,32),(1026,'FERNANDO GARCIA ESTRADA',4,'5541329001',1,32),(1027,'FERNANDO MARTINEZ',4,'5515028499',1,32),(1028,'FERNANDO OLARDE ROMERO',4,'5576847211',1,32),(1029,'FERNANDO OTOÑEZ',4,'5549852083',1,32),(1030,'FLEXO SANDOVAL CERVANTES',4,'5571466871',3,32),(1031,'FRANCISCO GUZMAN',4,'5562969751',1,32),(1032,'FRANCISCO IBARRA',4,'5559849366',1,32),(1033,'FRANCISCO JAVIER GARFIAS ROLDAN',4,'5618201585',1,32),(1034,'FRANCISCO JAVIER JUAREZ FLORES',4,'5560410274',3,32),(1035,'FRANCISCO LOYOLA',4,'SN',1,32),(1036,'FRANCISCO MAYA',4,'5540318400',1,32),(1037,'FRANCISCO MIGUEL PEREZ RUIZ',4,'5548181776',1,32),(1038,'FRANCISCO PEREZ ALEMAN',4,'5584780192',1,32),(1039,'GABINO MORALES',4,'5539208025',3,32),(1040,'GABRIEL BELTRAN',4,'5539555143',1,32),(1041,'GABRIEL MEDINA',4,'551803558',1,32),(1042,'GABRIEL MUÑOZ VAZQUEZ',4,'5572059923',1,32),(1043,'GABRIEL SANCHEZ GARCIA',4,'5537685013',1,32),(1044,'GABRIEL VAZQUEZ',4,'5617470990',1,32),(1045,'GABRIELA MARTINEZ',4,'SN',3,32),(1046,'GAYTAN CASTELLANOS',4,'5581280126',4,32),(1047,'GERAM CASTELAN ENRIQUEZ',4,'5575155812',1,32),(1048,'GERARDO ALVARADO AVALOS',4,'5530703733',1,32),(1049,'GERARDO BAUTISTA SANTIAGO',4,'5540663519',1,32),(1050,'GERARDO DIAZ ADICCION FITNESS',4,'5511588859',4,32),(1051,'GERARDO NARVAEZ ZARAGOZA',4,'5510279122',1,32),(1052,'GERARDO RAMIREZ MACHADO',4,'5535662896',1,32),(1053,'GERARDO RODRIGUEZ TORRES',4,'5545226690',1,32),(1054,'GERMAN ALEXIS GARCIA RAMIREZ',4,'5514985498',1,32),(1055,'GERMAN PEREZ',4,'5576672593',1,32),(1056,'GILBERTO CHAVEZ GUZMAN',4,'5532678350',1,32),(1057,'GISEL CAMPA',4,'5614481934',1,32),(1058,'GLADIS CRUZ CUAUTENCO',4,'5561931124',1,32),(1059,'GRACIELA JIMENEZ LUGO',4,'5616597203',1,32),(1060,'GUADALUPE MARTINEZ',4,'5620167349',1,32),(1061,'GUADALUPE RAMIREZ RUIZ',4,'5579204664',1,32),(1062,'GUADALUPE RUIZ',4,'5579424750',3,32),(1063,'GUILLERMO CHAVEZ',4,'5543254124',1,32),(1064,'GUILLERMO PEREZ',4,'5620168007',1,32),(1065,'GUSTAVO CAMPOS CRUZ',4,'5519341451',1,32),(1066,'GUSTAVO GARCIA',4,'5546128735',1,32),(1067,'GUSTAVO ROCHA GONZALEZ',4,'5615720165',1,32),(1068,'GUSTAVO VELAZQUEZ',4,'5546805008',1,32),(1069,'GYM ALEMAN',4,'5582999125',4,32),(1070,'GYM PALLADIUM',4,'5563985378',4,32),(1071,'GYM PALLADIUM',4,'5563985378',4,32),(1072,'GYM PALLADUIM',4,'55',1,32),(1073,'HANNEA ISABEL MIGOYA FLORES',4,'5530395873',1,32),(1074,'HECTOR GALLARDO',4,'5554760984',1,32),(1075,'HECTOR GALLARDO ORTEGA',4,'5554760984',1,32),(1076,'HECTOR HUGO RODRIGUEZ LEON',4,'5516228525',4,32),(1077,'HECTOR MANUEL PEREZ RIVERA',4,'5561677303',1,32),(1078,'HECTOR MANUEL VAZQUEZ',4,'5585711405',1,32),(1079,'HECTOR RODRIGUEZ MORENO',4,'5549442996',2,32),(1080,'HECTOR VELAZQUEZ',4,'5613502360',4,32),(1081,'HERIBERTO BAUTISTA GAMA',4,'5518664801',1,32),(1082,'HOMERO MARQUEZ',4,'5616222270',1,32),(1083,'HUGO FERNANDEZ LADRON DE GUEVARA',4,'5523196090',1,32),(1084,'HUGO MEDINA',4,'5528545061',1,32),(1085,'HUGO SEBASTIAN MARTINEZ DIAZ',4,'5584783440',1,32),(1086,'IBRAHIM SPENCER CAMACHO',4,'5627925481',4,32),(1087,'IGNACIO RAMIREZ',4,'5543738633',1,32),(1088,'IMANOL TOPETE',4,'5630455630',1,32),(1089,'IÑAKI SALGADO',4,'5535251735',4,32),(1090,'INOCENCIO REYES',4,'5524370061',4,32),(1091,'IRAN GOMEZ',4,'5545915315',1,32),(1092,'IRVIN VAZQUEZ',4,'2383900496',1,32),(1093,'ISAAC GONZALEZ  ALBARRAN',4,'5588307629',1,32),(1094,'ISAAC LAZCANO HUERTA',4,'5625868569',1,32),(1095,'ISAC GARCIA DIAZ',4,'5574922791',1,32),(1096,'ISAC SOLIS MEDINA',4,'5538639659',4,32),(1097,'ISAIT IRIARTE ROMERO',4,'5519339661',1,32),(1098,'ISMAEL DIAZ',4,'5539513368',1,32),(1099,'ISMAEL LUNA CAUDILLO',4,'5587922039',1,32),(1100,'ISMAEL VAZQUEZ PADILLA',4,'5533348292',1,32),(1101,'ISRAEL CALDERON',4,'5560583002',1,32),(1102,'ISRAEL GARCIA',4,'5577594886',1,32),(1103,'ISRAEL GUEVARA RUIZ',4,'5527202948',1,32),(1104,'ISRAEL IBARRA',4,'5626726240',1,32),(1105,'ISRAEL PONCE',4,'5545851911',1,32),(1106,'ITZEL AVILA',4,'7716082990',4,32),(1107,'IVAN CALIXTO',4,'5613035986',1,32),(1108,'IVAN CFC',4,'5527769524',1,32),(1109,'IVAN CHAVEZ',4,'5582870028',3,32),(1110,'IVAN CRUZ ROMERO',4,'5511223114',1,32),(1111,'IVAN MARTINEZ REYES',4,'5582331137',1,32),(1112,'IVAN ROTIA',4,'5587939015',3,32),(1113,'IVAN SALINAS',4,'5539154628',1,32),(1114,'IVET BRIONES',4,'5583931234',3,32),(1115,'IVETT BRIONES',4,'5583931234',1,32),(1116,'IVIS ORTIZ GOMEZ',4,'5561767895',1,32),(1117,'JAGUAR AZTECA GYM',4,'5564939551',2,32),(1118,'JAIME RAMIREZ',4,'5543730616',1,32),(1119,'JAIME VARGAS BERNAL',4,'5580405489',1,32),(1120,'JAIR JOSABAD GRANADOS ALBA',4,'5554619802',1,32),(1121,'JAIR RIVERA LOPEZ',4,'SN',1,32),(1122,'JAIRO JARAMILLO VIDA',4,'5544534273',3,32),(1123,'JAIRO SORIA',4,'SN',1,32),(1124,'JAIRO SOSA GARCIA',4,'5517069956',1,32),(1125,'JANETH MAURICIO ARENAS',4,'5512181751',1,32),(1126,'JAQUELINE GIL',4,'5582439564',1,32),(1127,'JARED BRAVO',4,'5567634869',4,32),(1128,'JASON',4,'5633930265',1,32),(1129,'JAVIER GUZMAN',4,'7226956237',4,32),(1130,'JAVIER LOPEZ',4,'5521481887',1,32),(1131,'JAVIER MORALES',4,'5527219879',4,32),(1132,'JEAN PAUL MILLAN ROJAS',4,'5526794114',1,32),(1133,'JENNIFER BRISA MARTINEZ MARTINEZ',4,'2382098404',1,32),(1134,'JESSICA COLLADO GUTIERREZ',4,'5568150217',1,32),(1135,'JESSICA DOMINGUEZ',4,'5567460031',1,32),(1136,'JESSICA MARIANA DIAZ RENTERIA',4,'3223498350',1,32),(1137,'JESUS ALBERTO CAMPOS SANCHEZ',4,'5579862657',1,32),(1138,'JESUS ALBERTO CORTES',4,'5527560574',1,32),(1139,'JESUS ALBERTO SOLIS MARTINEZ',4,'5539321647',3,32),(1140,'JESUS ALONSO FRIAS MONTIEL',4,'5611364192',1,32),(1141,'JESUS AMARO CORIA',4,'5585675639',1,32),(1142,'JESUS ANTONIO PEREZ RENDON',4,'55754147105',1,32),(1143,'JESUS BAUTISTA PANTOJA',4,'5512788757',4,32),(1144,'JESUS CARNIVORO',4,'5544925711',1,32),(1145,'JESUS DIAZ',4,'5523554368',1,32),(1146,'JESUS EDUARDO TORRES',4,'5571212099',1,32),(1147,'JESUS GARCIA LOPEZ',4,'5610575290',1,32),(1148,'JESUS HERNANDEZ SANDOVAL',4,'5624280216',1,32),(1149,'JESUS JACOME',4,'5535939587',1,32),(1150,'JESUS MANUEL GARCIA',4,'5571879360',1,32),(1151,'JESUS NAVARRO RESENDES',4,'5573800938',1,32),(1152,'JESUS OCTAVIO BAUTISTA',4,'5512788757',2,32),(1153,'JESUS ROSAS',4,'5520817098',3,32),(1154,'JESUS SANTILLAN',4,'5529702762',1,32),(1155,'JHERDAN BELTRAN',4,'5531981298',1,32),(1156,'JOAQUIN MARTIN RAMOS HERNANDEZ',4,'SN',1,32),(1157,'JOAQUIN RAMOS HERNANDEZ',4,'5561478199',4,32),(1158,'JOB EZEQUIEL SANTOS',4,'5530108210',1,32),(1159,'JOCELYN GOMEZ OVIEDO',4,'5631143496',4,32),(1160,'JOEL SORIA',4,'5574626324',1,32),(1161,'JONATHAN CADENA',4,'5526539968',1,32),(1162,'JONATHAN CARDENAS SANTANA',4,'5615863791',1,32),(1163,'JONATHAN EDWIN MEDINO',4,'5532349699',1,32),(1164,'JONATHAN FERNANDEZ PEREZ',4,'5547871089',1,32),(1165,'JONATHAN FERNANDEZ PEREZ',4,'5547871089',1,32),(1166,'JONATHAN LASCARI',4,'5536333517',1,32),(1167,'JONATHAN MEZA RODRIGUEZ',4,'5559608213',1,32),(1168,'JONATHAN NIETO ADMINISTRCION PLAZA',4,'5545498364',3,32),(1169,'JONATHAN PEREZ',4,'5510108758',1,32),(1170,'JORDAN DANIEL CHAVEZ VAZQUEZ',4,'5615480218',3,32),(1171,'JORDAN SANCHEZ',4,'5514471822',4,32),(1172,'JORGE ACOSTA CAÑETE',4,'5567392923',1,32),(1173,'JORGE GARRIDO LOPEZ',4,'5537113913',1,32),(1174,'JORGE GUTIERREZ',4,'5582080865',1,32),(1175,'JORGE LUIS ORTIZ GONZALEZ',4,'5574644871',1,32),(1176,'JORGE MARIN',4,'5536747998',1,32),(1177,'JORGE MAURICIO NAVA HUITRON',4,'55',1,32),(1178,'JORGE MORALES',4,'5530350781',1,32),(1179,'JORGE MUÑOZ',4,'5545074020',1,32),(1180,'JORGE RAMIREZ',4,'5591917542',1,32),(1181,'JORGE RIOS RAMIREZ',4,'5560678097',1,32),(1182,'JORGE RIVERA',4,'5678952300',4,32),(1183,'JORGE SATA',4,'5583679700',1,32),(1184,'JOSAFAT TREJO',4,'5532454541',1,32),(1185,'JOSE ALBERTO DIAZ LOPÉZ',4,'5542171786',1,32),(1186,'JOSE ALBERTO MARTINEZLOPEZ',4,'5580921506',1,32),(1187,'JOSE ANTONIO GUERRERO DE LA CRUZ',4,'5579933179',1,32),(1188,'JOSE BENITO CHIMECATL ESPINOZA',4,'5514158050',1,32),(1189,'JOSE BENITO CHIMECATL ESPINOZA',4,'5514158050',1,32),(1190,'JOSE CANDANEDO',4,'5550513294',3,32),(1191,'JOSE CRUZ GARCIA',4,'5571131439',1,32),(1192,'JOSE GUADALUPE RODRIGUEZ',4,'5540323166',1,32),(1193,'JOSE HOLGUIN',4,'5534227178',1,32),(1194,'JOSE JUAN ESCALANTE PAREDES',4,'5624258793',1,32),(1195,'JOSE JULIAN HERRERA',4,'5626679935',1,32),(1196,'JOSE LEONARDO VARGAS HERRERA',4,'5517761832',1,32),(1197,'JOSE LOPEZ',4,'5544045269',1,32),(1198,'JOSE LUCIO',4,'5696589510',4,32),(1199,'JOSE LUIS ARELLANO',4,'5537127828',4,32),(1200,'JOSE LUIS GONZALEZ SANCHEZ',4,'5580516037',1,32),(1201,'JOSE LUIS HERNANDEZ AGUERO',4,'7711137142',4,32),(1202,'JOSE LUIS LUCIO',4,'5585311287',1,32),(1203,'JOSE LUIS MEDINA MORALES',4,'5630263804',3,32),(1204,'JOSE LUIS TELLES LOPEZ',4,'5516244533',1,32),(1205,'JOSE MANUEL RAMIREZ MORALES',4,'5627144069',3,32),(1206,'JOSE MARCOS LOPEZ',4,'5529368873',1,32),(1207,'JOSE MENDOZA AGUILAR',4,'5529029721',1,32),(1208,'JOSE MORALES',4,'5530350781',1,32),(1209,'JOSE RODRIGUEZ GARCIA',4,'5530758679',1,32),(1210,'JOSE SANCHEZ OLMEDO',4,'5539579624',1,32),(1211,'JOSELIN RIOS',4,'5530305299',3,32),(1212,'JOSHELIN RIOS OJEDA',4,'5530305299',1,32),(1213,'JOSUA BARRERA',4,'5549017676',1,32),(1214,'JOSUA PEREZ MARTINEZ',4,'5610897408',1,32),(1215,'JOSUE CURIEL CARDENAS HERNANDEZ',4,'5617150313',1,32),(1216,'JOSUE TOMAS',4,'5639822594',1,32),(1217,'JOVANY HERNANDEZ',4,'5611257327',3,32),(1218,'JOVANY ISLAS',4,'5572235818',1,32),(1219,'JOZMAN YORGS',4,'5541845416',1,32),(1220,'JUAN AGUSTIN PERALES RENDON',4,'5521743164',1,32),(1221,'JUAN CARLOS ALVARADO LOPEZ',4,'5626954363',1,32),(1222,'JUAN CARLOS BARRERA',4,'5620955256',1,32),(1223,'JUAN CARLOS CRUZ',4,'5534908913',1,32),(1224,'JUAN CARLOS REYES',4,'5573738460',1,32),(1225,'JUAN CARLOS ROSALES FONSECA',4,'5528195034',1,32),(1226,'JUAN HORACIO DOMINGUEZ',4,'5580561011',1,32),(1227,'JUAN ISRAEL GUTIERREZ OLVERA',4,'5564088687',1,32),(1228,'JUAN LOPEZ MARTINEZ',4,'5564714327',1,32),(1229,'JUAN MANUEL HERNANDEZ',4,'5612007759',1,32),(1230,'JUAN PABLO OLVERA',4,'5539005069',1,32),(1231,'JUAN SOTO',4,'5570787069',1,32),(1232,'JULIO ARACEN',4,'5535056609',4,32),(1233,'JULIO CESAR BARRAGAN',4,'5513374399',1,32),(1234,'JULIO CESAR CERVANTES PEREZ',4,'5510201755',1,32),(1235,'JULIO CESAR MARTINEZ',4,'5534850424',1,32),(1236,'JULIO CESAR MONDRAGON',4,'5564545139',1,32),(1237,'JULIO ENRIQUE ZEPEDA',4,'5561520336',1,32),(1238,'JULIO MARTINEZ MELCHOR',4,'5534850424',1,32),(1239,'KAREN EZQUIVEL',4,'5586767577',1,32),(1240,'KAREN JANETH BRIZUELA LOPEZ',4,'SN',1,32),(1241,'KAREN SALAZAR',4,'5547896561',1,32),(1242,'KARINA MEDINA MAYORAL',4,'5526914996',1,32),(1243,'KARLA ALEXANDRA FLORES MEJIA',4,'5539384521',1,32),(1244,'KARLA GONZALEZ  ROMERO',4,'5573184575',1,32),(1245,'KARLA HINOJOSA',4,'5532914880',1,32),(1246,'KATIA GARIBAY FONSECA',4,'5514303468',1,32),(1247,'KELLY GARCIA',4,'SN',1,32),(1248,'KEVIN ANAYA',4,'5612762138',1,32),(1249,'KEVIN RAUL MORELOS URIEL',4,'5560918962',1,32),(1250,'KEVIN SIERRA',4,'5570999910',1,32),(1251,'LEONARDO DIAZ TELLEZ',4,'5572402443',1,32),(1252,'LEONCIO HINOJOSA',4,'5523027534',1,32),(1253,'LESLI DE JESUS  SANDOVAL',4,'5518672516',3,32),(1254,'LESLY GARCIA',4,'5518855662',1,32),(1255,'LESLY PAULINA ALBA',4,'5545728377',1,32),(1256,'LEYDI ALTAMIRANO',4,'5514165065',4,32),(1257,'LEYLANI OLVERA',4,'5582902597',1,32),(1258,'LIDIA EVANGELISTA MARTINEZ',4,'5581786472',1,32),(1259,'LILI GYM',4,'5627010057',4,32),(1260,'LIZBETH CORTEZ ORTIZ',4,'5539327017',1,32),(1261,'LIZETH ROSALES',4,'5615023534',1,32),(1262,'LORENA RODRIGUEZ MALAGON',4,'5520667000',1,32),(1263,'LOURDES ACCEVO',4,'5513038775',4,32),(1264,'LUIS ADRIAN GARCIA MENDOZA',4,'5577829605',1,32),(1265,'LUIS ALBERTO HERNANDEZ GERMAN',4,'5563495983',1,32),(1266,'LUIS ALBERTO MATINEZ',4,'2281443712',1,32),(1267,'LUIS ALBERTO RODRIGUEZ CARLOS',4,'5523018836',1,32),(1268,'LUIS ALONSO ROMERO',4,'5512395801',1,32),(1269,'LUIS ANGEL VENEGAS',4,'5575347148',1,32),(1270,'LUIS ARMAMDO CEH',4,'5519907762',1,32),(1271,'LUIS ARMAMDO CEH',4,'5519907762',1,32),(1272,'LUIS CORNEJO',4,'5540253370',1,32),(1273,'LUIS ENRIQUE GONZALEZ',4,'5615151534',3,32),(1274,'LUIS FELIPE YAÑEZ',4,'5545602569',1,32),(1275,'LUIS FERNANDO ROMERO OLALDE',4,'5576847211',2,32),(1276,'LUIS JAVIER GARCIA',4,'5572944975',1,32),(1277,'LUIS JESUS PEREZ',4,'5583268111',1,32),(1278,'LUIS MANCILLA',4,'5511286431',1,32),(1279,'LUIS MANCILLA',4,'5511286431',1,32),(1280,'LUIS MANUEL CORREA',4,'5537583649',1,32),(1281,'LUIS MANUEL GUTIERREZ',4,'5516797024',1,32),(1282,'LUIS MAURICIO FRANCO CABRERA',4,'5524738089',1,32),(1283,'LUIS MERINO',4,'5630879531',1,32),(1284,'LUIS MONTES',4,'5527667653',1,32),(1285,'LUIS RAMIREZ',4,'5521805581',1,32),(1286,'LUIS REDU-FACIL',4,'5550214490',4,32),(1287,'LUIS ROBERTO',4,'5540813090',3,32),(1288,'LUIS VILLALPANDO',4,'2226511633',1,32),(1289,'LUNA POLANCO',4,'5534754999',1,32),(1290,'LUSIANO RATIA GONZALEZ',4,'5587024398',4,32),(1291,'LUZ MARIA CALVILLO',4,'5624337187',1,32),(1292,'MANUEL ALEJANDRO JAMES GRAJALES',4,'5561641140',1,32),(1293,'MANUEL RICO NEGRON',4,'5510963498',1,32),(1294,'MARCO ANTONIO ESTRADA',4,'5531921812',1,32),(1295,'MARCO ANTONIO LOPEZ CASTAÑEDA',4,'5512772024',1,32),(1296,'MARCO ANTONIO RANGEL',4,'5580490911',1,32),(1297,'MARCO BARRIOS',4,'SN',1,32),(1298,'MARCO FERNANDO FLORES',4,'5560454941',1,32),(1299,'MARCO GONZALEZ RAMIREZ',4,'5535730364',1,32),(1300,'MARCOS RODRIGO CONTRERAS JIMENEZ',4,'5548600961',4,32),(1301,'MARIA DE JESUS ALMAGUER',4,'5518562437',1,32),(1302,'MARIA DE LA LUZ MENDOZA REYES',4,'5536759163',4,32),(1303,'MARIA DE LOS ANGELES',4,'5536446904',1,32),(1304,'MARIA DE LOURDES RAMOS',4,'5561203766',1,32),(1305,'MARIA GUADALUPE CARRILLO',4,'6631564318',1,32),(1306,'MARIANA IZQUIERDO',4,'5542289619',1,32),(1307,'MARIANO OROPEZA',4,'5522928324',1,32),(1308,'MARIO ALBERTO LEON GONZALEZ',4,'5632799617',1,32),(1309,'MARIO ALBERTO NOGUEZ',4,'5531215683',1,32),(1310,'MARIO ALFREDO HERNANDEZ ROLDAN',4,'5537343039',3,32),(1311,'MARIO CISNEROS',4,'5530383311',3,32),(1312,'MARIO SANCHEZ',4,'5635370015',4,32),(1313,'MARIO SEGURIDAD PLAZA',4,'5588242054',1,32),(1314,'MARISOL HERNANDEZ DIAZ',4,'5510641942',1,32),(1315,'MARLEN SANDOVAL',4,'5534387649',1,32),(1316,'MARLENE SANDOVAL',4,'5534387649',1,32),(1317,'MARTHA GARCIA ACOSTA',4,'5552143292',1,32),(1318,'MARTIN MANJAREZ',4,'5516842058',1,32),(1319,'MARY CRUZ',4,'5538213654',1,32),(1320,'MAURICIO ALVAREZ LUNA',4,'5539236059',1,32),(1321,'MAURICIO GOMERO NOLASCO',4,'5567661138',1,32),(1322,'MAURICIO HERNANDEZ',4,'5636000545',1,32),(1323,'MAURICIO MORALES RODRIGUEZ',4,'5585767137',1,32),(1324,'MAURICIO RODRIGUEZ COARDOVA',4,'5523136537',1,32),(1325,'MAXIMILIANO CUARON',4,'5574809686',4,32),(1326,'MAYRA BERENICE GONZALEZ',4,'5548852608',1,32),(1327,'MAYRA LARA',4,'5516885856',1,32),(1328,'MAYRA SOSA   FEDERICO PALACIOS   GYM PEGASO',4,'5524953060    5547102608',4,32),(1329,'MERARI ESPINOZA',4,'5534697209',1,32),(1330,'MIGUEL ANGEL CARVAJAL MAURICIO',4,'5565038505',1,32),(1331,'MIGUEL ANGEL MONDRAGON',4,'5523181754',1,32),(1332,'MIGUEL ANGEL PEREZ MARTINEZ',4,'5526744453',1,32),(1333,'MIGUEL CARBAJAL',4,'5539718000',4,32),(1334,'MIGUEL CARVAJAL',4,'5539718009',4,32),(1335,'MIGUEL CORONA',4,'2411976217',1,32),(1336,'MIGUEL DUARTE MEDINA',4,'5619875635',4,32),(1337,'MIGUEL EDUARDO ALQUISIRAS PEÑA',4,'5545163688',1,32),(1338,'MIGUEL GOMEZ',4,'5579666127',1,32),(1339,'MIGUEL GOMEZ',4,'5579666127',1,32),(1340,'MIRIAM  ORTIZ HERNANDEZ',4,'5519397835',4,32),(1341,'MIRIAM LOPEZ SANCHEZ',4,'5572246370',1,32),(1342,'MIRIAM VARGAS',4,'5510817749',1,32),(1343,'MISAEL MATEO MILLAN',4,'5610963290',1,32),(1344,'MOISES CAMACHO CRUZ',4,'5574876916',1,32),(1345,'MONICA TOVAR',4,'5540360601',1,32),(1346,'MONSERRAT ADMINISTRACION',4,'5587701217',4,32),(1347,'MONSERRAT CELAYA',4,'5613568145',1,32),(1348,'MONSERRAT CHAVEZ',4,'5534553764',1,32),(1349,'MOSERRAT CHAVEZ',4,'5534553764',1,32),(1350,'NATALIA MENDEZ',4,'5637039229',1,32),(1351,'NEFTALI SANCHEZ',4,'5639704266',1,32),(1352,'OCTAVIO MORALES LOPEZ',4,'5611383599',1,32),(1353,'OMAR GODINEZ ESTRADA',4,'5584848064',1,32),(1354,'OMAR ROMERO',4,'5585705936',1,32),(1355,'OMAR SANCHEZ AVANTES',4,'5620768382',4,32),(1356,'ORLANDO GALINDO',4,'5636000031',1,32),(1357,'OSCAR CARDOZO',4,'SN',1,32),(1358,'OSCAR FELIX CABRERA',4,'5523866097',1,32),(1359,'OSCAR GAONA LINAREZ',4,'5561250651',1,32),(1360,'OSCAR GUTIERREZ ESCALONA',4,'5533654763',1,32),(1361,'OSCAR GYM MORENO',4,'5578563016',1,32),(1362,'OSCAR HERNANDEZ GARCIA',4,'5527754099',1,32),(1363,'OSCAR HERNANDEZ IBARRA',4,'5541796458',3,32),(1364,'OSCAR JAIMES VALLEJO',4,'5539784178',4,32),(1365,'OSCAR MARTINEZ',4,'5554778881',1,32),(1366,'OSCAR MARTINEZ ROBLEDO',4,'5549767904',1,32),(1367,'OSCAR PAREDES',4,'5544997366',1,32),(1368,'OSCAR RAMIREZ',4,'5620649215',1,32),(1369,'OSCAR REYES',4,'5627560001',1,32),(1370,'OSCAR VARGAS HERNANDEZ',4,'7298319193',4,32),(1371,'OSMAR DIEGO ARSINIEGA',4,'5620231808',1,32),(1372,'OSVALDO ALVAREZ ALTAMIRANO',4,'5554364581',1,32),(1373,'OSVALDO BALDEMAR HERNANDEZ',4,'5614279179',1,32),(1374,'OSVALDO MARTINEZ',4,'5626914849',3,32),(1375,'PABLO FRANCES',4,'5551552286',1,32),(1376,'PABLO RENE MENDOZA GONZALEZ',4,'5534665956',1,32),(1377,'PABLO RICARDO',4,'SN',1,32),(1378,'PABLO VAZQUEZ',4,'5527727714',1,32),(1379,'PATRICIA JIMENEZ HERRERA',4,'5527994704',1,32),(1380,'PATRICIA MELENDEZ',4,'5544555576',1,32),(1381,'PATRICIA SANCHEZ CRUZ',4,'5530462347',3,32),(1382,'PATRICIA VARGAS',4,'5532734622',1,32),(1383,'PATRICIO BALTAZAR REYES',4,'5512251484',1,32),(1384,'PAULINA BALDERRAMA DORANTES',4,'5519038547',1,32),(1385,'PEDRO HERNANDEZ PEREZ',4,'5518327239',3,32),(1386,'PEDRO SALVADOR ALVAREZ HDZ',4,'5518527807',1,32),(1387,'PILAR HERNANDEZ PEREZ',4,'5585770590',1,32),(1388,'POLANCO MARQUEZ LUNA',4,'5534754999',1,32),(1389,'PORFIRIO MENDEZ OCAMPO',4,'2213635785',1,32),(1390,'QUETZIN ESPINOZA',4,'5534697209',1,32),(1391,'RAFAEL CARDOZO GUERRERO',4,'5626316712',1,32),(1392,'RAFAEL FRAGOSO',4,'5567617048',1,32),(1393,'RAFAEL MOTA',4,'5567077319',1,32),(1394,'RAFAEL PEREZ',4,'5522537190',1,32),(1395,'RAFAEL ROMERO',4,'5615766324',1,32),(1396,'RAFAEL VALDEZ MONTOYA',4,'5510977827',1,32),(1397,'RAMFERI GUTIERREZ LOPEZ',4,'5566083402',1,32),(1398,'RAMSES COLIN BARRIENTOS',4,'5533234230',1,32),(1399,'RANDI SUAREZ',4,'5624099910',1,32),(1400,'RAUL SERRANO',4,'5583828620',1,32),(1401,'RAUL SOSA',4,'5549072617',1,32),(1402,'RAUL TOVAR',4,'5637268607',1,32),(1403,'RAYMUNDO ALVARADO CRUZ',4,'5514363594',1,32),(1404,'RAYMUNDO MONTIEL GARCIA',4,'5616231303',1,32),(1405,'RAYMUNDO TORRES',4,'5514552342',1,32),(1406,'RENE ORTIGOZA',4,'5548666468',1,32),(1407,'RICARDO CABRERA CRUZ',4,'5534787682',3,32),(1408,'RICARDO FLORES',4,'5561554707',1,32),(1409,'RICARDO GONZALEZ',4,'5581077417',1,32),(1410,'RICARDO GUARNEROS ARMENDARIZ',4,'5543908809',1,32),(1411,'RICARDO MARTIN HERNANDEZ',4,'55392133232',4,32),(1412,'RICARDO MELENDEZ',4,'5535166191',3,32),(1413,'RICARDO OMAR RAMIREZ',4,'5522782088',1,32),(1414,'RICARDO RAYON',4,'5566059659',1,32),(1415,'RICARDO RIOS HUERTA',4,'5545831139',1,32),(1416,'RICARDO RODRIGUEZ',4,'5613643773',1,32),(1417,'RICHARD OLVERA PATLAN',4,'5570809592',1,32),(1418,'ROBERTO BLAS GARCIA',4,'5547585059',1,32),(1419,'ROBERTO CASTRO',4,'5537260208',3,32),(1420,'ROBERTO SANCHEZ',4,'5541406253',1,32),(1421,'ROCIO CISNEROS PRUDENTE',4,'5579386642',4,32),(1422,'RODRIGO FERNANDEZ HERNANDEZ',4,'5550540854',1,32),(1423,'RODRIGO HERNANDEZ MENDEZ',4,'5571006733',4,32),(1424,'RODRIGO LOPEZ QUEZADA',4,'5617198890',1,32),(1425,'RODRIGO RIBERA GONZALEZ',4,'5531905514',1,32),(1426,'RODRIGO SOTO PONCE',4,'5549830191',1,32),(1427,'ROGELIO ANGELES',4,'5610806927',1,32),(1428,'ROMAN DE LA SERNA ORTEGA',4,'5582383449',1,32),(1429,'ROSA ABAUZA',4,'5545716706',1,32),(1430,'ROSA LINA CISNEROS',4,'5518154489',4,32),(1431,'ROSA LINDA MORENO REYES',4,'5539908067',4,32),(1432,'ROSA RIVERA LEYVA',4,'5615757084',1,32),(1433,'RUBEN ALEJANDRO VERGARA',4,'5515812769',1,32),(1434,'RUBEN VERGARA',4,'5515812769',1,32),(1435,'RUSSELL ABRAHAM OLARTE RUIZ',4,'5581266341',1,32),(1436,'SABINO MUÑOZ',4,'5548083304',1,32),(1437,'SALVADOR BUENO GARCIA',4,'5547249413',1,32),(1438,'SALVADOR BUENO GARCIA',4,'5547249413',1,32),(1439,'SALVADOR GALVAN VELAZQUEZ',4,'5566332063',1,32),(1440,'SALVADOR MALDONADO FLORES',4,'5611669140',1,32),(1441,'SAMIR TOVAR RODRIGUEZ',4,'5564673885',1,32),(1442,'SAMUEL MORALES BARRIENTOS',4,'5583055608',1,32),(1443,'SAMUEL SUAREZ MORENO',4,'5564168324',1,32),(1444,'SANDRA HERNANDEZ GALEANA',4,'5571344436',1,32),(1445,'SANDRA LARA',4,'5512322578',1,32),(1446,'SANDRA NOVELO',4,'5522999478',1,32),(1447,'SANDRA YOUSSETTE LARA',4,'5585702907',1,32),(1448,'SANTIAGO ORTEGA ROMERO',4,'5578633101',1,32),(1449,'SARAHI ARRIAGA MARTINEZ',4,'5568028569',1,32),(1450,'SATBANY ALEMAN',4,'5582999125',1,32),(1451,'SAUL HERNANDEZ',4,'5562905673',1,32),(1452,'SAUL PEREZ GURIÑO',4,'5618301138',1,32),(1453,'SEBASTIAN JIMENEZ',4,'5628308658',1,32),(1454,'SEBASTIAN SOTELO CHAVEZ',4,'5626020259',1,32),(1455,'SELENE GARCIA LOCATARIA 245',4,'5525634037',3,32),(1456,'SELINA GONZALEZ',4,'5633250838',1,32),(1457,'SERGIO CASTAÑEDA ESPINOSA',4,'5623202309',1,32),(1458,'SERGIO PEREIRA',4,'5526795815',1,32),(1459,'SERGIO RODRIGUEZ',4,'5571815186',1,32),(1460,'SERGIO SANTIAGO',4,'5632785868',1,32),(1461,'SERGIO VELAZQUEZ',4,'5540124538',3,32),(1462,'SHARON MARTINEZ',4,'5630145280',1,32),(1463,'SILVIA RODRIGUEZ',4,'SN',1,32),(1464,'STANLEY RAUL',4,'5574894160',3,32),(1465,'STIVEN GAMALIEL',4,'5531090840',1,32),(1466,'SUSANA ITZEL ROJAS VILLAFAÑA',4,'5517424922',1,32),(1467,'SUSANA MENDEZ Y WENDY MENDEZ',4,'8671928960',1,32),(1468,'TATIANA SAAVEDRA',4,'5573245118',1,32),(1469,'ULISES RAMIREZ',4,'5576641709',1,32),(1470,'ULISES RAMSES ALMONASI PEREA',4,'5526924140',1,32),(1471,'ULISES SEVERO',4,'5544608531',1,32),(1472,'URIBE QUINTANAL NUÑEZ',4,'5591931027',1,32),(1473,'URIEL LEON SALAZAR',4,'5571768677',1,32),(1474,'VALERIA MONTAÑEZ',4,'5626299668',1,32),(1475,'VERONICA BATEZ',4,'5545382450',1,32),(1476,'VERONICA VAZQUEZ',4,'5532638571',1,32),(1477,'VIANEY ACOSTA SANTOS',4,'4427915266',4,32),(1478,'VIANEY REYES',4,'5560005309',1,32),(1479,'VIANNEY ROMERO ROJAS',4,'5510823697',1,32),(1480,'VICTOR ALFONSO LEON MORA',4,'5546821432',1,32),(1481,'VICTOR ARIAS',4,'5512254681',1,32),(1482,'VICTOR GUTIERREZ CLEMENTE',4,'5548623765',1,32),(1483,'VICTOR HUEGO GONZALEZ',4,'5564199997',1,32),(1484,'VICTOR HUGO',4,'5564199997',1,32),(1485,'VICTOR JAVIER DIAZ VELAZQUEZ',4,'6121501659',1,32),(1486,'VICTOR JULIAN VALDEZ GUEVARA',4,'5521992711',1,32),(1487,'VICTOR MORAN',4,'5562179058',1,32),(1488,'VICTOR ROSAS',4,'5536593982',1,32),(1489,'WENDY RODRIGUEZ RANGEL',4,'5544534273',1,32),(1490,'YAEL ALEXIS HERNANDEZ',4,'5545609144',1,32),(1491,'YAEL RAMIREZ',4,'5582227631',1,32),(1492,'YAEL TORRES',4,'5521845180',1,32),(1493,'YAIDH ISAACK RODRIGUEZ FLORES',4,'5611685644',1,32),(1494,'YAIR LISARDI',4,'5585238930',1,32),(1495,'YAMILET',4,'7298876536',1,32),(1496,'YARICK MICHELL GARCIA',4,'5611112695',1,32),(1497,'YAZMIN HERNANDEZ ALVARADO',4,'5617463356',1,32),(1498,'YESENIA RIOS',4,'5565586076',1,32),(1499,'YESICA NADIA SALAZAR',4,'5573903863',1,32),(1500,'YOLANDA GUEVARA',4,'5523525756',1,32),(1501,'YRIDIAN ROMO',4,'5570070084',4,32),(1502,'ZARA VELAZQUEZ SERRANO',4,'5533552387',1,32),(1503,'MARINA AGUIRRE ISLAS',4,'5523930284',1,32),(1504,'JOSUE YEE',4,'5536086660',1,32),(1505,'GAEL FRAGOSO',4,'5591207823',1,32),(1506,'MIGUEL ANGEL NOGUEZ HDZ',4,'5528072804',1,32),(1507,'DANNY GARCIA FLORES',4,'5513371059',1,32),(1508,'GUSTAVO REYES',4,'5546128735',1,32),(1509,'Fernanda Hernandez Gar',7,'5521924261',1,29),(1510,'MARIANA ORIGUELA PENICHE',2,'5528844141',3,25),(1511,'SEBASTAN CANDELARA',2,'5518517799',1,25),(1512,'SERGIO ISRAEL GONZALEZ',2,'5511259858',1,25),(1513,'HAZAEL ARREOLA zeus gym',7,'5523722519',4,29),(1514,'AZAEL GONZALEZ',2,'5562226132',1,25),(1515,'CLAUDIA SOSA',2,'5517910208',1,25),(1516,'DULCE HERNANDEZ',2,'5560619633',1,25),(1517,'GERMAN PEREZ CHAVEZ',2,'5576672593',1,25),(1518,'ISELA ALEJANDRA MENDOZA',2,'5628214402',1,25),(1519,'JESUS SAMUEL ANAYA SOLIS',2,'5575047497',1,25),(1520,'KAREN',2,'5510731876',1,25),(1521,'LUIS EDUARDO POLANCO',2,'5568175105',1,25),(1522,'LUISA HAZEL BARRIENTOS ARRIAGA',2,'5549208083',1,25),(1523,'PEDRO MARTINEZ',2,'5539449340',1,25),(1524,'ROBERTO GOMEZ',2,'5567398214',1,25),(1525,'URIEL SILVA',2,'5546715472',1,25),(1526,'NURY NOHELY SANCHEZ INSTRUCTOR',2,'5545798425',4,25),(1527,'GABRIEL MEDELLIN IRON GYM',3,'SN',4,37),(1528,'ROBERTO VILLANUEVA',4,'5514300514',4,32),(1529,'CARLOS ALEJANDRO VELAZQUEZ GALARZA',7,'5522706445',4,29),(1530,'HUGO ALDAIR MORENO VELASQUEZ',3,'5624699660',4,37),(1531,'FERNANDO JUAREZ',2,'SN',4,25),(1532,'URIEL CALDERON MORALES',2,'5520423837',4,25),(1533,'RICARDO CASAS VARTIERRA',2,'5547663504',3,25),(1534,'CARMEN GYM MANANTIALES',3,'5527626073',4,37),(1535,'JUAN CARLOS ZUÑIGA',2,'SN',4,25),(1536,'ismael salgedo gym cubil felino',7,'5522550197',4,29),(1537,'Keily Najera',7,'5580368304',1,29),(1538,'SURI MONTES',7,'5563711454',1,29),(1539,'RICHARD ONOFRE VENEZ',7,'5618228685',1,29),(1540,'AARON ALEXEI NEGRETE',7,'5525622732',1,29),(1541,'AARON ESPINOSA',7,'5611877936',1,29),(1542,'AARON PALOMINO',7,'SN',1,29),(1543,'ABEL LEOBARDO RODRIGUEZ REYES',7,'5536466460',1,29),(1544,'ABEL MONROY',7,'5587607341',1,29),(1545,'ABELARDO RUIZ',7,'5624320183',1,29),(1546,'ABRAHAM ALDECO',7,'7222520285',1,29),(1547,'ABRAHAM ARMENDARIZ SANTIAGO',7,'5623356693',1,29),(1548,'ABRAHAM VALVUENA',7,'5578457735',1,29),(1549,'ADÁN COPADO TAPIA',7,'5538478027',1,29),(1550,'ADOLFO FLORES',7,'SN',1,29),(1551,'ADRIAN ARELLANES',7,'5561620361',1,29),(1552,'ADRIAN HERRERA',7,'SN',1,29),(1553,'ADRIAN ORTIZ SALAZAR',7,'5513314652',1,29),(1554,'ADRIAN PALMA',7,'5513771047',1,29),(1555,'ADRIANA AGUILAR RODRÍGUEZ',7,'5582453826',1,29),(1556,'ADRIANA CARDONA',7,'5531082978',1,29),(1557,'AGUSTIN GARCIA',7,'5617184987',1,29),(1558,'AGUSTIN ZAVALA',7,'5522855244',1,29),(1559,'ALAN ÁVILA',7,'5545631703',1,29),(1560,'ALAN COLIN REYES',7,'5614400350',1,29),(1561,'ALAN FONSECA',7,'5575426098',1,29),(1562,'ALAN JESUS MORALES',7,'5568979884',1,29),(1563,'ALAN MANRTINEZ',7,'5586988057',1,29),(1564,'ALAN MERECIAS',7,'5539542967',1,29),(1565,'ALAN MICHELL REYES',7,'5569614923',1,29),(1566,'ALAN RAMIREZ',7,'5618949239',1,29),(1567,'ALAN ROSALES',7,'SN',1,29),(1568,'ALBERTO BECERRA',7,'5635349235',1,29),(1569,'ALBERTO DE JESUS',7,'5625532220',1,29),(1570,'ALBERTO DOMINGUEZ',7,'5554015092',3,29),(1571,'ALBERTO ESCOBAR',7,'5662957662',1,29),(1572,'ALBERTO ESCOBAR',7,'5562957662',1,29),(1573,'ALBERTO HERNANDEZ',7,'5549592002',1,29),(1574,'Alejandra Amalia Evangelista',7,'5567069091',1,29),(1575,'ALEJANDRA PEDROZA',7,'5612589024',1,29),(1576,'ALEJANDRO AGUILAR',7,'5523748159',1,29),(1577,'ALEJANDRO COLUNGA',7,'5545145827',4,29),(1578,'ALEJANDRO FUENTES',7,'5624406677',1,29),(1579,'ALEJANDRO GARCIA',7,'5552527861',1,29),(1580,'alejandro gomez',7,'5534289839',1,29),(1581,'ALEJANDRO GONZÁLES SALGADO',7,'5531889750',1,29),(1582,'ALEJANDRO JACOBO',7,'SN',1,29),(1583,'ALEJANDRO LARA',7,'5521413241',1,29),(1584,'ALEJANDRO LEON',7,'5521078068',1,29),(1585,'Alejandro Marin',7,'5511919917',1,29),(1586,'ALEJANDRO MONTALVO',7,'SN',1,29),(1587,'ALEJANDRO NEVER GYM',7,'SN',4,29),(1588,'ALEJANDRO PÉREZ',7,'5530125825',1,29),(1589,'ALEJANDRO QUINTERO',7,'5564467354',1,29),(1590,'Alejandro Reyes',7,'5585109572',1,29),(1591,'ALEJANDRO SANCHEZ',7,'5543695440',1,29),(1592,'ALEJANDRO VILLALOBOS',7,'5635017598',1,29),(1593,'ALEX CASTILLA',7,'5512789704',4,29),(1594,'ALEXANDRA EXIGA',7,'5583829767',1,29),(1595,'ALEXIA SEGURA MARTINEZ',7,'SN',1,29),(1596,'ALEXIS SANTIAGO',7,'9712069435',1,29),(1597,'ALEXIS TREJO',7,'5588090819',1,29),(1598,'ALFONSO RODRIGUEZ',7,'5545877270',1,29),(1599,'ALFREDO AKE',7,'5549224304',1,29),(1600,'ALFREDO MONTES',7,'5531106248',1,29),(1601,'ALHISTER TORRES',7,'5512402398',4,29),(1602,'ALICIA MARTÍNEZ',7,'5578164170',1,29),(1603,'ALLAN FRANCO ENERGYM GYM',7,'5540014000',4,29),(1604,'ALMA GUZMAN AGUILAR',7,'5525748307',1,29),(1605,'ALMA HERNANDEZ',7,'5542890554',1,29),(1606,'ALMA PLIEGO',7,'5539009087',1,29),(1607,'ALONSO HERNANDEZ',7,'5538890021',1,29),(1608,'ALONSO MARIANO CRUZ',7,'5620449287',1,29),(1609,'ALVARO ROSAS',7,'5521029343',1,29),(1610,'AMAIRANI HERNANDEZ',7,'5577116288',1,29),(1611,'ANA GABRIELA HERRERA',7,'555516229713',1,29),(1612,'ANA GRANADOS',7,'5527079307',1,29),(1613,'ANA LAURA JIMENEZ SÁNCHEZ',7,'5519644450',1,29),(1614,'ANA PATRICIA',7,'5516965079',1,29),(1615,'ANAHI',7,'5544211813',1,29),(1616,'ANAY FLORES',7,'7352876730',1,29),(1617,'ANDREA MARTINEZ VAZQUES',7,'5523335329',1,29),(1618,'ANDRES CASTILLO MARTINEZ',7,'5527705351',1,29),(1619,'ANDRES EMILIO',7,'5549043193',1,29),(1620,'ANDRES ETZANA',7,'5580584037',1,29),(1621,'ANDRES GRIMALDO',7,'5565767680',3,29),(1622,'ANDRES JIMENEZ',7,'5559077948',1,29),(1623,'ANDRES TOVAR',7,'5523635251',1,29),(1624,'ANEL GUTIERREZ',7,'5554337138',1,29),(1625,'ANGEL CASTUL',7,'7471419485',1,29),(1626,'ANGEL DAVID',7,'5528689386',1,29),(1627,'ÁNGEL GÓMEZ',7,'5524714218',1,29),(1628,'ANGEL JIMENEZ',7,'5636031579',1,29),(1629,'ANGEL JIMENEZ BARRIOS',7,'5614291013',1,29),(1630,'ANGEL LOBATO QUINTANA',7,'5580664680',1,29),(1631,'ANGEL MANUEL',7,'7471419485',1,29),(1632,'ANGEL MARTINEZ',7,'5565573322',1,29),(1633,'ÁNGEL OLIVOS',7,'5537344755',4,29),(1634,'ÁNGEL PÉREZ',7,'5624147416',1,29),(1635,'ANGEL REGRA',7,'5566406676',1,29),(1636,'ANGEL RIVERA',7,'5538827845',1,29),(1637,'Angel Roldan',7,'5547794057',1,29),(1638,'ÁNGEL TENA',7,'5516235406',1,29),(1639,'ANGELES NAVARRETE',7,'5534807005',1,29),(1640,'ANGELICA ESTRADA',7,'5580386677',1,29),(1641,'ANGELICA JARAMILLO',7,'5516255872',1,29),(1642,'ANGELICA ORTIZ MACHORRO',7,'5525081144',1,29),(1643,'ANNA GRANADOS',7,'5513658443',4,29),(1644,'ANTONIA CAMPOS PEREZ',7,'5528175421',1,29),(1645,'ANTONIO FRANCO',7,'2213493371',1,29),(1646,'ANTONIO MENDOZA',7,'2461112729',1,29),(1647,'ANTONIO PACHUCA',7,'5527011376',1,29),(1648,'ANTONIO ROJAS',7,'5638107164',1,29),(1649,'ANTONIO ZALDIVAR',7,'5516098985',1,29),(1650,'ANUAR ARRIAGA',7,'5545713731',1,29),(1651,'ANXEL LIAM  JOKER GYM',7,'5540548122',4,29),(1652,'APOLINAR POLITO',7,'5544667141',1,29),(1653,'ARACELI MENDEZ TREJO',7,'5513916831',1,29),(1654,'ARAM GALLARDO',7,'5634735421',1,29),(1655,'ARES GALLEGOS',7,'5548365372',1,29),(1656,'ARLET SEGUNDO',7,'5617983761',1,29),(1657,'ARMANDO FLORES',7,'5611688703',1,29),(1658,'ARMANDO GONZALEZ',7,'5521856425',1,29),(1659,'ARMANDO MORQUECHO',7,'5566135194',1,29),(1660,'ARMANDO OLIVAR',7,'5524313489',1,29),(1661,'ARMANDO RIOS',7,'5624412598',1,29),(1662,'ARTEMIO TEJEDA',7,'9515691677',1,29),(1663,'ARTEMIO ZEPEDA',7,'5564137124',1,29),(1664,'ARTURO AUREOLES',7,'5585814164',1,29),(1665,'ARTURO BARRUETA',7,'5584499194',1,29),(1666,'ARTURO GALAN',7,'5521069521',1,29),(1667,'ARTURO RAUL',7,'5529188626',1,29),(1668,'AUDELIA RIOS GYM BLACK POWER',7,'SN',4,29),(1669,'AUGUSTO ANGEL',7,'7298596324',1,29),(1670,'Aurelia Vazquez',7,'5540046294',1,29),(1671,'AURELIO MARTÍNEZ RODRÍGUEZ',7,'5537219302',1,29),(1672,'AXEL SAAVEDRA',7,'5524645342',1,29),(1673,'AXEL SAVREDA',7,'5626174594',1,29),(1674,'AZAEL MEJIA',7,'5613814846',1,29),(1675,'Betsabe Fernandez',7,'SN',1,29),(1676,'BRANDO OMAR',7,'5547874801',1,29),(1677,'BRANDON GUTIERREZ',7,'5517005204',1,29),(1678,'BRANDON UBIAS',7,'5621255766',1,29),(1679,'BRAULIO ZUÑIGA',7,'5635577635',1,29),(1680,'Brayan Cruz',7,'5564400738',1,29),(1681,'BRENDA NUÑEZ',7,'5514759349',1,29),(1682,'BRENDA PIÑA',7,'5536757893',1,29),(1683,'BRENDA RUBYD',7,'5537054728',1,29),(1684,'BRIAN URBINA',7,'5523304220',1,29),(1685,'Briceida Olivos',7,'5580600896',1,29),(1686,'BRUNO AVILA',7,'5535659857',1,29),(1687,'BRYAN GALLARDO DE LA CRUZ',7,'5618614077',1,29),(1688,'BRYANT REYES',7,'7298911812',1,29),(1689,'BYBY YALIS',7,'7221692272',1,29),(1690,'CARLOS ALBERTO',7,'5613975149',1,29),(1691,'CARLOS ALBERTO',7,'5513077513',1,29),(1692,'CARLOS ALVARADO',7,'5530868525',1,29),(1693,'Carlos Castillo',7,'5548021257',1,29),(1694,'CARLOS FLORES',7,'SN',1,29),(1695,'CARLOS MANUEL',7,'5533400187',1,29),(1696,'CARLOS OMAR',7,'5562311405',1,29),(1697,'CARLOS PEREA',7,'5518096621',1,29),(1698,'CARLOS URIEL',7,'19516424980',1,29),(1699,'CARMEN ÁVILA',7,'5561674889',1,29),(1700,'CARMEN MONRROY',7,'5545112963',1,29),(1701,'CAROLINA',7,'5634434292',1,29),(1702,'CESAR ABRAHAM SUAREZ CHAMETLA',7,'5519813015',1,29),(1703,'CESAR AUGUSTO SANTIZ',7,'5581276578',3,29),(1704,'CÉSAR CAMACHO',7,'5521758310',1,29),(1705,'CESAR DE LA CRUZ',7,'5616058852',1,29),(1706,'CESAR EDUARDO',7,'5578026316',1,29),(1707,'CESAR FABIAN',7,'5522446912',1,29),(1708,'CHARBEL BAROLA',7,'5513523423',1,29),(1709,'CHRISTIAN JAVIER',7,'5627254136',4,29),(1710,'CHRISTIAN MARTINEZ',7,'5610237401',1,29),(1711,'CHRISTOPHER DAVID GÓMEZ MANCILLA',7,'4441910175',1,29),(1712,'CITLALI RODRIGUEZ HERNANDEZ',7,'5542442111',1,29),(1713,'CLAUDIA GARCIA',7,'5579082213',1,29),(1714,'Claudia Rubi Medina',7,'6674289539',1,29),(1715,'CLAUDIO SANTIAGO',7,'5573830440',1,29),(1716,'CRIATIAN CARRILLO',7,'5646525198',1,29),(1717,'CRISTIAN CARRILLO SOTELO',7,'5591990212',1,29),(1718,'CRISTIAN FORTIS',7,'5533322870',3,29),(1719,'CRISTIAN JACOBO',7,'SN',1,29),(1720,'CRISTIAN ORTEGA',7,'SN',3,29),(1721,'CRISTIAN RAMIREZ',7,'5510614095',1,29),(1722,'Cristian Torres Romero',7,'5621996644',1,29),(1723,'CRISTIAN URIEL JACOBO',7,'5579884598',1,29),(1724,'CRISTINA FONSECA',7,'SN',1,29),(1725,'cristina villa gomez',7,'553225936',1,29),(1726,'CRUZ MARTINEZ',7,'5541393934',4,29),(1727,'DAFNE MARIEL',7,'5528498433',1,29),(1728,'DAMIAN MIRANDA',7,'5588043544',1,29),(1729,'DAMIAN ORTEGA',7,'5571912799',1,29),(1730,'DANIEL ALBERTO MICTLAN GYM',7,'5523016967',4,29),(1731,'DANIEL BECERRIL',7,'5624006224',1,29),(1732,'DANIEL ESTRADA',7,'9512389190',1,29),(1733,'DANIEL GARCIA',7,'5574514813',1,29),(1734,'DANIEL HERNANDEZ',7,'5547995328',1,29),(1735,'DANIEL INSTRUCTOR NAUCALPAN',7,'5549445531',4,29),(1736,'DANIEL SANCHEZ',7,'5530737366',1,29),(1737,'DANIEL VALLE',7,'5580318788',1,29),(1738,'DANIELA VARAS',7,'5588357806',1,29),(1739,'DANIELA VARELA',7,'5580325365',1,29),(1740,'DANIELA VARELA',7,'5580325365',1,29),(1741,'DANNA CASTELAN',7,'5591654394',3,29),(1742,'DANNY GARCIA HUERTA',7,'5522763487',1,29),(1743,'DAVID ANGEL',7,'5554184395',1,29),(1744,'DAVID DE LA CRUZ',7,'5516029329',1,29),(1745,'David Galvez',7,'4424396948',1,29),(1746,'DAVID MENDOZA',7,'5635363092',1,29),(1747,'DAVID NAVARRO',7,'5532964566',1,29),(1748,'DAVID PERALTA',7,'5583230098',1,29),(1749,'DAVID QUIROZ',7,'5616932069',1,29),(1750,'DAVID RAMÍREZ OBREGÓN',7,'5579040012',1,29),(1751,'DAVID RODRIGUEZ',7,'5639965997',1,29),(1752,'Diana Bernal',7,'5580312827',1,29),(1753,'Diana Dorantes',7,'5544489899',1,29),(1754,'DIANA DORANTES',7,'5544489899',1,29),(1755,'DIANA ESTRADA',7,'5575038826',1,29),(1756,'Diana Laura Sanchez',7,'5566295577',1,29),(1757,'DIANA VENCES',7,'5551057791',1,29),(1758,'DIANA YAMILET',7,'5578103255',1,29),(1759,'DIEGO ALVAREZ',7,'5587064190',1,29),(1760,'Diego Barrera',7,'5540638412',1,29),(1761,'DIEGO COLIN',7,'5544776176',1,29),(1762,'DIEGO FERNANDO',7,'5561667281',1,29),(1763,'DIEGO JESUS CORONA',7,'5549118398',1,29),(1764,'Diego Leal',7,'5611275460',1,29),(1765,'DIEGO RAFAEL RODRIGUEZ',7,'7228741153',1,29),(1766,'DIEGO VARGAS',7,'5561667351',1,29),(1767,'DIEGO ZARCO',7,'5534165643',1,29),(1768,'DIETER MONTALVO',7,'5520098273',4,29),(1769,'DMITRI MORKHIREV',7,'4428351011',1,29),(1770,'DMITRY MOKHIREV',7,'524428351011',1,29),(1771,'DONOVAN NAVARRO',7,'5528745282',3,29),(1772,'DULCE IVONN PEREZ',7,'5576902559',1,29),(1773,'Dulce Maria Martin',7,'5573686084',1,29),(1774,'EDGAR ALEJANDRO MORA',7,'3320528053',1,29),(1775,'EDGAR ANTONIO',7,'2461485289',1,29),(1776,'EDGAR ARIEL',7,'5621099280',1,29),(1777,'EDGAR BERBER',7,'5612820005',1,29),(1778,'EDGAR DANIEL',7,'SN',1,29),(1779,'EDGAR EDUARDO',7,'5617147603',1,29),(1780,'EDGAR ESTUDILLO',7,'5621437944',1,29),(1781,'EDGAR ESTUDILLO',7,'5621437944',1,29),(1782,'EDGAR SALIAS',7,'5581939373',1,29),(1783,'EDGAR SANCHEZ',7,'5527036954',1,29),(1784,'EDGAR SÁNCHEZ',7,'5544909157',1,29),(1785,'EDGAR SUAREZ BODY GYM',7,'SN',4,29),(1786,'EDGAR ZAMORA',7,'56272388959',1,29),(1787,'EDUARDO ALTAMIRANO',7,'9541005273',1,29),(1788,'Eduardo Bernal',7,'5510595130',1,29),(1789,'EDUARDO DIAZ',7,'5584151568',1,29),(1790,'EDUARDO GONZALEZ',7,'5633753991',1,29),(1791,'EDUARDO LEON',7,'5623931755',1,29),(1792,'EDUARDO MARTINEZ',7,'5527274212',1,29),(1793,'EDUARDO MUÑOZ',7,'5545112700',1,29),(1794,'EDUARDO SOTO',7,'5527544194',1,29),(1795,'EDUARDO TOVAR',7,'5611886235',4,29),(1796,'EDWIN RAMSES',7,'5525722407',1,29),(1797,'EDY TRINIDAD',7,'5559633344',1,29),(1798,'ELISEO ALVAREZ',7,'5614436227',4,29),(1799,'ELIUD DIAZ SAENZ',7,'5544591893',4,29),(1800,'ELIZABETH CARMONA',7,'5539749989',1,29),(1801,'ELIZABETH DE LA TORRE',7,'5517025885',1,29),(1802,'ELIZABETH GAZPAR GARCIA',7,'5562186901',1,29),(1803,'ELOISA RUIZ',7,'5530242596',1,29),(1804,'Emanuel Rodriguez',7,'5539006267',1,29),(1805,'EMILIO LOPEZ',7,'4623249221',1,29),(1806,'EMMANUEL',7,'5531005988',1,29),(1807,'EMMANUEL GARCIA',7,'5564716761',1,29),(1808,'EMMANUEL ROJAS',7,'5532873451',1,29),(1809,'ENRIQUE DANIEL',7,'5548658425',1,29),(1810,'ENRIQUE GERICKO',7,'5591225644',1,29),(1811,'Enrique Gomez Hernandez',7,'5516788720',4,29),(1812,'ENRIQUE GONZALEZ',7,'5531983096',1,29),(1813,'ENRIQUE MARTÍNEZ',7,'5591019086',1,29),(1814,'ENRIQUE PINEDA',7,'5552888188',1,29),(1815,'ERIC GONZÁLEZ',7,'5540649802',1,29),(1816,'ERICA MARTÍNEZ',7,'5525335970',1,29),(1817,'ERICK ARMANDO ROBLEDO',7,'5653876890',1,29),(1818,'Erick Brian Castro',7,'5580660304',1,29),(1819,'ERICK EDUARDO RODRIGUEZ ALCANTARA',7,'5617642341',1,29),(1820,'ERICK ESCOBAR',7,'5626341028    5524173469',1,29),(1821,'ERICK FERIA HEREDIA',7,'5517277421',4,29),(1822,'ERICK FONSECA',7,'5575462883',1,29),(1823,'ERICK KENEL',7,'5538287364',1,29),(1824,'ERICK NUÑEZ',7,'SN',1,29),(1825,'Erick Ramirez',7,'5522120936',1,29),(1826,'ERICK ROJAS',7,'SN',3,29),(1827,'ERICK SANTIAGO',7,'7292249312',1,29),(1828,'ERICK TEJADA VILCHIS',7,'5548982938',1,29),(1829,'ERICK XAVIER MORENO RUIZ',7,'SN',1,29),(1830,'ERICK YAEL',7,'5547194755',1,29),(1831,'ERICKA BARRIOS',7,'5611807379',1,29),(1832,'ERICKA JUAREZ',7,'5567486173',4,29),(1833,'ERICKA MARGARITA',7,'5561024457',1,29),(1834,'ERIK RODRIGUEZ',7,'5640008200',1,29),(1835,'ERIK VAZQUEZ',7,'7773711061',1,29),(1836,'ERIKA BAUTISTA',7,'5526708934',1,29),(1837,'ERIKA MAGAÑA',7,'5525313130',1,29),(1838,'ERIKA MARTINEZ',7,'5521141457',1,29),(1839,'ERIKA SALGADO',7,'5569819144',1,29),(1840,'ERNESTO ISLAS',7,'5534808055',1,29),(1841,'ERNESTO LIMA',7,'5547681317',1,29),(1842,'ESMERALDA ALEY',7,'5634565272',1,29),(1843,'ESMERALDA HERNÁNDEZ',7,'5620526660',1,29),(1844,'ESTEBAN AARON ESPARZA',7,'3320841609',1,29),(1845,'ESTEBAN VILLAGRAN',7,'56325751',1,29),(1846,'ESTEFANI CHAVEZ',7,'5543084029',1,29),(1847,'ESTEFANIA MARTINEZ',7,'SN',1,29),(1848,'EUGENIA MARTINEZ',7,'5549261401',1,29),(1849,'EVELIA SURIANO',7,'5516392231',1,29),(1850,'EVELYN RAPOSO',7,'5534938915',1,29),(1851,'EZEQUIEL CRUZ',7,'5543384044',1,29),(1852,'EZEQUIEL LLANOS',7,'5577989299',1,29),(1853,'FABIAN VALENCIA',7,'5566080887',1,29),(1854,'FABIARCHE JAVIER',7,'5619883258',1,29),(1855,'FÁTIMA ARIAS',7,'5579935894',1,29),(1856,'FEDERICO GAYOL',7,'5559522358',1,29),(1857,'FELIPE DOMINGUEZ',7,'5632509925',1,29),(1858,'FELIPE HERNANDEZ',7,'5518607387',1,29),(1859,'FELIPE JIMENEZ',7,'5566278049',1,29),(1860,'FELIZ LOPEZ',7,'5617904010',1,29),(1861,'FER TORRES',7,'5615160441',1,29),(1862,'FERNANDA CRUZ LOPEZ',7,'5511609249',1,29),(1863,'FERNANDA ISABEL',7,'5581933348',1,29),(1864,'Fernanda Martinez',7,'5529624373',1,29),(1865,'FERNANDA PEREZ',7,'56370290093',1,29),(1866,'FERNANDO ANGEL ALVAREZ',7,'9512762820',1,29),(1867,'FERNANDO BARRIOS',7,'5537218032',1,29),(1868,'FERNANDO MONTIEL',7,'5540528092',1,29),(1869,'FERNANDO MORALES',7,'5525416655',1,29),(1870,'FERNANDO TOVAR',7,'5530232302',1,29),(1871,'FERNANDO VWEGA',7,'5545204108',1,29),(1872,'FERNANDO ZARAGOZA',7,'7222695707',4,29),(1873,'FRANCISCO GARCIA',7,'5527537796',1,29),(1874,'FRANCISCO JAVIER',7,'9621435085',1,29),(1875,'FRANCISCO JAVIER ESTRADA',7,'5560751040',1,29),(1876,'FRANCISCO MARTINEZ',7,'SN',4,29),(1877,'FRANCISCO REYES',7,'5554724383',3,29),(1878,'FRANCISCO SOTO',7,'5614022003',1,29),(1879,'FREDY MARTINEZ',7,'5521022559',1,29),(1880,'FRIDA MARTINEZ',7,'5561622870',1,29),(1881,'FROYLAN FUENTES',7,'5528792175',1,29),(1882,'GABRIEL ALCALA',7,'5529677595',1,29),(1883,'GABRIEL ANTONIO CONTRERAS',7,'3122193319',1,29),(1884,'GABRIEL CAMPOS',7,'5615318824',1,29),(1885,'GABRIEL ESPINOZA',7,'2299007612',1,29),(1886,'GABRIEL GONZALES',7,'6391197961',1,29),(1887,'Gabriel Torres',7,'5580044864',1,29),(1888,'GABRIELA GERARO',7,'5634497366',1,29),(1889,'GAEL MONTALVO',7,'5546363362',1,29),(1890,'GAUDENCIO GARATACHIA',7,'5513876776',1,29),(1891,'GEOVANI GUTIERREZ',7,'5530277777',1,29),(1892,'GERARDO',7,'5611500761',1,29),(1893,'GERARDO BAUTISTA',7,'SN',1,29),(1894,'Gerardo Domingo',7,'5559062972',1,29),(1895,'Gerardo Jacobo',7,'5543954776',1,29),(1896,'GERARDO MARTINEZ ZAMORA',7,'5630138668',1,29),(1897,'GERARDO ROJAS GALINDO',7,'5611321724',1,29),(1898,'Giovani Guzman',7,'SN',1,29),(1899,'GREGORIO EMANUEL TOVAR',7,'5545955202',1,29),(1900,'GUADALUPE CABALLERO',7,'5562317671',1,29),(1901,'GUADALUPE CARREON',7,'5580043718',1,29),(1902,'GUADALUPE CERON',7,'5576630714',1,29),(1903,'GUILLERMO DEGANTE',7,'5518555800',1,29),(1904,'Guillermo Mondragon',7,'5545779312',1,29),(1905,'GUILLERMO ROMAN SANCHEZ',7,'5534177850',1,29),(1906,'GUILLERMO SANCHEZ',7,'5586183968',1,29),(1907,'GUILLERMO TOMÁS',7,'5523503682',1,29),(1908,'GUIOVANNI DIAZ',7,'5567749788',1,29),(1909,'GUSTABO ADOLFO',7,'5537048517',1,29),(1910,'GUSTABO ANTONIO',7,'5540544240',1,29),(1911,'GUSTABO VILLEGAS',7,'5522811902',1,29),(1912,'GUSTAVO LAGUNAS',7,'5585068212',1,29),(1913,'GUSTAVO NOE AVENDAÑO',7,'5584700942',1,29),(1914,'Haidee Espitia Figueroa',7,'5583659637',1,29),(1915,'HAZEL TELLEZ',7,'5611070882',1,29),(1916,'HECTOR LOPEZ',7,'5616043237',1,29),(1917,'HECTOR MARTINEZ',7,'5534866698',1,29),(1918,'HECTOR TRIGUEROS',7,'5548787592',1,29),(1919,'HERIBERTO CARRILLO',7,'6521057820',1,29),(1920,'HIRAM CRUZ CAMARILLO',7,'5535595549',1,29),(1921,'HIRAM MACÍAS GARZÓN',7,'5532733247',1,29),(1922,'HUGO ALBERTO GASPAR MIGUEL',7,'5526929870',1,29),(1923,'HUGO MARTINEZ',7,'5518337311',1,29),(1924,'HUGO TELLEZ',7,'5567038396',1,29),(1925,'HUMBERTO VIILLEGAS RAMIREZ',7,'5513373987',1,29),(1926,'HUMBERTO VILLEGAS',7,'5513373987',4,29),(1927,'IGNACIO AARON',7,'5519828371',1,29),(1928,'IGNACIO BOLAÑOS',7,'5533336286',1,29),(1929,'IRAD BATIZ',7,'2321183199',1,29),(1930,'IRAM ALVAREZ',7,'5584811839',1,29),(1931,'IRENE SANCHEZ',7,'5525174814',1,29),(1932,'IRVIN SANCHEZ',7,'5531749125',1,29),(1933,'IRVING MARTÍNEZ',7,'5520659368',1,29),(1934,'IRVING RAUL MARENTES ACEVES',7,'5565579651',1,29),(1935,'ISAAC ARREGOITIA',7,'5586841229',1,29),(1936,'ISAAC CALDERON',7,'5513636725',1,29),(1937,'ISABEL GONZÁLES',7,'5529120654',1,29),(1938,'ISABEL GONZÁLES',7,'5529120654',1,29),(1939,'ISAC MENA FLORES',7,'5521841673',1,29),(1940,'ISAI COLCHADO',7,'5575689253',1,29),(1941,'ISMAEL CASTELAN RAMIREZ',7,'SN',1,29),(1942,'ISMAEL HERNADEZ',7,'5529384986',1,29),(1943,'Ismael Santiago',7,'5583835864',1,29),(1944,'ISRAEL BARAJAS',7,'5620840349',1,29),(1945,'ISRAEL GOMEZ',7,'5544532752',1,29),(1946,'ISRAEL MARTINEZ',7,'5614128207',1,29),(1947,'ISRAEL OLAYO',7,'5525612608',1,29),(1948,'Israel Severiano',7,'5567877696',1,29),(1949,'ISRAEL VEGA GYM PALO SOLO',7,'5611654011',4,29),(1950,'ITZEL VILLAREAL',7,'SN',1,29),(1951,'ivan chavez',7,'5513055173',3,29),(1952,'IVAN GARDUÑO',7,'5517049756',1,29),(1953,'IVAN HERNANDEZ',7,'5539964036',1,29),(1954,'IVAN NOE',7,'9871060274',1,29),(1955,'IVAN NOVA',7,'5551918716',1,29),(1956,'IVAN SANCHEZ',7,'SN',1,29),(1957,'IVAN SANCHEZ HERRERA',7,'5548511603',1,29),(1958,'IVON GONSALEZ',7,'5569028228',1,29),(1959,'IVONNE VIDAL',7,'5626458327',1,29),(1960,'JAIR EMMANUEL BALTAZAR JIMENEZ',7,'5575162246',1,29),(1961,'JAIR ROCHA',7,'5537190861',1,29),(1962,'JAIRO SALVADOR',7,'8781216548',1,29),(1963,'JAQUELIN MONRROY',7,'5624168130',1,29),(1964,'JAQUELINE GARCIA ORTIZ',7,'5627415778',1,29),(1965,'JAQUELINE PORTILLO',7,'5539958908',1,29),(1966,'JARED AGUILAR',7,'5532697318',1,29),(1967,'JAVIER ANTONIO ROSALES',7,'SN',1,29),(1968,'JAVIER AREVALO',7,'5521172141',4,29),(1969,'JAVIER CERVANTES',7,'SN',1,29),(1970,'JAVIER DANIEL LUCAS ESPINO',7,'5554055965',1,29),(1971,'JAVIER GARCIA',7,'7421196668',1,29),(1972,'JAVIER GONZALEZ',7,'5585937555',1,29),(1973,'JAVIER PEREZ',7,'5510165662',1,29),(1974,'JAVIER PUÑOSDE ACERO',7,'5536684871',1,29),(1975,'JAVIER SANCHEZ AGUILAR',7,'5548107795',4,29),(1976,'JAYR ADRIAN',7,'5522023909',1,29),(1977,'JEANETH CERVANTES',7,'5521429539',1,29),(1978,'JEFFERSON RAMIREZ MARTÍNEZ',7,'3421087570',1,29),(1979,'JESSICA ARANZA',7,'5564069847',1,29),(1980,'JESSICA BERNAL',7,'5591191656',1,29),(1981,'JESSICA ELIAS',7,'SN',1,29),(1982,'JESSICA GARCIA',7,'5611099531',1,29),(1983,'JESSICA IVETTE',7,'7443128559',1,29),(1984,'JESSICA MONDRAGON',7,'5631027032',1,29),(1985,'JESUS ALBERTO',7,'5532515012',1,29),(1986,'JESÚS ALBERTO TORRES AGUILAR',7,'5561010798',1,29),(1987,'Jesus Arath Padilla',7,'7443259827',1,29),(1988,'JESUS CAMACHO',7,'5536641158',1,29),(1989,'JESUS CAMACHO',7,'5536641158',1,29),(1990,'JESÚS CARRILLO',7,'5618280270',1,29),(1991,'JESUS CORREA',7,'5535040840',1,29),(1992,'JESUS EDGAR',7,'5567920704',1,29),(1993,'JESÚS GONZALEZ',7,'5586922484',1,29),(1994,'JESUS GUZMAN (INST)',7,'5511472192',1,29),(1995,'JESUS IBARRA',7,'5582639638',1,29),(1996,'JESUS MARINO',7,'5520078670',1,29),(1997,'JESUS MUNGUIA',7,'5525528828',1,29),(1998,'JESUS OVIEDO',7,'5646411058',1,29),(1999,'JESUS SANTIAGO',7,'5519551597',1,29),(2000,'JESUS SANTIAGO',7,'5619551597',1,29),(2001,'JESUS ZAVALA',7,'5513327253',3,29),(2002,'JEZER OHAD GARCIA',7,'5545328640',1,29),(2003,'JOAQUIN MALDONADO',7,'5533564117',1,29),(2004,'JOEL CAMPOS',7,'5563545286',1,29),(2005,'JOEL COSI-CAHUALLA',7,'9581870209',1,29),(2006,'Joel Gomez',7,'5618297158',1,29),(2007,'JONATAN SANTIAGO',7,'5564894212',1,29),(2008,'JONATHAN AGUILAR',7,'5577836372',1,29),(2009,'JONATHAN CONTRERAS',7,'5534067709',1,29),(2010,'JONATHAN DUARTE',7,'5610177633',1,29),(2011,'JONATHAN GARCIA',7,'5612905068',1,29),(2012,'JORDAN CRUZ',7,'5573527503',1,29),(2013,'Jorge Antonio Perez',7,'5561099309',1,29),(2014,'JORGE FIGUEROA',7,'5621580341',1,29),(2015,'JORGE GARCÍA HERNÁNDEZ',7,'5621402507',1,29),(2016,'JORGE GUIJOSA',7,'5578437307',1,29),(2017,'JORGE LARA',7,'5520187277',1,29),(2018,'JORGE LARA',7,'5638199274',1,29),(2019,'JORGE LOEZA ARCEO',7,'5553761483',1,29),(2020,'Jorge Luz',7,'5513850365',4,29),(2021,'JORGE MANUEL',7,'5518869978',1,29),(2022,'Jorge Moreno Rodriguez',7,'5560707393',1,29),(2023,'JORGE NAVARRETE PARRAS',7,'5511592768',1,29),(2024,'JORGE RICARDO',7,'5577873052',1,29),(2025,'JORGE SANCHEZ',7,'5532939166',1,29),(2026,'JORGE SANTANA',7,'5522417746',1,29),(2027,'JORGE URIEL',7,'5547533437',1,29),(2028,'JOSE ALBERTO',7,'5621259563',1,29),(2029,'JOSE ANGEL JIMENEZ',7,'5518890882',1,29),(2030,'JOSE ANGEL SÁNCHEZ',7,'5535327454',1,29),(2031,'JOSE ANTONIO ZUÑIGA',7,'5543864692',1,29),(2032,'JOSE BARRIOS',7,'SN',1,29),(2033,'JOSE CARLOS',7,'5536657936',1,29),(2034,'JOSÉ CHAVEZ MEJIA',7,'5546412398',1,29),(2035,'JOSE ELIZALDE',7,'5578216669',1,29),(2036,'JOSE GARCIA',7,'5516366521',1,29),(2037,'JOSE GERARDO',7,'5617081846',1,29),(2038,'JOSE GUADALUPE OSORIO',7,'5638288887',1,29),(2039,'JOSE JAIME VALDEZ',7,'5561207645',1,29),(2040,'JOSE LEGANTE',7,'5514772511',1,29),(2041,'JOSE LUIS',7,'5531996121',1,29),(2042,'JOSE LUIS ALDAVE',7,'5580125800',1,29),(2043,'JOSE LUIS BAUTISTA',7,'5512875140',1,29),(2044,'JOSE LUIS CEVALLOS CHAVEZ',7,'5611876360',1,29),(2045,'JOSE LUIS GARCIA',7,'5544879894',1,29),(2046,'JOSE LUIS GONZALEZ',7,'5516452484',1,29),(2047,'JOSE LUIS LAGUNA',7,'5578570609',1,29),(2048,'JOSE LUIS MARTINEZ',7,'5541946922',1,29),(2049,'JOSE LUIS MEZA',7,'5527133083',1,29),(2050,'JOSE LUIS PONCE',7,'5564269088',1,29),(2051,'JOSE LUNA',7,'5585289689',1,29),(2052,'JOSE MANUEL',7,'5513048198',1,29),(2053,'JOSE OLVERA',7,'5549818403',1,29),(2054,'JOSE ROBERTO',7,'5548189126',1,29),(2055,'JOSE SALVADOR',7,'5539374417',1,29),(2056,'JOSE TORRES',7,'5564943702',1,29),(2057,'JOSÉ TORRES WOLF GYM',7,'5587457828',4,29),(2058,'jose zavala',7,'5549011608',1,29),(2059,'JOSUE BOBADILLA',7,'8721398465',1,29),(2060,'Josue Nava',7,'5583933091',1,29),(2061,'JOVANI RODRIGUEZ',7,'5538886011',1,29),(2062,'JUAN ALBERTO',7,'SN',1,29),(2063,'JUAN ALBERTO SANCHEZ',7,'5522200129',1,29),(2064,'JUAN CARLOS',7,'5615609804',1,29),(2065,'JUAN CARLOS',7,'5512305904',1,29),(2066,'JUAN CARLOS CALDERON',7,'5581941745',1,29),(2067,'JUAN CARLOS MARTINEZ',7,'5574430586',1,29),(2068,'Juan Cuauhtemoc Campos',7,'5581331833',4,29),(2069,'JUAN DIEGO',7,'7531211627',1,29),(2070,'JUAN GUTIERREZ GONZÁLES',7,'5580069279',1,29),(2071,'JUAN HERNANDEZ',7,'5626253421',1,29),(2072,'JUAN JESUS MADRIGAL',7,'5529092460',1,29),(2073,'Juan Jose Juarez Valencia',7,'5537272961',1,29),(2074,'JUAN LUIS',7,'5536521335',1,29),(2075,'JUAN LUIS CRUZ RUIZ',7,'5513999912',1,29),(2076,'JUAN MANUEL',7,'5561024146',1,29),(2077,'JUAN MANUEL',7,'SN',1,29),(2078,'JUAN MANUEL PEÑA',7,'5579292446',1,29),(2079,'JUAN MILITAR',7,'3313816343',1,29),(2080,'JUAN MORALES GONZALES',7,'5542393075',1,29),(2081,'JUAN PABLO',7,'5520',1,29),(2082,'JUAN PABLO CANO HERNANDEZ',7,'5531394944',1,29),(2083,'JUAN PABLO ORTIZ',7,'5618152719',1,29),(2084,'JUAN PABLO ORTÍZ GARCÍA',7,'5618152719',1,29),(2085,'JUAN REYES',7,'SN',1,29),(2086,'JUAN REYES',7,'5582997941',1,29),(2087,'JUAN RUBIO',7,'5613276899',1,29),(2088,'JUAN SEGURA',7,'5567555267',1,29),(2089,'JUAN ZAVALA',7,'5518139902',1,29),(2090,'JULIA BERNAL',7,'5636266634',1,29),(2091,'JULIAN ZUÑIGA',7,'5620851757',1,29),(2092,'JULIO ALBERTO',7,'5580090605',1,29),(2093,'JULIO CESAR CELAYA',7,'5581558395',1,29),(2094,'JULIO CESAR VELASQUEZ',7,'5534859412',1,29),(2095,'JULIO MENA',7,'5551580664',1,29),(2096,'JULIOS CESAR LARA',7,'5625768759',1,29),(2097,'KAREN MATEOS',7,'5580379803',4,29),(2098,'KARLA DANIELA HERNANDEZ SALAZAR',7,'5554157180',1,29),(2099,'KARLA HERRERA',7,'5613704298',1,29),(2100,'KARLA MARIA RIVERA PEÑA',7,'5528754028',1,29),(2101,'KARLA ROCHA',7,'5513859209',1,29),(2102,'KARLA SÁNCHEZ',7,'5528930976',1,29),(2103,'KATHERINE NUÑEZ RODRIGUEZ',7,'5547606870',1,29),(2104,'KELLY YAMILETH',7,'5633456456',1,29),(2105,'KEVIN ALDAIR',7,'5634058970',1,29),(2106,'KEVIN RODRIGUEZ',7,'5548250889',1,29),(2107,'KEVIN SALINAS',7,'5534199369',1,29),(2108,'KEVIN YAHIR NAVARRETE ROMERO',7,'5564739411',4,29),(2109,'LAEJANDRO LOBATO',7,'5531526302',1,29),(2110,'Laura Jaramillo',7,'5546960085',1,29),(2111,'LAURA OLVERA',7,'5515801528',1,29),(2112,'LEONARDO ISAC PEÑUELAS',7,'5545854885',1,29),(2113,'LESLIE LOPEZ',7,'5575695191',1,29),(2114,'LESLY GARCIA GONZALEZ',7,'5522018448',1,29),(2115,'LETICI NAJERA CAZARES',7,'5527606763',1,29),(2116,'LETICIA MENDEZ',7,'5545503438',1,29),(2117,'LIAM TORRES',7,'5635502992',1,29),(2118,'LILIAN CORTEZ SANTAMARIA',7,'5560426137',1,29),(2119,'LILIANA CASTRO',7,'5564952964',1,29),(2120,'LILIANA ELIZALDE',7,'563088515',1,29),(2121,'LILIANA FRANCO',7,'5519066869',1,29),(2122,'LILIANA JIMENEZ',7,'5526761268',1,29),(2123,'LILIANA LABASTIDA',7,'5611840781',1,29),(2124,'LISSET SANTIAGO',7,'5610671907',1,29),(2125,'LIZBETH JARAMILLO',7,'5537923541',1,29),(2126,'LIZBETH JIMENEZ',7,'5574809748',1,29),(2127,'LIZET MARQUEZ',7,'5576979672',1,29),(2128,'LOLA JIMENEZ',7,'5620149944',1,29),(2129,'LORENA DOMINGUEZ',7,'5521918298',1,29),(2130,'LORENA LEDEZMA PATIÑO',7,'5625991538',1,29),(2131,'LUCIA LEON',7,'5568813316',1,29),(2132,'LUCIA MORALES',7,'5513757591',1,29),(2133,'LUCIO MUÑOZ MUÑOZ',7,'5580605519',1,29),(2134,'LUIS ADRIAN UGALDE CORTES',7,'5540279471',1,29),(2135,'LUIS ALBERTO',7,'5525020204',1,29),(2136,'LUIS ALBERTO',7,'5576634490',1,29),(2137,'LUIS ALBERTO',7,'5510812655',1,29),(2138,'LUIS ALBERTO GARCIA',7,'5522024927',1,29),(2139,'LUIS ÁNGEL CARMONA OCEGUEDA',7,'5529380783',1,29),(2140,'LUIS ANGEL SANCHEZ',7,'5571133374',1,29),(2141,'LUIS CARLOS',7,'3342981099',1,29),(2142,'LUIS DAVID GONZALEZ',7,'5580098859',1,29),(2143,'Luis Duran',7,'5524593225',1,29),(2144,'LUIS ENRIQUE VILLANUEVA',7,'5638325139',3,29),(2145,'LUIS ERICK BERNAL RODRIGUEZ',7,'SN',1,29),(2146,'LUIS FLORENTINO',7,'7774227542',1,29),(2147,'LUIS GARCÍA NUÑEZ',7,'4272445937',1,29),(2148,'LUIS GONZALES',7,'5548053627',1,29),(2149,'LUIS JARAMILLO',7,'5539140249',1,29),(2150,'LUIS LOPEZ',7,'5528601911',1,29),(2151,'LUIS MANUEL',7,'2213777195',1,29),(2152,'LUIS MENDOZA',7,'5615724834',1,29),(2153,'LUIS OJEDA',7,'5561357208',1,29),(2154,'luis ordas',7,'5582419716',1,29),(2155,'LUIS VELAZQUEZ',7,'5521893197',1,29),(2156,'MAGALI DIAZ',7,'5538914985',1,29),(2157,'MAGALY CAMPOS',7,'5563238271',1,29),(2158,'MAIRA ESPINOZA',7,'5551736965',1,29),(2159,'MANUEL URIBE',7,'5635987326',1,29),(2160,'MANUEL VARAJAS',7,'5570551188',1,29),(2161,'MARA LAURA CERECERO',7,'5',1,29),(2162,'MARA LAURA CERECERO',7,'5639627644',1,29),(2163,'MARCE GALINDO',7,'5630682046',1,29),(2164,'MARCE GALINDO',7,'5587460087',1,29),(2165,'MARCO ANTONIO',7,'5534419950',1,29),(2166,'MARCO ANTONIO LÓPEZ',7,'5518339929',3,29),(2167,'Marco Reyes',7,'5527488894',1,29),(2168,'MARCO TORRES',7,'5516900932',1,29),(2169,'MARCOS ASPIROS',7,'5632958626',1,29),(2170,'MARCOS ELIAS PEREZ',7,'5515688581',1,29),(2171,'MARCOS GAYTAN',7,'5623932407',1,29),(2172,'MARCOS LIRA',7,'5580208676',1,29),(2173,'MARIA DE LOURDES',7,'5567437335',1,29),(2174,'MARIA EUGENIA MATA REYES',7,'5511534931',1,29),(2175,'Maria Fernanda Galaviz',7,'5527219309',1,29),(2176,'MARIA GUADALUPE GUTIERREZ',7,'5518432867',1,29),(2177,'Maria Gutierrez',7,'5518432867',1,29),(2178,'MARÍA LECONA',7,'5566331989',1,29),(2179,'MARÍA LECONA',7,'5566331989',1,29),(2180,'MARIANA CAMACHO',7,'5576811242',1,29),(2181,'MARIANA GONZALES ALBINO',7,'5537069866',1,29),(2182,'MARIANA SOSA',7,'5616102902',1,29),(2183,'MARIBEL GOMEZ',7,'7442662527',1,29),(2184,'Maribel Mondragon',7,'5565366992',1,29),(2185,'MARIELA BOILLA LOPEZ',7,'SN',1,29),(2186,'MARIO ALONSO',7,'5545451662',1,29),(2187,'MARIO GONZALEZ',7,'5624270142',1,29),(2188,'MARIO GURROLA',7,'SN',1,29),(2189,'MARIO POLITO BOLAÑOS',7,'5532429895',1,29),(2190,'MARIO POSADAS',7,'5529426989',1,29),(2191,'MARITZA ANAHI',7,'5561885091',1,29),(2192,'MARLENI ZEPEDA',7,'5573771334',1,29),(2193,'MARLON ADRIAN RENTERAL DIAZ',7,'9661018088',1,29),(2194,'MARTÍN ALVARADO MONTEALEGRE',7,'5564864907',1,29),(2195,'MARTIN CAMACHO GYM NAUCALPAN',7,'5614139666',4,29),(2196,'MARTIN ZUÑIGA VAZQUEZ',7,'5537705630',1,29),(2197,'MARU FLORES',7,'5527172676',1,29),(2198,'MARVIN OLIVA DE LA CRUZ',7,'5535689239',1,29),(2199,'MAURO DE JESUS ANSUREZ',7,'8124361400',1,29),(2200,'MAURO HERNANDEZ',7,'5522992556',1,29),(2201,'MAURO MORALES',7,'5585689859',1,29),(2202,'MELANIE ESTRADA',7,'5525200973',1,29),(2203,'MELODY ORTIZ ZAMBRANO',7,'5618295759',1,29),(2204,'Micaela Ortega',7,'5550438365',1,29),(2205,'MICHAEL MENDIETA FLORES',7,'5511338046',1,29),(2206,'MICHELL MARTINEZ',7,'5518897936',1,29),(2207,'MICHNA MAISEL',7,'5541756594',1,29),(2208,'MIGUEL ÁNGEL GUTIERREZ',7,'5574834863',1,29),(2209,'MIGUEL ANGEL HERNADEZ',7,'5561011202',1,29),(2210,'MIGUEL ANGEL MARTINEZ',7,'5630784893',1,29),(2211,'MIGUEL ANGEL MARTINEZ',7,'5612978904',1,29),(2212,'MIGUEL ANGEL PALOMARES',7,'5537041867',1,29),(2213,'MIGUEL ANGEL RAMIREZ LOPEZ  WORLD GYM',7,'5541767650',4,29),(2214,'MIGUEL ANGEL ROMAN',7,'5559393202',1,29),(2215,'MIGUEL ANGEL SANCHEZ SANCHEZ',7,'5581970917',1,29),(2216,'MIGUEL ANGEL VALDES',7,'5579805576',1,29),(2217,'MIGUEL ANGEL ZIÑIGA',7,'5516473043',1,29),(2218,'MIGUEL ÁVALOS',7,'5518927799',1,29),(2219,'MIGUEL GYM SPIDER',7,'SN',4,29),(2220,'MIGUEL OSORIO',7,'5563368172',1,29),(2221,'MIGUEL TADEO',7,'5614017598',1,29),(2222,'MIGUEL ZERON',7,'7717720332',1,29),(2223,'MILDRET ALCAUFER',7,'5533676687',1,29),(2224,'MIRELLA TEJEDA',7,'5562543234',1,29),(2225,'MIREYA DE LA CRUZ',7,'5617976793',1,29),(2226,'MIREYA SANCHEZ',7,'5526579839',1,29),(2227,'MIRIAM GARCIA',7,'5534117025',1,29),(2228,'MISAEL AGUIRRE',7,'5536338068',1,29),(2229,'MISAEL VAZQUEZ',7,'5628249555',1,29),(2230,'MOISES ARRASTIO',7,'5526999437',1,29),(2231,'MOISES ARRASTIO',7,'5560159983',1,29),(2232,'MOLLY',7,'5534055722',1,29),(2233,'monica saldivar',7,'5525725077',1,29),(2234,'MONICA YELITZA NAVARRETE AGUILAR',7,'5639629200',4,29),(2235,'MONSERRAT AVENDAÑO',7,'5568923674',1,29),(2236,'MONSERRAT MEJIA',7,'5519050694',4,29),(2237,'NANCY ALVAREZ',7,'5515013533',1,29),(2238,'NANCY DIAZ',7,'5513329619',1,29),(2239,'NANSY TORRES',7,'5539160261',1,29),(2240,'NATIVITAS HERNADEZ',7,'5535628821',1,29),(2241,'NEFTALI BAUTISTA CORTEZ',7,'SN',1,29),(2242,'NEFTALÍ MURILLO',7,'5540343247',1,29),(2243,'NELLY HUITRON FLORES',7,'5618704054',1,29),(2244,'NICOLAS MARES',7,'5537067525',1,29),(2245,'NICOLAS MARQUEZ',7,'5537067525',1,29),(2246,'NOÉ MONTERO OLVERA',7,'5582376746',1,29),(2247,'NORBERTO CASTILLO',7,'SN',1,29),(2248,'OAVALDO HERNANDEZ MENDOZA',7,'9221848568',1,29),(2249,'OCTAVIO COLIN',7,'5579605483',1,29),(2250,'OLIVER GONZÁLEZ',7,'5522479057',1,29),(2251,'OLIVER ROGRIGUEZ',7,'5532496950',1,29),(2252,'OlLIMPIA BUCIO',7,'5576040063',1,29),(2253,'OMAR',7,'2462020688',1,29),(2254,'OMAR EDUARDO CLETO MAYEN GYM',7,'5581013341',4,29),(2255,'OMAR ESPENAL',7,'7226469887',1,29),(2256,'OMAR GUASSO',7,'5535583256',1,29),(2257,'OMAR MOJICA',7,'5571320301',1,29),(2258,'OMAR REYES',7,'5620618024',1,29),(2259,'ORLANDO PEREZ NIEVES',7,'5569761167',1,29),(2260,'OSCAR ALVARADO',7,'5574711436',1,29),(2261,'OSCAR GARCIA',7,'5637643682',1,29),(2262,'OSCAR HERNANDEZ',7,'5510631143',1,29),(2263,'Oscar Kevin Chavez',7,'5548261918',1,29),(2264,'OSCAR RINCON PEREZ',7,'5561081731',1,29),(2265,'OSCAR ULISES SANTOS TINOCO',7,'5579036062',1,29),(2266,'OSIRIS LUIS MORENO RIOS',7,'5579236631',1,29),(2267,'OSMAR MENDIOLA',7,'5520802993',1,29),(2268,'OSVALDO GARCÍA',7,'5539989881',1,29),(2269,'OSWALDO GONZALEZ',7,'5532312029',1,29),(2270,'PAMELA GRANADA MARTINEZ',7,'5543387656',3,29),(2271,'PAMELA MARTINEZ',7,'5636924283',1,29),(2272,'Paola Garcia',7,'5582056330',1,29),(2273,'PATRICIA CAÑEDO EULLOQUI',7,'5521171228 O 5546177599',1,29),(2274,'PEDRO ESTEBAN ALVARADO',7,'5535046140',1,29),(2275,'PEDRO HERNANDEZ',7,'5562194496',1,29),(2276,'PEDRO HERNANDEZ',7,'5634260778',1,29),(2277,'PEDRO MONDRAGÓN',7,'5516571265',1,29),(2278,'PIER GUZMAN',7,'5540477071',1,29),(2279,'RAFAEL',7,'5574748184',1,29),(2280,'RAFAEL MARTINEZ',7,'5531496786',1,29),(2281,'RAFAEL RAMIREZ',7,'5528553867',1,29),(2282,'RAFAEL RAMOS',7,'5513065950',1,29),(2283,'RAFAEL SOSA TENORIO',7,'5518379830',1,29),(2284,'RAFAEL TELLEZ',7,'5571330202',1,29),(2285,'RAMIRO SOLIS',7,'SN',1,29),(2286,'RANDI GERONIMO',7,'SN',1,29),(2287,'RAQUEL ROJAS',7,'5537122500',1,29),(2288,'Raul Figueroa',7,'5540034563',1,29),(2289,'RAUL PEREZ SERRANO',7,'9983083959',1,29),(2290,'REYNA TALAVERA',7,'5539709972',1,29),(2291,'REYNALDO AYALA HERNANDEZ',7,'5513588486',1,29),(2292,'RICARDO ANTONIO',7,'5574859440',1,29),(2293,'RICARDO BENITO',7,'5569359247',1,29),(2294,'RICARDO GARCIA ARREOLA',7,'5564208210',4,29),(2295,'RICARDO HERNANDEZ',7,'5540965836',1,29),(2296,'RICARDO HERNÁNDEZ',7,'5540965836',1,29),(2297,'RICARDO HERNANDEZ TOVAR',7,'5564852113',1,29),(2298,'RICARDO INSTRUCTOR',7,'5525679642',4,29),(2299,'RICARDO JIMENEZ MARTINEZ',7,'5525648348',1,29),(2300,'RICARDO LOPEZ',7,'5543955963',1,29),(2301,'RICARDO MORALES',7,'9721136581',1,29),(2302,'RICARDO MORENO',7,'5522554303',1,29),(2303,'RICARDO SANCHEZ',7,'5621610106',1,29),(2304,'RICARDO SANCHEZ',7,'5621610106',1,29),(2305,'RICARDO TRINIDAD',7,'5552520106',1,29),(2306,'ROBERTO AICAOL',7,'5633753991',1,29),(2307,'ROBERTO BARRERA',7,'5628194941',1,29),(2308,'ROBERTO CARLOS',7,'5620609303',1,29),(2309,'ROBERTO CARLOS',7,'5591969308',1,29),(2310,'ROBERTO ENDONEO',7,'5578987443',1,29),(2311,'ROBERTO GARCIA',7,'5580754090',1,29),(2312,'ROBERTO GUADARRAMA',7,'5543948655',1,29),(2313,'ROBERTO HERNANDEZ HERNANDEZ',7,'5585413968',1,29),(2314,'ROBERTO HERNANDEZ MEJIA',7,'7831433285',1,29),(2315,'ROBERTO RUIZ',7,'5545414382',1,29),(2316,'ROBERTO ZAMBRANO',7,'5579442571',1,29),(2317,'ROBLEDO GALVEZ',7,'7299483320',1,29),(2318,'ROCIO ACEVEDO GARCIA',7,'5548193996',1,29),(2319,'RODOLFO ALEJANDRO TOLEDO TORRES',7,'5611651984',1,29),(2320,'RODOLFO ROSALES',7,'5510060864',1,29),(2321,'RODRIGO OLVERA',7,'5524945044',1,29),(2322,'RODRIGO ROSAS GONZALEZ',7,'5551763677',1,29),(2323,'RODRIGO SALINAS',7,'SN',1,29),(2324,'Rogelio Lazaro Ortiz',7,'5588221690',1,29),(2325,'ROGELIO TORRES',7,'5575115669',1,29),(2326,'ROGER BIKER',7,'5530710404',1,29),(2327,'ROMELIA GUTIERREZ',7,'5540800536',1,29),(2328,'ROSA MARIA SANTIAGO',7,'5514839262',1,29),(2329,'ROSA MORALES',7,'5584231480',1,29),(2330,'ROSALBA ALMAZAN',7,'5511587662',1,29),(2331,'RUBÉN RAMÍREZ',7,'5535232009',1,29),(2332,'RUBEN SANCHEZ',7,'5525543483',1,29),(2333,'RUBEN SANDOVAL',7,'5562065122',1,29),(2334,'SAMANTHA OJEDA',7,'7761202216',1,29),(2335,'SAMUEL MENDEZ',7,'5547677794',1,29),(2336,'SANAHY OLIVAR',7,'8312383212',1,29),(2337,'Sandra Angelica Navarro',7,'5535160589',1,29),(2338,'SANDRA BRAVO',7,'5538843785',1,29),(2339,'Sandra Ledezma',7,'SN',1,29),(2340,'SANDRA MENDEZ LÓPEZ',7,'5567613213',1,29),(2341,'SANTIAGO MONDRAGON',7,'5564638094',1,29),(2342,'SANTIAGO RODRIGUEZ',7,'5544589678',1,29),(2343,'SANTIAGO VELAZQUEZ',7,'SN',1,29),(2344,'SANTIAGO VELAZQUEZ',7,'5631752387',1,29),(2345,'SARAI MENDEZ',7,'5534902009',1,29),(2346,'SAUL CABERA',7,'5618403963',1,29),(2347,'SERGIO ALVAREZ',7,'5535547714',1,29),(2348,'SERGIO EMMANUEL CHAVEZ',7,'5534887960',1,29),(2349,'SERGIO FABELA',7,'5580339869',1,29),(2350,'SERGIO GARCÍA HERNÁNDEZ',7,'5538853526',1,29),(2351,'SERGIO GYM HORMIGA',7,'5540443892',1,29),(2352,'SERGIO TAGLE',7,'5548179442',4,29),(2353,'SERGIO URIEL',7,'5565600257',1,29),(2354,'SILVIA FLORES',7,'5588145454',1,29),(2355,'SINTHIA REGALADO',7,'5512492725',1,29),(2356,'SOUCEET MAGAÑA',7,'5560662197',1,29),(2357,'SUSANA VILLAVICENCIO',7,'5520300471',1,29),(2358,'TERESA MATIAS',7,'5554775079',1,29),(2359,'TERESITA GUZMAN',7,'SN',1,29),(2360,'THALIA CARDENAS',7,'5511842829',1,29),(2361,'THALIO HERNANDEZ ACERO GYM',7,'5534581514',4,29),(2362,'TIGGER GYM',7,'5517447366',1,29),(2363,'TIRZA LARA',7,'5530873703',1,29),(2364,'TOMAS MORALES',7,'5560101643',1,29),(2365,'TOÑO',7,'5522543726',1,29),(2366,'ULISES APARICIO',7,'5548550352',1,29),(2367,'UZIEL MEJIA',7,'5535539635',1,29),(2368,'UZZIEL MEGIA',7,'5535539635',1,29),(2369,'VALENTIN TINOCO',7,'5523234380',1,29),(2370,'VALERIA ANDREA',7,'5580377937',1,29),(2371,'VALERIA OBIDO',7,'5574404059',1,29),(2372,'VEGA ISRAEL GYM',7,'5611654011',1,29),(2373,'VERONICA DIAZ',7,'5610905657',1,29),(2374,'VERÓNICA PÉREZ MARTÍNEZ',7,'5540414529',1,29),(2375,'VERONICA RAMIREZ RAYON',7,'5619494475',1,29),(2376,'VERONICA SANCHEZ',7,'5539307852',1,29),(2377,'VICTOR ESQUIVEL',7,'5538789562',1,29),(2378,'VICTOR FERNANDO VEGA COLIN',7,'5545204108',1,29),(2379,'VICTOR FUENTES',7,'5532405482',1,29),(2380,'VICTOR GONZALEZ',7,'5535041687',1,29),(2381,'VICTOR HUGO',7,'5571889536',1,29),(2382,'VICTOR LUNA',7,'5518228113',1,29),(2383,'VICTOR MANUEL HIDALGO',7,'5617238992',1,29),(2384,'VICTOR PÉREZ',7,'5544761162',1,29),(2385,'VICTOR RICO',7,'5528989512',1,29),(2386,'VICTOR VASQUEZ',7,'7298786441',1,29),(2387,'VIRIDIANA FLORES',7,'5539118385',1,29),(2388,'VIRIDIANA TORRES VEGA',7,'5523385322',1,29),(2389,'VLADIMIR PADILLA GARCÍA',7,'5587017463',1,29),(2390,'YACIEL DEITA',7,'5586118582',1,29),(2391,'YADIRA OLEA',7,'5636000041',1,29),(2392,'YARA MONTANEZ',7,'5553591856',1,29),(2393,'Yessica Trujillo',7,'5528537609',1,29),(2394,'ZURIEL CALDERON',7,'5524340225',1,29),(2395,'ZURISADAI SÁNCHEZ QUESADA',7,'5624718571',1,29),(2396,'GILBERTO SOSA',7,'5540111934',4,29),(2397,'Carlos Quezada Colin (warrior´s gym)',7,'5561448183',4,29),(2398,'TIRZA LARA AVILES',7,'5530873703',1,29),(2399,'ERICK SANCHEZ NAVARRO',7,'5617549737',4,29),(2400,'javier gonzalez',7,'5571487119',1,29),(2401,'ALONSO HERNANDEZ',7,'5611144203',1,29),(2402,'ANGEL ARTURO ORTIZ',7,'5587919618',1,29),(2403,'ANGEL RODRIGO PADILLA PLAZA',7,'5632412166',1,29),(2404,'DAVID ALEJANDRO MARQUEZ',7,'5544877300',1,29),(2405,'GERARDO',7,'5541279675',1,29),(2406,'ISABEL GARCIA',7,'5526866017',1,29),(2407,'LILIANA PEREZ',7,'5564666955',1,29),(2408,'LUIS ENRIQUE BAUTISTA CRUZ',7,'5514704211',1,29),(2409,'SANTIAGO GAÑA SANTOS',7,'5564339745',1,29),(2410,'JOSE FELICIANO TOLEDO REYNA',7,'9221215366',1,29),(2411,'SANTIAGO DE JESUS',7,'5573830440',4,29),(2412,'RICARDO MEDINA ARELLANO',7,'4925590754',1,29),(2413,'Cesar Altos',7,'5577901640',1,29),(2414,'ROBERTO PÉREZ ACOSTA',7,'9933883394',1,29),(2415,'AARON SORIANO',3,'5564223297',1,37),(2416,'ALEJANDRA GALICIA',3,'SN',4,37),(2417,'ALEJANDRO ACTIVE',3,'5540960548',1,37),(2418,'ALEJANDRO OROZCO PEREIRA PUBLICO',3,'5621050901',1,37),(2419,'ALEJANDRO SALAZAR GARCIA PUBLICO',3,'5567734243',1,37),(2420,'ALFONSO ALARCON PUBLICO',3,'5547969973',1,37),(2421,'ALMA OSCAR JESUS PUBLICO',3,'5528353875',1,37),(2422,'ANDRES VAZQUEZ REYES PUBLICO',3,'5548435680',1,37),(2423,'ANI MATIAS PUBLICO',3,'5616842586',1,37),(2424,'AURORA FERNANDEZ PUBLICO',3,'5563678657',1,37),(2425,'BERENICE MOYER PUBLICO',3,'5580084134',1,37),(2426,'BETY SOLACHE PUBLICO',3,'5612642170',1,37),(2427,'CARLOS FERNANDO HUERTA RODRIGUEZ',3,'SN',1,37),(2428,'CECELIA GARCIA PUBLICO',3,'7293918029',1,37),(2429,'CRISTIAN GUTIERREZ FLORES PUBLICO',3,'5568921476',1,37),(2430,'CRISTIAN PALAFOX PUBLICO',3,'5543584428',1,37),(2431,'CRISTOPHER GONZALEZ PUBLICO',3,'5536527182',1,37),(2432,'DANIELA FUENTES LIRA',3,'5565067450',1,37),(2433,'DANIELA RUBI PUBLICO',3,'5625118516',1,37),(2434,'DAVID AGUILAR FLORES CROSSFIT',3,'5536754291',1,37),(2435,'DEMETRIO',3,'5545910991',3,37),(2436,'DIANA LAURA LOPEZ',3,'5540469836',1,37),(2437,'DUNCAN MUNGUIA',3,'5583708002',1,37),(2438,'EDSO NAVA PUBLICO',3,'5561978594',1,37),(2439,'EDUARDO AGUIRRE PUBLICO',3,'5531903253',1,37),(2440,'EDUARDO FLORES PUBLICO',3,'5529998602',1,37),(2441,'EDUARDO JIMENEZ CRUZ',3,'5617623640',1,37),(2442,'EDUARDO LOPEZ RAMIREZ PUBLICO',3,'5628237913',1,37),(2443,'EDUARDO RAMIREZ PUBLICO',3,'5633123091',1,37),(2444,'ERICK ALEXANDER PUBLICO',3,'5549461779',1,37),(2445,'ERICK MISAEL PUBLICO',3,'5614161621',1,37),(2446,'ERNESTO ZAPIEN PUBLIBO',3,'5566554012',1,37),(2447,'EVELYN ESPINOZA NAVARRETE',3,'5580375966',1,37),(2448,'FABIOLA VAZQUEZ',3,'5614059802',4,37),(2449,'FATIMA ROSILES',3,'5513095940',1,37),(2450,'FERNANDO BRAMADERO',3,'5540925418',4,37),(2451,'FERNANDO RAMIREZ PUBLICO',3,'5613929397',1,37),(2452,'FERNANDO ZARAGOZA',3,'SN',4,37),(2453,'FRANCISCO FLORES',3,'5533275146',4,37),(2454,'FRANCISCO SANTIAGO PUBLICO',3,'5545331725',1,37),(2455,'GABRIEL MARTINEZ COVARUBIAS PUBLICO',3,'5631654862',1,37),(2456,'GABY HERNANDEZ ROMERO PUBLICO',3,'5645835833',1,37),(2457,'GIOVANI GONZALES PUBLICO',3,'5546930256',1,37),(2458,'GUILLERMO MORALES PUBLICO',3,'5521178691',1,37),(2459,'ISRAEL ´PORTUGAL PUBLICO',3,'5568961574',1,37),(2460,'JAZINTO',3,'SN',1,37),(2461,'LILIA VARGAS',3,'SN',3,37),(2462,'LILIANA GOMEZ',3,'5578760591',1,37),(2463,'RICARDO ARZATE CRUZ',3,'SN',4,37),(2464,'SARAI MARTINEZ',3,'5538918985',1,37),(2465,'TERESA ALVAREZ AVENGERS GYM',3,'5546389752',4,37),(2466,'ULISES OLVERA POLI',3,'5546083725',4,37),(2467,'XIMENA RAMIREZ',3,'5626783413',1,37),(2468,'FERNANDO PEREZ SANCHEZ',3,'SN',4,37),(2469,'RAUL ARCOIRIS',3,'SN',4,37),(2470,'AXEL POL',3,'SN',4,37),(2471,'MIGUEL MORALES INSTRUCTOR',3,'SN',4,37),(2472,'JONATHAN ENRIQUE MERCADO JONNY GYM',3,'5517586362',4,37),(2473,'ALEXIS LOPEZ',3,'SN',4,37),(2474,'TANIA CASTILLO SALAZAR',3,'SN',4,37),(2475,'CARLOS RAMIREZ',3,'SN',4,37),(2476,'ARMANDO SORIA INSTRUCTOR',3,'SN',4,37),(2477,'ELISA CURTIS',3,'5535458872',4,37),(2478,'MONICA MENDEZ  BLACK GYM',3,'55 26 65 95 20',4,37),(2479,'EMA CARBONERAS',3,'SN',4,37),(2480,'GABRIELA ROSAS GONZALEZ',3,'SN',4,37),(2481,'AYEZA SALINAS',4,'5619581215',1,32),(2482,'CRISTO JESUS',2,'5634431459',1,25),(2483,'JUAN SANCHEZ ROSAS',3,'5613706742',1,37),(2484,'JUAN CARLOS MELIN CAMPOS',6,'0452224266862',4,30),(2485,'ASOCIACION CULTURAL ZARAGOZA',2,'5548433767',4,25),(2486,'ABRAHAM GONZALEZ',2,'SN',1,25),(2487,'ABRHAM EDUARDO ORTIZ',2,'5568805577',1,25),(2488,'ADAN RAMIREZ',2,'5574987526',3,25),(2489,'ADAN YEFTE',2,'5633616053',1,25),(2490,'ADRIAN GRANADOS',2,'3327215830',1,25),(2491,'ADRIAN SALDAÑA',2,'SN',1,25),(2492,'ALAN',2,'55775426',1,25),(2493,'ALAN',2,'5519775426',1,25),(2494,'alberto cortes',2,'5530585801',1,25),(2495,'ALBERTO GRANADOS',2,'5526611184',1,25),(2496,'ALBERTO GUILLEN',2,'SN',1,25),(2497,'ALBERTO LOPEZ',2,'5529363513',1,25),(2498,'ALEJANDRA CALZADA',2,'SN',1,25),(2499,'ALEJANDRA GARRIDO',2,'5568912868',1,25),(2500,'ALEJANDRO MORENO',2,'5513880181',1,25),(2501,'ALEJANDRO VALENZUELA',2,'5520452714',1,25),(2502,'ALEXIA VAZQUEZ',2,'5558801482',1,25),(2503,'ALEXIS JATZEL PONSE',2,'8118087978',1,25),(2504,'ALFREDO MARTINEZ',2,'SN',1,25),(2505,'ALICIA MUÑOS',2,'5618978607',1,25),(2506,'ALICIA SANCHEZ',2,'SN',1,25),(2507,'ALMA VARELA',2,'5613259206',1,25),(2508,'ALMA VAZQUEZ SPORTY FIT',2,'5578752874',1,25),(2509,'ALONSO CHAVARRIA',2,'5539206289',1,25),(2510,'ANA',2,'SN',1,25),(2511,'ANA MARIA GUTIERREZ',2,'5525340615',1,25),(2512,'ANDRES VAZQUEZ',2,'5512342159',1,25),(2513,'ANGEL DURAN',2,'5552855060',1,25),(2514,'ANGEL MORENO',2,'9842413301',1,25),(2515,'ANGEL SOU FUN LUZ DE LA ROSA',2,'5521418062',1,25),(2516,'ANTONIO FARFAN',2,'5541332132',1,25),(2517,'ARELY OLVERA',2,'5516034091',1,25),(2518,'ARMANDO GIRON',2,'5518051291',1,25),(2519,'ARMANDO GONZALEZ',2,'5558185720',1,25),(2520,'ARMANDO SILVESTRE',2,'5636305865',1,25),(2521,'ARTURO FIGUEROA GUTIERREZ',2,'2292111973',1,25),(2522,'ARTURO MEJIA',2,'SN',1,25),(2523,'ARTURO OROZCO',2,'5526716156',1,25),(2524,'AXEL REYES',2,'5543038015',1,25),(2525,'Ayesha Instructora',2,'5578372423',1,25),(2526,'Ayesha Rivera',2,'5578372423',1,25),(2527,'BEATRIZ MARQUEZ ALONSO',2,'5630539268',1,25),(2528,'BENJAMIN ORTEGA',2,'SN',1,25),(2529,'BERNARDO GONZALEZ',2,'5539661602',1,25),(2530,'BERTIN CADENA',2,'5515826833',1,25),(2531,'BRANDON ALEXIS',2,'5624599538',1,25),(2532,'BRIAN RODRI',2,'5528959074',1,25),(2533,'CARDIO SPORT',2,'5618192023',1,25),(2534,'CARLOS',2,'5550697140',1,25),(2535,'CARLOS CAMACHO',2,'5512141771',1,25),(2536,'carlos del angel',2,'55570065954',1,25),(2537,'CARLOS GOMEZ',2,'SN',1,25),(2538,'CARLOS RAMIREZ TULA',2,'5510038793',1,25),(2539,'CARLOS REYES',2,'5539523763',1,25),(2540,'CARLOS ZAPIEN RUBIO',2,'5585337696',1,25),(2541,'CARMEN GUTIERREZ',2,'5576715903',1,25),(2542,'CAROL MICHELLE',2,'5519062786',1,25),(2543,'CASANDRA NEAVE',2,'5572273620',1,25),(2544,'CECILIA OVIEDO',2,'SN',1,25),(2545,'CESAR LOPEZ',2,'5529333720',1,25),(2546,'CHRISTIAN NAVARRO',2,'5529728370',1,25),(2547,'CHRISTIAN PALOMINO',2,'5550541154',1,25),(2548,'CINTHIA AT&T',2,'5519493234',1,25),(2549,'CLARA ESPINOZA',2,'5561811424',1,25),(2550,'CLAUDIA LIMAS',2,'5628022293',1,25),(2551,'CRISTIAN SANTILLAN',2,'SN',1,25),(2552,'DANA CRUZ',2,'5621915593',1,25),(2553,'DANIEL GOMEZ',2,'5539881354',1,25),(2554,'DANIEL NAVARRO',2,'5570076909',1,25),(2555,'DANIELA TAPIA',2,'SN',1,25),(2556,'DARIO GARCIA',2,'5532385603',1,25),(2557,'DAVID CASTAÑEDA',2,'5637058226',1,25),(2558,'DAVID JIMENEZ',2,'SN',1,25),(2559,'DAVID NIETO',2,'5534127050',1,25),(2560,'DELIA RU',2,'5525032267',1,25),(2561,'DIEGO RIJAS',2,'5627303880',1,25),(2562,'DIEGO VARGAS',2,'5623932352',1,25),(2563,'DILAN TELLEZ',2,'5568037519',1,25),(2564,'DOLORES SILVA',2,'5554639919',1,25),(2565,'EATHAN RAMSES GARCIA',2,'5631175783',1,25),(2566,'edgar campos',2,'5551001325',1,25),(2567,'EDGAR MORALES',2,'5637023250',1,25),(2568,'EDGAR RESENDIZ',2,'5545782471',1,25),(2569,'EDGAR VAZQUEZ',2,'5520968393',1,25),(2570,'EDGAR VENTURA',2,'5620923660',1,25),(2571,'EDHER MODRAGON',2,'5631141153',1,25),(2572,'EDUARDO ALCARAZ',2,'5525004586',1,25),(2573,'EDUARDO AVILA',2,'5523372114',1,25),(2574,'EDUARDO D ANDRES',2,'5561921583',1,25),(2575,'EDUARDO PEREZ',2,'5554567244',1,25),(2576,'EDUARDO PIÑA',2,'5564165299',1,25),(2577,'EDUARDO RETURETA',2,'SN',1,25),(2578,'EDUARDO RIVERA',2,'5528838979',1,25),(2579,'EDUARDO VILLAREAL',2,'SN',1,25),(2580,'EDUARDO VILLAREAL',2,'5519952419',1,25),(2581,'EDWIN JAFET',2,'5564733850',1,25),(2582,'EDWIN MEDINA',2,'SN',1,25),(2583,'EL CUARTEL',2,'5630256300',1,25),(2584,'ELIZEO ELIZALDE',2,'5520655985',1,25),(2585,'emmanuel pineda',2,'SN',1,25),(2586,'EMMANUEL PINEDA',2,'8677520705',1,25),(2587,'ERICK CAMCHO',2,'7224638460',1,25),(2588,'ERICK LANGARICA',2,'5551391259',1,25),(2589,'ERIK ZARATE',2,'5576656192',1,25),(2590,'Erika Rosales',2,'7223872705',1,25),(2591,'ESTEBAN CANTU PALACIO',2,'5519638451',4,25),(2592,'FABIO GARCIA',2,'5544821858',1,25),(2593,'fabricio solano',2,'5514919800',1,25),(2594,'FELIPE TREJO',2,'5541936526',1,25),(2595,'FERNANDO ANDRADE',2,'5534148669',1,25),(2596,'FERNANDO CAMPOS',2,'5580248881',1,25),(2597,'FERNANDO FERNANDEZ',2,'5561178197',1,25),(2598,'FERNANDO LOPEZ',2,'5544946185',1,25),(2599,'fernando lopez',2,'5523051120',1,25),(2600,'fernando romero',2,'5565429064',1,25),(2601,'FERNANDO SANCHEZ',2,'5540328321',1,25),(2602,'FRANCISCO ALPIZAR',2,'SN',1,25),(2603,'FRANCISCO CERVANTES',2,'5511533420',1,25),(2604,'Francisco Morales',2,'SN',1,25),(2605,'GABRIEL ESTUDILLO',2,'5584086109',1,25),(2606,'GABRIEL GERRARDO SUAREZ',2,'5515070180',1,25),(2607,'GABRIELA CAMARGO',2,'5541069980',1,25),(2608,'genoveva mata otero',2,'9613492244',1,25),(2609,'GERARDO ORTIZ',2,'5512645978',1,25),(2610,'GERARDO VAZQUEZ',2,'5539963711',1,25),(2611,'GRACIELA QUINTANA',2,'5571908390',1,25),(2612,'GUILLERMO HERNANDEZ',2,'5569886079',1,25),(2613,'guillermo pardo',2,'5543571463',1,25),(2614,'GUILLERMO RAMIREZ',2,'5520486113',1,25),(2615,'GUILLERMO TALONIA',2,'5521389467',1,25),(2616,'GUSTAVO VAZQUEZ',2,'5528464585',1,25),(2617,'HECTOR HUGO',2,'5613814616',1,25),(2618,'HECTOR MARTINEZ',2,'8115449603',1,25),(2619,'HUGO SAUCEDO',2,'5565119835',1,25),(2620,'HUGO SAUCEDO',2,'SN',1,25),(2621,'HUMBERTO VAZQUEZ',2,'5540085363',1,25),(2622,'IKER SOLANA',2,'5561657360',1,25),(2623,'IRIS FERMAN',2,'5529819296',1,25),(2624,'IRVIN SALIN',2,'5512996474',1,25),(2625,'IRVING HERNANDEZ',2,'5611298777',1,25),(2626,'ISAAC GALVAN',2,'5560113416',1,25),(2627,'ISAAC VILLAR',2,'5626359280',1,25),(2628,'ISABEL FLORES',2,'SN',1,25),(2629,'IVAN ISMAEL',2,'5524470033',1,25),(2630,'IVONNE LOPEZ',2,'558121407',1,25),(2631,'JAIR RIVERA',2,'557455887',1,25),(2632,'JAVIER ANGELES CRUZ',2,'5513253660',1,25),(2633,'JAVIER CRUZ (INSTRUCTOR)',2,'5564795865',1,25),(2634,'JAVIER ESPEJEL',2,'SN',1,25),(2635,'JAVIER NAVARRO',2,'5517063795',1,25),(2636,'JAVIER SANCHEZ',2,'5512423741',1,25),(2637,'JAVIR MUÑOZ',2,'5587633779',1,25),(2638,'JESHUA CABRERA',2,'SN',1,25),(2639,'JESHUA CABRERA',2,'5579155547',1,25),(2640,'JESSICA',2,'SN',1,25),(2641,'JESUS REYES',2,'5544244858',1,25),(2642,'JESUS TOVAR',2,'5566954735',1,25),(2643,'JHONATAN JIMENEZ',2,'SN',1,25),(2644,'JHONATAN PEREZ BAZA',2,'5552886938',1,25),(2645,'JOAQUIN ZAMORA',2,'5536261020',1,25),(2646,'JOEL VALENCIA',2,'5524638289',1,25),(2647,'JOEL VAZQUEZ',2,'5541601369',1,25),(2648,'JONATHAN CRUZ',2,'5554144903',1,25),(2649,'JONATHAN PEREZ SANCHEZ',2,'SN',1,25),(2650,'JONATHAN REYES',2,'5554183449',1,25),(2651,'JORDY SALDIVAR LECHUGA',2,'5558837221',1,25),(2652,'JORGE ALAN MARTINEZ',2,'5610930325',1,25),(2653,'JORGE BOTELLO',2,'SN',1,25),(2654,'JORGE CORTES',2,'SN',1,25),(2655,'JORGE RIVERA',2,'5578133775',4,25),(2656,'JORGE SOLIS',2,'5574684452',1,25),(2657,'JOSE ANTONIO',2,'5627017965',1,25),(2658,'JOSE CARLOS',2,'5529865754',1,25),(2659,'JOSE CASAS',2,'5635580932',1,25),(2660,'JOSE LUIS BENAVIDES',2,'5568155079',1,25),(2661,'JOSE OLMEDO',2,'5551676233',1,25),(2662,'JOSE RAFAEL OMAÑA',2,'5536397205',1,25),(2663,'JOSE RAUL PONCIANO',2,'5523143511',4,25),(2664,'JOSE SOTO',2,'5571711798',1,25),(2665,'JOSE TREJO',2,'5564951539',1,25),(2666,'Josias Guzman',2,'6863064852',1,25),(2667,'JOSUE CELIS',2,'5534186217',1,25),(2668,'JOSUE GARCIA',2,'5544580574',1,25),(2669,'JOSUE ORDOÑEZ',2,'5519709595',1,25),(2670,'JOVANNI GONZALEZ',2,'5639703872',1,25),(2671,'JUAN ALBERTO GARCIA',2,'5566949234',1,25),(2672,'JUAN CARLOS POMPA HERREJON',2,'5518207947',4,25),(2673,'juan higareda',2,'SN',1,25),(2674,'juan martinez',2,'5561919048',1,25),(2675,'JUAN PABLO RECENDIZ',2,'5517057789',1,25),(2676,'JULIAN LARIOS',2,'5582336463',1,25),(2677,'JULIO MARTINEZ',2,'5628273076',1,25),(2678,'JULIO RIVAS',2,'5579060458',1,25),(2679,'KARIM RAMIREZ',2,'SN',1,25),(2680,'KARINA RODRIGUEZ',2,'SN',1,25),(2681,'KARLA',2,'SN',1,25),(2682,'KARLA GONZALEZ',2,'5532233802',1,25),(2683,'KARLA GONZALEZ',2,'SN',1,25),(2684,'KARLA PATRICIA',2,'SN',1,25),(2685,'KEMISH GONZALEZ',2,'SN',1,25),(2686,'KEVIN ACEVEDO',2,'5580145857',1,25),(2687,'KEVIN ESPINOZA',2,'5551969038',1,25),(2688,'KRISZTIAN PASZTOR',2,'5535052091',1,25),(2689,'LEO PARRA',2,'5531154942',1,25),(2690,'LILIANA MORALES',2,'5531301052',1,25),(2691,'LIZBETH HERNANDEZ',2,'5591981788',3,25),(2692,'LIZETH ZETINA',2,'5579201382',1,25),(2693,'LORENA OROZCO',2,'5615807043',1,25),(2694,'LUCIA AYALA',2,'5621123011',1,25),(2695,'LUIS',2,'5543454589',1,25),(2696,'LUIS ANTONIO LOPEZ',2,'5537327110',1,25),(2697,'LUIS ANTONIO RODRIGUEZ',2,'5627199160',1,25),(2698,'LUIS ARTURO',2,'5621219713',1,25),(2699,'LUIS BARAJAS',2,'3334521774',1,25),(2700,'LUIS JAIME',2,'5545824146',1,25),(2701,'LUIS LOREDO',2,'5517931743',1,25),(2702,'LUIS MANUEL',2,'5572964047',1,25),(2703,'LUIS SALTIJERAL',2,'5578789404',1,25),(2704,'LUZ GARCIA',2,'5545669390',1,25),(2705,'MANUEL MARTINEZ',2,'5532304037',1,25),(2706,'MARCO ANTONIO ESPITIA',2,'5573334671',1,25),(2707,'MARCO ANTONIO MARTINEZ',2,'5520935160',1,25),(2708,'Marco Polo  Maya',2,'5534821237',1,25),(2709,'MARCO ROMERO',2,'7711122862',1,25),(2710,'MARCOS JUAREZ',2,'SN',1,25),(2711,'MARIA BELEM',2,'5565357709',1,25),(2712,'MARIA DOLORES ORTIZ',2,'55307043332',1,25),(2713,'MARIA GOMEZ',2,'5561320709',1,25),(2714,'MARIANA GONZALEZ CRUZ',2,'5543306886',1,25),(2715,'MARIANA MALDONADO',2,'5533571783',1,25),(2716,'MARIO JARAMILLO',2,'5579901159',1,25),(2717,'MARIO LOPEZ',2,'SN',1,25),(2718,'MARISOL RODRIGUEZ',2,'5523154328',1,25),(2719,'MARTHA',2,'SN',1,25),(2720,'MAURI MONROY',2,'5584051030',1,25),(2721,'MAURO MUÑOZ',2,'5624712240',1,25),(2722,'MAX GONZALEZ',2,'5539861045',1,25),(2723,'MAYTE MARQUEZ',2,'5631221623',1,25),(2724,'MELISA REYES',2,'5566747355',1,25),(2725,'MELISSA CERON',2,'5540055045',1,25),(2726,'MIGUEL ANGEL CHAVEZ',2,'SN',1,25),(2727,'MIGUEL CARRILLO',2,'5621590241',1,25),(2728,'MIGUEL DONIS',2,'5545121005',1,25),(2729,'MIGUEL TINOCO',2,'SN',1,25),(2730,'MISHELLE VERDI',2,'5621923432',1,25),(2731,'nancy olivera',2,'SN',1,25),(2732,'NATALIE OLMEDO',2,'5585816272',1,25),(2733,'NAYELLY ESPINOZA',2,'5530397272',1,25),(2734,'NOE FERNANDEZ SOTO',2,'SN',1,25),(2735,'NOE REYES GALAN',2,'5566117509',1,25),(2736,'NORBERTO DOMINGUEZ',2,'5580401167',1,25),(2737,'OCTAVIO MORENO',2,'5526207391',1,25),(2738,'Octavio Padilla',2,'5534552429',1,25),(2739,'OLIVER GUZMAN',2,'5511979731',1,25),(2740,'OMAR GONZALES',2,'SN',4,25),(2741,'OMAR GRANGEL',2,'5580457802',1,25),(2742,'OMAR TRANCOSO',2,'5551011188',1,25),(2743,'ONELIA ESPINOZA',2,'SN',1,25),(2744,'OSCAR AVILA',2,'5618320481',1,25),(2745,'OSCAR JIMENEZ',2,'5522473283',1,25),(2746,'OSCAR LOYOLA',2,'5561841300',1,25),(2747,'OSCAR PALO',2,'SN',1,25),(2748,'OSCAR ROMERO',2,'SN',1,25),(2749,'OSCAR SANCHEZ',2,'5616304129',1,25),(2750,'OSCAR SANCHEZ',2,'5616304129',1,25),(2751,'OSVALDO MENDEZ TORRES',2,'7292907425',1,25),(2752,'OSWALDO ESPINOZA',2,'5550305435',1,25),(2753,'OSWALDO ROMEO',2,'5526680887',1,25),(2754,'OSWALDO TORRES',2,'7292907425',1,25),(2755,'PAOLA OSORIO',2,'5583262343',1,25),(2756,'pascual hernandez',2,'5544730543',1,25),(2757,'PASCUAL HERNANDEZ',2,'SN',1,25),(2758,'PASCUAL PINEDA',2,'5565259166',1,25),(2759,'PEDRO MERCADO',2,'5585735956',1,25),(2760,'PIERRE PHILTIDOR',2,'2871253127',1,25),(2761,'RAUL BTK',2,'5523143511',1,25),(2762,'RAUL MIRANDA',2,'SN',1,25),(2763,'RAYMUNDO CALDERON MONTOYA',2,'5531006797',1,25),(2764,'REINALDO RAMIREZ',2,'5540802839',1,25),(2765,'RICARDO GARCIA',2,'5579504441',1,25),(2766,'RODRIGO AVITIA',2,'SN',1,25),(2767,'ROGELIO TAPIA',2,'5526912801',1,25),(2768,'ROMAN CRUZ',2,'SN',1,25),(2769,'ROSA VENEGAS',2,'SN',1,25),(2770,'SABINO ARRILLO',2,'5555099963',1,25),(2771,'SAHIRA LEE MENDOZA',2,'5571900176',1,25),(2772,'SALVADOR BADILLO',2,'5579862623',1,25),(2773,'SANDRA COACH',2,'551266838',1,25),(2774,'SANTOS PRADO',2,'9531303396',1,25),(2775,'SEBASTIAN SALINAS',2,'5627263589',1,25),(2776,'SELENE',2,'SN',1,25),(2777,'SELENE DOMINGUEZ',2,'SN',1,25),(2778,'SERGIO AGUILAR',2,'5614257966',1,25),(2779,'SERGIO AYALA',2,'5618028162',1,25),(2780,'sergio Jabel',2,'SN',1,25),(2781,'SERGIO JABEL LUNA',2,'SN',1,25),(2782,'SERGIO JULIAN SANCHEZ (LOCATARIO)',2,'5526597413',3,25),(2783,'SERGIO MARTINEZ',2,'5578092048',1,25),(2784,'SERGIO ONTIVEROS',2,'5555038271',1,25),(2785,'taurus gym',2,'SN',1,25),(2786,'TERE CARDENAS',2,'SN',1,25),(2787,'ULISES ROMERO',2,'5570516236',1,25),(2788,'uriel rivera',2,'5636257837',1,25),(2789,'UZIEL SANCHEZ',2,'5574713508',1,25),(2790,'VERONICA VELAZCO',2,'5529479022',1,25),(2791,'VICENTE MANCILLA',2,'5534403549',1,25),(2792,'VICTOR BAEZ',2,'5512540530',1,25),(2793,'VIVIAN HIDALGO',2,'5580318960',1,25),(2794,'VIVIANA RIVERA',2,'5581451296',1,25),(2795,'YENI TREJO',2,'5521168487',1,25),(2796,'YOTZIN',2,'SN',1,25),(2797,'TONY ESTRADA',2,'5548072548',1,25),(2798,'IVAN PEREZ REYES',7,'5539020046',1,29),(2799,'EMILIO HERRERA',7,'5619328880',1,29),(2800,'ALEXIS YAÑEZ',3,'5626164360',1,37),(2801,'ABIGAIL ALONDRA',4,'5538304738',1,32),(2802,'ABRAHAM FLORES',4,'5650284444',1,32),(2803,'ABRAHAM GONZALEZ',4,'5540147292',1,32),(2804,'ADAN OLVERA',4,'5531891925',1,32),(2805,'ADAN ORDOÑEZ',4,'5550530946',1,32),(2806,'ADRIAN RIVERA',4,'56 2477 7316',1,32),(2807,'ALAN DAVID RAMIREZ VAZQUEZ',4,'7791062354',1,32),(2808,'ALAN SALVADOR',4,'5611330337',1,32),(2809,'ALBERTO CALDERON',4,'9981983784',1,32),(2810,'ALBERTO DIAZ',4,'55 4217 1786',1,32),(2811,'ALBERTO LOPEZ',4,'56 1171 9171',1,32),(2812,'ALEJANDRA LOPEZ',4,'5585444428',1,32),(2813,'ALEJANDRO HERRERA',4,'5527596577',1,32),(2814,'ALEJANDRO HERRERA',4,'SN',1,32),(2815,'ALEJANDRO LOPEZ',4,'5580353377',1,32),(2816,'ALEJANDRO RAMIREZ ESTRADA',4,'5588364088',1,32),(2817,'ALEXANDER PALACIOS',4,'5545226350',1,32),(2818,'ALEXANDER ZARAZUA',4,'5582479969',1,32),(2819,'ALEXIS COACALCO',4,'SN',1,32),(2820,'ALEXIS MENDEZ',4,'5549368344',1,32),(2821,'ALFREDO ESPINOZA',4,'5540235408',1,32),(2822,'ALFREDO JUAREZ',4,'5612754567',1,32),(2823,'ALFREDO PIÑA',4,'5534333931',1,32),(2824,'ALICIA RAMIREZ',4,'9541007705',1,32),(2825,'ALONDRA VAZQUEZ',4,'5624821737',1,32),(2826,'ALONZO GRANADOS',4,'3318021800',4,32),(2827,'ANA GRANADOS',4,'5534267606',1,32),(2828,'ANA PASCUALLI',4,'SN',1,32),(2829,'ANDRES BENITEZ',4,'5573709479',1,32),(2830,'ANDRES DE AURORA',4,'5573709479',1,32),(2831,'ANGEL ESTEVEZ',4,'SN',1,32),(2832,'ANGEL MIGUEL LOYO',4,'5575160284',1,32),(2833,'ANGEL SANTIAGO RUIZ ARREOLA',4,'5525362201',1,32),(2834,'ANGEL VAZQUEZ',4,'5534177093',1,32),(2835,'ANGELICA DAVILA TAFOLLA',4,'5525023562',1,32),(2836,'ANTHONY MARTINEZ',4,'5537940318',3,32),(2837,'ANTONIO RAMIREZ',4,'5575320799',1,32),(2838,'ANTONIO SALMERON ARELLANO',4,'5546832662',1,32),(2839,'ARACELI ESTUDILLO',4,'5528212863',1,32),(2840,'ARACELI SUAREZ',4,'SN',1,32),(2841,'ARAT DE LA CRUZ',4,'5564634135',1,32),(2842,'ARTEMIO CATILLO',4,'5544487166',1,32),(2843,'ARTURO BRITO',4,'5582447465',1,32),(2844,'ARTURO COLIN',4,'5545453598',1,32),(2845,'ARTURO PECK',4,'5578314751',1,32),(2846,'ARTURO VIVEROS VICTORIANO',4,'5548556511',1,32),(2847,'ARTUROFERNANDEZ TOBILLA',4,'5541452650',1,32),(2848,'AXEL BALDERAS',4,'5569302092',1,32),(2849,'BEATRIZ MATEOS',4,'5510623161',1,32),(2850,'BEATRIZ ROBLES',4,'SN',1,32),(2851,'BEATRIZ SANCHEZ VILLEGAS',4,'5612676191',1,32),(2852,'BLANCA PEREZ GONZALES',4,'5534761794',3,32),(2853,'BRANDON JOSE LOPEZ',4,'5574508766',1,32),(2854,'BRAYAN HERNANDEZ',4,'5616518312',1,32),(2855,'BRENDA CASTILLO',4,'5548960316',1,32),(2856,'BRENDA ELIAS',4,'5579195681',4,32),(2857,'BRIAN LUCERO PEREZ',4,'5572939141',1,32),(2858,'CARLA CABALLERO',4,'5611748925',1,32),(2859,'CARLOS ARIEL RAMIREZ GONZALEZ',4,'5548330158',1,32),(2860,'CARLOS CAMPOS CESPEDES',4,'5510983862',3,32),(2861,'CARLOS PEÑALOZA',4,'5620312641',1,32),(2862,'CARLOS RODOLFO GOMEZ MARTINEZ',4,'5538542168',1,32),(2863,'CECILIA VELAZQUEZ',4,'5591434357',1,32),(2864,'CESAR CORTEZ',4,'5573498579',1,32),(2865,'CESAR ERNESTO ORTEGA MEDINA',4,'5611109798',1,32),(2866,'CESAR JUAREZ',4,'SN',1,32),(2867,'CHAVARRIA CACERES ARATH',4,'55 6888 6904',1,32),(2868,'CHRISTIAN RODRIGUEZ',4,'8126944660',1,32),(2869,'CHRISTOPER LOZADA DIAZ',4,'SN',1,32),(2870,'CLAUDIA GUERRERO VEGA',4,'5584038041',1,32),(2871,'CONCEPCION VALTIERRA',4,'5564227841',1,32),(2872,'CRISTIAN RAMIREZ C.',4,'5580714398',1,32),(2873,'CRISTINA AMARO SANCHEZ',4,'5518374926',1,32),(2874,'CRISTOBAL BAUTISTA MARTINEZ',4,'5540571357',1,32),(2875,'CRISTOPHER FERNANDEZ MIRANDA',4,'5621900026',1,32),(2876,'DANIEL GARCIA CANO',4,'5576885160',1,32),(2877,'DANIEL SANCHEZ',4,'5576675089',1,32),(2878,'DARWIN MONTEJO',4,'5548654809',4,32),(2879,'DAVID JOSE LUNA',4,'5610057734',1,32),(2880,'DAVID MORALES C',4,'3125953830',1,32),(2881,'DEREK',4,'SN',1,32),(2882,'DIANA GARCIA',4,'5584250830',1,32),(2883,'DIANA GLADIS VIZUET GARCIA',4,'5618191335',1,32),(2884,'DIANA ITZEL HERNANDEZ IBARRA',4,'SN',1,32),(2885,'DIANA OLALDE',4,'5560274552',1,32),(2886,'DIANA ROSALES',4,'5576727016',1,32),(2887,'DIEGO JAIMES',4,'55 2861 1348',3,32),(2888,'DIEGO SANCHEZ ARANDA',4,'5582740899',1,32),(2889,'EBETH SERVIN',4,'5584314782',1,32),(2890,'EDGAR LUNA',4,'5615105425',1,32),(2891,'EDGAR MARQUEZ',4,'5511865947',1,32),(2892,'EDGAR RAMIREZ DIAZ',4,'8123532177',1,32),(2893,'EDGAR SANTAMARIA',4,'5523135880',1,32),(2894,'EDUARDO RAMIREZ',4,'5626369333',1,32),(2895,'EDUARDO ROMERO',4,'5566355498',1,32),(2896,'EDUARDO SERRANO',4,'5569306310',1,32),(2897,'EDWIN JAVIER',4,'5635626822',1,32),(2898,'EERY GONZALEZ FRANCO',4,'5624076116',1,32),(2899,'ELENA SOTO',4,'5537715586',1,32),(2900,'ELIZABETH FLORES (POLICIA)',4,'5564539154',4,32),(2901,'ELIZABETH JARILLO',4,'5532102159',1,32),(2902,'ELIZABETH ROSALES',4,'5514732927',1,32),(2903,'EMANUEL HERNANDEZ',4,'35787335',1,32),(2904,'EMILIO RAMIREZ',4,'5613044064',1,32),(2905,'ENRIQUE CABALLERO',4,'5525447571',1,32),(2906,'ENRIQUE LAREDO',4,'5627167051',3,32),(2907,'ERICK ANTONIO PEREZ',4,'5530563032',1,32),(2908,'ERICK AVILA GONZALES',4,'5620992113',1,32),(2909,'ERICK SANCHEZ',4,'5534553211',1,32),(2910,'ERICK SCHUBERT',4,'8661608759',1,32),(2911,'ERIKA GUZMAN',4,'5559625774',1,32),(2912,'ERIKA SOLIS',4,'5514796708',1,32),(2913,'ERNESTO IBARRA',4,'SN',1,32),(2914,'FERNANDO MONFORT',4,'55 1878 9983',4,32),(2915,'FRANCICO MIRANDA',4,'5566904944',1,32),(2916,'FRANCISCO GOMEZ MEDELLIN',4,'SN',1,32),(2917,'FRANCISCO GOVE',4,'5582279122',1,32),(2918,'FRANCISCO HERNANDEZ',4,'7297074057',1,32),(2919,'GERARDO GARCIA PASCUALLI',4,'5578975535',1,32),(2920,'GERARDO NADAL',4,'5519422570',1,32),(2921,'GIOVANI HERNANDEZ',4,'5611257327',1,32),(2922,'GUADALUPE CORDERO',4,'5536438091',1,32),(2923,'GUADALUPE RODRIGUEZ',4,'5560556689',1,32),(2924,'GYM PALADION',4,'5563985378',4,32),(2925,'GYM PITBULL',4,'5617690914',4,32),(2926,'HANNIA MIGOYA',4,'5530395873',1,32),(2927,'HIRAM SANCHEZ',4,'5572053981',1,32),(2928,'HORACIO GUERRERO',4,'5531555787',1,32),(2929,'HUMBERTO VIDALCASTRO MONTES',4,'5538184204',1,32),(2930,'IKER JIMENEZ',4,'55 8182 5796',4,32),(2931,'IRMA VERGARA',4,'5525112906',1,32),(2932,'IRUA PEREZ',4,'5568915670',1,32),(2933,'ISRAEL ALBA RAMIRO',4,'5617027813',1,32),(2934,'ISRAEL HERNANDEZ',4,'5535550462',1,32),(2935,'IVAN RODRIGUEZ',4,'5516370594',1,32),(2936,'JACOBO ZULETA',4,'5512956250',1,32),(2937,'JAVIER DORANTES PEREZ',4,'5530239585',1,32),(2938,'JERICO GALVEZ LOPEZ',4,'5565271526',3,32),(2939,'JESSICA CHIANG',4,'5587934105',1,32),(2940,'JESSICA TOVAR GONZALEZ',4,'5536512909',1,32),(2941,'JESUS EFREN CRUZ MARTINEZ',4,'5545875505',1,32),(2942,'JESUS FLORES',4,'5523715260',1,32),(2943,'JESUS GONZALES',4,'5621004058',1,32),(2944,'JESUS GUTIERREZ',4,'SN',1,32),(2945,'JESUS MUÑIZ BARRAGAN',4,'5519149614',1,32),(2946,'JESUS NAVARRO RESENDES',4,'5514471822',1,32),(2947,'JESUS QUIROZ',4,'5528282425',1,32),(2948,'JHONATAN RAMIREZ MONROY',4,'5610293339',1,32),(2949,'JOAQUIN ARENAS',4,'5576182309',1,32),(2950,'JOHAN HERNAN ROCHAR',4,'5581707394',1,32),(2951,'JOHAN JAIMES',4,'5614565021',4,32),(2952,'JONATHAN MAYA',4,'5516224063',1,32),(2953,'JORGE ARGUELLO',4,'5549304278',1,32),(2954,'JORGE ARTURO ALVAREZ ROSAS',4,'5526929647',1,32),(2955,'JORGE AYALA',4,'5616099676',1,32),(2956,'JORGE F SOLIS',4,'5672029471',1,32),(2957,'JORGE GAMBOA',4,'9625136535',1,32),(2958,'JORGE GARRIDO',4,'5537113913',1,32),(2959,'JORGE LUIS LOPEZ REYES',4,'5629644840',1,32),(2960,'JORGE QUINTANA',4,'5537126295',1,32),(2961,'JOSE BARRERA',4,'5549668705',1,32),(2962,'JOSE DE JESUS CHAVEZ',4,'SN',1,32),(2963,'JOSE HERNANDEZ',4,'5513220281',1,32),(2964,'JOSE RAMOS SANCHEZ',4,'5527322794',1,32),(2965,'JOSUE MICHEL PETRIOLET CORTES',4,'5574955736',1,32),(2966,'JOSUE URIARTE',4,'5530565645',1,32),(2967,'JUAN CARLOS ARIAS',4,'5536960691',1,32),(2968,'JUAN CARLOS DOMINGUEZ',4,'5511480635',1,32),(2969,'JUAN CARLOS GOMEZ',4,'5522782297',1,32),(2970,'JUAN CARLOS PEREZ CONTRERAS',4,'5629560356',1,32),(2971,'JUAN MANUEL BRAVO MARTINEZ',4,'5630057691',1,32),(2972,'JUAN MANUEL CORDOBA',4,'SN',1,32),(2973,'JUAN PEREZ',4,'56258461',3,32),(2974,'JULIO CESAR ROMERO NAVARRETE',4,'5519241763',1,32),(2975,'JULIO GONZALEZ',4,'5354793046',1,32),(2976,'JULIO ISRAEL ANGELES',4,'5588043777',1,32),(2977,'JULIO LUNA',4,'5547032995',1,32),(2978,'JULIO MARTINEZ',4,'5534850424',1,32),(2979,'JULIO SANCHEZ RUIZ',4,'5512790276',1,32),(2980,'JULIO TERRON',4,'5564545139',1,32),(2981,'KAREN HERNANDEZ',4,'5522938850',1,32),(2982,'KAREN RODRIGUEZ',4,'5518253860',1,32),(2983,'KARLA ONTIVEROS',4,'5572066755',1,32),(2984,'KARLA SADOVAL',4,'5620417415',1,32),(2985,'KEVIN ALEJANDRO SILVA',4,'5543798630',1,32),(2986,'LEON ROMERO',4,'5544525359',1,32),(2987,'LEONARDO BARRERA',4,'5512125020',1,32),(2988,'LEONARDO COSME HERNANDEZ',4,'5633423921',1,32),(2989,'LEONARDO SANCHEZ',4,'579214691',1,32),(2990,'LEONEL MENDIOLA',4,'4251095663',1,32),(2991,'LILIANA AREVALO',4,'5539325470',1,32),(2992,'LILIANA ESCAMILLA',4,'5529978507',1,32),(2993,'LILIANA GOMEZ LOPEZ',4,'5528804859',1,32),(2994,'LOURDES PEREZ',4,'5514916626',1,32),(2995,'LOURDES REVELO',4,'6371183553',3,32),(2996,'LUIS ALBERTO ROJAS SEGURA',4,'5577624260',1,32),(2997,'LUIS BRIAN CALVA HERNANDEZ',4,'5539661387',1,32),(2998,'LUIS EDUARDO RODRIGUEZ',4,'5551365737',1,32),(2999,'LUIS ERICK MALDONADO',4,'5588053440',1,32),(3000,'LUIS FERNANDO VILLALOBOS',4,'5564533566',1,32),(3001,'LUIS FRANCO',4,'5632901793',1,32),(3002,'LUIS GERARDO',4,'SN',1,32),(3003,'LUIS HUERTA',4,'5578351106',1,32),(3004,'LUNA ENRIQUE',4,'5545896788 Y 5628531808',1,32),(3005,'MADELEINE PERZ',4,'5620163384',1,32),(3006,'MAIRA NALLELY RODRIGUEZ LUZ',4,'5531942726',1,32),(3007,'MALENA GARCIA',4,'5518440834',1,32),(3008,'MANUEL ALEJANDRO CASTRO MEZA',4,'6121081297',1,32),(3009,'MANUEL ALEJANDRO RAMIREZ ESTRADA',4,'SN',1,32),(3010,'MANUEL CERON',4,'5536301404',1,32),(3011,'MARCO CARRILLO',4,'5528545561',1,32),(3012,'MARCO CORDOBA',4,'SN',1,32),(3013,'MARCO GALLEGOS',4,'8110768486',1,32),(3014,'MARCO RANGEL OSORIO',4,'5580490911',3,32),(3015,'MARCO ROJAS',4,'SN',1,32),(3016,'MARCOS ROJAS',4,'5529591033',1,32),(3017,'MARIA DEL SOCORRO GARIBAY',4,'5531983375',1,32),(3018,'MARIA ELIZABETH MARQUEZ',4,'5519640715',1,32),(3019,'MARIBEL GUEVARA',4,'5560666382',1,32),(3020,'MARICARMEN ESPARZA',4,'5587084157',1,32),(3021,'MARINA AGUIRRE ISLAS',4,'5523930284',1,32),(3022,'MARINA PEREZ',4,'5535085881',1,32),(3023,'MARIO LUNA',4,'5521809269',1,32),(3024,'MARIO REYES',4,'5578379860',1,32),(3025,'MARLENE FLORES',4,'5514122696',1,32),(3026,'MARTIN SOLIS',4,'5565180034',1,32),(3027,'MAURICIO REA SAUCEDO',4,'6531135377',1,32),(3028,'MAURICIO ROSALES',4,'5617564890',1,32),(3029,'MELISA AMPUDIA',4,'5533831336',1,32),(3030,'MELY GARCIA',4,'5583309064',1,32),(3031,'MIGUEL ANGEL GARDUÑO',4,'5516441776',1,32),(3032,'MIGUEL ANGEL OLMEDO ESCAMILLA',4,'5611666511',1,32),(3033,'MIGUEL ANGEL PEREZ',4,'5523713151',1,32),(3034,'MIGUEL CAMPUZANO',4,'5630466043',1,32),(3035,'MIGUEL GAMBOA',4,'5532674779',1,32),(3036,'MIGUEL RODRIGUEZ',4,'5513670569',1,32),(3037,'MOICES GUTIERREZ',4,'5620897958',1,32),(3038,'MOISES ELIAS LOPEZ',4,'5516814862',1,32),(3039,'NAIFER CANTO',4,'9841768211',1,32),(3040,'NANCY SERRANO',4,'5574508766',1,32),(3041,'NICOLAS ANDRADE',4,'4441892440',1,32),(3042,'NORMA TONCHE',4,'5614936229',1,32),(3043,'NOZOMI RODRIGUEZ HERNANDEZ',4,'5586113981',1,32),(3044,'OLIVIA RODRIGUEZ',4,'5576959586',1,32),(3045,'OMAR CORONA',4,'5516293746',1,32),(3046,'OMAR MEDINA',4,'5621298137',1,32),(3047,'ORACIO GUERRERO',4,'5531555787',1,32),(3048,'ORLANDO CRUZ',4,'5548730580',1,32),(3049,'OSCAR ADRIAN LUCIO DIAZ',4,'5560799384',1,32),(3050,'OSVALDO NOYOLA',4,'5532320567',1,32),(3051,'OSWALDO MARTINEZ BARRERA',4,'5626914849',1,32),(3052,'PABLO MIRANDA',4,'5523398147',1,32),(3053,'PABLO SAMUEL',4,'5574348701',1,32),(3054,'PAOLA GARCIA',4,'5534860211',1,32),(3055,'PAOLA MORALES',4,'5628230412',1,32),(3056,'PAUL CASTILLO',4,'5569170694',1,32),(3057,'RAFAEL ESPINOZA',4,'5576091628',1,32),(3058,'RAFAEL MENES SANCHEZ',4,'5562984605',1,32),(3059,'RAFAEL ROBLEDO',4,'5571925411',1,32),(3060,'RAFAEL VAZQUEZ CARRILLO',4,'5513985805',1,32),(3061,'RAMON CONTRERAS',4,'5526613960',1,32),(3062,'RAMON HUERTA ARTOLA',4,'SN',1,32),(3063,'RAMON HUERTA ARTOLA',4,'5529089535',1,32),(3064,'RAMSES MARQUEZ',4,'5571797957',1,32),(3065,'RAMSES MERLOS',4,'5615881459',1,32),(3066,'RANDY ELI SUAREZ',4,'5624099910',1,32),(3067,'RAY BEJAR SANCHEZ',4,'5611981385',1,32),(3068,'RAYMUNDO ASCENCIO',4,'5530588052',1,32),(3069,'REBECA GOMEZ',4,'5527494495',1,32),(3070,'RICARDO CERVANTES',4,'5552149566',1,32),(3071,'RICARDO ESPINOZA',4,'5544477400',1,32),(3072,'RICARDO GONZALEZ',4,'5531986872',1,32),(3073,'RIGOBERTO IBAÑEZ JARAMILLO',4,'5511609621',1,32),(3074,'ROBERTO FABIAN ARAGON',4,'5585108278',1,32),(3075,'RODRIGO ZEDILLO',4,'5624680873',4,32),(3076,'ROGELIO HERNANDEZ',4,'5532521312',1,32),(3077,'ROGELIO LIRA',4,'5587349869',1,32),(3078,'ROSA TOVAR',4,'5587499025',1,32),(3079,'RUBEN MARTINEZ',4,'SN',1,32),(3080,'RUBEN ROMERO',4,'5527110949',1,32),(3081,'SAID GONZALEZ',4,'5548499493',1,32),(3082,'SALVADOR RANGEL',4,'5514552317',1,32),(3083,'SANDRA CENTENO',4,'5584970152',1,32),(3084,'SANDRA CRUZ CASTRO',4,'5581395922',1,32),(3085,'SARAI VALDEZ',4,'5574338512',1,32),(3086,'SAUL GARCIA',4,'5534766229',1,32),(3087,'SAUL SAGASTUME',4,'5584063787',1,32),(3088,'SEBASTIAN JIMENEZ',4,'5652280102',1,32),(3089,'SERGIO HERRERA',4,'5578700192',1,32),(3090,'SINTIA ESMERALDA TORRES HERNANDEZ',4,'5527739342',1,32),(3091,'SPORTICA',4,'5540213233',4,32),(3092,'SR. MEDINA',4,'SN',1,32),(3093,'SRA ROSALES SPORTICA',4,'SN',1,32),(3094,'SUSANA ORTEGA',4,'5583866733',1,32),(3095,'SUSANA SALGADO',4,'5587285987',1,32),(3096,'SUSANA VERONICA VALDEZ',4,'5520852392',1,32),(3097,'TANIA URIBE',4,'5561189492',1,32),(3098,'ULISES CRUZ SOTO',4,'5543268751',1,32),(3099,'ULISES MONRROY',4,'5524454448',1,32),(3100,'ULISES YAIR GARCIA',4,'5612208088',1,32),(3101,'VERONICA BATREZ',4,'5545382450',1,32),(3102,'VICTOR COLORADO CARRAZCO',4,'5582028680',1,32),(3103,'VICTOR LEONARDO',4,'5573100218',1,32),(3104,'VICTOR LIRA',4,'SN',1,32),(3105,'VICTOR RANGEL',4,'5630096256',1,32),(3106,'VICTOR VAZQUEZ',4,'SN',1,32),(3107,'WENDY KARINA CRUZ',4,'5621584817',1,32),(3108,'YAIR',4,'5534955422',1,32),(3109,'YAMETH MEDINA',4,'5514555931',3,32),(3110,'YAZMANIC FRAGOSO DURAN',4,'5584322827',1,32),(3111,'YAZMIN GOMEZ QUINTANA',4,'5513084431',1,32),(3112,'YOSHIO GARCIA ROBLES',4,'5564425894',1,32),(3113,'YRIDIAN ROMO',4,'5570070084',4,32),(3114,'ZURI OROZCO',4,'5512973600',1,32),(3115,'JORGE ZAMUDIO',4,'5531262515',1,32),(3116,'JULIO CESAR MEJIA GOMEZ',4,'5551958203',1,32),(3117,'DAVID CRUZ',2,'5565198559',1,28),(3118,'ELIZABETH HERNANDEZ',2,'5632440055',1,28),(3119,'GUADALUPE ARREOLA',2,'5530653939',1,28),(3120,'XENIA PERINORTE',2,'5526895429',1,28),(3121,'ALAN JESUS JIMENEZ',2,'5619875299',1,25),(3122,'ALEJANDRO MIRANDA',2,'5620704793',1,25),(3123,'ALEJANDRO PAZ',2,'5569175325',1,25),(3124,'ALEXIA CORTES',2,'5539853945',1,25),(3125,'ALEXIS GOMEZ',2,'5571138780',1,25),(3126,'ALMA CELEDON',2,'5620241677',1,25),(3127,'ANTONIO GARCIA',2,'5618710396',1,25),(3128,'BRHAYANN VAZQUEZ (1 PUBLICO)',2,'5636941763',1,25),(3129,'CARLOS LOPEZ',2,'5638126196',1,25),(3130,'CAROLINA ROMERO',2,'5630932153',1,25),(3131,'CELESTINO MARTINEZ',2,'5516135635',1,25),(3132,'CHRISTIAN SALAZAR',2,'5540878434',1,25),(3133,'CHRISTIAN ZUÑIGA',2,'5581189623',4,25),(3134,'CLAUDIA CASTAÑEDA GONZALEZ',2,'5531443616',1,25),(3135,'DAVID CONDE',2,'7221939549',1,25),(3136,'EBERARDO CRUZ',2,'5615705609',1,25),(3137,'EDGAR HERNANDEZ',2,'5513795490',1,25),(3138,'EDGAR RAMIREZ',2,'5531914393',1,25),(3139,'EDUARDO LOPEZ',2,'5628237913',1,25),(3140,'EMILIANO MONROY',2,'5573738581',1,25),(3141,'EMILIANO SALAZAR',2,'5583597687',1,25),(3142,'ENRIQUE GOMEZ',2,'5636505763',1,25),(3143,'ENRIQUE MELENDEZ ALPHA FITNESS',2,'5627666503',4,25),(3144,'ENRIQUE RICO VIVAS',2,'5566070695',1,25),(3145,'ESPERALDA PERDOMO',2,'5530772258',1,25),(3146,'FABRICIO',2,'5256323462',1,25),(3147,'FAVIO GARCIA',2,'SN',1,25),(3148,'FERNANDO ROJAS',2,'5545405264',1,25),(3149,'GUADALUPE GALBAN',2,'5524157402',1,25),(3150,'GUILLERMO CHAVEZ',2,'5535712294',1,25),(3151,'GUILLERMO CORONA',2,'5572229728',1,25),(3152,'GUSTAVO GARCIA',2,'5571355915',1,25),(3153,'HEY GYM LA QUEBRADA',2,'5524263057',4,25),(3154,'HUGO RIVAS',2,'5624481227',1,25),(3155,'IRON SOUL GYM',2,'5617760171',4,25),(3156,'JESSICA HERNANDEZ ADN GYM',2,'5540547504',4,25),(3157,'JONATHAN CHICO',2,'5514753033',1,25),(3158,'JONATHAN EDAHIN PEREZ',2,'5536086614',1,25),(3159,'JONATHAN GERARDO OLVERA MORALES',2,'5581445258',1,25),(3160,'JORGE ALEXIS ZAMORATEGUI',2,'5548582092',1,25),(3161,'JORGE PALACIOS',2,'5565094891',1,25),(3162,'JOSE ALBERTO RAMIREZ GARCIA',2,'5518031101',1,25),(3163,'JOSE LUIS MACIAS',2,'5515859599',1,25),(3164,'JOSE LUIS PICHARDO',2,'5583669399',1,25),(3165,'JOVANI AREVALO GONZALEZ',2,'5639703872',1,25),(3166,'KARLA BEATRIZ ROMERO',2,'5615048236',1,25),(3167,'LUIS ALBERTO HUESCA CORDERO',2,'5535773793',1,25),(3168,'LUIS CASTRO',2,'5576881391',1,25),(3169,'LUIS ENRIQUE MELENDEZ SIERRA',2,'5560922252',1,25),(3170,'MANUEL VAZQUEZ GYM VERSUS',2,'5616504548',4,25),(3171,'MARIO CARREÑO SPORT FIV3 FYM',2,'5585659381',4,25),(3172,'MELANI MEZA',2,'5545282282',1,25),(3173,'MIGUEL ANGEL SILVA',2,'5512956885',1,25),(3174,'MOISES SANCHEZ',2,'5565797446',1,25),(3175,'NAYELI VALENCIA',2,'5511345958',1,25),(3176,'OMAR JUAREZ',2,'2382235260',1,25),(3177,'OMAR MARTINEZ',2,'5513798433',1,25),(3178,'OMAR VAZQUEZ',2,'5514026088',1,25),(3179,'PABLO ZENTENO',2,'5551979885',1,25),(3180,'RAQUEL REYES',2,'5543728307',1,25),(3181,'RHINO GYM',2,'5532867392',4,25),(3182,'RICARDO KHALIL RAMIREZ GARCIA',2,'5562017956',1,25),(3183,'ROBERTO CARLOS GARCIA BARRIOS',2,'5580156030',1,25),(3184,'ROBERTO PORTILLO',2,'5511433778',1,25),(3185,'SALVADOR CRUZ',2,'5579184809',1,25),(3186,'SERGIO LUNA',2,'5540576596',1,25),(3187,'SPARTANS CROSSFITERS',2,'5522635447',4,25),(3188,'TERKOS GYM',2,'5513992746',4,25),(3189,'ANDRES ROBLES MARTINEZ',2,'5618535775',1,25),(3190,'Blanca Estela Esparta Gym',7,'5539406303',4,29),(3191,'CARLOS MIRANDA',7,'5520271410',1,29),(3192,'CESAR GARCÍA',2,'5544427329',1,25),(3193,'CRISTIAN SANTANA',2,'5565568206',1,25),(3194,'EDGAR TORRES',2,'SN',1,25),(3195,'EMMANUEL GARCIA SANCHEZ',2,'5540970889',1,25),(3196,'ISAI GONZALEZ RAMIREZ',2,'5620064105',1,25),(3197,'LEONARDO KIM',2,'5539291812',1,25),(3198,'MAR SOSA',2,'5635501328',1,25),(3199,'PEDRO CRUZ',2,'5621718958',1,25),(3200,'RENE HERNANDEZ',2,'5585369980',1,25),(3201,'ABIGAIL GARRIDO',7,'8134075346',1,29),(3202,'ABRIL CONDE',7,'5532297946',1,29),(3203,'ADRIAN AGUILAR',7,'5530194893',1,29),(3204,'ADRIAN CERON RAMIREZ',7,'5535060144',1,29),(3205,'ALAN',7,'5525384103',1,29),(3206,'ALAN JAHIR GONZALEZ',7,'5514216991',1,29),(3207,'ALBERTO ELIZONDO',7,'5526579384',1,29),(3208,'ALBERTO MUÑOZ TOLEDO',7,'5630265678',1,29),(3209,'ALBERTO OCAMPO DE LA CRUZ',7,'5543809545',1,29),(3210,'ALBERTO PALMA',7,'7296831317',1,29),(3211,'ALEJANDRO GARCIA MARTINEZ',7,'SN',1,29),(3212,'ALEJANDRO JIMENEZ',7,'5530568378',1,29),(3213,'ALEJANDRO MENDOZA',7,'5565032402',1,29),(3214,'ALEXIA DOMINGUEZ',7,'5548891360',1,29),(3215,'ALEXIS ROBLES',7,'5575246846',1,29),(3216,'ALICIA MATAMOROS RAMIREZ',7,'5523419210',1,29),(3217,'ALICIA SOLIS',7,'5545545795',1,29),(3218,'ANAYELI MARTINEZ AQUINO',7,'5545908380',1,29),(3219,'ANGEL GABRIEL LOPEZ',7,'5526620431',1,29),(3220,'ANTONIO RAMIREZ',7,'5528794087',1,29),(3221,'ARMANDO LOPEZ',7,'5543615145',1,29),(3222,'ARTURO PEREZ',7,'5545905605',1,29),(3223,'ARTURO SUAREZ',7,'SN',1,29),(3224,'AXEL',7,'2261055810',1,29),(3225,'AXEL RODRIGUEZ',7,'3314216540',1,29),(3226,'BEATRIZ GARCIA',7,'5591257704',1,29),(3227,'BELEN AVY JHOANA AGUILAR MARQUEZ',7,'5573475993',4,29),(3228,'BENICIO MARTINEZ OLIVARES',7,'5554674445',1,29),(3229,'BERNABE PEREZ RAMIREZ',7,'5587720880',1,29),(3230,'BLANCA MORALES',7,'5516981581',1,29),(3231,'BRANDON TERAN',7,'5529473598',1,29),(3232,'BRENDA KARINA',7,'5510159780',1,29),(3233,'BUKER SOLIS',7,'5587910264',1,29),(3234,'CARLOS ADRIAN LOPEZ ARELLANES',7,'5634720953',1,29),(3235,'CARLOS ALBERTO HERNANDEZ',7,'5516237198',1,29),(3236,'CARLOS DANIELVEGA PICAZO',7,'5522635389',1,29),(3237,'CARLOS EDUARDO BAUTISTA HERNANDEZ',7,'5520725193',1,29),(3238,'CARLOS ELIAS MARQUEZ',7,'5532221536',1,29),(3239,'CARLOS MANUEL ROSAS',7,'5610140014',1,29),(3240,'CARMELO MOLINA',7,'SN',1,29),(3241,'CARMEN ESTELA HERNANDEZ VAZQUEZ',7,'5531959325',1,29),(3242,'CAROL CRUZ',7,'5548037387',1,29),(3243,'CECILIA ALCANTARA',7,'SN',1,29),(3244,'CESAR ABRAHAM JUAREZ',7,'5519813015',1,29),(3245,'CESAR ALBERTO ARRES SANTOS',7,'9932797907',1,29),(3246,'CHRISTIAN FERNANDO RUIZ',7,'5535590869',1,29),(3247,'CHRISTIAN ULISES HERNANDEZ MARTINEZ',7,'5626720355',1,29),(3248,'CHRISTIAN URIEL',7,'5583477519',1,29),(3249,'CHRISTOPHER BERNARDO',7,'5632359369',1,29),(3250,'CITLALI PAOLA',7,'5639623520',1,29),(3251,'CLARA CHAVEZ',7,'5520578362',1,29),(3252,'CRESCENCIO MARIN TORRES',7,'5585428944',1,29),(3253,'DAMIAN LEON RAMIREZ',7,'5585177420',1,29),(3254,'DANIEL MEDERO',7,'5527504593',1,29),(3255,'DANIEL RAMIREZ MUÑIZ',7,'5535968131',1,29),(3256,'DARIO SALINAS ROMAN',7,'5582304772',1,29),(3257,'DAVID HERNANDEZ',7,'5613790311',1,29),(3258,'DAVID ISMAEL ARELLANES',7,'5585398517',1,29),(3259,'DAVID TAPIA',7,'5636133173',1,29),(3260,'DIANA SANCHEZ',7,'5545924943',1,29),(3261,'DIEGO CUREÑO TRUJILLO',7,'5581433614',1,29),(3262,'DIEGO ISAI GALLEGOS GARCIA',7,'5623979366',1,29),(3263,'EDGAR HERNANDEZ SUAREZ',7,'5621099280',1,29),(3264,'EDUARDO CASTRO',7,'5612628286',1,29),(3265,'EDUARDO REMIGIO ROSALES',7,'5510162847',1,29),(3266,'EDUARDO SOTELO GARCIA',7,'SN',1,29),(3267,'EDUARDO URBAN',7,'5576817172',1,29),(3268,'ELENA RENDON GARCIA',7,'6674582751',1,29),(3269,'ELIZABETH RAMIREZ',7,'5614108453',1,29),(3270,'ELMER CARBAJAL',7,'9516530028',1,29),(3271,'EMILIANO MORALES',7,'5512930944',1,29),(3272,'ENRIQUE ACEVES',7,'4497576262',1,29),(3273,'ENRIQUE CASAS',7,'5635634204',1,29),(3274,'ENRIQUE SAN JUAN',7,'5579942528',1,29),(3275,'ERICK DAMIAN SILVA',7,'5537085290',1,29),(3276,'ERICK MENDOZA',7,'5620266117',1,29),(3277,'ERICK ROJANO',7,'5582137587',1,29),(3278,'ERNESTO FLORES GARCIA',7,'5576626615',1,29),(3279,'ERNESTO MORALES',7,'SN',1,29),(3280,'ERNESTO SANCHEZ TORRES',7,'5586787505',1,29),(3281,'FAUSTINO YOREL',7,'5633385842',1,29),(3282,'FERNANDO DE LA CRUZ',7,'5535295966',1,29),(3283,'FERNANDO EDGAR',7,'5624185138',1,29),(3284,'FERNANDO GOMEZ TRUJANO',7,'5581595814',1,29),(3285,'FRANCISCO ESPARZA',7,'SN',1,29),(3286,'FRANCISCO MARTINEZ',7,'5539554101',4,29),(3287,'FRANKLIN GABRIEL TORRES MEDINA',7,'5512291467',1,29),(3288,'FREDDY JAVIER NERI',7,'5548523136',1,29),(3289,'GABRIEL AMBRIZ',7,'5618517586',1,29),(3290,'GABRIEL CHAVEZ',7,'5580033676',1,29),(3291,'GAEL LOPEZ',7,'5547892167',1,29),(3292,'GERARDO RAYON DIAZ',7,'5522015715',1,29),(3293,'GREGORIO EMANUEL TOVAR',7,'5591672557',1,29),(3294,'GUSTAVO SANDOVAL',7,'5591959233',1,29),(3295,'GUSTAVO YAÑEZ',7,'5611805410',1,29),(3296,'IRVING GONZALEZ',7,'5518123260',1,29),(3297,'ISAAC PEREZ',7,'5587680084',1,29),(3298,'ISMAEL AVILES',7,'5512306628',1,29),(3299,'ISMAEL GOMEZ',7,'5544867011',1,29),(3300,'ISRAEL RUIZ',7,'5540689838',1,29),(3301,'JANET CRUZDEL ANGEL',7,'5551808034',1,29),(3302,'JAQUELINE BARRANCO MADRID',7,'2226108002',1,29),(3303,'JAVIER CERVANTES',7,'5559636073',1,29),(3304,'JAVIER HERNANDEZ MORALES',7,'8995175446',1,29),(3305,'JAVIER PEREZ',7,'5510165662',1,29),(3306,'JAVIER SALINAS SPORT CITY',7,'5511940167',4,29),(3307,'JEOVANI ESTRADA',7,'SN',1,29),(3308,'JESUS AZCATL',7,'5536679757',1,29),(3309,'JESUS CRISTIAN CORTEZ',7,'5564642825',1,29),(3310,'JESUS EDUARDO AMBRIZ OVIEDO',7,'5526868843',1,29),(3311,'JESUS FLORES PEREZ TTE.',7,'5540781673',3,29),(3312,'JESUS GONZALEZ CERVANTES',7,'5548385988',1,29),(3313,'JESUS VANEGAS',7,'5580373919',1,29),(3314,'JESUS ZAMBRANO',7,'5547986665',1,29),(3315,'JOEL VERDUGO LOPEZ',7,'5616048983',1,29),(3316,'JONATHAN MERCADO',7,'5574415758',1,29),(3317,'JORGE CARMONA',7,'5511331369',1,29),(3318,'JORGE GONZALEZ',7,'SN',1,29),(3319,'JORGE JUAREZ',7,'5581660532',1,29),(3320,'JORGE MUÑOZ TREJO',7,'5582108256',1,29),(3321,'JORGE TORIBIO HERNANDEZ',7,'5614380225',1,29),(3322,'JORGE VAZQUEZ',7,'5548651912',1,29),(3323,'JOSE ANTONIO SANTANA GARCIA',7,'5545677984',1,29),(3324,'JOSE ARNULFO RODRIGUEZ RODRIGUEZ',7,'5537135197',1,29),(3325,'JOSE IVAN ZARATE RODRIGUEZ',7,'9513024632',1,29),(3326,'JOSE JOEL GIL LARA',7,'5561377708',1,29),(3327,'JOSE LUIS CASTILLO GONZALEZ',7,'5546695020',1,29),(3328,'JOSE LUIS HERNANDEZ',7,'7298113339',4,29),(3329,'JOSE MANUEL GARCIA HERNANDEZ',7,'5544773568',1,29),(3330,'JOSE RAMONREYES LOMELI',7,'5534446767',3,29),(3331,'JOSE RAUL VELAZQUEZ LOPEZ',7,'5538825403',1,29),(3332,'JOSE SEBASTIAN RODRIGUEZ PEREZ',7,'9611747834',1,29),(3333,'JOSUE UGALDE',7,'5586025986',1,29),(3334,'jUAN  Y LESLIE SALVADOR NIRVANA FITNESS',7,'5511947854',4,29),(3335,'JUAN ALBERTO FLORES HERNANDEZ',7,'5512732344',1,29),(3336,'JUAN CARLOS GONZALEZ',7,'5538837183',3,29),(3337,'JUAN CARLOS PACHECO',7,'5591964716',1,29),(3338,'JULIO MACIEL',7,'5574791850',1,29),(3339,'KARINA QUINTANA',7,'5560316818',1,29),(3340,'KATHERINE MORALES',7,'5521320797',1,29),(3341,'KEVIN ALVAREZ',7,'5527602021',1,29),(3342,'Laura Olvera',7,'5515801528',1,29),(3343,'LEONEL ZALAZAR ALVA',7,'2382493718',1,29),(3344,'LESLY GARCIA',7,'5522018448',1,29),(3345,'LIZANDRO HERRERA YEPEZ',7,'4621023064',1,29),(3346,'LIZBETH JACOB ORTIZ',7,'5519569954',1,29),(3347,'LORENA DE LA TORRE',7,'5574651747',1,29),(3348,'LOURDES ARREOLA',7,'9181120613',1,29),(3349,'LUCIA MOLINA',7,'5636868201',1,29),(3350,'LUIS ANGEL ORTUÑO',7,'5583978734',1,29),(3351,'LUIS DÍAZ',7,'5575362985',1,29),(3352,'LUIS JAVIER MORALES ORTIZ',7,'5554599079',1,29),(3353,'LUIS RAYMUNDO HERNANDEZ HERNANDEZ',7,'5626853567',1,29),(3354,'MANUEL BARAJAS MENDIOLA',7,'5570521188',4,29),(3355,'MARCO ANTONIO AYALA',7,'8721136003',1,29),(3356,'MARCO ANTONIO CORTEZ',7,'SN',1,29),(3357,'MARCO ANTONIO LARA',7,'5554024611',1,29),(3358,'MARCO RAMIREZ',7,'7295428733',1,29),(3359,'MARGARITO GALLEGOS',7,'SN',1,29),(3360,'MARIBEL ASCENSION MARTINEZ',7,'5613361753',1,29),(3361,'MARINA MARTINEZ',7,'5534730235',1,29),(3362,'MARISELA DE JESUS',7,'5611603553',1,29),(3363,'MARISOL',7,'SN',1,29),(3364,'MARLENE CHAVEZ HERNANDEZ',7,'5521324953',1,29),(3365,'MARTIN PRADO',7,'5521338478',1,29),(3366,'MAURICIO MIRANDA',7,'5577916140',1,29),(3367,'MAYELA CAMARGO',7,'5548489518',1,29),(3368,'MAYRA KARINA PINZON',7,'5613604564',1,29),(3369,'MAYRA LETICIA JIMENEZ',7,'5523897230',1,29),(3370,'MELQUIADES MARTINEZ',7,'5612687456',1,29),(3371,'MIGUEL ACOSTA',7,'SN',1,29),(3372,'MIGUEL ANGEL GUERRERO',7,'5561284061',1,29),(3373,'MIGUEL ANGEL XACA TLAZALO',7,'5542846702',1,29),(3374,'MIRIAM HERNANDEZ',7,'5573342532',1,29),(3375,'MOERIS MICHAEL MARTINEZ SANCHEZ',7,'5610465212',1,29),(3376,'MONICA ROQUE',7,'5635569164',1,29),(3377,'MONSERRAT ESPINOZA',7,'5539085984',1,29),(3378,'NANCY COALAN',7,'5518480818',1,29),(3379,'NAYELI VAZQUEZ',7,'7971225625',1,29),(3380,'NERY ABIGAIL MENDIETA',7,'5561081297',1,29),(3381,'NOE MEDINA',7,'5536966256',1,29),(3382,'OCIEL VASQUEZ',7,'5512414697',1,29),(3383,'OSCAR FRANCISCO JIMENEZ ROSAS',7,'SN',1,29),(3384,'OSCAR MIGUEL HERNANDEZ',7,'5610647765',1,29),(3385,'OSCAR SANCHEZ',7,'3330622267',1,29),(3386,'PEDRO CEDILLO MARTINEZ',7,'5531365676',1,29),(3387,'PROCESO GIJON',7,'5515074808',1,29),(3388,'REBECA BUCIO',7,'5530206197',1,29),(3389,'RICARDO MORENO',7,'5522554304',1,29),(3390,'RICARDO RIVERA',7,'SN',1,29),(3391,'ROBERTO GUTIERREZ',7,'5562189217',1,29),(3392,'ROBERTO SANTIAGO',7,'9542011284',1,29),(3393,'ROEL HERNANDEZ',7,'6131112918',1,29),(3394,'ROMAN DE LA CRUZ',7,'9617087652',1,29),(3395,'RUBEN ESCOBAR',7,'5633757631',1,29),(3396,'RUBEN HERRERA',7,'5621942480',1,29),(3397,'SANDRA FUENTE',7,'5575420862',1,29),(3398,'SANDRO BARAJAS',7,'5531236779',1,29),(3399,'SANTIAGO PEREZ GARCIA',7,'2921530827',1,29),(3400,'SAUL RODRIGUEZ',7,'5537141935',1,29),(3401,'SEBASTIAN CANDELARIO LOPEZ',7,'4522492096',1,29),(3402,'SERGIO ANTONIO',7,'SN',1,29),(3403,'TATY CARDIEL',7,'5560844210',1,29),(3404,'ULISES SALGADO',7,'5527514795',1,29),(3405,'ULISES TORRES SANCHEZ',7,'5549010521',1,29),(3406,'URIEL ARANA',7,'5511979199',1,29),(3407,'VANESSA RAMOS',7,'7444565542',1,29),(3408,'VERONICA GUTIERREZ',7,'5535225305',1,29),(3409,'VERONICA SAMARA ROMERO (MILITAR)',7,'5539639312',4,29),(3410,'VICTOR ANTONIO VAZQUEZ',7,'SN',1,29),(3411,'VICTOR GONZALEZ',7,'5585506891',1,29),(3412,'VICTOR JULIO GOMEZ',7,'5518978799',1,29),(3413,'WILLIAM NEFTALI',7,'5527514342',1,29),(3414,'XHUNAXHI OROPEZA',7,'5564943358',1,29),(3415,'YADIRA OLEA ROSIQUEZ',7,'SN',1,29),(3416,'YARELY RODRIGUEZ',7,'5573008428',1,29),(3417,'CELIA MUÑOZ GUTIERREZ',7,'SN',1,29),(3418,'DANIEL HERNANDEZ',7,'5520065617',1,29),(3419,'CRISTOPHER BRIAN BERNAL PEREZ',7,'5577967110',1,29),(3420,'ABEL POPOCA',7,'5568731413',1,29),(3421,'ABIGAIL SANCHEZ',7,'5561680839',1,29),(3422,'ADRIAN ISRAEL CASTILLEJOS',7,'5545951618',1,29),(3423,'ADRIAN PALMA',7,'5561008923',1,29),(3424,'ADRIAN PALMA',7,'5561009891',1,29),(3425,'ALAN FARIAS',7,'5614312792',1,29),(3426,'ALAN SANCHEZ',7,'5522552015',1,29),(3427,'ALBERTO BARRAGAN',7,'5616832564',1,29),(3428,'ALBERTO GUDIÑO',7,'5520965025',1,29),(3429,'ALBERTO RAMOS',7,'5540391928',1,29),(3430,'ALBERTO TAPIA',7,'5618669894',1,29),(3431,'ALBERTO VARELA ONOFRE',7,'7531095384',1,29),(3432,'ALDO SAMUEL LOPEZ CHAVEZ',7,'5521929049',1,29),(3433,'ALEJANDRO FLORES',7,'SN',1,29),(3434,'ALEJANDRO LEON',7,'5523841049',1,29),(3435,'ALEJANDRO PALMA',7,'5528658104',1,29),(3436,'ALEJANDRO ZUÑIGA',7,'SN',1,29),(3437,'ALEXANDER ZIGGY',7,'5611099830',4,29),(3438,'ALFONSO CAMACHO',7,'5510811976',1,29),(3439,'ANA MONROY',7,'5614030340',1,29),(3440,'ANDREA MEJIA TORRES',7,'7757517982',1,29),(3441,'ANGEL GABRIEL GONZALEZ',7,'5517244846',1,29),(3442,'ANTONIO CHAVEZ',7,'5545590699',1,29),(3443,'ARIANA PEREZ',7,'5626785030',1,29),(3444,'ARMANDO DANIEL LOPEZ RIVERA',7,'5584186651',1,29),(3445,'ARMANDO PEREZ',7,'5528966391',1,29),(3446,'ARMANDO PEREZ PANTOJA',7,'5587610021',1,29),(3447,'ARTURO GALAN',7,'5583645090',1,29),(3448,'AUGUSTO BARRERA',7,'5569717173',1,29),(3449,'AXEL LEONARDO',7,'5573656286',1,29),(3450,'BEATRIZ GARCIA',7,'5548453668',1,29),(3451,'BRENDA ESPINOZA ZAICO',7,'7352723539',1,29),(3452,'BRIAN ALEXIS GUTIERREZ',7,'5564801317',1,29),(3453,'BRIAN ARCE BAUTISTA',7,'5586190153',1,29),(3454,'BRIAN RAMIREZ',7,'5625292665',1,29),(3455,'CARLOS ALBERTO GARCIA',7,'5537441571',1,29),(3456,'CESAR GUERRERO',7,'5537303779',1,29),(3457,'CHRISTIAN CAMACHO',7,'5531039748',1,29),(3458,'CHRISTIAN EMANUEL GARCIA MARTINEZ GYM EBC',7,'5585799587',1,29),(3459,'CHRISTIAN RAMIREZ GONZALEZ',7,'5528921211',1,29),(3460,'CRISTIAN HERRERA',7,'5519521939',1,29),(3461,'CRISTIAN SAN JUAN',7,'5574413098',1,29),(3462,'CRISTINA ABOYTS',7,'SN',1,29),(3463,'CRISTINA VILLAGOMEZ',7,'7353225936',1,29),(3464,'DAMIAN MONDRAGON REYES',7,'5624225791',1,29),(3465,'DANIEL GARCIA',7,'8138821985',1,29),(3466,'DANIEL MARTINEZ',7,'5513856107',1,29),(3467,'DANIEL MENDEZ MAYA',7,'5548579041',1,29),(3468,'DANIEL RIOS',7,'5614815445',1,29),(3469,'DELFINO HILARIO MORALES',7,'5518039731',1,29),(3470,'DEREK TREJO CASTAÑEDA',7,'5632976183',1,29),(3471,'DIANA CRUZ',7,'5611814525',1,29),(3472,'DIEGO OMAR ESTRADA',7,'5513714474',1,29),(3473,'DIEGO REYES',7,'5584533721',1,29),(3474,'EDUARDO ANASTACIO CARRILLO',7,'5518203561',1,29),(3475,'EDUARDO ASCENCIO',7,'5545053152',1,29),(3476,'EDUARDO FRANCISCO MALAGA',7,'5510454205',1,29),(3477,'EDUARDO JOAQUIN MARQUEZ',7,'7225492421',1,29),(3478,'EDWIN CARAPIA BRAVO',7,'5621575726',1,29),(3479,'ELI OLIVARES',7,'9981264138',1,29),(3480,'ELIAS FLORES (CTE. EJERCITO)',7,'2225751873',4,29),(3481,'ENRIQUE MORENO REYES',7,'5516788720',1,29),(3482,'ERICK GONZALEZ',7,'7971314123',1,29),(3483,'ERICK LARA AGUILAR',7,'5548905916',1,29),(3484,'ERICK RAMIREZ ARANDA',7,'5532046252',1,29),(3485,'ERIKA MARGARITA ACOSTA',7,'5561024457',1,29),(3486,'ERIKA QUIROZ',7,'5531461277',1,29),(3487,'ERWIN FELIPE SIBAJA DE LOS SANTOS',7,'3332210180',1,29),(3488,'EZEKIEL ORTIZ',7,'5531336669',1,29),(3489,'EZEQUIEL CHACON MARTINEZ',7,'7294841054',1,29),(3490,'FERNANDO ALONSO',7,'5547820041',1,29),(3491,'FERNANDO JARAMIILO',7,'5542165387',1,29),(3492,'FRANCISCO JAVIER LANDEROS',7,'7296153621',1,29),(3493,'GABRIEL BELTRAN GUZMAN',7,'5540527675',1,29),(3494,'GABRIELA RICO',7,'SN',1,29),(3495,'GENARO SEBASTIAN PADILLA FLORES',7,'5632756090',1,29),(3496,'GUADALUPE LOBATO',7,'5574914524',1,29),(3497,'GUADALUPE QUINTERO',7,'7351614193',1,29),(3498,'GUSTAVO GARCIA VILLEGAS',7,'SN',1,29),(3499,'GUSTAVO PACHECO',7,'5588400863',4,29),(3500,'HECTOR HERNANDEZ',7,'6644831803',1,29),(3501,'HECTOR IVAN VAZQUEZ',7,'5580366642',1,29),(3502,'ISAAC LARA',7,'5632838716',1,29),(3503,'ISMAEL BENITO HERNANDEZ',7,'5548053338',1,29),(3504,'IVAN CUEVAS LOPEZ',7,'7441620099',1,29),(3505,'JAIR ALVAREZVITE',7,'5625884076',1,29),(3506,'JAQUELINE GOMEZ MARTINEZ',7,'SN',1,29),(3507,'JAVIER HERRERA CHAVEZ',7,'5525206620',1,29),(3508,'JEAN JIMENEZ',7,'5587628308',1,29),(3509,'JOEL CASIMIROHERNANDEZ',7,'5530414920',1,29),(3510,'JONATHAN MACIAS',7,'5574127303',1,29),(3511,'JORGE GUTIERREZ',7,'5579243645',1,29),(3512,'JOSE ANGEL AGUIRRE LOPEZ',7,'5528916453',1,29),(3513,'JOSE ANONIO GONZALEZ CASTELAN',7,'SN',1,29),(3514,'JOSE BARRIENTOS',7,'5579416811',1,29),(3515,'JOSE FERNANDOPOBLANO ORTIZ',7,'5519014062',1,29),(3516,'JOSE GUADALUPE GARCIA GARCIA',7,'5549011083',1,29),(3517,'JOSE LUIS PIZANO',7,'5532620511',1,29),(3518,'JOSE MANUEL PATIÑO RODRIGUEZ',7,'5515064053',1,29),(3519,'JOSE MORENO',7,'5564419628',1,29),(3520,'JOSE PABLO POPOCA',7,'5577832763',1,29),(3521,'JOSHUA EUGALDE',7,'5619442335',1,29),(3522,'JUAN CARLOS LOPEZ',7,'5535124431',1,29),(3523,'JUAN MANUEL COLIN REYES',7,'5527679602',1,29),(3524,'KAREN MEDINA',7,'5573671774',1,29),(3525,'KARINA MONZALVO ROJAS',7,'5513547503',1,29),(3526,'KEVIN URIEL ROJAS',7,'4761454354',1,29),(3527,'LETICIA DE LA CRUZ',7,'5543760787',1,29),(3528,'LETICIA ORTIZ SANDOVAL',7,'5543866894',1,29),(3529,'LUCIA JIMENEZ',7,'5510145300',1,29),(3530,'LUIS DANIEL MARIN',7,'5580780386',1,29),(3531,'LUIS ENRIQUE MENESES ALONSO',7,'5540908326',1,29),(3532,'LUIS FIERRO',7,'5513962816',1,29),(3533,'LUIS FRANCO CERRILLOS',7,'5513793825',1,29),(3534,'LUIS HERNANDEZ',7,'5544548152',1,29),(3535,'LUIS MANUEL ENCARNACION',7,'7731561855',1,29),(3536,'LUIS MURILLO',7,'5628071359',1,29),(3537,'LUZ MARTINEZ',7,'5534714096',1,29),(3538,'MANUEL BARAJAS MENDIOLA',7,'5570521188',4,29),(3539,'MARCELINO HERNANDEZ',7,'3333976641',1,29),(3540,'MARCO ANTONIO SANCHEZ',7,'5534419950',1,29),(3541,'MARCO ANTONIO SERRANO',7,'5618989145',1,29),(3542,'MARCO ANTONIO VARGAS BARAJAS',7,'5521960912',1,29),(3543,'MARCO LOPEZ',7,'5527573202',1,29),(3544,'MARCOS ALBERTO BAUTISTA',7,'5584268033',1,29),(3545,'MARIANA GONZALEZ ALBINO',7,'5615284281',1,29),(3546,'MARIBEL MENDEZ ALVARADO',7,'5527627337',1,29),(3547,'MARIZOL MALDONADO RODRIGUEZ',7,'5537877473',1,29),(3548,'MARTIN GYM JUAREZ',7,'5527133753',4,29),(3549,'MAYBED ESTEBAN ALLENDE',7,'SN',1,29),(3550,'MIGUEL ANGEL GUTIERREZ',7,'5532069729',1,29),(3551,'MIGUEL AVILES',7,'5581231052',1,29),(3552,'MIGUEL PENELE',7,'5591988899',1,29),(3553,'MIGUEL SOTO GARCIA',7,'5559099984',1,29),(3554,'MIGUEL TORRES',7,'5540174719',1,29),(3555,'MIRIAM GUZMAN POSADAS',7,'5537086833',1,29),(3556,'MOICES SAUL MIGUEL',7,'5531463812',1,29),(3557,'MONSERRAT ESTEBAN RAMIREZ',7,'5548648644',1,29),(3558,'NARCOS CALVILLO GUTIERREZ',7,'5624195448',1,29),(3559,'NEREO BAUTISTA',7,'5628016707',1,29),(3560,'OLIVER ALEXANDER LOPEZ',7,'55749037050 Y 5581763012',1,29),(3561,'OMAR AGUSTIN VALENTIN',7,'5525372783',1,29),(3562,'OMAR CEVADA',7,'5627886620',1,29),(3563,'OSCAR FRANCISCO SNACHEZ GUZMAN',7,'5582277500',1,29),(3564,'OSCAR MICHEL ANTONIO AQUINO',7,'5545193114',1,29),(3565,'OSCAR ROJAS',7,'5624332320',1,29),(3566,'OSVALDO ESPINOSA',7,'SN',1,29),(3567,'PAOLA CORTEZ',7,'SN',1,29),(3568,'PAOLA GARCIA N.',7,'2294591668',1,29),(3569,'PEDRO ANTONIO ESTEBAN ALVARADO',7,'5535046140',1,29),(3570,'PEDRO ORTIZ LOPEZ',7,'5622005053',1,29),(3571,'RAFAEL ADRIAN GARRIDO',7,'5576334788',1,29),(3572,'RAUL MENDEZ',7,'5558181715',3,29),(3573,'RICARDO A. HDZ. PALOMERA MILITAR',7,'2411362848',4,29),(3574,'RICARDO GARCIA',7,'2227862189',1,29),(3575,'ROBERTO HERNANDEZ',7,'5545699639',1,29),(3576,'ROBERTO RIVAS',7,'5511959003',1,29),(3577,'ROCIO LOPEZ Y PABLO GYM DEMOLEDOR',7,'5530762260',4,29),(3578,'RUBEN DÍAZ',7,'5577370912',1,29),(3579,'RUBEN TORRIJOS',7,'5626329731',1,29),(3580,'SANTIAGO RODRIGUEZ',7,'5569009352',1,29),(3581,'SARA BERENICE VALDEZ',7,'5564645340',1,29),(3582,'SAUL VALADEZ',7,'5615423795',1,29),(3583,'SERGIO DANIEL FABELA GARCIA',7,'5580339869',1,29),(3584,'SERGIO MONDRAGON',7,'5581249667',1,29),(3585,'SERGO MARTINEZ C',7,'5514261053',1,29),(3586,'TEODORA RIVERA GARCIA',7,'5537178035',4,29),(3587,'ULISES BERNAL LASCURAIN',7,'5521337834',1,29),(3588,'ULISES PALOMINO FLORES',7,'5533034382',1,29),(3589,'URIEL FLORES FRANCO',7,'7296259626',1,29),(3590,'VANESSA JARAMILLO',7,'5537921833',1,29),(3591,'YAIR AGUILAR',7,'5585682302',1,29),(3592,'YERMAIN ESPINOSA',7,'5591426758',1,29),(3593,'YOBANI SANTOS',7,'5520519473',1,29),(3594,'YORDI GARCIA RODRIGUEZ',7,'5579860090',1,29),(3595,'ZEB GUTIERREZ',7,'5510076139',1,29),(3596,'MIGUEL ANGEL CASAS',7,'5561678643',1,29),(3597,'SERGIO MARTINEZ N',7,'5514261053',1,29),(3598,'FRANCISCO SANCHEZ',7,'5617908798',1,29),(3599,'RODRIGO ROSAS',7,'5551763677',1,29),(3600,'LUIS ANGEL MARTINEZ MENDOZA',7,'5515628794',1,29),(3601,'MARIEL FRIAS ROSALES',3,'5517523095',1,37),(3602,'ABRAHAM ROMERO',3,'5620727199',1,37),(3603,'ADRIANA ASCENCIO ALVAREZ',3,'5571285543',1,37),(3604,'ADRIANA PEDRAZA',3,'5539133916',1,37),(3605,'ALAN CADENA',3,'5585764487',1,37),(3606,'ALAN ENRIQUE MEJIA',3,'5537048924',1,37),(3607,'ALAN FAJARDO',3,'5634686029',1,37),(3608,'ALBERTO MARTINEZ FUENTES',3,'5578990499',1,37),(3609,'ALBERTO MARTINEZ FUENTES',3,'5578990499',1,37),(3610,'ALEJANDRO MARTINEZ BARRON',3,'5534558619',1,37),(3611,'ALEXIS RUIZ ORTIZ',3,'5572187195',1,37),(3612,'ALFONSO GOMEZ RONIE GYM',3,'5526551322',4,37),(3613,'ALFONSO SEBASTIAN OJEDA',3,'5535547557',1,37),(3614,'ALICIA MENDOZA',3,'5571119356',3,37),(3615,'ANGEL FERNANDO RAMIREZ VARGAS',3,'5573468269',1,37),(3616,'ANGEL GONGORA',3,'5562523199',1,37),(3617,'ANGELICA ROMERO',3,'5522585697',1,37),(3618,'ANGELO FLORENCIO ROJAS',3,'5527124928',1,37),(3619,'ARIANA CRUZ LOPEZ',3,'5617360018',1,37),(3620,'ARMANDO MARTINEZ',3,'5612900950',1,37),(3621,'ASTRID BARRETO',3,'5591030223',1,37),(3622,'AURELIO MARTINEZ MARTINEZ',3,'5620211049',1,37),(3623,'BEATRIZ ALVAREZ VILLANUEVA',3,'5582668090',1,37),(3624,'BELEM CRUZ',3,'5531032587',1,37),(3625,'BRANDON ARTURO MONZON',3,'5639260915',1,37),(3626,'BRANDON MEJIA MOSQUEDA',3,'5613283688',1,37),(3627,'BRENDA RAMIREZ',3,'5527093713',1,37),(3628,'BRUNO CHAVEZ',3,'SN',1,37),(3629,'CARLOS EDUARDO PEDRAZA',3,'5546817988',1,37),(3630,'CARLOS GARCIA',3,'5580361033',1,37),(3631,'CARLOS TADEO RODRIGUEZ',3,'5614345427',1,37),(3632,'CECILIA MARIA FERNANDA GARDUÑO',3,'5565064165',1,37),(3633,'CRISTEL',3,'5633494570',1,37),(3634,'CRISTINA DE LA CRUZ',3,'5585631740',1,37),(3635,'DANIEL ANTONIO',3,'5571667638',1,37),(3636,'DANIEL BENITEZ',3,'5518042909',1,37),(3637,'DANIEL GOMEZ BOCANEGRA',3,'5630291436',1,37),(3638,'DANIEL JIMENEZ',3,'5634102885',1,37),(3639,'DANIEL URBINA JUAREZ',3,'5552891336',1,37),(3640,'DANIELA SATRE',3,'5650845283',1,37),(3641,'DARA SANCHEZ',3,'5587202366',1,37),(3642,'DAVID AGUILAR',3,'6242351930',1,37),(3643,'DAVID APOLINAR',3,'SN',1,37),(3644,'DAVID ORTIZ',3,'SN',1,37),(3645,'DAVID VILLANUEVA',3,'5579588057',1,37),(3646,'DAYANA ORTEGA',3,'5627490087',1,37),(3647,'DIANA ELIZABETH',3,'5582538457',1,37),(3648,'DIANA MENDOZA (1 PUBLICO)',3,'5619138983',1,37),(3649,'DIEGO ARMANDO BARRIOS ROA',3,'5566231914',1,37),(3650,'DIEGO OSNAYA RIVERA',3,'5540822123',1,37),(3651,'EDGAR CARREON',3,'5532546523',3,37),(3652,'EDUARDO DURAN',3,'5570821554',1,37),(3653,'EDUARDO ESPEJEL',3,'5514526739',1,37),(3654,'EDUARDO VERA',3,'5626410444',1,37),(3655,'ELIZABETH ALBIDRES',3,'5617030810',1,37),(3656,'EMANUEL VIZCAYA',3,'SN',1,37),(3657,'ENOE MOLINA GOMEZ',3,'SN',1,37),(3658,'ENRIQUE TAVERA',3,'5558278704',1,37),(3659,'ENRIQUE YNCLAN MARTINEZ',3,'5614485272',1,37),(3660,'ERICK JUAREZ',3,'5637126492',1,37),(3661,'ERNESTO JAVIER',3,'5543744625',1,37),(3662,'ERNESTO TELLEZ',3,'5548337186',1,37),(3663,'ERNESTO UMAÑA VEGA',3,'SN',4,37),(3664,'FELIPE MARTIN ARRIAGA',3,'722868575',1,37),(3665,'FELIPE SALINAS',3,'5542852946',1,37),(3666,'FERNANDO ESTRADA',3,'5534977119',1,37),(3667,'FERNANDO PRIETO',3,'5531884094',1,37),(3668,'FERNANDO VIDAL RAMON',3,'5576869693',1,37),(3669,'FLORA CRUZ REYES',3,'SN',1,37),(3670,'FRANCISCA VARGAS',3,'5530213414',1,37),(3671,'FRANCISCO TRONCOSO',3,'5583574916',1,37),(3672,'GERARDO PEÑA GUEVARA',3,'5515865756',1,37),(3673,'GIOVANNI HERRERA',3,'5564704643',1,37),(3674,'GIOVANNY TAPIA',3,'SN',1,37),(3675,'GUSTAVO AARON HERNANDEZ ZAVALA',3,'5566181780',1,37),(3676,'GUSTAVO GARDUÑO',3,'5534254003',1,37),(3677,'HECTOR MIGUEL MEDINA',3,'5564239270',1,37),(3678,'IAN HERNANDEZ CRUZ',3,'5560727924',1,37),(3679,'IGNACIO MARIN',3,'5516004891',1,37),(3680,'IGNACIO MARTIN',3,'5633192673',1,37),(3681,'ILDA RUIZ ECHEVERRIA',3,'5532537389',1,37),(3682,'ISAAC RAUL VARGAS CRUZ',3,'5613284904',1,37),(3683,'ISABEL ALVAREZ PEREZ',3,'2291260254',1,37),(3684,'ISAI CONTRERAS',3,'5626721487',1,37),(3685,'ISIEL ESCAMILLA VARGAS',3,'5540687491',1,37),(3686,'ISMAEL GIL VENEGAS',3,'5628548623',1,37),(3687,'ISRAEL PEÑALOZA',3,'5563493287',1,37),(3688,'IVON ZAVALETA',3,'5570750046',1,37),(3689,'JACQUELINE MIRANDA',3,'5617548121',1,37),(3690,'JAIME HERNANDEZ PEREZ',3,'5516311506',1,37),(3691,'JAZMIN CRUZ',3,'SN',1,37),(3692,'JEOVANI GARCIA MEJIA',3,'5584587710',1,37),(3693,'JEOVANI HERNANDEZ',3,'5533963749',1,37),(3694,'JEREMY CALIXTO',3,'5562276495',1,37),(3695,'JESSICA GOMEZ',3,'5549326619',1,37),(3696,'JESUS CENTENOS',3,'5534720729',1,37),(3697,'JESUS ENRIQUE HERNANDEZ',3,'553025655',1,37),(3698,'JESUS MACHUCA',3,'5551930080',1,37),(3699,'JONATHAN JIMENEZ',3,'5530442969',1,37),(3700,'JORGE EFRENFLORES ACEVES',3,'5564254823',1,37),(3701,'JORGE SANCHEZ DE LA BARQUERA',3,'5572245768',4,37),(3702,'JOSE ANGEL BARENCA',3,'5539786919',1,37),(3703,'JOSE JAVIER GUTIERREZ',3,'5615824454',1,37),(3704,'JOSE JUAN GOMEZ ROJAS',3,'5527623723',1,37),(3705,'JOSE MIGUEL VEGA',3,'5532528004',1,37),(3706,'JOSELYN BECERRA',3,'5523106258',1,37),(3707,'JOSEPH MICHEL LORA VARGAS',3,'5616138997',1,37),(3708,'JUAN ANTONIO AGUILAR',3,'5621278966',1,37),(3709,'JUAN CARLOS BERNAL ORDAZ',3,'5511215020',1,37),(3710,'JUAN CARLOS ESCALONA',3,'5546133401',1,37),(3711,'JUAN FRANCISCO LICEA',3,'5521517931',1,37),(3712,'JUAN IGNACIO ZARAGOZA MENDEZ',3,'5566592064',1,37),(3713,'JUAN MARTIN MEJIA',3,'5510966689',1,37),(3714,'JUAN PABLO HUERTA',3,'5547203294',1,37),(3715,'JULIA HERNANDEZ HERNANDEZ',3,'5626703271',1,37),(3716,'JULIO CESAR PEREDO',3,'5626417508',1,37),(3717,'JULIO CESAR PEREZ',3,'5512591897',1,37),(3718,'KARINA MARTINEZ BARRON',3,'5610603239',1,37),(3719,'KEVIN ZAID SOLIS RUBIO',3,'5537553689',1,37),(3720,'LAURA BADILLO',3,'5624021755',1,37),(3721,'LAURA VARGAS',3,'5564115202',1,37),(3722,'LEILANY DALAY OSORNIO NAVA',3,'5535124452',1,37),(3723,'LEOBARDO ISMAEL MENDOZA',3,'5626126273',1,37),(3724,'LILIA ELIZABETH GUADALUPE',3,'5620694915',1,37),(3725,'LILIANA MIRANDA',3,'5544932048',1,37),(3726,'LIZBETH BARRON',3,'5518731446',1,37),(3727,'LIZBETH FUENTES COLIN',3,'5570474384',1,37),(3728,'LIZZETH VARGAS',3,'5633744255',1,37),(3729,'LOURDES FERREIRA VAZQUEZ',3,'5526954647',1,37),(3730,'LUIS FERNANDO',3,'5560944320',1,37),(3731,'MANUEL VARGAS',3,'5544773825',1,37),(3732,'MARCO ANTONIO CASTILLO',3,'5584495917',1,37),(3733,'MARCO ANTONIO NAMBO RAMIREZ',3,'5517271891',1,37),(3734,'MARCO ANTONIO PEREZ',3,'5547960648',1,37),(3735,'MARCOS LOPEZ RIVERA',3,'5574464985',1,37),(3736,'MARIO ALBERTO LOPEZ',3,'5620914996',1,37),(3737,'MELANIE LUCIA VILLAGRAN CARRILLO',3,'5624735081',1,37),(3738,'MICHAEL ALAN CARBAJAL',3,'5565731251',1,37),(3739,'MIGUEL ANGEL AVALOS BETHER BODY',3,'5581477762',1,37),(3740,'MIGUEL ANGEL MORALES',3,'5635558011',1,37),(3741,'MIRKA SANCHEZ',3,'5531033205',1,37),(3742,'MIZRAIM RUBIO SEGUNDO',3,'5569173832',1,37),(3743,'MONSERRAT ZACARIAS',3,'5644376794',1,37),(3744,'NANCY GONZALEZ',3,'5621989559',1,37),(3745,'NANCY GUADARRAMA',3,'5515574039',1,37),(3746,'OMAR ISRAEL TELLEZ',3,'5636587054',1,37),(3747,'OSCAR JUAREZ',3,'5543417796',1,37),(3748,'OSCAR MARIO ROSAS HERNANDEZ',3,'5540254493',1,37),(3749,'OSWALDO TORRES',3,'SN',1,37),(3750,'PABLO AGUIRRE',3,'5575329825',1,37),(3751,'PABLO LOPEZ',3,'5535031532',1,37),(3752,'PAMELA DE LA CRUZ',3,'5578688778',1,37),(3753,'PATRICIA DEL RIO',3,'5574095443',1,37),(3754,'RAMIRO ALVARADO INSTRUCTOR',3,'SN',4,37),(3755,'RICARDO DE LA ROSA',3,'5541826719',1,37),(3756,'RODRIGO RIVERA',3,'9831683874',1,37),(3757,'ROSA ISELA MENDEZ',3,'5622144163',1,37),(3758,'SARA REYES',3,'5591875734',1,37),(3759,'SUSANA REYES',3,'5579256155',1,37),(3760,'TANIA DIAZ FLORES',3,'5617240408',1,37),(3761,'TANIA OCHOA',3,'5587999990',1,37),(3762,'TERESA JUAREZ LOPEZ',3,'5611687418',1,37),(3763,'ULISES RODRIGUEZ',3,'5548741266',1,37),(3764,'VANESA FLORES',3,'5519210014',1,37),(3765,'VANESSA VEGA',3,'5522975795',1,37),(3766,'VANIA VELAZQUEZ GONZALEZ',3,'5641057074',1,37),(3767,'VICTOR EMANUEL DELGADO',3,'5510073975',1,37),(3768,'VICTOR FLORES',3,'5537510731',1,37),(3769,'YOSTIN CARBALLO',3,'5551896625',1,37),(3770,'DANIEL GAZCA',3,'5532837288',1,37),(3771,'ELIZABETH GAMERO',3,'5572135931',1,37),(3772,'ERNESTO ALONSO',3,'SN',1,37),(3773,'JESUS FERNANDO ORTIZ REYES',3,'5517981030',1,37),(3774,'LOURDES MALDONADO',3,'SN',1,37),(3775,'EDUARDO OSORIO',3,'5619877131',1,37),(3776,'DANIEL MAXIMINO JIMENEZ',3,'5565333453',1,37),(3777,'KEVIN SOLIS',3,'5621093205',1,37),(3778,'LESLIE GONZALEZ',3,'5614336426',1,37),(3779,'SANDRA JUAREZ GONZALEZ',3,'5585658835',1,37),(3780,'SANDRA ORTIZ TENORIO',3,'5548622823',1,37),(3781,'DANIELA MONSERRAT JUAREZ',7,'5527875472',1,29),(3782,'VIDAURA GARCIA SANCHEZ',4,'5574313352',1,32),(3783,'JOSE LUIS GONZALEZ CRUZ',7,'5571960950',1,29),(3784,'SAMANTA OLAYO',4,'5617229487',1,32),(3785,'BRANDON GOROZTIETA TORRES',7,'5535222675',1,29),(3786,'OSCAR URIEL GARCIA',3,'SN',4,37),(3787,'ETEFANIA CARMONA MONRROY',7,'5624076585',1,29),(3788,'ENRIQUE VAZQUEZ',2,'5545652454',1,25),(3789,'ALEJANDRO RUIZ',7,'5579166704',1,29),(3790,'BORRE AKA',7,'5561347840',1,29),(3791,'CHRISTIAN ORTEGA RAMOS',7,'5610020281',1,29),(3792,'FRANCISCO EMMANUELLE INSTRUCTOR GYM SUPER',7,'5613868706',4,29),(3793,'HERLINDA MAYA AROYO INSTRUCTORA',7,'5552743024',4,29),(3794,'JOSUE RODRIGO LOPEZ LUNA',7,'9542013374',1,29),(3795,'LUIS GARCIA MIRALES INSTR',7,'5620439564',4,29),(3796,'luis mondragon gonzales',7,'5616708452',1,29),(3797,'ALAN ALVAREZ',7,'5628333704',1,29),(3798,'LEONARDO CEREZO CAMACHO',7,'3339561279',4,29),(3799,'ALBERTO ESQUIVEL',7,'5515826343',1,29),(3800,'JORGE HURTADO',7,'5618477036',1,29),(3801,'ROSA JIMENEZ',7,'5517022759',1,29),(3802,'SERGIO DE JESUS',7,'5579966239',1,29),(3803,'ALEJANDRO IRVIN GOMEZ PEREZ INSTRUCTOR',3,'5582603720',4,37),(3804,'JORGE LUIS ACOSTA (BROTHERS GYM´S)',3,'SN',4,37),(3805,'ASAI MARTINEZ GYM CHESMAN',3,'5623731911',4,37),(3806,'JOSEFATH BECERRA',3,'5573116472',1,37),(3807,'ALEJANDRO PEÑA ROSAS',2,'SN',4,25),(3808,'ALEJANDRO VAQUERO',2,'SN',3,25),(3809,'ALEX ROA',2,'SN',3,25),(3810,'ALFONSO RIVAS',2,'SN',3,25),(3811,'ALFREDO DIAZ',2,'SN',3,25),(3812,'ALFREDO RESENDIZ',2,'SN',4,25),(3813,'alfredo sanchez',2,'SN',3,25),(3814,'ANGEL PASTRADA',2,'SN',3,25),(3815,'ANTONIO GORDILLO',2,'SN',4,25),(3816,'ANTONIO RUEDA',2,'SN',3,25),(3817,'CESAR IVAN LOPEZ MARTINEZ',2,'SN',3,25),(3818,'CLAUDIA BONILLA',2,'SN',1,25),(3819,'CRISTIAN JASSO',2,'SN',1,25),(3820,'DANIEL ESPINOZA MEDINA',2,'SN',3,25),(3821,'DAVID CESAR VARGAS REBOLLOSO',2,'SN',4,25),(3822,'DAVID MARQUEZ',2,'SN',3,25),(3823,'EDUARDO DANIEL RUIZ',2,'SN',1,25),(3824,'EDUARDO GARCIA',2,'SN',4,25),(3825,'EFREN BECIEZ ESTETICA VIVEROS ASIS',2,'5554021534',4,25),(3826,'ERICK JUAREZ',2,'SN',1,25),(3827,'FRANCISCO GOMEZ PATIÑO',2,'SN',4,25),(3828,'GERARDO VALLE',2,'SN',3,25),(3829,'IRENE HERNANDEZ',2,'SN',1,25),(3830,'IVONNE HERNANDEZ',2,'SN',3,25),(3831,'JAVIER HERRERA',2,'SN',3,25),(3832,'JESSICA ROA',2,'SN',3,25),(3833,'JOSE JESUS GARCIA PÉREZ',2,'5549556127',4,25),(3834,'LUIS FERNANDO MUCINO',2,'SN',3,25),(3835,'MARCO ANTONIO VELASQUEZ PEÑA',2,'SN',3,25),(3836,'miriam aguilar',2,'SN',3,25),(3837,'NADIA VARGAS MONTOYA',2,'5581936200',3,25),(3838,'NELY NAVARRETE',2,'SN',4,25),(3839,'octavio cordoba',2,'SN',3,25),(3840,'octavio hernandez',2,'SN',1,25),(3841,'OSBALDO CIERRA',2,'SN',3,25),(3842,'RODRIGO MEJIA',2,'SN',1,25),(3843,'samanta',2,'SN',3,25),(3844,'selene morales',2,'SN',1,25),(3845,'SERGIO SANCHEZ',2,'SN',3,25),(3846,'PIERO LARA',2,'SN',4,25),(3847,'PÉDRO SOTO',2,'5520948312',1,25),(3848,'JUAN ERASTO REYES JACUINDE',2,'5537490177',4,25),(3849,'MIGUEL RAMIREZ SALDIVAR',2,'5540788032',1,25),(3850,'ZAYARI COPCA',2,'5528526163',3,25),(3851,'GABRIELA BECERRA FLORES',3,'5563993799',1,37),(3852,'ALAN DE SANTIAGO',7,'5539112979',1,29),(3853,'ALAN HUESCA',7,'5573875495',1,29),(3854,'ANDRES DE LOS SANTOS',7,'5579704438',1,29),(3855,'AVIMAEL ESTRADA MATIAS',7,'5516055852',1,29),(3856,'BRANDON HERNANDEZ',7,'5634057242',3,29),(3857,'CHRISTIAN ANAYA',7,'5571946959',1,29),(3858,'CHRISTIAN RAMIREZ SOTELO',7,'5625818524',1,29),(3859,'CRISTIAN MONTEZ',7,'5517406763',1,29),(3860,'ESMERALDA HIDALGO',7,'5621656068',1,29),(3861,'ESMERALDA ROMERO',7,'5570410861',1,29),(3862,'ESTEFANY GARCIA',7,'6675079903',1,29),(3863,'JOSE GARCIA',7,'5547205398',1,29),(3864,'LETICIA MENDEZ',7,'5545503438',1,29),(3865,'LUIS ENRIQUE LOPEZ',7,'5582355619',1,29),(3866,'LUIS MONDRAGON GOMEZ',7,'7151095757',1,29),(3867,'lulu hernandez',7,'5519324278',1,29),(3868,'MARIA DE LA PAZ TORREZ GUTIERREZ',7,'5574704313',1,29),(3869,'MONICA GUTIERRES',7,'5527093975',1,29),(3870,'RAFAEL GOMEZ MARTINEZ',7,'4622870733',1,29),(3871,'RUBEN ANGEL LOPEZ',7,'5523234596',1,29),(3872,'SERGIO DANIEL FABELA GARCIA',7,'5580339869',1,29),(3873,'VALERIA ROMERO JUAREZ',7,'5539766615',1,29),(3874,'alexis ariel velazquez martinez',7,'5626999262',1,29),(3875,'EDWIN MAURICIO GUTIERREZ GARCIA',7,'5579328215',1,29),(3876,'MAURICIO CHAVEZ INSTRUCTR',7,'5512895066',4,29),(3877,'RAFAEL JIMENEZ INSTRUCTR DE FUT FITNES GYM',7,'5531535450',4,29),(3878,'VICTORIA PEREZ',7,'5615314017',1,29),(3879,'KARINA BUENO DAVILA',3,'5518808676',1,37),(3880,'JANNET FLORES GUTIERREZ',6,'5527410826',1,30),(3881,'MAURO TOVAR NAVA',6,'5633360840',1,30),(3882,'ALEJANDRO REYNA',2,'5535564186',1,25),(3883,'ENERGYM HECTOR TENORIO',7,'5584096972',4,29),(3884,'BRENDA ABIGAIL',2,'5575249789',1,25),(3885,'GONZALO FLORES',2,'5579317461',1,25),(3886,'HECTOR MARTINEZ',2,'5549408625',1,25),(3887,'JOSE ARMANDO MARQUEZ RICARDIZ',3,'5537246126',1,37),(3888,'ABIGAIL GARCIA',2,'5528892616',1,25),(3889,'URIEL AKIN',3,'5513643218',1,37),(3890,'MANUEL ALEJANDRO LOCATARIO PTEC.',4,'5636585226',4,32),(3891,'ROBERTO TORIZ',4,'5522573619',4,32),(3892,'VERONICA PEREZ HERRERA',4,'5565223892',1,32),(3893,'ALAN REY JUAREZ',7,'5584008803',1,29),(3894,'ANGEL YAHIR MORA CHAVEZ',7,'5618280278',1,29),(3895,'CMTE IQUER DIAZ',7,'5532020045',4,29),(3896,'STEVE RUBIO',7,'5534400989',2,29),(3897,'ARACELI VAZQUEZ (ZONA FITNESS GYM)',2,'SN',1,25),(3898,'SAMUEL SANCHEZ',2,'5530384064',1,25),(3899,'AARON CAMPOS MARQUEZ',4,'5532787936',1,32),(3900,'ALEJANDRA MONZALVO',4,'5585575802',1,32),(3901,'ANDRES GONZALEZ MAYA',4,'SN',1,32),(3902,'BERNARDO HERNANDEZ',4,'5529660133',1,32),(3903,'BRENDA HURTADO',4,'5528245134',1,32),(3904,'CESAR MARTINEZ JIMENEZ',4,'5548509775',1,32),(3905,'DANIEL BORJA MARTINEZ',4,'5614969380',1,32),(3906,'DIEGO ALVAREZ',4,'5623994679',1,32),(3907,'EDUARDO SANGUINO',4,'5520858042',1,32),(3908,'EDWIN JESUS FRANCO',4,'5624615808',1,32),(3909,'ENRIQUE MARTINEZ',4,'5614074619',1,32),(3910,'ERICK ERNESTO GARCIA',4,'5548172415',1,32),(3911,'ERICK MIGUEL MORALES',4,'5561092186',1,32),(3912,'ETHAN RODRIGUEZ',4,'5632931448',1,32),(3913,'FERNANDO CASTILLO',4,'5569089769',1,32),(3914,'FERNANDO JUAREZ PEDRAZA',4,'5540059600',4,32),(3915,'FERNANDO SOSA RODRIGUEZ',4,'5529469408',1,32),(3916,'GABRIEL RAMIREZ HERRERA',4,'5537787884',4,32),(3917,'GEORGINA POE',4,'8123955215',1,32),(3918,'GUADALUPE RODRIGUEZ',4,'5543045350',1,32),(3919,'HAACKON BAHARUSH VAZQUEZ URBINA',4,'5618586396',1,32),(3920,'IMANOL TOPETE',4,'5576233802',1,32),(3921,'IRAZEMA MORALES',4,'5535530732',1,32),(3922,'IVAN ULISES RIOS',4,'8127584787',1,32),(3923,'JUAN CARLOS LOPEZ SALAZAR',4,'5617498763',1,32),(3924,'LEANDRO DE LA TORRE',4,'5611647867',1,32),(3925,'LEON ALEXANDRO JIMENEZ',4,'5545519262',1,32),(3926,'LUIS ARTURO GONZALEZ VALLEJO',4,'5581024587',1,32),(3927,'LUIS MANUEL LOPEZ',4,'5544900105',1,32),(3928,'MARTHA FABIAN',4,'5548648846',1,32),(3929,'MAURO ROMAN ROBLES',4,'5540047161',1,32),(3930,'MAX SANCHEZ',4,'5563589367',1,32),(3931,'MIRIAM BARRAGAN',4,'5538462492',1,32),(3932,'OMAR TEMICH',4,'5544980196',1,32),(3933,'RAUL LOPEZ VAZQUEZ',4,'5530194982',4,32),(3934,'RODRIGO AYALA',4,'5532630948',1,32),(3935,'ROGELIO DE JESUS',4,'5518073980',1,32),(3936,'SERGIO MENDOZA ESTRADA',4,'5581284545',1,32),(3937,'SERGIO RODRIGUEZ SAVEDRA',4,'5571815186',1,32),(3938,'VLADIMIR GUIDO',4,'5549713118',1,32),(3939,'XOCHITL LUIS ESPINOZA',4,'5580186615',1,32),(3940,'YAEL VALDEZ',4,'5561813642',1,32),(3941,'JULIO CESAR MORALES LIMON',7,'5523341798',1,29),(3942,'CESAR ALEJANDRO DEYTA LINAREZ GYM',7,'5633963231',4,29),(3943,'CRISTIAN EDUARDO CRUZ',7,'5579952930',1,29),(3944,'EDITH GARCIA',7,'5560066216',1,29),(3945,'JESSICA HERNANDEZ',7,'5574022184',1,29),(3946,'JONATHAN ANDRES SOLANO HERNANDEZ',7,'7351218622',4,29),(3947,'JOSE MANUEL ALVAREZ HERNANDEZ',7,'5551109262',1,29),(3948,'JUAN DIEGO N',7,'SN',1,29),(3949,'KAREN BALBUENA CEREZO',7,'5614134107',1,29),(3950,'LILIANA GUZMAN PEÑA',7,'5581856678',1,29),(3951,'LUIS DANIEL GONZALEZ SANCHEZ',7,'5548053627',1,29),(3952,'PEDRO REY GALVAN',7,'5566117509',1,29),(3953,'REFUGIO CUNA',7,'5624347206',1,29),(3954,'RODRIGO GUZMAN JARAMILLO',7,'5551961427',1,29),(3955,'SANTIAGO FACIO PEREZ',7,'5549545887',1,29),(3956,'ULISES OLVERA',7,'5546083725',4,29),(3957,'ALEJANDRO GALLARDO',3,'5550762655',1,37),(3958,'ALEXIS VALENCIA',3,'5630054411',1,37),(3959,'ARTURO ANTONIO',3,'5541394262',1,37),(3960,'CARLOS CORAL',3,'5566930309',1,37),(3961,'CESAR',3,'5626248030',1,37),(3962,'DOLORES MIRANDA',3,'5548538264',1,37),(3963,'EDER LORA CESARS GYM',3,'SN',4,37),(3964,'FERNANDA LUNA',3,'5574526792',1,37),(3965,'FERNANDO GONZALEZ',3,'5587608228',1,37),(3966,'FREDDY  DENTALVIS',3,'5550551913',1,37),(3967,'JESSICA ALFARO',3,'SN',1,37),(3968,'JESSICA GUZMAN',3,'5610994713',1,37),(3969,'JORGE SERRANO',3,'5523259855',3,37),(3970,'JOSUE CARRILLO',3,'5616938531',1,37),(3971,'JUAN PABLO CRUZ',3,'5542807711',1,37),(3972,'KAREN SANCHEZ',3,'5527272607',1,37),(3973,'LAURA AGUILAR',3,'5617563990',1,37),(3974,'LEOPOLDO HERNANDEZ HERNANDEZ',3,'5563440180',1,37),(3975,'LUZ ELENA',3,'5573869094',1,37),(3976,'MARIO CERVANTES',3,'5636507932',3,37),(3977,'NOEMI REYES',3,'5635299205',1,37),(3978,'OLIDIA JIMENEZ',3,'5513184622',1,37),(3979,'OSCAR CANO',3,'5570469555',1,37),(3980,'PATRICIA JAVIER PEREZ',3,'5531183133',1,37),(3981,'ROLANDO ROA',3,'5538872982',1,37),(3982,'SANTIAGO BRISEÑO',3,'5549341630',1,37),(3983,'SEBASTIAN IVAN HERNANDEZ',3,'5519861192',1,37),(3984,'SERGIO FLORES TENORIO',3,'5534757392',1,37),(3985,'URIEL OCTAVIO',3,'5574715154',1,37),(3986,'XIMENA MARCITO',3,'5534406279',1,37),(3987,'ARIEL CACHO HERNANDEZ (HERMANO DE THALIO)',7,'5647724245',4,29),(3988,'KAREN RIVERA',7,'5519816450',4,29),(3989,'SANTIAGO CASAS (TIGGER GYM)',7,'5517447366',4,29),(3990,'ABISAI ZURIEL HERNANDEZ TREJO',2,'5545406753',1,25),(3991,'ALBERTO QUIROZ',2,'5521853847',1,25),(3992,'ALEJANDRA ESPEJEL',2,'5524131344',3,25),(3993,'ANTONIO LONGORIA GARCIA',2,'5615036042',1,25),(3994,'GONZALO TAPIA',2,'5539350050',4,25),(3995,'GUSTAVO ISAAC MARTINEZ ESTRADA',2,'5528708311',4,25),(3996,'JESUS ENRIQUE SERRANO GOMEZ',2,'5521919699',4,25),(3997,'JOSE ANGEL CASTRO',2,'5526725949',1,25),(3998,'PEDRO AYALA',2,'5527641754',3,25),(3999,'TERE GONZALEZ',2,'5591856527',3,25),(4000,'VICTOR MENDOZA SANCHEZ',2,'5515629091',3,25),(4001,'YURITZI HERRERA CAMACHO',2,'5554606377',1,25),(4002,'ALEJANDRA TAPIA DIAZ',3,'5532057038',1,37),(4003,'ALEXANDER JIMENEZ',3,'5628109996',1,37),(4004,'ANGEL QUINTANA',3,'5631393874',1,37),(4005,'ANTONIO MARTINEZ',3,'5630273771',1,37),(4006,'ARABELLE PENELOPE RODRIGUEZ',3,'5535559938',1,37),(4007,'BRITANY RAMONE',3,'5614184831',1,37),(4008,'CARLOS JAIR AGUILAR ESPINOZA',3,'5547983261',1,37),(4009,'DANIEL BERNAL MILLLAN',3,'5628392742',1,37),(4010,'DAVID ROJAS',3,'5534565073',3,37),(4011,'DIANA HERNANDEZ MENDEZ',3,'5514843489',1,37),(4012,'EDMUNDO ROSANO MEZA (LOCATARIO)',3,'5581033967',4,37),(4013,'ESTEFANI SERRANO',3,'5578512330',1,37),(4014,'GERARDO MARQUEZ',3,'5547402074',1,37),(4015,'GUSTAVO IVAN ROMERO',3,'5545367264',1,37),(4016,'JONATHAN SOLANA TORRES',3,'SN',4,37),(4017,'JOSE ARMANDO MARQUEZ',3,'5537246126',1,37),(4018,'JOSE LUIS VALDES SALAZAR',3,'5521991603',1,37),(4019,'JUAN CARLOS VIZCARRA',3,'5580358950',3,37),(4020,'JUAN PLAZA',3,'5561598572',1,37),(4021,'JULIAN REYES',3,'5519113319',3,37),(4022,'LEONARDO HERNANDEZ',3,'5613043131',1,37),(4023,'MANUEL MELCHOR',3,'5574413215',1,37),(4024,'MARA IBAÑEZ',3,'5549924808',1,37),(4025,'MAX GUEVARA',3,'5614678105',1,37),(4026,'OBER SACARIAS',3,'SN',4,37),(4027,'PABLO ANTONIO MARIN',3,'5527970082',1,37),(4028,'RICARDO ROMERO ALMARAZ',3,'5526748009',1,37),(4029,'ROCIO BARRAZA HERNANDEZ',3,'5516030444',1,37),(4030,'SOFI LOPEZ',3,'SN',1,37),(4031,'VALERIA CABRAL',3,'6131076304',1,37),(4032,'BRANDON MICHELL MERCADO JONNY GYM',3,'5546369667',4,37),(4033,'KALID MILLA',6,'5610628453',4,30),(4034,'ZARAHY VICTORIANO',6,'5621943199',1,30),(4035,'BEATRIZ BERNAL',6,'5531124426',1,30),(4036,'DAVID ORTIZ',6,'5613480413',1,30),(4037,'DAVID ORTIZ VALLARTA',6,'5613480413',1,30),(4038,'DAYANE CORPUS',6,'5613585541',1,30),(4039,'FRANCISCO ALEMAN RAYON',6,'5587216544',1,30),(4040,'GERARDO MACIAS',6,'5519671998',1,30),(4041,'HENRY ESPINOZA REYES',6,'5615519998',1,30),(4042,'JOCELYN ROMERO MERINO',6,'5614000031',1,30),(4043,'JUAN CARLOS GOMEZ',6,'5550726208',1,30),(4044,'JULIO QUINTERO ALVAREZ',6,'5621048366',4,30),(4045,'LAURA HERNANDEZ',6,'5585594364',1,30),(4046,'MARCO ANTONIO GUZMAN',6,'5591928548',1,30),(4047,'MIGUEL ANGEL GONZALEZ FABELA',6,'5613827038',1,30),(4048,'OSCAR JAIR CASTAÑEDA ORTEGA',6,'5641567019',1,30),(4049,'ARMANDO REYES',6,'5585385454',1,30),(4050,'JAVIER GAYTAN',6,'5523206346',1,30),(4051,'VICTOR NADER',6,'5533970665',1,30),(4052,'ADRIAN ZAMORA',2,'5512677815',1,25),(4053,'ALEJANDRO ESCOBAR',2,'5536800934',1,25),(4054,'ALEJANDRO PULIDO',2,'SN',3,25),(4055,'ALEXA QUIROZ',2,'SN',3,25),(4056,'ALEXIS GERMAN SOLIS',2,'5537474966',3,25),(4057,'ALEXIS MIRELES',2,'5564946083',1,25),(4058,'BRENDA VILLAREAL',2,'5567035024',1,25),(4059,'CARLOS IVAN GASPAR FLORES',2,'5540191159',1,25),(4060,'CHRYSTOPHER GARRIDO ESPEJEL',2,'5537176117',1,25),(4061,'CRISTINA JUDITH SANCHEZ LEMUS',2,'5534904478',1,25),(4062,'DANIEL REYES',2,'5532285765',3,25),(4063,'DANIEL VILLEGAS',2,'5566108468',1,25),(4064,'DIEGO RAMIREZ',2,'5580311008',1,25),(4065,'JACOB CEDILLO',2,'5532062752',3,25),(4066,'JESUS ELEAZAR GARCIA',2,'5559892445',1,25),(4067,'JONATHAN GARRIDO RUIZ',2,'5583905060',1,25),(4068,'JUAN FARIAS',2,'5534640786',4,25),(4069,'JUAN SALVADOR ZAMORA IBARRA',2,'5633590519',1,25),(4070,'KARLA CABALLERO',2,'5534599106',3,25),(4071,'LUIS REYES',2,'5531134758',4,25),(4072,'LUIS SANCHEZ',2,'5612750441',1,25),(4073,'MAFER MAYEN',2,'SN',3,25),(4074,'MARCO MENDEZ',2,'SN',3,25),(4075,'OMAR ALVAREZ',2,'5562000907',1,25),(4076,'OSCAR PEREZ MARTINEZ (POLICIA MUN)',2,'5549521667',4,25),(4077,'STEFANIE MENDOZA',2,'5536632966',3,25),(4078,'FERNANDO MUÑOZ AGUILAR \"FACEBOOK\"',2,'5624728928',3,25),(4079,'YASIR',2,'5517010076',3,25),(4080,'ADRIANA VAZQUEZ MORENO',2,'SN',3,25),(4081,'MARCO BENHUMEA RAMIREZ',2,'5519160147',3,25),(4082,'SERGIO GUTIERREZ',2,'5537959263',1,25),(4083,'HAZAEL COURTOIS  \"IRON LABS\"',2,'5534559547',4,25),(4084,'CRISTIAN ESCAMILLA',2,'SN',1,25),(4085,'GERARDO RODRIGUEZ',2,'5560863021',1,25),(4086,'HECTOR AQUILES  PONCE',2,'5551679392',4,25),(4087,'ZABDIEL CANCINO',2,'5573246889',1,25),(4088,'ABRAHAM REYNA',2,'5523085641',1,25),(4089,'ADRIAN TAPIA SUAREZ',2,'SN',1,25),(4090,'ARIANA VALENCIA',2,'SN',1,25),(4091,'DAVID AYALA MUÑIZ',2,'5555015388',1,25),(4092,'JAVIER ESCALONA',2,'5525330329',1,25),(4093,'JONATHAN MARTNEZ ARANA',2,'5523077001',1,25),(4094,'JULIETA MENDOZA',2,'5513775264',1,25),(4095,'MARIA HANNA MEDINA',2,'5565447641',4,25),(4096,'MARY MEJIA',2,'5620728857',1,25),(4097,'RAMON VELAZQUEZ',2,'5548799364',1,25),(4098,'RICARDO VALERO',2,'5581571080',1,25),(4099,'OMAR LOPEZ ARELLANO',2,'5516573382 / 58161473',4,25),(4100,'JOSE LOPEZ HERNANDEZ INSTRUCTR SMART SAN',7,'5518697855',1,29),(4101,'SERGIO LEZAMA',2,'5636358820',1,25),(4102,'*ALEJANDRO ESPINOZA',2,'SN',3,25),(4103,'ABRAHAM MURGIA',2,'5533995506',3,25),(4104,'ALEJANDRO CUEVAS',2,'5523075281',1,25),(4105,'ALEXIS ORDOÑEZ',2,'5535339025',1,25),(4106,'ALFREDO RUIZ',2,'5535810447',1,25),(4107,'ANDRES HERNANDEZ MONTES',2,'5512881663',1,25),(4108,'andres izquierdo',2,'SN',4,25),(4109,'ANDRES REYES',2,'SN',3,25),(4110,'ANTONIO LAGUNA GARZA',2,'5519241455',1,25),(4111,'ARMANDO DAVID DIAZ SALINAS',2,'5540127441',4,25),(4112,'ARTURO CRUZ MUNICIPIO',2,'5511619101',4,25),(4113,'AXEL ALEXIS SALAZAR',2,'5588049044',1,25),(4114,'CRISTINA PADILLA',2,'5534443602',3,25),(4115,'Daniel Ayala',2,'5559538239',3,25),(4116,'DIANA FLORES',2,'5539222663',1,25),(4117,'DIEGO MANUEL CHAVEZ',2,'5561753914',1,25),(4118,'DIEGO PEREZ',2,'5522122657',4,25),(4119,'DORIAN LORA ESPINOZA',2,'5581019144',1,25),(4120,'EDGAR CATALAN',2,'5634625478',1,25),(4121,'EDMUNDO PEDROZA',2,'5521811504',4,25),(4122,'EMMANUEL CRUZ CAMPOS',2,'5537345177',1,25),(4123,'ERIKA ROJAS',2,'5523011029',1,25),(4124,'FRANCISCO SANTIAGO ESPINOZA',2,'5551925621',1,25),(4125,'GERARDO SOTO ALOR',2,'5552521427',1,25),(4126,'GUILLERMO GONZALEZ',2,'5527276903',3,25),(4127,'HADA OVILLA',2,'5525189033',1,25),(4128,'JAFET ISSAC MARQUEZ',2,'5521014691',1,25),(4129,'JAVIER DELGADO',2,'5548391063',1,25),(4130,'JONATHAN ROBLES POLI',2,'5544203874',4,25),(4131,'JOSE JAVER CRUZ',2,'5582249610',1,25),(4132,'JUAN JOSE MOGUEL',2,'5561514597',4,25),(4133,'JUAN MANUEL ROSALES',2,'5530208207',4,25),(4134,'JUAN MARTIN CAMPOS SERRANO',2,'5539997995',1,25),(4135,'JUAN RAMON CRUZ',2,'5564327949',1,25),(4136,'Karla Alarcon',2,'5520103960',1,25),(4137,'LUIS A. REYES HERNANDEZ',2,'5531134758',4,25),(4138,'MARISSA MARTINEZ',2,'5554526674',1,25),(4139,'MARTIN ROMERO',2,'5537081645',1,25),(4140,'MIGUEL ANGEL MEXICANO',2,'5547797826',3,25),(4141,'NICOLAS VICTORINO',2,'5578886277',1,25),(4142,'OLIVER TERRAZAS NUÑEZ (PM)',2,'5578185562',4,25),(4143,'OMAR HERNANDEZ',2,'5576865477',1,25),(4144,'OSCAR SAMPEDRO SANCHEZ',2,'5537031113',1,25),(4145,'ROBERTO SANCHEZ',2,'5541406253',1,25),(4146,'RODRIGO RODRIGUEZ',2,'5518403615',1,25),(4147,'RODRIGO TORRES',2,'5528994698',1,25),(4148,'IRVING DANIEL REYES',2,'2961024912',3,25),(4149,'RAYMUNDO TENAYO',2,'5514915990',4,25),(4150,'PABLO ROJAS',2,'5585483085',1,25),(4151,'EDUARDO ROCHA INSTRUCTOR',2,'55 4071 4078',4,25),(4152,'JAVIER ARCHUNDIA',2,'5539170170',3,25),(4153,'JORGE EDUARDO MORA ESTRADA',2,'SN',3,25),(4154,'JOSE ANGEL PEREZ',2,'5517649819',1,25),(4155,'JOSE LUIS MARIN',2,'SN',4,25),(4156,'MEDARDO ROSAS',2,'5565659353',4,25),(4157,'RODRIGO MARTINEZ MARTINEZ',2,'SN',3,25),(4158,'VERONICA HERNANDEZ',2,'SN',3,25),(4159,'WILLIAM SPORT GYM',2,'SN',4,25),(4160,'OSCAR MARTINEZ',2,'SN',1,25),(4161,'ESTER RODRIGUEZ',2,'5591862534',4,25),(4162,'CESAR MENDOZA',2,'5524481482',4,25),(4163,'FAUSTO CABAÑAS GARCIA',2,'5540274073',1,25),(4164,'HECTOR SALAZAR INSTRUCTOR',2,'SN',3,25),(4165,'CHRISTIAN GARRIDO',2,'SN',4,25),(4166,'DAVID MONDRAGON',2,'SN',1,25),(4167,'ELIAS ORTIZ',2,'5543935459',3,25),(4168,'HECTOR HERNANDEZ',2,'5513444782',1,25),(4169,'JESUS LOPEZ',2,'SN',1,25),(4170,'SILVIA JULE GALVES VALLEJO',2,'SN',4,25),(4171,'TARZAN',2,'SN',4,25),(4172,'Oliver Velazquez',3,'5626643424',1,37),(4173,'ALAN FABELA INSTRUCTOR',3,'SN',4,37),(4174,'ANGEL IVAN GONZÁLEZ PEREDO',3,'5512563470',3,37),(4175,'DANIEL VEGA PEREZ',3,'5510080978',1,37),(4176,'EDUARDO LOPEZ',3,'5618482615',1,37),(4177,'MILIANGEL MELEAN',3,'5564700909',1,37),(4178,'SANDRO REYES',3,'5528317154',1,37),(4179,'MARIBEL RAMOS MATEO',3,'5547893178',1,37),(4180,'GINA OLMOS PEREZ',3,'5573527977',1,37),(4181,'OMAR JESUS',3,'5567622402',1,37),(4182,'*ABIGAIL',3,'SN',1,37),(4183,'*ALICIA',3,'SN',1,37),(4184,'*AXEL TOWN CENTER',3,'5548917779',3,37),(4185,'*CARLOS NAVA',3,'SN',1,37),(4186,'*DANIEL LOPEZ',3,'55285869',3,37),(4187,'*EDUARDO CASA BLANCA',3,'SN',4,37),(4188,'*EDUARDO JAIME',3,'SN',3,37),(4189,'*EDUARDO SALINAS',3,'SN',3,37),(4190,'*FELIPE',3,'SN',3,37),(4191,'*FELIPE RAMIREZ',3,'5571080318',1,37),(4192,'*GABRIEL CORTEZ',3,'SN',1,37),(4193,'*GERARDO CORIA',3,'SN',3,37),(4194,'*HERNAN',3,'SN',3,37),(4195,'*JONATHAN GONZALES',3,'5522125714',3,37),(4196,'*JOSE ALFREDO',3,'5573880507',3,37),(4197,'*JOSUE',3,'SN',3,37),(4198,'*LUIS ANGEL',3,'SN',1,37),(4199,'*MANUEL LOPEZ',3,'5524699932',1,37),(4200,'*MARCOS GONZALES',3,'SN',1,37),(4201,'*MARIANO',3,'5514711560',1,37),(4202,'*RAYMUNDO',3,'5511989788',1,37),(4203,'*TANIA GARCIA',3,'5566976918',3,37),(4204,'*TANIA RUIZ',3,'5546929418',3,37),(4205,'*uriel contreras',3,'SN',3,37),(4206,'*XOCHIL PEREZ',3,'5540237239',1,37),(4207,'AARON ALANIS',3,'5548293377',1,37),(4208,'AARON BRECEDA',3,'5573799706',1,37),(4209,'AARON PEREZ MONROY',3,'5573221218',1,37),(4210,'ABAKUC GARCIA',3,'SN',1,37),(4211,'Abel Alejandro Orozco Álvarez',3,'5566697987',1,37),(4212,'ABEL CRUZ GARCIA',3,'SN',1,37),(4213,'ABEL FAJARDO',3,'5532271713',1,37),(4214,'ABEL LA TORRE',3,'5548533365',1,37),(4215,'ABEL ROSAS PEÑALOZA',3,'5513217826',1,37),(4216,'ABELARDO MONTOYA',3,'5530707194',1,37),(4217,'ABIGAIL CASTRO',3,'5535969625',1,37),(4218,'ABIGAIL FLORES ROMERO',3,'5539795862',1,37),(4219,'ABIGAIL PEREZ ROSALES',3,'5',1,37),(4220,'ABIGAIL PEREZ ROSALES',3,'5618013267',1,37),(4221,'ABIGAIL QUIJADA',3,'5513661856',1,37),(4222,'ABIGAIL QUIJANO',3,'SN',1,37),(4223,'ABIGAIL RODRIGUEZ',3,'SN',1,37),(4224,'ABRAHAM  ESPINOZA',3,'SN',1,37),(4225,'ABRAHAM SOLIS',3,'5522006673',1,37),(4226,'ABRAM HERNANDEZ',3,'7442109795',1,37),(4227,'ABRAM JOSUE TOLEDO',3,'5522637774',1,37),(4228,'ABUK GARCÍA LÓPEZ',3,'5540905808',1,37),(4229,'ADAN CANALES REYES',3,'5611531124',1,37),(4230,'ADAN FERNANDO LORENZO MARTINEZ',3,'5611197177',1,37),(4231,'ADAN REYES CRUZ',3,'5539169613',1,37),(4232,'ADELAIDA MACIN BALTAZAR',3,'SN',1,37),(4233,'ADOLFO ANGEL PADILLA MATEOS',3,'5583097465',1,37),(4234,'ADOLFO ANGEL VARGAS AVILA',3,'5618103405',1,37),(4235,'ADOLFO AREÑANO',3,'SN',1,37),(4236,'Adolfo García',3,'SN',1,37),(4237,'ADOLFO GARCIA TORRES',3,'5515211752',1,37),(4238,'ADOLFO RAMIREZ TRUJILLO',3,'5520691361',1,37),(4239,'ADRIAN ALCANTARA',3,'5545469083',1,37),(4240,'ADRIAN ESCOBAR',3,'5569409875',1,37),(4241,'ADRIAN FERNANDO JIMENEZ CRUZ',3,'5577749164',1,37),(4242,'ADRIAN GOMEZ LICONA',3,'5539080121',1,37),(4243,'ADRIAN ISAAC RABAGO MEDINA',3,'5573263844',1,37),(4244,'ADRIAN JUAREZ CASTILLO',3,'SN',1,37),(4245,'ADRIANA AREVALO MENDOZA',3,'5535083903',1,37),(4246,'ADRIANA CHAIRES',3,'5535375753',1,37),(4247,'ADRIANA CURTO MORENO',3,'5591006833',1,37),(4248,'ADRIANA DE JULIAN',3,'SN',1,37),(4249,'ADRIANA FONSECA',3,'SN',1,37),(4250,'ADRIANA JIMENEZ',3,'5588318313',1,37),(4251,'ADRIANA PEÑA',3,'5518204418',3,37),(4252,'ADRIANA SANCHEZ BALLESTEROS',3,'5569663108',1,37),(4253,'ADRIANA SANDOVAL ARIAS',3,'SN',1,37),(4254,'AGUSTIN GOMEZ',3,'5562277545',1,37),(4255,'AHIZAR CAMACHO NOGUEZ',3,'SN',1,37),(4256,'AIDA RODRIGUEZ',3,'5544151506',1,37),(4257,'AIDE NAVARRO',3,'5569669954',1,37),(4258,'AIDE PONCE GUTIERREZ',3,'5518133648',1,37),(4259,'AILYN GOMEZ FLORENTINO',3,'5581967675',1,37),(4260,'AIXA SAUCEDO',3,'5530274403',1,37),(4261,'ALAIN MICHELLE TORRES SANTANA',3,'5581888699',1,37),(4262,'ALAN AGUILAR AYON',3,'5615016855',1,37),(4263,'ALAN ALBERTO LEON HERNANDEZ',3,'5536343533',1,37),(4264,'ALAN BAUTISTA WALMART',3,'5614189618',4,37),(4265,'ALAN CABAÑAS',3,'5580067194',1,37),(4266,'ALAN CERVANTES PEREZ',3,'5568147736',1,37),(4267,'ALAN CESAR GYM',3,'SN',4,37),(4268,'ALAN CRUZ',3,'5534797426',1,37),(4269,'ALAN DOMINGUEZ',3,'552215354',1,37),(4270,'ALAN EVANS ROMERO',3,'5626768023',1,37),(4271,'ALAN GARCIA PEREZ',3,'5532662058',1,37),(4272,'ALAN GRANADOS',3,'5615096764',1,37),(4273,'ALAN ISAC LUNA',3,'5548585044',1,37),(4274,'ALAN JARILLO VARGAS',3,'SN',1,37),(4275,'ALAN RAMIREZ ALDANA',3,'5548253257',1,37),(4276,'ALAN RINCON',3,'5543675357',1,37),(4277,'ALAN RODRIGO GARCIA ZAMUDIO',3,'5529199142',1,37),(4278,'ALAN SAGAHON',3,'5510176482',1,37),(4279,'ALAN SIERRA GARCIA',3,'5562551551',1,37),(4280,'ALBERTO ASCANIO',3,'7971288788',1,37),(4281,'ALBERTO BELTRAN RAMIREZ',3,'5545056042',1,37),(4282,'ALBERTO BLANCO',3,'5523090390',1,37),(4283,'ALBERTO CABALLERO',3,'SN',1,37),(4284,'ALBERTO CARDOZO',3,'5534116203',1,37),(4285,'ALBERTO FLORES',3,'SN',1,37),(4286,'ALBERTO GARCIA DOMINGUEZ',3,'5538790746',1,37),(4287,'ALBERTO GOMEZ',3,'5621325434',1,37),(4288,'ALBERTO HERNANDEZ',3,'5536772633',1,37),(4289,'ALBERTO JORGE HERNANDEZ',3,'SN',1,37),(4290,'ALBERTO MEJIA',3,'SN',1,37),(4291,'ALBERTO REYES MUÑOZ',3,'5575253011',1,37),(4292,'ALBERTO VELAZQUEZ GARCIA',3,'5520583017',1,37),(4293,'ALDO ANTONIO URIBE CADENA',3,'5581767954',1,37),(4294,'ALDO CHAVEZ',3,'SN',1,37),(4295,'ALE CARRASCO',3,'5569852101',1,37),(4296,'ALEJANDRA CASTAÑEDA',3,'5560258490',1,37),(4297,'ALEJANDRA CASTAÑEDA',3,'5560258490',1,37),(4298,'ALEJANDRA CRUZ DE JESUS',3,'SN',1,37),(4299,'ALEJANDRA KARINA IBARRA',3,'SN',1,37),(4300,'ALEJANDRA MALAGON PARRA',3,'5571109101',1,37),(4301,'ALEJANDRA RAMOS',3,'5571774977',3,37),(4302,'ALEJANDRA RIVERA',3,'5625862863',1,37),(4303,'ALEJANDRA VARGAS',3,'5518165066',1,37),(4304,'ALEJANDRO ALZATE DAVILA',3,'5548463971',1,37),(4305,'ALEJANDRO BECERRIL',3,'SN',1,37),(4306,'ALEJANDRO CASTILLO',3,'5561908432',1,37),(4307,'ALEJANDRO CHAVEZ',3,'5576690525',1,37),(4308,'ALEJANDRO DE LOS SANTOS',3,'5566676533',1,37),(4309,'ALEJANDRO DIAS',3,'5514632083',3,37),(4310,'ALEJANDRO DOMINGUEZ MORALES',3,'5565119474',4,37),(4311,'ALEJANDRO GALAN',3,'5519336178',1,37),(4312,'ALEJANDRO GARCIA HERNANDEZ',3,'5540332760',1,37),(4313,'ALEJANDRO GARDUÑO MAYEN',3,'5582425447',1,37),(4314,'ALEJANDRO HERNANDEZ FIGEROA',3,'5564860448',1,37),(4315,'ALEJANDRO IRRA',3,'5578696409',1,37),(4316,'ALEJANDRO ISLAS',3,'5572660869',1,37),(4317,'ALEJANDRO LIMON',3,'5530763482',1,37),(4318,'ALEJANDRO MARQUEZ ORTIZ',3,'5561654761',1,37),(4319,'ALEJANDRO MARQUEZ TRUJILLO',3,'5576308688',1,37),(4320,'ALEJANDRO MARTINEZ MORALES',3,'5637170724',4,37),(4321,'ALEJANDRO MARTINEZ PEREZ',3,'5636370608',1,37),(4322,'ALEJANDRO MENDOZA CRUZ',3,'5549584313',1,37),(4323,'ALEJANDRO MORALES',3,'5534043117',1,37),(4324,'ALEJANDRO OCERIN',3,'5563252954',1,37),(4325,'ALEJANDRO RAMIREZ',3,'SN',1,37),(4326,'ALEJANDRO RAMIREZ ALVARADO',3,'5542413926',1,37),(4327,'ALEJANDRO RIVAS',3,'5518464796',4,37),(4328,'ALEJANDRO RODRIGUEZ MEDINA',3,'5540907735',1,37),(4329,'ALEJANDRO SANCHEZ',3,'5512661417',1,37),(4330,'ALEJANDRO SEBASTIAN DORANTES',3,'5519516795',1,37),(4331,'ALEJANDRO SIMON SANCHEZ',3,'5614692387',1,37),(4332,'ALEJANDRO TORRES OLVERA',3,'5534806920',1,37),(4333,'ALEJANDRO VEGA ALCANTARA',3,'5586075028',1,37),(4334,'ALEJANDRO VICENTE',3,'5615152939',4,37),(4335,'ALEX ANGELES MAYORGA',3,'5560605262',1,37),(4336,'ALEX ARRIAGA BARRIOS',3,'5564811825',1,37),(4337,'ALEX GOMES',3,'5563252954',1,37),(4338,'ALEX GOMEZ OCERIN',3,'5563252954',3,37),(4339,'ALEX MEDINA',3,'5526789992',1,37),(4340,'ALEX UBALDO CESAR GYM',3,'SN',4,37),(4341,'ALEXANDER LOPEZ',3,'5617060456',1,37),(4342,'ALEXANDER VALDEZ',3,'SN',1,37),(4343,'ALEXIS ALBERTO PEREZ ROBLES',3,'5541335967',1,37),(4344,'ALEXIS BACA',3,'5521384577',1,37),(4345,'ALEXIS DAMIAN SANTANA SANCHEZ',3,'5616535465',1,37),(4346,'ALEXIS GONZALEZ',3,'5520888842',1,37),(4347,'ALEXIS GONZÁLEZ',3,'5520303917',1,37),(4348,'ALEXIS JESUS MORAN',3,'5575437554',1,37),(4349,'ALEXIS JUAREZ',3,'5566926272',1,37),(4350,'ALEXIS MARTINEZ',3,'5579017504',1,37),(4351,'ALEXIS OMAR ROJAS BARRON',3,'5532897004',1,37),(4352,'ALEXIS SANCHEZ ANGUIANO',3,'5620830541',1,37),(4353,'ALEXIS URIEL AGUILAR MARTINEZ',3,'5586746257',1,37),(4354,'ALEXIS YAEL SARMIENTO PEREZ',3,'5583186580',1,37),(4355,'ALFONSO ALARCÓN OLIVO',3,'5547969973',1,37),(4356,'ALFONSO FLORES PEREZ',3,'5565062558',1,37),(4357,'ALFONSO LEDEZMA',3,'SN',1,37),(4358,'ALFONSO MARTINEZ HERNANDEZ',3,'5549022683',1,37),(4359,'ALFONSO OJEDA SANCEZ',3,'5523180334',1,37),(4360,'ALFREDO BLANCO',3,'5512394571',1,37),(4361,'ALFREDO BLANCO ZARRAGA',3,'5564152337',1,37),(4362,'ALFREDO CAMARGO',3,'5519247423',1,37),(4363,'ALFREDO CAMARGO CASTRO',3,'5519247423',1,37),(4364,'ALFREDO CARVAGAL',3,'5531513949',1,37),(4365,'ALFREDO DÍAZ VÁZQUEZ',3,'5548888124',1,37),(4366,'ALFREDO GARCIA',3,'5613268213',1,37),(4367,'ALFREDO LORA',3,'5546939391',1,37),(4368,'ALFREDO PARRA',3,'5540468019',1,37),(4369,'alfredo sanchez',3,'5581552334',3,37),(4370,'ALFREDO TORRES',3,'SN',3,37),(4371,'ALFREDO TREJO',3,'5591113825',1,37),(4372,'ALFREDO VILLAGRAN HERNANDEZ',3,'SN',1,37),(4373,'ALFREDO YESCAS',3,'SN',1,37),(4374,'ALICIA MARTINEZ',3,'5571119356',1,37),(4375,'ALICIA RAMIREZ',3,'5553814881',1,37),(4376,'ALICIA ROA',3,'5540230133',1,37),(4377,'ALINE CUREÑO MARQUEZ',3,'5510081932',1,37),(4378,'ALLAN JARILLO',3,'5540591301',1,37),(4379,'ALLISON GOMEZ',3,'5562170867',1,37),(4380,'ALMA JESSICA FONSECA',3,'5587202890',1,37),(4381,'ALMA ROSA SEBASTIAN VARGAS',3,'5574385265',1,37),(4382,'ALONDRA BERENICE CRUZ MARTINEZ',3,'5566632666',1,37),(4383,'ALONDRA GONZALEZ',3,'5512863359',1,37),(4384,'ALONDRA LUVIANO',3,'5562122691',1,37),(4385,'ALONSO DE JESUS MEJIA GUERRERO',3,'5536692917',1,37),(4386,'alonso hernandez',3,'5539109973',1,37),(4387,'ALONSO HERRERA',3,'5532132547',1,37),(4388,'ALVARO HERNANDEZ',3,'SN',4,37),(4389,'ALVARO MARTIN MONDRAGON',3,'7714037951',1,37),(4390,'ALVARO MARTINEZ GUTIERREZ',3,'5531336767',1,37),(4391,'AMANDA RAMIREZ CASTRO',3,'55586789997',1,37),(4392,'ANA CRISTINA SANTOS GONZALEZ',3,'5573511558',1,37),(4393,'Ana Cruz De la Luz',3,'5549142867',1,37),(4394,'ANA DE LA LUZ',3,'SN',1,37),(4395,'ANA ESCOBAR',3,'5520242708',1,37),(4396,'ANA ESCOBAR 2',3,'5520242708',1,37),(4397,'ANA GABRIELA HERNANDEZ',3,'5610960865',1,37),(4398,'ANA ISABEL SALAZAR',3,'5551909379',1,37),(4399,'ANA KAREN ARGUETA VAZQUEZ',3,'5584576772',1,37),(4400,'ANA KAREN OLALDE',3,'5527989870',1,37),(4401,'ANA KAREN ORDUÑO MOLINA',3,'5562022728',1,37),(4402,'ANA KAREN SANTOS',3,'5569608905',1,37),(4403,'ANA KAREN VEGA',3,'5612971331',1,37),(4404,'ANA LAURA CRUZ',3,'5579651423',1,37),(4405,'ANA LAURA GARCIA COLIN',3,'5547988836',1,37),(4406,'ANA LAURA SUAREZ ÁLVARADO',3,'5530161578',1,37),(4407,'ANA LAURIA ARIAS GARRIDO',3,'5534666170',1,37),(4408,'ANA LEIDY MIRANDA',3,'5511459631',1,37),(4409,'ANA LILIA DIAZ ARIAS',3,'5584972717',1,37),(4410,'ANA LILIA MARTINEZ ORTIZ',3,'5539788400',1,37),(4411,'ANA LUISA FRANCO',3,'5549690226',1,37),(4412,'ANA MARIA CRUZ HERNANDEZ',3,'5538522372',1,37),(4413,'ANA MERCEDES VALDESPINO MEJIA',3,'5528991142',1,37),(4414,'ANA PAOLA VELARDE ROSAS',3,'5549368725',1,37),(4415,'ANA PEREZ',3,'SN',1,37),(4416,'ANA REYES',3,'5583431113',1,37),(4417,'ANA VICTORIA ANDRADE RUBIO',3,'5584400301',1,37),(4418,'ANA VICTORIA LEON',3,'5560756079',1,37),(4419,'ANA ZAMORA',3,'5536742966',1,37),(4420,'ANABEL GARCIA',3,'555441174925',1,37),(4421,'ANABEL GARCIA',3,'5564449076',1,37),(4422,'ANADORIS CORONA CASTREJON',3,'5526682022',1,37),(4423,'ANAHI AYALA',3,'5576580213',1,37),(4424,'ANAHI CRUZ',3,'5548557138',1,37),(4425,'ANAID TORRES QUINTANAR',3,'5573283909',1,37),(4426,'ANAYELI ARREOLA OLVERA',3,'5526543211',1,37),(4427,'ANAYELLI GALLEGOS',3,'5614060105',1,37),(4428,'ANDREA DE JESUS VALDEZ',3,'5537962708',1,37),(4429,'ANDREA DENIS ROMERO SANCHEZ',3,'5515739881',1,37),(4430,'ANDREA GONZALES BARRERA',3,'5551557598',1,37),(4431,'ANDREA GONZALEZ',3,'5551557598',1,37),(4432,'ANDRES DEL PUERTO HEALTH GYM',3,'5527163408',1,37),(4433,'ANDRES EMILIANO TELLEZ',3,'5635617446',1,37),(4434,'ANDRES HERNANDEZ',3,'SN',1,37),(4435,'ANDRES JIMENEZ',3,'5577361080',1,37),(4436,'ANDRES LOPEZ',3,'5585511037',1,37),(4437,'ANDRES MELITON MATEO',3,'5623644715',1,37),(4438,'ANDREZ VAZQUEZ',3,'5620512380',1,37),(4439,'Anel Romero',3,'SN',1,37),(4440,'ANELINN CANTORAL',3,'5627245861',1,37),(4441,'ANGEL AGUIRRE',3,'SN',3,37),(4442,'ANGEL ALEXIS FLORES',3,'SN',1,37),(4443,'ANGEL ALEXIS PORTILLO',3,'SN',1,37),(4444,'ANGEL AMIEVA HERNANDEZ',3,'5634663882',1,37),(4445,'ANGEL BALLESTEROS VALDIVIA',3,'SN',1,37),(4446,'ANGEL BERNAL TORRES',3,'5518119398',4,37),(4447,'ANGEL BRANDO LOZANO',3,'5568596342',1,37),(4448,'ANGEL BRANDON LOZANO',3,'5568596342',4,37),(4449,'ANGEL CASTELON',3,'5573999095',1,37),(4450,'ANGEL DAVID ALAMILLO ARTEAGA',3,'5521115994',1,37),(4451,'ANGEL EDUARDO GUTEERREZ',3,'5534539064',1,37),(4452,'ANGEL EDUARDO LECHUGA RENTERIA',3,'5582422198',1,37),(4453,'ANGEL EDUARDO LEON GALVAN',3,'5576638741',1,37),(4454,'ANGEL FERNANDO SALINAS VIVAS',3,'5516393625',1,37),(4455,'ANGEL GABRIEL LOPEZ CABALLERO',3,'5612985610',1,37),(4456,'ANGEL GONZALES ALVAREZ',3,'5571745649',1,37),(4457,'ANGEL GUTIERREZ EDUARDO',3,'5539401492',1,37),(4458,'ANGEL HERNANDEZ',3,'5540966504',1,37),(4459,'ANGEL HERNANDEZ',3,'SN',1,37),(4460,'angel hernandez',3,'5537482573',1,37),(4461,'ANGEL IVAN PEREDA',3,'5635671283',1,37),(4462,'ANGEL JONATHAN RAMIREZ',3,'5567536465',1,37),(4463,'ANGEL JOSUE GARCIA',3,'5626939192',1,37),(4464,'ANGEL LUCIO RODRIGUEZ',3,'5524842056',1,37),(4465,'ANGEL MORAN',3,'5529535660',1,37),(4466,'ANGEL OSIRIS VEGA',3,'5581381959',1,37),(4467,'ANGEL RIOS',3,'SN',1,37),(4468,'ANGEL ROJAS',3,'5532718413',1,37),(4469,'ANGEL ROMO GOMEZ',3,'5522578532',1,37),(4470,'ANGEL ZAMUDIO',3,'5591392545',3,37),(4471,'ANGELES DE CANTAROS',3,'SN',1,37),(4472,'ANGELES MARTINEZ',3,'5515715166',1,37),(4473,'ANGELICA ALVARADO ALLENDE',3,'5573999303',1,37),(4474,'ANGELICA CONTRERAS',3,'5581423793',1,37),(4475,'ANGELICA ESPINOZA',3,'5543603639',3,37),(4476,'ANGELICA GALINDO JIMENEZ',3,'SN',1,37),(4477,'ANGELICA MARTINEZ',3,'5564921579',1,37),(4478,'ANGELICA MIRANDA',3,'5614672232',1,37),(4479,'ANGELICA TOMAS',3,'5532638708',3,37),(4480,'ANGELICA TRUJILLO',3,'5529511331',1,37),(4481,'ANGELICA VIRIDIANA GALINDO',3,'5520074752',1,37),(4482,'ANGELINA CRUZ',3,'5564376391',3,37),(4483,'ANNEL URBANO MIGUEL',3,'5627375654',1,37),(4484,'ANTONHY ACOSTA',3,'5610863137',1,37),(4485,'ANTONINO MENDOZA ORTIZ',3,'SN',1,37),(4486,'ANTONIO ARELLANO',3,'5551803546',1,37),(4487,'ANTONIO CAMPOS',3,'5574219298',1,37),(4488,'ANTONIO CARDENAS PACHECO',3,'SN',1,37),(4489,'ANTONIO CHAVEZ ARAGON',3,'5525621326',1,37),(4490,'ANTONIO DIAZ',3,'5627339762',1,37),(4491,'ANTONIO ENRIQUES',3,'SN',1,37),(4492,'antonio gonzales',3,'5546130464',1,37),(4493,'ANTONIO HERNANDEZ RIOS',3,'5526654104',1,37),(4494,'ANTONIO MAYORGA',3,'5616437524',1,37),(4495,'ANTONIO MORALES CRUZ',3,'5568236548',1,37),(4496,'ANTONIO NORMAN',3,'5548250724',1,37),(4497,'ANTONIO QUIRINO FLORES',3,'5521790809',1,37),(4498,'ANTONIO RODRIGUEZ',3,'5587486544',1,37),(4499,'ANTONIO ROMERO',3,'5536639914',1,37),(4500,'ANTONIO ROMO',3,'5551901877',1,37),(4501,'ANTONIO TREJO',3,'5614443590',1,37),(4502,'ANTONIO TURRUBIARTE SANTOS',3,'5513702659',1,37),(4503,'ANTUAN FONSECA',3,'SN',1,37),(4504,'ANUAR MORENO',3,'5565375945',1,37),(4505,'ARABELLE PENELOPE RODRIGUEZ FAJARDO',3,'5535559938',1,37),(4506,'ARACELI AGUILAR BALDERAS',3,'5560864224',1,37),(4507,'ARACELI CRUZ MORALES',3,'5551787384',1,37),(4508,'ARACELI LARA OVIEDO',3,'5567558222',1,37),(4509,'ARACELI QUIROZ',3,'5617708976',1,37),(4510,'ARACELI SANCHEZ MUÑOZ',3,'5564544304',1,37),(4511,'Ari López',3,'5528559452',1,37),(4512,'ARI LÓPEZ',3,'SN',1,37),(4513,'ARIADNA FLORES',3,'5525637031',1,37),(4514,'ARIEL GONZALEZ SANTOS',3,'5527195965',1,37),(4515,'ARIEL SANCHEZ REYES',3,'5532102352',1,37),(4516,'ARIELA HERNANDEZ LOPEZ',3,'5567637912',3,37),(4517,'ARLEM MENDOZA',3,'5614889329',1,37),(4518,'ARLET CORIA VEGA',3,'SN',1,37),(4519,'ARMANDO ABRAHAM MURGUIA GOMEZ',3,'5535620240',1,37),(4520,'ARMANDO ANGELES TOLEDO',3,'5564282175',4,37),(4521,'ARMANDO ARANDA ALANIZ',3,'5565736544',1,37),(4522,'ARMANDO DE DIOS VARGAS GIL',3,'5531162486',1,37),(4523,'ARMANDO EDUARDO CERVANTES ESPINOZA',3,'5523635965',3,37),(4524,'ARMANDO SANCHEZ',3,'5573682465',1,37),(4525,'ARMANDO VARGAS',3,'5531162486',1,37),(4526,'ARMANDO VEGA',3,'5610009288',1,37),(4527,'ARON DIAZ',3,'5533831759',1,37),(4528,'ARON DOMINGUEZ (LOCATARIO)',3,'5611320149',3,37),(4529,'ARON JOSUE MARTINEZ',3,'5580366534',1,37),(4530,'ARON PRECEDA',3,'SN',1,37),(4531,'ARTEMIO FIERROS  VALENCIA',3,'5554150891',1,37),(4532,'ARTURO CARDENAS JARAMILLO',3,'5614874716',1,37),(4533,'ARTURO COUTOLEMC',3,'5516569399',4,37),(4534,'ARTURO DE JESUS GODOY  ROSAS',3,'5566734753',1,37),(4535,'ARTURO ESPINOZA PEREZ',3,'5582194628',1,37),(4536,'ARTURO GALVAN CHAVEZ',3,'5570073113',1,37),(4537,'ARTURO LIRA',3,'5551814244',1,37),(4538,'ARTURO MACIAS',3,'SN',1,37),(4539,'ARTURO MATA ALONSO',3,'5571826093',1,37),(4540,'ARTURO ROMERO HERNANDEZ',3,'5620430004',1,37),(4541,'ARTURO VALDEZ BERNAL',3,'5511841949',3,37),(4542,'ARYMI MENDOZA SILVA',3,'5610128453',1,37),(4543,'ASAÍ MARTINEZ.',3,'5584538070',1,37),(4544,'ASSIEL HERNANDEZ GARCIA',3,'5568600917',4,37),(4545,'AURORA LOPEZ BASURTO',3,'5541846190',1,37),(4546,'AURORA RAMIMREZ',3,'SN',1,37),(4547,'AVISAC MARTINEZ CRUZ',3,'SN',1,37),(4548,'AXEL ADAN CRUZ',3,'SN',1,37),(4549,'AXEL ANTONIO PEÑALOZA REYES',3,'5522125807',1,37),(4550,'AXEL ANTONIO RIZO',3,'5511981323',1,37),(4551,'AXEL CASTRO GARCIA',3,'5574349796',1,37),(4552,'AXEL CORPUS ACEVES',3,'5614621499',1,37),(4553,'AXEL FONSECA PERALES INSTRUCTOR',3,'5543889681',4,37),(4554,'AXEL GABRIEL SALGADO ALEGRIA',3,'5630752799',1,37),(4555,'AXEL GARCIA QUIROZ',3,'5569654083',1,37),(4556,'AXEL RAMIREZ ROMERO',3,'5611177760',3,37),(4557,'AXEL RAMON GONZALEZ',3,'5627455029',1,37),(4558,'AXEL ROBLES',3,'5618521129',1,37),(4559,'AXEL SANCHEZ',3,'5610073830',3,37),(4560,'AYLIN SOLANO',3,'5545656695',4,37),(4561,'BALDO BENITEZ CRUZ',3,'5614233981',1,37),(4562,'BEATRIZ ESTRADA',3,'5527736242',1,37),(4563,'beatriz medina jimenez',3,'5514587756',1,37),(4564,'BEATRIZ SALVADOR',3,'5545645164',1,37),(4565,'BEATRIZ SOLACHE GYM MURAT',3,'5585869507',4,37),(4566,'BENITO HERNANDEZ CRUZ',3,'5537057062',1,37),(4567,'BENITO MIRANDA GARCIA',3,'SN',1,37),(4568,'BENITO SORIA ALEJANDRE',3,'5540916435',1,37),(4569,'BENITO SORIA P.CIVIL',3,'5540916435',4,37),(4570,'BENJAMIN GONZALES',3,'5577427316',1,37),(4571,'BENJAMIN MENDOZA',3,'5525143269',1,37),(4572,'BERENICE MACEDO ORTEGA',3,'5549471927',1,37),(4573,'BERENICE RAGOYTIA',3,'5624208214',1,37),(4574,'BERNARDO VARGAS SALIDAS',3,'SN',1,37),(4575,'BETO MERCADO',3,'SN',1,37),(4576,'BIRZAYIT GARCIA',3,'5543873605',4,37),(4577,'BLANCA ALVAREZ',3,'5578011727',1,37),(4578,'BLANCA ESTELA REYES AGUILAR',3,'5560907982',1,37),(4579,'BLANCA GUEVARA TRINIDAD',3,'SN',1,37),(4580,'BLANCA ZARIÑAN ALVAREZ',3,'5578011727',1,37),(4581,'brandon alexis ramirez yescas',3,'5530290342',1,37),(4582,'BRANDON ESQUIVEL',3,'SN',1,37),(4583,'BRANDON MARTINEZ',3,'5550755091',1,37),(4584,'BRAULIO ACOSTA',3,'5541834861',1,37),(4585,'BRAULIO CESAR HUITRON GARCIA',3,'5561832183',1,37),(4586,'BRAULIO GARCIA CALDERON',3,'5612985300',1,37),(4587,'BRAYAN ALEXANDER ISLAS LONGORIA',3,'5578744402',1,37),(4588,'BRAYAN CRUZ',3,'SN',1,37),(4589,'BRAYAN GUZMAN BERNAL',3,'5572218028',1,37),(4590,'BRENDA AGUILAR SANDOVAL',3,'5527989910',1,37),(4591,'BRENDA JANET CRUZ ACEBEDO',3,'5614657621',1,37),(4592,'BRENDA JANETE CRUZ ACEVEDO',3,'5521176831',1,37),(4593,'BRENDA LOMAS',3,'5536424638',1,37),(4594,'BRENDA MENA',3,'5611575312',1,37),(4595,'BRENDA MICHELLE MORALES HERRERA',3,'5547850803',1,37),(4596,'BRENDA SOFIA TORRES',3,'5544796872',1,37),(4597,'BRENDA VEGA',3,'5523385855',1,37),(4598,'BRENDA VILLAGOMEZ HERNANDEZ',3,'5614354602',1,37),(4599,'BRIAN CRUZ',3,'5537728381',1,37),(4600,'BRIAN DANIEL',3,'5635248372',1,37),(4601,'brian luna',3,'SN',1,37),(4602,'BRISELDA EVELYN RODRIGUEZ HERNANDEZ',3,'SN',1,37),(4603,'BRISSA NOEMI GOMEZ MENDEZ',3,'5631131085',1,37),(4604,'BRUNO BUSTOS ANTONIO',3,'5554314600',1,37),(4605,'BRUNO OLMOS CLIMACO',3,'5511792933',1,37),(4606,'BRYAN CARBAJAL',3,'5560418538',1,37),(4607,'BRYAN MAURICIO DIAZ',3,'5540630223',4,37),(4608,'BRYAN MOISES GONZALEZ RIVERA',3,'5624091453',1,37),(4609,'BRYAN RICARDO MEDINA CARRILLO',3,'5631357359',1,37),(4610,'CALOS JUAREZ YAÑEZ',3,'5554085214',1,37),(4611,'Camerino Mendoza',3,'SN',1,37),(4612,'CARLA GALAN',3,'5518561472',1,37),(4613,'CARLOS AGUSTO PIÑA',3,'5519024612',1,37),(4614,'CARLOS ALBERTO LOPEZ MARTINEZ',3,'5548556357',1,37),(4615,'CARLOS ALBERTO MORA MORALES',3,'5585425685',1,37),(4616,'CARLOS ALFARO',3,'2294382896',4,37),(4617,'CARLOS ALFARO SALDAÑA',3,'2294382896',1,37),(4618,'CARLOS AMBROSIO',3,'SN',1,37),(4619,'CARLOS ANDRES GARCIA MARTINEZ',3,'5549962638',1,37),(4620,'CARLOS ARAGON',3,'5578060535',1,37),(4621,'CARLOS CASTRO',3,'5510496863',1,37),(4622,'CARLOS CIRIACO',3,'SN',1,37),(4623,'CARLOS DAVILA SILVA',3,'5510806481',1,37),(4624,'CARLOS ESCOBAR',3,'SN',4,37),(4625,'CARLOS FRANCISCO MORENO RAMIREZ',3,'5576893401',1,37),(4626,'CARLOS HIDALGO',3,'5564263198',1,37),(4627,'CARLOS HUERTA HERNANDEZ',3,'5510209324',1,37),(4628,'CARLOS JUAREZ',3,'5554085214',1,37),(4629,'CARLOS LOPEZ GARCES',3,'5538257581',1,37),(4630,'CARLOS MARTINEZ',3,'5568032513',1,37),(4631,'CARLOS MARTINEZ ROSAS',3,'5624147819',1,37),(4632,'CARLOS MATELUNA',3,'5535856552',3,37),(4633,'CARLOS MENDEZ FLORES',3,'5561465504',1,37),(4634,'CARLOS MENDOZA',3,'5546344772',1,37),(4635,'CARLOS MENDOZA',3,'5546343772',1,37),(4636,'CARLOS MENDOZA DIAZ',3,'5534859273',1,37),(4637,'CARLOS MIGUEL SANCHEZ MIRANDA',3,'5580320628',1,37),(4638,'CARLOS MONTAÑO',3,'5550609159',1,37),(4639,'Carlos Mora',3,'5565076147',1,37),(4640,'CARLOS NIEVES',3,'5581742850',1,37),(4641,'CARLOS NOLASCO  GYM LIBERTAD',3,'SN',4,37),(4642,'Carlos Olvera',3,'5587443886',1,37),(4643,'CARLOS OSWALDO URRIETA ASUNCION',3,'5571182183',1,37),(4644,'CARLOS RL',3,'SN',4,37),(4645,'CARLOS SAID CORTEZ TEODORO',3,'5519800082',1,37),(4646,'CARLOS VARGAS MONROY',3,'5540021160',1,37),(4647,'CARLOS VELARDE',3,'5519578574',1,37),(4648,'CARLOS YHOASIN MONTOYA',3,'5578522813',1,37),(4649,'CARLOS ZAMUDIO',3,'5578060535',1,37),(4650,'CARLOS ZEPEDA  SANCHEZ',3,'5522648162',1,37),(4651,'CARMEN ARROYO',3,'SN',1,37),(4652,'CARMEN PORTILLO CRUZ',3,'5534410730',1,37),(4653,'CARMIN ROA INSTRUCTOR',3,'SN',4,37),(4654,'CARO IBAMAR',3,'SN',1,37),(4655,'carol  celene flores',3,'5580171816',1,37),(4656,'CAROLINA CAMACHO TORRES',3,'5587939268',1,37),(4657,'CAROLINA IBAÑEZ',3,'5570908085',1,37),(4658,'CAROLINA MIRANDA MORALES',3,'5548418407',1,37),(4659,'CAROLINA MUÑOS',3,'5581329245',1,37),(4660,'CAROLINA RODRIGUEZ',3,'5577890094',3,37),(4661,'CASANDRA CORNEJO',3,'SN',3,37),(4662,'CASANDRA MUÑOZ NEAVE',3,'5572273620',1,37),(4663,'CECILIA',3,'SN',1,37),(4664,'CECILIA CORONA CAMPOS',3,'5520940017',1,37),(4665,'CECILIA HERNANDEZ',3,'5540440103',1,37),(4666,'CECILIA OVIEDO',3,'SN',1,37),(4667,'CECILIA VARGAS',3,'5510495938',1,37),(4668,'CELIC YETLANEZI MOSQUEDA FLORES',3,'5526942649',3,37),(4669,'CELINA CRUZ',3,'5521951303',1,37),(4670,'CESAR ALEJANDRO FLORES REZA',3,'5539576455',1,37),(4671,'CÉSAR ALVARADO',3,'5574075870',1,37),(4672,'CESAR ALVARADO GYM DEL PUERTO',3,'5574075870',4,37),(4673,'CESAR ARZATE PEREA',3,'5567044664',1,37),(4674,'CESAR AUGUSTO DIONICIO',3,'5560959841',1,37),(4675,'CESAR CABALLERO',3,'5549383949',1,37),(4676,'CESAR CARMONA OLVERA',3,'5565262721',1,37),(4677,'CESAR DAVID  FIERRO MALDONADO',3,'5584812305',1,37),(4678,'CESAR DOMINGUEZ COBARRUBIAS',3,'SN',1,37),(4679,'CESAR GONZALEZ',3,'5532253462',1,37),(4680,'CESAR GUERRERO',3,'5552993233',1,37),(4681,'César Guerrero',3,'5541935349',1,37),(4682,'CESAR GUTIERREZ',3,'5543964840',1,37),(4683,'CESAR LANDEROS LOPEZ',3,'5532482193',1,37),(4684,'CESAR MAURICIO GONZALEZ',3,'5534011495',4,37),(4685,'César Mauricio López Maldonado.',3,'5574158102',1,37),(4686,'CESAR MAURIZIO GONZALEZ SANCHEZ',3,'5534011495',1,37),(4687,'CESAR MENDOZA CASTALLEDA',3,'5580223655',1,37),(4688,'CESAR MORALES HERNANDEZ',3,'5544226697',1,37),(4689,'Cesar Olvera',3,'5513368749',1,37),(4690,'CESAR SANCHEZ',3,'5584983057',1,37),(4691,'CESIA ELOISA LOPEZ',3,'5583194192',1,37),(4692,'CINTHIA CRUZ',3,'5581716618',1,37),(4693,'CINTHYA FLORES',3,'5519163430',1,37),(4694,'CLARA REYES',3,'5561427644',1,37),(4695,'CLARA REYEZ',3,'SN',1,37),(4696,'CLARISSA DIAZ TINAJERO',3,'5626028648',1,37),(4697,'CLAUDIA BERNAL ORDOÑEZ',3,'5632929229',1,37),(4698,'CLAUDIA DE LA CRUZ LOPEZ',3,'5513303331',1,37),(4699,'CLAUDIA ELBA TORRES',3,'5529669739',1,37),(4700,'CLAUDIA GOMEZ',3,'5519626747',1,37),(4701,'CLAUDIA JIMENEZ',3,'5633536637',1,37),(4702,'CLAUDIA JIMENEZ GALVAN',3,'5574519709',1,37),(4703,'CLAUDIA MARIN',3,'5548512457',1,37),(4704,'CLAUDIA URIBE GOMEZ',3,'5543428108',1,37),(4705,'CLAUDIA URIBE GOMEZ',3,'5543428108',1,37),(4706,'CONRADO MARIN',3,'5541933223',1,37),(4707,'CONRADO MONRROY MATEOS',3,'5635427323',1,37),(4708,'CORINA LOPEZ HERNANDEZ',3,'5555058025',1,37),(4709,'CRISTEL ORTIZ',3,'5549501538',1,37),(4710,'CRISTHIAN ROJAS',3,'5617887469',1,37),(4711,'CRISTIAN CASTRO DENTALVIS',3,'SN',4,37),(4712,'CRISTIAN GARCIA DIAZ',3,'5546039178',1,37),(4713,'CRISTIAN GUTIERRES FLORES',3,'5568921476',1,37),(4714,'CRISTIAN HERNÁNDEZ',3,'5583681506',1,37),(4715,'CRISTIAN JACINTO ROQUE',3,'5564096300',1,37),(4716,'CRISTIAN LUA',3,'5514630213',1,37),(4717,'CRISTIAN MENDOZA',3,'5543285267',1,37),(4718,'CRISTIAN RIVERA',3,'SN',1,37),(4719,'CRISTIAN TORRIJOS',3,'5576735006',1,37),(4720,'CRISTIAN VILLANUEVA',3,'5565432043',4,37),(4721,'CRISTINA HERNANDEZ',3,'5542213172',1,37),(4722,'CRISTINA SANCHEZ VARGAS',3,'4421588355',1,37),(4723,'CRISTINA VALDEZ',3,'5612844362',1,37),(4724,'CRISTOBAL ORTEGA',3,'5529295459',1,37),(4725,'CRISTOPHER ALEXANDER',3,'SN',1,37),(4726,'CRISTOPHER BARRIDO',3,'5510732380',3,37),(4727,'CRISTOPHER DE LA O',3,'5529701318',1,37),(4728,'CYNTHIA SALCEDO',3,'5529682941',1,37),(4729,'cyntia sanchez',3,'SN',1,37),(4730,'DAISY HENDIOLA MARIN',3,'5567539941',1,37),(4731,'DALID ALCANTARA',3,'SN',1,37),(4732,'DAMIAN DAVILA',3,'5562525596',1,37),(4733,'DANA AGUIRRE',3,'5624840309',1,37),(4734,'DANA HERNANDEZ MONZON',3,'5612944559',1,37),(4735,'DANAE SERRANO',3,'5579125802',1,37),(4736,'DANEIL LORENZO VARGAS',3,'5535590699',1,37),(4737,'daniel',3,'SN',1,37),(4738,'DANIEL ALDAIR SANCHEZ RIVAS',3,'5626588119',3,37),(4739,'DANIEL ANTONIO GOMEZ',3,'5574508689',1,37),(4740,'DANIEL ARRAGOI',3,'SN',1,37),(4741,'DANIEL BECERRA',3,'5528488985',1,37),(4742,'DANIEL BELMONTES',3,'5547144152',3,37),(4743,'DANIEL BOLOÑA',3,'5533643923',1,37),(4744,'DANIEL CASTAÑEDA CASTILLO',3,'5587595550',1,37),(4745,'DANIEL CAZARES',3,'SN',1,37),(4746,'DANIEL DELGADO',3,'5570468875',1,37),(4747,'DANIEL DIAZ LOCAL STA CLARA',3,'5561108024',4,37),(4748,'DANIEL FERRUSCA',3,'5542653691',1,37),(4749,'DANIEL GALINDO LOPEZ',3,'SN',1,37),(4750,'DANIEL GALINDO LOPEZ',3,'5630283820',1,37),(4751,'DANIEL GALINDO LOPEZ',3,'5627170004',1,37),(4752,'DANIEL GARCIA',3,'5548989838',1,37),(4753,'DANIEL GARCIA',3,'5517560005',1,37),(4754,'DANIEL GARCIA FLORES',3,'5542530343',1,37),(4755,'DANIEL GARCIA MARQUEZ',3,'5517560005',1,37),(4756,'DANIEL GOMEZ',3,'5510937564',1,37),(4757,'DANIEL GONZALEZ',3,'5291366402',1,37),(4758,'DANIEL GUZMAN',3,'5549620980',1,37),(4759,'DANIEL HERNANDEZ SALGADO',3,'SN',1,37),(4760,'DANIEL JONATHAN LUGO',3,'SN',1,37),(4761,'DANIEL JUÁREZ',3,'5514605681',1,37),(4762,'DANIEL MALAGON',3,'SN',1,37),(4763,'DANIEL MUÑOZ',3,'SN',1,37),(4764,'DANIEL MÚÑOZ',3,'5516404632',1,37),(4765,'DANIEL NOAH LARRAGOITE',3,'5542405199',1,37),(4766,'DANIEL OSNAYA',3,'5579108841',1,37),(4767,'DANIEL PALAGOT',3,'5528235013',1,37),(4768,'DANIEL RAMIREZ BECERRIL',3,'5525336686',1,37),(4769,'DANIEL RIVAS PUENTE',3,'5571791219',1,37),(4770,'DANIEL RIVERA',3,'5535944726',1,37),(4771,'DANIEL RIVERA BELLO',3,'5540256065',1,37),(4772,'DANIEL RIVERA PROGRESO',3,'SN',3,37),(4773,'Daniel Rodriguez',3,'5534038928',1,37),(4774,'DANIEL SANCHEZ',3,'5513437049',1,37),(4775,'DANIEL SANTIAGO MORENO',3,'5526749252',1,37),(4776,'DANIEL ULISES ACEVEDO',3,'5516813754',1,37),(4777,'DANIELA ADRIANA MAYA ROMERO',3,'5567816927',1,37),(4778,'DANIELA AGUILAR',3,'5536611753',1,37),(4779,'DANIELA ALDAIR SANCHEZ RIVAS',3,'5515700709',1,37),(4780,'DANIELA GARCIA',3,'5513774226',1,37),(4781,'DANIELA GARCIA ALEMAN',3,'5572147095',1,37),(4782,'DANIELA GISELLE FALCON ARCIA',3,'5543513690',1,37),(4783,'DANIELA GODFREY AVENDAÑO',3,'5572916959',1,37),(4784,'DANIELA GOMEZ SALAZAR',3,'5539733234',1,37),(4785,'DANIELA GONZALES',3,'SN',1,37),(4786,'DANIELA LIRA',3,'SN',4,37),(4787,'DANIELA LOPEZ ZUÑIGA',3,'5586144475',1,37),(4788,'DANIELA MICHEL SOSA',3,'5540330267',1,37),(4789,'DANIELA RUBI HERNANDEZ HERNANDEZ',3,'5579453553',1,37),(4790,'DANIELA XAVIER MEJIA',3,'5548333903',1,37),(4791,'DANNA GONZALEZ',3,'5537025405',1,37),(4792,'DANTE ARAGON',3,'SN',1,37),(4793,'DANTE ARAGON',3,'5512812456',1,37),(4794,'DARIO HERNANDEZ GARCIA',3,'9211674767',1,37),(4795,'DAVID ABRAHAM TELLEZ BAUTISTA',3,'5584904028',1,37),(4796,'DAVID ALFREDO LOPEZ',3,'5578079005',3,37),(4797,'DAVID ALMAZAN LARA',3,'5571096210',1,37),(4798,'DAVID ARNULFO ALVAREZ',3,'5536782571',1,37),(4799,'DAVID CHIHUAHUA',3,'SN',1,37),(4800,'DAVID FERNANDO GYM BLACK & WHITE',3,'5539392961',3,37),(4801,'DAVID FERNANDO JUAREZ',3,'5539392961',1,37),(4802,'DAVID FLORES',3,'5626268886',4,37),(4803,'DAVID GARCIA',3,'5647833688',1,37),(4804,'DAVID GOMEZ',3,'5564107722',1,37),(4805,'DAVID GONZALEZ',3,'5529972700',1,37),(4806,'DAVID HUGO MUÑOZ IBARRA',3,'5626753200',1,37),(4807,'DAVID MALDONADO',3,'5518270222',1,37),(4808,'DAVID MAYO',3,'5612063175',1,37),(4809,'DAVID MORALES',3,'SN',1,37),(4810,'DAVID OMAR AQUINO MORAN',3,'5577280902',1,37),(4811,'DAVID OSNAYA',3,'5576699538',1,37),(4812,'DAVID RAMIREZ AMACOSTA',3,'5543592320',1,37),(4813,'DAVID RANGEL',3,'SN',1,37),(4814,'DAVID ROSAS LARA',3,'5610786642',1,37),(4815,'DAVID SANDOVAL CHAVEZ',3,'5626866837',1,37),(4816,'DAVID URSUA',3,'5565082675',1,37),(4817,'DAVID VARGAS SANCHEZ',3,'SN',3,37),(4818,'DAVID VEGA',3,'5569102465',1,37),(4819,'DELIA GYM GLOBO',3,'SN',4,37),(4820,'DENNISE PANIAGUA',3,'5611603864',1,37),(4821,'DEREK OLMOS CALLEJA',3,'5558281134',1,37),(4822,'DIANA AGUILAR BOLAÑOZ',3,'5539971142',1,37),(4823,'DIANA DE LA CRUZ',3,'5526633877',1,37),(4824,'DIANA GABRIELA VARGAS LOPEZ',3,'5512944605',1,37),(4825,'DIANA GRANDE BENITEZ',3,'5535301376',1,37),(4826,'DIANA HERNANDEZ',3,'5548651669',1,37),(4827,'DIANA HERNANDEZ JIMENEZ',3,'5541809182',1,37),(4828,'DIANA IRENE HERNANDEZ MACIAS',3,'5516259924',4,37),(4829,'DIANA IVETTE HERNANDEZ',3,'5525033195',1,37),(4830,'DIANA JESSICA VILLANUEVA REYES',3,'SN',1,37),(4831,'DIANA LAURA OLMEDO MENDEZ',3,'5618585410',1,37),(4832,'DIANA LAURA PRIMITIVO',3,'5571297672',1,37),(4833,'DIANA LITZI FLORES CARRANZA',3,'5514877531',1,37),(4834,'DIANA LIZETH DUARTE',3,'5555912407',1,37),(4835,'DIANA MARIA GARCIA',3,'5584076447',1,37),(4836,'DIANA MARIA GARCIA JIMENEZ',3,'5561090286',3,37),(4837,'DIANA MARTINEZ',3,'5512217385',1,37),(4838,'DIANA MARTINEZ ALVARADO',3,'5578446895',1,37),(4839,'DIANA MENDOZA CESAR GYM',3,'5619138983',3,37),(4840,'DIANA SABINO CRUZ',3,'5574441972',1,37),(4841,'DIEGO AGUILAR',3,'5513085822',1,37),(4842,'DIEGO AGUILAR UGALDE',3,'SN',1,37),(4843,'DIEGO ARMANDO GOMEZ DIAZ',3,'5518484784',1,37),(4844,'DIEGO BAUTISTA',3,'56149364971',1,37),(4845,'DIEGO CASTILLO LORENZANA',3,'5542146564',3,37),(4846,'DIEGO CIGARROA',3,'5567038985',1,37),(4847,'DIEGO GOMEZ',3,'SN',1,37),(4848,'DIEGO GONZALEZ RODRIGUEZ',3,'5532242688',1,37),(4849,'DIEGO LUCAS CASTILLO',3,'5585091763',1,37),(4850,'DIEGO LUGO ZARRAGA',3,'5573354967',1,37),(4851,'DIEGO MAGAÑA',3,'5586193740',1,37),(4852,'DIEGO PEREZ',3,'5568186373',4,37),(4853,'DIEGO RANGEL RUIZ',3,'5611129114',1,37),(4854,'DIEGO ROJAS VIDAL',3,'5572052938',1,37),(4855,'DIEGO SANTIAGO SANTIAGO',3,'5637090945',1,37),(4856,'DIEGO VARGAS',3,'5577908410',1,37),(4857,'DIEJO IVAN MARTINEZ FLORES',3,'5549381428',1,37),(4858,'DINORA HIDALGO ALMAZAN',3,'5516801374',1,37),(4859,'DIONISIO VILLEGAS',3,'5516904665',1,37),(4860,'DIOSMA CISNEROS',3,'5513855471',1,37),(4861,'DOLLY ESTELA BENITEZ',3,'5518216401',1,37),(4862,'DOLORES JIMENEZ',3,'SN',1,37),(4863,'DONOVAN ESCOGIDO',3,'5568941650',1,37),(4864,'DONOVAN HERRERA',3,'5621167087',1,37),(4865,'DORIAN ESTRADA',3,'SN',1,37),(4866,'DULCE ALEJANDRA ACEVEZ GONZALEZ',3,'5566797325',1,37),(4867,'DULCE CARLA RANGEL RIVERA',3,'5572240679',1,37),(4868,'DULCE ORTEGA',3,'5583372063',1,37),(4869,'DULCE ORTEGA',3,'5622058895',1,37),(4870,'DULCE ROSARIO  BARTOLO SANTIAGO',3,'554437063',1,37),(4871,'DYLAN LOPEZ',3,'5630930140',1,37),(4872,'EDDIE HERNANDEZ',3,'SN',1,37),(4873,'EDER CASTAÑEDA',3,'5558206909',1,37),(4874,'EDGAR ABDIAS LORA REYES',3,'5531342225',1,37),(4875,'EDGAR ALBERTO SALAZAR ANDRES',3,'5569048618',4,37),(4876,'EDGAR ALEJANDRO FRACISCO CRUZ',3,'SN',1,37),(4877,'EDGAR ARELLANO BLAQUEL',3,'5544392763',4,37),(4878,'EDGAR ARTURO FLORES BLANCO',3,'SN',1,37),(4879,'EDGAR AUGUSTO ALMONASI SANTOS',3,'5526759192',1,37),(4880,'EDGAR BECERRIL DE LA ROSA',3,'5612705532',1,37),(4881,'edgar briseño',3,'5513188580',1,37),(4882,'EDGAR CRUZ OSORIO',3,'5561262972',1,37),(4883,'EDGAR DORANTES',3,'5534485034',1,37),(4884,'EDGAR ELUIT ESPINOZA',3,'5584402674',1,37),(4885,'EDGAR FLORES',3,'SN',1,37),(4886,'EDGAR GARCIA SALAZAR',3,'5516102204',1,37),(4887,'EDGAR GARDUÑO',3,'SN',1,37),(4888,'EDGAR GOMEZ',3,'5571939003',1,37),(4889,'EDGAR GOMEZ OROZCO',3,'5539587287',1,37),(4890,'EDGAR GUZMAN',3,'SN',1,37),(4891,'EDGAR HERNANDEZ DEL ANGEL',3,'5555088944',1,37),(4892,'EDGAR MORALES GARCIA',3,'5613961762',1,37),(4893,'Edgar Nolasco',3,'5560751339',1,37),(4894,'EDGAR RODRIGUEZ',3,'5582559375',1,37),(4895,'EDGAR RUIZ',3,'5528211976',1,37),(4896,'EDGAR ULISES ANGELES TELLEZ',3,'5518911170',3,37),(4897,'EDGAR ULISES ARTEAGA GUERRERO',3,'5544726320',1,37),(4898,'EDGAR URAGA',3,'5544544645',1,37),(4899,'EDGAR VARGAS FRAGOSO',3,'SN',1,37),(4900,'EDGAR VILLANUEVA',3,'5540611228',1,37),(4901,'EDGAR ZAMUDIO',3,'5545977753',1,37),(4902,'EDGARDO GARCIA GONZALEZ',3,'5552154567',1,37),(4903,'EDGARDO GARCÍA GONZALEZ',3,'5552154567',1,37),(4904,'EDITH CEDILLO',3,'5564785391',3,37),(4905,'EDITH CRUZ CARRILLO',3,'5554667735',1,37),(4906,'EDITH JIMENEZ',3,'5532669815',1,37),(4907,'EDITH RABIOS LÓPEZ.',3,'5529003140',1,37),(4908,'EDMUNDO',3,'5521811504',1,37),(4909,'EDNA AIDE BECERRA CORNEJO',3,'5545958026',1,37),(4910,'EDNA ARENAS DOMINGUEZ',3,'5518819882',2,37),(4911,'EDSON VALDERRAMA',3,'5532694067',1,37),(4912,'EDUARDO AGUILERA CORDINADOR POLICIA',3,'5547758493',1,37),(4913,'EDUARDO AGUIRRE',3,'5559901899',1,37),(4914,'EDUARDO ARTURO RODRIGUEZ SANCHEZ',3,'5624106083',1,37),(4915,'EDUARDO BERNAL FLORES',3,'5540715686',1,37),(4916,'EDUARDO CHAVIRA GARDUÑO',3,'5585044152',1,37),(4917,'EDUARDO CRUZ BALLESTEROS',3,'5620231443',1,37),(4918,'EDUARDO DANIEL RIVERA MARTINEZ',3,'5581629372',4,37),(4919,'EDUARDO FLORES BERNAL',3,'SN',1,37),(4920,'EDUARDO GALVÁN',3,'5564193479',1,37),(4921,'EDUARDO GONZALEZ',3,'5566882604',1,37),(4922,'EDUARDO GUZMAN PEREZ',3,'5575067692',1,37),(4923,'EDUARDO HERNANDEZ',3,'5527377255',1,37),(4924,'EDUARDO HERNANDEZ TAPIA',3,'5537642172',1,37),(4925,'EDUARDO JAIME GUZMAN TOWN CENTER',3,'5536549504',1,37),(4926,'EDUARDO LUIS PEREZ',3,'5618371186',1,37),(4927,'EDUARDO MALDONADO',3,'5545545000',1,37),(4928,'EDUARDO MALDONADO',3,'5545545000',1,37),(4929,'EDUARDO MALDONADO MARTINEZ',3,'5545545000',1,37),(4930,'EDUARDO MARQUEZ',3,'5547781682',1,37),(4931,'EDUARDO MATEO NEGRETE TREJO',3,'5585720127',1,37),(4932,'EDUARDO MELCHOR',3,'5574325928',1,37),(4933,'EDUARDO MERCADO',3,'5624345068',1,37),(4934,'EDUARDO MIGUEL REYES',3,'5552872735',1,37),(4935,'EDUARDO MOLINA',3,'5544892344',1,37),(4936,'EDUARDO MORALES SUAREZ',3,'5565234210',1,37),(4937,'EDUARDO PALACIOS ARTEAGA',3,'5543247864',1,37),(4938,'EDUARDO PEREZ',3,'SN',1,37),(4939,'EDUARDO PEREZ LOPEZ',3,'5524497108',1,37),(4940,'EDUARDO RODRIGUEZ',3,'SN',1,37),(4941,'EDUARDO ROMERO',3,'5562065028',1,37),(4942,'EDUARDO SALAZAR',3,'5545926939',1,37),(4943,'EDUARDO SANCHEZ',3,'5521320340',1,37),(4944,'EDUARDO TRONCOSO',3,'5529998602',1,37),(4945,'EDUARDO YAÑEZ SALGADO',3,'5523917804',1,37),(4946,'EDUARDO ZARZA',3,'5540017482',1,37),(4947,'EDWIN RODRIGO',3,'5626742963',1,37),(4948,'EDWIN VARGAS CRUZ',3,'5525654049',1,37),(4949,'EFRAIN BLAZ',3,'5539019582',1,37),(4950,'EFRAIN RODRIGUEZ DIAZ',3,'5569608732',1,37),(4951,'EFREN GONZALEZ ROMO',3,'SN',1,37),(4952,'ELDER FRANCKAERT',3,'5543841143',1,37),(4953,'ELEAZAR AGUILAR',3,'5522059649',1,37),(4954,'ELEAZAR ORTEGA',3,'5548664302',1,37),(4955,'ELIANA ROMERO',3,'SN',1,37),(4956,'ELISA MARQUEZ',3,'5525351172',1,37),(4957,'ELIZABETH ALBINO',3,'5584464748',1,37),(4958,'ELIZABETH ARTEAGA PAZ',3,'5573936982',1,37),(4959,'ELIZABETH CASTILLON COACH',3,'SN',4,37),(4960,'ELIZABETH HERRERA',3,'SN',1,37),(4961,'ELIZABETH JARAMILLO LICEA',3,'5522578962',1,37),(4962,'ELIZABETH MACHUCA',3,'5573579808',1,37),(4963,'ELIZABETH MACHUCA  GARCIA',3,'5511820923',1,37),(4964,'ELIZABETH PONCE DE LEON FLORES',3,'5520901836',1,37),(4965,'ELIZABETH SANCHEZ',3,'5514964065',1,37),(4966,'ELIZETH RODRIGUEZ',3,'5535693483',1,37),(4967,'ELOY GARCIA',3,'SN',1,37),(4968,'ELSA TORRES',3,'5568065364',1,37),(4969,'ELVIRA ANTONIO ORTEGA',3,'5533884763',1,37),(4970,'EMANUEL ALEJANDRO RODRIGUEZ GONZALEZ',3,'SN',1,37),(4971,'EMANUEL BECERRA',3,'5539337977',1,37),(4972,'EMANUEL CEDILLO',3,'SN',1,37),(4973,'EMANUEL CRUZ HERNANDEZ',3,'5544158410',1,37),(4974,'EMANUEL GONZALES MARTINEZ',3,'5586878950',1,37),(4975,'EMANUEL GONZALEZ',3,'5522466493',1,37),(4976,'EMANUEL GYM VICENTE',3,'SN',4,37),(4977,'emanuel juceppe roa',3,'5622143090',1,37),(4978,'emanuel martinez',3,'5523446685',1,37),(4979,'emanuel reyes',3,'5543584845',1,37),(4980,'EMANUEL RODRIGUEZ',3,'5588228843',1,37),(4981,'EMANUEL TELLEZ GOMEZ',3,'5585321901',1,37),(4982,'emanuel torres',3,'5633033471',1,37),(4983,'EMILI AMAIRAMI AMARAZ',3,'5530741593',1,37),(4984,'EMILIANO MACIAS LUCAS',3,'5614854316',1,37),(4985,'EMILIO ALEJANDRO MIJARES',3,'5564563602',1,37),(4986,'EMILIO MORALES',3,'5622003857',1,37),(4987,'EMILY DANIELA RIVERA',3,'5574917679',1,37),(4988,'EMIR TINOCO',3,'5627483356',1,37),(4989,'EMMA CARBONERAS',3,'SN',1,37),(4990,'EMMA COPCA',3,'5560663424',1,37),(4991,'EMMANUEL CRUZ GARROSA',3,'5546526870',1,37),(4992,'emmanuel gonzalez',3,'5554647131',1,37),(4993,'EMMANUEL OSCOY',3,'5529379132',1,37),(4994,'EMMANUEL ZAHUNA HERNANDEZ',3,'5540496808',1,37),(4995,'EMMANUELA JOSEFINA RAMIREZ BARRIENTOS',3,'5554326602',1,37),(4996,'EMMANUELLE RUIZ',3,'5517789364',1,37),(4997,'ENRIQUE FLORES',3,'5576345560',1,37),(4998,'ENRIQUE GAMBOA RODRIGUEZ',3,'5517025442',1,37),(4999,'ENRIQUE GARCIA',3,'5548737867',1,37),(5000,'ENRIQUE GOVEA',3,'5561217540',1,37),(5001,'ENRIQUE LOPEZ ORTEGA',3,'5535068693',1,37),(5002,'ENRIQUE MONDRAGON',3,'5591416033',1,37),(5003,'ENRIQUE PALOMINO',3,'5616072492',1,37),(5004,'ENRIQUE REYES MUÑOZ',3,'5537010732',1,37),(5005,'ENRIQUE SOTO',3,'5574641981',1,37),(5006,'ENRIQUE VALENCIA',3,'SN',3,37),(5007,'ERANDINE CORPUS',3,'5616943212',1,37),(5008,'ERANDY MOSQUEDA',3,'5564840417',1,37),(5009,'ERCIK BUSTAMANET',3,'SN',1,37),(5010,'ERICA SOLANO',3,'SN',1,37),(5011,'ERICK  ALEXANDER',3,'SN',1,37),(5012,'ERICK ANGELES DIAZ',3,'5512957654',1,37),(5013,'ERICK ANTONIO',3,'5624143737',1,37),(5014,'ERICK BALDERAS',3,'5545673908',1,37),(5015,'ERICK BONILLA JASSO',3,'5624617749',1,37),(5016,'ERICK CARRERAS RODRIGUEZ',3,'5547596350',1,37),(5017,'ERICK CELINES',3,'SN',1,37),(5018,'ERICK CONTRERAS',3,'5534341721',1,37),(5019,'ERICK CRUZ',3,'5532709013',1,37),(5020,'ERICK CRUZ PEREZ',3,'5520703637',1,37),(5021,'ERICK DANIEL',3,'5625955323',1,37),(5022,'ERICK DANIEL GARAY PEREZ',3,'5572176285',1,37),(5023,'ERICK DANIEL HERNANDEZ',3,'5513416177',1,37),(5024,'ERICK DE JESUS TOVAR',3,'5620613365',1,37),(5025,'ERICK DE LA CRUZ',3,'SN',1,37),(5026,'ERICK GIOVANNI MORALES REYES',3,'PENDIENTE',1,37),(5027,'ERICK GONZALEZ VALADEZ',3,'5588330322',4,37),(5028,'ERICK HERNANDEZ',3,'5510495376',1,37),(5029,'ERICK JAIR JASSO IBELLES',3,'SN',1,37),(5030,'ERICK JOYA HERNANDEZ',3,'5541119938',1,37),(5031,'ERICK MARTINEZ',3,'5568671803',1,37),(5032,'ERICK MUSIÑO',3,'5612938446',1,37),(5033,'ERICK PARRA MORENO RAVENS GYM',3,'5612946486',4,37),(5034,'ERICK RAFAEL',3,'5563397582',1,37),(5035,'ERICK RAMIREZ',3,'5554653616',1,37),(5036,'ERICK RAMIREZ CALDERON',3,'5530326152',1,37),(5037,'ERICK RAMIREZ LEAL',3,'5615975603',1,37),(5038,'ERICK RICO GONZALEZ (GYM VIKINGOS)',3,'5626074363',4,37),(5039,'ERICK RODRIGO SERRANO',3,'5581468661',1,37),(5040,'ERICK SALGADO  PEREZ',3,'5540030840',1,37),(5041,'ERICK SALINAS',3,'5514791850',1,37),(5042,'ERICK SANCHEZ JIMENEZ',3,'5614161621',1,37),(5043,'ERICKA GARCIA RIVERA',3,'5544565841',1,37),(5044,'ERICKA LOPEZ',3,'5516852316',1,37),(5045,'ericka monroy',3,'5559436653',1,37),(5046,'ERIK CHAMED JIMENEZ VALENCIA',3,'5532242235',1,37),(5047,'ERIK DANIEL MALDONADO LOPEZ',3,'5535305930',1,37),(5048,'ERIK MAXIMILIANO BARRERA OSNAYA',3,'5520773405',1,37),(5049,'ERIKA CABELLO',3,'SN',1,37),(5050,'ERIKA GUTIERREZ',3,'SN',1,37),(5051,'ERIKA MENDOZA',3,'5518487989',1,37),(5052,'ERIKA RUEDA',3,'5541908919',1,37),(5053,'ERIKA VENTURA',3,'SN',1,37),(5054,'ERNESTO AGUILAR LOPEZ',3,'5568157957',1,37),(5055,'ERNESTO ESCALONA TREJO MAS VISION',3,'6551242901',3,37),(5056,'ERNESTO GARCIA VARGAS',3,'5614884110',1,37),(5057,'ERNESTO GUTIERREZ',3,'SN',1,37),(5058,'ERWIN ALEJANDRO SANCHEZ GONZALEZ',3,'5549573649',1,37),(5059,'Esequiel Vargas',3,'5552851974',1,37),(5060,'ESMERALDA VALLE',3,'5548297050',1,37),(5061,'ESTAFANY ESCALANTE',3,'5524914338',1,37),(5062,'ESTEBAN ADRIAN RIOS HERNANDEZ',3,'6181595937',1,37),(5063,'ESTEBAN CHAVEZ',3,'5545184867',1,37),(5064,'ESTEBAN DURAN TOWN CENTER',3,'SN',1,37),(5065,'ESTEBAN FONSECA',3,'5579171294',4,37),(5066,'ESTEBAN VEGA',3,'5527525062',1,37),(5067,'ESTEFANNY VEGA HERNANDEZ',3,'5515358627',1,37),(5068,'ESTEFANY GUZMAN  LUZ',3,'5618351472',1,37),(5069,'EULALIO CERVANTES ALCANTARA',3,'SN',1,37),(5070,'EURIDICE GARCIA AGUILAR',3,'5676725156',1,37),(5071,'EUSEBIO JUAREZ PEREZ',3,'5578324611',4,37),(5072,'EVELIN GARDUÑO FLORES',3,'5525298679',1,37),(5073,'EVELIN REYES VELAZQ',3,'5575475365',1,37),(5074,'EVELYN MARTINEZ DE LA CRUZ',3,'5584401287',1,37),(5075,'EVER BARAJAS',3,'5564789734',1,37),(5076,'EVER URIEL CUEVAS',3,'5539524640',4,37),(5077,'EXSAEL GOMEZ',3,'5518140118',1,37),(5078,'EZEQUIEL ARTEAGA',3,'5614937654',1,37),(5079,'FABIAN AURELIO',3,'SN',1,37),(5080,'FABIAN BAÑUELOS CRUZ',3,'5516997891',1,37),(5081,'FABIAN JIMENEZ',3,'5561421176',1,37),(5082,'FABIAN NAVARRO ANAMGUAMEA',3,'SN',1,37),(5083,'FABIAN RUIZ',3,'5586817704',1,37),(5084,'FABIAN SERRATS',3,'SN',1,37),(5085,'FABIAN SILVA',3,'5519754791',1,37),(5086,'FABIAN VADILLO FLORES',3,'5613151931',1,37),(5087,'FABIAN VERA',3,'5534762324',3,37),(5088,'FABIAN VERTIZ',3,'SN',1,37),(5089,'FABIOLA  SANCHEZ JUAREZ',3,'5579188483',1,37),(5090,'FABIOLA CASTILLO',3,'5617052675',1,37),(5091,'FABIOLA COYOTE ROBLEDO',3,'5535698320',3,37),(5092,'FABIOLA KARINA GIL ORTEGA',3,'5521533676',1,37),(5093,'FABIOLA XOCHIPA',3,'SN',1,37),(5094,'FATIMA ACARI PALERMO',3,'5582194590',1,37),(5095,'FATIMA CARRASCO',3,'5543814299',1,37),(5096,'FATIMA DE LA ROSA',3,'5523229206',3,37),(5097,'FATIMA FORTANEL',3,'6692515496',1,37),(5098,'FAUSTO MONRROY',3,'5512882593',1,37),(5099,'FAUSTO OCHOA BARAJAS',3,'5547093293',1,37),(5100,'FEDERICO LARA GUERRERO',3,'5534055932',3,37),(5101,'FELICIA CRUZ PEREZ',3,'5614168069',1,37),(5102,'FELIPE DE JESUS',3,'5548523366',1,37),(5103,'FELIPE DE JESUS SANCHEZ',3,'555525684765',1,37),(5104,'FELIPE GUERRERO',3,'5518878553',1,37),(5105,'FELIPE LEOPOR',3,'5546134415',1,37),(5106,'FELIPE LIMON',3,'5520344823',1,37),(5107,'FELIPE PERA RODRIGUEZ',3,'5570480488',1,37),(5108,'FELIPE RAMIREZ',3,'5520069457',1,37),(5109,'FELIPE VARGAS ALVARADO',3,'5534812066',1,37),(5110,'FELIX SOTO DURAN',3,'5573218116',1,37),(5111,'FERMIN ALEJANDRO TRINIDAD MORALES',3,'5546771761',1,37),(5112,'FERMIN ALVARADO',3,'SN',3,37),(5113,'FERNANDA BUCANEROS',3,'SN',4,37),(5114,'FERNANDA GARCIA DEL RIO',3,'5545363961',1,37),(5115,'FERNANDA GARCIA PAVON',3,'5516401526',1,37),(5116,'FERNANDA TORRES MORALES',3,'5624384512',1,37),(5117,'FERNANDO ALVA JIMENEZ',3,'5514400812',1,37),(5118,'FERNANDO ANTONIO TAPIA',3,'5583652765',1,37),(5119,'FERNANDO ARELLANO',3,'5616281511',4,37),(5120,'FERNANDO ARRAZOLA BONILLA',3,'5574890155',1,37),(5121,'FERNANDO CORDOBA',3,'5579039765',1,37),(5122,'FERNANDO CRUZ',3,'5578742040',1,37),(5123,'FERNANDO CUEVAS JIMENEZ',3,'5545552299',1,37),(5124,'FERNANDO FRANCISCO ESPINOZA',3,'5511550029',1,37),(5125,'FERNANDO FRNCO',3,'5582129028',1,37),(5126,'FERNANDO GONZALEZ MORENO',3,'5618419958',1,37),(5127,'FERNANDO HERNANDEZ',3,'5550996701',1,37),(5128,'FERNANDO HERNANDEZ LARA',3,'5636275471',1,37),(5129,'Fernando Herrera',3,'5540210525',1,37),(5130,'FERNANDO ISMAEL FUENTES',3,'SN',1,37),(5131,'FERNANDO JIMENEZ CAMACHO',3,'SN',1,37),(5132,'FERNANDO JUAREZ',3,'5559951582',4,37),(5133,'FERNANDO LOPEZ RAMIREZ',3,'5551930010',1,37),(5134,'FERNANDO MARTINEZ',3,'SN',1,37),(5135,'FERNANDO MEDINA LOPEZ P. CIVIL',3,'5537270959',4,37),(5136,'FERNANDO MENDOZA',3,'5560221908',1,37),(5137,'FERNANDO RAMIREZ',3,'5580807041',1,37),(5138,'FERNANDO REYES RAMOS',3,'SN',1,37),(5139,'fernando rocha',3,'5547681706',1,37),(5140,'FERNANDO ROQUE',3,'5577243469',1,37),(5141,'FERNANDO ROSADO',3,'5527495549',1,37),(5142,'FERNANDO ROSALES',3,'5514210489',1,37),(5143,'FERNANDO ROSAS',3,'5527739239',1,37),(5144,'FERNANDO SANTIAGO DOMINGUEZ',3,'5562209084',1,37),(5145,'FERNANDO VARGAS',3,'5551674772',1,37),(5146,'FERNANDO VEGA CADENA',3,'SN',3,37),(5147,'FERNANDO VILCHIS MUÑOZ',3,'5611869711',1,37),(5148,'FERNANDO VILLAFRANCO',3,'5626151771',1,37),(5149,'FIDEL ANGEL RIOS HERRERA',3,'5521908346',3,37),(5150,'FIDEL HERNANDEZ',3,'5541903089',1,37),(5151,'FIDEL HERNANDEZ  HERNANDEZ',3,'5541903089',1,37),(5152,'FLOR LOPEZ LOPEZ',3,'5533014430',1,37),(5153,'FRANCISCO BECERRIL',3,'5536771263',3,37),(5154,'FRANCISCO BRUNO',3,'5583830272',1,37),(5155,'FRANCISCO COLIN TOMAS',3,'5512800522',1,37),(5156,'FRANCISCO DE JESUS',3,'5538571381',1,37),(5157,'FRANCISCO DE JESÚS',3,'5581088364',1,37),(5158,'FRANCISCO ENRIQUE MENDOZA FLORES',3,'5610111997',1,37),(5159,'FRANCISCO ENRIQUE VARON SAINZ',3,'5580262076',1,37),(5160,'FRANCISCO GARCIA',3,'5583413698',1,37),(5161,'FRANCISCO JAVIER CHAVEZ ORTIZ',3,'5544591021',1,37),(5162,'FRANCISCO JAVIER FERNANDEZ GUERRERO',3,'5530598015',1,37),(5163,'FRANCISCO JAVIER HERNANDEZ MEDINA',3,'5565056462',1,37),(5164,'FRANCISCO JAVIER LOREDO REYES',3,'5549340642',1,37),(5165,'FRANCISCO JAVIER ROJANO',3,'5523013930',1,37),(5166,'FRANCISCO JAVIER VICTORIA ZARATE',3,'5580667247',1,37),(5167,'FRANCISCO OSMAR JIMENEZ',3,'5537350219',1,37),(5168,'FRANCISCO PEREZ',3,'5536724623',1,37),(5169,'FRANCISCO PIÑA',3,'SN',1,37),(5170,'FRANCISCO ROA',3,'5531780029',1,37),(5171,'FRANCISCO ROSAS CORNEJO',3,'5584016517',1,37),(5172,'FRANCISCO ROSAS GABRIEL',3,'5527427450',1,37),(5173,'FRANCISCO VALADEZ',3,'5584976955',1,37),(5174,'FRANCISCO VARGAS DORANTES',3,'5554711341',1,37),(5175,'FRANCISCO VERANO',3,'SN',1,37),(5176,'FRANCISCO ZARATE',3,'5579103473',1,37),(5177,'FROY DE SEGURIDAD PUBLICA',3,'5568038309',1,37),(5178,'GABINO PEREZ',3,'5536198319',1,37),(5179,'GABRIEL ANGEL TEJEDA',3,'5544979263',1,37),(5180,'GABRIEL ANGEL TEJEDA QUINTOS',3,'5647087114',1,37),(5181,'GABRIEL ARGUETA',3,'5631330076',1,37),(5182,'GABRIEL ARVIZU LEDESMA',3,'5513862112',1,37),(5183,'GABRIEL AVENDAÑO',3,'5551497455',1,37),(5184,'GABRIEL AVILA',3,'5519483360',1,37),(5185,'GABRIEL CORTES',3,'5576400167',1,37),(5186,'GABRIEL DAVILA DELGADO',3,'5567502882',1,37),(5187,'GABRIEL GARCIA',3,'5538102209',1,37),(5188,'Gabriel Guerrero',3,'5532335355',1,37),(5189,'GABRIEL GUERRERO',3,'5532335355',1,37),(5190,'GABRIEL HUMBERTO RODRIGUEZ FRAUSTO',3,'5580031683',1,37),(5191,'GABRIEL MARCELO',3,'5571194843',1,37),(5192,'GABRIEL MUÑOZ',3,'5646967989',1,37),(5193,'GABRIELA HERNANDEZ',3,'58287160',1,37),(5194,'GABRIELA PEREZ',3,'5631015738',1,37),(5195,'GABRIELA SALAS',3,'5545422610',1,37),(5196,'GABRIELA SANTIAGO CRUZ',3,'5586013418',1,37),(5197,'GABY FLORES',3,'SN',1,37),(5198,'GABY MEZA',3,'5551587097',1,37),(5199,'GAEL FERNANDO DIAZ',3,'5534323304',1,37),(5200,'GAEL LOPEZ',3,'5540952880',1,37),(5201,'GENARO GARCIA',3,'5535521360',1,37),(5202,'GEOVANNA SILVA',3,'5567569690',1,37),(5203,'GEOVANNI GARCIA GARCIA',3,'SN',3,37),(5204,'GEOVANNY LIRA',3,'5527629323',1,37),(5205,'GEOVANNY ROJAS',3,'5613653685',1,37),(5206,'GERARDO ADOLFO CONTRERAS',3,'5561112800',3,37),(5207,'GERARDO ALVARES',3,'SN',1,37),(5208,'GERARDO ALVAREZ GONZALEZ',3,'5546522509',1,37),(5209,'GERARDO BARBOSA',3,'5549627308',1,37),(5210,'GERARDO BENJAMIN SOTO CUEVAS',3,'SN',1,37),(5211,'GERARDO CASTILLO',3,'5610083308',1,37),(5212,'GERARDO ESPEGEL',3,'5523735908',1,37),(5213,'GERARDO GOMEZ',3,'5539986360',1,37),(5214,'GERARDO GONZALEZ MEZA',3,'5533459355',1,37),(5215,'GERARDO JUAREZ GARCIA',3,'5621281150',1,37),(5216,'GERARDO LOPEZ ALARCON',3,'5541419514',1,37),(5217,'GERARDO LOPEZ MARTINEZ',3,'5560830732',1,37),(5218,'gerardo monroy',3,'SN',1,37),(5219,'GERARDO RODOLFO TREJO',3,'5549639312',1,37),(5220,'GERARDO TORRES',3,'5586864666',1,37),(5221,'GERMAN DÍAZ OLMOS',3,'5524971112',1,37),(5222,'GERMAN ORDUÑA',3,'5530694200',1,37),(5223,'GILBERTO MERCADO',3,'5578796374',1,37),(5224,'GIOVANI CONSTANTINO',3,'5560619752',1,37),(5225,'GIOVANI MONROY',3,'5549635977',1,37),(5226,'GIOVANNI COLIN',3,'5565569399',1,37),(5227,'GIOVANNI DE LEON',3,'SN',1,37),(5228,'GIOVANNI SANCHEZ JUAREZ',3,'SN',1,37),(5229,'GIOVANNI SEGUNDO',3,'5614911848',1,37),(5230,'GIOVANNI TAPIA GONZALEZ',3,'SN',1,37),(5231,'GIOVANNY GONZALEZ MENDEZ',3,'5534752229',1,37),(5232,'GISELLE GOMEZ',3,'5568660260',1,37),(5233,'GISELLE GOMEZ DE LA CASA',3,'5547751836',1,37),(5234,'GONZALO CERVANTES',3,'5537114960',1,37),(5235,'GONZALO ESTRADA',3,'5562148921',1,37),(5236,'GRACIELA VAZQUEZ HERNANDEZ',3,'5538050388',1,37),(5237,'GRISEL SANCHEZ HERNANDEZ',3,'5519628964',1,37),(5238,'GUADALUOE FLORES RINCON',3,'5621495124',1,37),(5239,'GUADALUPE  AZALA DE LEON',3,'5580207360',1,37),(5240,'GUADALUPE  LIRA',3,'SN',3,37),(5241,'GUADALUPE ALBA',3,'5532035348',1,37),(5242,'GUADALUPE DIAZ',3,'5566949075',1,37),(5243,'GUADALUPE LOPEZ LOPEZ',3,'5581020506',1,37),(5244,'GUADALUPE REYES ESTRADA',3,'5561642528',1,37),(5245,'GUADALUPE ROMERO',3,'SN',1,37),(5246,'GUADALUPE SALAS',3,'SN',1,37),(5247,'GUADALUPE SANCHEZ GARDUÑO',3,'5527204491',1,37),(5248,'GUADALUPE SANCHEZ REYES',3,'5530582465',1,37),(5249,'GUILLERMO  DAVILA',3,'5534456803',1,37),(5250,'GUILLERMO ALEJANDRO MORALES MENDEZ',3,'SN',1,37),(5251,'GUILLERMO FLORES FLORES',3,'5579595640',1,37),(5252,'GUILLERMO GARCES ELIZALDE',3,'5543672866',1,37),(5253,'GUILLERMO HERNANDEZ',3,'5510223327',1,37),(5254,'GUILLERMO HERNANDEZ  VARGAS',3,'SN',1,37),(5255,'GUILLERMO palacios',3,'5510223327',1,37),(5256,'GUSTAVO ALDOLFO GONZALEZ SEVERO',3,'5540200225',1,37),(5257,'GUSTAVO ALVAREZ CASTAÑEDA',3,'5615110541',1,37),(5258,'GUSTAVO ANTONIO RODRIGUEZ',3,'5521374402',1,37),(5259,'GUSTAVO ARTURO ANDRADE GONZALEZ',3,'SN',1,37),(5260,'GUSTAVO DE LA CRUZ HERNANDEZ',3,'7354612150',1,37),(5261,'GUSTAVO FLORES MARTINEZ',3,'5570702781',1,37),(5262,'GUSTAVO FLORES MARTINEZ',3,'5536605052',1,37),(5263,'GUSTAVO LOPEZ',3,'5573662436',1,37),(5264,'GUSTAVO MIGUEL SANCHEZ',3,'5577974541',1,37),(5265,'GUSTAVO PEÑONURE',3,'SN',1,37),(5266,'GUSTAVO RAMIREZ CALVILLO',3,'5540289130',1,37),(5267,'GUSTAVO ROMERO',3,'5536421852',1,37),(5268,'GUSTAVO SOTO  OTERO',3,'5521439413',1,37),(5269,'HANIBAL GYM',3,'SN',4,37),(5270,'HANS OSORIO',3,'5546014258',1,37),(5271,'HANS SAMANIEGO',3,'5523732635',1,37),(5272,'HARIANET MIRANDA',3,'5614731881',1,37),(5273,'HECTOR ARENAS',3,'5527378827',1,37),(5274,'HECTOR CONRADO DOMINGUEZ',3,'5532911495',1,37),(5275,'HECTOR CRUZ LOPEZ',3,'5578329600',1,37),(5276,'HECTOR DAVID RAMOS PACHECO',3,'5576863501',1,37),(5277,'HECTOR DE LA CURVA',3,'SN',1,37),(5278,'HECTOR DE LA ROSA',3,'5518164083',1,37),(5279,'HECTOR ESCALONA HERNANDEZ',3,'5525007468',1,37),(5280,'HECTOR HERNANDEZ',3,'SN',1,37),(5281,'HECTOR HUGO QUINTERO GARCÍA',3,'5529824060',1,37),(5282,'HECTOR JAVIER ENRIQUEZ LOPEZ',3,'5532042243',1,37),(5283,'HECTOR LOPEZ',3,'5515836399',1,37),(5284,'Héctor Luna',3,'5587618610',1,37),(5285,'HECTOR LUNA SUSHI',3,'5587618610',4,37),(5286,'HECTOR OLMOS OLVERA',3,'5577392686',1,37),(5287,'HECTOR SANDOVAL RIOS',3,'5532889999',1,37),(5288,'HECTOR VAZQUEZ',3,'SN',1,37),(5289,'Héctor Vega',3,'5581811998',1,37),(5290,'HERIBERTO FUENTES BAUTISTA',3,'SN',4,37),(5291,'HERIBERTO PALACIOS',3,'5560701274',1,37),(5292,'HERIBERTO SALAZAR',3,'5540463932',1,37),(5293,'HERNÁDEZ VALDEZ ANDRÉS.',3,'5519397064',1,37),(5294,'HISAU VARGAS',3,'5585754493',1,37),(5295,'HUGO ACOSTA',3,'5531337530',1,37),(5296,'HUGO ALEJANDRO BARRERA',3,'5513082664',1,37),(5297,'HUGO ALVAREZ ESCALONA',3,'5612921517',1,37),(5298,'HUGO AMADOR MENDOZA',3,'5520589161',1,37),(5299,'HUGO AVENDAÑO',3,'3315321974',1,37),(5300,'HUGO AVILA V',3,'5536239659',1,37),(5301,'HUGO EDUARDO GOMEZ REYES',3,'5519735435',1,37),(5302,'HUGO EMILIANO SALAZAR',3,'5573857501',1,37),(5303,'HUGO FRANSICO FRAGOSO GONZALEZ',3,'SN',1,37),(5304,'HUGO GONZALEZ',3,'5519109997',1,37),(5305,'HUGO LOPEZ BARAJAS',3,'5525692703',1,37),(5306,'HUGO MARTÍN CORBELLO',3,'5535610320',1,37),(5307,'HUGO PALMA',3,'5559698904',4,37),(5308,'HUGO SALAZAR',3,'5514739745',1,37),(5309,'HUGO SANCHEZ LICONA',3,'5514272648',1,37),(5310,'HUMBERTO CRUZ MARTINEZ',3,'5570773142',1,37),(5311,'HUMBERTO ROSALES',3,'5581507016',1,37),(5312,'IAN ALEJANDRO MERCADO REYES',3,'5562226820',1,37),(5313,'IAN JAVIER BARRIGA GONZALES',3,'5531447534',1,37),(5314,'IGNACIO MILTON ABRAHAM',3,'5525613230',1,37),(5315,'ILSE RENATA HERNANDEZ RIVERA',3,'5582559587',1,37),(5316,'IMELDA FLORES VELAZQUEZ',3,'5529213901',1,37),(5317,'IMELDA RANGEL PEREZ',3,'5615598912',1,37),(5318,'INES ACEVEZ',3,'5522507303',1,37),(5319,'INÉS CRUZ',3,'5532654102',1,37),(5320,'INGRID DANIELA ORTEGA',3,'5549587128',1,37),(5321,'IRAN SHERLINE RICO TELLEZ GIRON',3,'5582391904',1,37),(5322,'IRENE RAMIREZ',3,'5540982612',3,37),(5323,'IRIS LOPEZ GARCIA',3,'5586101108',1,37),(5324,'IRLANDA VEGA',3,'5591441539',1,37),(5325,'IRMA LUNA',3,'5525020264',1,37),(5326,'IRVIN GARDUÑO SALAS',3,'5586066903',3,37),(5327,'IRVIN GONZALEZ VALORA',3,'5540011150',1,37),(5328,'IRVIN OYLLE MARTIMEZ',3,'5517020381',1,37),(5329,'ISAAC ALVAREZ ORDOÑEZ',3,'5621544550',1,37),(5330,'ISAAC BOTELLO FUENTES',3,'5512440327',1,37),(5331,'ISAAC CARAPIA FABELA TOWN CENTER',3,'5566973644',1,37),(5332,'ISAAC GODINEZ MORADO',3,'5534825806',1,37),(5333,'ISAAC HERNANDEZ OROSCO',3,'SN',1,37),(5334,'ISAAC LUNA',3,'5548585044',1,37),(5335,'ISAAC RUIZ',3,'5573567097',1,37),(5336,'ISABEL CABAÑAS',3,'5583569767',1,37),(5337,'ISABEL CALLEJA',3,'5532385073',1,37),(5338,'ISABEL GAMBOA MORALES',3,'5565144511',1,37),(5339,'ISABEL SORIANO DECTOR',3,'2721845157',1,37),(5340,'ISABEL VAZQUEZ',3,'5617998245',1,37),(5341,'ISABEL VILLEGAS FLORES',3,'5559520770',1,37),(5342,'Isac Luna',3,'5520451020',1,37),(5343,'ISAC MENDOZA',3,'5554773286',1,37),(5344,'ISAC RESENDIS GONZALEZ',3,'5525535057',1,37),(5345,'ISAC RODRIGUEZ DELGADO',3,'5520654413',1,37),(5346,'ISAHUC GOMEZ VENTURA',3,'5512489688',1,37),(5347,'ISAI ALCANTARA GONZALEZ',3,'5538825158',1,37),(5348,'ISAI HERNANDEZ RODRIGUEZ',3,'5534103985',1,37),(5349,'ISAMARA CHAVERO JIMENEZ',3,'5626436848',1,37),(5350,'ISELA CRUZ',3,'7227027554',1,37),(5351,'ISIS LEMUS ORTA',3,'5587223003',4,37),(5352,'ISMAEL ARANA',3,'5538962188',1,37),(5353,'ISMAEL CORIO',3,'SN',1,37),(5354,'ISMAEL FUENTES',3,'SN',1,37),(5355,'ISMAEL MARTINEZ',3,'SN',3,37),(5356,'ISMAEL MARTINEZ HERRERA',3,'SN',1,37),(5357,'ISMAEL MATEO VALENTIN',3,'5534455296',1,37),(5358,'ISRAEL  CRUZ',3,'5618704670',1,37),(5359,'ISRAEL ARANA',3,'5531098965',1,37),(5360,'ISRAEL ARANGO',3,'5531657494',1,37),(5361,'ISRAEL ARENA INSTRUCTOR POWER',3,'SN',4,37),(5362,'ISRAEL ARREDONDO MELESES',3,'SN',1,37),(5363,'israel chavez',3,'SN',1,37),(5364,'ISRAEL CRUZ',3,'5538172709',1,37),(5365,'ISRAEL LIRA TREJO',3,'5519640664',1,37),(5366,'ISRAEL MORALES',3,'SN',1,37),(5367,'ISRAEL ORTEGA',3,'5539510738',1,37),(5368,'ISRAEL PEREZ RESENDIZ',3,'5567858835',1,37),(5369,'ISRAEL RAMIREZ',3,'5573006683',1,37),(5370,'ISRAEL ROCHA',3,'5540800614',1,37),(5371,'ISRAEL RODRIGUEZ OLIVA',3,'5531046923',1,37),(5372,'ISRAEL RUBIO',3,'5520401510',1,37),(5373,'ISRAEL SOLANO GONZALEZ',3,'5610831606',1,37),(5374,'ISRAEL VERONA HERNANDEZ',3,'5586165159',1,37),(5375,'ITZEL GAMBOA',3,'5549291237',1,37),(5376,'ITZEL OSORIO',3,'5525048220',1,37),(5377,'ITZEL VECANY BRIZUELA AMEZCUA',3,'SN',1,37),(5378,'IVAN AGUILAR ANDRADE',3,'5529391199',1,37),(5379,'IVAN ALEJANDRO GARCIA MAYEN',3,'5527596127',1,37),(5380,'IVAN ALVAREZ',3,'5549507489',1,37),(5381,'IVAN CANSECO',3,'5583416184',1,37),(5382,'IVAN CRUZ ALEJO',3,'5610232392',1,37),(5383,'IVAN CRUZ MARTINEZ',3,'5566945974',1,37),(5384,'IVAN DE LA CRUZ',3,'SN',1,37),(5385,'IVAN DEL RIO MORENO',3,'5524988617',1,37),(5386,'IVAN DIAZ TELLES',3,'5621335136',1,37),(5387,'IVAN DOMINGUEZ ZETINA',3,'5513312494',1,37),(5388,'IVAN EMBARCADERO CASTAÑON',3,'5527115995',1,37),(5389,'IVAN FIGUEROA PINELO',3,'5551731140',3,37),(5390,'IVAN GONZALEZ',3,'5585571744',1,37),(5391,'IVAN HERNANDEZ',3,'5621163337',1,37),(5392,'IVAN LEON GUTIERREZ',3,'5546741252',1,37),(5393,'ivan lira',3,'5559977641',1,37),(5394,'IVAN LIRA HERNANDEZ',3,'5517035002',1,37),(5395,'IVAN MARIN',3,'5527065394',1,37),(5396,'IVAN PEREZ',3,'5532502581',1,37),(5397,'IVAN REYES SOTO',3,'5548707611',1,37),(5398,'IVAN TREVIÑO',3,'5579565081',1,37),(5399,'IVAN VALDEZ',3,'5584261576',1,37),(5400,'IVAN VALENCIA HERNANDEZ',3,'5516083623',1,37),(5401,'IVAN VILLAVICENCIO',3,'5534666499',1,37),(5402,'IVONNE ASCENCIO',3,'SN',3,37),(5403,'IVONNE ESPINOZA',3,'5531640975',1,37),(5404,'JACINTO SERRANO',3,'5550304015',1,37),(5405,'JACOB RESENDIZ',3,'5578720988',1,37),(5406,'JACQUELINE QUINTERO',3,'5518258486',1,37),(5407,'JAEL DAMIAN MARTINEZ',3,'5521966295',1,37),(5408,'JAHAZIEL GALICIA',3,'5517168581',1,37),(5409,'JAIME ADOLFO PEREZ GASCA',3,'5586170711',1,37),(5410,'JAIME ALONSO',3,'5536940197',3,37),(5411,'JAIME GONZALEZ',3,'5530523345',1,37),(5412,'JAIME LOPEZ',3,'5533406448',1,37),(5413,'JAIME SAMPERIO',3,'7712950645',1,37),(5414,'JAIR ARROYO',3,'5529536579',1,37),(5415,'JAIR ROAR',3,'SN',1,37),(5416,'JANNET CALLEJA AGUILAR',3,'5583590258',1,37),(5417,'jannet padilla',3,'5570507583',1,37),(5418,'JANNETE SAUCEDO',3,'5585098859',1,37),(5419,'JANNY CRISTEL CHAVEZ',3,'SN',3,37),(5420,'JAQUELINA RAMIREZ NARANJO',3,'SN',1,37),(5421,'JAQUELINE COSME',3,'5578517478',1,37),(5422,'JAQUELINE MARTINEZ',3,'5616690625',1,37),(5423,'JARED CALLAJA CHANES',3,'5514974606',1,37),(5424,'JARET',3,'5573708922',1,37),(5425,'JAVIER BAEZ',3,'5514042419',1,37),(5426,'JAVIER BRUNO',3,'5591090944',1,37),(5427,'JAVIER CRUZ SACARIAS',3,'5540467017',1,37),(5428,'JAVIER DE LA TORRE',3,'5534163505',1,37),(5429,'JAVIER DE LA TORRE',3,'5534163505',1,37),(5430,'Javier Estrada',3,'5518707859',3,37),(5431,'JAVIER ESTRADA',3,'SN',3,37),(5432,'JAVIER GARCIA',3,'5553209504',1,37),(5433,'JAVIER GARDUÑO',3,'5581511167',1,37),(5434,'JAVIER HRNANDEZ',3,'5529477565',4,37),(5435,'javier jaret anaya',3,'5567652105',1,37),(5436,'JAVIER LOPEZ TAPIA',3,'5545715578',1,37),(5437,'JAVIER LUNA',3,'5540323232',1,37),(5438,'JAVIER MACIAS',3,'5539965234',3,37),(5439,'JAVIER MACÍAS',3,'5544999183',1,37),(5440,'JAVIER MORENO',3,'5564986591',1,37),(5441,'JAVIER MORENO GARDUÑO',3,'5564986591',1,37),(5442,'JAVIER ORDUÑON ROMERO',3,'5631634670',1,37),(5443,'JAVIER ORTIZ GYM MAGIC MOVIL',3,'SN',1,37),(5444,'JAVIER PAZ',3,'5615947885',1,37),(5445,'JAVIER PIÑA INSTRUCTOR',3,'5512670245',1,37),(5446,'JAVIER RUEDA LPEZ SPORT GYM',3,'5545715578',4,37),(5447,'JAVIER VELASCO',3,'5535092518',1,37),(5448,'JAZMIN FLORES',3,'SN',1,37),(5449,'JEAN MANUEL TIRADO GONZALEZ',3,'5624338750',4,37),(5450,'JEAN MARLENE GARCIA HERNANDEZ',3,'5572266980',1,37),(5451,'JEANNETTE RAMIREZ',3,'5516443266',1,37),(5452,'JERONIMO GONZALEZ',3,'5547668559',3,37),(5453,'Jésica Chavez',3,'SN',1,37),(5454,'JESICA ROA TORRES',3,'SN',1,37),(5455,'JESSICA VALLE',3,'5542212656',3,37),(5456,'JESUS ABRAHAM SANCHEZ CUEVAS',3,'4423786986',1,37),(5457,'JESUS ACEVES',3,'5510035056',1,37),(5458,'JESUS ACEVEZ',3,'5554624420',1,37),(5459,'JESUS AGUILAR DE LA BORBOLLA',3,'5528995290',1,37),(5460,'JESUS AGUIRRE',3,'5515350942',1,37),(5461,'JESUS ALEJANDRO HERNANDEZ HERNANDEZ',3,'5549427823',1,37),(5462,'JESÚS ARANA',3,'5512380265',1,37),(5463,'JESUS AVENDAÑO',3,'5551497455',1,37),(5464,'JESUS CARRASCO',3,'5576210271',1,37),(5465,'JESUS CEVERINO',3,'SN',3,37),(5466,'JESUS COSIO GONZALEZ',3,'5527753167',1,37),(5467,'JESUS CRISTIAN RODEA MACiAS',3,'SN',4,37),(5468,'JESUS CRUZ MORA',3,'5513588107',1,37),(5469,'JESUS DAVID BERNAL',3,'5582417421',1,37),(5470,'Jesus David Marin Ramirez',3,'5543587758',1,37),(5471,'JESUS GODINEZ',3,'5527459242',1,37),(5472,'JESUS GONZALEZ',3,'5627618756',1,37),(5473,'JESUS HERNANDEZ',3,'5585190431',1,37),(5474,'JESUS MIRANDA MELCHOR',3,'5526664818',1,37),(5475,'JESUS MONROY',3,'5538352655',1,37),(5476,'JESUS MUÑOZ',3,'5523577129',1,37),(5477,'JESUS NIEVES TORRES',3,'5573776995',1,37),(5478,'JESUS OSVALDO VARELA MENDIOLA',3,'5569071884',1,37),(5479,'JESUS OSWALDO CARDELAS',3,'5610438433',1,37),(5480,'JESUS RAMIREZ PATRICIO',3,'5511372778',1,37),(5481,'JESUS RODEA MORALES',3,'5510781870',4,37),(5482,'JESUS RODRIGUEZ',3,'SN',1,37),(5483,'JESUS ROGRIGUEZ',3,'5528995290',1,37),(5484,'JESUS ROMERO',3,'SN',4,37),(5485,'JESUS RUIZ',3,'5576172820',1,37),(5486,'JESUS SANCHEZ',3,'5626806500',1,37),(5487,'JESUS VEGA',3,'5522062881',1,37),(5488,'JESUS YAÑEZ MAYA',3,'5551381339',1,37),(5489,'JHONATAN JOSUE MARTINEZ',3,'5614692139',1,37),(5490,'JHONY GYM COLMENA',3,'SN',4,37),(5491,'JIM GONZALEZ VERA',3,'5528013620',1,37),(5492,'JIOVANI SANCHEZ JUAREZ',3,'SN',1,37),(5493,'jJOSE DE JESUS JIMENEZ HERNANDEZ',3,'5547938829',1,37),(5494,'JOANA  RODRIGUEZ',3,'5539634826',1,37),(5495,'JOAQUIN SANTA MARIA',3,'SN',1,37),(5496,'JOEL GARCIA CORTES',3,'5545151899',1,37),(5497,'JOEL GOMEZ GARCIA',3,'5538998100',3,37),(5498,'JOEL HERNANDEZ GARCIA',3,'5586786856',1,37),(5499,'JOEL VILLAFRANCO ATLANTE SPORT GYM',3,'5634203260',4,37),(5500,'JOHAN CRUZ',3,'5533326040',1,37),(5501,'JOHN COFFE',3,'5585971409',1,37),(5502,'JOHN VELAZQUEZ',3,'7297754461',1,37),(5503,'JON MARTINEZ VELASQUEZ',3,'SN',1,37),(5504,'JONATAN ALCALA PADILLA',3,'5578104332',1,37),(5505,'JONATAN DANIEL HURTADO',3,'SN',1,37),(5506,'JONATAN TREJO',3,'5516578275',1,37),(5507,'JONATAN URIBE MOSQUEDA',3,'7131593165',1,37),(5508,'JONATHAN  VARGAS MARTINEZ',3,'5629859763',1,37),(5509,'JONATHAN ARELLANO HERNANDEZ',3,'5531467492',1,37),(5510,'JONATHAN FLORES AGUILAR',3,'5510537440',1,37),(5511,'JONATHAN GARCIA',3,'5620603322',1,37),(5512,'JONATHAN GONZALEZ',3,'5522125714',1,37),(5513,'JONATHAN GONZALEZ MIRALRIO',3,'5591424669',1,37),(5514,'JONATHAN IVAN ORTIZ OROZCO',3,'SN',1,37),(5515,'JONATHAN josue martinez',3,'5568844836',1,37),(5516,'JONATHAN MIGUEL HERNANDEZ',3,'SN',1,37),(5517,'JONATHAN NUÑEZ',3,'5526887140',3,37),(5518,'JONATHAN PERALTA',3,'5513616835',1,37),(5519,'JONATHAN REBOLLO',3,'5581817800',1,37),(5520,'JONATHAN RUBIO GONZALEZ',3,'5530215497',1,37),(5521,'JONATHAN SAENZ CHAVEZ  CUATITLAN',3,'5571349003',1,37),(5522,'JONATHAN ZUÑIGA',3,'5561813526',1,37),(5523,'JONATHAN ZURIEL PEREZ CRUZ',3,'5521779700',1,37),(5524,'JONY LOPEZ SEGUNDO',3,'5528550220',1,37),(5525,'JORGE ALBERTO CRUZ  JIMENEZ',3,'5537918701',1,37),(5526,'Jorge Alberto Garcia Ramirez',3,'5537294068',3,37),(5527,'JORGE ALBERTO NAVA JIMENEZ',3,'5540302242',1,37),(5528,'JORGE ALBERTO PEREZ',3,'5576071420',1,37),(5529,'JORGE ALCANTARA CASTILLO',3,'5531459170',1,37),(5530,'JORGE ANDRES DURAN VELAZQUEZ',3,'5631912874',1,37),(5531,'JORGE ANTONIO OLIVARES REYES',3,'5577769013',1,37),(5532,'JORGE ANTONIO SILVA',3,'5513194782',1,37),(5533,'JORGE ARMANDO SANTOS',3,'5615058523',1,37),(5534,'JORGE AVENDAÑO',3,'5580879411',1,37),(5535,'JORGE BARRAGAN',3,'5591191113',1,37),(5536,'JORGE CABRERA CROSSFIT',3,'SN',1,37),(5537,'JORGE CASTELAN OROZCO',3,'5516847785',1,37),(5538,'JORGE CHAVIRO GLE',3,'5511810965',1,37),(5539,'JORGE CRUZ LORA',3,'SN',1,37),(5540,'JORGE EDUARDO AGUIRRE ALMAZAN',3,'5544717675',1,37),(5541,'Jorge Eduardo Santana Lara',3,'5510482237',1,37),(5542,'JORGE EMANUEL BLANCO GALLEGOS',3,'5543680626',1,37),(5543,'JORGE GARCIA VEGA',3,'5581043492',1,37),(5544,'JORGE GARDUÑO BELLEZA',3,'SN',1,37),(5545,'JORGE ISRAEL ESTRADA MERINO',3,'5578523507',3,37),(5546,'JORGE LUIS ACOSTA DAVILA',3,'5563991729',1,37),(5547,'JORGE LUIS PIÑA ALVARADO',3,'5531397862',1,37),(5548,'JORGE LUIS TORRES AMBROSIO',3,'5563222395',1,37),(5549,'JORGE MANUEL BLANCO',3,'5543680626',1,37),(5550,'JORGE NAVARRETE',3,'5580879411',1,37),(5551,'JORGE OLVERA',3,'5540687498',1,37),(5552,'JORGE QUIROGA',3,'5561661071',1,37),(5553,'JORGE SANCHEZ',3,'5572245768',1,37),(5554,'JORGE SILVA',3,'5513194782',1,37),(5555,'JORGE SOSA',3,'5535924718',1,37),(5556,'JORGE TREJO',3,'5586164758',3,37),(5557,'JORGE VALTIERRA',3,'2741554413',1,37),(5558,'jorge valtierra',3,'SN',1,37),(5559,'JORGE VIDAL MONRROY',3,'5544764527',1,37),(5560,'JORGE ZEPEDA',3,'5522703513',1,37),(5561,'JOSAFAT MORALES',3,'5633773606',1,37),(5562,'JOSE AGUSTIN TREJO MARIN',3,'5530859155',1,37),(5563,'JOSE ALBERTO AGUILAR CABALLERO',3,'5620938021',1,37),(5564,'JOSE ALBERTO FLORES',3,'5634531234',1,37),(5565,'JOSE ALFREDO GARCÍA',3,'5585705646',1,37),(5566,'JOSE ALFREDO HERRERA FRAGOSO',3,'5615167167',1,37),(5567,'JOSE ALFREDO JIMENEZ RIVAS',3,'SN',1,37),(5568,'JOSE ANGEL CRUZ',3,'5571749923',1,37),(5569,'JOSE ANGEL GOMEZ CRUZ',3,'5516386845',1,37),(5570,'JOSE ANGEL LARA HERNANDEZ',3,'5521413401',1,37),(5571,'JOSE ANGEL SALINAS',3,'5549546956',1,37),(5572,'JOSE ANGEL SANDOVAL GARCIA',3,'5621230500',1,37),(5573,'JOSE ANTONIO ELIZALDE',3,'5612974204',1,37),(5574,'JOSE ANTONIO ENRIQUEZ',3,'5539786919',1,37),(5575,'JOSE ANTONIO ENRIQUEZ',3,'5564507216',1,37),(5576,'JOSE ANTONIO GARCIA',3,'5547736684',1,37),(5577,'JOSE ANTONIO GONZALEZ BAEZ',3,'5525380635',1,37),(5578,'JOSE ANTONIO GUTIERREZ',3,'SN',1,37),(5579,'JOSE ANTONIO MOHAMED CONDADO',3,'5617670255',1,37),(5580,'JOSE ANTONIO ROJAS TORRES',3,'5514397879',1,37),(5581,'JOSE ANTONIO VEGA MARTINEZ',3,'55760780',1,37),(5582,'JOSE ANTONIO VERASTEGUI SANCHEZ',3,'5510177221',1,37),(5583,'JOSE ARMANDO CARRILLO RICO',3,'5548024803',1,37),(5584,'JOSE ARMANDO MARTINEZ GARCIA',3,'5574647688',1,37),(5585,'JOSE ARNULFO BALVANEDA LUQUE',3,'5545647231',1,37),(5586,'JOSE CARLOS RUIZ GARCIA',3,'5562270812',1,37),(5587,'JOSE CARMEN CUNA CRUZ',3,'5533676568',1,37),(5588,'JOSE DAVID CORREA FARIAS',3,'5578988377',1,37),(5589,'JOSE DE JESUS CARRASCO',3,'5576210271',1,37),(5590,'JOSE EDUARDO JIMENEZ SOLIS',3,'SN',1,37),(5591,'JOSE EDUARDO MANZANAREZ RANGEL',3,'5539356937',1,37),(5592,'JOSE FRANCISCO MONTES DOMINGUEZ',3,'5551439906',1,37),(5593,'JOSE GABRIEL CORTES FLORES',3,'5576400167',1,37),(5594,'JOSE GARCIA VELAZQUEZ',3,'5627710326',1,37),(5595,'JOSE GUADALUPE BUENO DAVILA',3,'SN',1,37),(5596,'JOSE JAVIER GUITIERREZ',3,'5615824454',1,37),(5597,'JOSE JAVIER VILLAREAL LABRADA',3,'5611624750',1,37),(5598,'JOSE JESUS CABRERA MIRELES',3,'5553347751',1,37),(5599,'JOSE JIMENEZ',3,'5547938829',1,37),(5600,'JOSE JUAN GOMEZ VICTORIO',3,'5580572922',1,37),(5601,'JOSE LAMAS',3,'5561452173',1,37),(5602,'JOSE LUIS AGUILLON SANCHEZ',3,'5561161383',1,37),(5603,'JOSE LUIS CID MURATH GYM',3,'SN',4,37),(5604,'JOSE LUIS CLEMENTE CANTU',3,'5617018480',1,37),(5605,'JOSE LUIS FERNANDEZ RABAGO',3,'5541364423',1,37),(5606,'JOSE LUIS GONZALEZ ESCALONA',3,'5618013857',1,37),(5607,'JOSE LUIS HERNANDEZ OLIVERUS',3,'5519546052',3,37),(5608,'JOSE LUIS HERNANDEZ PEREZ',3,'5520465075',3,37),(5609,'JOSE LUIS JACINTO ROQUE',3,'5572193288',1,37),(5610,'JOSE LUIS MARTINEZ LICONA',3,'5554133040',1,37),(5611,'JOSE LUIS MORALES RAMIREZ',3,'5541270494',1,37),(5612,'JOSE LUIS MORELOS',3,'5577684057',1,37),(5613,'JOSE LUIS PEREZ SANTOS',3,'5529441115',1,37),(5614,'JOSE LUIS QUIROZ',3,'5513947068',1,37),(5615,'JOSE LUIS RAMIREZ',3,'5553323786',1,37),(5616,'JOSE LUIS RODRIGUEZ DE JESUS',3,'5537340691',1,37),(5617,'JOSE LUIS SANCHEZ VARGAS',3,'5520071693',1,37),(5618,'JOSE LUIS SAUCEDO',3,'4613481139',1,37),(5619,'JOSE LUIS TOMAS SANCHEZ',3,'SN',1,37),(5620,'JOSE LUIS VALDES',3,'5521991603',1,37),(5621,'jose luis vasquez antonio',3,'SN',1,37),(5622,'JOSE MANUEL ESPINOSA',3,'5539080379',3,37),(5623,'JOSE MANUEL FLORES MEJIA',3,'5615334882',1,37),(5624,'JOSE MANUEL LUIS VICTORIANO',3,'4494648516',3,37),(5625,'JOSE MANUEL MATA MALDONADO',3,'3222118047',1,37),(5626,'JOSE MARIO RIOS NOLASCO',3,'5518776321',1,37),(5627,'JOSE MARTIN MENDOZA',3,'5591971140',4,37),(5628,'Jose Martin Mendoza Parizio',3,'5591971140',1,37),(5629,'JOSE MIGUEL MONDRAGON NAVA',3,'5576299712',1,37),(5630,'JOSE MIGUEL RAMIREZ',3,'5561477693',1,37),(5631,'JOSE PABLO ALBAÑIL INES',3,'5544699378',1,37),(5632,'JOSE ROSAS PEREZ',3,'5583717386',1,37),(5633,'JOSE SAMUEL QUIROZ HERNANDEZ',3,'5519381561',1,37),(5634,'JOSE SOLIS',3,'5534750738',1,37),(5635,'jose trejo',3,'5536234267',1,37),(5636,'JOSE TRINIDAD',3,'5583717386',1,37),(5637,'JOSE ZARRAGA',3,'5529085298',1,37),(5638,'JOSELIN NAVARRETE',3,'SN',1,37),(5639,'JOSEPH ANDROS LLANAS RUIZ',3,'5577582692',1,37),(5640,'JOSHUA PEÑA',3,'5572099076',1,37),(5641,'JOSSELINA FRANCO COSSIO',3,'5554625083',4,37),(5642,'JOSUE ADRIEL VILLAVICENCIO',3,'5611403285',1,37),(5643,'JOSUE ANTONIO MENDEZ FERREIRA',3,'5617534085',1,37),(5644,'JOSUE ARZATE TRAJO',3,'5525542230',1,37),(5645,'JOSUE CABALLERO',3,'5527416745',4,37),(5646,'JOSUE CHACON EZPINOZA',3,'5564001114',4,37),(5647,'JOSUE GERARDO',3,'5545882654',1,37),(5648,'JOSUE MOISES ORTEGA CRUZ',3,'5552880291',1,37),(5649,'JOSUE NAVARRETE',3,'5518081582',1,37),(5650,'JOSUE PEREZ GONZALEZ',3,'5519303082',4,37),(5651,'JOSUE VILLAFRANCA',3,'5527135639',1,37),(5652,'JOSUE ZARRAGA',3,'5524085298',1,37),(5653,'JOVANY BUTRON',3,'5531487557',1,37),(5654,'JOVANY SANCHEZ',3,'5519566786',1,37),(5655,'JUAN ALBERTO GONZALEZ LOREDO',3,'5518537409',1,37),(5656,'JUAN ANDRES LINDERO',3,'5546371707',1,37),(5657,'JUAN ANTONIO ARZATE',3,'5583407991',3,37),(5658,'JUAN ANTONIO HERNANDEZ',3,'5534216071',1,37),(5659,'JUAN ANTONIO MARTINEZ',3,'5539826976',1,37),(5660,'JUAN AYALA',3,'5566763514',1,37),(5661,'JUAN BECERRIL',3,'5536516707',1,37),(5662,'JUAN BETTER',3,'5585595646',4,37),(5663,'JUAN CARLOS AGUILAR',3,'5571932335',1,37),(5664,'JUAN CARLOS BECERRIL',3,'5541815063',1,37),(5665,'JUAN CARLOS CRUZ',3,'SN',1,37),(5666,'JUAN CARLOS CRUZ VALERIO',3,'SN',1,37),(5667,'JUAN CARLOS ESPINOZA GONZALEZ',3,'5519735498',1,37),(5668,'JUAN CARLOS ESTRELLA',3,'5522956286',4,37),(5669,'JUAN CARLOS FLORES',3,'5523134518',1,37),(5670,'JUAN CARLOS GAMEZ',3,'5518406030',1,37),(5671,'JUAN CARLOS LEON LOPEZ',3,'5547938108',1,37),(5672,'JUAN CARLOS LOPEZ GALAN',3,'5528286752',1,37),(5673,'JUAN CARLOS MATA LUNA',3,'5618149076',3,37),(5674,'JUAN CARLOS NAVA GARCIA',3,'5537280981',1,37),(5675,'JUAN CARLOS RIOS',3,'SN',1,37),(5676,'JUAN CARLOS TOLEDO',3,'7772362366',1,37),(5677,'JUAN CID FUENTES',3,'5554553635',1,37),(5678,'JUAN DE LA CRUZ GARCIA PALOMARES',3,'5513020005',1,37),(5679,'JUAN DIEGO TORRES CARMONA',3,'5528895709',1,37),(5680,'JUAN ENRIQUE CORRALES',3,'5587660510',1,37),(5681,'JUAN ENRIQUE LARIOS',3,'SN',1,37),(5682,'JUAN ENRIQUE LARIOS LOPEZ',3,'SN',1,37),(5683,'JUAN HERNANDEZ',3,'SN',1,37),(5684,'JUAN JOSE PLATERO CRUZ',3,'5574035828',1,37),(5685,'JUAN JOSE PUENTE',3,'5551598201',1,37),(5686,'JUAN JOSE RODRIGUEZ',3,'5521803172',1,37),(5687,'JUAN JOSE RODRIGUEZ NOLASCO',3,'5521803172',4,37),(5688,'JUAN JUAREZ',3,'5535206876',1,37),(5689,'JUAN LUIS REYES HERNANDEZ',3,'SN',1,37),(5690,'JUAN MANUEL CORDOVA GRIMALDO',3,'5538082971',1,37),(5691,'JUAN MANUEL GONZALEZ CRUZ',3,'SN',1,37),(5692,'JUAN MANUEL MEDINA MUÑOZ',3,'5613454866',1,37),(5693,'JUAN MANUEL MONTIEL UGALDE',3,'5584423235',1,37),(5694,'JUAN MANUEL PEREZ MAURICIO',3,'5531980633',1,37),(5695,'Juan Manuel Santos',3,'5587262649',1,37),(5696,'JUAN MANUEL SOTO',3,'5527811147',1,37),(5697,'JUAN MANUEL VERA VILLAFUERTE',3,'5547715505',1,37),(5698,'JUAN MARES',3,'5537195338',1,37),(5699,'JUAN MIGUEL GENTY',3,'58195020',4,37),(5700,'JUAN PABLO CARRILLO PEREZ',3,'5511220207',1,37),(5701,'JUAN PABLO LONGORIA',3,'5562124299',1,37),(5702,'JUAN PABLO LONGORIA TELCEL',3,'5510473818',3,37),(5703,'JUAN PABLO SUAREZ OCHOA',3,'5521735223',1,37),(5704,'JUAN PEREZ FLORES',3,'5626571646',1,37),(5705,'JUAN PLAZA',3,'5561598572',1,37),(5706,'JUAN RAMON TORRES',3,'5538881309',1,37),(5707,'JUAN RODRIGUEZ FLORES',3,'5545789413',1,37),(5708,'JUAN SANTOS',3,'5513568164',1,37),(5709,'JUANA VILCHIS',3,'5515887971',1,37),(5710,'JUDITH RAMIREZ',3,'SN',4,37),(5711,'JULIA VILCHIS',3,'5521644227',1,37),(5712,'JULIETA CARVALLO CARO',3,'5619073464',1,37),(5713,'JULIETA MARTINEZ',3,'5546759411',1,37),(5714,'JULIO  HERNANDEZ RESENDIZ',3,'5534983520',1,37),(5715,'JULIO CESAR ALMARAZ',3,'5513668713',1,37),(5716,'JULIO CESAR ANGELES',3,'5573327194',1,37),(5717,'JULIO CESAR ARIAS',3,'SN',4,37),(5718,'JULIO CESAR MACIAS DURAN',3,'5636625713',1,37),(5719,'JULIO CÉSAR MARTINEZ JIMENEZ',3,'5615860179',1,37),(5720,'JULIO CESAR VALENZUELA',3,'5583686893',1,37),(5721,'JULIO CESAR VARGAS',3,'5535782356',4,37),(5722,'JULIO CESAR VELARDE',3,'PENDIENTE',1,37),(5723,'JULIO DE JESUS CONTRERAS',3,'5568532228',1,37),(5724,'JULIO EDUARDO ESPEJEL',3,'5619094404',1,37),(5725,'JULIO GEOVANNI COLIN LOPEZ',3,'5618552654',1,37),(5726,'JULIO GONZALEZ INSTRUCTOR',3,'5533330302',4,37),(5727,'JULIO ROA',3,'5536524760',1,37),(5728,'KAREL VELAZQUEZ',3,'5587314965',1,37),(5729,'KAREN ARIANA',3,'SN',1,37),(5730,'KAREN DANEY CRUZ ALCANTARA',3,'5529419225',1,37),(5731,'KAREN DE LA ROSA LUGO',3,'5579232974',1,37),(5732,'KAREN GUADALUPE ORDUÑA BENITES',3,'5564562931',1,37),(5733,'KAREN IRIGOYEN',3,'5578024938',1,37),(5734,'KAREN LOPEZ',3,'5567813106',1,37),(5735,'KAREN LOPEZ',3,'5544749166',1,37),(5736,'KAREN MEDRANO',3,'5564637134',1,37),(5737,'KAREN ORDUÑA BENITEZ',3,'SN',1,37),(5738,'KARIM JASSO',3,'5565178887',1,37),(5739,'KARINA AGUILAR',3,'PENDIENTE',1,37),(5740,'KARINA CANTAROS',3,'SN',1,37),(5741,'KARINA CARDONA',3,'5540779950',1,37),(5742,'KARINA LANDEROS SOBREYRA',3,'5627529011',4,37),(5743,'KARINA MENDOZA',3,'5514312481',1,37),(5744,'KARINA MIRANDA FRANCO',3,'5547953463',1,37),(5745,'KARINA PADILLA',3,'5527130586',1,37),(5746,'KARLA A',3,'5549032363',1,37),(5747,'KARLA BARRIOS',3,'5580462403',1,37),(5748,'KARLA BECERRIL',3,'5582331508',1,37),(5749,'KARLA ITZEL HERNANDEZ',3,'5572236429',1,37),(5750,'KARLA LEYVA CONTRERAS',3,'5580316213',1,37),(5751,'KARLA LULE',3,'5571098003',1,37),(5752,'KARLA MARTINEZ VARGAS',3,'5517988965',1,37),(5753,'KARLA MATEOS',3,'5513650523',1,37),(5754,'KARLA SALINAS',3,'5520822664',1,37),(5755,'KARLA SANCHEZ',3,'5577949633',1,37),(5756,'KARLA XIMENA CRISTOBAL CRUZ',3,'5551893249',1,37),(5757,'KARMEN MIRELES',3,'5577358092',1,37),(5758,'KAROLINA DE ATIZAPAN',3,'5548418407',1,37),(5759,'kathy flores',3,'SN',1,37),(5760,'KATIA GONZALEZ',3,'5610969898',1,37),(5761,'KATIA RODRIGUEZ',3,'5522802843',1,37),(5762,'KATO SANDOVAL',3,'SN',1,37),(5763,'KELLY CHAVEZ',3,'5548973767',1,37),(5764,'KELVIN CRUZ',3,'SN',1,37),(5765,'KENIA ACOSTA',3,'5554191656',1,37),(5766,'KEVIN ADRIAN',3,'5529282935',1,37),(5767,'KEVIN ALEJANDRO JAIME MATA',3,'5544151180',1,37),(5768,'KEVIN ARROYO',3,'5631480956',1,37),(5769,'KEVIN AXEL MARTINEZ',3,'5516809896',1,37),(5770,'KEVIN DONOVAN JIMENEZ',3,'5537455607',1,37),(5771,'KEVIN GODOY',3,'SN',1,37),(5772,'KEVIN HERNANDEZ',3,'5511411574',1,37),(5773,'KEVIN PALOMINO',3,'5611129875',1,37),(5774,'KEVIN ROSALES AVILA',3,'5546498914',1,37),(5775,'KEVYN JONATHAN PALOMINO LOPEZ',3,'7298041332',1,37),(5776,'KRISTEL ORTIZ GERONIMO',3,'5549501538',1,37),(5777,'KUIS ANGEL BUSTAMANTE VELAZQUEZ GYM DEJAVU',3,'5572107523',1,37),(5778,'LAEL SEGURA',3,'SN',1,37),(5779,'LAO HERNANDEZ',3,'5616288392',1,37),(5780,'LAURA EAGLE GYM',3,'SN',4,37),(5781,'LAURA FLEXI',3,'5522016147',1,37),(5782,'LAURA GONZALEZ LINARES',3,'SN',1,37),(5783,'LAURA GUARDADO',3,'SN',1,37),(5784,'LAURA GUARDADO',3,'5510094787',1,37),(5785,'LAURA JIMENEZ',3,'5516600165',1,37),(5786,'LAURA MIRANDA',3,'5563543650',1,37),(5787,'LAURA PEREZ CHAVEZ',3,'5512358111',1,37),(5788,'LAURA SANCHEZ GARCIA',3,'5584466168',1,37),(5789,'LAY MINEL',3,'5531923000',1,37),(5790,'LEO HERNANDEZ',3,'5542870081',4,37),(5791,'LEOBARDO GUZMAN CRUZ',3,'5613030678',1,37),(5792,'LEONARDO DANIEL GONZALEZ HUERTA',3,'5550640230',1,37),(5793,'LEONARDO DANIEL RIVERA NOLASCO',3,'5546408033',1,37),(5794,'LEONARDO ESPINOSA DELGADO',3,'5534074393',1,37),(5795,'LEONARDO GARRIDO VASQUEZ',3,'SN',1,37),(5796,'LEONARDO GONZALES HUERTA',3,'SN',1,37),(5797,'LEONARDO LOPEZ',3,'5535677531',1,37),(5798,'LEONARDO RIVERA AGUILAR',3,'5539646929',1,37),(5799,'LEONARDO SERVIN',3,'5586141756',1,37),(5800,'LEONEL HERNANDEZ LOPEZ',3,'5528944981',1,37),(5801,'LEONEL RIVERA',3,'SN',3,37),(5802,'LEONEL VARGAS',3,'SN',1,37),(5803,'LEOPOLDO HERNANDEZ',3,'5563440180',1,37),(5804,'LEOPOLDO JUAREZ LIRA',3,'5540865628',1,37),(5805,'LEOPOLDO NUÑEZ RAMIREZ',3,'5517043689',1,37),(5806,'LEPOLDO GIL',3,'SN',1,37),(5807,'lesli edith olvera gomez',3,'5547950897',1,37),(5808,'LESLIE TELORIO',3,'SN',1,37),(5809,'LESLIE TENORIO MARTINEZ',3,'5537274794',1,37),(5810,'LESLIE VISUET',3,'5558187920',1,37),(5811,'LESLY REZA',3,'5536987718',1,37),(5812,'LESLY VIANEY HERNANDEZ',3,'3329562765',1,37),(5813,'LETICIA JIMENEZ',3,'5554979613',1,37),(5814,'LETICIA SANCHEZ',3,'5510816997',1,37),(5815,'LETICIA SANTILLAN',3,'SN',1,37),(5816,'LIBIER MORALES ALVAREZ',3,'5620249496',1,37),(5817,'LIBNI BETZABE CAMACHO',3,'7296723703',1,37),(5818,'LIDIA PRICILIANO',3,'5533316662',1,37),(5819,'LIDIA RAMIREZ',3,'SN',1,37),(5820,'LILIANA GOMEZ LOBATO',3,'5578760591',1,37),(5821,'LILIANA TORRES',3,'5578589756',1,37),(5822,'LIVERT ENFERMERA IMSS',3,'SN',1,37),(5823,'LIZBETH BARRON',3,'5575289336',1,37),(5824,'LIZBETH GARCIA',3,'5572091017',1,37),(5825,'LIZBETH MARTINEZ',3,'5624713092',1,37),(5826,'LIZBETH ORTEGA BECERRIL',3,'5530127388',1,37),(5827,'LIZBETH ROSAS RUEDA',3,'7122045931',1,37),(5828,'LORENA CARRAZCO',3,'5530766678',1,37),(5829,'LORENA GARCIA SANCHEZ',3,'5510488523',1,37),(5830,'LORENA RAMIREZ VALDEZ',3,'5568994250',3,37),(5831,'LOURDES CRUZ CRISOSTOMO',3,'5554634696',1,37),(5832,'LOURDES NOLASCO CREPAS',3,'5530751570',3,37),(5833,'LUCI CRUZ',3,'5525263882',1,37),(5834,'LUCIA ISABEL DE LA CRUZ',3,'5564156747',1,37),(5835,'LUCIANO RIVERA RODRIGUEZ',3,'5574663947',1,37),(5836,'LUIS ADRIAN BECERRA GONZALEZ',3,'5627876601',1,37),(5837,'LUIS AGUILAR DIMAS',3,'5510989797',1,37),(5838,'LUIS ALBERTO',3,'SN',1,37),(5839,'LUIS ALBERTO CARINO',3,'SN',1,37),(5840,'LUIS ALBERTO LORENZO HERRERA',3,'5510131416',1,37),(5841,'LUIS ALEJANDRO MUÑOZ',3,'5527191141',1,37),(5842,'LUIS ALFREDO ROMERO',3,'5551811701',1,37),(5843,'LUIS ALONSO SANTANA',3,'5549932647',1,37),(5844,'LUIS ANGEL FLORENCIO ROJAS',3,'5562089359',4,37),(5845,'LUIS ANGEL GARDUÑO',3,'5545552312',1,37),(5846,'LUIS ANGEL GRANADOS GONZALEZ',3,'5544677712',1,37),(5847,'LUIS ANGEL JOSE SANCHEZ',3,'5576595734',1,37),(5848,'LUIS ANGEL OVIEDO',3,'5548820925',1,37),(5849,'LUIS ÁNGEL OVIEDO GARCIZO',3,'5583984787',1,37),(5850,'LUIS ÁNGEL PAVIN',3,'5575382340',1,37),(5851,'LUIS ANTHONY FLORES PORTILLO',3,'5573656735',1,37),(5852,'LUIS ANTONIO ARRIAGA HERRERA',3,'5579448512',1,37),(5853,'LUIS ANTONIO CASTILLO VARGAS',3,'5519749932',1,37),(5854,'LUIS ANTONIO RAMIREZ RUEDA',3,'5545627782',1,37),(5855,'LUIS ANTONIO RANGEL',3,'5583833881',1,37),(5856,'LUIS ANTONIO RODRIGUEZ MEDINA',3,'5537341107',1,37),(5857,'LUIS ANTONIO VARGAS NUÑEZ',3,'5613933446',1,37),(5858,'LUIS ARMANDO LOPEZ HERNANDEZ POLICIA',3,'56 3720 044',4,37),(5859,'LUIS BENITEZ',3,'SN',1,37),(5860,'LUIS BRAVO',3,'SN',1,37),(5861,'LUIS BRAVO',3,'5610973837',1,37),(5862,'LUIS CRUZ GONZALES',3,'5511820914',1,37),(5863,'LUIS CRUZ GONZALES',3,'5511820914',1,37),(5864,'LUIS DAVID GONZALEZ ALDANA',3,'5581487521',1,37),(5865,'LUIS DAVID MARTINEZ',3,'5572703849',1,37),(5866,'LUIS DAVID TELLEZ',3,'5564137593',1,37),(5867,'LUIS EDUARDO VARGAS',3,'5549083750',1,37),(5868,'LUIS ENRIQUE CASTILLO CARDOSO',3,'9984598418',1,37),(5869,'LUIS ENRIQUE MARTINEZ',3,'5614197618',1,37),(5870,'LUIS ENRIQUE MORENO',3,'SN',1,37),(5871,'LUIS ENRIQUE OCTAVIANO VALENCIA',3,'5583934249',1,37),(5872,'LUIS FELIPE HERNANDEZ',3,'5633765136',1,37),(5873,'LUIS FELIPE MENDEZ RAMIREZ',3,'5536523006',3,37),(5874,'LUIS FERNANDO ARROYO MENDEZ',3,'5531914359',1,37),(5875,'LUIS FERNANDO BRIONES JIMENEZ',3,'5623731108',1,37),(5876,'LUIS FERNANDO MUÑOZ HERNANDEZ',3,'5514697982',1,37),(5877,'LUIS FLORES',3,'5586954015',3,37),(5878,'LUIS FRANCISCO NAVA',3,'5543570651',1,37),(5879,'LUIS GAYTAN',3,'5510090878',3,37),(5880,'LUIS GERARDO HERNANDEZ',3,'5537032667',1,37),(5881,'LUIS GOMEZ BOJORGES',3,'SN',1,37),(5882,'LUIS ISAAC MAQUEDA',3,'5583809405',1,37),(5883,'LUIS JESUS ARAMBULA JIMENEZ',3,'5621493760',3,37),(5884,'LUIS JESUS SOLANA TORRES',3,'5612680536',4,37),(5885,'LUIS JOSE CUNA CRUZ',3,'5567063561',1,37),(5886,'LUIS JUAREZ CRISTIAN',3,'5519786542',1,37),(5887,'LUIS MANUEL BARBOSA',3,'5624484674',1,37),(5888,'LUIS MANUEL GASPAR JUAREZ',3,'5514303831',3,37),(5889,'LUIS MANUEL MOLINA MERCADO',3,'5578785620',1,37),(5890,'LUIS MANUEL PEREZ HERNANDEZ',3,'5544308608',1,37),(5891,'LUIS MARTIN CAMACHO',3,'5621605534',4,37),(5892,'LUIS MARTIN VILLANUEVA',3,'5535437900',1,37),(5893,'LUIS MEDINA RODRIGUEZ',3,'5534886327',1,37),(5894,'LUIS MORALES',3,'SN',1,37),(5895,'LUIS REYES',3,'5581807735',4,37),(5896,'LUIS RODRIGUEZ BALDERAS',3,'5551932209',1,37),(5897,'LUIS SANTANA',3,'5549932647',1,37),(5898,'LUIS TREJO',3,'5520698747',1,37),(5899,'LUIS TRUJILLO BORREGON',3,'5664360120',1,37),(5900,'LULU GUILLEN',3,'5565823173',1,37),(5901,'LUPITA  DIAZ LOPEZ',3,'5566949095',3,37),(5902,'LUPITA OZUNA',3,'5514267347',1,37),(5903,'LUYENNY DEZIRE CRUZ VIZCAYA',3,'5577309256',1,37),(5904,'LUZ ROMERO',3,'5513325037',1,37),(5905,'MAGALI CLAVELLINA',3,'5588137275',1,37),(5906,'MAGALI SARAI PEREZ LIMON',3,'SN',3,37),(5907,'MANUEL ACOSTA',3,'SN',1,37),(5908,'MANUEL ALEJANDRO RAMIREZ',3,'5570705919',3,37),(5909,'MANUEL ALONSO GARCIA',3,'5610491513',1,37),(5910,'MANUEL ALVAREZ BRAVO',3,'5535309592',1,37),(5911,'MANUEL AYALA AYALA',3,'5543733825',1,37),(5912,'MANUEL GASPAR JUAREZ',3,'5514303831',1,37),(5913,'MANUEL GDP BECERRA FREZA',3,'5569797906',1,37),(5914,'MANUEL HERNANDEZ BUEN DIA GYM TITANUIM',3,'5530185285',4,37),(5915,'MANUEL JUAREZ HIDROGO',3,'5537822620',1,37),(5916,'MANUEL MELCHOR',3,'5548102205',1,37),(5917,'MANUEL MURRIETA',3,'5620071573',4,37),(5918,'MANUEL ROMERO',3,'5576881094',1,37),(5919,'MANUEL YAEL BUSTAMANTE HERRERA',3,'5523422498',1,37),(5920,'MARA ZUYIN',3,'5548496741',1,37),(5921,'MARCELO VARGAS',3,'5551575508',1,37),(5922,'MARCO ALEJANDRO TOVAR HERNANDEZ',3,'5559094141',1,37),(5923,'MARCO ANTONIO CARBAJAL GONZALEZ',3,'5561090286',1,37),(5924,'MARCO ANTONIO DE LA FUENTE',3,'5520553487',1,37),(5925,'MARCO ANTONIO DOMINGUEZ MORELOS',3,'6692733382',4,37),(5926,'MARCO ANTONIO HERNANDEZ',3,'SN',3,37),(5927,'MARCO ANTONIO LOPEZ GUZMAN',3,'5527573202',1,37),(5928,'MARCO ANTONIO MARTINEZ',3,'5581513867',1,37),(5929,'MARCO ANTONIO MARTINEZ',3,'5568999089',1,37),(5930,'MARCO ANTONIO ORDEZ CRUZ',3,'5523844994',1,37),(5931,'MARCO ANTONIO ORTIZ',3,'5515308020',1,37),(5932,'MARCO ANTONIO RIVAS',3,'5536956274',1,37),(5933,'MARCO ANTONIO RIVERA HERNANDEZ',3,'5566888342',1,37),(5934,'MARCO ANTONIO VALENTE FLORES',3,'5513622958',1,37),(5935,'MARCO ANTONIO VELAZCO PINEDA',3,'5546939118',1,37),(5936,'MARCO DAVID RUEDAS VALDEZ',3,'5618708560',1,37),(5937,'MARCO FABIO CABRERA',3,'5612960005',1,37),(5938,'Marcos Irineo Soto',3,'5539559590',4,37),(5939,'MARCOS JIMENEZ NOYOLA',3,'5615236676',1,37),(5940,'MARCOS LINARES HERNANDEZ',3,'5566784502',1,37),(5941,'MARCOS LOPEZ RAMIREZ',3,'5573555332',1,37),(5942,'MARGARITA  CRUZ GABRIEL',3,'5573401305',1,37),(5943,'MARGARITA PINEDA',3,'5531137833',1,37),(5944,'MARGARITA SAN MARTIN',3,'5549444531',1,37),(5945,'MARGARITA SOLORSANO SANTOS',3,'SN',1,37),(5946,'MARI CARMEN CLARA GARCIA',3,'5548489588',1,37),(5947,'MARIA ANTONIETA AGUILAR GOMEZ',3,'5517478584',1,37),(5948,'MARIA DE JESUS MONZON',3,'5512150163',1,37),(5949,'MARIA DE LOS ANGELES AMBROSIO PEÑA',3,'5577418897',1,37),(5950,'MARIA DEL CARMEN BAILON ABOYTES',3,'5626135615',1,37),(5951,'MARIA ELENA ROMERO',3,'SN',1,37),(5952,'MARIA ELENA ROMERO VALDEZ',3,'5579596628',1,37),(5953,'MARIA ESTER RUIZ',3,'5514936842',1,37),(5954,'MARIA FERNANDA SANCHEZ',3,'5563226158',1,37),(5955,'MARIA GARCIA',3,'5559663356',1,37),(5956,'MARIA GUADALUPE  LOPEZ',3,'5539367794',1,37),(5957,'MARIA GUADALUPE CRUZ',3,'5568726008',1,37),(5958,'MARIA GUADALUPE MARTINEZ ARANA',3,'5574615068',1,37),(5959,'MARIA GUADALUPE ZARCO',3,'5519114742',1,37),(5960,'MARIA ISABEL VAZQUEZ GALVAN',3,'SN',1,37),(5961,'MARIA JAZMIN NAVARRETE REYES',3,'5620430150',1,37),(5962,'MARIA LUISA GRANADOS',3,'5514816688',1,37),(5963,'MARIA MONSERRAT GONZALES ROSAS',3,'5548524109',1,37),(5964,'MARIA TERESA MARTINEZ RIVERA',3,'5581446266',1,37),(5965,'MARIA TINOCO OIÑON',3,'5615221934',1,37),(5966,'MARIA ZURI DIAZ GODINEZ',3,'5579118921',1,37),(5967,'MARIANA ANDRADE',3,'5563605194',1,37),(5968,'MARIANA ANTONIO FRANCO',3,'5523100627',1,37),(5969,'MARIANA ESQUIVEL RAMIREZ',3,'5547593950',1,37),(5970,'MARIANA JIMENEZ',3,'5561358770',1,37),(5971,'MARIANA LOPEZ',3,'5579149637',1,37),(5972,'MARIANA MONTES DE OCA',3,'SN',1,37),(5973,'MARIANA TERRAZAS',3,'5538887897',1,37),(5974,'MARIANO GOMEZ',3,'5514711560',1,37),(5975,'MARIANO PEREZ',3,'5542575478',1,37),(5976,'MARIANO VARGAS',3,'SN',1,37),(5977,'Mariano Vargas Roa',3,'5537175964',1,37),(5978,'MARIBEL REYES ATANACIO',3,'5565354115',1,37),(5979,'MARIBEL RIVERA PADILLA',3,'5581896936',1,37),(5980,'MARICELA GUZMAN BARRERA',3,'5545445680',1,37),(5981,'MARICELA MARTINEZ',3,'552493771',1,37),(5982,'MARIEL ALVAREZ',3,'5540907735',1,37),(5983,'MARIELA ALVAREZ',3,'5614661031',1,37),(5984,'MARIO  ALBERTO GARCIA CAMPOS',3,'5564821687',1,37),(5985,'MARIO ALBERTO AGUILAR',3,'5531399891',1,37),(5986,'MARIO ALBERTO GARNICA',3,'5537266250',1,37),(5987,'MARIO ALBERTO HUERTA',3,'SN',1,37),(5988,'MARIO ALBERTO MARTINEZ',3,'5531337530',1,37),(5989,'MARIO ARMANDO MONTES',3,'SN',1,37),(5990,'MARIO CHIMAL',3,'5572733902',1,37),(5991,'MARIO GARCIA GARCIA',3,'5614938940',1,37),(5992,'MARIO HUERTA',3,'5626084490',1,37),(5993,'MARIO LANDEROS',3,'SN',4,37),(5994,'MARIO LICONA BAZA',3,'5514168840',1,37),(5995,'MARIO MENDOZA',3,'SN',1,37),(5996,'MARIO MERCADO JONNY GYMS',3,'SN',4,37),(5997,'MARIO URIEL VAZQUEZ ORTIZ',3,'5582126111',1,37),(5998,'MARIPAZ GOMEZ HERNANDEZ',3,'5542414079',1,37),(5999,'MARISEL HERNANDEZ',3,'5615134302',1,37),(6000,'MARISOL ROMERO JUAREZ',3,'5527436477',3,37),(6001,'MARISOL SANCHEZ',3,'SN',1,37),(6002,'MARISOL SANCHEZ',3,'5542557073',1,37),(6003,'MARISSA RONQUILLO FLORES',3,'5621192851',1,37),(6004,'MARITZA ANGELI RODRIGUEZ',3,'5548291165',1,37),(6005,'MARLEN ALONSO REYES',3,'5548967683',1,37),(6006,'MARLEN HERNADEZ',3,'5577372475',1,37),(6007,'MARLEN MORENO LUNA',3,'5560078438',1,37),(6008,'MARLEN PALACIOS GARCIA',3,'SN',1,37),(6009,'MARLENE CHABOYA',3,'5515131396',1,37),(6010,'MARLENI FARFAN',3,'5522543022',1,37),(6011,'MARTIN ANTONIO GUZMAN GARCIA',3,'5512429026',1,37),(6012,'MARTIN GOROSTIETA',3,'5544479216',1,37),(6013,'MARTIN HUERTA TORRES',3,'SN',1,37),(6014,'MAURICIO ALVARADO',3,'5531241681',1,37),(6015,'MAURICIO BLANCAS',3,'5591974877',1,37),(6016,'MAURICIO FLORES FELIX',3,'5529372989',1,37),(6017,'MAURICIO FUENTES',3,'5534884466',1,37),(6018,'MAURICIO GARCIA GARCIA',3,'5547738979',1,37),(6019,'MAURICIO GOMEZ',3,'5571131138',1,37),(6020,'MAURICIO LEGORRETA FEM',3,'5539720151',1,37),(6021,'MAURICIO RAMINEZ BARRIOS',3,'5560765393',1,37),(6022,'MAURICIO RAMIREZ BARRIOS',3,'5619889303',1,37),(6023,'MAURICIO ROMERO',3,'5618128982',1,37),(6024,'MAURO GARCIA',3,'5532006295',1,37),(6025,'MAYRA BANCOMER',3,'SN',1,37),(6026,'MAYRA LIRA',3,'5571131138',1,37),(6027,'MAYRET ORTIZ',3,'5518484771',1,37),(6028,'MAYTE COLÍN',3,'5585613663',1,37),(6029,'MELISA MARTINEZ GUEVARA',3,'SN',1,37),(6030,'MICHAEL LUNA',3,'5618532596',1,37),(6031,'MICHEL ROCHA TAPIA',3,'5568764973',1,37),(6032,'MICHELLE HERNANDEZ SANCHEZ',3,'5613910675',1,37),(6033,'MICHELLE ROCHA GARCIA',3,'5569378168',1,37),(6034,'MIGUEL ALEXIS SANDOVAL CHAVEZ',3,'5561463778',1,37),(6035,'MIGUEL ANGEL AGUIRRE',3,'5510452922',1,37),(6036,'MIGUEL ANGEL ANDRADE  ANTONIO',3,'5579310390',1,37),(6037,'MIGUEL ANGEL ARANA',3,'5513622579',4,37),(6038,'MIGUEL ANGEL BOTELLO NIEVES',3,'5626611206',1,37),(6039,'MIGUEL ANGEL CABRERA TELLEZ',3,'5611992128',1,37),(6040,'MIGUEL ANGEL CERVANTES CONTRERAS',3,'5555000004',1,37),(6041,'MIGUEL ANGEL DIEGO HERNANDEZ',3,'5534575848',1,37),(6042,'MIGUEL ANGEL ESPEJEL GYM M/M DEL VIDRIO',3,'5521055305',4,37),(6043,'MIGUEL ANGEL ESTRASDA ASCEVEDO',3,'5582556342',1,37),(6044,'MIGUEL ANGEL GARCIA MARTINEZ',3,'5623397498',1,37),(6045,'MIGUEL ANGEL GOMEZ LARA',3,'5530279576',1,37),(6046,'MIGUEL ANGEL GUERRERO',3,'5531906103',1,37),(6047,'MIGUEL ANGEL GUZMAN',3,'5550534715',1,37),(6048,'MIGUEL ANGEL HUERTA',3,'5519921741',1,37),(6049,'MIGUEL ANGEL LEMUS',3,'5554634745',1,37),(6050,'MIGUEL ANGEL MURRIETA GONZALES',3,'5542186832',1,37),(6051,'MIGUEL ANGEL PICHARDO',3,'SN',1,37),(6052,'MIGUEL ANGEL RAMIREZ',3,'5586023310',1,37),(6053,'MIGUEL ANGEL RANGEL',3,'5550092512',1,37),(6054,'MIGUEL ANGEL SOLANO GAMIÑO',3,'5532693551',1,37),(6055,'MIGUEL ANGEL VILLA MORAN',3,'5538781708',1,37),(6056,'MIGUEL ANGUEL ARANA',3,'5533600649',4,37),(6057,'MIGUEL AVILA',3,'SN',1,37),(6058,'MIGUEL AVILA MONTELONGO',3,'5511915018',1,37),(6059,'MIGUEL BARRERECHERA',3,'SN',1,37),(6060,'MIGUEL CAMACHO',3,'3411092247',1,37),(6061,'MIGUEL CAZARIN MARTINEZ',3,'5538756692',1,37),(6062,'MIGUEL DE MOVISTAR',3,'5519646468',3,37),(6063,'MIGUEL GARCIA ENRIQUEZ',3,'SN',3,37),(6064,'MIGUEL HERNANDEZ',3,'5510756716',1,37),(6065,'MIGUEL HIDALGO',3,'SN',1,37),(6066,'MIGUEL HIDALGO',3,'5548928323',1,37),(6067,'MIGUEL MORALES',3,'5536761748',1,37),(6068,'MIGUEL MURO',3,'SN',1,37),(6069,'MIGUEL REZA RIVERA',3,'5543830008',1,37),(6070,'MIGUEL VEGA',3,'5532528004',1,37),(6071,'MIKE VARGAS VARGAS',3,'5617113155',1,37),(6072,'MIRELLA GARCIA',3,'5512648456',1,37),(6073,'MIREYA ALONSO',3,'5512648456',1,37),(6074,'MIREYA MACEDO GARCIA',3,'5512240047',1,37),(6075,'MIRIAM ANGELES',3,'SN',1,37),(6076,'MIRIAM ANGELES PABLO',3,'5527834582',1,37),(6077,'MIRIAM GONZALES',3,'5567735358',1,37),(6078,'MIRIAM HERNANDEZ',3,'5534683023',1,37),(6079,'MIRIAM ZARIÑAN ALVARES',3,'5540937703',1,37),(6080,'MISAEL AGUILAR',3,'7221510245',1,37),(6081,'MISAEL URIEL ALVAREZ SANCHEZ',3,'5621981489',1,37),(6082,'MISHAEL STEPHANIA LUNA SANCHEZ',3,'5618532596',1,37),(6083,'MOISÉS RANGEL',3,'5569676585',1,37),(6084,'MOISES VELAZQUEZ HERNANDEZ',3,'SN',1,37),(6085,'MOISES VENTOLERO CHAVEZ',3,'5615433907',1,37),(6086,'MONCHIS',3,'5532428402',1,37),(6087,'MONICA ARRIAGA GUZMAN',3,'5543778745',1,37),(6088,'MONICA CRUZ',3,'5582297025',1,37),(6089,'MONSE JIMENEZ',3,'SN',4,37),(6090,'MONSERAT RUEDA BUCANEROS',3,'SN',4,37),(6091,'monserrat gallegos',3,'5634731340',1,37),(6092,'MONSERRAT OLVERA ARIAS',3,'5535942705',1,37),(6093,'MONSERRAT SANDOVAL',3,'5578449519',1,37),(6094,'MONSERRATH HERNANDEZ',3,'5545578673',1,37),(6095,'MONTSERRAT MONRROY',3,'5540679661',1,37),(6096,'MOVIK SANCHEZ TOWN CENTER',3,'5510175510',1,37),(6097,'MOY GYM DEL PUERTO',3,'SN',4,37),(6098,'NAHUM MARTINEZ',3,'5517038378',4,37),(6099,'NALLELY BERENICE GUADARRAMA',3,'5548869544',3,37),(6100,'NANCY CERVANTES',3,'5537149532',1,37),(6101,'Nancy Elizabeth Ruiz Carbajal',3,'5531342135',4,37),(6102,'NANCY ENGAVI',3,'5529604394',1,37),(6103,'NANCY FLORES',3,'SN',1,37),(6104,'NANCY RAMIREZ JIMENEZ',3,'5611260547',1,37),(6105,'NANCY RODRIGUEZ XOCHIPA',3,'5626508033',1,37),(6106,'NANCY VILLA',3,'5586747432',1,37),(6107,'nar hurtado',3,'5620834580',1,37),(6108,'NAYELI CEDILLO',3,'SN',1,37),(6109,'NAYELI MORA',3,'5516826322',1,37),(6110,'NEFTALI SILVA',3,'5620943190',1,37),(6111,'NELLY RAMIREZ',3,'5571445054',1,37),(6112,'NERIDA NOEMI HERNANDEZ CABALLERO',3,'5573824995',3,37),(6113,'NESTOR EDUARDO',3,'5587333646',1,37),(6114,'NETZAE EVERARDO NONATO VALLE',3,'5571728648',1,37),(6115,'NICOLAS LOPEZ GRISALES',3,'5535175175',1,37),(6116,'NISAR MARTINEZ',3,'5551643713',1,37),(6117,'NOE MATA TAPIA',3,'55439301157',1,37),(6118,'NOE PEREZ REVELES',3,'SN',1,37),(6119,'NOEL CABRERA',3,'5519201516',1,37),(6120,'NOEMI HERNANDEZ',3,'5539741904',1,37),(6121,'NOEMI ROSAS CRUZ',3,'5521346756',1,37),(6122,'NOEMI SANTOS VELAZQUEZ',3,'5540173024',1,37),(6123,'NOEMI SILVA JARAMILLO',3,'5534445240',1,37),(6124,'NORMA LOPEZ ANAYA',3,'SN',1,37),(6125,'OCTAVIANO REYES VANEGAS',3,'5581421444',1,37),(6126,'OCTAVIO ESCOBAR',3,'5577584427',1,37),(6127,'OCTAVIO ESCORCIA CABRERA',3,'5616775637',1,37),(6128,'OCTAVIO MENDEZ MARTINEZ',3,'5620971571',1,37),(6129,'OCTAVIO REYES NOYOLA',3,'5618061669',1,37),(6130,'OCTAVIO URIBE TOTAL PLAY',3,'5566825514',3,37),(6131,'ODET RUEDA',3,'5549063164',1,37),(6132,'OFEIDA',3,'5543901410',1,37),(6133,'OLGA LIDIA ROJAS CRUZ',3,'5515740226',1,37),(6134,'OLGA LIRA RODRIGUEZ',3,'5516547947',1,37),(6135,'OLIVIA REZA',3,'5545467022',1,37),(6136,'OMAR BALERIO',3,'SN',1,37),(6137,'OMAR BARRERA',3,'5533896697',1,37),(6138,'OMAR BUSTAMANTE',3,'5530510999',1,37),(6139,'OMAR CASTRO',3,'5540913449',1,37),(6140,'OMAR ESAU CARRANZA JIMENEZ',3,'5583153791',1,37),(6141,'OMAR FONSECA',3,'5513492724',1,37),(6142,'OMAR GARCÍA SIMON',3,'5529819418',1,37),(6143,'OMAR GOMEZ',3,'5579462754',1,37),(6144,'OMAR HERNANDEZ',3,'SN',1,37),(6145,'OMAR ISRAEL GARCIA',3,'5588046814',1,37),(6146,'OMAR JESUS SERRANO RIVERA',3,'5567622402',1,37),(6147,'OMAR JIMENEZ ARAMBULA',3,'5517953802',4,37),(6148,'OMAR JIMENEZ MARTINEZ',3,'5578183224',1,37),(6149,'OMAR LOPEZ CORNEJO',3,'5531141728',1,37),(6150,'OMAR MARTINEZ ALCARAZ',3,'6671908302',1,37),(6151,'OMAR ORTIZ',3,'5559060465',1,37),(6152,'OMAR PEREZ HERNANDEZ',3,'PENDIENTE',1,37),(6153,'OMAR PEREZ ORTIZ',3,'5559060465',1,37),(6154,'OMAR ROA BLACK GYM',3,'5582426842',4,37),(6155,'OMAR VEGA GONZALES',3,'SN',1,37),(6156,'ORLANDO ISRAEL HERNANDEZ FLORES',3,'5567367210',1,37),(6157,'ORLANDO OSNAYA',3,'5563258826',1,37),(6158,'OSCAR CHAVEZ ROSAS',3,'5626096561',1,37),(6159,'OSCAR DANIEL AGUILERA RAMIREZ',3,'5545571665',1,37),(6160,'OSCAR DANIEL IBARRA',3,'5530356933',1,37),(6161,'ÓSCAR DANIEL MARTINEZ LEVARIO',3,'5582330822',1,37),(6162,'OSCAR DAVID MESA',3,'5624142198',1,37),(6163,'OSCAR DE LEON',3,'5579581171',1,37),(6164,'OSCAR DE LEON',3,'5515733981',1,37),(6165,'OSCAR GALINDO',3,'5573544035',1,37),(6166,'OSCAR GARCIA',3,'SN',1,37),(6167,'OSCAR IGNACIO ROSAS',3,'5571745413',1,37),(6168,'OSCAR ISAAC SOSA DE LA CRUZ',3,'5581403000',1,37),(6169,'OSCAR JAVIER LANDAVERDE RAMIREZ',3,'5618050911',1,37),(6170,'OSCAR JOAN',3,'5636052156',1,37),(6171,'OSCAR LOPEZ TOWN CENTER',3,'5533526853',3,37),(6172,'OSCAR MORAMENDEZ',3,'5528849244',1,37),(6173,'OSCAR NOLASCO',3,'5532389249',1,37),(6174,'OSCAR PEREZ',3,'5537824087',1,37),(6175,'OSCAR RAMIREZ LEON',3,'5614008933',1,37),(6176,'OSCAR ROMERO MARTINEZ',3,'5627037060',1,37),(6177,'OSCAR ROMERO RIOS',3,'5536593086',1,37),(6178,'OSCAR SANCHEZ OJEDA',3,'5574443450',1,37),(6179,'OSCAR SIMON VERA',3,'58284118',1,37),(6180,'OSCAR URIEL CRUZ SALDAÑA',3,'5617130250',1,37),(6181,'OSCAR VARGAS',3,'5540057234',1,37),(6182,'OSCAR VEGA',3,'5548356014',1,37),(6183,'OSCAR VELAZQUEZ',3,'SN',1,37),(6184,'OSCAR YAHIR  MONTIEL',3,'5587958426',1,37),(6185,'OSVALDO BASURTO',3,'SN',1,37),(6186,'OSVALDO HERNANDEZ',3,'5529338214',1,37),(6187,'OSVALDO MENDOZA',3,'5626163227',1,37),(6188,'OSVALDO SANCHEZ GUTIERREZ',3,'SN',1,37),(6189,'OSWALDO RAMOS TORT',3,'5570722705',1,37),(6190,'OTILIO ARENAS',3,'SN',1,37),(6191,'PABLO ALEJANDRO SAENZ HERNANDEZ',3,'5582226763',1,37),(6192,'PABLO FERNANDEZ BECERRIL',3,'5626822927',1,37),(6193,'PABLO HERNANDEZ OLIVARES',3,'5513568452',1,37),(6194,'PABLO MUÑOZ ORTIZ',3,'5547666231',1,37),(6195,'PABLO PADILLA',3,'5523207169',1,37),(6196,'PABLO ZARCO',3,'5536646863',1,37),(6197,'PAMELA RUIZ',3,'5578051780',4,37),(6198,'PAMELA SALAS',3,'SN',1,37),(6199,'PAMELA VARGAS TORRES',3,'SN',4,37),(6200,'PAOLA BARRERA FLORES',3,'5543784718',1,37),(6201,'PAOLA MIRELES JIMENEZ',3,'5571296030',1,37),(6202,'PAOLA RUIZ',3,'5579901400',1,37),(6203,'Paola Serrano',3,'5574103969',1,37),(6204,'PASCUAL CASTILLO LOPEZ',3,'6143947347',1,37),(6205,'PATRICIA BAUTISTA GARCIA',3,'5579346348',1,37),(6206,'PATRICIA GOMEZ',3,'5513361245',3,37),(6207,'PATRICIA PEREZ',3,'5578712283',1,37),(6208,'PATRICIA POLO',3,'5546569301',1,37),(6209,'PATRICIA RAMIREZ',3,'5553378940',1,37),(6210,'PAUL CHAVEZ HERNANDEZ',3,'5537123912',1,37),(6211,'PAUL RICARDO ROSAS',3,'5567746830',1,37),(6212,'PAULINA FERNANDEZ BAUTISTA',3,'5520964181',1,37),(6213,'PAULO CESAR GARCIA RODRIGUEZ',3,'5515653601',1,37),(6214,'PEDRO ALEXANDER',3,'5617946372',1,37),(6215,'PEDRO ALONSO ANGELES TORRES',3,'5624146035',1,37),(6216,'PEDRO ANGEL VAZQUEZ',3,'5617675330',1,37),(6217,'PEDRO DE LA LUZ CATALAN ZONA 20',3,'5548122842',4,37),(6218,'PEDRO DELGADO ARAIZA',3,'5563989815',1,37),(6219,'PEDRO FIGUEROA',3,'5527524288',1,37),(6220,'PEDRO GONGORA',3,'5535671474',1,37),(6221,'PEDRO MARTINEZ',3,'5533966975',1,37),(6222,'PEDRO MOISES ESPINOZA ORTIZ',3,'SN',1,37),(6223,'PEDRO RAMIREZ CRUZ',3,'5648949842',1,37),(6224,'PEDRO SANTOS SANTOS',3,'5543468568',1,37),(6225,'PENDIENTE LLENAR',3,'SN',1,37),(6226,'PEPE HERNANDEZ',3,'5618589082',3,37),(6227,'PEPE MARTINEZ',3,'5523446685',1,37),(6228,'PERLA ALEJANDRA BECERRA SANCHEZ',3,'5586896223',1,37),(6229,'RAFAEL AVENDAÑO',3,'5581609461',1,37),(6230,'RAFAEL CHAVEZ EL DE LOS LABORATORIOS',3,'5519296771',1,37),(6231,'RAFAEL FONSECA',3,'5613904430',1,37),(6232,'RAFAEL HERRERA HERNANDEZ',3,'5534155775',1,37),(6233,'RAFAEL MENDOZA ALVAREZ',3,'5611687736',1,37),(6234,'RAFAEL MORALEZ',3,'5530510351',1,37),(6235,'RAFAEL OLVERA',3,'5513208612',4,37),(6236,'RAFAEL PICHARDO',3,'5544554094',1,37),(6237,'RAFAEL VAZQUEZ',3,'5530780823',1,37),(6238,'RAFAEL VILLAVICENCIA',3,'SN',1,37),(6239,'RAFEL RODRIGUEZ',3,'5617454608',1,37),(6240,'RAMON CALDERON ORTEGA',3,'5615622804',1,37),(6241,'RAMON HERNANDEZ',3,'SN',1,37),(6242,'RAMON JASSO MARTINEZ',3,'5518101073',1,37),(6243,'RAMON VARGAS',3,'5520598959',1,37),(6244,'RAMON VIA CORTA',3,'SN',4,37),(6245,'RANDY SANTA MARIA RUIZ',3,'5510823625',1,37),(6246,'RAQUEL IBAÑEZ',3,'5545182844',1,37),(6247,'RAUL CABALLERO',3,'5560734851',1,37),(6248,'RAUL CASTELLANOS',3,'5611403990',1,37),(6249,'RAUL HERNANDEZ EAGLE GYM',3,'5528991455',4,37),(6250,'RAUL JUAREZ ROA',3,'5545271225',4,37),(6251,'RAUL ROSAS OLMOS',3,'5563724192',1,37),(6252,'RAUL UBAYA',3,'SN',1,37),(6253,'RAUL VARGAS',3,'SN',1,37),(6254,'RAY PEÑALOZA',3,'5534040024',3,37),(6255,'RAYMUNDO CONTRERAS MARTINEZ',3,'5543900990',1,37),(6256,'RAYMUNDO CONTRERAS MARTÍNEZ.',3,'5543900990',1,37),(6257,'RAYMUNDO CRUZ     INSTRUCTOR',3,'5525038123',4,37),(6258,'RAYMUNDO ORTEGA CARRANCO',3,'5531415106',1,37),(6259,'RAYMUNDO RIOS',3,'5543579850',1,37),(6260,'RAYMUNDO ROA',3,'5528384591',1,37),(6261,'REBECA RAMIREZ ESPINOZA',3,'5543943326',1,37),(6262,'REINA ISABEL TORRES',3,'SN',1,37),(6263,'Renato Luna',3,'5543460479',3,37),(6264,'RENE LERMA FLORES',3,'5561940309',1,37),(6265,'RENE URZUA',3,'5523736791',1,37),(6266,'REY ALEXIS NEYRA',3,'5610506420',1,37),(6267,'REYNA HERNANDEZ',3,'5566945974',1,37),(6268,'RICARDO ADRIAN JIMENEZ GALVEZ',3,'5548557412',1,37),(6269,'RICARDO ALCANTARA',3,'5586879807',1,37),(6270,'RICARDO ANTONIO GARCIA',3,'5617021523',1,37),(6271,'RICARDO BALDERA',3,'5584475298',1,37),(6272,'RICARDO CASTRO MARTINEZ',3,'5542253587',1,37),(6273,'RICARDO CAZAS',3,'5625998777',1,37),(6274,'RICARDO CORTEZ',3,'5513644179',1,37),(6275,'RICARDO CRUZ ANDRADE',3,'5614611787',1,37),(6276,'RICARDO DOMINGUEZ VILLEGAS',3,'5537071169',1,37),(6277,'RICARDO DUARTE MUÑOS',3,'5543381760',1,37),(6278,'RICARDO ESTRADA',3,'5540852183',1,37),(6279,'RICARDO GALVAN',3,'SN',1,37),(6280,'RICARDO GARCIA CARPIO',3,'5524279553',1,37),(6281,'RICARDO GONZALES CRUZ',3,'5531523122',1,37),(6282,'RICARDO GRANADOS',3,'5564602780',1,37),(6283,'RICARDO MALAGON',3,'5586879807',1,37),(6284,'RICARDO MARTINEZ HERNANDEZ',3,'5585322377',1,37),(6285,'Ricardo Medrano',3,'5581941486',1,37),(6286,'RICARDO MEJÍA',3,'5518486186',1,37),(6287,'RICARDO PEREZ MARQUEZ',3,'5626892687',1,37),(6288,'RICARDO RAMIREZ SERAPIO',3,'5534296224',1,37),(6289,'RICARDO RUBIO',3,'5578442534',1,37),(6290,'RICARDO RUFINO HERNANDEZ',3,'5581445139',1,37),(6291,'RICARDO SANCHEZ GALLEGOS',3,'5548350160',1,37),(6292,'RICARDO TORIBIO',3,'5536072661',1,37),(6293,'RICARDO VAZQUEZ HERNANDEZ',3,'5572702592',1,37),(6294,'RIGOBERTO CRUZ',3,'5554022928',1,37),(6295,'RIGOBERTO PONCE',3,'5554770544',1,37),(6296,'RITA ARENAS ORTEGA',3,'9992328880',1,37),(6297,'RIVALDO ROSALES CASTILLO',3,'5548260407',1,37),(6298,'ROBERTO CARLOS TAPIA TORRES',3,'SN',1,37),(6299,'ROBERTO CENTENO',3,'5578216921',1,37),(6300,'ROBERTO GALVAN',3,'5544701158',1,37),(6301,'ROBERTO GOMEZ',3,'5551574523',1,37),(6302,'ROBERTO HERRERA ESPINOZA',3,'5584275917',1,37),(6303,'ROBERTO MARTINEZ',3,'5646468530',1,37),(6304,'ROBERTO MARTINEZ DOMINGUEZ',3,'5546468530',1,37),(6305,'ROBERTO MARTINEZ LOPEZ',3,'5527253304',1,37),(6306,'ROBERTO MEJIA',3,'5564556566',1,37),(6307,'ROBERTO MEJIA',3,'5564556566',1,37),(6308,'ROBERTO MEJIA FUENTES',3,'5564152356',1,37),(6309,'ROBERTO NAVA',3,'SN',1,37),(6310,'ROBERTO PEREZ OROZCO',3,'5569775477',1,37),(6311,'ROBERTO RENTERIA HERNANDEZ',3,'5569350979',1,37),(6312,'ROBERTO SILVA',3,'SN',1,37),(6313,'ROBERTO URIEL PIXLEY',3,'5527202493',1,37),(6314,'ROBERTO VASQUEZ',3,'5579154168',1,37),(6315,'ROBERTO VAZQUEZ RODRIGUEZ',3,'5513828249',1,37),(6316,'ROBERTO ZAMORA',3,'5543861701',1,37),(6317,'ROCIO ALVARADO TREJO',3,'5591612992',3,37),(6318,'ROCIO MAGALI PASTRANA CASILLAS',3,'5529095790',1,37),(6319,'ROCIO MONROY',3,'SN',1,37),(6320,'ROCIO PEREZ GONZALEZ',3,'5516511982',1,37),(6321,'ROCIO ROSAS',3,'5535419815',1,37),(6322,'rodolfo gomez',3,'5518271515',1,37),(6323,'RODOLFO MURILLO',3,'5579805583',3,37),(6324,'RODOLFO RIVAS',3,'SN',1,37),(6325,'RODRIGO ARANA',3,'SN',1,37),(6326,'RODRIGO BAUTISTA',3,'SN',1,37),(6327,'RODRIGO DIAZ DE LEON GALVEZ',3,'5563501882',1,37),(6328,'RODRIGO DIAZ GOMEZ',3,'5534887570',1,37),(6329,'RODRIGO EMANUEL PONCE MACEDO',3,'5543584845',1,37),(6330,'RODRIGO GREGORIO ALLENDE',3,'5535184020',1,37),(6331,'RODRIGO LLANO',3,'5548385517',1,37),(6332,'RODRIGO MARTINEZ GUTIERREZ',3,'5610264208',1,37),(6333,'RODRIGO MEDINA ESPINOZA',3,'5543223957',1,37),(6334,'RODRIGO MURO',3,'5581967009',1,37),(6335,'RODRIGO ROJAS VARGAS',3,'5532214664',1,37),(6336,'RODRIGO SANCHEZ',3,'5527520892',1,37),(6337,'RODRIGO VARELA RODRIGUEZ',3,'5526546046',1,37),(6338,'ROGELIO BARRIGA SANCHEZ',3,'5611831344',1,37),(6339,'ROGELIO ENRIQUE FERNANDO VILLEGAS',3,'5626235653',1,37),(6340,'ROGELIO HERNANDEZ MONTIEL',3,'5512340884',1,37),(6341,'ROGELIO LEON',3,'5580324391',1,37),(6342,'ROGELIO MAYA',3,'5615669802',1,37),(6343,'ROGELIO PONCE',3,'5539543112',1,37),(6344,'ROGELIO RIOS',3,'5554632259',1,37),(6345,'Rolando Rivera',3,'5582571453',1,37),(6346,'ROMAN ALBERTO QUIJANO GARCIA',3,'5580367382',1,37),(6347,'ROMAN ROMERO ROJAS',3,'5573892240',1,37),(6348,'ROMMEL RABADAN',3,'5515021717',1,37),(6349,'RONALDO JAVIER JACOME',3,'5531009964',1,37),(6350,'ROSA PUENTES',3,'SN',1,37),(6351,'ROSA SOTO',3,'5543969333',3,37),(6352,'ROSALBA CAMACHOP TOWN CENTER',3,'5511447833',1,37),(6353,'ROSALBA DE LA LUZ',3,'5610943372',1,37),(6354,'ROSALIA CLEMENTE',3,'5539821969',1,37),(6355,'ROSALVA ARREDONDO JUAREZ',3,'5583073802',1,37),(6356,'ROSARIO GUTIERREZ',3,'5514270386',1,37),(6357,'rosario romo rojas',3,'SN',1,37),(6358,'ROXET SANCHEZ',3,'5626047595',1,37),(6359,'RUBEN GONZALEZ HUITRON',3,'5511965415',1,37),(6360,'RUBEN HERNANDEZ',3,'5514805082',1,37),(6361,'RUBEN VARGAS VELAZQUEZ',3,'5510144855',1,37),(6362,'RUBEN YANILD',3,'5550579748',1,37),(6363,'RUBENS SERVANDO DOMINGUEZ',3,'5534318594',1,37),(6364,'RUBENS ZARZA DELGADO',3,'5571849314',1,37),(6365,'RUBI TAPIA MIRANDA',3,'5611231673',1,37),(6366,'RUTH',3,'SN',1,37),(6367,'SABDY BARRERA',3,'5578607339',1,37),(6368,'SAGNITE BERENICE HERNANDEZ OSORIO',3,'5519581291',1,37),(6369,'SALOME MEDINA',3,'5614862132',3,37),(6370,'SALOMON RAFAEL MARTINEZ MONDRAGON',3,'5531496785',1,37),(6371,'SALVADOR BALTAZAR',3,'5523334536',3,37),(6372,'SALVADOR CORONA',3,'5584957553',1,37),(6373,'SALVADOR FUENTES GUERRERO',3,'5572275703',1,37),(6374,'SALVADOR GARCIA PEREZ',3,'5578553877',1,37),(6375,'SALVADOR JIMENEZ BECERRIL',3,'5549864132',1,37),(6376,'SALVADOR MARTINEZ CARBAJAL',3,'5530200640',1,37),(6377,'SALVADOR RAMIREZ OSORNIO',3,'5574644812',1,37),(6378,'SAMANTA PEREZ',3,'SN',1,37),(6379,'SAMANTHA DE LEON',3,'5548882129',1,37),(6380,'SAMANTHA LUCERO LUNA',3,'5611358869',1,37),(6381,'SAMANTHA MICUIO VEGA',3,'5551461053',1,37),(6382,'SAMUEL ROCHA',3,'SN',4,37),(6383,'SANDIBEL LUCAS TENORIO',3,'SN',1,37),(6384,'SANDRA ANDRADE DIAZ',3,'5580350450',1,37),(6385,'SANDRA GRANDE',3,'5612834296',1,37),(6386,'SANDRA HERNANDEZ BLANCAS',3,'SN',1,37),(6387,'SANDRA NAVARRO CHAVARRIA',3,'5534238865',1,37),(6388,'Sandra Velazquez',3,'5525080043',1,37),(6389,'SANTIAGO DE LA LUZ',3,'5529533938',1,37),(6390,'SARAI PEREZ',3,'5612596129',1,37),(6391,'SARAI PEREZ LIMON',3,'5612596129',1,37),(6392,'SARAI REYES REYES',3,'5531875734',1,37),(6393,'SAUL ALEJANDRO RODRIGUEZ',3,'5518436760',1,37),(6394,'SAUL ALVARO ALVARADO',3,'5574728411',1,37),(6395,'SAUL CENOBIO',3,'5622045369',1,37),(6396,'SAUL DAVID VALDEZ',3,'SN',1,37),(6397,'SAUL FUENTES INFANTE',3,'5534524712',1,37),(6398,'SAUL GONZALEZ',3,'5568083143',1,37),(6399,'SAUL IZAI RUIZ MORENO',3,'5567597938',1,37),(6400,'SAUL JAVIER BAUTISTA',3,'SN',1,37),(6401,'SAUL JIMENEZ',3,'5526695899',1,37),(6402,'SAUL PEREZ BERMUDEZ',3,'5512432249',1,37),(6403,'Saul Ramirez',3,'5517972810',3,37),(6404,'SAUL SANTIAGO',3,'5610153989',1,37),(6405,'SEBASTIAN AGUILAR ARZATE',3,'5626909386',1,37),(6406,'SEBASTIAN GONZALEZ RIVERA',3,'SN',1,37),(6407,'SEBASTIAN IBARRA',3,'5629901844',1,37),(6408,'SEBASTIAN JUAREZ BASILIO',3,'5520022177',1,37),(6409,'SEBASTIAN MONTA ROSA',3,'SN',1,37),(6410,'SEIGNER TOLEDO VARGAS',3,'5535632757',1,37),(6411,'SELENE LIRA',3,'5560764287',1,37),(6412,'SERGIO',3,'5567786230',1,37),(6413,'SERGIO AGUILAR',3,'5624316756',1,37),(6414,'SERGIO ALFARO',3,'5518192738',1,37),(6415,'SERGIO ALVARO TORRES',3,'5558071662',1,37),(6416,'SERGIO EMANUEL JUAREZ',3,'5617886493',3,37),(6417,'SERGIO GARCIA',3,'5583403182',1,37),(6418,'SERGIO GARCIA',3,'SN',1,37),(6419,'SERGIO IVAN MARTINEZ',3,'5573360084',1,37),(6420,'SERGIO MARTINEZ',3,'5514818609',1,37),(6421,'SERGIO QUEZADA',3,'5618524284',1,37),(6422,'SERGIO ROCHA',3,'5521121777',3,37),(6423,'SERGIO ROSAS',3,'5565746033',1,37),(6424,'SERGIO SANCHEZ HERRERA',3,'5635716217',1,37),(6425,'SERGIO SANTANA',3,'5561042883',1,37),(6426,'SHERLYN RICO',3,'5520294314',3,37),(6427,'SIDNEY OMAR GARDUÑO P.CIVIL',3,'5537270959',4,37),(6428,'SILVERIO MENDOZA TREJO',3,'55531126871',1,37),(6429,'SILVERIO QUIJANO',3,'5580279617',1,37),(6430,'SINUE  VAZQUEZ VAZQUEZ',3,'3535364983',1,37),(6431,'SOL BARRERA',3,'5583718537',1,37),(6432,'SONIA BONILLA',3,'5582393678',3,37),(6433,'SONIA CALDERA',3,'5581732911',1,37),(6434,'SONIA GUDIÑO ORTEGA',3,'5580372895',1,37),(6435,'SONIA RIVERA',3,'5517447508',1,37),(6436,'SRA ESTHER',3,'SN',1,37),(6437,'STEFFANYA SAN AGUSTIN',3,'5522997641',1,37),(6438,'STEPHANIE CARRASCO ESPINOZA',3,'5532603846',1,37),(6439,'STEPHANIE VARGAS TORRES',3,'5540957335',3,37),(6440,'SURIEL BARRON MORENO',3,'5612665201',1,37),(6441,'SUSANA BOLAÑOS',3,'SN',3,37),(6442,'SUSANA DE LA CRUZ',3,'5514579250',1,37),(6443,'SUSANA ESPINOZA TAFOLLA',3,'5539619767',1,37),(6444,'SUSANA HERNADEZ BLANCAS',3,'5617753470',4,37),(6445,'SUSANA OLOVARES',3,'5512902625',1,37),(6446,'TADEO ARTURO HERNANDEZ VAZQUEZ INSTRUCTOR',3,'5564209134',4,37),(6447,'TAMARA HUERTA',3,'5570784105',1,37),(6448,'TANIA DENIS PASTRAN',3,'5539965234',1,37),(6449,'TANIA GUADALUPE LUNA VICENTE',3,'SN',1,37),(6450,'TANIA GUTIERREZ MARTINEZ',3,'5574348382',1,37),(6451,'TANIA MIRANDA',3,'SN',1,37),(6452,'TAYDE LIZBETH CUEVAS GARCIA',3,'5627926630',1,37),(6453,'THANIA ROSAS GUZMAN',3,'5515944671',1,37),(6454,'THOMAS NAVARRO',3,'5522335142',1,37),(6455,'TOMAS CAMPOS BRINGAS',3,'5618326418',1,37),(6456,'TOMAS LUNA',3,'SN',1,37),(6457,'TOMAS MOLINA VAZQUEZ',3,'5623974807',1,37),(6458,'TOMAS NAVARRO',3,'5521999591',1,37),(6459,'TOMAS SANTANA DELGADILLO',3,'SN',1,37),(6460,'TOMASA ACEVES RAMIREZ',3,'5551839223',1,37),(6461,'TONY BENITEZ PLACIDO',3,'5587672997',1,37),(6462,'TONY BENITEZ PLACIDO',3,'5587672997',1,37),(6463,'TONY HERNANDEZ',3,'SN',1,37),(6464,'TRESA JUAREZ LOPEZ',3,'SN',1,37),(6465,'ULISES GONZALES',3,'5537211283',1,37),(6466,'ULISES ISAIAS PIÑA GOMEZ',3,'5539673894',1,37),(6467,'ULISES JASSO CASTILLO',3,'5529498058',3,37),(6468,'ULISES MEMBRILLO RAMIREZ',3,'5618187278',1,37),(6469,'ulises monroy',3,'5516022838',1,37),(6470,'ULISES TAPIA MIRANDA',3,'5560135267',1,37),(6471,'URIEL BAREÑO PEREZ',3,'5561680732',1,37),(6472,'URIEL CUANDON VALDES',3,'5526624004',1,37),(6473,'URIEL GALLEGOS',3,'5638076794',1,37),(6474,'URIEL ROBLES',3,'5548737249',1,37),(6475,'URIEL VELAZQUEZ GARCIA',3,'5548690472',1,37),(6476,'URSULA ELIZABETH MEDRANO TORRES',3,'5541374656',1,37),(6477,'URSULA MEDRANO TORRES',3,'5541374656',1,37),(6478,'VALENTE MATA GUTIERREZ',3,'5560279776',1,37),(6479,'VALERI HUERTA TORRES',3,'SN',1,37),(6480,'VALERIA CLETO',3,'5514706966',1,37),(6481,'VALERIA MORENO',3,'SN',1,37),(6482,'VANESSA MONROY',3,'5530756338',3,37),(6483,'VERONICA AYALA',3,'5512109478',1,37),(6484,'VERONICA BECERRIL',3,'5578453160',1,37),(6485,'VERONICA BELLO',3,'5534835465',1,37),(6486,'VERONICA CRUZ BRAVO',3,'5626159022',1,37),(6487,'VERONICA DÍAZ',3,'5548745883',1,37),(6488,'VERONICA FLORES',3,'5548025620',1,37),(6489,'VERONICA GLORIA SANCHEZ',3,'5612670873',1,37),(6490,'VERONICA HERNANDEZ SANCHEZ',3,'5537324566',1,37),(6491,'VERONICA IVONNE CRUZ',3,'5543120711',1,37),(6492,'VERONICA RUIZ MEDINA',3,'5610211130',1,37),(6493,'VIANET PALMA',3,'SN',4,37),(6494,'VIANNEY CASTILLO',3,'SN',1,37),(6495,'VICENTE TORRES JIMENEZ',3,'5516797919',1,37),(6496,'VICTOR ALFONSO ROJAS LOPEZ',3,'5523650442',1,37),(6497,'VICTOR ALFREDO REYES ROSAS',3,'5586786185',1,37),(6498,'VICTOR DANIEL CADENA ANGELES',3,'5578948378',1,37),(6499,'VICTOR ERNESTO GARCIA',3,'7291308963',1,37),(6500,'VICTOR EUGENIO HERNÁDEZ RAMOS',3,'5552481769',1,37),(6501,'VICTOR HERNANDEZ',3,'5566985149',1,37),(6502,'VICTOR HUGO CRUZ',3,'5618766454',4,37),(6503,'VICTOR HUGO RODRIGUEZ  RODRIGUEZ',3,'5532463452',1,37),(6504,'VICTOR HUGO SOLANO LARA',3,'5561530934',1,37),(6505,'VICTOR MANUEL OTERO',3,'5543748067',1,37),(6506,'VICTOR MANUEL PEÑA MIRANDA',3,'5548831846',1,37),(6507,'VICTOR MENDOZA',3,'5580277576',1,37),(6508,'VICTOR MENDOZA',3,'5530151708',1,37),(6509,'VICTOR MERCADO',3,'5583300727',1,37),(6510,'VICTOR MIGUEL MALAGON GARCIA',3,'5561532700',1,37),(6511,'VICTOR MIGUEL MARTINEZ GARCIA',3,'5536535582',4,37),(6512,'VICTOR RIVERA CROSSFIT',3,'5539847939',4,37),(6513,'VICTOR ROSALES',3,'SN',1,37),(6514,'VICTOR ROSALES',3,'5650123824',1,37),(6515,'VICTOR VEGA',3,'5587376448',1,37),(6516,'VICTORIA BLASS PEREZ',3,'5522550755',1,37),(6517,'VICTORIA GONZALEZ',3,'5558180331',1,37),(6518,'VICTORIA MARTINEZ CRUZ',3,'5583490729',1,37),(6519,'VIRIDIANA CARBALLO',3,'5517729517',1,37),(6520,'VIRIDIANA HERNANDEZ',3,'5524983622',1,37),(6521,'VIRIDIANA SANCHEZ ROA',3,'5625826351',1,37),(6522,'VIVIANA PEREZ',3,'5621467190',1,37),(6523,'VIVIANA PEREZ VELAZQUEZ',3,'5613000086',1,37),(6524,'VLADIMIR MEDINA',3,'5530832806',1,37),(6525,'WENDY DE LA ROSA GUTIERREZ',3,'5518148157',1,37),(6526,'WENDY GYM MARANTIALES',3,'SN',1,37),(6527,'WENDY MARLEN PATIÑO MORENO',3,'5586902386',1,37),(6528,'WENDY SARAI ALVAREZ VAZQUEZ',3,'5618370983',1,37),(6529,'WENDY VELAZQUEZ',3,'5565813723',1,37),(6530,'WILLIAMS YOEL JIMENEZ GONZALEZ',3,'5567754711',1,37),(6531,'WUENDY PAMELA RAMIREZ BALDERAS',3,'SN',1,37),(6532,'Xally Yolotzin',3,'5561493146',1,37),(6533,'XAVIER MONROY',3,'5524453994',1,37),(6534,'XAVIER PEREZ RODRIGUEZ',3,'5582639770',1,37),(6535,'YADIRA CAMPOS',3,'5577838947',1,37),(6536,'YAEL ARMENDARIZ',3,'5583801195',1,37),(6537,'YAFTÉ ROSAS',3,'5564692007',1,37),(6538,'YAIR AROYO DE ANDA',3,'5544561113',1,37),(6539,'YAMIRETH MONROY',3,'5532434958',1,37),(6540,'YANET',3,'5518744026',1,37),(6541,'YANET BASTIDA',3,'5518744026',1,37),(6542,'YARELI JIMENEZ',3,'5545767488',1,37),(6543,'YAZMIN ALEJANDRA DEL RIO',3,'5591915249',1,37),(6544,'YAZMIN HERNANDEZ',3,'5578554690',3,37),(6545,'YAZMIN HERNANDEZ (JUAN)',3,'5549805056',1,37),(6546,'YAZMIN MARTINEZ',3,'5610204032',1,37),(6547,'YAZMIN NOLASCO ROSAS',3,'SN',1,37),(6548,'YAZMIN ROCHA',3,'5578054662',1,37),(6549,'YENI ISABEL REAL VIVANCO',3,'5539721744',1,37),(6550,'YERIKA ITURRIAGA',3,'5531083118',1,37),(6551,'YERIKENDY CAROLINA RODRIGUEZ',3,'5630167900',1,37),(6552,'YESENIA JILOTE',3,'5523485859',1,37),(6553,'YESICA GARCIA',3,'5536309593',1,37),(6554,'YESSICA FABIOLA CRUZ RODRIGUEZ',3,'5621004727',1,37),(6555,'YOALI LORA',3,'5528790825',1,37),(6556,'YOALI REYES',3,'5534566642',3,37),(6557,'YOLANDA TORRES DON',3,'5548609889',4,37),(6558,'YOLOTZIN APARICIO TELLEZ',3,'5626172053',1,37),(6559,'YOLOTZIN SEGURA',3,'5564986431',1,37),(6560,'YONATHAN MORA NOGUES',3,'5582851512',1,37),(6561,'YURI CARMONA',3,'5548072520',1,37),(6562,'YURI DIANA RAMIREZ',3,'5548072520',1,37),(6563,'ZAMANTHA MARTINEZ ACOSTA',3,'5585474092',1,37),(6564,'ZAMORA NERI LUIS ENRIQUE',3,'5523413430',1,37),(6565,'ZARA AIDE',3,'5574952047',1,37),(6566,'ZARA CORTES',3,'5539766973',1,37),(6567,'ZEFARINO SANCHEZ CRUZ',3,'5521097737',1,37),(6568,'ZOE CRUZ',3,'SN',1,37),(6569,'ZOFET RUEDA LOPEZ',3,'5577828919',1,37),(6570,'ZORRE ZARRAGA',3,'5529085298',1,37),(6571,'ALEJANDRO CASTELON',3,'66442469956',3,37),(6572,'MAURICIO GUTIERREZ',3,'5532591886',1,37),(6573,'JORGE GARCIA VEGA',3,'SN',1,37),(6574,'YARA CV',7,'SN',4,29),(6575,'EMILIO CARDENAS',3,'5543779775',3,37),(6576,'ROMAN ARROYO IGLESIAS',3,'SN',4,37),(6577,'ISABEL SORIANO',3,'5520690264',1,37),(6578,'RAYMUNDO HERNANDEZ OÑATE',3,'5591115977',1,37),(6579,'KARINA MENDEZ GARCIA',3,'5620233365',1,37),(6580,'GUSTAVO ARAUJO',3,'5549647659',1,37),(6581,'OSVALDO LOPEZ',3,'5543721298',1,37),(6582,'SUHELI MARTINEZ PAULIN',3,'5539919399',1,37),(6583,'ABEL ROJAS',3,'5614546485',4,37),(6584,'DANIEL LARRAGOITE RUIZ',3,'5542405199',1,37),(6585,'SALVADOR RAMIREZ',3,'SN',1,37),(6586,'YOALI MEJIA MOSQUEDA',3,'5621535763',1,37),(6587,'Alejandra Lira',3,'5560667938',1,37),(6588,'Luis Manuel Medina Rodriguez',3,'5534886327',1,37),(6589,'MONSERRAT BECERRIL',3,'5549055487',1,37),(6590,'Rodrigo Martinez',3,'5610264208',1,37),(6591,'ANGELICA ACEVES',3,'SN',3,37),(6592,'CRISTINA RODRIGUEZ',2,'5611318417',1,25),(6593,'KALID MILLA VELAZQUEZ',2,'5610628453',4,25),(6594,'PERFECT GYM',2,'5522644991',4,25),(6595,'ABILENE MORALES GARCIA',7,'5580306232',1,29),(6596,'JESUS CARBONERAS PANOCH',3,'SN',4,37),(6597,'ABRAHAM OLMOS CRESPO',6,'5523140934',1,30),(6598,'ALEJANDRA VILLAS DE LA HDA',6,'5568869587',1,30),(6599,'ALEJANDRO CAMACHO',6,'5614891505',1,30),(6600,'ALEJANDRO MEDINA',6,'5545548842',1,30),(6601,'ALEJANDRO MORENO',6,'5630484940',1,30),(6602,'ALFREDO MARQUEZ TORRES',6,'5566685073',1,30),(6603,'ALMA LEYVA',6,'7299277177',1,30),(6604,'ANDRES GUERRERO',6,'5637293332',1,30),(6605,'ANDRES HERNANDEZ',6,'5624043895',1,30),(6606,'ANDRES RAMIREZ',6,'5611681957',1,30),(6607,'ANGEL ISAAC LOPEZ VERA',6,'5635337598',1,30),(6608,'ANGEL JESUS HERNANDEZ',6,'5513978463',1,30),(6609,'ANGEL SUAREZ',6,'8332339210',1,30),(6610,'ANTONIO SEGURA',6,'SN',1,30),(6611,'ARMANDO ABRAHAM MURGUIA GOMEZ ENTREN',6,'5535620240',4,30),(6612,'BARBARA GOMEZ',6,'5512689704',1,30),(6613,'BENY GYM HONDURAS 4',6,'5564596495',4,30),(6614,'BERTHA MARIA TREJO',6,'SN',1,30),(6615,'BRENDA ESCOBAR',6,'5647680426',1,30),(6616,'Carlos barragan',6,'5542022381',1,30),(6617,'CARLOS VIVEROS',6,'5562005831',1,30),(6618,'CAROLINA IBARRA',6,'5583251460',1,30),(6619,'CESAR MORALES',6,'5567603155',1,30),(6620,'CLAUDIA CAMPOS',6,'5560911703',1,30),(6621,'CLEMENTE MACIEL HERRERA',6,'5520934202',1,30),(6622,'DALIA ALOR MATEO',6,'5524081888',1,30),(6623,'DANIEL MARTINEZ PEREZ',6,'5566575761',1,30),(6624,'DANIEL PIÑA',6,'5633451203',1,30),(6625,'DANIEL SEGURA',6,'5610252533',1,30),(6626,'DARIO VILLAREAL',6,'5528572342',1,30),(6627,'DIANA PEREZ',6,'5527547310',1,30),(6628,'DIEGO BUCIO',6,'5514159011',1,30),(6629,'DIEGO MARTINEZ',6,'5516968079',1,30),(6630,'DIEGO PIÑA CABRERA',6,'5639807603',1,30),(6631,'DIOSELINA GARCIA',6,'5627920649',1,30),(6632,'EDUARDO ALCARAZ ORTEGA',6,'5568536383',2,30),(6633,'EDUARDO BAEZ',6,'5624092692',1,30),(6634,'EDUARDO NAVARRETE',6,'5587356206',1,30),(6635,'EDWIN HERNANDEZ',6,'5513961230',1,30),(6636,'EINAR ZARATE',6,'5631416459',1,30),(6637,'ELIAS RUBEN',6,'5547759099',1,30),(6638,'ESTRELLA RUIZ',6,'5533322923',1,30),(6639,'FELIX OCAMPO NOYOLA',6,'5633093404',1,30),(6640,'FERNANDO GALINDO SANCHEZ',6,'5652746637',1,30),(6641,'FRANCISCO IBARRA',6,'5561840870',1,30),(6642,'GABRIEL JIMENEZ',6,'5545788486',1,30),(6643,'GERARDO BANDA (GIMNASIO IRON MAN)',6,'5533150987',4,30),(6644,'GISELA ANTONIO TRUJILLO',6,'5611081623',1,30),(6645,'GLORIA ESTRADA',6,'5535774943',1,30),(6646,'GUADALUPE ALEJANDRO',6,'6391092502',1,30),(6647,'HECTOR GONZALEZ  P4',6,'5642377446',4,30),(6648,'HECTOR LOPEZ',6,'5514841433',1,30),(6649,'HECTOR PAREDES',6,'5615067608',1,30),(6650,'HERNAN CRUZ',6,'5565647451',1,30),(6651,'IAN SANTIAGO SANCHEZ DÍAZ',6,'5528239057',1,30),(6652,'INSTRUCTOR CESAR',6,'SN',1,30),(6653,'ISMAEL LAGUNAS',6,'7221568558',1,30),(6654,'IVONNE LOPEZ',6,'5520568143',1,30),(6655,'JAIME ALFARO AVILES',6,'5574164214',1,30),(6656,'JAZMIN ORTIZ',6,'5610540034',1,30),(6657,'JESSICA MATUS',6,'5626862008',1,30),(6658,'JESUS ATILANO',6,'5535884252',1,30),(6659,'JESUS MARTINEZ',6,'5621727333',1,30),(6660,'JHONATHAN PADILLA',6,'5639724858',1,30),(6661,'JOHANA GONZALEZ',6,'6461212863',1,30),(6662,'JONATHAN CALDERON',6,'5528869639',1,30),(6663,'JONATHAN GARCIA MONDRAGON',6,'5519739751',1,30),(6664,'JORGE BARRADAS',6,'5578900589',1,30),(6665,'JORGE CRUZ',6,'5612874876',1,30),(6666,'JORGE GARCIA',6,'5516474581',1,30),(6667,'JOSE LUIS NAJERA',6,'5535952607',1,30),(6668,'JOSUE HERNANDEZ',6,'5618652676',1,30),(6669,'JUAN CARLOS CASTILLO',6,'5567027520',1,30),(6670,'JUAN CARLOS GARCIA',6,'5529213367',1,30),(6671,'JUAN CARLOS JIMENEZ',6,'5565233853',1,30),(6672,'JUAN CARLOS MARTINEZ VICTORIANO',6,'5554121764',1,30),(6673,'JUAN GREGORIO PEREZ',6,'5559173609',1,30),(6674,'JUAN JOSE ABREYO',6,'5632848706',1,30),(6675,'JUAN PABLO ALBA',6,'5542612495',1,30),(6676,'JUAN PUEBLA',6,'5591986488',1,30),(6677,'JULIAN BERMUDEZ',6,'5610219923',1,30),(6678,'JULIO CESAR MENDOZA BRAVO',6,'5510103686',1,30),(6679,'KATIA TELLEZ',6,'5543867174',1,30),(6680,'KEVIN CABALLERO',6,'5537192564',1,30),(6681,'LENIN MARTINEZ',6,'5630930211',1,30),(6682,'LILIANA VERDE',6,'5585355193',1,30),(6683,'LINA VERA',6,'5543842900',1,30),(6684,'LIZBETH DE JESUS NAVA',6,'5554686929',1,30),(6685,'LOURDES RIVERA',6,'5543691296',1,30),(6686,'LUCILA ZAMBRANO',6,'5586126997',1,30),(6687,'LUIS FELIPE AYALA SANCHEZ',6,'5562148316',1,30),(6688,'LUIS ROMERO',6,'5625834293',1,30),(6689,'LUZ SALAZAR',6,'5560248275',1,30),(6690,'MAGALI ARRIAGA',6,'5565249346',1,30),(6691,'MARCO ANTONIO GARCIA',6,'5534987389',3,30),(6692,'MARCO ANTONIO GUERRERO',6,'5554926193',1,30),(6693,'MARCO ANTONIO HERNANDEZ',6,'5529456926',3,30),(6694,'MARCO ANTONIO OCHOA',6,'5637070164',1,30),(6695,'MARIANO PEÑA HERNANDEZ',6,'5544419383',1,30),(6696,'MARIBEL REYES HERNANDEZ',6,'5521973647',1,30),(6697,'MARIO ALBERTO MOTA',6,'7298161633',1,30),(6698,'MARIO GUERRERO',6,'5542963574',1,30),(6699,'MARIO LEON',6,'5580393335',1,30),(6700,'MARK VALDES',6,'5532590395',1,30),(6701,'MAURICIO MEZA',6,'5513444846',1,30),(6702,'MAXIMILIANO PATIÑO',6,'SN',1,30),(6703,'MAXIMILIANO PATIÑO',6,'5514175040',1,30),(6704,'MIGUEL ESTRADA',6,'5568188858',1,30),(6705,'MIGUEL PEÑALOZA OFIC.',6,'5567419529',1,30),(6706,'MIRIAM FERNANDEZ',6,'5544523115',1,30),(6707,'MIRIAM HERNANDEZ',6,'5616026477',1,30),(6708,'NAYELI BENITEZ',6,'5513715945',1,30),(6709,'NOE GARCIA',6,'5635309254',1,30),(6710,'ONESIMO PEREZ LUCIANO',6,'5580372402',1,30),(6711,'OSCAR OWEN AGUILAR',6,'5636845917',1,30),(6712,'OSCAR TORRES',6,'5561708006',1,30),(6713,'PAMELA CABALLERO',6,'5534796183',1,30),(6714,'PATRICK BUSTAMANTE',6,'5520788833',1,30),(6715,'PEDRO FRANCISCO RIOS GUZMAN',6,'5610983892',1,30),(6716,'RICARDO SANCHEZ',6,'5650452135',1,30),(6717,'RICARDO VELAZQUEZ',6,'5512347343',1,30),(6718,'RODRIGO GARDUÑO',6,'5535639902',1,30),(6719,'RUBEN MUÑIZ',6,'5562912709',1,30),(6720,'SAHAD GUILLEN',6,'5566733263',1,30),(6721,'SAMANTHA VEGA AMORES',6,'5565043089',1,30),(6722,'SAMUEL PONCE',6,'5648359227',1,30),(6723,'SAMUEL URIBE',6,'5567452883',1,30),(6724,'SANAE FLORES MORA',6,'5611421988',4,30),(6725,'SANTIAGO ALVARADO',6,'5586115923',1,30),(6726,'SANTIAGO SOTO',6,'5521071691',1,30),(6727,'SERGIO HERNANDEZ',6,'9841423203',1,30),(6728,'SILVESTRE CERON RAMIREZ',6,'5514875704',1,30),(6729,'SIMON GARCIA',6,'5520795312',1,30),(6730,'VICTOR DE JESUS',6,'5528923981',1,30),(6731,'YAHIR PEREZ PRADO',6,'5526698027',1,30),(6732,'YAMIL SAID GORIDI',6,'5610140420',1,30),(6733,'YESERAYE',6,'5040704276',1,30),(6734,'ZAID ROSALES',6,'5527424981',1,30),(6735,'JESUS CRISTIAN RODEA MACIAS',6,'5584241823',4,30),(6736,'HECTOR GONZALEZ',6,'5642377446',1,30),(6737,'LUIS ROMERO 2',6,'5625834293',4,30),(6738,'MIGUEL ANGEL GARCIA SOSA',6,'5510272479',3,30),(6739,'SANTIAGO BRAND GARCIA',6,'5587943758',1,30),(6740,'ARMANDO ABRAHAM MURGUIA GOMEZ',6,'5635620240',1,30),(6741,'JUAN CARLOS QUIROZ CARREÑO',6,'5320393519',4,30),(6742,'CARMEN TORRES DON',3,'SN',4,37),(6743,'ALEJANDRO SALAZAR',2,'5560859454',1,25),(6744,'GERARDO FRANCO',2,'SN',1,25),(6745,'MARCO MORALES',2,'5519678413',3,28),(6746,'Oscar Gonzales Reyes',2,'5525737003',1,28),(6747,'LUIS PIMENTEL',2,'5514982304',3,28),(6748,'KEVIN LOPEZ LOPEZ',2,'5525261003',3,28),(6749,'(JERRY) GERARDO APOLO',2,'5518503507',1,28),(6750,'ABDESLEM MARQUINA',2,'5542852110',1,28),(6751,'ABRAHAM CHICO',2,'5645237847',1,28),(6752,'ABRAHAM GARCIA ARANA',2,'5531536920',1,28),(6753,'ABRAHAM HERNANDEZ',2,'5525346615',1,28),(6754,'ADOLFO JAVIER GONZALEZ',2,'5540734176',4,28),(6755,'ADOLFO SANCHEZ',2,'5569784512',3,28),(6756,'ADRIAN ALMARAZ',2,'5535137198',1,28),(6757,'ADRIAN ANDRADE',2,'5563185202',1,28),(6758,'ADRIAN DURAN',2,'5554959317',1,28),(6759,'ADRIAN MELCHOR ROBLES',2,'5525001208',1,28),(6760,'ADRIAN ROMO ISLAS',2,'5527729709',1,28),(6761,'Aimee Pallares',2,'SN',1,28),(6762,'ALAN GUERRERO',2,'5534288385',1,28),(6763,'ALBERTO GARCIA',2,'5545529080',1,28),(6764,'ALEJANDRA DEL VALLE',2,'5549991776',1,28),(6765,'ALEJANDRA GONZALEZ',2,'5545234581',1,28),(6766,'ALEJANDRO BARRON ROCHA',2,'5513608678',1,28),(6767,'ALEJANDRO DIAZ MACHINES GYM',2,'5617564025',4,28),(6768,'ALEJANDRO GONZALEZ ( PROVEEDOR)',2,'SN',2,28),(6769,'ALEJANDRO GRACIANO',2,'5549509911',3,28),(6770,'ALEJANDRO HERNANDEZ',2,'5573755095',1,28),(6771,'ALEJANDRO MORAN',2,'5540366369',1,28),(6772,'ALEJANDRO SANDOVAL',2,'5632968908',3,28),(6773,'ALEJANDRO ZAVALA',2,'5640005923',1,28),(6774,'ALEXA MARTINEZ',2,'5548800224',1,28),(6775,'ALFONSO RAMIREZ',2,'5638211367',1,28),(6776,'ALFONSO RUIZ',2,'5518225849',1,28),(6777,'ALFREDO MARTINEZ',2,'SN',1,28),(6778,'ALFREDO QUEVEDO',2,'5519175005',1,28),(6779,'ALFREDO RIVAS',2,'5575532326',1,28),(6780,'ALMA KAREN HERNANDEZ',2,'5579225309',1,28),(6781,'AMAURI',2,'5617401078',1,28),(6782,'ANDRES CRUZ',2,'5613168093',1,28),(6783,'ANDRICK GARCIA SANCHEZ',2,'5541363593',1,28),(6784,'ANGELICA CABALLERO',2,'5525330510',1,28),(6785,'ANGELICA HERNANDEZ',2,'SN',1,28),(6786,'ANGELO MARTINEZ',2,'5611603195',4,28),(6787,'ANIBAL RAMIREZ',2,'5569784512',3,28),(6788,'ANTONIO ESPARZA',2,'8128683168',1,28),(6789,'ANTONIO FLORES',2,'3221262507',1,28),(6790,'ANTONIO LUNA',2,'5612708451',4,28),(6791,'ARMANDO BONILLA',2,'5532932248',1,28),(6792,'ARMANDO ISRAEL SANDOVAL',2,'5549819293',1,28),(6793,'ARTURO FLORES',2,'5631248692',1,28),(6794,'ARTURO GONZALEZ ARANA',2,'5586863819',1,28),(6795,'ARTURO IBAÑEZ MPIO TLALNE',2,'5511619101',4,28),(6796,'BELEN DE ANDA ESPINOSA',2,'5565354397',1,28),(6797,'BENJAMIN SANCHEZ INSTRUCTOR',2,'5585770657',4,28),(6798,'BERNARDO FLORES',2,'5517620342',1,28),(6799,'BLANCA ROBLEDO',2,'5638182926',1,28),(6800,'BRYAN ALEJANDRO RERGIS GUERRA',2,'5618685113',1,28),(6801,'CARLOS BRINGAS',2,'5526570613',1,28),(6802,'CARLOS GARCIA DE ALBA',2,'5538943950',1,28),(6803,'CARLOS IZQUIERDO',2,'SN',1,28),(6804,'CARLOS LOPEZ',2,'5561539121',1,28),(6805,'CESAR MAURICIO RIVAS',2,'5535106015',1,28),(6806,'CESAR RIOS',2,'5561239435',3,28),(6807,'CHRISTIAN HERNANDEZ',2,'5514367400',1,28),(6808,'CHRISTIAN ORTIZ',2,'SN',1,28),(6809,'CHRISTIAN RAMIREZ',2,'5551038101',1,28),(6810,'CHRISTOPHER AXEL MONTOYA',2,'5569661018',1,28),(6811,'CIRILO SANCHEZ',2,'5525024259',1,28),(6812,'CRISTIAN DENA',2,'5611710573',1,28),(6813,'Cristian Hernandez Gutierrez',2,'SN',3,28),(6814,'CRISTIAN SANTOYO',2,'5613015316',4,28),(6815,'CRISTINA SAUCEDO',2,'5529290521',1,28),(6816,'Damian Isaac',2,'SN',1,28),(6817,'DANIEL AGUILAR VIZZUET',2,'5536658104',1,28),(6818,'DANIEL FLORES',2,'5534239658',1,28),(6819,'DANIEL GOMEZ DURAN',2,'5540601702',1,28),(6820,'DANIEL LUGO',2,'5581192536',1,28),(6821,'DANIEL RAMOS',2,'5539082303',1,28),(6822,'DANIELA FLOREZ',2,'5539875438',1,28),(6823,'DANIELA MARTINEZ',2,'5549624785',1,28),(6824,'DAVID ALEXIS POLO PAREDES',2,'5543198704',4,28),(6825,'DAVID MARTINEZ VILLARINO',2,'5628159018',4,28),(6826,'DAVID VILLANUEVA CASTILLO',2,'5571514671',1,28),(6827,'DENISE CHAUSAL',2,'5530336158',1,28),(6828,'DEREK ALMARAZ',2,'5530664359',1,28),(6829,'DIANA HERRERA',2,'5518491087',1,28),(6830,'DIANCY MEJIA',2,'5568059611',1,28),(6831,'DIEGO ANTONIO BAEZ CRUZ',2,'5549341938',1,28),(6832,'DIEGO CASTREJON',2,'SN',4,28),(6833,'DIEGO GARCIA',2,'5567638051',4,28),(6834,'DIEGO LOPEZ ALBARRAN',2,'5530757321',4,28),(6835,'EDGAR CARDENAS',2,'5622147791',3,28),(6836,'EDGAR MENESES',2,'5562501700',1,28),(6837,'EDGAR OMAR CUELLO ESCOBAR',2,'5511333900',1,28),(6838,'EDGAR VARGAS',2,'5543550839',3,28),(6839,'EDUARDO CENTENO',2,'5577312204',1,28),(6840,'EDUARDO JUAREZ',2,'5546021851',1,28),(6841,'EDUARDO MAGALLON',2,'5566533839',1,28),(6842,'EDUARDO MENDOZA',2,'5521483170',1,28),(6843,'EDUARDO TRANQUILINO MIRANDA',2,'5575544115',1,28),(6844,'EDUARDO ZAVALA',2,'5545537166',1,28),(6845,'ELIZABEHT RODRIGUEZ',2,'5540857486',1,28),(6846,'EMANUEL ALVARADO JIMENEZ',2,'5566786827',4,28),(6847,'EMILIO OLIVAR',2,'5565259463',1,28),(6848,'EMILIO VALDEZ',2,'5543823202',1,28),(6849,'EMILIO VAZQUEZ',2,'5565259463',1,28),(6850,'ENRIQUE CASILLAS',2,'5580350851',4,28),(6851,'ENRIQUE OROZCO',2,'5554316915',1,28),(6852,'ENRIQUE VARGAS',2,'5534163613',1,28),(6853,'ERANDENI HERNANDEZ',2,'5541330600',1,28),(6854,'ERICK GOMEZ',2,'5559977818',1,28),(6855,'erick hernandez',2,'SN',1,28),(6856,'ERICK ROJAS',2,'5523134538',3,28),(6857,'ERICK SANCHEZ',2,'5527537471',1,28),(6858,'Erik Marquez',2,'5579424844',1,28),(6859,'ERNESTO RAMIREZ',2,'5591885406',1,28),(6860,'ERNESTO RIVERA',2,'5544414943',1,28),(6861,'ESTEBAN AYON',2,'5535606970',1,28),(6862,'EZEQUIEL MORALES IRRA',2,'5514975363',1,28),(6863,'FEDERICO GARRIDO',2,'5527508382',4,28),(6864,'FELIPE DE JESUS BALDERAS',2,'5580090528',1,28),(6865,'FELIX SAN MIGUEL',2,'5541426921',1,28),(6866,'FERNANDA REYES',2,'5533451816',1,28),(6867,'FERNANDO DEL ANGEL',2,'5516843528',1,28),(6868,'FERNANDO FERREIRA',2,'5516002959',1,28),(6869,'FRANCISCO ALMENGOR   TE',2,'5511796686',4,28),(6870,'FRANCISCO CORONEL PLATA',2,'5518695133',3,28),(6871,'FRANCISCO HERNANDEZ',2,'5510164023',1,28),(6872,'FRANCISCO MEDINA',2,'5511335334',1,28),(6873,'FRANCISCO MIRANDA',2,'5560361932',1,28),(6874,'FRANCISCO VIDAL',2,'5532227263',1,28),(6875,'GABRIEL GUZMAN',2,'5568040210',1,28),(6876,'GABRIEL LINNO',2,'5582275925',4,28),(6877,'GAEL SANCHEZ',2,'5611104678',1,28),(6878,'GEOVANNI LOME',2,'5520966909',1,28),(6879,'GEOVANNI PEREZ',2,'5587614353',1,28),(6880,'GERARDO MARTIN OCHOA',2,'2224808833',1,28),(6881,'GERARDO PONCE',2,'5554566080',1,28),(6882,'Gerson Santiago',2,'7775499470',1,28),(6883,'GIOVANA TRILLO',2,'5554738202',1,28),(6884,'GREGORIO REYES HERRERA',2,'5537093789',1,28),(6885,'GUILLERMO BAUTISTA',2,'5560990689',1,28),(6886,'GUILLERMO GARCIA',2,'SN',4,28),(6887,'HIRAM GOMEZ',2,'5581015512',1,28),(6888,'HUGO ALBETO ANAYA BUENROSTRO',2,'552569695881',3,28),(6889,'HUMBERTO FRAGROSO',2,'5532253460',1,28),(6890,'IAN LOPEZ',2,'6241060673',1,28),(6891,'IAN RODRIGO LOPEZ',2,'6241060673',1,28),(6892,'IRIS GABRIELA CHAPAS',2,'5591113960',1,28),(6893,'IRVIN MORENO CHAVEZ',2,'5576170422',4,28),(6894,'ISAAC CEDILLO',2,'5541747809',1,28),(6895,'ISAAC MENDOZA',2,'5577113135',1,28),(6896,'ITZEL PINETH GONZALES',2,'5515840855',1,28),(6897,'ITZEL RAMIREZ',2,'5511758324',3,28),(6898,'ivan casas',2,'5553816780',1,28),(6899,'IVAN JAEM',2,'5550556806',1,28),(6900,'IVETTE ANGELES TOLEDO',2,'5554668636',1,28),(6901,'IVONNE TELLEZ HIGAREDA',2,'5613571901',1,28),(6902,'JALIL GOMEZ',2,'5524175017',3,28),(6903,'JAVIER TOVAR',2,'5552998319',3,28),(6904,'JESHUA GOMEZ',2,'5551562811',1,28),(6905,'JESUS ALBARRAN',2,'7222841486',1,28),(6906,'JESUS CORTES',2,'7711804739',1,28),(6907,'JESUS ROMERO',2,'5513190416',4,28),(6908,'JOHAN HERNANDEZ FIGUEROA',2,'5591410332',1,28),(6909,'JOHNY ARRIAGA',2,'5536737736',1,28),(6910,'JONATHAN ALVAREZ MENDEZ',2,'5521401978',1,28),(6911,'JONATHAN MORENO CRUZ',2,'5520862344',1,28),(6912,'JORGE ALAN MONRROY',2,'5519798533',1,28),(6913,'JORGE CAMPOS',2,'5545549425',1,28),(6914,'JORGE CARRERA',2,'5566317825',1,28),(6915,'JORGE DANIEL LOPEZ',2,'5518345841',1,28),(6916,'JORGE FRANCO',2,'5559620952',1,28),(6917,'JORGE GARCIA',2,'5586843404',1,28),(6918,'JORGE MARTINEZ GALLARDO',2,'5522017829',1,28),(6919,'JORGE MENDIOLA',2,'SN',4,28),(6920,'JORGE RODRIGUEZ',2,'SN',1,28),(6921,'JOSE ADAN CASTRO',2,'5630127560',1,28),(6922,'JOSE EVERARDO',2,'5562542389',1,28),(6923,'JOSE EZEQUIEL GOMEZ',2,'5523149383',1,28),(6924,'JOSE LUIS LEON',2,'5519178472',1,28),(6925,'JOSE LUIS MORA',2,'5563010552',1,28),(6926,'JOSE LUIS PEÑA',2,'5569676757',3,28),(6927,'Jose Luis Rojas Castillo',2,'5554304801',3,28),(6928,'JOSE LUIS SANCHEZ DE LA PORTILLA',2,'5561311339',1,28),(6929,'JOSE LUIS SANCHEZ MENDEZ',2,'5540935580',1,28),(6930,'JOSE LUIS ZAINOS',2,'5575799981',1,28),(6931,'JOSE MANUEL CANO',2,'5631041060',1,28),(6932,'JOSE MANUEL DOMINGUEZ',2,'SN',3,28),(6933,'JOSE MENDOZA PM',2,'4531730369',4,28),(6934,'JOSSELINE LOPEZ',2,'5554050714',1,28),(6935,'JOSUE SASTRE',2,'5541389733',1,28),(6936,'JUAN CARLOS LAZCANO RODRIGUEZ',2,'5620729465',4,28),(6937,'JUAN CARLOS MARTINEZ RUIZ',2,'5581714921',1,28),(6938,'JUAN DAVID MOSQUEDA',2,'5539961993',1,28),(6939,'JUAN DAVID PANFILO HERNANDEZ',2,'5534708226',1,28),(6940,'JUAN GONZALEZ',2,'5540734813',4,28),(6941,'JUAN MANUEL ARGUETTA',2,'SN',3,28),(6942,'JUAN MANUEL ORTEGA',2,'5572155279',1,28),(6943,'JUAN MANUEL REYES',2,'5551584786',1,28),(6944,'JUAN MARTINEZ',2,'5516465490',1,28),(6945,'JULIAN AGUILAR CAYETANO',2,'5511347604',3,28),(6946,'JULIO CESAR GASCA',2,'8326308308',1,28),(6947,'JUVENAL VENEGAS',2,'5525559268',1,28),(6948,'KARLA SERRANO',2,'5611774320',1,28),(6949,'KEVIN MUÑOZ GONZALEZ',2,'5539373301',1,28),(6950,'KEVIN REYES',2,'SN',4,28),(6951,'LALO RAMIREZ',2,'5616805883',3,28),(6952,'LEONARDO SOLIS',2,'525626925760',3,28),(6953,'LIAM ALEJANDRO',2,'5536748007',1,28),(6954,'LIZETH ORTIZ',2,'5611801274',1,28),(6955,'LORENA CAMPOS',2,'5543637696',3,28),(6956,'LORENZO HERNANDEZ',2,'5634766229',1,28),(6957,'LUCIA GARCIA',2,'SN',1,28),(6958,'LUIS ANGEL HERNANDEZ',2,'5562181396',1,28),(6959,'LUIS ENRIQUE SANCHEZ SALGADO',2,'5574740721',1,28),(6960,'LUIS GORDILLO',2,'5518665954',1,28),(6961,'LUIS GUILLERMO SANCHEZ ROMERO',2,'5610524494',1,28),(6962,'LUIS HERNANDEZ',2,'5528869856',1,28),(6963,'LUIS MIGUEL MEJIA',2,'5540275799',1,28),(6964,'LUIS MONRROY',2,'5523085340',3,28),(6965,'LUIS MUCIÑO',2,'5523354715',1,28),(6966,'LUIS OSORIO RESTAURANTE  OJO NEGRO',2,'SN',3,28),(6967,'LUIS SILVA',2,'5524993082',1,28),(6968,'Manuel Alejandro Rios',2,'5571111971',1,28),(6969,'MANUEL DE JESUS PEREZ LIRA',2,'5514075458',4,28),(6970,'MARCO ANTONIO CENTENO',2,'SN',1,28),(6971,'MARCO ANTONIO CENTENO',2,'5610146817',1,28),(6972,'MARCO ANTONIO CRUZ VIQUEZ',2,'5517681139',1,28),(6973,'MARCO ANTONIO LOPEZ',2,'5635436681',1,28),(6974,'MARCO ANTONIO PERALTA',2,'5545466215',1,28),(6975,'MARCO ANTONIO REYNOSO',2,'5568862372',1,28),(6976,'MARIA TEREZA',2,'SN',4,28),(6977,'MARIANA HERNANDEZ',2,'SN',3,28),(6978,'MARIANA PALMERIN',2,'5541933775',1,28),(6979,'MARIANO NAVA',2,'5627268203',1,28),(6980,'MARIO ALBERTO NEVAREZ VIRAMONTES',2,'55726489',3,28),(6981,'MARIO BELEZ',2,'5651721533',1,28),(6982,'MARIO ROSALES',2,'SN',3,28),(6983,'MARTHA MIREYA NAVARRO',2,'5540680487',4,28),(6984,'MELINA AYALA LOPEZ',2,'5545555407',4,28),(6985,'MERY RIVAS',2,'5540077185',1,28),(6986,'MIGUEL JACOBSEN',2,'5611739426',3,28),(6987,'MIGUEL MARTINEZ',2,'5551757563',1,28),(6988,'MIGUEL RODRIGUEZ BECERRIL',2,'5580187335',1,28),(6989,'MOISES DE LEON',2,'5575389352',1,28),(6990,'MONICA SELAH SANCHEZ',2,'5521928847',1,28),(6991,'NAILA ARCE',2,'SN',1,28),(6992,'NANCY BRISEÑO',2,'5540614682',1,28),(6993,'NANCY ESTRADA',2,'5519395901',1,28),(6994,'NANCY LOPEZ',2,'5521742067',1,28),(6995,'NELSON GOMEZ CABA',2,'5541309836',1,28),(6996,'NISAR MARTINEZ',2,'5551643713',1,28),(6997,'NORMAN LIRA',2,'5554778275',1,28),(6998,'olivia ayala',2,'SN',1,28),(6999,'OMAR TRANCOSO',2,'SN',1,28),(7000,'OSCAR HERNANDEZ RAMIREZ',2,'5591869002',3,28),(7001,'OSCAR PERALES',2,'5528917514',1,28),(7002,'OSCAR RAMIREZ',2,'5577583178',1,28),(7003,'OSCAR ROBERTO CHAVEZ',2,'5540940362',1,28),(7004,'OSVALDO SOSA',2,'5516907231',1,28),(7005,'OSWALDO SIERRA ROJAS',2,'5534774165',1,28),(7006,'PABLO GARCILAZO',2,'4435281332',4,28),(7007,'PAOLA SERVIEN',2,'5576209556',1,28),(7008,'PATRICIA GONZALEZ',2,'5554353158',3,28),(7009,'PATRICIO SAN RROMAN',2,'5625089655',1,28),(7010,'PAULA RAMIREZ MONTALVO',2,'5611303614',1,28),(7011,'PAVEL CORTES',2,'5527265673',1,28),(7012,'RAFA ORTEGA',2,'5510698555',1,28),(7013,'RAFAEL ORTEGA',2,'5510698555',1,28),(7014,'RAMON ACOSTA',2,'5539282490',1,28),(7015,'Raul Salcedo',2,'5517962774',1,28),(7016,'RAUL VALDEZ',2,'5615158114',3,28),(7017,'RAYMUNDO GRANADOS',2,'5533021772',3,28),(7018,'RENE SAUZA',2,'5539719147',1,28),(7019,'RICARDO ALCAZAR',2,'5522717468',3,28),(7020,'RICARDO ALVAREZ OSNAYA',2,'5563701065',1,28),(7021,'RICARDO ANTONIO PINEDA',2,'5526655192',1,28),(7022,'RICARDO DE LOS COBOS',2,'5539557856',1,28),(7023,'RICARDO SANCHEZ AGUIRRE',2,'5532233246',1,28),(7024,'RICARDO TERRAZAS',2,'5531450257',1,28),(7025,'RICARDO TERRAZAS',2,'5531450257',1,28),(7026,'RICARDO VILLEGAS',2,'5540879755',1,28),(7027,'ROBERTO GALINDO',2,'5537231319',1,28),(7028,'ROBERTO MARTINEZ GYM CAMPANARIO',2,'5539775490',4,28),(7029,'ROBERTO OROZCO RESENDIZ',2,'5535539514',1,28),(7030,'ROCIO VELASQUEZ PEREZ',2,'SN',1,28),(7031,'Rodney Santana Troncoso',2,'5538114681',1,28),(7032,'RODOLFO ALPIZAR GOMEZ',2,'7226115113',1,28),(7033,'RODRIGO HERNANDEZ',2,'6141868784',1,28),(7034,'RODRIGO LUGO',2,'5537273245',4,28),(7035,'RODRIGO MIRANDA',2,'5533976617',3,28),(7036,'RODRIGO MORALES',2,'5587924234',1,28),(7037,'RODRIGO OCAMPO',2,'2294803803',1,28),(7038,'RODRIGO REYES',2,'5518229248',1,28),(7039,'ROMAN FUERTES',2,'5530530051',1,28),(7040,'ROSALBA VIZUET',2,'6634409869',1,28),(7041,'SANDY ORTIZ',2,'5561236293',1,28),(7042,'SAUL FERNANDEZ',2,'SN',4,28),(7043,'SAUL VIDAL',2,'5647849028',1,28),(7044,'SEBASTIAN RODRIGUEZ',2,'5543614863',1,28),(7045,'SERGIO COLIN',2,'5569130036',3,28),(7046,'Sergio Olivarez',2,'SN',1,28),(7047,'SERGIO RIOS',2,'5568883255',1,28),(7048,'SOFIA VELAZCO',2,'5514169766',1,28),(7049,'TOMAS RAMIREZ',2,'5522681465',3,28),(7050,'TONATIUH GUERRERO',2,'5545408595',1,28),(7051,'ULISES ZURITA (PM)',2,'5620395204',4,28),(7052,'URIEL OLIVO',2,'6242454100',1,28),(7053,'VERONICA IVETTE CARRERO',2,'5521882464',4,28),(7054,'VICTOR CONTRERAS',2,'5528633252',3,28),(7055,'VICTOR HUGO VARGAS',2,'5579910916',1,28),(7056,'VICTOR MARTINEZ ALVAREZ',2,'5624689966',4,28),(7057,'VICTOR PALMERIN',2,'5561404890',1,28),(7058,'VICTOR SANTILLAN',2,'5516013725',1,28),(7059,'VICTOR SOLIS',2,'SN',4,28),(7060,'VICTOR VARGAS',2,'5579910916',1,28),(7061,'WILLIBALDO MENDOZA',2,'5555041916',1,28),(7062,'YAEL ESPINOZ',2,'5626640361',3,28),(7063,'Yair Loreto',2,'SN',1,28),(7064,'YERATH ZARZA',2,'5532879973',1,28),(7065,'YESICA BENITEZ',2,'5513918392',1,28),(7066,'YOHANNA CORONA',2,'SN',1,28),(7067,'ALEJANDRO MENDEZ',2,'SN',4,28),(7068,'ARTURO CORTES',2,'SN',4,28),(7069,'BENJAMIN SANCHEZ',2,'5585770657',1,28),(7070,'BRIAN MARTINEZ',2,'SN',4,28),(7071,'CARLOS ALFREDO SALAZAR ARIAS',2,'SN',3,28),(7072,'CARLOS SALAZAR ARIAS',2,'SN',3,28),(7073,'CESAR SALAS',2,'5611243692',1,28),(7074,'CLAUDIA BOSQUES',2,'SN',1,28),(7075,'CRISTINA SANCHEZ LEMUS',2,'SN',3,28),(7076,'CRISTOPHER LONG',2,'SN',3,28),(7077,'DIANA CORTES',2,'SN',1,28),(7078,'DOLORES SILVIA',2,'SN',3,28),(7079,'EDUARDO CAMACHO',2,'5512620232',4,28),(7080,'EFRAIN RUBIO',2,'SN',1,28),(7081,'EMANUEL ADBERSTEIN',2,'5539900940',3,28),(7082,'ENRIQUE GONZALEZ',2,'5531148910',1,28),(7083,'FRANCISCO RAMIREZ',2,'SN',1,28),(7084,'GIOVANI ORIBE',2,'SN',1,28),(7085,'JESUS MEDINA',2,'SN',1,28),(7086,'JOAQUIN ALVARES RIOS',2,'SN',1,28),(7087,'JOSE LUIS GARCIA',2,'SN',1,28),(7088,'JUAN CARLOS LAZACANO',2,'SN',4,28),(7089,'JULS MENDOZA',2,'SN',1,28),(7090,'KAREN NOGUEZ',2,'SN',3,28),(7091,'KEHAN PINEDA',2,'5529882292',1,28),(7092,'LINDA TIRADO',2,'SN',3,28),(7093,'MANUEL CORONADO',2,'SN',3,28),(7094,'MANUEL RUIZ R.',2,'SN',3,28),(7095,'MARIO CARBAJAL SIBAJA',2,'SN',1,28),(7096,'MIGUEL HERRERA',2,'SN',4,28),(7097,'MOISES TELLEZ',2,'SN',1,28),(7098,'PABLO MADRIGAL',2,'SN',3,28),(7099,'RACIEL LUGO VARGAS',2,'SN',1,28),(7100,'RICARDO  GALICIA CASAS',2,'5530446163',1,28),(7101,'RICARDO PEDROZA',2,'SN',1,28),(7102,'RICARDO ZAVALA',2,'5569687888',1,28),(7103,'ROBERTO ALVAREZ RONDERO',2,'5577246902',3,28),(7104,'ROBERTO CASTELLO',2,'SN',1,28),(7105,'SERGIO MORA NAVARRO',2,'SN',4,28),(7106,'SERGIO RAUL RAMIREZ',2,'SN',4,28),(7107,'ULISES BERNAL',2,'SN',4,28),(7108,'ZAYRA NAVA',2,'5534285160',1,28),(7109,'Sandra Aparicio',2,'5512968944',3,25),(7110,'SARA CASARRUVIAS ARIES GYM',2,'SN',4,28),(7111,'Oscar Vargas',2,'SN',1,28),(7112,'ANDREA SOTO',2,'SN',1,28),(7113,'HECTOR TERAN',2,'SN',1,28),(7114,'Victor Alexis',2,'SN',1,28),(7115,'Yoselin Salazar',2,'SN',1,28),(7116,'ESTEPHANY VALDIVIA',2,'5534811301',1,28),(7117,'ERIK PEON LOPEZ',2,'SN',4,28),(7118,'ALEJANDRO BALDERAS',2,'5582338573',1,28),(7119,'ALEJANDRO MARTINEZ LOPEZ',2,'SN',1,28),(7120,'ALEJANDRO VILLAFAÑA',2,'5547924326',1,28),(7121,'ANTONIO JIMENEZ',2,'5543288594',1,28),(7122,'BEATRIZ VALENCIA',2,'5519562906',1,28),(7123,'CARLOS DIAZ',2,'5530389996',4,28),(7124,'CRISTIAN GARCIA',2,'SN',1,28),(7125,'CYNTHYA QUINTERO',2,'5614000154',1,28),(7126,'DANIEL TRUJILLO CALDERON',2,'5533631091',1,28),(7127,'DAVID ANTONIO RODRIGUEZ PEÑA',2,'5587592458',1,28),(7128,'DIEGO MORALES COVA',2,'5559405912',1,28),(7129,'EDGAR ADRIAN ROMERO GARCIA',2,'5540247491',1,28),(7130,'EDUARDO MURILLO',2,'5571965515',1,28),(7131,'EMMANUEL GONZALEZ',2,'5530156695',1,28),(7132,'ENRIQUE CRUZ GARCIA',2,'5543425116',1,28),(7133,'ERWIN OMAR SALAZAR MARTINEZ',2,'5530107161',1,28),(7134,'FELIPE ANCER HERNANDEZ',2,'5528566354',1,28),(7135,'FERNANDO GIL VILLAFUERTE',2,'5620046677',1,28),(7136,'FRANCISCA DAVILA',2,'5537311529',1,28),(7137,'FRANCISCO JAVIER CADENA',2,'5631051257',1,28),(7138,'GABRIEL DUQUE',2,'5516558778',1,28),(7139,'GERARDO HERNANDEZ',2,'5581343686',1,28),(7140,'GERSAIN FOSADO',2,'55',2,28),(7141,'GUILLERMO BAUTISTA',2,'5560890690',1,28),(7142,'HECTOR GARCIA PEÑA',2,'5527790864',3,28),(7143,'JONATHAN ALVAREZ MENDEZ',2,'5521401978',1,28),(7144,'JORGE GOMEZ',2,'5577851831',1,28),(7145,'JOSHUA GAEL GOMEZ GAMBOA',2,'5621913336',1,28),(7146,'MARIA ISABEL OLMEDO CARMONA',2,'5564772646',1,28),(7147,'MARIEL ROMERO GARCIA',2,'5587005063',1,28),(7148,'MIGUEL RAMIREZ',2,'5560588208',1,28),(7149,'OSCAR MONTIEL',2,'5586151543',1,28),(7150,'RODRIGO MARTINEZ',2,'5513316452',1,28),(7151,'SERGIO TORRES',2,'5563575698',1,28),(7152,'TEODORO HERNANDEZ',2,'SN',3,28),(7153,'VICTOR GARCIA HERNANDEZ',2,'5543683229',3,28),(7154,'YADIRA TUXPAN PIZAÑA',2,'5568935411',1,28),(7155,'OSCAR NARTINEZ',2,'5569418571 Y 5539383171',4,28),(7156,'ERICK MANUEL PORTILLO LOPEZ',2,'5617778851',3,28),(7157,'ARMANDO ROCHA HERNANDEZ',2,'5523735377',4,28),(7158,'ALEJANDRO MONDRAGON',2,'5523940660',1,28),(7159,'ALEJANDRO PEÑA',2,'5586968291',4,28),(7160,'ANDRES BERNAL',2,'5551058964',3,28),(7161,'ANDRES MARTINEZ',2,'5615007983',4,28),(7162,'ANGELES HERNANDEZ',2,'5579179025',1,28),(7163,'ARTURO PEREZ',2,'2212165997',1,28),(7164,'CARLOS MORALES',2,'5519147429',1,28),(7165,'CLAUDIO CUEVAS',2,'5531185839',1,28),(7166,'DIEGO FERNANDO ORTEGA',2,'SN',1,28),(7167,'EDITH MILLAN',2,'5521816387',1,28),(7168,'EDUARDO PADILLA',2,'5566957842',1,28),(7169,'EDUARDU RAMIREZ CORTEZ',2,'SN',1,28),(7170,'ERICK GEOVANI VARON',2,'SN',1,28),(7171,'EUGENIA',2,'SN',1,28),(7172,'FRANCISCO DANIEL LUGO',2,'5538925315',1,28),(7173,'FREDY VALENCIA',2,'5522195161',1,28),(7174,'GEOVANI SANCHEZ',2,'5525525747',1,28),(7175,'JACOB LARA',2,'5561827329',1,28),(7176,'JOAQUIN SOLIS MUÑOZ',2,'5554121981',1,28),(7177,'JOSE MANUEL TICO RIVERO',2,'5618570014',1,28),(7178,'KALi MENDAZ',2,'SN',3,28),(7179,'LEONCIO PEDRO GARCIA NUÑEZ',2,'SN',1,28),(7180,'LEONEL CARDENAS',2,'SN',1,28),(7181,'LUIS MIGUEL',2,'SN',1,28),(7182,'MANUEL ANGELES',2,'5545574910',1,28),(7183,'MARCO ANTONIO REYES',2,'5540890065',1,28),(7184,'MARLENE NAVARRETE',2,'5554097923',1,28),(7185,'NOE PUGA',2,'5524990097',3,28),(7186,'OSKAR RODRIGUEZ',2,'5573820500',1,28),(7187,'PABLO MEDINA',2,'5548993270',3,28),(7188,'RENE CRUZ MONTEJO',2,'5510981330',1,28),(7189,'RICARDO TAFOLLA',2,'5517287532',3,28),(7190,'SALVADOR SANTIAGO RAMIREZ',2,'5565126471',1,28),(7191,'SERGIO BENITEZ',2,'5511949280',3,28),(7192,'ZEDNA MARIANA ALCANTARA',2,'5565143997',1,28),(7193,'GRACIELA MOEDANO IZQUIERDO',2,'5523144092',1,28),(7194,'ERWIN SAUL CERON',2,'5535697531',1,28),(7195,'IRVING MARTINEZ',2,'5540801291',1,28),(7196,'CARLOS DIAZ LEON',2,'5530389996',4,28),(7197,'DAGOBERTO MONTAÑO',2,'SN',1,28),(7198,'DAViD VARGAS',2,'SN',4,28),(7199,'GUSTAVO MARTINEZ PEREZ',2,'SN',3,28),(7200,'JESUS MANUEL PACHECO HUERTA',2,'SN',1,28),(7201,'OMAR CUELLAR',2,'SN',4,28),(7202,'PATRICIA TOVAR  LOPEZ',2,'5621856409',4,28),(7203,'ROBERTO PADILLA',2,'SN',4,28),(7204,'RODRIGO SANDOVAL',2,'5586766968',4,28),(7205,'ALBERTO SANCHEZ',2,'5587736834',4,28),(7206,'VICTOR HUGO MILAN',2,'SN',3,28),(7207,'EMILIANO REYES',2,'SN',3,28),(7208,'GIOVANNI ROJAS',2,'SN',1,28),(7209,'FRANCISCO HERNANDEZ',2,'5545122902',1,28),(7210,'GABRIEL GUARDADO GONZALEZ',2,'5511879686',3,28),(7211,'GERARDO VENEGAS',2,'5618212744',1,28),(7212,'ANTONO DEMARCO',2,'5525725238',1,25),(7213,'PABLO ROMAN',2,'5524748845',4,25),(7214,'CLAUDIA GUIVEL',5,'4428250634',4,25),(7215,'BRENDA GARCIA GARCIA',5,'5533991654',4,25),(7216,'Diego Avila',5,'4425624827',1,25),(7217,'emiliano luna',5,'5533352949',1,25),(7218,'Erick Vargas',5,'5591896716',1,25),(7219,'Fernanda acosta',5,'6421160510',1,25),(7220,'Omar Guzman',5,'4424495361',1,25),(7221,'ALFONSO HERNANDEZ',5,'4771154794',3,25),(7222,'Andy Estes',5,'+13462178452',3,25),(7223,'Armando Castillon',5,'5533560749',3,25),(7224,'Benjamin Vazquez',5,'28122126928',1,25),(7225,'Bibian Peña',5,'8681703752',4,25),(7226,'CARLOS DOMINGUEZ',5,'4423357542',1,25),(7227,'CARLOS GRANILLO',5,'4425992766',1,25),(7228,'CLAUDIA GUIVEL',5,'4428250634',4,25),(7229,'Elias Orea',5,'7227085113',1,25),(7230,'Emanuel Murillo',5,'4272139585',3,25),(7231,'Emilio Perez',5,'4423270137',3,25),(7232,'Estefania Borrego',5,'8717450979',3,25),(7233,'GABRIELA CASILLAS',5,'8441605657',1,25),(7234,'Hector Segura',5,'5554374104',1,25),(7235,'Humberto Avalos',5,'6242101497',3,25),(7236,'IVAN MENDOZA',5,'6671253425',1,25),(7237,'JAIME RINCON',5,'5559038153',1,25),(7238,'Jose Pablo',5,'6681368950',3,25),(7239,'Kevin Martinez',5,'4461036434',1,25),(7240,'LUIS ENRIQUE QUINTANA',5,'5533670475',3,25),(7241,'Marcos protein',5,'7715698496',1,25),(7242,'Miguel Angel Dib',5,'4421863599',1,25),(7243,'Monica Mejorada Renteria',5,'4422878542',1,25),(7244,'NORMA HERNANDEZ',5,'7227621774',1,25),(7245,'Sabina Garnea',5,'6291184374',1,25),(7246,'SANTIAGO MARCOS',5,'614 3520382',1,25),(7247,'SANTIAGO RODRIGUEZ',5,'7772338024',1,25),(7248,'VANESA GOMEZ',5,'5549111859',1,25),(7249,'Yaya Aguilar',5,'4613120500',1,25),(7250,'Roberto Otomindi',5,'4425992766',1,25),(7251,'ALEJANDRA GONZALEZ',2,'5575042437/5558252316',1,25),(7252,'ANTONIO SOSA CASTILLO',2,'SN',4,25);

INSERT INTO `incidents` VALUES (9,25,'2024-11-18','OTRO','DIA FESTIVO OFICIAL'),(10,27,'2024-11-18','OTRO','DIA FESTIVO'),(11,28,'2024-11-18','OTRO','DIA FESTIVO'),(12,38,'2024-11-18','OTRO','DIA FESTIVO'),(13,36,'2024-11-18','OTRO','DIA FESTIVO'),(14,34,'2024-11-18','OTRO','DIA FESTIVO'),(15,34,'2024-11-18','OTRO','DIA FESTIVO'),(16,34,'2024-11-18','OTRO','DIA FESTIVO'),(17,32,'2024-11-12','VACACION','CUBRE ANTONIO'),(18,32,'2024-11-26','VACACION','CUBRE MIRIAM'),(19,27,'2024-12-03','OTRO','ENTREGA DE CAJA'),(20,28,'2024-12-03','OTRO','ENTREGA DE CAJA'),(21,29,'2024-12-03','OTRO','ENTREGA DE CAJA'),(22,32,'2024-12-03','OTRO','ENTREGA DE CAJA'),(23,30,'2024-11-01','FALTA','NO ENTREGO RECETA'),(24,38,'2024-12-03','PERMISO','PERMISO DE LLEGAR TARDE POR LLEVAR MOTOCICLETA A SERVICIO'),(25,30,'2025-01-06','FALTA','ENFERMEDAD'),(26,30,'2025-01-06','FALTA','ENFERMEDAD'),(27,30,'2025-01-07','FALTA','ENFERMEDAD'),(28,28,'2025-01-23','PERMISO','SALIDA TEMPRANO'),(29,29,'2025-01-28','PERMISO','CAMBIO DE HORARIO 9-6'),(30,33,'2025-01-05','FALTA','ACCIDENTE'),(31,37,'2025-01-07','TERMINO_RELACION_LAVORAL','RENUNCIA'),(32,32,'2025-01-31','FALTA','CUBRE MIRIAM'),(33,32,'2025-01-23','PERMISO','CITA MEDICA LLEGADA 1 PM'),(34,32,'2025-01-20','FALTA','CUBRE MIRIAM'),(35,32,'2025-01-21','FALTA','CUBRE MIRIAM'),(36,32,'2025-01-02','VACACION',NULL),(37,32,'2025-01-02','VACACION','REVISAR DIAS'),(38,32,'2025-01-02','VACACION',NULL),(39,32,'2025-01-02','VACACION',NULL);

INSERT INTO `prices` VALUES (1,'Publico'),(2,'Frecuente'),(3,'Mayoreo'),(4,'Distribuidor'),(6,'Lista_especial');

INSERT INTO `product` VALUES (6693004,'PHEDRACUT WATER DIURETIC 90 CAPS','166','6',0,NULL),(9911003,'TOPPING EXTRA AVENA','119','10',0,NULL),(11040009,'BLENDER BOTTER','1','9',0,NULL),(11040012,'LIGA TENSORA','1','7',0,NULL),(11080001,'RODILLO DE POLIURETANO  20X10','2','7',0,NULL),(11080003,'RODILLO DE POLIURETANO  12X50','2','7',0,NULL),(11080004,'SOPORTE P/ BARRA POLIURETANO GRANDE','17','11',0,NULL),(11080006,'SOPORTE PARA BARRA TIPO HUESO','2','7',0,NULL),(11120003,'BANDOLA CROMADA PARA CABLE DE ACERO','3','7',0,NULL),(11120004,'POLEA CHICA DE PLASTICO','3','7',0,NULL),(11120005,'POLEA ESTÁNDAR DE PLASTICO DE  4.5\"','3','7',0,NULL),(11120007,'SEGUROS PARA BARRA (PAR)','1','7',0,NULL),(11120008,'PAR  DE GRILLETES DE CUERO','3','7',0,NULL),(11120009,'US SHAKER','166','9',0,NULL),(11120010,'FAJA CUERO  CH, M, GDE, EX','4','7',0,NULL),(11120011,'PAR DE GRILLETES SINTETICOS','4','7',0,NULL),(11120012,'PAR DE GUANTES CON Y SIN MUÑEQUERA','18','15',0,NULL),(11120013,'CHALECO DE NEOPRENO TALLA CH, M, GDE','4','7',0,NULL),(11120014,'FAJA COLOMBIANA NEOPRENO CH, M, GDE','4','7',0,NULL),(11120015,'FAJA 3 VELCROS CH, M, GDE','4','7',0,NULL),(11120016,'FAJA CARNAZA VARIOS DISEÑOS CH,M,G','4','7',0,NULL),(11120017,'VENDA MTX REFORZADA P/RODILLA 1.5M','4','7',0,NULL),(11120018,'PAR DE MUÑEQUERAS VARIOS COLORES','4','7',0,NULL),(11120019,'PAR DE VENDAS P/RODILLAS V/COLORES','4','7',0,NULL),(11120020,'CHALECO DE HULE PARA SUDAR DAMA','4','7',0,NULL),(11120021,'CALLERAS (VARIOS MODELOS)','4','7',0,NULL),(11120022,'PAR DE STRAPS   ECONOMICO','4','7',0,NULL),(11120023,'PAR DE STRAPS CON MUÑEQUERA','4','7',0,NULL),(11120024,'BANDA ELASTICA P/ PIERNA CHICA','1','54',0,NULL),(11120026,'BANDA ELASTICA P/ PIERNA  GRANDE','1','54',0,NULL),(11120027,'SET CON 3 BANDAS TELA (3 RESIS) 3MODELOS','4','7',0,NULL),(11120028,'GUANTE VERRY REFORZADO','4','7',0,NULL),(11120031,'SET HIP RESISTANCE BANDS (3PZ)','4','7',0,NULL),(11120032,'GUANTE EVERLAST BOX','4','7',0,NULL),(11120033,'PAR GRILLETES CARNAZA','89','6',0,NULL),(11120034,'MANOPLA BOX','4','7',0,NULL),(11120035,'COSTAL MED P/BOX','33','14',0,NULL),(11120036,'VENDA PARA BOX (VARIOS COLORES)','4','7',0,NULL),(11120038,'POLAINA PAR  1/2 KILO','4','7',0,NULL),(11120039,'CHALECO DE PESO 10 KILOS','4','7',0,NULL),(11120041,'CINTA KINESIOLOGICA','4','7',0,NULL),(11120042,'CUERDA PARA BRINCAR DE CUERO','4','7',0,NULL),(11120043,'ARMBLASTER','4','7',0,NULL),(11120044,'PAR DE MUÑEQUERAS AIR (AZUL-NEGRO)','4','7',0,NULL),(11120045,'POLAINA PAR DE 2KG','4','7',0,NULL),(11120046,'FAJA CORSET NEOPRENO TALLA CH, M, GDE','93','1',0,NULL),(11120047,'PROTECTOR BUCAL ECONOMICO','120','3',0,NULL),(11120048,' BANDAS ANCHAS CUERPO ENTERO VERDE','4','7',0,NULL),(11120049,'PROTECTOR BUCAL GEL','96','2',0,NULL),(11120054,'RODILLERA ALTA COMPRESION','4','7',0,NULL),(11120055,'ROLLER CON LIGA','4','7',0,NULL),(11120058,'CUERDA P/BRINCAR DE CUERO C PESO PROFESI','4','7',0,NULL),(11120060,'CUERDA PARA BRINCAR CHICOTE ACERO','4','7',0,NULL),(11120061,'CHALECO DE HULE PARA SUDAR VARIAS TALLAS','4','7',0,NULL),(11120062,'CODERA TALLA: CH,M,G','179','7',0,NULL),(11130000,'SUDADERA CORTA NIKE (VARIOS MODELOS)','6','7',0,NULL),(11130001,'LEGGINS NIKE, ADIDAS (VARIOS MODELOS)','6','7',0,NULL),(11130003,'PLAYERA PROSUPS Y BSN','33','2',0,NULL),(11130007,'PLAYERA HOMBRE (NIKE,ADIDAS,UMBRO)','6','7',0,NULL),(11130008,'FALDA/SHORT NIKE (VARIOS COLORES)','6','7',0,NULL),(11130009,'PAR DE CALCETAS GYM NIKE','94','5',0,NULL),(11130010,'SHORT LISO NIKE','6','7',0,NULL),(11130011,'SHORT NIKE, BARBIE LARGO','6','7',0,NULL),(11130014,'CHALECO CIERRE HOMBRE (VARIOS MODELOS)','6','7',0,NULL),(11130016,'PLAYERA DE TIRANTES (VARIOS MODELOS)','8','7',0,NULL),(11130018,'GORRA (VARIOS MODELOS)','8','7',0,NULL),(11130021,'SHORT WILSON HOMBRE','10','7',0,NULL),(11130022,'MAYONES WILSON MUJER','10','7',0,NULL),(11130023,'PLAYERA WILSON MUJER MANGA CORTA','10','7',0,NULL),(11130025,'PLAYERA WILSON HOMBRE MANGA CORTA','10','7',0,NULL),(11160003,'LUBRICANTE PARA CAMINADORA  250 ML','12','7',0,NULL),(11160005,'SPRAY LUBRICANTE PARA POLEAS','17','11',0,NULL),(11250008,'CABLE ACERO/VINIL  1/8 - 3/16 (DELGADO)','13','7',0,NULL),(11250009,'CABLE ACERO/VINIL  3/16 - 1/4 (GRUESO)','13','7',0,NULL),(33100006,'TRITAN SENCILLOS (ROJO,ROSA,NARANJA)','15','9',0,NULL),(33100007,'COOL GEAR SENCILLO (VARIOS COLORES)','15','9',0,NULL),(33100008,'COOL GEAR C/ENFRIADOR (VARIOS COLORES)','15','9',0,NULL),(33100009,'MAGNESIA DEPORTIVA POLVO 100 G','4','7',0,NULL),(33100011,'CONJUNTOS SUPER HEROES UNITALLA','179','7',0,NULL),(33100012,'LEGGINGS NEON UNITALLA','179','7',0,NULL),(33100013,'FALDA SHORT SUBLIMADA UNITALLA','179','7',0,NULL),(33100016,'LEGGINS SUBLIMADO XL','179','7',0,NULL),(33100019,'MAGNESIA DEPORTIVA EN BARRA','179','16',0,NULL),(33125001,'TEST 400 10ML  CIPIONATO 200MG ENANTATO','161','2',0,NULL),(33125002,'NPP 100 10ML  NANDROLONE PHENYLPROPIONAT','179','11',0,NULL),(33125003,'TREN E 200 10ML   (TRENBOLONE ENANTHATE','179','11',0,NULL),(33125004,'TEST E 200 10ML    (TESTO ENANTHATE)','179','11',0,NULL),(33125005,'SUSTANON 250 10ml   (PROPIO, PHEN PROPIO','164','14',0,NULL),(33125006,'TREN A 100MG/ML','179','11',0,NULL),(33125007,'DECA N 200 (NANDROLONE DECAONATE 200MG/M','179','11',0,NULL),(33125008,'MAST P 100  (DROSTANOLONE PROPIONATE 100','166','14',0,NULL),(33125009,'TEST PROP 100   (TESTO PROPIONATE 100MG/','166','1',0,NULL),(33125010,'WINSTROL 100   (STANOZOLOL 100MG/ML)','180','11',0,NULL),(33125011,'TEST CYP 200    (TESTO CYPIONATE 200MG/M','180','11',0,NULL),(33125012,'PRIMO A 100   (METHENOLONE ACETATE 100MG','180','11',0,NULL),(33125013,'EQUIPOISE 200   (BOLDENONE UNDECYLENATE','180','11',0,NULL),(33125015,'MK-2866 OSTARINE 10MG 100TABS   AUMEN','180','11',0,NULL),(33125016,'GW-501516 CARDARINE 10MG 100TABS','180','11',0,NULL),(33125018,'LGD-4033 LIGANDROL 25MG 100TABS','180','11',0,NULL),(33125019,'OXY-50 OXYMETALONA 50MG 100TABS','180','11',0,NULL),(33125020,'CLEN-40 CLEMBUTEROL .04MG 100TABS','180','11',0,NULL),(33125022,'DIANA-25 DIANABOL 25MG 100TABS','180','11',0,NULL),(33125023,'OXA-10 OXANDROLONA 10MG 100TABS','180','11',0,NULL),(33125024,'WIN-15 WINSTROL 15MG 100TABS','180','11',0,NULL),(33150003,'BOLDENONA ADN 200MG  10ML','17','11',0,NULL),(33150005,'CIPIONATO TESTO ADN 300MG  10 ML','17','11',0,NULL),(33150006,'CLEMBUTEROL ADN 40 MCG','17','11',0,NULL),(33150007,'DECA NANDROLONA ADN 200 MG 10ML','35','7',0,NULL),(33150008,'DIANABOL ADN  100 TABS 20MG','35','7',0,NULL),(33150009,'ENANTATO TESTO ADN 300MG 10 ML','17','11',0,NULL),(33150010,'OXANDROLONA ADN 10MG  100TABS','35','2',0,NULL),(33150011,'OXYMETALONA ADN 100 TABS 10MG','17','11',0,NULL),(33150012,'PRIMOBOLAN ADN 100 MG 10ML','17','11',0,NULL),(33150013,'PROPIONATO TESTO ADN 100MG 10ML','17','11',0,NULL),(33150014,'PROVIRON ADN 50 TABS','17','11',0,NULL),(33150015,'STANOZOLOL ADN INY 100MG 10ML','17','11',0,NULL),(33150016,'STANOZOLOL ADN 10MG 100TABS','17','11',0,NULL),(33150017,'SOSTENON ADN 275MG 10ML','187','XXXXXX',0,NULL),(33150018,'TREMBOLONA ACETATO ADN 100MG  10ML','17','11',0,NULL),(33150021,'MASTERON ADN 100MG  10ML','17','11',0,NULL),(33200003,'PULSERA THE CURSE','18','7',0,NULL),(33200005,'ARGININA ONE RAW + SHAKER TRITAN $240','179','7',0,NULL),(33200006,'COOL GEAR ENFRIADOR + CREAT SAN $220','18','15',0,NULL),(33200007,'GUMMIES CLA 2PZASX$140','18','6',0,NULL),(33200008,'PASTILLERO ULTIMATE NUT','18','7',0,NULL),(33200009,'TVR 350 10MG XT LABS','24','11',0,NULL),(33200010,'PSYCHOTIC WAR ZOMBIE2PZ X $590','18','15',0,NULL),(33300012,'EMBUDOS ULTIMATE NUT','18','15',0,NULL),(33300013,'TREMBO GOLD 75MG/10ML REDGOLD','19','11',0,NULL),(33300015,'STANO GOLD INY 100 MG/ML REDGOLD','19','11',0,NULL),(33300018,'OXYTOLAND 50MG (OXYMETALONA)','21','11',0,NULL),(33300020,'PERFECT BOOTY 80MG 100 TABS','13','11',0,NULL),(33300021,'PERFECT LEG´S + ABS 100 TABS','13','11',0,NULL),(33360890,'GLUTEO PEPTONAS NEXA 100 CAPS','13','11',0,NULL),(33360891,'PEPTONAS INY UN 40 ML','13','11',0,NULL),(33800003,'EURO CUTS PRO 400','22','11',0,NULL),(33800004,'EURO DECA 300 10ML','22','11',0,NULL),(33800007,'EURO PRIMO 100 10 ML','22','11',0,NULL),(33800008,'EURO SUSTA 350 10 ML','22','11',0,NULL),(33800009,'EURO TESTO 500 10 ML','22','11',0,NULL),(33800010,'EURO TESTO-C 350 10ML','22','11',0,NULL),(33800011,'EURO TESTO-E 350 10 ML','22','11',0,NULL),(33800012,'EURO TESTO-P 100 10ML','22','11',0,NULL),(33800013,'EURO TREN-A 100 10ML','22','11',0,NULL),(33800015,'EURO WINNY 100 10ML','22','11',0,NULL),(33800016,'EURO WINNY PRO 100 10ML','22','11',0,NULL),(33800018,'EURO CLEMBU 60 TABS 40 MCG','22','11',0,NULL),(33800019,'FENTERMINA 30MG        IFA CELTICS','185','11',0,NULL),(33800022,'EQUIPOISE 50ML (UNDECILENATO DE BOLDE)','25','11',0,NULL),(33800023,'EURO OXANDROLONA 10MG','22','11',0,NULL),(33800024,'EURO PRIMO 50MG 60 CAPS','22','11',0,NULL),(33800025,'EURO OXYMETALONA 50MG 60CAPS','22','11',0,NULL),(33800028,'EURO ARIDEX 1MG 60 CAPS (LIQUIDACIÓN)','22','11',0,NULL),(33800029,'EURO PROVY 25MG 60 CAPS (LIQUIDACIÓN)','33','14',0,NULL),(33805005,'DURATESTON 350MG (MEZCLA DE TESTO)','26','11',0,NULL),(33805009,'NANDRO PLUS 300MG X 10ML (MEZCLA DECAS)','26','11',0,NULL),(33805011,'NANOBOLDE 200MG X 10ML (BOLDENONA)','79','XXXXXX',0,NULL),(33805013,'NANOBOLDE PLUS 300MG X10ML MEZCLA BOLD','26','11',0,NULL),(33805014,'PROVIRON  50 TABS 25 MG  ROTTERDAM','26','11',0,NULL),(33805015,'TESTEX 100MG (PROPIONATO TESTO)','26','11',0,NULL),(33805017,'PARABOLAN 100MG X 10ML (TREMBOLONA ACE)','79','14',0,NULL),(33805018,'PARABOLAN PLUS 300MG 10ML  MESCLA DE TRE','26','11',0,NULL),(33805019,'FINAJET 100MG X 10ML (TREMBO ENANTATO)','26','11',0,NULL),(33805021,'TESTOVIRON 250MG X 10ML (TESTO ENANTATO)','26','11',0,NULL),(33805023,'DEPOSTERON 25MG X 10ML (TESTO CIPIONATO)','79','16',0,NULL),(33805025,'MASTERON 100  (DROSTANOLONA PROPIONATO)','79','3',0,NULL),(33805027,'PRIMOBOLAN 100MG X 10ML','26','11',0,NULL),(33805029,'AQCUA-WINN 100MG X 10ML (STANO EN AGUA)','26','11',0,NULL),(33805031,'WINSTROL 100MG X 10ML (STANOZOLOL)','26','11',0,NULL),(33805033,'AQCUAVIRON 100MG X 10ML (TESTO EN AGUA )','26','11',0,NULL),(33805035,'ANABOL ORAL 5OTABS X 25MG (DIANABOL)','80','1',0,NULL),(33805037,'LEBIDO 200MG X 10ML (TESTO UNDECANOATO)','4','6',0,NULL),(33805039,'ANAVAR ORAL 50TABSX 25MG   (OXANDROLONA)','26','11',0,NULL),(33805041,'ANADROL  50MG X 30TABS (OXIMETALONA)','86','6',0,NULL),(33805042,'WINSTROL ORAL 50 TABSX25MG (STANOZOLOL)','26','11',0,NULL),(33805043,'ARIMIDEX 1MG 30 TABS   POS-CICLO TAXUS','26','11',0,NULL),(33805045,'SUPERDROL 10MG X 100TABS (METHASTERONE)','26','11',0,NULL),(33805046,'SARMS LIGANDROL 25MG/30TABS','18','15',0,NULL),(33805047,'SARMS OSTARINE 25MG/30TABS','26','11',0,NULL),(33805048,'SPIROPENT CLEMBUTEROL .04MG  50 TABS','26','11',0,NULL),(33805049,'ANABOL 50MG X 10ML','26','11',0,NULL),(33805050,'TESTEX 400MG ROTTER','26','11',0,NULL),(33805051,'IBUTAMOREN 25 MG 50 TABS','26','11',0,NULL),(33820002,'BIOPHARMA LIVER PROTEC 10AMP 5ML','28','11',0,NULL),(33820003,'PRENGNYL GONADOTROPIN 10,000 IU VIAL','28','11',0,NULL),(33830001,'SOMATROPE 50 UI 5ML VIAL GERMAN','185','11',0,NULL),(33900005,'COCTEL MIX REDUCTOR+CLA 5ML   MESO F','30','11',0,NULL),(33900007,'BLISTER COCTEL MIX REDUCTOR + CLA','30','13',0,NULL),(33900008,'GLUTEOFIRM AMP 5ML','1','54',0,NULL),(33900009,'GLUTEOMAX 5ML MESO F','30','13',0,NULL),(33900010,'TRIAC 100 AMP 5ML','30','13',0,NULL),(33900012,'GLUTEOMAX BLISTER 10 AMP 5ML','30','13',0,NULL),(33900013,'1/2 CAJA MESOFRANCE 50 AMP (VARIOS)','30','0',0,NULL),(33900015,'GLUTEOFIRM BLISTER 10 AMP DE 5ML','18','15',0,NULL),(33900016,'TRIAC I BLISTER 10 AMP DE 5ML','30','13',0,NULL),(33900017,'COCTEL SUPER REDUCTIVO INT BLISTER','30','13',0,NULL),(33900021,'COCTEL SUPER REDUCTIVO INT 5ML','30','13',0,NULL),(33900022,'SILICIO ORGANICO 0.5%  AMP DE 5ML','30','13',0,NULL),(33900025,'BLISTE MF SILICIO ORGANICO .5% 10AMP/5ML','30','13',0,NULL),(33900027,'BLISTER LIPOENZIMAS 10 AMPOLLETAS MESO','30','11',0,NULL),(33900028,'BLISTER GLUTEOLIFT+PEPTONAS 10 AMOP','18','15',0,NULL),(33900101,'CAJA MESOFRANCE 100AMP GLUTEOMAX','30','13',0,NULL),(33900105,'CAJA MESOFRANCE 100 AMP COCTEL RED INTE','30','11',0,NULL),(33900106,'CAJA MESOTERAPIA 100AMP COCTEL REDUC+CLA','30','11',0,NULL),(33900108,'BLISTER LIPOESCULTOR 10AMP/5ML  MESOF','30','0',0,NULL),(33900109,'GLUTEO PEPTONAS 90CAPS','30','11',0,NULL),(66010003,'L-CARNITINA  BETAN 2PZASX$290','32','10',0,NULL),(66025032,'CANGURERA CON PORTA TERMO 43SUP','35','7',0,NULL),(66025055,'43 RIPPED WHEY 6.17LB    43 SUP','35','2',0,NULL),(66025150,'43 FAJA DE CARGA NYLON NEGRA','35','7',0,NULL),(66025151,'43 FAJA REDUCTIVA         VARIOS COLORES','35','7',0,NULL),(66025401,'43 HARD MASS GAINER 15 LB COSTAL','2','51',0,NULL),(66025402,'43 HARD MASS GAINER 2KG','35','2',0,NULL),(66025655,'43 ZERO PROTEIN 6KG','35','2',0,NULL),(66025800,'43 HIDRO ZERO 6.17 LB BOTE','35','2',0,NULL),(66025801,'43 PROTEIN 10K 264 SERV','35','2',0,NULL),(66025850,'THERMO BURNER 50SERV','35','6',0,NULL),(66026150,'ABE PWO PUMP 40 SERV','191','1',0,NULL),(66040906,'WHEY GOLD 5 LBS ALLMAX','40','2',0,NULL),(66050700,'OMEGA 3 180 CAPS','40','3',0,NULL),(66070050,'A LION SUPER HUMAN SUPREME 21 SERV','41','1',0,NULL),(66085650,'AN ABE SHOT PRE-WORK 60ML','43','1',0,NULL),(66090998,'KETO BROWNIE 16 SERV','44','10',0,NULL),(66090999,'A&S BETAINE 40 SERV UNFLAVORADE','187','0',0,NULL),(66100900,'BATLLE SHAKERS 20 OZ VARIOS MODELOS','47','9',0,NULL),(66110900,'SHAKER BEAST 700ML','48','9',0,NULL),(66130153,'RIPPED JUICE POWDER 30 SERV','49','6',0,NULL),(66130500,'L-CARNITINA 3000 MG 16OZ BETANCOURT','49','8',0,NULL),(66130502,'L-CARNITINA 16OZ 5PZ X $650 BETANCOURT','49','6',0,NULL),(66130651,'S.W.E.T. DIURETIC +BURN 30SERV','49','6',0,NULL),(66130655,'B-NOX RELOADED 20 SERV','71','14',0,NULL),(66150040,'PSYCHOTIC 15 SERV 3PZ X $490.','18','15',0,NULL),(66150042,'BCAA 6000 NUTREX 30SERV 2 X $350','18','5',0,NULL),(66150044,'CREATINA SAN PROMO BUEN FIN','18','15',0,NULL),(66150046,'WHEY 1KG LUXOR + BCAA 6000 30SERV $430','18','15',0,NULL),(66150048,'EXTASIS 40SERV + BCAA 6000 30SER  $390','18','15',0,NULL),(66150050,'LUXOR WHEY 1KG + CREAT 120 CAPS SAN $300','18','15',0,NULL),(66150052,'WHEY 1KG +EXTASIS 40SERV +BCAA 6000 $650','18','15',0,NULL),(66150060,'CARE TAKER BCAA 2PZ X $490','18','15',0,NULL),(66150065,'SHAKER DE ULTIMATE NUT 2PZ  X $120.','18','15',0,NULL),(66150100,'CREATINA 41 SERV       PRO TGT','18','14',0,NULL),(66150101,'SHAKERS MUTAN 5PZAS X$440','18','9',0,NULL),(66150102,'WHEY LUXOR 1K + SHAKER ULTIMATE $310','18','15',0,NULL),(66150103,'PROMO MUTANT WHEY 5PZ X $3400.','117','15',0,NULL),(66150104,'EXTASIS + SHAKER ULTIMATE $270','18','15',0,NULL),(66150105,'PROMO 4PZ SHAKER GRENADE $600','18','15',0,NULL),(66150106,'SHAKER SENCILLO VARIOS MODELOS','18','9',0,NULL),(66150107,'TRIBULUS GAT 90 CAPS 4PZ X $500','18','15',0,NULL),(66150120,'VITRIX 30 CAPS 2PZ X $390      NUTREX','18','15',0,NULL),(66150125,'LIPOCIDE IR 30SER + BCAA DRIVE   $360','18','5',0,NULL),(66150130,'TROPHIX 5LB VARIOS SABORES','18','15',0,NULL),(66150135,'SUPREMACY 5LB + CREAT 1KG + GLUTAM $1090','179','15',0,NULL),(66150150,'PROMO ONE RAW 4PZAS X $600','56','2',0,NULL),(66150250,'EXTASIS 40SER + TRIBULUS GAT 90CAP $320','18','15',0,NULL),(66150300,'COLLASTIGEN SOBRE GLAMOUR','18','8',0,NULL),(66150400,'EXTASIS 40SER + AGMATINE GAT 100SER $350','18','15',0,NULL),(66150420,'XENADRINE 7X 60CAPS 2PZ X $250','18','15',0,NULL),(66150450,'LIPO 6 CLEANCE & DETOX 2PZ X $320','18','15',0,NULL),(66150500,'CREATINA 41 SERV 2PZ X $140    PRO TGT','18','15',0,NULL),(66150501,'WAKE THE DEAD 2PZ X $290','18','15',0,NULL),(66150800,'WHEY LUXOR 2.5KG + BCAA DRIVE $520','18','15',0,NULL),(66150820,'WHEY LUXOR 1K + BCAA DRIVE $300','18','15',0,NULL),(66150825,'ALLMAX WHEY GOLD + EXATSIS $890','18','15',0,NULL),(66150830,'CAFFEINA DE INSANE 2PZ X $260','93','1',0,NULL),(66155250,'CREATINA 450GR    BIRDMAN','53','14',0,NULL),(66160005,'PRE-ENTRENO SHOCK 80 SERV','89','6',0,NULL),(66160006,'PRE ENTRENO SHOCK C/CLEMBU 80 SERV','54','1',0,NULL),(66160009,'PRE-ENT SHOCK + CLEMBU + OXA 80SERV','54','1',0,NULL),(66170050,'WHEY-HD 4.2LB   BPI','55','2',0,NULL),(66170101,'BEST AMINOS 25 SERV BPI','55','5',0,NULL),(66170150,'BETTER BEST BCAA 30 SERV BPI','55','5',0,NULL),(66170157,'BEST BCAA ENERGY 25 SERV HOT SALE','55','5',0,NULL),(66170158,'BEST BCAA SHREDDED 25 SERV   BPI','55','5',0,NULL),(66170300,'CLA + CARNITINE  50 SERV','55','15',0,NULL),(66170650,'1 M.R.  ONE MORE REP  25 SERV','55','1',0,NULL),(66170651,'VORTEX  50 SERV   BPI','55','1',0,NULL),(66170750,'CLA+CARNITINA SHREDDED 50 SERV   BPI','55','6',0,NULL),(66190100,'AMINO X 30 SERV  BSN','56','5',0,NULL),(66190101,'AMINO X 70 SERV','56','5',0,NULL),(66190250,'CREATINA POWDER 300GR BSN','139','2',0,NULL),(66190400,'TRUE MASS 5.75 LB','56','2',0,NULL),(66190405,'TRUE MASS 10LB','56','2',0,NULL),(66190650,'NO-X-PLODE 30','56','1',0,NULL),(66190653,'CELL MASS 1.06LB','56','1',0,NULL),(66190928,'SYNTHA-6  2.91LB','56','2',0,NULL),(66190930,'SYNTHA-6  5 LBS','26','11',0,NULL),(66190933,'SYNTHA 6 ISOLATE 4LB','56','2',0,NULL),(66200050,'BUCKSHOTS PRE WORK 2 OZ','133','1',0,NULL),(66210050,'C-4 SMART ENERGY 16 OZ BLACK CHERRY','57','1',0,NULL),(66210651,'C-4 ORIG 60 SERV','57','1',0,NULL),(66210654,'C-4 ENERGY SHOT 1 TOMA CELLU','58','1',0,NULL),(66210656,'C-4 ULTIMATE 40 SERV','58','1',0,NULL),(66210658,'C-4 ENERGY NON CARBONATED ZERO 12OZ','58','10',0,NULL),(66210659,'C-4 ORIG 50 SERV','57','1',0,NULL),(66230871,'SHAKER CICLONE CORE','60','9',0,NULL),(66250901,'BLACK SPIDER-25  100 CAPS','61','6',0,NULL),(66250903,'METHILDRENE 100 CAPS','61','6',0,NULL),(66250906,'METHILDRENE ELITE  100 CAPS','61','6',0,NULL),(66250909,'CHINA WHITE 100CAPS','61','6',0,NULL),(66270650,'THE CURSE  50 SERV','62','1',0,NULL),(66270900,'COBRA  RIPPER  150GR   TERMO','62','6',0,NULL),(66290970,'SHAKER CUTLER 500ML','63','9',0,NULL),(66330650,'CITRULINA SCIMITAR 30 SERV','65','16',0,NULL),(66330655,'CREATINA MONOHYDRATE 300G DRAGON','66','14',0,NULL),(66340250,'DRAGON BLACK VIPER 30 CAPS','66','1',0,NULL),(66340650,'VENOM 40 SERV   DRAGON PHARMA','66','1',0,NULL),(66340652,'VENOM INFERNO 40 SERV','66','1',0,NULL),(66340653,'HYDRA HIGH POTENCY NATURAL ANABOLIC 120C','66','0',0,NULL),(66340654,'DRAGON WHEY PHORM 5LB','66','2',0,NULL),(66340900,'ISO PHORM 5LB','66','2',0,NULL),(66350050,'ELITE 100 % WHEY  DYMATIZE  5LB','67','2',0,NULL),(66350400,'SUPER MASS GAINER  12 LBS','67','2',0,NULL),(66350930,'ISO-100  5LB  DYMATIZE','67','2',0,NULL),(66355905,'WOMENS THERMOGENIC 1KG HOTSALE','15','11',0,NULL),(66355955,'WOMENS VITAMINS 1KG HOTSALE','69','3',0,NULL),(66360100,'AMINOJECT  30 SERV','71','5',0,NULL),(66360150,'AMINO K.E.M. 150 TAB','71','5',0,NULL),(66360650,'EVP  EXTREME 40 SERV      OXIDO  EVOGEN','71','1',0,NULL),(66360653,'EVP-X 40 SERV','71','1',0,NULL),(66360655,'EVP  3D 40SERV       EVOGEN','71','1',0,NULL),(66360840,'CREATINA MONOHYDRATRE 300G EVOGEN','71','14',0,NULL),(66360900,'LIPOCIDE IR 30 SERV','71','6',0,NULL),(66360910,'SUPER DRY 45 CAPS   EVOGEN','123','6',0,NULL),(66360950,'EVOVITE POWDER 30 SERV','71','3',0,NULL),(66360952,'CELL K.E.M 30 SERV EVOGEN','71','14',0,NULL),(66361250,'GT CLAAS PROTEIN 1K 33SERV','72','6',0,NULL),(66365101,'PURE BCAA 2:1:1 C/VIT C 30 SERV PONCHE','75','5',0,NULL),(66365105,'PURE BCAA 2:1:1 POWDER 80 SERV UNFLAVO','75','5',0,NULL),(66365151,'PRE HYDR8 90 CAPS FINAFLEX','35','7',0,NULL),(66365665,'STIMUL 8 35 SERV','75','1',0,NULL),(66365900,'XANTHINE 60 CAPS    TERMO    FINAFLEX','75','6',0,NULL),(66373900,'BLACK ANGEL 473 ML      FORZA','124','10',0,NULL),(66375650,'MANIAC  40 SERV','77','1',0,NULL),(66377800,'TRIBULUS GALLO 120 CAPS','180','4',0,NULL),(66377801,'OXIDO NITRICO PRE 30 SERV','179','1',0,NULL),(66390060,'WHEY MATRIX  4. 5LB         GAT','33','10',0,NULL),(66390250,'CREATINA DE  1K  GAT','79','14',0,NULL),(66390500,'L-CARNITINA  LIQ  16OZ    GAT','79','6',0,NULL),(66390501,'L-CARNITINA  60  CAPS  GAT','79','6',0,NULL),(66390600,'MULTI-TEST   60 CAPS  GAT','79','4',0,NULL),(66390651,'NITRAFLEX 30SERV  GAT','79','1',0,NULL),(66390653,'CLA 1250  90 CAPS GAT','79','6',0,NULL),(66390654,'AGMATINE SULFATE POWER 100SERV','79','16',0,NULL),(66390655,'LIBIDO BOOST 30 SERV POWER','79','4',0,NULL),(66390658,'NITRAFLEX ADVANCE 15 SERV','79','1',0,NULL),(66390659,'NITRAFLEX PUMP 40 SERV','127','14',0,NULL),(66390750,'TESTROL  60 TABS   GAT','79','4',0,NULL),(66390751,'TRIBULUS DE GAT 90 CAPS','56','2',0,NULL),(66390752,'TESTROL   GOLD  60  TABS','79','4',0,NULL),(66390753,'TESTROL ELITE 30 SERV','79','4',0,NULL),(66390754,'TESTROL PROSTATE 90 CAPS','79','4',0,NULL),(66390755,'ZMAG-T  90 CAPS       GAT','79','8',0,NULL),(66390757,'OMEGA-3 90CAPS      GAT','79','3',0,NULL),(66390840,'CARBOTEIN  42 SERV   GAT','17','11',0,NULL),(66390842,'JETMASS  30 SERV    GAT','79','2',0,NULL),(66390980,'L-ARGININE  180 TABS      GAT','79','16',0,NULL),(66390990,'LIVER CLEANSE 60 CAPS','79','8',0,NULL),(66390991,'CAFFEINE 200MG  100 TABS  GAT','79','8',0,NULL),(66390992,'BETA-ALANINA GAT100 SERVICIOS','79','16',0,NULL),(66390995,'INMUNOLOGY DAILY DEFENSE 60 CAPS HOTSALE','79','11',0,NULL),(66400000,'GHOST PUMP OXIDO NITRICO 40 SERV','65','XXXXXX',0,NULL),(66400004,'GHOST LEGEND PWO 30 SERV','80','1',0,NULL),(66400006,'CEREAL GHOST 266G (7 SERV APROX)','80','2',0,NULL),(66400007,'GHOST 500ML ELECTROLITES BEBIDA','80','8',0,NULL),(66405900,'REDUTAX 30 CAPS HOT SALE $100','82','15',0,NULL),(66408050,'GORILLA COOKIE 12 COOKIES CAJA','83','10',0,NULL),(66410980,'SHAKER  GRENADE 16 OZ','84','9',0,NULL),(66417655,'LIPO SKULL 30 SERV       HALLOWEEN LABZ','86','6',0,NULL),(66420901,'NEUROTIC INTENSITY 30 SERV','87','1',0,NULL),(66420902,'NEUROTIC TEST HIGH INTENSITY 30 SERV','87','1',0,NULL),(66421000,'BLEND PROTEIN 4 LBS 50 SERV','88','2',0,NULL),(66421001,'ISO ZERO 5 LBS 70 SERV','124','14',0,NULL),(66421400,'MASS GAINER 10LB','88','2',0,NULL),(66430250,'CREATINE MONOHYDRATE 80SERV    HI-TECH','89','14',0,NULL),(66430651,'TAURINA 750 MG 120 CAPS','89','16',0,NULL),(66430900,'BLACK WIDOW  90 CAPS','89','6',0,NULL),(66430901,'LIPODRENE XTREME 90 TABS','89','6',0,NULL),(66430903,'LIPODRENE HARD CORRE 90 CAPS','89','6',0,NULL),(66430904,'LIPODRENE  100 CAPS','89','6',0,NULL),(66430905,'LIPODRENE  ELITE  HC  90C','89','6',0,NULL),(66430906,'ZINC 100 TABS','18','15',0,NULL),(66430908,'STIMEREX-ES  90 CAPS','89','0',0,NULL),(66430912,'RED PALM OIL 90 CAPS','89','6',0,NULL),(66430913,'NAC N-ACETYL CYSTEINE 100 CAPS','89','3',0,NULL),(66430970,'LIVER RX   90 TAB','89','0',0,NULL),(66440004,'BANDAS ELASTICAS (5PZAS)','90','7',0,NULL),(66440005,'SET LIGAS RESISTENCIA C/ARNES (5PZA)','90','7',0,NULL),(66460900,'BLACK MAMBA  90 CAPS','92','6',0,NULL),(66470050,'INSANE WHEY 4LB BOLSA','93','2',0,NULL),(66470055,'INSANE WHEY RIPPED 4.5LB','93','2',0,NULL),(66470250,'HELLBOY AMINO 30 SERV   INS','93','5',0,NULL),(66470253,'CREATINE 60 SERV INSANE','93','14',0,NULL),(66470255,'BETA-ALANINA 30 SERV','93','16',0,NULL),(66470300,'HMB 120 CAPS','93','8',0,NULL),(66470450,'GLUTAMINE 60SERV   INSANE','93','16',0,NULL),(66470550,'CAFFEINE 120 CAPS   INSANE','93','8',0,NULL),(66470645,'PSYCHOTIC 30 STICKS VARIETY BAG  ROJO','93','1',0,NULL),(66470646,'PSYCHOTIC SAW SERIES 30 SERV','127','5',0,NULL),(66470647,'SAW FAT BURNER 60 CAPS INSAN','93','1',0,NULL),(66470650,'PSYCHOTIC GOLD 30 STICKS VARIETY BAG','61','6',0,NULL),(66470651,'PSYCHOTIC  35 SERV','93','1',0,NULL),(66470652,'PSYCHOTIC  GOLD 35 SERV','93','1',0,NULL),(66470653,'PSYCHOTIC HELLBOY 35 SERV','93','1',0,NULL),(66470655,'PSYCHOTIC BLACK 35 SERV','93','1',0,NULL),(66470656,'PSYCHOTIC GOLD 15 SERV','186','2',0,NULL),(66470658,'PSYCHOTIC 60 SERV','93','1',0,NULL),(66470660,'INSANE VEINZ 35 SERV','93','1',0,NULL),(66470662,'BLOOD BATH NON PRO 40SERV   SAW SERIES','127','1',0,NULL),(66470666,'DEMON BCAA 60 SERV INSANE','93','5',0,NULL),(66470668,'PSYCHOTIC GOLD 60 SERV','93','1',0,NULL),(66470750,'PSYCHOTIC TEST 30 SERV','93','1',0,NULL),(66470751,'TRIBULUS 90 CAPS      INSANE','93','4',0,NULL),(66470840,'PSYCHOTIC 15 SERV','93','1',0,NULL),(66470841,'PSYCHOTIC SAM 30 SERV','93','1',0,NULL),(66470870,'SHAKER INSANE 33 OZ (1L)','93','9',0,NULL),(66470874,'VITAMINA C 120 CAPS','93','3',0,NULL),(66470899,'INSANE CUTZ 35 SERV','93','6',0,NULL),(66470900,'INSANE CUTS  45 CAPS','93','6',0,NULL),(66470901,'PSYCHOTIC DIABLO 60 CAPS','93','6',0,NULL),(66470905,'WAKE THE DEAD','67','2',0,NULL),(66470906,'L-CITRULLINE 60 SERV   INSANE','93','16',0,NULL),(66470907,'YOHIMBE HCL 2.5 MG 120CAPS  INSANE','93','8',0,NULL),(66470908,'D-ASPARTIC ACID 30 SERV','93','16',0,NULL),(66470930,'INSANE ISO 4.3 LB','88','2',0,NULL),(66480150,'BRUTE  BCAA  450GR   KILLER LABS','94','5',0,NULL),(66480151,'BRUTE NRG ANABOLIC ENERGY BCAA 30SERV','94','5',0,NULL),(66480152,'BRUTE EAA 60 SERV','94','0',0,NULL),(66480750,'TERMINATOR TEST 90 CAPS','94','4',0,NULL),(66480900,'EXTERMINATOR   60 CAPS   KILLER LAB','94','6',0,NULL),(66490102,'GLUTALEAN 500GR','96','16',0,NULL),(66490970,'ELASTI-JOINT  350G','96','16',0,NULL),(66490980,'PRE-ELLA 30 SERV','98','1',0,NULL),(66490982,'SEXY FIT PROTEIN 3LB','98','2',0,NULL),(66490983,'BCAA COMPLEX 30 SERV   LIMITIX','98','5',0,NULL),(66490984,'SEXY BCAA 30 SERV','98','5',0,NULL),(66491002,'DIP´D WAFER BAR VARIOS SABORES','124','6',0,NULL),(66491005,'THE COMPLETE COOKIE','99','0',0,NULL),(66496050,'100%WHEY 1KG LUXOR','100','2',0,NULL),(66496055,'100% WHEY 2.5KG LUXOR PROTEINA','100','2',0,NULL),(66496120,'CREATINA 1KG SIN SABOR      LUXOR','100','14',0,NULL),(66496122,'CREATINA 1KG SABOR FRUTOS ROJOS  LUXOR','100','14',0,NULL),(66497650,'EXTASIS 40/80 SERV  PRE-WORK   LUXOR SP','100','1',0,NULL),(66499900,'MACHETE 10 TABS    RENDIMIENTO SEXUAL','103','4',0,NULL),(66499905,'PROTEIN 5LB            MAMMOTH','186','2',0,NULL),(66499906,'MAMMOTH MASS 5LB','186','2',0,NULL),(66500050,'100% WHEY  MAD LABZ  5LB','104','2',0,NULL),(66510401,'SHAKER MAXLER    500ML','105','9',0,NULL),(66530250,'CREATINA  METANUTRITION  500GR','18','15',0,NULL),(66530800,'META VEGAN  5 LB  METANUTRITION','106','2',0,NULL),(66530820,'OMEGA 90 CAPS META','106','8',0,NULL),(66530910,'FULL CARB 4.4LB      METANUT','91','2',0,NULL),(66560902,'SUPER FAT BURNER 60 SERV   MHP','108','6',0,NULL),(66570501,'PULSERA ARNORLD  MP','110','7',0,NULL),(66570980,'Z-PM  60 CAPS   RECUPERADOR','110','8',0,NULL),(66590420,'CARNIVOR MASS  6 LBS','112','2',0,NULL),(66590820,'CARNIVOR CERO  NUEVA PRESENTACION 4 LBS','112','2',0,NULL),(66590900,'SHAKER CARNIVOR 700ML','112','9',0,NULL),(66610048,'GRASS FED 100% WHEY PROTEIN 1.8LB','33','2',0,NULL),(66610050,'NITROTECH 4LB WHEY PROTEIN  MUSCLE TECH','114','2',0,NULL),(66610051,'GRASS FED 4.57 LB 100% WHEY PROTEIN','33','2',0,NULL),(66610052,'NITROTECH WHEY GOLD  5 LB','33','2',0,NULL),(66610054,'NITROTECH WHEY GOLD 8LB','33','2',0,NULL),(66610105,'PLATINUM AMINO 2500    946ML','33','5',0,NULL),(66610248,'CELL TECH ELITE 20 SERV SOLIDIFICADO','33','14',0,NULL),(66610249,'CELL TECH 3LB','33','14',0,NULL),(66610250,'CELL TECH  6 LB','33','14',0,NULL),(66610251,'CREATINA  PLATINUM   400GR  MUSCTECH','33','14',0,NULL),(66610254,'CREATOR (120 SERV)  DE SABOR','33','14',0,NULL),(66610300,'PLATINUM PURE CLA  MT 90 CAPS','33','6',0,NULL),(66610400,'MASS TECH  7 LBS','33','2',0,NULL),(66610401,'MASS TECH  20LB','33','2',0,NULL),(66610406,'MASS TECH 12LB','40','10',0,NULL),(66610600,'PLATINUM  MULTIVIT  90 CAPS','33','3',0,NULL),(66610652,'SIX STAR CLA 90 CAPS','151','6',0,NULL),(66610653,'VAPOR X5  30 SERV   PRE-WORK','114','2',0,NULL),(66610803,'NITROTECH RIPPED 4 LB','33','2',0,NULL),(66610900,'HYDROXICUT ELITE  100 CAPS','33','6',0,NULL),(66620055,'FIT PROTEIN 5LB     MUSCLE FIT','33','2',0,NULL),(66620902,'ESPONJA PARA BARRA','113','7',0,NULL),(66620905,'MALETA/MOCHILA 2 EN 1','113','7',0,NULL),(66625980,'COLAGENO 30 SERV PASTEL ARCOIRIS','115','8',0,NULL),(66630970,'BIKINI BRONZE  7 OZ','114','16',0,NULL),(66630971,'PROTAN  OVERNIGTH COMPETITION 8OZ','114','7',0,NULL),(66630990,'MUSCLE SANDWICH  MANI BAR','114','10',0,NULL),(66630991,'MUSCLE SANDWICH VANILLA  BAR','114','10',0,NULL),(66640800,'MYO-VECTOR FEMME  3LB','116','2',0,NULL),(66650050,'100% WHEY MUTANT 5LB','117','2',0,NULL),(66650055,'CAFFEINA MUTAN 240 SERV','117','8',0,NULL),(66650250,'CREATINA CREAKONG  300G 75SERV','117','14',0,NULL),(66650252,'CREAKONG CX8  249GR','117','14',0,NULL),(66650400,'MUTANT MASS  15 LBS','117','2',0,NULL),(66650401,'MUTANT MASS EXTREME 6LB','117','2',0,NULL),(66650450,'GLUTAMINA  300GR  / 60 SERV MUTANT','117','16',0,NULL),(66650500,'L-CARNITINA  90 CAPS  MUTANT','117','6',0,NULL),(66650605,'MULTIVITAMINICO 60 CAPS MUTANT','117','3',0,NULL),(66650650,'MADNESS  30 SERV  OXIDO NIT','117','1',0,NULL),(66650651,'MUTANT TEST 90 CAPS','117','4',0,NULL),(66650850,'CREAKONG 1K 250 SERV  MUTANT','117','14',0,NULL),(66650870,'SHAKER  MUTANT  34 OZ','117','9',0,NULL),(66650871,'VASO STADIUM 32 OZ     MUTANT','117','9',0,NULL),(66650872,'SHAKER MUTANT 600ML  TRANSPARENTE','117','9',0,NULL),(66680050,'CITRATO DE MAGNESIO CAPS','119','16',0,NULL),(66680054,'OMEGA 3 60 CAPS','119','3',0,NULL),(66680056,'LEVADURA DE CERVEZA 100 TABS','179','8',0,NULL),(66680057,'COLAGENO HIDRO 120 TABS','93','10',0,NULL),(66680100,'CARTILAGO DE TIBURON  50 CAPS','119','0',0,NULL),(66680110,'ASHWAGANDHA 90 CAPS','18','15',0,NULL),(66680140,'OMEGA 3,6 9 60 CAPS','119','3',0,NULL),(66680150,'VITAMINA E 100 30 CAPS','119','3',0,NULL),(66680160,'CETONAS DE FRAMBUESA 60 CAPS','119','8',0,NULL),(66680170,'CARBON ACTIVADO 90 CAPS','119','8',0,NULL),(66680180,'RESVERATROL 30 CAPS','119','0',0,NULL),(66680200,'VITAMINA A RETINOL 650 MG 60 CAPS','119','3',0,NULL),(66690930,'ISOPURE ZERO  Y  LOW CARBS 3LB','120','2',0,NULL),(66695950,'SPORT FLEX 30 SERV     NST    COLAGENO','121','8',0,NULL),(66700300,'NUCLEAR RIPPED CLA + CARNITINA 30 SERV','33','2',0,NULL),(66710900,'PHANTOM  90 CAPS','123','0',0,NULL),(66710901,'PHANTOM   XS 120 CAPS','123','6',0,NULL),(66710903,'SXR 8 MAX  60SERV       NUBRED','66','1',0,NULL),(66730150,'BCAA DRIVE  200 TABS 40 SERV','179','7',0,NULL),(66730155,'BCAA 6000 30 SERV  WARRIOR SERIES','124','5',0,NULL),(66730250,'CREATINA DRIVE 1 KG  NUTREX','79','14',0,NULL),(66730255,'CREATINA DRIVE 300GR  NUTREX','124','14',0,NULL),(66730300,'CLA LIPO 6  90 CAPS','124','6',0,NULL),(66730302,'LIPO 6 BASIX 120 CAPS','30','11',0,NULL),(66730500,'L-CARNITINA  3000  NUTREX','124','6',0,NULL),(66730653,'HEMO-RAGE UNLEASHED  30 SERV  NUTREX','89','16',0,NULL),(66730751,'T-UP BLACK TESTOSTERONE 120 CAPS','124','4',0,NULL),(66730755,'VITRIX 80 CT  PRECURSOR  TESTO','124','6',0,NULL),(66730800,'MUSCLE IN FUSION 5LB','124','2',0,NULL),(66730801,'LIPO 6 CHROMIUM','124','6',0,NULL),(66730810,'HMB BLACK 1000 120CAPS','124','8',0,NULL),(66730890,'LIPO 6 BLACK TRAINING 30 SERV','124','1',0,NULL),(66730900,'LIPO 6 BLACK ULTRA CONCENTRADO 60CAP','124','6',0,NULL),(66730901,'LIPO 6 BLACK HERS ULTRA CONCENTRADO 60CA','124','6',0,NULL),(66730908,'LIPO 6 BLACK THYROLEAN 60 CAPS','124','6',0,NULL),(66730909,'LIPO 6 BLACK CLEANCE & DETOX 60 CAPS','124','6',0,NULL),(66730920,'ISOFIT 5LB  NUTREX','124','2',0,NULL),(66730921,'NIOX OXIDE NITRIC 90 CAPS','124','1',0,NULL),(66730950,'FAJA REDUCTORA NEOPRENO UNITALLA','179','7',0,NULL),(66730970,'LIPO 6 BLACK NIGHT TIME ULTRA 60CAPS','124','6',0,NULL),(66730980,'WARRIOR 100% WHEY 5LB 61 SERV','30','11',0,NULL),(66760005,'H2OBVI BEBIDA 250ML','126','10',0,NULL),(66760840,'COLLAGENIC BURN POWDER','126','8',0,NULL),(66770050,'100% WHEY GOLD STANDART  5LB','127','2',0,NULL),(66770057,'GOLD STD ISOLATE 5LB   ON','56','XXXXXX',0,NULL),(66770058,'HYDRO WHEY 3.5LB    ON','88','2',0,NULL),(66770060,'100% WHEY GOLD STANDAR 1LB','127','2',0,NULL),(66770100,'AMINO ENERGY 30 SERV','18','15',0,NULL),(66770102,'AMINO ENERGY 65 SERV   ON','127','5',0,NULL),(66770200,'CASEIN GOLD STD 4LB   ON','61','6',0,NULL),(66770250,'CREATINA POWDER  600GR ON','127','14',0,NULL),(66770401,'SERIOUS MASS 6 LBS','127','2',0,NULL),(66770405,'PRE-WORKOUT 30 SERV','127','1',0,NULL),(66770600,'OPTI MEN MULTIVITAMI  150 CAPS','127','3',0,NULL),(66770650,'BCAA 1000mg  60 CAPS  ON','127','5',0,NULL),(66771400,'PANDA PANDAMIC EXTREME PWO 25 SERV','189','1',0,NULL),(66775790,'BOODY FIT 25MG 100TABS','193','11',0,NULL),(66775800,'BOOTY WOMAN 25MG 100TABS','165','11',0,NULL),(66776980,'PERFECT SHAKER (VARIOS MODELOS)','130','9',0,NULL),(66778040,'ABCUTS CLA GUMMIES 60PZ  PERFORMIX','132','6',0,NULL),(66778150,'BUCKSHOTS PRE WORK 2 OZ','190','1',0,NULL),(66778310,'SST SUPPORT CLENCE 60 CAPS','132','8',0,NULL),(66779900,'THINK PROTEIN BAR CUPCAKE','133','10',0,NULL),(66779905,'CAJA THINK PROTEIN 10PZ','133','10',0,NULL),(66788050,'WHEY PROSUPPS 4LB','7','2',0,NULL),(66788980,'KILL IT 12OZ PRE-WORK  RICH PIANA BEBIDA','7','1',0,NULL),(66790050,'100%WHEY PURO CAMMPEON 5LB','139','2',0,NULL),(66790650,'NITRATEST 30SERV','139','1',0,NULL),(66790820,'CARNIVORO  4LB  PURO CAMPEON','139','2',0,NULL),(66790930,'ISO-ZERO  5LB  PURO CAMPEON','139','2',0,NULL),(66790970,'ELASTIPURE  350G','139','16',0,NULL),(66792650,'CONDENSE 40 SERV     PRE WORK','140','1',0,NULL),(66792655,'D-POL POWDER 30 SERV PRE-WORK','140','1',0,NULL),(66795450,'GLUTAMINA 60 SERV REDCON1','9','16',0,NULL),(66795600,'THAVAGE PWO 40 SERV','141','1',0,NULL),(66795601,'THAVAGE PWO 40SERV  GREEN CRUNCH OFERTA','141','1',0,NULL),(66795602,'THAVAGE THUPER 20 SERV','141','1',0,NULL),(66795650,'CBUM ISO PROTEIN 1.7 LB 25 SERV','89','6',0,NULL),(66795651,'CBUM ITHOLATE 5 LBS','141','2',0,NULL),(66795652,'CBUM WHEY PROTEIN 5LB','141','2',0,NULL),(66795900,'WAR GAMES 30 SERV  PRE WORK','9','1',0,NULL),(66795905,'CLUSTER BOMB 30 SERV','49','5',0,NULL),(66810052,'RED LINE BLAZE 8LB','143','2',0,NULL),(66810900,'GANADOR DINOSAUR BLAST 6.8K REDLINE','143','2',0,NULL),(66830050,'100%WHEY XS 5LB RONNI COLL','144','2',0,NULL),(66830150,'AGMATINE 30 SERV    500MG','179','8',0,NULL),(66830151,'AMINO TONE + EAA 30SERV','144','5',0,NULL),(66830250,'CREATINE XS 300grs   RC','144','14',0,NULL),(66830298,'OMEGA 3-XS 120 GELS  RONNI','144','8',0,NULL),(66830400,'KING MASS  15LB','144','2',0,NULL),(66830405,'KING MASS 6LB    RONNI COLLEMAN','144','2',0,NULL),(66830650,'EAA XS 120 CT RONNIE','124','14',0,NULL),(66830651,'TRIBULUS XS 120 CAPS','144','4',0,NULL),(66830652,'PRE XS  30 SERV   RONNIE COL','180','11',0,NULL),(66830750,'KING TEST 90TABS        RONNI COL','144','4',0,NULL),(66830820,'KING WHEY 5LB','144','2',0,NULL),(66830840,'KING CARB  XS  2.22LB','95','2',0,NULL),(66830915,'SLEEP XS 100 CAPS','144','8',0,NULL),(66830980,'L-ARGININA XS 100 CAPS','18','15',0,NULL),(66840801,'RYSE PRE WORK 25 SERV','146','1',0,NULL),(66840803,'RYSE LOADED PRE 30SERV (KOOL AID/VARIOS)','124','2',0,NULL),(66840804,'RYSE ELEMENTS PWO 25 SERV','146','1',0,NULL),(66840805,'RYSE PROTEIN 2LB','146','2',0,NULL),(66840806,'RYSE PUMP STIM-FREE 25 SERV','146','1',0,NULL),(66840808,'RYSE HIGH STIM PRE WORK 30 SERV','146','1',0,NULL),(66850500,'CREATINA  120 CAPS 120 SERV','147','14',0,NULL),(66850750,'SHAKER SAN   600ML','147','9',0,NULL),(66860900,'ABSTEEL  200ML     CREMA REDUCTORA','148','6',0,NULL),(66860901,'CELLULESS  200ML  CREMA  ANTI-CELULITIS','148','6',0,NULL),(66860903,'ABSTEEL 50ML MINI CREMA RED','120','XXXXXX',0,NULL),(66860904,'CELLULESS 50ML MINI ANTI-CELULITIS','148','6',0,NULL),(66861055,'FIT GIRL WHEY PROTEIN ISOLATE 2KG','149','2',0,NULL),(66861200,'STEEL FIT-TONE 237ML REAFIRMANTE','117','10',0,NULL),(66862650,'SUB ZERO 30 SERV','179','1',0,NULL),(66865051,'WHEY PROTEIN HIDRO SAIYAN 5LBS','96','XXXXXX',0,NULL),(66865052,'CREATINA SAIYAN 500GR 100 SERV','153','14',0,NULL),(66865401,'KAIOKEN BLACK 30 SERV','153','1',0,NULL),(66865405,'KAIOKEN BLUE 30 SERV','80','10',0,NULL),(66868650,'KRAKEN 40 SERV','155','0',0,NULL),(66869031,'XTEND BCAAS 30 SERV','156','5',0,NULL),(66890400,'SHAKER SYNTRAX 800ML','160','9',0,NULL),(66890973,'SHAKER AERO SYNTRAX','160','9',0,NULL),(66895150,'WHEY PROTEIN PUNISHER 5LB','161','2',0,NULL),(66895650,'JOKER   30 SERV     TERROR LAB','161','1',0,NULL),(66895900,'MANIAC  30 SERV   50 EPH  TERROR L','161','1',0,NULL),(66900872,'SHAKER  ULTIMATE NUTRITION','163','9',0,NULL),(66910601,'ANIMAL PACK 44 PACKS 8 PHILLS','124','1',0,NULL),(66910605,'ANIMAL PACK POWDER 30 SERV','164','3',0,NULL),(66930041,'CREATINA MONOHYDRATADA 60 SERV USN','166','14',0,NULL),(66930050,'QHUSH 500ML PRE-WORK','166','1',0,NULL),(66930060,'HYDRO 100 5LB  USP','167','2',0,NULL),(66930155,'EAA +    30 SERV               USP','167','15',0,NULL),(66930200,'100% WHEY 4.5LB BLUE LAB','166','2',0,NULL),(66930870,'SHAKER  DE  USP   25OZ','167','9',0,NULL),(66940250,'CREATINA 1KG  VICTORY','169','14',0,NULL),(66940252,'VICTORY SUPREMACY 5 LB HYDROLIZADA','169','2',0,NULL),(66940450,'GLUTAMINA 500GR   VICTORY','169','8',0,NULL),(66965780,'GLUCOFLEX 120 TABS GLUCOSAMINE & CHONDRO','172','3',0,NULL),(66965790,'CITRATO DE MAGNESIO 60 TABS','172','3',0,NULL),(66965800,'CALCIUM, MAGNESIUM, ZINC 100TABS','179','8',0,NULL),(66965900,'REJUVICARE LIQUID COLLAGEN 16OZ','172','8',0,NULL),(66965980,'CHROMIUM PICOLINATE 60CAPS','172','6',0,NULL),(66970900,'XENADRINE 7X 60 CAPS','173','6',0,NULL),(66970901,'XENADRINE NEXT GENEREATION 60CAPS','173','6',0,NULL),(66971050,'ACIDO HIALURONICO 1.100KG 73SERV','175','8',0,NULL),(66971100,'COLAGENO HIDROLIZADO (VARIOS SAB) 73SERV','175','8',0,NULL),(66971150,'REUMOFLEX 1.100KG  73SERV','188','1',0,NULL),(66975050,'ZOMBIE HYDROWHEY TEST 5LB','176','2',0,NULL),(66980150,'WHEY ZOO 3LB','177','2',0,NULL),(66980200,'ISO ZOO 3LB','177','2',0,NULL),(66980550,'ONE RAW CITRULINE D L-MALATE 60SERV','179','16',0,NULL),(66980600,'ONE RAW AAKG 300GR  ARGININA','176','16',0,NULL),(66980650,'CARE TAKER 30SERV','177','5',0,NULL),(99910991,'TOMA DE PROTE MUTANT MASS','75','10',0,NULL),(99910992,'TOMA DE PROTEINA WHEY GOLD STD','127','10',0,NULL),(99910993,'TOMA GRANEL PSYCHOTIC-GOLD,HELLBOY,TEST','93','10',0,NULL),(99910995,'TOMA PROTEINA LUXOR WHEY','100','10',0,NULL),(99910996,'TOMA DE MUTANT PRO WHEY','117','2',0,NULL),(99910997,'TOMA DE PROTEINA 43 WHEY PROTEIN','35','10',0,NULL),(99910998,'TOMA PROTEINA ISOPURE','120','10',0,NULL),(99910999,'TOMA PROTEINA ISO 100','67','10',0,NULL),(99911000,'TOMA PROTEINA MASS TECH 1 SCOOP','127','16',0,NULL),(99911001,'TOPPING EXTRA ARANDANO','119','10',0,NULL),(99911002,'TOPPING EXTRA NUEZ','119','10',0,NULL),(99915005,'BATIDO DE PROTEINA ISO-100','178','10',0,NULL),(99915010,'BATIDO DE PROTE ISOPURE ZERO','178','10',0,NULL),(99915020,'BATIDO DE PROTE 100% WHEY GOLD STD  ON','178','10',0,NULL),(99915037,'BATIDO DE PROTE MASS TECH (1SCOOP)','178','10',0,NULL),(99915039,'BATIDO DE WHEY LUXOR EN PROMO','178','10',0,NULL),(99915041,'BATIDO DE MUTANT MASS','117','10',0,NULL),(99915100,'LECHE DECREMADA EXTRA  ALPURA','178','10',0,NULL),(99915101,'1 SERVICIO GHOST WHEY PROTEIN','80','2',0,NULL),(99915102,'1 SERVICIO ISOFLEX PROTEIN','179','10',0,NULL),(99915103,'1 SERVICIO PLANT PROTEIN GAT SPORT','18','10',0,NULL),(99915104,'1 TOMA GHOST LEYEND PRE','18','1',0,NULL),(99915105,'1 TOMA NITRAFLEX VARIOS GAT','18','10',0,NULL),(99915106,'1 TOMA PSYCHOTIC BAG INSAN','18','0',0,NULL),(99915107,'1 TOMA AMINO CORE ALLMAX','18','5',0,NULL),(99915108,'1 TOMA RED LINE BLAZE','18','10',0,NULL),(99915110,'TOMA STIMUL 8','75','10',0,NULL),(99915111,'1 SERVICIO WHEY PROTEIN NTS','121','2',0,NULL),(99915112,'1 TOMA HEMORAGE RUSH','18','0',0,NULL),(99915113,'1 TOMA EUPHORIQ MUSCLETECH','112','10',0,NULL),(99915114,'1 TOMA NITRAFLEX BLACK','79','10',0,NULL),(99915115,'1 SERVICIO PROTE BIRDMAN','53','10',0,NULL),(99915116,'1 SERVICIO PROTEIN PLANT MUSCLE TECH','189','1',0,NULL),(99915117,'1 SERVICIO CARNIVOR CERO','18','2',0,NULL),(99915119,'1 TOMA ANIMAL FURY','179','10',0,NULL),(99915120,'1 TOMA B-NOX','179','10',0,NULL),(99915121,'1 SERVICIO PROTEINA MRE','179','10',0,NULL),(99915122,'TOMA GRANEL NITRAFLEX VARIOS','18','1',0,NULL),(99915123,'TOMA GRANEL B-NOX RELOADED','18','1',0,NULL),(99915124,'1 TOMA FLEEX EAAS GAT','18','10',0,NULL),(331500223,'METHANDROSTENOLONE 25 MG100TABS','17','11',0,NULL);

INSERT INTO `product_price` VALUES (11080003,1,540),(11080003,2,540),(11080003,3,540),(11080003,4,500),(11120005,1,220),(11120005,2,220),(11120005,3,220),(11120005,4,200),(33100007,1,150),(33100007,2,140),(33100007,3,130),(33100007,4,120),(33100008,1,190),(33100008,2,190),(33100008,3,190),(33100008,4,170),(33300020,1,520),(33300020,2,480),(33300020,3,450),(33300020,4,420),(33200003,1,15),(33200003,2,15),(33200003,3,15),(33200003,4,15),(33200005,1,240),(33200005,2,240),(33200005,3,240),(33200005,4,240),(33200006,1,220),(33200006,2,220),(33200006,3,220),(33200006,4,220),(33200008,1,45),(33200008,2,40),(33200008,3,35),(33200008,4,30),(66070050,1,630),(66070050,2,590),(66070050,3,550),(66070050,4,500),(66090999,1,270),(66090999,2,250),(66090999,3,220),(66090999,4,190),(66110650,1,370),(66110650,2,350),(66110650,3,0),(66110650,4,330),(66130500,1,250),(66130500,2,230),(66130500,3,210),(66130500,4,130),(66150050,1,300),(66150050,2,300),(66150050,3,300),(66150050,4,300),(66150101,1,440),(66150101,2,440),(66150101,3,440),(66150101,4,440),(66150820,1,470),(66150820,2,470),(66150820,3,470),(66150820,4,470),(66150300,1,890),(66150300,2,890),(66150300,3,890),(66150300,4,890),(66150500,1,140),(66150500,2,140),(66150500,3,140),(66150500,4,120),(66150501,1,290),(66150501,2,290),(66150501,3,290),(66150501,4,290),(66150800,1,520),(66150800,2,520),(66150800,3,520),(66150800,4,520),(66190100,1,480),(66190100,2,450),(66190100,3,420),(66190100,4,390),(66190930,1,1140),(66190930,2,1090),(66190930,3,1050),(66190930,4,990),(66250903,1,480),(66250903,2,450),(66250903,3,420),(66250903,4,390),(66270650,1,460),(66270650,2,430),(66270650,3,400),(66270650,4,370),(66350050,1,1280),(66350050,2,1230),(66350050,3,1190),(66350050,4,1150),(66390600,1,320),(66390600,2,290),(66390600,3,270),(66390600,4,240),(66390651,1,500),(66390651,2,470),(66390651,3,440),(66390651,4,410),(66390800,1,500),(66390800,2,480),(66390800,3,450),(66390800,4,420),(66390750,1,400),(66390750,2,370),(66390750,3,340),(66390750,4,310),(66470900,1,460),(66470900,2,440),(66470900,3,420),(66470900,4,390),(66470651,1,460),(66470651,2,430),(66470651,3,400),(66470651,4,380),(66470652,1,490),(66470652,2,460),(66470652,3,430),(66470652,4,400),(66590820,1,970),(66590820,2,930),(66590820,3,890),(66590820,4,850),(66590420,1,790),(66590420,2,740),(66590420,3,700),(66590420,4,650),(66610300,1,180),(66610300,2,180),(66610300,3,180),(66610300,4,180),(66610900,1,420),(66610900,2,390),(66610900,3,360),(66610900,4,330),(66610400,1,850),(66610400,2,820),(66610400,3,780),(66610400,4,750),(66650250,1,410),(66650250,2,380),(66650250,3,350),(66650250,4,320),(66710900,1,380),(66710900,2,360),(66710900,3,340),(66710900,4,310),(66730900,1,420),(66730900,2,390),(66730900,3,360),(66730900,4,330),(66730970,1,360),(66730970,2,330),(66730970,3,300),(66730970,4,270),(66730800,1,780),(66730800,2,750),(66730800,3,720),(66730800,4,680),(66770100,1,480),(66770100,2,450),(66770100,3,420),(66770100,4,390),(66790820,1,640),(66790820,2,600),(66790820,3,560),(66790820,4,520),(66790970,1,380),(66790970,2,350),(66790970,3,320),(66790970,4,300),(66790930,1,1190),(66790930,2,1150),(66790930,3,1090),(66790930,4,1050),(66810900,1,710),(66810900,2,710),(66810900,3,710),(66810900,4,710),(66830150,1,120),(66830150,2,110),(66830150,3,100),(66830150,4,90),(66890400,1,140),(66890400,2,130),(66890400,3,120),(66890400,4,90),(66650650,1,350),(66650650,2,320),(66650650,3,290),(66650650,4,270),(66170101,1,380),(66170101,2,350),(66170101,3,320),(66170101,4,290),(11080006,1,320),(11080006,2,320),(11080006,3,320),(11080006,4,290),(66390990,1,280),(66390990,2,260),(66390990,3,240),(66390990,4,220),(66430901,1,610),(66430901,2,580),(66430901,3,550),(66430901,4,520),(11120008,1,410),(11120008,2,390),(11120008,3,370),(11120008,4,350),(11120009,1,450),(11120009,2,450),(11120009,3,420),(11120009,4,380),(66470653,1,510),(66470653,2,480),(66470653,3,450),(66470653,4,420),(66430651,1,250),(66430651,2,220),(66430651,3,190),(66430651,4,160),(66610251,1,620),(66610251,2,590),(66610251,3,560),(66610251,4,530),(66730150,1,120),(66730150,2,110),(66730150,3,100),(66730150,4,60),(11080001,1,220),(11080001,2,220),(11080001,3,220),(11080001,4,190),(11080004,1,490),(11080004,2,490),(11080004,3,490),(11080004,4,450),(11120007,1,320),(11120007,2,320),(11120007,3,290),(11120007,4,260),(11250008,1,29),(11250008,2,29),(11250008,3,26),(11250008,4,25),(11250009,1,39),(11250009,2,39),(11250009,3,39),(11250009,4,30),(33100011,1,350),(33100011,2,350),(33100011,3,350),(33100011,4,350),(33100012,1,220),(33100012,2,220),(33100012,3,220),(33100012,4,220),(33100013,1,220),(33100013,2,220),(33100013,3,220),(33100013,4,220),(33100016,1,250),(33100016,2,250),(33100016,3,250),(33100016,4,250),(33300012,1,45),(33300012,2,40),(33300012,3,35),(33300012,4,30),(33300013,1,850),(33300013,2,850),(33300013,3,890),(33300013,4,850),(33300015,1,600),(33300015,2,600),(33300015,3,600),(33300015,4,600),(66150250,1,320),(66150250,2,320),(66150250,3,320),(66150250,4,320),(66150400,1,350),(66150400,2,350),(66150400,3,350),(66150400,4,350),(66150450,1,1600),(66150450,2,1600),(66150450,3,1600),(66150450,4,1600),(66350930,1,1780),(66350930,2,1740),(66350930,3,1700),(66350930,4,1660),(66470250,1,300),(66470250,2,280),(66470250,3,250),(66470250,4,210),(66490970,1,600),(66490970,2,580),(66490970,3,550),(66490970,4,510),(66630970,1,380),(66630970,2,360),(66630970,3,330),(66630970,4,300),(66170150,1,320),(66170150,2,320),(66170150,3,320),(66170150,4,320),(11120004,1,150),(11120004,2,150),(11120004,3,120),(11120004,4,90),(11120003,1,210),(11120003,2,210),(11120003,3,210),(11120003,4,190),(11120002,1,30),(11120002,2,30),(11120002,3,30),(11120002,4,27),(66970900,1,160),(66970900,2,160),(66970900,3,160),(66970900,4,160),(66170650,1,300),(66170650,2,280),(66170650,3,260),(66170650,4,230),(66170651,1,460),(66170651,2,430),(66170651,3,390),(66170651,4,360),(66480150,1,460),(66480150,2,420),(66480150,3,390),(66480150,4,360),(66830651,1,240),(66830651,2,220),(66830651,3,200),(66830651,4,180),(66830652,1,220),(66830652,2,220),(66830652,3,220),(66830652,4,180),(66390752,1,450),(66390752,2,420),(66390752,3,390),(66390752,4,360),(66650870,1,140),(66650870,2,130),(66650870,3,120),(66650870,4,90),(66650651,1,290),(66650651,2,260),(66650651,3,230),(66650651,4,190),(66830050,1,720),(66830050,2,720),(66830050,3,720),(66830050,4,720),(66850750,1,130),(66850750,2,120),(66850750,3,110),(66850750,4,90),(66610052,1,1320),(66610052,2,1280),(66610052,3,1240),(66610052,4,1200),(66410980,1,150),(66410980,2,150),(66410980,3,150),(66410980,4,130),(66390755,1,290),(66390755,2,260),(66390755,3,230),(66390755,4,200),(66390501,1,320),(66390501,2,280),(66390501,3,250),(66390501,4,220),(66270900,1,490),(66270900,2,460),(66270900,3,420),(66270900,4,400),(66895650,1,500),(66895650,2,480),(66895650,3,450),(66895650,4,420),(66895900,1,520),(66895900,2,490),(66895900,3,460),(66895900,4,430),(11040009,1,160),(11040009,2,160),(11040009,3,160),(11040009,4,160),(11160003,1,160),(11160003,2,160),(11160003,3,160),(11160003,4,150),(11160005,1,110),(11160005,2,110),(11160005,3,110),(11160005,4,90),(33100009,1,50),(33100009,2,50),(33100009,3,50),(33100009,4,50),(33100019,1,120),(33100019,2,100),(33100019,3,80),(33100019,4,60),(33800008,1,680),(33800008,2,650),(33800008,3,600),(33800008,4,550),(33800009,1,680),(33800009,2,650),(33800009,3,620),(33800009,4,590),(33800012,1,680),(33800012,2,650),(33800012,3,620),(33800012,4,580),(33800013,1,720),(33800013,2,680),(33800013,3,650),(33800013,4,600),(33800018,1,720),(33800018,2,690),(33800018,3,660),(33800018,4,630),(66150420,1,1200),(66150420,2,1200),(66150420,3,1200),(66150420,4,1200),(66250901,1,440),(66250901,2,410),(66250901,3,380),(66250901,4,330),(66430900,1,650),(66430900,2,620),(66430900,3,590),(66430900,4,560),(66430904,1,570),(66430904,2,550),(66430904,3,530),(66430904,4,500),(66430970,1,350),(66430970,2,320),(66430970,3,280),(66430970,4,250),(66530500,1,250),(66530500,2,230),(66530500,3,210),(66530500,4,190),(66830400,1,1090),(66830400,2,1040),(66830400,3,990),(66830400,4,950),(66610050,1,1020),(66610050,2,990),(66610050,3,960),(66610050,4,920),(66630990,1,40),(66630990,2,40),(66630990,3,35),(66630990,4,35),(66390500,1,290),(66390500,2,270),(66390500,3,220),(66390500,4,190),(66390991,1,230),(66390991,2,210),(66390991,3,190),(66390991,4,170),(66980650,1,320),(66980650,2,290),(66980650,3,260),(66980650,4,230),(66630971,1,350),(66630971,2,350),(66630971,3,350),(66630971,4,350),(66776980,1,270),(66776980,2,250),(66776980,3,240),(66776980,4,220),(66350931,1,1140),(66350931,2,190),(66350931,3,1050),(66350931,4,990),(66330650,1,320),(66330650,2,320),(66330650,3,320),(66330650,4,320),(66610600,1,320),(66610600,2,300),(66610600,3,270),(66610600,4,240),(66430908,1,640),(66430908,2,610),(66430908,3,580),(66430908,4,550),(66430905,1,620),(66430905,2,580),(66430905,3,550),(66430905,4,520),(66360650,1,770),(66360650,2,750),(66360650,3,730),(66360650,4,685),(66775800,1,450),(66775800,2,420),(66775800,3,390),(66775800,4,350),(66430903,1,610),(66430903,2,580),(66430903,3,550),(66430903,4,520),(66788980,1,60),(66788980,2,60),(66788980,3,60),(66788980,4,60),(66500050,1,680),(66500050,2,650),(66500050,3,630),(66500050,4,600),(66360100,1,350),(66360100,2,350),(66360100,3,350),(66360100,4,350),(99910991,1,25),(99910991,2,25),(99910991,3,25),(99910991,4,25),(66480900,1,440),(66480900,2,420),(66480900,3,390),(66480900,4,360),(66610250,1,870),(66610250,2,830),(66610250,3,790),(66610250,4,760),(66900872,1,90),(66900872,2,80),(66900872,3,70),(66900872,4,50),(66640800,1,950),(66640800,2,910),(66640800,3,870),(66640800,4,830),(66170931,1,1160),(66170931,2,1120),(66170931,3,1080),(66170931,4,1040),(66710901,1,390),(66710901,2,370),(66710901,3,350),(66710901,4,330),(66390840,1,660),(66390840,2,630),(66390840,3,590),(66390840,4,560),(66470870,1,180),(66470870,2,160),(66470870,3,140),(66470870,4,120),(66860900,1,320),(66860900,2,300),(66860900,3,270),(66860900,4,240),(66860901,1,320),(66860901,2,300),(66860901,3,270),(66860901,4,240),(33100006,1,80),(33100006,2,80),(33100006,3,80),(33100006,4,80),(66390980,1,380),(66390980,2,380),(66390980,3,350),(66390980,4,320),(66390653,1,290),(66390653,2,260),(66390653,3,230),(66390653,4,210),(66390992,1,500),(66390992,2,480),(66390992,3,460),(66390992,4,440),(66930870,1,270),(66930870,2,250),(66930870,3,230),(66930870,4,200),(66170300,1,450),(66170300,2,420),(66170300,3,390),(66170300,4,360),(66390654,1,230),(66390654,2,210),(66390654,3,180),(66390654,4,160),(66210651,1,680),(66210651,2,630),(66210651,3,620),(66210651,4,580),(66570501,1,20),(66570501,2,20),(66570501,3,20),(66570501,4,20),(66130153,1,270),(66130153,2,270),(66130153,3,270),(66130153,4,250),(66970901,1,250),(66970901,2,220),(66970901,3,190),(66970901,4,130),(66830151,1,420),(66830151,2,390),(66830151,3,360),(66830151,4,330),(66170050,1,1080),(66170050,2,1050),(66170050,3,1000),(66170050,4,970),(33900005,1,60),(33900005,2,50),(33900005,3,40),(33900005,4,35),(66770102,1,810),(66770102,2,780),(66770102,3,750),(66770102,4,720),(66190400,1,1080),(66190400,2,1040),(66190400,3,990),(66190400,4,950),(66730980,1,870),(66730980,2,830),(66730980,3,790),(66730980,4,750),(66610105,1,350),(66610105,2,300),(66610105,3,0),(66610105,4,250),(66430912,1,250),(66430912,2,250),(66430912,3,250),(66430912,4,250),(66480151,1,400),(66480151,2,370),(66480151,3,340),(66480151,4,310),(66868650,1,380),(66868650,2,350),(66868650,3,320),(66868650,4,290),(66405900,1,100),(66405900,2,100),(66405900,3,100),(66405900,4,100),(66830250,1,380),(66830250,2,360),(66830250,3,340),(66830250,4,320),(66730302,1,380),(66730302,2,360),(66730302,3,330),(66730302,4,300),(66770401,1,820),(66770401,2,780),(66770401,3,740),(66770401,4,700),(11120010,1,360),(11120010,2,340),(11120010,3,320),(11120010,4,300),(66340650,1,520),(66340650,2,480),(66340650,3,440),(66340650,4,410),(33150003,1,580),(33150003,2,560),(33150003,3,540),(33150003,4,520),(33150005,1,580),(33150005,2,550),(33150005,3,520),(33150005,4,480),(33150006,1,550),(33150006,2,520),(33150006,3,480),(33150006,4,450),(33150007,1,580),(33150007,2,560),(33150007,3,540),(33150007,4,520),(33150009,1,580),(33150009,2,550),(33150009,3,520),(33150009,4,480),(33150010,1,720),(33150010,2,680),(33150010,3,650),(33150010,4,620),(33150011,1,700),(33150011,2,660),(33150011,3,630),(33150011,4,600),(33150012,1,780),(33150012,2,740),(33150012,3,710),(33150012,4,700),(33150013,1,580),(33150013,2,550),(33150013,3,520),(33150013,4,480),(33150014,1,680),(33150014,2,660),(33150014,3,640),(33150014,4,620),(33150015,1,600),(33150015,2,580),(33150015,3,550),(33150015,4,520),(33150017,1,580),(33150017,2,550),(33150017,3,520),(33150017,4,480),(33150018,1,700),(33150018,2,680),(33150018,3,640),(33150018,4,600),(33150021,1,650),(33150021,2,650),(33150021,3,650),(33150021,4,650),(66170157,1,190),(66170157,2,190),(66170157,3,190),(66170157,4,190),(33900007,1,420),(33900007,2,360),(33900007,3,330),(33900007,4,290),(33805046,1,490),(33805046,2,490),(33805046,3,490),(33805046,4,450),(66470255,1,300),(66470255,2,280),(66470255,3,260),(66470255,4,240),(11120011,1,270),(11120011,2,250),(11120011,3,220),(11120011,4,200),(11120012,1,220),(11120012,2,190),(11120012,3,160),(11120012,4,140),(11120013,1,270),(11120013,2,250),(11120013,3,220),(11120013,4,190),(11120014,1,270),(11120014,2,250),(11120014,3,220),(11120014,4,180),(11120015,1,270),(11120015,2,250),(11120015,3,220),(11120015,4,180),(11120016,1,240),(11120016,2,240),(11120016,3,240),(11120016,4,240),(11120017,1,290),(11120017,2,260),(11120017,3,230),(11120017,4,210),(11120018,1,80),(11120018,2,70),(11120018,3,60),(11120018,4,50),(11120019,1,140),(11120019,2,130),(11120019,3,120),(11120019,4,110),(11120021,1,190),(11120021,2,170),(11120021,3,150),(11120021,4,130),(66150102,1,310),(66150102,2,310),(66150102,3,310),(66150102,4,310),(66150103,1,490),(66150103,2,490),(66150103,3,490),(66150103,4,460),(66150104,1,270),(66150104,2,270),(66150104,3,270),(66150104,4,270),(66150106,1,1300),(66150106,2,1300),(66150106,3,1300),(66150106,4,1200),(66150120,1,390),(66150120,2,390),(66150120,3,390),(66150120,4,390),(66150125,1,1760),(66150125,2,1760),(66150125,3,1760),(66150125,4,1760),(66150130,1,800),(66150130,2,800),(66150130,3,800),(66150130,4,760),(66150135,1,360),(66150135,2,360),(66150135,3,360),(66150135,4,360),(66850500,1,90),(66850500,2,90),(66850500,3,50),(66850500,4,50),(11040012,1,150),(11040012,2,150),(11040012,3,150),(11040012,4,150),(66830750,1,240),(66830750,2,240),(66830750,3,240),(66830750,4,240),(66470901,1,230),(66470901,2,230),(66470901,3,230),(66470901,4,210),(99910992,1,25),(99910992,2,25),(99910992,3,25),(99910992,4,25),(66470666,1,420),(66470666,2,390),(66470666,3,360),(66470666,4,320),(66830980,1,310),(66830980,2,290),(66830980,3,260),(66830980,4,230),(66971050,1,350),(66971050,2,320),(66971050,3,300),(66971050,4,270),(11120022,1,160),(11120022,2,150),(11120022,3,140),(11120022,4,130),(11120023,1,220),(11120023,2,200),(11120023,3,190),(11120023,4,180),(11120024,1,110),(11120024,2,100),(11120024,3,80),(11120024,4,70),(11120026,1,150),(11120026,2,130),(11120026,3,110),(11120026,4,100),(33900008,1,100),(33900008,2,75),(33900008,3,50),(33900008,4,30),(66965900,1,250),(66965900,2,250),(66965900,3,230),(66965900,4,200),(33900009,1,100),(33900009,2,75),(33900009,3,50),(33900009,4,30),(33900010,1,60),(33900010,2,50),(33900010,3,40),(33900010,4,30),(66025401,1,720),(66025401,2,720),(66025401,3,720),(66025401,4,720),(66695950,1,720),(66695950,2,680),(66695950,3,640),(66695950,4,590),(66490980,1,320),(66490980,2,300),(66490980,3,280),(66490980,4,260),(66470655,1,420),(66470655,2,390),(66470655,3,360),(66470655,4,330),(66470899,1,400),(66470899,2,400),(66470899,3,400),(66470899,4,380),(66025150,1,260),(66025150,2,260),(66025150,3,260),(66025150,4,260),(66810050,1,2250),(66810050,2,2250),(66810050,3,2250),(66810050,4,2250),(66620905,1,530),(66620905,2,500),(66620905,3,470),(66620905,4,440),(66170158,1,240),(66170158,2,240),(66170158,3,240),(66170158,4,210),(66025151,1,230),(66025151,2,230),(66025151,3,230),(66025151,4,230),(66025801,1,1240),(66025801,2,1240),(66025801,3,1240),(66025801,4,1240),(66630991,1,40),(66630991,2,40),(66630991,3,35),(66630991,4,35),(66250909,1,450),(66250909,2,420),(66250909,3,390),(66250909,4,350),(66770057,1,1620),(66770057,2,1580),(66770057,3,1540),(66770057,4,1500),(66150150,1,600),(66150150,2,600),(66150150,3,600),(66150150,4,600),(66650055,1,240),(66650055,2,220),(66650055,3,190),(66650055,4,160),(66770650,1,300),(66770650,2,270),(66770650,3,240),(66770650,4,210),(66840801,1,490),(66840801,2,490),(66840801,3,490),(66840801,4,450),(66530800,1,780),(66530800,2,750),(66530800,3,720),(66530800,4,690),(66940450,1,310),(66940450,2,280),(66940450,3,250),(66940450,4,220),(66560902,1,360),(66560902,2,330),(66560902,3,290),(66560902,4,260),(33800015,1,680),(33800015,2,650),(33800015,3,620),(33800015,4,600),(66440004,1,200),(66440004,2,180),(66440004,3,160),(66440004,4,130),(66710903,1,460),(66710903,2,430),(66710903,3,390),(66710903,4,370),(66440005,1,280),(66440005,2,280),(66440005,3,280),(66440005,4,250),(66730901,1,420),(66730901,2,390),(66730901,3,360),(66730901,4,330),(66862650,1,380),(66862650,2,360),(66862650,3,330),(66862650,4,310),(6693004,1,130),(6693004,2,130),(6693004,3,130),(6693004,4,130),(66499900,1,370),(66499900,2,340),(66499900,3,310),(66499900,4,280),(66470905,1,300),(66470905,2,280),(66470905,3,250),(66470905,4,110),(33900015,1,260),(33900015,2,260),(33900015,3,260),(33900015,4,260),(66680050,1,250),(66680050,2,250),(66680050,3,200),(66680050,4,200),(66150825,1,260),(66150825,2,260),(66150825,3,260),(66150825,4,260),(66680100,1,160),(66680100,2,160),(66680100,3,160),(66680100,4,160),(66680140,1,280),(66680140,2,260),(66680140,3,240),(66680140,4,210),(66680150,1,120),(66680150,2,110),(66680150,3,100),(66680150,4,90),(66680180,1,160),(66680180,2,140),(66680180,3,140),(66680180,4,120),(66971100,1,350),(66971100,2,320),(66971100,3,300),(66971100,4,270),(66130655,1,340),(66130655,2,340),(66130655,3,340),(66130655,4,340),(66490982,1,650),(66490982,2,610),(66490982,3,570),(66490982,4,530),(66150060,1,490),(66150060,2,490),(66150060,3,490),(66150060,4,490),(66150048,1,390),(66150048,2,390),(66150048,3,390),(66150048,4,390),(66150042,1,350),(66150042,2,350),(66150042,3,350),(66150042,4,350),(66150044,1,0),(66150044,2,0),(66150044,3,0),(66150044,4,0),(66150046,1,430),(66150046,2,430),(66150046,3,430),(66150046,4,430),(66090998,1,120),(66090998,2,120),(66090998,3,120),(66090998,4,120),(66730890,1,190),(66730890,2,190),(66730890,3,190),(66730890,4,180),(11120027,1,240),(11120027,2,220),(11120027,3,200),(11120027,4,180),(11120028,1,150),(11120028,2,150),(11120028,3,150),(11120028,4,150),(66150065,1,120),(66150065,2,120),(66150065,3,120),(66150065,4,120),(33360890,1,430),(33360890,2,400),(33360890,3,370),(33360890,4,340),(66470750,1,530),(66470750,2,500),(66470750,3,470),(66470750,4,440),(66390655,1,320),(66390655,2,290),(66390655,3,260),(66390655,4,230),(66770058,1,1220),(66770058,2,1180),(66770058,3,1140),(66770058,4,1100),(66770405,1,580),(66770405,2,580),(66770405,3,550),(66770405,4,520),(66830298,1,280),(66830298,2,260),(66830298,3,240),(66830298,4,220),(33805005,1,490),(33805005,2,490),(33805005,3,490),(33805005,4,450),(11120031,1,280),(11120031,2,260),(11120031,3,230),(11120031,4,200),(33805009,1,490),(33805009,2,490),(33805009,3,490),(33805009,4,450),(33805011,1,490),(33805011,2,490),(33805011,3,490),(33805011,4,450),(33805013,1,490),(33805013,2,490),(33805013,3,490),(33805013,4,450),(33805015,1,490),(33805015,2,490),(33805015,3,490),(33805015,4,450),(33805017,1,490),(33805017,2,490),(33805017,3,490),(33805017,4,450),(33805019,1,490),(33805019,2,490),(33805019,3,490),(33805019,4,450),(33805021,1,490),(33805021,2,490),(33805021,3,490),(33805021,4,450),(33805023,1,490),(33805023,2,490),(33805023,3,490),(33805023,4,450),(33805025,1,490),(33805025,2,490),(33805025,3,490),(33805025,4,450),(33805027,1,490),(33805027,2,490),(33805027,3,490),(33805027,4,450),(33805029,1,490),(33805029,2,490),(33805029,3,490),(33805029,4,450),(33805031,1,490),(33805031,2,490),(33805031,3,490),(33805031,4,450),(33805033,1,490),(33805033,2,490),(33805033,3,490),(33805033,4,450),(33805035,1,490),(33805035,2,490),(33805035,3,490),(33805035,4,450),(33805037,1,490),(33805037,2,490),(33805037,3,490),(33805037,4,450),(33805039,1,490),(33805039,2,490),(33805039,3,490),(33805039,4,450),(33805041,1,490),(33805041,2,490),(33805041,3,490),(33805041,4,450),(33805043,1,490),(33805043,2,490),(33805043,3,490),(33805043,4,450),(33805045,1,490),(33805045,2,490),(33805045,3,490),(33805045,4,450),(66470930,1,1150),(66470930,2,1100),(66470930,3,1060),(66470930,4,1020),(66490984,1,340),(66490984,2,320),(66490984,3,300),(66490984,4,270),(66869031,1,360),(66869031,2,330),(66869031,3,300),(66869031,4,260),(66470300,1,360),(66470300,2,330),(66470300,3,280),(66470300,4,260),(66160006,1,480),(66160006,2,450),(66160006,3,420),(66160006,4,390),(66470055,1,960),(66470055,2,930),(66470055,3,900),(66470055,4,870),(66930155,1,380),(66930155,2,350),(66930155,3,320),(66930155,4,280),(11120032,1,350),(11120032,2,320),(11120032,3,300),(11120032,4,280),(33805014,1,490),(33805014,2,490),(33805014,3,490),(33805014,4,450),(11120034,1,340),(11120034,2,320),(11120034,3,300),(11120034,4,280),(66730653,1,230),(66730653,2,230),(66730653,3,230),(66730653,4,200),(66810052,1,680),(66810052,2,650),(66810052,3,620),(66810052,4,580),(66160009,1,480),(66160009,2,450),(66160009,3,420),(66160009,4,390),(66530910,1,420),(66530910,2,380),(66530910,3,350),(66530910,4,320),(66355905,1,280),(66355905,2,280),(66355905,3,280),(66355905,4,280),(11120036,1,200),(11120036,2,180),(11120036,3,150),(11120036,4,120),(11120038,1,220),(11120038,2,200),(11120038,3,180),(11120038,4,160),(11120039,1,590),(11120039,2,560),(11120039,3,530),(11120039,4,500),(11120041,1,160),(11120041,2,140),(11120041,3,130),(11120041,4,120),(11120042,1,220),(11120042,2,200),(11120042,3,170),(11120042,4,160),(11120043,1,520),(11120043,2,520),(11120043,3,500),(11120043,4,480),(66390995,1,150),(66390995,2,150),(66390995,3,150),(66390995,4,150),(66025032,1,170),(66025032,2,160),(66025032,3,150),(66025032,4,130),(66408050,1,35),(66408050,2,35),(66408050,3,35),(66408050,4,31),(66610254,1,490),(66610254,2,460),(66610254,3,430),(66610254,4,400),(33900016,1,420),(33900016,2,380),(33900016,3,350),(33900016,4,330),(33800022,1,360),(33800022,2,360),(33800022,3,360),(33800022,4,360),(11120044,1,100),(11120044,2,90),(11120044,3,80),(11120044,4,70),(33900017,1,370),(33900017,2,350),(33900017,3,320),(33900017,4,290),(66365900,1,420),(66365900,2,420),(66365900,3,350),(66365900,4,320),(66730755,1,280),(66730755,2,280),(66730755,3,250),(66730755,4,180),(66795900,1,460),(66795900,2,430),(66795900,3,400),(66795900,4,360),(66150830,1,240),(66150830,2,240),(66150830,3,240),(66150830,4,240),(66390060,1,870),(66390060,2,830),(66390060,3,790),(66390060,4,750),(11120046,1,250),(11120046,2,220),(11120046,3,200),(11120046,4,180),(66795905,1,350),(66795905,2,350),(66795905,3,350),(66795905,4,350),(66730908,1,240),(66730908,2,210),(66730908,3,180),(66730908,4,120),(66730909,1,260),(66730909,2,240),(66730909,3,210),(66730909,4,150),(66470906,1,290),(66470906,2,280),(66470906,3,260),(66470906,4,240),(11120047,1,35),(11120047,2,30),(11120047,3,25),(11120047,4,20),(11120048,1,20),(11120048,2,20),(11120048,3,20),(11120048,4,20),(33805042,1,490),(33805042,2,490),(33805042,3,490),(33805042,4,450),(66650252,1,360),(66650252,2,330),(66650252,3,300),(66650252,4,270),(66650871,1,75),(66650871,2,70),(66650871,3,65),(66650871,4,55),(33800007,1,740),(33800007,2,710),(33800007,3,680),(33800007,4,650),(33800016,1,680),(33800016,2,650),(33800016,3,620),(33800016,4,590),(66230871,1,140),(66230871,2,140),(66230871,3,140),(66230871,4,140),(99910993,1,20),(99910993,2,20),(99910993,3,20),(99910993,4,20),(66420902,1,580),(66420902,2,550),(66420902,3,520),(66420902,4,490),(66730255,1,300),(66730255,2,280),(66730255,3,260),(66730255,4,220),(66650850,1,680),(66650850,2,650),(66650850,3,620),(66650850,4,580),(11130009,1,65),(11130009,2,65),(11130009,3,60),(11130009,4,55),(11130010,1,200),(11130010,2,180),(11130010,3,160),(11130010,4,140),(11130011,1,210),(11130011,2,190),(11130011,3,170),(11130011,4,150),(11120049,1,70),(11120049,2,65),(11120049,3,60),(11120049,4,50),(66650605,1,230),(66650605,2,210),(66650605,3,190),(66650605,4,170),(66470907,1,280),(66470907,2,250),(66470907,3,220),(66470907,4,200),(33900021,1,60),(33900021,2,40),(33900021,3,50),(33900021,4,30),(66470751,1,150),(66470751,2,150),(66470751,3,150),(66470751,4,130),(11130016,1,210),(11130016,2,200),(11130016,3,190),(11130016,4,180),(66100900,1,200),(66100900,2,200),(66100900,3,180),(66100900,4,150),(66861055,1,580),(66861055,2,540),(66861055,3,500),(66861055,4,470),(11120050,1,110),(11120050,2,100),(11120050,3,90),(11120050,4,80),(11120054,1,150),(11120054,2,140),(11120054,3,130),(11120054,4,120),(11120055,1,350),(11120055,2,350),(11120055,3,340),(11120055,4,330),(66496120,1,400),(66496120,2,370),(66496120,3,340),(66496120,4,290),(66496122,1,430),(66496122,2,390),(66496122,3,350),(66496122,4,310),(33900012,1,370),(33900012,2,350),(33900012,3,320),(33900012,4,290),(66779900,1,20),(66779900,2,20),(66779900,3,20),(66779900,4,20),(66610248,1,290),(66610248,2,290),(66610248,3,290),(66610248,4,290),(66470550,1,120),(66470550,2,120),(66470550,3,120),(66470550,4,120),(66340100,1,650),(66340100,2,620),(66340100,3,590),(66340100,4,560),(66025850,1,390),(66025850,2,360),(66025850,3,340),(66025850,4,310),(66470658,1,700),(66470658,2,670),(66470658,3,640),(66470658,4,590),(66010003,1,290),(66010003,2,290),(66010003,3,290),(66010003,4,290),(99910995,1,15),(99910995,2,15),(99910995,3,15),(99910995,4,15),(66190405,1,1600),(66190405,2,1570),(66190405,3,1530),(66190405,4,1490),(66365665,1,440),(66365665,2,410),(66365665,3,380),(66365665,4,360),(99910996,1,30),(99910996,2,30),(99910996,3,30),(99910996,4,30),(99910997,1,15),(99910997,2,15),(99910997,3,15),(99910997,4,15),(66430250,1,430),(66430250,2,400),(66430250,3,370),(66430250,4,340),(33805047,1,490),(33805047,2,490),(33805047,3,490),(33805047,4,450),(33900025,1,420),(33900025,2,360),(33900025,3,330),(33900025,4,290),(66620055,1,660),(66620055,2,630),(66620055,3,600),(66620055,4,570),(33830001,1,370),(33830001,2,350),(33830001,3,330),(33830001,4,300),(33900022,1,60),(33900022,2,50),(33900022,3,40),(33900022,4,30),(66470660,1,380),(66470660,2,350),(66470660,3,320),(66470660,4,280),(33805018,1,490),(33805018,2,490),(33805018,3,490),(33805018,4,450),(66700300,1,390),(66700300,2,390),(66700300,3,390),(66700300,4,390),(66830915,1,250),(66830915,2,230),(66830915,3,210),(66830915,4,190),(66330655,1,430),(66330655,2,400),(66330655,3,370),(66330655,4,340),(11120020,1,80),(11120020,2,70),(11120020,3,60),(11120020,4,50),(11120035,1,340),(11120035,2,280),(11120035,3,310),(11120035,4,250),(11130000,1,260),(11130000,2,240),(11130000,3,220),(11130000,4,200),(11130001,1,220),(11130001,2,200),(11130001,3,180),(11130001,4,150),(11130003,1,150),(11130003,2,140),(11130003,3,130),(11130003,4,120),(11130007,1,210),(11130007,2,190),(11130007,3,170),(11130007,4,150),(11130008,1,240),(11130008,2,220),(11130008,3,200),(11130008,4,180),(11130014,1,210),(11130014,2,190),(11130014,3,170),(11130014,4,150),(11130018,1,120),(11130018,2,120),(11130018,3,120),(11130018,4,120),(11130021,1,220),(11130021,2,220),(11130021,3,220),(11130021,4,220),(11130022,1,220),(11130022,2,220),(11130022,3,220),(11130022,4,220),(11130023,1,220),(11130023,2,220),(11130023,3,220),(11130023,4,220),(11130025,1,220),(11130025,2,220),(11130025,3,220),(11130025,4,220),(33300021,1,520),(33300021,2,480),(33300021,3,450),(33300021,4,420),(33800003,1,700),(33800003,2,650),(33800003,3,600),(33800003,4,580),(33800004,1,680),(33800004,2,650),(33800004,3,620),(33800004,4,590),(33800010,1,680),(33800010,2,650),(33800010,3,600),(33800010,4,550),(66130651,1,300),(66130651,2,270),(66130651,3,250),(66130651,4,230),(66150100,1,90),(66150100,2,90),(66150100,3,80),(66150100,4,60),(66150105,1,600),(66150105,2,600),(66150105,3,600),(66150105,4,600),(66210050,1,60),(66210050,2,60),(66210050,3,60),(66210050,4,60),(66361250,1,250),(66361250,2,250),(66361250,3,250),(66361250,4,250),(66380055,1,1190),(66380055,2,1190),(66380055,3,1150),(66380055,4,1090),(66680170,1,120),(66680170,2,110),(66680170,3,100),(66680170,4,90),(66680200,1,220),(66680200,2,220),(66680200,3,220),(66680200,4,220),(66770050,1,1470),(66770050,2,1420),(66770050,3,1380),(66770050,4,1340),(66788050,1,660),(66788050,2,660),(66788050,3,610),(66788050,4,570),(66795650,1,790),(66795650,2,760),(66795650,3,730),(66795650,4,690),(66910605,1,820),(66910605,2,790),(66910605,3,760),(66910605,4,730),(66770060,1,320),(66770060,2,320),(66770060,3,320),(66770060,4,290),(66480750,1,340),(66480750,2,310),(66480750,3,280),(66480750,4,250),(33805048,1,490),(33805048,2,490),(33805048,3,490),(33805048,4,450),(99915005,1,55),(99915005,2,50),(99915005,3,45),(99915005,4,40),(99915010,1,60),(99915010,2,55),(99915010,3,50),(99915010,4,50),(99915020,1,50),(99915020,2,45),(99915020,3,40),(99915020,4,40),(99915100,1,10),(99915100,2,10),(99915100,3,10),(99915100,4,10),(66360150,1,380),(66360150,2,350),(66360150,3,320),(66360150,4,290),(66360950,1,380),(66360950,2,350),(66360950,3,330),(66360950,4,280),(66497650,1,230),(66497650,2,230),(66497650,3,230),(66497650,4,230),(66860903,1,100),(66860903,2,90),(66860903,3,70),(66860903,4,50),(66860904,1,100),(66860904,2,90),(66860904,3,70),(66860904,4,50),(99915037,1,35),(99915037,2,35),(99915037,3,35),(99915037,4,35),(66496050,1,320),(66496050,2,300),(66496050,3,280),(66496050,4,260),(66360910,1,250),(66360910,2,250),(66360910,3,230),(66360910,4,180),(11120058,1,280),(11120058,2,260),(11120058,3,240),(11120058,4,220),(66025655,1,850),(66025655,2,820),(66025655,3,780),(66025655,4,750),(66830405,1,450),(66830405,2,450),(66830405,3,450),(66830405,4,420),(66421001,1,760),(66421001,2,740),(66421001,3,720),(66421001,4,700),(66650401,1,610),(66650401,2,570),(66650401,3,530),(66650401,4,490),(66491002,1,50),(66491002,2,50),(66491002,3,45),(66491002,4,40),(66210654,1,50),(66210654,2,50),(66210654,3,45),(66210654,4,40),(66496055,1,550),(66496055,2,520),(66496055,3,490),(66496055,4,460),(66730155,1,180),(66730155,2,180),(66730155,3,180),(66730155,4,180),(66470908,1,290),(66470908,2,270),(66470908,3,250),(66470908,4,230),(66390658,1,250),(66390658,2,230),(66390658,3,210),(66390658,4,140),(66795600,1,710),(66795600,2,680),(66795600,3,640),(66795600,4,600),(66910601,1,890),(66910601,2,860),(66910601,3,830),(66910601,4,800),(66730920,1,1320),(66730920,2,1280),(66730920,3,1240),(66730920,4,1080),(66650872,1,100),(66650872,2,90),(66650872,3,80),(66650872,4,70),(66290970,1,270),(66290970,2,250),(66290970,3,230),(66290970,4,200),(66770605,1,460),(66770605,2,440),(66770605,3,420),(66770605,4,378),(66470645,1,590),(66470645,2,570),(66470645,3,550),(66470645,4,510),(66510401,1,120),(66510401,2,110),(66510401,3,100),(66510401,4,80),(66340400,1,950),(66340400,2,900),(66340400,3,850),(66340400,4,800),(66390751,1,210),(66390751,2,190),(66390751,3,170),(66390751,4,110),(66390754,1,290),(66390754,2,290),(66390754,3,290),(66390754,4,210),(66360653,1,300),(66360653,2,300),(66360653,3,300),(66360653,4,280),(66730751,1,300),(66730751,2,280),(66730751,3,260),(66730751,4,240),(99915039,1,25),(99915039,2,25),(99915039,3,25),(99915039,4,25),(66470647,1,400),(66470647,2,370),(66470647,3,340),(66470647,4,310),(66421400,1,770),(66421400,2,730),(66421400,3,690),(66421400,4,650),(66840805,1,940),(66840805,2,900),(66840805,3,860),(66840805,4,820),(66390659,1,480),(66390659,2,450),(66390659,3,420),(66390659,4,380),(66792655,1,290),(66792655,2,290),(66792655,3,290),(66792655,4,290),(66470662,1,510),(66470662,2,480),(66470662,3,450),(66470662,4,420),(99910998,1,35),(99910998,2,35),(99910998,3,35),(99910998,4,35),(99910999,1,35),(99910999,2,35),(99910999,3,35),(99910999,4,35),(99911000,1,30),(99911000,2,30),(99911000,3,30),(99911000,4,30),(99911001,1,5),(99911001,2,5),(99911001,3,5),(99911001,4,5),(99911002,1,5),(99911002,2,5),(99911002,3,5),(99911002,4,5),(9911003,1,5),(9911003,2,5),(9911003,3,5),(9911003,4,5),(66390757,1,480),(66390757,2,450),(66390757,3,420),(66390757,4,380),(99915041,1,40),(99915041,2,40),(99915041,3,35),(99915041,4,35),(66625980,1,320),(66625980,2,290),(66625980,3,260),(66625980,4,230),(66971150,1,350),(66971150,2,320),(66971150,3,300),(66971150,4,270),(66499905,1,730),(66499905,2,690),(66499905,3,660),(66499905,4,620),(66795651,1,1690),(66795651,2,1640),(66795651,3,1590),(66795651,4,1550),(66365151,1,290),(66365151,2,260),(66365151,3,230),(66365151,4,200),(33800024,1,750),(33800024,2,720),(33800024,3,680),(33800024,4,650),(66470253,1,420),(66470253,2,390),(66470253,3,360),(66470253,4,330),(33800025,1,720),(33800025,2,690),(33800025,3,660),(33800025,4,630),(99915117,1,25),(99915117,2,25),(99915117,3,25),(99915117,4,25),(66400007,1,60),(66400007,2,60),(66400007,3,60),(66400007,4,60),(66864050,1,620),(66864050,2,600),(66864050,3,580),(66864050,4,560),(33805049,1,490),(33805049,2,490),(33805049,3,490),(33805049,4,450),(11120060,1,180),(11120060,2,170),(11120060,3,160),(11120060,4,140),(33900109,1,540),(33900109,2,510),(33900109,3,480),(33900109,4,450),(11120061,1,110),(11120061,2,100),(11120061,3,90),(11120061,4,80),(33805050,1,490),(33805050,2,490),(33805050,3,490),(33805050,4,450),(66400004,1,710),(66400004,2,680),(66400004,3,650),(66400004,4,620),(66340652,1,520),(66340652,2,490),(66340652,3,460),(66340652,4,430),(66840800,1,1010),(66840800,2,980),(66840800,3,950),(66840800,4,920),(66530250,1,550),(66530250,2,520),(66530250,3,480),(66530250,4,450),(66190250,1,590),(66190250,2,560),(66190250,3,530),(66190250,4,490),(99915101,1,35),(99915101,2,35),(99915101,3,35),(99915101,4,35),(99915103,1,30),(99915103,2,30),(99915103,3,30),(99915103,4,30),(99915104,1,30),(99915104,2,30),(99915104,3,30),(99915104,4,30),(99915105,1,25),(99915105,2,25),(99915105,3,25),(99915105,4,16),(99915106,1,25),(99915106,2,25),(99915106,3,25),(99915106,4,25),(99915107,1,15),(99915107,2,15),(99915107,3,15),(99915107,4,15),(66491005,1,35),(66491005,2,35),(66491005,3,30),(66491005,4,25),(66792650,1,360),(66792650,2,360),(66792650,3,360),(66792650,4,360),(66980550,1,190),(66980550,2,190),(66980550,3,190),(66980550,4,190),(99915108,1,20),(99915108,2,20),(99915108,3,20),(99915108,4,20),(66760005,1,20),(66760005,2,20),(66760005,3,20),(66760005,4,20),(66210659,1,690),(66210659,2,670),(66210659,3,640),(66210659,4,610),(66975050,1,670),(66975050,2,670),(66975050,3,630),(66975050,4,590),(66840806,1,270),(66840806,2,270),(66840806,3,270),(66840806,4,270),(66890973,1,220),(66890973,2,200),(66890973,3,180),(66890973,4,160),(66980600,1,200),(66980600,2,200),(66980600,3,200),(66980600,4,160),(99915110,1,20),(99915110,2,20),(99915110,3,20),(99915110,4,20),(99915112,1,15),(99915112,2,15),(99915112,3,15),(99915112,4,15),(99915113,1,25),(99915113,2,25),(99915113,3,25),(99915113,4,25),(99915115,1,25),(99915115,2,25),(99915115,3,25),(99915115,4,25),(99915116,1,30),(99915116,2,30),(99915116,3,30),(99915116,4,30),(33900105,1,2400),(33900105,2,2350),(33900105,3,2300),(33900105,4,2200),(33900106,1,2400),(33900106,2,2350),(33900106,3,2300),(33900106,4,2200),(66865052,1,350),(66865052,2,320),(66865052,3,290),(66865052,4,250),(33900108,1,400),(33900108,2,370),(33900108,3,330),(33900108,4,290),(66377800,1,430),(66377800,2,400),(66377800,3,370),(66377800,4,340),(66050700,1,390),(66050700,2,360),(66050700,3,330),(66050700,4,300),(66965800,1,240),(66965800,2,230),(66965800,3,210),(66965800,4,190),(33125001,1,360),(33125001,2,330),(33125001,3,290),(33125001,4,250),(33125002,1,360),(33125002,2,330),(33125002,3,290),(33125002,4,250),(33125003,1,360),(33125003,2,330),(33125003,3,290),(33125003,4,250),(33125004,1,360),(33125004,2,330),(33125004,3,290),(33125004,4,250),(33125005,1,360),(33125005,2,320),(33125005,3,290),(33125005,4,250),(33125006,1,360),(33125006,2,330),(33125006,3,290),(33125006,4,250),(33125007,1,360),(33125007,2,330),(33125007,3,290),(33125007,4,250),(33125008,1,360),(33125008,2,330),(33125008,3,290),(33125008,4,250),(33125009,1,360),(33125009,2,330),(33125009,3,290),(33125009,4,250),(33125010,1,360),(33125010,2,330),(33125010,3,290),(33125010,4,250),(33125011,1,360),(33125011,2,320),(33125011,3,290),(33125011,4,250),(33125012,1,360),(33125012,2,320),(33125012,3,290),(33125012,4,250),(33125013,1,360),(33125013,2,330),(33125013,3,290),(33125013,4,250),(33125015,1,360),(33125015,2,330),(33125015,3,290),(33125015,4,250),(33125016,1,360),(33125016,2,330),(33125016,3,290),(33125016,4,250),(33125018,1,360),(33125018,2,330),(33125018,3,290),(33125018,4,250),(33125019,1,360),(33125019,2,330),(33125019,3,290),(33125019,4,250),(33125020,1,360),(33125020,2,330),(33125020,3,290),(33125020,4,250),(33125022,1,360),(33125022,2,320),(33125022,3,290),(33125022,4,250),(33125023,1,360),(33125023,2,320),(33125023,3,290),(33125023,4,250),(33125024,1,360),(33125024,2,320),(33125024,3,290),(33125024,4,250),(66680056,1,120),(66680056,2,120),(66680056,3,120),(66680056,4,120),(66760840,1,380),(66760840,2,350),(66760840,3,320),(66760840,4,290),(66730950,1,220),(66730950,2,200),(66730950,3,180),(66730950,4,160),(66940252,1,730),(66940252,2,690),(66940252,3,650),(66940252,4,590),(99915119,1,25),(99915119,2,25),(99915119,3,25),(99915119,4,25),(99915120,1,25),(99915120,2,25),(99915120,3,25),(99915120,4,25),(99915121,1,25),(99915121,2,25),(99915121,3,25),(99915121,4,25),(66400006,1,420),(66400006,2,420),(66400006,3,420),(66400006,4,420),(66861200,1,340),(66861200,2,320),(66861200,3,300),(66861200,4,280),(66778310,1,260),(66778310,2,240),(66778310,3,220),(66778310,4,190),(66190928,1,770),(66190928,2,740),(66190928,3,710),(66190928,4,670),(66377801,1,450),(66377801,2,420),(66377801,3,390),(66377801,4,360),(66775790,1,450),(66775790,2,420),(66775790,3,390),(66775790,4,350),(66360952,1,700),(66360952,2,680),(66360952,3,650),(66360952,4,630),(11120062,1,180),(11120062,2,180),(11120062,3,180),(11120062,4,180),(33805051,1,550),(33805051,2,520),(33805051,3,480),(33805051,4,450),(99915122,1,20),(99915122,2,20),(99915122,3,20),(99915122,4,20),(66340900,1,1690),(66340900,2,1650),(66340900,3,1600),(66340900,4,1560),(331500223,1,680),(331500223,2,650),(331500223,3,630),(331500223,4,600),(99915123,1,20),(99915123,2,20),(99915123,3,20),(99915123,4,20),(66930041,1,220),(66930041,2,220),(66930041,3,220),(66930041,4,220),(66895150,1,1160),(66895150,2,1120),(66895150,3,1080),(66895150,4,1040),(99915124,1,15),(99915124,2,15),(99915124,3,15),(99915124,4,15),(66470874,1,240),(66470874,2,220),(66470874,3,200),(66470874,4,180),(66026150,1,580),(66026150,2,550),(66026150,3,520),(66026150,4,490),(66930050,1,60),(66930050,2,60),(66930050,3,60),(66930050,4,60),(66417655,1,230),(66417655,2,200),(66417655,3,180),(66417655,4,150),(33900027,1,350),(33900027,2,320),(33900027,3,290),(33900027,4,260),(66610406,1,1050),(66610406,2,1010),(66610406,3,970),(66610406,4,930),(66795450,1,310),(66795450,2,290),(66795450,3,270),(66795450,4,250),(66373900,1,50),(66373900,2,50),(66373900,3,50),(66373900,4,50),(66778150,1,530),(66778150,2,500),(66778150,3,470),(66778150,4,440),(66190933,1,1160),(66190933,2,1120),(66190933,3,1080),(66190933,4,1040),(66930200,1,960),(66930200,2,920),(66930200,3,880),(66930200,4,840),(33800029,1,400),(33800029,2,400),(33800029,3,400),(33800029,4,400),(66965780,1,360),(66965780,2,330),(66965780,3,300),(66965780,4,270),(66965790,1,240),(66965790,2,220),(66965790,3,200),(66965790,4,180),(66980150,1,430),(66980150,2,430),(66980150,3,430),(66980150,4,430),(66980200,1,660),(66980200,2,660),(66980200,3,660),(66980200,4,660),(66795602,1,860),(66795602,2,860),(66795602,3,830),(66795602,4,800),(66730921,1,470),(66730921,2,450),(66730921,3,420),(66730921,4,390),(66779905,1,210),(66779905,2,210),(66779905,3,210),(66779905,4,210),(66470841,1,560),(66470841,2,530),(66470841,3,500),(66470841,4,470),(66430913,1,320),(66430913,2,300),(66430913,3,280),(66430913,4,260),(66771400,1,790),(66771400,2,760),(66771400,3,730),(66771400,4,700),(33820002,1,280),(33820002,2,260),(33820002,3,240),(33820002,4,220),(33820003,1,460),(33820003,2,430),(33820003,3,400),(33820003,4,370);

INSERT INTO `product_warehouse` VALUES (66170650,1,0),(66170650,2,1),(66170650,3,0),(66170650,4,0),(66170650,6,0),(66170650,7,0),(99915101,1,0),(99915101,2,0),(99915101,3,0),(99915101,4,0),(99915101,6,3),(99915101,7,0),(99915117,1,0),(99915117,2,0),(99915117,3,1),(99915117,4,0),(99915117,6,2),(99915117,7,2),(99915103,1,20),(99915103,2,2),(99915103,3,6),(99915103,4,0),(99915103,6,0),(99915103,7,7),(99915115,1,180),(99915115,2,5),(99915115,3,5),(99915115,4,5),(99915115,6,4),(99915115,7,8),(99915116,1,36),(99915116,2,8),(99915116,3,7),(99915116,4,0),(99915116,6,2),(99915116,7,13),(99915121,1,0),(99915121,2,1),(99915121,3,0),(99915121,4,0),(99915121,6,0),(99915121,7,0),(99915107,1,0),(99915107,2,0),(99915107,3,0),(99915107,4,4),(99915107,6,0),(99915107,7,2),(99915119,1,10),(99915119,2,1),(99915119,3,3),(99915119,4,2),(99915119,6,5),(99915119,7,0),(99915120,1,1),(99915120,2,0),(99915120,3,3),(99915120,4,0),(99915120,6,0),(99915120,7,0),(99915113,1,4),(99915113,2,0),(99915113,3,0),(99915113,4,0),(99915113,6,0),(99915113,7,0),(99915124,1,0),(99915124,2,0),(99915124,3,0),(99915124,4,5),(99915124,6,0),(99915124,7,0),(99915104,1,1),(99915104,2,0),(99915104,3,0),(99915104,4,0),(99915104,6,0),(99915104,7,0),(99915112,1,0),(99915112,2,0),(99915112,3,1),(99915112,4,0),(99915112,6,0),(99915112,7,0),(99915105,1,104),(99915105,2,1),(99915105,3,0),(99915105,4,1),(99915105,6,1),(99915105,7,7),(99915106,1,0),(99915106,2,0),(99915106,3,5),(99915106,4,0),(99915106,6,23),(99915106,7,0),(99915108,1,17),(99915108,2,5),(99915108,3,2),(99915108,4,0),(99915108,6,0),(99915108,7,4),(99915122,1,5),(99915122,2,0),(99915122,3,0),(99915122,4,0),(99915122,6,0),(99915122,7,0),(33900013,1,0),(33900013,2,1),(33900013,3,0),(33900013,4,0),(33900013,6,0),(33900013,7,0),(66150135,1,8),(66150135,2,2),(66150135,3,2),(66150135,4,1),(66150135,6,1),(66150135,7,2),(66150300,1,28),(66150300,2,1),(66150300,3,2),(66150300,4,2),(66150300,6,2),(66150300,7,2),(66500050,1,0),(66500050,2,0),(66500050,3,1),(66500050,4,0),(66500050,6,1),(66500050,7,1),(66496055,1,9),(66496055,2,3),(66496055,3,3),(66496055,4,3),(66496055,6,3),(66496055,7,2),(66930200,1,0),(66930200,2,0),(66930200,3,1),(66930200,4,1),(66930200,6,0),(66930200,7,1),(66770060,1,55),(66770060,2,3),(66770060,3,3),(66770060,4,3),(66770060,6,2),(66770060,7,2),(66496050,1,129),(66496050,2,2),(66496050,3,4),(66496050,4,3),(66496050,6,3),(66496050,7,2),(66830050,1,37),(66830050,2,1),(66830050,3,2),(66830050,4,2),(66830050,6,2),(66830050,7,2),(66025150,1,0),(66025150,2,0),(66025150,3,1),(66025150,4,0),(66025150,6,1),(66025150,7,0),(66025151,1,0),(66025151,2,0),(66025151,3,2),(66025151,4,1),(66025151,6,0),(66025151,7,0),(66025401,1,3),(66025401,2,1),(66025401,3,1),(66025401,4,1),(66025401,6,1),(66025401,7,1),(66025801,1,3),(66025801,2,1),(66025801,3,1),(66025801,4,1),(66025801,6,1),(66025801,7,1),(66025655,1,0),(66025655,2,0),(66025655,3,0),(66025655,4,0),(66025655,6,1),(66025655,7,0),(66150250,1,5),(66150250,2,0),(66150250,3,1),(66150250,4,3),(66150250,6,0),(66150250,7,0),(66070050,1,1),(66070050,2,1),(66070050,3,2),(66070050,4,1),(66070050,6,2),(66070050,7,1),(66090999,1,1),(66090999,2,1),(66090999,3,1),(66090999,4,1),(66090999,6,0),(66090999,7,0),(66026150,1,0),(66026150,2,0),(66026150,3,1),(66026150,4,0),(66026150,6,0),(66026150,7,0),(66860900,1,0),(66860900,2,0),(66860900,3,1),(66860900,4,0),(66860900,6,1),(66860900,7,0),(66860903,1,0),(66860903,2,0),(66860903,3,0),(66860903,4,0),(66860903,6,0),(66860903,7,1),(66971050,1,4),(66971050,2,1),(66971050,3,1),(66971050,4,1),(66971050,6,1),(66971050,7,1),(11120048,1,2),(11120048,2,2),(11120048,3,4),(11120048,4,3),(11120048,6,4),(11120048,7,4),(66830150,1,2),(66830150,2,2),(66830150,3,1),(66830150,4,2),(66830150,6,1),(66830150,7,1),(66390654,1,28),(66390654,2,2),(66390654,3,2),(66390654,4,3),(66390654,6,2),(66390654,7,3),(66770100,1,1),(66770100,2,1),(66770100,3,1),(66770100,4,1),(66770100,6,1),(66770100,7,1),(66770102,1,1),(66770102,2,0),(66770102,3,0),(66770102,4,0),(66770102,6,0),(66770102,7,1),(66360150,1,0),(66360150,2,0),(66360150,3,1),(66360150,4,1),(66360150,6,0),(66360150,7,0),(66830151,1,0),(66830151,2,0),(66830151,3,1),(66830151,4,0),(66830151,6,0),(66830151,7,0),(66190100,1,0),(66190100,2,1),(66190100,3,0),(66190100,4,0),(66190100,6,0),(66190100,7,0),(66868650,1,0),(66868650,2,2),(66868650,3,1),(66868650,4,0),(66868650,6,1),(66868650,7,2),(66360100,1,25),(66360100,2,2),(66360100,3,3),(66360100,4,0),(66360100,6,2),(66360100,7,2),(33805049,1,0),(33805049,2,0),(33805049,3,0),(33805049,4,2),(33805049,6,0),(33805049,7,1),(33805035,1,0),(33805035,2,0),(33805035,3,1),(33805035,4,0),(33805035,6,0),(33805035,7,1),(33805041,1,0),(33805041,2,1),(33805041,3,1),(33805041,4,0),(33805041,6,0),(33805041,7,1),(33805039,1,1),(33805039,2,1),(33805039,3,2),(33805039,4,2),(33805039,6,1),(33805039,7,1),(66910601,1,5),(66910601,2,1),(66910601,3,1),(66910601,4,2),(66910601,6,1),(66910601,7,0),(33805029,1,1),(33805029,2,0),(33805029,3,1),(33805029,4,0),(33805029,6,0),(33805029,7,0),(33805033,1,0),(33805033,2,0),(33805033,3,1),(33805033,4,0),(33805033,6,0),(33805033,7,0),(33200005,1,0),(33200005,2,2),(33200005,3,1),(33200005,4,2),(33200005,6,2),(33200005,7,3),(33805043,1,0),(33805043,2,1),(33805043,3,1),(33805043,4,1),(33805043,6,1),(33805043,7,1),(11120043,1,1),(11120043,2,1),(11120043,3,1),(11120043,4,1),(11120043,6,1),(11120043,7,1),(66680100,1,9),(66680100,2,1),(66680100,3,0),(66680100,4,2),(66680100,6,1),(66680100,7,2),(66130655,1,2),(66130655,2,0),(66130655,3,0),(66130655,4,0),(66130655,6,0),(66130655,7,0),(11120026,1,1),(11120026,2,0),(11120026,3,0),(11120026,4,0),(11120026,6,0),(11120026,7,0),(11120024,1,9),(11120024,2,0),(11120024,3,0),(11120024,4,0),(11120024,6,0),(11120024,7,0),(66440004,1,1),(66440004,2,0),(66440004,3,0),(66440004,4,0),(66440004,6,0),(66440004,7,0),(11120003,1,8),(11120003,2,0),(11120003,3,3),(11120003,4,0),(11120003,6,0),(11120003,7,0),(99915041,1,0),(99915041,2,12),(99915041,3,0),(99915041,4,0),(99915041,6,0),(99915041,7,16),(99915020,1,0),(99915020,2,8),(99915020,3,0),(99915020,4,0),(99915020,6,0),(99915020,7,15),(99915010,1,0),(99915010,2,0),(99915010,3,0),(99915010,4,0),(99915010,6,0),(99915010,7,4),(99915037,1,0),(99915037,2,20),(99915037,3,0),(99915037,4,0),(99915037,6,0),(99915037,7,25),(99915005,1,16),(99915005,2,11),(99915005,3,0),(99915005,4,0),(99915005,6,0),(99915005,7,0),(99915039,1,0),(99915039,2,5),(99915039,3,0),(99915039,4,0),(99915039,6,0),(99915039,7,0),(66100900,1,0),(66100900,2,1),(66100900,3,1),(66100900,4,0),(66100900,6,0),(66100900,7,0),(66770650,1,0),(66770650,2,0),(66770650,3,1),(66770650,4,0),(66770650,6,1),(66770650,7,0),(66730155,1,25),(66730155,2,2),(66730155,3,2),(66730155,4,2),(66730155,6,4),(66730155,7,4),(66150042,1,0),(66150042,2,1),(66150042,3,0),(66150042,4,0),(66150042,6,2),(66150042,7,2),(66730150,1,95),(66730150,2,2),(66730150,3,3),(66730150,4,3),(66730150,6,1),(66730150,7,2),(66110650,1,6),(66110650,2,0),(66110650,3,1),(66110650,4,2),(66110650,6,2),(66110650,7,2),(66170101,1,4),(66170101,2,1),(66170101,3,1),(66170101,4,1),(66170101,6,0),(66170101,7,1),(66170157,1,5),(66170157,2,2),(66170157,3,0),(66170157,4,0),(66170157,6,0),(66170157,7,0),(66170158,1,8),(66170158,2,2),(66170158,3,0),(66170158,4,0),(66170158,6,1),(66170158,7,0),(66470255,1,4),(66470255,2,1),(66470255,3,0),(66470255,4,2),(66470255,6,1),(66470255,7,1),(66390992,1,0),(66390992,2,1),(66390992,3,1),(66390992,4,0),(66390992,6,0),(66390992,7,0),(66170150,1,3),(66170150,2,0),(66170150,3,0),(66170150,4,0),(66170150,6,0),(66170150,7,0),(66630970,1,1),(66630970,2,0),(66630970,3,0),(66630970,4,0),(66630970,6,0),(66630970,7,1),(33820002,1,1),(33820002,2,0),(33820002,3,1),(33820002,4,1),(33820002,6,1),(33820002,7,0),(66373900,1,9),(66373900,2,4),(66373900,3,4),(66373900,4,7),(66373900,6,3),(66373900,7,4),(66250901,1,0),(66250901,2,0),(66250901,3,0),(66250901,4,2),(66250901,6,0),(66250901,7,0),(66430900,1,0),(66430900,2,0),(66430900,3,1),(66430900,4,1),(66430900,6,1),(66430900,7,1),(11040009,1,0),(11040009,2,0),(11040009,3,1),(11040009,4,1),(11040009,6,0),(11040009,7,0),(33900025,1,0),(33900025,2,0),(33900025,3,2),(33900025,4,0),(33900025,6,0),(33900025,7,0),(33900007,1,8),(33900007,2,1),(33900007,3,2),(33900007,4,4),(33900007,6,3),(33900007,7,2),(33900017,1,2),(33900017,2,1),(33900017,3,1),(33900017,4,2),(33900017,6,1),(33900017,7,0),(33900027,1,1),(33900027,2,0),(33900027,3,2),(33900027,4,1),(33900027,6,1),(33900027,7,1),(33900108,1,0),(33900108,2,0),(33900108,3,2),(33900108,4,1),(33900108,6,0),(33900108,7,3),(33900016,1,4),(33900016,2,1),(33900016,3,2),(33900016,4,2),(33900016,6,2),(33900016,7,2),(66470662,1,0),(66470662,2,1),(66470662,3,1),(66470662,4,0),(66470662,6,0),(66470662,7,1),(33150003,1,2),(33150003,2,0),(33150003,3,1),(33150003,4,1),(33150003,6,1),(33150003,7,1),(66775790,1,1),(66775790,2,0),(66775790,3,1),(66775790,4,0),(66775790,6,0),(66775790,7,1),(66775800,1,1),(66775800,2,0),(66775800,3,1),(66775800,4,0),(66775800,6,0),(66775800,7,1),(66480150,1,3),(66480150,2,1),(66480150,3,0),(66480150,4,1),(66480150,6,0),(66480150,7,1),(66480151,1,4),(66480151,2,0),(66480151,3,0),(66480151,4,0),(66480151,6,0),(66480151,7,0),(66210654,1,156),(66210654,2,5),(66210654,3,2),(66210654,4,2),(66210654,6,4),(66210654,7,4),(66210659,1,4),(66210659,2,2),(66210659,3,0),(66210659,4,2),(66210659,6,1),(66210659,7,2),(66210651,1,5),(66210651,2,0),(66210651,3,0),(66210651,4,1),(66210651,6,0),(66210651,7,2),(66210050,1,0),(66210050,2,0),(66210050,3,0),(66210050,4,0),(66210050,6,0),(66210050,7,1),(11250008,1,65),(11250008,2,0),(11250008,3,0),(11250008,4,0),(11250008,6,0),(11250008,7,0),(11250009,1,139),(11250009,2,0),(11250009,3,9),(11250009,4,0),(11250009,6,0),(11250009,7,0),(66150830,1,2),(66150830,2,1),(66150830,3,1),(66150830,4,1),(66150830,6,2),(66150830,7,3),(66650055,1,0),(66650055,2,0),(66650055,3,0),(66650055,4,0),(66650055,6,0),(66650055,7,1),(66470550,1,102),(66470550,2,1),(66470550,3,1),(66470550,4,4),(66470550,6,1),(66470550,7,2),(66390991,1,0),(66390991,2,0),(66390991,3,0),(66390991,4,1),(66390991,6,0),(66390991,7,1),(66408050,1,0),(66408050,2,1),(66408050,3,2),(66408050,4,2),(66408050,6,1),(66408050,7,2),(33900105,1,2),(33900105,2,0),(33900105,3,0),(33900105,4,0),(33900105,6,0),(33900105,7,0),(33900106,1,1),(33900106,2,0),(33900106,3,0),(33900106,4,0),(33900106,6,0),(33900106,7,0),(66779905,1,18),(66779905,2,2),(66779905,3,0),(66779905,4,4),(66779905,6,2),(66779905,7,2),(66965800,1,0),(66965800,2,0),(66965800,3,1),(66965800,4,0),(66965800,6,0),(66965800,7,0),(11120021,1,82),(11120021,2,1),(11120021,3,3),(11120021,4,5),(11120021,6,3),(11120021,7,3),(66025032,1,0),(66025032,2,1),(66025032,3,0),(66025032,4,0),(66025032,6,0),(66025032,7,0),(66680170,1,0),(66680170,2,0),(66680170,3,0),(66680170,4,0),(66680170,6,0),(66680170,7,1),(66390840,1,0),(66390840,2,0),(66390840,3,1),(66390840,4,0),(66390840,6,0),(66390840,7,1),(66980650,1,16),(66980650,2,2),(66980650,3,4),(66980650,4,4),(66980650,6,3),(66980650,7,3),(66150060,1,0),(66150060,2,1),(66150060,3,2),(66150060,4,3),(66150060,6,1),(66150060,7,0),(66590820,1,3),(66590820,2,1),(66590820,3,0),(66590820,4,1),(66590820,6,1),(66590820,7,2),(66590420,1,0),(66590420,2,2),(66590420,3,0),(66590420,4,0),(66590420,6,2),(66590420,7,1),(66790820,1,5),(66790820,2,2),(66790820,3,1),(66790820,4,2),(66790820,6,1),(66790820,7,1),(66795650,1,0),(66795650,2,0),(66795650,3,0),(66795650,4,0),(66795650,6,0),(66795650,7,1),(66795651,1,0),(66795651,2,0),(66795651,3,1),(66795651,4,0),(66795651,6,0),(66795651,7,0),(66360952,1,1),(66360952,2,0),(66360952,3,1),(66360952,4,0),(66360952,6,0),(66360952,7,0),(66610250,1,0),(66610250,2,0),(66610250,3,0),(66610250,4,0),(66610250,6,1),(66610250,7,0),(66610248,1,3),(66610248,2,0),(66610248,3,0),(66610248,4,0),(66610248,6,0),(66610248,7,0),(66860901,1,2),(66860901,2,1),(66860901,3,1),(66860901,4,1),(66860901,6,1),(66860901,7,1),(66860904,1,3),(66860904,2,1),(66860904,3,1),(66860904,4,1),(66860904,6,1),(66860904,7,1),(66400006,1,0),(66400006,2,0),(66400006,3,1),(66400006,4,0),(66400006,6,0),(66400006,7,1),(11130014,1,0),(11130014,2,0),(11130014,3,0),(11130014,4,0),(11130014,6,0),(11130014,7,1),(11120020,1,0),(11120020,2,0),(11120020,3,0),(11120020,4,0),(11120020,6,0),(11120020,7,1),(11120061,1,2),(11120061,2,1),(11120061,3,1),(11120061,4,1),(11120061,6,1),(11120061,7,1),(11120013,1,1),(11120013,2,0),(11120013,3,2),(11120013,4,0),(11120013,6,0),(11120013,7,1),(11120039,1,0),(11120039,2,0),(11120039,3,1),(11120039,4,0),(11120039,6,0),(11120039,7,0),(66250909,1,0),(66250909,2,0),(66250909,3,1),(66250909,4,1),(66250909,6,1),(66250909,7,1),(11120041,1,0),(11120041,2,1),(11120041,3,1),(11120041,4,1),(11120041,6,0),(11120041,7,1),(66965790,1,0),(66965790,2,0),(66965790,3,0),(66965790,4,0),(66965790,6,0),(66965790,7,1),(66680050,1,1),(66680050,2,1),(66680050,3,1),(66680050,4,1),(66680050,6,1),(66680050,7,1),(66170300,1,0),(66170300,2,0),(66170300,3,1),(66170300,4,1),(66170300,6,0),(66170300,7,0),(66390653,1,0),(66390653,2,1),(66390653,3,0),(66390653,4,0),(66390653,6,0),(66390653,7,1),(33150006,1,0),(33150006,2,0),(33150006,3,0),(33150006,4,1),(33150006,6,0),(33150006,7,0),(33125020,1,9),(33125020,2,0),(33125020,3,0),(33125020,4,2),(33125020,6,0),(33125020,7,2),(66270900,1,1),(66270900,2,0),(66270900,3,0),(66270900,4,0),(66270900,6,0),(66270900,7,0),(33900005,1,2),(33900005,2,0),(33900005,3,0),(33900005,4,0),(33900005,6,0),(33900005,7,1),(33900021,1,4),(33900021,2,0),(33900021,3,0),(33900021,4,0),(33900021,6,0),(33900021,7,8),(11120062,1,1),(11120062,2,1),(11120062,3,1),(11120062,4,1),(11120062,6,1),(11120062,7,1),(66625980,1,0),(66625980,2,1),(66625980,3,1),(66625980,4,0),(66625980,6,1),(66625980,7,0),(66971100,1,5),(66971100,2,2),(66971100,3,1),(66971100,4,2),(66971100,6,2),(66971100,7,2),(66760840,1,0),(66760840,2,1),(66760840,3,0),(66760840,4,0),(66760840,6,1),(66760840,7,0),(66792650,1,12),(66792650,2,2),(66792650,3,2),(66792650,4,1),(66792650,6,1),(66792650,7,1),(33100011,1,1),(33100011,2,0),(33100011,3,0),(33100011,4,0),(33100011,6,0),(33100011,7,2),(33100008,1,11),(33100008,2,2),(33100008,3,2),(33100008,4,3),(33100008,6,3),(33100008,7,3),(33200006,1,3),(33200006,2,2),(33200006,3,2),(33200006,4,2),(33200006,6,1),(33200006,7,2),(33100007,1,1),(33100007,2,3),(33100007,3,3),(33100007,4,3),(33100007,6,2),(33100007,7,1),(11120035,1,0),(11120035,2,0),(11120035,3,0),(11120035,4,0),(11120035,6,0),(11120035,7,1),(66650850,1,2),(66650850,2,0),(66650850,3,1),(66650850,4,0),(66650850,6,0),(66650850,7,0),(66650252,1,0),(66650252,2,1),(66650252,3,0),(66650252,4,1),(66650252,6,1),(66650252,7,2),(66150825,1,12),(66150825,2,1),(66150825,3,2),(66150825,4,2),(66150825,6,1),(66150825,7,3),(66850500,1,168),(66850500,2,2),(66850500,3,3),(66850500,4,1),(66850500,6,1),(66850500,7,1),(66530250,1,0),(66530250,2,0),(66530250,3,1),(66530250,4,0),(66530250,6,0),(66530250,7,0),(66496122,1,29),(66496122,2,4),(66496122,3,4),(66496122,4,3),(66496122,6,4),(66496122,7,5),(66496120,1,0),(66496120,2,4),(66496120,3,1),(66496120,4,3),(66496120,6,2),(66496120,7,5),(66150100,1,0),(66150100,2,0),(66150100,3,0),(66150100,4,0),(66150100,6,0),(66150100,7,2),(66470253,1,0),(66470253,2,0),(66470253,3,1),(66470253,4,0),(66470253,6,1),(66470253,7,0),(66650250,1,2),(66650250,2,1),(66650250,3,0),(66650250,4,1),(66650250,6,1),(66650250,7,1),(66730255,1,1),(66730255,2,1),(66730255,3,1),(66730255,4,0),(66730255,6,0),(66730255,7,1),(66930041,1,129),(66930041,2,1),(66930041,3,3),(66930041,4,3),(66930041,6,2),(66930041,7,2),(66430250,1,0),(66430250,2,1),(66430250,3,2),(66430250,4,0),(66430250,6,1),(66430250,7,1),(66190250,1,0),(66190250,2,1),(66190250,3,1),(66190250,4,1),(66190250,6,1),(66190250,7,0),(66865052,1,0),(66865052,2,0),(66865052,3,2),(66865052,4,0),(66865052,6,1),(66865052,7,1),(66150044,1,0),(66150044,2,1),(66150044,3,1),(66150044,4,0),(66150044,6,0),(66150044,7,1),(66830250,1,2),(66830250,2,2),(66830250,3,0),(66830250,4,1),(66830250,6,1),(66830250,7,2),(11120058,1,0),(11120058,2,1),(11120058,3,0),(11120058,4,0),(11120058,6,0),(11120058,7,1),(11120060,1,0),(11120060,2,1),(11120060,3,0),(11120060,4,0),(11120060,6,0),(11120060,7,0),(11120042,1,0),(11120042,2,1),(11120042,3,1),(11120042,4,0),(11120042,6,0),(11120042,7,1),(33150005,1,1),(33150005,2,1),(33150005,3,1),(33150005,4,1),(33150005,6,1),(33150005,7,1),(66470908,1,0),(66470908,2,0),(66470908,3,0),(66470908,4,1),(66470908,6,0),(66470908,7,0),(66792655,1,1),(66792655,2,0),(66792655,3,0),(66792655,4,0),(66792655,6,0),(66792655,7,0),(33125007,1,2),(33125007,2,1),(33125007,3,2),(33125007,4,2),(33125007,6,1),(33125007,7,2),(33150007,1,0),(33150007,2,1),(33150007,3,1),(33150007,4,1),(33150007,6,1),(33150007,7,1),(66470666,1,0),(66470666,2,0),(66470666,3,1),(66470666,4,2),(66470666,6,1),(66470666,7,2),(33805023,1,0),(33805023,2,1),(33805023,3,1),(33805023,4,0),(33805023,6,1),(33805023,7,0),(33125022,1,0),(33125022,2,1),(33125022,3,1),(33125022,4,1),(33125022,6,1),(33125022,7,1),(66491002,1,18),(66491002,2,0),(66491002,3,7),(66491002,4,3),(66491002,6,14),(66491002,7,8),(66340100,1,0),(66340100,2,0),(66340100,3,0),(66340100,4,1),(66340100,6,0),(66340100,7,0),(66340400,1,0),(66340400,2,1),(66340400,3,1),(66340400,4,0),(66340400,6,0),(66340400,7,0),(33805005,1,6),(33805005,2,1),(33805005,3,2),(33805005,4,1),(33805005,6,1),(33805005,7,2),(66930155,1,0),(66930155,2,1),(66930155,3,1),(66930155,4,1),(66930155,6,0),(66930155,7,1),(66490970,1,1),(66490970,2,0),(66490970,3,0),(66490970,4,1),(66490970,6,0),(66490970,7,1),(66790970,1,5),(66790970,2,2),(66790970,3,1),(66790970,4,2),(66790970,6,2),(66790970,7,1),(66350050,1,2),(66350050,2,1),(66350050,3,1),(66350050,4,1),(66350050,6,1),(66350050,7,0),(33300012,1,88),(33300012,2,0),(33300012,3,3),(33300012,4,0),(33300012,6,8),(33300012,7,2),(33150009,1,1),(33150009,2,0),(33150009,3,0),(33150009,4,1),(33150009,6,1),(33150009,7,1),(33125013,1,5),(33125013,2,0),(33125013,3,1),(33125013,4,1),(33125013,6,0),(33125013,7,1),(33800022,1,0),(33800022,2,1),(33800022,3,2),(33800022,4,1),(33800022,6,0),(33800022,7,0),(33800018,1,0),(33800018,2,0),(33800018,3,1),(33800018,4,1),(33800018,6,0),(33800018,7,0),(33800004,1,0),(33800004,2,0),(33800004,3,0),(33800004,4,0),(33800004,6,0),(33800004,7,1),(33800025,1,0),(33800025,2,1),(33800025,3,0),(33800025,4,0),(33800025,6,0),(33800025,7,0),(33800007,1,0),(33800007,2,0),(33800007,3,1),(33800007,4,0),(33800007,6,0),(33800007,7,0),(33800024,1,0),(33800024,2,0),(33800024,3,0),(33800024,4,0),(33800024,6,1),(33800024,7,1),(33800029,1,1),(33800029,2,0),(33800029,3,0),(33800029,4,0),(33800029,6,0),(33800029,7,0),(33800008,1,0),(33800008,2,0),(33800008,3,0),(33800008,4,1),(33800008,6,1),(33800008,7,0),(33800009,1,0),(33800009,2,0),(33800009,3,0),(33800009,4,1),(33800009,6,0),(33800009,7,0),(33800012,1,0),(33800012,2,0),(33800012,3,0),(33800012,4,1),(33800012,6,0),(33800012,7,0),(33800013,1,0),(33800013,2,0),(33800013,3,0),(33800013,4,1),(33800013,6,0),(33800013,7,0),(33800015,1,0),(33800015,2,0),(33800015,3,1),(33800015,4,0),(33800015,6,0),(33800015,7,0),(33800016,1,0),(33800016,2,0),(33800016,3,1),(33800016,4,0),(33800016,6,0),(33800016,7,0),(66360950,1,3),(66360950,2,0),(66360950,3,0),(66360950,4,1),(66360950,6,0),(66360950,7,0),(66360650,1,0),(66360650,2,0),(66360650,3,1),(66360650,4,0),(66360650,6,0),(66360650,7,0),(66360653,1,29),(66360653,2,3),(66360653,3,0),(66360653,4,3),(66360653,6,2),(66360653,7,4),(66150104,1,7),(66150104,2,0),(66150104,3,0),(66150104,4,0),(66150104,6,2),(66150104,7,0),(66497650,1,3),(66497650,2,2),(66497650,3,3),(66497650,4,0),(66497650,6,2),(66497650,7,1),(66150400,1,3),(66150400,2,0),(66150400,3,0),(66150400,4,0),(66150400,6,0),(66150400,7,0),(66150048,1,2),(66150048,2,0),(66150048,3,0),(66150048,4,0),(66150048,6,0),(66150048,7,0),(66480900,1,0),(66480900,2,1),(66480900,3,1),(66480900,4,2),(66480900,6,0),(66480900,7,1),(11120015,1,1),(11120015,2,0),(11120015,3,0),(11120015,4,0),(11120015,6,1),(11120015,7,0),(11120016,1,22),(11120016,2,3),(11120016,3,6),(11120016,4,6),(11120016,6,4),(11120016,7,6),(11120014,1,0),(11120014,2,0),(11120014,3,1),(11120014,4,1),(11120014,6,0),(11120014,7,0),(11120046,1,1),(11120046,2,0),(11120046,3,0),(11120046,4,1),(11120046,6,0),(11120046,7,0),(11120010,1,27),(11120010,2,3),(11120010,3,3),(11120010,4,5),(11120010,6,3),(11120010,7,7),(66730950,1,0),(66730950,2,0),(66730950,3,1),(66730950,4,1),(66730950,6,1),(66730950,7,0),(33100013,1,1),(33100013,2,0),(33100013,3,0),(33100013,4,0),(33100013,6,0),(33100013,7,0),(11130008,1,0),(11130008,2,0),(11130008,3,0),(11130008,4,0),(11130008,6,0),(11130008,7,1),(33805019,1,0),(33805019,2,1),(33805019,3,0),(33805019,4,0),(33805019,6,1),(33805019,7,1),(66861055,1,1),(66861055,2,1),(66861055,3,1),(66861055,4,1),(66861055,6,1),(66861055,7,1),(66620055,1,3),(66620055,2,1),(66620055,3,1),(66620055,4,1),(66620055,6,1),(66620055,7,1),(66390800,1,2),(66390800,2,1),(66390800,3,1),(66390800,4,1),(66390800,6,1),(66390800,7,1),(66530910,1,0),(66530910,2,0),(66530910,3,1),(66530910,4,1),(66530910,6,0),(66530910,7,1),(66810900,1,1),(66810900,2,1),(66810900,3,0),(66810900,4,1),(66810900,6,1),(66810900,7,1),(66400007,1,17),(66400007,2,5),(66400007,3,4),(66400007,4,7),(66400007,6,11),(66400007,7,4),(66400004,1,0),(66400004,2,0),(66400004,3,1),(66400004,4,1),(66400004,6,0),(66400004,7,0),(66965780,1,1),(66965780,2,0),(66965780,3,1),(66965780,4,1),(66965780,6,0),(66965780,7,1),(66940450,1,86),(66940450,2,1),(66940450,3,3),(66940450,4,2),(66940450,6,2),(66940450,7,3),(66795450,1,0),(66795450,2,0),(66795450,3,1),(66795450,4,1),(66795450,6,1),(66795450,7,0),(33900109,1,1),(33900109,2,1),(33900109,3,0),(33900109,4,0),(33900109,6,0),(33900109,7,0),(33360890,1,1),(33360890,2,0),(33360890,3,0),(33360890,4,0),(33360890,6,0),(33360890,7,0),(33900008,1,6),(33900008,2,0),(33900008,3,0),(33900008,4,8),(33900008,6,3),(33900008,7,0),(33900015,1,5),(33900015,2,1),(33900015,3,1),(33900015,4,1),(33900015,6,1),(33900015,7,1),(33900009,1,2),(33900009,2,0),(33900009,3,0),(33900009,4,0),(33900009,6,9),(33900009,7,0),(33900012,1,10),(33900012,2,2),(33900012,3,1),(33900012,4,2),(33900012,6,0),(33900012,7,2),(66770057,1,0),(66770057,2,0),(66770057,3,0),(66770057,4,1),(66770057,6,0),(66770057,7,1),(11130018,1,0),(11130018,2,0),(11130018,3,0),(11130018,4,0),(11130018,6,0),(11130018,7,1),(66361250,1,0),(66361250,2,0),(66361250,3,0),(66361250,4,0),(66361250,6,0),(66361250,7,1),(11120032,1,0),(11120032,2,0),(11120032,3,2),(11120032,4,0),(11120032,6,0),(11120032,7,1),(11120028,1,39),(11120028,2,3),(11120028,3,4),(11120028,4,4),(11120028,6,5),(11120028,7,1),(33125016,1,0),(33125016,2,0),(33125016,3,0),(33125016,4,1),(33125016,6,0),(33125016,7,0),(66760005,1,0),(66760005,2,0),(66760005,3,2),(66760005,4,0),(66760005,6,0),(66760005,7,0),(66470250,1,42),(66470250,2,0),(66470250,3,1),(66470250,4,0),(66470250,6,2),(66470250,7,0),(66730651,1,0),(66730651,2,8),(66730651,3,7),(66730651,4,8),(66730651,6,6),(66730651,7,8),(66150800,1,9),(66150800,2,2),(66150800,3,2),(66150800,4,2),(66150800,6,2),(66150800,7,2),(66730653,1,297),(66730653,2,3),(66730653,3,2),(66730653,4,1),(66730653,6,2),(66730653,7,2),(66470300,1,1),(66470300,2,1),(66470300,3,1),(66470300,4,1),(66470300,6,1),(66470300,7,1),(66730810,1,4),(66730810,2,0),(66730810,3,1),(66730810,4,0),(66730810,6,1),(66730810,7,0),(66770058,1,0),(66770058,2,0),(66770058,3,1),(66770058,4,1),(66770058,6,0),(66770058,7,0),(66610900,1,1),(66610900,2,1),(66610900,3,1),(66610900,4,1),(66610900,6,1),(66610900,7,1),(33805051,1,0),(33805051,2,0),(33805051,3,1),(33805051,4,1),(33805051,6,1),(33805051,7,0),(66390995,1,1),(66390995,2,0),(66390995,3,0),(66390995,4,0),(66390995,6,0),(66390995,7,0),(66470900,1,20),(66470900,2,1),(66470900,3,1),(66470900,4,1),(66470900,6,1),(66470900,7,1),(66470899,1,4),(66470899,2,0),(66470899,3,1),(66470899,4,2),(66470899,6,0),(66470899,7,0),(66470930,1,0),(66470930,2,0),(66470930,3,0),(66470930,4,1),(66470930,6,0),(66470930,7,1),(66470660,1,2),(66470660,2,0),(66470660,3,0),(66470660,4,1),(66470660,6,0),(66470660,7,0),(66470055,1,5),(66470055,2,1),(66470055,3,1),(66470055,4,1),(66470055,6,1),(66470055,7,1),(66695950,1,18),(66695950,2,1),(66695950,3,2),(66695950,4,1),(66695950,6,1),(66695950,7,2),(66778150,1,0),(66778150,2,0),(66778150,3,1),(66778150,4,0),(66778150,6,0),(66778150,7,0),(66421001,1,0),(66421001,2,1),(66421001,3,1),(66421001,4,0),(66421001,6,1),(66421001,7,1),(66980200,1,12),(66980200,2,2),(66980200,3,2),(66980200,4,3),(66980200,6,1),(66980200,7,2),(66150500,1,7),(66150500,2,2),(66150500,3,2),(66150500,4,2),(66150500,6,2),(66150500,7,2),(66350931,1,0),(66350931,2,0),(66350931,3,0),(66350931,4,0),(66350931,6,1),(66350931,7,0),(66350930,1,3),(66350930,2,0),(66350930,3,1),(66350930,4,1),(66350930,6,0),(66350930,7,1),(66170931,1,0),(66170931,2,0),(66170931,3,1),(66170931,4,0),(66170931,6,0),(66170931,7,1),(66790930,1,1),(66790930,2,1),(66790930,3,1),(66790930,4,0),(66790930,6,0),(66790930,7,0),(66730920,1,0),(66730920,2,0),(66730920,3,1),(66730920,4,0),(66730920,6,0),(66730920,7,0),(66340900,1,1),(66340900,2,0),(66340900,3,0),(66340900,4,1),(66340900,6,1),(66340900,7,0),(66895650,1,0),(66895650,2,0),(66895650,3,1),(66895650,4,0),(66895650,6,0),(66895650,7,1),(66090998,1,5),(66090998,2,0),(66090998,3,0),(66090998,4,0),(66090998,6,0),(66090998,7,0),(66788980,1,2),(66788980,2,0),(66788980,3,0),(66788980,4,0),(66788980,6,0),(66788980,7,0),(66830400,1,0),(66830400,2,0),(66830400,3,1),(66830400,4,1),(66830400,6,1),(66830400,7,1),(66830405,1,132),(66830405,2,1),(66830405,3,1),(66830405,4,2),(66830405,6,3),(66830405,7,2),(66150103,1,13),(66150103,2,0),(66150103,3,2),(66150103,4,1),(66150103,6,2),(66150103,7,2),(66150125,1,0),(66150125,2,0),(66150125,3,0),(66150125,4,1),(66150125,6,0),(66150125,7,1),(66830750,1,0),(66830750,2,0),(66830750,3,1),(66830750,4,0),(66830750,6,0),(66830750,7,1),(66390980,1,0),(66390980,2,0),(66390980,3,1),(66390980,4,0),(66390980,6,0),(66390980,7,0),(66830980,1,2),(66830980,2,1),(66830980,3,1),(66830980,4,1),(66830980,6,1),(66830980,7,0),(66390501,1,1),(66390501,2,1),(66390501,3,1),(66390501,4,1),(66390501,6,1),(66390501,7,1),(66530500,1,0),(66530500,2,0),(66530500,3,0),(66530500,4,1),(66530500,6,0),(66530500,7,1),(66010003,1,0),(66010003,2,2),(66010003,3,4),(66010003,4,1),(66010003,6,1),(66010003,7,2),(66390500,1,0),(66390500,2,0),(66390500,3,0),(66390500,4,1),(66390500,6,0),(66390500,7,0),(66130500,1,28),(66130500,2,9),(66130500,3,2),(66130500,4,5),(66130500,6,8),(66130500,7,13),(66470906,1,0),(66470906,2,0),(66470906,3,0),(66470906,4,0),(66470906,6,1),(66470906,7,1),(33805037,1,0),(33805037,2,0),(33805037,3,1),(33805037,4,1),(33805037,6,1),(33805037,7,1),(99915100,1,0),(99915100,2,0),(99915100,3,0),(99915100,4,0),(99915100,6,0),(99915100,7,2),(33100012,1,1),(33100012,2,0),(33100012,3,0),(33100012,4,0),(33100012,6,0),(33100012,7,1),(11130001,1,0),(11130001,2,0),(11130001,3,0),(11130001,4,0),(11130001,6,0),(11130001,7,2),(33100016,1,2),(33100016,2,0),(33100016,3,0),(33100016,4,0),(33100016,6,0),(33100016,7,2),(66680056,1,0),(66680056,2,0),(66680056,3,1),(66680056,4,0),(66680056,6,0),(66680056,7,0),(33125018,1,2),(33125018,2,0),(33125018,3,0),(33125018,4,0),(33125018,6,0),(33125018,7,1),(66390655,1,0),(66390655,2,0),(66390655,3,1),(66390655,4,0),(66390655,6,0),(66390655,7,0),(11040012,1,1),(11040012,2,0),(11040012,3,0),(11040012,4,0),(11040012,6,0),(11040012,7,0),(66730302,1,1),(66730302,2,0),(66730302,3,0),(66730302,4,0),(66730302,6,0),(66730302,7,0),(66730909,1,0),(66730909,2,0),(66730909,3,1),(66730909,4,0),(66730909,6,0),(66730909,7,0),(66730901,1,0),(66730901,2,0),(66730901,3,1),(66730901,4,1),(66730901,6,0),(66730901,7,0),(66730970,1,0),(66730970,2,1),(66730970,3,1),(66730970,4,1),(66730970,6,1),(66730970,7,1),(66730908,1,42),(66730908,2,2),(66730908,3,2),(66730908,4,2),(66730908,6,2),(66730908,7,2),(66730890,1,2),(66730890,2,0),(66730890,3,1),(66730890,4,1),(66730890,6,0),(66730890,7,0),(66730900,1,3),(66730900,2,0),(66730900,3,1),(66730900,4,1),(66730900,6,1),(66730900,7,0),(66150420,1,0),(66150420,2,0),(66150420,3,0),(66150420,4,1),(66150420,6,0),(66150420,7,0),(66417655,1,0),(66417655,2,0),(66417655,3,0),(66417655,4,0),(66417655,6,1),(66417655,7,1),(66430904,1,0),(66430904,2,0),(66430904,3,0),(66430904,4,1),(66430904,6,1),(66430904,7,0),(66430905,1,0),(66430905,2,1),(66430905,3,1),(66430905,4,1),(66430905,6,1),(66430905,7,1),(66430903,1,0),(66430903,2,0),(66430903,3,0),(66430903,4,1),(66430903,6,0),(66430903,7,1),(66430901,1,1),(66430901,2,0),(66430901,3,0),(66430901,4,1),(66430901,6,0),(66430901,7,0),(66390990,1,4),(66390990,2,1),(66390990,3,1),(66390990,4,1),(66390990,6,1),(66390990,7,1),(66430970,1,0),(66430970,2,0),(66430970,3,1),(66430970,4,1),(66430970,6,1),(66430970,7,0),(11160003,1,0),(11160003,2,0),(11160003,3,1),(11160003,4,1),(11160003,6,2),(11160003,7,1),(66150050,1,1),(66150050,2,1),(66150050,3,0),(66150050,4,0),(66150050,6,0),(66150050,7,0),(66499900,1,3),(66499900,2,1),(66499900,3,1),(66499900,4,2),(66499900,6,1),(66499900,7,1),(66650650,1,2),(66650650,2,1),(66650650,3,0),(66650650,4,1),(66650650,6,1),(66650650,7,1),(33100019,1,0),(33100019,2,0),(33100019,3,1),(33100019,4,2),(33100019,6,0),(33100019,7,0),(33100009,1,0),(33100009,2,0),(33100009,3,1),(33100009,4,1),(33100009,6,1),(33100009,7,0),(66620905,1,3),(66620905,2,0),(66620905,3,1),(66620905,4,0),(66620905,6,0),(66620905,7,2),(66895900,1,0),(66895900,2,0),(66895900,3,1),(66895900,4,1),(66895900,6,1),(66895900,7,1),(11120034,1,0),(11120034,2,0),(11120034,3,1),(11120034,4,1),(11120034,6,1),(11120034,7,0),(66421400,1,0),(66421400,2,0),(66421400,3,1),(66421400,4,1),(66421400,6,1),(66421400,7,1),(66610406,1,0),(66610406,2,1),(66610406,3,0),(66610406,4,1),(66610406,6,1),(66610406,7,0),(66610400,1,31),(66610400,2,2),(66610400,3,1),(66610400,4,2),(66610400,6,1),(66610400,7,2),(33125008,1,3),(33125008,2,1),(33125008,3,1),(33125008,4,2),(33125008,6,0),(33125008,7,1),(33805025,1,0),(33805025,2,0),(33805025,3,0),(33805025,4,1),(33805025,6,1),(33805025,7,0),(33150021,1,0),(33150021,2,0),(33150021,3,0),(33150021,4,1),(33150021,6,0),(33150021,7,0),(11130022,1,0),(11130022,2,0),(11130022,3,0),(11130022,4,0),(11130022,6,0),(11130022,7,1),(66530800,1,0),(66530800,2,0),(66530800,3,1),(66530800,4,0),(66530800,6,0),(66530800,7,1),(331500223,1,2),(331500223,2,0),(331500223,3,1),(331500223,4,1),(331500223,6,0),(331500223,7,1),(66250903,1,1),(66250903,2,1),(66250903,3,1),(66250903,4,1),(66250903,6,1),(66250903,7,1),(33125015,1,0),(33125015,2,1),(33125015,3,1),(33125015,4,1),(33125015,6,0),(33125015,7,0),(66390600,1,1),(66390600,2,2),(66390600,3,1),(66390600,4,2),(66390600,6,1),(66390600,7,2),(66650605,1,3),(66650605,2,1),(66650605,3,2),(66650605,4,2),(66650605,6,1),(66650605,7,1),(66730800,1,14),(66730800,2,1),(66730800,3,1),(66730800,4,1),(66730800,6,1),(66730800,7,1),(66630990,1,0),(66630990,2,0),(66630990,3,0),(66630990,4,1),(66630990,6,0),(66630990,7,0),(66630991,1,0),(66630991,2,3),(66630991,3,0),(66630991,4,0),(66630991,6,0),(66630991,7,0),(66650401,1,11),(66650401,2,0),(66650401,3,0),(66650401,4,1),(66650401,6,1),(66650401,7,0),(66650651,1,2),(66650651,2,1),(66650651,3,0),(66650651,4,1),(66650651,6,0),(66650651,7,0),(66640800,1,0),(66640800,2,1),(66640800,3,1),(66640800,4,1),(66640800,6,1),(66640800,7,1),(66430913,1,0),(66430913,2,0),(66430913,3,1),(66430913,4,0),(66430913,6,0),(66430913,7,0),(33805009,1,4),(33805009,2,0),(33805009,3,1),(33805009,4,1),(33805009,6,1),(33805009,7,1),(33805011,1,0),(33805011,2,0),(33805011,3,1),(33805011,4,1),(33805011,6,1),(33805011,7,0),(33805013,1,1),(33805013,2,1),(33805013,3,1),(33805013,4,1),(33805013,6,1),(33805013,7,1),(66420902,1,0),(66420902,2,0),(66420902,3,1),(66420902,4,0),(66420902,6,0),(66420902,7,0),(66730921,1,1),(66730921,2,0),(66730921,3,0),(66730921,4,0),(66730921,6,0),(66730921,7,0),(66150450,1,7),(66150450,2,0),(66150450,3,0),(66150450,4,0),(66150450,6,0),(66150450,7,0),(66390651,1,2),(66390651,2,1),(66390651,3,0),(66390651,4,1),(66390651,6,2),(66390651,7,1),(66390658,1,336),(66390658,2,2),(66390658,3,3),(66390658,4,4),(66390658,6,4),(66390658,7,3),(66390659,1,18),(66390659,2,1),(66390659,3,1),(66390659,4,0),(66390659,6,0),(66390659,7,1),(66610050,1,0),(66610050,2,0),(66610050,3,0),(66610050,4,1),(66610050,6,0),(66610050,7,0),(66610052,1,0),(66610052,2,1),(66610052,3,0),(66610052,4,0),(66610052,6,1),(66610052,7,0),(33125002,1,1),(33125002,2,1),(33125002,3,0),(33125002,4,1),(33125002,6,0),(33125002,7,0),(66700300,1,0),(66700300,2,0),(66700300,3,1),(66700300,4,0),(66700300,6,0),(66700300,7,0),(66680140,1,0),(66680140,2,0),(66680140,3,0),(66680140,4,1),(66680140,6,0),(66680140,7,0),(66050700,1,0),(66050700,2,0),(66050700,3,1),(66050700,4,1),(66050700,6,0),(66050700,7,0),(66830298,1,0),(66830298,2,0),(66830298,3,2),(66830298,4,2),(66830298,6,1),(66830298,7,1),(66390757,1,0),(66390757,2,0),(66390757,3,0),(66390757,4,0),(66390757,6,1),(66390757,7,0),(66980600,1,67),(66980600,2,3),(66980600,3,2),(66980600,4,2),(66980600,6,2),(66980600,7,4),(66980550,1,73),(66980550,2,3),(66980550,3,3),(66980550,4,3),(66980550,6,3),(66980550,7,2),(33125023,1,4),(33125023,2,1),(33125023,3,2),(33125023,4,2),(33125023,6,1),(33125023,7,2),(33150010,1,1),(33150010,2,2),(33150010,3,2),(33150010,4,2),(33150010,6,1),(33150010,7,1),(66377801,1,0),(66377801,2,0),(66377801,3,1),(66377801,4,0),(66377801,6,0),(66377801,7,0),(33125019,1,5),(33125019,2,0),(33125019,3,1),(33125019,4,0),(33125019,6,0),(33125019,7,0),(33150011,1,0),(33150011,2,1),(33150011,3,1),(33150011,4,1),(33150011,6,1),(33150011,7,1),(66771400,1,0),(66771400,2,1),(66771400,3,1),(66771400,4,1),(66771400,6,1),(66771400,7,0),(11120008,1,10),(11120008,2,1),(11120008,3,1),(11120008,4,1),(11120008,6,1),(11120008,7,1),(11130009,1,1),(11130009,2,0),(11130009,3,0),(11130009,4,0),(11130009,6,0),(11130009,7,0),(11120011,1,0),(11120011,2,2),(11120011,3,1),(11120011,4,1),(11120011,6,2),(11120011,7,1),(11120012,1,3),(11120012,2,0),(11120012,3,0),(11120012,4,0),(11120012,6,0),(11120012,7,0),(11120044,1,0),(11120044,2,1),(11120044,3,0),(11120044,4,0),(11120044,6,0),(11120044,7,1),(11120018,1,24),(11120018,2,1),(11120018,3,2),(11120018,4,3),(11120018,6,0),(11120018,7,3),(11120022,1,30),(11120022,2,3),(11120022,3,3),(11120022,4,3),(11120022,6,3),(11120022,7,2),(11120023,1,0),(11120023,2,2),(11120023,3,0),(11120023,4,2),(11120023,6,2),(11120023,7,3),(11120019,1,0),(11120019,2,0),(11120019,3,1),(11120019,4,1),(11120019,6,2),(11120019,7,4),(33805017,1,0),(33805017,2,1),(33805017,3,0),(33805017,4,0),(33805017,6,1),(33805017,7,0),(33805018,1,1),(33805018,2,1),(33805018,3,1),(33805018,4,0),(33805018,6,1),(33805018,7,1),(33200008,1,129),(33200008,2,2),(33200008,3,2),(33200008,4,3),(33200008,6,2),(33200008,7,3),(33300020,1,1),(33300020,2,1),(33300020,3,2),(33300020,4,0),(33300020,6,0),(33300020,7,0),(33300021,1,0),(33300021,2,0),(33300021,3,0),(33300021,4,0),(33300021,6,0),(33300021,7,1),(66776980,1,3),(66776980,2,1),(66776980,3,2),(66776980,4,2),(66776980,6,2),(66776980,7,3),(66710901,1,3),(66710901,2,1),(66710901,3,1),(66710901,4,1),(66710901,6,1),(66710901,7,1),(66710900,1,2),(66710900,2,1),(66710900,3,1),(66710900,4,1),(66710900,6,1),(66710900,7,1),(6693004,1,0),(6693004,2,0),(6693004,3,1),(6693004,4,0),(6693004,6,0),(6693004,7,0),(66610105,1,3),(66610105,2,1),(66610105,3,1),(66610105,4,1),(66610105,6,1),(66610105,7,0),(66610300,1,117),(66610300,2,1),(66610300,3,1),(66610300,4,1),(66610300,6,3),(66610300,7,1),(11130016,1,4),(11130016,2,0),(11130016,3,0),(11130016,4,0),(11130016,6,0),(11130016,7,5),(11130007,1,0),(11130007,2,0),(11130007,3,0),(11130007,4,0),(11130007,6,0),(11130007,7,2),(11130003,1,0),(11130003,2,0),(11130003,3,0),(11130003,4,0),(11130003,6,0),(11130003,7,1),(11130025,1,0),(11130025,2,0),(11130025,3,0),(11130025,4,0),(11130025,6,0),(11130025,7,1),(11130023,1,0),(11130023,2,0),(11130023,3,0),(11130023,4,0),(11130023,6,0),(11130023,7,2),(11120038,1,0),(11120038,2,0),(11120038,3,1),(11120038,4,0),(11120038,6,0),(11120038,7,0),(11120004,1,1),(11120004,2,0),(11120004,3,0),(11120004,4,0),(11120004,6,0),(11120004,7,0),(11120005,1,7),(11120005,2,1),(11120005,3,1),(11120005,4,2),(11120005,6,1),(11120005,7,1),(11120050,1,3),(11120050,2,0),(11120050,3,0),(11120050,4,0),(11120050,6,0),(11120050,7,0),(66160006,1,2),(66160006,2,1),(66160006,3,2),(66160006,4,1),(66160006,6,1),(66160006,7,2),(66365151,1,2),(66365151,2,1),(66365151,3,1),(66365151,4,1),(66365151,6,1),(66365151,7,0),(66830652,1,2),(66830652,2,0),(66830652,3,0),(66830652,4,0),(66830652,6,0),(66830652,7,0),(66490980,1,0),(66490980,2,0),(66490980,3,1),(66490980,4,0),(66490980,6,1),(66490980,7,1),(66160009,1,0),(66160009,2,1),(66160009,3,1),(66160009,4,0),(66160009,6,0),(66160009,7,0),(66770405,1,0),(66770405,2,0),(66770405,3,1),(66770405,4,1),(66770405,6,0),(66770405,7,1),(33820003,1,1),(33820003,2,0),(33820003,3,0),(33820003,4,1),(33820003,6,1),(33820003,7,1),(33125012,1,0),(33125012,2,1),(33125012,3,0),(33125012,4,1),(33125012,6,1),(33125012,7,0),(33805027,1,0),(33805027,2,1),(33805027,3,1),(33805027,4,0),(33805027,6,1),(33805027,7,1),(33150012,1,1),(33150012,2,0),(33150012,3,0),(33150012,4,1),(33150012,6,1),(33150012,7,0),(66150105,1,0),(66150105,2,0),(66150105,3,0),(66150105,4,0),(66150105,6,0),(66150105,7,1),(66150150,1,0),(66150150,2,0),(66150150,3,0),(66150150,4,0),(66150150,6,1),(66150150,7,1),(33150013,1,0),(33150013,2,0),(33150013,3,1),(33150013,4,1),(33150013,6,1),(33150013,7,0),(66630971,1,0),(66630971,2,0),(66630971,3,0),(66630971,4,2),(66630971,6,0),(66630971,7,0),(11120047,1,1),(11120047,2,1),(11120047,3,2),(11120047,4,2),(11120047,6,2),(11120047,7,2),(11120049,1,10),(11120049,2,2),(11120049,3,2),(11120049,4,2),(11120049,6,2),(11120049,7,2),(66499905,1,4),(66499905,2,0),(66499905,3,2),(66499905,4,1),(66499905,6,1),(66499905,7,2),(66380055,1,0),(66380055,2,0),(66380055,3,0),(66380055,4,0),(66380055,6,0),(66380055,7,1),(33805014,1,1),(33805014,2,1),(33805014,3,1),(33805014,4,1),(33805014,6,1),(33805014,7,1),(33150014,1,0),(33150014,2,0),(33150014,3,0),(33150014,4,1),(33150014,6,0),(33150014,7,1),(66470651,1,16),(66470651,2,3),(66470651,3,5),(66470651,4,5),(66470651,6,3),(66470651,7,3),(66470658,1,1),(66470658,2,1),(66470658,3,0),(66470658,4,1),(66470658,6,1),(66470658,7,2),(66470655,1,1),(66470655,2,2),(66470655,3,1),(66470655,4,2),(66470655,6,2),(66470655,7,2),(66470901,1,2),(66470901,2,2),(66470901,3,2),(66470901,4,3),(66470901,6,1),(66470901,7,2),(66470652,1,7),(66470652,2,2),(66470652,3,1),(66470652,4,3),(66470652,6,2),(66470652,7,2),(66470653,1,1),(66470653,2,1),(66470653,3,2),(66470653,4,2),(66470653,6,1),(66470653,7,1),(66470841,1,5),(66470841,2,1),(66470841,3,2),(66470841,4,2),(66470841,6,2),(66470841,7,2),(66470750,1,5),(66470750,2,1),(66470750,3,0),(66470750,4,1),(66470750,6,1),(66470750,7,1),(66570501,1,360),(66570501,2,5),(66570501,3,4),(66570501,4,2),(66570501,6,6),(66570501,7,2),(33200003,1,60),(33200003,2,3),(33200003,3,1),(33200003,4,1),(33200003,6,4),(33200003,7,6),(66930050,1,0),(66930050,2,1),(66930050,3,0),(66930050,4,0),(66930050,6,0),(66930050,7,0),(66810052,1,29),(66810052,2,2),(66810052,3,2),(66810052,4,2),(66810052,6,2),(66810052,7,2),(66810050,1,3),(66810050,2,0),(66810050,3,0),(66810050,4,0),(66810050,6,0),(66810050,7,0),(66430912,1,1),(66430912,2,0),(66430912,3,0),(66430912,4,0),(66430912,6,0),(66430912,7,0),(66795905,1,36),(66795905,2,6),(66795905,3,11),(66795905,4,10),(66795905,6,7),(66795905,7,8),(66405900,1,0),(66405900,2,1),(66405900,3,0),(66405900,4,0),(66405900,6,0),(66405900,7,0),(66965900,1,1),(66965900,2,0),(66965900,3,0),(66965900,4,0),(66965900,6,0),(66965900,7,0),(66680180,1,0),(66680180,2,0),(66680180,3,1),(66680180,4,0),(66680180,6,0),(66680180,7,1),(66971150,1,0),(66971150,2,0),(66971150,3,1),(66971150,4,1),(66971150,6,0),(66971150,7,0),(66130153,1,6),(66130153,2,1),(66130153,3,0),(66130153,4,0),(66130153,6,1),(66130153,7,0),(11120054,1,0),(11120054,2,2),(11120054,3,1),(11120054,4,0),(11120054,6,2),(11120054,7,2),(11080003,1,6),(11080003,2,1),(11080003,3,2),(11080003,4,2),(11080003,6,0),(11080003,7,2),(11080001,1,1),(11080001,2,0),(11080001,3,0),(11080001,4,0),(11080001,6,0),(11080001,7,0),(11120055,1,1),(11120055,2,0),(11120055,3,0),(11120055,4,0),(11120055,6,0),(11120055,7,0),(66840800,1,0),(66840800,2,1),(66840800,3,3),(66840800,4,2),(66840800,6,1),(66840800,7,1),(66840805,1,4),(66840805,2,1),(66840805,3,0),(66840805,4,1),(66840805,6,0),(66840805,7,0),(66840806,1,10),(66840806,2,2),(66840806,3,2),(66840806,4,1),(66840806,6,1),(66840806,7,2),(66130651,1,0),(66130651,2,0),(66130651,3,0),(66130651,4,0),(66130651,6,0),(66130651,7,1),(33805046,1,0),(33805046,2,1),(33805046,3,1),(33805046,4,1),(33805046,6,1),(33805046,7,1),(33805047,1,0),(33805047,2,0),(33805047,3,0),(33805047,4,1),(33805047,6,1),(33805047,7,1),(66470647,1,7),(66470647,2,1),(66470647,3,1),(66470647,4,1),(66470647,6,0),(66470647,7,1),(11120007,1,1),(11120007,2,0),(11120007,3,0),(11120007,4,0),(11120007,6,0),(11120007,7,0),(66770401,1,0),(66770401,2,1),(66770401,3,1),(66770401,4,1),(66770401,6,0),(66770401,7,1),(11120027,1,1),(11120027,2,0),(11120027,3,0),(11120027,4,1),(11120027,6,0),(11120027,7,0),(11120031,1,1),(11120031,2,0),(11120031,3,0),(11120031,4,0),(11120031,6,0),(11120031,7,0),(66440005,1,1),(66440005,2,0),(66440005,3,0),(66440005,4,0),(66440005,6,0),(66440005,7,1),(66490984,1,0),(66490984,2,0),(66490984,3,1),(66490984,4,1),(66490984,6,0),(66490984,7,1),(66490982,1,0),(66490982,2,0),(66490982,3,1),(66490982,4,0),(66490982,6,0),(66490982,7,0),(66230871,1,0),(66230871,2,0),(66230871,3,1),(66230871,4,0),(66230871,6,0),(66230871,7,0),(66290970,1,8),(66290970,2,2),(66290970,3,2),(66290970,4,2),(66290970,6,2),(66290970,7,1),(66410980,1,134),(66410980,2,2),(66410980,3,4),(66410980,4,3),(66410980,6,2),(66410980,7,3),(66470870,1,0),(66470870,2,1),(66470870,3,0),(66470870,4,0),(66470870,6,0),(66470870,7,0),(66510401,1,0),(66510401,2,0),(66510401,3,1),(66510401,4,0),(66510401,6,0),(66510401,7,0),(66650870,1,184),(66650870,2,3),(66650870,3,4),(66650870,4,3),(66650870,6,6),(66650870,7,4),(66650872,1,0),(66650872,2,1),(66650872,3,1),(66650872,4,0),(66650872,6,0),(66650872,7,1),(66850750,1,1),(66850750,2,1),(66850750,3,1),(66850750,4,2),(66850750,6,2),(66850750,7,1),(66890400,1,0),(66890400,2,1),(66890400,3,1),(66890400,4,1),(66890400,6,0),(66890400,7,0),(66890973,1,1),(66890973,2,0),(66890973,3,0),(66890973,4,0),(66890973,6,0),(66890973,7,0),(66150065,1,16),(66150065,2,3),(66150065,3,0),(66150065,4,2),(66150065,6,3),(66150065,7,2),(66900872,1,147),(66900872,2,3),(66900872,3,2),(66900872,4,3),(66900872,6,3),(66900872,7,4),(66930870,1,58),(66930870,2,2),(66930870,3,1),(66930870,4,2),(66930870,6,2),(66930870,7,2),(66150101,1,0),(66150101,2,2),(66150101,3,0),(66150101,4,2),(66150101,6,0),(66150101,7,1),(11130010,1,1),(11130010,2,0),(11130010,3,0),(11130010,4,0),(11130010,6,0),(11130010,7,1),(11130011,1,2),(11130011,2,0),(11130011,3,0),(11130011,4,0),(11130011,6,0),(11130011,7,0),(11130021,1,0),(11130021,2,0),(11130021,3,0),(11130021,4,0),(11130021,6,0),(11130021,7,1),(33900022,1,6),(33900022,2,0),(33900022,3,0),(33900022,4,0),(33900022,6,0),(33900022,7,0),(66830915,1,3),(66830915,2,2),(66830915,3,2),(66830915,4,2),(66830915,6,2),(66830915,7,1),(33830001,1,0),(33830001,2,0),(33830001,3,0),(33830001,4,2),(33830001,6,0),(33830001,7,0),(11080004,1,1),(11080004,2,0),(11080004,3,0),(11080004,4,1),(11080004,6,0),(11080004,7,0),(11080006,1,18),(11080006,2,1),(11080006,3,3),(11080006,4,3),(11080006,6,1),(11080006,7,1),(33150017,1,0),(33150017,2,1),(33150017,3,1),(33150017,4,2),(33150017,6,1),(33150017,7,2),(33805048,1,3),(33805048,2,1),(33805048,3,0),(33805048,4,1),(33805048,6,1),(33805048,7,1),(11160005,1,0),(11160005,2,0),(11160005,3,2),(11160005,4,2),(11160005,6,0),(11160005,7,2),(66778310,1,0),(66778310,2,0),(66778310,3,1),(66778310,4,0),(66778310,6,0),(66778310,7,0),(33300015,1,2),(33300015,2,0),(33300015,3,0),(33300015,4,0),(33300015,6,0),(33300015,7,0),(33150015,1,2),(33150015,2,1),(33150015,3,1),(33150015,4,1),(33150015,6,1),(33150015,7,1),(66861200,1,0),(66861200,2,0),(66861200,3,1),(66861200,4,0),(66861200,6,0),(66861200,7,1),(66430908,1,0),(66430908,2,0),(66430908,3,2),(66430908,4,0),(66430908,6,0),(66430908,7,0),(66365665,1,1),(66365665,2,0),(66365665,3,0),(66365665,4,0),(66365665,6,0),(66365665,7,0),(66862650,1,0),(66862650,2,0),(66862650,3,1),(66862650,4,0),(66862650,6,0),(66862650,7,0),(11130000,1,0),(11130000,2,0),(11130000,3,0),(11130000,4,0),(11130000,6,0),(11130000,7,1),(66360910,1,0),(66360910,2,0),(66360910,3,1),(66360910,4,0),(66360910,6,0),(66360910,7,0),(66560902,1,0),(66560902,2,0),(66560902,3,1),(66560902,4,0),(66560902,6,0),(66560902,7,0),(33805045,1,0),(33805045,2,0),(33805045,3,1),(33805045,4,0),(33805045,6,1),(33805045,7,0),(33125005,1,1),(33125005,2,0),(33125005,3,2),(33125005,4,2),(33125005,6,2),(33125005,7,2),(66710903,1,0),(66710903,2,0),(66710903,3,1),(66710903,4,0),(66710903,6,0),(66710903,7,0),(66190933,1,0),(66190933,2,0),(66190933,3,0),(66190933,4,1),(66190933,6,0),(66190933,7,0),(66190928,1,1),(66190928,2,1),(66190928,3,1),(66190928,4,0),(66190928,6,1),(66190928,7,1),(66190930,1,0),(66190930,2,1),(66190930,3,1),(66190930,4,1),(66190930,6,0),(66190930,7,1),(66730751,1,2),(66730751,2,1),(66730751,3,2),(66730751,4,2),(66730751,6,1),(66730751,7,2),(66430651,1,0),(66430651,2,1),(66430651,3,1),(66430651,4,0),(66430651,6,1),(66430651,7,0),(66480750,1,7),(66480750,2,2),(66480750,3,1),(66480750,4,3),(66480750,6,1),(66480750,7,0),(33125001,1,1),(33125001,2,1),(33125001,3,1),(33125001,4,1),(33125001,6,1),(33125001,7,1),(33125011,1,2),(33125011,2,1),(33125011,3,0),(33125011,4,1),(33125011,6,1),(33125011,7,0),(33125004,1,2),(33125004,2,1),(33125004,3,2),(33125004,4,2),(33125004,6,1),(33125004,7,1),(33125009,1,1),(33125009,2,1),(33125009,3,2),(33125009,4,2),(33125009,6,1),(33125009,7,1),(33805015,1,0),(33805015,2,0),(33805015,3,0),(33805015,4,0),(33805015,6,1),(33805015,7,1),(33805050,1,0),(33805050,2,0),(33805050,3,1),(33805050,4,0),(33805050,6,1),(33805050,7,0),(33805021,1,0),(33805021,2,2),(33805021,3,1),(33805021,4,1),(33805021,6,1),(33805021,7,0),(66390750,1,5),(66390750,2,2),(66390750,3,1),(66390750,4,2),(66390750,6,2),(66390750,7,2),(66390752,1,1),(66390752,2,1),(66390752,3,0),(66390752,4,0),(66390752,6,1),(66390752,7,1),(66390754,1,1),(66390754,2,2),(66390754,3,2),(66390754,4,3),(66390754,6,3),(66390754,7,2),(66795602,1,1),(66795602,2,0),(66795602,3,0),(66795602,4,0),(66795602,6,0),(66795602,7,0),(66491005,1,0),(66491005,2,5),(66491005,3,7),(66491005,4,3),(66491005,6,1),(66491005,7,4),(66270650,1,2),(66270650,2,2),(66270650,3,2),(66270650,4,2),(66270650,6,2),(66270650,7,2),(66025850,1,1),(66025850,2,0),(66025850,3,0),(66025850,4,0),(66025850,6,0),(66025850,7,0),(66779900,1,538),(66779900,2,6),(66779900,3,16),(66779900,4,5),(66779900,6,7),(66779900,7,7),(99910996,1,0),(99910996,2,0),(99910996,3,1),(99910996,4,0),(99910996,6,0),(99910996,7,0),(99910991,1,0),(99910991,2,10),(99910991,3,0),(99910991,4,0),(99910991,6,0),(99910991,7,3),(99910997,1,24),(99910997,2,0),(99910997,3,0),(99910997,4,0),(99910997,6,0),(99910997,7,1),(99910992,1,189),(99910992,2,1),(99910992,3,0),(99910992,4,0),(99910992,6,0),(99910992,7,0),(99915123,1,0),(99915123,2,0),(99915123,3,0),(99915123,4,0),(99915123,6,0),(99915123,7,16),(99910993,1,35),(99910993,2,0),(99910993,3,36),(99910993,4,0),(99910993,6,20),(99910993,7,4),(99910999,1,15),(99910999,2,7),(99910999,3,0),(99910999,4,0),(99910999,6,0),(99910999,7,0),(99910998,1,123),(99910998,2,0),(99910998,3,0),(99910998,4,0),(99910998,6,0),(99910998,7,7),(99910995,1,7),(99910995,2,6),(99910995,3,3),(99910995,4,0),(99910995,6,0),(99910995,7,0),(99911000,1,0),(99911000,2,18),(99911000,3,4),(99911000,4,0),(99911000,6,0),(99911000,7,27),(99915110,1,0),(99915110,2,2),(99915110,3,0),(99915110,4,0),(99915110,6,0),(99915110,7,0),(11120002,1,14),(11120002,2,0),(11120002,3,0),(11120002,4,0),(11120002,6,0),(11120002,7,0),(99911001,1,24),(99911001,2,11),(99911001,3,0),(99911001,4,0),(99911001,6,0),(99911001,7,15),(9911003,1,40),(9911003,2,34),(9911003,3,0),(9911003,4,0),(9911003,6,0),(9911003,7,33),(99911002,1,24),(99911002,2,12),(99911002,3,0),(99911002,4,0),(99911002,6,0),(99911002,7,13),(33125006,1,4),(33125006,2,1),(33125006,3,0),(33125006,4,1),(33125006,6,1),(33125006,7,1),(33125003,1,1),(33125003,2,1),(33125003,3,1),(33125003,4,2),(33125003,6,1),(33125003,7,0),(33300013,1,2),(33300013,2,0),(33300013,3,0),(33300013,4,0),(33300013,6,0),(33300013,7,0),(33150018,1,0),(33150018,2,0),(33150018,3,0),(33150018,4,1),(33150018,6,0),(33150018,7,0),(33900010,1,6),(33900010,2,0),(33900010,3,0),(33900010,4,0),(33900010,6,0),(33900010,7,8),(66470751,1,5),(66470751,2,2),(66470751,3,2),(66470751,4,2),(66470751,6,2),(66470751,7,1),(66377800,1,0),(66377800,2,0),(66377800,3,0),(66377800,4,1),(66377800,6,1),(66377800,7,1),(66830651,1,10),(66830651,2,1),(66830651,3,2),(66830651,4,2),(66830651,6,2),(66830651,7,2),(33100006,1,26),(33100006,2,2),(33100006,3,2),(33100006,4,2),(33100006,6,3),(33100006,7,4),(66150130,1,0),(66150130,2,0),(66150130,3,1),(66150130,4,0),(66150130,6,0),(66150130,7,1),(66190405,1,0),(66190405,2,0),(66190405,3,1),(66190405,4,0),(66190405,6,0),(66190405,7,0),(66190400,1,0),(66190400,2,1),(66190400,3,0),(66190400,4,1),(66190400,6,1),(66190400,7,0),(11120009,1,1),(11120009,2,1),(11120009,3,1),(11120009,4,2),(11120009,6,0),(11120009,7,1),(66650871,1,37),(66650871,2,0),(66650871,3,0),(66650871,4,0),(66650871,6,0),(66650871,7,0),(11120017,1,17),(11120017,2,1),(11120017,3,2),(11120017,4,2),(11120017,6,2),(11120017,7,3),(11120036,1,1),(11120036,2,0),(11120036,3,1),(11120036,4,1),(11120036,6,0),(11120036,7,1),(66340650,1,0),(66340650,2,0),(66340650,3,1),(66340650,4,0),(66340650,6,0),(66340650,7,1),(66340652,1,9),(66340652,2,2),(66340652,3,1),(66340652,4,2),(66340652,6,1),(66340652,7,3),(66940252,1,81),(66940252,2,1),(66940252,3,1),(66940252,4,3),(66940252,6,2),(66940252,7,3),(66680200,1,0),(66680200,2,0),(66680200,3,0),(66680200,4,0),(66680200,6,0),(66680200,7,1),(66470874,1,0),(66470874,2,0),(66470874,3,1),(66470874,4,0),(66470874,6,0),(66470874,7,0),(66680150,1,0),(66680150,2,0),(66680150,3,1),(66680150,4,0),(66680150,6,0),(66680150,7,0),(66150120,1,0),(66150120,2,1),(66150120,3,0),(66150120,4,1),(66150120,6,0),(66150120,7,0),(66730755,1,89),(66730755,2,2),(66730755,3,3),(66730755,4,3),(66730755,6,1),(66730755,7,3),(66170651,1,1),(66170651,2,1),(66170651,3,1),(66170651,4,2),(66170651,6,1),(66170651,7,1),(66470905,1,81),(66470905,2,1),(66470905,3,3),(66470905,4,2),(66470905,6,2),(66470905,7,3),(66150501,1,15),(66150501,2,2),(66150501,3,2),(66150501,4,2),(66150501,6,2),(66150501,7,2),(66795900,1,3),(66795900,2,1),(66795900,3,2),(66795900,4,2),(66795900,6,1),(66795900,7,0),(66730980,1,83),(66730980,2,0),(66730980,3,2),(66730980,4,2),(66730980,6,1),(66730980,7,2),(66150046,1,1),(66150046,2,0),(66150046,3,0),(66150046,4,0),(66150046,6,0),(66150046,7,1),(66770605,1,0),(66770605,2,0),(66770605,3,0),(66770605,4,1),(66770605,6,1),(66770605,7,0),(66390060,1,3),(66390060,2,0),(66390060,3,1),(66390060,4,1),(66390060,6,1),(66390060,7,1),(66788050,1,0),(66788050,2,0),(66788050,3,0),(66788050,4,0),(66788050,6,0),(66788050,7,1),(66895150,1,0),(66895150,2,0),(66895150,3,0),(66895150,4,1),(66895150,6,0),(66895150,7,0),(66980150,1,111),(66980150,2,0),(66980150,3,2),(66980150,4,1),(66980150,6,2),(66980150,7,1),(66150820,1,15),(66150820,2,0),(66150820,3,2),(66150820,4,2),(66150820,6,1),(66150820,7,0),(66170050,1,0),(66170050,2,0),(66170050,3,1),(66170050,4,1),(66170050,6,1),(66170050,7,0),(33125024,1,5),(33125024,2,0),(33125024,3,0),(33125024,4,1),(33125024,6,1),(33125024,7,1),(33125010,1,5),(33125010,2,0),(33125010,3,0),(33125010,4,2),(33125010,6,0),(33125010,7,0),(33805031,1,1),(33805031,2,0),(33805031,3,1),(33805031,4,0),(33805031,6,1),(33805031,7,0),(33805042,1,0),(33805042,2,0),(33805042,3,1),(33805042,4,0),(33805042,6,1),(33805042,7,0),(66864050,1,0),(66864050,2,0),(66864050,3,1),(66864050,4,1),(66864050,6,0),(66864050,7,0),(66355905,1,0),(66355905,2,0),(66355905,3,1),(66355905,4,0),(66355905,6,0),(66355905,7,0),(66365900,1,0),(66365900,2,0),(66365900,3,1),(66365900,4,1),(66365900,6,0),(66365900,7,1),(66970900,1,0),(66970900,2,0),(66970900,3,2),(66970900,4,0),(66970900,6,0),(66970900,7,1),(66970901,1,0),(66970901,2,0),(66970901,3,2),(66970901,4,2),(66970901,6,1),(66970901,7,2),(66150106,1,0),(66150106,2,0),(66150106,3,0),(66150106,4,1),(66150106,6,0),(66150106,7,0),(66869031,1,0),(66869031,2,0),(66869031,3,2),(66869031,4,0),(66869031,6,3),(66869031,7,2),(66470907,1,0),(66470907,2,0),(66470907,3,0),(66470907,4,0),(66470907,6,1),(66470907,7,0),(66390755,1,0),(66390755,2,0),(66390755,3,1),(66390755,4,0),(66390755,6,0),(66390755,7,1),(66975050,1,0),(66975050,2,0),(66975050,3,1),(66975050,4,0),(66975050,6,0),(66975050,7,1);

INSERT INTO `supplier` VALUES (7,'ATOMOZ','0448672179400','ATMZ'),(8,'SUPLEMENTOS GYM','00000','SUPGYM'),(9,'CORPORATIVO RAIS SA  DE CV','013313062119','RAIS'),(10,'SUPLEMENT PLANET','018717185808E105','SUPPLA'),(11,'BODYFIT SUPLEMENTOS','0453311767890','BODFIT'),(12,'TIENDA PURO CAMPEON','56772848','PURCAMP'),(13,'ADN BIOTECH','0000','ADNB'),(14,'EXCLUSIVAS LOS REYES S.A. DE C.V.','53006699','EXREY'),(15,'EQUIPO ELIOLT','57902607','EELIO'),(16,'ERNESTO MARTINES FLORES','5585793316','EMF'),(17,'PROVEEDORES VARIOS','0000','PV'),(18,'SUCURSAL VIVEROS','0000','SUCVIV'),(19,'UNO SUPLEMENTOS','52643821','USUP'),(20,'CARPOL  S.A. DE C.V.','58847602','CARPOL'),(21,'SUPLEMENT WORLD','5521908640','SUPWOR'),(22,'COMERCIALIZADORA RUPOL  S.A. DE C.V.','0000','RUPOL'),(23,'QUIMICOS PLEDCA  S.A. DE C.V.','0000','QUIMPLE'),(24,'DEPORTES REYES','5530531134','DEPREY'),(25,'SUPER NATURISTA','0000','SUPNAT'),(26,'ADDICTION GYM','0000','ADDGYM'),(27,'MADNESS NUTRITION','0000','MADNUT'),(28,'VEGAN NUTRITION','0000','VEGNUT'),(29,'NATURAL GYM','5612680536','NATGYM'),(30,'ROTTERDAM PHARMA','5527508409','ROTPHA'),(31,'BLUE SUPPLEMENT','4735936888','BLUSUP'),(32,'UNIVERSAL SPORT','0000','UNIVSP'),(33,'LUXOR SPORT NUTRITION','5568341113','LUXSP'),(34,'FASHION AND FITNESS','0000','FAANDFIT'),(35,'BIRDMAN ALMA VALDIVIA','3311141398','BIRDM');

INSERT INTO `users` VALUES (25,'OSCAR GARCIA','oscar.garcia@progyms.com',NULL,'$2y$10$Xe/SKzBpHTlJTXe8BHmEIecBUiiTYpsZSN7uPLfh7uOZoWvUePS.a',NULL,'2024-09-07 05:18:00','2024-09-07 05:18:00',1,'y!rXZ5ZV','5544604588',2,'09:00:00','18:00:00','2024-01-01',1),(26,'LIZBETH VARGAS','lizbeth.vargas@progyms.com',NULL,'$2y$10$S0THp3iJADYvkUaAY/ehOOjMV9MMg.Gh84zYIwLtVsb2baOzqF2jS',NULL,'2024-09-07 05:18:42','2024-09-07 05:18:42',2,'jg&k4ZzU','5584542783',2,'09:00:00','18:00:00','2024-01-01',1),(27,'JUAN REYES','juan.reyes@progyms.com',NULL,'$2y$10$m3JEAbNtfc98XRVaBTEt.O2qmagV8hs08s5HheXeQ0Av4OmgcziIG',NULL,'2024-09-07 05:19:10','2025-01-13 21:37:26',3,'lzxPbxX3','5537490177',2,'09:00:00','18:00:00','2022-02-22',1),(28,'MONTSERRAT GARCIA','montserrat.garcia@progyms.com',NULL,'$2y$10$NIPjgwjq1FSaFVJkLbApq.F43SikfJBrAT1oFIiY0BjuUtl8EBfvy',NULL,'2024-09-07 05:19:35','2025-01-29 22:28:40',3,'lachica22','5581353400',2,'09:00:00','18:00:00','2022-03-22',1),(29,'MONICA NAVARRETE','monica.navarrete@progyms.com',NULL,'$2y$10$0mKY/TPmdHhQKRIG6QViWeSarmO/2H33BSibxu5NSXmOkAxCZAvBO',NULL,'2024-09-07 05:20:06','2024-09-07 05:20:06',4,'XLU&Ch3Q','5521963915',7,'09:00:00','18:00:00','2023-10-05',1),(30,'KALID MILLA','kalid.milla@progyms.com',NULL,'$2y$10$CzQYucyc38zD8pvoJEdkGefmuDHUFagrAMREl//RjZbi5VBKiwzTG',NULL,'2024-09-07 05:20:42','2024-09-07 05:20:42',4,'l6YbYHmT','5610628453',6,'09:00:00','19:00:00','2024-08-28',1),(31,'KEVIN NAVARRETE','kevin.navarrete@progyms.com',NULL,'$2y$10$8hOS16Q7UBTJyK46/R3EaOiyzNs9btRP.bpcMSyl.MiocP9MlRcOi',NULL,'2024-09-07 05:21:08','2024-09-07 05:21:08',4,'XtRb%Vd1','5564739411',7,'14:01:00','19:00:00','2024-02-10',0),(32,'YOLANDA SOTO','yolanda.soto@progyms.com',NULL,'$2y$10$NMaUozkZXy0ILzcIcLmdXuNVSugpD2da7RyDmUnfYpEutIeXKarCO',NULL,'2024-09-07 05:21:35','2024-09-07 05:21:35',4,'L&dNu#Zt','5531216226',4,'11:00:00','19:00:00','2021-08-01',1),(33,'MIRIAM ORTIZ','miriam.sanchez@progyms.com',NULL,'$2y$10$MTsyVc.FG5XLFUoOr6g1weV4ubOrNgJjmsO7TKkYMBx6H4bQLSkhC',NULL,'2024-09-07 05:21:55','2024-09-07 05:21:55',4,'b4Cmko&*','5626001825',4,'10:00:00','19:00:00','2024-01-01',1),(34,'CLEMENTE ZARRAGA','clemente.zarraga@progyms.com',NULL,'$2y$10$A5xO1jr7szt1YLHEloBzoeJbx5Ovtb456I2mumS3H3uaL7l8jT9qa',NULL,'2024-09-07 05:22:24','2025-01-11 00:19:54',1,'Sg&)xagP','5533668907',2,'09:00:00','18:00:00','2024-08-25',1),(36,'LEONARDO GARCIA','leonardo.garcia@progyms.com',NULL,'$2y$10$Qe3QwTBXBWZpgXPtudLPGOMTJbwgdt8xrqtl.Y6dlTAmdm3BI3zVK',NULL,'2024-09-07 05:23:58','2024-09-07 05:23:58',4,'@1ykPWSo','5576869984',2,'09:00:00','18:00:00','2024-01-01',1),(37,'EDILBERTO SANCHEZ','ediberto.sanchez@progyms.com',NULL,'$2y$10$XRYuUlDqeo5s9E4KrvDm.eNpnAt8siFMb/M.E9Us5O1tWY/Czo6aq',NULL,'2024-09-07 05:24:54','2024-09-07 05:24:54',4,')NmDpAB)','5518198468',3,'11:00:00','20:00:00','2024-08-25',0),(38,'ANGEL BAZAN','ANGEL.BAZAN@PROGYMS.COM',NULL,'$2y$10$Eln4wDS1hbHZADCGwOyy9uglsb6swtmHPSbi5gV19vJ01qBdoyTLy',NULL,'2024-09-23 20:58:51','2024-09-23 20:58:51',4,'23ut$(9n',NULL,2,'09:00:00','18:00:00','2024-09-23',1),(39,'SANDRA MIRELLA ALONSO GARCIA','sandra.alonso@progyms.com',NULL,'$2y$10$f4pcJ6pKBug1nEU6YHh0U.XGsYKyLvIlvmd6xYX.rPf4lHWm1NyD6',NULL,'2025-01-30 01:35:51','2025-01-30 01:35:51',4,'U0&js*4b',NULL,3,'11:00:00','20:00:00','2025-02-03',1),(40,'JOSE DE JESUS PASCACIO REYES','jose.pascacio@progyms.com',NULL,'$2y$10$xrEuMIKwMamvslzRZLC3MO2ngWT75w2IJdpXn3LZrGiM5nIi9iV9i',NULL,'2025-02-12 23:09:48','2025-02-12 23:09:48',1,'zKIO5&b5',NULL,1,'11:00:00','20:00:00','2025-02-16',1),(41,'KEVIN JONATHAN LOPEZ PALOMINO','kevin.lopez@progyms.com',NULL,'$2y$10$SKM3xUV.hwqxl8LgDzs/d.Q4S8GxxqfmXWvQIVBTq2Yc9rR1paca.',NULL,'2025-03-13 02:43:28','2025-03-13 02:43:28',4,'PU*zyeDd',NULL,3,'11:00:00','20:00:00',NULL,1);

INSERT INTO `vacation` VALUES (1,28,'2024-03-30','1'),(2,28,'2024-06-22','2'),(3,28,'2024-07-23','3'),(4,28,'2024-07-24','4'),(5,28,'2024-08-30','5'),(6,28,'2024-09-10','6'),(7,28,'2024-10-10','7'),(8,27,'2024-02-24','1'),(9,27,'2024-02-27','2'),(10,27,'2024-02-28','3'),(11,27,'2024-02-29','4'),(12,27,'2024-03-25','5'),(13,27,'2024-03-27','6'),(14,27,'2024-03-28','7'),(15,27,'2024-03-29','8'),(16,27,'2024-03-30','9'),(17,27,'2024-05-20','10'),(18,27,'2024-05-25','11'),(19,27,'2024-06-15','12'),(20,27,'2024-06-20','13'),(21,27,'2024-09-07','14'),(22,32,'2024-06-30','1'),(23,32,'2024-08-01','2'),(24,32,'2024-10-07','3'),(25,32,'2024-10-11','4'),(26,32,'2024-10-12','5'),(29,29,'2024-11-22','1'),(30,32,'2025-01-02','1');

INSERT INTO `warehouse` VALUES (1,'Almacén Principal'),(2,'Viveros'),(3,'Towncenter Nicolas Romero'),(4,'Coacalco'),(5,'Queretaro'),(6,'Villas de la Hacienda'),(7,'Naucalpan');
/* agregar un alter table para cashclousure y agregar una columna que diga sucursales  */ 