SELECT vol.*, loc.localidad
FROM voluntarios AS vol, localidades AS loc
WHERE vol.idLocalidad = loc.idLocalidad
AND loc.localidad LIKE '%villanueva%'