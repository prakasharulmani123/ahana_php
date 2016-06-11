/*
SQLyog Ultimate v8.55 
MySQL - 5.6.14 : Database - ahana
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `app_configuration` */

DROP TABLE IF EXISTS `app_configuration`;

CREATE TABLE `app_configuration` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `key` text NOT NULL,
  `value` text NOT NULL,
  `notes` varchar(50) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`config_id`),
  KEY `FK_app_configuration_tenant` (`tenant_id`),
  CONSTRAINT `FK_app_configuration_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

/*Data for the table `app_configuration` */

insert  into `app_configuration`(`config_id`,`tenant_id`,`code`,`key`,`value`,`notes`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,60,'RC','ROOM_CHARGE_CONFIG','11',NULL,'0',0,'2016-05-02 18:16:02',51,'2016-05-03 12:43:57','2016-05-03 12:43:57'),(2,60,'ET','ELAPSED_TIME','3600','seconds','1',0,'2016-05-02 18:28:32',51,'2016-06-09 17:32:45','0000-00-00 00:00:00'),(3,60,'ENCOUNTER','SHARE_ENCOUNTER','1','Share Encounter','1',0,'2016-06-09 16:28:56',51,'2016-06-09 17:13:42','0000-00-00 00:00:00'),(4,60,'NOTES','SHARE_NOTES','1','Share Notes','1',0,'2016-06-09 16:29:20',51,'2016-06-09 17:13:42','0000-00-00 00:00:00'),(5,60,'CONSULTANT','SHARE_CONSULTANT','1','Share Consultant','1',0,'2016-06-09 16:30:18',51,'2016-06-09 17:13:42','0000-00-00 00:00:00'),(6,60,'ALERT','SHARE_ALERT','1','Share Alert','1',0,'2016-06-09 16:30:43',51,'2016-06-09 17:13:42','0000-00-00 00:00:00'),(7,60,'VITALS','SHARE_VITALS','1','Share Vitals','1',0,'2016-06-09 16:31:02',51,'2016-06-09 17:13:42','0000-00-00 00:00:00'),(8,60,'PRESCRIPTION','SHARE_PRESCRIPTION','0','Share Prescription','1',0,'2016-06-09 16:31:22',51,'2016-06-09 17:13:42','0000-00-00 00:00:00'),(9,68,'ET','ELAPSED_TIME','3600','seconds','1',-1,'2016-06-09 19:23:22',-1,'2016-06-09 19:23:22','0000-00-00 00:00:00'),(10,68,'ENCOUNTER','SHARE_ENCOUNTER','0','Share Encounter','1',-1,'2016-06-09 19:23:22',-1,'2016-06-09 19:23:22','0000-00-00 00:00:00'),(11,68,'NOTES','SHARE_NOTES','0','Share Notes','1',-1,'2016-06-09 19:23:22',-1,'2016-06-09 19:23:22','0000-00-00 00:00:00'),(12,68,'CONSULTANT','SHARE_CONSULTANT','0','Share Consultant','1',-1,'2016-06-09 19:23:22',-1,'2016-06-09 19:23:22','0000-00-00 00:00:00'),(13,68,'ALERT','SHARE_ALERT','1','Share Alert','1',-1,'2016-06-09 19:23:22',-1,'2016-06-09 19:23:22','0000-00-00 00:00:00'),(14,68,'VITALS','SHARE_VITALS','1','Share Vitals','1',-1,'2016-06-09 19:23:22',-1,'2016-06-09 19:23:22','0000-00-00 00:00:00'),(15,68,'PRESCRIPTION','SHARE_PRESCRIPTION','0','Share Prescription','1',-1,'2016-06-09 19:23:22',-1,'2016-06-09 19:23:22','0000-00-00 00:00:00'),(16,58,'ET','ELAPSED_TIME','3600','seconds','1',-1,'2016-06-10 11:43:42',-1,'2016-06-10 11:43:42','0000-00-00 00:00:00'),(17,58,'ENCOUNTER','SHARE_ENCOUNTER','1','Share Encounter','1',-1,'2016-06-10 11:43:42',-1,'2016-06-10 11:43:42','0000-00-00 00:00:00'),(18,58,'NOTES','SHARE_NOTES','1','Share Notes','1',-1,'2016-06-10 11:43:42',-1,'2016-06-10 11:43:42','0000-00-00 00:00:00'),(19,58,'CONSULTANT','SHARE_CONSULTANT','1','Share Consultant','1',-1,'2016-06-10 11:43:42',-1,'2016-06-10 11:43:42','0000-00-00 00:00:00'),(20,58,'ALERT','SHARE_ALERT','1','Share Alert','1',-1,'2016-06-10 11:43:42',-1,'2016-06-10 11:43:42','0000-00-00 00:00:00'),(21,58,'VITALS','SHARE_VITALS','1','Share Vitals','1',-1,'2016-06-10 11:43:42',-1,'2016-06-10 11:43:42','0000-00-00 00:00:00'),(22,58,'PRESCRIPTION','SHARE_PRESCRIPTION','1','Share Prescription','1',-1,'2016-06-10 11:43:42',-1,'2016-06-10 11:43:42','0000-00-00 00:00:00'),(23,58,'BASIC_DATA','SHARE_BASIC_DATA','1','SHARE_BASIC_DATA','1',-1,'2016-06-11 19:01:50',NULL,NULL,'0000-00-00 00:00:00');

/*Table structure for table `co_alert` */

DROP TABLE IF EXISTS `co_alert`;

CREATE TABLE `co_alert` (
  `alert_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `alert_name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`alert_id`),
  UNIQUE KEY `CoAlertUnique` (`tenant_id`,`alert_name`,`deleted_at`),
  CONSTRAINT `FK_co_alert_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `co_alert` */

insert  into `co_alert`(`alert_id`,`tenant_id`,`alert_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'new','1',51,'2016-02-19 01:33:25',51,'2016-02-19 01:33:25','0000-00-00 00:00:00'),(2,60,'Warning','1',59,'2016-02-21 22:31:39',59,'2016-02-21 22:31:39','0000-00-00 00:00:00'),(3,60,'new','1',59,'2016-02-21 22:31:47',59,'2016-02-21 22:31:47','0000-00-00 00:00:00'),(4,60,'waiting','1',59,'2016-02-21 22:31:55',59,'2016-02-21 22:31:55','0000-00-00 00:00:00'),(5,61,'test','1',67,'2016-02-23 02:20:48',67,'2016-02-23 02:20:48','0000-00-00 00:00:00'),(6,58,'Alertttt','1',51,'2016-04-16 12:55:34',51,'2016-04-16 12:55:34','0000-00-00 00:00:00');

/*Table structure for table `co_allied_charge` */

DROP TABLE IF EXISTS `co_allied_charge`;

CREATE TABLE `co_allied_charge` (
  `allied_charge_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `allied_charge_name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`allied_charge_id`),
  KEY `co_allied_charge_tenant` (`tenant_id`),
  CONSTRAINT `FK_co_allied_charge_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `co_allied_charge` */

/*Table structure for table `co_charge_per_category` */

DROP TABLE IF EXISTS `co_charge_per_category`;

CREATE TABLE `co_charge_per_category` (
  `charge_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `charge_cat_type` enum('C','P') NOT NULL DEFAULT 'C' COMMENT 'C -> Category, P -> Professional',
  `charge_cat_id` int(11) DEFAULT NULL COMMENT 'If -1 means related to user_id',
  `charge_code_id` int(11) NOT NULL COMMENT 'Link with user_id & room_charge_subcategory_id',
  `charge_default` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`charge_id`),
  UNIQUE KEY `CoChargePerCategoryUnique` (`tenant_id`,`charge_cat_type`,`charge_cat_id`,`charge_code_id`,`deleted_at`),
  CONSTRAINT `FK_co_charge_per_category_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `co_charge_per_category` */

insert  into `co_charge_per_category`(`charge_id`,`tenant_id`,`charge_cat_type`,`charge_cat_id`,`charge_code_id`,`charge_default`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (3,58,'C',1,22,'250','2016-02-04 22:36:47',51,'2016-03-02 12:55:14',51,'0000-00-00 00:00:00'),(4,58,'C',5,26,'150','2016-02-09 02:22:54',51,'2016-02-20 04:23:56',62,'0000-00-00 00:00:00'),(5,58,'C',5,25,NULL,'2016-02-09 02:24:37',51,'2016-02-09 02:24:37',51,'0000-00-00 00:00:00'),(6,58,'P',-1,56,'352','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(7,58,'P',-1,54,'100','2016-02-17 04:36:29',51,'2016-03-21 15:59:29',51,'0000-00-00 00:00:00'),(8,60,'P',-1,65,'200','2016-02-19 07:53:17',59,'2016-02-19 07:53:17',59,'0000-00-00 00:00:00'),(9,60,'P',-1,60,'100','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(10,60,'P',-1,61,'100','2016-02-19 23:22:28',59,'2016-02-19 23:22:28',59,'0000-00-00 00:00:00'),(11,58,'P',-1,58,'100','2016-02-20 02:17:57',62,'2016-02-20 02:17:57',62,'0000-00-00 00:00:00'),(12,60,'C',1,35,'100','2016-02-20 03:29:39',59,'2016-02-20 03:29:39',59,'0000-00-00 00:00:00'),(13,61,'P',-1,68,'200','2016-02-22 00:01:27',67,'2016-02-23 02:19:20',67,'0000-00-00 00:00:00'),(14,58,'C',1,39,'200','2016-03-22 15:35:18',51,'2016-03-22 15:35:18',51,'0000-00-00 00:00:00');

/*Table structure for table `co_charge_per_subcategory` */

DROP TABLE IF EXISTS `co_charge_per_subcategory`;

CREATE TABLE `co_charge_per_subcategory` (
  `sub_charge_id` int(11) NOT NULL AUTO_INCREMENT,
  `charge_id` int(11) NOT NULL,
  `charge_type` enum('IP','OP') NOT NULL,
  `charge_link_id` int(11) NOT NULL COMMENT 'Link with patient_category_id & room_type_id',
  `charge_amount` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`sub_charge_id`),
  KEY `FK_co_charge_per_subcategory_category` (`charge_id`),
  CONSTRAINT `FK_co_charge_per_subcategory_category` FOREIGN KEY (`charge_id`) REFERENCES `co_charge_per_category` (`charge_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;

/*Data for the table `co_charge_per_subcategory` */

insert  into `co_charge_per_subcategory`(`sub_charge_id`,`charge_id`,`charge_type`,`charge_link_id`,`charge_amount`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (1,3,'IP',9,'111.00','2016-02-04 22:36:48',51,'2016-02-04 22:36:48',51,'0000-00-00 00:00:00'),(2,3,'IP',10,'111.00','2016-02-04 22:36:48',51,'2016-02-04 22:36:48',51,'0000-00-00 00:00:00'),(3,3,'IP',11,'111.00','2016-02-04 22:36:48',51,'2016-02-04 22:36:48',51,'0000-00-00 00:00:00'),(4,4,'IP',9,'1000.00','2016-02-09 02:22:55',51,'2016-02-09 02:22:55',51,'0000-00-00 00:00:00'),(5,4,'IP',10,'1200.00','2016-02-09 02:22:55',51,'2016-02-09 02:22:55',51,'0000-00-00 00:00:00'),(6,4,'IP',11,'1500.00','2016-02-09 02:22:55',51,'2016-02-09 02:22:55',51,'0000-00-00 00:00:00'),(7,4,'IP',12,'1900.00','2016-02-09 02:22:55',51,'2016-02-09 02:22:55',51,'0000-00-00 00:00:00'),(8,4,'IP',13,'2000.00','2016-02-09 02:22:55',51,'2016-02-09 02:22:55',51,'0000-00-00 00:00:00'),(9,5,'IP',9,'1111.00','2016-02-09 02:24:57',51,'2016-02-09 02:24:57',51,'0000-00-00 00:00:00'),(10,5,'IP',10,'11111.00','2016-02-09 02:24:57',51,'2016-02-09 02:24:57',51,'0000-00-00 00:00:00'),(11,5,'IP',11,'1111.00','2016-02-09 02:24:57',51,'2016-02-09 02:24:57',51,'0000-00-00 00:00:00'),(12,5,'IP',12,'11111.00','2016-02-09 02:24:57',51,'2016-02-09 02:24:57',51,'0000-00-00 00:00:00'),(13,5,'IP',13,'2222.00','2016-02-09 02:24:57',51,'2016-02-09 02:24:57',51,'0000-00-00 00:00:00'),(14,6,'OP',4,'100.00','2016-02-17 04:35:32',51,'2016-03-02 12:54:38',51,'0000-00-00 00:00:00'),(15,6,'OP',5,'200.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(16,6,'OP',6,'300.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(17,6,'IP',9,'100.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(18,6,'IP',10,'20.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(19,6,'IP',11,'33.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(20,6,'IP',12,'11.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(21,6,'IP',13,'15.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(22,7,'OP',4,'100.00','2016-02-17 04:36:29',51,'2016-02-17 04:36:29',51,'0000-00-00 00:00:00'),(23,7,'OP',5,'100.00','2016-02-17 04:36:29',51,'2016-02-17 04:36:29',51,'0000-00-00 00:00:00'),(24,7,'OP',6,'100.00','2016-02-17 04:36:29',51,'2016-02-17 04:36:29',51,'0000-00-00 00:00:00'),(25,7,'IP',9,'180.00','2016-02-17 04:36:29',51,'2016-03-21 15:59:17',51,'0000-00-00 00:00:00'),(26,7,'IP',10,'100.00','2016-02-17 04:36:29',51,'2016-03-21 15:59:11',51,'0000-00-00 00:00:00'),(27,7,'IP',11,'120.00','2016-02-17 04:36:29',51,'2016-02-25 04:10:33',51,'0000-00-00 00:00:00'),(28,7,'IP',12,'200.00','2016-02-17 04:36:29',51,'2016-02-17 04:36:29',51,'0000-00-00 00:00:00'),(29,7,'IP',13,'200.00','2016-02-17 04:36:29',51,'2016-02-17 04:36:29',51,'0000-00-00 00:00:00'),(30,6,'OP',7,'400.00','2016-02-19 07:45:04',51,'2016-02-19 07:45:04',51,'0000-00-00 00:00:00'),(31,8,'OP',8,'100.00','2016-02-19 07:53:18',59,'2016-02-19 07:53:18',59,'0000-00-00 00:00:00'),(32,8,'OP',9,'100.00','2016-02-19 07:53:18',59,'2016-02-19 07:53:18',59,'0000-00-00 00:00:00'),(33,8,'OP',10,'101.00','2016-02-19 07:53:18',59,'2016-02-19 07:53:18',59,'0000-00-00 00:00:00'),(34,8,'OP',11,'102.00','2016-02-19 07:53:18',59,'2016-02-19 07:53:18',59,'0000-00-00 00:00:00'),(35,8,'OP',12,'103.00','2016-02-19 07:53:18',59,'2016-02-19 07:53:18',59,'0000-00-00 00:00:00'),(36,9,'OP',8,'101.00','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(37,9,'OP',9,'102.00','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(38,9,'OP',10,'103.00','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(39,9,'OP',11,'104.00','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(40,9,'OP',12,'105.00','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(41,10,'OP',8,'101.00','2016-02-19 23:29:21',59,'2016-02-19 23:29:21',59,'0000-00-00 00:00:00'),(42,3,'OP',4,'500.00','2016-02-20 01:21:12',62,'2016-02-20 01:21:12',62,'0000-00-00 00:00:00'),(43,3,'OP',5,'600.00','2016-02-20 01:21:22',62,'2016-02-20 01:21:22',62,'0000-00-00 00:00:00'),(44,11,'OP',4,'100.00','2016-02-20 02:17:57',62,'2016-02-20 02:17:57',62,'0000-00-00 00:00:00'),(45,12,'OP',8,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(46,12,'OP',9,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(47,12,'OP',10,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(48,12,'OP',11,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(49,12,'OP',12,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(50,12,'IP',14,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(51,12,'IP',15,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(52,12,'IP',16,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(53,13,'OP',14,'200.00','2016-02-23 04:52:20',67,'2016-02-23 04:52:20',67,'0000-00-00 00:00:00'),(54,3,'IP',12,'100.00','2016-03-21 11:47:33',51,'2016-03-21 11:47:33',51,'0000-00-00 00:00:00'),(55,7,'OP',7,'200.00','2016-03-21 15:58:51',51,'2016-03-21 15:58:51',51,'0000-00-00 00:00:00'),(56,7,'OP',13,'600.00','2016-03-21 15:58:55',51,'2016-03-21 15:58:55',51,'0000-00-00 00:00:00'),(57,7,'OP',13,'150.00','2016-03-21 15:59:23',51,'2016-03-21 15:59:23',51,'0000-00-00 00:00:00'),(58,14,'OP',4,'200.00','2016-03-22 15:35:18',51,'2016-03-22 15:35:18',51,'0000-00-00 00:00:00'),(59,14,'OP',13,'200.00','2016-03-22 15:35:18',51,'2016-03-22 15:35:18',51,'0000-00-00 00:00:00'),(60,14,'OP',6,'200.00','2016-03-22 15:35:18',51,'2016-03-22 15:35:18',51,'0000-00-00 00:00:00'),(61,14,'OP',5,'200.00','2016-03-22 15:35:18',51,'2016-03-22 15:35:18',51,'0000-00-00 00:00:00'),(62,14,'OP',7,'200.00','2016-03-22 15:35:18',51,'2016-03-22 15:35:18',51,'0000-00-00 00:00:00'),(63,14,'IP',9,'200.00','2016-03-22 15:35:18',51,'2016-03-22 15:35:18',51,'0000-00-00 00:00:00'),(64,14,'IP',11,'200.00','2016-03-22 15:35:18',51,'2016-03-22 15:35:18',51,'0000-00-00 00:00:00'),(65,14,'IP',10,'200.00','2016-03-22 15:35:18',51,'2016-03-22 15:35:18',51,'0000-00-00 00:00:00'),(66,14,'IP',13,'200.00','2016-03-22 15:35:18',51,'2016-03-22 15:35:18',51,'0000-00-00 00:00:00'),(67,14,'IP',12,'200.00','2016-03-22 15:35:19',51,'2016-03-22 15:35:19',51,'0000-00-00 00:00:00');

/*Table structure for table `co_doctor_schedule` */

DROP TABLE IF EXISTS `co_doctor_schedule`;

CREATE TABLE `co_doctor_schedule` (
  `schedule_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `schedule_day` enum('1','2','3','4','5','6','7','-1') NOT NULL COMMENT '-1 means All day',
  `schedule_time_in` time NOT NULL,
  `schedule_time_out` time NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int(11) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`schedule_id`),
  KEY `FK_co_doctor_schedule_tenant` (`tenant_id`),
  KEY `FK_co_doctor_schedule_user` (`user_id`),
  CONSTRAINT `FK_co_doctor_schedule_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_co_doctor_schedule_user` FOREIGN KEY (`user_id`) REFERENCES `co_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `co_doctor_schedule` */

insert  into `co_doctor_schedule`(`schedule_id`,`tenant_id`,`user_id`,`schedule_day`,`schedule_time_in`,`schedule_time_out`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (1,58,54,'-1','07:30:00','08:00:00','2016-02-04 22:40:42',51,'2016-02-04 22:40:42',51,'2016-02-04 22:41:31'),(2,58,54,'-1','05:00:00','07:30:00','2016-02-04 22:40:42',51,'2016-02-04 22:40:42',51,'2016-02-04 22:41:31'),(3,58,56,'-1','11:00:00','12:00:00','2016-02-17 00:45:37',51,'2016-02-17 00:45:37',10,'2016-03-17 15:33:53'),(4,60,60,'-1','09:00:00','10:00:00','2016-02-17 06:33:58',59,'2016-02-17 06:33:58',59,'0000-00-00 00:00:00'),(5,60,61,'-1','00:30:00','03:00:00','2016-02-19 23:24:54',59,'2016-02-19 23:24:54',59,'0000-00-00 00:00:00'),(6,60,65,'-1','16:00:00','18:00:00','2016-02-20 03:30:18',59,'2016-02-20 03:30:18',59,'0000-00-00 00:00:00'),(7,60,64,'-1','22:30:00','23:00:00','2016-02-20 03:30:32',59,'2016-02-20 03:30:32',59,'0000-00-00 00:00:00'),(8,61,68,'-1','01:00:00','00:00:00','2016-02-21 23:26:35',67,'2016-02-21 23:26:35',19,'2016-02-21 23:34:57'),(9,61,68,'-1','02:00:00','00:00:00','2016-02-21 23:27:24',67,'2016-02-21 23:27:24',19,'2016-02-21 23:34:55'),(10,61,68,'-1','10:30:00','23:30:00','2016-02-21 23:35:20',67,'2016-02-21 23:35:20',19,'2016-02-23 05:12:53'),(11,58,56,'-1','20:30:00','21:00:00','2016-03-17 15:33:19',51,'2016-03-17 15:33:19',10,'2016-03-17 15:33:54'),(12,58,54,'-1','10:00:00','14:00:00','2016-03-17 15:37:02',51,'2016-05-03 15:53:36',51,'0000-00-00 00:00:00'),(13,58,54,'1','17:00:00','19:00:00','2016-03-17 15:39:18',51,'2016-05-03 15:53:50',51,'0000-00-00 00:00:00'),(14,58,54,'2','09:00:00','14:00:00','2016-05-03 18:01:15',51,'2016-05-03 19:34:50',51,'0000-00-00 00:00:00');

/*Table structure for table `co_floor` */

DROP TABLE IF EXISTS `co_floor`;

CREATE TABLE `co_floor` (
  `floor_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `floor_name` varchar(50) NOT NULL,
  `floor_code` char(2) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`floor_id`),
  UNIQUE KEY `FloorNameUnique` (`floor_name`,`tenant_id`,`deleted_at`),
  KEY `FK_co_floor_tenant` (`tenant_id`),
  CONSTRAINT `FK_co_floor_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

/*Data for the table `co_floor` */

insert  into `co_floor`(`floor_id`,`tenant_id`,`floor_name`,`floor_code`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (7,58,'Ground Floor','1','1',51,'2016-02-04 07:15:34',51,'2016-02-04 07:15:34','0000-00-00 00:00:00'),(8,58,'Floor 1','2','1',51,'2016-02-04 07:15:44',51,'2016-02-04 07:15:44','0000-00-00 00:00:00'),(9,58,'Floor 2','3','1',51,'2016-02-04 07:15:54',51,'2016-02-04 07:15:54','0000-00-00 00:00:00'),(10,59,'1','1','1',52,'2016-02-05 06:47:59',52,'2016-02-05 06:47:59','0000-00-00 00:00:00'),(14,58,'111','90','1',51,'2016-02-15 06:49:27',51,'2016-04-16 11:51:07','0000-00-00 00:00:00'),(15,58,'11231','9','1',51,'2016-02-15 07:17:28',NULL,'2016-03-02 16:46:33','0000-00-00 00:00:00'),(16,60,'Ground Floor','01','1',59,'2016-02-19 22:25:45',59,'2016-02-19 22:25:45','0000-00-00 00:00:00'),(17,60,'First Floor','02','1',59,'2016-02-20 01:10:57',59,'2016-02-20 01:10:57','0000-00-00 00:00:00'),(18,60,'Second Floor','03','1',59,'2016-02-20 01:13:41',59,'2016-02-20 01:13:41','0000-00-00 00:00:00'),(19,61,'Floor1','F1','1',67,'2016-02-23 02:33:20',67,'2016-02-23 02:33:20','0000-00-00 00:00:00'),(20,61,'Floor2','F2','1',67,'2016-02-23 02:33:36',67,'2016-02-23 02:33:36','0000-00-00 00:00:00');

/*Table structure for table `co_internal_code` */

DROP TABLE IF EXISTS `co_internal_code`;

CREATE TABLE `co_internal_code` (
  `internal_code_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `code_type` varchar(2) NOT NULL DEFAULT 'B' COMMENT 'B - Bill, P - Patient, PU -> Purchase',
  `code_prefix` varchar(10) NOT NULL,
  `code` int(11) NOT NULL,
  `code_padding` tinyint(4) NOT NULL DEFAULT '7',
  `code_suffix` varchar(10) DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int(11) NOT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`internal_code_id`),
  UNIQUE KEY `code_unique` (`tenant_id`,`code_type`),
  KEY `FK_co_internal_code` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

/*Data for the table `co_internal_code` */

insert  into `co_internal_code`(`internal_code_id`,`tenant_id`,`code_type`,`code_prefix`,`code`,`code_padding`,`code_suffix`,`status`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (2,58,'B','AH',55,7,NULL,'1','2016-06-11 18:52:10',-1,'2016-06-11 18:52:10',51,'0000-00-00 00:00:00'),(3,58,'P','AH',73,7,NULL,'1','2016-06-11 18:16:20',-1,'2016-06-11 18:16:20',51,'0000-00-00 00:00:00'),(4,59,'B','AR',1,7,NULL,'1','2016-02-02 22:43:11',-1,'2016-02-02 22:43:11',-1,'0000-00-00 00:00:00'),(5,59,'P','AR',2,7,NULL,'1','2016-06-09 10:41:59',-1,'2016-06-09 10:41:59',51,'0000-00-00 00:00:00'),(6,60,'B','RA',11,7,NULL,'1','2016-06-08 15:33:59',-1,'2016-06-08 15:33:59',51,'0000-00-00 00:00:00'),(7,60,'P','RA',19,7,NULL,'1','2016-06-09 19:09:57',-1,'2016-06-09 19:09:57',51,'0000-00-00 00:00:00'),(8,61,'B','TE',34343434,7,NULL,'1','2016-02-23 02:20:29',-1,'2016-02-23 02:20:29',67,'0000-00-00 00:00:00'),(9,61,'P','TE',2,7,NULL,'1','2016-02-21 23:20:06',-1,'2016-02-21 23:20:06',67,'0000-00-00 00:00:00'),(10,62,'B','TE',1,7,NULL,'1','2016-02-29 02:00:01',-1,'2016-02-29 02:00:01',-1,'0000-00-00 00:00:00'),(11,62,'P','TE',1,7,NULL,'1','2016-02-29 02:00:01',-1,'2016-02-29 02:00:01',-1,'0000-00-00 00:00:00'),(12,58,'PU','AH',20,7,NULL,'1','2016-03-31 16:00:45',-1,'2016-03-31 16:00:45',51,'0000-00-00 00:00:00'),(13,58,'PR','PR',5,7,NULL,'1','2016-03-11 15:15:03',-1,'2016-03-11 15:15:03',51,'0000-00-00 00:00:00'),(14,68,'B','K.',1,7,NULL,'1','2016-06-09 19:23:21',-1,'2016-06-09 19:23:21',-1,'0000-00-00 00:00:00'),(15,68,'P','K.',4,7,NULL,'1','2016-06-10 10:41:36',-1,'2016-06-10 10:41:36',51,'0000-00-00 00:00:00'),(16,68,'PU','K.',1,7,NULL,'1','2016-06-09 19:23:21',-1,'2016-06-09 19:23:21',-1,'0000-00-00 00:00:00'),(17,68,'PR','K.',1,7,NULL,'1','2016-06-09 19:23:21',-1,'2016-06-09 19:23:21',-1,'0000-00-00 00:00:00'),(18,69,'B','RK',1,7,NULL,'1','2016-06-10 11:43:42',-1,'2016-06-10 11:43:42',-1,'0000-00-00 00:00:00'),(19,69,'P','RK',1,7,NULL,'1','2016-06-10 11:43:42',-1,'2016-06-10 11:43:42',-1,'0000-00-00 00:00:00'),(20,69,'PU','RK',1,7,NULL,'1','2016-06-10 11:43:42',-1,'2016-06-10 11:43:42',-1,'0000-00-00 00:00:00'),(21,69,'PR','RK',1,7,NULL,'1','2016-06-10 11:43:42',-1,'2016-06-10 11:43:42',-1,'0000-00-00 00:00:00');

/*Table structure for table `co_login` */

DROP TABLE IF EXISTS `co_login`;

CREATE TABLE `co_login` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `password_reset_token` varchar(255) DEFAULT NULL,
  `authtoken` varchar(255) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `activation_date` date DEFAULT NULL,
  `Inactivation_date` date DEFAULT NULL,
  `logged_tenant_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`login_id`),
  KEY `FK_co_login_user` (`user_id`),
  CONSTRAINT `FK_co_login_user` FOREIGN KEY (`user_id`) REFERENCES `co_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

/*Data for the table `co_login` */

insert  into `co_login`(`login_id`,`user_id`,`username`,`password`,`password_reset_token`,`authtoken`,`created_by`,`created_at`,`modified_by`,`modified_at`,`activation_date`,`Inactivation_date`,`logged_tenant_id`) values (10,51,'vikhram','$2y$13$fiIoeo1BUmyPw1bx4fSe/.ePp7Xh.K9uXqZa6.j4UQa6rN5TBJzT.','b1SD_pk2esmjHp5RiON3wzGPpzmDxS0q_1457939704','dmlraHJhbTE0NjU2MjQ0OTczOTIx',-1,'2016-02-02 22:26:39',NULL,'2016-06-11 11:24:57',NULL,NULL,58),(11,52,'ark','$2y$13$4T7TlDr8in4ydQTVxEfTke.donWnYhKLOJG8r/c78g.UXuXeqfNFO',NULL,'YXJrMTQ1NDk5MDU0NTE1MTg=',-1,'2016-02-02 22:43:12',NULL,'2016-02-08 22:02:25',NULL,NULL,NULL),(12,54,'John','$2y$13$/mlVvR83V.H4qLbC1wGelenerJWeBGEF1SYMWeAXJ9FxzF9vvTyR2',NULL,'Sm9objE0NjM3MTg5OTI4NjIy',51,'2016-02-04 07:07:43',NULL,'2016-05-20 10:06:32','2016-02-04','2016-02-28',58),(13,56,'surya','$2y$13$lpvuN2LSd2zOqt5Mx4TdmeuGcgBa7YuOsBwRdHLtKQrd3uioJioeq',NULL,'c3VyeWExNDU1NTQxODM1ODkwOQ==',51,'2016-02-05 22:50:58',NULL,'2016-02-15 07:10:35','2016-02-06','2016-04-30',NULL),(14,59,'gayatri','$2y$13$ZEtwkbrJqouJw3KqMkoEzO6JIGFyuOUA3mba5AENqyYe7jX5HmpTe',NULL,'Z2F5YXRyaTE0NTYxNDM0MTYyNDgz',-1,'2016-02-17 06:28:39',NULL,'2016-02-22 06:16:56',NULL,NULL,60),(15,62,'prakash','$2y$13$X9agaug8aC21f9ujjR9vzOze3nqFNsuaLPf0kgOwwI06tsqX35IrW',NULL,'',51,'2016-02-19 07:08:27',62,'2016-03-03 17:28:56','2016-02-19','2016-02-19',NULL),(16,63,'nadesh','$2y$13$X9agaug8aC21f9ujjR9vzOze3nqFNsuaLPf0kgOwwI06tsqX35IrW',NULL,'',51,'2016-02-19 07:09:05',63,'2016-02-29 06:16:28','2016-02-19','2016-02-19',NULL),(17,65,'test','$2y$13$A4KhMKHUYaMb4m0MoTBNVufbQu4gkBcTc0zV.vSkFiuv..QlAhfh2',NULL,NULL,59,'2016-02-19 07:49:44',59,'2016-02-19 07:49:44','2016-02-19','2016-02-19',NULL),(18,66,'prakash2','$2y$13$mfGVdp/.Cst1GsGHSo/Vv.q9.gxFCaecIokQmbF29OnIw9WS8aIX.',NULL,'cHJha2FzaDIxNDU1OTcyNTk2NDA5Nw==',59,'2016-02-20 05:10:18',NULL,'2016-02-20 06:49:56','2016-02-20','2016-02-20',60),(19,67,'paramesh','$2y$13$u.tSO2LUiafMwxi19midCOlGruWNOIR1lD3gqsGnYhXnSbNYHqvqC','2NCgwIefzaenjPjYtE2lCd_M9eLzyfsQ_1456575065','',-1,'2016-02-21 23:16:05',67,'2016-02-29 02:01:25',NULL,NULL,NULL),(20,73,'parames','$2y$13$1TsRqCJ5ThWc.Pp2vVrdQecg1tFoqsKPGJRCwII5QZqlpB2AtSn86',NULL,NULL,-1,'2016-02-29 02:00:02',-1,'2016-02-29 02:00:02',NULL,NULL,NULL);

/*Table structure for table `co_master_city` */

DROP TABLE IF EXISTS `co_master_city`;

CREATE TABLE `co_master_city` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) DEFAULT NULL,
  `state_id` int(11) NOT NULL,
  `city_name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`city_id`),
  UNIQUE KEY `CoMasterCityUnique` (`tenant_id`,`state_id`,`city_name`,`deleted_at`),
  KEY `FK_co_master_city_state` (`state_id`),
  CONSTRAINT `FK_co_master_city_state` FOREIGN KEY (`state_id`) REFERENCES `co_master_state` (`state_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `co_master_city` */

insert  into `co_master_city`(`city_id`,`tenant_id`,`state_id`,`city_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,NULL,8,'Madurai','1',-1,'2016-01-22 08:13:06',NULL,NULL,'0000-00-00 00:00:00'),(4,58,10,'Los Angeles','1',51,'2016-02-05 01:02:19',51,'2016-02-05 01:02:19','0000-00-00 00:00:00'),(5,61,8,'Trichy','0',67,'2016-02-23 05:10:48',NULL,'2016-02-23 05:12:01','0000-00-00 00:00:00');

/*Table structure for table `co_master_country` */

DROP TABLE IF EXISTS `co_master_country`;

CREATE TABLE `co_master_country` (
  `country_id` int(10) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) DEFAULT NULL,
  `country_name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`country_id`),
  UNIQUE KEY `CountryNameUnique` (`country_name`,`tenant_id`,`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `co_master_country` */

insert  into `co_master_country`(`country_id`,`tenant_id`,`country_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (7,NULL,'India','1',-1,'2016-01-22 08:11:40',NULL,NULL,'0000-00-00 00:00:00'),(11,58,'USA','1',51,'2016-02-05 00:58:16',51,'2016-02-05 00:59:15','0000-00-00 00:00:00'),(12,58,'Pakistan','1',51,'2016-04-16 13:01:54',51,'2016-04-16 13:01:54','0000-00-00 00:00:00');

/*Table structure for table `co_master_state` */

DROP TABLE IF EXISTS `co_master_state`;

CREATE TABLE `co_master_state` (
  `state_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) DEFAULT NULL,
  `country_id` int(11) NOT NULL,
  `state_name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`state_id`),
  UNIQUE KEY `CoMasterStateNameUnique` (`tenant_id`,`country_id`,`state_name`,`deleted_at`),
  KEY `FK_co_master_state_country` (`country_id`),
  CONSTRAINT `FK_co_master_state_country` FOREIGN KEY (`country_id`) REFERENCES `co_master_country` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `co_master_state` */

insert  into `co_master_state`(`state_id`,`tenant_id`,`country_id`,`state_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (8,NULL,7,'Tamilnadu','1',-1,'2016-01-22 08:12:06',NULL,NULL,'0000-00-00 00:00:00'),(10,58,11,'California','1',51,'2016-02-05 00:59:37',51,'2016-02-05 00:59:37','0000-00-00 00:00:00');

/*Table structure for table `co_organization` */

DROP TABLE IF EXISTS `co_organization`;

CREATE TABLE `co_organization` (
  `org_id` int(11) NOT NULL AUTO_INCREMENT,
  `org_name` varchar(100) NOT NULL,
  `org_description` text,
  `org_db_host` varchar(255) NOT NULL DEFAULT 'localhost',
  `org_db_username` varchar(255) NOT NULL DEFAULT 'root',
  `org_db_password` varchar(255) DEFAULT NULL,
  `org_database` varchar(255) NOT NULL,
  `org_domain` varchar(255) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`org_id`),
  UNIQUE KEY `orgNameUnique` (`org_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `co_organization` */

insert  into `co_organization`(`org_id`,`org_name`,`org_description`,`org_db_host`,`org_db_username`,`org_db_password`,`org_database`,`org_domain`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (7,'Org','Org','localhost','root',NULL,'ahana','ahana.hms.ark','1',-1,'2016-02-17 18:50:12',NULL,NULL,'0000-00-00 00:00:00');

/*Table structure for table `co_patient_category` */

DROP TABLE IF EXISTS `co_patient_category`;

CREATE TABLE `co_patient_category` (
  `patient_cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `patient_cat_name` varchar(50) NOT NULL,
  `patient_cat_color` varchar(10) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`patient_cat_id`),
  UNIQUE KEY `FK_co_patient_category_tenant` (`tenant_id`,`patient_cat_name`,`deleted_at`),
  CONSTRAINT `FK_co_patient_category_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `co_patient_category` */

insert  into `co_patient_category`(`patient_cat_id`,`tenant_id`,`patient_cat_name`,`patient_cat_color`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (4,58,'BUSINESS','#ffffff','1',51,'2016-02-05 00:50:24',51,'2016-04-16 15:26:02','0000-00-00 00:00:00'),(5,58,'VIP','#df9a26','1',51,'2016-02-05 00:50:43',51,'2016-02-17 06:45:23','0000-00-00 00:00:00'),(6,58,'Standrad','#FFFFFF','1',51,'2016-02-09 01:52:26',51,'2016-02-17 06:45:14','0000-00-00 00:00:00'),(7,58,'VVIP','#FFFFFF','1',51,'2016-02-17 06:45:45',51,'2016-02-17 06:45:45','0000-00-00 00:00:00'),(8,60,'vip','#FFFFFF','1',59,'2016-02-17 23:15:35',59,'2016-02-17 23:15:35','0000-00-00 00:00:00'),(9,60,'business','#FFFFFF','1',59,'2016-02-17 23:15:42',59,'2016-02-17 23:15:42','0000-00-00 00:00:00'),(10,60,'free','#2cb372','1',59,'2016-02-17 23:15:48',51,'2016-06-07 17:49:45','0000-00-00 00:00:00'),(11,60,'standard','#FFFFFF','1',59,'2016-02-17 23:15:56',59,'2016-02-17 23:15:56','0000-00-00 00:00:00'),(12,60,'vvip','#FFFFFF','1',59,'2016-02-17 23:16:04',59,'2016-02-17 23:16:04','0000-00-00 00:00:00'),(13,58,'classic','#d01e1e','1',51,'2016-02-19 01:34:56',51,'2016-02-19 01:34:56','0000-00-00 00:00:00'),(14,61,'Standard','#FFFFFF','1',67,'2016-02-23 02:22:51',67,'2016-02-23 02:22:51','0000-00-00 00:00:00');

/*Table structure for table `co_resources` */

DROP TABLE IF EXISTS `co_resources`;

CREATE TABLE `co_resources` (
  `resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `resource_name` varchar(50) NOT NULL,
  `resource_url` varchar(100) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`resource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=latin1;

/*Data for the table `co_resources` */

insert  into `co_resources`(`resource_id`,`parent_id`,`resource_name`,`resource_url`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,NULL,'Configuration','configuration',-1,'2015-12-29 15:11:20',NULL,NULL),(2,1,'Organization Module','organization',-1,'2015-12-29 15:11:42',NULL,NULL),(3,2,'Organization','configuration.organization',-1,'2016-01-19 15:35:50',NULL,NULL),(4,2,'Organization Module','configuration.organizationModule',-1,'2016-01-19 15:36:07',NULL,NULL),(5,1,'Administrative Module','administrative',-1,'2016-01-20 11:11:09',NULL,NULL),(6,5,'Roles','configuration.roles',-1,'2016-01-20 11:11:58',NULL,NULL),(7,5,'Role Rights','configuration.roleRights',-1,'2016-01-20 11:14:04',NULL,NULL),(8,5,'User roles','configuration.userRoles',-1,'2016-01-20 11:14:31',NULL,NULL),(9,5,'Charge Category','configuration.roomChargeCategory',-1,'2016-01-20 11:15:00',NULL,NULL),(10,1,'User Module','userModule',-1,'2016-01-20 11:16:12',NULL,NULL),(11,10,'User Registration','configuration.registration',-1,'2016-01-20 11:16:50',NULL,NULL),(12,1,'Ward Management','wardManagement',-1,'2016-01-20 11:17:42',NULL,NULL),(13,12,'Floors','configuration.floors',-1,'2016-01-20 11:18:10',NULL,NULL),(14,12,'Wards','configuration.wards',-1,'2016-01-20 11:18:25',NULL,NULL),(15,12,'Bed Type','configuration.roomType',-1,'2016-01-20 11:18:48',NULL,NULL),(16,12,'Room','configuration.room',-1,'2016-01-20 11:19:17',NULL,NULL),(17,12,'Room and Bed Type','configuration.roomTypeRoom',-1,'2016-01-20 11:20:39',NULL,NULL),(18,1,'Charges Configuration','chargesConfiguration',-1,'2016-01-20 11:21:17',NULL,NULL),(19,18,'Room Charge','configuration.roomCharge',-1,'2016-01-20 11:21:40',NULL,NULL),(20,18,'Room Maintenance','configuration.roomMaintenance',-1,'2016-01-20 11:21:59',NULL,NULL),(21,18,'Charges for Category','configuration.chargePerCategory',-1,'2016-01-20 11:22:20',NULL,NULL),(22,1,'Doctor’s Configuration','doctorsConfiguration',-1,'2016-01-20 11:22:59',NULL,NULL),(23,22,'Doctors Schedule','configuration.docSchedule',-1,'2016-01-20 11:23:20',NULL,NULL),(24,22,'Specialities','configuration.specialities',-1,'2016-01-20 11:23:39',NULL,NULL),(25,1,'Miscellaneous','miscellaneous',-1,'2016-01-20 11:24:17',NULL,NULL),(26,25,'Alerts','configuration.alerts',-1,'2016-01-20 11:24:32',NULL,NULL),(27,25,'Patient Category','configuration.patientCategories',-1,'2016-01-20 11:24:47',NULL,NULL),(28,25,'Bill-No Prefix','configuration.internalCode',-1,'2016-01-20 11:25:06',NULL,NULL),(29,25,'Master Country','configuration.countries',-1,'2016-01-20 11:25:22',NULL,NULL),(30,25,'Master State','configuration.states',-1,'2016-01-20 11:25:35',NULL,NULL),(31,25,'Master City','configuration.cities',-1,'2016-01-20 11:25:52',NULL,NULL),(32,5,'Room Charge Item','configuration.roomChargeCategoryItem',-1,'2016-02-01 12:04:21',NULL,NULL),(33,5,'Allied Charges','configuration.alliedCharge',-1,'2016-02-03 15:31:05',NULL,NULL),(34,5,'Procedures','configuration.procedure',-1,'2016-02-05 15:43:00',NULL,NULL),(35,6,'Add Role','configuration.role_create',-1,'2016-02-08 15:16:27',NULL,NULL),(36,6,'Update Role','configuration.role_update',-1,'2016-02-08 15:17:21',NULL,NULL),(37,6,'Delete Role','configuration.role_delete',-1,'2016-02-08 15:18:46',NULL,NULL),(38,9,'Add Charge Category','configuration.roomChargeCategoryCreate',-1,'2016-02-08 15:20:26',NULL,NULL),(39,9,'Update Charge Category','configuration.roomChargeCategoryUpdate',-1,'2016-02-08 15:20:26',NULL,NULL),(40,9,'Delete Charge Category','configuration.roomChargeCategoryDelete',-1,'2016-02-08 15:20:27',NULL,NULL),(41,32,'Add Room Charge Item','configuration.roomChargeCategoryItemCreate',-1,'2016-02-08 15:21:56',NULL,NULL),(42,32,'Update Room Charge Item','configuration.roomChargeCategoryItemUpdate',-1,'2016-02-08 15:21:56',NULL,NULL),(43,32,'Delete Room Charge Item','configuration.roomChargeCategoryItemDelete',-1,'2016-02-08 15:21:56',NULL,NULL),(44,33,'Add Allied Charges','configuration.alliedChargeCreate',-1,'2016-02-08 15:31:45',NULL,NULL),(45,33,'Update Allied Charges','configuration.alliedChargeUpdate',-1,'2016-02-08 15:31:45',NULL,NULL),(46,33,'Delete Allied Charges','configuration.alliedChargeDelete',-1,'2016-02-08 15:31:45',NULL,NULL),(47,34,'Add Procedures','configuration.procedureChargeCreate',-1,'2016-02-08 15:38:42',NULL,NULL),(48,34,'Update Procedures','configuration.procedureChargeUpdate',-1,'2016-02-08 15:38:42',NULL,NULL),(49,34,'Delete Procedures','configuration.procedureChargeDelete',-1,'2016-02-08 15:38:42',NULL,NULL),(54,11,'Add User','configuration.user_create',-1,'2016-02-08 15:41:39',NULL,NULL),(55,11,'Update User','configuration.user_update',-1,'2016-02-08 15:41:39',NULL,NULL),(56,11,'Delete User','configuration.user_delete',-1,'2016-02-08 15:41:39',NULL,NULL),(57,11,'Add/Update Login','configuration.login_update',-1,'2016-02-08 15:41:39',NULL,NULL),(58,13,'Add Floor','configuration.floor_create',-1,'2016-02-08 15:49:25',NULL,NULL),(59,13,'Update Floor','configuration.floor_update',-1,'2016-02-08 15:49:25',NULL,NULL),(60,13,'Delete Floor','configuration.floor_delete',-1,'2016-02-08 15:49:25',NULL,NULL),(61,14,'Add Ward','configuration.ward_create',-1,'2016-02-08 15:50:14',NULL,NULL),(62,14,'Update Ward','configuration.ward_update',-1,'2016-02-08 15:50:14',NULL,NULL),(63,14,'Delete Ward','configuration.ward_delete',-1,'2016-02-08 15:50:14',NULL,NULL),(64,15,'Add Bed Type','configuration.roomTypeCreate',-1,'2016-02-08 15:51:19',NULL,NULL),(65,15,'Update Bed Type','configuration.roomTypeUpdate',-1,'2016-02-08 15:51:19',NULL,NULL),(66,15,'Delete Bed Type','configuration.roomTypeDelete',-1,'2016-02-08 15:51:19',NULL,NULL),(67,16,'Add Room','configuration.roomCreate',-1,'2016-02-08 15:52:21',NULL,NULL),(68,16,'Update Room','configuration.roomUpdate',-1,'2016-02-08 15:52:21',NULL,NULL),(69,16,'Delete Room','configuration.roomDelete',-1,'2016-02-08 15:52:21',NULL,NULL),(70,17,'Assign Room and Bed Types','configuration.roomTypeRoomUpdate',-1,'2016-02-08 15:53:47',NULL,NULL),(71,19,'Create RoomCharge','configuration.roomChargeCreate',-1,'2016-02-08 15:55:00',NULL,NULL),(72,19,'Update RoomCharge','configuration.roomChargeUpdate',-1,'2016-02-08 15:55:00',NULL,NULL),(73,19,'Delete RoomCharge','configuration.roomChargeDelete',-1,'2016-02-08 15:55:00',NULL,NULL),(74,20,'Create Room Maintenance','configuration.roomMaintenanceCreate',-1,'2016-02-08 15:55:59',NULL,NULL),(75,20,'Update Room Maintenance','configuration.roomMaintenanceUpdate',-1,'2016-02-08 15:55:59',NULL,NULL),(76,20,'Delete Room Maintenance','configuration.roomMaintenanceDelete',-1,'2016-02-08 15:55:59',NULL,NULL),(77,21,'Create Charges for Category','configuration.chargePerCategoryCreate',-1,'2016-02-08 16:00:51',NULL,NULL),(78,22,'Create Doctor Schedule','configuration.docScheduleCreate',-1,'2016-02-08 16:02:26',NULL,NULL),(79,22,'Update Doctor Schedule','configuration.docScheduleUpdate',-1,'2016-02-08 16:02:26',NULL,NULL),(80,22,'Delete Doctor Schedule','configuration.docScheduleDelete',-1,'2016-02-08 16:02:26',NULL,NULL),(81,24,'Create Speciality','configuration.specialityCreate',-1,'2016-02-08 16:03:14',NULL,NULL),(82,24,'Update Speciality','configuration.specialityUpdate',-1,'2016-02-08 16:03:14',NULL,NULL),(83,24,'Delete Speciality','configuration.specialityDelete',-1,'2016-02-08 16:03:14',NULL,NULL),(84,26,'Create Alerts','configuration.alertCreate',-1,'2016-02-08 16:04:00',NULL,NULL),(85,26,'Update Alerts','configuration.alertUpdate',-1,'2016-02-08 16:04:00',NULL,NULL),(86,26,'Delete Alerts','configuration.alertDelete',-1,'2016-02-08 16:04:00',NULL,NULL),(87,27,'Create Patient Category','configuration.patientCategoryCreate',-1,'2016-02-08 16:04:42',NULL,NULL),(88,27,'Update Patient Category','configuration.patientCategoryUpdate',-1,'2016-02-08 16:04:42',NULL,NULL),(89,27,'Delete Patient Category','configuration.patientCategoryDelete',-1,'2016-02-08 16:04:42',NULL,NULL),(90,29,'Create Country','configuration.countryCreate',-1,'2016-02-08 16:05:26',NULL,NULL),(91,29,'Update Country','configuration.countryUpdate',-1,'2016-02-08 16:05:27',NULL,NULL),(92,29,'Delete Country','configuration.countryDelete',-1,'2016-02-08 16:05:27',NULL,NULL),(93,30,'Create State','configuration.stateCreate',-1,'2016-02-08 16:06:03',NULL,NULL),(94,30,'Update State','configuration.stateUpdate',-1,'2016-02-08 16:06:03',NULL,NULL),(95,30,'Delete State','configuration.stateDelete',-1,'2016-02-08 16:06:03',NULL,NULL),(96,31,'Create City','configuration.cityCreate',-1,'2016-02-08 16:06:59',NULL,NULL),(97,31,'Update City','configuration.cityUpdate',-1,'2016-02-08 16:06:59',NULL,NULL),(98,31,'Delete City','configuration.cityDelete',-1,'2016-02-08 16:06:59',NULL,NULL),(99,NULL,'Patient','patient',-1,'2016-02-09 12:15:31',NULL,NULL),(100,99,'Details','patient.view',-1,'2016-02-09 12:16:49',NULL,NULL),(101,99,'Timeline','patient.timeLine',-1,'2016-02-09 12:17:35',NULL,NULL),(102,99,'Documents','patient.documents',-1,'2016-02-09 12:17:43',NULL,NULL),(103,99,'Encounter','patient.encounter',-1,'2016-02-09 12:17:57',NULL,NULL),(104,99,'Notes','patient.notes',-1,'2016-02-09 12:18:01',NULL,NULL),(105,99,'Consultant','patient.consultant',-1,'2016-02-09 12:18:12',NULL,NULL),(106,99,'Procedure','patient.procedure',-1,'2016-02-09 12:18:22',NULL,NULL),(107,99,'Prescription','patient.prescription',-1,'2016-02-09 12:18:45',NULL,NULL),(108,99,'Alert','patient.alert',-1,'2016-02-09 12:18:55',NULL,NULL),(109,99,'Update Patient','patient.update',-1,'2016-03-29 19:16:49',NULL,NULL),(110,104,'Create Note','patient.noteCreate',-1,'2016-03-29 19:17:30',NULL,NULL),(111,104,'Update Note','patient.noteUpdate',-1,'2016-03-29 19:17:55',NULL,NULL),(112,104,'View Note','patient.noteView',-1,'2016-03-29 19:18:15',NULL,NULL),(113,105,'Create Consultant','patient.consultantCreate',-1,'2016-03-29 19:18:58',NULL,NULL),(114,105,'Update Consultant','patient.consultantUpdate',-1,'2016-03-29 19:23:26',NULL,NULL),(115,105,'Delete Consultant','patient.consultantDelete',-1,'2016-03-29 19:23:58',NULL,NULL),(116,106,'Add Procedure','patient.add_procedure',-1,'2016-03-29 19:24:29',NULL,NULL),(117,106,'Update Procedure','patient.edit_procedure',-1,'2016-03-29 19:24:54',NULL,NULL),(118,106,'Delete Procedure','patient.delete_procedure',-1,'2016-03-29 19:25:10',NULL,NULL),(119,108,'Create Alert','patient.alertCreate',-1,'2016-03-29 19:25:45',NULL,NULL),(120,108,'Update Alert','patient.alertUpdate',-1,'2016-03-29 19:26:03',NULL,NULL),(121,103,'Create Admission','patient.admission',-1,'2016-03-29 19:30:01',NULL,NULL),(122,103,'Create Appointment','patient.appointment',-1,'2016-03-29 19:30:22',NULL,NULL),(123,103,'Transfer','patient.transfer',-1,'2016-03-29 19:31:07',NULL,NULL),(124,103,'Discharge','patient.discharge',-1,'2016-03-29 19:31:31',NULL,NULL),(125,103,'Swapping','patient.swapping',-1,'2016-03-29 19:31:51',NULL,NULL),(126,103,'Change Appointment status','patient.changeStatus',-1,'2016-03-29 19:32:47',NULL,NULL),(127,103,'Cancel Appointment','patient.cancelAppointment',-1,'2016-03-29 19:33:56',NULL,NULL),(128,103,'Edit Doctor Fee','patient.editDoctorFee',-1,'2016-03-29 19:34:57',NULL,NULL),(129,99,'Billing','patient.billing',-1,'2016-03-29 19:38:05',NULL,NULL),(130,129,'Add Other Charges','patient.addOtherCharge',-1,'2016-03-29 19:38:32',NULL,NULL),(131,129,'Edit Other Charges','patient.editOtherCharge',-1,'2016-03-29 19:39:06',NULL,NULL),(132,129,'Add Extra Amount','patient.addExtraAmount',-1,'2016-03-29 19:39:36',NULL,NULL),(133,129,'Add Concession Amount','patient.addConcessionAmount',-1,'2016-03-29 19:39:59',NULL,NULL),(134,129,'Add Payment','patient.addPayment',-1,'2016-03-29 19:40:24',NULL,NULL),(135,129,'Edit Payment','patient.editPayment',-1,'2016-03-29 19:41:15',NULL,NULL),(136,129,'Delete Payment','patient.deletePayment',-1,'2016-03-29 19:41:53',NULL,NULL),(137,129,'Add Room Concession','patient.roomConcession',-1,'2016-03-29 19:42:17',NULL,NULL),(138,129,'Finalize','patient.finalize',-1,'2016-03-29 19:42:39',NULL,NULL),(139,129,'Unfinalize','patient.unfinalize',-1,'2016-03-29 19:42:54',NULL,NULL),(140,129,'Authorize','patient.authorize',-1,'2016-03-29 19:43:19',NULL,NULL),(141,129,'Unauthorize','patient.unathorize',-1,'2016-03-29 19:44:04',NULL,NULL),(142,99,'In-Patient','patient.inPatients',-1,'2016-05-12 11:20:52',NULL,NULL),(143,99,'Out-Patient','patient.outPatients',-1,'2016-05-12 11:21:47',NULL,NULL),(144,NULL,'Pharmacy','pharmacy',-1,'2016-05-12 12:32:29',NULL,NULL),(145,144,'Purchase','pharmacy.purchase',-1,'2016-05-12 12:43:50',NULL,NULL),(146,145,'Add Purchase','pharmacy.purchaseCreate',-1,'2016-05-12 12:32:51',NULL,NULL),(147,145,'Edit Purchase','pharmacy.purchaseUpdate',-1,'2016-05-12 12:33:27',NULL,NULL),(148,144,'Purchase Return','pharmacy.purchaseReturn',-1,'2016-05-12 12:44:58',NULL,NULL),(149,148,'Add Purchase Return','pharmacy.purchaseReturnCreate',-1,'2016-05-12 12:45:42',NULL,NULL),(150,148,'Edit Purchase Return','pharmacy.purchaseReturnUpdate',-1,'2016-05-12 12:46:08',NULL,NULL),(151,144,'Sale','pharmacy.sales',-1,'2016-05-12 12:46:55',NULL,NULL),(152,151,'Add Sale','pharmacy.saleCreate',-1,'2016-05-12 12:47:06',NULL,NULL),(153,151,'Edit Sale','pharmacy.saleUpdate',-1,'2016-05-12 12:51:53',NULL,NULL),(154,144,'Sale Return','pharmacy.saleReturn',-1,'2016-05-12 12:52:48',NULL,NULL),(155,154,'Add Sale Return','pharmacy.saleReturnCreate',-1,'2016-05-12 12:53:07',NULL,NULL),(156,154,'Edit Sale Return','pharmacy.saleReturnUpdate',-1,'2016-05-12 12:53:49',NULL,NULL),(157,144,'Reports','pharmacy.report',-1,'2016-05-12 12:57:49',NULL,NULL),(158,144,'Stock Detail','pharmacy.stock',-1,'2016-05-12 12:59:19',NULL,NULL),(159,158,'Batch Details','pharmacy.batchDetails',-1,'2016-05-12 12:59:38',NULL,NULL),(160,158,'Stock Adjust','pharmacy.stockAdjust',-1,'2016-05-12 12:59:57',NULL,NULL),(161,144,'Configuration','pharmacy.configuration',-1,'2016-05-12 13:00:41',NULL,NULL),(162,161,'Brand','pharmacy.brand',-1,'2016-05-12 13:01:25',NULL,NULL),(163,161,'Brand Rep','pharmacy.brandrep',-1,'2016-05-12 13:01:45',NULL,NULL),(164,161,'Products','pharmacy.products',-1,'2016-05-12 13:02:11',NULL,NULL),(165,161,'Supplier','pharmacy.supplier',-1,'2016-05-12 13:02:28',NULL,NULL),(166,162,'Add Brand','pharmacy.brandCreate',-1,'2016-05-12 13:03:07',NULL,NULL),(167,162,'Edit Brand','pharmacy.brandUpdate',-1,'2016-05-12 13:03:27',NULL,NULL),(168,163,'Add Brand Rep','pharmacy.brandrepCreate',-1,'2016-05-12 13:03:47',NULL,NULL),(169,163,'Edit Brand Rep','pharmacy.brandrepUpdate',-1,'2016-05-12 13:04:04',NULL,NULL),(170,164,'Add Product','pharmacy.productAdd',-1,'2016-05-12 13:05:09',NULL,NULL),(171,164,'Edit Product','pharmacy.productEdit',-1,'2016-05-12 13:05:22',NULL,NULL),(172,165,'Add Supplier','pharmacy.supplierCreate',-1,'2016-05-12 13:05:46',NULL,NULL),(173,165,'Edit Supplier','pharmacy.supplierUpdate',-1,'2016-05-12 13:05:58',NULL,NULL),(174,161,'Brand Division','pharmacy.brandDivision',-1,'2016-05-12 13:06:54',NULL,NULL),(175,174,'Add Brand Division','pharmacy.brandDivisionCreate',-1,'2016-05-12 13:08:16',NULL,NULL),(176,174,'Edit Brand Division','pharmacy.brandDivisionUpdate',-1,'2016-05-12 13:08:42',NULL,NULL),(177,161,'Drug Class','pharmacy.drugclass',-1,'2016-05-12 13:17:33',NULL,NULL),(178,177,'Add Drug Class','pharmacy.drugclassCreate',-1,'2016-05-12 13:17:58',NULL,NULL),(179,177,'Edit Drug Class','pharmacy.drugclassUpdate',-1,'2016-05-12 13:18:57',NULL,NULL),(180,161,'Generic Names','pharmacy.drugclass',-1,'2016-05-12 13:19:41',NULL,NULL),(181,180,'Add Generic Name','pharmacy.genericNameCreate',-1,'2016-05-12 13:20:14',NULL,NULL),(182,180,'Edit Generic Name','pharmacy.genericNameUpdate',-1,'2016-05-12 13:20:32',NULL,NULL),(183,161,'Drug Class & Generic','pharmacy.drugGeneric',-1,'2016-05-12 13:21:01',NULL,NULL),(184,183,'Add Drug Class & Generic','pharmacy.drugGenericCreate',-1,'2016-05-12 13:21:46',NULL,NULL),(185,183,'Edit Drug Class & Generic','pharmacy.drugGenericUpdate',-1,'2016-05-12 13:22:09',NULL,NULL),(186,161,'Product Description','pharmacy.prodesc',-1,'2016-05-12 13:22:52',NULL,NULL),(187,186,'Add Product Description','pharmacy.prodescCreate',-1,'2016-05-12 13:23:15',NULL,NULL),(188,186,'Edit Product Description','pharmacy.prodescUpdate',-1,'2016-05-12 13:23:41',NULL,NULL),(189,161,'Vat','pharmacy.vat',-1,'2016-05-12 13:24:16',NULL,NULL),(190,189,'Add Vat','pharmacy.vatCreate',-1,'2016-05-12 13:24:35',NULL,NULL),(191,189,'Edit Vat','pharmacy.vatUpdate',-1,'2016-05-12 13:24:47',NULL,NULL),(192,161,'Packing Unit','pharmacy.packingUnit',-1,'2016-05-12 13:25:22',NULL,NULL),(193,192,'Add Packing Unit','pharmacy.packingUnitCreate',-1,'2016-05-12 13:25:39',NULL,NULL),(194,192,'Edit Packing Unit','pharmacy.packingUnitUpdate',-1,'2016-05-12 13:25:56',NULL,NULL),(195,99,'Patient Registration','patient.registration',-1,'2016-05-12 17:39:56',NULL,NULL),(196,129,'Administrative Discharge','patient.admindischarge',-1,'2016-05-13 11:16:11',NULL,NULL),(197,103,'Future Appointment','patient.futureAppointment',-1,'2016-05-18 15:24:32',NULL,NULL),(198,103,'Future Appointment List','patient.futureAppointmentList',-1,'2016-05-18 15:24:53',NULL,NULL),(199,99,'Vitals','patient.vitals',-1,'2016-05-18 15:25:36',NULL,NULL),(200,199,'Add Vitals','patient.vitalCreate',-1,'2016-05-18 15:28:20',NULL,NULL),(201,99,'Modify Casesheet No.','patient.modifyCaseSheetNo',-1,'2016-05-20 13:07:44',NULL,NULL),(202,99,'Modify Admission','patient.update_admission',-1,'2016-05-20 13:39:02',NULL,NULL),(203,99,'Backdate appointments','patient.backdateappointment',-1,'2016-05-21 16:36:48',NULL,NULL),(204,144,'Sale Billing','pharmacy.makePayment',-1,'2016-05-23 12:23:20',NULL,NULL),(205,103,'Cancel Last Encounter','patient.cancelLastEncounter',-1,'2016-05-24 17:34:12',NULL,NULL),(206,103,'Cancel Admission','patient.cancelAdmission',-1,'2016-05-24 17:37:21',NULL,NULL),(207,16,'Room Maintanance','configuration.updateMaintenance',-1,'2016-05-31 15:27:55',NULL,NULL),(208,99,'Documents','patient.document',-1,'2016-05-31 15:28:11',NULL,NULL),(209,208,'Add Document','patient.addDocument',-1,'2016-05-31 16:51:45',NULL,NULL),(210,208,'Edit Document','patient.editDocument',-1,'2016-05-31 16:52:05',NULL,NULL),(211,99,'Assign Patient Share','patient.assignShare',-1,'2016-06-10 12:49:15',NULL,NULL);

/*Table structure for table `co_role` */

DROP TABLE IF EXISTS `co_role`;

CREATE TABLE `co_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `description` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `CoRoleUnique` (`tenant_id`,`description`,`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=latin1;

/*Data for the table `co_role` */

insert  into `co_role`(`role_id`,`tenant_id`,`description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (64,58,'Administrator','1',-1,'2016-02-02 22:26:38',-1,'2016-02-02 22:26:38','0000-00-00 00:00:00'),(65,59,'Administrator','1',-1,'2016-02-02 22:43:11',-1,'2016-02-02 22:43:11','0000-00-00 00:00:00'),(66,58,'Admin','1',51,'2016-02-04 07:02:50',51,'2016-02-04 07:02:50','0000-00-00 00:00:00'),(67,58,'Cashier','1',51,'2016-02-04 07:03:04',51,'2016-02-04 07:03:04','0000-00-00 00:00:00'),(68,58,'Nurse','1',51,'2016-02-05 22:27:45',51,'2016-05-13 11:45:32','0000-00-00 00:00:00'),(69,60,'admin','1',-1,'2016-02-17 06:28:38',-1,'2016-02-17 06:28:38','0000-00-00 00:00:00'),(72,60,'Sub-Admin','1',59,'2016-02-19 03:57:13',59,'2016-02-19 07:38:06','0000-00-00 00:00:00'),(73,60,'Chief Cashier','1',59,'2016-02-19 04:17:31',59,'2016-02-19 04:31:12','0000-00-00 00:00:00'),(74,60,'Doctor','1',59,'2016-02-19 04:17:46',59,'2016-02-19 04:17:46','0000-00-00 00:00:00'),(79,60,'Nurse','1',59,'2016-02-19 04:22:36',59,'2016-02-19 04:29:12','0000-00-00 00:00:00'),(80,60,'Receptionist','0',59,'2016-02-19 04:22:48',59,'2016-02-19 04:23:14','0000-00-00 00:00:00'),(81,60,'Accountant','1',59,'2016-02-19 04:26:33',59,'2016-02-19 04:29:23','0000-00-00 00:00:00'),(82,60,'PRO','1',59,'2016-02-19 04:27:34',59,'2016-02-19 04:27:58','0000-00-00 00:00:00'),(84,60,'Human Resource','1',59,'2016-02-19 04:31:40',59,'2016-02-19 04:48:00','0000-00-00 00:00:00'),(85,60,'Director','0',59,'2016-02-19 04:43:23',59,'2016-02-19 04:54:09','0000-00-00 00:00:00'),(86,60,'Psychologist','1',59,'2016-02-19 04:43:59',59,'2016-02-19 04:54:02','0000-00-00 00:00:00'),(87,60,'Pharmacy','1',59,'2016-02-19 04:45:43',59,'2016-02-19 04:53:53','0000-00-00 00:00:00'),(88,60,'Supervisor','1',59,'2016-02-19 04:47:28',59,'2016-02-19 04:53:40','0000-00-00 00:00:00'),(89,60,'manager','1',59,'2016-02-19 04:54:33',59,'2016-02-19 04:54:33','0000-00-00 00:00:00'),(90,60,'Care Provider','1',59,'2016-02-19 07:12:03',59,'2016-02-19 07:12:30','0000-00-00 00:00:00'),(91,61,'admin','1',-1,'2016-02-21 23:16:05',-1,'2016-02-21 23:16:05','0000-00-00 00:00:00'),(92,61,'Administrator','1',67,'2016-02-23 02:28:08',67,'2016-02-25 04:59:00','0000-00-00 00:00:00'),(93,62,'admin','1',-1,'2016-02-29 02:00:01',-1,'2016-02-29 02:00:01','0000-00-00 00:00:00'),(94,58,'asdsdas','1',51,'2016-05-17 10:49:46',51,'2016-05-17 10:49:46','0000-00-00 00:00:00'),(95,58,'asdasdasd','1',51,'2016-05-17 10:50:52',51,'2016-05-17 10:50:52','0000-00-00 00:00:00'),(96,58,'Doctor','1',51,'2016-05-18 16:23:46',51,'2016-05-18 16:23:46','0000-00-00 00:00:00'),(97,68,'AAAAA','1',51,'2016-06-10 11:27:10',51,'2016-06-10 11:27:20','0000-00-00 00:00:00'),(98,58,'asdasd','1',51,'2016-06-11 16:44:38',51,'2016-06-11 16:44:38','0000-00-00 00:00:00');

/*Table structure for table `co_roles_resources` */

DROP TABLE IF EXISTS `co_roles_resources`;

CREATE TABLE `co_roles_resources` (
  `role_perm_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`role_perm_id`),
  KEY `FK_co_role_permissions_role` (`role_id`),
  KEY `FK_co_role_permissions_resource` (`resource_id`),
  KEY `FK_co_role_permissions_tenant` (`tenant_id`),
  CONSTRAINT `FK_co_role_permissions_resource` FOREIGN KEY (`resource_id`) REFERENCES `co_resources` (`resource_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_co_role_permissions_role` FOREIGN KEY (`role_id`) REFERENCES `co_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=786 DEFAULT CHARSET=latin1;

/*Data for the table `co_roles_resources` */

insert  into `co_roles_resources`(`role_perm_id`,`tenant_id`,`role_id`,`resource_id`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (459,58,64,1,'1',-1,'2016-05-12 17:11:23',NULL,NULL),(460,58,64,2,'1',-1,'2016-05-12 17:11:23',NULL,NULL),(461,58,64,3,'1',-1,'2016-05-12 17:11:23',NULL,NULL),(462,58,64,4,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(463,58,64,5,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(464,58,64,6,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(465,58,64,7,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(466,58,64,8,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(467,58,64,9,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(468,58,64,10,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(469,58,64,11,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(470,58,64,12,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(471,58,64,13,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(472,58,64,14,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(473,58,64,15,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(474,58,64,16,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(475,58,64,17,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(476,58,64,18,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(477,58,64,19,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(478,58,64,20,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(479,58,64,21,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(480,58,64,22,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(481,58,64,23,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(482,58,64,24,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(483,58,64,25,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(484,58,64,26,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(485,58,64,27,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(486,58,64,28,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(487,58,64,29,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(488,58,64,30,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(489,58,64,31,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(490,58,64,32,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(491,58,64,33,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(492,58,64,34,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(493,58,64,35,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(494,58,64,36,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(495,58,64,37,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(496,58,64,38,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(497,58,64,39,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(498,58,64,40,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(499,58,64,41,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(500,58,64,42,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(501,58,64,43,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(502,58,64,44,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(503,58,64,45,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(504,58,64,46,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(505,58,64,47,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(506,58,64,48,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(507,58,64,49,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(508,58,64,54,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(509,58,64,55,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(510,58,64,56,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(511,58,64,57,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(512,58,64,58,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(513,58,64,59,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(514,58,64,60,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(515,58,64,61,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(516,58,64,62,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(517,58,64,63,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(518,58,64,64,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(519,58,64,65,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(520,58,64,66,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(521,58,64,67,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(522,58,64,68,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(523,58,64,69,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(524,58,64,70,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(525,58,64,71,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(526,58,64,72,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(527,58,64,73,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(528,58,64,74,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(529,58,64,75,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(530,58,64,76,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(531,58,64,77,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(532,58,64,78,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(533,58,64,79,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(534,58,64,80,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(535,58,64,81,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(536,58,64,82,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(537,58,64,83,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(538,58,64,84,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(539,58,64,85,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(540,58,64,86,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(541,58,64,87,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(542,58,64,88,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(543,58,64,89,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(544,58,64,90,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(545,58,64,91,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(546,58,64,92,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(547,58,64,93,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(548,58,64,94,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(549,58,64,95,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(550,58,64,96,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(551,58,64,97,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(552,58,64,98,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(553,58,64,99,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(554,58,64,100,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(555,58,64,101,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(556,58,64,102,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(557,58,64,103,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(558,58,64,104,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(559,58,64,105,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(560,58,64,106,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(561,58,64,107,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(562,58,64,108,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(563,58,64,109,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(564,58,64,110,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(565,58,64,111,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(566,58,64,112,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(567,58,64,113,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(568,58,64,114,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(569,58,64,115,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(570,58,64,116,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(571,58,64,117,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(572,58,64,118,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(573,58,64,119,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(574,58,64,120,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(575,58,64,121,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(576,58,64,122,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(577,58,64,123,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(578,58,64,124,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(579,58,64,125,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(580,58,64,126,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(581,58,64,127,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(582,58,64,128,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(583,58,64,129,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(584,58,64,130,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(585,58,64,131,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(586,58,64,132,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(587,58,64,133,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(588,58,64,134,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(589,58,64,135,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(590,58,64,136,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(591,58,64,137,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(592,58,64,138,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(593,58,64,139,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(594,58,64,140,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(595,58,64,141,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(596,58,64,142,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(597,58,64,143,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(598,58,64,144,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(599,58,64,145,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(600,58,64,146,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(601,58,64,147,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(602,58,64,148,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(603,58,64,149,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(604,58,64,150,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(605,58,64,151,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(606,58,64,152,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(607,58,64,153,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(608,58,64,154,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(609,58,64,155,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(610,58,64,156,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(611,58,64,157,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(612,58,64,158,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(613,58,64,159,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(614,58,64,160,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(615,58,64,161,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(616,58,64,162,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(617,58,64,163,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(618,58,64,164,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(619,58,64,165,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(620,58,64,166,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(621,58,64,167,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(622,58,64,168,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(623,58,64,169,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(624,58,64,170,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(625,58,64,171,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(626,58,64,172,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(627,58,64,173,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(628,58,64,174,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(629,58,64,175,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(630,58,64,176,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(631,58,64,177,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(632,58,64,178,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(633,58,64,179,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(634,58,64,180,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(635,58,64,181,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(636,58,64,182,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(637,58,64,183,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(638,58,64,184,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(639,58,64,185,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(640,58,64,186,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(641,58,64,187,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(642,58,64,188,'1',-1,'2016-05-12 17:11:29',NULL,NULL),(643,58,64,189,'1',-1,'2016-05-12 17:11:29',NULL,NULL),(644,58,64,190,'1',-1,'2016-05-12 17:11:29',NULL,NULL),(645,58,64,191,'1',-1,'2016-05-12 17:11:29',NULL,NULL),(646,58,64,192,'1',-1,'2016-05-12 17:11:29',NULL,NULL),(647,58,64,193,'1',-1,'2016-05-12 17:11:29',NULL,NULL),(648,58,64,194,'1',-1,'2016-05-12 17:11:29',NULL,NULL),(649,58,64,195,'1',-1,'2016-05-12 17:41:02',NULL,NULL),(650,58,64,196,'1',-1,'2016-05-13 11:16:42',NULL,NULL),(651,58,64,197,'1',-1,'2016-05-18 15:26:36',NULL,NULL),(652,58,64,198,'1',-1,'2016-05-18 15:26:43',NULL,NULL),(653,58,64,199,'1',-1,'2016-05-18 15:26:48',NULL,NULL),(654,58,64,200,'1',-1,'2016-05-18 15:28:48',NULL,NULL),(655,58,96,1,'1',51,'2016-05-18 16:24:09',NULL,NULL),(656,58,96,2,'1',51,'2016-05-18 16:24:09',NULL,NULL),(657,58,96,3,'1',51,'2016-05-18 16:24:09',NULL,NULL),(658,58,96,4,'1',51,'2016-05-18 16:24:09',NULL,NULL),(659,58,96,5,'1',51,'2016-05-18 16:24:09',NULL,NULL),(660,58,96,6,'1',51,'2016-05-18 16:24:09',NULL,NULL),(661,58,96,7,'1',51,'2016-05-18 16:24:09',NULL,NULL),(662,58,96,8,'1',51,'2016-05-18 16:24:09',NULL,NULL),(663,58,96,9,'1',51,'2016-05-18 16:24:09',NULL,NULL),(664,58,96,10,'1',51,'2016-05-18 16:24:09',NULL,NULL),(665,58,96,11,'1',51,'2016-05-18 16:24:09',NULL,NULL),(666,58,96,12,'1',51,'2016-05-18 16:24:09',NULL,NULL),(667,58,96,13,'1',51,'2016-05-18 16:24:09',NULL,NULL),(668,58,96,14,'1',51,'2016-05-18 16:24:09',NULL,NULL),(669,58,96,15,'1',51,'2016-05-18 16:24:09',NULL,NULL),(670,58,96,16,'1',51,'2016-05-18 16:24:09',NULL,NULL),(671,58,96,17,'1',51,'2016-05-18 16:24:09',NULL,NULL),(672,58,96,18,'1',51,'2016-05-18 16:24:09',NULL,NULL),(673,58,96,19,'1',51,'2016-05-18 16:24:09',NULL,NULL),(674,58,96,20,'1',51,'2016-05-18 16:24:09',NULL,NULL),(675,58,96,21,'1',51,'2016-05-18 16:24:09',NULL,NULL),(676,58,96,22,'1',51,'2016-05-18 16:24:09',NULL,NULL),(677,58,96,23,'1',51,'2016-05-18 16:24:09',NULL,NULL),(678,58,96,24,'1',51,'2016-05-18 16:24:09',NULL,NULL),(679,58,96,25,'1',51,'2016-05-18 16:24:10',NULL,NULL),(680,58,96,26,'1',51,'2016-05-18 16:24:10',NULL,NULL),(681,58,96,27,'1',51,'2016-05-18 16:24:10',NULL,NULL),(682,58,96,28,'1',51,'2016-05-18 16:24:10',NULL,NULL),(683,58,96,29,'1',51,'2016-05-18 16:24:10',NULL,NULL),(684,58,96,30,'1',51,'2016-05-18 16:24:10',NULL,NULL),(685,58,96,31,'1',51,'2016-05-18 16:24:10',NULL,NULL),(686,58,96,32,'1',51,'2016-05-18 16:24:10',NULL,NULL),(687,58,96,33,'1',51,'2016-05-18 16:24:10',NULL,NULL),(688,58,96,34,'1',51,'2016-05-18 16:24:10',NULL,NULL),(689,58,96,78,'1',51,'2016-05-18 16:24:10',NULL,NULL),(690,58,96,79,'1',51,'2016-05-18 16:24:10',NULL,NULL),(691,58,96,80,'1',51,'2016-05-18 16:24:10',NULL,NULL),(692,58,96,99,'1',51,'2016-05-18 16:24:10',NULL,NULL),(693,58,96,100,'1',51,'2016-05-18 16:24:10',NULL,NULL),(694,58,96,101,'1',51,'2016-05-18 16:24:10',NULL,NULL),(695,58,96,102,'1',51,'2016-05-18 16:24:10',NULL,NULL),(696,58,96,103,'1',51,'2016-05-18 16:24:10',NULL,NULL),(697,58,96,104,'1',51,'2016-05-18 16:24:10',NULL,NULL),(698,58,96,105,'1',51,'2016-05-18 16:24:10',NULL,NULL),(699,58,96,106,'1',51,'2016-05-18 16:24:10',NULL,NULL),(700,58,96,107,'1',51,'2016-05-18 16:24:10',NULL,NULL),(701,58,96,108,'1',51,'2016-05-18 16:24:10',NULL,NULL),(702,58,96,109,'1',51,'2016-05-18 16:24:10',NULL,NULL),(703,58,96,110,'1',51,'2016-05-18 16:24:10',NULL,NULL),(704,58,96,111,'1',51,'2016-05-18 16:24:10',NULL,NULL),(705,58,96,112,'1',51,'2016-05-18 16:24:10',NULL,NULL),(706,58,96,113,'1',51,'2016-05-18 16:24:10',NULL,NULL),(707,58,96,114,'1',51,'2016-05-18 16:24:10',NULL,NULL),(708,58,96,115,'1',51,'2016-05-18 16:24:10',NULL,NULL),(709,58,96,116,'1',51,'2016-05-18 16:24:10',NULL,NULL),(710,58,96,117,'1',51,'2016-05-18 16:24:10',NULL,NULL),(711,58,96,118,'1',51,'2016-05-18 16:24:11',NULL,NULL),(712,58,96,119,'1',51,'2016-05-18 16:24:11',NULL,NULL),(713,58,96,120,'1',51,'2016-05-18 16:24:11',NULL,NULL),(714,58,96,121,'1',51,'2016-05-18 16:24:11',NULL,NULL),(715,58,96,122,'1',51,'2016-05-18 16:24:11',NULL,NULL),(716,58,96,123,'1',51,'2016-05-18 16:24:11',NULL,NULL),(717,58,96,124,'1',51,'2016-05-18 16:24:11',NULL,NULL),(718,58,96,125,'1',51,'2016-05-18 16:24:11',NULL,NULL),(719,58,96,126,'1',51,'2016-05-18 16:24:11',NULL,NULL),(720,58,96,127,'1',51,'2016-05-18 16:24:11',NULL,NULL),(721,58,96,128,'1',51,'2016-05-18 16:24:11',NULL,NULL),(722,58,96,129,'1',51,'2016-05-18 16:24:11',NULL,NULL),(723,58,96,130,'1',51,'2016-05-18 16:24:11',NULL,NULL),(724,58,96,131,'1',51,'2016-05-18 16:24:11',NULL,NULL),(725,58,96,132,'1',51,'2016-05-18 16:24:11',NULL,NULL),(726,58,96,133,'1',51,'2016-05-18 16:24:11',NULL,NULL),(727,58,96,134,'1',51,'2016-05-18 16:24:11',NULL,NULL),(728,58,96,135,'1',51,'2016-05-18 16:24:11',NULL,NULL),(729,58,96,136,'1',51,'2016-05-18 16:24:11',NULL,NULL),(730,58,96,137,'1',51,'2016-05-18 16:24:11',NULL,NULL),(731,58,96,138,'1',51,'2016-05-18 16:24:11',NULL,NULL),(732,58,96,139,'1',51,'2016-05-18 16:24:11',NULL,NULL),(733,58,96,140,'1',51,'2016-05-18 16:24:11',NULL,NULL),(734,58,96,141,'1',51,'2016-05-18 16:24:11',NULL,NULL),(735,58,96,142,'1',51,'2016-05-18 16:24:11',NULL,NULL),(736,58,96,143,'1',51,'2016-05-18 16:24:11',NULL,NULL),(737,58,96,144,'1',51,'2016-05-18 16:24:11',NULL,NULL),(738,58,96,145,'1',51,'2016-05-18 16:24:11',NULL,NULL),(739,58,96,146,'1',51,'2016-05-18 16:24:11',NULL,NULL),(740,58,96,147,'1',51,'2016-05-18 16:24:11',NULL,NULL),(741,58,96,148,'1',51,'2016-05-18 16:24:11',NULL,NULL),(742,58,96,149,'1',51,'2016-05-18 16:24:11',NULL,NULL),(743,58,96,150,'1',51,'2016-05-18 16:24:11',NULL,NULL),(744,58,96,151,'1',51,'2016-05-18 16:24:11',NULL,NULL),(745,58,96,152,'1',51,'2016-05-18 16:24:11',NULL,NULL),(746,58,96,153,'1',51,'2016-05-18 16:24:11',NULL,NULL),(747,58,96,154,'1',51,'2016-05-18 16:24:11',NULL,NULL),(748,58,96,155,'1',51,'2016-05-18 16:24:11',NULL,NULL),(749,58,96,156,'1',51,'2016-05-18 16:24:12',NULL,NULL),(750,58,96,157,'1',51,'2016-05-18 16:24:12',NULL,NULL),(751,58,96,158,'1',51,'2016-05-18 16:24:12',NULL,NULL),(752,58,96,159,'1',51,'2016-05-18 16:24:12',NULL,NULL),(753,58,96,160,'1',51,'2016-05-18 16:24:12',NULL,NULL),(754,58,96,161,'1',51,'2016-05-18 16:24:12',NULL,NULL),(755,58,96,162,'1',51,'2016-05-18 16:24:12',NULL,NULL),(756,58,96,163,'1',51,'2016-05-18 16:24:12',NULL,NULL),(757,58,96,164,'1',51,'2016-05-18 16:24:12',NULL,NULL),(758,58,96,165,'1',51,'2016-05-18 16:24:12',NULL,NULL),(759,58,96,174,'1',51,'2016-05-18 16:24:12',NULL,NULL),(760,58,96,177,'1',51,'2016-05-18 16:24:12',NULL,NULL),(761,58,96,180,'1',51,'2016-05-18 16:24:12',NULL,NULL),(762,58,96,183,'1',51,'2016-05-18 16:24:12',NULL,NULL),(763,58,96,186,'1',51,'2016-05-18 16:24:12',NULL,NULL),(764,58,96,189,'1',51,'2016-05-18 16:24:12',NULL,NULL),(765,58,96,192,'1',51,'2016-05-18 16:24:12',NULL,NULL),(766,58,96,195,'1',51,'2016-05-18 16:24:12',NULL,NULL),(767,58,96,196,'1',51,'2016-05-18 16:24:12',NULL,NULL),(768,58,96,197,'1',51,'2016-05-18 16:24:12',NULL,NULL),(769,58,96,198,'1',51,'2016-05-18 16:24:12',NULL,NULL),(770,58,96,199,'1',51,'2016-05-18 16:24:12',NULL,NULL),(771,58,96,200,'1',51,'2016-05-18 16:24:12',NULL,NULL),(772,58,96,201,'1',51,'2016-05-20 13:08:04',NULL,NULL),(773,58,64,201,'1',51,'2016-05-20 13:09:12',NULL,NULL),(774,58,64,202,'1',51,'2016-05-20 13:39:28',NULL,NULL),(775,58,64,203,'1',51,'2016-05-21 16:37:57',NULL,NULL),(776,58,64,204,'1',51,'2016-05-23 12:23:46',NULL,NULL),(777,58,64,205,'1',51,'2016-05-24 17:38:08',NULL,NULL),(778,58,64,206,'1',51,'2016-05-24 17:38:12',NULL,NULL),(779,58,64,207,'1',51,'2016-05-25 10:40:23',NULL,NULL),(782,58,64,208,'1',51,'2016-05-31 15:28:38',NULL,NULL),(783,58,64,209,'1',51,'2016-05-31 16:53:10',NULL,NULL),(784,58,64,210,'1',51,'2016-05-31 16:53:19',NULL,NULL),(785,58,64,211,'1',51,'2016-06-10 12:49:48',NULL,NULL);

/*Table structure for table `co_room` */

DROP TABLE IF EXISTS `co_room`;

CREATE TABLE `co_room` (
  `room_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `ward_id` int(11) NOT NULL,
  `bed_name` varchar(50) NOT NULL,
  `maintain_id` int(11) DEFAULT NULL,
  `occupied_status` enum('0','1','2') DEFAULT '0',
  `notes` text,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`room_id`),
  UNIQUE KEY `CoBedUnique` (`tenant_id`,`ward_id`,`bed_name`,`deleted_at`),
  KEY `FK_co_room_maintenance` (`maintain_id`),
  KEY `FK_co_room_ward` (`ward_id`),
  CONSTRAINT `FK_co_rooms_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_co_room_ward` FOREIGN KEY (`ward_id`) REFERENCES `co_ward` (`ward_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

/*Data for the table `co_room` */

insert  into `co_room`(`room_id`,`tenant_id`,`ward_id`,`bed_name`,`maintain_id`,`occupied_status`,`notes`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (9,58,8,'2112',5,'1',NULL,'1',51,'2016-02-04 07:30:53',51,'2016-06-11 18:52:10','0000-00-00 00:00:00'),(10,58,9,'112',7,'0',NULL,'1',51,'2016-02-05 06:12:21',51,'2016-05-13 11:18:23','0000-00-00 00:00:00'),(11,58,8,'113',5,'1','','1',51,'2016-02-05 06:41:04',51,'2016-06-10 15:43:20','0000-00-00 00:00:00'),(12,58,8,'112',6,'1','','1',51,'2016-02-05 06:41:15',51,'2016-06-10 12:51:40','0000-00-00 00:00:00'),(17,58,8,'909',NULL,'0','','1',62,'2016-02-20 03:50:45',51,'2016-05-07 19:18:01','0000-00-00 00:00:00'),(18,60,12,'999',NULL,'0',NULL,'1',59,'2016-02-20 06:03:54',59,'2016-02-20 06:40:01','0000-00-00 00:00:00'),(19,60,12,'4234',NULL,'1','','1',59,'2016-02-20 06:05:14',51,'2016-06-08 15:33:59','0000-00-00 00:00:00'),(20,60,13,'2342',NULL,'0',NULL,'1',59,'2016-02-20 06:05:25',59,'2016-02-20 06:48:56','0000-00-00 00:00:00'),(21,60,14,'111',NULL,'0',NULL,'1',59,'2016-02-20 06:06:12',59,'2016-02-20 07:31:03','0000-00-00 00:00:00'),(23,60,13,'111',NULL,'0',NULL,'1',59,'2016-02-20 06:07:42',51,'2016-06-07 19:37:56','0000-00-00 00:00:00'),(30,60,13,'11',NULL,'0',NULL,'1',66,'2016-02-20 07:56:03',66,'2016-02-20 07:56:03','0000-00-00 00:00:00'),(31,61,15,'101',NULL,'0',NULL,'1',67,'2016-02-23 04:44:52',67,'2016-02-25 05:20:44','0000-00-00 00:00:00'),(32,61,15,'102',NULL,'0',NULL,'1',67,'2016-02-23 04:45:03',67,'2016-02-25 05:29:44','0000-00-00 00:00:00'),(33,61,15,'103',NULL,'0',NULL,'1',67,'2016-02-23 04:45:13',NULL,'2016-02-23 04:47:42','0000-00-00 00:00:00'),(34,61,16,'104',NULL,'0',NULL,'1',67,'2016-02-23 04:48:06',67,'2016-02-23 04:48:06','0000-00-00 00:00:00'),(35,61,16,'105',NULL,'0',NULL,'1',67,'2016-02-23 04:48:22',67,'2016-02-25 05:38:13','0000-00-00 00:00:00'),(36,61,16,'106',NULL,'0',NULL,'1',67,'2016-02-23 04:48:46',67,'2016-02-23 04:48:46','0000-00-00 00:00:00'),(37,58,8,'899',NULL,'0',NULL,'1',51,'2016-05-20 11:05:09',51,'2016-05-24 14:06:51','0000-00-00 00:00:00'),(38,58,8,'4444',NULL,'0',NULL,'1',51,'2016-05-20 16:43:55',51,'2016-05-20 16:47:41','0000-00-00 00:00:00'),(39,58,8,'787',NULL,'0','aaddd aaaasd asdasdsd','1',51,'2016-05-25 10:52:24',51,'2016-05-25 11:01:23','0000-00-00 00:00:00'),(40,58,8,'963',NULL,'0',NULL,'1',51,'2016-05-25 11:00:41',51,'2016-05-25 11:00:41','0000-00-00 00:00:00');

/*Table structure for table `co_room_charge` */

DROP TABLE IF EXISTS `co_room_charge`;

CREATE TABLE `co_room_charge` (
  `charge_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `charge_item_id` int(11) NOT NULL,
  `room_type_id` int(11) NOT NULL,
  `charge` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`charge_id`),
  UNIQUE KEY `CoRoomChargeUnique` (`tenant_id`,`charge_item_id`,`room_type_id`,`deleted_at`),
  KEY `co_room_charge_tenant` (`tenant_id`),
  KEY `FK_co_room_charge_room_type` (`room_type_id`),
  KEY `FK_co_room_charge_charge_item` (`charge_item_id`),
  CONSTRAINT `FK_co_room_charge_charge_item` FOREIGN KEY (`charge_item_id`) REFERENCES `co_room_charge_item` (`charge_item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_co_room_charge_room_type` FOREIGN KEY (`room_type_id`) REFERENCES `co_room_type` (`room_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_co_room_charge_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_charge` */

insert  into `co_room_charge`(`charge_id`,`tenant_id`,`charge_item_id`,`room_type_id`,`charge`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,1,9,'300.00','1',51,'2016-02-04 22:29:18',51,'2016-04-19 10:45:10','0000-00-00 00:00:00'),(2,58,1,11,'300.00','1',51,'2016-02-04 22:29:50',51,'2016-02-04 22:29:50','0000-00-00 00:00:00'),(3,58,1,13,'100.00','1',51,'2016-02-09 02:04:38',51,'2016-02-09 02:04:38','0000-00-00 00:00:00'),(4,58,3,10,'2820.00','1',51,'2016-02-09 02:38:16',51,'2016-05-20 13:11:42','0000-00-00 00:00:00'),(5,58,3,11,'2000.00','1',51,'2016-02-09 02:39:16',51,'2016-02-09 02:39:16','0000-00-00 00:00:00'),(6,60,4,14,'878.00','1',59,'2016-02-20 03:28:47',59,'2016-02-20 03:28:47','0000-00-00 00:00:00'),(7,60,5,15,'215.00','1',59,'2016-02-20 03:28:57',59,'2016-02-20 03:28:57','0000-00-00 00:00:00'),(8,60,6,16,'1255.00','1',59,'2016-02-20 03:29:12',59,'2016-02-20 03:29:12','0000-00-00 00:00:00'),(9,61,7,19,'450.00','1',67,'2016-02-23 04:49:52',67,'2016-02-23 04:49:52','0000-00-00 00:00:00'),(10,61,7,20,'500.00','1',67,'2016-02-23 04:50:26',67,'2016-02-23 04:51:21','0000-00-00 00:00:00'),(11,58,8,10,'2200.00','1',51,'2016-03-17 18:12:13',51,'2016-04-21 13:33:17','0000-00-00 00:00:00'),(12,58,3,13,'150.00','1',51,'2016-03-26 16:32:51',51,'2016-04-18 15:10:22','0000-00-00 00:00:00'),(13,58,8,13,'350.00','1',51,'2016-03-26 16:33:07',51,'2016-04-18 17:02:25','0000-00-00 00:00:00');

/*Table structure for table `co_room_charge_category` */

DROP TABLE IF EXISTS `co_room_charge_category`;

CREATE TABLE `co_room_charge_category` (
  `charge_cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) DEFAULT NULL,
  `charge_cat_name` varchar(50) NOT NULL,
  `charge_cat_code` varchar(10) DEFAULT NULL,
  `charge_cat_description` text,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`charge_cat_id`),
  UNIQUE KEY `RoomCatNameUnique` (`tenant_id`,`charge_cat_name`,`deleted_at`),
  KEY `co_room_cat_tenant` (`tenant_id`),
  CONSTRAINT `FK_co_room_cat_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_charge_category` */

insert  into `co_room_charge_category`(`charge_cat_id`,`tenant_id`,`charge_cat_name`,`charge_cat_code`,`charge_cat_description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,NULL,'Procedures','PRC','Procedures','1',1,'2016-01-28 15:34:22',NULL,NULL,'0000-00-00 00:00:00'),(2,NULL,'Allied Charges','ALC','Allied Charges','1',1,'2016-01-28 15:35:12',NULL,NULL,'0000-00-00 00:00:00'),(3,58,'Miscellaneous','12','Miscellaneous','1',51,'2016-02-04 07:04:17',51,'2016-02-04 07:04:17','0000-00-00 00:00:00'),(4,58,'Procedures','1234','2000','1',51,'2016-02-09 01:47:49',51,'2016-02-09 01:47:49','0000-00-00 00:00:00'),(5,58,'Room Charges','123','Chargers for Rooms','1',51,'2016-02-09 02:19:45',51,'2016-02-09 02:19:45','0000-00-00 00:00:00'),(6,60,'Dummy Charges',NULL,'charges','1',59,'2016-02-17 23:09:11',59,'2016-02-19 07:51:09','0000-00-00 00:00:00'),(8,60,'Dummy2 charges',NULL,'Dummy2 Charges','1',59,'2016-02-17 23:12:06',59,'2016-02-19 07:51:53','0000-00-00 00:00:00'),(9,61,'test','tsest','tes','1',67,'2016-02-23 04:36:28',67,'2016-02-23 04:36:28','0000-00-00 00:00:00');

/*Table structure for table `co_room_charge_item` */

DROP TABLE IF EXISTS `co_room_charge_item`;

CREATE TABLE `co_room_charge_item` (
  `charge_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `charge_item_name` varchar(50) NOT NULL,
  `charge_item_code` varchar(10) NOT NULL,
  `charge_item_description` text,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`charge_item_id`),
  UNIQUE KEY `RoomChargeUnique` (`charge_item_name`,`tenant_id`,`deleted_at`),
  KEY `co_charge_tenant` (`tenant_id`),
  CONSTRAINT `FK_co_charge_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_charge_item` */

insert  into `co_room_charge_item`(`charge_item_id`,`tenant_id`,`charge_item_name`,`charge_item_code`,`charge_item_description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'Test','TE','Testing','1',51,'2016-02-03 00:46:31',51,'2016-02-03 00:46:31','0000-00-00 00:00:00'),(2,58,'doppler','2389','doppler','1',51,'2016-02-04 22:38:37',51,'2016-02-04 22:38:37','0000-00-00 00:00:00'),(3,58,'Room Rent','123','Rent for Rooms','1',51,'2016-02-09 02:37:57',51,'2016-02-09 02:37:57','0000-00-00 00:00:00'),(4,60,'DMO','1','DMO','1',59,'2016-02-19 07:28:13',59,'2016-02-19 07:28:13','0000-00-00 00:00:00'),(5,60,'NURSING CHARGES','2','NURSING CHARGES','1',59,'2016-02-19 07:28:24',59,'2016-02-19 07:28:24','0000-00-00 00:00:00'),(6,60,'ROOM RENT','3','ROOM RENT','1',59,'2016-02-19 07:28:39',59,'2016-02-19 07:28:39','0000-00-00 00:00:00'),(7,61,'DMO','DMO','DMO','1',67,'2016-02-23 02:30:10',67,'2016-02-23 02:30:10','0000-00-00 00:00:00'),(8,58,'DMO','200','DMO','1',51,'2016-03-17 18:11:57',51,'2016-03-17 18:11:57','0000-00-00 00:00:00');

/*Table structure for table `co_room_charge_subcategory` */

DROP TABLE IF EXISTS `co_room_charge_subcategory`;

CREATE TABLE `co_room_charge_subcategory` (
  `charge_subcat_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `charge_cat_id` int(11) NOT NULL,
  `charge_subcat_name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`charge_subcat_id`),
  UNIQUE KEY `CoRoomChargeSubCategoryUnique` (`tenant_id`,`charge_cat_id`,`charge_subcat_name`,`deleted_at`),
  KEY `co_room_cat_tenant` (`tenant_id`),
  KEY `FK_co_room_charge_subcategory_category` (`charge_cat_id`),
  CONSTRAINT `FK_co_room_charge_subcategory_category` FOREIGN KEY (`charge_cat_id`) REFERENCES `co_room_charge_category` (`charge_cat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_co_room_subcat_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_charge_subcategory` */

insert  into `co_room_charge_subcategory`(`charge_subcat_id`,`tenant_id`,`charge_cat_id`,`charge_subcat_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (20,58,3,'misc1','1',51,'2016-02-04 07:04:18',51,'2016-02-04 07:04:18','0000-00-00 00:00:00'),(21,58,3,'misc2','1',51,'2016-02-04 07:04:18',51,'2016-02-04 07:04:18','0000-00-00 00:00:00'),(22,58,1,'stomach wash','1',51,'2016-02-04 22:34:10',51,'2016-02-04 22:34:10','0000-00-00 00:00:00'),(23,58,2,'Alied','1',51,'2016-02-05 06:22:39',51,'2016-02-05 06:22:39','0000-00-00 00:00:00'),(24,58,4,'Challenge test','1',51,'2016-02-09 01:47:51',51,'2016-02-09 01:48:48','0000-00-00 00:00:00'),(25,58,5,'DMO','1',51,'2016-02-09 02:19:46',51,'2016-02-09 02:19:46','0000-00-00 00:00:00'),(26,58,5,'Room Rent','1',51,'2016-02-09 02:19:46',51,'2016-02-09 02:19:46','0000-00-00 00:00:00'),(27,60,8,'vikhram','1',59,'2016-02-17 23:12:07',14,'2016-02-17 23:12:07','2016-02-19 07:51:27'),(28,60,8,'mary','1',59,'2016-02-17 23:12:07',14,'2016-02-17 23:12:07','2016-02-19 07:51:29'),(29,60,8,'jayant','1',59,'2016-02-17 23:12:07',14,'2016-02-17 23:12:07','2016-02-19 07:51:30'),(30,60,1,'Pulse Check','1',59,'2016-02-18 01:01:49',59,'2016-02-18 01:01:49','0000-00-00 00:00:00'),(31,60,2,'CANTEEN CHARGES','1',59,'2016-02-19 07:24:55',59,'2016-02-19 07:24:55','0000-00-00 00:00:00'),(32,60,2,'DRESSING CHARGES','1',59,'2016-02-19 07:25:25',59,'2016-02-19 07:25:25','0000-00-00 00:00:00'),(33,60,2,'MONITOR CHARGES','1',59,'2016-02-19 07:25:26',59,'2016-02-19 07:25:26','0000-00-00 00:00:00'),(34,60,2,'NEBULIZATION CHARGES','1',59,'2016-02-19 07:25:28',59,'2016-02-19 07:25:28','0000-00-00 00:00:00'),(35,60,1,'Aversion','1',59,'2016-02-19 07:25:54',59,'2016-02-19 07:25:54','0000-00-00 00:00:00'),(36,60,1,'Challenge Test','1',59,'2016-02-19 07:26:01',59,'2016-02-19 07:26:01','0000-00-00 00:00:00'),(37,60,1,'Treatment Charges','1',59,'2016-02-19 07:26:31',59,'2016-02-19 07:26:31','0000-00-00 00:00:00'),(38,61,9,'test','1',67,'2016-02-23 04:36:30',67,'2016-02-23 04:36:30','0000-00-00 00:00:00'),(39,58,1,'Aversion','1',51,'2016-03-22 15:34:47',51,'2016-03-22 15:34:47','0000-00-00 00:00:00'),(40,58,4,'Test','1',51,'2016-05-10 16:08:35',51,'2016-05-10 16:08:35','0000-00-00 00:00:00'),(41,58,5,'New One','1',51,'2016-05-25 11:03:49',51,'2016-05-25 11:03:49','0000-00-00 00:00:00');

/*Table structure for table `co_room_maintenance` */

DROP TABLE IF EXISTS `co_room_maintenance`;

CREATE TABLE `co_room_maintenance` (
  `maintain_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `maintain_name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`maintain_id`),
  UNIQUE KEY `MaintainNameUnique` (`tenant_id`,`maintain_name`,`deleted_at`),
  CONSTRAINT `FK_co_room_maintenance_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_maintenance` */

insert  into `co_room_maintenance`(`maintain_id`,`tenant_id`,`maintain_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (5,58,'cleaning','1',51,'2016-02-04 07:27:58',51,'2016-02-04 07:27:58','0000-00-00 00:00:00'),(6,58,'ac maintenance','1',51,'2016-02-04 22:30:34',51,'2016-02-04 22:30:34','0000-00-00 00:00:00'),(7,58,'testing-Raj','1',51,'2016-02-05 06:11:35',51,'2016-02-05 06:11:35','0000-00-00 00:00:00');

/*Table structure for table `co_room_type` */

DROP TABLE IF EXISTS `co_room_type`;

CREATE TABLE `co_room_type` (
  `room_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `room_type_name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`room_type_id`),
  UNIQUE KEY `RoomTypeNameUnique` (`tenant_id`,`room_type_name`,`deleted_at`),
  KEY `co_room_type_tenant` (`tenant_id`),
  CONSTRAINT `FK_co_room_type_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_type` */

insert  into `co_room_type`(`room_type_id`,`tenant_id`,`room_type_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (9,58,'ac','1',51,'2016-02-04 07:16:44',51,'2016-02-04 07:16:44','0000-00-00 00:00:00'),(10,58,'Non AC','1',51,'2016-02-04 07:16:50',51,'2016-02-04 07:16:50','0000-00-00 00:00:00'),(11,58,'Deluxe','1',51,'2016-02-04 07:16:56',51,'2016-02-04 07:16:56','0000-00-00 00:00:00'),(12,58,'Suite','1',51,'2016-02-05 06:40:40',51,'2016-02-05 06:40:40','0000-00-00 00:00:00'),(13,58,'Single','1',51,'2016-02-09 02:02:18',51,'2016-02-09 02:02:18','0000-00-00 00:00:00'),(14,60,'DELUX','1',59,'2016-02-20 02:44:04',59,'2016-02-20 06:04:25','0000-00-00 00:00:00'),(15,60,'NON AC','1',59,'2016-02-20 02:57:57',59,'2016-02-20 06:04:15','0000-00-00 00:00:00'),(16,60,'AC','1',59,'2016-02-20 02:58:03',59,'2016-02-20 06:04:07','0000-00-00 00:00:00'),(17,60,'SUITE','1',59,'2016-02-20 06:04:32',59,'2016-02-20 06:04:32','0000-00-00 00:00:00'),(18,60,'GENERAL','1',59,'2016-02-20 06:05:01',59,'2016-02-20 06:05:01','0000-00-00 00:00:00'),(19,61,'AC','1',67,'2016-02-23 04:44:21',67,'2016-02-23 04:44:21','0000-00-00 00:00:00'),(20,61,'Non-AC','1',67,'2016-02-23 04:44:33',67,'2016-02-23 04:44:33','0000-00-00 00:00:00');

/*Table structure for table `co_room_types_rooms` */

DROP TABLE IF EXISTS `co_room_types_rooms`;

CREATE TABLE `co_room_types_rooms` (
  `room_type_room_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `room_type_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`room_type_room_id`),
  KEY `FK_room_types_rooms_tenane` (`tenant_id`),
  KEY `FK_room_types_rooms` (`room_type_id`),
  KEY `FK_room_types_rooms_room` (`room_id`),
  CONSTRAINT `FK_room_types_rooms` FOREIGN KEY (`room_type_id`) REFERENCES `co_room_type` (`room_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_room_types_rooms_room` FOREIGN KEY (`room_id`) REFERENCES `co_room` (`room_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_room_types_rooms_tenane` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_types_rooms` */

insert  into `co_room_types_rooms`(`room_type_room_id`,`tenant_id`,`room_type_id`,`room_id`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (11,58,9,9,51,'2016-02-04 07:31:07',51,'2016-02-04 07:31:07'),(13,58,10,10,51,'2016-02-05 06:39:43',51,'2016-02-05 06:39:43'),(14,58,11,10,51,'2016-02-05 06:39:43',51,'2016-02-05 06:39:43'),(15,58,11,9,51,'2016-02-05 06:39:58',51,'2016-02-05 06:39:58'),(16,58,9,11,51,'2016-02-05 06:42:02',51,'2016-02-05 06:42:02'),(17,58,10,11,51,'2016-02-05 06:42:02',51,'2016-02-05 06:42:02'),(18,58,11,11,51,'2016-02-05 06:42:02',51,'2016-02-05 06:42:02'),(19,58,12,11,51,'2016-02-05 06:42:02',51,'2016-02-05 06:42:02'),(20,58,12,12,51,'2016-02-05 06:42:11',51,'2016-02-05 06:42:11'),(21,58,9,12,51,'2016-02-15 07:12:36',51,'2016-02-15 07:12:36'),(22,60,16,23,59,'2016-02-20 06:07:58',59,'2016-02-20 06:07:58'),(23,60,14,21,59,'2016-02-20 06:08:06',59,'2016-02-20 06:08:06'),(24,60,18,21,59,'2016-02-20 06:08:06',59,'2016-02-20 06:08:06'),(25,60,15,20,59,'2016-02-20 06:08:14',59,'2016-02-20 06:08:14'),(26,60,17,20,59,'2016-02-20 06:08:14',59,'2016-02-20 06:08:14'),(27,60,15,19,59,'2016-02-20 06:08:22',59,'2016-02-20 06:08:22'),(28,60,18,19,59,'2016-02-20 06:08:22',59,'2016-02-20 06:08:22'),(29,60,14,18,59,'2016-02-20 06:08:32',59,'2016-02-20 06:08:32'),(30,60,16,18,59,'2016-02-20 06:08:32',59,'2016-02-20 06:08:32'),(31,61,19,31,67,'2016-02-23 04:49:09',67,'2016-02-23 04:49:09'),(32,61,20,31,67,'2016-02-23 04:49:09',67,'2016-02-23 04:49:09'),(33,61,19,32,67,'2016-02-23 04:49:18',67,'2016-02-23 04:49:18'),(34,61,20,34,67,'2016-02-23 04:49:30',67,'2016-02-23 04:49:30'),(35,61,19,34,67,'2016-02-23 04:49:30',67,'2016-02-23 04:49:30'),(36,61,19,35,67,'2016-02-23 05:28:01',67,'2016-02-23 05:28:01'),(37,61,20,35,67,'2016-02-23 05:28:01',67,'2016-02-23 05:28:01'),(38,61,19,36,67,'2016-02-23 05:29:43',67,'2016-02-23 05:29:43'),(39,61,20,36,67,'2016-02-23 05:29:43',67,'2016-02-23 05:29:43'),(40,61,19,33,67,'2016-02-23 05:29:55',67,'2016-02-23 05:29:55'),(41,61,20,33,67,'2016-02-23 05:29:55',67,'2016-02-23 05:29:55'),(42,58,10,12,51,'2016-03-02 19:18:23',51,'2016-03-02 19:18:23'),(43,58,13,12,51,'2016-03-02 19:18:23',51,'2016-03-02 19:18:23'),(44,58,11,12,51,'2016-03-02 19:18:24',51,'2016-03-02 19:18:24'),(45,58,9,17,51,'2016-03-26 16:33:51',51,'2016-03-26 16:33:51'),(46,58,11,17,51,'2016-03-26 16:33:51',51,'2016-03-26 16:33:51'),(47,58,10,17,51,'2016-03-26 16:33:51',51,'2016-03-26 16:33:51'),(48,58,13,17,51,'2016-03-26 16:33:51',51,'2016-03-26 16:33:51'),(50,58,13,11,51,'2016-03-26 16:34:02',51,'2016-03-26 16:34:02'),(51,58,13,10,51,'2016-03-26 16:34:08',51,'2016-03-26 16:34:08'),(52,58,12,10,51,'2016-03-26 16:34:08',51,'2016-03-26 16:34:08'),(53,58,10,9,51,'2016-03-26 16:34:15',51,'2016-03-26 16:34:15'),(54,58,13,9,51,'2016-03-26 16:34:15',51,'2016-03-26 16:34:15'),(55,58,12,9,51,'2016-03-26 16:34:15',51,'2016-03-26 16:34:15'),(56,58,11,37,51,'2016-05-20 11:05:20',51,'2016-05-20 11:05:20'),(57,58,9,37,51,'2016-05-20 11:05:20',51,'2016-05-20 11:05:20'),(58,58,10,37,51,'2016-05-20 11:05:20',51,'2016-05-20 11:05:20'),(59,58,9,38,51,'2016-05-20 16:44:05',51,'2016-05-20 16:44:05'),(60,58,10,38,51,'2016-05-20 16:44:05',51,'2016-05-20 16:44:05'),(61,58,9,40,51,'2016-05-25 11:01:01',51,'2016-05-25 11:01:01'),(62,58,11,40,51,'2016-05-25 11:01:01',51,'2016-05-25 11:01:01'),(63,58,10,40,51,'2016-05-25 11:01:01',51,'2016-05-25 11:01:01'),(64,58,12,39,51,'2016-05-25 11:01:08',51,'2016-05-25 11:01:08'),(65,58,13,39,51,'2016-05-25 11:01:08',51,'2016-05-25 11:01:08'),(66,58,10,39,51,'2016-05-25 11:01:08',51,'2016-05-25 11:01:08');

/*Table structure for table `co_speciality` */

DROP TABLE IF EXISTS `co_speciality`;

CREATE TABLE `co_speciality` (
  `speciality_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `speciality_name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`speciality_id`),
  UNIQUE KEY `co_speciality_tenant` (`tenant_id`,`speciality_name`,`deleted_at`),
  CONSTRAINT `FK_co_speciality_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `co_speciality` */

insert  into `co_speciality`(`speciality_id`,`tenant_id`,`speciality_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'General physician','1',51,'2016-02-05 22:49:38',51,'2016-02-05 22:49:38','0000-00-00 00:00:00'),(2,60,'gyno','1',59,'2016-02-17 06:31:51',59,'2016-02-17 06:31:51','0000-00-00 00:00:00'),(3,60,'pediat','1',59,'2016-02-17 06:32:00',59,'2016-02-17 06:32:00','0000-00-00 00:00:00'),(4,60,'Anaesthetist','1',59,'2016-02-19 07:17:05',59,'2016-02-19 07:17:05','0000-00-00 00:00:00'),(5,60,'Dentist','1',59,'2016-02-19 07:17:22',59,'2016-02-19 07:17:22','0000-00-00 00:00:00'),(6,60,'Endocrinologist','1',59,'2016-02-19 07:17:40',59,'2016-02-19 07:17:40','0000-00-00 00:00:00'),(7,60,'Nephrologist','1',59,'2016-02-19 07:17:57',59,'2016-02-19 07:17:57','0000-00-00 00:00:00'),(8,60,'Opthomologist','1',59,'2016-02-19 07:18:07',59,'2016-02-19 07:18:07','0000-00-00 00:00:00'),(9,60,'Physiotherapist','1',59,'2016-02-19 07:18:16',59,'2016-02-19 07:18:28','0000-00-00 00:00:00'),(10,60,'Psychiatrist','1',59,'2016-02-19 07:18:45',59,'2016-02-19 07:18:45','0000-00-00 00:00:00'),(11,61,'psychiatrist','1',67,'2016-02-21 23:21:54',NULL,'2016-02-21 23:23:41','0000-00-00 00:00:00'),(12,61,'testasdfasdfadsfads','1',67,'2016-02-23 02:13:53',67,'2016-02-23 02:14:12','0000-00-00 00:00:00');

/*Table structure for table `co_super_admin` */

DROP TABLE IF EXISTS `co_super_admin`;

CREATE TABLE `co_super_admin` (
  `su_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `authtoken` varchar(255) DEFAULT NULL,
  `last_activity` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`su_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `co_super_admin` */

insert  into `co_super_admin`(`su_id`,`username`,`password`,`authtoken`,`last_activity`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,'demo','$2y$13$pfNu2lorSgd3btV7foqp.uriRfXF.7lSi51b45oefB0V1NaObxEui','ZGVtbzE0NTY3NDgwNzg5Nzcz','0000-00-00 00:00:00',NULL,'0000-00-00 00:00:00',-1,'2016-01-07 11:46:28');

/*Table structure for table `co_tenant` */

DROP TABLE IF EXISTS `co_tenant`;

CREATE TABLE `co_tenant` (
  `tenant_id` int(11) NOT NULL AUTO_INCREMENT,
  `org_id` int(11) NOT NULL,
  `tenant_guid` varchar(50) DEFAULT NULL,
  `tenant_name` varchar(50) NOT NULL,
  `tenant_address` varchar(100) DEFAULT NULL,
  `tenant_city_id` int(11) DEFAULT NULL,
  `tenant_state_id` int(11) DEFAULT NULL,
  `tenant_country_id` int(11) DEFAULT NULL,
  `tenant_contact1` varchar(20) DEFAULT NULL,
  `tenant_contact2` varchar(20) DEFAULT NULL,
  `tenant_fax` varchar(50) DEFAULT NULL,
  `tenant_mobile` varchar(20) DEFAULT NULL,
  `tenant_email` varchar(50) DEFAULT NULL,
  `tenant_url` varchar(50) DEFAULT NULL,
  `slug` varchar(50) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`tenant_id`),
  UNIQUE KEY `TenantNameUnique` (`tenant_name`,`org_id`),
  KEY `FK_co_tenant_org` (`org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=latin1;

/*Data for the table `co_tenant` */

insert  into `co_tenant`(`tenant_id`,`org_id`,`tenant_guid`,`tenant_name`,`tenant_address`,`tenant_city_id`,`tenant_state_id`,`tenant_country_id`,`tenant_contact1`,`tenant_contact2`,`tenant_fax`,`tenant_mobile`,`tenant_email`,`tenant_url`,`slug`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (58,7,'','Ahana','Gandhi Nagar',1,1,1,'123','','','','vikhram@ahana.com','http://ahana.com','','1',-1,'2016-02-02 22:26:38',-1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(59,7,'','Ark Infotec','Bye-pass',4,3,2,'123','','','','gayatri@ark.com','http://ark.com','','0',-1,'2016-02-02 22:43:11',-1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(60,7,'','Radianz','rad',2,1,1,'123123','','','','abc@radianz.com','','','1',-1,'2016-02-17 06:28:38',-1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(61,7,NULL,'test','test',1,8,7,'99999999',NULL,NULL,NULL,'test.t@gm.xc','http://ahanahospitals.in/',NULL,'1',-1,'2016-02-21 23:16:05',-1,'2016-02-21 23:16:05','0000-00-00 00:00:00'),(62,0,NULL,'test test','test',5,8,7,'2323232323','',NULL,NULL,'34343@3444.3',NULL,NULL,'1',-1,'2016-02-29 02:00:01',-1,'2016-02-29 02:08:44','0000-00-00 00:00:00'),(68,7,'','K.K Nagar','K.K Nagar',1,1,1,'99888551154','','','','ts2@gaa.com','','','',-1,'0000-00-00 00:00:00',-1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(69,7,'','R.K Nagar','AAAA',1,1,1,'84515154151','','','','rk@gmail.com','','','',-1,'0000-00-00 00:00:00',-1,'0000-00-00 00:00:00','0000-00-00 00:00:00');

/*Table structure for table `co_user` */

DROP TABLE IF EXISTS `co_user`;

CREATE TABLE `co_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `org_id` int(11) NOT NULL,
  `title_code` varchar(10) DEFAULT 'Mr.',
  `name` varchar(50) NOT NULL,
  `designation` varchar(25) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `contact1` varchar(50) DEFAULT NULL,
  `contact2` varchar(50) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `speciality_id` int(11) DEFAULT NULL,
  `care_provider` enum('0','1') NOT NULL DEFAULT '0',
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`user_id`),
  KEY `FK_co_user_profile_tenant` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;

/*Data for the table `co_user` */

insert  into `co_user`(`user_id`,`tenant_id`,`org_id`,`title_code`,`name`,`designation`,`address`,`city_id`,`state_id`,`zip`,`country_id`,`contact1`,`contact2`,`mobile`,`email`,`speciality_id`,`care_provider`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (51,0,7,'Dr.','Vikhram','Doctor','Anna Nagar',1,8,'625008',7,NULL,NULL,'8989898989','vikhram@ahana.com',NULL,'0','1',-1,'2016-02-02 22:26:38',-1,'2016-02-02 22:26:38','0000-00-00 00:00:00'),(52,59,0,'Miss.','Gayatri','HR','Byepass',1,8,'625010',7,NULL,NULL,'7878787878','gayatri@ark.com',NULL,'0','1',-1,'2016-02-02 22:43:11',-1,'2016-02-04 05:55:51','0000-00-00 00:00:00'),(53,58,0,'Mr.','Gayatri','HR','11231',1,8,'1231231',7,NULL,NULL,'1121212','gayatri@gmail.com',NULL,'0','1',51,'2016-02-03 01:04:06',51,'2016-02-03 01:04:06','0000-00-00 00:00:00'),(54,58,0,'Dr.','John','Doctor','abc',1,8,'123123',7,NULL,NULL,'123123','john@a.com',NULL,'1','1',51,'2016-02-04 07:06:51',51,'2016-02-05 22:58:11','0000-00-00 00:00:00'),(55,58,0,'Mr.','sadasd','asdasd','asasd',1,8,'123123',7,NULL,NULL,'123123123','a@abc.com',NULL,'0','1',51,'2016-02-04 07:29:11',51,'2016-02-04 07:29:11','0000-00-00 00:00:00'),(56,58,0,'Dr.','Surya','Doctor','abc',1,8,'234234',7,NULL,NULL,'123123123','surya@gmail.com',1,'1','1',51,'2016-02-05 22:50:38',51,'2016-02-06 02:23:28','0000-00-00 00:00:00'),(57,58,0,'Mr.','2341234','sdf','sdfsdf',1,8,'12341234',7,'2341234','1234','2341234','sadfsad@asdf.com',1,'0','1',51,'2016-02-15 06:48:47',51,'2016-02-15 06:48:47','0000-00-00 00:00:00'),(58,58,0,'Mrs.','Jo','Doctor','sdfa',4,10,'123123',11,'123','123','123','dg@adf.com',1,'1','1',51,'2016-02-15 07:14:24',51,'2016-02-15 07:14:24','0000-00-00 00:00:00'),(59,60,0,'Miss.','Gayatri','doctor','12341243',1,8,'2341234',7,NULL,NULL,'1342134','g@abc.com',NULL,'0','1',-1,'2016-02-17 06:28:38',-1,'2016-02-17 06:28:38','0000-00-00 00:00:00'),(60,60,0,'Dr.','Gayatri','doctor','park st.',1,8,'12341234',7,NULL,NULL,'1342134234','g@yopmail.com',3,'1','1',59,'2016-02-17 06:32:40',59,'2016-02-18 03:08:22','0000-00-00 00:00:00'),(61,60,0,'Dr.','Sagar','Doctor','sfsdfa',1,8,'12123',7,NULL,NULL,'12313','abc@gmail.com',3,'1','1',59,'2016-02-18 00:59:09',59,'2016-02-18 00:59:09','0000-00-00 00:00:00'),(62,58,0,'Mr.','Prakash','ARK','test test',1,8,'625002',7,NULL,NULL,'9555652154','prakash.paramanandam@arkinfotec.com',NULL,'0','1',51,'2016-02-19 07:08:10',51,'2016-02-19 07:08:10','0000-00-00 00:00:00'),(63,58,0,'Mr.','Nadesh','ARK','asdasdsa',1,8,'625010',7,NULL,NULL,'12312312323','nadesh@arkinfotec.com',NULL,'0','1',51,'2016-02-19 07:08:55',51,'2016-02-19 07:08:55','0000-00-00 00:00:00'),(64,60,0,'Dr.','Jessi','Doctor','aaa',1,8,'123123',7,NULL,NULL,'1231231231','jess@abc.com',2,'1','1',59,'2016-02-19 07:29:45',59,'2016-02-19 07:29:45','0000-00-00 00:00:00'),(65,60,0,'Dr.','Neeraj','Doctor','abcd',4,10,'121212',11,NULL,NULL,'1231231231','neeraj@gmail.com',4,'1','1',59,'2016-02-19 07:30:54',59,'2016-02-19 07:52:43','0000-00-00 00:00:00'),(66,60,0,'Mr.','Prakash Arulmani','ARK','test test',1,8,'952021',7,NULL,NULL,'9569562512','prakash@gmail.com',NULL,'0','1',59,'2016-02-20 05:10:04',59,'2016-02-20 05:10:04','0000-00-00 00:00:00'),(67,61,0,'Mrs.','Paramesh','Testor','test',1,8,'33434',7,NULL,NULL,'9789654321','parames.31390@gmail.com',NULL,'0','1',-1,'2016-02-21 23:16:05',-1,'2016-02-27 06:07:08','0000-00-00 00:00:00'),(68,61,0,'Dr.','Vikhram Vikhram  Vikhram  Vikhram  Vikhram  Vikh','psychiatrist','test',1,8,'625001',7,NULL,NULL,'9876543210','vikhram@ahanahospitals.in',11,'1','1',67,'2016-02-21 23:25:03',67,'2016-02-27 07:46:51','0000-00-00 00:00:00'),(69,61,0,'Dr.','CRS','Phychartist','test',1,8,'62555',7,NULL,NULL,'9876543210','CRS@ahana.in',11,'1','1',67,'2016-02-25 02:19:05',67,'2016-02-25 02:19:05','0000-00-00 00:00:00'),(70,61,0,'Dr.','Panjanathan','GMO','asdfasd',1,8,'322',7,NULL,NULL,'343343434','test@test.coo',12,'1','1',67,'2016-02-27 07:40:49',67,'2016-02-27 07:40:49','0000-00-00 00:00:00'),(71,61,0,'Dr.','Raja Raja Raja Raja Raja Raja Raja Raja Raja','DMO','test',1,8,'34343',7,NULL,NULL,'03934030','raja@ahana.in',11,'1','1',67,'2016-02-27 07:42:02',67,'2016-02-27 07:45:35','0000-00-00 00:00:00'),(72,61,0,'Dr.','Gopi Gopi Gopi Gopi Gopi Gopi Gopi','Counseller','DFDFD',1,8,'34',7,NULL,NULL,'344','gopi@ahana.in',11,'1','1',67,'2016-02-27 07:42:51',67,'2016-02-27 07:44:37','0000-00-00 00:00:00'),(73,62,0,'Mrs.','Paramesh','testor','34343',5,8,'343434',7,NULL,NULL,'3434343434','test@test.com',NULL,'0','1',-1,'2016-02-29 02:00:01',-1,'2016-02-29 02:00:01','0000-00-00 00:00:00');

/*Table structure for table `co_users_roles` */

DROP TABLE IF EXISTS `co_users_roles`;

CREATE TABLE `co_users_roles` (
  `user_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_role_id`),
  KEY `FK_co_user_roles` (`user_id`),
  KEY `FK_co_user_roles_role` (`role_id`),
  KEY `FK_co_user_roles_tenant` (`tenant_id`),
  CONSTRAINT `FK_co_user_roles` FOREIGN KEY (`user_id`) REFERENCES `co_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_co_user_roles_role` FOREIGN KEY (`role_id`) REFERENCES `co_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

/*Data for the table `co_users_roles` */

insert  into `co_users_roles`(`user_role_id`,`tenant_id`,`user_id`,`role_id`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,58,51,64,-1,'2016-02-02 22:26:39',NULL,NULL),(2,59,52,65,-1,'2016-02-02 22:43:12',NULL,NULL),(3,58,53,66,0,'2016-02-04 07:03:39',51,'2016-02-04 07:03:39'),(4,58,56,66,0,'2016-02-05 22:59:29',51,'2016-02-05 22:59:29'),(5,60,59,69,-1,'2016-02-17 06:28:39',NULL,NULL),(6,58,62,66,0,'2016-02-19 07:09:22',51,'2016-02-19 07:09:22'),(7,58,62,67,0,'2016-02-19 07:09:22',51,'2016-02-19 07:09:22'),(8,58,62,68,0,'2016-02-19 07:09:22',51,'2016-02-19 07:09:22'),(9,58,63,66,0,'2016-02-19 07:09:27',51,'2016-02-19 07:09:27'),(10,58,63,67,0,'2016-02-19 07:09:27',51,'2016-02-19 07:09:27'),(11,58,63,68,0,'2016-02-19 07:09:27',51,'2016-02-19 07:09:27'),(12,60,60,74,0,'2016-02-19 07:32:09',59,'2016-02-19 07:32:09'),(13,60,60,84,0,'2016-02-19 07:32:09',59,'2016-02-19 07:32:09'),(14,60,61,90,0,'2016-02-19 07:32:17',59,'2016-02-19 07:32:17'),(15,60,61,81,0,'2016-02-19 07:32:17',59,'2016-02-19 07:32:17'),(16,60,64,79,0,'2016-02-19 07:32:22',59,'2016-02-19 07:32:22'),(17,60,65,89,0,'2016-02-19 07:32:30',59,'2016-02-19 07:32:30'),(18,60,65,88,0,'2016-02-19 07:32:30',59,'2016-02-19 07:32:30'),(19,60,65,82,0,'2016-02-19 07:32:30',59,'2016-02-19 07:32:30'),(20,60,66,81,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(21,60,66,90,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(22,60,66,73,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(23,60,66,84,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(24,60,66,74,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(25,60,66,89,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(26,60,66,79,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(27,60,66,87,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(28,60,66,86,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(29,60,66,82,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(30,60,66,72,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(31,60,66,88,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(32,61,67,91,-1,'2016-02-21 23:16:05',NULL,NULL),(33,62,73,93,-1,'2016-02-29 02:00:02',NULL,NULL),(39,58,58,96,0,'2016-05-18 16:24:34',51,'2016-05-18 16:24:34'),(40,58,54,96,0,'2016-05-18 16:25:43',51,'2016-05-18 16:25:43');

/*Table structure for table `co_ward` */

DROP TABLE IF EXISTS `co_ward`;

CREATE TABLE `co_ward` (
  `ward_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `floor_id` int(11) NOT NULL,
  `ward_name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ward_id`),
  UNIQUE KEY `WardNameUnique` (`tenant_id`,`ward_name`,`floor_id`),
  KEY `FK_co_ward_floor` (`floor_id`),
  CONSTRAINT `FK_co_ward_floor` FOREIGN KEY (`floor_id`) REFERENCES `co_floor` (`floor_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_co_ward_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

/*Data for the table `co_ward` */

insert  into `co_ward`(`ward_id`,`tenant_id`,`floor_id`,`ward_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (8,58,7,'100','1',51,'2016-02-04 07:16:14',51,'2016-02-04 07:16:14','0000-00-00 00:00:00'),(9,58,8,'201','1',51,'2016-02-04 07:16:24',51,'2016-02-04 07:16:24','0000-00-00 00:00:00'),(10,58,9,'301','1',51,'2016-02-04 07:16:34',51,'2016-02-04 07:16:34','0000-00-00 00:00:00'),(11,58,8,'301','1',51,'2016-02-15 06:37:18',51,'2016-02-15 06:37:18','0000-00-00 00:00:00'),(12,60,16,'G1','1',59,'2016-02-20 01:14:02',59,'2016-02-20 01:14:02','0000-00-00 00:00:00'),(13,60,17,'F1','1',59,'2016-02-20 01:14:42',59,'2016-02-20 01:14:54','0000-00-00 00:00:00'),(14,60,18,'S1','1',59,'2016-02-20 01:15:07',59,'2016-02-20 01:15:07','0000-00-00 00:00:00'),(15,61,19,'ward1','1',67,'2016-02-23 04:43:00',67,'2016-02-23 04:43:00','0000-00-00 00:00:00'),(16,61,19,'Ward2','1',67,'2016-02-23 04:43:12',67,'2016-02-23 04:43:12','0000-00-00 00:00:00'),(17,61,19,'Ward3','1',67,'2016-02-23 04:43:25',67,'2016-02-23 04:43:25','0000-00-00 00:00:00'),(18,61,20,'Ward4','0',67,'2016-02-23 04:43:38',67,'2016-02-23 04:43:38','0000-00-00 00:00:00'),(19,61,20,'ward5','1',67,'2016-02-23 04:44:07',67,'2016-02-23 04:44:07','0000-00-00 00:00:00');

/*Table structure for table `pat_admission` */

DROP TABLE IF EXISTS `pat_admission`;

CREATE TABLE `pat_admission` (
  `admn_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `status_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `consultant_id` int(11) NOT NULL,
  `floor_id` int(11) NOT NULL,
  `ward_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `room_type_id` int(11) NOT NULL,
  `admission_status` varchar(2) NOT NULL DEFAULT 'A' COMMENT 'A - Admission, D-Discharge, TD- Transfer Doctor, TR - Transfer Room, C - Cancelled, CD - Clinical Discharge',
  `status` enum('0','1') DEFAULT '1',
  `notes` text,
  `is_swap` smallint(6) DEFAULT '0',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`admn_id`),
  KEY `FK_pat_admission_tenant` (`tenant_id`),
  KEY `FK_pat_admission_patient` (`patient_id`),
  KEY `FK_pat_admission_encounter` (`encounter_id`),
  CONSTRAINT `FK_pat_admission_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `pat_encounter` (`encounter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_admission_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_admission_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

/*Data for the table `pat_admission` */

insert  into `pat_admission`(`admn_id`,`tenant_id`,`patient_id`,`encounter_id`,`status_date`,`consultant_id`,`floor_id`,`ward_id`,`room_id`,`room_type_id`,`admission_status`,`status`,`notes`,`is_swap`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (23,58,96,20,'2016-06-11 18:51:58',54,7,8,9,10,'A','1',NULL,0,51,'2016-06-11 18:52:10',51,'2016-06-11 18:52:10','0000-00-00 00:00:00');

/*Table structure for table `pat_alert` */

DROP TABLE IF EXISTS `pat_alert`;

CREATE TABLE `pat_alert` (
  `pat_alert_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `alert_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `alert_description` text NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`pat_alert_id`),
  KEY `FK_pat_alert_tenant` (`tenant_id`),
  KEY `FK_pat_alert_alert` (`alert_id`),
  KEY `FK_pat_alert_patient` (`patient_id`),
  CONSTRAINT `FK_pat_alert_alert` FOREIGN KEY (`alert_id`) REFERENCES `co_alert` (`alert_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_alert_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_alert_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `pat_alert` */

/*Table structure for table `pat_appointment` */

DROP TABLE IF EXISTS `pat_appointment`;

CREATE TABLE `pat_appointment` (
  `appt_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `status_date` date NOT NULL,
  `status_time` time NOT NULL,
  `consultant_id` int(11) NOT NULL,
  `appt_status` char(1) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `amount` decimal(10,2) DEFAULT '0.00' COMMENT 'Doctor Fee',
  `notes` text,
  `patient_cat_id` int(11) DEFAULT NULL,
  `patient_bill_type` varchar(2) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`appt_id`),
  KEY `FK_pat_appoinment_tenant` (`tenant_id`),
  KEY `FK_pat_appoinment_patient` (`patient_id`),
  KEY `FK_pat_appoinment_counter` (`encounter_id`),
  KEY `FK_pat_appoinment_user` (`consultant_id`),
  CONSTRAINT `FK_pat_appoinment_counter` FOREIGN KEY (`encounter_id`) REFERENCES `pat_encounter` (`encounter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_appoinment_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_appoinment_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_appoinment_user` FOREIGN KEY (`consultant_id`) REFERENCES `co_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `pat_appointment` */

/*Table structure for table `pat_billing_extra_concession` */

DROP TABLE IF EXISTS `pat_billing_extra_concession`;

CREATE TABLE `pat_billing_extra_concession` (
  `ec_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `ec_type` enum('P','C') NOT NULL COMMENT 'P -> Procedures, C -> Consultant',
  `link_id` int(11) NOT NULL COMMENT 'P -> charge_subcat_id, C -> user_id',
  `extra_amount` decimal(10,2) DEFAULT '0.00',
  `concession_amount` decimal(10,2) DEFAULT '0.00',
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ec_id`),
  UNIQUE KEY `PatBillingExtraConcessionUnique` (`tenant_id`,`encounter_id`,`patient_id`,`ec_type`,`link_id`,`deleted_at`),
  KEY `FK_pat_billing_extra_concession_encounter` (`encounter_id`),
  KEY `FK_pat_billing_extra_concession_patient` (`patient_id`),
  CONSTRAINT `FK_pat_billing_extra_concession_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `pat_encounter` (`encounter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_billing_extra_concession_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_billing_extra_concession_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pat_billing_extra_concession` */

/*Table structure for table `pat_billing_other_charges` */

DROP TABLE IF EXISTS `pat_billing_other_charges`;

CREATE TABLE `pat_billing_other_charges` (
  `other_charge_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `charge_cat_id` int(11) NOT NULL,
  `charge_subcat_id` int(11) NOT NULL,
  `charge_amount` decimal(10,2) DEFAULT '0.00',
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`other_charge_id`),
  UNIQUE KEY `patBillingOtherChargeUnique` (`tenant_id`,`encounter_id`,`patient_id`,`charge_cat_id`,`charge_subcat_id`,`deleted_at`),
  KEY `FK_pat_billing_other_charges_charge_category` (`charge_cat_id`),
  KEY `FK_pat_billing_other_charges_encounter` (`encounter_id`),
  KEY `FK_pat_billing_other_charges_patient` (`patient_id`),
  KEY `FK_pat_billing_other_charges_sub_category` (`charge_subcat_id`),
  CONSTRAINT `FK_pat_billing_other_charges_charge_category` FOREIGN KEY (`charge_cat_id`) REFERENCES `co_room_charge_category` (`charge_cat_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_billing_other_charges_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `pat_encounter` (`encounter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_billing_other_charges_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_billing_other_charges_sub_category` FOREIGN KEY (`charge_subcat_id`) REFERENCES `co_room_charge_subcategory` (`charge_subcat_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_billing_other_charges_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pat_billing_other_charges` */

/*Table structure for table `pat_billing_payment` */

DROP TABLE IF EXISTS `pat_billing_payment`;

CREATE TABLE `pat_billing_payment` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `payment_date` datetime NOT NULL,
  `payment_amount` decimal(10,2) DEFAULT '0.00',
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`payment_id`),
  KEY `FK_pat_billing_payment_tenant` (`tenant_id`),
  KEY `FK_pat_billing_payment_encounter` (`encounter_id`),
  KEY `FK_pat_billing_payment_patient` (`patient_id`),
  CONSTRAINT `FK_pat_billing_payment_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `pat_encounter` (`encounter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_billing_payment_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_billing_payment_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pat_billing_payment` */

/*Table structure for table `pat_billing_recurring` */

DROP TABLE IF EXISTS `pat_billing_recurring`;

CREATE TABLE `pat_billing_recurring` (
  `recurr_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `recurr_date` date NOT NULL,
  `room_type_id` int(11) NOT NULL,
  `room_type` varchar(255) NOT NULL,
  `charge_item_id` int(11) NOT NULL,
  `charge_item` varchar(255) NOT NULL,
  `charge_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `recurr_group` smallint(6) NOT NULL COMMENT 'admission_id',
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `executed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`recurr_id`),
  KEY `FK_pat_billing_recurring_tenant` (`tenant_id`),
  KEY `FK_pat_billing_recurring_encounter` (`encounter_id`),
  KEY `FK_pat_billing_recurring_patient` (`patient_id`),
  KEY `FK_pat_billing_recurring_room_type` (`room_type_id`),
  KEY `FK_pat_billing_recurring_charge_item` (`charge_item_id`),
  CONSTRAINT `FK_pat_billing_recurring_charge_item` FOREIGN KEY (`charge_item_id`) REFERENCES `co_room_charge_item` (`charge_item_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_billing_recurring_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `pat_encounter` (`encounter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_billing_recurring_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_billing_recurring_room_type` FOREIGN KEY (`room_type_id`) REFERENCES `co_room_type` (`room_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_billing_recurring_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

/*Data for the table `pat_billing_recurring` */

insert  into `pat_billing_recurring`(`recurr_id`,`tenant_id`,`encounter_id`,`patient_id`,`recurr_date`,`room_type_id`,`room_type`,`charge_item_id`,`charge_item`,`charge_amount`,`recurr_group`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`,`executed_at`) values (12,58,20,96,'2016-06-11',10,'Non AC',3,'Room Rent','2820.00',23,'1',51,'2016-06-11 18:52:10',51,'2016-06-11 18:52:10','0000-00-00 00:00:00',NULL),(13,58,20,96,'2016-06-11',10,'Non AC',8,'DMO','2200.00',23,'1',51,'2016-06-11 18:52:10',51,'2016-06-11 18:52:10','0000-00-00 00:00:00',NULL);

/*Table structure for table `pat_billing_room_charge_history` */

DROP TABLE IF EXISTS `pat_billing_room_charge_history`;

CREATE TABLE `pat_billing_room_charge_history` (
  `charge_hist_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date DEFAULT NULL,
  `charge_item_id` int(11) NOT NULL,
  `room_type_id` int(11) NOT NULL,
  `charge` decimal(10,2) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`charge_hist_id`),
  KEY `FK_pat_billing_room_charge_history_tenant` (`tenant_id`),
  KEY `FK_pat_billing_room_charge_history_encounter` (`encounter_id`),
  KEY `FK_pat_billing_room_charge_history_patient` (`patient_id`),
  KEY `FK_pat_billing_room_charge_history_room_type` (`room_type_id`),
  KEY `FK_pat_billing_room_charge_history_charge_item` (`charge_item_id`),
  CONSTRAINT `FK_pat_billing_room_charge_history_charge_item` FOREIGN KEY (`charge_item_id`) REFERENCES `co_room_charge_item` (`charge_item_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_billing_room_charge_history_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `pat_encounter` (`encounter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_billing_room_charge_history_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_billing_room_charge_history_room_type` FOREIGN KEY (`room_type_id`) REFERENCES `co_room_type` (`room_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_billing_room_charge_history_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pat_billing_room_charge_history` */

/*Table structure for table `pat_consultant` */

DROP TABLE IF EXISTS `pat_consultant`;

CREATE TABLE `pat_consultant` (
  `pat_consult_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `consultant_id` int(11) NOT NULL,
  `consult_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `notes` text,
  `charge_amount` decimal(10,2) DEFAULT '0.00',
  `proc_id` int(11) DEFAULT '0',
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`pat_consult_id`),
  KEY `FK_pat_consultant_tenant` (`tenant_id`),
  KEY `FK_pat_consultant_encounter` (`encounter_id`),
  KEY `FK_pat_consultant_patient` (`patient_id`),
  KEY `FK_pat_consultant_user` (`consultant_id`),
  CONSTRAINT `FK_pat_consultant_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `pat_encounter` (`encounter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_consultant_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_consultant_user` FOREIGN KEY (`consultant_id`) REFERENCES `co_user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `pat_consultant` */

/*Table structure for table `pat_document_types` */

DROP TABLE IF EXISTS `pat_document_types`;

CREATE TABLE `pat_document_types` (
  `doc_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `doc_type` enum('CH') NOT NULL DEFAULT 'CH',
  `doc_type_name` varchar(50) NOT NULL,
  `document_xml` longtext NOT NULL,
  `document_xslt` longtext NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`doc_type_id`),
  KEY `FK_pat_document_types_tenant` (`tenant_id`),
  CONSTRAINT `FK_pat_document_types_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `pat_document_types` */

insert  into `pat_document_types`(`doc_type_id`,`tenant_id`,`doc_type`,`doc_type_name`,`document_xml`,`document_xslt`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'CH','Case History','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<FIELDS>\r\n    <GROUP>\r\n        <PANELHEADER>Demographic Details</PANELHEADER>\r\n        <PANELBODY>\r\n            <FIELD id=\"name\" type=\"TextBox\" label=\"Name\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">txtName</PROPERTY>\r\n                    <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    <PROPERTY name=\"name\">name</PROPERTY>\r\n                </PROPERTIES>\r\n            </FIELD>\r\n\r\n            <FIELD id=\"age\" type=\"TextBox\" label=\"Age\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">txtage</PROPERTY>\r\n                    <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                    <PROPERTY name=\"name\">age</PROPERTY>\r\n                </PROPERTIES>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"gender\" type=\"RadioButtonList\" label=\"Gender\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">gender</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Male\" id=\"RBGender1\" Selected=\"False\">Male</LISTITEM>\r\n                    <LISTITEM value=\"Female\" id=\"RBGender2\" Selected=\"False\">Female</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"address\" type=\"TextBox\" label=\"Address\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">txtAddress</PROPERTY>\r\n                    <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    <PROPERTY name=\"name\">address</PROPERTY>\r\n                </PROPERTIES>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"referral_details\" type=\"CheckBoxList\" label=\"Referral Details\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">referral_details[]</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Self\" id=\"RBRefferals1\" Selected=\"False\">Self</LISTITEM>\r\n                    <LISTITEM value=\"General Practitioner\" id=\"RBRefferals2\" Selected=\"False\">General Practitioner</LISTITEM>\r\n                    <LISTITEM value=\"Neighbours\" id=\"RBRefferals3\" Selected=\"False\">Neighbours</LISTITEM>\r\n                    <LISTITEM value=\"Traditional healer\" id=\"RBRefferals4\" Selected=\"False\">Traditional healer</LISTITEM>\r\n                    <LISTITEM value=\"Other patient\" id=\"RBRefferals5\" Selected=\"False\">Other patient</LISTITEM>\r\n                    <LISTITEM value=\"Other psychiatrist\" id=\"RBRefferals6\" Selected=\"False\">Other psychiatrist</LISTITEM>\r\n                    <LISTITEM value=\"Media\" id=\"RBRefferals7\" Selected=\"False\">Media</LISTITEM>\r\n                    <LISTITEM value=\"Others\" id=\"RBRefferals8\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'referral_details_other\');\">Others</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"referral_details_other\" type=\"TextBox\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">referral_details_other</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                        <PROPERTY name=\"name\">referral_details_other</PROPERTY>\r\n                        <PROPERTY name=\"placeholder\">Other Referral Details</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n                      \r\n            <FIELD id=\"education\" type=\"RadioButtonList\" required=\"true\" label=\"Education\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">education</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Not Educated\" id=\"RBEducation1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'educationnote\');\">Not Educated</LISTITEM>\r\n                    <LISTITEM value=\"Primary\" id=\"RBEducation2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'educationnote\');\">Primary</LISTITEM>\r\n                    <LISTITEM value=\"High School\" id=\"RBEducation3\" Selected=\"False\" onclick=\"  OThersvisible(this.id,\'educationnote\');\">High School</LISTITEM>\r\n                    <LISTITEM value=\"Graduate\" id=\"RBEducation4\" Selected=\"False\" onclick=\" OThersvisible(this.id,\'educationnote\');\">Graduate</LISTITEM>\r\n                    <LISTITEM value=\"Post Graduate\" id=\"RBEducation5\" Selected=\"False\" onclick=\" OThersvisible(this.id,\'educationnote\');\">Post Graduate</LISTITEM>\r\n                    <LISTITEM value=\"Other\" id=\"RBEducation6\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'educationnote\');\">Other</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"educationnote\" type=\"TextBox\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">educationnote</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                        <PROPERTY name=\"name\">educationnote</PROPERTY>\r\n                        <PROPERTY name=\"placeholder\">Education Notes</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n                      \r\n            <FIELD id=\"occupation\" type=\"RadioButtonList\" label=\"Occupation\" re1quired=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">occupation</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Employed\" id=\"RBoccupation1\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'occupationnote\');\">Employed</LISTITEM>\r\n                    <LISTITEM value=\"UnEmployed\" id=\"RBoccupation2\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'occupationnote\');\">UnEmployed</LISTITEM>\r\n                    <LISTITEM value=\"Homemaker\" id=\"RBoccupation3\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'occupationnote\');\">Homemaker</LISTITEM>\r\n                    <LISTITEM value=\"Student\" id=\"RBoccupation4\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'occupationnote\');\">Student</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"occupationnote\" type=\"TextBox\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">occupationnote</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                        <PROPERTY name=\"name\">occupationnote</PROPERTY>\r\n                        <PROPERTY name=\"placeholder\">Occupation Notes</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"martial_status\" type=\"RadioButtonList\" label=\"Martial Status\" required=\"true\" >\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">martial_status</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Never married\" id=\"RBMartial1\" Selected=\"False\">Never married</LISTITEM>\r\n                    <LISTITEM value=\"Married\" id=\"RBMartial2\" Selected=\"False\">Married</LISTITEM>\r\n                    <LISTITEM value=\"Separated\" id=\"RBMartial3\" Selected=\"False\">Separated</LISTITEM>\r\n                    <LISTITEM value=\"Divorced\" id=\"RBMartial4\" Selected=\"False\">Divorced</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"religion\" type=\"RadioButtonList\" label=\"Religion\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">religion</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Hindu\" id=\"RBReligion1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'religionother\',\'none\');\">Hindu</LISTITEM>\r\n                    <LISTITEM value=\"Muslim\" id=\"RBReligion2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'religionother\',\'none\');\">Muslim</LISTITEM>\r\n                    <LISTITEM value=\"Christian\" id=\"RBReligion3\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'religionother\',\'none\');\">Christian</LISTITEM>\r\n                    <LISTITEM value=\"Others\" id=\"RBReligion4\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'religionother\',\'block\');\">Others</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"religionother\" type=\"TextBox\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">religionother</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                        <PROPERTY name=\"name\">religionother</PROPERTY>\r\n                        <PROPERTY name=\"placeholder\">Religion Other</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"status\" type=\"RadioButtonList\" label=\"Status\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">status</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Lower\" id=\"RBstatus1\" Selected=\"False\">Lower</LISTITEM>\r\n                    <LISTITEM value=\"Middle\" id=\"RBstatus2\" Selected=\"False\">Middle</LISTITEM>\r\n                    <LISTITEM value=\"Upper\" id=\"RBstatus3\" Selected=\"False\">Upper</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"place_of_living\" type=\"RadioButtonList\" label=\"Place of living\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">place_of_living</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Rural\" id=\"RBliving1\" Selected=\"False\">Rural</LISTITEM>\r\n                    <LISTITEM value=\"Urban\" id=\"RBliving2\" Selected=\"False\">Urban</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD type=\"Header2\" label=\"Informant\"></FIELD>\r\n            \r\n            <FIELD id=\"relationship\" type=\"RadioButtonList\" label=\"Relationship\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">relationship</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Self\" id=\"RBRelation1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'relationshipother\',\'none\');\">Self</LISTITEM>\r\n                    <LISTITEM value=\"Father\" id=\"RBRelation2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'relationshipother\',\'none\');\">Father</LISTITEM>\r\n                    <LISTITEM value=\"Mother\" id=\"RBRelation3\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'relationshipother\',\'none\');\">Mother</LISTITEM>\r\n                    <LISTITEM value=\"Sibling\" id=\"RBRelation4\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'relationshipother\',\'none\');\">Sibling</LISTITEM>\r\n                    <LISTITEM value=\"Spouse\" id=\"RBRelation5\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'relationshipother\',\'none\');\">Spouse</LISTITEM>\r\n                    <LISTITEM value=\"Children\" id=\"RBRelation6\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'relationshipother\',\'none\');\">Children</LISTITEM>\r\n                    <LISTITEM value=\"Friend\" id=\"RBRelation7\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'relationshipother\',\'none\');\">Friend</LISTITEM>\r\n                    <LISTITEM value=\"Others\" id=\"RBRelation8\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'relationshipother\',\'block\');\">Others</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"relationshipother\" type=\"TextBox\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">relationshipother</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                        <PROPERTY name=\"name\">relationshipother</PROPERTY>\r\n                        <PROPERTY name=\"placeholder\">Relationship Other</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"primary_care_giver\" type=\"RadioButtonList\" label=\"Primary Care giver\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">primary_care_giver</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Yes\" id=\"RBPrimarycare1\" Selected=\"False\">Yes</LISTITEM>\r\n                    <LISTITEM value=\"No\" id=\"RBPrimarycare2\" Selected=\"False\">No</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"duration_of_relationship\" type=\"TextBox\" label=\"Duration of Relationship\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">txtrelduration</PROPERTY>\r\n                    <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                    <PROPERTY name=\"name\">duration_of_relationship</PROPERTY>\r\n                </PROPERTIES>\r\n                <FIELD id=\"ddlrelation\" type=\"DropDownList\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">ddlrelation</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"name\">ddlrelation</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Yrs\" Selected=\"True\">Yrs</LISTITEM>\r\n                        <LISTITEM value=\"Months\" Selected=\"False\">Months</LISTITEM>\r\n                        <LISTITEM value=\"Weeks\" Selected=\"False\">Weeks</LISTITEM>\r\n                        <LISTITEM value=\"Days\" Selected=\"False\">Days</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"information\" type=\"RadioButtonList\" label=\"Information\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">information</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Reliable\" id=\"RBInfo1\" Selected=\"False\">Reliable</LISTITEM>\r\n                    <LISTITEM value=\"Unreliable\" id=\"RBInfo2\" Selected=\"False\">Unreliable</LISTITEM>\r\n                    <LISTITEM value=\"Adequate\" id=\"RBInfo3\" Selected=\"False\">Adequate</LISTITEM>\r\n                    <LISTITEM value=\"Inadequate\" id=\"RBInfo4\" Selected=\"False\">Inadequate</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n        </PANELBODY>\r\n    </GROUP>\r\n    \r\n    <GROUP>\r\n        <PANELHEADER>Presenting Compliants (In chronological order)</PANELHEADER>\r\n        <PANELBODY>\r\n            <FIELD type=\"RadGrid\" ADDButton=\"True\" ADDButtonID=\"RGCompliantadd\" AddButtonTableId=\"RGCompliant\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">RGCompliant</PROPERTY>\r\n                    <PROPERTY name=\"class\">table table-bordered</PROPERTY>\r\n                </PROPERTIES>\r\n                <HEADER>\r\n                    <TH>Complaints</TH>\r\n                    <TH>Duration</TH>\r\n                </HEADER>\r\n                <COLUMNS>\r\n                    <FIELD id=\"txtComplaints\" type=\"TextBox\" HeaderText=\"Complaints\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txtComplaints</PROPERTY>\r\n                            <PROPERTY name=\"name\">txtComplaints</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                    <FIELD id=\"txtDuration\" type=\"TextBox\" HeaderText=\"Duration\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txtDuration</PROPERTY>\r\n                            <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                            <PROPERTY name=\"name\">txtDuration</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <FIELD id=\"DDLDuration\" type=\"DropDownList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">DDLDuration</PROPERTY>\r\n                                <PROPERTY name=\"name\">DDLDuration</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"Yrs\" Selected=\"False\">Yrs</LISTITEM>\r\n                                <LISTITEM value=\"Months\" Selected=\"False\">Months</LISTITEM>\r\n                                <LISTITEM value=\"Weeks\" Selected=\"False\">Weeks</LISTITEM>\r\n                                <LISTITEM value=\"Days\" Selected=\"False\">Days</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                    </FIELD>\r\n                </COLUMNS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"total_duration\" type=\"TextBox\" label=\"Total Duration\" required=\"true\" >\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">txtillduration</PROPERTY>\r\n                    <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                    <PROPERTY name=\"name\">total_duration</PROPERTY>\r\n                </PROPERTIES>\r\n                <FIELD id=\"ddlillduration\" type=\"DropDownList\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">ddlillduration</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"name\">ddlillduration</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Yrs\" Selected=\"False\">Yrs</LISTITEM>\r\n                        <LISTITEM value=\"Months\" Selected=\"False\">Months</LISTITEM>\r\n                        <LISTITEM value=\"Weeks\" Selected=\"False\">Weeks</LISTITEM>\r\n                        <LISTITEM value=\"Days\" Selected=\"False\">Days</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"mode_of_onset\" type=\"RadioButtonList\" label=\"Mode of Onset\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">mode_of_onset</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Abrupt\" id=\"RBmode1\" Selected=\"False\">Abrupt</LISTITEM>\r\n                    <LISTITEM value=\"Acute\" id=\"RBmode2\" Selected=\"False\">Acute</LISTITEM>\r\n                    <LISTITEM value=\"Subacute\" id=\"RBmode3\" Selected=\"False\">Subacute</LISTITEM>\r\n                    <LISTITEM value=\"Insidious\" id=\"RBmode4\" Selected=\"False\">Insidious</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"course_type\" type=\"RadioButtonList\" label=\"Course type\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">course_type</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Continuous\" id=\"RBcourse1\" Selected=\"False\">Continuous</LISTITEM>\r\n                    <LISTITEM value=\"Episodic\" id=\"RBcourse2\" Selected=\"False\">Episodic</LISTITEM>\r\n                    <LISTITEM value=\"Fluctuating\" id=\"RBcourse3\" Selected=\"False\">Fluctuating</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"precipitating_factor\" type=\"CheckBoxList\" label=\"Precipitating factor\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">precipitating_factor[]</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Bereavement\" id=\"RBpresent1\" Selected=\"False\">Bereavement</LISTITEM>\r\n                    <LISTITEM value=\"Financial loss\" id=\"RBpresent2\" Selected=\"False\">Financial loss</LISTITEM>\r\n                    <LISTITEM value=\"Family conflicts\" id=\"RBpresent3\" Selected=\"False\">Family conflicts</LISTITEM>\r\n                    <LISTITEM value=\"Difficulty at work\" id=\"RBpresent4\" Selected=\"False\">Difficulty at work</LISTITEM>\r\n                    <LISTITEM value=\"Physical ailment\" id=\"RBpresent5\" Selected=\"False\">Physical ailment</LISTITEM>\r\n                    <LISTITEM value=\"Relationship problems\" id=\"RBpresent6\" Selected=\"False\">Relationship problems</LISTITEM>\r\n                    <LISTITEM value=\"Others\" id=\"RBpresent7\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'precipitating_factor_other\');\">Others</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"precipitating_factor_other\" type=\"TextBox\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">precipitating_factor_other</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                        <PROPERTY name=\"name\">precipitating_factor_other</PROPERTY>\r\n                        <PROPERTY name=\"placeholder\">Other Precipitating Factor</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"nature\" type=\"RadioButtonList\" label=\"Nature\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">nature</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Progressive\" id=\"RBnature1\" Selected=\"False\">Progressive</LISTITEM>\r\n                    <LISTITEM value=\"Improving\" id=\"RBnature2\" Selected=\"False\">Improving</LISTITEM>\r\n                    <LISTITEM value=\"Static\" id=\"RBnature3\" Selected=\"False\">Static</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n        </PANELBODY>\r\n    </GROUP>\r\n    \r\n    <GROUP>\r\n        <PANELHEADER>History Of Presenting Illness</PANELHEADER>\r\n        <PANELBODY>\r\n            <FIELD id=\"history_presenting_illness\" type=\"textareaFull\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">history_presenting_illness</PROPERTY>\r\n                    <PROPERTY name=\"name\">history_presenting_illness</PROPERTY>\r\n                    <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    <PROPERTY name=\"rows\">6</PROPERTY>\r\n                </PROPERTIES>\r\n            </FIELD>\r\n            \r\n            <FIELD type=\"Header2\" label=\"Associated Disturbances\"></FIELD>\r\n            \r\n            <FIELD id=\"sleep\" type=\"RadioButtonList\" label=\"Sleep\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">sleep</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Premorbid\" id=\"sleep1\" Selected=\"False\">Premorbid</LISTITEM>\r\n                    <LISTITEM value=\"Increased\" id=\"sleep2\" Selected=\"False\">Increased</LISTITEM>\r\n                    <LISTITEM value=\"Decreased\" id=\"sleep3\" Selected=\"False\">Decreased</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"appetite\" type=\"RadioButtonList\" label=\"Appetite\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">appetite</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Premorbid\" id=\"appetite1\" Selected=\"False\">Premorbid</LISTITEM>\r\n                    <LISTITEM value=\"Increased\" id=\"appetite2\" Selected=\"False\">Increased</LISTITEM>\r\n                    <LISTITEM value=\"Decreased\" id=\"appetite3\" Selected=\"False\">Decreased</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"weight\" type=\"RadioButtonList\" label=\"Weight\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">weight</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Premorbid\" id=\"weight1\" Selected=\"False\">Premorbid</LISTITEM>\r\n                    <LISTITEM value=\"Increased\" id=\"weight2\" Selected=\"False\">Increased</LISTITEM>\r\n                    <LISTITEM value=\"Decreased\" id=\"weight3\" Selected=\"False\">Decreased</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"sexual_functioning\" type=\"RadioButtonList\" label=\"Sexual Functioning\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">sexual_functioning</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Premorbid\" id=\"sexual_functioning1\" Selected=\"False\">Premorbid</LISTITEM>\r\n                    <LISTITEM value=\"Increased\" id=\"sexual_functioning2\" Selected=\"False\">Increased</LISTITEM>\r\n                    <LISTITEM value=\"Decreased\" id=\"sexual_functioning3\" Selected=\"False\">Decreased</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"social_functioning\" type=\"RadioButtonList\" label=\"Social Functioning\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">social_functioning</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Intact\" id=\"social_functioning1\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'social_functioning_radio_div\', \'none\');\">Intact</LISTITEM>\r\n                    <LISTITEM value=\"Impaired\" id=\"social_functioning2\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'social_functioning_radio_div\', \'block\');\">Impaired</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"social_functioning_radio\" type=\"RadioButtonList\" label=\"Severity\" Backcontrols=\"true\" Backdivid=\"social_functioning_radio_div\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">social_functioning_radio</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Mild\" id=\"social_functioning_radio1\" Selected=\"False\">Mild</LISTITEM>\r\n                        <LISTITEM value=\"Moderate\" id=\"social_functioning_radio2\" Selected=\"False\">Moderate</LISTITEM>\r\n                        <LISTITEM value=\"Severe\" id=\"social_functioning_radio3\" Selected=\"False\">Severe</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"occupational_functioning\" type=\"RadioButtonList\" label=\"Occupational Functioning\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">occupational_functioning</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Intact\" id=\"occupational_functioning1\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'occupational_functioning_radio_div\', \'none\');\">Intact</LISTITEM>\r\n                    <LISTITEM value=\"Impaired\" id=\"occupational_functioning2\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'occupational_functioning_radio_div\', \'block\');\">Impaired</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"occupational_functioning_radio\" type=\"RadioButtonList\" label=\"Severity\" Backcontrols=\"true\" Backdivid=\"occupational_functioning_radio_div\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">occupational_functioning_radio</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Mild\" id=\"occupational_functioning_radio1\" Selected=\"False\">Mild</LISTITEM>\r\n                        <LISTITEM value=\"Moderate\" id=\"occupational_functioning_radio2\" Selected=\"False\">Moderate</LISTITEM>\r\n                        <LISTITEM value=\"Severe\" id=\"occupational_functioning_radio3\" Selected=\"False\">Severe</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n            </FIELD>\r\n        </PANELBODY>\r\n    </GROUP>\r\n    \r\n    <GROUP>\r\n        <PANELHEADER>Past History</PANELHEADER>\r\n        <PANELBODY>\r\n            <FIELD type=\"Header2\" label=\"Past Psychiatric History\"></FIELD>\r\n            \r\n            <FIELD id=\"similar_episodes\" type=\"RadioButtonList\" label=\"Similar Episodes\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">similar_episodes</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"No\" id=\"similar_episodes1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'similar_episodes_ddl_div\',\'none\');\">No</LISTITEM>\r\n                    <LISTITEM value=\"Yes\" id=\"similar_episodes2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'similar_episodes_ddl_div\',\'block\');\">Yes</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"similar_episodes_ddl\" type=\"DropDownList\" label=\"Number of Episodes\" Backcontrols=\"true\" Backdivid=\"similar_episodes_ddl_div\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">similar_episodes_ddl</PROPERTY>\r\n                        <PROPERTY name=\"name\">similar_episodes_ddl</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"--Select--\" Selected=\"False\">--Select--</LISTITEM>\r\n                        <LISTITEM value=\"1\" Selected=\"False\">1</LISTITEM>\r\n                        <LISTITEM value=\"2\" Selected=\"False\">2</LISTITEM>\r\n                        <LISTITEM value=\"3\" Selected=\"False\">3</LISTITEM>\r\n                        <LISTITEM value=\"4\" Selected=\"False\">4</LISTITEM>\r\n                        <LISTITEM value=\"5\" Selected=\"False\">5</LISTITEM>\r\n                        <LISTITEM value=\"6\" Selected=\"False\">6</LISTITEM>\r\n                        <LISTITEM value=\"7\" Selected=\"False\">7</LISTITEM>\r\n                        <LISTITEM value=\"8\" Selected=\"False\">8</LISTITEM>\r\n                        <LISTITEM value=\"9\" Selected=\"False\">9</LISTITEM>\r\n                        <LISTITEM value=\"10\" Selected=\"False\">10</LISTITEM>\r\n                        <LISTITEM value=\"11\" Selected=\"False\">11</LISTITEM>\r\n                        <LISTITEM value=\"12\" Selected=\"False\">12</LISTITEM>\r\n                        <LISTITEM value=\"13\" Selected=\"False\">13</LISTITEM>\r\n                        <LISTITEM value=\"14\" Selected=\"False\">14</LISTITEM>\r\n                        <LISTITEM value=\"15\" Selected=\"False\">15</LISTITEM>\r\n                        <LISTITEM value=\"16\" Selected=\"False\">16</LISTITEM>\r\n                        <LISTITEM value=\"17\" Selected=\"False\">17</LISTITEM>\r\n                        <LISTITEM value=\"18\" Selected=\"False\">18</LISTITEM>\r\n                        <LISTITEM value=\"19\" Selected=\"False\">19</LISTITEM>\r\n                        <LISTITEM value=\"20\" Selected=\"False\">20</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"past_psychiatric_history\" type=\"textareaFull\" label=\"Notes\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">past_psychiatric_history</PROPERTY>\r\n                    <PROPERTY name=\"name\">past_psychiatric_history</PROPERTY>\r\n                    <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    <PROPERTY name=\"rows\">6</PROPERTY>\r\n                </PROPERTIES>\r\n            </FIELD>\r\n            \r\n            <FIELD type=\"Header2\" label=\"Past Medical History\"></FIELD>\r\n            \r\n            <FIELD type=\"RadGrid\" ADDButton=\"True\" ADDButtonID=\"RGMedHisadd\" AddButtonTableId=\"RGMedicalHistory\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">RGMedicalHistory</PROPERTY>\r\n                    <PROPERTY name=\"class\">table table-bordered</PROPERTY>\r\n                </PROPERTIES>\r\n                <HEADER>\r\n                    <TH>Complaints</TH>\r\n                    <TH>Duration</TH>\r\n                    <TH>Currently under treatment</TH>\r\n                </HEADER>\r\n                <COLUMNS>\r\n                    <FIELD id=\"DDLMedHis\" type=\"DropDownList\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">DDLMedHis</PROPERTY>\r\n                            <PROPERTY name=\"name\">DDLMedHis</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"--Select--\" Selected=\"False\">--Select--</LISTITEM>\r\n                            <LISTITEM value=\"Diabetes\" Selected=\"False\">Diabetes</LISTITEM>\r\n                            <LISTITEM value=\"Hypertension\" Selected=\"False\">Hypertension</LISTITEM>\r\n                            <LISTITEM value=\"Tuberculosis\" Selected=\"False\">Tuberculosis</LISTITEM>\r\n                            <LISTITEM value=\"Hepatitis\" Selected=\"False\">Hepatitis</LISTITEM>\r\n                            <LISTITEM value=\"Asthma\" Selected=\"False\">Asthma</LISTITEM>\r\n                            <LISTITEM value=\"Bronchitis\" Selected=\"False\">Bronchitis</LISTITEM>\r\n                            <LISTITEM value=\"Head injury/LOC\" Selected=\"False\">Head injury/LOC</LISTITEM>\r\n                            <LISTITEM value=\"Seizures\" Selected=\"False\">Seizures</LISTITEM>\r\n                            <LISTITEM value=\"Cerebrovascular Accidents\" Selected=\"False\">Cerebrovascular Accidents</LISTITEM>\r\n                            <LISTITEM value=\"Immuno compromised state\" Selected=\"False\">Immuno compromised state</LISTITEM>\r\n                            <LISTITEM value=\"Mycocardial Infarction\" Selected=\"False\">Mycocardial Infarction</LISTITEM>\r\n                            <LISTITEM value=\"Allergies\" Selected=\"False\">Allergies</LISTITEM>\r\n                            <LISTITEM value=\"IHD\" Selected=\"False\">IHD</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                    \r\n                    <FIELD id=\"TxtMedHisDuration\" type=\"TextBox\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">TxtMedHisDuration</PROPERTY>\r\n                            <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                            <PROPERTY name=\"name\">TxtMedHisDuration</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <FIELD id=\"DDLMedHisDuration\" type=\"DropDownList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">DDLMedHisDuration</PROPERTY>\r\n                                <PROPERTY name=\"name\">DDLMedHisDuration</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"Yrs\" Selected=\"False\">Yrs</LISTITEM>\r\n                                <LISTITEM value=\"Months\" Selected=\"False\">Months</LISTITEM>\r\n                                <LISTITEM value=\"Weeks\" Selected=\"False\">Weeks</LISTITEM>\r\n                                <LISTITEM value=\"Days\" Selected=\"False\">Days</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                    </FIELD>\r\n                    \r\n                    <FIELD id=\"radio_med_his_currently_under_treatment\" type=\"RadioButtonList\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"name\">radio_med_his_currently_under_treatment</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"Yes\" id=\"radio_med_his_currently_under_treatment1\" Selected=\"False\">Yes</LISTITEM>\r\n                            <LISTITEM value=\"No\" id=\"radio_med_his_currently_under_treatment2\" Selected=\"False\">No</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                </COLUMNS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"past_medical_history_notes\" type=\"textareaFull\" label=\"Notes\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">past_medical_history_notes</PROPERTY>\r\n                    <PROPERTY name=\"name\">past_medical_history_notes</PROPERTY>\r\n                    <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    <PROPERTY name=\"rows\">6</PROPERTY>\r\n                </PROPERTIES>\r\n            </FIELD>\r\n            \r\n            <!-- 08/06/2016-->\r\n            <FIELD type=\"PanelBar\" label=\"Treatment History\" target_div=\"treatment_history\">\r\n                <FIELD type=\"Header2\" label=\"Phamacotherapy\"></FIELD>\r\n                \r\n                <FIELD type=\"RadGrid\" ADDButton=\"True\" ADDButtonID=\"RGPhamacoadd\" AddButtonTableId=\"RGPhamaco\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">RGPhamaco</PROPERTY>\r\n                        <PROPERTY name=\"class\">table table-bordered</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <HEADER>\r\n                        <TH>Drug name</TH>\r\n                        <TH>Duration</TH>\r\n                        <TH>Currently under treatment</TH>\r\n                        <TH>Side effects</TH>\r\n                    </HEADER>\r\n                    <COLUMNS>\r\n                        <FIELD id=\"txtPhamacoDrugName\" type=\"TextBox\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">txtPhamacoDrugName</PROPERTY>\r\n                                <PROPERTY name=\"name\">txtPhamacoDrugName</PROPERTY>\r\n                            </PROPERTIES>\r\n                        </FIELD>\r\n                        <FIELD id=\"txtPhamacoDuration\" type=\"TextBox\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">txtPhamacoDuration</PROPERTY>\r\n                                <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                                <PROPERTY name=\"name\">txtPhamacoDuration</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <FIELD id=\"DDLPhamacoDuration\" type=\"DropDownList\">\r\n                                <PROPERTIES>\r\n                                    <PROPERTY name=\"id\">DDLPhamacoDuration</PROPERTY>\r\n                                    <PROPERTY name=\"name\">DDLPhamacoDuration</PROPERTY>\r\n                                </PROPERTIES>\r\n                                <LISTITEMS>\r\n                                    <LISTITEM value=\"Yrs\" Selected=\"False\">Yrs</LISTITEM>\r\n                                    <LISTITEM value=\"Months\" Selected=\"False\">Months</LISTITEM>\r\n                                    <LISTITEM value=\"Weeks\" Selected=\"False\">Weeks</LISTITEM>\r\n                                    <LISTITEM value=\"Days\" Selected=\"False\">Days</LISTITEM>\r\n                                </LISTITEMS>\r\n                            </FIELD>\r\n                        </FIELD>\r\n                        <FIELD id=\"radioPhamacoCurrentlyUnderTreatment\" type=\"RadioButtonList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"name\">radioPhamacoCurrentlyUnderTreatment</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"Adequate\" id=\"radioPhamacoCurrentlyUnderTreatment1\" Selected=\"False\">Adequate</LISTITEM>\r\n                                <LISTITEM value=\"Inadequate\" id=\"radioPhamacoCurrentlyUnderTreatment2\" Selected=\"False\">Inadequate</LISTITEM>\r\n                                <LISTITEM value=\"Partial\" id=\"radioPhamacoCurrentlyUnderTreatment3\" Selected=\"False\">Partial</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                        <FIELD id=\"txtPhamacoSideEffects\" type=\"TextBox\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">txtPhamacoSideEffects</PROPERTY>\r\n                                <PROPERTY name=\"name\">txtPhamacoSideEffects</PROPERTY>\r\n                            </PROPERTIES>\r\n                        </FIELD>\r\n                    </COLUMNS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"rb_pb_treatmenthistory\" type=\"RadioButtonList\" label=\"Medication Compliance\" required=\"true\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">rb_pb_treatmenthistory</PROPERTY>\r\n                        <PROPERTY name=\"ToolTip\">\r\n                            In the last 3 monts:\r\n                            Continuous intake=complaint\r\n                            Missed medic for less than 1wk= partially adherent\r\n                            Missed medic for 1wk or more=non-complaint\r\n                            (Criteria used by- Olfson et al,2000)\r\n                        </PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM id=\"rb_pb_treatmenthistory1\" value=\"Non-complaint\" Selected=\"False\">Non-complaint</LISTITEM>\r\n                        <LISTITEM id=\"rb_pb_treatmenthistory2\" value=\"Complaint\" Selected=\"False\">Complaint</LISTITEM>\r\n                        <LISTITEM id=\"rb_pb_treatmenthistory3\" value=\"Partially Complaint\" Selected=\"False\">Partially Complaint</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"Header2\" label=\"Electro Convulsive therapy\"></FIELD>\r\n                \r\n                <FIELD id=\"previous_ects\" type=\"RadioButtonList\" label=\"Previous ECT\'s\" Backcontrols=\"true\" Backdivid=\"previous_ects_radio_div\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">previous_ects</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"No\" id=\"previous_ects1\"  Selected=\"False\" onclick=\"OThersvisible(this.id,\'previous_ects_radio_div\',\'none\');\">No</LISTITEM>\r\n                        <LISTITEM value=\"Yes\" id=\"previous_ects2\"  Selected=\"False\" onclick=\"OThersvisible(this.id,\'previous_ects_radio_div\',\'block\');\">Yes</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"no_of_ects_ddl\" type=\"DropDownList\" label=\"No. of ECT course(s)\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">no_of_ects_ddl</PROPERTY>\r\n                            <PROPERTY name=\"name\">no_of_ects_ddl</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"--Select--\" Selected=\"False\">--Select--</LISTITEM>\r\n                            <LISTITEM value=\"1\" Selected=\"False\">1</LISTITEM>\r\n                            <LISTITEM value=\"2\" Selected=\"False\">2</LISTITEM>\r\n                            <LISTITEM value=\"3\" Selected=\"False\">3</LISTITEM>\r\n                            <LISTITEM value=\"4\" Selected=\"False\">4</LISTITEM>\r\n                            <LISTITEM value=\"5\" Selected=\"False\">5</LISTITEM>\r\n                            <LISTITEM value=\"6\" Selected=\"False\">6</LISTITEM>\r\n                            <LISTITEM value=\"7\" Selected=\"False\">7</LISTITEM>\r\n                            <LISTITEM value=\"8\" Selected=\"False\">8</LISTITEM>\r\n                            <LISTITEM value=\"9\" Selected=\"False\">9</LISTITEM>\r\n                            <LISTITEM value=\"10\" Selected=\"False\">10</LISTITEM>\r\n                            <LISTITEM value=\"11\" Selected=\"False\">11</LISTITEM>\r\n                            <LISTITEM value=\"12\" Selected=\"False\">12</LISTITEM>\r\n                            <LISTITEM value=\"13\" Selected=\"False\">13</LISTITEM>\r\n                            <LISTITEM value=\"14\" Selected=\"False\">14</LISTITEM>\r\n                            <LISTITEM value=\"15\" Selected=\"False\">15</LISTITEM>\r\n                            <LISTITEM value=\"16\" Selected=\"False\">16</LISTITEM>\r\n                            <LISTITEM value=\"17\" Selected=\"False\">17</LISTITEM>\r\n                            <LISTITEM value=\"18\" Selected=\"False\">18</LISTITEM>\r\n                            <LISTITEM value=\"19\" Selected=\"False\">19</LISTITEM>\r\n                            <LISTITEM value=\"20\" Selected=\"False\">20</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                    <FIELD id=\"average_no_of_ects_ddl\" type=\"DropDownList\" label=\"Average no. of ECT session per course\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">average_no_of_ects_ddl</PROPERTY>\r\n                            <PROPERTY name=\"name\">average_no_of_ects_ddl</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"--Select--\" Selected=\"False\">--Select--</LISTITEM>\r\n                            <LISTITEM value=\"1\" Selected=\"False\">1</LISTITEM>\r\n                            <LISTITEM value=\"2\" Selected=\"False\">2</LISTITEM>\r\n                            <LISTITEM value=\"3\" Selected=\"False\">3</LISTITEM>\r\n                            <LISTITEM value=\"4\" Selected=\"False\">4</LISTITEM>\r\n                            <LISTITEM value=\"5\" Selected=\"False\">5</LISTITEM>\r\n                            <LISTITEM value=\"6\" Selected=\"False\">6</LISTITEM>\r\n                            <LISTITEM value=\"7\" Selected=\"False\">7</LISTITEM>\r\n                            <LISTITEM value=\"8\" Selected=\"False\">8</LISTITEM>\r\n                            <LISTITEM value=\"9\" Selected=\"False\">9</LISTITEM>\r\n                            <LISTITEM value=\"10\" Selected=\"False\">10</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                    <FIELD id=\"response_ects_ddl\" type=\"DropDownList\" label=\"Response to ECT (%)\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">response_ects_ddl</PROPERTY>\r\n                            <PROPERTY name=\"name\">response_ects_ddl</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"--Select--\" Selected=\"False\">--Select--</LISTITEM>\r\n                            <LISTITEM value=\"25\" Selected=\"False\">25</LISTITEM>\r\n                            <LISTITEM value=\"50\" Selected=\"False\">50</LISTITEM>\r\n                            <LISTITEM value=\"75\" Selected=\"False\">75</LISTITEM>\r\n                            <LISTITEM value=\"100\" Selected=\"False\">100</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"Header2\" label=\"Counselling/Psychotherapy\"></FIELD>\r\n                \r\n                <FIELD id=\"rb_pb_mostrecentepisode\" type=\"RadioButtonList\" label=\"Most recent episode\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">rb_pb_mostrecentepisode</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Yes\" id=\"rb_pb_mostrecentepisode1\" Selected=\"False\">Yes</LISTITEM>\r\n                        <LISTITEM value=\"No\" id=\"rb_pb_mostrecentepisode2\" Selected=\"False\">No</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"txt_pb_no_of_sessions\" type=\"TextBox\" label=\"No. of sessions\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">txt_pb_no_of_sessions</PROPERTY>\r\n                        <PROPERTY name=\"name\">txt_pb_no_of_sessions</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"rb_pb_Response\" type=\"RadioButtonList\" label=\"Response\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">rb_pb_Response</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Adequate\" id=\"rb_pb_Response1\" Selected=\"False\">Adequate</LISTITEM>\r\n                        <LISTITEM value=\"Inadequate\" id=\"rb_pb_Response2\" Selected=\"False\">Inadequate</LISTITEM>\r\n                        <LISTITEM value=\"Partial\" id=\"rb_pb_Response3\" Selected=\"False\">Partial</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"rb_pb_Response1\" type=\"RadioButtonList\" Backcontrols=\"true\" Backdivid=\"rb_pb_Response1_Div\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">rb_pb_Response1</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Completed\" id=\"rb_pb_Response11\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'rb_pb_Response1_Div\',\'none\');\">Completed</LISTITEM>\r\n                        <LISTITEM value=\"Discontinued\" id=\"rb_pb_Response12\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'rb_pb_Response1_Div\',\'block\');\">Discontinued</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"txt_pb_reason\" type=\"TextBox\" label=\"Reason\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txt_pb_reason</PROPERTY>\r\n                            <PROPERTY name=\"name\">txt_pb_reason</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"Header2\" label=\"Alternative Therapies\"></FIELD>\r\n                \r\n                <FIELD type=\"RadGrid\" ADDButton=\"True\" ADDButtonID=\"RGaltadd\" AddButtonTableId=\"RGalt\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">RGalt</PROPERTY>\r\n                        <PROPERTY name=\"class\">table table-bordered</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <HEADER>\r\n                        <TH>Therapy</TH>\r\n                        <TH>Taken</TH>\r\n                        <TH>Currently under treatment</TH>\r\n                    </HEADER>\r\n                    <COLUMNS>\r\n                        <FIELD id=\"ddl_pb_therapy\" type=\"DropDownList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">ddl_pb_therapy</PROPERTY>\r\n                                <PROPERTY name=\"name\">ddl_pb_therapy</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"--Select--\" Selected=\"False\">--Select--</LISTITEM>\r\n                                <LISTITEM value=\"Magico Religious\" Selected=\"False\">Magico Religious</LISTITEM>\r\n                                <LISTITEM value=\"Homeopathy\" Selected=\"False\">Homeopathy</LISTITEM>\r\n                                <LISTITEM value=\"Ayurveda\" Selected=\"False\">Ayurveda</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                        <FIELD id=\"radio_pb_taken\" type=\"RadioButtonList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"name\">radio_pb_taken</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"Yes\" id=\"radio_pb_taken1\" Selected=\"False\">Yes</LISTITEM>\r\n                                <LISTITEM value=\"No\" id=\"radio_pb_taken2\" Selected=\"False\">No</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                        <FIELD id=\"radio_pb_currently_under_taken\" type=\"RadioButtonList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"name\">radio_pb_currently_under_taken</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"Adequate\" id=\"radio_pb_currently_under_taken1\" Selected=\"False\">Adequate</LISTITEM>\r\n                                <LISTITEM value=\"Inadequate\" id=\"radio_pb_currently_under_taken2\" Selected=\"False\">Inadequate</LISTITEM>\r\n                                <LISTITEM value=\"Partial\" id=\"radio_pb_currently_under_taken3\" Selected=\"False\">Partial</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                        \r\n                    </COLUMNS>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"Header2\" label=\"Treatment History Notes\"></FIELD>\r\n                \r\n                <FIELD id=\"treatment_history_notes\" type=\"textareaFull\" label=\"Notes\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">treatment_history_notes</PROPERTY>\r\n                        <PROPERTY name=\"name\">treatment_history_notes</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"rows\">6</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD type=\"PanelBar\" label=\"Family History\" target_div=\"family_history\">\r\n                <FIELD id=\"RBtypeoffamily\" type=\"RadioButtonList\" label=\"Type of Family\" required=\"true\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBtypeoffamily</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Nuclear\" id=\"RBtypeoffamily1\" Selected=\"False\">Nuclear</LISTITEM>\r\n                        <LISTITEM value=\"Joint\" id=\"RBtypeoffamily2\" Selected=\"False\">Joint</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBtypeofmarriage\" type=\"RadioButtonList\" label=\"Type of Marriage\" required=\"true\" Backcontrols=\"true\" Backdivid=\"RBtypeofmarriageDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBtypeofmarriage</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Consanguineous\" id=\"RBtypeofmarriage1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'RBtypeofmarriageDiv\',\'block\');\">Consanguineous</LISTITEM>\r\n                        <LISTITEM value=\"Non-Consanguineous\" id=\"RBtypeofmarriage2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'RBtypeofmarriageDiv\',\'none\');\">Non-Consanguineous</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"RBdegreeofconsan\" type=\"RadioButtonList\" label=\"Degree of Consanguinity\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"name\">RBdegreeofconsan</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"II\" id=\"RBdegreeofconsan1\" Selected=\"False\">II</LISTITEM>\r\n                            <LISTITEM value=\"III\" id=\"RBdegreeofconsan2\" Selected=\"False\">III</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"RadGrid\" ADDButton=\"True\" ADDButtonID=\"RGfamilyadd\" AddButtonTableId=\"RGfamily\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">RGfamily</PROPERTY>\r\n                        <PROPERTY name=\"class\">table table-bordered</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <HEADER>\r\n                        <TH>Relation</TH>\r\n                        <TH>Illness type</TH>\r\n                        <TH>Treatment</TH>\r\n                    </HEADER>\r\n                    <COLUMNS>\r\n                        <FIELD id=\"ddl_pb_relation\" type=\"DropDownList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">ddl_pb_relation</PROPERTY>\r\n                                <PROPERTY name=\"name\">ddl_pb_relation</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"--Select--\" Selected=\"False\">--Select--</LISTITEM>\r\n                                <LISTITEM value=\"GrandParents\" Selected=\"False\">GrandParents</LISTITEM>\r\n                                <LISTITEM value=\"Parents\" Selected=\"False\">Parents</LISTITEM>\r\n                                <LISTITEM value=\"Siblings\" Selected=\"False\">Siblings</LISTITEM>\r\n                                <LISTITEM value=\"Spouse\" Selected=\"False\">Spouse</LISTITEM>\r\n                                <LISTITEM value=\"Children\" Selected=\"False\">Children</LISTITEM>\r\n                                <LISTITEM value=\"Uncle/Aunt\" Selected=\"False\">Uncle/Aunt</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                        <FIELD id=\"radio_pb_illnesstype\" type=\"RadioButtonList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"name\">radio_pb_illnesstype</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"Similar Illness\" id=\"radio_pb_illnesstype1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'radio_pb_illnesstype_note\',\'none\');\">Similar Illness</LISTITEM>\r\n                                <LISTITEM value=\"Other Illness\" id=\"radio_pb_illnesstype2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'radio_pb_illnesstype_note\',\'block\');\">Other Illness</LISTITEM>\r\n                            </LISTITEMS>\r\n                            <FIELD id=\"radio_pb_illnesstype_note\" type=\"TextBox\">\r\n                                <PROPERTIES>\r\n                                    <PROPERTY name=\"id\">radio_pb_illnesstype_note</PROPERTY>\r\n                                    <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                                    <PROPERTY name=\"name\">radio_pb_illnesstype_note</PROPERTY>\r\n                                    <PROPERTY name=\"placeholder\">Notes</PROPERTY>\r\n                                </PROPERTIES>\r\n                            </FIELD>\r\n                        </FIELD>\r\n                        <FIELD id=\"radio_pb_treatment\" type=\"RadioButtonList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"name\">radio_pb_treatment</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"Treated\" id=\"radio_pb_treatment1\" Selected=\"False\">Treated</LISTITEM>\r\n                                <LISTITEM value=\"Untreated\" id=\"radio_pb_treatment2\" Selected=\"False\">Untreated</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                    </COLUMNS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBexpressedemotion\" type=\"RadioButtonList\" label=\"Expressed emotions\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBexpressedemotion</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Consanguineous\" id=\"RBexpressedemotion1\" Selected=\"False\">Hostility</LISTITEM>\r\n                        <LISTITEM value=\"Criticality\" id=\"RBexpressedemotion2\" Selected=\"False\">Criticality</LISTITEM>\r\n                        <LISTITEM value=\"Over involvement\" id=\"RBexpressedemotion3\" Selected=\"False\">Over involvement</LISTITEM>\r\n                        <LISTITEM value=\"Warmth\" id=\"RBexpressedemotion4\" Selected=\"False\">Warmth</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"history_family\" type=\"textareaFull\" label=\"Notes\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">history_family</PROPERTY>\r\n                        <PROPERTY name=\"name\">history_family</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"rows\">6</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD type=\"PanelBar\" label=\"Personal History\" target_div=\"personal_history\">\r\n                <FIELD type=\"Header2\" label=\"Birth and Development\"></FIELD>\r\n                \r\n                <FIELD id=\"RBpbprenatal\" type=\"RadioButtonList\" label=\"Prenatal\" required=\"true\" Backcontrols=\"true\" Backdivid=\"PrenatalDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbprenatal</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Uneventful\" id=\"RBpbprenatal1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'PrenatalDiv\',\'none\');\">Uneventful</LISTITEM>\r\n                        <LISTITEM value=\"Eventful\" id=\"RBpbprenatal2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'PrenatalDiv\',\'block\');\">Eventful</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"prenatalSpecify\" type=\"TextBox\" label=\"Specify\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"name\">prenatalSpecify</PROPERTY>\r\n                            <PROPERTY name=\"id\">prenatalSpecify</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control</PROPERTY> \r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBpbperinatal\" type=\"RadioButtonList\" label=\"Perinatal\" required=\"true\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbperinatal</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Full Term\" id=\"RBpbperinatal1\" Selected=\"False\">Full Term</LISTITEM>\r\n                        <LISTITEM value=\"Premature\" id=\"RBpbperinatal2\" Selected=\"False\">Premature</LISTITEM>\r\n                        <LISTITEM value=\"Post mature\" id=\"RBpbperinatal3\" Selected=\"False\">Post mature</LISTITEM>\r\n                        <LISTITEM value=\"Delayed\" id=\"RBpbperinatal4\" Selected=\"False\">Delayed</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBpbperinatal2\" type=\"RadioButtonList\" label=\"Perinatal2\" required=\"true\" Backcontrols=\"true\" Backdivid=\"perinatal2div\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbperinatal2</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Uneventful\" id=\"RBpbperinatal21\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'perinatal2div\',\'none\');\">Uneventful</LISTITEM>\r\n                        <LISTITEM value=\"Eventful\" id=\"RBpbperinatal22\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'perinatal2div\',\'block\');\">Eventful</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"txtPerinatal2\" type=\"TextBox\" label=\"Specify\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"name\">txtPerinatal2</PROPERTY>\r\n                            <PROPERTY name=\"id\">txtPerinatal2</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBpbmajorillness\" type=\"RadioButtonList\" label=\"Major illness during infancy\" Backcontrols=\"true\" Backdivid=\"RBpbmajorillnessDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbmajorillness</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"No\" id=\"RBpbmajorillness1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'RBpbmajorillnessDiv\',\'none\');\">No</LISTITEM>\r\n                        <LISTITEM value=\"Yes\" id=\"RBpbmajorillness2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'RBpbmajorillnessDiv\',\'block\');\">Yes</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"txtRBpbmajorillness\" type=\"TextBox\" label=\"Specify\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txtRBpbmajorillness</PROPERTY>\r\n                            <PROPERTY name=\"name\">txtRBpbmajorillness</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBpbimmunizationschedule\" type=\"RadioButtonList\" label=\"Immunization schedule\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbimmunizationschedule</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Completed\" id=\"RBpbimmunizationschedule1\" Selected=\"False\">Completed</LISTITEM>\r\n                        <LISTITEM value=\"Not Completed\" id=\"RBpbimmunizationschedule2\" Selected=\"False\">Not Completed</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBpbdevelopmentmilestone\" type=\"RadioButtonList\" label=\"Developmental milestones\" required=\"true\" Backcontrols=\"true\" Backdivid=\"developmentmilestoneDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbdevelopmentmilestone</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Normal\" id=\"RBpbdevelopmentmilestone1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'developmentmilestoneDiv\',\'none\');\">Normal</LISTITEM>\r\n                        <LISTITEM value=\"Delayed\" id=\"RBpbdevelopmentmilestone2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'developmentmilestoneDiv\',\'block\');\">Delayed</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"RBdevlopmentmilestonesub\" type=\"RadioButtonList\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"name\">RBdevlopmentmilestonesub</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"Motor\" id=\"RBdevlopmentmilestonesub1\" Selected=\"False\">Motor</LISTITEM>\r\n                            <LISTITEM value=\"Adaptive\" id=\"RBdevlopmentmilestonesub2\" Selected=\"False\">Adaptive</LISTITEM>\r\n                            <LISTITEM value=\"Speech\" id=\"RBdevlopmentmilestonesub3\" Selected=\"False\">Speech</LISTITEM>\r\n                            <LISTITEM value=\"Social\" id=\"RBdevlopmentmilestonesub4\" Selected=\"False\">Social</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBpbmajorillnessduringchild\" type=\"RadioButtonList\" label=\"Major physical illness during childhood\" Backcontrols=\"true\" Backdivid=\"pbmajorillnessduringchildDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbmajorillnessduringchild</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"No\" id=\"RBpbmajorillnessduringchild1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'pbmajorillnessduringchildDiv\',\'none\');\">No</LISTITEM>\r\n                        <LISTITEM value=\"Yes\" id=\"RBpbmajorillnessduringchild2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'pbmajorillnessduringchildDiv\',\'block\');\">Yes</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"txtpbmajorillnesschild\" type=\"TextBox\" label=\"Specify\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txtpbmajorillnesschild</PROPERTY>\r\n                            <PROPERTY name=\"name\">txtpbmajorillnesschild</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"CBpbemotionalbehaviour\" type=\"CheckBoxList\" label=\"Emotional and behavioural problems during childhood\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">CBpbemotionalbehaviour</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Self\" id=\"CBpbemotionalbehaviour1\" Selected=\"False\">Sleep Walking</LISTITEM>\r\n                        <LISTITEM value=\"General Practitioner\" id=\"CBpbemotionalbehaviour2\" Selected=\"False\">Temper Tantrums</LISTITEM>\r\n                        <LISTITEM value=\"Neighbours\" id=\"CBpbemotionalbehaviour3\" Selected=\"False\">Stammering</LISTITEM>\r\n                        <LISTITEM value=\"Traditional healer\" id=\"CBpbemotionalbehaviour4\" Selected=\"False\">Nail biting</LISTITEM>\r\n                        <LISTITEM value=\"Other patient\" id=\"CBpbemotionalbehaviour5\" Selected=\"False\">Enuresis</LISTITEM>\r\n                        <LISTITEM value=\"Other psychiatrist\" id=\"CBpbemotionalbehaviour6\" Selected=\"False\">Encopresis</LISTITEM>\r\n                        <LISTITEM value=\"Media\" id=\"CBpbemotionalbehaviour7\" Selected=\"False\">Thumb sucking</LISTITEM>\r\n                        <LISTITEM value=\"Traditional healer\" id=\"CBpbemotionalbehaviour8\" Selected=\"False\">Head banging</LISTITEM>\r\n                        <LISTITEM value=\"Other patient\" id=\"CBpbemotionalbehaviour9\" Selected=\"False\">Nightmares</LISTITEM>\r\n                        <LISTITEM value=\"Other psychiatrist\" id=\"CBpbemotionalbehaviour10\" Selected=\"False\">Seperation anxiety</LISTITEM>\r\n                        <LISTITEM value=\"Media\" id=\"CBpbemotionalbehaviour11\" Selected=\"False\">Conduct problems</LISTITEM>\r\n                        <LISTITEM value=\"Others\" id=\"CBpbemotionalbehaviour12\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'Txtpbemotionalbehaviou\');\">Others</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"Txtpbemotionalbehaviou\" type=\"TextBox\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">Txtpbemotionalbehaviou</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                            <PROPERTY name=\"name\">Txtpbemotionalbehaviou</PROPERTY>\r\n                            <PROPERTY name=\"placeholder\">Other</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBpbhomeatmosphere\" type=\"RadioButtonList\" label=\"Home atmosphere during childhood\" Backcontrols=\"true\" Backdivid=\"pbhomeatmosphereDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbhomeatmosphere</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"No\" id=\"RBpbhomeatmosphere1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'pbhomeatmosphereDiv\',\'none\');\">Satisfactory</LISTITEM>\r\n                        <LISTITEM value=\"Yes\" id=\"RBpbhomeatmosphere2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'pbhomeatmosphereDiv\',\'block\');\">Unsatisfactory</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"txtpbhomeatmosphereSpcify\" type=\"TextBox\" label=\"Specify\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txtpbhomeatmosphereSpcify</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                            <PROPERTY name=\"name\">txtpbhomeatmosphereSpcify</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"CBpbemotionalbehaviouradole\" type=\"CheckBoxList\" label=\"Emotional and behavioural problems during adolescence\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">CBpbemotionalbehaviouradole</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Mood disturbances\" id=\"CBpbemotionalbehaviouradole1\" Selected=\"False\">Mood disturbances</LISTITEM>\r\n                        <LISTITEM value=\"Substance use\" id=\"CBpbemotionalbehaviouradole2\" Selected=\"False\">Substance use</LISTITEM>\r\n                        <LISTITEM value=\"Argumentative\" id=\"CBpbemotionalbehaviouradole3\" Selected=\"False\">Argumentative</LISTITEM>\r\n                        <LISTITEM value=\"Inferiority\" id=\"CBpbemotionalbehaviouradole4\" Selected=\"False\">Inferiority</LISTITEM>\r\n                        <LISTITEM value=\"Conduct problems\" id=\"CBpbemotionalbehaviouradole5\" Selected=\"False\">Conduct problems</LISTITEM>\r\n                        <LISTITEM value=\"Others\" id=\"CBpbemotionalbehaviouradole6\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'Txtpbemotionalbehaviouradole\');\">Others</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"Txtpbemotionalbehaviouradole\" type=\"TextBox\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">Txtpbemotionalbehaviouradole</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                            <PROPERTY name=\"name\">Txtpbemotionalbehaviouradole</PROPERTY>\r\n                            <PROPERTY name=\"placeholder\">Other</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBpbhomeatmosphereadole\" type=\"RadioButtonList\" label=\"Home atmosphere during adolescent\" Backcontrols=\"true\" Backdivid=\"pbhomeatmosphereadoleDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbhomeatmosphereadole</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"No\" id=\"RBpbhomeatmosphereadole1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'pbhomeatmosphereadoleDiv\',\'none\');\">Satisfactory</LISTITEM>\r\n                        <LISTITEM value=\"Yes\" id=\"RBpbhomeatmosphereadole2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'pbhomeatmosphereadoleDiv\',\'block\');\">Unsatisfactory</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"txthomeatmosphereadoleSpecify\" type=\"TextBox\" label=\"Specify\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txthomeatmosphereadoleSpecify</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                            <PROPERTY name=\"name\">txthomeatmosphereadoleSpecify</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBpbparentallack\" type=\"RadioButtonList\" label=\"Parental Lack\" required=\"true\" Backcontrols=\"true\" Backdivid=\"parentallackDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbparentallack</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Mother\" id=\"RBpbparentallack1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'parentallackDiv\',\'block\');\">Mother</LISTITEM>\r\n                        <LISTITEM value=\"Father\" id=\"RBpbparentallack2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'parentallackDiv\',\'block\');\">Father</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"RBparentallackreason\" type=\"RadioButtonList\" label=\"Reason\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"name\">RBparentallackreason</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"Dead\" id=\"RBparentallackreason1\" Selected=\"False\">Dead</LISTITEM>\r\n                            <LISTITEM value=\"Seperate\" id=\"RBparentallackreason2\" Selected=\"False\">Separated</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"birthdevelopmentnotes\" type=\"textareaFull\" label=\"Notes\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">birthdevelopmentnotes</PROPERTY>\r\n                        <PROPERTY name=\"name\">birthdevelopmentnotes</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"rows\">6</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"Header2\" label=\"Education History\"></FIELD>\r\n                \r\n                <FIELD id=\"RBpbbreakstudy\" type=\"RadioButtonList\" label=\"Break in Studies\" required=\"true\" Backcontrols=\"true\" Backdivid=\"breakstudyDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbbreakstudy</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"No\" id=\"RBpbbreakstudy1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'breakstudyDiv\',\'none\');\">No</LISTITEM>\r\n                        <LISTITEM value=\"Yes\" id=\"RBpbbreakstudy2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'breakstudyDiv\',\'block\');\">Yes</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"txtbreakstudyreason\" type=\"TextBox\" label=\"Reason\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txtbreakstudyreason</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                            <PROPERTY name=\"name\">txtbreakstudyreason</PROPERTY>\r\n                            <PROPERTY name=\"placeholder\">Reason</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBpbfrechangeschool\" type=\"RadioButtonList\" label=\"Frequent change of school\" required=\"true\" Backcontrols=\"true\" Backdivid=\"frechangeschoolDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbfrechangeschool</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"No\" id=\"RBpbfrechangeschool1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'frechangeschoolDiv\',\'none\');\">No</LISTITEM>\r\n                        <LISTITEM value=\"Yes\" id=\"RBpbfrechangeschool2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'frechangeschoolDiv\',\'block\');\">Yes</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"txtfrechangeschool\" type=\"TextBox\" label=\"Reason\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txtfrechangeschool</PROPERTY>\r\n                            <PROPERTY name=\"name\">txtfrechangeschool</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                            <PROPERTY name=\"placeholder\">Reason</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBpbtypeofschool\" type=\"RadioButtonList\" label=\"Type of school/college\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbtypeofschool</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Urban\" id=\"RBpbtypeofschool1\" Selected=\"False\">Urban</LISTITEM>\r\n                        <LISTITEM value=\"Rural\" id=\"RBpbtypeofschool2\" Selected=\"False\">Rural</LISTITEM>\r\n                        <LISTITEM value=\"Residental\" id=\"RBpbtypeofschool3\" Selected=\"False\">Residential</LISTITEM>\r\n                        <LISTITEM value=\"Day scholar\" id=\"RBpbtypeofschool4\" Selected=\"False\">Day scholar</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBpbmedium\" type=\"RadioButtonList\" label=\"Medium\" Backcontrols=\"true\" Backdivid=\"mediumDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbmedium</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Tamil\" id=\"RBpbmedium1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'mediumDiv\',\'none\');\">Tamil</LISTITEM>\r\n                        <LISTITEM value=\"English\" id=\"RBpbmedium2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'mediumDiv\',\'none\');\">English</LISTITEM>\r\n                        <LISTITEM value=\"Others\" id=\"RBpbmedium3\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'mediumDiv\',\'block\');\">Others</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"txtMedium\" type=\"TextBox\" label=\"Specify\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txtMedium</PROPERTY>\r\n                            <PROPERTY name=\"name\">txtMedium</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBpbacademicperfor\" type=\"RadioButtonList\" label=\"Academic performance\" required=\"true\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbacademicperfor</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Good\" id=\"RBpbacademicperfor1\" Selected=\"False\">Good</LISTITEM>\r\n                        <LISTITEM value=\"Average\" id=\"RBpbacademicperfor2\" Selected=\"False\">Average</LISTITEM>\r\n                        <LISTITEM value=\"Below average\" id=\"RBpbacademicperfor3\" Selected=\"False\">Below average</LISTITEM>\r\n                        <LISTITEM value=\"Poor\" id=\"RBpbacademicperfor4\" Selected=\"False\">Poor</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBpbteacherrelation\" type=\"RadioButtonList\" label=\"Relationship with teachers\" required=\"true\" Backcontrols=\"true\" Backdivid=\"teacherrelationDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbteacherrelation</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"No\" id=\"RBpbteacherrelation1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'teacherrelationDiv\',\'none\');\">Satisfactory</LISTITEM>\r\n                        <LISTITEM value=\"Yes\" id=\"RBpbteacherrelation2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'teacherrelationDiv\',\'block\');\">Unsatisfactory</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"txtteacherrelationspecify\" type=\"TextBox\" label=\"Specify\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txtteacherrelationspecify</PROPERTY>\r\n                            <PROPERTY name=\"name\">txtteacherrelationspecify</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBpbstudentrelation\" type=\"RadioButtonList\" label=\"Relationship with students\" required=\"true\" Backcontrols=\"true\" Backdivid=\"studentrelationDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbstudentrelation</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"No\" id=\"RBpbstudentrelation1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'studentrelationDiv\',\'none\');\">Satisfactory</LISTITEM>\r\n                        <LISTITEM value=\"Yes\" id=\"RBpbstudentrelation2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'studentrelationDiv\',\'block\');\">Unsatisfactory</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"txtstudentrelationspecify\" type=\"TextBox\" label=\"Specify\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txtstudentrelationspecify</PROPERTY>\r\n                            <PROPERTY name=\"name\">txtstudentrelationspecify</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"educational_history_notes\" type=\"textareaFull\" label=\"Notes\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">educational_history_notes</PROPERTY>\r\n                        <PROPERTY name=\"name\">educational_history_notes</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"rows\">6</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"Header2\" label=\"Occupational History \"></FIELD>\r\n                \r\n                <FIELD id=\"DDLstartedworking\" type=\"DropDownList\" label=\"Started working at\" Backtext=\" Years\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">DDLstartedworking</PROPERTY>\r\n                        <PROPERTY name=\"name\">DDLstartedworking</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"--Select--\" Selected=\"False\">--Select--</LISTITEM>\r\n                        <LISTITEM value=\"10\" Selected=\"False\">10</LISTITEM>\r\n                        <LISTITEM value=\"11\" Selected=\"False\">11</LISTITEM>\r\n                        <LISTITEM value=\"12\" Selected=\"False\">12</LISTITEM>\r\n                        <LISTITEM value=\"13\" Selected=\"False\">13</LISTITEM>\r\n                        <LISTITEM value=\"14\" Selected=\"False\">14</LISTITEM>\r\n                        <LISTITEM value=\"15\" Selected=\"False\">15</LISTITEM>\r\n                        <LISTITEM value=\"16\" Selected=\"False\">16</LISTITEM>\r\n                        <LISTITEM value=\"17\" Selected=\"False\">17</LISTITEM>\r\n                        <LISTITEM value=\"18\" Selected=\"False\">18</LISTITEM>\r\n                        <LISTITEM value=\"19\" Selected=\"False\">19</LISTITEM>\r\n                        <LISTITEM value=\"20\" Selected=\"False\">20</LISTITEM>\r\n                        <LISTITEM value=\"21\" Selected=\"False\">21</LISTITEM>\r\n                        <LISTITEM value=\"22\" Selected=\"False\">22</LISTITEM>\r\n                        <LISTITEM value=\"23\" Selected=\"False\">23</LISTITEM>\r\n                        <LISTITEM value=\"24\" Selected=\"False\">24</LISTITEM>\r\n                        <LISTITEM value=\"25\" Selected=\"False\">25</LISTITEM>\r\n                        <LISTITEM value=\"26\" Selected=\"False\">26</LISTITEM>\r\n                        <LISTITEM value=\"27\" Selected=\"False\">27</LISTITEM>\r\n                        <LISTITEM value=\"28\" Selected=\"False\">28</LISTITEM>\r\n                        <LISTITEM value=\"29\" Selected=\"False\">29</LISTITEM>\r\n                        <LISTITEM value=\"30\" Selected=\"False\">30</LISTITEM>\r\n                        <LISTITEM value=\"31\" Selected=\"False\">31</LISTITEM>\r\n                        <LISTITEM value=\"32\" Selected=\"False\">32</LISTITEM>\r\n                        <LISTITEM value=\"33\" Selected=\"False\">33</LISTITEM>\r\n                        <LISTITEM value=\"34\" Selected=\"False\">34</LISTITEM>\r\n                        <LISTITEM value=\"35\" Selected=\"False\">35</LISTITEM>\r\n                        <LISTITEM value=\"36\" Selected=\"False\">36</LISTITEM>\r\n                        <LISTITEM value=\"37\" Selected=\"False\">37</LISTITEM>\r\n                        <LISTITEM value=\"38\" Selected=\"False\">38</LISTITEM>\r\n                        <LISTITEM value=\"39\" Selected=\"False\">39</LISTITEM>\r\n                        <LISTITEM value=\"40\" Selected=\"False\">40</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBpbworkrecord\" type=\"RadioButtonList\" label=\"Work Record\" required=\"true\" Backcontrols=\"true\" Backdivid=\"workrecordDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBpbworkrecord</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Satisfactory\" id=\"RBpbworkrecord1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'workrecordDiv\',\'none\');\">Satisfactory</LISTITEM>\r\n                        <LISTITEM value=\"Unsatisfactory\" id=\"RBpbworkrecord2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'workrecordDiv\',\'block\');\">Unsatisfactory</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"txtworkrecordspecify\" type=\"TextBox\" label=\"Specify\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txtworkrecordspecify</PROPERTY>\r\n                            <PROPERTY name=\"name\">txtworkrecordspecify</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBfreqchangeofjob\" type=\"RadioButtonList\" label=\"Frequent change of jobs\" required=\"true\" Backcontrols=\"true\" Backdivid=\"freqchangeofjobDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBfreqchangeofjob</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"No\" id=\"RBfreqchangeofjob1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'freqchangeofjobDiv\',\'none\');\">No</LISTITEM>\r\n                        <LISTITEM value=\"Yes\" id=\"RBfreqchangeofjob2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'freqchangeofjobDiv\',\'block\');\">Yes</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"CBreasonforchange\" type=\"CheckBoxList\" label=\"Reason for change\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"name\">CBreasonforchange</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"Better\" id=\"CBreasonforchange1\" Selected=\"False\">Better</LISTITEM>\r\n                            <LISTITEM value=\"Opportunity\" id=\"CBreasonforchange2\" Selected=\"False\">Opportunity</LISTITEM>\r\n                            <LISTITEM value=\"Better Income\" id=\"CBreasonforchange3\" Selected=\"False\">Better Income</LISTITEM>\r\n                            <LISTITEM value=\"Termination\" id=\"CBreasonforchange4\" Selected=\"False\">Termination</LISTITEM>\r\n                            <LISTITEM value=\"Illness\" id=\"CBreasonforchange5\" Selected=\"False\">Illness</LISTITEM>\r\n                            <LISTITEM value=\"Others\" id=\"CBreasonforchange6\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'txtreasonforchangeother\');\">Others</LISTITEM>\r\n                        </LISTITEMS>\r\n                        <FIELD id=\"txtreasonforchangeother\" type=\"TextBox\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">txtreasonforchangeother</PROPERTY>\r\n                                <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                                <PROPERTY name=\"name\">txtreasonforchangeother</PROPERTY>\r\n                                <PROPERTY name=\"placeholder\">Others</PROPERTY>\r\n                            </PROPERTIES>\r\n                        </FIELD>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"occupational_history_notes\" type=\"textareaFull\" label=\"Notes\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">occupational_history_notes</PROPERTY>\r\n                        <PROPERTY name=\"name\">occupational_history_notes</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"rows\">6</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"Header2\" label=\"Menstrual History\"></FIELD>\r\n                \r\n                <FIELD id=\"txtMenarche\" type=\"TextBox\" label=\"Menarche\" Backtext=\"Years\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">txtMenarche</PROPERTY>\r\n                        <PROPERTY name=\"name\">txtMenarche</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBRegularity\" type=\"RadioButtonList\" label=\"Regularity\" required=\"true\" Backcontrols=\"true\" Backdivid=\"RegularityDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBRegularity</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Regular\" id=\"RBRegularity1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'RegularityDiv\',\'none\');\">Regular</LISTITEM>\r\n                        <LISTITEM value=\"Irregular\" id=\"RBRegularity2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'RegularityDiv\',\'block\');\">Irregular</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"RBRegularity1\" type=\"RadioButtonList\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"name\">RBRegularity1</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"Premenstrual Dysphoria\" id=\"RBRegularity1\" Selected=\"False\">Premenstrual Dysphoria</LISTITEM>\r\n                            <LISTITEM value=\"Post menopausal Dysphoria\" id=\"RBRegularity12\" Selected=\"False\">Post menopausal Dysphoria</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"txtLMP\" type=\"TextBox\" label=\"LMP\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">txtLMP</PROPERTY>\r\n                        <PROPERTY name=\"name\">txtLMP</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"txtMenopause\" type=\"TextBox\" label=\"Menopause\" Backtext=\"Years\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">txtMenopause</PROPERTY>\r\n                        <PROPERTY name=\"name\">txtMenopause</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"Header2\" label=\"Marital History\"></FIELD>\r\n                \r\n                <FIELD id=\"txtDurationofMarriage\" type=\"TextBox\" label=\"Duration of Marriage\" required=\"true\" Backcontrol=\"true\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">txtDurationofMarriage</PROPERTY>\r\n                        <PROPERTY name=\"name\">txtDurationofMarriage</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <FIELD id=\"DDLDurationofMarriage\" type=\"DropDownList\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">DDLDurationofMarriage</PROPERTY>\r\n                            <PROPERTY name=\"name\">DDLDurationofMarriage</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"Yrs\" Selected=\"True\">Yrs</LISTITEM>\r\n                            <LISTITEM value=\"Months\" Selected=\"False\">Months</LISTITEM>\r\n                            <LISTITEM value=\"Weeks\" Selected=\"False\">Weeks</LISTITEM>\r\n                            <LISTITEM value=\"Days\" Selected=\"False\">Days</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"txtAgeofMarriage\" type=\"TextBox\" label=\"Age of Marriage\" required=\"true\" Backcontrol=\"true\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">txtAgeofMarriage</PROPERTY>\r\n                        <PROPERTY name=\"name\">txtAgeofMarriage</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <FIELD id=\"DDLAgeofMarriage\" type=\"DropDownList\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">DDLAgeofMarriage</PROPERTY>\r\n                            <PROPERTY name=\"name\">DDLAgeofMarriage</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"Yrs\" Selected=\"True\">Yrs</LISTITEM>\r\n                            <LISTITEM value=\"Months\" Selected=\"False\">Months</LISTITEM>\r\n                            <LISTITEM value=\"Weeks\" Selected=\"False\">Weeks</LISTITEM>\r\n                            <LISTITEM value=\"Days\" Selected=\"False\">Days</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBtype\" type=\"RadioButtonList\" label=\"Type\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBtype</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Arrange\" id=\"RBtype1\" Selected=\"False\">Arranged</LISTITEM>\r\n                        <LISTITEM value=\"By choice\" id=\"RBtype2\" Selected=\"False\">By choice</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBmaritalsexualsatisfac\" type=\"RadioButtonList\" label=\"Marital and Sexual satisfaction\" required=\"true\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBmaritalsexualsatisfac</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Statisfactory\" id=\"RBmaritalsexualsatisfac1\" Selected=\"False\">Statisfactory</LISTITEM>\r\n                        <LISTITEM value=\"Unsatisfactory\" id=\"RBmaritalsexualsatisfac2\" Selected=\"False\">Unsatisfactory</LISTITEM>\r\n                        <LISTITEM value=\"Neutral\" id=\"RBmaritalsexualsatisfac3\" Selected=\"False\">Neutral</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBhistoryof\" type=\"RadioButtonList\" label=\"History of\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBhistoryof</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Seperation\" id=\"RBhistoryof1\" Selected=\"False\">Separation</LISTITEM>\r\n                        <LISTITEM value=\"Divorce\" id=\"RBhistoryof2\" Selected=\"False\">Divorce</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBknowledgeofspouse\" type=\"RadioButtonList\" label=\"Knowledge of spouse about patient\'s illness prior to marriage\" required=\"true\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBknowledgeofspouse</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Yes\" id=\"RBknowledgeofspouse1\" Selected=\"False\">Yes</LISTITEM>\r\n                        <LISTITEM value=\"No\" id=\"RBknowledgeofspouse2\" Selected=\"False\">No</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"martial_history\" type=\"textareaFull\" label=\"Notes\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">martial_history</PROPERTY>\r\n                        <PROPERTY name=\"name\">martial_history</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"rows\">6</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"Header2\" label=\"Sexual History\"></FIELD>\r\n                \r\n                <FIELD id=\"RBorientation\" type=\"RadioButtonList\" label=\"Orientation\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBorientation</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Same Sex\" id=\"RBorientation1\" Selected=\"False\">Same Sex</LISTITEM>\r\n                        <LISTITEM value=\"Opposite Sex\" id=\"RBorientation2\" Selected=\"False\">Opposite Sex</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"CBsexualfunctioning\" type=\"CheckBoxList\" label=\"Sexual Functioning\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">CBsexualfunctioning</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Premarital relationships\" id=\"CBsexualfunctioning1\" Selected=\"False\">Premarital relationships</LISTITEM>\r\n                        <LISTITEM value=\"Extra marital relationships\" id=\"CBsexualfunctioning2\" Selected=\"False\">Extra marital relationships</LISTITEM>\r\n                        <LISTITEM value=\"Hyper sexulaity\" id=\"CBsexualfunctioning3\" Selected=\"False\">Hyper sexuality</LISTITEM>\r\n                        <LISTITEM value=\"Hypo sexuality\" id=\"CBsexualfunctioning4\" Selected=\"False\">Hypo sexuality</LISTITEM>\r\n                        <LISTITEM value=\"Sexual Aversion\" id=\"CBsexualfunctioning5\" Selected=\"False\">Sexual Aversion</LISTITEM>\r\n                        <LISTITEM value=\"Loss of libido\" id=\"CBsexualfunctioning6\" Selected=\"False\">Loss of libido</LISTITEM>\r\n                        <LISTITEM value=\"Erectile dysfunction\" id=\"CBsexualfunctioning7\" Selected=\"False\">Erectile dysfunction</LISTITEM>\r\n                        <LISTITEM value=\"Masturbation guilt\" id=\"CBsexualfunctioning8\" Selected=\"False\">Masturbation guilt</LISTITEM>\r\n                        <LISTITEM value=\"Premature ejaculation\" id=\"CBsexualfunctioning9\" Selected=\"False\">Premature ejaculation</LISTITEM>\r\n                        <LISTITEM value=\"Dyspareunia\" id=\"CBsexualfunctioning10\" Selected=\"False\">Dyspareunia</LISTITEM>\r\n                        <LISTITEM value=\"Vaginismus\" id=\"CBsexualfunctioning11\" Selected=\"False\">Vaginismus</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"CBparaphilias\" type=\"CheckBoxList\" label=\"Paraphilias\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">CBparaphilias</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Exhibitionism\" id=\"CBparaphilias1\" Selected=\"False\">Exhibitionism</LISTITEM>\r\n                        <LISTITEM value=\"Fetishism\" id=\"CBparaphilias2\" Selected=\"False\">Fetishism</LISTITEM>\r\n                        <LISTITEM value=\"Frotteruism\" id=\"CBparaphilias3\" Selected=\"False\">Frotteruism</LISTITEM>\r\n                        <LISTITEM value=\"Pedophillia\" id=\"CBparaphilias4\" Selected=\"False\">Pedophillia</LISTITEM>\r\n                        <LISTITEM value=\"Sexual Sadism\" id=\"CBparaphilias5\" Selected=\"False\">Sexual Sadism</LISTITEM>\r\n                        <LISTITEM value=\"Sexual Machoism\" id=\"CBparaphilias6\" Selected=\"False\">Sexual Machoism</LISTITEM>\r\n                        <LISTITEM value=\"Voyerism\" id=\"CBparaphilias7\" Selected=\"False\">Voyerism</LISTITEM>\r\n                        <LISTITEM value=\"Transvestism\" id=\"CBparaphilias8\" Selected=\"False\">Transvestism</LISTITEM>\r\n                        <LISTITEM value=\"GID\" id=\"CBparaphilias9\" Selected=\"False\">GID</LISTITEM>\r\n                        <LISTITEM value=\"Bestiality\" id=\"CBparaphilias10\" Selected=\"False\">Bestiality</LISTITEM>\r\n                        <LISTITEM value=\"Masochism\" id=\"CBparaphilias11\" Selected=\"False\">Masochism</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"sexual_history_notes\" type=\"textareaFull\" label=\"Notes\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">sexual_history_notes</PROPERTY>\r\n                        <PROPERTY name=\"name\">sexual_history_notes</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"rows\">6</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"Header2\" label=\"Substance History\"></FIELD>\r\n                \r\n                <FIELD type=\"RadGrid\" ADDButton=\"True\" ADDButtonID=\"RGSubsadd\" AddButtonTableId=\"RGSubs\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">RGSubs</PROPERTY>\r\n                        <PROPERTY name=\"class\">table table-bordered</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <HEADER>\r\n                        <TH>Substance</TH>\r\n                        <TH>Duration</TH>\r\n                        <TH>Pattern</TH>\r\n                    </HEADER>\r\n                    <COLUMNS>\r\n                        <FIELD id=\"ddl_pb_substance\" type=\"DropDownList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">ddl_pb_substance</PROPERTY>\r\n                                <PROPERTY name=\"name\">ddl_pb_substance</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"--Select--\" Selected=\"False\">--Select--</LISTITEM>\r\n                                <LISTITEM value=\"Smoking\" Selected=\"False\">Smoking</LISTITEM>\r\n                                <LISTITEM value=\"Alcohol\" Selected=\"False\">Alcohol</LISTITEM>\r\n                                <LISTITEM value=\"Cannabis\" Selected=\"False\">Cannabis</LISTITEM>\r\n                                <LISTITEM value=\"Solvents/Inhalants\" Selected=\"False\">Solvents/Inhalants</LISTITEM>\r\n                                <LISTITEM value=\"Others\" Selected=\"False\">Others</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                        \r\n                        <FIELD id=\"txtPBDuration\" type=\"TextBox\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">txtPBDuration</PROPERTY>\r\n                                <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                                <PROPERTY name=\"name\">txtPBDuration</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <FIELD id=\"DDLPBDuration\" type=\"DropDownList\">\r\n                                <PROPERTIES>\r\n                                    <PROPERTY name=\"id\">DDLPBDuration</PROPERTY>\r\n                                    <PROPERTY name=\"name\">DDLPBDuration</PROPERTY>\r\n                                </PROPERTIES>\r\n                                <LISTITEMS>\r\n                                    <LISTITEM value=\"Yrs\" Selected=\"False\">Yrs</LISTITEM>\r\n                                    <LISTITEM value=\"Months\" Selected=\"False\">Months</LISTITEM>\r\n                                    <LISTITEM value=\"Weeks\" Selected=\"False\">Weeks</LISTITEM>\r\n                                    <LISTITEM value=\"Days\" Selected=\"False\">Days</LISTITEM>\r\n                                </LISTITEMS>\r\n                            </FIELD>\r\n                        </FIELD>\r\n                        \r\n                        <FIELD id=\"CBPBpattern\" type=\"CheckBoxList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"name\">CBPBpattern[]</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"Use\" id=\"CBPBpattern1\" Selected=\"False\">Use</LISTITEM>\r\n                                <LISTITEM value=\"Abuse\" id=\"CBPBpattern2\" Selected=\"False\">Abuse</LISTITEM>\r\n                                <LISTITEM value=\"Dependence\" id=\"CBPBpattern3\" Selected=\"False\">Dependence</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                    </COLUMNS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"substance_history_notes\" type=\"textareaFull\" label=\"Notes\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">substance_history_notes</PROPERTY>\r\n                        <PROPERTY name=\"name\">substance_history_notes</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"rows\">6</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"Header2\" label=\"Premorbid Personality\"></FIELD>\r\n                \r\n                <FIELD id=\"CBattitudetoself\" type=\"CheckBoxList\" label=\"Attitude to self\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">CBattitudetoself</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Ego centric\" id=\"CBattitudetoself1\" Selected=\"False\">Ego centric</LISTITEM>\r\n                        <LISTITEM value=\"Selfish\" id=\"CBattitudetoself2\" Selected=\"False\">Selfish</LISTITEM>\r\n                        <LISTITEM value=\"Dramatizing\" id=\"CBattitudetoself3\" Selected=\"False\">Dramatizing</LISTITEM>\r\n                        <LISTITEM value=\"Critical\" id=\"CBattitudetoself4\" Selected=\"False\">Critical</LISTITEM>\r\n                        <LISTITEM value=\"Self-consicious\" id=\"CBattitudetoself5\" Selected=\"False\">Self-conscious</LISTITEM>\r\n                        <LISTITEM value=\"Satisfied\" id=\"CBattitudetoself6\" Selected=\"False\">Satisfied</LISTITEM>\r\n                        <LISTITEM value=\"Over concerned\" id=\"CBattitudetoself7\" Selected=\"False\">Over concerned</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"CBmoralreligiousattitude\" type=\"CheckBoxList\" label=\"Moral and Religious attitude\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">CBmoralreligiousattitude</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Evidence of rigidity\" id=\"CBmoralreligiousattitude1\" Selected=\"False\">Evidence of rigidity</LISTITEM>\r\n                        <LISTITEM value=\"Compliance\" id=\"CBmoralreligiousattitude2\" Selected=\"False\">Compliance</LISTITEM>\r\n                        <LISTITEM value=\"Permissiveness\" id=\"CBmoralreligiousattitude3\" Selected=\"False\">Permissiveness</LISTITEM>\r\n                        <LISTITEM value=\"Over conscientiousness\" id=\"CBmoralreligiousattitude4\" Selected=\"False\">Over conscientiousness</LISTITEM>\r\n                        <LISTITEM value=\"Rebellious\" id=\"CBmoralreligiousattitude5\" Selected=\"False\">Rebellious</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"CBsocialrelationships\" type=\"CheckBoxList\" label=\"Social relationships\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">CBsocialrelationships</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Leader\" id=\"CBsocialrelationships1\" Selected=\"False\">Leader</LISTITEM>\r\n                        <LISTITEM value=\"Follower\" id=\"CBsocialrelationships2\" Selected=\"False\">Follower</LISTITEM>\r\n                        <LISTITEM value=\"Organiser\" id=\"CBsocialrelationships3\" Selected=\"False\">Organiser</LISTITEM>\r\n                        <LISTITEM value=\"Aggressive\" id=\"CBsocialrelationships4\" Selected=\"False\">Aggressive</LISTITEM>\r\n                        <LISTITEM value=\"Submissive\" id=\"CBsocialrelationships5\" Selected=\"False\">Submissive</LISTITEM>\r\n                        <LISTITEM value=\"Ambitious\" id=\"CBsocialrelationships6\" Selected=\"False\">Ambitious</LISTITEM>\r\n                        <LISTITEM value=\"Adjustable\" id=\"CBsocialrelationships7\" Selected=\"False\">Adjustable</LISTITEM>\r\n                        <LISTITEM value=\"Independent\" id=\"CBsocialrelationships8\" Selected=\"False\">Independent</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"CBmood\"  type=\"CheckBoxList\" label=\"Mood\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">CBmood</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Stable\" id=\"CBmood1\" Selected=\"False\">Stable</LISTITEM>\r\n                        <LISTITEM value=\"Mood swings\" id=\"CBmood2\" Selected=\"False\">Mood swings</LISTITEM>\r\n                        <LISTITEM value=\"Anxious\" id=\"CBmood3\" Selected=\"False\">Anxious</LISTITEM>\r\n                        <LISTITEM value=\"Irritable\" id=\"CBmood4\" Selected=\"False\">Irritable</LISTITEM>\r\n                        <LISTITEM value=\"Submissive\" id=\"CBmood5\" Selected=\"False\">Worrying</LISTITEM>\r\n                        <LISTITEM value=\"Cheerful\" id=\"CBmood6\" Selected=\"False\">Cheerful</LISTITEM>\r\n                        <LISTITEM value=\"Glomy\" id=\"CBmood7\" Selected=\"False\">Glomy</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"CBleisuretimespent\" type=\"CheckBoxList\" label=\"Leisure time spent\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">CBleisuretimespent</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Alone\" id=\"CBleisuretimespent1\" Selected=\"False\">Alone</LISTITEM>\r\n                        <LISTITEM value=\"With friends\" id=\"CBleisuretimespent2\" Selected=\"False\">With friends</LISTITEM>\r\n                        <LISTITEM value=\"With family\" id=\"CBleisuretimespent3\" Selected=\"False\">With family</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"premorbid_personality_notes\" type=\"textareaFull\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">premorbid_personality_notes</PROPERTY>\r\n                        <PROPERTY name=\"name\">premorbid_personality_notes</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"rows\">6</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD type=\"PanelBar\" label=\"Mental Status Examination\" target_div=\"mental_status_examination\">\r\n                <FIELD type=\"Header2\" label=\"General Appearance Behaviour\"></FIELD>\r\n                \r\n                <FIELD id=\"RBAppearance\" type=\"RadioButtonList\" label=\"Appearance\" required=\"true\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBAppearance</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Looks ones age\" id=\"RBAppearance1\" Selected=\"False\">Looks ones age</LISTITEM>\r\n                        <LISTITEM value=\"Older\" id=\"RBAppearance2\" Selected=\"False\">Older</LISTITEM>\r\n                        <LISTITEM value=\"Younger\" id=\"RBAppearance3\" Selected=\"False\">Younger</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBlevelofgrooming\" type=\"RadioButtonList\" label=\"Level of grooming\" required=\"true\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBlevelofgrooming</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Normal\" id=\"RBlevelofgrooming1\" Selected=\"False\">Normal</LISTITEM>\r\n                        <LISTITEM value=\"Shabbily Dressed\" id=\"RBlevelofgrooming2\" Selected=\"False\">Shabbily Dressed</LISTITEM>\r\n                        <LISTITEM value=\"Over Dressed\" id=\"RBlevelofgrooming3\" Selected=\"False\">Over Dressed</LISTITEM>\r\n                        <LISTITEM value=\"Inappropriate\" id=\"RBlevelofgrooming4\" Selected=\"False\">Inappropriate</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBlevelofcleanliness\" type=\"RadioButtonList\" label=\"Level of Cleanliness\" required=\"true\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBlevelofcleanliness</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Adequate\" id=\"RBlevelofcleanliness1\" Selected=\"False\">Adequate</LISTITEM>\r\n                        <LISTITEM value=\"Inadequate\" id=\"RBlevelofcleanliness2\" Selected=\"False\">Inadequate</LISTITEM>\r\n                        <LISTITEM value=\"Overtly Clean\" id=\"RBlevelofcleanliness3\" Selected=\"False\">Overtly Clean</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBmodeofentry\" type=\"RadioButtonList\" label=\"Mode of entry\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBmodeofentry</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Stable\" id=\"RBmodeofentry1\" Selected=\"False\">Came willingly</LISTITEM>\r\n                        <LISTITEM value=\"Mood swings\" id=\"RBmodeofentry2\" Selected=\"False\">Persuaded by physical force</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBCooperativeness\" type=\"RadioButtonList\" label=\"Cooperativeness\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBCooperativeness</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Yes\" id=\"RBCooperativeness1\" Selected=\"False\">Yes</LISTITEM>\r\n                        <LISTITEM value=\"No\" id=\"RBCooperativeness2\" Selected=\"False\">No</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBeyetoeyecontact\" type=\"RadioButtonList\" label=\"Eye to Eye contacat\" required=\"true\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBeyetoeyecontact</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Maintained\" id=\"RBeyetoeyecontact1\" Selected=\"False\">Maintained</LISTITEM>\r\n                        <LISTITEM value=\"Difficult\" id=\"RBeyetoeyecontact2\" Selected=\"False\">Difficult</LISTITEM>\r\n                        <LISTITEM value=\"Not Maintained\" id=\"RBeyetoeyecontact3\" Selected=\"False\">Not Maintained</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBHallucinatorybehaviour\" type=\"RadioButtonList\" label=\"Hallucinatory behaviour\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBHallucinatorybehaviour</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Present\" id=\"RBHallucinatorybehaviour1\" Selected=\"False\">Present</LISTITEM>\r\n                        <LISTITEM value=\"Absent\" id=\"RBHallucinatorybehaviour2\" Selected=\"False\">Absent</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBrapport\" type=\"RadioButtonList\" label=\"Rapport\" required=\"true\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBrapport</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Spontaneous\" id=\"RBrapport1\" Selected=\"False\">Spontaneous</LISTITEM>\r\n                        <LISTITEM value=\"Difficult\" id=\"RBrapport2\" Selected=\"False\">Difficult</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"CBGesturingposturing\" type=\"CheckBoxList\" label=\"Gesturing and posturing\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">CBGesturingposturing</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Normal\" id=\"CBGesturingposturing1\" Selected=\"False\">Normal</LISTITEM>\r\n                        <LISTITEM value=\"Exaggerated\" id=\"CBGesturingposturing2\" Selected=\"False\">Exaggerated</LISTITEM>\r\n                        <LISTITEM value=\"Catatonic\" id=\"CBGesturingposturing3\" Selected=\"False\">Catatonic</LISTITEM>\r\n                        <LISTITEM value=\"Negativism\" id=\"CBGesturingposturing4\" Selected=\"False\">Negativism</LISTITEM>\r\n                        <LISTITEM value=\"Waxy flexibility\" id=\"CBGesturingposturing5\" Selected=\"False\">Waxy flexibility</LISTITEM>\r\n                        <LISTITEM value=\"Echopraxia\" id=\"CBGesturingposturing6\" Selected=\"False\">Echopraxia</LISTITEM>\r\n                        <LISTITEM value=\"Automatism\" id=\"CBGesturingposturing7\" Selected=\"False\">Automatism</LISTITEM>\r\n                        <LISTITEM value=\"Others\" id=\"CBGesturingposturing8\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'txtGesturingposturing\');\">Others</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"txtGesturingposturing\" type=\"TextBox\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txtGesturingposturing</PROPERTY>\r\n                            <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                            <PROPERTY name=\"name\">txtGesturingposturing</PROPERTY>\r\n                            <PROPERTY name=\"placeholder\">Other</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBgaitdisurbances\" type=\"RadioButtonList\" label=\"Gait Disurbances\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBgaitdisurbances</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Spontaneous\" id=\"RBgaitdisurbances1\" Selected=\"False\">Normal</LISTITEM>\r\n                        <LISTITEM value=\"March\" id=\"RBgaitdisurbances2\" Selected=\"False\">March</LISTITEM>\r\n                        <LISTITEM value=\"Limb\" id=\"RBgaitdisurbances3\" Selected=\"False\">Limb</LISTITEM>\r\n                        <LISTITEM value=\"Assisted\" id=\"RBgaitdisurbances4\" Selected=\"False\">Assisted</LISTITEM>\r\n                        <LISTITEM value=\"Shuffling\" id=\"RBgaitdisurbances5\" Selected=\"False\">Shuffling</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n            </FIELD>\r\n        </PANELBODY>\r\n    </GROUP>\r\n</FIELDS>','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<xsl:stylesheet xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" version=\"1.0\">\r\n    <xsl:output method=\"html\"/>\r\n    <xsl:template match=\"/\">\r\n        <script type=\"text/javascript\" src=\"js/xmlvalidation.js\">&#160;</script> \r\n        \r\n        <form method=\"post\" id=\"xmlform\">\r\n            \r\n            <xsl:for-each select=\"FIELDS/GROUP\">\r\n                <div class=\"panel panel-default\">\r\n                    <div class=\"panel-heading\">\r\n                        <b> \r\n                            <xsl:value-of select=\"PANELHEADER\" /> \r\n                        </b>\r\n                    </div>\r\n                \r\n                    <xsl:for-each select=\"PANELBODY\">\r\n                        <div class=\"panel-body\">\r\n                            <xsl:for-each select=\"FIELD\">\r\n                                <xsl:choose>\r\n                                    \r\n                                    <!-- Main Text Box -->\r\n                                    <xsl:when test=\"@type=\'TextBox\'\">\r\n                                        <div class=\"form-group\">\r\n                                            <label class=\"col-sm-3 control-label\">\r\n                                                <xsl:value-of select=\"@label\" />\r\n                                                <xsl:if test=\"@required=\'true\'\">\r\n                                                    <span class=\"required\"> *</span>\r\n                                                </xsl:if>\r\n                                            </label>\r\n                                            <div class=\"col-sm-9\">\r\n                                                <input type=\"text\">\r\n                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                        <xsl:attribute name=\"{@name}\">\r\n                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                    </xsl:for-each>\r\n                                                </input>\r\n                                                <xsl:if test=\"FIELD\">\r\n                                                    <xsl:for-each select=\"FIELD\">\r\n                                                        <xsl:choose>\r\n                                                            <xsl:when test=\"@type=\'DropDownList\'\">\r\n                                                                <select>\r\n                                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                        <xsl:attribute name=\"{@name}\">\r\n                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                        </xsl:attribute>\r\n                                                                    </xsl:for-each>\r\n                                                                    <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                        <option>\r\n                                                                            <xsl:attribute name=\"value\">\r\n                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                <xsl:attribute name=\"selected\">\r\n                                                                                    <xsl:text>selected</xsl:text>\r\n                                                                                </xsl:attribute>\r\n                                                                            </xsl:if>\r\n                                                                            <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                        </option>\r\n                                                                    </xsl:for-each>\r\n                                                                </select>\r\n                                                            </xsl:when>\r\n                                                        </xsl:choose>\r\n                                                    </xsl:for-each>\r\n                                                </xsl:if>\r\n                                            </div>\r\n                                        </div>\r\n                                        <div class=\"line line-dashed b-b line-lg \"></div>\r\n                                    </xsl:when> \r\n                                    \r\n                                    <!-- Main Radio Button -->                          \r\n                                    <xsl:when test=\"@type=\'RadioButtonList\'\">\r\n                                        <div class=\"form-group\">\r\n                                            <label class=\"col-sm-3 control-label\">\r\n                                                <xsl:value-of select=\"@label\" />\r\n                                                <xsl:if test=\"@required=\'true\'\">\r\n                                                    <span class=\"required\"> *</span>\r\n                                                </xsl:if>\r\n                                            </label>\r\n                                            <div class=\"col-sm-9\">\r\n                                                <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                    <input type=\"radio\">\r\n                                                        <xsl:attribute name=\"value\">\r\n                                                            <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:attribute name=\"id\">\r\n                                                            <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:if test=\"@Selected = \'true\'\">\r\n                                                            <xsl:attribute name=\"checked\">\r\n                                                                <xsl:text>checked</xsl:text>\r\n                                                            </xsl:attribute>\r\n                                                        </xsl:if>\r\n                                                        <xsl:attribute name=\"onclick\">\r\n                                                            <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                            </xsl:attribute>\r\n                                                        </xsl:for-each>\r\n                                                    </input>&#160;\r\n                                                    <label for=\"{@id}\">\r\n                                                        <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                    </label>&#160;&#160;\r\n                                                </xsl:for-each>\r\n                                                <xsl:if test=\"FIELD\">\r\n                                                    <xsl:for-each select=\"FIELD\">\r\n                                                        <xsl:choose>\r\n                                                            <xsl:when test=\"@type=\'TextBox\'\">\r\n                                                                <xsl:value-of select=\"@label\" />\r\n                                                                <input type=\"text\">\r\n                                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                        <xsl:attribute name=\"{@name}\">\r\n                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                        </xsl:attribute>\r\n                                                                    </xsl:for-each>\r\n                                                                </input>\r\n                                                            </xsl:when>\r\n                                                            \r\n                                                            <xsl:when test=\"@type=\'RadioButtonList\'\">\r\n                                                                <xsl:if test=\"@Backcontrols = \'true\'\">\r\n                                                                    <div>\r\n                                                                        <xsl:attribute name=\"id\">\r\n                                                                            <xsl:value-of select=\"@Backdivid\"></xsl:value-of>\r\n                                                                        </xsl:attribute>\r\n                                                                        <xsl:attribute name=\"class\">\r\n                                                                            <xsl:text>hide</xsl:text>\r\n                                                                        </xsl:attribute>\r\n                                                                        <xsl:value-of select=\"@label\" />\r\n                                                                        <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                            <input type=\"radio\">\r\n                                                                                <xsl:attribute name=\"value\">\r\n                                                                                    <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                </xsl:attribute>\r\n                                                                                <xsl:attribute name=\"id\">\r\n                                                                                    <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                                                </xsl:attribute>\r\n                                                                                <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                    <xsl:attribute name=\"checked\">\r\n                                                                                        <xsl:text>checked</xsl:text>\r\n                                                                                    </xsl:attribute>\r\n                                                                                </xsl:if>\r\n                                                                                <xsl:attribute name=\"onclick\">\r\n                                                                                    <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                                                </xsl:attribute>\r\n                                                                                <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                                                    <xsl:attribute name=\"{@name}\">\r\n                                                                                        <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                    </xsl:attribute>\r\n                                                                                </xsl:for-each>\r\n                                                                            </input>\r\n                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>&#160;\r\n                                                                        </xsl:for-each>\r\n                                                                    </div>\r\n                                                                </xsl:if>\r\n                                                            </xsl:when>\r\n                                                            \r\n                                                            <xsl:when test=\"@type=\'DropDownList\'\">\r\n                                                                <xsl:if test=\"@Backcontrols = \'true\'\">\r\n                                                                    <div>\r\n                                                                        <xsl:attribute name=\"id\">\r\n                                                                            <xsl:value-of select=\"@Backdivid\"></xsl:value-of>\r\n                                                                        </xsl:attribute>\r\n                                                                        <xsl:attribute name=\"class\">\r\n                                                                            <xsl:text>hide</xsl:text>\r\n                                                                        </xsl:attribute>\r\n                                                                        <xsl:value-of select=\"@label\" />\r\n                                                                        <select>\r\n                                                                            <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                <xsl:attribute name=\"{@name}\">\r\n                                                                                    <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                </xsl:attribute>\r\n                                                                            </xsl:for-each>\r\n                                                                            <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                <option>\r\n                                                                                    <xsl:attribute name=\"value\">\r\n                                                                                        <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                    </xsl:attribute>\r\n                                                                                    <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                        <xsl:attribute name=\"selected\">\r\n                                                                                            <xsl:text>selected</xsl:text>\r\n                                                                                        </xsl:attribute>\r\n                                                                                    </xsl:if>\r\n                                                                                    <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                </option>\r\n                                                                            </xsl:for-each>\r\n                                                                        </select>\r\n                                                                    </div>\r\n                                                                </xsl:if>\r\n                                                            </xsl:when>\r\n                                                        </xsl:choose>\r\n                                                    </xsl:for-each>\r\n                                                </xsl:if>\r\n                                            </div>\r\n                                        </div>\r\n                                        <div class=\"line line-dashed b-b line-lg \"></div>\r\n                                    </xsl:when>\r\n                                \r\n                                    <!-- Main Checkbox -->\r\n                                    <xsl:when test=\"@type=\'CheckBoxList\'\">\r\n                                        <div class=\"form-group\">\r\n                                            <label class=\"col-sm-3 control-label\">\r\n                                                <xsl:value-of select=\"@label\" />\r\n                                                <xsl:if test=\"@required=\'true\'\">\r\n                                                    <span class=\"required\"> *</span>\r\n                                                </xsl:if>\r\n                                            </label>\r\n                                            <div class=\"col-sm-9\">\r\n                                                <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                    <input type=\"checkbox\">\r\n                                                        <xsl:attribute name=\"value\">\r\n                                                            <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:attribute name=\"id\">\r\n                                                            <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:if test=\"@Selected = \'true\'\">\r\n                                                            <xsl:attribute name=\"checked\">\r\n                                                                <xsl:text>checked</xsl:text>\r\n                                                            </xsl:attribute>\r\n                                                        </xsl:if>\r\n                                                        <xsl:attribute name=\"onclick\">\r\n                                                            <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                            </xsl:attribute>\r\n                                                        </xsl:for-each>\r\n                                                    </input>\r\n                                                    &#160;\r\n                                                    <label for=\"{@id}\">\r\n                                                        <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                    </label>&#160;&#160;\r\n                                                </xsl:for-each>\r\n                                                <xsl:if test=\"FIELD\">\r\n                                                    <xsl:for-each select=\"FIELD\">\r\n                                                        <xsl:choose>\r\n                                                            <xsl:when test=\"@type=\'TextBox\'\">\r\n                                                                <xsl:value-of select=\"@label\" />\r\n                                                                <input type=\"text\">\r\n                                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                        <xsl:attribute name=\"{@name}\">\r\n                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                        </xsl:attribute>\r\n                                                                    </xsl:for-each>\r\n                                                                </input>\r\n                                                            </xsl:when>\r\n                                                        </xsl:choose>\r\n                                                    </xsl:for-each>\r\n                                                </xsl:if>\r\n                                            </div>\r\n                                        </div>\r\n                                        <div class=\"line line-dashed b-b line-lg \"></div>\r\n                                    </xsl:when>\r\n                                \r\n                                    \r\n                                    <!-- Main Header2 -->\r\n                                    <xsl:when test=\"@type=\'Header2\'\">\r\n                                        <h4>\r\n                                            <b> \r\n                                                <xsl:value-of select=\"@label\" /> \r\n                                            </b>\r\n                                        </h4>\r\n                                    </xsl:when>\r\n                                    \r\n                                    <!-- Main Grid -->\r\n                                    <xsl:when test=\"@type=\'RadGrid\'\">\r\n                                        <div class=\"form-group\">\r\n                                            <div class=\"col-sm-12\">\r\n                                                <xsl:if test=\"@ADDButton=\'True\'\">\r\n                                                    <input type=\"button\">\r\n                                                        <xsl:attribute name=\"class\">\r\n                                                            <xsl:text>addMore</xsl:text>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:attribute name=\"value\">\r\n                                                            <xsl:text>Add</xsl:text>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:attribute name=\"id\">\r\n                                                            <xsl:value-of select=\"@ADDButtonID\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:attribute name=\"data-table-id\">\r\n                                                            <xsl:value-of select=\"@AddButtonTableId\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                    </input>\r\n                                                </xsl:if>\r\n                                        \r\n                                                <table>\r\n                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                        <xsl:attribute name=\"{@name}\">\r\n                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                    </xsl:for-each>\r\n                                                    <thead>\r\n                                                        <tr>\r\n                                                            <xsl:for-each select=\"HEADER/TH\">\r\n                                                                <th>\r\n                                                                    <xsl:value-of select=\"current()\" />\r\n                                                                </th>\r\n                                                            </xsl:for-each>\r\n                                                        </tr>\r\n                                                    </thead>\r\n                                                    <tbody>\r\n                                                        <xsl:for-each select=\"COLUMNS\">\r\n                                                            <tr>\r\n                                                                <xsl:for-each select=\"FIELD\">\r\n                                                                    <td>\r\n                                                                        <xsl:choose>\r\n                                                                            <xsl:when test=\"@type=\'TextBox\'\">\r\n                                                                                <input type=\"text\">\r\n                                                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                        <xsl:attribute name=\"{@name}\">\r\n                                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                        </xsl:attribute>\r\n                                                                                    </xsl:for-each>\r\n                                                                                </input>\r\n                                                                                <xsl:if test=\"FIELD\">\r\n                                                                                    <xsl:for-each select=\"FIELD\">\r\n                                                                                        <xsl:choose>\r\n                                                                                            <xsl:when test=\"@type=\'DropDownList\'\">\r\n                                                                                                <select>\r\n                                                                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                                        <xsl:attribute name=\"{@name}\">\r\n                                                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                        </xsl:attribute>\r\n                                                                                                    </xsl:for-each>\r\n                                                                                                    <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                                        <option>\r\n                                                                                                            <xsl:attribute name=\"value\">\r\n                                                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                            <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                                <xsl:attribute name=\"selected\">\r\n                                                                                                                    <xsl:text>selected</xsl:text>\r\n                                                                                                                </xsl:attribute>\r\n                                                                                                            </xsl:if>\r\n                                                                                                            <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                        </option>\r\n                                                                                                    </xsl:for-each>\r\n                                                                                                </select>\r\n                                                                                            </xsl:when>\r\n                                                                                        </xsl:choose>\r\n                                                                                    </xsl:for-each>\r\n                                                                                </xsl:if>\r\n                                                                            </xsl:when>\r\n                                                                    \r\n                                                                            <xsl:when test=\"@type=\'DropDownList\'\">\r\n                                                                                <select>\r\n                                                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                        <xsl:attribute name=\"{@name}\">\r\n                                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                        </xsl:attribute>\r\n                                                                                    </xsl:for-each>\r\n                                                                                    <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                        <option>\r\n                                                                                            <xsl:attribute name=\"value\">\r\n                                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                            </xsl:attribute>\r\n                                                                                            <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                <xsl:attribute name=\"selected\">\r\n                                                                                                    <xsl:text>selected</xsl:text>\r\n                                                                                                </xsl:attribute>\r\n                                                                                            </xsl:if>\r\n                                                                                            <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                        </option>\r\n                                                                                    </xsl:for-each>\r\n                                                                                </select>\r\n                                                                            </xsl:when>\r\n                                                                    \r\n                                                                            <xsl:when test=\"@type=\'RadioButtonList\'\">\r\n                                                                                <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                    <input type=\"radio\">\r\n                                                                                        <xsl:attribute name=\"value\">\r\n                                                                                            <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                        </xsl:attribute>\r\n                                                                                        <xsl:attribute name=\"id\">\r\n                                                                                            <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                                                        </xsl:attribute>\r\n                                                                                        <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                            <xsl:attribute name=\"checked\">\r\n                                                                                                <xsl:text>checked</xsl:text>\r\n                                                                                            </xsl:attribute>\r\n                                                                                        </xsl:if>\r\n                                                                                        <xsl:attribute name=\"onclick\">\r\n                                                                                            <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                                                        </xsl:attribute>\r\n                                                                                        <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                            </xsl:attribute>\r\n                                                                                        </xsl:for-each>\r\n                                                                                    </input>\r\n                                                                                    <xsl:value-of select=\"current()\"></xsl:value-of>&#160;\r\n                                                                                </xsl:for-each>\r\n                                                                            </xsl:when>\r\n                                                                        </xsl:choose>\r\n                                                                    </td>\r\n                                                                </xsl:for-each>\r\n                                                            </tr>\r\n                                                        </xsl:for-each>\r\n                                                \r\n                                                    </tbody>\r\n                                                </table>\r\n                                            </div>\r\n                                        </div>\r\n                                    </xsl:when>\r\n                                    \r\n                                    <!-- Main Textarea -->\r\n                                    <xsl:when test=\"@type=\'textareaFull\'\">\r\n                                        <div class=\"form-group\">\r\n                                            <div class=\"col-sm-12\">\r\n                                                <label>\r\n                                                    <xsl:value-of select=\"@label\" />\r\n                                                </label>\r\n                                                <textarea>\r\n                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                        <xsl:attribute name=\"{@name}\">\r\n                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                    </xsl:for-each>\r\n                                                    <xsl:value-of select=\"VALUE\"></xsl:value-of>\r\n                                                </textarea>\r\n                                            </div>\r\n                                        </div>\r\n                                        <div class=\"line line-dashed b-b line-lg \"></div>\r\n                                    </xsl:when> \r\n                                    \r\n                                    <!-- Main Panel Bar -->\r\n                                    <xsl:when test=\"@type=\'PanelBar\'\">\r\n                                        <div class=\"panel panel-default\">\r\n                                            <div class=\"panel-heading\">\r\n                                                <h4 class=\"panel-title\">\r\n                                                    <a class=\"accordion-toggle\" data-toggle=\"collapse\" data-target=\"#{@target_div}\" href=\"javascript:void(0)\">\r\n                                                        <span>\r\n                                                            <xsl:value-of select=\"@label\"></xsl:value-of>\r\n                                                        </span>\r\n                                                    </a>\r\n                                                </h4>\r\n                                            </div>\r\n                                            <div id=\"{@target_div}\" class=\"collapse panel-body\">\r\n                                                <xsl:for-each select=\"FIELD\">\r\n                                                    <xsl:choose>\r\n                                                        <xsl:when test=\"@type=\'Header2\'\">\r\n                                                            <h4>\r\n                                                                <b> \r\n                                                                    <xsl:value-of select=\"@label\" /> \r\n                                                                </b>\r\n                                                            </h4>\r\n                                                        </xsl:when>\r\n                                                        \r\n                                                        <xsl:when test=\"@type=\'RadGrid\'\">\r\n                                                            <div class=\"form-group\">\r\n                                                                <div class=\"col-sm-12\">\r\n                                                                    <xsl:if test=\"@ADDButton=\'True\'\">\r\n                                                                        <input type=\"button\">\r\n                                                                            <xsl:attribute name=\"class\">\r\n                                                                                <xsl:text>addMore</xsl:text>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:attribute name=\"value\">\r\n                                                                                <xsl:text>Add</xsl:text>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:attribute name=\"id\">\r\n                                                                                <xsl:value-of select=\"@ADDButtonID\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:attribute name=\"data-table-id\">\r\n                                                                                <xsl:value-of select=\"@AddButtonTableId\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                        </input>\r\n                                                                    </xsl:if>\r\n                                        \r\n                                                                    <table>\r\n                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                        </xsl:for-each>\r\n                                                                        <thead>\r\n                                                                            <tr>\r\n                                                                                <xsl:for-each select=\"HEADER/TH\">\r\n                                                                                    <th>\r\n                                                                                        <xsl:value-of select=\"current()\" />\r\n                                                                                    </th>\r\n                                                                                </xsl:for-each>\r\n                                                                            </tr>\r\n                                                                        </thead>\r\n                                                                        <tbody>\r\n                                                                            <xsl:for-each select=\"COLUMNS\">\r\n                                                                                <tr>\r\n                                                                                    <xsl:for-each select=\"FIELD\">\r\n                                                                                        <td>\r\n                                                                                            <xsl:choose>\r\n                                                                                                <xsl:when test=\"@type=\'TextBox\'\">\r\n                                                                                                    <input type=\"text\">\r\n                                                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                        </xsl:for-each>\r\n                                                                                                    </input>\r\n                                                                                                    <xsl:if test=\"FIELD\">\r\n                                                                                                        <xsl:for-each select=\"FIELD\">\r\n                                                                                                            <xsl:choose>\r\n                                                                                                                <xsl:when test=\"@type=\'DropDownList\'\">\r\n                                                                                                                    <select>\r\n                                                                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                                            </xsl:attribute>\r\n                                                                                                                        </xsl:for-each>\r\n                                                                                                                        <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                                                            <option>\r\n                                                                                                                                <xsl:attribute name=\"value\">\r\n                                                                                                                                    <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                                                </xsl:attribute>\r\n                                                                                                                                <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                                                    <xsl:attribute name=\"selected\">\r\n                                                                                                                                        <xsl:text>selected</xsl:text>\r\n                                                                                                                                    </xsl:attribute>\r\n                                                                                                                                </xsl:if>\r\n                                                                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                                            </option>\r\n                                                                                                                        </xsl:for-each>\r\n                                                                                                                    </select>\r\n                                                                                                                </xsl:when>\r\n                                                                                                            </xsl:choose>\r\n                                                                                                        </xsl:for-each>\r\n                                                                                                    </xsl:if>\r\n                                                                                                </xsl:when>\r\n                                                                    \r\n                                                                                                <xsl:when test=\"@type=\'DropDownList\'\">\r\n                                                                                                    <select>\r\n                                                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                        </xsl:for-each>\r\n                                                                                                        <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                                            <option>\r\n                                                                                                                <xsl:attribute name=\"value\">\r\n                                                                                                                    <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                                </xsl:attribute>\r\n                                                                                                                <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                                    <xsl:attribute name=\"selected\">\r\n                                                                                                                        <xsl:text>selected</xsl:text>\r\n                                                                                                                    </xsl:attribute>\r\n                                                                                                                </xsl:if>\r\n                                                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                            </option>\r\n                                                                                                        </xsl:for-each>\r\n                                                                                                    </select>\r\n                                                                                                </xsl:when>\r\n                                                                    \r\n                                                                                                <xsl:when test=\"@type=\'RadioButtonList\'\">\r\n                                                                                                    <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                                        <input type=\"radio\">\r\n                                                                                                            <xsl:attribute name=\"value\">\r\n                                                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                            <xsl:attribute name=\"id\">\r\n                                                                                                                <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                            <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                                <xsl:attribute name=\"checked\">\r\n                                                                                                                    <xsl:text>checked</xsl:text>\r\n                                                                                                                </xsl:attribute>\r\n                                                                                                            </xsl:if>\r\n                                                                                                            <xsl:attribute name=\"onclick\">\r\n                                                                                                                <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                            <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                                                                                <xsl:attribute name=\"{@name}\">\r\n                                                                                                                    <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                                </xsl:attribute>\r\n                                                                                                            </xsl:for-each>\r\n                                                                                                        </input>\r\n                                                                                                        <xsl:value-of select=\"current()\"></xsl:value-of>&#160;\r\n                                                                                                    </xsl:for-each>\r\n                                                                                                    <xsl:if test=\"FIELD\">\r\n                                                                                                        <xsl:for-each select=\"FIELD\">\r\n                                                                                                            <xsl:choose>\r\n                                                                                                                <xsl:when test=\"@type=\'TextBox\'\">\r\n                                                                                                                    <xsl:value-of select=\"@label\" />\r\n                                                                                                                    <input type=\"text\">\r\n                                                                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                                            </xsl:attribute>\r\n                                                                                                                        </xsl:for-each>\r\n                                                                                                                    </input>\r\n                                                                                                                </xsl:when>\r\n                                                                                                            </xsl:choose>\r\n                                                                                                        </xsl:for-each>\r\n                                                                                                    </xsl:if>\r\n                                                                                                </xsl:when>\r\n                                                                                                \r\n                                                                                                <xsl:when test=\"@type=\'CheckBoxList\'\">\r\n                                                                                                    <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                                        <input type=\"checkbox\">\r\n                                                                                                            <xsl:attribute name=\"value\">\r\n                                                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                            <xsl:attribute name=\"id\">\r\n                                                                                                                <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                            <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                                <xsl:attribute name=\"checked\">\r\n                                                                                                                    <xsl:text>checked</xsl:text>\r\n                                                                                                                </xsl:attribute>\r\n                                                                                                            </xsl:if>\r\n                                                                                                            <xsl:attribute name=\"onclick\">\r\n                                                                                                                <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                            <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                                                                                <xsl:attribute name=\"{@name}\">\r\n                                                                                                                    <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                                </xsl:attribute>\r\n                                                                                                            </xsl:for-each>\r\n                                                                                                        </input>\r\n                                                                        &#160;\r\n                                                                                                        <label for=\"{@id}\">\r\n                                                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                        </label>&#160;&#160;\r\n                                                                                                    </xsl:for-each>\r\n                                                                                                </xsl:when>\r\n                                                                                            </xsl:choose>\r\n                                                                                        </td>\r\n                                                                                    </xsl:for-each>\r\n                                                                                </tr>\r\n                                                                            </xsl:for-each>\r\n                                                \r\n                                                                        </tbody>\r\n                                                                    </table>\r\n                                                                </div>\r\n                                                            </div>\r\n                                                        </xsl:when>\r\n                                                        \r\n                                                        <xsl:when test=\"@type=\'RadioButtonList\'\">\r\n                                                            <div class=\"form-group\">\r\n                                                                <label class=\"col-sm-3 control-label\">\r\n                                                                    <xsl:value-of select=\"@label\" />\r\n                                                                    <xsl:if test=\"@required=\'true\'\">\r\n                                                                        <span class=\"required\"> *</span>\r\n                                                                    </xsl:if>\r\n                                                                </label>\r\n                                                                <div class=\"col-sm-9\">\r\n                                                                    <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                        <input type=\"radio\">\r\n                                                                            <xsl:attribute name=\"value\">\r\n                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:attribute name=\"id\">\r\n                                                                                <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                <xsl:attribute name=\"checked\">\r\n                                                                                    <xsl:text>checked</xsl:text>\r\n                                                                                </xsl:attribute>\r\n                                                                            </xsl:if>\r\n                                                                            <xsl:attribute name=\"onclick\">\r\n                                                                                <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                                                <xsl:attribute name=\"{@name}\">\r\n                                                                                    <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                </xsl:attribute>\r\n                                                                            </xsl:for-each>\r\n                                                                        </input>\r\n                                                                        <xsl:value-of select=\"current()\"></xsl:value-of>&#160;\r\n                                                                    </xsl:for-each>\r\n                                                                    <xsl:if test=\"FIELD\">\r\n                                                                        <div id=\"{@Backdivid}\" class=\"hide\"> \r\n                                                                            <xsl:for-each select=\"FIELD\">\r\n                                                                                <xsl:choose>\r\n                                                                                    <xsl:when test=\"@type=\'DropDownList\'\">\r\n                                                                                        <div>\r\n                                                                                            <xsl:value-of select=\"@label\" />\r\n                                                                                            <select>\r\n                                                                                                <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                                    <xsl:attribute name=\"{@name}\">\r\n                                                                                                        <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                    </xsl:attribute>\r\n                                                                                                </xsl:for-each>\r\n                                                                                                <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                                    <option>\r\n                                                                                                        <xsl:attribute name=\"value\">\r\n                                                                                                            <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                        </xsl:attribute>\r\n                                                                                                        <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                            <xsl:attribute name=\"selected\">\r\n                                                                                                                <xsl:text>selected</xsl:text>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                        </xsl:if>\r\n                                                                                                        <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                    </option>\r\n                                                                                                </xsl:for-each>\r\n                                                                                            </select>\r\n                                                                                        </div>\r\n                                                                                    </xsl:when>\r\n                                                                                    \r\n                                                                                    <xsl:when test=\"@type=\'TextBox\'\">\r\n                                                                                        <div>\r\n                                                                                            <xsl:value-of select=\"@label\" />\r\n                                                                                            <input type=\"text\">\r\n                                                                                                <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                                    <xsl:attribute name=\"{@name}\">\r\n                                                                                                        <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                    </xsl:attribute>\r\n                                                                                                </xsl:for-each>\r\n                                                                                            </input>\r\n                                                                                        </div>\r\n                                                                                    </xsl:when>\r\n                                                                                    \r\n                                                                                    <xsl:when test=\"@type=\'RadioButtonList\'\">\r\n                                                                                        <div>\r\n                                                                                            <xsl:value-of select=\"@label\" />\r\n                                                                                            <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                                <input type=\"radio\">\r\n                                                                                                    <xsl:attribute name=\"value\">\r\n                                                                                                        <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                    </xsl:attribute>\r\n                                                                                                    <xsl:attribute name=\"id\">\r\n                                                                                                        <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                                                                    </xsl:attribute>\r\n                                                                                                    <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                        <xsl:attribute name=\"checked\">\r\n                                                                                                            <xsl:text>checked</xsl:text>\r\n                                                                                                        </xsl:attribute>\r\n                                                                                                    </xsl:if>\r\n                                                                                                    <xsl:attribute name=\"onclick\">\r\n                                                                                                        <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                                                                    </xsl:attribute>\r\n                                                                                                    <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                                                                        <xsl:attribute name=\"{@name}\">\r\n                                                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                        </xsl:attribute>\r\n                                                                                                    </xsl:for-each>\r\n                                                                                                </input>\r\n                                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>&#160;\r\n                                                                                            </xsl:for-each>\r\n                                                                                        </div>\r\n                                                                                    </xsl:when>\r\n                                                                                    \r\n                                                                                    <xsl:when test=\"@type=\'CheckBoxList\'\">\r\n                                                                                        <xsl:value-of select=\"@label\" />\r\n                                                                                        <div>\r\n                                                                                            <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                                <input type=\"checkbox\">\r\n                                                                                                    <xsl:attribute name=\"value\">\r\n                                                                                                        <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                    </xsl:attribute>\r\n                                                                                                    <xsl:attribute name=\"id\">\r\n                                                                                                        <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                                                                    </xsl:attribute>\r\n                                                                                                    <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                        <xsl:attribute name=\"checked\">\r\n                                                                                                            <xsl:text>checked</xsl:text>\r\n                                                                                                        </xsl:attribute>\r\n                                                                                                    </xsl:if>\r\n                                                                                                    <xsl:attribute name=\"onclick\">\r\n                                                                                                        <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                                                                    </xsl:attribute>\r\n                                                                                                    <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                                                                        <xsl:attribute name=\"{@name}\">\r\n                                                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                        </xsl:attribute>\r\n                                                                                                    </xsl:for-each>\r\n                                                                                                </input>\r\n                                                                        &#160;\r\n                                                                                                <label for=\"{@id}\">\r\n                                                                                                    <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                </label>&#160;&#160;\r\n                                                                                            </xsl:for-each>\r\n                                                                                        </div>\r\n                                                                                    </xsl:when>\r\n                                                                                </xsl:choose>\r\n                                                                            </xsl:for-each>\r\n                                                                        </div>\r\n                                                                    </xsl:if>\r\n                                                                </div>\r\n                                                            </div>\r\n                                                            <div class=\"line line-dashed b-b line-lg \"></div>\r\n                                                        </xsl:when>\r\n                                                        \r\n                                                        <xsl:when test=\"@type=\'TextBox\'\">\r\n                                                            <div class=\"form-group\">\r\n                                                                <label class=\"col-sm-3 control-label\">\r\n                                                                    <xsl:value-of select=\"@label\" />\r\n                                                                    <xsl:if test=\"@required=\'true\'\">\r\n                                                                        <span class=\"required\"> *</span>\r\n                                                                    </xsl:if>\r\n                                                                </label>\r\n                                                                <div class=\"col-sm-9\">\r\n                                                                    <input type=\"text\">\r\n                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                        </xsl:for-each>\r\n                                                                    </input>\r\n                                                                    <xsl:if test=\"FIELD\">\r\n                                                                        <xsl:for-each select=\"FIELD\">\r\n                                                                            <xsl:choose>\r\n                                                                                <xsl:when test=\"@type=\'DropDownList\'\">\r\n                                                                                    <select>\r\n                                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                            </xsl:attribute>\r\n                                                                                        </xsl:for-each>\r\n                                                                                        <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                            <option>\r\n                                                                                                <xsl:attribute name=\"value\">\r\n                                                                                                    <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                </xsl:attribute>\r\n                                                                                                <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                    <xsl:attribute name=\"selected\">\r\n                                                                                                        <xsl:text>selected</xsl:text>\r\n                                                                                                    </xsl:attribute>\r\n                                                                                                </xsl:if>\r\n                                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                            </option>\r\n                                                                                        </xsl:for-each>\r\n                                                                                    </select>\r\n                                                                                </xsl:when>\r\n                                                                            </xsl:choose>\r\n                                                                        </xsl:for-each>\r\n                                                                    </xsl:if>\r\n                                                                </div>\r\n                                                            </div>\r\n                                                            <div class=\"line line-dashed b-b line-lg \"></div>\r\n                                                        </xsl:when>\r\n                                                        \r\n                                                        <xsl:when test=\"@type=\'textareaFull\'\">\r\n                                                            <div class=\"form-group\">\r\n                                                                <div class=\"col-sm-12\">\r\n                                                                    <label>\r\n                                                                        <xsl:value-of select=\"@label\" />\r\n                                                                    </label>\r\n                                                                    <textarea>\r\n                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                        </xsl:for-each>\r\n                                                                        <xsl:value-of select=\"VALUE\"></xsl:value-of>\r\n                                                                    </textarea>\r\n                                                                </div>\r\n                                                            </div>\r\n                                                            <div class=\"line line-dashed b-b line-lg \"></div>\r\n                                                        </xsl:when>\r\n                                                        \r\n                                                        <xsl:when test=\"@type=\'CheckBoxList\'\">\r\n                                                            <div class=\"form-group\">\r\n                                                                <label class=\"col-sm-3 control-label\">\r\n                                                                    <xsl:value-of select=\"@label\" />\r\n                                                                    <xsl:if test=\"@required=\'true\'\">\r\n                                                                        <span class=\"required\"> *</span>\r\n                                                                    </xsl:if>\r\n                                                                </label>\r\n                                                                <div class=\"col-sm-9\">\r\n                                                                    <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                        <input type=\"checkbox\">\r\n                                                                            <xsl:attribute name=\"value\">\r\n                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:attribute name=\"id\">\r\n                                                                                <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                <xsl:attribute name=\"checked\">\r\n                                                                                    <xsl:text>checked</xsl:text>\r\n                                                                                </xsl:attribute>\r\n                                                                            </xsl:if>\r\n                                                                            <xsl:attribute name=\"onclick\">\r\n                                                                                <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                                                <xsl:attribute name=\"{@name}\">\r\n                                                                                    <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                </xsl:attribute>\r\n                                                                            </xsl:for-each>\r\n                                                                        </input>\r\n                                                                        &#160;\r\n                                                                        <label for=\"{@id}\">\r\n                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                        </label>&#160;&#160;\r\n                                                                    </xsl:for-each>\r\n                                                                    <xsl:if test=\"FIELD\">\r\n                                                                        <xsl:for-each select=\"FIELD\">\r\n                                                                            <xsl:choose>\r\n                                                                                <xsl:when test=\"@type=\'TextBox\'\">\r\n                                                                                    <xsl:value-of select=\"@label\" />\r\n                                                                                    <input type=\"text\">\r\n                                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                            </xsl:attribute>\r\n                                                                                        </xsl:for-each>\r\n                                                                                    </input>\r\n                                                                                </xsl:when>\r\n                                                                            </xsl:choose>\r\n                                                                        </xsl:for-each>\r\n                                                                    </xsl:if>\r\n                                                                </div>\r\n                                                            </div>\r\n                                                            <div class=\"line line-dashed b-b line-lg \"></div>\r\n                                                        </xsl:when>\r\n                                                        \r\n                                                        <xsl:when test=\"@type=\'DropDownList\'\">\r\n                                                            <div class=\"form-group\">\r\n                                                                <label class=\"col-sm-3 control-label\">\r\n                                                                    <xsl:value-of select=\"@label\" />\r\n                                                                    <xsl:if test=\"@required=\'true\'\">\r\n                                                                        <span class=\"required\"> *</span>\r\n                                                                    </xsl:if>\r\n                                                                </label>\r\n                                                                <div class=\"col-sm-9\">\r\n                                                                    <select>\r\n                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                        </xsl:for-each>\r\n                                                                        <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                            <option>\r\n                                                                                <xsl:attribute name=\"value\">\r\n                                                                                    <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                </xsl:attribute>\r\n                                                                                <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                    <xsl:attribute name=\"selected\">\r\n                                                                                        <xsl:text>selected</xsl:text>\r\n                                                                                    </xsl:attribute>\r\n                                                                                </xsl:if>\r\n                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                            </option>\r\n                                                                        </xsl:for-each>\r\n                                                                    </select>\r\n                                                                </div>\r\n                                                            </div>\r\n                                                            <div class=\"line line-dashed b-b line-lg \"></div>\r\n                                                            \r\n                                                        </xsl:when>\r\n                                                    </xsl:choose>\r\n                                                </xsl:for-each>\r\n                                            </div>\r\n                                        </div>\r\n                                    </xsl:when>\r\n                                    \r\n                                </xsl:choose>\r\n                            </xsl:for-each>\r\n                        </div>\r\n                    </xsl:for-each>\r\n                </div>\r\n            </xsl:for-each>\r\n        </form>\r\n    </xsl:template>\r\n</xsl:stylesheet>','1',-1,'2016-05-31 11:56:21',51,'2016-06-04 11:27:37','0000-00-00 00:00:00');

/*Table structure for table `pat_documents` */

DROP TABLE IF EXISTS `pat_documents`;

CREATE TABLE `pat_documents` (
  `doc_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doc_type_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `document_xml` longtext,
  `status` enum('0','1') DEFAULT '0',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`doc_id`),
  KEY `FK_pat_documents_tenant` (`tenant_id`),
  KEY `FK_pat_documents_encounter` (`encounter_id`),
  KEY `FK_pat_documents_patient` (`patient_id`),
  KEY `FK_pat_documents_doc_type` (`doc_type_id`),
  CONSTRAINT `FK_pat_documents_doc_type` FOREIGN KEY (`doc_type_id`) REFERENCES `pat_document_types` (`doc_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_documents_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `pat_encounter` (`encounter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_documents_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_documents_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `pat_documents` */

/*Table structure for table `pat_encounter` */

DROP TABLE IF EXISTS `pat_encounter`;

CREATE TABLE `pat_encounter` (
  `encounter_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `encounter_type` varchar(5) NOT NULL,
  `encounter_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `inactive_date` timestamp NULL DEFAULT NULL,
  `bill_no` varchar(30) DEFAULT NULL,
  `finalize` tinyint(1) NOT NULL DEFAULT '0',
  `authorize` tinyint(1) NOT NULL DEFAULT '0',
  `discharge` tinyint(1) NOT NULL DEFAULT '0',
  `casesheet_no` varchar(50) NOT NULL,
  `concession_amount` decimal(10,2) DEFAULT '0.00',
  `status` enum('0','1') DEFAULT '1' COMMENT 'Status common for OP Seen & IP Discharge',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`encounter_id`),
  KEY `FK_pat_encounter_tenant` (`tenant_id`),
  KEY `FK_pat_encounter_patient` (`patient_id`),
  CONSTRAINT `FK_pat_encounter_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_encounter_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

/*Data for the table `pat_encounter` */

insert  into `pat_encounter`(`encounter_id`,`tenant_id`,`patient_id`,`encounter_type`,`encounter_date`,`inactive_date`,`bill_no`,`finalize`,`authorize`,`discharge`,`casesheet_no`,`concession_amount`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (20,58,96,'IP','2016-06-11 18:51:58',NULL,'AH0000054',0,0,0,'1511','0.00','1',51,'2016-06-11 18:52:10',51,'2016-06-11 18:52:10','0000-00-00 00:00:00');

/*Table structure for table `pat_notes` */

DROP TABLE IF EXISTS `pat_notes`;

CREATE TABLE `pat_notes` (
  `pat_note_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `notes` text NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`pat_note_id`),
  KEY `FK_pat_notes_tenant` (`tenant_id`),
  KEY `FK_pat_notes_patient` (`patient_id`),
  KEY `FK_pat_notes_encounter` (`encounter_id`),
  CONSTRAINT `FK_pat_notes_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `pat_encounter` (`encounter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_notes_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_notes_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pat_notes` */

/*Table structure for table `pat_notes_users` */

DROP TABLE IF EXISTS `pat_notes_users`;

CREATE TABLE `pat_notes_users` (
  `vital_note_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `note_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `seen` enum('0','1') NOT NULL DEFAULT '0',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`vital_note_id`),
  KEY `FK_pat_vitals_users_user` (`user_id`),
  KEY `FK_pat_vitals_users_vitals` (`note_id`),
  KEY `FK_pat_vitals_users_tenant` (`tenant_id`),
  CONSTRAINT `FK_pat_notes_users_note` FOREIGN KEY (`note_id`) REFERENCES `pat_notes` (`pat_note_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_notes_users_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_notes_users_user` FOREIGN KEY (`user_id`) REFERENCES `co_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pat_notes_users` */

/*Table structure for table `pat_patient` */

DROP TABLE IF EXISTS `pat_patient`;

CREATE TABLE `pat_patient` (
  `patient_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_global_guid` varchar(50) NOT NULL,
  `patient_guid` varchar(50) CHARACTER SET latin1 NOT NULL,
  `casesheetno` int(11) DEFAULT NULL,
  `patient_int_code` varchar(30) CHARACTER SET latin1 NOT NULL,
  `tenant_id` int(11) NOT NULL,
  `patient_reg_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `patient_title_code` varchar(10) CHARACTER SET latin1 NOT NULL,
  `patient_firstname` varchar(50) CHARACTER SET latin1 NOT NULL,
  `patient_lastname` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `patient_relation_code` varchar(2) CHARACTER SET latin1 DEFAULT NULL,
  `patient_relation_name` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `patient_care_taker` int(11) DEFAULT NULL,
  `patient_care_taker_name` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `patient_dob` date DEFAULT NULL,
  `patient_gender` varchar(2) CHARACTER SET latin1 NOT NULL,
  `patient_marital_status` varchar(2) CHARACTER SET latin1 DEFAULT NULL,
  `patient_occupation` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `patient_blood_group` varchar(5) CHARACTER SET latin1 DEFAULT NULL,
  `patient_category_id` int(11) DEFAULT NULL,
  `patient_email` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `patient_reg_mode` varchar(2) CHARACTER SET latin1 NOT NULL,
  `patient_type` varchar(2) CHARACTER SET latin1 DEFAULT NULL,
  `patient_ref_hospital` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `patient_ref_id` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `patient_mobile` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `patient_bill_type` varchar(2) CHARACTER SET latin1 DEFAULT NULL,
  `patient_image` longblob,
  `status` enum('0','1') CHARACTER SET latin1 DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`patient_id`),
  UNIQUE KEY `PatientCasesheetUnique` (`casesheetno`,`tenant_id`),
  KEY `FK_pat_patient_tenant` (`tenant_id`),
  CONSTRAINT `FK_pat_patient_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;

/*Data for the table `pat_patient` */

insert  into `pat_patient`(`patient_id`,`patient_global_guid`,`patient_guid`,`casesheetno`,`patient_int_code`,`tenant_id`,`patient_reg_date`,`patient_title_code`,`patient_firstname`,`patient_lastname`,`patient_relation_code`,`patient_relation_name`,`patient_care_taker`,`patient_care_taker_name`,`patient_dob`,`patient_gender`,`patient_marital_status`,`patient_occupation`,`patient_blood_group`,`patient_category_id`,`patient_email`,`patient_reg_mode`,`patient_type`,`patient_ref_hospital`,`patient_ref_id`,`patient_mobile`,`patient_bill_type`,`patient_image`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (95,'b1253b5f-650e-5cf7-aa58-e295060f3a68','0c51d66a-388a-5818-b9b4-4b8f2bafc71e',NULL,'AH0000071',58,'2016-06-11 18:13:24','Mr.','Prakash','Arul Mani',NULL,NULL,NULL,NULL,'1991-06-11','M',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'9566699580',NULL,NULL,'1',51,'2016-06-11 18:13:24',51,'2016-06-11 18:13:24','0000-00-00 00:00:00'),(96,'ca72267d-2338-560c-89c2-8d0b56d25667','77f58f37-b928-5380-b689-f4f46ecbf1df',NULL,'AH0000072',58,'2016-06-11 18:16:20','Mr.','Nadesh','S',NULL,NULL,NULL,NULL,'1991-06-11','M',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'9789741406',NULL,NULL,'1',51,'2016-06-11 18:16:20',51,'2016-06-11 18:16:20','0000-00-00 00:00:00');

/*Table structure for table `pat_patient_address` */

DROP TABLE IF EXISTS `pat_patient_address`;

CREATE TABLE `pat_patient_address` (
  `addr_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `addr_current_address` text,
  `addr_country_id` int(11) DEFAULT NULL,
  `addr_state_id` int(11) DEFAULT NULL,
  `addr_city_id` int(11) DEFAULT NULL,
  `addr_zip` varchar(10) DEFAULT NULL,
  `addr_perm_address` text,
  `addr_perm_country_id` int(11) DEFAULT NULL,
  `addr_perm_state_id` int(11) DEFAULT NULL,
  `addr_perm_city_id` int(11) DEFAULT NULL,
  `addr_perm_zip` varchar(10) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`addr_id`),
  KEY `FK_pat_addr_address_patient` (`patient_id`),
  KEY `FK_pat_patient_address_country` (`addr_country_id`),
  KEY `FK_pat_patient_address_state` (`addr_state_id`),
  KEY `FK_pat_patient_address_city` (`addr_city_id`),
  KEY `FK_pat_patient_address_perm_country` (`addr_perm_country_id`),
  KEY `FK_pat_patient_address_perm_state` (`addr_perm_state_id`),
  KEY `FK_pat_patient_address_perm_city` (`addr_perm_city_id`),
  CONSTRAINT `FK_pat_addr_address_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_patient_address_city` FOREIGN KEY (`addr_city_id`) REFERENCES `co_master_city` (`city_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_patient_address_country` FOREIGN KEY (`addr_country_id`) REFERENCES `co_master_country` (`country_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_patient_address_perm_city` FOREIGN KEY (`addr_perm_city_id`) REFERENCES `co_master_city` (`city_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_patient_address_perm_country` FOREIGN KEY (`addr_perm_country_id`) REFERENCES `co_master_country` (`country_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_patient_address_perm_state` FOREIGN KEY (`addr_perm_state_id`) REFERENCES `co_master_state` (`state_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_patient_address_state` FOREIGN KEY (`addr_state_id`) REFERENCES `co_master_state` (`state_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pat_patient_address` */

/*Table structure for table `pat_patient_casesheet` */

DROP TABLE IF EXISTS `pat_patient_casesheet`;

CREATE TABLE `pat_patient_casesheet` (
  `casesheet_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `casesheet_no` varchar(50) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`casesheet_id`),
  UNIQUE KEY `PatPatientCasesheetUnique` (`tenant_id`,`patient_id`,`casesheet_no`),
  KEY `FK_pat_patient_casesheet_patient` (`patient_id`),
  CONSTRAINT `FK_pat_patient_casesheet_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_patient_casesheet_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `pat_patient_casesheet` */

insert  into `pat_patient_casesheet`(`casesheet_id`,`tenant_id`,`patient_id`,`casesheet_no`,`start_date`,`end_date`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (6,58,96,'1511','2016-06-11',NULL,'1',51,'2016-06-11 18:52:10',51,'2016-06-11 18:52:10','0000-00-00 00:00:00');

/*Table structure for table `pat_prescription` */

DROP TABLE IF EXISTS `pat_prescription`;

CREATE TABLE `pat_prescription` (
  `pres_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `pres_date` datetime NOT NULL,
  `consultant_id` int(11) NOT NULL,
  `number_of_days` smallint(6) DEFAULT NULL,
  `notes` text,
  `next_visit` date DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`pres_id`),
  KEY `FK_pat_prescription_tenant` (`tenant_id`),
  KEY `FK_pat_prescription_patient` (`patient_id`),
  KEY `FK_pat_prescription_encounter` (`encounter_id`),
  CONSTRAINT `FK_pat_prescription_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `pat_encounter` (`encounter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_prescription_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_prescription_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pat_prescription` */

/*Table structure for table `pat_prescription_favourite` */

DROP TABLE IF EXISTS `pat_prescription_favourite`;

CREATE TABLE `pat_prescription_favourite` (
  `pres_fav_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `generic_id` int(11) NOT NULL,
  `drug_class_id` int(11) NOT NULL,
  `consultant_id` int(11) NOT NULL,
  `pres_id` int(11) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`pres_fav_id`),
  KEY `FK_pat_prescription_favourite_tenant` (`tenant_id`),
  KEY `FK_pat_prescription_favourite_encounter` (`encounter_id`),
  KEY `FK_pat_prescription_favourite_product` (`product_id`),
  KEY `FK_pat_prescription_favourite_generic` (`generic_id`),
  KEY `FK_pat_prescription_favourite_drug_class` (`drug_class_id`),
  KEY `FK_pat_prescription_favourite_consultant` (`consultant_id`),
  KEY `FK_pat_prescription_favourite_prescription` (`pres_id`),
  CONSTRAINT `FK_pat_prescription_favourite_consultant` FOREIGN KEY (`consultant_id`) REFERENCES `co_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_prescription_favourite_drug_class` FOREIGN KEY (`drug_class_id`) REFERENCES `pha_drug_class` (`drug_class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_prescription_favourite_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `pat_encounter` (`encounter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_prescription_favourite_generic` FOREIGN KEY (`generic_id`) REFERENCES `pha_generic` (`generic_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_prescription_favourite_prescription` FOREIGN KEY (`pres_id`) REFERENCES `pat_prescription` (`pres_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_prescription_favourite_product` FOREIGN KEY (`product_id`) REFERENCES `pha_product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_prescription_favourite_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pat_prescription_favourite` */

/*Table structure for table `pat_prescription_frequency` */

DROP TABLE IF EXISTS `pat_prescription_frequency`;

CREATE TABLE `pat_prescription_frequency` (
  `freq_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `freq_name` varchar(20) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`freq_id`),
  KEY `FK_pat_prescription_frequency_tenant` (`tenant_id`),
  FULLTEXT KEY `FreqNameFulltext` (`freq_name`),
  CONSTRAINT `FK_pat_prescription_frequency_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `pat_prescription_frequency` */

insert  into `pat_prescription_frequency`(`freq_id`,`tenant_id`,`freq_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'2-9-6','1',51,'2016-04-02 16:28:04',51,'2016-04-02 16:28:04','0000-00-00 00:00:00'),(2,58,'4-8-6','1',51,'2016-04-02 16:34:53',51,'2016-04-02 16:34:53','0000-00-00 00:00:00'),(3,58,'2-5-1','1',51,'2016-04-02 17:30:34',51,'2016-04-02 17:30:34','0000-00-00 00:00:00'),(4,58,'1-5-4','1',51,'2016-04-02 17:34:11',51,'2016-04-02 17:34:11','0000-00-00 00:00:00'),(5,58,'1-1-1','1',51,'2016-04-04 10:30:35',51,'2016-04-04 10:30:35','0000-00-00 00:00:00'),(6,58,'1-5-1','1',51,'2016-04-19 16:08:42',51,'2016-04-19 16:08:42','0000-00-00 00:00:00'),(7,58,'1-1-5','1',51,'2016-04-23 15:52:10',51,'2016-04-23 15:52:10','0000-00-00 00:00:00');

/*Table structure for table `pat_prescription_items` */

DROP TABLE IF EXISTS `pat_prescription_items`;

CREATE TABLE `pat_prescription_items` (
  `pres_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `pres_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `generic_id` int(11) NOT NULL,
  `generic_name` varchar(255) NOT NULL,
  `drug_class_id` int(11) NOT NULL,
  `drug_name` varchar(255) NOT NULL,
  `route_id` int(11) NOT NULL,
  `freq_id` int(11) NOT NULL,
  `number_of_days` smallint(6) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`pres_item_id`),
  KEY `FK_pat_prescription_items_tenant` (`tenant_id`),
  KEY `FK_pat_prescription_items_pres` (`pres_id`),
  KEY `FK_pat_prescription_items_prodduct` (`product_id`),
  KEY `FK_pat_prescription_items_generic` (`generic_id`),
  KEY `FK_pat_prescription_items_drug_class` (`drug_class_id`),
  KEY `FK_pat_prescription_items_frequency` (`freq_id`),
  KEY `FK_pat_prescription_items_route` (`route_id`),
  CONSTRAINT `FK_pat_prescription_items_drug_class` FOREIGN KEY (`drug_class_id`) REFERENCES `pha_drug_class` (`drug_class_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_prescription_items_frequency` FOREIGN KEY (`freq_id`) REFERENCES `pat_prescription_frequency` (`freq_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_prescription_items_generic` FOREIGN KEY (`generic_id`) REFERENCES `pha_generic` (`generic_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_prescription_items_pres` FOREIGN KEY (`pres_id`) REFERENCES `pat_prescription` (`pres_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_prescription_items_prodduct` FOREIGN KEY (`product_id`) REFERENCES `pha_product` (`product_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_prescription_items_route` FOREIGN KEY (`route_id`) REFERENCES `pat_prescription_route` (`route_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_prescription_items_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pat_prescription_items` */

/*Table structure for table `pat_prescription_route` */

DROP TABLE IF EXISTS `pat_prescription_route`;

CREATE TABLE `pat_prescription_route` (
  `route_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `route_name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`route_id`),
  KEY `FK_pat_prescription_route_tenant` (`tenant_id`),
  FULLTEXT KEY `RouteNameFulltext` (`route_name`),
  CONSTRAINT `FK_pat_prescription_route_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `pat_prescription_route` */

insert  into `pat_prescription_route`(`route_id`,`tenant_id`,`route_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'oral','1',51,'2016-04-02 16:28:23',51,'2016-04-02 16:28:23','0000-00-00 00:00:00'),(2,58,'P/O','1',51,'2016-04-02 16:34:53',51,'2016-04-02 16:34:53','0000-00-00 00:00:00'),(3,58,'IV','1',51,'2016-04-02 17:30:34',51,'2016-04-02 17:30:34','0000-00-00 00:00:00'),(4,58,'Mouth','1',51,'2016-04-02 17:34:11',51,'2016-04-02 17:34:11','0000-00-00 00:00:00'),(5,58,'ARM','1',51,'2016-04-04 10:30:35',51,'2016-04-04 10:30:35','0000-00-00 00:00:00');

/*Table structure for table `pat_procedure` */

DROP TABLE IF EXISTS `pat_procedure`;

CREATE TABLE `pat_procedure` (
  `proc_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `charge_subcat_id` int(11) NOT NULL,
  `proc_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `proc_consultant_ids` text,
  `proc_description` text,
  `charge_amount` decimal(10,2) DEFAULT '0.00',
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`proc_id`),
  KEY `FK_pat_procedure_tenant` (`tenant_id`),
  KEY `FK_pat_procedure_encounter` (`encounter_id`),
  KEY `FK_pat_procedure_room_charge_subcategory` (`charge_subcat_id`),
  KEY `FK_pat_procedure_patient` (`patient_id`),
  CONSTRAINT `FK_pat_procedure_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `pat_encounter` (`encounter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_procedure_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_procedure_room_charge_subcategory` FOREIGN KEY (`charge_subcat_id`) REFERENCES `co_room_charge_subcategory` (`charge_subcat_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_procedure_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `pat_procedure` */

/*Table structure for table `pat_timeline` */

DROP TABLE IF EXISTS `pat_timeline`;

CREATE TABLE `pat_timeline` (
  `timeline_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `date_time` datetime NOT NULL,
  `header` varchar(100) NOT NULL,
  `header_sub` varchar(100) DEFAULT NULL,
  `message` longtext NOT NULL,
  `ip_adderss` varchar(50) DEFAULT NULL,
  `resource` varchar(50) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`timeline_id`),
  KEY `FK_pat_timeline_tenant` (`tenant_id`),
  KEY `FK_pat_timeline_patient` (`patient_id`),
  CONSTRAINT `FK_pat_timeline_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_timeline_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=482 DEFAULT CHARSET=latin1;

/*Data for the table `pat_timeline` */

insert  into `pat_timeline`(`timeline_id`,`tenant_id`,`patient_id`,`date_time`,`header`,`header_sub`,`message`,`ip_adderss`,`resource`,`encounter_id`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (478,58,95,'2016-06-11 18:13:24','Patient Registration','','Mr. Prakash Registered Successfully.','127.0.0.1','BASIC',NULL,'1',51,'2016-06-11 18:13:25',51,'2016-06-11 18:13:25','0000-00-00 00:00:00'),(479,58,96,'2016-06-11 18:16:20','Patient Registration','','Mr. Nadesh Registered Successfully.','127.0.0.1','BASIC',NULL,'1',51,'2016-06-11 18:16:21',51,'2016-06-11 18:16:21','0000-00-00 00:00:00'),(480,58,96,'2016-06-11 18:52:10','Casesheet No.','','Casesheet No.: 1511 Added.','127.0.0.1','BASIC',NULL,'1',51,'2016-06-11 18:52:10',51,'2016-06-11 18:52:10','0000-00-00 00:00:00'),(481,58,96,'2016-06-11 18:51:58','Patient Admission','Encounter # 20','Patient Admitted. <br /> Bed No: <b>2112 (Non AC)</b>','127.0.0.1','ENCOUNTER',20,'1',51,'2016-06-11 18:52:10',51,'2016-06-11 18:52:10','0000-00-00 00:00:00');

/*Table structure for table `pat_vitals` */

DROP TABLE IF EXISTS `pat_vitals`;

CREATE TABLE `pat_vitals` (
  `vital_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `vital_time` datetime NOT NULL,
  `temperature` varchar(20) DEFAULT NULL,
  `blood_pressure` varchar(20) DEFAULT NULL,
  `pulse_rate` varchar(20) DEFAULT NULL,
  `weight` varchar(10) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`vital_id`),
  KEY `FK_pat_vitals_tenant` (`tenant_id`),
  KEY `FK_pat_vitals_encounter` (`encounter_id`),
  KEY `FK_pat_vitals_patient` (`patient_id`),
  CONSTRAINT `FK_pat_vitals_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `pat_encounter` (`encounter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_vitals_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_vitals_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pat_vitals` */

/*Table structure for table `pat_vitals_users` */

DROP TABLE IF EXISTS `pat_vitals_users`;

CREATE TABLE `pat_vitals_users` (
  `vital_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `vital_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `seen` enum('0','1') NOT NULL DEFAULT '0',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`vital_user_id`),
  KEY `FK_pat_vitals_users_user` (`user_id`),
  KEY `FK_pat_vitals_users_vitals` (`vital_id`),
  KEY `FK_pat_vitals_users_tenant` (`tenant_id`),
  CONSTRAINT `FK_pat_vitals_users_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_vitals_users_user` FOREIGN KEY (`user_id`) REFERENCES `co_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_vitals_users_vitals` FOREIGN KEY (`vital_id`) REFERENCES `pat_vitals` (`vital_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pat_vitals_users` */

/*Table structure for table `pha_brand` */

DROP TABLE IF EXISTS `pha_brand`;

CREATE TABLE `pha_brand` (
  `brand_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `brand_name` varchar(255) NOT NULL,
  `brand_code` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`brand_id`),
  UNIQUE KEY `PhaBrandUnique` (`tenant_id`,`brand_name`,`brand_code`,`deleted_at`),
  CONSTRAINT `FK_pha_brand_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `pha_brand` */

insert  into `pha_brand`(`brand_id`,`tenant_id`,`brand_name`,`brand_code`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'Brand','0001','1',51,'2016-03-07 15:25:23',51,'2016-03-07 15:25:23','0000-00-00 00:00:00'),(2,58,'New Brand','01841','1',51,'2016-03-16 16:09:06',51,'2016-03-16 16:09:06','0000-00-00 00:00:00');

/*Table structure for table `pha_brand_division` */

DROP TABLE IF EXISTS `pha_brand_division`;

CREATE TABLE `pha_brand_division` (
  `division_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `division_name` varchar(255) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`division_id`),
  UNIQUE KEY `PhaBrandDivisionUnique` (`tenant_id`,`division_name`,`deleted_at`),
  CONSTRAINT `FK_pha_brand_division_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `pha_brand_division` */

insert  into `pha_brand_division`(`division_id`,`tenant_id`,`division_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'Division','1',51,'2016-03-07 15:25:35',51,'2016-03-07 15:25:35','0000-00-00 00:00:00'),(2,58,'New Division','1',51,'2016-03-16 16:13:15',51,'2016-03-16 16:13:15','0000-00-00 00:00:00');

/*Table structure for table `pha_brand_representative` */

DROP TABLE IF EXISTS `pha_brand_representative`;

CREATE TABLE `pha_brand_representative` (
  `rep_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `division_id` int(11) NOT NULL,
  `rep_1_name` varchar(50) NOT NULL,
  `rep_1_contact` varchar(100) NOT NULL,
  `rep_1_designation` varchar(100) NOT NULL,
  `rep_2_name` varchar(50) DEFAULT NULL,
  `rep_2_contact` varchar(100) DEFAULT NULL,
  `rep_2_designation` varchar(100) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`rep_id`),
  KEY `FK_pha_brand_representative_tenant` (`tenant_id`),
  KEY `FK_pha_brand_representative_division` (`division_id`),
  KEY `FK_pha_brand_representative` (`brand_id`),
  CONSTRAINT `FK_pha_brand_representative` FOREIGN KEY (`brand_id`) REFERENCES `pha_brand` (`brand_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_brand_representative_division` FOREIGN KEY (`division_id`) REFERENCES `pha_brand_division` (`division_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_brand_representative_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pha_brand_representative` */

/*Table structure for table `pha_drug_class` */

DROP TABLE IF EXISTS `pha_drug_class`;

CREATE TABLE `pha_drug_class` (
  `drug_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `drug_name` varchar(255) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`drug_class_id`),
  UNIQUE KEY `PhadrugUnique` (`tenant_id`,`drug_name`,`deleted_at`),
  FULLTEXT KEY `DrugNameFulltext` (`drug_name`),
  CONSTRAINT `FK_pha_drug_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `pha_drug_class` */

insert  into `pha_drug_class`(`drug_class_id`,`tenant_id`,`drug_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'CALCIUM WITH VITAMINS','1',51,'2016-03-03 15:10:20',51,'2016-03-03 15:10:28','0000-00-00 00:00:00'),(2,58,'ANTIPSYCHOTICS','1',51,'2016-03-04 15:11:48',51,'2016-03-04 16:56:57','0000-00-00 00:00:00');

/*Table structure for table `pha_drug_generic` */

DROP TABLE IF EXISTS `pha_drug_generic`;

CREATE TABLE `pha_drug_generic` (
  `drug_generic_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `drug_class_id` int(11) NOT NULL,
  `generic_id` int(11) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`drug_generic_id`),
  UNIQUE KEY `PhaDrugClassGenericUnique` (`tenant_id`,`generic_id`,`deleted_at`),
  KEY `FK_pha_drug_generic_drug` (`drug_class_id`),
  KEY `FK_pha_drug_generic_generic` (`generic_id`),
  CONSTRAINT `FK_pha_drug_generic_drug` FOREIGN KEY (`drug_class_id`) REFERENCES `pha_drug_class` (`drug_class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_drug_generic_generic` FOREIGN KEY (`generic_id`) REFERENCES `pha_generic` (`generic_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_drug_generic_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;

/*Data for the table `pha_drug_generic` */

insert  into `pha_drug_generic`(`drug_generic_id`,`tenant_id`,`drug_class_id`,`generic_id`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (40,58,1,2,'1',51,'2016-03-04 19:48:30',51,'2016-03-04 19:48:30','0000-00-00 00:00:00'),(41,58,1,1,'1',51,'2016-03-04 19:48:39',51,'2016-03-04 19:48:39','0000-00-00 00:00:00');

/*Table structure for table `pha_generic` */

DROP TABLE IF EXISTS `pha_generic`;

CREATE TABLE `pha_generic` (
  `generic_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `generic_name` varchar(255) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`generic_id`),
  UNIQUE KEY `PhaBrandgenericUnique` (`tenant_id`,`generic_name`,`deleted_at`),
  FULLTEXT KEY `GenericNameFulltext` (`generic_name`),
  CONSTRAINT `FK_pha_brand_generic_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `pha_generic` */

insert  into `pha_generic`(`generic_id`,`tenant_id`,`generic_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'IRON FOLIC ACID VITAMIN B & ZINC','1',51,'2016-03-03 18:20:16',51,'2016-03-03 18:20:16','0000-00-00 00:00:00'),(2,58,'ACAMPROSATECALCIUM','1',51,'2016-03-04 13:48:40',51,'2016-03-04 13:48:40','0000-00-00 00:00:00'),(3,58,'S-ADENOSYL METHIONINE','1',51,'2016-03-16 16:31:27',51,'2016-03-16 16:31:27','0000-00-00 00:00:00'),(4,58,'MEMANTINE HYDROCHLORIDE','1',51,'2016-03-16 16:33:34',51,'2016-03-16 16:33:34','0000-00-00 00:00:00');

/*Table structure for table `pha_package_unit` */

DROP TABLE IF EXISTS `pha_package_unit`;

CREATE TABLE `pha_package_unit` (
  `package_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `package_name` varchar(255) NOT NULL,
  `package_unit` varchar(100) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`package_id`),
  UNIQUE KEY `PhapackageUnique` (`tenant_id`,`package_name`,`package_unit`,`deleted_at`),
  CONSTRAINT `FK_pha_package_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `pha_package_unit` */

insert  into `pha_package_unit`(`package_id`,`tenant_id`,`package_name`,`package_unit`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'10s','10','1',51,'2016-03-07 15:26:15',51,'2016-03-07 15:26:15','0000-00-00 00:00:00'),(2,58,'Paking','10','1',51,'2016-03-16 16:56:01',51,'2016-03-16 16:56:01','0000-00-00 00:00:00'),(3,58,'Packing','1','1',51,'2016-03-16 16:56:56',51,'2016-03-16 16:56:56','0000-00-00 00:00:00'),(4,58,'Unit','5','1',51,'2016-03-16 16:57:33',51,'2016-03-16 16:57:33','0000-00-00 00:00:00'),(5,58,'Sale Unit','10','1',51,'2016-03-16 16:57:43',51,'2016-03-16 16:57:43','0000-00-00 00:00:00');

/*Table structure for table `pha_product` */

DROP TABLE IF EXISTS `pha_product`;

CREATE TABLE `pha_product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `product_code` varchar(50) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_unit` varchar(25) NOT NULL,
  `product_unit_count` varchar(25) NOT NULL,
  `product_description_id` int(11) NOT NULL,
  `product_reorder_min` smallint(6) NOT NULL,
  `product_reorder_max` smallint(6) NOT NULL,
  `product_price` decimal(10,2) NOT NULL,
  `product_location` varchar(255) DEFAULT NULL,
  `brand_id` int(11) NOT NULL,
  `division_id` int(11) NOT NULL,
  `generic_id` int(11) NOT NULL,
  `drug_class_id` int(11) DEFAULT NULL,
  `purchase_vat_id` int(11) NOT NULL,
  `purchase_package_id` int(11) NOT NULL,
  `sales_vat_id` int(11) NOT NULL,
  `sales_package_id` int(11) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `supplier_id_1` int(11) DEFAULT NULL,
  `supplier_id_2` int(11) DEFAULT NULL,
  `supplier_id_3` int(11) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `PhaProductUnique` (`tenant_id`,`product_name`),
  KEY `FK_pha_product_description` (`product_description_id`),
  KEY `FK_pha_product_brand` (`brand_id`),
  KEY `FK_pha_product_division` (`division_id`),
  KEY `FK_pha_product_generic` (`generic_id`),
  KEY `FK_pha_product_purchase_vat` (`purchase_vat_id`),
  KEY `FK_pha_product_sales_vat` (`sales_vat_id`),
  KEY `FK_pha_product_purchase_packing_unit` (`purchase_package_id`),
  KEY `FK_pha_product_sales_packing_unit` (`sales_package_id`),
  FULLTEXT KEY `ProductNameFulltext` (`product_name`),
  FULLTEXT KEY `ProductUnitFulltext` (`product_unit`),
  FULLTEXT KEY `ProductUnitCountFulltext` (`product_unit_count`),
  CONSTRAINT `FK_pha_product_brand` FOREIGN KEY (`brand_id`) REFERENCES `pha_brand` (`brand_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_description` FOREIGN KEY (`product_description_id`) REFERENCES `pha_product_description` (`description_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_division` FOREIGN KEY (`division_id`) REFERENCES `pha_brand_division` (`division_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_generic` FOREIGN KEY (`generic_id`) REFERENCES `pha_generic` (`generic_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_purchase_packing_unit` FOREIGN KEY (`purchase_package_id`) REFERENCES `pha_package_unit` (`package_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_purchase_vat` FOREIGN KEY (`purchase_vat_id`) REFERENCES `pha_vat` (`vat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_sales_packing_unit` FOREIGN KEY (`sales_package_id`) REFERENCES `pha_package_unit` (`package_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_sales_vat` FOREIGN KEY (`sales_vat_id`) REFERENCES `pha_vat` (`vat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `pha_product` */

insert  into `pha_product`(`product_id`,`tenant_id`,`product_code`,`product_name`,`product_unit`,`product_unit_count`,`product_description_id`,`product_reorder_min`,`product_reorder_max`,`product_price`,`product_location`,`brand_id`,`division_id`,`generic_id`,`drug_class_id`,`purchase_vat_id`,`purchase_package_id`,`sales_vat_id`,`sales_package_id`,`status`,`supplier_id_1`,`supplier_id_2`,`supplier_id_3`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'A00001','ABDIFER','MG','1',1,50,0,'50.00',NULL,1,1,1,NULL,1,1,1,1,'1',NULL,NULL,NULL,1,'2016-03-07 15:26:33',51,'2016-03-31 16:57:15','0000-00-00 00:00:00'),(2,58,'VGGU2V','ADESAM','MG','2',1,50,0,'60.00',NULL,1,1,1,1,2,1,2,1,'1',NULL,NULL,NULL,51,'2016-03-09 17:49:04',51,'2016-03-09 17:49:04','0000-00-00 00:00:00'),(3,58,'NGVS0O','ALZIL','MG','10',1,50,0,'0.00',NULL,1,1,1,1,1,1,1,1,'1',NULL,NULL,NULL,51,'2016-03-30 16:20:00',51,'2016-03-30 16:20:00','0000-00-00 00:00:00'),(4,58,'LHCGO9','ATTENTROL','MG','1',1,50,0,'0.00',NULL,1,1,1,1,1,1,1,1,'1',NULL,NULL,NULL,51,'2016-04-21 18:25:00',51,'2016-04-21 18:25:00','0000-00-00 00:00:00');

/*Table structure for table `pha_product_batch` */

DROP TABLE IF EXISTS `pha_product_batch`;

CREATE TABLE `pha_product_batch` (
  `batch_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `batch_no` varchar(255) NOT NULL,
  `expiry_date` date NOT NULL,
  `total_qty` int(11) NOT NULL,
  `available_qty` int(11) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`batch_id`),
  KEY `FK_pha_product_batch_tenant` (`tenant_id`),
  KEY `FK_pha_product_batch_product` (`product_id`),
  CONSTRAINT `FK_pha_product_batch_product` FOREIGN KEY (`product_id`) REFERENCES `pha_product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_batch_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

/*Data for the table `pha_product_batch` */

insert  into `pha_product_batch`(`batch_id`,`tenant_id`,`product_id`,`batch_no`,`expiry_date`,`total_qty`,`available_qty`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (31,58,1,'20015','2016-05-01',264,17,'1',51,'2016-03-10 14:01:01',51,'2016-05-30 11:05:29','0000-00-00 00:00:00'),(32,58,2,'2000','2016-03-01',50,-3,'1',51,'2016-03-10 14:01:02',51,'2016-05-30 10:59:59','0000-00-00 00:00:00'),(33,58,1,'2000','2016-09-01',18,-55,'1',51,'2016-03-10 14:01:26',51,'2016-05-24 14:02:38','0000-00-00 00:00:00'),(34,58,2,'1510','2016-11-01',10,-15,'1',51,'2016-03-11 13:08:10',51,'2016-05-24 13:00:36','0000-00-00 00:00:00'),(35,58,3,'1000','2016-08-01',40,-358,'1',51,'2016-03-31 16:00:45',51,'2016-05-30 11:05:30','0000-00-00 00:00:00');

/*Table structure for table `pha_product_batch_rate` */

DROP TABLE IF EXISTS `pha_product_batch_rate`;

CREATE TABLE `pha_product_batch_rate` (
  `batch_rate_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `batch_id` int(11) NOT NULL,
  `mrp` decimal(10,2) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`batch_rate_id`),
  KEY `FK_pha_product_batch_rate_tenant` (`tenant_id`),
  KEY `FK_pha_product_batch_rate_batch` (`batch_id`),
  CONSTRAINT `FK_pha_product_batch_rate_batch` FOREIGN KEY (`batch_id`) REFERENCES `pha_product_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_batch_rate_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

/*Data for the table `pha_product_batch_rate` */

insert  into `pha_product_batch_rate`(`batch_rate_id`,`tenant_id`,`batch_id`,`mrp`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (29,58,31,'14000.00','1',51,'2016-03-10 14:01:02',51,'2016-04-16 13:33:45','0000-00-00 00:00:00'),(30,58,32,'960.00','1',51,'2016-03-10 14:01:02',51,'2016-03-11 16:32:52','0000-00-00 00:00:00'),(31,58,33,'100.00','1',51,'2016-03-10 14:01:26',51,'2016-04-16 13:31:44','0000-00-00 00:00:00'),(32,58,34,'150.00','1',51,'2016-03-11 13:08:10',51,'2016-03-11 13:08:10','0000-00-00 00:00:00'),(33,58,35,'10.00','1',51,'2016-03-31 16:00:45',51,'2016-03-31 16:01:22','0000-00-00 00:00:00');

/*Table structure for table `pha_product_description` */

DROP TABLE IF EXISTS `pha_product_description`;

CREATE TABLE `pha_product_description` (
  `description_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `description_name` varchar(255) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`description_id`),
  UNIQUE KEY `PhadescriptionUnique` (`tenant_id`,`description_name`,`deleted_at`),
  CONSTRAINT `FK_pha_description_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `pha_product_description` */

insert  into `pha_product_description`(`description_id`,`tenant_id`,`description_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'Tablet','1',51,'2016-03-07 15:25:04',51,'2016-03-07 15:25:04','0000-00-00 00:00:00'),(2,58,'New Tablet','1',51,'2016-03-16 15:32:08',51,'2016-03-16 15:32:08','0000-00-00 00:00:00'),(3,58,'New wwee','1',51,'2016-03-16 15:35:25',51,'2016-03-16 15:35:25','0000-00-00 00:00:00'),(4,58,'New Product DESC','1',51,'2016-03-16 15:35:57',51,'2016-03-16 15:35:57','0000-00-00 00:00:00'),(5,58,'Again New','1',51,'2016-03-16 15:38:23',51,'2016-03-16 15:38:23','0000-00-00 00:00:00'),(6,58,'New neeee','1',51,'2016-03-16 15:42:29',51,'2016-03-16 15:42:29','0000-00-00 00:00:00');

/*Table structure for table `pha_purchase` */

DROP TABLE IF EXISTS `pha_purchase`;

CREATE TABLE `pha_purchase` (
  `purchase_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `purchase_code` varchar(50) NOT NULL,
  `invoice_date` date NOT NULL,
  `invoice_no` varchar(50) NOT NULL,
  `payment_type` enum('CA','CR') NOT NULL DEFAULT 'CA' COMMENT 'CA -> Cash, CR -> Credit',
  `supplier_id` int(11) NOT NULL,
  `total_item_purchase_amount` decimal(10,2) DEFAULT NULL,
  `total_item_vat_amount` decimal(10,2) DEFAULT NULL,
  `total_item_discount_amount` decimal(10,2) DEFAULT NULL,
  `before_disc_amount` decimal(10,2) DEFAULT NULL,
  `discount_percent` decimal(10,2) DEFAULT NULL,
  `discount_amount` decimal(10,2) DEFAULT NULL,
  `after_disc_amount` decimal(10,2) DEFAULT NULL,
  `roundoff_amount` decimal(10,2) DEFAULT NULL,
  `net_amount` decimal(10,2) DEFAULT NULL COMMENT '(Total Amount - Discount Amount) +- RoundOff',
  `gr_num` varchar(50) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`purchase_id`),
  UNIQUE KEY `PhaPurchaseInvoiceUnique` (`tenant_id`,`invoice_no`),
  KEY `FK_pha_purchase_tenant` (`tenant_id`),
  KEY `FK_pha_purchase_supplier` (`supplier_id`),
  CONSTRAINT `FK_pha_purchase_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `pha_supplier` (`supplier_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_purchase_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

/*Data for the table `pha_purchase` */

insert  into `pha_purchase`(`purchase_id`,`tenant_id`,`purchase_code`,`invoice_date`,`invoice_no`,`payment_type`,`supplier_id`,`total_item_purchase_amount`,`total_item_vat_amount`,`total_item_discount_amount`,`before_disc_amount`,`discount_percent`,`discount_amount`,`after_disc_amount`,`roundoff_amount`,`net_amount`,`gr_num`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (36,58,'AH0000017','2016-03-10','1000','CR',1,'1900.00','100.00','100.00','2000.00',NULL,'0.00','2000.00','0.00','2000.00',NULL,'1',51,'2016-03-10 14:01:01',51,'2016-03-10 17:07:38','0000-00-00 00:00:00'),(37,58,'AH0000018','2016-03-11','10020','CR',1,'1917.00','308.85','213.00','2225.85','10.00','191.70','2034.15','0.15','2034.00',NULL,'1',51,'2016-03-11 13:08:10',51,'2016-03-11 13:08:10','0000-00-00 00:00:00'),(38,58,'AH0000019','2016-03-31','0151','CA',1,'90.00','5.00','10.00','95.00',NULL,'0.00','95.00','0.00','95.00',NULL,'1',51,'2016-03-31 16:00:45',51,'2016-03-31 16:01:22','0000-00-00 00:00:00');

/*Table structure for table `pha_purchase_item` */

DROP TABLE IF EXISTS `pha_purchase_item`;

CREATE TABLE `pha_purchase_item` (
  `purchase_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `purchase_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `batch_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `free_quantity` int(11) DEFAULT '0',
  `free_quantity_unit` int(11) DEFAULT '0',
  `mrp` decimal(10,2) NOT NULL,
  `purchase_rate` decimal(10,2) NOT NULL,
  `purchase_amount` decimal(10,2) NOT NULL COMMENT 'Qty * Purchase Rate',
  `discount_percent` decimal(10,2) DEFAULT '0.00',
  `discount_amount` decimal(10,2) DEFAULT '0.00',
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '(Purchase Amount - Discount Amount)',
  `package_name` varchar(255) NOT NULL,
  `vat_amount` decimal(10,2) NOT NULL,
  `vat_percent` decimal(10,2) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`purchase_item_id`),
  KEY `FK_pha_purchase_item_tenant` (`tenant_id`),
  KEY `FK_pha_purchase_item_purchase` (`purchase_id`),
  KEY `FK_pha_purchase_item_product` (`product_id`),
  KEY `FK_pha_purchase_item_batch` (`batch_id`),
  CONSTRAINT `FK_pha_purchase_item_batch` FOREIGN KEY (`batch_id`) REFERENCES `pha_product_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_purchase_item_product` FOREIGN KEY (`product_id`) REFERENCES `pha_product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_purchase_item_purchase` FOREIGN KEY (`purchase_id`) REFERENCES `pha_purchase` (`purchase_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_purchase_item_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

/*Data for the table `pha_purchase_item` */

insert  into `pha_purchase_item`(`purchase_item_id`,`tenant_id`,`purchase_id`,`product_id`,`batch_id`,`quantity`,`free_quantity`,`free_quantity_unit`,`mrp`,`purchase_rate`,`purchase_amount`,`discount_percent`,`discount_amount`,`total_amount`,`package_name`,`vat_amount`,`vat_percent`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (45,58,36,1,31,10,10,0,'100.00','100.00','1000.00','0.00','0.00','1000.00','10s','50.00','5.00','1',51,'2016-03-10 14:01:02',51,'2016-03-10 17:07:38','0000-00-00 00:00:00'),(47,58,36,1,33,10,10,0,'100.00','100.00','1000.00','10.00','100.00','900.00','10s','50.00','5.00','1',51,'2016-03-10 14:01:26',51,'2016-03-10 17:07:38','0000-00-00 00:00:00'),(48,58,37,2,34,15,0,0,'150.00','142.00','2130.00','10.00','213.00','1917.00','10s','308.85','14.50','1',51,'2016-03-11 13:08:10',51,'2016-03-11 13:08:10','0000-00-00 00:00:00'),(49,58,38,3,35,10,25,0,'10.00','10.00','100.00','10.00','10.00','90.00','10s','5.00','5.00','1',51,'2016-03-31 16:00:45',51,'2016-03-31 16:01:22','0000-00-00 00:00:00');

/*Table structure for table `pha_purchase_return` */

DROP TABLE IF EXISTS `pha_purchase_return`;

CREATE TABLE `pha_purchase_return` (
  `purchase_ret_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `purchase_ret_code` varchar(50) NOT NULL,
  `invoice_date` date NOT NULL,
  `invoice_no` varchar(50) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `total_item_purchase_ret_amount` decimal(10,2) DEFAULT NULL,
  `total_item_vat_amount` decimal(10,2) DEFAULT NULL,
  `total_item_discount_amount` decimal(10,2) DEFAULT NULL,
  `before_disc_amount` decimal(10,2) DEFAULT NULL,
  `discount_percent` decimal(10,2) DEFAULT '0.00',
  `discount_amount` decimal(10,2) DEFAULT '0.00',
  `after_disc_amount` decimal(10,2) DEFAULT NULL,
  `roundoff_amount` decimal(10,2) DEFAULT NULL,
  `net_amount` decimal(10,2) DEFAULT NULL COMMENT '(Total Amount - Discount Amount) +- RoundOff',
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`purchase_ret_id`),
  KEY `FK_pha_purchase_ret_tenant` (`tenant_id`),
  KEY `FK_pha_purchase_ret_supplier` (`supplier_id`),
  CONSTRAINT `FK_pha_purchase_ret_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `pha_supplier` (`supplier_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_purchase_ret_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

/*Data for the table `pha_purchase_return` */

insert  into `pha_purchase_return`(`purchase_ret_id`,`tenant_id`,`purchase_ret_code`,`invoice_date`,`invoice_no`,`supplier_id`,`total_item_purchase_ret_amount`,`total_item_vat_amount`,`total_item_discount_amount`,`before_disc_amount`,`discount_percent`,`discount_amount`,`after_disc_amount`,`roundoff_amount`,`net_amount`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (43,58,'PR0000003','2016-03-11','15411',1,'5650.00','752.50','850.00','6402.50',NULL,'0.00','6402.50','0.50','6403.00','1',51,'2016-03-11 13:38:45',51,'2016-03-11 15:14:39','0000-00-00 00:00:00'),(44,58,'PR0000004','2016-03-11','15411',1,'900.00','50.00','100.00','950.00','0.00','0.00','950.00','0.00','950.00','1',51,'2016-03-11 15:15:03',51,'2016-03-11 15:15:03','0000-00-00 00:00:00');

/*Table structure for table `pha_purchase_return_item` */

DROP TABLE IF EXISTS `pha_purchase_return_item`;

CREATE TABLE `pha_purchase_return_item` (
  `purchase_ret_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `purchase_ret_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `batch_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `free_quantity` int(11) DEFAULT '0',
  `free_quantity_unit` int(11) DEFAULT '0',
  `mrp` decimal(10,2) NOT NULL,
  `purchase_ret_rate` decimal(10,2) NOT NULL,
  `purchase_ret_amount` decimal(10,2) NOT NULL COMMENT 'Qty * Purchase Rate',
  `discount_percent` decimal(10,2) DEFAULT '0.00',
  `discount_amount` decimal(10,2) DEFAULT '0.00',
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '(Purchase Amount - Discount Amount)',
  `package_name` varchar(255) NOT NULL,
  `vat_amount` decimal(10,2) NOT NULL,
  `vat_percent` decimal(10,2) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`purchase_ret_item_id`),
  KEY `FK_pha_purchase_ret_item_tenant` (`tenant_id`),
  KEY `FK_pha_purchase_ret_item_purchase` (`purchase_ret_id`),
  KEY `FK_pha_purchase_ret_item_product` (`product_id`),
  KEY `FK_pha_purchase_ret_item_batch` (`batch_id`),
  CONSTRAINT `FK_pha_purchase_ret_item_batch` FOREIGN KEY (`batch_id`) REFERENCES `pha_product_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_purchase_ret_item_product` FOREIGN KEY (`product_id`) REFERENCES `pha_product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_purchase_ret_item_purchase` FOREIGN KEY (`purchase_ret_id`) REFERENCES `pha_purchase_return` (`purchase_ret_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_purchase_ret_item_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;

/*Data for the table `pha_purchase_return_item` */

insert  into `pha_purchase_return_item`(`purchase_ret_item_id`,`tenant_id`,`purchase_ret_id`,`product_id`,`batch_id`,`quantity`,`free_quantity`,`free_quantity_unit`,`mrp`,`purchase_ret_rate`,`purchase_ret_amount`,`discount_percent`,`discount_amount`,`total_amount`,`package_name`,`vat_amount`,`vat_percent`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (61,58,43,2,34,30,0,0,'150.00','150.00','4500.00','10.00','450.00','4050.00','10s','652.50','14.50','1',51,'2016-03-11 13:38:45',51,'2016-03-11 15:14:39','0000-00-00 00:00:00'),(62,58,43,1,31,20,0,0,'100.00','100.00','2000.00','20.00','400.00','1600.00','10s','100.00','5.00','1',51,'2016-03-11 13:38:45',51,'2016-03-11 15:14:39','0000-00-00 00:00:00'),(63,58,44,1,31,10,0,0,'100.00','100.00','1000.00','10.00','100.00','900.00','10s','50.00','5.00','1',51,'2016-03-11 15:15:03',51,'2016-03-11 15:15:03','0000-00-00 00:00:00');

/*Table structure for table `pha_sale` */

DROP TABLE IF EXISTS `pha_sale`;

CREATE TABLE `pha_sale` (
  `sale_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `bill_no` varchar(50) NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `mobile_no` varchar(50) DEFAULT NULL,
  `consultant_id` int(11) NOT NULL,
  `sale_date` date NOT NULL,
  `payment_type` enum('CA','CR','COD') NOT NULL DEFAULT 'CA' COMMENT 'CA - Cash, CR - Credit, COD - Cash On delivery',
  `total_item_vat_amount` decimal(10,2) DEFAULT NULL,
  `total_item_sale_amount` decimal(10,2) DEFAULT NULL,
  `total_item_discount_percent` decimal(10,2) DEFAULT NULL,
  `total_item_discount_amount` decimal(10,2) DEFAULT NULL COMMENT 'total_item_sale_amount * discount_percent',
  `total_item_amount` decimal(10,2) DEFAULT NULL COMMENT 'total_item_vat_amount + total_item_sale_amount - discount_amount',
  `welfare_amount` decimal(10,2) DEFAULT NULL,
  `roundoff_amount` decimal(10,2) DEFAULT NULL,
  `bill_amount` decimal(10,2) DEFAULT NULL COMMENT 'total_item_amount + welfare + roundoff',
  `payment_status` enum('P','C','PC') NOT NULL DEFAULT 'C' COMMENT 'P - Pending, C- Completed, PC - Partialy Completed',
  `encounter_id` int(11) DEFAULT NULL,
  `patient_name` varchar(50) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`sale_id`),
  KEY `FK_pha_sale_tenant` (`tenant_id`),
  KEY `FK_pha_sale_patient` (`patient_id`),
  KEY `FK_pha_sale_consultant` (`consultant_id`),
  CONSTRAINT `FK_pha_sale_consultant` FOREIGN KEY (`consultant_id`) REFERENCES `co_user` (`user_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_sale_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

/*Data for the table `pha_sale` */

insert  into `pha_sale`(`sale_id`,`tenant_id`,`bill_no`,`patient_id`,`mobile_no`,`consultant_id`,`sale_date`,`payment_type`,`total_item_vat_amount`,`total_item_sale_amount`,`total_item_discount_percent`,`total_item_discount_amount`,`total_item_amount`,`welfare_amount`,`roundoff_amount`,`bill_amount`,`payment_status`,`encounter_id`,`patient_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (30,58,'AH0000036',19,'9898989898',54,'2016-05-23','CR','5.00','100.00',NULL,'0.00','105.00',NULL,'0.00','105.00','C',163,'Gayatri','1',51,'2016-05-23 17:04:18',51,'2016-05-23 17:21:06','0000-00-00 00:00:00'),(31,58,'AH0000037',19,'9898989898',54,'2016-05-23','CR','696.00','4800.00',NULL,'0.00','5496.00',NULL,'0.00','5496.00','C',163,'Gayatri','1',51,'2016-05-23 17:04:36',51,'2016-05-23 17:21:06','0000-00-00 00:00:00'),(32,58,'AH0000038',39,'9566695006',54,'2016-05-23','CR','0.00','14000.00',NULL,'0.00','14000.00',NULL,'0.00','14000.00','PC',172,'Prakash Arul Mani','1',51,'2016-05-23 17:24:27',51,'2016-05-30 11:15:29','0000-00-00 00:00:00'),(33,58,'AH0000039',39,'9566695006',54,'2016-05-23','CA','278.40','1920.00',NULL,'0.00','2198.40',NULL,'0.40','2198.00','C',172,'Prakash Arul Mani','1',51,'2016-05-23 17:24:38',51,'2016-05-23 17:24:38','0000-00-00 00:00:00'),(34,58,'AH0000040',39,'9566695006',54,'2016-05-23','CR','0.00','10.00',NULL,'0.00','10.00',NULL,'0.00','10.00','C',148,'Prakash Arul Mani','1',51,'2016-05-23 17:25:21',51,'2016-05-23 17:27:40','0000-00-00 00:00:00'),(35,58,'AH0000041',39,'9566695006',54,'2016-05-23','CR','696.00','4800.00',NULL,'0.00','5496.00',NULL,'0.00','5496.00','C',148,'Prakash Arul Mani','1',51,'2016-05-23 17:25:32',51,'2016-05-23 17:28:25','0000-00-00 00:00:00'),(36,58,'AH0000042',NULL,NULL,54,'2016-05-23','COD','0.50','10.00',NULL,'0.00','10.50',NULL,'0.50','11.00','P',NULL,'aaaaa','1',51,'2016-05-23 17:59:20',51,'2016-05-23 17:59:20','0000-00-00 00:00:00'),(37,58,'AH0000043',NULL,NULL,56,'2016-05-23','CA','5.00','100.00',NULL,'0.00','105.00',NULL,'0.00','105.00','C',NULL,NULL,'1',51,'2016-05-23 18:28:49',51,'2016-05-23 18:28:50','0000-00-00 00:00:00'),(38,58,'AH0000044',34,'9865565668',54,'2016-05-23','CA','844.20','15060.00',NULL,'0.00','15904.20',NULL,'0.20','15904.00','C',171,'Prakash','1',51,'2016-05-23 18:58:49',51,'2016-05-23 18:58:49','0000-00-00 00:00:00'),(39,58,'AH0000045',20,'676767676',54,'2016-05-23','CA','5.00','100.00',NULL,'0.00','105.00',NULL,'0.00','105.00','C',165,'Rahul','1',51,'2016-05-23 19:07:53',51,'2016-05-23 19:07:53','0000-00-00 00:00:00'),(40,58,'AH0000046',NULL,NULL,54,'2016-05-24','CA','0.00','0.00',NULL,'0.00','0.00',NULL,'0.00','0.00','C',NULL,NULL,'1',51,'2016-05-24 12:59:06',51,'2016-05-24 12:59:06','0000-00-00 00:00:00'),(41,58,'AH0000047',40,'9789741406',56,'2016-05-24','CA','0.00','0.00',NULL,'0.00','0.00',NULL,'0.00','0.00','C',139,'Nadesh','1',51,'2016-05-24 13:00:36',51,'2016-05-24 13:00:36','0000-00-00 00:00:00'),(42,58,'AH0000048',NULL,NULL,58,'2016-05-24','CA','147.50','2950.00','0.00','0.00','3097.50',NULL,'0.50','3098.00','C',NULL,NULL,'1',51,'2016-05-24 14:02:36',51,'2016-05-24 14:02:37','0000-00-00 00:00:00'),(43,58,'AH0000050',NULL,NULL,54,'2016-05-30','CR','2789.00','19300.00',NULL,'0.00','22089.00',NULL,'0.00','22089.00','PC',NULL,'Vinoth','1',51,'2016-05-30 10:59:59',51,'2016-05-30 11:17:49','0000-00-00 00:00:00'),(44,58,'AH0000051',26,NULL,56,'2016-05-30','CR','7007.50','140150.00',NULL,'0.00','147157.50',NULL,'0.50','147158.00','PC',154,'rajesh','1',51,'2016-05-30 11:05:29',51,'2016-05-30 11:09:23','0000-00-00 00:00:00');

/*Table structure for table `pha_sale_billing` */

DROP TABLE IF EXISTS `pha_sale_billing`;

CREATE TABLE `pha_sale_billing` (
  `sale_billing_id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_id` int(11) NOT NULL,
  `tenant_id` int(11) NOT NULL,
  `paid_date` date NOT NULL,
  `paid_amount` decimal(10,2) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`sale_billing_id`),
  KEY `FK_pha_sale_billing_tenant` (`tenant_id`),
  KEY `FK_pha_sale_billing_sale` (`sale_id`),
  CONSTRAINT `FK_pha_sale_billing_sale` FOREIGN KEY (`sale_id`) REFERENCES `pha_sale` (`sale_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_sale_billing_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

/*Data for the table `pha_sale_billing` */

insert  into `pha_sale_billing`(`sale_billing_id`,`sale_id`,`tenant_id`,`paid_date`,`paid_amount`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,30,58,'2016-05-23','105.00','1',51,'2016-05-23 17:21:06',51,'2016-05-23 17:21:06','0000-00-00 00:00:00'),(2,31,58,'2016-05-23','5496.00','1',51,'2016-05-23 17:21:06',51,'2016-05-23 17:21:06','0000-00-00 00:00:00'),(3,33,58,'2016-05-23','2198.00','1',51,'2016-05-23 17:24:38',51,'2016-05-23 17:24:38','0000-00-00 00:00:00'),(4,34,58,'2016-05-23','10.00','1',51,'2016-05-23 17:27:40',51,'2016-05-23 17:27:40','0000-00-00 00:00:00'),(5,35,58,'2016-05-23','4990.00','1',51,'2016-05-23 17:27:40',51,'2016-05-23 17:27:40','0000-00-00 00:00:00'),(6,35,58,'2016-05-23','400.00','1',51,'2016-05-23 17:28:14',51,'2016-05-23 17:28:14','0000-00-00 00:00:00'),(7,35,58,'2016-05-23','106.00','1',51,'2016-05-23 17:28:25',51,'2016-05-23 17:28:25','0000-00-00 00:00:00'),(8,32,58,'2016-05-23','10000.00','1',51,'2016-05-23 17:30:21',51,'2016-05-23 17:30:21','0000-00-00 00:00:00'),(9,37,58,'2016-05-23','105.00','1',51,'2016-05-23 18:28:50',51,'2016-05-23 18:28:50','0000-00-00 00:00:00'),(10,38,58,'2016-05-23','15904.00','1',51,'2016-05-23 18:58:49',51,'2016-05-23 18:58:49','0000-00-00 00:00:00'),(11,39,58,'2016-05-23','105.00','1',51,'2016-05-23 19:07:53',51,'2016-05-23 19:07:53','0000-00-00 00:00:00'),(12,32,58,'2016-05-23','180.00','1',51,'2016-05-23 19:09:12',51,'2016-05-23 19:09:12','0000-00-00 00:00:00'),(13,32,58,'2016-05-23','222.00','1',51,'2016-05-23 19:10:06',51,'2016-05-23 19:10:06','0000-00-00 00:00:00'),(14,32,58,'2016-05-23','100.00','1',51,'2016-05-23 19:10:41',51,'2016-05-23 19:10:41','0000-00-00 00:00:00'),(15,40,58,'2016-05-24','0.00','1',51,'2016-05-24 12:59:06',51,'2016-05-24 12:59:06','0000-00-00 00:00:00'),(16,41,58,'2016-05-24','0.00','1',51,'2016-05-24 13:00:36',51,'2016-05-24 13:00:36','0000-00-00 00:00:00'),(17,42,58,'2016-05-24','3098.00','1',51,'2016-05-24 14:02:37',51,'2016-05-24 14:02:37','0000-00-00 00:00:00'),(18,32,58,'2016-05-28','200.00','1',51,'2016-05-28 18:52:05',51,'2016-05-28 18:52:05','0000-00-00 00:00:00'),(19,32,58,'2016-05-28','1.00','1',51,'2016-05-28 18:59:27',51,'2016-05-28 18:59:27','0000-00-00 00:00:00'),(20,32,58,'2016-05-28','1.00','1',51,'2016-05-28 19:01:59',51,'2016-05-28 19:01:59','0000-00-00 00:00:00'),(21,32,58,'2016-05-28','1.00','1',51,'2016-05-28 19:13:11',51,'2016-05-28 19:13:11','0000-00-00 00:00:00'),(22,32,58,'2016-05-28','1.00','1',51,'2016-05-28 19:33:05',51,'2016-05-28 19:33:05','0000-00-00 00:00:00'),(23,32,58,'2016-05-28','1.00','1',51,'2016-05-28 19:34:08',51,'2016-05-28 19:34:08','0000-00-00 00:00:00'),(24,32,58,'2016-05-28','1.00','1',51,'2016-05-28 19:40:12',51,'2016-05-28 19:40:12','0000-00-00 00:00:00'),(25,32,58,'2016-05-28','1.00','1',51,'2016-05-28 19:41:21',51,'2016-05-28 19:41:21','0000-00-00 00:00:00'),(26,32,58,'2016-05-28','1.00','1',51,'2016-05-28 19:43:59',51,'2016-05-28 19:43:59','0000-00-00 00:00:00'),(27,32,58,'2016-05-28','1.00','1',51,'2016-05-28 19:45:09',51,'2016-05-28 19:45:09','0000-00-00 00:00:00'),(28,32,58,'2016-05-28','1.00','1',51,'2016-05-28 19:45:52',51,'2016-05-28 19:45:52','0000-00-00 00:00:00'),(29,32,58,'2016-05-30','1.00','1',51,'2016-05-30 10:13:28',51,'2016-05-30 10:13:28','0000-00-00 00:00:00'),(30,32,58,'2016-05-30','1.00','1',51,'2016-05-30 10:18:29',51,'2016-05-30 10:18:29','0000-00-00 00:00:00'),(31,32,58,'2016-05-30','1.00','1',51,'2016-05-30 10:20:29',51,'2016-05-30 10:20:29','0000-00-00 00:00:00'),(32,32,58,'2016-05-30','1.00','1',51,'2016-05-30 10:22:32',51,'2016-05-30 10:22:32','0000-00-00 00:00:00'),(33,32,58,'2016-05-30','1.00','1',51,'2016-05-30 10:23:13',51,'2016-05-30 10:23:13','0000-00-00 00:00:00'),(34,32,58,'2016-05-30','1.00','1',51,'2016-05-30 10:23:26',51,'2016-05-30 10:23:26','0000-00-00 00:00:00'),(35,32,58,'2016-05-30','1.00','1',51,'2016-05-30 10:23:45',51,'2016-05-30 10:23:45','0000-00-00 00:00:00'),(36,44,58,'2016-05-30','1.00','1',51,'2016-05-30 11:05:54',51,'2016-05-30 11:05:54','0000-00-00 00:00:00'),(37,44,58,'2016-05-30','1.00','1',51,'2016-05-30 11:06:07',51,'2016-05-30 11:06:07','0000-00-00 00:00:00'),(38,44,58,'2016-05-30','1.00','1',51,'2016-05-30 11:07:10',51,'2016-05-30 11:07:10','0000-00-00 00:00:00'),(39,44,58,'2016-05-30','1.00','1',51,'2016-05-30 11:08:02',51,'2016-05-30 11:08:02','0000-00-00 00:00:00'),(40,32,58,'2016-05-30','1.00','1',51,'2016-05-30 11:08:11',51,'2016-05-30 11:08:11','0000-00-00 00:00:00'),(41,44,58,'2016-05-30','1.00','1',51,'2016-05-30 11:08:45',51,'2016-05-30 11:08:45','0000-00-00 00:00:00'),(42,32,58,'2016-05-30','1.00','1',51,'2016-05-30 11:08:52',51,'2016-05-30 11:08:52','0000-00-00 00:00:00'),(43,44,58,'2016-05-30','10.00','1',51,'2016-05-30 11:09:23',51,'2016-05-30 11:09:23','0000-00-00 00:00:00'),(44,43,58,'2016-05-30','12.00','1',51,'2016-05-30 11:14:41',51,'2016-05-30 11:14:41','0000-00-00 00:00:00'),(45,43,58,'2016-05-30','12.00','1',51,'2016-05-30 11:14:52',51,'2016-05-30 11:14:52','0000-00-00 00:00:00'),(46,32,58,'2016-05-30','12.00','1',51,'2016-05-30 11:15:29',51,'2016-05-30 11:15:29','0000-00-00 00:00:00'),(47,43,58,'2016-05-30','6.00','1',51,'2016-05-30 11:15:44',51,'2016-05-30 11:15:44','0000-00-00 00:00:00'),(48,43,58,'2016-05-30','20.00','1',51,'2016-05-30 11:16:06',51,'2016-05-30 11:16:06','0000-00-00 00:00:00'),(49,43,58,'2016-05-30','39.00','1',51,'2016-05-30 11:17:49',51,'2016-05-30 11:17:49','0000-00-00 00:00:00');

/*Table structure for table `pha_sale_item` */

DROP TABLE IF EXISTS `pha_sale_item`;

CREATE TABLE `pha_sale_item` (
  `sale_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `batch_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `package_name` varchar(255) DEFAULT NULL,
  `mrp` decimal(10,2) NOT NULL,
  `item_amount` decimal(10,2) NOT NULL COMMENT 'qty * mrp',
  `vat_amount` decimal(10,2) DEFAULT NULL,
  `vat_percent` decimal(10,2) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`sale_item_id`),
  KEY `FK_pha_sale_item_tenant` (`tenant_id`),
  KEY `FK_pha_sale_item` (`sale_id`),
  KEY `FK_pha_sale_item_product` (`product_id`),
  KEY `FK_pha_sale_item_batch` (`batch_id`),
  CONSTRAINT `FK_pha_sale_item` FOREIGN KEY (`sale_id`) REFERENCES `pha_sale` (`sale_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_sale_item_batch` FOREIGN KEY (`batch_id`) REFERENCES `pha_product_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_sale_item_product` FOREIGN KEY (`product_id`) REFERENCES `pha_product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_sale_item_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

/*Data for the table `pha_sale_item` */

insert  into `pha_sale_item`(`sale_item_id`,`tenant_id`,`sale_id`,`product_id`,`batch_id`,`quantity`,`package_name`,`mrp`,`item_amount`,`vat_amount`,`vat_percent`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,30,3,35,10,'10s','10.00','100.00','5.00','5.00','1',51,'2016-05-23 17:04:18',51,'2016-05-23 17:04:18','0000-00-00 00:00:00'),(2,58,31,2,32,5,'10s','960.00','4800.00','696.00','14.50','1',51,'2016-05-23 17:04:36',51,'2016-05-23 17:04:36','0000-00-00 00:00:00'),(3,58,32,1,31,1,'','14000.00','14000.00','0.00','0.00','1',51,'2016-05-23 17:24:27',51,'2016-05-23 17:24:27','0000-00-00 00:00:00'),(4,58,33,2,32,2,'10s','960.00','1920.00','278.40','14.50','1',51,'2016-05-23 17:24:38',51,'2016-05-23 17:24:38','0000-00-00 00:00:00'),(5,58,34,3,35,1,'','10.00','10.00','0.00','0.00','1',51,'2016-05-23 17:25:21',51,'2016-05-23 17:25:21','0000-00-00 00:00:00'),(6,58,35,2,32,5,'10s','960.00','4800.00','696.00','14.50','1',51,'2016-05-23 17:25:32',51,'2016-05-23 17:25:32','0000-00-00 00:00:00'),(7,58,36,3,35,1,'10s','10.00','10.00','0.50','5.00','1',51,'2016-05-23 17:59:20',51,'2016-05-23 17:59:20','0000-00-00 00:00:00'),(8,58,37,3,35,10,'10s','10.00','100.00','5.00','5.00','1',51,'2016-05-23 18:28:50',51,'2016-05-23 18:28:50','0000-00-00 00:00:00'),(9,58,38,3,35,10,'10s','10.00','100.00','5.00','5.00','1',51,'2016-05-23 18:58:49',51,'2016-05-23 18:58:49','0000-00-00 00:00:00'),(10,58,38,2,32,1,'10s','960.00','960.00','139.20','14.50','1',51,'2016-05-23 18:58:49',51,'2016-05-23 18:58:49','0000-00-00 00:00:00'),(11,58,38,1,31,1,'10s','14000.00','14000.00','700.00','5.00','1',51,'2016-05-23 18:58:49',51,'2016-05-23 18:58:49','0000-00-00 00:00:00'),(12,58,39,3,35,10,'10s','10.00','100.00','5.00','5.00','1',51,'2016-05-23 19:07:54',51,'2016-05-23 19:07:54','0000-00-00 00:00:00'),(13,58,40,2,32,10,'10s','960.00','0.00','0.00','14.50','1',51,'2016-05-24 12:59:06',51,'2016-05-24 12:59:06','0000-00-00 00:00:00'),(14,58,40,3,35,10,'10s','10.00','0.00','0.00','5.00','1',51,'2016-05-24 12:59:06',51,'2016-05-24 12:59:06','0000-00-00 00:00:00'),(15,58,40,1,31,15,'10s','14000.00','0.00','0.00','5.00','1',51,'2016-05-24 12:59:06',51,'2016-05-24 12:59:06','0000-00-00 00:00:00'),(16,58,41,3,35,10,'10s','10.00','0.00','0.00','5.00','1',51,'2016-05-24 13:00:36',51,'2016-05-24 13:00:36','0000-00-00 00:00:00'),(17,58,41,2,34,15,'10s','150.00','0.00','0.00','14.50','1',51,'2016-05-24 13:00:37',51,'2016-05-24 13:00:37','0000-00-00 00:00:00'),(18,58,42,3,35,15,'10s','10.00','150.00','7.50','5.00','1',51,'2016-05-24 14:02:37',51,'2016-05-24 14:02:37','0000-00-00 00:00:00'),(19,58,42,1,33,28,'10s','100.00','2800.00','140.00','5.00','1',51,'2016-05-24 14:02:38',51,'2016-05-24 14:02:38','0000-00-00 00:00:00'),(20,58,43,3,35,10,'10s','10.00','100.00','5.00','5.00','1',51,'2016-05-30 10:59:59',51,'2016-05-30 10:59:59','0000-00-00 00:00:00'),(21,58,43,2,32,20,'10s','960.00','19200.00','2784.00','14.50','1',51,'2016-05-30 10:59:59',51,'2016-05-30 10:59:59','0000-00-00 00:00:00'),(22,58,44,1,31,10,'10s','14000.00','140000.00','7000.00','5.00','1',51,'2016-05-30 11:05:30',51,'2016-05-30 11:05:30','0000-00-00 00:00:00'),(23,58,44,3,35,15,'10s','10.00','150.00','7.50','5.00','1',51,'2016-05-30 11:05:30',51,'2016-05-30 11:05:30','0000-00-00 00:00:00');

/*Table structure for table `pha_sale_return` */

DROP TABLE IF EXISTS `pha_sale_return`;

CREATE TABLE `pha_sale_return` (
  `sale_ret_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `bill_no` varchar(50) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `mobile_no` varchar(50) NOT NULL,
  `sale_date` date NOT NULL,
  `total_item_sale_amount` decimal(10,2) DEFAULT NULL,
  `total_item_discount_percent` decimal(10,2) DEFAULT NULL,
  `total_item_discount_amount` decimal(10,2) DEFAULT NULL COMMENT 'total_item_sale_amount * discount_percent',
  `total_item_amount` decimal(10,2) DEFAULT NULL COMMENT 'total_item_sale_amount - discount_amount',
  `roundoff_amount` decimal(10,2) DEFAULT NULL,
  `bill_amount` decimal(10,2) DEFAULT NULL COMMENT 'total_item_amount  + roundoff',
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`sale_ret_id`),
  KEY `FK_pha_sale_return_tenant` (`tenant_id`),
  KEY `FK_pha_sale_return_patient` (`patient_id`),
  CONSTRAINT `FK_pha_sale_return_patient` FOREIGN KEY (`patient_id`) REFERENCES `pat_patient` (`patient_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_sale_return_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pha_sale_return` */

/*Table structure for table `pha_sale_return_item` */

DROP TABLE IF EXISTS `pha_sale_return_item`;

CREATE TABLE `pha_sale_return_item` (
  `sale_ret_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `sale_ret_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `batch_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `package_name` varchar(255) DEFAULT NULL,
  `mrp` decimal(10,2) NOT NULL,
  `item_amount` decimal(10,2) NOT NULL COMMENT 'qty * mrp',
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`sale_ret_item_id`),
  KEY `FK_pha_sale_ret_item_tenant` (`tenant_id`),
  KEY `FK_pha_sale_ret_item` (`sale_ret_id`),
  KEY `FK_pha_sale_ret_item_product` (`product_id`),
  KEY `FK_pha_sale_ret_item_batch` (`batch_id`),
  CONSTRAINT `FK_pha_sale_ret_item` FOREIGN KEY (`sale_ret_id`) REFERENCES `pha_sale_return` (`sale_ret_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_sale_ret_item_batch` FOREIGN KEY (`batch_id`) REFERENCES `pha_product_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_sale_ret_item_product` FOREIGN KEY (`product_id`) REFERENCES `pha_product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_sale_ret_item_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pha_sale_return_item` */

/*Table structure for table `pha_supplier` */

DROP TABLE IF EXISTS `pha_supplier`;

CREATE TABLE `pha_supplier` (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `supplier_name` varchar(100) NOT NULL,
  `supplier_code` varchar(50) DEFAULT NULL,
  `supplier_address` text NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `zip` varchar(30) DEFAULT NULL,
  `supplier_mobile` varchar(50) NOT NULL,
  `supplier_phone` varchar(50) DEFAULT NULL,
  `cst_no` varchar(100) NOT NULL,
  `tin_no` varchar(100) NOT NULL,
  `drug_license` varchar(100) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`supplier_id`),
  UNIQUE KEY `PhasupplierUnique` (`tenant_id`,`supplier_name`,`deleted_at`),
  KEY `FK_pha_supplier_city` (`city_id`),
  KEY `FK_pha_supplier_state` (`state_id`),
  KEY `FK_pha_supplier_country` (`country_id`),
  CONSTRAINT `FK_pha_supplier_city` FOREIGN KEY (`city_id`) REFERENCES `co_master_city` (`city_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_supplier_country` FOREIGN KEY (`country_id`) REFERENCES `co_master_country` (`country_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_supplier_state` FOREIGN KEY (`state_id`) REFERENCES `co_master_state` (`state_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_supplier_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `pha_supplier` */

insert  into `pha_supplier`(`supplier_id`,`tenant_id`,`supplier_name`,`supplier_code`,`supplier_address`,`city_id`,`state_id`,`country_id`,`zip`,`supplier_mobile`,`supplier_phone`,`cst_no`,`tin_no`,`drug_license`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'Supplier 1','0001','Supplier 1',1,8,7,'625002','',NULL,'','',NULL,'1',51,'2016-03-07 15:40:53',51,'2016-03-07 15:40:53','0000-00-00 00:00:00'),(2,58,'supplier 2',NULL,'23123123',NULL,NULL,NULL,NULL,'233213123',NULL,'12323','23231',NULL,'1',51,'2016-05-23 19:26:27',51,'2016-05-23 19:26:27','0000-00-00 00:00:00'),(3,58,'supplier 3',NULL,'23123123',NULL,NULL,NULL,NULL,'233213123',NULL,'12323','23231',NULL,'1',51,'2016-05-23 19:26:33',51,'2016-05-23 19:26:33','0000-00-00 00:00:00');

/*Table structure for table `pha_vat` */

DROP TABLE IF EXISTS `pha_vat`;

CREATE TABLE `pha_vat` (
  `vat_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `vat` decimal(10,2) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`vat_id`),
  UNIQUE KEY `PhavatUnique` (`tenant_id`,`vat`,`deleted_at`),
  CONSTRAINT `FK_pha_vat_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `pha_vat` */

insert  into `pha_vat`(`vat_id`,`tenant_id`,`vat`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'5.00','1',51,'2016-03-07 15:25:56',51,'2016-03-07 15:25:56','0000-00-00 00:00:00'),(2,58,'14.50','1',51,'2016-03-07 15:26:03',51,'2016-03-07 15:26:03','0000-00-00 00:00:00'),(3,58,'12.00','1',51,'2016-03-16 16:47:29',51,'2016-03-16 16:47:29','0000-00-00 00:00:00'),(4,58,'18.00','1',51,'2016-03-16 16:47:39',51,'2016-03-16 16:47:39','0000-00-00 00:00:00');

/*Table structure for table `v_billing_advance_charges` */

DROP TABLE IF EXISTS `v_billing_advance_charges`;

/*!50001 DROP VIEW IF EXISTS `v_billing_advance_charges` */;
/*!50001 DROP TABLE IF EXISTS `v_billing_advance_charges` */;

/*!50001 CREATE TABLE  `v_billing_advance_charges`(
 `tenant_id` int(11) ,
 `encounter_id` int(11) ,
 `patient_id` int(11) ,
 `payment_id` int(11) ,
 `payment_date` datetime ,
 `category` varchar(14) ,
 `headers` varchar(20) ,
 `charge` int(1) ,
 `visit_count` int(1) ,
 `trans_mode` varchar(1) ,
 `total_charge` decimal(10,2) ,
 `extra_amount` int(1) ,
 `concession_amount` int(1) 
)*/;

/*Table structure for table `v_billing_other_charges` */

DROP TABLE IF EXISTS `v_billing_other_charges`;

/*!50001 DROP VIEW IF EXISTS `v_billing_other_charges` */;
/*!50001 DROP TABLE IF EXISTS `v_billing_other_charges` */;

/*!50001 CREATE TABLE  `v_billing_other_charges`(
 `tenant_id` int(11) ,
 `encounter_id` int(11) ,
 `patient_id` int(11) ,
 `category_id` int(11) ,
 `category` varchar(50) ,
 `headers` varchar(50) ,
 `charge` decimal(10,2) ,
 `visit_count` int(1) ,
 `trans_mode` varchar(1) ,
 `total_charge` decimal(10,2) ,
 `extra_amount` int(1) ,
 `concession_amount` int(1) ,
 `other_charge_id` int(11) 
)*/;

/*Table structure for table `v_billing_procedures` */

DROP TABLE IF EXISTS `v_billing_procedures`;

/*!50001 DROP VIEW IF EXISTS `v_billing_procedures` */;
/*!50001 DROP TABLE IF EXISTS `v_billing_procedures` */;

/*!50001 CREATE TABLE  `v_billing_procedures`(
 `tenant_id` int(11) ,
 `encounter_id` int(11) ,
 `patient_id` int(11) ,
 `category_id` int(11) ,
 `category` varchar(17) ,
 `headers` varchar(50) ,
 `charge` decimal(10,2) ,
 `visit_count` bigint(21) ,
 `trans_mode` varchar(1) ,
 `total_charge` decimal(32,2) ,
 `extra_amount` decimal(10,2) ,
 `concession_amount` decimal(10,2) ,
 `ec_id` bigint(11) ,
 `ec_type` varchar(1) 
)*/;

/*Table structure for table `v_billing_professionals` */

DROP TABLE IF EXISTS `v_billing_professionals`;

/*!50001 DROP VIEW IF EXISTS `v_billing_professionals` */;
/*!50001 DROP TABLE IF EXISTS `v_billing_professionals` */;

/*!50001 CREATE TABLE  `v_billing_professionals`(
 `tenant_id` int(11) ,
 `encounter_id` int(11) ,
 `patient_id` int(11) ,
 `category_id` int(11) ,
 `category` varchar(20) ,
 `headers` varchar(61) ,
 `charge` decimal(10,2) ,
 `visit_count` bigint(21) ,
 `trans_mode` varchar(1) ,
 `total_charge` decimal(32,2) ,
 `extra_amount` decimal(10,2) ,
 `concession_amount` decimal(10,2) ,
 `ec_id` bigint(11) ,
 `ec_type` varchar(1) 
)*/;

/*Table structure for table `v_billing_recurring` */

DROP TABLE IF EXISTS `v_billing_recurring`;

/*!50001 DROP VIEW IF EXISTS `v_billing_recurring` */;
/*!50001 DROP TABLE IF EXISTS `v_billing_recurring` */;

/*!50001 CREATE TABLE  `v_billing_recurring`(
 `tenant_id` int(11) ,
 `encounter_id` int(11) ,
 `room_type_id` int(11) ,
 `room_type` varchar(255) ,
 `charge_item_id` int(11) ,
 `charge_item` varchar(255) ,
 `from_date` date ,
 `to_date` date ,
 `duration` int(8) ,
 `charge_amount` decimal(32,2) ,
 `total_charge` decimal(32,2) 
)*/;

/*Table structure for table `v_encounter` */

DROP TABLE IF EXISTS `v_encounter`;

/*!50001 DROP VIEW IF EXISTS `v_encounter` */;
/*!50001 DROP TABLE IF EXISTS `v_encounter` */;

/*!50001 CREATE TABLE  `v_encounter`(
 `id` int(11) ,
 `encounter_id` int(11) ,
 `date` varchar(21) ,
 `type` varchar(24) ,
 `details` varchar(214) ,
 `doctor` varchar(60) ,
 `patient_id` int(11) ,
 `patient_guid` varchar(50) ,
 `encounter_type` varchar(5) ,
 `status` varchar(1) ,
 `date_time` datetime ,
 `row_sts` varchar(2) ,
 `is_swap` bigint(6) ,
 `consultant_id` int(11) 
)*/;

/*View structure for view v_billing_advance_charges */

/*!50001 DROP TABLE IF EXISTS `v_billing_advance_charges` */;
/*!50001 DROP VIEW IF EXISTS `v_billing_advance_charges` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_billing_advance_charges` AS (select `a`.`tenant_id` AS `tenant_id`,`a`.`encounter_id` AS `encounter_id`,`a`.`patient_id` AS `patient_id`,`a`.`payment_id` AS `payment_id`,`a`.`payment_date` AS `payment_date`,'Advance Charge' AS `category`,concat('Payment(',`a`.`payment_id`,')') AS `headers`,0 AS `charge`,0 AS `visit_count`,'C' AS `trans_mode`,`a`.`payment_amount` AS `total_charge`,0 AS `extra_amount`,0 AS `concession_amount` from `pat_billing_payment` `a` where ((`a`.`status` = '1') and (`a`.`deleted_at` = '0000-00-00 00:00:00'))) */;

/*View structure for view v_billing_other_charges */

/*!50001 DROP TABLE IF EXISTS `v_billing_other_charges` */;
/*!50001 DROP VIEW IF EXISTS `v_billing_other_charges` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_billing_other_charges` AS (select `a`.`tenant_id` AS `tenant_id`,`a`.`encounter_id` AS `encounter_id`,`a`.`patient_id` AS `patient_id`,`a`.`charge_subcat_id` AS `category_id`,`b`.`charge_cat_name` AS `category`,`c`.`charge_subcat_name` AS `headers`,`a`.`charge_amount` AS `charge`,0 AS `visit_count`,'D' AS `trans_mode`,`a`.`charge_amount` AS `total_charge`,0 AS `extra_amount`,0 AS `concession_amount`,`a`.`other_charge_id` AS `other_charge_id` from ((`pat_billing_other_charges` `a` join `co_room_charge_category` `b` on((`b`.`charge_cat_id` = `a`.`charge_cat_id`))) join `co_room_charge_subcategory` `c` on((`c`.`charge_subcat_id` = `a`.`charge_subcat_id`))) where ((`a`.`status` = '1') and (`a`.`deleted_at` = '0000-00-00 00:00:00'))) */;

/*View structure for view v_billing_procedures */

/*!50001 DROP TABLE IF EXISTS `v_billing_procedures` */;
/*!50001 DROP VIEW IF EXISTS `v_billing_procedures` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_billing_procedures` AS (select `a`.`tenant_id` AS `tenant_id`,`a`.`encounter_id` AS `encounter_id`,`a`.`patient_id` AS `patient_id`,`a`.`charge_subcat_id` AS `category_id`,'Procedure Charges' AS `category`,`b`.`charge_subcat_name` AS `headers`,truncate(avg(`a`.`charge_amount`),2) AS `charge`,count(`a`.`proc_id`) AS `visit_count`,'D' AS `trans_mode`,sum(`a`.`charge_amount`) AS `total_charge`,ifnull((select `c`.`extra_amount` from `pat_billing_extra_concession` `c` where ((`c`.`encounter_id` = `a`.`encounter_id`) and (`c`.`patient_id` = `a`.`patient_id`) and (`c`.`link_id` = `a`.`charge_subcat_id`) and (`c`.`ec_type` = 'P'))),0) AS `extra_amount`,ifnull((select `c`.`concession_amount` from `pat_billing_extra_concession` `c` where ((`c`.`encounter_id` = `a`.`encounter_id`) and (`c`.`patient_id` = `a`.`patient_id`) and (`c`.`link_id` = `a`.`charge_subcat_id`) and (`c`.`ec_type` = 'P'))),0) AS `concession_amount`,ifnull((select `c`.`ec_id` from `pat_billing_extra_concession` `c` where ((`c`.`encounter_id` = `a`.`encounter_id`) and (`c`.`patient_id` = `a`.`patient_id`) and (`c`.`link_id` = `a`.`charge_subcat_id`) and (`c`.`ec_type` = 'P')) limit 1),0) AS `ec_id`,ifnull((select `c`.`ec_type` from `pat_billing_extra_concession` `c` where ((`c`.`encounter_id` = `a`.`encounter_id`) and (`c`.`patient_id` = `a`.`patient_id`) and (`c`.`link_id` = `a`.`charge_subcat_id`) and (`c`.`ec_type` = 'P')) limit 1),0) AS `ec_type` from (`pat_procedure` `a` join `co_room_charge_subcategory` `b` on((`b`.`charge_subcat_id` = `a`.`charge_subcat_id`))) where ((`a`.`status` = '1') and (`a`.`deleted_at` = '0000-00-00 00:00:00')) group by `a`.`encounter_id`,`a`.`charge_subcat_id`) */;

/*View structure for view v_billing_professionals */

/*!50001 DROP TABLE IF EXISTS `v_billing_professionals` */;
/*!50001 DROP VIEW IF EXISTS `v_billing_professionals` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_billing_professionals` AS (select `a`.`tenant_id` AS `tenant_id`,`a`.`encounter_id` AS `encounter_id`,`a`.`patient_id` AS `patient_id`,`a`.`consultant_id` AS `category_id`,'Professional Charges' AS `category`,concat(`b`.`title_code`,' ',`b`.`name`) AS `headers`,truncate(avg(`a`.`charge_amount`),2) AS `charge`,count(`a`.`pat_consult_id`) AS `visit_count`,'D' AS `trans_mode`,sum(`a`.`charge_amount`) AS `total_charge`,ifnull((select `c`.`extra_amount` from `pat_billing_extra_concession` `c` where ((`c`.`encounter_id` = `a`.`encounter_id`) and (`c`.`patient_id` = `a`.`patient_id`) and (`c`.`link_id` = `a`.`consultant_id`) and (`c`.`ec_type` = 'C'))),0) AS `extra_amount`,ifnull((select `c`.`concession_amount` from `pat_billing_extra_concession` `c` where ((`c`.`encounter_id` = `a`.`encounter_id`) and (`c`.`patient_id` = `a`.`patient_id`) and (`c`.`link_id` = `a`.`consultant_id`) and (`c`.`ec_type` = 'C'))),0) AS `concession_amount`,ifnull((select `c`.`ec_id` from `pat_billing_extra_concession` `c` where ((`c`.`encounter_id` = `a`.`encounter_id`) and (`c`.`patient_id` = `a`.`patient_id`) and (`c`.`link_id` = `a`.`consultant_id`) and (`c`.`ec_type` = 'C')) limit 1),0) AS `ec_id`,ifnull((select `c`.`ec_type` from `pat_billing_extra_concession` `c` where ((`c`.`encounter_id` = `a`.`encounter_id`) and (`c`.`patient_id` = `a`.`patient_id`) and (`c`.`link_id` = `a`.`consultant_id`) and (`c`.`ec_type` = 'C')) limit 1),0) AS `ec_type` from (`pat_consultant` `a` join `co_user` `b` on((`b`.`user_id` = `a`.`consultant_id`))) where ((`a`.`status` = '1') and (`a`.`deleted_at` = '0000-00-00 00:00:00')) group by `a`.`encounter_id`,`a`.`consultant_id`) */;

/*View structure for view v_billing_recurring */

/*!50001 DROP TABLE IF EXISTS `v_billing_recurring` */;
/*!50001 DROP VIEW IF EXISTS `v_billing_recurring` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_billing_recurring` AS (select `pat_billing_recurring`.`tenant_id` AS `tenant_id`,`pat_billing_recurring`.`encounter_id` AS `encounter_id`,`pat_billing_recurring`.`room_type_id` AS `room_type_id`,`pat_billing_recurring`.`room_type` AS `room_type`,`pat_billing_recurring`.`charge_item_id` AS `charge_item_id`,`pat_billing_recurring`.`charge_item` AS `charge_item`,min(`pat_billing_recurring`.`recurr_date`) AS `from_date`,max(`pat_billing_recurring`.`recurr_date`) AS `to_date`,((to_days(max(`pat_billing_recurring`.`recurr_date`)) - to_days(min(`pat_billing_recurring`.`recurr_date`))) + 1) AS `duration`,truncate((sum(`pat_billing_recurring`.`charge_amount`) / ((to_days(max(`pat_billing_recurring`.`recurr_date`)) - to_days(min(`pat_billing_recurring`.`recurr_date`))) + 1)),2) AS `charge_amount`,sum(`pat_billing_recurring`.`charge_amount`) AS `total_charge` from `pat_billing_recurring` group by `pat_billing_recurring`.`encounter_id`,`pat_billing_recurring`.`room_type_id`,`pat_billing_recurring`.`recurr_group`,`pat_billing_recurring`.`charge_item_id`,`pat_billing_recurring`.`charge_amount`) */;

/*View structure for view v_encounter */

/*!50001 DROP TABLE IF EXISTS `v_encounter` */;
/*!50001 DROP VIEW IF EXISTS `v_encounter` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_encounter` AS select `a`.`appt_id` AS `id`,`c`.`encounter_id` AS `encounter_id`,concat(`a`.`status_date`,' ',`a`.`status_time`) AS `date`,(case `a`.`appt_status` when 'B' then 'Booked' when 'A' then 'Arrived' when 'S' then 'Seen' when 'C' then 'Cancelled' else NULL end) AS `type`,'\nOP' AS `details`,concat(`b`.`title_code`,`b`.`name`) AS `doctor`,`c`.`patient_id` AS `patient_id`,`d`.`patient_guid` AS `patient_guid`,`c`.`encounter_type` AS `encounter_type`,`c`.`status` AS `status`,`a`.`status_date` AS `date_time`,`a`.`appt_status` AS `row_sts`,0 AS `is_swap`,`a`.`consultant_id` AS `consultant_id` from (((`pat_appointment` `a` join `co_user` `b` on((`b`.`user_id` = `a`.`consultant_id`))) join `pat_encounter` `c` on((`c`.`encounter_id` = `a`.`encounter_id`))) join `pat_patient` `d` on((`d`.`patient_id` = `c`.`patient_id`))) union all select `a`.`admn_id` AS `id`,`c`.`encounter_id` AS `encounter_id`,`a`.`status_date` AS `date`,(case `a`.`admission_status` when 'A' then 'Admission' when 'D' then 'Administrative Discharge' when 'CD' then 'Clinical Discharge' when 'TR' then 'Transfer (Room)' when 'TD' then 'Transfer (Doctor)' when 'C' then 'Cancelled' else NULL end) AS `type`,concat('IP: ',`d`.`floor_name`,' > ',`e`.`ward_name`,' > ',`f`.`bed_name`,'  (',`g`.`room_type_name`,')') AS `details`,concat(`b`.`title_code`,`b`.`name`) AS `doctor`,`c`.`patient_id` AS `patient_id`,`h`.`patient_guid` AS `patient_guid`,`c`.`encounter_type` AS `encounter_type`,`c`.`status` AS `status`,`a`.`status_date` AS `date_time`,`a`.`admission_status` AS `row_sts`,`a`.`is_swap` AS `is_swap`,`a`.`consultant_id` AS `consultant_id` from (((((((`pat_admission` `a` join `co_user` `b` on((`b`.`user_id` = `a`.`consultant_id`))) join `pat_encounter` `c` on((`c`.`encounter_id` = `a`.`encounter_id`))) left join `co_floor` `d` on((`d`.`floor_id` = `a`.`floor_id`))) left join `co_ward` `e` on((`e`.`ward_id` = `a`.`ward_id`))) left join `co_room` `f` on((`f`.`room_id` = `a`.`room_id`))) left join `co_room_type` `g` on((`g`.`room_type_id` = `a`.`room_type_id`))) join `pat_patient` `h` on((`h`.`patient_id` = `c`.`patient_id`))) where (`a`.`status` = '1') order by `encounter_id` desc,`date_time` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
