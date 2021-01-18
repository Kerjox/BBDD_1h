SELECT vol.nombre, prov.provincia, 
IF(prov.provincia = 'Zaragoza' || prov.provincia = 'Huesca' || prov.provincia = 'Teruel', 'Aragonés', 
IF(prov.provincia = 'Huelva' || prov.provincia = 'Sevilla' || prov.provincia = 'Cádiz' || prov.provincia = 'Córdoba' || prov.provincia = 'Málaga' || prov.provincia = 'Jaén' || prov.provincia = 'Granada' || prov.provincia = 'Almería', 'Andalúz', '-------')) AS 'Comunidad'
FROM voluntarios AS vol, localidades AS loc, provincias AS prov
WHERE vol.idLocalidad = loc.idLocalidad AND loc.idProvincia = prov.idProvincia