SELECT nombre, SUBSTRING(nombre, 1, 3) AS 'Tres Primeros Carácteres', SUBSTRING(nombre, -3, 3) AS 'Tres Últimos Carácteres'
FROM voluntarios