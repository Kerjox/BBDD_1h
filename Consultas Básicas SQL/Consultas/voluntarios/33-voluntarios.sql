SELECT vol.*, loc.localidad
FROM voluntarios AS vol, localidades AS loc
WHERE vol.idLocalidad = loc.idLocalidad
AND loc.localidad LIKE '%á%' OR loc.localidad LIKE '%é%' OR loc.localidad LIKE '%í%' OR loc.localidad LIKE '%ó%' OR loc.localidad LIKE '%ú%'