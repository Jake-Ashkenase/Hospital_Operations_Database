CREATE DATABASE  IF NOT EXISTS `operations` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `operations`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: operations
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `box_of_gloves`
--

DROP TABLE IF EXISTS `box_of_gloves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `box_of_gloves` (
  `brand` varchar(64) NOT NULL,
  `count` int NOT NULL,
  `ppe_id` int NOT NULL,
  KEY `gloves_PPE_foreign_key` (`ppe_id`),
  CONSTRAINT `gloves_PPE_foreign_key` FOREIGN KEY (`ppe_id`) REFERENCES `ppe` (`ppe_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `box_of_gloves`
--

LOCK TABLES `box_of_gloves` WRITE;
/*!40000 ALTER TABLE `box_of_gloves` DISABLE KEYS */;
INSERT INTO `box_of_gloves` VALUES ('gloves inc',100,1),('protect',150,2),('gl company',125,3),('ggc',150,11);
/*!40000 ALTER TABLE `box_of_gloves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `box_of_masks`
--

DROP TABLE IF EXISTS `box_of_masks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `box_of_masks` (
  `brand` varchar(64) NOT NULL,
  `type` varchar(64) NOT NULL,
  `count` int NOT NULL,
  `ppe_id` int NOT NULL,
  KEY `masks_PPE_foreign_key` (`ppe_id`),
  CONSTRAINT `masks_PPE_foreign_key` FOREIGN KEY (`ppe_id`) REFERENCES `ppe` (`ppe_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `box_of_masks`
--

LOCK TABLES `box_of_masks` WRITE;
/*!40000 ALTER TABLE `box_of_masks` DISABLE KEYS */;
INSERT INTO `box_of_masks` VALUES ('Masks inc','standerd',100,7),('Masks inc','KN-95',150,8),('Mask Makers','KN-95',125,9);
/*!40000 ALTER TABLE `box_of_masks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `check_in`
--

DROP TABLE IF EXISTS `check_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `check_in` (
  `patient_id` int NOT NULL,
  `surgeon_id` int NOT NULL,
  `check_in_date` date NOT NULL,
  `check_in_summary` varchar(150) NOT NULL,
  KEY `patient_check_foreign_key` (`patient_id`),
  KEY `surgeon_check_foreign_key` (`surgeon_id`),
  CONSTRAINT `patient_check_foreign_key` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `surgeon_check_foreign_key` FOREIGN KEY (`surgeon_id`) REFERENCES `surgeon` (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `check_in`
--

LOCK TABLES `check_in` WRITE;
/*!40000 ALTER TABLE `check_in` DISABLE KEYS */;
INSERT INTO `check_in` VALUES (1,3,'2022-05-23','Made sure the medication was still being taken'),(2,2,'2022-01-05','Symptoms have gone down'),(4,1,'2021-05-21','discharged patient'),(4,1,'2021-07-22','Infection present');
/*!40000 ALTER TABLE `check_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `equipment_id` int NOT NULL,
  `type` varchar(64) NOT NULL,
  `is_clean` tinyint(1) NOT NULL,
  PRIMARY KEY (`equipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` VALUES (1,'scalpel',1),(2,'scissors',1),(3,'SP02 monitor',1),(4,'surgical glue',1),(5,'forceps',0);
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment_procedure`
--

DROP TABLE IF EXISTS `equipment_procedure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment_procedure` (
  `equipment_id` int NOT NULL,
  `procedure_id` int NOT NULL,
  KEY `Equipment_procedure_foreign_key` (`equipment_id`),
  KEY `procedure_Equipment_foreign_key` (`procedure_id`),
  CONSTRAINT `Equipment_procedure_foreign_key` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `procedure_Equipment_foreign_key` FOREIGN KEY (`procedure_id`) REFERENCES `medical_procedure` (`procedure_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment_procedure`
--

LOCK TABLES `equipment_procedure` WRITE;
/*!40000 ALTER TABLE `equipment_procedure` DISABLE KEYS */;
INSERT INTO `equipment_procedure` VALUES (1,1),(3,2),(2,3);
/*!40000 ALTER TABLE `equipment_procedure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_condition`
--

DROP TABLE IF EXISTS `medical_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_condition` (
  `type` varchar(64) NOT NULL,
  `severity` int NOT NULL,
  PRIMARY KEY (`type`),
  CONSTRAINT `medical_condition_chk_1` CHECK ((`severity` between 0 and 10))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_condition`
--

LOCK TABLES `medical_condition` WRITE;
/*!40000 ALTER TABLE `medical_condition` DISABLE KEYS */;
INSERT INTO `medical_condition` VALUES ('Cancer',7),('Diabetes',5),('Hemophilia',9),('Tumor',2);
/*!40000 ALTER TABLE `medical_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_procedure`
--

DROP TABLE IF EXISTS `medical_procedure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medical_procedure` (
  `procedure_id` int NOT NULL,
  `procedure_date` date NOT NULL,
  `procedure_time` time NOT NULL,
  `type` varchar(64) NOT NULL,
  `anesthetic` varchar(64) NOT NULL,
  `surgeon` int NOT NULL,
  `patient` int NOT NULL,
  `room` int NOT NULL,
  PRIMARY KEY (`procedure_id`),
  KEY `surgeon_procedure_foreign_key` (`surgeon`),
  KEY `patient_procedure_foreign_key` (`patient`),
  KEY `room_procedure_foreign_key` (`room`),
  CONSTRAINT `patient_procedure_foreign_key` FOREIGN KEY (`patient`) REFERENCES `patient` (`patient_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `room_procedure_foreign_key` FOREIGN KEY (`room`) REFERENCES `room` (`room_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `surgeon_procedure_foreign_key` FOREIGN KEY (`surgeon`) REFERENCES `surgeon` (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_procedure`
--

LOCK TABLES `medical_procedure` WRITE;
/*!40000 ALTER TABLE `medical_procedure` DISABLE KEYS */;
INSERT INTO `medical_procedure` VALUES (1,'2021-05-13','13:30:00','Skin Lesion Removal','Propofal',1,2,3),(2,'2022-04-12','09:30:00','Tumor removal','Ketamine',1,1,2),(3,'2022-05-15','16:00:00','Hair removal','Ketamine',3,2,1);
/*!40000 ALTER TABLE `medical_procedure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurse`
--

DROP TABLE IF EXISTS `nurse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nurse` (
  `staff_id` int NOT NULL,
  `is_attending` tinyint(1) NOT NULL,
  `nurse_type` varchar(64) NOT NULL,
  KEY `nurse_id_foreign_key` (`staff_id`),
  CONSTRAINT `nurse_id_foreign_key` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurse`
--

LOCK TABLES `nurse` WRITE;
/*!40000 ALTER TABLE `nurse` DISABLE KEYS */;
INSERT INTO `nurse` VALUES (4,1,'nurse practitioner'),(5,0,'nurse practitioner'),(6,0,'Registered');
/*!40000 ALTER TABLE `nurse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `patient_id` int NOT NULL,
  `sex` varchar(1) NOT NULL,
  `age` int NOT NULL,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1,'M',51,'Juan','Uribe'),(2,'M',42,'David','Wright'),(3,'F',22,'Arielle','Smith'),(4,'F',88,'Karen','Hirsh');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_condition`
--

DROP TABLE IF EXISTS `patient_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_condition` (
  `patient_id` int NOT NULL,
  `condition_type` varchar(64) NOT NULL,
  KEY `patient_condition_foreign_key` (`patient_id`),
  KEY `condition_patient_foreign_key` (`condition_type`),
  CONSTRAINT `condition_patient_foreign_key` FOREIGN KEY (`condition_type`) REFERENCES `medical_condition` (`type`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `patient_condition_foreign_key` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_condition`
--

LOCK TABLES `patient_condition` WRITE;
/*!40000 ALTER TABLE `patient_condition` DISABLE KEYS */;
INSERT INTO `patient_condition` VALUES (1,'Cancer'),(2,'Tumor'),(3,'Diabetes'),(4,'Diabetes');
/*!40000 ALTER TABLE `patient_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ppe`
--

DROP TABLE IF EXISTS `ppe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ppe` (
  `ppe_id` int NOT NULL,
  PRIMARY KEY (`ppe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ppe`
--

LOCK TABLES `ppe` WRITE;
/*!40000 ALTER TABLE `ppe` DISABLE KEYS */;
INSERT INTO `ppe` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(11),(12),(13),(14);
/*!40000 ALTER TABLE `ppe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ppe_procedure`
--

DROP TABLE IF EXISTS `ppe_procedure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ppe_procedure` (
  `ppe_id` int NOT NULL,
  `procedure_id` int NOT NULL,
  KEY `PPE_procedure_foreign_key` (`ppe_id`),
  KEY `procedure_PPE_foreign_key` (`procedure_id`),
  CONSTRAINT `PPE_procedure_foreign_key` FOREIGN KEY (`ppe_id`) REFERENCES `ppe` (`ppe_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `procedure_PPE_foreign_key` FOREIGN KEY (`procedure_id`) REFERENCES `medical_procedure` (`procedure_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ppe_procedure`
--

LOCK TABLES `ppe_procedure` WRITE;
/*!40000 ALTER TABLE `ppe_procedure` DISABLE KEYS */;
INSERT INTO `ppe_procedure` VALUES (1,1),(4,1),(7,1),(2,3),(9,3),(6,2);
/*!40000 ALTER TABLE `ppe_procedure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procedure_nurses`
--

DROP TABLE IF EXISTS `procedure_nurses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedure_nurses` (
  `nurse` int NOT NULL,
  `procedure_id` int NOT NULL,
  KEY `nurse_procedure_foreign_key` (`nurse`),
  KEY `procedure_nurse_foreign_key` (`procedure_id`),
  CONSTRAINT `nurse_procedure_foreign_key` FOREIGN KEY (`nurse`) REFERENCES `nurse` (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `procedure_nurse_foreign_key` FOREIGN KEY (`procedure_id`) REFERENCES `medical_procedure` (`procedure_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procedure_nurses`
--

LOCK TABLES `procedure_nurses` WRITE;
/*!40000 ALTER TABLE `procedure_nurses` DISABLE KEYS */;
INSERT INTO `procedure_nurses` VALUES (4,1),(5,1),(4,2),(5,2),(6,2),(6,3);
/*!40000 ALTER TABLE `procedure_nurses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `room_id` int NOT NULL,
  `last_use` date NOT NULL,
  `is_sanitised` tinyint(1) NOT NULL,
  PRIMARY KEY (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,'2021-12-21',1),(2,'2022-05-30',1),(3,'2022-01-15',1),(12,'2022-01-15',1);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL,
  `start_date` date NOT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'2001-04-23'),(2,'2003-05-13'),(3,'2008-01-01'),(4,'1997-04-23'),(5,'1999-06-24'),(6,'2004-02-19');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suit`
--

DROP TABLE IF EXISTS `suit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suit` (
  `size` varchar(50) NOT NULL,
  `type` varchar(64) NOT NULL,
  `is_washed` tinyint(1) NOT NULL,
  `ppe_id` int NOT NULL,
  KEY `suit_PPE_foreign_key` (`ppe_id`),
  CONSTRAINT `suit_PPE_foreign_key` FOREIGN KEY (`ppe_id`) REFERENCES `ppe` (`ppe_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suit`
--

LOCK TABLES `suit` WRITE;
/*!40000 ALTER TABLE `suit` DISABLE KEYS */;
INSERT INTO `suit` VALUES ('Adult Medium','gown',1,4),('Adult Large','hazmat',1,5),('Adult Small','hazmat',1,6),('Adult Large','hazmat',1,12),('Small','Hazmat',1,13),('medium','regular',0,14);
/*!40000 ALTER TABLE `suit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surgeon`
--

DROP TABLE IF EXISTS `surgeon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surgeon` (
  `staff_id` int NOT NULL,
  `speciality` varchar(64) NOT NULL,
  KEY `surgeon_id_foreign_key` (`staff_id`),
  CONSTRAINT `surgeon_id_foreign_key` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surgeon`
--

LOCK TABLES `surgeon` WRITE;
/*!40000 ALTER TABLE `surgeon` DISABLE KEYS */;
INSERT INTO `surgeon` VALUES (1,'Emergency'),(2,'Orthopedic'),(3,'Cardiovascular');
/*!40000 ALTER TABLE `surgeon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'operations'
--

--
-- Dumping routines for database 'operations'
--
/*!50003 DROP PROCEDURE IF EXISTS `clean_rooms` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clean_rooms`(
room_param int
)
begin 
	UPDATE room 
	SET is_sanitised = True
	
    WHERE room.room_id = room_param;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `clean_suit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clean_suit`(
suit_param int
)
begin 
	UPDATE suit
	SET is_washed = True
	
    WHERE ppe_id = suit_param;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `count_of_gloves` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_of_gloves`( )
begin 
	select count(*) from box_of_gloves;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `count_of_masks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_of_masks`( )
begin 
	select count(*) from box_of_masks;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `count_of_suits` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_of_suits`( )
begin 
	select count(*) from suit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_glove` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_glove`( 
ppe_param int
)
begin 
	DELETE FROM box_of_gloves WHERE ppe_id = ppe_param;
    DELETE FROM ppe WHERE ppe_id = ppe_param;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_mask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_mask`( 
ppe_param int
)
begin 
	DELETE FROM box_of_masks WHERE ppe_id = ppe_param;
    DELETE FROM ppe WHERE ppe_id = ppe_param;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_suit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_suit`( 
ppe_param int
)
begin 
	DELETE FROM suit WHERE ppe_id = ppe_param;
    DELETE FROM ppe WHERE ppe_id = ppe_param;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_gloves` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_gloves`( 
brand_param varchar(64),
count_param int
)
begin 
	declare new_id_var int;
    select max(ppe_id) + 1 into new_id_var from ppe; 
    
	INSERT INTO  ppe VALUES (new_id_var);
    INSERT INTO box_of_gloves VALUES (brand_param, 
										count_param, 
										new_id_var);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_masks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_masks`( 
brand_param varchar(64),
type_param varchar(64),
count_param int
)
begin 
	declare new_id_var int;
    select max(ppe_id) + 1 into new_id_var from ppe; 
    
	INSERT INTO  ppe  VALUES (new_id_var);
    INSERT INTO box_of_masks VALUES (brand_param, 
										type_param, 
										count_param, 
										new_id_var);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_suit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_suit`( 
size_param varchar(64),
type_param varchar(64),
washed_param boolean
)
begin 
	declare new_id_var int;
    select max(ppe_id) + 1 into new_id_var from ppe; 
    
	INSERT INTO  ppe VALUES (new_id_var);
    INSERT INTO suit VALUES (size_param, 
										type_param, 
										washed_param, 
										new_id_var);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `view_procedure` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `view_procedure`( 
procedure_param int
)
begin 
	select type, ppe_id from ppe_procedure left outer join medical_procedure
		on ppe_procedure.procedure_id = medical_procedure.procedure_id
		where ppe_procedure.procedure_id = procedure_param;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-27 11:13:26
