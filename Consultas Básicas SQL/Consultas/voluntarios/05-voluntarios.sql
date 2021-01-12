SELECT *
FROM voluntarios
WHERE floor(datediff (now(), fNacimiento)/365) BETWEEN 18 AND 25 AND peso > 70 AND talla IN ('M', 'L')