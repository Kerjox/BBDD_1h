/*
 01. Escribe un procedimiento que no tenga ningún parámetro de entrada
 ni de salida y que muestre el texto ¡Hola mundo!.
 */

DELIMITER $$
DROP PROCEDURE IF EXISTS salutacion$$
CREATE PROCEDURE salutacion()
BEGIN
    SELECT "¡Hola mundo!" AS Message;

END
$$
DELIMITER ;

CALL salutacion();

/*
 02. Escribe un procedimiento que reciba un número real de entrada y
 muestre un mensaje indicando si el número es positivo, negativo o cero.
 */

DELIMITER $$
DROP PROCEDURE IF EXISTS checkNumber$$
CREATE PROCEDURE checkNumber(IN n INT)
BEGIN
    IF n > 0 THEN
        SELECT "Positivo" AS Message;
    ELSEIF n = 0 THEN
        SELECT "Cero" AS Message;
    ELSE
        SELECT "Negativo" AS Message;
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

DELIMITER $$
DROP PROCEDURE IF EXISTS checkNumberOUT$$
CREATE PROCEDURE checkNumberOUT(IN n INT, OUT s VARCHAR(20))
BEGIN
    IF n > 0 THEN
        SET s = "Positivo";
    ELSEIF n = 0 THEN
        SET s = "Cero";
    ELSE
        SET s = "Negativo";
    END IF;

END $$
DELIMITER ;

CALL checkNumberOUT(1, @out);
SELECT @out AS Message;