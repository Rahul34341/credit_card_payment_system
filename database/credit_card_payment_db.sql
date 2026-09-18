-- MySQL dump 10.13  Distrib 8.4.11, for Win64 (x86_64)
--
-- Host: localhost    Database: credit_card_payment_db
-- ------------------------------------------------------
-- Server version	8.4.11

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

--
-- Table structure for table `admin_logs_adminlog`
--

DROP TABLE IF EXISTS `admin_logs_adminlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_logs_adminlog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `action` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `admin_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_logs_adminlog_admin_id_58feada8_fk_auth_user_id` (`admin_id`),
  CONSTRAINT `admin_logs_adminlog_admin_id_58feada8_fk_auth_user_id` FOREIGN KEY (`admin_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_logs_adminlog`
--

LOCK TABLES `admin_logs_adminlog` WRITE;
/*!40000 ALTER TABLE `admin_logs_adminlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_logs_adminlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',3,'add_permission'),(6,'Can change permission',3,'change_permission'),(7,'Can delete permission',3,'delete_permission'),(8,'Can view permission',3,'view_permission'),(9,'Can add group',2,'add_group'),(10,'Can change group',2,'change_group'),(11,'Can delete group',2,'delete_group'),(12,'Can view group',2,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add Blacklisted Token',7,'add_blacklistedtoken'),(26,'Can change Blacklisted Token',7,'change_blacklistedtoken'),(27,'Can delete Blacklisted Token',7,'delete_blacklistedtoken'),(28,'Can view Blacklisted Token',7,'view_blacklistedtoken'),(29,'Can add Outstanding Token',8,'add_outstandingtoken'),(30,'Can change Outstanding Token',8,'change_outstandingtoken'),(31,'Can delete Outstanding Token',8,'delete_outstandingtoken'),(32,'Can view Outstanding Token',8,'view_outstandingtoken'),(33,'Can add card',9,'add_card'),(34,'Can change card',9,'change_card'),(35,'Can delete card',9,'delete_card'),(36,'Can view card',9,'view_card'),(37,'Can add admin log',11,'add_adminlog'),(38,'Can change admin log',11,'change_adminlog'),(39,'Can delete admin log',11,'delete_adminlog'),(40,'Can view admin log',11,'view_adminlog'),(41,'Can add transaction',10,'add_transaction'),(42,'Can change transaction',10,'change_transaction'),(43,'Can delete transaction',10,'delete_transaction'),(44,'Can view transaction',10,'view_transaction');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$1500000$7tLREonrhETE1GWwNMRNky$MuEglS409JgmIUlFiJO+qzRC7z+UueUM2o7fmP8GXx0=',NULL,0,'rahul','','','rahul12345@gmail.com',0,1,'2026-09-14 07:38:19.062122'),(2,'pbkdf2_sha256$1500000$43iXRIRWO5l8KVDjS6KIOH$eSvYX8R/iLG/o2y4EHz5qfZDeSaCg/iQC92DOYrG2BQ=','2026-09-15 10:12:49.857681',1,'rahul_admin','','','rahul12345@gmail.com',1,1,'2026-09-15 10:12:26.971932'),(3,'pbkdf2_sha256$1500000$qeSj8l8tKKcVH49d1SIJ9k$6qpUPrdjLxKi3h7LeizYDdyHcvrPh/i0bvzzk0QjLok=',NULL,0,'rahul12345','','','rahul12345@gmail.com',0,1,'2026-09-15 15:48:51.782345');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cards_card`
--

DROP TABLE IF EXISTS `cards_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cards_card` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `card_holder_name` varchar(100) NOT NULL,
  `card_type` varchar(10) NOT NULL,
  `masked_card_number` varchar(19) NOT NULL,
  `last_four` varchar(4) NOT NULL,
  `expiry_month` smallint unsigned NOT NULL,
  `expiry_year` smallint unsigned NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cards_card_user_id_9c174339_fk_auth_user_id` (`user_id`),
  CONSTRAINT `cards_card_user_id_9c174339_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `cards_card_chk_1` CHECK ((`expiry_month` >= 0)),
  CONSTRAINT `cards_card_chk_2` CHECK ((`expiry_year` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cards_card`
--

LOCK TABLES `cards_card` WRITE;
/*!40000 ALTER TABLE `cards_card` DISABLE KEYS */;
INSERT INTO `cards_card` VALUES (1,'Rahul','CREDIT','************1111','1111',12,2028,'2026-09-15 05:45:43.731877',1),(3,'4111111111111111','CREDIT','************1111','1111',12,2028,'2026-09-15 16:05:21.802769',3);
/*!40000 ALTER TABLE `cards_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(11,'admin_logs','adminlog'),(2,'auth','group'),(3,'auth','permission'),(4,'auth','user'),(9,'cards','card'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(7,'token_blacklist','blacklistedtoken'),(8,'token_blacklist','outstandingtoken'),(10,'transactions','transaction');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-09-14 06:23:49.728274'),(2,'auth','0001_initial','2026-09-14 06:23:50.504108'),(3,'admin','0001_initial','2026-09-14 06:23:50.733432'),(4,'admin','0002_logentry_remove_auto_add','2026-09-14 06:23:50.742129'),(5,'admin','0003_logentry_add_action_flag_choices','2026-09-14 06:23:50.753144'),(6,'contenttypes','0002_remove_content_type_name','2026-09-14 06:23:50.893020'),(7,'auth','0002_alter_permission_name_max_length','2026-09-14 06:23:50.975112'),(8,'auth','0003_alter_user_email_max_length','2026-09-14 06:23:51.000648'),(9,'auth','0004_alter_user_username_opts','2026-09-14 06:23:51.012005'),(10,'auth','0005_alter_user_last_login_null','2026-09-14 06:23:51.090916'),(11,'auth','0006_require_contenttypes_0002','2026-09-14 06:23:51.095342'),(12,'auth','0007_alter_validators_add_error_messages','2026-09-14 06:23:51.107227'),(13,'auth','0008_alter_user_username_max_length','2026-09-14 06:23:51.202767'),(14,'auth','0009_alter_user_last_name_max_length','2026-09-14 06:23:51.291005'),(15,'auth','0010_alter_group_name_max_length','2026-09-14 06:23:51.312214'),(16,'auth','0011_update_proxy_permissions','2026-09-14 06:23:51.323160'),(17,'auth','0012_alter_user_first_name_max_length','2026-09-14 06:23:51.406544'),(18,'sessions','0001_initial','2026-09-14 06:23:51.454312'),(19,'token_blacklist','0001_initial','2026-09-14 07:52:12.843968'),(20,'token_blacklist','0002_outstandingtoken_jti_hex','2026-09-14 07:52:12.917093'),(21,'token_blacklist','0003_auto_20171017_2007','2026-09-14 07:52:12.930500'),(22,'token_blacklist','0004_auto_20171017_2013','2026-09-14 07:52:13.020235'),(23,'token_blacklist','0005_remove_outstandingtoken_jti','2026-09-14 07:52:13.087902'),(24,'token_blacklist','0006_auto_20171017_2113','2026-09-14 07:52:13.116391'),(25,'token_blacklist','0007_auto_20171017_2214','2026-09-14 07:52:13.367682'),(26,'token_blacklist','0008_migrate_to_bigautofield','2026-09-14 07:52:13.637308'),(27,'token_blacklist','0010_fix_migrate_to_bigautofield','2026-09-14 07:52:13.655556'),(28,'token_blacklist','0011_linearizes_history','2026-09-14 07:52:13.659560'),(29,'token_blacklist','0012_alter_outstandingtoken_user','2026-09-14 07:52:13.670318'),(30,'token_blacklist','0013_alter_blacklistedtoken_options_and_more','2026-09-14 07:52:13.684525'),(31,'cards','0001_initial','2026-09-15 05:28:07.323958'),(32,'admin_logs','0001_initial','2026-09-16 05:14:53.157645'),(33,'transactions','0001_initial','2026-09-17 01:09:10.333781');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('98loenrdezcdpsq0z9nzqy2qzaeigp2q','.eJxVjDkOwjAQAP-yNbJ8JTYp6fOGaO3dxQFkSzkqxN9RpBTQzozmDRPuW5n2lZdpJhjAwuWXJcxProegB9Z7U7nVbZmTOhJ12lWNjfh1O9u_QcG1wADYO5M6K5GZrGSdxffEgnwlG3TMYkmYOTkTrMHkdULRnY8ham0cMny-HwE5DQ:1x6Q9h:1ntHlPxfTK-_uQcVXbOAJbX948S5Jd_jiX4NZrTmF4M','2026-09-29 10:12:49.870855');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `card_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_payments_user_id` (`user_id`),
  KEY `ix_payments_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,1,500.00,'SUCCESS','2026-09-15 06:55:32','2026-09-15 06:55:32'),(2,1,1,500.00,'FAILED','2026-09-15 07:02:14','2026-09-15 09:48:25'),(3,1,1,500.00,'PENDING','2026-09-15 09:32:34','2026-09-15 09:32:34'),(4,3,3,500.00,'FAILED','2026-09-15 17:19:08','2026-09-15 17:19:18'),(5,3,3,1500.00,'FAILED','2026-09-15 17:20:05','2026-09-15 17:20:07'),(6,3,3,500.00,'SUCCESS','2026-09-17 02:17:04','2026-09-17 02:20:21');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist_blacklistedtoken`
--

DROP TABLE IF EXISTS `token_blacklist_blacklistedtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_blacklist_blacklistedtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `blacklisted_at` datetime(6) NOT NULL,
  `token_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_id` (`token_id`),
  CONSTRAINT `token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk` FOREIGN KEY (`token_id`) REFERENCES `token_blacklist_outstandingtoken` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist_blacklistedtoken`
--

LOCK TABLES `token_blacklist_blacklistedtoken` WRITE;
/*!40000 ALTER TABLE `token_blacklist_blacklistedtoken` DISABLE KEYS */;
INSERT INTO `token_blacklist_blacklistedtoken` VALUES (1,'2026-09-14 08:10:08.473154',3),(2,'2026-09-15 05:18:38.596205',6),(3,'2026-09-15 17:24:40.136749',17),(4,'2026-09-17 01:42:28.813192',21);
/*!40000 ALTER TABLE `token_blacklist_blacklistedtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist_outstandingtoken`
--

DROP TABLE IF EXISTS `token_blacklist_outstandingtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_blacklist_outstandingtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `expires_at` datetime(6) NOT NULL,
  `user_id` int DEFAULT NULL,
  `jti` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq` (`jti`),
  KEY `token_blacklist_outs_user_id_83bc629a_fk_auth_user` (`user_id`),
  CONSTRAINT `token_blacklist_outs_user_id_83bc629a_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist_outstandingtoken`
--

LOCK TABLES `token_blacklist_outstandingtoken` WRITE;
/*!40000 ALTER TABLE `token_blacklist_outstandingtoken` DISABLE KEYS */;
INSERT INTO `token_blacklist_outstandingtoken` VALUES (1,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4OTk3NzczNSwiaWF0IjoxNzg5MzcyOTM1LCJqdGkiOiI0MWM4NTg0N2Q4ZTM0M2EyODVmMjVmM2EyNTEwNzcwOSIsInVzZXJfaWQiOiIxIn0.v_jUoBtxaD9ZB67SyiWk5zrnGgNDo9SA9-ZowOzj63I','2026-09-14 08:02:15.405029','2026-09-21 08:02:15.000000',1,'41c85847d8e343a285f25f3a25107709'),(2,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4OTk3Nzc5MSwiaWF0IjoxNzg5MzcyOTkxLCJqdGkiOiJmYTE1MzVjNzI2ZjI0ZjQzYmExMDQ5MjdkM2NmM2YzNCIsInVzZXJfaWQiOiIxIn0.5HzWTmPByaW1iQhxfmU6xAHKxQEmU6UR14MUnnfviZI','2026-09-14 08:03:11.714229','2026-09-21 08:03:11.000000',1,'fa1535c726f24f43ba104927d3cf3f34'),(3,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc4OTk3ODAwMCwiaWF0IjoxNzg5MzczMjAwLCJqdGkiOiIyM2MwMGM3Nzc2NzQ0ZGRlOGFhZDY1N2YxMTA3YmUzYiIsInVzZXJfaWQiOiIxIn0.n8DbEIV7TgkAIJAb1xJjWB5KJqR9tSpwVr7JNUj2go4','2026-09-14 08:06:40.186214','2026-09-21 08:06:40.000000',1,'23c00c7776744dde8aad657f1107be3b'),(4,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDA1MzY3NSwiaWF0IjoxNzg5NDQ4ODc1LCJqdGkiOiJhNzI3NjRiYzA3N2E0MDZmOTBjNDFlMzhjYzkwZjNlYiIsInVzZXJfaWQiOiIxIn0.e8Ot7eC1wBl3W-I3MZPnaSAkHZGYogFgKqk0J4B-zKA','2026-09-15 05:07:55.031099','2026-09-22 05:07:55.000000',1,'a72764bc077a406f90c41e38cc90f3eb'),(5,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDA1Mzk3MiwiaWF0IjoxNzg5NDQ5MTcyLCJqdGkiOiI5YjAxMGIzN2E5Yzc0ZTMwYTFhZjA5YWY2YzgyNGJhNSIsInVzZXJfaWQiOiIxIn0.WaaznzaC-IOuqzmqSj9jmYH4iRW2f7XtqlSUCLbzM2U','2026-09-15 05:12:52.840658','2026-09-22 05:12:52.000000',1,'9b010b37a9c74e30a1af09af6c824ba5'),(6,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDA1Mzk5MywiaWF0IjoxNzg5NDQ5MTkzLCJqdGkiOiJmNjAzMTc4MDA2Mjc0MmEwYjg0ZDQ1Njk4YzE4NWI3YSIsInVzZXJfaWQiOiIxIn0.jrHm6GXuu_blp1RdZN1T84618ocLkWmbrmGMDgv_m9U','2026-09-15 05:13:13.137885','2026-09-22 05:13:13.000000',1,'f6031780062742a0b84d45698c185b7a'),(7,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDA1NDEzMCwiaWF0IjoxNzg5NDQ5MzMwLCJqdGkiOiI3MjhjOWFlODZhZWE0YWEwOGY5ZjIwMDI2ZDA3YmRiNCIsInVzZXJfaWQiOiIxIn0.mZWgMDmu4a4Bc0z2CX-pOlSXNQE1hdr5sfjITtvz1d4','2026-09-15 05:15:30.866646','2026-09-22 05:15:30.000000',1,'728c9ae86aea4aa08f9f20026d07bdb4'),(8,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDA1NTcyMCwiaWF0IjoxNzg5NDUwOTIwLCJqdGkiOiI0YmZkM2I1MjlhMjE0NzMxYThhNzFmZjQ3ODBjYTNkNCIsInVzZXJfaWQiOiIxIn0.KQlPBm17xIKDrSadaLYtnC6J4QPFnAQQtR3SdbmJJwM','2026-09-15 05:42:00.203768','2026-09-22 05:42:00.000000',1,'4bfd3b529a214731a8a71ff4780ca3d4'),(9,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDA2MTgwNiwiaWF0IjoxNzg5NDU3MDA2LCJqdGkiOiI5NmJiMTIyOWU2ODk0Njg4YmI0M2M4OTZjODU3ODU5MCIsInVzZXJfaWQiOiIxIn0.hYNjTCkFdnYuMqhDb_uU0p9pOHkLwomdN6Q_ni0HMkw','2026-09-15 07:23:26.571865','2026-09-22 07:23:26.000000',1,'96bb1229e6894688bb43c896c8578590'),(10,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDA2MTk3OCwiaWF0IjoxNzg5NDU3MTc4LCJqdGkiOiJiNTkyZjFkZDE5OWE0MzhhOWUzNDkwZDdiY2Q4NDU4MiIsInVzZXJfaWQiOiIxIn0._ZYVzaFKFfHXtgQile4KggT52m4cfmP-2nwsmndrxsU','2026-09-15 07:26:18.859268','2026-09-22 07:26:18.000000',1,'b592f1dd199a438a9e3490d7bcd84582'),(11,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDA2NTAwNiwiaWF0IjoxNzg5NDYwMjA2LCJqdGkiOiI0NWE3NzVlYWY3ODM0OTg3ODA5NGY4MGQ2YjEwNzgwMCIsInVzZXJfaWQiOiIxIn0.DeRsgLYWjcYXJRdgvk6B0yyqCaK_vlhPIEN2BLo6PK8','2026-09-15 08:16:46.451216','2026-09-22 08:16:46.000000',1,'45a775eaf78349878094f80d6b107800'),(12,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDA2NjAxMCwiaWF0IjoxNzg5NDYxMjEwLCJqdGkiOiIwYmVmMzBkNTQ1NmI0YzJjYTdjMzkxMjVkYzJkYzBjYiIsInVzZXJfaWQiOiIxIn0.4EvQItHroScmTMEzv97oOcwvDY_Y6un-uKlsmiP-X4o','2026-09-15 08:33:30.014481','2026-09-22 08:33:30.000000',1,'0bef30d5456b4c2ca7c39125dc2dc0cb'),(13,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDA2OTQ5MSwiaWF0IjoxNzg5NDY0NjkxLCJqdGkiOiJiNmVhOTdkMTU4ZTM0ZDg0OWM4NTk1YTA0ODlkNjk1MyIsInVzZXJfaWQiOiIxIn0.r9oVG_5CNc6thKXZXkfVTZhwa_YQLPh-zoJLpjs_AAE','2026-09-15 09:31:31.739914','2026-09-22 09:31:31.000000',1,'b6ea97d158e34d849c8595a0489d6953'),(14,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDA3MDYwOSwiaWF0IjoxNzg5NDY1ODA5LCJqdGkiOiIzZDZmMTIzMGMwMTE0YWQwOThjMmRhMzlmNWIzNDk1OSIsInVzZXJfaWQiOiIxIn0.u_u6O-ffGhkvTXrC2-JGGnWGK9nuElLEG4gG0An5qXg','2026-09-15 09:50:09.506810','2026-09-22 09:50:09.000000',1,'3d6f1230c0114ad098c2da39f5b34959'),(15,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDA3MjIzMywiaWF0IjoxNzg5NDY3NDMzLCJqdGkiOiJlOTBkMWFkMDcyM2U0YTFiOWM4MmY3NDQwN2IzNDgzYiIsInVzZXJfaWQiOiIyIn0.s1LVEyEZeUBiDemSXAOik6zuDsiUBjchNgLpgArxsCY','2026-09-15 10:17:13.402045','2026-09-22 10:17:13.000000',2,'e90d1ad0723e4a1b9c82f74407b3483b'),(16,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDA5MjE0NCwiaWF0IjoxNzg5NDg3MzQ0LCJqdGkiOiIxMzMxN2UxMDNlZDQ0MDAzYTU0YzY3OGI2MzM0MTQ2ZiIsInVzZXJfaWQiOiIzIn0.Uho30Ol0wcpC1CfUzr40NZpJenbVkfAYSn_zvsHaAZ4','2026-09-15 15:49:04.673815','2026-09-22 15:49:04.000000',3,'13317e103ed44003a54c678b6334146f'),(17,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDA5NzA1OCwiaWF0IjoxNzg5NDkyMjU4LCJqdGkiOiJlNjk2OGRmNTJhNjM0NjZlOGE5YWNjZjgyYzFhMWE2YSIsInVzZXJfaWQiOiIzIn0.UAGcMZu6aTBbNcksWlv712Q-G9QjPEv8WqJpSf3RCpA','2026-09-15 17:10:58.925315','2026-09-22 17:10:58.000000',3,'e6968df52a63466e8a9accf82c1a1a6a'),(18,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDA5Nzg5NCwiaWF0IjoxNzg5NDkzMDk0LCJqdGkiOiI1N2UwMjhhODBmZDk0M2Y3YTIzOTI3OGUxN2JmZDE0MiIsInVzZXJfaWQiOiIyIn0.rRwohtQjVkgN17xBNCAkQNFG8wkE0Y4yQKRmJbaK-rA','2026-09-15 17:24:54.089741','2026-09-22 17:24:54.000000',2,'57e028a80fd943f7a239278e17bfd142'),(19,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDA5ODQwNiwiaWF0IjoxNzg5NDkzNjA2LCJqdGkiOiJhMWQ0ODY2N2I4NzQ0MTY5OWM1YTRiZDdjYWNmNWE0YyIsInVzZXJfaWQiOiIzIn0.PexR61GWsnajFgfm40RrOjpP1-4o97Ysprt-j6xvR-Y','2026-09-15 17:33:26.022807','2026-09-22 17:33:26.000000',3,'a1d48667b87441699c5a4bd7cacf5a4c'),(20,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDIxMzAyNywiaWF0IjoxNzg5NjA4MjI3LCJqdGkiOiI3YjIwZjYyMDE1OTc0NTk5YTQ1NWIyYzc0NzdmM2FmMCIsInVzZXJfaWQiOiIzIn0.sLELfvmbTRdlBJzH4JPG-q19X46U_ZEeeflC8Ya-qXo','2026-09-17 01:23:47.268414','2026-09-24 01:23:47.000000',3,'7b20f62015974599a455b2c7477f3af0'),(21,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDIxNDA5NCwiaWF0IjoxNzg5NjA5Mjk0LCJqdGkiOiI0M2VkYzljZWYyYjI0Y2VjOThmYmE5OTA2MmIwOTBjOCIsInVzZXJfaWQiOiIzIn0.UlWM-aUvF9MpPYUXwdgXS98kmVJxpxhtaTHkGDZIT7Y','2026-09-17 01:41:34.690699','2026-09-24 01:41:34.000000',3,'43edc9cef2b24cec98fba99062b090c8'),(22,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDIxNDc1OCwiaWF0IjoxNzg5NjA5OTU4LCJqdGkiOiJkZTMwYWUzMTYxOTQ0Yzg1YWIxMGNmMTA1NzJiYTM3NiIsInVzZXJfaWQiOiIzIn0.VgY7zadEGFlWKaOLEo0YPGU7cSC7oHBo5WMofJHYeM0','2026-09-17 01:52:38.388658','2026-09-24 01:52:38.000000',3,'de30ae3161944c85ab10cf10572ba376'),(23,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDIxNzQwNCwiaWF0IjoxNzg5NjEyNjA0LCJqdGkiOiIzMzZmN2IyYzg5NjQ0Yjk5YTZhNzA2OTUzZGU1MmQ1YiIsInVzZXJfaWQiOiIzIn0.i9JJvTAUwbZu7OjkVPDU9d_b9vGXWCgVANlRgezQiNw','2026-09-17 02:36:44.236697','2026-09-24 02:36:44.000000',3,'336f7b2c89644b99a6a706953de52d5b'),(24,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDIyMTQzMCwiaWF0IjoxNzg5NjE2NjMwLCJqdGkiOiI2OWQzOWM5OTc0N2Y0ZGMyYWQwZjVjMzIyY2M0NDRmZSIsInVzZXJfaWQiOiIzIn0.AdPiH1piT_uQr9h4CMVtcK8VfEX_n8emUiWo3NsEWkM','2026-09-17 03:43:50.153776','2026-09-24 03:43:50.000000',3,'69d39c99747f4dc2ad0f5c322cc444fe'),(25,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDIyMTczNSwiaWF0IjoxNzg5NjE2OTM1LCJqdGkiOiI5ZDQ4ZGU2ODFiNjY0ZDQzYjZmYjhhYjVkNDFmMmRiOSIsInVzZXJfaWQiOiIzIn0.6u7UI0GLbkD-Wi_hdCTTouaIG4-D_25nu31dQrLoBuI','2026-09-17 03:48:55.203319','2026-09-24 03:48:55.000000',3,'9d48de681b664d43b6fb8ab5d41f2db9'),(26,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc5MDIyMjc5NywiaWF0IjoxNzg5NjE3OTk3LCJqdGkiOiJhMDYxYzE0ZTA4NjM0YjZjYWJjYzdlZjU1MTZmZjc3MyIsInVzZXJfaWQiOiIzIn0.fTSm_M4WJND1HjYjqg0Ks7lTJEeOA1ePjRBFDseCoUA','2026-09-17 04:06:37.970365','2026-09-24 04:06:37.000000',3,'a061c14e08634b6cabcc7ef5516ff773');
/*!40000 ALTER TABLE `token_blacklist_outstandingtoken` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-17 10:17:27
