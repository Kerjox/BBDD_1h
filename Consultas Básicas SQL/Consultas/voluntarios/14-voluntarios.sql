SELECT *
FROM voluntarios
WHERE MONTH(fNacimiento) = MONTH(NOW()) AND DAY(fNacimiento) = DAY(NOW())