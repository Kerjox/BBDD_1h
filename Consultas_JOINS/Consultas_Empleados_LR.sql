/*
 01. Devuelve un listado con todos los empleados junto con los
 datos de los departamentos donde trabajan. Este listado
 también debe incluir los empleados que no tienen ningún
 departamento asociado.
 */

SELECT e.nombre, d.nombre
FROM empleado e LEFT JOIN departamento d on
    d.codigo = e.codigo_departamento;

/*
 02. Devuelve un listado donde sólo aparezcan aquellos
 empleados que no tienen ningún departamento asociado.
 */

SELECT e.nombre, d.nombre
FROM empleado e LEFT JOIN departamento d on
    d.codigo = e.codigo_departamento
WHERE d.nombre IS NULL;

/*
 03. Devuelve un listado donde sólo aparezcan aquellos
 departamentos que no tienen ningún empleado asociado.
 */

SELECT d.nombre
FROM empleado e RIGHT JOIN departamento d on
    d.codigo = e.codigo_departamento
WHERE e.nombre IS NULL;

/*
 04. Devuelve un listado con todos los empleados junto con los
 datos de los departamentos donde trabajan. El listado debe incluir
 los empleados que no tienen ningún departamento asociado y los
 departamentos que no tienen ningún empleado asociado. Ordene el
 listado alfabéticamente por el nombre del departamento.
 */

(SELECT e.nombre, d.nombre AS Departamento
FROM empleado e LEFT JOIN departamento d on
    d.codigo = e.codigo_departamento)
UNION
(SELECT e.nombre, d.nombre AS Departamento
FROM empleado e RIGHT JOIN departamento d on
    d.codigo = e.codigo_departamento)
ORDER BY Departamento;

/*
 05. Devuelve un listado con los empleados que no
 tienen ningún departamento asociado y los departamentos
 que no tienen ningún empleado asociado. Ordene el listado
 alfabéticamente por el nombre del departamento.
 */

(SELECT e.nombre, d.nombre AS Departamento
    FROM empleado e LEFT JOIN departamento d on
        d.codigo = e.codigo_departamento
    WHERE d.nombre IS NULL)
UNION
(SELECT e.nombre, d.nombre AS Departamento
FROM departamento d LEFT JOIN empleado e on
    d.codigo = e.codigo_departamento
    WHERE e.nombre IS NULL)
ORDER BY Departamento;