/*
 12. Realice los siguientes procedimientos y funciones sobre la base de datos jardineria.


Función: calcular_precio_total_pedido
Descripción: Dado un código de pedido la función debe calcular la suma total del pedido. Tenga en cuenta que un pedido puede contener varios productos diferentes y varias cantidades de cada producto.
Parámetros de entrada: codigo_pedido (INT)
Parámetros de salida: El precio total del pedido (FLOAT)

Función: calcular_suma_pedidos_cliente
Descripción: Dado un código de cliente la función debe calcular la suma total de todos los pedidos realizados por el cliente. Deberá hacer uso de la función calcular_precio_total_pedido que ha desarrollado en el apartado anterior.
Parámetros de entrada: codigo_cliente (INT)
Parámetros de salida: La suma total de todos los pedidos del cliente (FLOAT)

Función: calcular_suma_pagos_cliente
Descripción: Dado un código de cliente la función debe calcular la suma total de los pagos realizados por ese cliente.
Parámetros de entrada: codigo_cliente (INT)
Parámetros de salida: La suma total de todos los pagos del cliente (FLOAT)

Procedimiento: calcular_pagos_pendientes
Descripción: Deberá calcular los pagos pendientes de todos los clientes. Para saber si un cliente tiene algún pago pendiente deberemos calcular cuál es la cantidad de todos los pedidos y los pagos que ha realizado. Si la cantidad de los pedidos es mayor que la de los pagos entonces ese cliente tiene pagos pendientes.
Deberá insertar en una tabla llamada clientes_con_pagos_pendientes los siguientes datos:

id_cliente
suma_total_pedidos
suma_total_pagos
pendiente_de_pago
 */

DROP FUNCTION IF EXISTS calcular_precio_total_pedido;
DELIMITER $$
CREATE FUNCTION calcular_precio_total_pedido(_codigo_pedido INT UNSIGNED)
RETURNS FLOAT UNSIGNED
BEGIN

    DECLARE cantidad INT UNSIGNED;
    DECLARE precio_unidad FLOAT UNSIGNED;
    DECLARE cur_data CURSOR FOR (SELECT cp.cantidad, cp.precio_unidad
                                FROM detalle_pedido cp
                                WHERE codigo_pedido = _codigo_pedido);

    OPEN cur_data;
    FETCH cur_data INTO cantidad, precio_unidad;
    RETURN cantidad * precio_unidad;
    CLOSE cur_data;

END $$
DELIMITER ;

SELECT calcular_precio_total_pedido(1);

DROP FUNCTION IF EXISTS calcular_suma_pedidos_cliente;
DELIMITER $$
CREATE FUNCTION calcular_suma_pedidos_cliente(_codigo_cliente INT UNSIGNED)
RETURNS FLOAT UNSIGNED
BEGIN

    DECLARE _codigo_pedido INT UNSIGNED;
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE suma FLOAT UNSIGNED DEFAULT 0;
    DECLARE codigos_pedidos CURSOR FOR (SELECT p.codigo_pedido
                                        FROM pedido p
                                        WHERE codigo_cliente = _codigo_cliente);
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
        BEGIN
            SET done = TRUE;
        END ;

    OPEN codigos_pedidos;

    loop1:LOOP

        FETCH codigos_pedidos INTO _codigo_pedido;

        IF done THEN

            LEAVE loop1;

        END IF ;

        SET suma = suma + calcular_precio_total_pedido(_codigo_pedido);
    END LOOP loop1;

    CLOSE codigos_pedidos;
    RETURN suma;
END $$
DELIMITER ;

SELECT calcular_suma_pedidos_cliente(1);


DROP FUNCTION IF EXISTS calcular_suma_pagos_cliente;
DELIMITER $$
CREATE FUNCTION calcular_suma_pagos_cliente(_codigo_cliente INT UNSIGNED)
RETURNS FLOAT UNSIGNED
BEGIN

    RETURN (SELECT SUM(p.total) FROM pago p WHERE codigo_cliente = _codigo_cliente);

END $$
DELIMITER ;

SELECT calcular_suma_pagos_cliente(1);

DROP TABLE IF EXISTS clientes_con_pagos_pendientes;
CREATE TABLE clientes_con_pagos_pendientes (

    id_cliente INT UNSIGNED UNIQUE NOT NULL,
    suma_total_pedidos FLOAT UNSIGNED,
    suma_total_pagos FLOAT UNSIGNED,
    pendiente_de_pago FLOAT
);

DROP PROCEDURE IF EXISTS calcular_pagos_pendientes;
DELIMITER $$
CREATE PROCEDURE calcular_pagos_pendientes(IN _codigo_cliente INT UNSIGNED)
BEGIN


    DECLARE total_pedidos FLOAT UNSIGNED;
    DECLARE total_pagos FLOAT UNSIGNED;

    SET total_pedidos = calcular_suma_pedidos_cliente(_codigo_cliente);
    SELECT total_pedidos;
    SET total_pagos = calcular_suma_pagos_cliente(_codigo_cliente);

    INSERT INTO clientes_con_pagos_pendientes (id_cliente, suma_total_pedidos, suma_total_pagos, pendiente_de_pago) VALUES (_codigo_cliente, total_pedidos, total_pagos, total_pedidos - total_pagos);

END $$
DELIMITER ;

CALL calcular_pagos_pendientes(1);
SELECT * FROM clientes_con_pagos_pendientes;