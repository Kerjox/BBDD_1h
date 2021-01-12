SELECT vol.nombre, SUBSTRING(vol.nombre, 2, 2) AS 'Posición 2 y 3 del nombre',prov.provincia, CONCAT_WS(', ', SUBSTRING(prov.provincia, 1, 1), SUBSTRING(prov.provincia, -1, 1)) AS 'Última y primera letra de la provincia'
FROM voluntarios AS vol, localidades AS loc, provincias AS prov
WHERE vol.IdVoluntarios = loc.idLocalidad AND loc.idProvincia = prov.idProvincia