-- MySQL dump 10.13  Distrib 8.0.23-14, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: banco_sangre
-- ------------------------------------------------------
-- Server version	8.0.17-8

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*!50717 SELECT COUNT(*) INTO @rocksdb_has_p_s_session_variables FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'performance_schema' AND TABLE_NAME = 'session_variables' */;
/*!50717 SET @rocksdb_get_is_supported = IF (@rocksdb_has_p_s_session_variables, 'SELECT COUNT(*) INTO @rocksdb_is_supported FROM performance_schema.session_variables WHERE VARIABLE_NAME=\'rocksdb_bulk_load\'', 'SELECT 0') */;
/*!50717 PREPARE s FROM @rocksdb_get_is_supported */;
/*!50717 EXECUTE s */;
/*!50717 DEALLOCATE PREPARE s */;
/*!50717 SET @rocksdb_enable_bulk_load = IF (@rocksdb_is_supported, 'SET SESSION rocksdb_bulk_load = 1', 'SET @rocksdb_dummy_bulk_load = 0') */;
/*!50717 PREPARE s FROM @rocksdb_enable_bulk_load */;
/*!50717 EXECUTE s */;
/*!50717 DEALLOCATE PREPARE s */;

--
-- Current Database: `banco_sangre`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `banco_sangre` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `banco_sangre`;

--
-- Table structure for table `control`
--

DROP TABLE IF EXISTS `control`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `control` (
  `id_donante` int(11) NOT NULL,
  `fecha_extrac` date NOT NULL,
  `cod_proceso` int(11) NOT NULL,
  `cod_herramienta` int(11) NOT NULL,
  `fecha_control` date NOT NULL,
  `hora_control` time NOT NULL,
  `resultado_control` varchar(255) NOT NULL,
  PRIMARY KEY (`id_donante`,`fecha_extrac`,`cod_proceso`,`cod_herramienta`),
  KEY `fk_control_proceso_idx` (`cod_proceso`),
  CONSTRAINT `fk_control_extraccion` FOREIGN KEY (`id_donante`, `fecha_extrac`) REFERENCES `extraccion` (`id_donante`, `fecha_extrac`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_control_herramienta` FOREIGN KEY (`cod_proceso`) REFERENCES `herramienta` (`cod_herramienta`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_control_proceso` FOREIGN KEY (`cod_proceso`) REFERENCES `proceso` (`cod_proceso`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `control`
--

LOCK TABLES `control` WRITE;
/*!40000 ALTER TABLE `control` DISABLE KEYS */;
/*!40000 ALTER TABLE `control` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donante`
--

DROP TABLE IF EXISTS `donante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donante` (
  `id_donante` int(11) NOT NULL AUTO_INCREMENT,
  `grupo_sanguineo` varchar(5) NOT NULL,
  `nom_ape` varchar(255) NOT NULL,
  `tipo_doc` varchar(45) NOT NULL,
  `nro_doc` bigint(20) NOT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `sexo` varchar(45) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `ciudad` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_donante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donante`
--

LOCK TABLES `donante` WRITE;
/*!40000 ALTER TABLE `donante` DISABLE KEYS */;
/*!40000 ALTER TABLE `donante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado` (
  `cod_estado` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) NOT NULL,
  PRIMARY KEY (`cod_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_donante`
--

DROP TABLE IF EXISTS `estado_donante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_donante` (
  `id_donante` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `cod_estado` int(11) NOT NULL,
  `observaciones` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_donante`,`fecha`,`hora`),
  KEY `fk_estado_donante_estado_idx` (`cod_estado`),
  CONSTRAINT `fk_estado_donante_donante` FOREIGN KEY (`id_donante`) REFERENCES `donante` (`id_donante`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_estado_donante_estado` FOREIGN KEY (`cod_estado`) REFERENCES `estado` (`cod_estado`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_donante`
--

LOCK TABLES `estado_donante` WRITE;
/*!40000 ALTER TABLE `estado_donante` DISABLE KEYS */;
/*!40000 ALTER TABLE `estado_donante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extraccion`
--

DROP TABLE IF EXISTS `extraccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `extraccion` (
  `id_donante` int(11) NOT NULL,
  `fecha_extrac` date NOT NULL,
  `matricula` int(11) NOT NULL,
  `hora_extrac` time NOT NULL,
  `motivo_descarte` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_donante`,`fecha_extrac`),
  KEY `fk_extraccion_profesional_idx` (`matricula`),
  CONSTRAINT `fk_extraccion_donante` FOREIGN KEY (`id_donante`) REFERENCES `donante` (`id_donante`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_extraccion_profesional` FOREIGN KEY (`matricula`) REFERENCES `profesional` (`matricula`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extraccion`
--

LOCK TABLES `extraccion` WRITE;
/*!40000 ALTER TABLE `extraccion` DISABLE KEYS */;
/*!40000 ALTER TABLE `extraccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `herramienta`
--

DROP TABLE IF EXISTS `herramienta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `herramienta` (
  `cod_herramienta` int(11) NOT NULL AUTO_INCREMENT,
  `denom_herramienta` varchar(255) NOT NULL,
  `descrip_herramienta` varchar(255) NOT NULL,
  `modelo_herramienta` varchar(255) NOT NULL,
  `fabri_herramienta` varchar(255) NOT NULL,
  PRIMARY KEY (`cod_herramienta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `herramienta`
--

LOCK TABLES `herramienta` WRITE;
/*!40000 ALTER TABLE `herramienta` DISABLE KEYS */;
/*!40000 ALTER TABLE `herramienta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institucion`
--

DROP TABLE IF EXISTS `institucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institucion` (
  `cod_insti` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_insti` varchar(255) NOT NULL,
  `nombre_resp` varchar(255) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  PRIMARY KEY (`cod_insti`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institucion`
--

LOCK TABLES `institucion` WRITE;
/*!40000 ALTER TABLE `institucion` DISABLE KEYS */;
/*!40000 ALTER TABLE `institucion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proceso`
--

DROP TABLE IF EXISTS `proceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proceso` (
  `cod_proceso` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) NOT NULL,
  PRIMARY KEY (`cod_proceso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proceso`
--

LOCK TABLES `proceso` WRITE;
/*!40000 ALTER TABLE `proceso` DISABLE KEYS */;
/*!40000 ALTER TABLE `proceso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `cod_tipo` int(11) NOT NULL,
  `nro_lote` int(11) NOT NULL,
  `cantidad_ml` double NOT NULL,
  `fecha_entrega` date DEFAULT NULL,
  `hora_entrega` time DEFAULT NULL,
  `cod_insti` int(11) DEFAULT NULL,
  `id_donante` int(11) NOT NULL,
  `fecha_extrac` date NOT NULL,
  PRIMARY KEY (`cod_tipo`,`nro_lote`),
  KEY `fk_producto_institucion_idx` (`cod_insti`),
  KEY `fk_producto_extraccion_idx` (`id_donante`,`fecha_extrac`),
  CONSTRAINT `fk_producto_extraccion` FOREIGN KEY (`id_donante`, `fecha_extrac`) REFERENCES `extraccion` (`id_donante`, `fecha_extrac`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_producto_institucion` FOREIGN KEY (`cod_insti`) REFERENCES `institucion` (`cod_insti`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_producto_tipo_producto` FOREIGN KEY (`cod_tipo`) REFERENCES `tipo_producto` (`cod_tipo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profesional`
--

DROP TABLE IF EXISTS `profesional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesional` (
  `matricula` int(11) NOT NULL,
  `nomb_ape` varchar(255) NOT NULL,
  `tipo_doc` varchar(45) NOT NULL,
  `nro_doc` bigint(20) NOT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesional`
--

LOCK TABLES `profesional` WRITE;
/*!40000 ALTER TABLE `profesional` DISABLE KEYS */;
/*!40000 ALTER TABLE `profesional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_producto`
--

DROP TABLE IF EXISTS `tipo_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_producto` (
  `cod_tipo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) NOT NULL,
  `temp_conserv` double NOT NULL,
  `tiempo_conserv` varchar(255) NOT NULL,
  PRIMARY KEY (`cod_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_producto`
--

LOCK TABLES `tipo_producto` WRITE;
/*!40000 ALTER TABLE `tipo_producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_producto` ENABLE KEYS */;
UNLOCK TABLES;
/*!50112 SET @disable_bulk_load = IF (@is_rocksdb_supported, 'SET SESSION rocksdb_bulk_load = @old_rocksdb_bulk_load', 'SET @dummy_rocksdb_bulk_load = 0') */;
/*!50112 PREPARE s FROM @disable_bulk_load */;
/*!50112 EXECUTE s */;
/*!50112 DEALLOCATE PREPARE s */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-17 22:20:58
