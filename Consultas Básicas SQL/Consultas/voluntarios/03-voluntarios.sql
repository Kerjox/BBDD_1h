SELECT vol.*
FROM voluntarios AS vol, localidades AS loc
WHERE vol.idLocalidad = loc.idLocalidad AND loc.localidad = 'Jaca'