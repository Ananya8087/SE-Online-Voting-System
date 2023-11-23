CREATE DATABASE  IF NOT EXISTS `evoting-3` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `evoting-3`;
-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: evoting-3
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `AddressID` int NOT NULL AUTO_INCREMENT,
  `District` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Municipality` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `WardNo` int NOT NULL,
  `Province` int NOT NULL,
  PRIMARY KEY (`AddressID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'Kathmandu','Chandragiri',5,3),(2,'Lalitpur','Mahalaxmi',9,3),(3,'Bhaktapur','SanoThimi',4,3),(4,'Taplejung','Taplejung',31,1),(5,'Pachthar','Phidim',22,1),(6,'Ilam','Ilam',9,1),(7,'Bara','Kalaiya',19,2),(8,'Dhanusa','Janakpur',12,2),(9,'Mahottari','Jaleshwar',9,2),(10,'Baglung','Baglung',35,4),(11,'Gorkha','Gorkha',4,4),(12,'Kaski','Pokhara',9,4),(13,'Palpa','Tansen',8,5),(14,'Banke','Nepalganj',25,5),(15,'Bardiya','Gulariya',6,5),(16,'Dailekh','Narayan',14,6),(17,'Dolpa','Dunai',21,6),(18,'Humla','Simikot',16,6),(19,'Jajarkot','Khalanga',15,6),(20,'Achham','Mangalsen',20,7),(21,'Salyan','Salyan',17,6),(22,'Bajhang','Jayaprithvi',9,7),(23,'Bajura','Martadi',10,7),(24,'Dadeldhura','Amargadhi',24,7),(25,'Makwanpur','Hetauda',9,3),(26,'bhaktapur','chandragiri',7,4),(27,'kathmandu','chandragiri',5,2),(28,'kathmandu','chandragiri',5,1),(29,'kathmandu','mahalaxmi',7,3),(30,'kathmandu','chandragiri',7,3);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adrress`
--

DROP TABLE IF EXISTS `adrress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adrress` (
  `AddressID` int NOT NULL AUTO_INCREMENT,
  `District` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Municiplaity` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `WardNo` int NOT NULL,
  PRIMARY KEY (`AddressID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adrress`
--

LOCK TABLES `adrress` WRITE;
/*!40000 ALTER TABLE `adrress` DISABLE KEYS */;
/*!40000 ALTER TABLE `adrress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_identity`
--

DROP TABLE IF EXISTS `candidate_identity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate_identity` (
  `CandidateID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `MiddleName` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LastName` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `DOB` date NOT NULL,
  `Age` int NOT NULL,
  `Email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PhoneNo` int NOT NULL,
  `Sex` tinyint(1) NOT NULL,
  `CitizenshipID` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `EducationID` int DEFAULT NULL,
  `AddressID` int NOT NULL,
  `PartyID` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`CandidateID`),
  UNIQUE KEY `PhoneNo_UNIQUE` (`PhoneNo`),
  UNIQUE KEY `CitizenshipID_UNIQUE` (`CitizenshipID`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  KEY `Address_idx` (`AddressID`),
  KEY `Education_idx` (`EducationID`),
  CONSTRAINT `AddressID` FOREIGN KEY (`AddressID`) REFERENCES `address` (`AddressID`),
  CONSTRAINT `EducationID` FOREIGN KEY (`EducationID`) REFERENCES `education` (`EducationID`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_identity`
--

LOCK TABLES `candidate_identity` WRITE;
/*!40000 ALTER TABLE `candidate_identity` DISABLE KEYS */;
INSERT INTO `candidate_identity` VALUES (1,'X','Y','Z','2000-12-23',21,'XYZ@gmail.com',98,0,'12-32-5555',1,1,'A'),(2,'A',NULL,'D','0000-00-00',50,'awd@gmail.com',95,0,'095-01-6620',2,2,'R'),(3,'S','E','F','0000-00-00',50,'sf@gmail.com',45,0,'069-86-0149',1,3,'T'),(4,'D',NULL,'G','0000-00-00',40,'drg@gmail.com',47,0,'016-37-8472',4,4,'Y'),(5,'F','T','S','0000-00-00',57,'fts@gmail.com',51,0,'013-49-0925',3,5,'E'),(6,'G','Y','F','0000-00-00',42,'gyf@yahoo.com',29,1,'032-55-2591',1,6,'W'),(7,'H',NULL,'H','0000-00-00',64,'hh@gmail.com',26,0,'086-77-5716',6,7,'D'),(8,'J','H','S','0000-00-00',35,'jhs@gmail.com',43,0,'059-70-6894',1,8,'F'),(9,'K','F','F','0000-00-00',31,'kff@yahoo.com',30,1,'096-99-2996',1,9,'G'),(10,'L','D','H','0000-00-00',52,'ldh@gmail.com',34,1,'026-09-3561',4,10,'B'),(11,'O','S','F','0000-00-00',49,'osf@gmail.com',42,0,'055-55-9342',1,11,'N'),(12,'I','V','G','0000-00-00',43,'ivg@yahoo.com',37,0,'096-38-9234',2,12,'C'),(13,'U',NULL,'H','0000-00-00',40,'uh@gmail.com',73,0,'011-53-3764',1,13,'S'),(14,'Y',NULL,'J','0000-00-00',63,'yj@gmail.com',70,1,'096-37-9042',1,14,'A'),(15,'T',NULL,'K','0000-00-00',68,'tk@yahoo.com',39,0,'048-11-6003',3,15,'X'),(16,'R','D','W','0000-00-00',54,'rdw@gmail.com',25,0,'013-11-0990',1,16,'H'),(17,'E',NULL,'E','0000-00-00',22,'ee@yahoo.com',60,0,'091-12-9782',6,17,'K'),(18,'W','E','T','0000-00-00',27,'wet@yahoo.com',72,1,'030-39-9438',1,18,'E'),(19,'Q',NULL,'Y','1994-11-20',26,'qwy@gmail.com',53,1,'093-98-0274',1,19,'W'),(20,'P','T','U','1982-08-23',38,'ptu@gmail.com',91,1,'086-10-8224',4,20,'O'),(21,'M','V','S','1984-03-28',37,'mvs@yahoo.com',80,0,'064-80-9922',1,21,'P'),(22,'N',NULL,'D','1992-05-19',29,'nsd@gmail.com',50,1,'064-95-8495',1,22,'L'),(23,'B',NULL,'G','1989-10-11',31,'bgg@gmail.com',44,1,'047-72-6461',2,23,'G'),(24,'V','N','F','1981-07-08',40,'vnf@yahoo.com',20,1,'047-20-7345',3,24,'D'),(25,'C','M','J','1956-07-17',65,'cmj@gmail.com',11,0,'097-94-2642',1,25,'S');
/*!40000 ALTER TABLE `candidate_identity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `education`
--

DROP TABLE IF EXISTS `education`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `education` (
  `EducationID` int NOT NULL AUTO_INCREMENT,
  `DegreeLevel` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`EducationID`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `education`
--

LOCK TABLES `education` WRITE;
/*!40000 ALTER TABLE `education` DISABLE KEYS */;
INSERT INTO `education` VALUES (1,'High School'),(2,'Bachelor\'s'),(3,'Master\'s'),(4,'PHD'),(6,'SLC');
/*!40000 ALTER TABLE `education` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login` (
  `LoginID` int NOT NULL AUTO_INCREMENT,
  `UserName` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Password` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserType` int NOT NULL,
  `Email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`LoginID`),
  UNIQUE KEY `UserName_UNIQUE` (`UserName`),
  UNIQUE KEY `Email_UNIQUE` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES (12,'AWD','712',2,'awd@gmail.com'),(13,'SF','673',2,'sf@gmail.com'),(14,'DRG','721',2,'drg@gmail.com'),(15,'FTS','583',2,'fts@gmail.com'),(16,'GYF','276',2,'gyf@yahoo.com'),(17,'HH','698',2,'hh@gmail.com'),(18,'JHS','611',2,'jhs@gmail.com'),(19,'KFF','243',2,'kff@yahoo.com'),(20,'LDH','302',2,'ldh@gmail.com'),(21,'OSF','540',2,'osf@gmail.com'),(22,'IVG','599',2,'ivg@yahoo.com'),(23,'UH','574',2,'uh@gmail.com'),(24,'YJ','466',2,'yj@gmail.com'),(25,'TK','261',2,'tk@yahoo.com'),(26,'RDW','570',2,'rdw@gmail.com'),(27,'EE','458',2,'ee@yahoo.com'),(28,'WET','163',2,'wet@yahoo.com'),(29,'QWY','785',2,'qwy@gmail.com'),(30,'PTU','710',2,'ptu@gmail.com'),(31,'MVS','160',2,'mvs@yahoo.com'),(32,'ND','202',2,'nd@gmail.com'),(33,'BG','694',2,'bg@gmail.com'),(34,'VNF','283',2,'vnf@yahoo.com'),(35,'CMJ','352',2,''),(36,'VN','767',1,'vnf@gmail.com'),(37,'MS','296',1,'ms@gmail.com'),(38,'EAE','352',1,'eae@gmail.com'),(39,'SEF','636',1,'sef@yahoo.com'),(40,'KF','451',1,'kf@yahoo.com'),(41,'JKS','497',1,'jks@gmail.com'),(42,'GF','373',1,'gf@yahoo.com'),(43,'LH','568',1,'lh@gmail.com'),(44,'HGH','426',1,'hgh@gmail.com'),(45,'OF','739',1,'of@gmail.com'),(46,'AD','553',1,'ad@gmail.com'),(47,'RW','350',1,'rw@gmail.com'),(48,'PU','705',1,'pu@gmail.com'),(49,'DG','172',1,'dg@gmail.com'),(50,'CM','728',1,'cmj@gmail.com'),(51,'WT','166',1,'wt@yahoo.com'),(52,'UBH','508',1,'ubh@gmail.com'),(53,'YNJ','717',1,'ynj@gmail.com'),(54,'IG','131',1,'ig@yahoo.com'),(55,'QY','562',1,'qy@gmail.com'),(56,'FT','567',1,'ft@gmail.com'),(57,'NSD','180',1,'nsd@gmail.com'),(58,'THK','182',1,'thk@yahoo.com'),(59,'BGG','678',1,'bgg@gmail.com'),(60,'OO','559',1,'oo@gmail.com'),(61,'ada@302','12345',1,'ada@gmail.com');
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sheet1`
--

DROP TABLE IF EXISTS `sheet1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sheet1` (
  `EducationID` int DEFAULT NULL,
  `DegreeLevel` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sheet1`
--

LOCK TABLES `sheet1` WRITE;
/*!40000 ALTER TABLE `sheet1` DISABLE KEYS */;
INSERT INTO `sheet1` VALUES (5,'Bachelor\'s'),(6,'SLC'),(7,'SLC'),(8,'Master\'s'),(9,'Master\'s'),(10,'PHD'),(11,'PHD'),(12,'High School'),(13,'SLC'),(14,'High School'),(15,'High School'),(16,'High School'),(17,'PHD'),(18,'Bachelor\'s'),(19,'Master\'s'),(20,'Bachelor\'s'),(21,'PHD'),(22,'Master\'s'),(23,'SLC'),(24,'Bachelor\'s'),(25,'SLC'),(5,'Bachelor\'s'),(6,'SLC'),(7,'SLC'),(8,'Master\'s'),(9,'Master\'s'),(10,'PHD'),(11,'PHD'),(12,'High School'),(13,'SLC'),(14,'High School'),(15,'High School'),(16,'High School'),(17,'PHD'),(18,'Bachelor\'s'),(19,'Master\'s'),(20,'Bachelor\'s'),(21,'PHD'),(22,'Master\'s'),(23,'SLC'),(24,'Bachelor\'s'),(25,'SLC');
/*!40000 ALTER TABLE `sheet1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usertype`
--

DROP TABLE IF EXISTS `usertype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usertype` (
  `UserTypeID` int NOT NULL AUTO_INCREMENT,
  `UserType` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`UserTypeID`),
  UNIQUE KEY `UserTypeID_UNIQUE` (`UserTypeID`),
  UNIQUE KEY `UserType_UNIQUE` (`UserType`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usertype`
--

LOCK TABLES `usertype` WRITE;
/*!40000 ALTER TABLE `usertype` DISABLE KEYS */;
INSERT INTO `usertype` VALUES (2,'Candidate'),(1,'Voter');
/*!40000 ALTER TABLE `usertype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote`
--

DROP TABLE IF EXISTS `vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vote` (
  `VoteID` int NOT NULL AUTO_INCREMENT,
  `VoterID` int NOT NULL,
  `CandidateID` int NOT NULL,
  `VoteTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`VoteID`),
  UNIQUE KEY `VoterID_UNIQUE` (`VoterID`),
  KEY `CandidateID_idx` (`CandidateID`),
  CONSTRAINT `CandidateID` FOREIGN KEY (`CandidateID`) REFERENCES `candidate_identity` (`CandidateID`),
  CONSTRAINT `VoterID` FOREIGN KEY (`VoterID`) REFERENCES `voter_identity` (`VoterID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote`
--

LOCK TABLES `vote` WRITE;
/*!40000 ALTER TABLE `vote` DISABLE KEYS */;
INSERT INTO `vote` VALUES (7,19,23,'2021-08-21 08:39:14'),(9,22,2,'2021-08-21 08:42:49'),(12,10,14,'2021-08-21 14:51:27'),(15,24,3,'2021-08-23 13:52:53');
/*!40000 ALTER TABLE `vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voter_identity`
--

DROP TABLE IF EXISTS `voter_identity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voter_identity` (
  `VoterID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `MiddleName` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LastName` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `DOB` date NOT NULL,
  `Age` int DEFAULT NULL,
  `Email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `PhoneNo` int NOT NULL,
  `Sex` tinyint(1) NOT NULL,
  `CitizenshipNo` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `AddressID` int NOT NULL,
  PRIMARY KEY (`VoterID`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  UNIQUE KEY `CitizenshipNo_UNIQUE` (`CitizenshipNo`),
  UNIQUE KEY `PhoneNo._UNIQUE` (`PhoneNo`),
  KEY `Address_idx` (`AddressID`),
  CONSTRAINT `Address` FOREIGN KEY (`AddressID`) REFERENCES `address` (`AddressID`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voter_identity`
--

LOCK TABLES `voter_identity` WRITE;
/*!40000 ALTER TABLE `voter_identity` DISABLE KEYS */;
INSERT INTO `voter_identity` VALUES (1,'V','N','F','1986-07-29',35,'vnf@gmail.com',20,1,'029-30-9654',24),(2,'M','V','S','1975-04-05',46,'ms@gmail.com',80,1,'081-54-0496',21),(3,'E',NULL,'E','1972-01-03',49,'eae@gmail.com',99,0,'019-29-8365',17),(4,'S','E','F','1968-08-13',52,'sef@yahoo.com',87,0,'038-96-4608',3),(5,'K','F','F','1994-10-03',26,'kf@yahoo.com',21,0,'081-43-3593',9),(6,'J','H','S','1995-12-06',25,'jks@gmail.com',32,1,'028-55-4529',8),(7,'G','Y','F','1997-06-04',24,'gf@yahoo.com',54,1,'090-05-3116',6),(8,'L','D','H','1965-08-18',55,'lh@gmail.com',37,1,'062-41-9732',10),(9,'H',NULL,'H','1981-03-29',40,'hgh@gmail.com',43,1,'054-33-9873',7),(10,'O','S','F','1983-05-03',38,'of@gmail.com',81,0,'086-76-5595',11),(11,'A',NULL,'D','1969-11-23',51,'ad@gmail.com',97,1,'018-95-9858',2),(12,'R','D','W','1956-08-23',64,'rw@gmail.com',41,0,'011-28-9503',16),(13,'P','T','U','1987-08-06',34,'pu@gmail.com',91,0,'055-42-4848',20),(14,'D',NULL,'G','1984-06-16',37,'dg@gmail.com',76,1,'054-66-7328',4),(15,'C','M','J','1992-12-27',28,'cmj@gmail.com',11,0,'043-34-6660',25),(16,'W','E','T','1965-09-15',55,'wt@yahoo.com',55,1,'060-79-6799',18),(17,'U',NULL,'H','1969-12-14',51,'ubh@gmail.com',52,0,'056-04-9112',13),(18,'Y',NULL,'J','1967-04-30',54,'ynj@gmail.com',66,1,'075-81-3726',14),(19,'I','V','G','1964-10-12',57,'ig@gmail.com',93,0,'083-03-0736',30),(20,'Q',NULL,'Y','1956-11-05',64,'qy@gmail.com',53,1,'081-73-6222',19),(21,'F','T','S','2000-11-30',20,'ft@gmail.com',67,1,'086-99-9450',5),(22,'N',NULL,'D','1968-01-21',53,'nsd@gmail.com',50,0,'047-60-0785',22),(23,'T',NULL,'K','1967-06-05',54,'thk@yahoo.com',46,1,'097-84-6544',15),(24,'B',NULL,'G','1990-03-11',31,'bgg@gmail.com',44,1,'082-55-7765',23),(25,'O',NULL,'O','1986-07-04',35,'oo@gmail.com',22,0,'063-10-6299',23),(26,'ada','dafa','gfdsgf','2008-06-18',13,'ada@gmail.com',789641213,0,'12-78-895',27);
/*!40000 ALTER TABLE `voter_identity` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-23 21:12:28
