/*
 01. Devuelve un listado que muestre solamente los clientes que
 no han realizado ningún pago.
 */

SELECT c.nombre_cliente
FROM cliente c LEFT JOIN pago p on
    c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

/*
 02. Devuelve un listado que muestre solamente los
 clientes que no han realizado ningún pedido.
 */

SELECT c.nombre_cliente
FROM cliente c LEFT JOIN pedido p on
    c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

/*
 03. Devuelve un listado que muestre los clientes que no han
 realizado ningún pago y los que no han realizado ningún pedido.
 */

SELECT c.nombre_cliente
FROM cliente c LEFT JOIN pago p on
    c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL

UNION

SELECT c.nombre_cliente
FROM cliente c LEFT JOIN pedido p on
    c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

/*
 04. Devuelve un listado que muestre solamente los empleados que
 no tienen una oficina asociada.
 */

SELECT e.nombre
FROM empleado e LEFT JOIN oficina o on
    e.codigo_oficina = o.codigo_oficina
WHERE o.codigo_oficina IS NULL;

/*
 05. Devuelve un listado que muestre solamente los empleados
 que no tienen un cliente asociado.
 */

SELECT e.nombre
FROM empleado e LEFT JOIN cliente c on
    e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_cliente IS NULL;

/*
 06. Devuelve un listado que muestre solamente los empleados
 que no tienen un cliente asociado junto con los datos de la
 oficina donde trabajan.
 */

SELECT e.nombre
FROM empleado e LEFT JOIN cliente c on
    e.codigo_empleado = c.codigo_empleado_rep_ventas INNER JOIN oficina o on
        e.codigo_oficina = o.codigo_oficina
WHERE c.codigo_cliente IS NULL;

/*
 07. Devuelve un listado que muestre los empleados que no
 tienen una oficina asociada y los que no tienen un cliente asociado.
 */

SELECT e.nombre
FROM empleado e LEFT JOIN oficina o on
    e.codigo_oficina = o.codigo_oficina RIGHT JOIN cliente c on
        e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE o.codigo_oficina IS NULL AND c.codigo_cliente IS NULL;

/*
 08. Devuelve un listado de los productos que nunca han
 aparecido en un pedido.
 */

SELECT DISTINCT p.nombre, dp.cantidad
FROM producto p LEFT JOIN detalle_pedido dp on
    p.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto IS NULL;

/*
 09. Devuelve un listado de los productos que nunca han aparecido
 en un pedido. El resultado debe mostrar el nombre, la descripción
 y la imagen del producto.
 */

SELECT p.nombre, p.descripcion, gp.imagen
FROM producto p LEFT JOIN detalle_pedido dp on
    p.codigo_producto = dp.codigo_producto INNER JOIN gama_producto gp on
        p.gama = gp.gama
WHERE dp.codigo_producto IS NULL;

/*
 10. Devuelve las oficinas donde no trabajan ninguno de los
 empleados que hayan sido los representantes de ventas de algún
 cliente que haya realizado la compra de algún producto de la
 gama Frutales.
 */

SELECT o.codigo_oficina
FROM oficina o LEFT JOIN empleado e on
    o.codigo_oficina = e.codigo_oficina INNER JOIN cliente c on
        e.codigo_empleado = c.codigo_empleado_rep_ventas INNER JOIN pedido p on
            c.codigo_cliente = p.codigo_cliente INNER JOIN detalle_pedido dp on
                p.codigo_pedido = dp.codigo_pedido INNER JOIN producto p2 on
                    dp.codigo_producto = p2.codigo_producto INNER JOIN gama_producto gp on
                        p2.gama = gp.gama
WHERE e.codigo_empleado IS NULL AND gp.gama = 'Frutales';