CREATE TABLE empleados (
    emp_id INT PRIMARY KEY,
    nombre VARCHAR(25),
    apellido VARCHAR (25),
    nacimiento DATE,
    sex VARCHAR(1),
    sueldo INT,
    id_supervisor INT,
    id_marca INT
);
SELECT * FROM empleados;
-- lineas 8 y 9 son foreign keys para otras tablas.
DROP TABLE empleados;
CREATE TABLE marca (
    marca_id INT PRIMARY KEY,
    nombre_marca VARCHAR(40),
    manager INT,
    manager_inicio DATE,
    FOREIGN KEY(manager) REFERENCES empleados(emp_id) ON DELETE SET NULL
);
SELECT * FROM marca;
ALTER TABLE empleados ADD FOREIGN KEY(id_marca) REFERENCES marca(marca_id) ON DELETE SET NULL;
ALTER TABLE empleados ADD FOREIGN KEY(id_supervisor) REFERENCES empleados(emp_id) ON DELETE SET NULL;
-- No se podia hacer antes porque no estaban las tablas creadas todavia

CREATE TABLE clientes(
    id_clientes INT PRIMARY KEY,
    nombre_cliente VARCHAR(40),
    id_marca INT,
    FOREIGN KEY(id_marca) REFERENCES marca(marca_id) ON DELETE SET NULL
);
SELECT * FROM clientes;
CREATE TABLE trabajo(
    emp_id INT,
    id_clientes INT,
    total_ventas INT,
    PRIMARY KEY(emp_id, id_clientes),
    FOREIGN KEY(emp_id) REFERENCES empleados(emp_id) ON DELETE CASCADE,
    FOREIGN KEY(id_clientes) REFERENCES clientes(id_clientes) ON DELETE CASCADE

);
SELECT * FROM clientes;

CREATE TABLE proveedores(
    id_marca INT,
    nombre VARCHAR(40),
    material VARCHAR(40),
    PRIMARY KEY(id_marca,nombre),
    FOREIGN KEY(id_marca) REFERENCES marca(marca_id) ON DELETE CASCADE
);
SELECT * FROM proveedores;
-- Empleados y Marcas
INSERT INTO empleados VALUES(100, 'Ramiro', 'Parcero', '2004-10-12', 'M', 200, NULL, NULL);

INSERT INTO marca VALUES(1,'Coca-Cola', 100, '2024-05-19');
SELECT * FROM marca;
UPDATE empleados 
SET id_marca = 1
WHERE emp_id = 100;
-- no se podía añadir la marca a la tabla empleados porque todavia no existia esa info

INSERT INTO empleados VALUES(101, 'Walter', 'Parcero', '1973-02-28', 'M', 300, 100, 1);
-- Como la marca 1 y el empleado 100 ya existen, se les puede asignar la foreign key

INSERT INTO empleados VALUE(102, 'Milena', 'Parcero', '2009-11-13', 'F', 150, 100, NULL);

INSERT INTO marca VALUES(2,'Fanta', 102, '2022-08-18');

UPDATE empleados
SET id_marca = 2
WHERE emp_id = 102;

INSERT INTO empleados VALUES(103, 'Esteban', 'Quito', '1980-05-06', 'M', 250, 102, 2 );
INSERT INTO empleados VALUES(104, 'Susana', 'Horia', '2005-10-23', 'F', 215, 102, 2 );
INSERT INTO empleados VALUES(105, 'Agustin', 'Prieto', '2005-11-11', 'M', 230, 102, 2 );

INSERT INTO empleados VALUES(106, 'Emiliano', 'Caserio', '2001-07-02', 'M', 230, 100, NULL);

INSERT INTO marca VALUES(3, 'Cunnington', 106, '2020-09-21');

DROP TABLE clientes;
UPDATE empleados
SET id_marca = 3
WHERE emp_id= 106;

INSERT INTO empleados VALUES(107, 'Franco', 'Marino', '2005-05-17', 'M', 220, 106, 3);
INSERT INTO empleados VALUES(108, 'Mateo', 'Arone', '2006-05-16', 'M', 100, 106, 3);

-- Proveedores
INSERT INTO proveedores VALUES(2, 'El Laterío', 'Latas');
INSERT INTO proveedores VALUES(2, 'Plastiquería', 'Botellas de plástico');
INSERT INTO proveedores VALUES(3, 'Etiquetadora', 'Etiquetas');
INSERT INTO proveedores VALUES(2, 'Taplast', 'Tapitas');
INSERT INTO proveedores VALUES(3, 'Químicos Locos', 'Edulcorante, Saborizante, etc');
INSERT INTO proveedores VALUES(3, 'Ledesma', 'Azúcar');
INSERT INTO proveedores VALUES(3, 'A toda máquina', 'Bienes de capital');
SELECT * FROM proveedores;

-- Clientes
INSERT INTO clientes VALUES(400, 'Coto', 2);
INSERT INTO clientes VALUES(401, 'Carrefour', 2);
INSERT INTO clientes VALUES(402, 'Día %', 3);
INSERT INTO clientes VALUES(403, 'Jumbo', 3);
INSERT INTO clientes VALUES(404, 'Maxi-Consumo', 2);
INSERT INTO clientes VALUES(405, 'Chino', 3);
INSERT INTO clientes VALUES(406, 'Almacén', 2);
SELECT * FROM clientes;

-- Trabajos
INSERT INTO trabajo VALUES(105, 400, 20000);
INSERT INTO trabajo VALUES(102, 401, 10000);
INSERT INTO trabajo VALUES(108, 402, 25000);
INSERT INTO trabajo VALUES(107, 403, 30000);
INSERT INTO trabajo VALUES(108, 403, 15000);
INSERT INTO trabajo VALUES(105, 404, 22000);
INSERT INTO trabajo VALUES(107, 405, 19000);
INSERT INTO trabajo VALUES(102, 406, 28000);
INSERT INTO trabajo VALUES(105, 406, 30000);
SELECT * FROM trabajo;

-- NOTAS Y MAS QUERIES para ver esta DB:
SELECT * FROM empleados ORDER BY sueldo;
SELECT * FROM empleados ORDER BY sueldo DESC;
SELECT * FROM empleados ORDER BY sex, nombre, apellido;
SELECT * FROM empleados WHERE emp_id <= 104;
SELECT * FROM empleados LIMIT 5;
SELECT nombre, apellido FROM empleados;
SELECT nombre AS N, apellido AS A FROM empleados;
SELECT DISTINCT sex FROM empleados;
-- separa los generos de la tabla de los empleados

-- SQL FUNCIONES:

SELECT COUNT(emp_id) FROM empleados;
-- Cuenta la cantidad de empleados que hay en la tabla empleados
SELECT COUNT(id_supervisor) FROM empleados;
-- Cuenta la cantidad de  supervisores que hay en la tabla empleados
SELECT COUNT(emp_id) FROM empleados WHERE sex = 'M' AND nacimiento > '2000-01-01';
-- Cuenta la cantidad de empleados Masculinos nacidos despues del 2000
SELECT AVG(sueldo) FROM empleados;
-- Muestra el promedio de los sueldos de los empleados
SELECT AVG(sueldo) FROM empleados WHERE sex = 'M';
-- Muestra el promedio de los sueldos de los empleados masculinos
SELECT SUM(sueldo) FROM empleados;
-- Muestra la suma de los sueldos de los empleados
SELECT COUNT(sex), sex FROM empleados GROUP BY sex;
-- Cuenta y diferencia la cantidad de empleados masculinos y femeninos (agregacion)
SELECT SUM(total_ventas), emp_id FROM trabajo GROUP BY emp_id;
-- Cuenta la suma de ventas totales que tuvo cada empleado
SELECT * FROM clientes WHERE nombre_cliente LIKE '%our';
-- Muestra, dentro de una tabla, cuales clientes terminan en "our"
SELECT * FROM proveedores WHERE nombre LIKE '%í%';
-- Muestra, dentro de una tabla, cuales proveedores tienen una í entre medio.
SELECT * FROM empleados WHERE nacimiento LIKE '____-10%';
-- Muestra, dentro de una tabla, cuales empleados nacieron en Octubre.
-- ( la wildcard % solo funciona con letras o números)
SELECT nombre FROM empleados UNION SELECT nombre_marca FROM marca;
-- Crea y une una lista del nombre de los empleados y de las marcas
-- Esto funciona cuando pedís el mismo numero de columnas en ambos SELECT
SELECT nombre_cliente, clientes.id_marca FROM clientes UNION SELECT nombre, proveedores.id_marca FROM proveedores;
-- Crea una lista de todos los id_marca tanto de los clientes como de los proveedores
SELECT empleados.emp_id, empleados.nombre, marca.nombre_marca FROM empleados JOIN marca ON empleados.emp_id = marca.manager;
-- Crea una lista de las marcas junto a sus respectviso managers
SELECT empleados.emp_id, empleados.nombre, marca.nombre_marca FROM empleados LEFT JOIN marca ON empleados.emp_id = marca.manager;
-- Crea una lista de las marcas juntos a sus respectivos managers, incluso los empleados que no tienen marca asociada.
-- LEFT JOIN muestra todas filas de la tabla que viene despues del FROM
SELECT empleados.emp_id, empleados.nombre, marca.nombre_marca FROM empleados RIGHT JOIN marca ON empleados.emp_id = marca.manager;
-- Crea una lista de las marcas juntos a sus respectivos managers, incluso las marcas que no tienen empleados asociados.
-- RIGHT JOIN muestra todas filas de la tabla que viene despues del FROM
-- FULL JOIN hace ambas.
SELECT empleados.nombre, empleados.apellido FROM empleados WHERE empleados.emp_id IN (
	SELECT trabajo.emp_id 
    FROM trabajo 
    WHERE trabajo.total_ventas >20000
    );
-- Muestra una lista de los nombres completos de los trabajadores que hayan vendido mas de $20000 (NESTED QUERY)
SELECT clientes.nombre_cliente FROM clientes WHERE clientes.id_marca = (
SELECT marca.marca_id 
FROM marca
 WHERE marca.manager = 102
 LIMIT 1
 );
 
 -- ON DELETE SET NULl elimina toda la correspondencia que tenga la fila eliminada
 DELETE FROM marca WHERE marca_id = 2;
 -- ON DELETE CASCADE elimina TODAS las filas "en cascada" todas las filas que esten asociadas con la fila eliminada.
 
CREATE TABLE trigger_prueba (
  mensaje VARCHAR(100)
  );
  SELECT * FROM trigger_prueba;
 
 -- DELIMITER: cambia el delimitador (;) por otros signos para que no se superpongan durante querys. 
 -- Hay que hacerlo en el commando line de MYSQL directo:
 -- DELIMITER $$
 -- CREATE
 -- TRIGGER mi_trigger BEFORE INSERT ON empleados FOR EACH ROW BEGIN INSERT INTO trigger_prueba VALUES('se agregó un nuevo empleado');
 -- END $$
 -- DELIMITER ;
 -- se cambia el delimiter y después se vuelve a cambiar
 
 -- Para testear, se agrega un nuevo empleado:
INSERT INTO empleados VALUES(109, 'Abril', 'Lazzati', '2005-01-06', 'F', 300, 106, 3);  
SELECT * FROM trigger_prueba;
-- Se me ocurre que se puede usar para automatizar el registro de la entrada y la salida de las cosas, con sus fechas, datos y etc.
-- Como por ejemplo:
-- CREATE TRIGGER mi_trigger1 BEFORE INSERT ON empleados FOR EACH ROW BEGIN INSERT INTO trigger_prueba VALUES(NEW.nombre);
INSERT INTO empleados VALUES(110, 'Peter', 'Parker', '2004-11-02', 'M', 220, 106, 3);
SELECT * FROM trigger_prueba;
 -- CREATE TRIGGER mi_trigger2 BEFORE INSERT ON empleados FOR EACH ROW BEGIN IF NEW.sex = 'M' THEN INSERT INTO trigger_prueba VALUES('se agregó un empleado masculino');
 -- ELSEIF NEW.sex = 'F' THEN INSERT INTO trigger_prueba VALUES('se agregó una empleada femenina');
 -- ELSE INSERT INTO trigger_prueba VALUES('se agregó un empleado sin genero');
 -- END IF;
INSERT INTO empleados VALUES(111, 'Pepe', 'Argento', '1974-08-13', 'M', 200, 106, 3);
SELECT * FROM trigger_prueba;
-- Los triggers aparte de ser usados para INSERT pueden ser usados para UPDATE o DELETE
-- Y en vez de poner BEFORE podes poner AFTER
DROP TRIGGER mi_trigger;

-- ER Diagram es un diagrama que tiene muchas formas, simbolos y textos. Todo se combina para terminar definiendo un modelo de relaciones
-- Convertir TODOS los datos y requisitos en un ER Diagram y eso convertirlo en un DB schema


