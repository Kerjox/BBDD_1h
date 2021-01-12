SELECT vol.*, tar.nombre, pref.Preferencia
FROM voluntarios AS vol, preferencias AS pref, tareas AS tar
WHERE vol.IdVoluntarios = pref.IdVoluntario AND pref.IdTarea = tar.IdTarea AND (tar.nombre = 'Informática' AND pref.Preferencia = 1) OR (tar.nombre = 'Conducción' AND pref.Preferencia = 1)