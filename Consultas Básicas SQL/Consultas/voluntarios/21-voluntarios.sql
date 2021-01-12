SELECT vol.*, tar.nombre, idio.idioma, niv.hablado, prov.provincia
FROM voluntarios AS vol, preferencias AS pref, tareas AS tar, nivel AS niv, localidades AS loc, provincias AS prov, idiomas AS idio
WHERE vol.IdVoluntarios = pref.IdVoluntario AND pref.IdTarea = tar.IdTarea AND vol.IdVoluntarios = niv.IdVoluntario AND niv.IdIdioma = idio.Ididioma AND vol.idLocalidad = loc.idLocalidad AND loc.idProvincia = prov.idProvincia
AND tar.nombre = 'Conducción'
AND pref.Preferencia = 1
AND idio.idioma = 'Ingles'
AND niv.hablado IN ('Medio', 'Alto')
AND floor(datediff (now(), vol.fNacimiento)/365) > 26
AND vol.carnetB = 'True'
AND prov.provincia = 'Huesca'