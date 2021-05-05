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

/*
 08. Crea un índice de tipo INDEX compuesto por las columnas apellido_contacto
 y nombre_contacto de la tabla cliente.
 */

CREATE INDEX nombre_contacto_apellido
	on cliente (nombre_contacto, apellido_contacto);

/*
 09. Una vez creado el índice del ejercicio anterior realice las siguientes
 consultas haciendo uso de EXPLAIN:
 */

/*
 Busca el cliente Javier Villar. ¿Cuántas filas se han examinado hasta
 encontrar el resultado?
 */

EXPLAIN SELECT c.nombre_cliente
FROM cliente c
WHERE c.nombre_cliente = 'Javier Villar';

/*
 Busca el ciente anterior utilizando solamente el apellido Villar.
 ¿Cuántas filas se han examinado hasta encontrar el resultado?
 */

EXPLAIN SELECT c.nombre_cliente
FROM cliente c
WHERE c.nombre_cliente LIKE '%Villar';

/*
 Busca el ciente anterior utilizando solamente el nombre Javier.
 ¿Cuántas filas se han examinado hasta encontrar el resultado?
 ¿Qué ha ocurrido en este caso?
 */

EXPLAIN SELECT c.nombre_cliente
FROM cliente c
WHERE c.nombre_cliente LIKE 'Javier%';


/*
 10. Calcula cuál podría ser un buen valor para crear un índice sobre
 un prefijo de la columna nombre_cliente de la tabla cliente. Tenga en
 cuenta que un buen valor será aquel que nos permita utilizar el menor
 número de caracteres para diferenciar todos los valores que existen en
 la columna sobre la que estamos creando el índice.
 */

create index cliente_nombre_cliente_index
	on cliente (nombre_cliente);

DROP INDEX cliente_nombre_cliente_index on cliente;

/*
 En primer lugar calculamos cuántos valores distintos existen en la
 columna nombre_cliente. Necesitarás utilizar la función COUNT y DISTINCT.
 */

SELECT DISTINCT COUNT(c.nombre_cliente)
FROM cliente c;

/*
 Haciendo uso de la función LEFT ve calculando el número de caracteres que
 necesitas utilizar como prefijo para diferenciar todos los valores de la columna.
 Necesitarás la función COUNT, DISTINCT y LEFT.
 */
SELECT COUNT(DISTINCT LEFT(c.nombre_cliente, 11))
    FROM cliente c;

/*
 Una vez que hayas encontrado el valor adecuado para el prefijo, crea el índice
 sobre la columna nombre_cliente de la tabla cliente.
 */

CREATE INDEX nombre_cliente
    on cliente (nombre_cliente);

