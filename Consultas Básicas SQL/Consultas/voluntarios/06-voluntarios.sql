SELECT vol.*, loc.localidad
FROM voluntarios AS vol, localidades AS loc
WHERE vol.idLocalidad = loc.idLocalidad AND (floor(datediff (now(), fNacimiento)/365) BETWEEN 26 AND 40 AND loc.localidad = 'Zaragoza') OR (floor(datediff (now(), fNacimiento)/365) BETWEEN 26 AND 40 AND loc.localidad = 'Huesca')