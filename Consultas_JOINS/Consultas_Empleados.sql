/*
 1.2.4 Consultas multitabla (Composición interna)
 */

 /*
  01. Devuelve un listado con los empleados y los datos de los departamentos donde
  trabaja cada uno.
  */

SELECT emp.nombre, dep.nombre
FROM empleado AS emp INNER JOIN departamento AS dep on
    emp.codigo_departamento = dep.codigo;

/*
 02. Devuelve un listado con los empleados y los datos de los departamentos donde
 trabaja cada uno. Ordena el resultado, en primer lugar por el nombre del departamento
 (en orden alfabético) y en segundo lugar por los apellidos y el nombre de los empleados.
 */

SELECT emp.nombre, emp.apellido1, emp.apellido2, dep.nombre
FROM empleado emp INNER JOIN departamento dep on
    emp.codigo_departamento = dep.codigo
ORDER BY dep.nombre, emp.apellido1, emp.apellido2, emp.nombre;

/*
 03. Devuelve un listado con el código y el nombre del departamento, solamente de
 aquellos departamentos que tienen empleados.
 */

SELECT DISTINCT dep.codigo, dep.nombre
FROM departamento AS dep INNER JOIN empleado e on
    dep.codigo = e.codigo_departamento;

/*
 04. Devuelve un listado con el código, el nombre del departamento y el valor del
 presupuesto actual del que dispone, solamente de aquellos departamentos que tienen
 empleados. El valor del presupuesto actual lo puede calcular restando al valor del
 presupuesto inicial (columna presupuesto) el valor de los gastos que ha generado
 (columna gastos).
 */

SELECT DISTINCT dep.codigo, dep.nombre, dep.presupuesto - dep.gastos AS Presupuesto_Actual
FROM departamento AS dep INNER JOIN empleado e on
    dep.codigo = e.codigo_departamento;

/*
 05. Devuelve el nombre del departamento donde trabaja el empleado que tiene
 el nif 38382980M
 */

SELECT dep.nombre
FROM departamento AS dep INNER JOIN empleado emp on dep.codigo = emp.codigo_departamento
WHERE emp.nif = "38382980M";

/*
 06. Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana
 */

SELECT dep.nombre
FROM departamento AS dep INNER JOIN empleado emp on dep.codigo = emp.codigo_departamento
WHERE emp.nombre = "Pepe" AND emp.apellido1 = "Ruiz" AND emp.apellido2 = "Santana";