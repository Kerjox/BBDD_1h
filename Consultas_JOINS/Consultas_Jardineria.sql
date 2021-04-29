/*
 01. Obtén un listado con el nombre de cada cliente y el nombre y
 apellido de su representante de ventas.
 */

SELECT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c INNER JOIN empleado e on
    c.codigo_empleado_rep_ventas = e.codigo_empleado;

/*
 02. Muestra el nombre de los clientes que hayan realizado pagos junto con el
 nombre de sus representantes de ventas.
 */

SELECT c.nombre_cliente
FROM cliente c INNER JOIN pago p on
    c.codigo_cliente = p.codigo_cliente INNER JOIN empleado e on
        c.codigo_empleado_rep_ventas = e.codigo_empleado;

/*
 03. Muestra el nombre de los clientes que no hayan realizado pagos junto
 con el nombre de sus representantes de ventas.
 */

SELECT DISTINCT c.nombre_cliente, e.nombre
FROM cliente c INNER JOIN pago p on
    c.codigo_cliente != p.codigo_cliente INNER JOIN empleado e on
        c.codigo_empleado_rep_ventas = e.codigo_empleado;

/*
 04. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
 representantes junto con la ciudad de la oficina a la que pertenece el representante.
 */

SELECT c.nombre_cliente, e.nombre, o.ciudad
FROM cliente c INNER JOIN pago p on
    c.codigo_cliente = p.codigo_cliente INNER JOIN empleado e on
        c.codigo_empleado_rep_ventas = e.codigo_empleado INNER JOIN oficina o on
            e.codigo_oficina = o.codigo_oficina;

/*
 05. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
 de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
 */

SELECT c.nombre_cliente, e.nombre, o.ciudad
FROM cliente c INNER JOIN pago p on
    c.codigo_cliente != p.codigo_cliente INNER JOIN empleado e on
        c.codigo_empleado_rep_ventas = e.codigo_empleado INNER JOIN oficina o on
            e.codigo_oficina = o.codigo_oficina;

/*
 06. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
 */

SELECT DISTINCT o.linea_direccion1
FROM oficina o INNER JOIN empleado e on
    o.codigo_oficina = e.codigo_oficina INNER JOIN cliente c on
        e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.ciudad = "Fuenlabrada";

/*
 07. Devuelve el nombre de los clientes y el nombre de sus representantes
 junto con la ciudad de la oficina a la que pertenece el representante.
 */

SELECT c.nombre_cliente, e.nombre, o.ciudad
FROM cliente c INNER JOIN  empleado e on
    c.codigo_empleado_rep_ventas = e.codigo_empleado INNER JOIN oficina o on
        e.codigo_oficina = o.codigo_oficina;

/*
 08. Devuelve un listado con el nombre de los empleados junto
 con el nombre de sus jefes.
 */

SELECT e.nombre, je.nombre
FROM empleado e INNER JOIN empleado je on
    e.codigo_empleado = je.codigo_jefe;

/*
 09. Devuelve un listado que muestre el nombre de cada empleados,
 el nombre de su jefe y el nombre del jefe de sus jefe.
 */

SELECT e.nombre, je.nombre, jeje.nombre
FROM empleado e INNER JOIN empleado je on
    e.codigo_empleado = je.codigo_jefe INNER JOIN empleado jeje on
        je.codigo_empleado = jeje.codigo_jefe;

/*
 10. Devuelve el nombre de los clientes a los que no se les ha
 entregado a tiempo un pedido.
 */

SELECT DISTINCT c.nombre_cliente
FROM cliente c INNER JOIN pedido p on
    c.codigo_cliente = p.codigo_cliente
WHERE p.fecha_entrega > p.fecha_esperada;

/*
 11. Devuelve un listado de las diferentes gamas de producto que ha
 comprado cada cliente.
 */

SELECT DISTINCT gp.gama, c.nombre_cliente
FROM gama_producto gp INNER JOIN producto p on
    gp.gama = p.gama INNER JOIN detalle_pedido dp on
        p.codigo_producto = dp.codigo_producto INNER JOIN pedido p2 on
            dp.codigo_pedido = p2.codigo_pedido INNER JOIN cliente c on
                p2.codigo_cliente = c.codigo_cliente;
