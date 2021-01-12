SELECT vol.*
FROM voluntarios AS vol, localidades AS loc, provincias AS prov
WHERE vol.idLocalidad = loc.idLocalidad AND loc.idProvincia = prov.idProvincia AND prov.provincia NOT IN ('Zaragoza', 'Huesca', 'Teruel')