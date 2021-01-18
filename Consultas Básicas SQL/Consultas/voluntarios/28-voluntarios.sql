SELECT vol_old.Nombre, vol_old.Sexo, vol_old.Provincia
FROM voluntarios_old AS vol_old
WHERE vol_old.Nombre LIKE '[A-L]%'
AND vol_old.Sexo = 'M'
AND vol_old.Provincia IN ('A Coruña', 'Lugo', 'Ourense', 'Pontevedra')