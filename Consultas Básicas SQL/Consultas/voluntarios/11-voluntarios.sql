SELECT vol.*, lab.labor, idio.idioma, niv.hablado, niv.escrito
FROM voluntarios AS vol, laboral AS lab, nivel AS niv, idiomas AS idio
WHERE vol.idLabor = lab.IdLabor AND vol.IdVoluntarios = niv.IdVoluntario AND niv.IdIdioma = idio.Ididioma AND lab.labor = 'Jubilado' AND idio.idioma IN ('Frances', 'Ingles') AND niv.hablado = 'alto' AND niv.escrito = 'alto'