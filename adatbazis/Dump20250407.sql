-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: imageeval.mysql.database.azure.com    Database: szakdoga
-- ------------------------------------------------------
-- Server version	8.0.40-azure

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
-- Table structure for table `ertekelt_fajlok`
--

DROP TABLE IF EXISTS `ertekelt_fajlok`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ertekelt_fajlok` (
  `my_row_id` bigint unsigned NOT NULL AUTO_INCREMENT /*!80023 INVISIBLE */,
  `id` int NOT NULL,
  `kitolto_id` int NOT NULL,
  `fajl_id` int NOT NULL,
  `projekt_id` int NOT NULL,
  `pontszam` int NOT NULL,
  PRIMARY KEY (`my_row_id`),
  KEY `kitolto_id` (`kitolto_id`),
  KEY `projekt_id` (`projekt_id`),
  KEY `ertekelt_fajlok_ibfk_2` (`fajl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ertekelt_fajlok`
--

LOCK TABLES `ertekelt_fajlok` WRITE;
/*!40000 ALTER TABLE `ertekelt_fajlok` DISABLE KEYS */;
/*!40000 ALTER TABLE `ertekelt_fajlok` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fajlok`
--

DROP TABLE IF EXISTS `fajlok`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fajlok` (
  `my_row_id` bigint unsigned NOT NULL AUTO_INCREMENT /*!80023 INVISIBLE */,
  `id` int NOT NULL,
  `projekt_id` int NOT NULL,
  `fajl_nev` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `tipus` enum('kep','video','hang') COLLATE utf8mb4_hungarian_ci NOT NULL,
  `ertekelesek_szama` int DEFAULT '0',
  PRIMARY KEY (`my_row_id`),
  KEY `projekt_id` (`projekt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=601 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fajlok`
--

LOCK TABLES `fajlok` WRITE;
/*!40000 ALTER TABLE `fajlok` DISABLE KEYS */;
INSERT INTO `fajlok` (`my_row_id`, `id`, `projekt_id`, `fajl_nev`, `tipus`, `ertekelesek_szama`) VALUES (1,1,1,'I01_02_01.png','kep',0),(2,2,1,'I01_02_02.png','kep',0),(3,3,1,'I01_02_03.png','kep',0),(4,4,1,'I01_02_04.png','kep',0),(5,5,1,'I01_02_05.png','kep',0),(6,6,1,'I06_02_01.png','kep',0),(7,7,1,'I06_02_02.png','kep',0),(8,8,1,'I06_02_03.png','kep',0),(9,9,1,'I06_02_04.png','kep',0),(10,10,1,'I06_02_05.png','kep',0),(11,11,1,'I08_02_01.png','kep',0),(12,12,1,'I08_02_02.png','kep',0),(13,13,1,'I08_02_03.png','kep',0),(14,14,1,'I08_02_04.png','kep',0),(15,15,1,'I08_02_05.png','kep',0),(16,16,1,'I11_02_01.png','kep',0),(17,17,1,'I11_02_02.png','kep',0),(18,18,1,'I11_02_03.png','kep',0),(19,19,1,'I11_02_04.png','kep',0),(20,20,1,'I11_02_05.png','kep',0),(21,21,1,'I12_02_01.png','kep',0),(22,22,1,'I12_02_02.png','kep',0),(23,23,1,'I12_02_03.png','kep',0),(24,24,1,'I12_02_04.png','kep',0),(25,25,1,'I12_02_05.png','kep',0),(26,26,1,'I14_02_01.png','kep',0),(27,27,1,'I14_02_02.png','kep',0),(28,28,1,'I14_02_03.png','kep',0),(29,29,1,'I14_02_04.png','kep',0),(30,30,1,'I14_02_05.png','kep',0),(31,31,1,'I15_02_01.png','kep',0),(32,32,1,'I15_02_02.png','kep',0),(33,33,1,'I15_02_03.png','kep',0),(34,34,1,'I15_02_04.png','kep',0),(35,35,1,'I15_02_05.png','kep',0),(36,36,1,'I18_02_01.png','kep',0),(37,37,1,'I18_02_02.png','kep',0),(38,38,1,'I18_02_03.png','kep',0),(39,39,1,'I18_02_04.png','kep',0),(40,40,1,'I18_02_05.png','kep',0),(41,41,1,'I19_02_01.png','kep',0),(42,42,1,'I19_02_02.png','kep',0),(43,43,1,'I19_02_03.png','kep',0),(44,44,1,'I19_02_04.png','kep',0),(45,45,1,'I19_02_05.png','kep',0),(46,46,1,'I20_02_01.png','kep',0),(47,47,1,'I20_02_02.png','kep',0),(48,48,1,'I20_02_03.png','kep',0),(49,49,1,'I20_02_04.png','kep',0),(50,50,1,'I20_02_05.png','kep',0),(51,51,1,'I23_02_01.png','kep',0),(52,52,1,'I23_02_02.png','kep',0),(53,53,1,'I23_02_03.png','kep',0),(54,54,1,'I23_02_04.png','kep',0),(55,55,1,'I23_02_05.png','kep',0),(56,56,1,'I24_02_01.png','kep',0),(57,57,1,'I24_02_02.png','kep',0),(58,58,1,'I24_02_03.png','kep',0),(59,59,1,'I24_02_04.png','kep',0),(60,60,1,'I24_02_05.png','kep',0),(61,61,1,'I25_02_01.png','kep',0),(62,62,1,'I25_02_02.png','kep',0),(63,63,1,'I25_02_03.png','kep',0),(64,64,1,'I25_02_04.png','kep',0),(65,65,1,'I25_02_05.png','kep',0),(66,66,1,'I26_02_01.png','kep',0),(67,67,1,'I26_02_02.png','kep',0),(68,68,1,'I26_02_03.png','kep',0),(69,69,1,'I26_02_04.png','kep',0),(70,70,1,'I26_02_05.png','kep',0),(71,71,1,'I27_02_01.png','kep',0),(72,72,1,'I27_02_02.png','kep',0),(73,73,1,'I27_02_03.png','kep',0),(74,74,1,'I27_02_04.png','kep',0),(75,75,1,'I27_02_05.png','kep',0),(76,76,1,'I29_02_01.png','kep',0),(77,77,1,'I29_02_02.png','kep',0),(78,78,1,'I29_02_03.png','kep',0),(79,79,1,'I29_02_04.png','kep',0),(80,80,1,'I29_02_05.png','kep',0),(81,81,1,'I30_02_01.png','kep',0),(82,82,1,'I30_02_02.png','kep',0),(83,83,1,'I30_02_03.png','kep',0),(84,84,1,'I30_02_04.png','kep',0),(85,85,1,'I30_02_05.png','kep',0),(86,86,1,'I31_02_01.png','kep',0),(87,87,1,'I31_02_02.png','kep',0),(88,88,1,'I31_02_03.png','kep',0),(89,89,1,'I31_02_04.png','kep',0),(90,90,1,'I31_02_05.png','kep',0),(91,91,1,'I32_02_01.png','kep',0),(92,92,1,'I32_02_02.png','kep',0),(93,93,1,'I32_02_03.png','kep',0),(94,94,1,'I32_02_04.png','kep',0),(95,95,1,'I32_02_05.png','kep',0),(96,96,1,'I33_02_01.png','kep',0),(97,97,1,'I33_02_02.png','kep',0),(98,98,1,'I33_02_03.png','kep',0),(99,99,1,'I33_02_04.png','kep',0),(100,100,1,'I33_02_05.png','kep',0),(101,101,1,'I34_02_01.png','kep',0),(102,102,1,'I34_02_02.png','kep',0),(103,103,1,'I34_02_03.png','kep',0),(104,104,1,'I34_02_04.png','kep',0),(105,105,1,'I34_02_05.png','kep',0),(106,106,1,'I35_02_01.png','kep',0),(107,107,1,'I35_02_02.png','kep',0),(108,108,1,'I35_02_03.png','kep',0),(109,109,1,'I35_02_04.png','kep',0),(110,110,1,'I35_02_05.png','kep',0),(111,111,1,'I36_02_01.png','kep',0),(112,112,1,'I36_02_02.png','kep',0),(113,113,1,'I36_02_03.png','kep',0),(114,114,1,'I36_02_04.png','kep',0),(115,115,1,'I36_02_05.png','kep',0),(116,116,1,'I37_02_01.png','kep',0),(117,117,1,'I37_02_02.png','kep',0),(118,118,1,'I37_02_03.png','kep',0),(119,119,1,'I37_02_04.png','kep',0),(120,120,1,'I37_02_05.png','kep',0),(121,121,1,'I38_02_01.png','kep',0),(122,122,1,'I38_02_02.png','kep',0),(123,123,1,'I38_02_03.png','kep',0),(124,124,1,'I38_02_04.png','kep',0),(125,125,1,'I38_02_05.png','kep',0),(126,126,1,'I39_02_01.png','kep',0),(127,127,1,'I39_02_02.png','kep',0),(128,128,1,'I39_02_03.png','kep',0),(129,129,1,'I39_02_04.png','kep',0),(130,130,1,'I39_02_05.png','kep',0),(131,131,1,'I40_02_01.png','kep',0),(132,132,1,'I40_02_02.png','kep',0),(133,133,1,'I40_02_03.png','kep',0),(134,134,1,'I40_02_04.png','kep',0),(135,135,1,'I40_02_05.png','kep',0),(136,136,1,'I43_02_01.png','kep',0),(137,137,1,'I43_02_02.png','kep',0),(138,138,1,'I43_02_03.png','kep',0),(139,139,1,'I43_02_04.png','kep',0),(140,140,1,'I43_02_05.png','kep',0),(141,141,1,'I44_02_01.png','kep',0),(142,142,1,'I44_02_02.png','kep',0),(143,143,1,'I44_02_03.png','kep',0),(144,144,1,'I44_02_04.png','kep',0),(145,145,1,'I44_02_05.png','kep',0),(146,146,1,'I45_02_01.png','kep',0),(147,147,1,'I45_02_02.png','kep',0),(148,148,1,'I45_02_03.png','kep',0),(149,149,1,'I45_02_04.png','kep',0),(150,150,1,'I45_02_05.png','kep',0),(151,151,1,'I52_02_01.png','kep',0),(152,152,1,'I52_02_02.png','kep',0),(153,153,1,'I52_02_03.png','kep',0),(154,154,1,'I52_02_04.png','kep',0),(155,155,1,'I52_02_05.png','kep',0),(156,156,1,'I54_02_01.png','kep',0),(157,157,1,'I54_02_02.png','kep',0),(158,158,1,'I54_02_03.png','kep',0),(159,159,1,'I54_02_04.png','kep',0),(160,160,1,'I54_02_05.png','kep',0),(161,161,1,'I55_02_01.png','kep',0),(162,162,1,'I55_02_02.png','kep',0),(163,163,1,'I55_02_03.png','kep',0),(164,164,1,'I55_02_04.png','kep',0),(165,165,1,'I55_02_05.png','kep',0),(166,166,1,'I58_02_01.png','kep',0),(167,167,1,'I58_02_02.png','kep',0),(168,168,1,'I58_02_03.png','kep',0),(169,169,1,'I58_02_04.png','kep',0),(170,170,1,'I58_02_05.png','kep',0),(171,171,1,'I59_02_01.png','kep',0),(172,172,1,'I59_02_02.png','kep',0),(173,173,1,'I59_02_03.png','kep',0),(174,174,1,'I59_02_04.png','kep',0),(175,175,1,'I59_02_05.png','kep',0),(176,176,1,'I62_02_01.png','kep',0),(177,177,1,'I62_02_02.png','kep',0),(178,178,1,'I62_02_03.png','kep',0),(179,179,1,'I62_02_04.png','kep',0),(180,180,1,'I62_02_05.png','kep',0),(181,181,1,'I63_02_01.png','kep',0),(182,182,1,'I63_02_02.png','kep',0),(183,183,1,'I63_02_03.png','kep',0),(184,184,1,'I63_02_04.png','kep',0),(185,185,1,'I63_02_05.png','kep',0),(186,186,1,'I70_02_01.png','kep',0),(187,187,1,'I70_02_02.png','kep',0),(188,188,1,'I70_02_03.png','kep',0),(189,189,1,'I70_02_04.png','kep',0),(190,190,1,'I70_02_05.png','kep',0),(191,191,1,'I73_02_01.png','kep',0),(192,192,1,'I73_02_02.png','kep',0),(193,193,1,'I73_02_03.png','kep',0),(194,194,1,'I73_02_04.png','kep',0),(195,195,1,'I73_02_05.png','kep',0),(196,196,1,'I74_02_01.png','kep',0),(197,197,1,'I74_02_02.png','kep',0),(198,198,1,'I74_02_03.png','kep',0),(199,199,1,'I74_02_04.png','kep',0),(200,200,1,'I74_02_05.png','kep',0),(201,201,2,'I02_10_01.png','kep',0),(202,202,2,'I02_10_02.png','kep',0),(203,203,2,'I02_10_03.png','kep',0),(204,204,2,'I02_10_04.png','kep',0),(205,205,2,'I02_10_05.png','kep',0),(206,206,2,'I03_10_01.png','kep',0),(207,207,2,'I03_10_02.png','kep',0),(208,208,2,'I03_10_03.png','kep',0),(209,209,2,'I03_10_04.png','kep',0),(210,210,2,'I03_10_05.png','kep',0),(211,211,2,'I04_10_01.png','kep',0),(212,212,2,'I04_10_02.png','kep',0),(213,213,2,'I04_10_03.png','kep',0),(214,214,2,'I04_10_04.png','kep',0),(215,215,2,'I04_10_05.png','kep',0),(216,216,2,'I05_10_01.png','kep',0),(217,217,2,'I05_10_02.png','kep',0),(218,218,2,'I05_10_03.png','kep',0),(219,219,2,'I05_10_04.png','kep',0),(220,220,2,'I05_10_05.png','kep',0),(221,221,2,'I07_10_01.png','kep',0),(222,222,2,'I07_10_02.png','kep',0),(223,223,2,'I07_10_03.png','kep',0),(224,224,2,'I07_10_04.png','kep',0),(225,225,2,'I07_10_05.png','kep',0),(226,226,2,'I09_10_01.png','kep',0),(227,227,2,'I09_10_02.png','kep',0),(228,228,2,'I09_10_03.png','kep',0),(229,229,2,'I09_10_04.png','kep',0),(230,230,2,'I09_10_05.png','kep',0),(231,231,2,'I10_10_01.png','kep',0),(232,232,2,'I10_10_02.png','kep',0),(233,233,2,'I10_10_03.png','kep',0),(234,234,2,'I10_10_04.png','kep',0),(235,235,2,'I10_10_05.png','kep',0),(236,236,2,'I13_10_01.png','kep',0),(237,237,2,'I13_10_02.png','kep',0),(238,238,2,'I13_10_03.png','kep',0),(239,239,2,'I13_10_04.png','kep',0),(240,240,2,'I13_10_05.png','kep',0),(241,241,2,'I16_10_01.png','kep',0),(242,242,2,'I16_10_02.png','kep',0),(243,243,2,'I16_10_03.png','kep',0),(244,244,2,'I16_10_04.png','kep',0),(245,245,2,'I16_10_05.png','kep',0),(246,246,2,'I17_10_01.png','kep',0),(247,247,2,'I17_10_02.png','kep',0),(248,248,2,'I17_10_03.png','kep',0),(249,249,2,'I17_10_04.png','kep',0),(250,250,2,'I17_10_05.png','kep',0),(251,251,2,'I21_10_01.png','kep',0),(252,252,2,'I21_10_02.png','kep',0),(253,253,2,'I21_10_03.png','kep',0),(254,254,2,'I21_10_04.png','kep',0),(255,255,2,'I21_10_05.png','kep',0),(256,256,2,'I22_10_01.png','kep',0),(257,257,2,'I22_10_02.png','kep',0),(258,258,2,'I22_10_03.png','kep',0),(259,259,2,'I22_10_04.png','kep',0),(260,260,2,'I22_10_05.png','kep',0),(261,261,2,'I28_10_01.png','kep',0),(262,262,2,'I28_10_02.png','kep',0),(263,263,2,'I28_10_03.png','kep',0),(264,264,2,'I28_10_04.png','kep',0),(265,265,2,'I28_10_05.png','kep',0),(266,266,2,'I41_10_01.png','kep',0),(267,267,2,'I41_10_02.png','kep',0),(268,268,2,'I41_10_03.png','kep',0),(269,269,2,'I41_10_04.png','kep',0),(270,270,2,'I41_10_05.png','kep',0),(271,271,2,'I42_10_01.png','kep',0),(272,272,2,'I42_10_02.png','kep',0),(273,273,2,'I42_10_03.png','kep',0),(274,274,2,'I42_10_04.png','kep',0),(275,275,2,'I42_10_05.png','kep',0),(276,276,2,'I46_10_01.png','kep',0),(277,277,2,'I46_10_02.png','kep',0),(278,278,2,'I46_10_03.png','kep',0),(279,279,2,'I46_10_04.png','kep',0),(280,280,2,'I46_10_05.png','kep',0),(281,281,2,'I47_10_01.png','kep',0),(282,282,2,'I47_10_02.png','kep',0),(283,283,2,'I47_10_03.png','kep',0),(284,284,2,'I47_10_04.png','kep',0),(285,285,2,'I47_10_05.png','kep',0),(286,286,2,'I48_10_01.png','kep',0),(287,287,2,'I48_10_02.png','kep',0),(288,288,2,'I48_10_03.png','kep',0),(289,289,2,'I48_10_04.png','kep',0),(290,290,2,'I48_10_05.png','kep',0),(291,291,2,'I49_10_01.png','kep',0),(292,292,2,'I49_10_02.png','kep',0),(293,293,2,'I49_10_03.png','kep',0),(294,294,2,'I49_10_04.png','kep',0),(295,295,2,'I49_10_05.png','kep',0),(296,296,2,'I50_10_01.png','kep',0),(297,297,2,'I50_10_02.png','kep',0),(298,298,2,'I50_10_03.png','kep',0),(299,299,2,'I50_10_04.png','kep',0),(300,300,2,'I50_10_05.png','kep',0),(301,301,2,'I51_10_01.png','kep',0),(302,302,2,'I51_10_02.png','kep',0),(303,303,2,'I51_10_03.png','kep',0),(304,304,2,'I51_10_04.png','kep',0),(305,305,2,'I51_10_05.png','kep',0),(306,306,2,'I53_10_01.png','kep',0),(307,307,2,'I53_10_02.png','kep',0),(308,308,2,'I53_10_03.png','kep',0),(309,309,2,'I53_10_04.png','kep',0),(310,310,2,'I53_10_05.png','kep',0),(311,311,2,'I56_10_01.png','kep',0),(312,312,2,'I56_10_02.png','kep',0),(313,313,2,'I56_10_03.png','kep',0),(314,314,2,'I56_10_04.png','kep',0),(315,315,2,'I56_10_05.png','kep',0),(316,316,2,'I57_10_01.png','kep',0),(317,317,2,'I57_10_02.png','kep',0),(318,318,2,'I57_10_03.png','kep',0),(319,319,2,'I57_10_04.png','kep',0),(320,320,2,'I57_10_05.png','kep',0),(321,321,2,'I60_10_01.png','kep',0),(322,322,2,'I60_10_02.png','kep',0),(323,323,2,'I60_10_03.png','kep',0),(324,324,2,'I60_10_04.png','kep',0),(325,325,2,'I60_10_05.png','kep',0),(326,326,2,'I61_10_01.png','kep',0),(327,327,2,'I61_10_02.png','kep',0),(328,328,2,'I61_10_03.png','kep',0),(329,329,2,'I61_10_04.png','kep',0),(330,330,2,'I61_10_05.png','kep',0),(331,331,2,'I64_10_01.png','kep',0),(332,332,2,'I64_10_02.png','kep',0),(333,333,2,'I64_10_03.png','kep',0),(334,334,2,'I64_10_04.png','kep',0),(335,335,2,'I64_10_05.png','kep',0),(336,336,2,'I65_10_01.png','kep',0),(337,337,2,'I65_10_02.png','kep',0),(338,338,2,'I65_10_03.png','kep',0),(339,339,2,'I65_10_04.png','kep',0),(340,340,2,'I65_10_05.png','kep',0),(341,341,2,'I66_10_01.png','kep',0),(342,342,2,'I66_10_02.png','kep',0),(343,343,2,'I66_10_03.png','kep',0),(344,344,2,'I66_10_04.png','kep',0),(345,345,2,'I66_10_05.png','kep',0),(346,346,2,'I67_10_01.png','kep',0),(347,347,2,'I67_10_02.png','kep',0),(348,348,2,'I67_10_03.png','kep',0),(349,349,2,'I67_10_04.png','kep',0),(350,350,2,'I67_10_05.png','kep',0),(351,351,2,'I68_10_01.png','kep',0),(352,352,2,'I68_10_02.png','kep',0),(353,353,2,'I68_10_03.png','kep',0),(354,354,2,'I68_10_04.png','kep',0),(355,355,2,'I68_10_05.png','kep',0),(356,356,2,'I69_10_01.png','kep',0),(357,357,2,'I69_10_02.png','kep',0),(358,358,2,'I69_10_03.png','kep',0),(359,359,2,'I69_10_04.png','kep',0),(360,360,2,'I69_10_05.png','kep',0),(361,361,2,'I71_10_01.png','kep',0),(362,362,2,'I71_10_02.png','kep',0),(363,363,2,'I71_10_03.png','kep',0),(364,364,2,'I71_10_04.png','kep',0),(365,365,2,'I71_10_05.png','kep',0),(366,366,2,'I72_10_01.png','kep',0),(367,367,2,'I72_10_02.png','kep',0),(368,368,2,'I72_10_03.png','kep',0),(369,369,2,'I72_10_04.png','kep',0),(370,370,2,'I72_10_05.png','kep',0),(371,371,2,'I75_10_01.png','kep',0),(372,372,2,'I75_10_02.png','kep',0),(373,373,2,'I75_10_03.png','kep',0),(374,374,2,'I75_10_04.png','kep',0),(375,375,2,'I75_10_05.png','kep',0),(376,376,2,'I76_10_01.png','kep',0),(377,377,2,'I76_10_02.png','kep',0),(378,378,2,'I76_10_03.png','kep',0),(379,379,2,'I76_10_04.png','kep',0),(380,380,2,'I76_10_05.png','kep',0),(381,381,2,'I77_10_01.png','kep',0),(382,382,2,'I77_10_02.png','kep',0),(383,383,2,'I77_10_03.png','kep',0),(384,384,2,'I77_10_04.png','kep',0),(385,385,2,'I77_10_05.png','kep',0),(386,386,2,'I78_10_01.png','kep',0),(387,387,2,'I78_10_02.png','kep',0),(388,388,2,'I78_10_03.png','kep',0),(389,389,2,'I78_10_04.png','kep',0),(390,390,2,'I78_10_05.png','kep',0),(391,391,2,'I79_10_01.png','kep',0),(392,392,2,'I79_10_02.png','kep',0),(393,393,2,'I79_10_03.png','kep',0),(394,394,2,'I79_10_04.png','kep',0),(395,395,2,'I79_10_05.png','kep',0),(396,396,2,'I80_10_01.png','kep',0),(397,397,2,'I80_10_02.png','kep',0),(398,398,2,'I80_10_03.png','kep',0),(399,399,2,'I80_10_04.png','kep',0),(400,400,2,'I80_10_05.png','kep',0),(401,401,3,'I10_12_01.png','kep',0),(402,402,3,'I10_12_02.png','kep',0),(403,403,3,'I10_12_03.png','kep',0),(404,404,3,'I10_12_04.png','kep',0),(405,405,3,'I10_12_05.png','kep',0),(406,406,3,'I11_12_01.png','kep',0),(407,407,3,'I11_12_02.png','kep',0),(408,408,3,'I11_12_03.png','kep',0),(409,409,3,'I11_12_04.png','kep',0),(410,410,3,'I11_12_05.png','kep',0),(411,411,3,'I12_12_01.png','kep',0),(412,412,3,'I12_12_02.png','kep',0),(413,413,3,'I12_12_03.png','kep',0),(414,414,3,'I12_12_04.png','kep',0),(415,415,3,'I12_12_05.png','kep',0),(416,416,3,'I13_12_01.png','kep',0),(417,417,3,'I13_12_02.png','kep',0),(418,418,3,'I13_12_03.png','kep',0),(419,419,3,'I13_12_04.png','kep',0),(420,420,3,'I13_12_05.png','kep',0),(421,421,3,'I14_12_01.png','kep',0),(422,422,3,'I14_12_02.png','kep',0),(423,423,3,'I14_12_03.png','kep',0),(424,424,3,'I14_12_04.png','kep',0),(425,425,3,'I14_12_05.png','kep',0),(426,426,3,'I15_12_01.png','kep',0),(427,427,3,'I15_12_02.png','kep',0),(428,428,3,'I15_12_03.png','kep',0),(429,429,3,'I15_12_04.png','kep',0),(430,430,3,'I15_12_05.png','kep',0),(431,431,3,'I16_12_01.png','kep',0),(432,432,3,'I16_12_02.png','kep',0),(433,433,3,'I16_12_03.png','kep',0),(434,434,3,'I16_12_04.png','kep',0),(435,435,3,'I16_12_05.png','kep',0),(436,436,3,'I17_12_01.png','kep',0),(437,437,3,'I17_12_02.png','kep',0),(438,438,3,'I17_12_03.png','kep',0),(439,439,3,'I17_12_04.png','kep',0),(440,440,3,'I17_12_05.png','kep',0),(441,441,3,'I18_12_01.png','kep',0),(442,442,3,'I18_12_02.png','kep',0),(443,443,3,'I18_12_03.png','kep',0),(444,444,3,'I18_12_04.png','kep',0),(445,445,3,'I18_12_05.png','kep',0),(446,446,3,'I19_12_01.png','kep',0),(447,447,3,'I19_12_02.png','kep',0),(448,448,3,'I19_12_03.png','kep',0),(449,449,3,'I19_12_04.png','kep',0),(450,450,3,'I19_12_05.png','kep',0),(451,451,3,'I20_12_01.png','kep',0),(452,452,3,'I20_12_02.png','kep',0),(453,453,3,'I20_12_03.png','kep',0),(454,454,3,'I20_12_04.png','kep',0),(455,455,3,'I20_12_05.png','kep',0),(456,456,3,'I21_12_01.png','kep',0),(457,457,3,'I21_12_02.png','kep',0),(458,458,3,'I21_12_03.png','kep',0),(459,459,3,'I21_12_04.png','kep',0),(460,460,3,'I21_12_05.png','kep',0),(461,461,3,'I22_12_01.png','kep',0),(462,462,3,'I22_12_02.png','kep',0),(463,463,3,'I22_12_03.png','kep',0),(464,464,3,'I22_12_04.png','kep',0),(465,465,3,'I22_12_05.png','kep',0),(466,466,3,'I23_12_01.png','kep',0),(467,467,3,'I23_12_02.png','kep',0),(468,468,3,'I23_12_03.png','kep',0),(469,469,3,'I23_12_04.png','kep',0),(470,470,3,'I23_12_05.png','kep',0),(471,471,3,'I24_12_01.png','kep',0),(472,472,3,'I24_12_02.png','kep',0),(473,473,3,'I24_12_03.png','kep',0),(474,474,3,'I24_12_04.png','kep',0),(475,475,3,'I24_12_05.png','kep',0),(476,476,3,'I25_12_01.png','kep',0),(477,477,3,'I25_12_02.png','kep',0),(478,478,3,'I25_12_03.png','kep',0),(479,479,3,'I25_12_04.png','kep',0),(480,480,3,'I25_12_05.png','kep',0),(481,481,3,'I26_12_01.png','kep',0),(482,482,3,'I26_12_02.png','kep',0),(483,483,3,'I26_12_03.png','kep',0),(484,484,3,'I26_12_04.png','kep',0),(485,485,3,'I26_12_05.png','kep',0),(486,486,3,'I27_12_01.png','kep',0),(487,487,3,'I27_12_02.png','kep',0),(488,488,3,'I27_12_03.png','kep',0),(489,489,3,'I27_12_04.png','kep',0),(490,490,3,'I27_12_05.png','kep',0),(491,491,3,'I32_12_01.png','kep',0),(492,492,3,'I32_12_02.png','kep',0),(493,493,3,'I32_12_03.png','kep',0),(494,494,3,'I32_12_04.png','kep',0),(495,495,3,'I32_12_05.png','kep',0),(496,496,3,'I33_12_01.png','kep',0),(497,497,3,'I33_12_02.png','kep',0),(498,498,3,'I33_12_03.png','kep',0),(499,499,3,'I33_12_04.png','kep',0),(500,500,3,'I33_12_05.png','kep',0),(501,501,3,'I34_12_01.png','kep',0),(502,502,3,'I34_12_02.png','kep',0),(503,503,3,'I34_12_03.png','kep',0),(504,504,3,'I34_12_04.png','kep',0),(505,505,3,'I34_12_05.png','kep',0),(506,506,3,'I35_12_01.png','kep',0),(507,507,3,'I35_12_02.png','kep',0),(508,508,3,'I35_12_03.png','kep',0),(509,509,3,'I35_12_04.png','kep',0),(510,510,3,'I35_12_05.png','kep',0),(511,511,3,'I43_12_01.png','kep',0),(512,512,3,'I43_12_02.png','kep',0),(513,513,3,'I43_12_03.png','kep',0),(514,514,3,'I43_12_04.png','kep',0),(515,515,3,'I43_12_05.png','kep',0),(516,516,3,'I44_12_01.png','kep',0),(517,517,3,'I44_12_02.png','kep',0),(518,518,3,'I44_12_03.png','kep',0),(519,519,3,'I44_12_04.png','kep',0),(520,520,3,'I44_12_05.png','kep',0),(521,521,3,'I45_12_01.png','kep',0),(522,522,3,'I45_12_02.png','kep',0),(523,523,3,'I45_12_03.png','kep',0),(524,524,3,'I45_12_04.png','kep',0),(525,525,3,'I45_12_05.png','kep',0),(526,526,3,'I55_12_01.png','kep',0),(527,527,3,'I55_12_02.png','kep',0),(528,528,3,'I55_12_03.png','kep',0),(529,529,3,'I55_12_04.png','kep',0),(530,530,3,'I55_12_05.png','kep',0),(531,531,3,'I56_12_01.png','kep',0),(532,532,3,'I56_12_02.png','kep',0),(533,533,3,'I56_12_03.png','kep',0),(534,534,3,'I56_12_04.png','kep',0),(535,535,3,'I56_12_05.png','kep',0),(536,536,3,'I57_12_01.png','kep',0),(537,537,3,'I57_12_02.png','kep',0),(538,538,3,'I57_12_03.png','kep',0),(539,539,3,'I57_12_04.png','kep',0),(540,540,3,'I57_12_05.png','kep',0),(541,541,3,'I58_12_01.png','kep',0),(542,542,3,'I58_12_02.png','kep',0),(543,543,3,'I58_12_03.png','kep',0),(544,544,3,'I58_12_04.png','kep',0),(545,545,3,'I58_12_05.png','kep',0),(546,546,3,'I59_12_01.png','kep',0),(547,547,3,'I59_12_02.png','kep',0),(548,548,3,'I59_12_03.png','kep',0),(549,549,3,'I59_12_04.png','kep',0),(550,550,3,'I59_12_05.png','kep',0),(551,551,3,'I60_12_01.png','kep',0),(552,552,3,'I60_12_02.png','kep',0),(553,553,3,'I60_12_03.png','kep',0),(554,554,3,'I60_12_04.png','kep',0),(555,555,3,'I60_12_05.png','kep',0),(556,556,3,'I61_12_01.png','kep',0),(557,557,3,'I61_12_02.png','kep',0),(558,558,3,'I61_12_03.png','kep',0),(559,559,3,'I61_12_04.png','kep',0),(560,560,3,'I61_12_05.png','kep',0),(561,561,3,'I62_12_01.png','kep',0),(562,562,3,'I62_12_02.png','kep',0),(563,563,3,'I62_12_03.png','kep',0),(564,564,3,'I62_12_04.png','kep',0),(565,565,3,'I62_12_05.png','kep',0),(566,566,3,'I63_12_01.png','kep',0),(567,567,3,'I63_12_02.png','kep',0),(568,568,3,'I63_12_03.png','kep',0),(569,569,3,'I63_12_04.png','kep',0),(570,570,3,'I63_12_05.png','kep',0),(571,571,3,'I65_12_01.png','kep',0),(572,572,3,'I65_12_02.png','kep',0),(573,573,3,'I65_12_03.png','kep',0),(574,574,3,'I65_12_04.png','kep',0),(575,575,3,'I65_12_05.png','kep',0),(576,576,3,'I66_12_01.png','kep',0),(577,577,3,'I66_12_02.png','kep',0),(578,578,3,'I66_12_03.png','kep',0),(579,579,3,'I66_12_04.png','kep',0),(580,580,3,'I66_12_05.png','kep',0),(581,581,3,'I67_12_01.png','kep',0),(582,582,3,'I67_12_02.png','kep',0),(583,583,3,'I67_12_03.png','kep',0),(584,584,3,'I67_12_04.png','kep',0),(585,585,3,'I67_12_05.png','kep',0),(586,586,3,'I68_12_01.png','kep',0),(587,587,3,'I68_12_02.png','kep',0),(588,588,3,'I68_12_03.png','kep',0),(589,589,3,'I68_12_04.png','kep',0),(590,590,3,'I68_12_05.png','kep',0),(591,591,3,'I69_12_01.png','kep',0),(592,592,3,'I69_12_02.png','kep',0),(593,593,3,'I69_12_03.png','kep',0),(594,594,3,'I69_12_04.png','kep',0),(595,595,3,'I69_12_05.png','kep',0),(596,596,3,'I71_12_01.png','kep',0),(597,597,3,'I71_12_02.png','kep',0),(598,598,3,'I71_12_03.png','kep',0),(599,599,3,'I71_12_04.png','kep',0),(600,600,3,'I71_12_05.png','kep',0);
/*!40000 ALTER TABLE `fajlok` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `felhasznalok`
--

DROP TABLE IF EXISTS `felhasznalok`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `felhasznalok` (
  `my_row_id` bigint unsigned NOT NULL AUTO_INCREMENT /*!80023 INVISIBLE */,
  `id` int NOT NULL,
  `felhasznalonev` varchar(50) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `jelszo` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `regisztracio_datum` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `admin` tinyint(1) DEFAULT '0',
  `letiltva` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`my_row_id`),
  UNIQUE KEY `felhasznalonev` (`felhasznalonev`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `felhasznalok`
--

LOCK TABLES `felhasznalok` WRITE;
/*!40000 ALTER TABLE `felhasznalok` DISABLE KEYS */;
INSERT INTO `felhasznalok` (`my_row_id`, `id`, `felhasznalonev`, `email`, `jelszo`, `regisztracio_datum`, `admin`, `letiltva`) VALUES (1,1,'admin','admin@gmail.com','$2y$10$l6xtuPGJ36tSpLYL2Iwyeen2fijv11iS44xd8NU6317JE3QHIbKdi','2025-02-27 22:59:43',1,0),(2,2,'Anna1','Anna1@gmail.com','$2y$10$sHFP3csPnxb6Z13BY5.8ceU3nCUGXOM2S1lqhpKMB9PfxbAz0P8L2','2025-03-04 20:23:47',0,0);
/*!40000 ALTER TABLE `felhasznalok` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kerdesek`
--

DROP TABLE IF EXISTS `kerdesek`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kerdesek` (
  `my_row_id` bigint unsigned NOT NULL AUTO_INCREMENT /*!80023 INVISIBLE */,
  `id` int NOT NULL,
  `projekt_id` int NOT NULL,
  `kerdes` text COLLATE utf8mb4_hungarian_ci NOT NULL,
  `valasz_tipus` enum('text','int','enum') COLLATE utf8mb4_hungarian_ci NOT NULL,
  `lehetseges_valaszok` text COLLATE utf8mb4_hungarian_ci,
  `required` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`my_row_id`),
  KEY `projektek_id` (`projekt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kerdesek`
--

LOCK TABLES `kerdesek` WRITE;
/*!40000 ALTER TABLE `kerdesek` DISABLE KEYS */;
INSERT INTO `kerdesek` (`my_row_id`, `id`, `projekt_id`, `kerdes`, `valasz_tipus`, `lehetseges_valaszok`, `required`) VALUES (1,1,1,'Tisztelt Kitöltő!  Ezúton tájékoztatjuk, hogy a szakdolgozati kutatás keretében gyűjtött adatokat és válaszokat titkosított formában kezeljük.  Az adatokat kizárólag tudományos célokra, a szakdolgozat elkészítéséhez használjuk fel.  Adatkezelés időtartama: A megadott információkat legfeljebb hat hónapig tároljuk, ezt követően azokat véglegesen és visszaállíthatatlanul töröljük.  Adatbiztonság: Minden megadott adat titkosítva kerül tárolásra, és harmadik fél számára nem hozzáférhető.  Az adatkezelés során a vonatkozó adatvédelmi előírásokat maradéktalanul betartjuk.  Köszönjük, hogy részvételével hozzájárul kutatásunk sikeréhez!','enum','Elfogadom, Nem fogadom el',1),(2,2,1,'Neme:','enum','Nő,Férfi',1),(3,3,1,'Végzettsége','enum','8 általános, Érettségi, Diploma',1),(4,4,1,'Életkora:','int','',1),(5,5,1,'Ha szeretne a kutatás lezárta után értesítést kapni az eredményekről, kérem adja meg email címét (opcionális)','text','',0),(6,6,2,'Tisztelt Kitöltő!  Ezúton tájékoztatjuk, hogy a szakdolgozati kutatás keretében gyűjtött adatokat és válaszokat titkosított formában kezeljük.  Az adatokat kizárólag tudományos célokra, a szakdolgozat elkészítéséhez használjuk fel.  Adatkezelés időtartama: A megadott információkat legfeljebb hat hónapig tároljuk, ezt követően azokat véglegesen és visszaállíthatatlanul töröljük.  Adatbiztonság: Minden megadott adat titkosítva kerül tárolásra, és harmadik fél számára nem hozzáférhető.  Az adatkezelés során a vonatkozó adatvédelmi előírásokat maradéktalanul betartjuk.  Köszönjük, hogy részvételével hozzájárul kutatásunk sikeréhez!','enum','Elfogadom, Nem fogadom el',1),(7,7,2,'Neme:','enum','Nő, Férfi',1),(8,8,2,'Végzettsége','enum','8 általános, Érettségi, Diploma',1),(9,9,2,'Életkora:','int','',1),(10,10,2,'Ha szeretne a kutatás lezárta után értesítést kapni az eredményekről, kérem adja meg email címét (opcionális)','text','',0),(11,11,3,'Tisztelt Kitöltő!  Ezúton tájékoztatjuk, hogy a szakdolgozati kutatás keretében gyűjtött adatokat és válaszokat titkosított formában kezeljük.  Az adatokat kizárólag tudományos célokra, a szakdolgozat elkészítéséhez használjuk fel.  Adatkezelés időtartama: A megadott információkat legfeljebb hat hónapig tároljuk, ezt követően azokat véglegesen és visszaállíthatatlanul töröljük.  Adatbiztonság: Minden megadott adat titkosítva kerül tárolásra, és harmadik fél számára nem hozzáférhető.  Az adatkezelés során a vonatkozó adatvédelmi előírásokat maradéktalanul betartjuk.  Köszönjük, hogy részvételével hozzájárul kutatásunk sikeréhez!','enum','Elfogadom, Nem fogadom el',0),(12,12,3,'Neme:','enum','Nő, Férfi',0),(13,13,3,'Végzettsége','enum','8 általános, Érettségi, Diploma',0),(14,14,3,'Életkora:','int','',0),(15,15,3,'Ha szeretne a kutatás lezárta után értesítést kapni az eredményekről, kérem adja meg email címét (opcionális)','text','',0);
/*!40000 ALTER TABLE `kerdesek` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kerdesekre_valasz`
--

DROP TABLE IF EXISTS `kerdesekre_valasz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kerdesekre_valasz` (
  `my_row_id` bigint unsigned NOT NULL AUTO_INCREMENT /*!80023 INVISIBLE */,
  `id` int NOT NULL,
  `projekt_id` int NOT NULL,
  `kerdesek_id` int NOT NULL,
  `valasz` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `kitolto_id` int NOT NULL,
  PRIMARY KEY (`my_row_id`),
  KEY `projekt_id` (`projekt_id`),
  KEY `fk_kerdesek` (`kerdesek_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kerdesekre_valasz`
--

LOCK TABLES `kerdesekre_valasz` WRITE;
/*!40000 ALTER TABLE `kerdesekre_valasz` DISABLE KEYS */;
/*!40000 ALTER TABLE `kerdesekre_valasz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kitoltok`
--

DROP TABLE IF EXISTS `kitoltok`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kitoltok` (
  `my_row_id` bigint unsigned NOT NULL AUTO_INCREMENT /*!80023 INVISIBLE */,
  `id` int NOT NULL,
  `projekt_id` int DEFAULT NULL,
  PRIMARY KEY (`my_row_id`),
  KEY `kitoltok_ibfk_2` (`projekt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kitoltok`
--

LOCK TABLES `kitoltok` WRITE;
/*!40000 ALTER TABLE `kitoltok` DISABLE KEYS */;
/*!40000 ALTER TABLE `kitoltok` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projektek`
--

DROP TABLE IF EXISTS `projektek`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projektek` (
  `my_row_id` bigint unsigned NOT NULL AUTO_INCREMENT /*!80023 INVISIBLE */,
  `id` int NOT NULL,
  `nev` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `fokep` varchar(255) COLLATE utf8mb4_hungarian_ci NOT NULL,
  `leiras` text COLLATE utf8mb4_hungarian_ci NOT NULL,
  `felhasznalok_id` int NOT NULL,
  `eddigi_kitoltesek` int DEFAULT '0',
  `kitoltesi_cel` int DEFAULT '200',
  PRIMARY KEY (`my_row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projektek`
--

LOCK TABLES `projektek` WRITE;
/*!40000 ALTER TABLE `projektek` DISABLE KEYS */;
INSERT INTO `projektek` (`my_row_id`, `id`, `nev`, `fokep`, `leiras`, `felhasznalok_id`, `eddigi_kitoltesek`, `kitoltesi_cel`) VALUES (1,1,'Elhomályosítás','I01_02_05.png','A következő képek egy 5 fokozatú skálán elhomályosított változatok, amelyek különböző mértékben csökkentett részletességgel jelennek meg.\r\nAz elhomályosítás célja lehet:\r\n    Képminőség-értékelés vizsgálata\r\n    Emberi észlelés kutatása különböző minőségű képeken',2,0,100),(2,2,'Pixelizáció','I02_10_05.png','A következő képek egy 5 fokozatú skálán pixelizált változatok, ahol a kép részleteit eltérő mértékben nagyobb, négyzetes blokkokra bontottuk.\r\nA pixelizáció célja lehet:\r\n       Képminőség-értékelés vizsgálata\r\n       Emberi észlelés kutatása különböző minőségű képeken',2,0,100),(3,3,'Zaj','I10_12_05.png','A következő képek egy 5 fokozatú skálán zajjal módosított változatok, ahol a képhez véletlenszerű színes pontok kerültek hozzáadásra.\r\nA zaj hozzáadása célja lehet:\r\n     Képminőség-értékelés vizsgálata\r\n     Emberi észlelés kutatása különböző zajszinteken',2,0,100);
/*!40000 ALTER TABLE `projektek` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-07 18:49:53
