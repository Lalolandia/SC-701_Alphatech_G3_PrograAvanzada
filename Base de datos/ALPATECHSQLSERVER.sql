CREATE DATABASE Alphatech;
GO
USE Alphatech;
GO

-- Tabla: roles
CREATE TABLE roles (
    id_rol INT IDENTITY(1,1) PRIMARY KEY,
    nombre_rol NVARCHAR(100) NOT NULL
);

-- Tabla: categorias
CREATE TABLE categorias (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre_categoria NVARCHAR(100) NOT NULL
);

-- Tabla: cupones
CREATE TABLE cupones (
    id_cupon INT IDENTITY(1,1) PRIMARY KEY,
    codigo NVARCHAR(100) NOT NULL UNIQUE,
    descripcion NVARCHAR(255),
    descuento DECIMAL(5,2) NOT NULL,
    fecha_expiracion DATE,
    activo BIT DEFAULT 1
);

-- Tabla: usuarios
CREATE TABLE usuarios (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    apellido NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    contrasena NVARCHAR(255) NOT NULL,
    telefono NVARCHAR(100),
    fecha_registro DATE NOT NULL,
    rol_id INT,
    FOREIGN KEY (rol_id) REFERENCES roles(id_rol)
);

-- Tabla: productos
CREATE TABLE productos (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100) NOT NULL,
    descripcion NVARCHAR(MAX),
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    imagen_url NVARCHAR(255),
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id_categoria)
);

-- Tabla: carrito
CREATE TABLE carrito (
    id_carrito INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla: carrito_productos
CREATE TABLE carrito_productos (
    id_carrito_producto INT IDENTITY(1,1) PRIMARY KEY,
    id_carrito INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_carrito) REFERENCES carrito(id_carrito),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Tabla: ventas
CREATE TABLE ventas (
    id_venta INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_venta DATETIME NOT NULL DEFAULT GETDATE(),
    total DECIMAL(10,2) NOT NULL,
    cupon_aplicado NVARCHAR(50) NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla: detalle_venta
CREATE TABLE detalle_venta (
    id_detalle INT IDENTITY(1,1) PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Tabla: tickets_soporte
CREATE TABLE tickets_soporte (
    id_ticket INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    asunto NVARCHAR(255) NOT NULL,
    mensaje NVARCHAR(MAX) NOT NULL,
    fecha_envio DATE NOT NULL,
    estado BIT DEFAULT 0, -- 0: Abierto, 1: Cerrado
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla: restablecer_contrasena
CREATE TABLE restablecer_contrasena (
    id_token INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    token NVARCHAR(255) NOT NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    usado BIT DEFAULT 0,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla: favoritos
CREATE TABLE favoritos (
    id_favorito INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_producto INT NOT NULL,
    fecha_agregado DATE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    CONSTRAINT usuario_producto_favorito UNIQUE (id_usuario, id_producto)
);

-- Tabla: notificaciones
CREATE TABLE notificaciones (
    id_notificacion INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    tipo NVARCHAR(50) NOT NULL,
    mensaje NVARCHAR(MAX) NOT NULL,
    fecha_envio DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla: __efmigrationshistory
CREATE TABLE __efmigrationshistory (
    MigrationId NVARCHAR(150) NOT NULL PRIMARY KEY,
    ProductVersion NVARCHAR(32) NOT NULL
);

-- Tabla: aspnetroles
CREATE TABLE aspnetroles (
    Id NVARCHAR(128) NOT NULL PRIMARY KEY, -- reducido de 255 a 128
    Name NVARCHAR(256),
    NormalizedName NVARCHAR(256),
    ConcurrencyStamp NVARCHAR(MAX),
    CONSTRAINT RoleNameIndex UNIQUE (NormalizedName)
);

-- Tabla: aspnetroleclaims
CREATE TABLE aspnetroleclaims (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    RoleId NVARCHAR(128) NOT NULL,
    ClaimType NVARCHAR(MAX),
    ClaimValue NVARCHAR(MAX),
    FOREIGN KEY (RoleId) REFERENCES aspnetroles(Id) ON DELETE CASCADE
);

-- Tabla: aspnetusers
CREATE TABLE aspnetusers (
    Id NVARCHAR(128) NOT NULL PRIMARY KEY, -- reducido de 255 a 128
    NombreCompleto NVARCHAR(MAX) NOT NULL,
    UserName NVARCHAR(256),
    NormalizedUserName NVARCHAR(256),
    Email NVARCHAR(256),
    NormalizedEmail NVARCHAR(256),
    EmailConfirmed BIT NOT NULL,
    PasswordHash NVARCHAR(MAX),
    SecurityStamp NVARCHAR(MAX),
    ConcurrencyStamp NVARCHAR(MAX),
    PhoneNumber NVARCHAR(MAX),
    PhoneNumberConfirmed BIT NOT NULL,
    TwoFactorEnabled BIT NOT NULL,
    LockoutEnd DATETIME,
    LockoutEnabled BIT NOT NULL,
    AccessFailedCount INT NOT NULL,
    CONSTRAINT UserNameIndex UNIQUE (NormalizedUserName),
    CONSTRAINT EmailIndex UNIQUE (NormalizedEmail)
);

-- Tabla: aspnetuserclaims
CREATE TABLE aspnetuserclaims (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId NVARCHAR(128) NOT NULL,
    ClaimType NVARCHAR(MAX),
    ClaimValue NVARCHAR(MAX),
    FOREIGN KEY (UserId) REFERENCES aspnetusers(Id) ON DELETE CASCADE
);

-- Tabla: aspnetuserlogins
CREATE TABLE aspnetuserlogins (
    LoginProvider NVARCHAR(128) NOT NULL,
    ProviderKey NVARCHAR(128) NOT NULL,
    ProviderDisplayName NVARCHAR(MAX),
    UserId NVARCHAR(128) NOT NULL,
    PRIMARY KEY (LoginProvider, ProviderKey),
    FOREIGN KEY (UserId) REFERENCES aspnetusers(Id) ON DELETE CASCADE
);

-- Tabla: aspnetuserroles
CREATE TABLE aspnetuserroles (
    UserId NVARCHAR(128) NOT NULL,
    RoleId NVARCHAR(128) NOT NULL,
    PRIMARY KEY (UserId, RoleId),
    FOREIGN KEY (RoleId) REFERENCES aspnetroles(Id) ON DELETE CASCADE,
    FOREIGN KEY (UserId) REFERENCES aspnetusers(Id) ON DELETE CASCADE
);

-- Tabla: aspnetusertokens
CREATE TABLE aspnetusertokens (
    UserId NVARCHAR(128) NOT NULL,
    LoginProvider NVARCHAR(128) NOT NULL,
    Name NVARCHAR(128) NOT NULL,
    Value NVARCHAR(MAX),
    PRIMARY KEY (UserId, LoginProvider, Name),
    FOREIGN KEY (UserId) REFERENCES aspnetusers(Id) ON DELETE CASCADE
);

-- __efmigrationshistory
INSERT INTO __efmigrationshistory (MigrationId, ProductVersion)
VALUES ('20250820073621_Inicial', '9.0.8');

-- aspnetroles
INSERT INTO aspnetroles (Id, Name, NormalizedName, ConcurrencyStamp)
VALUES 
('3cbfa03c-99bc-4046-bb04-2d6aa7d6563a','User','USER',NULL),
('687230f4-ddc4-4012-ac4c-c3332aab9374','Admin','ADMIN',NULL);

-- aspnetusers
INSERT INTO aspnetusers (Id, NombreCompleto, UserName, NormalizedUserName, Email, NormalizedEmail, EmailConfirmed, PasswordHash, SecurityStamp, ConcurrencyStamp, PhoneNumber, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEnd, LockoutEnabled, AccessFailedCount)
VALUES
('1a2849a9-2c62-46f3-9661-6ae400a322b3','Darian','prueba@prueba.com','PRUEBA@PRUEBA.COM','prueba@prueba.com','PRUEBA@PRUEBA.COM',0,'AQAAAAIAAYagAAAAEDFLI2NR6wMcTbCbd/liYdNVkZP31juElR4F1W7dSfu31cFOekL5vNceQ9vDq9URgw==','RSAIBH24VQ4RKEA7Z6D6SBS6MDAV757J','f931bb07-5fe3-4709-82a1-75710920eff7',NULL,0,0,NULL,1,0),
('3361b33a-2b1f-4865-9196-c69811de155a','Darian Kaled Gozalez Rojas','kaledgrojas@gmail.com','KALEDGROJAS@GMAIL.COM','kaledgrojas@gmail.com','KALEDGROJAS@GMAIL.COM',0,'AQAAAAIAAYagAAAAED0eomFA1Aeh4+nw3AwIv4Umvx2zb6XyFtdDshcvkKmnMMMM7BDwTqO9UmSiMcs3kw==','XAA76PZ7HJ3GJTQPR6TFQVNPNAZIS2CE','ab0e895a-7d53-4d0c-a7de-c6c0237584b6',NULL,0,0,NULL,1,0),
('e11c52af-3b13-47cd-8af6-a51b9fb82e83','Usuario Administrador','admin@alphatech.com','ADMIN@ALPHATECH.COM','admin@alphatech.com','ADMIN@ALPHATECH.COM',1,'AQAAAAIAAYagAAAAEIQkfjzrjDSfCdR6fOqPOfyYQBTe+b0QnZeBFPFxS/cGg2UMOrLFDuxZt4vLmSLGfw==','57TORLFZK6AGMY6F6YQA3IRDUDEYTXWI','b3225507-3723-49a8-85c0-3a464641f25f',NULL,0,0,NULL,1,0);

-- aspnetuserroles
INSERT INTO aspnetuserroles (UserId, RoleId)
VALUES 
('1a2849a9-2c62-46f3-9661-6ae400a322b3','3cbfa03c-99bc-4046-bb04-2d6aa7d6563a'),
('e11c52af-3b13-47cd-8af6-a51b9fb82e83','687230f4-ddc4-4012-ac4c-c3332aab9374');

-- Roles
INSERT INTO roles (nombre_rol) VALUES
('USER'), ('ADMIN'), ('Administrador'), ('Cliente'),
('Editor de Contenido'), ('Soporte Técnico');

-- Categorías
INSERT INTO categorias (nombre_categoria) VALUES
('Teclados'), ('Tarjetas de Video (GPU)'), ('Procesadores (CPU)'),
('Placas Madre (Motherboards)'), ('Memoria RAM'),
('Almacenamiento (SSD/HDD)'), ('Fuentes de Poder (PSU)'),
('Gabinetes (Cases)'), ('Monitores'),
('Periféricos (Teclados, Ratones, Audífonos)'), ('Sillas Gamer');

-- Cupones
INSERT INTO cupones (codigo, descripcion, descuento, fecha_expiracion, activo) VALUES
('GAMERX10','10% de descuento en tu primera compra gamer',10.00,'2025-12-31',1),
('ALPHAFAN','15% de descuento para clientes recurrentes',15.00,'2025-10-31',1),
('NVIDIAPOWER','20% en todas las tarjetas NVIDIA serie 40',20.00,'2025-08-30',1),
('SETUP2025','Compra un monitor y un teclado y obtén $50 de descuento',50.00,'2025-09-15',1),
('ENVIOSETUP','Envío gratuito en compras mayores a $200',10.00,'2025-12-31',1),
('CYBERALPHA','Cupón para el evento Cyber Monday',25.00,'2025-12-02',1),
('SOLOSSD','10% de descuento en unidades de estado sólido de 1TB o más',10.00,'2025-11-30',1);

-- Productos
INSERT INTO productos (nombre, descripcion, precio, stock, imagen_url, categoria_id) VALUES
('NVIDIA GeForce RTX 4080','Tarjeta de video con 16GB GDDR6X, ideal para gaming en 4K y Ray Tracing.',1199.99,20,'https://example.com/images/rtx4080.jpg',2),
('AMD Ryzen 9 7950X','Procesador de 16 núcleos y 32 hilos, hasta 5.7GHz.',699.00,25,'https://example.com/images/ryzen9.jpg',3),
('ASUS ROG Crosshair X670E Hero','Placa madre ATX para procesadores AMD Ryzen 7000.',699.99,20,'https://example.com/images/asus_x670e.jpg',4),
('Corsair Vengeance DDR5 32GB','Kit de 2x16GB DDR5 a 6000MHz.',149.99,50,'https://example.com/images/corsair_ddr5.jpg',5),
('Samsung 990 Pro 2TB NVMe SSD','Unidad NVMe M.2 con velocidades de lectura de hasta 7450 MB/s.',169.99,80,'https://example.com/images/samsung990.jpg',6),
('Corsair RM1000x SHIFT','Fuente de poder de 1000W, 80+ Gold.',209.99,30,'https://example.com/images/corsair_rm1000x.jpg',7),
('Lian Li O11 Dynamic EVO','Gabinete Mid-Tower con diseño de doble cámara.',169.99,40,'https://example.com/images/lianli_o11.jpg',8),
('LG UltraGear 27GP850-B','Monitor de 27 pulgadas, 1440p, 165Hz.',449.99,35,'https://example.com/images/lg_ultragear.jpg',9),
('Razer BlackWidow V4 Pro','Teclado mecánico gamer con switches verdes.',229.99,60,'https://example.com/images/razer_blackwidow.jpg',1),
('Secretlab TITAN Evo 2022','Silla gamer ergonómica con soporte lumbar.',549.00,25,'https://example.com/images/secretlab_titan.jpg',10);

-- Usuarios
INSERT INTO usuarios (nombre, apellido, email, contrasena, telefono, fecha_registro, rol_id) VALUES
('Juan','Perez','juan.perez@email.com','hash_contrasena_1','8811-2233','2024-01-10',5),
('Maria','Gonzalez','maria.gonzalez@email.com','hash_contrasena_2','8822-3344','2024-02-15',5),
('Carlos','Rodriguez','carlos.rodriguez@email.com','hash_contrasena_3','8833-4455','2024-03-20',5),
('Ana','Martinez','ana.martinez@email.com','hash_contrasena_4','8844-5566','2024-04-25',5),
('Pedro','Sanchez','pedro.sanchez@email.com','hash_contrasena_5','8855-6677','2024-05-30',5),
('Laura','Gomez','laura.gomez@email.com','hash_contrasena_6','8866-7788','2024-06-05',5),
('Sergio','Lopez','sergio.lopez@email.com','hash_contrasena_7','8877-8899','2024-07-01',7),
('Lucia','Diaz','lucia.diaz@email.com','hash_contrasena_8','8888-9900','2025-01-12',6),
('Javier','Fernandez','javier.fernandez@email.com','hash_contrasena_9','8899-0011','2025-02-18',7),
('Sofia','Moreno','sofia.moreno@email.com','hash_contrasena_10','8800-1122','2025-03-22',5);

-- Ventas
INSERT INTO ventas (id_usuario, fecha_venta, total, cupon_aplicado) VALUES
(1,'2025-08-19 03:13:00',31132.00,'ALPHAFAN');

-- Carrito
INSERT INTO carrito (id_usuario, fecha_creacion) VALUES
(1,'2025-07-18 10:30:00'),
(1,'2025-07-17 15:00:00'),
(2,'2025-07-18 18:00:00'),
(2,'2025-07-18 18:00:00'),
(3,'2025-07-16 09:00:00');

-- Carrito_Productos
INSERT INTO carrito_productos (id_carrito, id_producto, cantidad) VALUES
(1,1,1),(1,2,1),(2,5,1),(2,6,1),(4,7,1),(5,8,2);


