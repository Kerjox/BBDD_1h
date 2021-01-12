SELECT vol.*, tar.nombre, niv.hablado, pref.Preferencia
FROM voluntarios AS vol, preferencias AS pref, tareas AS tar, nivel AS niv
WHERE vol.IdVoluntarios = pref.IdVoluntario AND vol.IdVoluntarios = niv.IdVoluntario AND pref.IdTarea = tar.IdTarea AND tar.nombre = 'Intérprete' AND niv.hablado = 'Alto' AND pref.Preferencia = 1