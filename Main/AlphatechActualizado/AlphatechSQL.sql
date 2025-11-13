-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: alphatech
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `__efmigrationshistory`
--

DROP TABLE IF EXISTS `__efmigrationshistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `__efmigrationshistory` (
  `MigrationId` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProductVersion` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__efmigrationshistory`
--

LOCK TABLES `__efmigrationshistory` WRITE;
/*!40000 ALTER TABLE `__efmigrationshistory` DISABLE KEYS */;
INSERT INTO `__efmigrationshistory` VALUES ('20250820073621_Inicial','9.0.8');
/*!40000 ALTER TABLE `__efmigrationshistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetroleclaims`
--

DROP TABLE IF EXISTS `aspnetroleclaims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aspnetroleclaims` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `RoleId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ClaimType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ClaimValue` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetRoleClaims_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `aspnetroles` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetroleclaims`
--

LOCK TABLES `aspnetroleclaims` WRITE;
/*!40000 ALTER TABLE `aspnetroleclaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetroleclaims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetroles`
--

DROP TABLE IF EXISTS `aspnetroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aspnetroles` (
  `Id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `NormalizedName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ConcurrencyStamp` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `RoleNameIndex` (`NormalizedName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetroles`
--

LOCK TABLES `aspnetroles` WRITE;
/*!40000 ALTER TABLE `aspnetroles` DISABLE KEYS */;
INSERT INTO `aspnetroles` VALUES ('3cbfa03c-99bc-4046-bb04-2d6aa7d6563a','User','USER',NULL),('687230f4-ddc4-4012-ac4c-c3332aab9374','Admin','ADMIN',NULL);
/*!40000 ALTER TABLE `aspnetroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetuserclaims`
--

DROP TABLE IF EXISTS `aspnetuserclaims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aspnetuserclaims` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UserId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ClaimType` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ClaimValue` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetUserClaims_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetuserclaims`
--

LOCK TABLES `aspnetuserclaims` WRITE;
/*!40000 ALTER TABLE `aspnetuserclaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetuserclaims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetuserlogins`
--

DROP TABLE IF EXISTS `aspnetuserlogins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aspnetuserlogins` (
  `LoginProvider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProviderKey` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ProviderDisplayName` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `UserId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`LoginProvider`,`ProviderKey`),
  KEY `IX_AspNetUserLogins_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetuserlogins`
--

LOCK TABLES `aspnetuserlogins` WRITE;
/*!40000 ALTER TABLE `aspnetuserlogins` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetuserlogins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetuserroles`
--

DROP TABLE IF EXISTS `aspnetuserroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aspnetuserroles` (
  `UserId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `RoleId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`),
  KEY `IX_AspNetUserRoles_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `aspnetroles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetuserroles`
--

LOCK TABLES `aspnetuserroles` WRITE;
/*!40000 ALTER TABLE `aspnetuserroles` DISABLE KEYS */;
INSERT INTO `aspnetuserroles` VALUES ('1a2849a9-2c62-46f3-9661-6ae400a322b3','3cbfa03c-99bc-4046-bb04-2d6aa7d6563a'),('e11c52af-3b13-47cd-8af6-a51b9fb82e83','687230f4-ddc4-4012-ac4c-c3332aab9374');
/*!40000 ALTER TABLE `aspnetuserroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetusers`
--

DROP TABLE IF EXISTS `aspnetusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aspnetusers` (
  `Id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `NombreCompleto` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `UserName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `NormalizedUserName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `Email` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `NormalizedEmail` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `EmailConfirmed` tinyint(1) NOT NULL,
  `PasswordHash` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `SecurityStamp` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `ConcurrencyStamp` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `PhoneNumber` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `PhoneNumberConfirmed` tinyint(1) NOT NULL,
  `TwoFactorEnabled` tinyint(1) NOT NULL,
  `LockoutEnd` datetime(6) DEFAULT NULL,
  `LockoutEnabled` tinyint(1) NOT NULL,
  `AccessFailedCount` int NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserNameIndex` (`NormalizedUserName`),
  KEY `EmailIndex` (`NormalizedEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetusers`
--

LOCK TABLES `aspnetusers` WRITE;
/*!40000 ALTER TABLE `aspnetusers` DISABLE KEYS */;
INSERT INTO `aspnetusers` VALUES ('1a2849a9-2c62-46f3-9661-6ae400a322b3','Darian','prueba@prueba.com','PRUEBA@PRUEBA.COM','prueba@prueba.com','PRUEBA@PRUEBA.COM',0,'AQAAAAIAAYagAAAAEDFLI2NR6wMcTbCbd/liYdNVkZP31juElR4F1W7dSfu31cFOekL5vNceQ9vDq9URgw==','RSAIBH24VQ4RKEA7Z6D6SBS6MDAV757J','f931bb07-5fe3-4709-82a1-75710920eff7',NULL,0,0,NULL,1,0),('3361b33a-2b1f-4865-9196-c69811de155a','Darian Kaled Gozalez Rojas','kaledgrojas@gmail.com','KALEDGROJAS@GMAIL.COM','kaledgrojas@gmail.com','KALEDGROJAS@GMAIL.COM',0,'AQAAAAIAAYagAAAAED0eomFA1Aeh4+nw3AwIv4Umvx2zb6XyFtdDshcvkKmnMMMM7BDwTqO9UmSiMcs3kw==','XAA76PZ7HJ3GJTQPR6TFQVNPNAZIS2CE','ab0e895a-7d53-4d0c-a7de-c6c0237584b6',NULL,0,0,NULL,1,0),('e11c52af-3b13-47cd-8af6-a51b9fb82e83','Usuario Administrador','admin@alphatech.com','ADMIN@ALPHATECH.COM','admin@alphatech.com','ADMIN@ALPHATECH.COM',1,'AQAAAAIAAYagAAAAEIQkfjzrjDSfCdR6fOqPOfyYQBTe+b0QnZeBFPFxS/cGg2UMOrLFDuxZt4vLmSLGfw==','57TORLFZK6AGMY6F6YQA3IRDUDEYTXWI','b3225507-3723-49a8-85c0-3a464641f25f',NULL,0,0,NULL,1,0);
/*!40000 ALTER TABLE `aspnetusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetusertokens`
--

DROP TABLE IF EXISTS `aspnetusertokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aspnetusertokens` (
  `UserId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `LoginProvider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`UserId`,`LoginProvider`,`Name`),
  CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetusertokens`
--

LOCK TABLES `aspnetusertokens` WRITE;
/*!40000 ALTER TABLE `aspnetusertokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetusertokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carrito`
--

DROP TABLE IF EXISTS `carrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrito` (
  `id_carrito` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_carrito`),
  KEY `usuario_idx` (`id_usuario`),
  CONSTRAINT `usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrito`
--

LOCK TABLES `carrito` WRITE;
/*!40000 ALTER TABLE `carrito` DISABLE KEYS */;
INSERT INTO `carrito` VALUES (3,26,'2025-07-18 10:30:00'),(4,26,'2025-07-17 15:00:00'),(5,27,'2025-07-18 18:00:00'),(6,27,'2025-07-18 18:00:00'),(7,28,'2025-07-16 09:00:00');
/*!40000 ALTER TABLE `carrito` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carrito_productos`
--

DROP TABLE IF EXISTS `carrito_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrito_productos` (
  `id_carrito_producto` int NOT NULL AUTO_INCREMENT,
  `id_carrito` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int DEFAULT NULL,
  PRIMARY KEY (`id_carrito_producto`),
  KEY `producto_idx` (`id_producto`),
  KEY `carrito_idx` (`id_carrito`),
  CONSTRAINT `carrito` FOREIGN KEY (`id_carrito`) REFERENCES `carrito` (`id_carrito`),
  CONSTRAINT `producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrito_productos`
--

LOCK TABLES `carrito_productos` WRITE;
/*!40000 ALTER TABLE `carrito_productos` DISABLE KEYS */;
INSERT INTO `carrito_productos` VALUES (5,3,12,1),(6,3,13,1),(8,4,16,1),(9,4,17,1),(12,6,18,1),(14,7,19,2);
/*!40000 ALTER TABLE `carrito_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (2,'string'),(3,'Teclados'),(4,'Tarjetas de Video (GPU)'),(5,'Procesadores (CPU)'),(6,'Placas Madre (Motherboards)'),(7,'Memoria RAM'),(8,'Almacenamiento (SSD/HDD)'),(9,'Fuentes de Poder (PSU)'),(10,'Gabinetes (Cases)'),(11,'Monitores'),(12,'Periféricos (Teclados, Ratones, Audífonos)'),(13,'Sillas Gamer'),(14,'Tarjetas de Video (GPU)'),(15,'Procesadores (CPU)'),(16,'Placas Madre (Motherboards)'),(17,'Memoria RAM'),(18,'Almacenamiento (SSD/HDD)'),(19,'Fuentes de Poder (PSU)'),(20,'Gabinetes (Cases)'),(21,'Monitores'),(22,'Periféricos (Teclados, Ratones, Audífonos)'),(23,'Sillas Gamer');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cupones`
--

DROP TABLE IF EXISTS `cupones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cupones` (
  `id_cupon` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(100) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `descuento` decimal(5,2) DEFAULT NULL,
  `fecha_expiracion` datetime DEFAULT NULL,
  `activo` tinyint DEFAULT NULL,
  PRIMARY KEY (`id_cupon`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cupones`
--

LOCK TABLES `cupones` WRITE;
/*!40000 ALTER TABLE `cupones` DISABLE KEYS */;
INSERT INTO `cupones` VALUES (1,'GAMERX10','10% de descuento en tu primera compra gamer',10.00,'2025-12-31 00:00:00',1),(2,'ALPHAFAN','15% de descuento para clientes recurrentes',15.00,'2025-10-31 00:00:00',1),(3,'NVIDIAPOWER','20% en todas las tarjetas NVIDIA serie 40',20.00,'2025-08-30 00:00:00',1),(4,'SETUP2025','Compra un monitor y un teclado y obtén $50 de descuento',50.00,'2025-09-15 00:00:00',1),(5,'ENVIOSETUP','Envío gratuito en compras mayores a $200',10.00,'2025-12-31 00:00:00',1),(6,'AMDRAZOR','Descuento especial en procesadores AMD Ryzen',25.00,'2025-07-30 00:00:00',1),(7,'FLASHJULIO','Oferta relámpago de 48 horas en periféricos',30.00,'2025-07-20 00:00:00',1),(8,'BACK2SCHOOL','Descuentos en laptops y equipos para estudiantes',15.00,'2024-08-31 00:00:00',0),(9,'CYBERALPHA','Cupón para el evento Cyber Monday',25.00,'2025-12-02 00:00:00',1),(10,'SOLOSSD','10% de descuento en unidades de estado sólido de 1TB o más',10.00,'2025-11-30 00:00:00',1),(11,'GAMERX10','10% de descuento en tu primera compra gamer',10.00,'2025-12-31 00:00:00',1),(12,'ALPHAFAN','15% de descuento para clientes recurrentes',15.00,'2025-10-31 00:00:00',1),(13,'NVIDIAPOWER','20% en todas las tarjetas NVIDIA serie 40',20.00,'2025-08-30 00:00:00',1),(14,'SETUP2025','Compra un monitor y un teclado y obtén $50 de descuento',50.00,'2025-09-15 00:00:00',1),(15,'ENVIOSETUP','Envío gratuito en compras mayores a $200',10.00,'2025-12-31 00:00:00',1),(16,'AMDRAZOR','Descuento especial en procesadores AMD Ryzen',25.00,'2025-07-30 00:00:00',1),(17,'FLASHJULIO','Oferta relámpago de 48 horas en periféricos',30.00,'2025-07-20 00:00:00',1),(18,'BACK2SCHOOL','Descuentos en laptops y equipos para estudiantes',15.00,'2024-08-31 00:00:00',0),(19,'CYBERALPHA','Cupón para el evento Cyber Monday',25.00,'2025-12-02 00:00:00',1),(20,'SOLOSSD','10% de descuento en unidades de estado sólido de 1TB o más',10.00,'2025-11-30 00:00:00',1);
/*!40000 ALTER TABLE `cupones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_venta`
--

DROP TABLE IF EXISTS `detalle_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_venta` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_venta` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `venta_idx` (`id_venta`),
  KEY `product_idx` (`id_producto`),
  CONSTRAINT `product` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `venta` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_venta`
--

LOCK TABLES `detalle_venta` WRITE;
/*!40000 ALTER TABLE `detalle_venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favoritos`
--

DROP TABLE IF EXISTS `favoritos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoritos` (
  `id_favorito` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `fecha_agregado` date DEFAULT NULL,
  `id_user` varchar(255) NOT NULL,
  PRIMARY KEY (`id_favorito`),
  KEY `productoFav_idx` (`id_producto`),
  KEY `fk_favoritos_usuario` (`id_user`),
  CONSTRAINT `fk_favoritos_usuario` FOREIGN KEY (`id_user`) REFERENCES `aspnetusers` (`Id`),
  CONSTRAINT `productoFav` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoritos`
--

LOCK TABLES `favoritos` WRITE;
/*!40000 ALTER TABLE `favoritos` DISABLE KEYS */;
/*!40000 ALTER TABLE `favoritos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificaciones`
--

DROP TABLE IF EXISTS `notificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificaciones` (
  `id_notificacion` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `mensaje` text,
  `fecha_envio` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_notificacion`),
  KEY `userNoti_idx` (`id_usuario`),
  CONSTRAINT `userNoti` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificaciones`
--

LOCK TABLES `notificaciones` WRITE;
/*!40000 ALTER TABLE `notificaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `notificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` text,
  `precio` decimal(10,2) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `imagen_url` varchar(255) DEFAULT NULL,
  `categoria_id` int DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  KEY `categoriafk_idx` (`categoria_id`),
  CONSTRAINT `categoriafk` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (12,'NVIDIA GeForce RTX 4080','Tarjeta de video con 16GB GDDR6X, ideal para gaming en 4K y Ray Tracing.',1199.99,20,'https://example.com/images/rtx4080.jpg',4),(13,'AMD Ryzen 9 7950X','Procesador de 16 núcleos y 32 hilos, hasta 5.7GHz. Potencia extrema para gaming y creación.',699.00,25,'https://example.com/images/ryzen9.jpg',5),(14,'ASUS ROG Crosshair X670E Hero','Placa madre ATX para procesadores AMD Ryzen 7000, con WiFi 6E y PCIe 5.0.',699.99,20,'https://example.com/images/asus_x670e.jpg',6),(15,'Corsair Vengeance DDR5 32GB','Kit de 2x16GB de memoria RAM DDR5 a 6000MHz, con RGB.',149.99,50,'https://example.com/images/corsair_ddr5.jpg',7),(16,'Samsung 990 Pro 2TB NVMe SSD','Unidad de estado sólido NVMe M.2 con velocidades de lectura de hasta 7450 MB/s.',169.99,80,'https://example.com/images/samsung990.jpg',8),(17,'Corsair RM1000x SHIFT','Fuente de poder de 1000W, 80+ Gold, completamente modular con conectores laterales.',209.99,30,'https://example.com/images/corsair_rm1000x.jpg',9),(18,'Lian Li O11 Dynamic EVO','Gabinete Mid-Tower con diseño de doble cámara y paneles de vidrio templado.',169.99,40,'https://example.com/images/lianli_o11.jpg',10),(19,'LG UltraGear 27GP850-B','Monitor de 27 pulgadas, 1440p (QHD), 165Hz, 1ms, compatible con G-Sync.',449.99,35,'https://example.com/images/lg_ultragear.jpg',11),(20,'Razer BlackWidow V4 Pro','Teclado mecánico gamer con switches verdes, RGB Chroma y macros dedicadas.',229.99,60,'https://example.com/images/razer_blackwidow.jpg',3),(21,'Secretlab TITAN Evo 2022','Silla gamer ergonómica con soporte lumbar ajustable y materiales premium.',549.00,25,'https://example.com/images/secretlab_titan.jpg',13);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restablecer_contrasena`
--

DROP TABLE IF EXISTS `restablecer_contrasena`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restablecer_contrasena` (
  `id_token` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `usado` tinyint DEFAULT NULL,
  PRIMARY KEY (`id_token`),
  KEY `usuarioTok_idx` (`id_usuario`),
  CONSTRAINT `usuarioTok` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restablecer_contrasena`
--

LOCK TABLES `restablecer_contrasena` WRITE;
/*!40000 ALTER TABLE `restablecer_contrasena` DISABLE KEYS */;
/*!40000 ALTER TABLE `restablecer_contrasena` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'USER'),(2,'ADMIN'),(4,'Administrador'),(5,'Cliente'),(6,'Editor de Contenido'),(7,'Soporte Técnico'),(8,'Administrador'),(9,'Cliente'),(10,'Editor de Contenido'),(11,'Soporte Técnico');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets_soporte`
--

DROP TABLE IF EXISTS `tickets_soporte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets_soporte` (
  `id_ticket` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `asunto` varchar(100) DEFAULT NULL,
  `mensaje` varchar(100) DEFAULT NULL,
  `fecha_envio` datetime DEFAULT NULL,
  `estado` tinyint DEFAULT NULL,
  PRIMARY KEY (`id_ticket`),
  KEY `usuarioCon_idx` (`id_usuario`),
  CONSTRAINT `usuarioCon` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets_soporte`
--

LOCK TABLES `tickets_soporte` WRITE;
/*!40000 ALTER TABLE `tickets_soporte` DISABLE KEYS */;
/*!40000 ALTER TABLE `tickets_soporte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `contrasena` varchar(255) DEFAULT NULL,
  `telefono` varchar(100) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `rol_id` int DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `rolfk_idx` (`rol_id`),
  CONSTRAINT `rolfk` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (3,'string','string','string','string','Selogro','2025-07-17 15:10:38',1),(5,'string','intento','string','string','string','2025-07-19 00:36:31',1),(26,'Juan','Perez','juan.perez@email.com','hash_contrasena_1','8811-2233','2024-01-10 00:00:00',5),(27,'Maria','Gonzalez','maria.gonzalez@email.com','hash_contrasena_2','8822-3344','2024-02-15 00:00:00',5),(28,'Carlos','Rodriguez','carlos.rodriguez@email.com','hash_contrasena_3','8833-4455','2024-03-20 00:00:00',5),(29,'Ana','Martinez','ana.martinez@email.com','hash_contrasena_4','8844-5566','2024-04-25 00:00:00',5),(30,'Pedro','Sanchez','pedro.sanchez@email.com','hash_contrasena_5','8855-6677','2024-05-30 00:00:00',5),(31,'Laura','Gomez','laura.gomez@email.com','hash_contrasena_6','8866-7788','2024-06-05 00:00:00',5),(32,'Sergio','Lopez','sergio.lopez@email.com','hash_contrasena_7','8877-8899','2024-07-01 00:00:00',7),(33,'Lucia','Diaz','lucia.diaz@email.com','hash_contrasena_8','8888-9900','2025-01-12 00:00:00',6),(34,'Javier','Fernandez','javier.fernandez@email.com','hash_contrasena_9','8899-0011','2025-02-18 00:00:00',7),(35,'Sofia','Moreno','sofia.moreno@email.com','hash_contrasena_10','8800-1122','2025-03-22 00:00:00',5),(37,'kaled','gonzalez','prueba@prueba.com','$2a$12$wq4A7MWlZWXl3SdUxSZrNefsm6M2rGtEU3MaosJMhmsGsk9Et7oYi','prueba','2025-08-19 01:55:15',5);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id_venta` int NOT NULL,
  `id_usuario` int DEFAULT NULL,
  `fecha_venta` datetime DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(10,2) DEFAULT NULL,
  `cupon_aplicado` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `usuario_idx` (`id_usuario`),
  CONSTRAINT `user` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (1,3,'2025-08-19 03:13:00',31132.00,'2');
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-20 19:20:27
