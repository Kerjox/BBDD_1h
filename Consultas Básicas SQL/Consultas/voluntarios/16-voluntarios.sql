SELECT *
FROM voluntarios
WHERE (MONTH(fNacimiento) >= 12 AND DAY(fNacimiento) >= 21) OR MONTH(fNacimiento) < 3 OR (MONTH(fNacimiento) = 3 AND DAY(fNacimiento) <= 20)