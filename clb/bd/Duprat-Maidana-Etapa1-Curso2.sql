-- Iniciar transacción
START TRANSACTION;

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS bases_de_datos_2;
USE bases_de_datos_2;

-- Tabla de códigos postales 
CREATE TABLE codigo_postal (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    ciudad VARCHAR(50) NOT NULL
);

-- Tabla de personas (alumnos y profesores)
CREATE TABLE persona (
    id INT AUTO_INCREMENT PRIMARY KEY,
    legajo INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    direccion VARCHAR(100),
    fecha_nacimiento DATE,
    codigo_postal INT NOT NULL,
    FOREIGN KEY (codigo_postal) REFERENCES codigo_postal(id)
);

-- Tabla de roles (define tipos de rol: alumno, profesor, etc.)
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    nivel INT NOT NULL, -- Nivel de acceso (por ejemplo: 1 = alumno, 2 = profesor)
    descripcion VARCHAR(100) NOT NULL
);

-- Tabla de asignación de roles a personas
CREATE TABLE rol (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rolesID INT NOT NULL,
    personaID INT NOT NULL,
    FOREIGN KEY (rolesID) REFERENCES roles(id),
    FOREIGN KEY (personaID) REFERENCES persona(id)
);

-- Tabla de materias
CREATE TABLE materia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
	carga_horaria INT
 );

-- Cursadas (relación alumno-materia por año y semestre)
CREATE TABLE cursada (
    id INT AUTO_INCREMENT PRIMARY KEY,
    personaID INT NOT NULL,
    materiaID INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (personaID) REFERENCES persona(id),
    FOREIGN KEY (materiaID) REFERENCES materia(id)
);

-- Parciales (por materia)
CREATE TABLE parcial (
    id INT AUTO_INCREMENT PRIMARY KEY,
    materiaID INT NOT NULL,
    fecha DATE NOT NULL,
    tipo VARCHAR(20) NOT NULL, -- Ejemplo: 'Primer Parcial', 'Segundo Parcial'
    FOREIGN KEY (materiaID) REFERENCES materia(id)
);

-- Teléfonos de personas
CREATE TABLE telefono (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(15) NOT NULL,
    personaID INT NOT NULL,
    FOREIGN KEY (personaID) REFERENCES persona(id)
);

-- Calificaciones de alumnos en parciales
CREATE TABLE parcial_alumno (
    id_parcial INT NOT NULL,
    id_alumno INT NOT NULL,
    nota DECIMAL(4,2) CHECK (nota >= 0 AND nota <= 10),
    PRIMARY KEY (id_parcial, id_alumno),
    FOREIGN KEY (id_parcial) REFERENCES parcial(id),
    FOREIGN KEY (id_alumno) REFERENCES persona(id)
);

-- Índices para optimizar búsquedas frecuentes
CREATE INDEX idx_nombre_persona ON persona(nombre); -- Búsqueda por nombre
CREATE INDEX idx_materia_nombre ON materia(nombre); -- Búsqueda por materia

 
-- Insertar códigos postales
INSERT INTO codigo_postal (codigo, ciudad) VALUES
('1000', 'Ciudad Autónoma de Buenos Aires'),
('1406', 'Flores'),
('1650', 'San Martín'),
('1708', 'Morón'),
('1900', 'La Plata');

-- Insertar personas (alumnos y profesores)
INSERT INTO persona (legajo, nombre, email, direccion, fecha_nacimiento, codigo_postal) VALUES
(1001, 'Juan Pérez', 'juan.perez@email.com', 'Av. Siempre Viva 123', '2001-05-10', 1),
(1002, 'María Gómez', 'maria.gomez@email.com', 'Calle Falsa 456', '2000-08-15', 2),
(1003, 'Carlos Díaz', 'carlos.diaz@email.com', 'Diagonal Norte 789', '1999-12-01', 3),
(1004, 'Ana Ruiz', 'ana.ruiz@email.com', 'Mitre 2020', '2002-03-25', 4),
(1005, 'Lucía Fernández', 'lucia.fernandez@email.com', 'Alsina 555', '2003-11-11', 5),

-- Profesores
(2001, 'Prof. Marta Salas', 'marta.salas@uni.edu', 'Sarmiento 100', '1980-01-15', 1),
(2002, 'Prof. Jorge López', 'jorge.lopez@uni.edu', 'Belgrano 200', '1975-07-20', 2),
(2003, 'Prof. Laura Torres', 'laura.torres@uni.edu', 'Lavalle 300', '1982-09-30', 3);

-- Insertar roles (alumno = 1, profesor = 2)
INSERT INTO roles (nombre, nivel, descripcion) VALUES
('Alumno', 1, 'Estudiante regular'),
('Profesor', 2, 'Profesor titular o adjunto');

-- Asignar roles a personas
INSERT INTO rol (rolesID, personaID) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), -- Alumnos
(2, 6), (2, 7), (2, 8);               -- Profesores

-- Insertar materias
INSERT INTO materia (nombre, carga_horaria) VALUES
('Base de Datos',4),
('Programación I',4);

-- Insertar cursadas (asociar alumnos a materias)
INSERT INTO cursada (personaID, materiaID, fecha) VALUES
(1, 1, "2024-04-10"),
(2, 1, "2024-04-11"),
(3, 1, "2024-04-12"),
(4, 2, "2024-04-13"),
(5, 2, "2024-04-14");

-- Insertar parciales
INSERT INTO parcial (materiaID, fecha, tipo) VALUES
(1, '2024-04-10', 'Primer Parcial'),
(1, '2024-06-01', 'Segundo Parcial'),
(2, '2024-05-15', 'Parcial Único');

-- Insertar calificaciones (10 notas en total)
INSERT INTO parcial_alumno (id_parcial, id_alumno, nota) VALUES
(1, 1, 7.50),
(1, 2, 8.00),
(1, 3, 6.00),
(2, 1, 9.00),
(2, 2, 5.50),
(2, 3, 7.75),
(3, 4, 7.80),
(3, 5, 8.20);

-- Teléfonos (opcional)
INSERT INTO telefono (numero, personaID) VALUES
('1123456789', 1),
('1134567890', 2),
('1145678901', 3),
('1156789012', 4),
('1167890123', 5),
('1178901234', 6),
('1189012345', 7),
('1190123456', 8);



-- Confirmar cambios
COMMIT;
