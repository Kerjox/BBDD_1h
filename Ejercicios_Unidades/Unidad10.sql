/*
 01. Consulte cuáles son los índices que hay en la tabla producto
 utilizando las dos instrucciones SQL que nos permiten obtener esta
 información de la tabla.
 */

DESCRIBE producto;
SHOW INDEX FROM producto;

/*
 02. Haga uso de EXPLAIN para obtener información sobre cómo se están
 realizando las consultas y diga cuál de las dos consultas realizará
 menos comparaciones para encontrar el producto que estamos buscando.
 ¿Cuántas comparaciones se realizan en cada caso? ¿Por qué?.
 */

EXPLAIN SELECT *
FROM producto
WHERE codigo_producto = 'OR-114';

/* En esta consulta existe un index para el codigo_producto, analiza 1 fila */

EXPLAIN SELECT *
FROM producto
WHERE nombre = 'Evonimus Pulchellus';

/* En esta consulta no existe un index y compara con todos las filas de la tabla */


/*
 03. Suponga que estamos trabajando con la base de datos jardineria
 y queremos saber optimizar las siguientes consultas. ¿Cuál de las
 dos sería más eficiente?. Se recomienda hacer uso de EXPLAIN para
 obtener información sobre cómo se están realizando las consultas.
 */

EXPLAIN SELECT AVG(total)
FROM pago
WHERE YEAR(fecha_pago) = 2008;

/* Esta no se puede optimizar con un index del campo fecha_pago */

CREATE INDEX idx_fecha_pago ON pago(fecha_pago);

EXPLAIN SELECT AVG(total)
FROM pago
WHERE fecha_pago >= '2010-01-01' AND fecha_pago <= '2010-12-31';

/* Esta si se pude optimizar con un index del campo fecha_pago */

/*
 04. Optimiza la siguiente consultas creando índices cuando sea necesario.
 Se recomienda hacer uso de EXPLAIN para obtener información sobre cómo se
 están realizando las consultas.
 */

EXPLAIN SELECT *
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE cliente.nombre_cliente LIKE 'A%';

/* Creación de un index en el campo de nombre_cliente */

/*
 05. ¿Por qué no es posible optimizar el tiempo de ejecución de las
 siguientes consultas, incluso haciendo uso de índices?
 */

EXPLAIN SELECT *
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE cliente.nombre_cliente LIKE '%A%';

EXPLAIN SELECT *
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE cliente.nombre_cliente LIKE '%A';

/* No se pueden optimizar porque los indices no funcionan al hacer este
   tipo de busqedas con el like, hay que usar la función MATCH */

/*
 06. Crea un índice de tipo FULLTEXT sobre las columnas nombre y
 descripcion de la tabla producto.
 */

CREATE FULLTEXT INDEX producto_nombre_descripcion_index
	on producto (nombre, descripcion);

/* 07. Una vez creado el índice del ejercicio anterior realiza las
   siguientes consultas haciendo uso de la función MATCH, para buscar
   todos los productos que:
 */

/*
 Contienen la palabra planta en el nombre o en la descripción. Realice una
 consulta para cada uno de los modos de búsqueda full-text que existen en
 MySQL (IN NATURAL LANGUAGE MODE, IN BOOLEAN MODE y WITH QUERY EXPANSION)
 y compare los resultados que ha obtenido en cada caso.
 */
SELECT p.nombre, p.descripcion
FROM producto p
WHERE MATCH(nombre, descripcion) AGAINST ('planta' IN NATURAL LANGUAGE MODE);

SELECT p.nombre, p.descripcion
FROM producto p
WHERE MATCH(nombre, descripcion) AGAINST ('planta' IN BOOLEAN MODE);

SELECT p.nombre, p.descripcion
FROM producto p
WHERE MATCH(nombre, descripcion) AGAINST ('planta' WITH QUERY EXPANSION);

/*
 Contienen la palabra planta seguida de cualquier carácter o conjunto de
 caracteres, en el nombre o en la descripción.
 */

SELECT p.nombre, p.descripcion
FROM producto p
WHERE MATCH(nombre, descripcion) AGAINST ('planta*' IN BOOLEAN MODE);

/*
 Empiezan con la palabra planta en el nombre o en la descripción.
 */

 /*
  Contienen la palabra tronco o la palabra árbol en el nombre o en la descripción.
  */

SELECT p.nombre, p.descripcion
FROM producto p
WHERE MATCH(nombre, descripcion) AGAINST ('tronco, árbol');

/*
 Contienen la palabra tronco y la palabra árbol en el nombre o en la descripción.
 */

SELECT p.nombre, p.descripcion
FROM producto p
WHERE MATCH(nombre, descripcion) AGAINST ('+tronco +árbol' IN BOOLEAN MODE);

/*
 Contienen la palabra tronco pero no contienen la
 palabra árbol en el nombre o en la descripción.
 */

SELECT p.nombre, p.descripcion
FROM producto p
WHERE MATCH(nombre, descripcion) AGAINST ('+tronco -árbol' IN BOOLEAN MODE);

/*
 Contiene la frase proviene de las costas en el nombre o en la descripción.
 */

SELECT p.nombre, p.descripcion
FROM producto p
WHERE MATCH(nombre, descripcion) AGAINST ('"proviene de las costas"' IN BOOLEAN MODE);
