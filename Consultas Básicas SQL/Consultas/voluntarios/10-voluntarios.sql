SELECT vol.*, idio.idioma, niv.hablado, niv.escrito
FROM voluntarios AS vol, nivel AS niv, idiomas AS idio
WHERE vol.IdVoluntarios = niv.IdVoluntario AND niv.IdIdioma = idio.Ididioma AND idio.idioma = 'Ingles' AND niv.hablado = 'alto' AND niv.escrito = 'alto'