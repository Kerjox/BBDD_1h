SELECT vol.nombre, prov.provincia
FROM voluntarios AS vol, localidades AS loc, provincias AS prov
WHERE vol.idLocalidad = loc.idLocalidad AND loc.idProvincia = prov.idProvincia
AND vol.nombre LIKE 'A%'
AND prov.provincia IN ('Barcelona', 'Tarragona', 'Lleida', 'Girona')