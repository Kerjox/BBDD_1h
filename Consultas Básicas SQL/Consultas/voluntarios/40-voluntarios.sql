SELECT Nombre, FechaNacimiento, Edad, DATE_FORMAT(,'%y-%m-%d')  AS 'Edad Exacta'
FROM voluntarios_old