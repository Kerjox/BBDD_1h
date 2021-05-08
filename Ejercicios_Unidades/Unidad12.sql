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
RETURNS DATE
BEGIN
   RETURN DATEDIFF(date1, date2);
END $$
DELIMITER ;

SELECT DATEFIFF(STR_TO_DATE('2018-01-01', '%Y-%m-%d'), STR_TO_DATE('2008-01-01', '%Y-%m-%d'));

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
    id INT UNSIGNED PRIMARY KEY,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50)
);
