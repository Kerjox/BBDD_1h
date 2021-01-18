SELECT vol.*, tar.nombre, pref.Preferencia, idio.idioma, niv.hablado, floor(datediff (now(), fNacimiento)/365) AS 'Edad'
FROM voluntarios AS vol, preferencias AS pref, tareas AS tar, nivel AS niv, idiomas AS idio
WHERE vol.IdVoluntarios = pref.IdVoluntario AND pref.IdTarea = tar.IdTarea AND niv.IdVoluntario = vol.IdVoluntarios AND niv.IdIdioma = idio.Ididioma 
AND tar.nombre = 'Administrativas' 
AND pref.Preferencia = 2 
AND idio.idioma = 'Ingles' 
AND niv.hablado IN ('Medio', 'Alto') 
AND floor(datediff (now(), vol.fNacimiento)/365) > 40