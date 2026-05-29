-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: art_hub_db
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `arthub_cart`
--

DROP TABLE IF EXISTS `arthub_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arthub_cart` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `added_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `arthub_cart_user_id_4ea0d83a_fk_arthub_user_id` (`user_id`),
  KEY `arthub_cart_product_id_5f721126_fk_arthub_product_id` (`product_id`),
  CONSTRAINT `arthub_cart_product_id_5f721126_fk_arthub_product_id` FOREIGN KEY (`product_id`) REFERENCES `arthub_product` (`id`),
  CONSTRAINT `arthub_cart_user_id_4ea0d83a_fk_arthub_user_id` FOREIGN KEY (`user_id`) REFERENCES `arthub_user` (`id`),
  CONSTRAINT `arthub_cart_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arthub_cart`
--

LOCK TABLES `arthub_cart` WRITE;
/*!40000 ALTER TABLE `arthub_cart` DISABLE KEYS */;
INSERT INTO `arthub_cart` VALUES (32,1,'2025-05-15 10:11:34.438761',15,18),(34,1,'2025-05-15 10:12:10.648168',15,10),(36,1,'2025-05-17 06:00:12.515669',10,10),(37,1,'2025-05-17 10:39:18.356303',10,8);
/*!40000 ALTER TABLE `arthub_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arthub_order`
--

DROP TABLE IF EXISTS `arthub_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arthub_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `address` longtext NOT NULL,
  `email` varchar(254) NOT NULL,
  `order_date` datetime(6) NOT NULL,
  `expected_delivery_date` date NOT NULL,
  `user_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `order_id` char(32) NOT NULL,
  `payment_mode` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `arthub_order_product_id_68bd5d86_fk_arthub_product_id` (`product_id`),
  KEY `arthub_order_user_id_afa15a13_fk_arthub_user_id` (`user_id`),
  CONSTRAINT `arthub_order_product_id_68bd5d86_fk_arthub_product_id` FOREIGN KEY (`product_id`) REFERENCES `arthub_product` (`id`),
  CONSTRAINT `arthub_order_user_id_afa15a13_fk_arthub_user_id` FOREIGN KEY (`user_id`) REFERENCES `arthub_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arthub_order`
--

LOCK TABLES `arthub_order` WRITE;
/*!40000 ALTER TABLE `arthub_order` DISABLE KEYS */;
INSERT INTO `arthub_order` VALUES (2,'Darshan Bhagavat','6548219734','Angol Buda Colony House no 24','darshan1@gmail.com','2025-05-15 10:13:03.534934','2025-05-20',15,10,'28b18a277b4a4c8783c3f16de25971bd','Cash on Delivery'),(3,'Darshan Bhagavat','6548219734','Angol Buda Colony House no 24','darshan1@gmail.com','2025-05-15 10:13:57.461082','2025-05-20',15,18,'5ac2c4efed3c4747952dbb8e04430cc7','Cash on Delivery'),(4,'samruddhi patil','6361259022','Parijat Colony Angol Belagavi','sam1@gmail.com','2025-05-16 18:57:31.153229','2025-05-21',10,15,'fa402d7624b745ae9969a18bb5a07290','Cash on Delivery'),(5,'ashish devaram kuldeep ','8007413708','ayodhya nagar 2nd lane gadhinglaj-416502,kolhapur','ashishkuldeep@gmail.com','2025-05-17 05:20:16.013669','2025-05-22',10,8,'da3ea6d534234da4b863ee683e6f438e','Cash on Delivery'),(6,'ashish devaram kuldeep ','8007413708','ayodhya nagar 2nd lane gadhinglaj-416502,kolhapur','ashishkuldeep@gmail.com','2025-05-17 10:41:11.917424','2025-05-22',10,10,'2b60ca75da5640758a0f153023d4a7cd','Cash on Delivery');
/*!40000 ALTER TABLE `arthub_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arthub_product`
--

DROP TABLE IF EXISTS `arthub_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arthub_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `category` varchar(50) NOT NULL,
  `image` varchar(100) NOT NULL,
  `description` longtext,
  `price` decimal(10,2) NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `uploaded_by_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `arthub_product_uploaded_by_id_238e7e19_fk_arthub_user_id` (`uploaded_by_id`),
  CONSTRAINT `arthub_product_uploaded_by_id_238e7e19_fk_arthub_user_id` FOREIGN KEY (`uploaded_by_id`) REFERENCES `arthub_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arthub_product`
--

LOCK TABLES `arthub_product` WRITE;
/*!40000 ALTER TABLE `arthub_product` DISABLE KEYS */;
INSERT INTO `arthub_product` VALUES (8,'BUDDHA PAINTING','painting','product_images/Buddha_Art_-_Copy.jpg','MEDIUM :CRALIC \r\nSIZE   :30*20\r\nORIGINAL PAINTING',30000.00,'2025-05-15 06:57:05.156679',10),(9,'KANTARA','painting','product_images/download_2.jpg','MEDIUM : ACRALIC PAINTING , SIZE : 20*30, THIS IS ORIGINAL PAINTING OF THE KHATAK DANCE FORM ,REFRENCE OF A GREAT DANCER',29000.00,'2025-05-15 09:08:48.288980',10),(10,'TRIBE PAINTING','painting','product_images/download_5.jpg','MEDIUM : ACRALIC, SIZE : 20*30, ORIGINAL TRIBAL PAINTING REFRENCE OF ORIGINAL TRIBE PHOTO',9000.00,'2025-05-15 09:13:07.702324',10),(11,'NANDI','painting','product_images/download_1.jpg','MEDIUM : WATER COLOR, SIZE :20*15, THIS IS A BEAUTIFUL NANDI PAINTING IMAGINED THE NANDI OF MAHADEV',25000.00,'2025-05-15 09:27:32.845185',11),(12,'OWL','painting','product_images/download_9.jpg','MEDIUM : WATER PAINTING, SIZE :50*25, THIS IS AN BEAUTIFUL OWL PAINTING WHICH IS ORIGINAL AND A FORM OF DOODLE ART',19000.00,'2025-05-15 09:30:12.445818',11),(13,'PORTRAID','painting','product_images/download_6.jpg','MEDIUM : MIX , SIZE : 35*25, ORIGINAL PAINTING OF MORDERN AND TRADITIONAL MIX PORTRAID',28000.00,'2025-05-15 09:40:00.812251',12),(14,'FIRE BIRD','painting','product_images/Art.jpg','MEDIUM : ACRALIC, SIZE : 20*25, THIS IS ORIGINAL FIRE BIRD PAINTING FROM IMAGINARY WORLD',20000.00,'2025-05-15 09:44:02.085787',12),(15,'BRUSTO BRUSH','material','product_images/34a0e536-132a-447b-975c-f7b9153a14b4.jpg','BRUSTO COMPANY PRODUCTS',299.00,'2025-05-15 09:54:19.870879',13),(16,'STRECHED CANVAS','material','product_images/11_X_14_Inch_Stretched_Canvas_Value_Pack_of_7_-_Copy.jpg','SPECIAL STRECHED CANVAS IN A COMBO OF 4',1999.00,'2025-05-15 09:57:07.364169',13),(17,'WATER COLOR','material','product_images/0ef8b2ba-e112-4d34-b558-b520af157bf6_-_Copy_-_Copy.jpg','50+ SHADES OF WATER COLOR AVAILABLE , FREE BRUSH AVAIALBLE',499.00,'2025-05-15 10:04:25.378910',14),(18,'ACRALIC PAINT BOTTLE','material','product_images/1a1c2e72-badf-4e47-89a8-887d20756983_-_Copy.jpg','AVAILABLE IN 60+ SHADES AND PALLET FREE',999.00,'2025-05-15 10:05:35.270356',14);
/*!40000 ALTER TABLE `arthub_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arthub_purchasehistory`
--

DROP TABLE IF EXISTS `arthub_purchasehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arthub_purchasehistory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `purchased_at` datetime(6) NOT NULL,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `arthub_purchasehistory_product_id_48b1dc67_fk_arthub_product_id` (`product_id`),
  KEY `arthub_purchasehistory_user_id_47cef95f_fk_arthub_user_id` (`user_id`),
  CONSTRAINT `arthub_purchasehistory_product_id_48b1dc67_fk_arthub_product_id` FOREIGN KEY (`product_id`) REFERENCES `arthub_product` (`id`),
  CONSTRAINT `arthub_purchasehistory_user_id_47cef95f_fk_arthub_user_id` FOREIGN KEY (`user_id`) REFERENCES `arthub_user` (`id`),
  CONSTRAINT `arthub_purchasehistory_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arthub_purchasehistory`
--

LOCK TABLES `arthub_purchasehistory` WRITE;
/*!40000 ALTER TABLE `arthub_purchasehistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `arthub_purchasehistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arthub_user`
--

DROP TABLE IF EXISTS `arthub_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arthub_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `phone_number` varchar(10) NOT NULL,
  `email` varchar(254) NOT NULL,
  `user_type` varchar(20) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `profile_image` varchar(100) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arthub_user`
--

LOCK TABLES `arthub_user` WRITE;
/*!40000 ALTER TABLE `arthub_user` DISABLE KEYS */;
INSERT INTO `arthub_user` VALUES (10,'pbkdf2_sha256$1000000$YuVocJhVmY3iW1QLyP6upo$BAfiYCRC0DtLhu34iF+5juXfRLXAzxBMgqdPC4raWLY=','2025-05-17 10:35:48.604422','samruddhi patil','6361259022','sam1@gmail.com','artist','2025-05-15 06:50:12.313229',1,0,'profile_images/WhatsApp_Image_2025-05-15_at_12.42.38_70f8462c.jpg','I AM AN TRADITIONAL ARTISTR PASSIONATE ABOUT THE CULTURAL ART , FOLLOWING THE ACRALIC MEDIUM .'),(11,'pbkdf2_sha256$1000000$QxzEQZi6GZca2yQQTBnC8x$rbC1BIe2iJBaACd5mh5FcoQ6LCai/mrH44r4yEfh68s=','2025-05-15 09:20:02.123242','Parinitha patil','9456278653','pari@1gmail.com','artist','2025-05-15 09:19:54.146804',1,0,'profile_images/Parrot_Painting_Art_Bird_Lovers_Wildlife_Art_Print_Elegant_Nature-inspire_SdGwzOg.jpg','HELLO I AM PARINITHA PATIL FROM BELGAVI KARNATAKA , I AM PASSIONATED ARTIST AND DEDICATED MY WHOLE LIFE TO THE WORLD OF ART'),(12,'pbkdf2_sha256$1000000$32vPai6gyedyPCQe498J4o$C/t0uvca7lqGtUYTSiePc+gN+hYpNkw/vehj7BFAX4E=','2025-05-15 09:36:08.409620','Sanket Patil','654823497','Sanket1@gmail.com','artist','2025-05-15 09:36:00.939278',1,0,'profile_images/Bob_Marley_Street_Art_-_Ultra_High_Detail_Digital_Art_-_130cm_X_260cm_300_yFw7JT9.jpg','I AM AN ARTIS FROM BANGLORE AND PASSIONATED FOR ART IN TRADITIONAL AS WELL MORDERN ART AND I FOLLOW ABSTRACT STYLE'),(13,'pbkdf2_sha256$1000000$Rc7aMv1DEf4cDUROBrqKh1$cYPWA86OoIaPSS2Ee3OOeu5ADK7SBD8U2aOHtsRExN8=','2025-05-15 09:49:33.177292','Manish Sambrekar','6548279346','Manish1@gmail.com','shopkeeper','2025-05-15 09:49:25.493597',1,0,'profile_images/47bb7ca8-1da7-4bc4-9d6d-5851a0b84310.jpg','WE HAVE ALL TYPE OF BRUSHES SPECIAL BRUSH STALL AND EVEN MOST OF THE ART PRODUCTS WHICH ARTIST NEED'),(14,'pbkdf2_sha256$1000000$h6KBUXPeRNiRDREEvqw53f$56q+Y3YuljlFFJx03C+Y4mOKdoAEyWg+CkwoW8TgbxA=','2025-05-15 10:02:17.709106','Rajeshwari Mahajik','4589621735','rajeshwari1@gmail.com','shopkeeper','2025-05-15 10:02:12.044120',1,0,'profile_images/6ae242e8-9c5a-44b8-a944-1cddcdca9866_-_Copy.jpg','ALL TYPES OF COLORS , ACRALIC PAINTS , WATERCOLOR PAINTS , OIL PAINTS AND PALLETS ARE AVAILABLE HERE.'),(15,'pbkdf2_sha256$1000000$4xqQOhgtNC3e47NBDSjy7R$+lPLtAca+NXrqPDcHBCXuVmjfQgr9kaKTcGaTn0PJM8=','2025-05-17 06:09:29.842361','Darshan Bhagavat','6548219734','darshan1@gmail.com','buyer','2025-05-15 10:11:13.197460',1,0,'profile_images/default.png',NULL);
/*!40000 ALTER TABLE `arthub_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arthub_userprofile`
--

DROP TABLE IF EXISTS `arthub_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arthub_userprofile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `phone_number` varchar(10) NOT NULL,
  `profile_image` varchar(100) DEFAULT NULL,
  `user_type` varchar(20) NOT NULL,
  `description` longtext,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `arthub_userprofile_user_id_3af3f4b9_fk_arthub_user_id` FOREIGN KEY (`user_id`) REFERENCES `arthub_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arthub_userprofile`
--

LOCK TABLES `arthub_userprofile` WRITE;
/*!40000 ALTER TABLE `arthub_userprofile` DISABLE KEYS */;
/*!40000 ALTER TABLE `arthub_userprofile` ENABLE KEYS */;
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
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add product',7,'add_product'),(26,'Can change product',7,'change_product'),(27,'Can delete product',7,'delete_product'),(28,'Can view product',7,'view_product'),(29,'Can add cart',8,'add_cart'),(30,'Can change cart',8,'change_cart'),(31,'Can delete cart',8,'delete_cart'),(32,'Can view cart',8,'view_cart'),(33,'Can add purchase history',9,'add_purchasehistory'),(34,'Can change purchase history',9,'change_purchasehistory'),(35,'Can delete purchase history',9,'delete_purchasehistory'),(36,'Can view purchase history',9,'view_purchasehistory'),(37,'Can add order',10,'add_order'),(38,'Can change order',10,'change_order'),(39,'Can delete order',10,'delete_order'),(40,'Can view order',10,'view_order'),(41,'Can add user profile',11,'add_userprofile'),(42,'Can change user profile',11,'change_userprofile'),(43,'Can delete user profile',11,'delete_userprofile'),(44,'Can view user profile',11,'view_userprofile');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
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
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_arthub_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_arthub_user_id` FOREIGN KEY (`user_id`) REFERENCES `arthub_user` (`id`),
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
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(8,'arthub','cart'),(10,'arthub','order'),(7,'arthub','product'),(9,'arthub','purchasehistory'),(6,'arthub','user'),(11,'arthub','userprofile'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(5,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-04-28 04:38:59.254660'),(2,'arthub','0001_initial','2025-04-28 04:38:59.689303'),(3,'admin','0001_initial','2025-04-28 04:38:59.862631'),(4,'admin','0002_logentry_remove_auto_add','2025-04-28 04:38:59.873301'),(5,'admin','0003_logentry_add_action_flag_choices','2025-04-28 04:38:59.886337'),(6,'contenttypes','0002_remove_content_type_name','2025-04-28 04:39:00.062944'),(7,'auth','0001_initial','2025-04-28 04:39:00.387535'),(8,'auth','0002_alter_permission_name_max_length','2025-04-28 04:39:00.471586'),(9,'auth','0003_alter_user_email_max_length','2025-04-28 04:39:00.477846'),(10,'auth','0004_alter_user_username_opts','2025-04-28 04:39:00.482882'),(11,'auth','0005_alter_user_last_login_null','2025-04-28 04:39:00.492440'),(12,'auth','0006_require_contenttypes_0002','2025-04-28 04:39:00.497117'),(13,'auth','0007_alter_validators_add_error_messages','2025-04-28 04:39:00.506442'),(14,'auth','0008_alter_user_username_max_length','2025-04-28 04:39:00.512805'),(15,'auth','0009_alter_user_last_name_max_length','2025-04-28 04:39:00.520025'),(16,'auth','0010_alter_group_name_max_length','2025-04-28 04:39:00.541374'),(17,'auth','0011_update_proxy_permissions','2025-04-28 04:39:00.553273'),(18,'auth','0012_alter_user_first_name_max_length','2025-04-28 04:39:00.559033'),(19,'sessions','0001_initial','2025-04-28 04:39:00.600269'),(20,'arthub','0002_order','2025-05-01 08:10:44.018732'),(23,'arthub','0003_alter_order_expected_delivery_date','2025-05-04 12:28:15.159394'),(24,'arthub','0004_remove_order_cash_on_delivery_remove_order_quantity_and_more','2025-05-06 17:30:59.318145'),(25,'arthub','0005_alter_user_phone_number','2025-05-07 10:59:47.709399'),(26,'arthub','0006_rename_buyer_order_user','2025-05-07 17:38:42.409130');
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
INSERT INTO `django_session` VALUES ('iltmp796yiovmtandahcxnos57lr6f8o','.eJxVjDsOwyAQRO9CHSEW802Z3mdACwvBSYQlY1dR7h5bcpGUM-_NvFnAba1h63kJE7ErA8Euv2XE9MztIPTAdp95mtu6TJEfCj9p5-NM-XU73b-Dir3ua09Dyb5IUzBaY0gOJVqUNoFKIBEBtM8oJETtINk9KyWKME6QVtoZ9vkCEm43jw:1uGEtQ:ivJEZCWxYbHHyv1k6IDST9O5ylIczi_OUasiTJ0faG4','2025-05-31 10:35:48.615258'),('j19px6jod7gduizycrwl1z5idkbxltlr','.eJxVjDsOwyAQBe9CHSH-hpTpfQbELktwEmHJ2FWUu0dILpL2zcx7s5iOvcaj0xaXzK7MscvvBgmf1AbIj9TuK8e17dsCfCj8pJ3Pa6bX7XT_DmrqddQanbC2KMokNagCqE0gb10BJTzZyRunk5pQiyKNsUkECQU1eRUQBPt8Aem8N88:1uCbrM:lqj9Pnp2SQ6opfpJEiTYEyR9OXQ7O-AKplVA09YLRmY','2025-05-21 10:18:40.253671'),('p7upci3xrh7g9mq69mhfini055dwmphz','.eJxVjDsOgzAQRO_iOrL8WYOdMj1nsHbtJSaJjIShinL3gESRlDPz3rxFxG0tcWu8xCmLq-jF5bcjTE-ux5AfWO-zTHNdl4nkgchzbXKYM79uJ_t3ULCV3QZnlWdQFFyXyXa7OeZkmCho9MRKhQSj1dBZ1J61cRD26IwK2IMH8fkC6kc3ag:1uDoGB:W0KXhl35c_v6wt1j48AWKd0pJDBSckjk1-1qx4fQW58','2025-05-24 17:45:15.876423');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-17 20:45:55
