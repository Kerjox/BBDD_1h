SELECT vol.nombre, prov.provincia
FROM voluntarios AS vol, localidades AS loc, provincias AS prov
WHERE vol.idLocalidad = loc.idLocalidad AND loc.idProvincia = prov.idProvincia 
AND prov.provincia IN ('Zaragoza', 'Huesca', 'Teruel') 
AND nombre LIKE '____[P-T]%'