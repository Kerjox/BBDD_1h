/*
 01. Devuelve un listado de todos los fabricantes que existen en la base de datos,
 junto con los productos que tiene cada uno de ellos. El listado deberá
 mostrar también aquellos fabricantes que no tienen productos asociados.
 */

SELECT p.nombre, f.nombre
FROM producto p RIGHT JOIN fabricante f on
    f.codigo = p.codigo_fabricante;

/*
 02. Devuelve un listado donde sólo aparezcan aquellos fabricantes
 que no tienen ningún producto asociado.
 */

SELECT p.nombre, f.nombre
FROM producto p RIGHT JOIN fabricante f on
    f.codigo = p.codigo_fabricante
    WHERE p.nombre IS NULL;

/*
 03. ¿Pueden existir productos que no estén relacionados con
 un fabricante? Justifique su respuesta.
 */

/* No se puede ya que el fabricante es obligatorio*/