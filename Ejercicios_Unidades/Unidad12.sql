USE jardineria;

/*
 01. Escribe un procedimiento que no tenga ningún parámetro de entrada
 ni de salida y que muestre el texto ¡Hola mundo!.
 */

DROP PROCEDURE IF EXISTS salutacion;
DELIMITER $$
CREATE PROCEDURE salutacion()
BEGIN
    SELECT '¡Hola mundo!' AS Message;

END $$
DELIMITER ;

CALL salutacion();

/*
 02. Escribe un procedimiento que reciba un número real de entrada y
 muestre un mensaje indicando si el número es positivo, negativo o cero.
 */

DROP PROCEDURE IF EXISTS checkNumber;
DELIMITER $$
CREATE PROCEDURE checkNumber(IN n INT)
BEGIN
    IF n > 0 THEN
        SELECT 'Positivo' AS Message;
    ELSEIF n = 0 THEN
        SELECT 'Cero' AS Message;
    ELSE
        SELECT 'Negativo' AS Message;
    END IF;

END $$
DELIMITER ;

CALL checkNumber(0);

/*
 03. Modifique el procedimiento diseñado en el ejercicio anterior para que
 tenga un parámetro de entrada, con el valor un número real, y un parámetro
 de salida, con una cadena de caracteres indicando si el número es positivo,
 negativo o cero.
 */

DROP PROCEDURE IF EXISTS checkNumberOUT;
DELIMITER $$
CREATE PROCEDURE checkNumberOUT(IN n INT, OUT s VARCHAR(20))
BEGIN
    IF n > 0 THEN
        SET s = 'Positivo';
    ELSEIF n = 0 THEN
        SET s = 'Cero';
    ELSE
        SET s = 'Negativo';
    END IF;

END $$
DELIMITER ;

CALL checkNumberOUT(1, @out);
SELECT @out AS Message;

/*
 04. Escribe un procedimiento que reciba un número real de entrada, que representa
 el valor de la nota de un alumno, y muestre un mensaje indicando qué nota ha
 obtenido teniendo en cuenta las siguientes condiciones:
[0, 5) = Insuficiente
[5, 6) = Aprobado
[6, 7) = Bien
[7, 9) = Notable
[9, 10] = Sobresaliente
En cualquier otro caso la nota no será válida.
 */

DROP PROCEDURE IF EXISTS notas;
DELIMITER $$
CREATE PROCEDURE notas(IN n INT)
BEGIN
    IF n >= 9 AND n <= 10 THEN
        SELECT 'Sobresaliente' AS Nota;
    ELSEIF n >= 7 AND n < 9 THEN
        SELECT 'Notable' AS Nota;
    ELSEIF n >= 6 AND n < 7 THEN
        SELECT 'Bien' AS Nota;
    ELSEIF n >= 5 AND n < 6 THEN
        SELECT 'Aprobado' AS Nota;
    ELSEIF n >= 0 AND n < 5 THEN
        SELECT 'Insuficiente' AS Nota;
    ELSE
        SELECT 'No valido' AS Nota;
    END IF;
END $$
DELIMITER ;

CALL notas(1);

/*
05. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un
parámetro de entrada, con el valor de la nota en formato numérico y un parámetro
de salida, con una cadena de texto indicando la nota correspondiente.
 */

DROP PROCEDURE IF EXISTS notas2;
DELIMITER $$
CREATE PROCEDURE notas2(IN n INT, OUT v VARCHAR(20))
BEGIN
    IF n >= 9 AND n <= 10 THEN
        SET v = 'Sobresaliente';
    ELSEIF n >= 7 AND n < 9 THEN
        SET v = 'Notable';
    ELSEIF n >= 6 AND n < 7 THEN
        SET v = 'Bien';
    ELSEIF n >= 5 AND n < 6 THEN
        SET v = 'Aprobado';
    ELSEIF n >= 0 AND n < 5 THEN
        SET v = 'Insuficiente';
    ELSE
        SET v = 'No valido';
    END IF;
END $$
DELIMITER ;

CALL notas2(4, @nota);
SELECT @nota AS Nota;

/*
 06. Resuelva el procedimiento diseñado en el ejercicio anterior
 haciendo uso de la estructura de control CASE.
 */

DROP PROCEDURE IF EXISTS notas3;
DELIMITER $$
CREATE PROCEDURE notas3(IN n INT, OUT v VARCHAR(20))
BEGIN
    CASE n

        WHEN 0 THEN SET v = 'Insuficiente';
        WHEN 1 THEN SET v = 'Insuficiente';
        WHEN 2 THEN SET v = 'Insuficiente';
        WHEN 3 THEN SET v = 'Insuficiente';
        WHEN 4 THEN SET v = 'Insuficiente';
        WHEN 5 THEN SET v = 'Aprobado';
        WHEN 6 THEN SET v = 'Bien';
        WHEN 7 THEN SET v = 'Bien';
        WHEN 8 THEN SET v = 'Notable';
        WHEN 9 THEN SET v = 'Sobresaliente';
        WHEN 10 THEN SET v = 'Sobresaleinte';
        ELSE SET v = 'No valido';

    END CASE;
END $$
DELIMITER ;

CALL notas3(7, @nota);
SELECT @nota AS Nota;

/*
 07. Escribe un procedimiento que reciba como parámetro de entrada un valor numérico que
 represente un día de la semana y que devuelva una cadena de caracteres con el nombre
 del día de la semana correspondiente. Por ejemplo, para el valor de entrada 1 debería
 devolver la cadena lunes.
 */

DROP PROCEDURE IF EXISTS diaSemana;
DELIMITER $$
CREATE PROCEDURE diaSemana(IN n INT, OUT v VARCHAR(20))
BEGIN

    CASE n
        WHEN 1 THEN SET v = 'Lunes';
        WHEN 2 THEN SET v = 'Martes';
        WHEN 3 THEN SET v = 'Miercoles';
        WHEN 4 THEN SET v = 'Jueves';
        WHEN 5 THEN SET v = 'Viernes';
        WHEN 6 THEN SET v = 'Sabado';
        WHEN 7 THEN SET v = 'Domingo';
    END CASE;
end $$
DELIMITER ;

CALL diaSemana(5, @dia);
SELECT @dia AS DiaSemana;


/*
 01. Escribe un procedimiento que reciba el nombre de un país como parámetro de entrada
 y realice una consulta sobre la tabla cliente para obtener todos los clientes que existen
 en la tabla de ese país.
 */

DROP PROCEDURE IF EXISTS SELECT_CLEINT_BY_COUNTRY;
DELIMITER $$
CREATE PROCEDURE SELECT_CLEINT_BY_COUNTRY(IN country VARCHAR(30))
BEGIN

    SELECT c.nombre_cliente, c.pais FROM cliente c WHERE pais = country;
END $$
DELIMITER ;

CALL SELECT_CLEINT_BY_COUNTRY('USA');

/*
 02. Escribe un procedimiento que reciba como parámetro de entrada una forma
 de pago, que será una cadena de caracteres (Ejemplo: PayPal, Transferencia, etc).
 Y devuelva como salida el pago de máximo valor realizado para esa forma de pago.
 Deberá hacer uso de la tabla pago de la base de datos jardineria.
 */

DROP PROCEDURE IF EXISTS MAX_PAYMENT;
DELIMITER $$
CREATE PROCEDURE MAX_PAYMENT(IN v VARCHAR(20), OUT max INT)
BEGIN

    SET max = (SELECT MAX(p.total) FROM pago p WHERE forma_pago = v);

END $$
DELIMITER ;

CALL MAX_PAYMENT('PayPal', @max);
SELECT @max AS Pago_Maximo;

/*
 03. Escribe un procedimiento que reciba como parámetro de entrada una
 forma de pago, que será una cadena de caracteres (Ejemplo: PayPal, Transferencia, etc).
 Y devuelva como salida los siguientes valores teniendo en cuenta la forma de pago seleccionada
 como parámetro de entrada:
el pago de máximo valor,
el pago de mínimo valor,
el valor medio de los pagos realizados,
la suma de todos los pagos,
el número de pagos realizados para esa forma de pago.
Deberá hacer uso de la tabla pago de la base de datos jardineria.
 */

DROP PROCEDURE IF EXISTS INFO_PAYMENT;
DELIMITER $$
CREATE PROCEDURE INFO_PAYMENT(IN v VARCHAR(20), OUT max INT, OUT min INT, OUT avg INT, OUT sum INT, OUT cont INT)
BEGIN

    SET max = (SELECT MAX(p.total) FROM pago p WHERE forma_pago = v);
    SET min = (SELECT MIN(p.total) FROM pago p WHERE forma_pago = v);
    SET avg = (SELECT AVG(p.total) FROM pago p WHERE forma_pago = v);
    SET sum = (SELECT SUM(p.total) FROM pago p WHERE forma_pago = v);
    SET cont = (SELECT COUNT(p.total) FROM pago p WHERE forma_pago = v);

END $$
DELIMITER ;

CALL INFO_PAYMENT('PayPal', @max, @min, @avg, @sum, @cont);
SELECT @max AS Maximo, @min AS Minimo, @avg AS Promedio, @sum AS Suma, @cont AS NumeroTotal;

/*
04. Crea una base de datos llamada procedimientos que contenga una tabla llamada cuadrados.
La tabla cuadrados debe tener dos columnas de tipo INT UNSIGNED, una columna llamada número
y otra columna llamada cuadrado.
 */

DROP DATABASE IF EXISTS procedimientos;
CREATE DATABASE procedimientos;
USE procedimientos;

CREATE TABLE cuadrados (
    numero INT UNSIGNED,
    cuadrado INT UNSIGNED
);

/*
 Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_cuadrados
 con las siguientes características. El procedimiento recibe un parámetro de entrada llamado tope de
 tipo INT UNSIGNED y calculará el valor de los cuadrados de los primeros números naturales hasta el
 valor introducido como parámetro. El valor del números y de sus cuadrados deberán ser almacenados en
 la tabla cuadrados que hemos creado previamente.

 Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de la tabla antes de insertar los
 nuevos valores de los cuadrados que va a calcular.

 Utilice un bucle WHILE para resolver el procedimiento.
 */

DROP PROCEDURE IF EXISTS calcular_cuadrados;
DELIMITER $$
CREATE PROCEDURE calcular_cuadrados(IN tope INT UNSIGNED)
BEGIN

    DECLARE i INT UNSIGNED DEFAULT 1;

    DELETE FROM cuadrados;

    while1:WHILE i < tope DO

        INSERT INTO cuadrados VALUES (i, POW(i, 2));
        SET i = i + 1;

    END WHILE while1;

END $$
DELIMITER ;


CALL calcular_cuadrados(5);
SELECT * FROM cuadrados;


/*
 05. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
 */

DROP PROCEDURE IF EXISTS calcular_cuadrados;
DELIMITER $$
CREATE PROCEDURE calcular_cuadrados(IN tope INT UNSIGNED)
BEGIN

    DECLARE i INT UNSIGNED DEFAULT 1;

    DELETE FROM cuadrados;

    repeat1:REPEAT

        INSERT INTO cuadrados VALUES (i, POW(i, 2));
        SET i = i + 1;

    UNTIL i + 1 > tope
    END REPEAT repeat1;

END $$
DELIMITER ;


CALL calcular_cuadrados(5);
SELECT * FROM cuadrados;

/*
 06. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
 */

DROP PROCEDURE IF EXISTS calcular_cuadrados;
DELIMITER $$
CREATE PROCEDURE calcular_cuadrados(IN tope INT UNSIGNED)
BEGIN

    DECLARE i INT UNSIGNED DEFAULT 1;

    DELETE FROM cuadrados;

    calc: LOOP

        IF i = tope THEN

            LEAVE calc;
        END IF ;

        INSERT INTO cuadrados VALUES (i, POW(i, 2));

        SET i = i + 1;

    END LOOP calc ;
END $$
DELIMITER ;


CALL calcular_cuadrados(5);
SELECT * FROM cuadrados;

/*
 07. Crea una base de datos llamada procedimientos que contenga una tabla llamada ejercicio.
 La tabla debe tener una única columna llamada número y el tipo de dato de esta columna debe ser INT UNSIGNED.
 */

CREATE TABLE ejercicios (
    numero INT UNSIGNED
);

/*
 Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_
 números con las siguientes características. El procedimiento recibe un parámetro de entrada
 llamado valor_inicial de tipo INT UNSIGNED y deberá almacenar en la tabla ejercicio toda la
 secuencia de números desde el valor inicial pasado como entrada hasta el 1.

 Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes
 de insertar los nuevos valores.

 Utilice un bucle WHILE para resolver el procedimiento.
 */

DROP PROCEDURE IF EXISTS calcular_numeros;
DELIMITER $$
CREATE PROCEDURE calcular_numeros(IN valor_inicial INT UNSIGNED)
BEGIN

    DELETE FROM ejercicios;

    while1:WHILE valor_inicial != 0 DO

        INSERT INTO ejercicios VALUES (valor_inicial);
        SET valor_inicial = valor_inicial - 1;
    END WHILE ;

END $$
DELIMITER ;

CALL calcular_numeros(6);
SELECT * FROM ejercicios;

/*
 08. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
 */

DROP PROCEDURE IF EXISTS calcular_numeros;
DELIMITER $$
CREATE PROCEDURE calcular_numeros(IN valor_inicial INT UNSIGNED)
BEGIN

    DELETE FROM ejercicios;

    repeat1:REPEAT

        INSERT INTO ejercicios VALUES (valor_inicial);
        SET valor_inicial = valor_inicial - 1;

    UNTIL valor_inicial = 0
    END REPEAT repeat1 ;

END $$
DELIMITER ;

CALL calcular_numeros(6);
SELECT * FROM ejercicios;

/*
09. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
 */

DROP PROCEDURE IF EXISTS calcular_numeros;
DELIMITER $$
CREATE PROCEDURE calcular_numeros(IN valor_inicial INT UNSIGNED)
BEGIN

    DELETE FROM ejercicios;

    loop1:LOOP

        INSERT INTO ejercicios VALUES (valor_inicial);
        SET valor_inicial = valor_inicial - 1;
        IF valor_inicial = 0 THEN

            LEAVE loop1;
        END if ;
    END loop loop1 ;

END $$
DELIMITER ;

CALL calcular_numeros(6);
SELECT * FROM ejercicios;

/*
 10. Crea una base de datos llamada procedimientos que contenga una tabla llamada
 pares y otra tabla llamada impares. Las dos tablas deben tener única columna llamada
 número y el tipo de dato de esta columna debe ser INT UNSIGNED.
 */

DROP TABLE IF EXISTS pares;

CREATE TABLE pares(
    numero INT UNSIGNED
);

CREATE TABLE impares(
    numero INT UNSIGNED
);

/*
 Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado
 calcular_pares_impares con las siguientes características. El procedimiento recibe
 un parámetro de entrada llamado tope de tipo INT UNSIGNED y deberá almacenar en la
 tabla pares aquellos números pares que existan entre el número 1 el valor introducido
 como parámetro. Habrá que realizar la misma operación para almacenar los números impares
 en la tabla impares.

 Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas
 antes de insertar los nuevos valores.

 Utilice un bucle WHILE para resolver el procedimiento.
 */

DROP PROCEDURE IF EXISTS calcular_pares_impares;
DELIMITER $$
CREATE PROCEDURE calcular_pares_impares(IN tope INT UNSIGNED)
BEGIN

    DELETE FROM impares;
    DELETE FROM pares;

    while1:WHILE tope > 1 DO

        IF tope % 2 = 0 THEN

            INSERT INTO pares VALUES (tope);
        ELSE

            INSERT INTO impares VALUES (tope);
        END IF ;

        SET tope = tope - 1;
    END WHILE ;

END $$
DELIMITER ;

CALL calcular_pares_impares(5);
SELECT p.numero AS pares, i.numero AS impares FROM pares p, impares i;

/*
 11. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
*/

DROP PROCEDURE IF EXISTS calcular_pares_impares;
DELIMITER $$
CREATE PROCEDURE calcular_pares_impares(IN tope INT UNSIGNED)
BEGIN

    DELETE FROM impares;
    DELETE FROM pares;

    repat1:REPEAT

        IF tope % 2 = 0 THEN

            INSERT INTO pares VALUES (tope);
        ELSE

            INSERT INTO impares VALUES (tope);
        END IF ;

        SET tope = tope - 1;
    UNTIL tope = 0 END REPEAT ;

END $$
DELIMITER ;

CALL calcular_pares_impares(5);
SELECT p.numero AS pares, i.numero AS impares FROM pares p, impares i;

/*
 12. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
 */

DROP PROCEDURE IF EXISTS calcular_pares_impares;
DELIMITER $$
CREATE PROCEDURE calcular_pares_impares(IN tope INT UNSIGNED)
BEGIN

    DELETE FROM impares;
    DELETE FROM pares;

    loop1: LOOP

        IF tope % 2 = 0 THEN

            INSERT INTO pares VALUES (tope);
        ELSE

            INSERT INTO impares VALUES (tope);
        END IF ;

        SET tope = tope - 1;
        IF tope = 0 THEN
            LEAVE loop1;
        END IF ;
    END LOOP loop1 ;

END $$
DELIMITER ;

CALL calcular_pares_impares(5);
SELECT p.numero AS pares, i.numero AS impares FROM pares p, impares i;


/*
 1.8.3 Funciones sin sentencias SQL
 */

 /*
  01. Escribe una función que reciba un número entero de entrada y devuelva TRUE si el
  número es par o FALSE en caso contrario.
  */

DROP FUNCTION IF EXISTS ISPAR;
DELIMITER $$
CREATE FUNCTION ISPAR(n INT UNSIGNED)
RETURNS boolean
BEGIN
    RETURN !(n % 2);
END $$
DELIMITER ;

SELECT ISPAR(5);
SELECT ISPAR(4);

/*
 02. Escribe una función que devuelva el valor de la hipotenusa de un triángulo a partir
 de los valores de sus lados.
 */

DROP FUNCTION IF EXISTS HYPOTENUSA;
DELIMITER $$
CREATE FUNCTION HYPOTENUSA(l1 DECIMAL UNSIGNED, l2 DECIMAL UNSIGNED)
RETURNS DECIMAL
BEGIN
    RETURN SQRT(l1 * l1 + l2 * l2);
END $$
DELIMITER ;

SELECT HYPOTENUSA(5, 6);

/*
 03. Escribe una función que reciba como parámetro de entrada un valor numérico que represente
 un día de la semana y que devuelva una cadena de caracteres con el nombre del día de la semana
 correspondiente. Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes.
 */

DROP FUNCTION IF EXISTS DAYTOSTRING;
DELIMITER $$
CREATE FUNCTION DAYTOSTRING(n INT UNSIGNED)
RETURNS VARCHAR(15)
BEGIN
    CASE n
        WHEN 1 THEN RETURN 'Lunes';
        WHEN 2 THEN RETURN 'Martes';
        WHEN 3 THEN RETURN 'Miercoles';
        WHEN 4 THEN RETURN 'Jueves';
        WHEN 5 THEN RETURN 'Viernes';
        WHEN 6 THEN RETURN 'Sabado';
        WHEN 7 THEN RETURN 'Domingo';
    END CASE;
END $$
DELIMITER ;

SELECT DAYTOSTRING(2);

/*
 04. Escribe una función que reciba tres números reales como parámetros de entrada y
 devuelva el mayor de los tres.
 */

DROP FUNCTION IF EXISTS MAXNUMBER;
DELIMITER $$
CREATE FUNCTION MAXNUMBER(n1 DECIMAL, n2 DECIMAL, n3 DECIMAL)
RETURNS DECIMAL
BEGIN
    IF n1 > n2 AND n1 > n3 THEN

        RETURN n1;
    ELSE IF n2 > n3 THEN

        RETURN n2;
    ELSE RETURN n3;
    END IF ;
    END IF ;

END $$
DELIMITER ;

SELECT MAXNUMBER(-98, 80, 19);

/*
 05. Escribe una función que devuelva el valor del área de un círculo a partir del
 valor del radio que se recibirá como parámetro de entrada.
 */

DROP FUNCTION IF EXISTS CIRCLEAREA;
DELIMITER $$
CREATE FUNCTION CIRCLEAREA(r DECIMAL UNSIGNED)
RETURNS DECIMAL
BEGIN
    RETURN (r * r) * PI();
END $$
DELIMITER ;

SELECT CIRCLEAREA(2);

/*
 06. Escribe una función que devuelva como salida el número de años que han transcurrido
 entre dos fechas que se reciben como parámetros de entrada. Por ejemplo, si pasamos como
 parámetros de entrada las fechas 2018-01-01 y 2008-01-01 la función tiene que devolver que han pasado 10 años.
 */

DROP FUNCTION IF EXISTS DATEDIFF2;
DELIMITER $$
CREATE FUNCTION DATEDIFF2(date1 DATE, date2 DATE)
RETURNS INT
BEGIN
    IF date1 > date2 THEN

        RETURN TIMESTAMPDIFF(YEAR, date2, date1);
    ELSE
        RETURN TIMESTAMPDIFF(YEAR, date1, date2);
    END if ;

END $$
DELIMITER ;

SELECT DATEDIFF2(STR_TO_DATE('2018-01-01', '%Y-%m-%d'), STR_TO_DATE('2008-01-01', '%Y-%m-%d'));

/*
 07. Escribe una función que reciba una cadena de entrada y devuelva la misma cadena
 pero sin acentos. La función tendrá que reemplazar todas las vocales que tengan acento
 por la misma vocal pero sin acento. Por ejemplo, si la función recibe como parámetro de
 entrada la cadena María la función debe devolver la cadena Maria.
 */

DROP FUNCTION IF EXISTS NORMALIZE;
DELIMITER $$
CREATE FUNCTION NORMALIZE(str TEXT)
RETURNS TEXT
BEGIN

    SET str = REPLACE(str,'Š','S');
    SET str = REPLACE(str,'š','s');
    SET str = REPLACE(str,'Ð','Dj');
    SET str = REPLACE(str,'Ž','Z');
    SET str = REPLACE(str,'ž','z');
    SET str = REPLACE(str,'À','A');
    SET str = REPLACE(str,'Á','A');
    SET str = REPLACE(str,'Â','A');
    SET str = REPLACE(str,'Ã','A');
    SET str = REPLACE(str,'Ä','A');
    SET str = REPLACE(str,'Å','A');
    SET str = REPLACE(str,'Æ','A');
    SET str = REPLACE(str,'Ç','C');
    SET str = REPLACE(str,'È','E');
    SET str = REPLACE(str,'É','E');
    SET str = REPLACE(str,'Ê','E');
    SET str = REPLACE(str,'Ë','E');
    SET str = REPLACE(str,'Ì','I');
    SET str = REPLACE(str,'Í','I');
    SET str = REPLACE(str,'Î','I');
    SET str = REPLACE(str,'Ï','I');
    SET str = REPLACE(str,'Ñ','N');
    SET str = REPLACE(str,'Ò','O');
    SET str = REPLACE(str,'Ó','O');
    SET str = REPLACE(str,'Ô','O');
    SET str = REPLACE(str,'Õ','O');
    SET str = REPLACE(str,'Ö','O');
    SET str = REPLACE(str,'Ø','O');
    SET str = REPLACE(str,'Ù','U');
    SET str = REPLACE(str,'Ú','U');
    SET str = REPLACE(str,'Û','U');
    SET str = REPLACE(str,'Ü','U');
    SET str = REPLACE(str,'Ý','Y');
    SET str = REPLACE(str,'Þ','B');
    SET str = REPLACE(str,'ß','Ss');
    SET str = REPLACE(str,'à','a');
    SET str = REPLACE(str,'á','a');
    SET str = REPLACE(str,'â','a');
    SET str = REPLACE(str,'ã','a');
    SET str = REPLACE(str,'ä','a');
    SET str = REPLACE(str,'å','a');
    SET str = REPLACE(str,'æ','a');
    SET str = REPLACE(str,'ç','c');
    SET str = REPLACE(str,'è','e');
    SET str = REPLACE(str,'é','e');
    SET str = REPLACE(str,'ê','e');
    SET str = REPLACE(str,'ë','e');
    SET str = REPLACE(str,'ì','i');
    SET str = REPLACE(str,'í','i');
    SET str = REPLACE(str,'î','i');
    SET str = REPLACE(str,'ï','i');
    SET str = REPLACE(str,'ð','o');
    SET str = REPLACE(str,'ñ','n');
    SET str = REPLACE(str,'ò','o');
    SET str = REPLACE(str,'ó','o');
    SET str = REPLACE(str,'ô','o');
    SET str = REPLACE(str,'õ','o');
    SET str = REPLACE(str,'ö','o');
    SET str = REPLACE(str,'ø','o');
    SET str = REPLACE(str,'ù','u');
    SET str = REPLACE(str,'ú','u');
    SET str = REPLACE(str,'û','u');
    SET str = REPLACE(str,'ý','y');
    SET str = REPLACE(str,'ý','y');
    SET str = REPLACE(str,'þ','b');
    SET str = REPLACE(str,'ÿ','y');
    SET str = REPLACE(str,'ƒ','f');

    RETURN str;
END $$
DELIMITER ;

SELECT NORMALIZE('Holá');

/*
 1.8.4 Funciones con sentencias SQL
 */

/*
  01. Escribe una función para la base de datos tienda que devuelva el número total
  de productos que hay en la tabla productos.
*/
USE tienda;
DROP FUNCTION IF EXISTS COUNTPRODUCTS;
DELIMITER $$
CREATE FUNCTION COUNTPRODUCTS()
RETURNS INT UNSIGNED
BEGIN
    RETURN (SELECT COUNT(p.codigo) FROM producto p);
END $$
DELIMITER ;

SELECT COUNTPRODUCTS();

/*
 02. Escribe una función para la base de datos tienda que devuelva el valor medio del
 precio de los productos de un determinado fabricante que se recibirá como parámetro de
 entrada. El parámetro de entrada será el nombre del fabricante.
 */

DROP FUNCTION IF EXISTS GET_AVG_PRICE_PRODUCTS_BY_SELLER;
DELIMITER $$
CREATE FUNCTION GET_AVG_PRICE_PRODUCTS_BY_SELLER(seller TEXT)
RETURNS DECIMAL UNSIGNED
BEGIN

    RETURN (SELECT AVG(p.precio)
    FROM producto p INNER JOIN fabricante f
        on p.codigo_fabricante = f.codigo
    WHERE f.nombre = seller);

END $$
DELIMITER ;

SELECT GET_AVG_PRICE_PRODUCTS_BY_SELLER('Asus');

/*
 03. Escribe una función para la base de datos tienda que devuelva el valor máximo del precio
 de los productos de un determinado fabricante que se recibirá como parámetro de entrada.
 El parámetro de entrada será el nombre del fabricante.
 */

DROP FUNCTION IF EXISTS GET_MAX_PRICE_PRODUCT_BY_SELLER;
DELIMITER $$
CREATE FUNCTION GET_MAX_PRICE_PRODUCT_BY_SELLER(seller TEXT)
RETURNS DECIMAL UNSIGNED
BEGIN

    RETURN (SELECT MAX(p.precio)
    FROM producto p INNER JOIN fabricante f
        on p.codigo_fabricante = f.codigo
    WHERE f.nombre = seller);

END $$
DELIMITER ;

SELECT GET_MAX_PRICE_PRODUCT_BY_SELLER('Asus');

/*
 04. Escribe una función para la base de datos tienda que devuelva el valor mínimo del precio
 de los productos de un determinado fabricante que se recibirá como parámetro de entrada.
 El parámetro de entrada será el nombre del fabricante.
 */

DROP FUNCTION IF EXISTS GET_LOWER_PRICE_PRODUCT_BY_SELLER;
DELIMITER $$
CREATE FUNCTION GET_LOWER_PRICE_PRODUCT_BY_SELLER(seller TEXT)
RETURNS DECIMAL UNSIGNED
BEGIN

    RETURN (SELECT MIN(p.precio)
    FROM producto p INNER JOIN fabricante f
        on p.codigo_fabricante = f.codigo
    WHERE f.nombre = seller);

END $$
DELIMITER ;

SELECT GET_LOWER_PRICE_PRODUCT_BY_SELLER('Asus');

/*
 1.8.5 Manejo de errores en MySQL
 */

/*
 01. Crea una base de datos llamada test que contenga una tabla llamada alumno.
 La tabla debe tener cuatro columnas:
  id: entero sin signo (clave primaria).
  nombre: cadena de 50 caracteres.
  apellido1: cadena de 50 caracteres.
  apellido2: cadena de 50 caracteres.
 */

DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
USE test;

CREATE TABLE alumno (
    id INT UNSIGNED PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50)
);

/*
 Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado
 insertar_alumno con las siguientes características. El procedimiento recibe cuatro
 parámetros de entrada (id, nombre, apellido1, apellido2) y los insertará en la tabla alumno.
 El procedimiento devolverá como salida un parámetro llamado error que tendrá un valor
 igual a 0 si la operación se ha podido realizar con éxito y un valor igual a 1 en caso contrario.
 */

DROP PROCEDURE IF EXISTS insertar_alumno;
DELIMITER $$
CREATE PROCEDURE insertar_alumno(IN id INT UNSIGNED, IN nombre TEXT, IN apellido1 TEXT, IN apellido2 TEXT, OUT error BOOLEAN)
BEGIN

    DECLARE EXIT HANDLER FOR 1062 /*SQLSTATE '23000'*/
        BEGIN
            SET error = TRUE;
        END ;

    SET error = FALSE;
    INSERT INTO alumno VALUES (id, nombre, apellido1, apellido2);

END $$
DELIMITER ;

CALL insertar_alumno(2, 'hola', 'hola1', 'hola2', @error);
SELECT @error;

INSERT INTO alumno VALUES (1, 'hola', 'hola1', 'hola2');

/*
  1.8.6 Transacciones con procedimientos almacenados
 */

/*
 Crea una base de datos llamada cine que contenga dos tablas con las siguientes columnas.

  Tabla cuentas:

  id_cuenta: entero sin signo (clave primaria).
  saldo: real sin signo.

  Tabla entradas:

  id_butaca: entero sin signo (clave primaria).
  nif: cadena de 9 caracteres.
 */

DROP DATABASE IF EXISTS cine;
CREATE DATABASE cine;
USE cine;

CREATE TABLE cuentas (
    id_cuenta INT UNSIGNED PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    saldo REAL UNSIGNED
);

CREATE TABLE entradas(
    id_butaca INT UNSIGNED PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    nif VARCHAR(9)
);

INSERT INTO cuentas VALUES (1, 50);

/*
 Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado comprar_entrada
 con las siguientes características. El procedimiento recibe 3 parámetros de entrada
 (nif, id_cuenta, id_butaca) y devolverá como salida un parámetro llamado error que tendrá un
 valor igual a 0 si la compra de la entrada se ha podido realizar con éxito y un valor igual a 1 en caso contrario.


 El procedimiento de compra realiza los siguientes pasos:

  Inicia una transacción.
  Actualiza la columna saldo de la tabla cuentas cobrando 5 euros a la cuenta con el id_cuenta adecuado.
  Inserta una una fila en la tabla entradas indicando la butaca (id_butaca) que acaba de comprar el usuario (nif).
  Comprueba si ha ocurrido algún error en las operaciones anteriores. Si no ocurre ningún error entonces aplica
   un COMMIT a la transacción y si ha ocurrido algún error aplica un ROLLBACK.

 Deberá manejar los siguientes errores que puedan ocurrir durante el proceso.

  ERROR 1264 (Out of range value)
  ERROR 1062 (Duplicate entry for PRIMARY KEY)
 */

DROP PROCEDURE IF EXISTS comprar_entrada;
DELIMITER $$
CREATE PROCEDURE comprar_entrada(IN _nif VARCHAR(9), IN _id_cuenta INT UNSIGNED, IN _id_butaca INT UNSIGNED, OUT error BOOLEAN)
BEGIN

    DECLARE EXIT HANDLER FOR 1264, 1062
        BEGIN
            SET error = TRUE;
            ROLLBACK;
        END ;

    SET error = FALSE;

    START TRANSACTION;
        UPDATE cuentas SET saldo = saldo - 5 WHERE id_cuenta = _id_cuenta;
        INSERT INTO entradas VALUES (_id_butaca, _nif);
    COMMIT;
END $$
DELIMITER ;

CALL comprar_entrada('22222222T', 1, 56, @error);
SELECT @error;

/*
 02. ¿Qué ocurre cuando intentamos comprar una entrada y le pasamos como parámetro un número
 de cuenta que no existe en la tabla cuentas? ¿Ocurre algún error o podemos comprar la entrada?

 En caso de que exista algún error, ¿cómo podríamos resolverlo?.

 Se debe implementar un metodo para verufucar las columnas afectadas en el update para ver su existe un usuario
 con ROW_COUNT() podemos ver las columnas afectadas y verificarlo

 ERROR: Hay un bug en Mariadb que el ROW_COUNT() devuelve 0 siempre.
 */

 /*
  1.8.7 Cursores
  */

/*
 Escribe las sentencias SQL necesarias para crear una base de datos llamada test,
 una tabla llamada alumnos y 4 sentencias de inserción para inicializar la tabla.
 La tabla alumnos está formada por las siguientes columnas:

  id (entero sin signo y clave primaria)
  nombre (cadena de caracteres)
  apellido1 (cadena de caracteres)
  apellido2 (cadena de caracteres
  fecha_nacimiento (fecha)
 */

DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
USE test;

CREATE TABLE alumnos(
    id INT UNSIGNED PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
    nombre VARCHAR(20),
    apellido1 VARCHAR(20),
    apellido2 VARCHAR(20),
    fecha_nacimiento DATE
);

INSERT INTO alumnos VALUES (1, 'Alberto', 'aaa', 'eeeeee', '1985-5-3');
INSERT INTO alumnos VALUES (2, 'Juan', 'iii', 'oooooo', '2000-4-25');
INSERT INTO alumnos VALUES (3, 'Pedro', 'ppp', 'kkkkkk', '1963-9-14');
INSERT INTO alumnos VALUES (4, 'Rodrigo', 'ttt', 'jjjjjj', '1992-1-30');

/*
 Una vez creada la tabla se decide añadir una nueva columna a la tabla llamada edad que
 será un valor calculado a partir de la columna fecha_nacimiento. Escriba la sentencia
 SQL necesaria para modificar la tabla y añadir la nueva columna.
 */

ALTER TABLE alumnos
    add edad INT UNSIGNED;

/*
 Escriba una función llamada calcular_edad que reciba una fecha y devuelva el número
 de años que han pasado desde la fecha actual hasta la fecha pasada como parámetro:

 Función: calcular_edad
 Entrada: Fecha
 Salida: Número de años (entero)
 */

DROP FUNCTION IF EXISTS calcular_edad;
DELIMITER $$
CREATE FUNCTION calcular_edad(fecha_nacimiento DATE)
RETURNS INT UNSIGNED
BEGIN

    RETURN TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE());
END $$
DELIMITER ;

SELECT calcular_edad((SELECT a.fecha_nacimiento FROM alumnos a WHERE id = 1));

/*
 Ahora escriba un procedimiento que permita calcular la edad de todos los alumnmos que ya
 existen en la tabla. Para esto será necesario crear un procedimiento llamado actualizar_columna_edad
 que calcule la edad de cada alumno y actualice la tabla. Este procedimiento hará uso de la función
 calcular_edad que hemos creado en el paso anterior.
 */

DROP PROCEDURE IF EXISTS actualizar_columna_edad;
DELIMITER $$
CREATE PROCEDURE actualizar_columna_edad()
BEGIN

    DECLARE _id INT UNSIGNED;
    DECLARE _fecha_nacimiento DATE;
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE alumnos CURSOR FOR SELECT a.id, a.fecha_nacimiento FROM alumnos a;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
        BEGIN
            SET done = TRUE;
        END ;
    OPEN alumnos;

    loop1:LOOP

        FETCH alumnos INTO _id, _fecha_nacimiento;

        IF done THEN

            LEAVE loop1;
        END if ;

        UPDATE alumnos SET edad = calcular_edad(_fecha_nacimiento) WHERE id = _id;

    END loop loop1;

    CLOSE alumnos;
END $$
DELIMITER ;

CALL actualizar_columna_edad();
SELECT a.id, a.edad FROM alumnos a;

/*
 02. Modifica la tabla alumnos del ejercicio anterior para añadir una nueva columna email.
 Una vez que hemos modificado la tabla necesitamos asignarle una dirección de correo electrónico
 de forma automática.
 */

ALTER TABLE alumnos
    add email VARCHAR(100);

/*
 Escriba un procedimiento llamado crear_email que dados los parámetros de entrada: nombre, apellido1, apellido2 y dominio, cree una dirección de email y la devuelva como salida.

Procedimiento: crear_email

Entrada:
nombre (cadena de caracteres)
apellido1 (cadena de caracteres)
apellido2 (cadena de caracteres)
dominio (cadena de caracteres)

Salida:
email (cadena de caracteres)
devuelva una dirección de correo electrónico con el siguiente formato:

El primer carácter del parámetro nombre.
Los tres primeros caracteres del parámetro apellido1.
Los tres primeros caracteres del parámetro apellido2.
El carácter @.
El dominio pasado como parámetro.
 */

DROP PROCEDURE IF EXISTS crear_email;
DELIMITER $$
CREATE PROCEDURE crear_email(IN _nombre VARCHAR(20), IN _apellido1 VARCHAR(20), IN _apellido2 VARCHAR(20), IN _dominio VARCHAR(50), OUT email VARCHAR(100))
BEGIN

    SET email = LOWER(CONCAT(LEFT(_nombre, 1), LEFT(_apellido1, 3), LEFT(_apellido2, 3), '@', _dominio));
END $$
DELIMITER ;

SELECT LOWER(LEFT(a.nombre, 1)) FROM alumnos a;

/*
 Ahora escriba un procedimiento que permita crear un email para todos los alumnmos que ya existen
 en la tabla. Para esto será necesario crear un procedimiento llamado actualizar_columna_email que
 actualice la columna email de la tabla alumnos. Este procedimiento hará uso del procedimiento
 crear_email que hemos creado en el paso anterior.
 */

DROP PROCEDURE IF EXISTS actualizar_columna_email;
DELIMITER $$
CREATE PROCEDURE actualizar_columna_email()
BEGIN

    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE _id INT UNSIGNED;
    DECLARE _nombre VARCHAR(20);
    DECLARE _apellido1 VARCHAR(20);
    DECLARE _apellido2 VARCHAR(20);
    DECLARE alumnos CURSOR FOR SELECT a.id, a.nombre, a.apellido1, a.apellido2 FROM alumnos a;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
        BEGIN
            SET done = TRUE;
        END ;
    OPEN alumnos;

    loop1:LOOP

        FETCH alumnos INTO _id, _nombre, _apellido1, _apellido2;

        IF done THEN

            LEAVE loop1;
        END IF ;

        CALL crear_email(_nombre, _apellido1, _apellido2, 'salesianos.edu', @email);
        UPDATE alumnos SET email = @email WHERE id = _id;
    END LOOP ;
END $$
DELIMITER ;

CALL actualizar_columna_email;

SELECT * FROM alumnos;

/*
 03. Escribe un procedimiento llamado crear_lista_emails_alumnos que devuelva la lista de emails
 de la tabla alumnos separados por un punto y coma.
 Ejemplo: juan@iescelia.org;maria@iescelia.org;pepe@iescelia.org;lucia@iescelia.org.
 */

DROP PROCEDURE IF EXISTS crear_lista_emails_alumnos;
DELIMITER $$
CREATE PROCEDURE crear_lista_emails_alumnos(OUT emails TEXT)
BEGIN

    DECLARE email VARCHAR(100);
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE alumnos CURSOR FOR SELECT a.email FROM alumnos a;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
        BEGIN
            SET done = TRUE;
        END ;

    OPEN alumnos;

    loop1: LOOP

        FETCH alumnos INTO email;

        IF done THEN

            LEAVE loop1;
        END IF ;

        SET emails = CONCAT_WS(';', emails, email);
    END LOOP loop1 ;

    SELECT emails;

END $$
DELIMITER ;


CALL crear_lista_emails_alumnos(@emails);
SELECT @emails;

/*
 1.8.8 Triggers
 */

/*
 Crea una base de datos llamada test que contenga una tabla llamada alumnos con las siguientes columnas.

Tabla alumnos:

  id (entero sin signo)
  nombre (cadena de caracteres)
  apellido1 (cadena de caracteres)
  apellido2 (cadena de caracteres)
  nota (número real)
 */

DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
USE test;

CREATE TABLE alumnos(
    id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    nombre VARCHAR(20),
    apellido1 VARCHAR(20),
    apellido2 VARCHAR(20),
    nota REAL
);

/*
 Una vez creada la tabla escriba dos triggers con las siguientes características:

Trigger 1: trigger_check_nota_before_insert
  Se ejecuta sobre la tabla alumnos.
  Se ejecuta antes de una operación de inserción.
  Si el nuevo valor de la nota que se quiere insertar es negativo, se guarda como 0.
  Si el nuevo valor de la nota que se quiere insertar es mayor que 10, se guarda como 10.

Trigger2 : trigger_check_nota_before_update
  Se ejecuta sobre la tabla alumnos.
  Se ejecuta antes de una operación de actualización.
  Si el nuevo valor de la nota que se quiere actualizar es negativo, se guarda como 0.
  Si el nuevo valor de la nota que se quiere actualizar es mayor que 10, se guarda como 10.
 */

DROP TRIGGER IF EXISTS trigger_check_nota_before_insert;
DELIMITER $$
CREATE TRIGGER trigger_check_nota_before_insert
    BEFORE INSERT
    ON alumnos FOR EACH ROW
    BEGIN

        IF NEW.nota < 0 THEN

            SET NEW.nota = 0;
        ELSEIF NEW.nota > 10 THEN

            SET NEW.nota = 10;
        END IF ;

    END $$

DELIMITER ;

INSERT INTO alumnos VALUES (1, 'Pepe', 'López', 'López', -1);
INSERT INTO alumnos VALUES (2, 'María', 'Sánchez', 'Sánchez', 11);
INSERT INTO alumnos VALUES (3, 'Juan', 'Pérez', 'Pérez', 8.5);

SELECT * FROM alumnos;

DROP TRIGGER IF EXISTS trigger_check_nota_before_update;
DELIMITER $$
CREATE TRIGGER trigger_check_nota_before_update
    BEFORE UPDATE
    ON alumnos FOR EACH ROW
    BEGIN

        IF NEW.nota < 0 THEN

            SET NEW.nota = 0;
        ELSEIF NEW.nota > 10 THEN

            SET NEW.nota = 10;
        END IF ;

    END $$
DELIMITER ;

UPDATE alumnos SET nota = -4 WHERE id = 1;
UPDATE alumnos SET nota = 14 WHERE id = 2;
UPDATE alumnos SET nota = 9.5 WHERE id = 3;

SELECT * FROM alumnos;


/*
 02. Crea una base de datos llamada test que contenga una tabla llamada alumnos con las siguientes columnas.

 Tabla alumnos:

  id (entero sin signo)
  nombre (cadena de caracteres)
  apellido1 (cadena de caracteres)
  apellido2 (cadena de caracteres)
  email (cadena de caracteres)
 */

DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
USE test;

CREATE TABLE alumnos(
    id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    nombre VARCHAR(20),
    apellido1 VARCHAR(20),
    apellido2 VARCHAR(20),
    email VARCHAR(100)
);
 /*
 Una vez creada la tabla escriba un trigger con las siguientes características:

Trigger: trigger_crear_email_before_insert
  Se ejecuta sobre la tabla alumnos.
  Se ejecuta antes de una operación de inserción.
  Si el nuevo valor del email que se quiere insertar es NULL, entonces se le creará automáticamente una dirección de email y se insertará en la tabla.
  Si el nuevo valor del email no es NULL se guardará en la tabla el valor del email.
  Nota: Para crear la nueva dirección de email se deberá hacer uso del procedimiento crear_email.
 */

DROP TRIGGER IF EXISTS trigger_crear_email_before_insert;
DELIMITER $$
CREATE TRIGGER trigger_crear_email_before_insert
    BEFORE INSERT
    ON alumnos FOR EACH ROW
    BEGIN

        IF NEW.email IS NULL THEN

            CALL crear_email(NEW.nombre, NEW.apellido1, NEW.apellido2, 'salesianos.edu', @email);
            SET NEW.email = @email;
        END iF ;
    END $$

DELIMITER ;

/*
 03. Modifica el ejercicio anterior y añade un nuevo trigger que las siguientes características:
Trigger: trigger_guardar_email_after_update:

  Se ejecuta sobre la tabla alumnos.
  Se ejecuta después de una operación de actualización.
  Cada vez que un alumno modifique su dirección de email se deberá insertar un nuevo registro en una tabla llamada log_cambios_email.
  La tabla log_cambios_email contiene los siguientes campos:

  id: clave primaria (entero autonumérico)
  id_alumno: id del alumno (entero)
  fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)
  old_email: valor anterior del email (cadena de caracteres)
  new_email: nuevo valor con el que se ha actualizado
 */
DROP TABLE IF EXISTS log_cambios_email;
CREATE TABLE log_cambios_email(
    id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    id_alumno INT UNSIGNED,
    fecha_hora DATETIME NOT NULL,
    old_email VARCHAR(100),
    new_email VARCHAR(100)
);

DROP TRIGGER IF EXISTS trigger_guardar_email_after_update;
DELIMITER $$
CREATE TRIGGER trigger_guardar_email_after_update
    AFTER UPDATE
    ON alumnos FOR EACH ROW
    BEGIN

        INSERT INTO log_cambios_email (id_alumno, fecha_hora, old_email, new_email) VALUES (NEW.id, NOW(), OLD.email, NEW.email);
    END $$

DELIMITER ;

INSERT INTO alumnos (nombre, apellido1, apellido2) VALUES ('Alberto', 'ararr', 'uiyiy');

UPDATE alumnos SET email = 'hola@google.es' WHERE id = 1;


/*
 04. Modifica el ejercicio anterior y añade un nuevo trigger que tenga las siguientes características:

 Trigger: trigger_guardar_alumnos_eliminados:

  Se ejecuta sobre la tabla alumnos.
  Se ejecuta después de una operación de borrado.
  Cada vez que se elimine un alumno de la tabla alumnos se deberá insertar un nuevo registro en una
   tabla llamada log_alumnos_eliminados.

 La tabla log_alumnos_eliminados contiene los siguientes campos:

  id: clave primaria (entero autonumérico)
  id_alumno: id del alumno (entero)
  fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)
  nombre: nombre del alumno eliminado (cadena de caracteres)
  apellido1: primer apellido del alumno eliminado (cadena de caracteres)
  apellido2: segundo apellido del alumno eliminado (cadena de caracteres)
  email: email del alumno eliminado (cadena de caracteres)
 */

DROP TABLE IF EXISTS log_alumnos_eliminados;

CREATE TABLE log_alumnos_eliminados(
    id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    id_alumno INT UNSIGNED,
    fecha_hora DATETIME,
    nombre VARCHAR(20),
    apellido1 VARCHAR(20),
    apellido2 VARCHAR(20),
    email VARCHAR(100)
);

DROP TRIGGER IF EXISTS trigger_guardar_alumnos_eliminados;
DELIMITER $$
CREATE TRIGGER trigger_guardar_alumnos_eliminados
    AFTER DELETE
    ON alumnos FOR EACH ROW
    BEGIN

        INSERT INTO log_alumnos_eliminados (id_alumno, fecha_hora, nombre, apellido1, apellido2, email)
        VALUES (OLD.id, NOW(), OLD.nombre, OLD.apellido1, OLD.apellido2, OLD.email);
    END $$

DELIMITER ;

DELETE FROM alumnos WHERE alumnos.id = 1;