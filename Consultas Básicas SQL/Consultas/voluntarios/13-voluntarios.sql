SELECT vol.*, dep.deporte
FROM voluntarios AS vol, practicar AS prac, deportes AS dep
WHERE vol.IdVoluntarios = prac.IdVoluntarios AND prac.IdDeportes = dep.IdDeporte AND dep.deporte LIKE 'Esquí%'