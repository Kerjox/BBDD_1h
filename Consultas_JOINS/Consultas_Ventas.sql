/*
 01. Devuelve un listado con el identificador, nombre y los apellidos
 de todos los clientes que han realizado algún pedido. El listado debe
 estar ordenado alfabéticamente y se deben eliminar los elementos
 repetidos.
 */

SELECT DISTINCT c.id, c.nombre, c.apellido1, c.apellido2
FROM cliente c INNER JOIN pedido p on
    c.id = p.id_cliente
ORDER BY c.nombre;

/*
 02. Devuelve un listado que muestre todos los pedidos que ha
 realizado cada cliente. El resultado debe mostrar todos los
 datos de los pedidos y del cliente. El listado debe mostrar
 los datos de los clientes ordenados alfabéticamente.
 */

SELECT p.*, c.*
FROM pedido p INNER JOIN cliente c on
    p.id_cliente = c.id
ORDER BY c.nombre;

/*
 03. Devuelve un listado que muestre todos los pedidos en los que ha
 participado un comercial. El resultado debe mostrar todos los datos
 de los pedidos y de los comerciales. El listado debe mostrar los datos
 de los comerciales ordenados alfabéticamente.
 */

SELECT p.*, c.*
FROM pedido p INNER JOIN comercial c on
    p.id_comercial = c.id
ORDER BY c.nombre;

/*
 04. Devuelve un listado que muestre todos los clientes, con todos
 los pedidos que han realizado y con los datos de los comerciales
 asociados a cada pedido.
 */

SELECT c.nombre, p.id, co.nombre
FROM cliente c INNER JOIN pedido p on
    c.id = p.id_cliente INNER JOIN comercial co on
        p.id_comercial = co.id;

/*
 05. Devuelve un listado de todos los clientes que realizaron un
 pedido durante el año 2017, cuya cantidad esté entre 300 € y 1000 €.
 */

SELECT c.nombre
FROM cliente c INNER JOIN pedido p on
    c.id = p.id_cliente
WHERE YEAR(p.fecha) = 2017 AND p.total BETWEEN 300 AND 1000;

/*
 06. Devuelve el nombre y los apellidos de todos los comerciales que
 ha participado en algún pedido realizado por María Santana Moreno.
 */

SELECT co.nombre, co.apellido1, co.apellido2
FROM comercial co INNER JOIN pedido p on
    co.id = p.id_comercial INNEr JOIN cliente c on
        p.id_cliente = c.id
WHERE c.nombre = "María" AND c.apellido1 = "Santana" AND c.apellido2 = "Moreno";

/*
 07. Devuelve el nombre de todos los clientes que han realizado algún
 pedido con el comercial Daniel Sáez Vega.
 */

SELECT c.nombre
FROM cliente c INNER JOIN pedido p on
    c.id = p.id_cliente INNER JOIN comercial co on p.id_comercial = co.id
WHERE co.nombre = "Daniel" AND co.apellido1 = "Sáez" AND co.apellido2 = "Vega";