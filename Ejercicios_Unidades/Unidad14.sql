/*
 01. Configura tu sistema gestor de base de datos para que registre
 aquellas consultas que tardan más de 3 segundos en ejecutarse.
 */
SET GLOBAL slow_query_log = ON;
SET GLOBAL long_query_time = 0.200;
SHOW GLOBAL VARIABLES LIKE 'slow_query_log';
SHOW GLOBAL VARIABLES LIKE 'long_query_time';

/*
 02. Realice algunas consultas sobre las bases de datos jardineria y
 universidad que tengan un tiempo de ejecución superior a 3 segundos.
 */

SELECT c.*, e.*, o.*, p.*
FROM cliente c INNER JOIN empleado e on
    c.codigo_empleado_rep_ventas = e.codigo_empleado INNER JOIN oficina o on
        e.codigo_oficina = o.codigo_oficina INNER JOIN pago p on
            c.codigo_cliente = p.codigo_cliente
WHERE c.apellido_contacto LIKE "%a%" OR
      c.apellido_contacto LIKE "%r%" OR
      c.apellido_contacto LIKE "%i%" OR
      e.apellido2 LIKE "%a%" OR
      e.apellido2 LIKE "%r%" OR
      e.apellido2 LIKE "%i%";


/* 03. Configura tu sistema gestor de base de datos para que registre
   aquellas consultas que no usan índices. */

SET GLOBAL log_queries_not_using_indexes = ON;
SHOW GLOBAL VARIABLES LIKE 'log_queries_not_using_indexes';

/* 04. Realice algunas consultas sobre las bases de datos
   jardineria y universidad que no hagan uso de índices.
 */

SELECT c.*
FROM cliente c INNER JOIN empleado e on
    c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE c.apellido_contacto LIKE "%a%";