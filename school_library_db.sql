CREATE DATABASE  IF NOT EXISTS `school_library` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `school_library`;
-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: school_library
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `book_categories`
--

DROP TABLE IF EXISTS `book_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_categories`
--

LOCK TABLES `book_categories` WRITE;
/*!40000 ALTER TABLE `book_categories` DISABLE KEYS */;
INSERT INTO `book_categories` VALUES (1,'Action and Adventure'),(2,'Classics'),(3,'Detective and Mystery'),(4,'Fantasy'),(5,'Historical Fiction'),(6,'Horror'),(7,'Literary Fiction'),(8,'Romance'),(9,'Science Fiction (Sci-Fi)'),(10,'Short Stories'),(11,'Suspense and Thrillers'),(12,'Cookbooks'),(13,'Essays'),(14,'History'),(15,'Memoir'),(16,'Poetry'),(17,'Self-Help'),(18,'True Crime'),(19,'Miscellaneous');
/*!40000 ALTER TABLE `book_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bk_title` varchar(255) NOT NULL,
  `bk_desc` text,
  `bk_cover` text,
  `author` varchar(255) DEFAULT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `category_id` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'Sea of Tranquility','In this captivating tale of imagination and ambition, a seemingly disparate array of people come into contact with a time traveller who must resist the pull to change the past and the future. The cast includes a British exile on the West coast of Canada in the early 1900s; the author of a bestselling novel about a fictional pandemic who embarks on a galaxy-spanning book tour during the outbreak of an actual pandemic; a resident of a moon colony almost 300 years in the future; and a lonely girl who films an old-growth forest and experiences a disruption in the recording. Blurring the lines between reality and fantasy, Emily St. John Mandel’s dazzling story follows these engrossing characters across space and time as their lives ultimately intersect.','https://books.google.com.jm/books/publisher/content?id=Knc4EAAAQBAJ&printsec=frontcover&img=1&zoom=1&imgtk=AFLRE70KBQgNOTyGZUcWCFA366kK3i3lai5oQCuqJcIHy-x-qcwmaG1ExqKTG3LW-ve0F9cjmOd7e0At-KR3xkM8X4mkryF5uM1WXSQPuKE4nDdol3w4s6qj1GQZbxSP9unNscW2j53v','Emily St. John Mandel',9,1,'2022-05-24 14:05:04','2022-05-25 14:03:04'),(2,'Architectural Shades and Shadows',NULL,NULL,'Edgar Greer Shelton',3,19,'2022-05-24 14:30:50','2022-05-25 14:03:02');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrow_history`
--

DROP TABLE IF EXISTS `borrow_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrow_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `book_id` int NOT NULL,
  `is_approved` tinyint(1) NOT NULL DEFAULT '0',
  `is_returned` tinyint NOT NULL DEFAULT '0',
  `borrow_dt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `return_dt` date NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `book_id` (`book_id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `book_id` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow_history`
--

LOCK TABLES `borrow_history` WRITE;
/*!40000 ALTER TABLE `borrow_history` DISABLE KEYS */;
INSERT INTO `borrow_history` VALUES (22,1,2,1,1,'2022-05-25 09:36:38','2022-06-08','2022-05-25 09:36:38','2022-05-25 10:53:05'),(23,1,1,1,1,'2022-05-25 10:01:00','2022-06-08','2022-05-25 10:01:00','2022-05-25 11:15:57'),(24,1,1,1,1,'2022-05-25 10:25:10','2022-06-08','2022-05-25 10:25:10','2022-05-25 10:52:08'),(25,1,2,1,1,'2022-05-25 10:32:38','2022-06-08','2022-05-25 10:32:38','2022-05-25 11:15:17'),(26,1,2,1,1,'2022-05-25 11:10:35','2022-06-08','2022-05-25 11:10:35','2022-05-25 11:15:17'),(27,1,1,1,1,'2022-05-25 11:27:14','2022-06-08','2022-05-25 11:27:14','2022-05-25 14:00:07'),(28,1,2,1,1,'2022-05-25 11:27:31','2022-06-08','2022-05-25 11:27:31','2022-05-25 13:53:08'),(29,1,1,1,1,'2022-05-25 12:40:36','2022-06-08','2022-05-25 12:40:36','2022-05-25 14:00:07'),(30,1,1,1,1,'2022-05-25 14:00:14','2022-06-08','2022-05-25 14:00:14','2022-05-25 14:03:04'),(31,1,2,1,1,'2022-05-25 14:01:19','2022-06-08','2022-05-25 14:01:19','2022-05-25 14:03:02');
/*!40000 ALTER TABLE `borrow_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin'),(2,'user');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_nm` varchar(500) DEFAULT NULL,
  `last_nm` varchar(500) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(500) NOT NULL,
  `password` varchar(80) NOT NULL,
  `role_id` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,NULL,'roshane','roshane@mail.com','$2b$10$M007H3HDsdiDZYYbAqt5CenPVpDtUvs8Ws5sxrXN8NFKObkSDjS12','1','2022-05-24 09:28:13','2022-05-24 09:28:13'),(2,'Nigel','Johnson','nigel','nigel@mail.com','$2b$10$M007H3HDsdiDZYYbAqt5CenPVpDtUvs8Ws5sxrXN8NFKObkSDjS12','2','2022-05-24 09:28:53','2022-05-24 09:28:53');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-25 14:05:36
