SELECT vol.*, pais.pais
FROM voluntarios AS vol, localidades AS loc, provincias AS prov, paises AS pais
WHERE vol.idLocalidad = loc.idLocalidad AND loc.idProvincia = prov.idProvincia AND prov.idPais = pais.idPais AND pais.pais = 'Extranjeros'