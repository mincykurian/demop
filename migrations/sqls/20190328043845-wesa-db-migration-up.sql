CREATE DATABASE  IF NOT EXISTS `wesa` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `wesa`;
-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: wesa
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.18.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `boards`
--

DROP TABLE IF EXISTS `boards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `created_at` varchar(45) DEFAULT NULL,
  `updated_at` varchar(45) DEFAULT NULL,
  `grade_category` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boards`
--

LOCK TABLES `boards` WRITE;
/*!40000 ALTER TABLE `boards` DISABLE KEYS */;
INSERT INTO `boards` VALUES (1,'STATE BOARD','2019-03-14 00:00:00','2019-03-21 00:00:00',NULL),(2,'CBSE','2019-03-14 00:00:00','2019-03-21 00:00:00',NULL),(3,'ICSE','2019-03-14 00:00:00','2019-03-14 00:00:00',NULL);
/*!40000 ALTER TABLE `boards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_exam`
--

DROP TABLE IF EXISTS `course_exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_exam` (
  `course_id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL,
  PRIMARY KEY (`exam_id`,`course_id`),
  KEY `fk_course_exam_1_idx` (`course_id`),
  CONSTRAINT `fk_course_exam_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_exam_2` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_exam`
--

LOCK TABLES `course_exam` WRITE;
/*!40000 ALTER TABLE `course_exam` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_subject`
--

DROP TABLE IF EXISTS `course_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_subject` (
  `course_id` int(10) NOT NULL,
  `subject_id` int(10) NOT NULL,
  `staff_id` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`course_id`,`subject_id`),
  KEY `fk_course_subject_2_idx` (`staff_id`),
  KEY `fk_course_subject_3_idx` (`subject_id`),
  KEY `fk_course_subject_1_idx` (`course_id`),
  KEY `fk_course` (`course_id`),
  CONSTRAINT `fk_course_subject_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_subject_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_subject_3` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Linking table between courses and subject.follows Many to Many relationship';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_subject`
--

LOCK TABLES `course_subject` WRITE;
/*!40000 ALTER TABLE `course_subject` DISABLE KEYS */;
INSERT INTO `course_subject` VALUES (1,1,3,'2019-03-22 18:30:00','2019-03-22 18:30:00'),(1,5,6,'2019-03-22 18:30:00','2019-03-22 18:30:00'),(2,1,3,'2019-03-22 18:30:00','2019-03-22 18:30:00');
/*!40000 ALTER TABLE `course_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `school_id` int(11) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `course_title` varchar(15) CHARACTER SET utf8 NOT NULL,
  `category` enum('LP','UP','HS','HSE') COLLATE utf8_unicode_ci NOT NULL,
  `course_code` varchar(10) CHARACTER SET utf8 NOT NULL,
  `grade_system` enum('percentage','gpa') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'percentage',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('Active','Inactive') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_courses_1_idx` (`staff_id`),
  KEY `fk_courses_2_idx` (`school_id`),
  CONSTRAINT `fk_courses_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_courses_2` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='To store all available courses';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,1,3,'10A','UP','TEN1','percentage','SSFHH','Active',NULL,NULL),(2,1,NULL,'10B','LP','TEN2','percentage','FDDDG','Active',NULL,NULL),(3,1,6,'10C','LP','TEN3','percentage','SJHTJUI','Active',NULL,NULL),(4,1,NULL,'9A','UP','NINE1','percentage','TYYIHFS','Active',NULL,NULL),(5,1,NULL,'9B','LP','NINE2','percentage','FFJBJ','Active',NULL,NULL),(6,1,9,'9C','LP','NINE3','percentage','DFSFJDF','Active',NULL,NULL),(7,1,NULL,'8A','UP','EIGHT1','percentage','DGFFFFF','Active',NULL,NULL),(8,1,7,'8B','LP','EIGHT2','percentage','DFRR','Active',NULL,NULL),(9,1,NULL,'8C','LP','EIGHT3','percentage','DSDZ','Active',NULL,NULL);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_categories`
--

DROP TABLE IF EXISTS `exam_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_categories` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_categories`
--

LOCK TABLES `exam_categories` WRITE;
/*!40000 ALTER TABLE `exam_categories` DISABLE KEYS */;
INSERT INTO `exam_categories` VALUES (1,'weekly-test','2018-07-10 06:41:35','2018-07-10 06:41:35'),(2,'monthly-test','2018-07-10 06:41:35','2018-07-10 06:41:35'),(3,'class-test','2018-07-10 06:41:35','2018-07-10 06:41:35'),(4,'mid-term','2018-07-10 06:41:35','2018-07-10 06:41:35'),(5,'quarterly','2018-07-10 06:41:35','2018-07-10 06:41:35'),(6,'half-yearly','2018-07-10 06:41:35','2018-07-10 06:41:35'),(7,'yearly','2018-07-10 06:41:35','2018-07-10 06:41:35'),(8,'unit-test','2018-07-10 06:41:35','2018-07-10 06:41:35');
/*!40000 ALTER TABLE `exam_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_results`
--

DROP TABLE IF EXISTS `exam_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_results` (
  `user_id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL,
  `marks_obtained` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`exam_id`),
  KEY `fk_exam_results_1_idx` (`exam_id`),
  KEY `fk_exam_results_2_idx` (`user_id`),
  CONSTRAINT `fk_exam_results_1` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_exam_results_2` FOREIGN KEY (`user_id`) REFERENCES `students` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_results`
--

LOCK TABLES `exam_results` WRITE;
/*!40000 ALTER TABLE `exam_results` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exams`
--

DROP TABLE IF EXISTS `exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exams` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 NOT NULL,
  `course_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `starts_on` timestamp NULL DEFAULT NULL,
  `ends_on` timestamp NULL DEFAULT NULL,
  `exam_category_id` int(11) NOT NULL,
  `conducted_by` int(11) NOT NULL,
  `maximum_marks` int(11) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `deleted` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index2` (`conducted_by`),
  KEY `subject_idx` (`subject_id`),
  KEY `exam_category_idx` (`exam_category_id`),
  KEY `fk_exams_1_idx` (`course_id`),
  CONSTRAINT `exam_category` FOREIGN KEY (`exam_category_id`) REFERENCES `exam_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `staff` FOREIGN KEY (`conducted_by`) REFERENCES `staff` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `subject` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exams`
--

LOCK TABLES `exams` WRITE;
/*!40000 ALTER TABLE `exams` DISABLE KEYS */;
INSERT INTO `exams` VALUES (4,'Malayalam',1,5,'2019-03-22 18:30:00','2019-03-22 18:30:00',1,3,50,1,NULL,'2019-03-24 07:14:05','2019-03-24 07:14:05'),(9,'Malayalam',1,9,'2019-03-22 18:30:00','2019-03-22 18:30:00',1,3,50,1,NULL,'2019-03-23 22:10:39','2019-03-23 22:10:39'),(10,'Malayalam',5,9,'2019-03-22 18:30:00','2019-03-22 18:30:00',1,3,50,1,1,'2019-03-29 03:10:02','2019-03-29 03:28:19');
/*!40000 ALTER TABLE `exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grades`
--

DROP TABLE IF EXISTS `grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grades` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `grade_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('UP','LP','HS','HSE') COLLATE utf8_unicode_ci NOT NULL,
  `board` int(11) NOT NULL,
  `percentage_from` decimal(10,2) DEFAULT NULL,
  `percentage_to` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_grades_1_idx` (`board`),
  CONSTRAINT `fk_grades_1` FOREIGN KEY (`board`) REFERENCES `boards` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grades`
--

LOCK TABLES `grades` WRITE;
/*!40000 ALTER TABLE `grades` DISABLE KEYS */;
/*!40000 ALTER TABLE `grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_servicess`
--

DROP TABLE IF EXISTS `group_servicess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_servicess` (
  `group_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `service_code` int(10) DEFAULT NULL,
  PRIMARY KEY (`group_id`,`service_id`),
  KEY `fk_group_servicess_1_idx` (`service_id`),
  CONSTRAINT `fk_group_servicess_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_servicess_2` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_servicess`
--

LOCK TABLES `group_servicess` WRITE;
/*!40000 ALTER TABLE `group_servicess` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_servicess` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `decription` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Common','This group include common services ','2019-03-15 04:24:48'),(2,'Super Admin group ','Common group for super admin','2019-03-15 04:26:52'),(3,'Common group staff','common groups for staffs','2019-03-15 04:27:58'),(4,'Common group student','common groups for students','2019-03-15 04:27:58');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_category`
--

DROP TABLE IF EXISTS `menu_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COMMENT=' sort out all category of menu items';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_category`
--

LOCK TABLES `menu_category` WRITE;
/*!40000 ALTER TABLE `menu_category` DISABLE KEYS */;
INSERT INTO `menu_category` VALUES (1,'Common'),(2,'Academic'),(3,'Social'),(4,'Personal');
/*!40000 ALTER TABLE `menu_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `icon` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COMMENT='To store all available menus';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (2,'Home','pin','2019-03-12 18:30:00'),(3,'My Notifications','notifications','2019-03-13 18:30:00'),(4,'Help & Feedback',NULL,'2019-03-13 18:30:00'),(5,"User's Guide",NULL,'2019-03-13 18:30:00'),(6,'About us',NULL,'2019-03-13 18:30:00'),(7,'Attendance','calendar','2019-03-13 18:30:00'),(8,'Examinations','document','2019-03-13 18:30:00'),(9,'Home Works','book','2019-03-13 18:30:00'),(10,'Class Notes','clipboard','2019-03-13 18:30:00'),(11,'Chats','chatboxes','2019-03-13 18:30:00'),(12,'Events','bookmark','2019-03-13 18:30:00'),(13,'My Photos','images','2019-03-13 18:30:00'),(14,'Student Information','paper','2019-03-13 18:30:00'),(15,'My Timetable','tablet-landscape','2019-03-13 18:30:00'),(16,'My Profile','person','2019-03-13 18:30:00'),(17,'Leave Application','paper','2019-03-13 18:30:00'),(18,'ToDo List','checkbox-outline','2019-03-13 18:30:00');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `run_on` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'/20190328043845-wesa-db-migration','2019-03-28 10:32:06');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(2500) CHARACTER SET utf8mb4 NOT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `record_updated_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,'hh','jjjjj',NULL,1,'2019-04-17 21:13:46','2019-04-17 21:13:46'),(2,'hh','jjjjj',NULL,1,'2019-04-17 21:17:01','2019-04-17 21:17:01'),(3,'hh','jjjjj',NULL,1,'2019-04-18 01:31:24','2019-04-18 01:31:24'),(4,'hh','jjjjj',NULL,1,'2019-04-18 01:34:00','2019-04-18 01:34:00'),(5,'hh','jjjjj',NULL,1,'2019-04-18 01:34:52','2019-04-18 01:34:52'),(6,'hh','jjjjj',NULL,1,'2019-04-18 02:18:56','2019-04-18 02:18:56'),(7,'hh','jjjjj',NULL,1,'2019-04-19 04:17:37','2019-04-19 04:17:37'),(8,'hh','jjjjj',NULL,1,'2019-04-19 04:20:39','2019-04-19 04:20:39'),(9,'hh','jjjjj',NULL,1,'2019-04-19 04:21:13','2019-04-19 04:21:13'),(10,'hh','jjjjj',NULL,1,'2019-04-19 04:22:16','2019-04-19 04:22:16'),(11,'hh','jjjjj',NULL,1,'2019-04-19 04:22:57','2019-04-19 04:22:57'),(12,'hh','jjjjj',NULL,1,'2019-04-19 04:25:02','2019-04-19 04:25:02'),(13,'hh','jjjjj',NULL,1,'2019-04-19 04:31:17','2019-04-19 04:31:17'),(14,'hh','jjjjj',NULL,1,'2019-04-19 04:33:11','2019-04-19 04:33:11'),(15,'hh','jjjjj',NULL,1,'2019-04-23 06:24:08','2019-04-23 06:24:08'),(16,'hh','jjjjj',NULL,1,'2019-04-23 06:28:21','2019-04-23 06:28:21'),(17,'hh','jjjjj',NULL,1,'2019-04-24 06:30:03','2019-04-24 06:30:03'),(18,'hh','jjjjj',NULL,1,'2019-04-24 06:31:02','2019-04-24 06:31:02'),(19,'hh','jjjjj',NULL,1,'2019-04-24 06:35:25','2019-04-24 06:35:25'),(20,'hh','jjjjj',NULL,1,'2019-04-24 06:38:43','2019-04-24 06:38:43');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8 NOT NULL,
  `display_name` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `description` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Table to store all available /possible roles of a user';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'owner','Owner','Owner of this account','2016-06-07 22:02:59','2016-06-07 22:02:59'),(2,'admin','Admin','Admin of this Account','2016-06-07 22:03:19','2016-06-07 22:03:19'),(3,'staff','Staff','Staff User','2016-11-04 18:14:22','2016-11-04 18:14:22'),(5,'student','Student','Student User','2016-06-07 22:31:54','2016-06-07 22:31:54'),(6,'parent','Parent User','Parent Login','2016-06-08 02:05:27','2016-06-08 02:05:27'),(7,'librarian','Librarian','Library User','2016-12-05 13:00:00','2016-12-05 13:00:00'),(8,'support','support','support','2016-12-06 20:15:12','2016-12-06 20:15:12'),(9,'principal','Principal','Principal user',NULL,NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_courses`
--

DROP TABLE IF EXISTS `school_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_courses` (
  `school_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY (`school_id`,`course_id`),
  KEY `fk_school_courses_2_idx` (`course_id`),
  CONSTRAINT `fk_school_courses_1` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_school_courses_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_courses`
--

LOCK TABLES `school_courses` WRITE;
/*!40000 ALTER TABLE `school_courses` DISABLE KEYS */;
/*!40000 ALTER TABLE `school_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_role_services`
--

DROP TABLE IF EXISTS `school_role_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_role_services` (
  `school_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `role_id` tinyint(3) NOT NULL,
  PRIMARY KEY (`school_id`,`group_id`,`role_id`),
  KEY `fk_school_role_services_2_idx` (`group_id`),
  KEY `fk_school_role_services_3_idx` (`role_id`),
  CONSTRAINT `fk_school_role_services_1` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_school_role_services_2` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_school_role_services_3` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_role_services`
--

LOCK TABLES `school_role_services` WRITE;
/*!40000 ALTER TABLE `school_role_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `school_role_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_roles_menu`
--

DROP TABLE IF EXISTS `school_roles_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_roles_menu` (
  `school_id` int(10) NOT NULL AUTO_INCREMENT,
  `role_id` tinyint(4) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `color` varchar(10) COLLATE latin1_general_ci DEFAULT NULL,
  `component` varchar(45) COLLATE latin1_general_ci DEFAULT NULL,
  `badge` tinyint(1) NOT NULL,
  `order_no` int(11) NOT NULL,
  PRIMARY KEY (`school_id`,`role_id`,`menu_id`),
  KEY `fk_schools_has_menus_menus1_idx` (`menu_id`),
  KEY `fk_schools_has_menus_schools1_idx` (`school_id`),
  KEY `fk_school_roles_menu_1_idx` (`role_id`),
  CONSTRAINT `fk_school_roles_menu_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_school_roles_menu_2` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_school_roles_menu_3` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_roles_menu`
--

LOCK TABLES `school_roles_menu` WRITE;
/*!40000 ALTER TABLE `school_roles_menu` DISABLE KEYS */;
INSERT INTO `school_roles_menu` VALUES (1,3,2,'#FF0000','HomePage',0,1),(1,3,5,'#FF0000','NotificationsPage',0,2),(1,5,2,'#00FF00','ParentHome',0,1);
/*!40000 ALTER TABLE `school_roles_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schools`
--

DROP TABLE IF EXISTS `schools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schools` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `school_code` varchar(10) NOT NULL,
  `name` varchar(60) NOT NULL,
  `image` varchar(45) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `head` varchar(20) DEFAULT NULL,
  `board` int(11) NOT NULL,
  `type` enum('Boys only','Girls only','Mixed') DEFAULT NULL,
  `address` varchar(100) NOT NULL,
  `email` varchar(20) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_code_UNIQUE` (`school_code`),
  KEY `fk_schools_1_idx` (`board`),
  CONSTRAINT `fk_schools_1` FOREIGN KEY (`board`) REFERENCES `boards` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='Details of all registerd schools';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schools`
--

LOCK TABLES `schools` WRITE;
/*!40000 ALTER TABLE `schools` DISABLE KEYS */;
INSERT INTO `schools` VALUES (1,'HFCGHS','Holy Family Convent Girls School','','9567133536','Britto',3,'Girls only','Holy Family C.G.H.S.S\nChembukavu\nThrissur, 680020','hfcghstcr@gmail.com',NULL,'2019-03-12 00:00:00','2019-03-12 00:00:00'),(2,'SJCGHS','St.Josephs CGHSS ',NULL,'9677485210','Sr.Jessi',3,'Girls only','St.Josephs CGHSS Mission Quarters Thrissur','sjcghsstcr@gmail.com',NULL,'2019-03-13 00:00:00','0201-03-13 00:00:00'),(3,'NMCS','Nirmala Matha Central School',NULL,'04872559633','Sr.Rani',1,'Mixed','Nirmala Matha Cental School\nEast Fort \nThrissur','nmcstcr@gmail.com',NULL,'2019-03-13 00:00:00','2019-03-13 00:00:00');
/*!40000 ALTER TABLE `schools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='All services offered by us';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff` (
  `user_id` int(10) NOT NULL,
  `course_id` int(10) NOT NULL,
  `job_title` enum('class_teacher','teacher','non teaching') CHARACTER SET utf8 DEFAULT NULL,
  `date_of_join` date DEFAULT NULL,
  `gender` enum('male','female') COLLATE utf8_unicode_ci NOT NULL,
  `marital_status` enum('single','married','divorced') COLLATE utf8_unicode_ci NOT NULL,
  `qualification` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_experience_years` int(11) NOT NULL,
  `total_experience_month` int(11) NOT NULL,
  `experience_information` text COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`course_id`),
  KEY `fk_staff_1_idx` (`user_id`),
  KEY `fk_staff_2_idx` (`course_id`),
  CONSTRAINT `fk_staff_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='All staff details are stored here';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (3,1,'non teaching',NULL,'male','single','MBA',3,4,'FGGFGFF',NULL,NULL,NULL),(4,1,'teacher',NULL,'male','single','BSC BED',1,1,'DDGDG',NULL,NULL,NULL),(6,1,'teacher',NULL,'male','single','BE',0,0,'DVVXF',NULL,NULL,NULL),(7,2,'non teaching',NULL,'female','married','mca',3,2,'qwddfjhhg',NULL,NULL,NULL),(9,1,'class_teacher',NULL,'male','single','MCA',3,2,'HGFG',NULL,NULL,NULL),(10,1,'teacher',NULL,'male','single','MSC ',2,3,'NIC TRIVANDRUM',NULL,NULL,NULL);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_attendance`
--

DROP TABLE IF EXISTS `student_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_attendance` (
  `user_id` int(5) NOT NULL,
  `course_id` int(10) NOT NULL,
  `attendance_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(2) DEFAULT NULL,
  `attendance_code` varchar(2) CHARACTER SET utf8 DEFAULT '',
  `record_updated_by` int(10) NOT NULL,
  `created_at` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_at` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remarks` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`attendance_date`,`user_id`),
  KEY `fk_student_attendance_1_idx` (`user_id`),
  CONSTRAINT `fk_student_attendance_1` FOREIGN KEY (`user_id`) REFERENCES `students` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_attendance`
--

LOCK TABLES `student_attendance` WRITE;
/*!40000 ALTER TABLE `student_attendance` DISABLE KEYS */;
INSERT INTO `student_attendance` VALUES (1,1,'2019-03-24 15:33:36',0,'L',7,NULL,NULL,NULL);
/*!40000 ALTER TABLE `student_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_medical_info`
--

DROP TABLE IF EXISTS `student_medical_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_medical_info` (
  `user_id` int(11) NOT NULL,
  `blood_group` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `medication_history` text CHARACTER SET utf8,
  `medication_current` varchar(256) CHARACTER SET utf8 DEFAULT NULL,
  `others` varchar(256) CHARACTER SET utf8 DEFAULT NULL,
  `created_at` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_at` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `fk_student_medical_info_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_medical_info`
--

LOCK TABLES `student_medical_info` WRITE;
/*!40000 ALTER TABLE `student_medical_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_medical_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `admission_no` varchar(10) CHARACTER SET utf8 NOT NULL,
  `course_id` int(10) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_of_join` date DEFAULT NULL,
  `category_id` int(10) DEFAULT NULL,
  `religion_id` int(10) DEFAULT NULL,
  `parent_education` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `parent_occupation` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `parent_income` decimal(10,2) DEFAULT NULL,
  `guardian_name` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `guardian_phone` varchar(12) CHARACTER SET utf8 DEFAULT NULL,
  `relationship_with_guardian` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `guardian_email` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `previous_institute_name` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `previous_institute_address` varchar(124) CHARACTER SET utf8 DEFAULT NULL,
  `previous_highest_qualification` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `previous_highest_qualification_percentage` decimal(10,0) DEFAULT NULL,
  `year_passing` year(4) DEFAULT NULL,
  `record_updated_by` int(10) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `paper_one` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `medical_id` int(11) DEFAULT NULL,
  `rfid` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `is_with_guardian` tinyint(1) DEFAULT NULL,
  `source_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `admission_no_UNIQUE` (`admission_no`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  KEY `fk_students_2_idx` (`course_id`),
  CONSTRAINT `fk_students_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_students_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='All students details goes here';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES ('1001',1,1,'2019-03-13',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('1002',1,2,'2019-03-15',1,1,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-14 18:30:00');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subjects` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` smallint(2) NOT NULL,
  `subject_title` varchar(20) CHARACTER SET utf8 NOT NULL,
  `subject_code` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `is_lab` tinyint(4) DEFAULT NULL,
  `is_elective_type` tinyint(4) DEFAULT NULL,
  `status` enum('Active','Inactive') CHARACTER SET utf8 DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='All available subjects';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
INSERT INTO `subjects` VALUES (1,1,'English','ENG',0,0,'Active','2019-03-05 13:11:22','2019-03-05 13:11:22'),(5,2,'Malayalam','MAL',0,0,'Active','2019-03-05 13:11:22','2019-03-05 13:11:22'),(9,3,'Hindi','HIN',0,0,'Active','2019-03-05 13:11:22','2019-03-05 13:11:22'),(13,4,'Mathematics','MAT',0,0,'Active','2019-03-05 13:11:22','2019-03-05 13:11:22'),(17,5,'Physics','PHY',1,0,'Active','2019-03-05 13:11:22','2019-03-05 13:11:22');
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_notifications`
--

DROP TABLE IF EXISTS `user_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_notifications` (
  `notification_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `last_read` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT NULL,
  KEY `fk_user_notifications_1_idx` (`notification_id`),
  CONSTRAINT `fk_user_notifications_1` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_notifications`
--

LOCK TABLES `user_notifications` WRITE;
/*!40000 ALTER TABLE `user_notifications` DISABLE KEYS */;
INSERT INTO `user_notifications` VALUES (2,2,NULL,NULL,NULL),(2,1,NULL,NULL,NULL),(3,1,NULL,NULL,NULL),(3,2,NULL,NULL,NULL),(4,1,NULL,NULL,NULL),(4,2,NULL,NULL,NULL),(5,1,NULL,NULL,NULL),(5,2,NULL,NULL,NULL),(6,1,NULL,NULL,NULL),(6,2,NULL,NULL,NULL),(12,3,NULL,NULL,NULL),(12,1,NULL,NULL,NULL),(12,2,NULL,NULL,NULL),(12,6,NULL,NULL,NULL),(12,3,NULL,NULL,NULL),(14,2,NULL,NULL,NULL),(14,1,NULL,NULL,NULL),(15,2,NULL,NULL,NULL),(15,1,NULL,NULL,NULL),(16,2,NULL,NULL,NULL),(16,1,NULL,NULL,NULL),(17,2,NULL,NULL,NULL),(17,1,NULL,NULL,NULL),(19,4,NULL,NULL,NULL),(20,4,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `school_id` int(11) DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 NOT NULL,
  `username` varchar(15) CHARACTER SET utf8 NOT NULL,
  `email` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `password` varchar(124) CHARACTER SET utf8 DEFAULT NULL,
  `login_enabled` tinyint(1) DEFAULT '1',
  `role_id` tinyint(3) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `image` varchar(124) CHARACTER SET utf8 DEFAULT NULL,
  `phone` varchar(12) CHARACTER SET utf8 DEFAULT NULL,
  `address` text CHARACTER SET utf8,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `fcmtoken` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `otp` varchar(154) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isVerified` tinyint(1) DEFAULT NULL,
  `user_verified` int(11) DEFAULT '0',
  `sessionId` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `apiToken` varchar(300) CHARACTER SET utf8 DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `alternate_phone` varchar(13) COLLATE utf8_unicode_ci DEFAULT NULL,
  `app_version` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `source_time` timestamp NULL DEFAULT NULL,
  `subscriptions` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index2` (`school_id`,`phone`),
  KEY `fk_users_1_idx` (`role_id`),
  CONSTRAINT `fk_users_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_2` FOREIGN KEY (`school_id`) REFERENCES `schools` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='All user details goes here';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'sandeep','sandeep','sna34g@gmal.com','san34',1,5,1,'test.png','9567133536','sandeep kumar olari',NULL,NULL,NULL,'8fbb05e74c1a3cdf70fc93f7b7b37309593eebb4f1d88edf3ba834ae6ca4873e',1,1,'1552804374330',NULL,'2019-02-25 13:11:22','9645862321','1',1,'2019-02-25 13:11:22','2019-02-25 13:11:22','erww'),(1,2,'shincy','shincy23','shi@gmail.com','shincy890',1,5,1,NULL,'9567133536','shincy,  punamparamp',NULL,NULL,NULL,'8fbb05e74c1a3cdf70fc93f7b7b37309593eebb4f1d88edf3ba834ae6ca4873e',1,1,'1552804374330',NULL,'2019-04-03 13:00:00','889390004','1',1,'2019-05-06 13:00:00','2019-05-06 13:00:00','wwww'),(1,3,'priyanka','priyanka','priya23@gmail','12priya\n',1,2,1,NULL,'7289873745','priyanka c s ollur\n',NULL,NULL,NULL,'4862',1,1,NULL,NULL,'2019-01-01 13:00:00','9809231937','1',1,'2019-03-24 13:00:00','2019-01-01 13:00:00','qwert'),(1,4,'mincy','mincy','mincy23@gmail.com','min67',1,3,1,NULL,'9567133536','mincy p k valakkavu',NULL,NULL,NULL,'8fbb05e74c1a3cdf70fc93f7b7b37309593eebb4f1d88edf3ba834ae6ca4873e',1,1,'1552804374330',NULL,'2019-02-24 13:11:22','5896961235','1',1,'2019-02-24 13:11:22','2019-02-24 13:11:22','ryhs'),(2,5,'majo','majo','majo23@gmail.com','majo',1,5,1,NULL,'7856231568','majo p amala',NULL,NULL,NULL,'2569',1,1,NULL,NULL,'2019-02-11 13:11:22','7569253645','1',1,'2019-02-24 13:11:22','2019-02-24 13:11:22','wqyi'),(2,6,'arun','arun','arunts@gmail.com','arun345',1,8,1,NULL,'5692345','arun t s magalam',NULL,NULL,NULL,'7842',1,1,NULL,NULL,'2019-02-21 13:11:22','9869254825','1',1,'2019-02-21 13:11:22','2019-02-21 13:11:22','rty'),(3,7,'seetha','seetha','setha@gmail.com','setha34',1,2,1,NULL,'7845632926','seetha p',NULL,NULL,NULL,'2165',1,1,NULL,NULL,'2019-02-21 13:11:22','9869545326','1',1,'2019-02-21 13:11:22','2019-02-21 13:11:22','yuii'),(3,8,'manju','manju','manju34@gmail.com','manju789',1,5,1,NULL,'9598756325','manju p trissur',NULL,NULL,NULL,'4723',1,1,NULL,NULL,'2019-02-27 13:11:22','8796523154','1',1,'2019-02-21 13:11:22','2019-02-21 13:11:22','rttuu'),(3,9,'rakhi','rakhi','23rakhi@gmail.com','rarrrr',1,3,1,NULL,'7856241536','rakhi s kochi',NULL,NULL,NULL,'6483',1,1,NULL,NULL,'2019-02-21 13:11:22','789654231','1',1,'2019-02-21 13:11:22','2019-02-21 13:11:22','our'),(3,10,'tinu','tinu','tinu678@gmail.com','123tinu',1,7,1,NULL,'7865942315','tinu raju matttam',NULL,NULL,NULL,'4326',1,1,NULL,NULL,'2019-03-05 13:11:22','9865321414','1',1,'2019-03-05 13:11:22','2019-03-05 13:11:22','wert');
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

-- Dump completed on 2019-04-24  0:27:45
