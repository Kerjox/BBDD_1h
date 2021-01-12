SELECT p.TITULO, IF(g.NOMBREGENERO = 'Infantil', 'Para Niños', 'Para Adultos') AS RECOMENDADA
FROM peliculas AS p, generos AS g
WHERE p.GENERO = g.CODIGOGENERO