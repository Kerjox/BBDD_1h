SELECT nombre, fNacimiento, DAYNAME(fNacimiento) AS 'Día Nacimiento', QUARTER(fNacimiento) AS 'Trimestre'
FROM voluntarios