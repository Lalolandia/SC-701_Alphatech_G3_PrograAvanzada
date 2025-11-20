
--------------------BD--------------------------------

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'alphatech')
BEGIN
    CREATE DATABASE alphatech;
END;
GO

USE alphatech;
GO

-----------------------TABLAS--------------------------

-- Roles
IF OBJECT_ID('roles', 'U') IS NOT NULL DROP TABLE roles;
GO

CREATE TABLE roles (
    id_rol INT IDENTITY(1,1) PRIMARY KEY,
    nombre_rol VARCHAR(100) NOT NULL
);
GO

-- Categorias
IF OBJECT_ID('categorias', 'U') IS NOT NULL DROP TABLE categorias;
GO

CREATE TABLE categorias (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);
GO

-- Cupones
IF OBJECT_ID('cupones', 'U') IS NOT NULL DROP TABLE cupones;
GO

CREATE TABLE cupones (
    id_cupon INT IDENTITY(1,1) PRIMARY KEY,
    codigo VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(255),
    descuento DECIMAL(5, 2) NOT NULL,
    fecha_inicio DATE NULL,
    fecha_expiracion DATE,
    tipo_descuento VARCHAR(20) NOT NULL CONSTRAINT chk_tipo_descuento
        CHECK (tipo_descuento IN ('PORCENTAJE', 'MONTO')),
    activo BIT DEFAULT 1
);
GO

-- Usuarios
IF OBJECT_ID('usuarios', 'U') IS NOT NULL DROP TABLE usuarios;
GO

CREATE TABLE usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    telefono VARCHAR(100),
    fecha_registro DATE NOT NULL,
    foto_url VARCHAR(255) NULL,
    rol_id INT,
    CONSTRAINT fk_usuarios_roles FOREIGN KEY (rol_id) REFERENCES roles(id_rol)
);
GO

-- Producto
IF OBJECT_ID('productos', 'U') IS NOT NULL DROP TABLE productos;
GO

CREATE TABLE productos (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    imagen_url VARCHAR(255),
    categoria_id INT,
    activo BIT DEFAULT 1,
    CONSTRAINT fk_productos_categorias FOREIGN KEY (categoria_id) REFERENCES categorias(id_categoria)
);
GO

-- Carrito
IF OBJECT_ID('carrito', 'U') IS NOT NULL DROP TABLE carrito;
GO

CREATE TABLE carrito (
    id_carrito INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_creacion DATETIME NOT NULL,
    CONSTRAINT fk_carrito_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
GO

-- Ventas
IF OBJECT_ID('ventas', 'U') IS NOT NULL DROP TABLE ventas;
GO

CREATE TABLE ventas (
    id_venta INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_venta DATETIME NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    cupon_aplicado VARCHAR(50) NULL,
    id_cupon INT NULL,
    CONSTRAINT fk_ventas_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_ventas_cupones FOREIGN KEY (id_cupon) REFERENCES cupones(id_cupon)
);
GO

-- Detalles de las ventas
IF OBJECT_ID('detalle_venta', 'U') IS NOT NULL DROP TABLE detalle_venta;
GO

CREATE TABLE detalle_venta (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_detalle_venta_ventas FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    CONSTRAINT fk_detalle_venta_productos FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
GO

-- Tickets de soporte
IF OBJECT_ID('tickets_soporte', 'U') IS NOT NULL DROP TABLE tickets_soporte;
GO

CREATE TABLE tickets_soporte (
    id_ticket INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    asunto VARCHAR(255) NOT NULL,
    mensaje TEXT NOT NULL,
    fecha_envio DATE NOT NULL,
    estado VARCHAR(20) NOT NULL CONSTRAINT chk_estado_ticket
        CHECK (estado IN ('ABIERTO', 'EN_PROCESO', 'CERRADO')),
    CONSTRAINT fk_tickets_soporte_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
GO

-- Restablecer Contraseña
IF OBJECT_ID('restablecer_contrasena', 'U') IS NOT NULL DROP TABLE restablecer_contrasena;
GO

CREATE TABLE restablecer_contrasena (
    id_token INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    token VARCHAR(255) NOT NULL,
    fecha_creacion DATETIME NOT NULL,
    usado BIT DEFAULT 0,
    CONSTRAINT fk_rest_contra_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
GO

-- Favoritos
IF OBJECT_ID('favoritos', 'U') IS NOT NULL DROP TABLE favoritos;
GO

CREATE TABLE favoritos (
    id_favorito INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_producto INT NOT NULL,
    fecha_agregado DATE NOT NULL,
    CONSTRAINT fk_favoritos_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_favoritos_productos FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    CONSTRAINT uk_usuario_producto_favorito UNIQUE (id_usuario, id_producto)
);
GO

-- Notificaciones
IF OBJECT_ID('notificaciones', 'U') IS NOT NULL DROP TABLE notificaciones;
GO

CREATE TABLE notificaciones (
    id_notificacion INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    mensaje TEXT NOT NULL,
    fecha_envio DATETIME NOT NULL,
    CONSTRAINT fk_notificaciones_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
GO

-- Carrito de productos
IF OBJECT_ID('carrito_productos', 'U') IS NOT NULL DROP TABLE carrito_productos;
GO

CREATE TABLE carrito_productos (
    id_carrito_producto INT IDENTITY(1,1) PRIMARY KEY,
    id_carrito INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT fk_carrito_prod_carrito FOREIGN KEY (id_carrito) REFERENCES carrito(id_carrito),
    CONSTRAINT fk_carrito_prod_productos FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    CONSTRAINT uk_carrito_producto UNIQUE (id_carrito, id_producto)
);
GO

-- Preferencias de notificaciones
IF OBJECT_ID('preferencias_notificaciones', 'U') IS NOT NULL DROP TABLE preferencias_notificaciones;
GO

CREATE TABLE preferencias_notificaciones (
    id_preferencia INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    activo BIT DEFAULT 1,
    CONSTRAINT fk_pref_notif_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    CONSTRAINT uk_usuario_tipo_notif UNIQUE (id_usuario, tipo)
);
GO

----------------INSERT------------------------

-- Roles
INSERT INTO roles (nombre_rol) VALUES
('Administrador'),
('Cliente'),
('Editor'),
('Soporte');
GO

-- Categorias
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
GO

-- Cupones
INSERT INTO cupones (codigo, descripcion, descuento, fecha_inicio, fecha_expiracion, tipo_descuento, activo) VALUES
('VERANO2025',   '15% de descuento en toda la tienda', 15.00, '2025-06-01', '2025-09-30', 'PORCENTAJE', 1),
('BIENVENIDA10', '10% para nuevos usuarios',           10.00, '2025-01-01', '2025-12-31', 'PORCENTAJE', 1),
('INVIERNO2024', 'Descuento de temporada de invierno', 20.00, '2024-09-01', '2024-12-21', 'PORCENTAJE', 0),
('FLASH24H',     'Oferta válida solo por 24 horas',    25.00, '2025-07-18', '2025-07-19', 'PORCENTAJE', 1),
('ENVIOFREE',    'Envío gratuito en compras mayores a $50', 5.00, '2025-05-01', '2025-08-31', 'MONTO', 1);
GO

--Usuarios
INSERT INTO usuarios (nombre, apellido, email, contrasena, telefono, fecha_registro, foto_url, rol_id) VALUES
('Carlos', 'Rivera',   'carlos.rivera@example.com',   'hash_contrasena_1', '8888-1234', '2024-01-15', NULL, 2),
('Ana', 'Gomez',       'ana.gomez@example.com',       'hash_contrasena_2', '8777-5678', '2024-02-20', NULL, 2),
('Luis', 'Martinez',   'luis.martinez@example.com',   'hash_contrasena_3', '8666-9012', '2024-03-10', NULL, 2),
('Sofia', 'Hernandez', 'sofia.hernandez@example.com', 'hash_contrasena_4', '8555-3456', '2024-04-05', NULL, 1),
('David', 'Chaves',    'david.chaves@example.com',    'hash_contrasena_5', '8444-7890', '2024-05-21', NULL, 2),
('Laura', 'Jimenez',   'laura.jimenez@example.com',   'hash_contrasena_6', '8333-2109', '2024-06-18', NULL, 2),
('Pedro', 'Morales',   'pedro.morales@example.com',   'hash_contrasena_7', '8999-6543', '2024-07-02', NULL, 3),
('Maria', 'Rojas',     'maria.rojas@example.com',     'hash_contrasena_8', '7777-1122', '2025-01-09', NULL, 2),
('Jose', 'Vega',       'jose.vega@example.com',       'hash_contrasena_9', '6666-3344', '2025-02-11', NULL, 2),
('Lucia', 'Solis',     'lucia.solis@example.com',     'hash_contrasena_10','5555-5566', '2025-03-15', NULL, 2);
GO

--Prodcutos
INSERT INTO productos (nombre, descripcion, precio, stock, imagen_url, categoria_id, activo) VALUES
('Laptop Pro X15',           'Laptop de alto rendimiento con 16GB RAM y 1TB SSD.',                    1200.00,  50, 'https://example.com/images/laptop_x15.jpg',      1, 1),
('Smartphone Nova 10',       'Teléfono inteligente con cámara de 108MP y pantalla OLED.',             850.50,  120, 'https://example.com/images/smartphone_nova10.jpg', 1, 1),
('Camiseta de Algodón',      'Camiseta básica de algodón orgánico, varios colores.',                  25.00,  300, 'https://example.com/images/camiseta.jpg',        2, 1),
('Jeans Slim Fit',           'Pantalones de mezclilla de corte moderno y cómodo.',                    60.00,  150, 'https://example.com/images/jeans.jpg',           2, 1),
('Sofá Modular "Comfort"',   'Sofá de 3 piezas, adaptable a tu espacio.',                             950.75,  20, 'https://example.com/images/sofa.jpg',            3, 1),
('"Cien Años de Soledad"',   'Edición de bolsillo de la obra de Gabriel García Márquez.',             15.99,  500, 'https://example.com/images/cien_anios.jpg',      4, 1),
('Balón de Fútbol Profesional','Balón oficial de la liga, tamaño 5.',                                45.00,   80, 'https://example.com/images/balon.jpg',           5, 1),
('Set de Lego "Ciudad"',     'Set de construcción con más de 800 piezas.',                            99.99,   60, 'https://example.com/images/lego_ciudad.jpg',     6, 1),
('Crema Hidratante Facial',  'Crema con ácido hialurónico para todo tipo de piel.',                   35.50,  200, 'https://example.com/images/crema_facial.jpg',    7, 1),
('Aceite Sintético para Motor','Garrafa de 5 litros de aceite 5W-30.',                                55.00,   90, 'https://example.com/images/aceite_motor.jpg',    8, 1);
GO

-- Carrito
INSERT INTO carrito (id_usuario, fecha_creacion) VALUES
(1, '2025-07-17 10:00:00'),
(2, '2025-07-18 11:30:00'),
(5, '2025-07-18 14:00:00'),
(6, '2025-07-18 15:20:00');
GO

-- Carrito productos
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
GO

-- Ventas
-- Cupones: 1 = VERANO2025 2 = BIENVENIDA10 3 = INVIERNO2024 4 = FLASH24H 5 = ENVIOFREE
INSERT INTO ventas (id_usuario, fecha_venta, total, cupon_aplicado, id_cupon) VALUES
(2, '2025-06-15 09:30:00',  85.00,  NULL,          NULL),
(3, '2025-06-20 14:00:00', 108.00,  'BIENVENIDA10', 2),
(1, '2025-07-01 18:45:00',  99.99,  NULL,          NULL),
(4, '2025-07-05 11:10:00', 1200.00, NULL,          NULL),
(6, '2025-07-10 12:00:00',  46.75,  'VERANO2025',   1);
GO

--Detalle venta
INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario) VALUES
(1, 4, 1,  60.00),
(1, 3, 1,  25.00),
(2, 2, 1, 120.00), -- Precio promocional ficticio
(3, 8, 1,  99.99),
(4, 1, 1, 1200.00),
(5, 7, 1,  45.00),
(5, 6, 1,  10.00); -- Precio promocional ficticio
GO

--Ticket soporte
INSERT INTO tickets_soporte (id_usuario, asunto, mensaje, fecha_envio, estado) VALUES
(1, 'Problema con mi pedido #12345', 'Hola, no he recibido confirmación de mi pedido.', '2025-07-15', 'ABIERTO'),
(3, 'Duda sobre un producto', 'Quisiera saber las dimensiones del sofá modular.', '2025-07-16', 'CERRADO'),
(5, 'No puedo aplicar mi cupón', 'El sistema no reconoce el cupón VERANO2025.', '2025-07-17', 'EN_PROCESO'),
(2, 'Garantía del Smartphone Nova 10', '¿Cuál es el periodo de garantía para el teléfono?', '2025-07-18', 'ABIERTO');
GO

--Restablecer contrañsea
INSERT INTO restablecer_contrasena (id_usuario, token, fecha_creacion, usado) VALUES
(6, 'tokentemporal123xyz', '2025-07-18 10:00:00', 0),
(9, 'tokentemporal456abc', '2025-07-17 15:30:00', 1);
GO

--Favoritos
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
GO

--Notificaciones
INSERT INTO notificaciones (id_usuario, tipo, mensaje, fecha_envio) VALUES
(1, 'Pedido Enviado', '¡Buenas noticias! Tu pedido #12346 ha sido enviado.', '2025-07-02 10:00:00'),
(2, 'Oferta Especial', '¡No te pierdas el 30% de descuento en Electrónica!', '2025-07-10 09:00:00'),
(4, 'Bienvenida', 'Gracias por registrarte, Sofia. Usa el código BIENVENIDA10.', '2024-04-05 10:00:00'),
(3, 'Ticket Resuelto', 'Tu ticket de soporte sobre las dimensiones del sofá ha sido cerrado.', '2025-07-17 11:00:00'),
(1, 'Carrito Abandonado', '¡No te olvides de tus productos! Completa tu compra ahora.', '2025-07-18 10:00:00'),
(5, 'Nuevo Producto', '¡Ha llegado el nuevo Smartphone SuperNova! Sé el primero en tenerlo.', '2025-06-01 12:00:00');
GO