CREATE DATABASE gosport1;
USE gosport1;

CREATE TABLE rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50)
);

CREATE TABLE ciudad (
    id_ciudad INT AUTO_INCREMENT PRIMARY KEY,
    nombre_ciudad VARCHAR(100)
);

CREATE TABLE localidad (
    id_localidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre_localidad VARCHAR(100),
    id_ciudad INT,
    FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100) UNIQUE,
    contraseña VARCHAR(255),
    telefono VARCHAR(20),
    id_rol INT,
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

CREATE TABLE deporte (
    id_deporte INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    jugadores_por_equipo INT
);

CREATE TABLE tipoCancha (
    id_tipo_cancha INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    descripcion VARCHAR(100)
);
CREATE TABLE direccion (
    id_direccion INT AUTO_INCREMENT PRIMARY KEY,
    id_localidad INT,
    barrio VARCHAR(50),
    calle VARCHAR(100),
    coordenadas VARCHAR(100),
    FOREIGN KEY (id_localidad) REFERENCES localidad(id_localidad)
);

CREATE TABLE cancha (
    id_cancha INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    capacidad INT,
    precio_hora DECIMAL(10,2),
    estado ENUM('disponible', 'mantenimiento'),
    reservada BOOLEAN,
    foto VARCHAR(100),
    stock int null,
    id_tipo_cancha INT,
    id_direccion INT,
    id_deporte INT,
    id_admin_cancha INT,
    FOREIGN KEY (id_tipo_cancha) REFERENCES tipoCancha(id_tipo_cancha),
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion),
    FOREIGN KEY (id_deporte) REFERENCES deporte(id_deporte),
    FOREIGN KEY (id_admin_cancha) REFERENCES clientes(id_cliente)
);
CREATE TABLE reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_cancha INT,
    fecha_reserva DATE,
	hora_inicio DATETIME,
    fecha_fin DATETIME,
    estado ENUM('pendiente', 'confirmada', 'cancelada'),
    FOREIGN KEY ( id_usuario) REFERENCES  usuario(id_usuario),
    FOREIGN KEY (id_cancha) REFERENCES cancha(id_cancha)
);

CREATE TABLE metodo_pago (
    id_metodo_pago INT AUTO_INCREMENT PRIMARY KEY,
    nombre_metodo VARCHAR(50)
);

CREATE TABLE pago (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_reserva INT,
    monto DECIMAL(10,2),
    id_metodo_pago INT,
    estado ENUM('pendiente', 'completado', 'cancelado'),
    fecha_pago DATETIME,
    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva),
    FOREIGN KEY (id_metodo_pago) REFERENCES metodo_pago(id_metodo_pago)
);

CREATE TABLE factura (
    id_factura INT AUTO_INCREMENT PRIMARY KEY,
    id_pago INT,
     id_usuario INT,
    id_reserva INT,
    id_cancha INT,
    fecha_emision DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (id_pago) REFERENCES pago(id_pago),
    FOREIGN KEY ( id_usuario) REFERENCES usuario( id_usuario),
    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva),
    FOREIGN KEY (id_cancha) REFERENCES cancha(id_cancha)
);

CREATE TABLE eventos (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    foto VARCHAR(100),
    id_reserva INT,
    id_deporte INT,
    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva),
    FOREIGN KEY (id_deporte) REFERENCES deporte(id_deporte)
);

CREATE TABLE participante_evento (
    id_par_evento INT AUTO_INCREMENT PRIMARY KEY,
    id_evento INT,
    id_usuario INT,
    FOREIGN KEY (id_evento) REFERENCES eventos(id_evento),
    FOREIGN KEY ( id_usuario) REFERENCES usuario( id_usuario)
);

create table torneos (
id_torneo INT AUTO_INCREMENT PRIMARY KEY,
nombre_torneo VARCHAR(100) NOT NULL,
fecha_inicio DATE,
fecha_fin DATE,
categoria VARCHAR(50),
premiso VARCHAR(100)
);

create table inscripcion_torneo(
id_detalle_torneo INT AUTO_INCREMENT PRIMARY KEY,
id_torneo int,
id_usuario int,
FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo),
FOREIGN KEY ( id_usuario) REFERENCES usuario( id_usuario)
);

INSERT INTO rol (nombre_rol) VALUES 
('jugador'), ('admin_app'), ('admin_cancha');

INSERT INTO ciudad (nombre_ciudad) VALUES 
('bogota');

INSERT INTO localidad (nombre_localidad, id_ciudad) VALUES 
('bosa', 1);

INSERT INTO usuario (nombre, correo, contraseña, telefono, id_rol) VALUES
('carlos ruiz', 'carlos@gmail.com', '12345', '3011111111', 1),
('laura mora', 'laura@gmail.com', '12345', '3022222222', 2),
('daniel torres', 'daniel@gmail.com', '12345', '3033333333', 3),
('alejandra mesa', 'alejandra@gmail.com', '12345', '3044444444', 1),
('alejandro povera', 'alejan@gmail.com', '12345', '3208573445', 2),
('Felipe gutierra', 'felipegarzon@gmail.com', '12345', '3155719255', 3),
('juan viras', 'juanguatauva@gmail.com', '12345', '3244604908', 1),
('analia mendoza', 'analiamendez@gmail.com', '12345', '3118795919', 1),
('gustavo cerrati', 'cerconioviscons01@gmail.com', '12345', '3521511211', 2),
('vicente fernandez', 'davidgonzaleschente@gmail.com', '12345', '3502244508', 3);

INSERT INTO deporte (nombre, jugadores_por_equipo) VALUES 
('futbol', 11),
('futbol sala', 5),
('futbol 8', 8),
('futbol', 11),
('futbol sala', 5),
('futbol 8', 8),
('futbol', 11),
('futbol sala', 5),
('futbol 8', 8),
('futbol', 11);

INSERT INTO tipoCancha (nombre, descripcion) VALUES 
('futbol 5', 'cancha para 5 jugadores'),
('futbol 8', 'cancha para 8 jugadores'),
('futbol 11', 'cancha para 11 jugadores'),
('futbol 5', 'cancha para 5 jugadores'),
('futbol 8', 'cancha para 8 jugadores'),
('futbol 11', 'cancha para 11 jugadores'),
('futbol 5', 'cancha para 5 jugadores'),
('futbol 8', 'cancha para 8 jugadores'),
('futbol 11', 'cancha para 11 jugadores'),
('futbol 5', 'cancha para 5 jugadores');

INSERT INTO direccion (calle, coordenadas, id_localidad, barrio) VALUES 
('cra 45 # 100-22', '4.65,-74.05', 1, 'barrio1'),
('cll 32 # 15-80', '4.64,-74.07', 1, 'barrio2'),
('av 1 de mayo # 50-30', '4.60,-74.10', 1, 'barrio3'),
('cra 10 # 12-60', '4.66,-74.08', 1, 'barrio4'),
('cll 80 # 20-15', '4.68,-74.06', 1, 'barrio5'),
('cra 68 # 48-12', '4.63,-74.09', 1, 'barrio6'),
('cll 26 # 96-45', '4.61,-74.12', 1, 'barrio7'),
('av boyacá # 75-22', '4.67,-74.11', 1, 'barrio8'),
('cll 100 # 23-10', '4.64,-74.13', 1, 'barrio9'),
('cra 7 # 34-56', '4.62,-74.14', 1, 'barrio10');

INSERT INTO cancha (nombre, capacidad, precio_hora, estado, reservada, foto,stock, id_tipo_cancha, id_direccion, id_deporte, id_admin_cancha) VALUES 
('cancha norte bosa', 11, 60000, 'disponible', false, 'cancha3.jpg',100000, 3, 3, 1, 3),
('cancha sur bosa', 10, 50000, 'mantenimiento', false, 'cancha4.jpg',null, 1, 4, 2, 3),
('cancha deportiva ', 10, 75000, 'disponible', true, 'cancha5.jpg',80000, 2, 5, 3, 3),
('cancha sintetica', 5, 85000, 'disponible', false, 'cancha6.jpg',100000, 3, 6, 8, 6),
('cancha la mejor', 8, 40000, 'disponible', true, 'cancha7.jpg',null, 1, 7, 9, 6),
('cancha fuchibol', 8, 45000, 'mantenimiento', false, 'cancha8.jpg',50000, 1, 8, 7, 6),
('cancha los pinos', 8, 90000, 'disponible', false, 'cancha9.jpg',null, 2, 9, 4, 6),
('cancha diamante', 14, 100000, 'disponible', true, 'cancha10.jpg',200000, 3, 10, 5, 10),
('cancha élite', 13, 95000, 'disponible', false, 'cancha11.jpg',95000, 2, 1, 6, 10),
('cancha popular', 10, 35000, 'mantenimiento', true, 'cancha12.jpg',null, 1, 2, 10, 10);

INSERT INTO metodo_pago (nombre_metodo) VALUES 
('efectivo'), ('nequi'), ('tarjeta');

INSERT INTO reservas (  id_usuario, id_cancha, fecha_reserva, hora_inicio, hora_fin, estado) VALUES 
(1, 3, '2025-06-24', '09:00:00', '10:00:00', 'confirmada'),
(4, 1, '2025-06-25', '18:00:00',  '19:00:00', 'pendiente'),
(7, 5, '2025-06-26', '12:00:00',  '13:30:00', 'cancelada'),
(8, 6, '2025-06-27', '07:00:00',  '08:00:00', 'confirmada'),
(7, 7, '2025-06-28', '20:00:00',  '21:00:00', 'confirmada'),
(1, 8, '2025-06-29', '10:30:00', '11:30:00', 'pendiente'),
(4, 9, '2025-06-30', '13:00:00', '14:00:00', 'confirmada'),
(8, 10,'2025-07-01', '15:00:00', '16:00:00', 'cancelada'),
(1, 2, '2025-07-02', '08:00:00', '09:00:00', 'confirmada'),
(7, 4, '2025-07-03', '17:00:00',  '18:30:00', 'pendiente');

INSERT INTO pago (id_reserva, monto, id_metodo_pago, estado, fecha_pago) VALUES 
(1, 50000, 2, 'completado', '2025-06-21 12:00:00'),
(2, 80000, 3, 'pendiente', '2025-06-22 10:30:00'),
(3, 60000, 1, 'completado', '2025-06-23 11:00:00'),
(4, 75000, 2, 'pendiente', '2025-06-24 14:30:00'),
(5, 40000, 3, 'cancelado', '2025-06-25 09:45:00'),
(6, 50000, 1, 'completado', '2025-06-26 08:00:00'),
(7, 85000, 2, 'completado', '2025-06-27 19:15:00'),
(8, 45000, 3, 'pendiente', '2025-06-28 10:00:00'),
(9, 70000, 1, 'completado', '2025-06-29 12:20:00'),
(10,55000, 2, 'cancelado', '2025-06-30 15:10:00');

INSERT INTO factura (id_pago, id_usuario, id_reserva, id_cancha, fecha_emision, total) VALUES 
(1, 1, 1, 1, '2025-06-22', 50000),
(2, 8, 2, 2, '2025-06-23', 80000),
(3, 7, 3, 3, '2025-06-24', 60000),
(4, 4, 4, 4, '2025-06-25', 75000),
(5, 7, 5, 5, '2025-06-26', 40000),
(6, 8, 6, 6, '2025-06-27', 50000),
(7, 4, 7, 7, '2025-06-28', 85000),
(8, 1, 8, 8, '2025-06-29', 45000),
(9, 4, 9, 9, '2025-06-30', 70000),
(10, 1, 10, 10, '2025-07-01', 55000);

INSERT INTO eventos (nombre, descripcion, foto, id_reserva, id_deporte) VALUES 
('encuentro juvenil', 'amistoso de menores', 'evento3.jpg', 3, 2),
('semifinal torneo escolar', 'semifinal zona norte', 'evento4.jpg', 4, 3),
('amistoso domingo', 'amistoso familiar', 'evento5.jpg', 5, 1),
('clásico local', 'equipos tradicionales', 'evento6.jpg', 6, 1),
('fase final copa barrio', 'últimos partidos', 'evento7.jpg', 7, 2),
('reto universitario', 'retadores de diferentes universidades', 'evento8.jpg', 8, 3),
('amistoso femenino', 'jugadoras destacadas', 'evento9.jpg', 9, 1),
('cierre de temporada', 'evento de clausura', 'evento10.jpg', 10, 2),
('cuadrangular express', 'cuatro equipos en una tarde', 'evento11.jpg', 7, 1),
('torneo relámpago', 'jornada única', 'evento12.jpg', 8, 3);

INSERT INTO participante_evento (id_evento,  id_usuario) VALUES 
(1, 1),
(2, 10),
(3, 2),
(4, 3),
(5, 4),
(6, 5),
(7, 6),
(8, 7),
(9, 8),
(10, 9);

INSERT INTO Torneos (nombre, fechaInicio, fechaFin, categoria, premio)	VALUES
('Torneo Fútbol 5 Verano', '2025-01-10', '2025-01-20', 'Libre', 'Trofeo y medallas'),
('Copa Tenis Primavera', '2025-02-05', '2025-02-15', 'Juvenil', 'Raquetas y premio en efectivo'),
('Campeonato Baloncesto Mixto', '2025-03-01', '2025-03-12', 'Mixto', 'Camisetas oficiales'),
('Torneo de Voleibol Playa', '2025-04-10', '2025-04-20', 'Adulto', 'Premio en efectivo'),
('Copa Infantil Fútbol 7', '2025-05-05', '2025-05-15', 'Infantil', 'Balones y medallas'),
('Campeonato de Pádel', '2025-06-01', '2025-06-10', 'Libre', 'Trofeo'),
('Torneo Relámpago Baloncesto', '2025-07-08', '2025-07-08', 'Libre', 'Bonos deportivos'),
('Copa Senior Tenis', '2025-08-15', '2025-08-25', 'Senior', 'Viaje deportivo'),
('Campeonato Regional Fútbol 11', '2025-09-01', '2025-09-15', 'Libre', 'Premio en efectivo'),
('Torneo de Natación', '2025-10-05', '2025-10-12', 'Infantil', 'Medallas y trofeo');

INSERT INTO inscripcion_torneo (id_usuario, id_torneo)
VALUES
(1, 1),
(4, 2),
(7, 3),
(8, 4),
(7, 5),
(8, 6),
(1, 7),
(4, 8),
(7, 9),
(1, 10);


SELECT id_evento FROM eventos ORDER BY id_evento;
SELECT id_cliente FROM clientes ORDER BY id_cliente;

SELECT c.nombre, c.correo
FROM clientes c
INNER JOIN rol r ON c.id_rol = r.id_rol
WHERE r.nombre_rol = (
    SELECT nombre_rol
    FROM rol
    WHERE nombre_rol = 'jugador'
);

SELECT c.nombre AS nombre_cliente, ca.nombre AS nombre_cancha, r.fecha_inicio, r.fecha_fin
FROM reservas r
INNER JOIN clientes c ON r.id_cliente = c.id_cliente
INNER JOIN cancha ca ON r.id_cancha = ca.id_cancha
WHERE r.estado = (
    SELECT estado
    FROM reservas
    WHERE estado = 'confirmada'
    LIMIT 1
);

SELECT cl.nombre AS cliente, f.total, f.fecha_emision
FROM factura f
INNER JOIN pago p ON f.id_pago = p.id_pago
INNER JOIN reservas r ON p.id_reserva = r.id_reserva
INNER JOIN clientes cl ON r.id_cliente = cl.id_cliente
WHERE p.estado = (
    SELECT estado
    FROM pago
    WHERE estado = 'completado'
    LIMIT 1
);

CREATE ROLE 'desarrollador';
GRANT SELECT ON gosport1.* TO 'desarrollador';

CREATE ROLE 'administrador';
GRANT INSERT, UPDATE ON gosport1.* TO 'administrador';

CREATE USER 'nicolasdes'@'localhost' IDENTIFIED BY '19283';
GRANT 'desarrollador', 'administrador' TO 'nicolasdes'@'localhost';

SHOW GRANTS FOR 'nicolasdes'@'localhost';

SQL
DELIMITER $$
CREATE PROCEDURE registrar_reserva(
 IN c_id_cancha INT,
 IN c_precio_hora INT,
 OUT c_id_nuevo_reserva INT
)
BEGIN	
 -- Declarar variable para el stock actual
 DECLARE v_stock_actual INT;
 -- Iniciar transacción
 START TRANSACTION;
 -- Obtener el stock actual y bloquear la fila para evitar concurrencia
 SELECT stock INTO v_stock_actual FROM cancha WHERE id_cancha =
c_id_cancha FOR UPDATE;
-- Validar si hay stock suficiente
 IF v_stock_actual >= '50000' THEN
 -- Actualizar el stock del producto
 UPDATE cancha SET stock = stock - c_precio_hora WHERE id_cancha =
c_id_cancha;
-- Insertar el nuevo pedido
 INSERT INTO cancha (id_cancha, precio_hora) VALUES (c_id_cancha,
c_precio_hora);
 -- Obtener el ID del nuevo pedido para devolverlo
 SET c_id_nuevo_reserva = LAST_INSERT_ID();
 -- Confirmar la transacción
 COMMIT;
 END IF;
END$$
DELIMITER ;
drop procedure registrar_reserva;
-- Llamar al procedimiento y pasarle los parámetros
CALL registrar_reserva(10,5, @nuevo_id);
-- Consultar el valor del parámetro de salida
SELECT @nuevo_id;

