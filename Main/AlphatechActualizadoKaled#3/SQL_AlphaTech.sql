CREATE DATABASE IF NOT EXISTS alphatech;
USE alphatech;

-- Tabla: roles
CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(100) NOT NULL
);

-- Tabla: categorias
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);

-- Tabla: cupones
CREATE TABLE cupones (
    id_cupon INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(255),
    descuento DECIMAL(5, 2) NOT NULL,
    fecha_expiracion DATE,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla: usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    telefono VARCHAR(100),
    fecha_registro DATE NOT NULL,
    rol_id INT,
    FOREIGN KEY (rol_id) REFERENCES roles(id_rol)
);

-- Tabla: productos
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    imagen_url VARCHAR(255),
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id_categoria)
);

-- Tabla: carrito
CREATE TABLE carrito (
    id_carrito INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_creacion DATETIME NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla: carrito_productos
CREATE TABLE carrito_productos (
    id_carrito_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_carrito INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_carrito) REFERENCES carrito(id_carrito),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Tabla: ventas
CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_venta DATETIME NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    cupon_aplicado VARCHAR(50) NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla: detalle_venta
CREATE TABLE detalle_venta (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Tabla: tickets_soporte
CREATE TABLE tickets_soporte (
    id_ticket INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    asunto VARCHAR(255) NOT NULL,
    mensaje TEXT NOT NULL,
    fecha_envio DATE NOT NULL,
    estado BOOLEAN DEFAULT FALSE, -- FALSE: Abierto, TRUE: Cerrado
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla: restablecer_contrasena
CREATE TABLE restablecer_contrasena (
    id_token INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    token VARCHAR(255) NOT NULL,
    fecha_creacion DATETIME NOT NULL,
    usado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla: favoritos
CREATE TABLE favoritos (
    id_favorito INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_producto INT NOT NULL,
    fecha_agregado DATE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    UNIQUE KEY usuario_producto_favorito (id_usuario, id_producto)
);

-- Tabla: notificaciones
CREATE TABLE notificaciones (
    id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    mensaje TEXT NOT NULL,
    fecha_envio DATETIME NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);




-- INSERTS PARA LA TABLA: roles
INSERT INTO roles (nombre_rol) VALUES
('Administrador'),
('Cliente'),
('Editor'),
('Soporte');

-- INSERTS PARA LA TABLA: categorias
INSERT INTO categorias (nombre_categoria) VALUES
('Electrónica'),
('Ropa y Accesorios'),
('Hogar y Jardín'),
('Libros y Revistas'),
('Deportes'),
('Juguetes y Juegos'),
('Salud y Belleza'),
('Automotriz'),
('Alimentos y Bebidas'),
('Mascotas');

-- INSERTS PARA LA TABLA: cupones
INSERT INTO cupones (codigo, descripcion, descuento, fecha_expiracion, activo) VALUES
('VERANO2025', '15% de descuento en toda la tienda', 15.00, '2025-09-30', TRUE),
('BIENVENIDA10', '10% para nuevos usuarios', 10.00, '2025-12-31', TRUE),
('INVIERNO2024', 'Descuento de temporada de invierno', 20.00, '2024-12-21', FALSE),
('FLASH24H', 'Oferta válida solo por 24 horas', 25.00, '2025-07-19', TRUE),
('ENVIOFREE', 'Envío gratuito en compras mayores a $50', 5.00, '2025-08-31', TRUE);

-- INSERTS PARA LA TABLA: usuarios
-- Nota: En una aplicación real, las contraseñas deben estar hasheadas (ej. con BCRYPT).
INSERT INTO usuarios (nombre, apellido, email, contrasena, telefono, fecha_registro, rol_id) VALUES
('Carlos', 'Rivera', 'carlos.rivera@example.com', 'hash_contrasena_1', '8888-1234', '2024-01-15', 2),
('Ana', 'Gomez', 'ana.gomez@example.com', 'hash_contrasena_2', '8777-5678', '2024-02-20', 2),
('Luis', 'Martinez', 'luis.martinez@example.com', 'hash_contrasena_3', '8666-9012', '2024-03-10', 2),
('Sofia', 'Hernandez', 'sofia.hernandez@example.com', 'hash_contrasena_4', '8555-3456', '2024-04-05', 1),
('David', 'Chaves', 'david.chaves@example.com', 'hash_contrasena_5', '8444-7890', '2024-05-21', 2),
('Laura', 'Jimenez', 'laura.jimenez@example.com', 'hash_contrasena_6', '8333-2109', '2024-06-18', 2),
('Pedro', 'Morales', 'pedro.morales@example.com', 'hash_contrasena_7', '8999-6543', '2024-07-02', 3),
('Maria', 'Rojas', 'maria.rojas@example.com', 'hash_contrasena_8', '7777-1122', '2025-01-09', 2),
('Jose', 'Vega', 'jose.vega@example.com', 'hash_contrasena_9', '6666-3344', '2025-02-11', 2),
('Lucia', 'Solis', 'lucia.solis@example.com', 'hash_contrasena_10', '5555-5566', '2025-03-15', 2);

-- INSERTS PARA LA TABLA: productos
INSERT INTO productos (nombre, descripcion, precio, stock, imagen_url, categoria_id) VALUES
('Laptop Pro X15', 'Laptop de alto rendimiento con 16GB RAM y 1TB SSD.', 1200.00, 50, 'https://example.com/images/laptop_x15.jpg', 1),
('Smartphone Nova 10', 'Teléfono inteligente con cámara de 108MP y pantalla OLED.', 850.50, 120, 'https://example.com/images/smartphone_nova10.jpg', 1),
('Camiseta de Algodón', 'Camiseta básica de algodón orgánico, varios colores.', 25.00, 300, 'https://example.com/images/camiseta.jpg', 2),
('Jeans Slim Fit', 'Pantalones de mezclilla de corte moderno y cómodo.', 60.00, 150, 'https://example.com/images/jeans.jpg', 2),
('Sofá Modular "Comfort"', 'Sofá de 3 piezas, adaptable a tu espacio.', 950.75, 20, 'https://example.com/images/sofa.jpg', 3),
('"Cien Años de Soledad"', 'Edición de bolsillo de la obra de Gabriel García Márquez.', 15.99, 500, 'https://example.com/images/cien_anios.jpg', 4),
('Balón de Fútbol Profesional', 'Balón oficial de la liga, tamaño 5.', 45.00, 80, 'https://example.com/images/balon.jpg', 5),
('Set de Lego "Ciudad"', 'Set de construcción con más de 800 piezas.', 99.99, 60, 'https://example.com/images/lego_ciudad.jpg', 6),
('Crema Hidratante Facial', 'Crema con ácido hialurónico para todo tipo de piel.', 35.50, 200, 'https://example.com/images/crema_facial.jpg', 7),
('Aceite Sintético para Motor', 'Garrafa de 5 litros de aceite 5W-30.', 55.00, 90, 'https://example.com/images/aceite_motor.jpg', 8);

-- INSERTS PARA LA TABLA: carrito
INSERT INTO carrito (id_usuario, fecha_creacion) VALUES
(1, '2025-07-17 10:00:00'),
(2, '2025-07-18 11:30:00'),
(5, '2025-07-18 14:00:00'),
(6, '2025-07-18 15:20:00');

-- INSERTS PARA LA TABLA: carrito_productos
INSERT INTO carrito_productos (id_carrito, id_producto, cantidad) VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(2, 7, 1),
(2, 6, 1),
(3, 4, 1),
(3, 9, 2),
(4, 5, 1),
(4, 10, 1);

-- INSERTS PARA LA TABLA: ventas
INSERT INTO ventas (id_usuario, fecha_venta, total, cupon_aplicado) VALUES
(2, '2025-06-15 09:30:00', 85.00, NULL),
(3, '2025-06-20 14:00:00', 108.00, 'BIENVENIDA10'),
(1, '2025-07-01 18:45:00', 99.99, NULL),
(4, '2025-07-05 11:10:00', 1200.00, NULL),
(6, '2025-07-10 12:00:00', 46.75, 'VERANO2025');

-- INSERTS PARA LA TABLA: detalle_venta
INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario) VALUES
(1, 4, 1, 60.00),
(1, 3, 1, 25.00),
(2, 2, 1, 120.00), -- Precio promocional ficticio
(3, 8, 1, 99.99),
(4, 1, 1, 1200.00),
(5, 7, 1, 45.00),
(5, 6, 1, 10.00); -- Precio promocional ficticio

-- INSERTS PARA LA TABLA: tickets_soporte
INSERT INTO tickets_soporte (id_usuario, asunto, mensaje, fecha_envio, estado) VALUES
(1, 'Problema con mi pedido #12345', 'Hola, no he recibido confirmación de mi pedido.', '2025-07-15', FALSE),
(3, 'Duda sobre un producto', 'Quisiera saber las dimensiones del sofá modular.', '2025-07-16', TRUE),
(5, 'No puedo aplicar mi cupón', 'El sistema no reconoce el cupón VERANO2025.', '2025-07-17', FALSE),
(2, 'Garantía del Smartphone Nova 10', '¿Cuál es el periodo de garantía para el teléfono?', '2025-07-18', FALSE);

-- INSERTS PARA LA TABLA: restablecer_contrasena
INSERT INTO restablecer_contrasena (id_usuario, token, fecha_creacion, usado) VALUES
(6, 'tokentemporal123xyz', '2025-07-18 10:00:00', FALSE),
(9, 'tokentemporal456abc', '2025-07-17 15:30:00', TRUE);

-- INSERTS PARA LA TABLA: favoritos
INSERT INTO favoritos (id_usuario, id_producto, fecha_agregado) VALUES
(1, 2, '2025-02-01'),
(1, 5, '2025-03-10'),
(2, 1, '2025-04-15'),
(3, 8, '2025-05-20'),
(4, 4, '2025-06-05'),
(5, 7, '2025-07-01'),
(6, 1, '2025-07-02'),
(6, 3, '2025-07-03'),
(8, 6, '2025-07-11'),
(9, 10, '2025-07-18');

-- INSERTS PARA LA TABLA: notificaciones
INSERT INTO notificaciones (id_usuario, tipo, mensaje, fecha_envio) VALUES
(1, 'Pedido Enviado', '¡Buenas noticias! Tu pedido #12346 ha sido enviado.', '2025-07-02 10:00:00'),
(2, 'Oferta Especial', '¡No te pierdas el 30% de descuento en Electrónica!', '2025-07-10 09:00:00'),
(4, 'Bienvenida', 'Gracias por registrarte, Sofia. Usa el código BIENVENIDA10.', '2024-04-05 10:00:00'),
(3, 'Ticket Resuelto', 'Tu ticket de soporte sobre las dimensiones del sofá ha sido cerrado.', '2025-07-17 11:00:00'),
(1, 'Carrito Abandonado', '¡No te olvides de tus productos! Completa tu compra ahora.', '2025-07-18 10:00:00'),
(5, 'Nuevo Producto', '¡Ha llegado el nuevo Smartphone SuperNova! Sé el primero en tenerlo.', '2025-06-01 12:00:00');