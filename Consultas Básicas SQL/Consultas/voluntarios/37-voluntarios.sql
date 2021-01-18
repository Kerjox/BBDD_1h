SELECT nombre, TO_DAYS(NOW()) - TO_DAYS(fNacimiento) AS 'Días vividos'
FROM voluntarios