CREATE DATABASE  IF NOT EXISTS `mobile_web` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mobile_web`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: mobile_web
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `check_`
--

DROP TABLE IF EXISTS `check_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `check_` (
  `id_check` int NOT NULL AUTO_INCREMENT,
  `check_year` int NOT NULL,
  `check_month` int NOT NULL,
  `total_amount` float NOT NULL,
  PRIMARY KEY (`id_check`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `check_`
--

LOCK TABLES `check_` WRITE;
/*!40000 ALTER TABLE `check_` DISABLE KEYS */;
INSERT INTO `check_` VALUES (1,2019,7,817.07),(2,2021,1,1849.58),(3,2021,2,999.32),(4,2021,3,1124.54),(5,2021,4,1904.43),(6,2021,5,74.42),(7,2021,6,678.45),(8,2021,7,0),(9,2021,8,0),(10,2021,9,0),(11,2021,10,0);
/*!40000 ALTER TABLE `check_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `check_detail`
--

DROP TABLE IF EXISTS `check_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `check_detail` (
  `check_detail_id` int NOT NULL AUTO_INCREMENT,
  `phone_num` varchar(15) NOT NULL,
  `amount_for_specific_num` float NOT NULL,
  `check_id` int NOT NULL,
  PRIMARY KEY (`check_detail_id`),
  KEY `check_detail_to_tariff_idx` (`phone_num`),
  KEY `check_detail_to_check_idx` (`check_id`),
  CONSTRAINT `check_detail_to_check` FOREIGN KEY (`check_id`) REFERENCES `check_` (`id_check`),
  CONSTRAINT `check_detail_to_tariff` FOREIGN KEY (`phone_num`) REFERENCES `tariff_plan` (`phone_num`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `check_detail`
--

LOCK TABLES `check_detail` WRITE;
/*!40000 ALTER TABLE `check_detail` DISABLE KEYS */;
INSERT INTO `check_detail` VALUES (1,'+79816483582',567.07,1),(2,'+79344550423',250,1),(17,'+79624952525',349.34,2),(18,'+79344550423',1500.24,2),(19,'+79624952525',999.32,3),(20,'+79624952525',1124.54,4),(21,'+79624952525',1904.43,5),(22,'+79624952525',74.42,6),(23,'+79624952525',678.45,7);
/*!40000 ALTER TABLE `check_detail` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_detail_AFTER_INSERT_1` AFTER INSERT ON `check_detail` FOR EACH ROW BEGIN
if exists(select * from check_ where id_check=new.check_id )then
update check_ set total_amount = total_amount+new.amount_for_specific_num where id_check=new.check_id;
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `external_user`
--

DROP TABLE IF EXISTS `external_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_user` (
  `user_id` int NOT NULL,
  `login` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  KEY `external_to_sub_idx` (`user_id`),
  CONSTRAINT `external_to_sub` FOREIGN KEY (`user_id`) REFERENCES `subscriber` (`id_subscriber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_user`
--

LOCK TABLES `external_user` WRITE;
/*!40000 ALTER TABLE `external_user` DISABLE KEYS */;
INSERT INTO `external_user` VALUES (1,'1111','1111'),(2,'2222','2222');
/*!40000 ALTER TABLE `external_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `internal_user`
--

DROP TABLE IF EXISTS `internal_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `internal_user` (
  `user_id` int NOT NULL,
  `user_group` varchar(45) DEFAULT NULL,
  `login` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  KEY `internal_to_sub_idx` (`user_id`),
  CONSTRAINT `internal_to_sub` FOREIGN KEY (`user_id`) REFERENCES `subscriber` (`id_subscriber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `internal_user`
--

LOCK TABLES `internal_user` WRITE;
/*!40000 ALTER TABLE `internal_user` DISABLE KEYS */;
INSERT INTO `internal_user` VALUES (10,'admin','admin','admin'),(100,'manager','man','man');
/*!40000 ALTER TABLE `internal_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `limit_table`
--

DROP TABLE IF EXISTS `limit_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `limit_table` (
  `id_limit` int NOT NULL AUTO_INCREMENT,
  `phone_num` varchar(15) NOT NULL,
  `excess_amount` float NOT NULL,
  `limit_year` int NOT NULL,
  `limit_month` int NOT NULL,
  `sign_of_payment` int NOT NULL,
  PRIMARY KEY (`id_limit`),
  KEY `limit_to_tariff_idx` (`phone_num`),
  CONSTRAINT `` FOREIGN KEY (`phone_num`) REFERENCES `tariff_plan` (`phone_num`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `limit_table`
--

LOCK TABLES `limit_table` WRITE;
/*!40000 ALTER TABLE `limit_table` DISABLE KEYS */;
INSERT INTO `limit_table` VALUES (3,'+79034826891',256.63,2020,5,0),(4,'+79256836424',25.25,2020,3,0),(5,'+79427920942',362.72,2020,3,0),(6,'+79816483582',567.07,2019,6,0),(8,'+79344550423',500.24,2021,1,0),(9,'+79624952525',124.54,2021,3,0),(10,'+79624952525',904.43,2021,4,0),(11,'+79624952525',49753.4,2022,1,0),(13,'+79816483582',23456,2025,1,0);
/*!40000 ALTER TABLE `limit_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id_payment` int NOT NULL AUTO_INCREMENT,
  `payment_year` int NOT NULL,
  `payment_month` varchar(45) NOT NULL,
  PRIMARY KEY (`id_payment`),
  UNIQUE KEY `id_payment_UNIQUE` (`id_payment`)
) ENGINE=InnoDB AUTO_INCREMENT=2357305 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_detail`
--

DROP TABLE IF EXISTS `payment_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_detail` (
  `phone_num` varchar(15) NOT NULL,
  `amount` float NOT NULL,
  `payment_year` int NOT NULL,
  `payment_month` varchar(45) NOT NULL,
  `payment_id` int DEFAULT NULL,
  `payment_detail_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`payment_detail_id`),
  KEY `pd_to_p_idx` (`payment_id`),
  CONSTRAINT `pd_to_p` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id_payment`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_detail`
--

LOCK TABLES `payment_detail` WRITE;
/*!40000 ALTER TABLE `payment_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_debt`
--

DROP TABLE IF EXISTS `report_debt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_debt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `debt_amount` float NOT NULL,
  `year_` int NOT NULL,
  `month_` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_debt`
--

LOCK TABLES `report_debt` WRITE;
/*!40000 ALTER TABLE `report_debt` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_debt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_over_limit`
--

DROP TABLE IF EXISTS `report_over_limit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_over_limit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `phone_id` varchar(15) NOT NULL,
  `year_` int NOT NULL,
  `sum_` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_over_limit`
--

LOCK TABLES `report_over_limit` WRITE;
/*!40000 ALTER TABLE `report_over_limit` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_over_limit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriber`
--

DROP TABLE IF EXISTS `subscriber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriber` (
  `id_subscriber` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `birthday` date NOT NULL,
  `adress` varchar(45) NOT NULL,
  `enroll_date` date NOT NULL,
  `department` varchar(45) NOT NULL,
  PRIMARY KEY (`id_subscriber`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriber`
--

LOCK TABLES `subscriber` WRITE;
/*!40000 ALTER TABLE `subscriber` DISABLE KEYS */;
INSERT INTO `subscriber` VALUES (1,'Alexander','Mitrovic','1994-12-23','London, Fulham st.','2020-01-01','ENG1'),(2,'Fedor','Smolov','1990-02-09','Moscow, Dynamo st.','2005-01-01','RUS1'),(3,'Alexander ','Golovin','1996-05-30','Monaco, Monaco st.','2012-01-01','FRA1'),(4,'Sergey','Milinkovic-Savic','1995-02-27','Rome, Lazio st.','2014-01-01','ITA1'),(5,'Robert','Lewandowski','1988-08-21','Barcelona,Barcelona st','2015-01-01','ESP1'),(6,'Artem','Dzyba','1988-08-22','Moscow, Lokomotiv st.','2016-01-01','RUS1'),(7,'Matvey','Safonov','1999-02-25','Krasnodar, Krasnodar St.','2018-01-01','RUS1'),(8,'Fedor','Chalov','1998-04-10','Moscow, CSKA st.','2019-02-20','RUS1'),(9,'Andrey','Shevchenko','1976-09-29','Kyiv, Dynamo st.','2018-11-11','UKR1'),(10,'Admin','Admin','2000-01-01','Admin','2000-01-01','ADM'),(11,'Marcos','Llorente','1995-01-30','Madrid, Atletico st.','2020-01-01','ESP1'),(12,'Kyle','Walker','1990-05-28','Manchester, City st.','2020-01-01','ENG1'),(13,'Kevin','De Bruyne','1991-06-28','Manchester, City st.','2020-01-01','ENG1'),(14,'Diego','Milito','1979-06-12','Milan, Inter st.','2020-01-01','ITA1'),(15,'Iker','Casillas','1981-05-20','Madrid, Real st.','2021-01-01','ESP1'),(100,'Manager','Manager','2000-01-01','Manager','2000-01-01','MAN'),(101,'Marko','Reus','1989-01-01','Dortmund, Borussia st.','2023-12-14','GER1'),(102,'Pavel','Schegolev','2003-04-05','Moscow','2023-12-27','RUS1');
/*!40000 ALTER TABLE `subscriber` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tariff_plan`
--

DROP TABLE IF EXISTS `tariff_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tariff_plan` (
  `phone_num` varchar(15) NOT NULL,
  `limit_` float NOT NULL,
  `period_year` int NOT NULL,
  `period_month` int NOT NULL,
  `sub_id` int NOT NULL,
  PRIMARY KEY (`phone_num`),
  KEY `tariff_to_sub_idx` (`sub_id`),
  CONSTRAINT `tariff_to_sub` FOREIGN KEY (`sub_id`) REFERENCES `subscriber` (`id_subscriber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tariff_plan`
--

LOCK TABLES `tariff_plan` WRITE;
/*!40000 ALTER TABLE `tariff_plan` DISABLE KEYS */;
INSERT INTO `tariff_plan` VALUES ('+76621864863',400,2027,12,8),('+79034826891',400,2027,12,7),('+79256836424',400,2027,12,5),('+79272864524',4000,2050,12,3),('+79324681485',600,2030,12,6),('+79344550423',500,2045,12,1),('+79427920942',800,2024,6,1),('+79587258131',1500,2031,12,2),('+79624952525',1000,2030,12,1),('+79677926492',900,2030,12,2),('+79816483582',400,2031,12,4),('+79856193550',3333,2077,12,13),('+79856193551',4000,11111,1,12),('+79857328822',500,2025,12,3);
/*!40000 ALTER TABLE `tariff_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'mobile_web'
--
/*!50003 DROP PROCEDURE IF EXISTS `proc_report_debt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_report_debt`(yyear_ int, mmonth_ int)
BEGIN
declare done int default 0;
declare if_exists int default 0;
declare s_id, yyear, mmonth integer;
declare totall float;

declare c1 cursor for select s.id_subscriber, excess_amount,limit_year,limit_month  from limit_table lt join tariff_plan tp 
on lt.phone_num = tp.phone_num join subscriber s on tp.sub_id= s.id_subscriber
where limit_month=mmonth_ and
limit_year= yyear_ and sign_of_payment=0;

declare c2 cursor for select count(*) from report_debt
where mmonth_=month_ and year_=yyear_;

declare exit handler for NOT FOUND set done = 1;

open c2;
fetch c2 into if_exists;
close c2;

if (if_exists is NULL or if_exists=0) then set if_exists=0;
else set if_exists=1;
end if;

if (if_exists = 0) then
open c1;
while done=0 do
fetch c1 into s_id, totall,yyear, mmonth;
insert report_debt (employee_id,debt_amount,year_,month_) values(s_id, totall,yyear, mmonth);
end while;
close c1;
end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_report_over_limit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_report_over_limit`(yyear_ int)
BEGIN
declare done int default 0;
declare if_exists int default 0;
declare yyear integer;
declare totall float;
declare phon varchar(15);

declare c1 cursor for select tp.phone_num,sum(excess_amount)  from tariff_plan tp join  limit_table lt
on lt.phone_num = tp.phone_num where lt.limit_year = yyear_ 
group by tp.phone_num;

declare c2 cursor for select count(*) from report_over_limit
where year_ = yyear_;

declare exit handler for NOT FOUND set done = 1;

open c2;
fetch c2 into if_exists;
close c2;

if (if_exists is NULL or if_exists=0) then set if_exists=0;
else set if_exists=1;
end if;

if (if_exists = 0) then
open c1;
while done=0 do
fetch c1 into phon, totall;
insert report_over_limit (phone_id,year_,sum_) values(phon, yyear_, totall);
end while;
close c1;
end if;

END ;;
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

-- Dump completed on 2024-05-23  9:52:09
