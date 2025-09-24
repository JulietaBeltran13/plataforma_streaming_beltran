CREATE DATABASE  IF NOT EXISTS `plataforma_streaming` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `plataforma_streaming`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: plataforma_streaming
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
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Acción'),(2,'Drama'),(3,'Comedia'),(4,'Documental'),(5,'Animación'),(6,'Ciencia ficción');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contenido`
--

DROP TABLE IF EXISTS `contenido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contenido` (
  `id_contenido` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) DEFAULT NULL,
  `descripcion` text,
  `tipo_contenido` varchar(20) DEFAULT NULL,
  `año` int DEFAULT NULL,
  `clasificacion_edad` varchar(10) DEFAULT NULL,
  `id_categoria` int DEFAULT NULL,
  PRIMARY KEY (`id_contenido`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `contenido_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contenido`
--

LOCK TABLES `contenido` WRITE;
/*!40000 ALTER TABLE `contenido` DISABLE KEYS */;
INSERT INTO `contenido` VALUES (1,'Café de Medianoche','Un barista descubre historias en la noche porteña.','pelicula',2022,'13+',NULL),(2,'Risas sin Fronteras','Comedia sobre un grupo de amigos y su gira por América Latina.','pelicula',2020,'ATP',NULL),(3,'Planeta Tierra','Documental sobre la biodiversidad del planeta.','pelicula',2019,'ATP',NULL),(4,'Galaxia 9','Tripulación explora los límites de la galaxia.','serie',2021,'16+',1),(5,'Mini Animados','Serie de cortos animados para niños.','serie',2018,'ATP',NULL),(6,'Ciencia en 10','Mini capítulos que explican ciencia en 10 minutos.','serie',2020,'ATP',NULL);
/*!40000 ALTER TABLE `contenido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `episodios`
--

DROP TABLE IF EXISTS `episodios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `episodios` (
  `id_episodio` int NOT NULL AUTO_INCREMENT,
  `id_temporada` int DEFAULT NULL,
  `titulos_episodio` varchar(150) DEFAULT NULL,
  `numero_episodio` int DEFAULT NULL,
  `duracion` int DEFAULT NULL,
  PRIMARY KEY (`id_episodio`),
  KEY `id_temporada` (`id_temporada`),
  CONSTRAINT `episodios_ibfk_1` FOREIGN KEY (`id_temporada`) REFERENCES `temporadas` (`id_temporada`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `episodios`
--

LOCK TABLES `episodios` WRITE;
/*!40000 ALTER TABLE `episodios` DISABLE KEYS */;
INSERT INTO `episodios` VALUES (1,NULL,'Despertar Estelar',1,48),(2,NULL,'Eco de Neón',2,52),(3,NULL,'Órbita Inestable',3,50),(4,NULL,'Nueva Frontera',1,55),(5,NULL,'Sombra de Pulsar',2,53),(6,NULL,'Regreso a Ícaro',3,57),(7,NULL,'La Gota Feliz',1,5),(8,NULL,'Brincos y Colores',2,6),(9,NULL,'El Globo',3,4),(10,NULL,'Sombras Bailarinas',4,5),(11,NULL,'Estrella de Papel',5,6),(12,NULL,'La Gravedad en 10',1,10),(13,NULL,'Átomos Rápidos',2,9),(14,NULL,'Energía a Prueba',3,11),(15,NULL,'El Sonido',4,10);
/*!40000 ALTER TABLE `episodios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_visualizacion`
--

DROP TABLE IF EXISTS `historial_visualizacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_visualizacion` (
  `id_historial` int NOT NULL AUTO_INCREMENT,
  `id_perfil` int DEFAULT NULL,
  `id_contenido` int DEFAULT NULL,
  `fecha_visualizacion` datetime DEFAULT NULL,
  `progreso_minutos` int DEFAULT NULL,
  PRIMARY KEY (`id_historial`),
  KEY `id_perfil` (`id_perfil`),
  KEY `id_contenido` (`id_contenido`),
  CONSTRAINT `historial_visualizacion_ibfk_1` FOREIGN KEY (`id_perfil`) REFERENCES `perfiles` (`id_perfil`),
  CONSTRAINT `historial_visualizacion_ibfk_2` FOREIGN KEY (`id_contenido`) REFERENCES `contenido` (`id_contenido`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_visualizacion`
--

LOCK TABLES `historial_visualizacion` WRITE;
/*!40000 ALTER TABLE `historial_visualizacion` DISABLE KEYS */;
INSERT INTO `historial_visualizacion` VALUES (1,NULL,NULL,'2025-09-07 17:12:50',120),(2,NULL,NULL,'2025-09-07 17:12:50',30),(3,NULL,NULL,'2025-09-07 17:12:50',90),(4,NULL,NULL,'2025-09-07 17:12:50',200),(5,NULL,NULL,'2025-09-07 17:12:50',15),(6,NULL,NULL,'2025-09-07 17:12:50',60),(7,NULL,NULL,'2025-09-07 17:12:50',10),(8,NULL,NULL,'2025-09-07 17:12:50',20);
/*!40000 ALTER TABLE `historial_visualizacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfiles`
--

DROP TABLE IF EXISTS `perfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfiles` (
  `id_perfil` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `nombre_perfil` varchar(50) DEFAULT NULL,
  `tipo_perfil` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_perfil`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `perfiles_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfiles`
--

LOCK TABLES `perfiles` WRITE;
/*!40000 ALTER TABLE `perfiles` DISABLE KEYS */;
INSERT INTO `perfiles` VALUES (1,1,'Juli','adultos'),(2,1,'Teen','niños'),(3,NULL,'Marcos','adultos'),(4,NULL,'Lu','adultos'),(5,NULL,'Peques','niños'),(6,NULL,'Pedro','adultos'),(7,NULL,'Ana','adultos'),(8,NULL,'Hermanita','niños'),(9,NULL,'Sofi','adultos');
/*!40000 ALTER TABLE `perfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planes`
--

DROP TABLE IF EXISTS `planes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planes` (
  `id_plan` int NOT NULL AUTO_INCREMENT,
  `nombre_plan` varchar(50) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `resolucion` varchar(20) DEFAULT NULL,
  `dispositivos_max` int DEFAULT NULL,
  PRIMARY KEY (`id_plan`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planes`
--

LOCK TABLES `planes` WRITE;
/*!40000 ALTER TABLE `planes` DISABLE KEYS */;
INSERT INTO `planes` VALUES (1,'Básico',2999.00,'HD',1),(2,'Estándar',4999.00,'FullHD',2),(3,'Premium',7999.00,'4K',4);
/*!40000 ALTER TABLE `planes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ratings` (
  `id_rating` int NOT NULL AUTO_INCREMENT,
  `id_perfil` int DEFAULT NULL,
  `id_contenido` int DEFAULT NULL,
  `puntaje` int DEFAULT NULL,
  `comentario` text,
  `fecha_rating` date DEFAULT NULL,
  PRIMARY KEY (`id_rating`),
  KEY `id_perfil` (`id_perfil`),
  KEY `id_contenido` (`id_contenido`),
  CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`id_perfil`) REFERENCES `perfiles` (`id_perfil`),
  CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`id_contenido`) REFERENCES `contenido` (`id_contenido`),
  CONSTRAINT `ratings_chk_1` CHECK ((`puntaje` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
INSERT INTO `ratings` VALUES (1,NULL,NULL,5,'Hermosa historia y fotografía.','2025-09-07'),(2,NULL,NULL,4,'Buena sci-fi, mejora en la T2.','2025-09-07'),(3,NULL,NULL,4,'Muy divertida.','2025-09-07'),(4,NULL,NULL,5,'Mi serie favorita este año.','2025-09-07'),(5,NULL,NULL,5,'A mis hijos les encanta.','2025-09-07'),(6,NULL,NULL,5,'Docu imperdible.','2025-09-07'),(7,NULL,NULL,4,'Muy informativo.','2025-09-07'),(8,NULL,NULL,4,'Breves y claros.','2025-09-07');
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_before_insert_ratings_validate` BEFORE INSERT ON `ratings` FOR EACH ROW BEGIN
    IF NEW.puntaje < 1 OR NEW.puntaje > 5 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El puntaje debe estar entre 1 y 5';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `suscripciones`
--

DROP TABLE IF EXISTS `suscripciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suscripciones` (
  `id_suscripcion` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `id_plan` int DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_suscripcion`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_plan` (`id_plan`),
  CONSTRAINT `suscripciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `suscripciones_ibfk_2` FOREIGN KEY (`id_plan`) REFERENCES `planes` (`id_plan`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suscripciones`
--

LOCK TABLES `suscripciones` WRITE;
/*!40000 ALTER TABLE `suscripciones` DISABLE KEYS */;
INSERT INTO `suscripciones` VALUES (1,1,NULL,'2025-07-08',NULL,'activa'),(2,NULL,NULL,'2025-08-07',NULL,'activa'),(3,NULL,1,'2025-05-09','2025-08-06','cancelada'),(4,NULL,1,'2025-08-22',NULL,'activa'),(5,NULL,NULL,'2025-08-27',NULL,'activa'),(6,NULL,NULL,'2025-08-07',NULL,'activa');
/*!40000 ALTER TABLE `suscripciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temporadas`
--

DROP TABLE IF EXISTS `temporadas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temporadas` (
  `id_temporada` int NOT NULL AUTO_INCREMENT,
  `id_contenido` int DEFAULT NULL,
  `numero_temporada` int DEFAULT NULL,
  `cantidad_episodios` int DEFAULT NULL,
  PRIMARY KEY (`id_temporada`),
  KEY `id_contenido` (`id_contenido`),
  CONSTRAINT `temporadas_ibfk_1` FOREIGN KEY (`id_contenido`) REFERENCES `contenido` (`id_contenido`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temporadas`
--

LOCK TABLES `temporadas` WRITE;
/*!40000 ALTER TABLE `temporadas` DISABLE KEYS */;
INSERT INTO `temporadas` VALUES (1,NULL,1,3),(2,NULL,2,3),(3,NULL,1,5),(4,NULL,1,4),(5,NULL,1,4);
/*!40000 ALTER TABLE `temporadas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_before_insert_temporadas_check_serie` BEFORE INSERT ON `temporadas` FOR EACH ROW BEGIN
    DECLARE v_tipo VARCHAR(20);

    -- Traer el tipo de contenido relacionado
    SELECT tipo_contenido
    INTO v_tipo
    FROM contenidos
    WHERE id_contenido = NEW.id_contenido;

    -- Validar que exista y que sea 'Serie'
    IF v_tipo IS NULL OR v_tipo <> 'Serie' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Solo se pueden crear temporadas para contenidos de tipo Serie';
    END IF;

    -- Validar que el número de temporada sea válido
    IF NEW.numero_temporada <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El número de temporada debe ser mayor a 0';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `contraseña` varchar(100) NOT NULL,
  `pais` varchar(50) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Julieta Beltrán','julieta@example.com','hash_seguro_juli','Argentina','2025-09-06'),(2,'Marcos Díaz','marcos@example.com','hash_seguro_marc','Argentina','2025-09-06'),(3,'Lucía Gómez','lucia@example.com','hash_seguro_luci','Chile','2025-09-06'),(4,'Pedro Álvarez','pedro@example.com','hash_seguro_ped','Uruguay','2025-09-06'),(5,'Ana Torres','ana@example.com','hash_seguro_ana','Argentina','2025-09-06'),(6,'Sofía Morales','sofia@example.com','hash_seguro_sof','México','2025-09-06');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_contenido_con_categoria`
--

DROP TABLE IF EXISTS `vw_contenido_con_categoria`;
/*!50001 DROP VIEW IF EXISTS `vw_contenido_con_categoria`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_contenido_con_categoria` AS SELECT 
 1 AS `id_contenido`,
 1 AS `titulo`,
 1 AS `tipo_contenido`,
 1 AS `año`,
 1 AS `clasificacion_edad`,
 1 AS `id_categoria`,
 1 AS `nombre_categoria`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_historial_detallado`
--

DROP TABLE IF EXISTS `vw_historial_detallado`;
/*!50001 DROP VIEW IF EXISTS `vw_historial_detallado`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_historial_detallado` AS SELECT 
 1 AS `id_historial`,
 1 AS `fecha_visualizacion`,
 1 AS `progreso_minutos`,
 1 AS `perfil`,
 1 AS `usuario`,
 1 AS `titulo_contenido`,
 1 AS `tipo_contenido`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_ratings_promedio`
--

DROP TABLE IF EXISTS `vw_ratings_promedio`;
/*!50001 DROP VIEW IF EXISTS `vw_ratings_promedio`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_ratings_promedio` AS SELECT 
 1 AS `id_contenido`,
 1 AS `titulo`,
 1 AS `promedio_puntaje`,
 1 AS `cantidad_ratings`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_series_episodios_resumen`
--

DROP TABLE IF EXISTS `vw_series_episodios_resumen`;
/*!50001 DROP VIEW IF EXISTS `vw_series_episodios_resumen`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_series_episodios_resumen` AS SELECT 
 1 AS `id_contenido`,
 1 AS `titulo`,
 1 AS `total_temporadas`,
 1 AS `total_episodios`,
 1 AS `total_minutos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_suscripciones_detalle`
--

DROP TABLE IF EXISTS `vw_suscripciones_detalle`;
/*!50001 DROP VIEW IF EXISTS `vw_suscripciones_detalle`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_suscripciones_detalle` AS SELECT 
 1 AS `id_suscripcion`,
 1 AS `usuario`,
 1 AS `email`,
 1 AS `nombre_plan`,
 1 AS `precio`,
 1 AS `resolucion`,
 1 AS `dispositivos_max`,
 1 AS `fecha_inicio`,
 1 AS `fecha_fin`,
 1 AS `estado`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'plataforma_streaming'
--

--
-- Dumping routines for database 'plataforma_streaming'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_perfiles_por_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_perfiles_por_usuario`(p_id_usuario INT) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE v_count INT;

    SELECT COUNT(p.id_perfil)
    INTO v_count
    FROM perfiles p
    WHERE p.id_usuario = p_id_usuario;

    RETURN v_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_promedio_rating_contenido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_promedio_rating_contenido`(p_id_contenido INT) RETURNS decimal(4,2)
    DETERMINISTIC
BEGIN
    DECLARE v_promedio DECIMAL(4,2);

    SELECT ROUND(AVG(r.puntaje),2)
    INTO v_promedio
    FROM ratings r
    WHERE r.id_contenido = p_id_contenido;

    RETURN IFNULL(v_promedio, 0.00);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_total_minutos_vistos_perfil` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_total_minutos_vistos_perfil`(p_id_perfil INT) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE v_total INT;

    SELECT SUM(hv.progreso_minutos)
    INTO v_total
    FROM historial_visualizacion hv
    WHERE hv.id_perfil = p_id_perfil;

    RETURN IFNULL(v_total, 0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cambiar_plan_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cambiar_plan_usuario`(
    IN p_id_usuario INT,
    IN p_id_plan INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    -- Cancelar suscripción activa actual
    UPDATE suscripciones
    SET estado = 'Cancelada'
    WHERE id_usuario = p_id_usuario
      AND estado = 'Activa';

    -- Crear nueva suscripción
    INSERT INTO suscripciones (id_usuario, id_plan, fecha_inicio, fecha_fin, estado)
    VALUES (p_id_usuario, p_id_plan, p_fecha_inicio, p_fecha_fin, 'Activa');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_contenido_con_categoria`
--

/*!50001 DROP VIEW IF EXISTS `vw_contenido_con_categoria`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_contenido_con_categoria` AS select `c`.`id_contenido` AS `id_contenido`,`c`.`titulo` AS `titulo`,`c`.`tipo_contenido` AS `tipo_contenido`,`c`.`año` AS `año`,`c`.`clasificacion_edad` AS `clasificacion_edad`,`c`.`id_categoria` AS `id_categoria`,`cat`.`nombre_categoria` AS `nombre_categoria` from (`contenido` `c` join `categorias` `cat` on((`c`.`id_categoria` = `cat`.`id_categoria`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_historial_detallado`
--

/*!50001 DROP VIEW IF EXISTS `vw_historial_detallado`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_historial_detallado` AS select `hv`.`id_historial` AS `id_historial`,`hv`.`fecha_visualizacion` AS `fecha_visualizacion`,`hv`.`progreso_minutos` AS `progreso_minutos`,`p`.`nombre_perfil` AS `perfil`,`u`.`nombre` AS `usuario`,`c`.`titulo` AS `titulo_contenido`,`c`.`tipo_contenido` AS `tipo_contenido` from (((`historial_visualizacion` `hv` join `perfiles` `p` on((`hv`.`id_perfil` = `p`.`id_perfil`))) join `usuarios` `u` on((`p`.`id_usuario` = `u`.`id_usuario`))) join `contenido` `c` on((`hv`.`id_contenido` = `c`.`id_contenido`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_ratings_promedio`
--

/*!50001 DROP VIEW IF EXISTS `vw_ratings_promedio`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_ratings_promedio` AS select `c`.`id_contenido` AS `id_contenido`,`c`.`titulo` AS `titulo`,round(avg(`r`.`puntaje`),2) AS `promedio_puntaje`,count(`r`.`id_rating`) AS `cantidad_ratings` from (`contenido` `c` left join `ratings` `r` on((`c`.`id_contenido` = `r`.`id_contenido`))) group by `c`.`id_contenido`,`c`.`titulo` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_series_episodios_resumen`
--

/*!50001 DROP VIEW IF EXISTS `vw_series_episodios_resumen`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_series_episodios_resumen` AS select `c`.`id_contenido` AS `id_contenido`,`c`.`titulo` AS `titulo`,count(distinct `t`.`id_temporada`) AS `total_temporadas`,count(`e`.`id_episodio`) AS `total_episodios`,ifnull(sum(`e`.`duracion`),0) AS `total_minutos` from ((`contenido` `c` left join `temporadas` `t` on((`c`.`id_contenido` = `t`.`id_contenido`))) left join `episodios` `e` on((`t`.`id_temporada` = `e`.`id_temporada`))) where (`c`.`tipo_contenido` = 'serie') group by `c`.`id_contenido`,`c`.`titulo` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_suscripciones_detalle`
--

/*!50001 DROP VIEW IF EXISTS `vw_suscripciones_detalle`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_suscripciones_detalle` AS select `s`.`id_suscripcion` AS `id_suscripcion`,`u`.`nombre` AS `usuario`,`u`.`email` AS `email`,`p`.`nombre_plan` AS `nombre_plan`,`p`.`precio` AS `precio`,`p`.`resolucion` AS `resolucion`,`p`.`dispositivos_max` AS `dispositivos_max`,`s`.`fecha_inicio` AS `fecha_inicio`,`s`.`fecha_fin` AS `fecha_fin`,`s`.`estado` AS `estado` from ((`suscripciones` `s` join `usuarios` `u` on((`s`.`id_usuario` = `u`.`id_usuario`))) join `planes` `p` on((`s`.`id_plan` = `p`.`id_plan`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-24 19:22:55
