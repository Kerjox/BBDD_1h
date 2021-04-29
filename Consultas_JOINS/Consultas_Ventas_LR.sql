/*
 01. Devuelve un listado con todos los clientes junto con los datos
 de los pedidos que han realizado. Este listado también debe incluir
 los clientes que no han realizado ningún pedido. El listado debe
 estar ordenado alfabéticamente por el primer apellido, segundo
 apellido y nombre de los clientes.
 */

SELECT c.*, p.*
FROM cliente c LEFT JOIN pedido p on
    c.id = p.id_cliente
ORDER BY c.apellido1, c.apellido2, c.nombre;

/*
 02. Devuelve un listado con todos los comerciales junto con los
 datos de los pedidos que han realizado. Este listado también debe
 incluir los comerciales que no han realizado ningún pedido. El
 listado debe estar ordenado alfabéticamente por el primer apellido,
 segundo apellido y nombre de los comerciales.
 */

SELECT co.*, p.*
FROM comercial co LEFT JOIN pedido p on
    co.id = p.id_comercial
ORDER BY co.apellido1, co.apellido2, co.nombre;

/*
 03. Devuelve un listado que solamente muestre los clientes que
 no han realizado ningún pedido.
 */

SELECT c.nombre
FROM cliente c LEFT JOIN pedido p on c.id = p.id_cliente
WHERE p.id IS NULL;

/*
 04. Devuelve un listado que solamente muestre los comerciales
 que no han realizado ningún pedido.
 */

SELECT co.nombre
FROM comercial co LEFT JOIN pedido p on
    co.id = p.id_comercial
WHERE p.id IS NULL;

/*
 05. Devuelve un listado con los clientes que no han realizado
 ningún pedido y de los comerciales que no han participado en
 ningún pedido. Ordene el listado alfabéticamente por los apellidos
 y el nombre. En en listado deberá diferenciar de algún modo los
 clientes y los comerciales.
 */
SELECT nombre, ap1, ap2, tipo
FROM (
    SELECT c.nombre AS nombre, c.apellido1 AS ap1, c.apellido2 AS ap2, "Cliente" AS tipo
    FROM cliente c LEFT JOIN pedido p on c.id = p.id_cliente
    WHERE p.id IS NULL

    UNION

    SELECT co.nombre AS nombre, co.apellido1 AS ap1, co.apellido2 AS ap2, "Comercial" AS tipo
    FROM comercial co LEFT JOIN pedido p on
        co.id = p.id_comercial
    WHERE p.id IS NULL
    ) as cpcp
    ORDER BY ap1, ap2, nombre;

/*
 06. ¿Se podrían realizar las consultas anteriores con
 NATURAL LEFT JOIN o NATURAL RIGHT JOIN? Justifique su respuesta.

 Si tienen el mismo campo da igual.
 */