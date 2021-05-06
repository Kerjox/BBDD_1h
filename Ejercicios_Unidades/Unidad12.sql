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
 */

DROP PROCEDURE IF EXISTS calcular_cuadrados;
DELIMITER $$
CREATE PROCEDURE calcular_cuadrados(IN tope INT UNSIGNED)
BEGIN

    DECLARE i INT UNSIGNED DEFAULT 0;
    calc: LOOP

        SET i = i + 1;
        INSERT INTO cuadrados VALUES (i, POW(i, i));

        IF i = tope THEN

            LEAVE calc;
        END IF ;
    END LOOP calc;
END $$
DELIMITER ;

DELETE FROM cuadrados;
CALL calcular_cuadrados(5);
SELECT * FROM cuadrados;