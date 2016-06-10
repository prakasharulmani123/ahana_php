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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

/*Data for the table `app_configuration` */

insert  into `app_configuration`(`config_id`,`tenant_id`,`code`,`key`,`value`,`notes`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,60,'RC','ROOM_CHARGE_CONFIG','11',NULL,'0',0,'2016-05-02 18:16:02',51,'2016-05-03 12:43:57','2016-05-03 12:43:57'),(2,60,'ET','ELAPSED_TIME','3600','seconds','1',0,'2016-05-02 18:28:32',51,'2016-06-09 17:32:45','0000-00-00 00:00:00'),(3,60,'ENCOUNTER','SHARE_ENCOUNTER','1','Share Encounter','1',0,'2016-06-09 16:28:56',51,'2016-06-09 17:13:42','0000-00-00 00:00:00'),(4,60,'NOTES','SHARE_NOTES','1','Share Notes','1',0,'2016-06-09 16:29:20',51,'2016-06-09 17:13:42','0000-00-00 00:00:00'),(5,60,'CONSULTANT','SHARE_CONSULTANT','1','Share Consultant','1',0,'2016-06-09 16:30:18',51,'2016-06-09 17:13:42','0000-00-00 00:00:00'),(6,60,'ALERT','SHARE_ALERT','1','Share Alert','1',0,'2016-06-09 16:30:43',51,'2016-06-09 17:13:42','0000-00-00 00:00:00'),(7,60,'VITALS','SHARE_VITALS','1','Share Vitals','1',0,'2016-06-09 16:31:02',51,'2016-06-09 17:13:42','0000-00-00 00:00:00'),(8,60,'PRESCRIPTION','SHARE_PRESCRIPTION','0','Share Prescription','1',0,'2016-06-09 16:31:22',51,'2016-06-09 17:13:42','0000-00-00 00:00:00'),(9,68,'ET','ELAPSED_TIME','3600','seconds','1',-1,'2016-06-09 19:23:22',-1,'2016-06-09 19:23:22','0000-00-00 00:00:00'),(10,68,'ENCOUNTER','SHARE_ENCOUNTER','0','Share Encounter','1',-1,'2016-06-09 19:23:22',-1,'2016-06-09 19:23:22','0000-00-00 00:00:00'),(11,68,'NOTES','SHARE_NOTES','0','Share Notes','1',-1,'2016-06-09 19:23:22',-1,'2016-06-09 19:23:22','0000-00-00 00:00:00'),(12,68,'CONSULTANT','SHARE_CONSULTANT','0','Share Consultant','1',-1,'2016-06-09 19:23:22',-1,'2016-06-09 19:23:22','0000-00-00 00:00:00'),(13,68,'ALERT','SHARE_ALERT','1','Share Alert','1',-1,'2016-06-09 19:23:22',-1,'2016-06-09 19:23:22','0000-00-00 00:00:00'),(14,68,'VITALS','SHARE_VITALS','1','Share Vitals','1',-1,'2016-06-09 19:23:22',-1,'2016-06-09 19:23:22','0000-00-00 00:00:00'),(15,68,'PRESCRIPTION','SHARE_PRESCRIPTION','0','Share Prescription','1',-1,'2016-06-09 19:23:22',-1,'2016-06-09 19:23:22','0000-00-00 00:00:00'),(16,58,'ET','ELAPSED_TIME','3600','seconds','1',-1,'2016-06-10 11:43:42',-1,'2016-06-10 11:43:42','0000-00-00 00:00:00'),(17,58,'ENCOUNTER','SHARE_ENCOUNTER','1','Share Encounter','1',-1,'2016-06-10 11:43:42',-1,'2016-06-10 11:43:42','0000-00-00 00:00:00'),(18,58,'NOTES','SHARE_NOTES','1','Share Notes','1',-1,'2016-06-10 11:43:42',-1,'2016-06-10 11:43:42','0000-00-00 00:00:00'),(19,58,'CONSULTANT','SHARE_CONSULTANT','1','Share Consultant','1',-1,'2016-06-10 11:43:42',-1,'2016-06-10 11:43:42','0000-00-00 00:00:00'),(20,58,'ALERT','SHARE_ALERT','1','Share Alert','1',-1,'2016-06-10 11:43:42',-1,'2016-06-10 11:43:42','0000-00-00 00:00:00'),(21,58,'VITALS','SHARE_VITALS','1','Share Vitals','1',-1,'2016-06-10 11:43:42',-1,'2016-06-10 11:43:42','0000-00-00 00:00:00'),(22,58,'PRESCRIPTION','SHARE_PRESCRIPTION','1','Share Prescription','1',-1,'2016-06-10 11:43:42',-1,'2016-06-10 11:43:42','0000-00-00 00:00:00');

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

insert  into `co_internal_code`(`internal_code_id`,`tenant_id`,`code_type`,`code_prefix`,`code`,`code_padding`,`code_suffix`,`status`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (2,58,'B','AH',54,7,NULL,'1','2016-06-10 15:43:20',-1,'2016-06-10 15:43:20',51,'0000-00-00 00:00:00'),(3,58,'P','AH',68,7,NULL,'1','2016-06-10 15:42:55',-1,'2016-06-10 15:42:55',51,'0000-00-00 00:00:00'),(4,59,'B','AR',1,7,NULL,'1','2016-02-02 22:43:11',-1,'2016-02-02 22:43:11',-1,'0000-00-00 00:00:00'),(5,59,'P','AR',2,7,NULL,'1','2016-06-09 10:41:59',-1,'2016-06-09 10:41:59',51,'0000-00-00 00:00:00'),(6,60,'B','RA',11,7,NULL,'1','2016-06-08 15:33:59',-1,'2016-06-08 15:33:59',51,'0000-00-00 00:00:00'),(7,60,'P','RA',19,7,NULL,'1','2016-06-09 19:09:57',-1,'2016-06-09 19:09:57',51,'0000-00-00 00:00:00'),(8,61,'B','TE',34343434,7,NULL,'1','2016-02-23 02:20:29',-1,'2016-02-23 02:20:29',67,'0000-00-00 00:00:00'),(9,61,'P','TE',2,7,NULL,'1','2016-02-21 23:20:06',-1,'2016-02-21 23:20:06',67,'0000-00-00 00:00:00'),(10,62,'B','TE',1,7,NULL,'1','2016-02-29 02:00:01',-1,'2016-02-29 02:00:01',-1,'0000-00-00 00:00:00'),(11,62,'P','TE',1,7,NULL,'1','2016-02-29 02:00:01',-1,'2016-02-29 02:00:01',-1,'0000-00-00 00:00:00'),(12,58,'PU','AH',20,7,NULL,'1','2016-03-31 16:00:45',-1,'2016-03-31 16:00:45',51,'0000-00-00 00:00:00'),(13,58,'PR','PR',5,7,NULL,'1','2016-03-11 15:15:03',-1,'2016-03-11 15:15:03',51,'0000-00-00 00:00:00'),(14,68,'B','K.',1,7,NULL,'1','2016-06-09 19:23:21',-1,'2016-06-09 19:23:21',-1,'0000-00-00 00:00:00'),(15,68,'P','K.',4,7,NULL,'1','2016-06-10 10:41:36',-1,'2016-06-10 10:41:36',51,'0000-00-00 00:00:00'),(16,68,'PU','K.',1,7,NULL,'1','2016-06-09 19:23:21',-1,'2016-06-09 19:23:21',-1,'0000-00-00 00:00:00'),(17,68,'PR','K.',1,7,NULL,'1','2016-06-09 19:23:21',-1,'2016-06-09 19:23:21',-1,'0000-00-00 00:00:00'),(18,69,'B','RK',1,7,NULL,'1','2016-06-10 11:43:42',-1,'2016-06-10 11:43:42',-1,'0000-00-00 00:00:00'),(19,69,'P','RK',1,7,NULL,'1','2016-06-10 11:43:42',-1,'2016-06-10 11:43:42',-1,'0000-00-00 00:00:00'),(20,69,'PU','RK',1,7,NULL,'1','2016-06-10 11:43:42',-1,'2016-06-10 11:43:42',-1,'0000-00-00 00:00:00'),(21,69,'PR','RK',1,7,NULL,'1','2016-06-10 11:43:42',-1,'2016-06-10 11:43:42',-1,'0000-00-00 00:00:00');

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

insert  into `co_login`(`login_id`,`user_id`,`username`,`password`,`password_reset_token`,`authtoken`,`created_by`,`created_at`,`modified_by`,`modified_at`,`activation_date`,`Inactivation_date`,`logged_tenant_id`) values (10,51,'vikhram','$2y$13$fiIoeo1BUmyPw1bx4fSe/.ePp7Xh.K9uXqZa6.j4UQa6rN5TBJzT.','b1SD_pk2esmjHp5RiON3wzGPpzmDxS0q_1457939704','dmlraHJhbTE0NjU1NTM3OTA1NzQ3',-1,'2016-02-02 22:26:39',NULL,'2016-06-10 15:46:30',NULL,NULL,58),(11,52,'ark','$2y$13$4T7TlDr8in4ydQTVxEfTke.donWnYhKLOJG8r/c78g.UXuXeqfNFO',NULL,'YXJrMTQ1NDk5MDU0NTE1MTg=',-1,'2016-02-02 22:43:12',NULL,'2016-02-08 22:02:25',NULL,NULL,NULL),(12,54,'John','$2y$13$/mlVvR83V.H4qLbC1wGelenerJWeBGEF1SYMWeAXJ9FxzF9vvTyR2',NULL,'Sm9objE0NjM3MTg5OTI4NjIy',51,'2016-02-04 07:07:43',NULL,'2016-05-20 10:06:32','2016-02-04','2016-02-28',58),(13,56,'surya','$2y$13$lpvuN2LSd2zOqt5Mx4TdmeuGcgBa7YuOsBwRdHLtKQrd3uioJioeq',NULL,'c3VyeWExNDU1NTQxODM1ODkwOQ==',51,'2016-02-05 22:50:58',NULL,'2016-02-15 07:10:35','2016-02-06','2016-04-30',NULL),(14,59,'gayatri','$2y$13$ZEtwkbrJqouJw3KqMkoEzO6JIGFyuOUA3mba5AENqyYe7jX5HmpTe',NULL,'Z2F5YXRyaTE0NTYxNDM0MTYyNDgz',-1,'2016-02-17 06:28:39',NULL,'2016-02-22 06:16:56',NULL,NULL,60),(15,62,'prakash','$2y$13$X9agaug8aC21f9ujjR9vzOze3nqFNsuaLPf0kgOwwI06tsqX35IrW',NULL,'',51,'2016-02-19 07:08:27',62,'2016-03-03 17:28:56','2016-02-19','2016-02-19',NULL),(16,63,'nadesh','$2y$13$X9agaug8aC21f9ujjR9vzOze3nqFNsuaLPf0kgOwwI06tsqX35IrW',NULL,'',51,'2016-02-19 07:09:05',63,'2016-02-29 06:16:28','2016-02-19','2016-02-19',NULL),(17,65,'test','$2y$13$A4KhMKHUYaMb4m0MoTBNVufbQu4gkBcTc0zV.vSkFiuv..QlAhfh2',NULL,NULL,59,'2016-02-19 07:49:44',59,'2016-02-19 07:49:44','2016-02-19','2016-02-19',NULL),(18,66,'prakash2','$2y$13$mfGVdp/.Cst1GsGHSo/Vv.q9.gxFCaecIokQmbF29OnIw9WS8aIX.',NULL,'cHJha2FzaDIxNDU1OTcyNTk2NDA5Nw==',59,'2016-02-20 05:10:18',NULL,'2016-02-20 06:49:56','2016-02-20','2016-02-20',60),(19,67,'paramesh','$2y$13$u.tSO2LUiafMwxi19midCOlGruWNOIR1lD3gqsGnYhXnSbNYHqvqC','2NCgwIefzaenjPjYtE2lCd_M9eLzyfsQ_1456575065','',-1,'2016-02-21 23:16:05',67,'2016-02-29 02:01:25',NULL,NULL,NULL),(20,73,'parames','$2y$13$1TsRqCJ5ThWc.Pp2vVrdQecg1tFoqsKPGJRCwII5QZqlpB2AtSn86',NULL,NULL,-1,'2016-02-29 02:00:02',-1,'2016-02-29 02:00:02',NULL,NULL,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=latin1;

/*Data for the table `co_role` */

insert  into `co_role`(`role_id`,`tenant_id`,`description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (64,58,'Administrator','1',-1,'2016-02-02 22:26:38',-1,'2016-02-02 22:26:38','0000-00-00 00:00:00'),(65,59,'Administrator','1',-1,'2016-02-02 22:43:11',-1,'2016-02-02 22:43:11','0000-00-00 00:00:00'),(66,58,'Admin','1',51,'2016-02-04 07:02:50',51,'2016-02-04 07:02:50','0000-00-00 00:00:00'),(67,58,'Cashier','1',51,'2016-02-04 07:03:04',51,'2016-02-04 07:03:04','0000-00-00 00:00:00'),(68,58,'Nurse','1',51,'2016-02-05 22:27:45',51,'2016-05-13 11:45:32','0000-00-00 00:00:00'),(69,60,'admin','1',-1,'2016-02-17 06:28:38',-1,'2016-02-17 06:28:38','0000-00-00 00:00:00'),(72,60,'Sub-Admin','1',59,'2016-02-19 03:57:13',59,'2016-02-19 07:38:06','0000-00-00 00:00:00'),(73,60,'Chief Cashier','1',59,'2016-02-19 04:17:31',59,'2016-02-19 04:31:12','0000-00-00 00:00:00'),(74,60,'Doctor','1',59,'2016-02-19 04:17:46',59,'2016-02-19 04:17:46','0000-00-00 00:00:00'),(79,60,'Nurse','1',59,'2016-02-19 04:22:36',59,'2016-02-19 04:29:12','0000-00-00 00:00:00'),(80,60,'Receptionist','0',59,'2016-02-19 04:22:48',59,'2016-02-19 04:23:14','0000-00-00 00:00:00'),(81,60,'Accountant','1',59,'2016-02-19 04:26:33',59,'2016-02-19 04:29:23','0000-00-00 00:00:00'),(82,60,'PRO','1',59,'2016-02-19 04:27:34',59,'2016-02-19 04:27:58','0000-00-00 00:00:00'),(84,60,'Human Resource','1',59,'2016-02-19 04:31:40',59,'2016-02-19 04:48:00','0000-00-00 00:00:00'),(85,60,'Director','0',59,'2016-02-19 04:43:23',59,'2016-02-19 04:54:09','0000-00-00 00:00:00'),(86,60,'Psychologist','1',59,'2016-02-19 04:43:59',59,'2016-02-19 04:54:02','0000-00-00 00:00:00'),(87,60,'Pharmacy','1',59,'2016-02-19 04:45:43',59,'2016-02-19 04:53:53','0000-00-00 00:00:00'),(88,60,'Supervisor','1',59,'2016-02-19 04:47:28',59,'2016-02-19 04:53:40','0000-00-00 00:00:00'),(89,60,'manager','1',59,'2016-02-19 04:54:33',59,'2016-02-19 04:54:33','0000-00-00 00:00:00'),(90,60,'Care Provider','1',59,'2016-02-19 07:12:03',59,'2016-02-19 07:12:30','0000-00-00 00:00:00'),(91,61,'admin','1',-1,'2016-02-21 23:16:05',-1,'2016-02-21 23:16:05','0000-00-00 00:00:00'),(92,61,'Administrator','1',67,'2016-02-23 02:28:08',67,'2016-02-25 04:59:00','0000-00-00 00:00:00'),(93,62,'admin','1',-1,'2016-02-29 02:00:01',-1,'2016-02-29 02:00:01','0000-00-00 00:00:00'),(94,58,'asdsdas','1',51,'2016-05-17 10:49:46',51,'2016-05-17 10:49:46','0000-00-00 00:00:00'),(95,58,'asdasdasd','1',51,'2016-05-17 10:50:52',51,'2016-05-17 10:50:52','0000-00-00 00:00:00'),(96,58,'Doctor','1',51,'2016-05-18 16:23:46',51,'2016-05-18 16:23:46','0000-00-00 00:00:00'),(97,68,'AAAAA','1',51,'2016-06-10 11:27:10',51,'2016-06-10 11:27:20','0000-00-00 00:00:00');

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

insert  into `co_room`(`room_id`,`tenant_id`,`ward_id`,`bed_name`,`maintain_id`,`occupied_status`,`notes`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (9,58,8,'2112',5,'0',NULL,'1',51,'2016-02-04 07:30:53',51,'2016-05-20 16:40:51','0000-00-00 00:00:00'),(10,58,9,'112',7,'0',NULL,'1',51,'2016-02-05 06:12:21',51,'2016-05-13 11:18:23','0000-00-00 00:00:00'),(11,58,8,'113',5,'1','','1',51,'2016-02-05 06:41:04',51,'2016-06-10 15:43:20','0000-00-00 00:00:00'),(12,58,8,'112',6,'1','','1',51,'2016-02-05 06:41:15',51,'2016-06-10 12:51:40','0000-00-00 00:00:00'),(17,58,8,'909',NULL,'0','','1',62,'2016-02-20 03:50:45',51,'2016-05-07 19:18:01','0000-00-00 00:00:00'),(18,60,12,'999',NULL,'0',NULL,'1',59,'2016-02-20 06:03:54',59,'2016-02-20 06:40:01','0000-00-00 00:00:00'),(19,60,12,'4234',NULL,'1','','1',59,'2016-02-20 06:05:14',51,'2016-06-08 15:33:59','0000-00-00 00:00:00'),(20,60,13,'2342',NULL,'0',NULL,'1',59,'2016-02-20 06:05:25',59,'2016-02-20 06:48:56','0000-00-00 00:00:00'),(21,60,14,'111',NULL,'0',NULL,'1',59,'2016-02-20 06:06:12',59,'2016-02-20 07:31:03','0000-00-00 00:00:00'),(23,60,13,'111',NULL,'0',NULL,'1',59,'2016-02-20 06:07:42',51,'2016-06-07 19:37:56','0000-00-00 00:00:00'),(30,60,13,'11',NULL,'0',NULL,'1',66,'2016-02-20 07:56:03',66,'2016-02-20 07:56:03','0000-00-00 00:00:00'),(31,61,15,'101',NULL,'0',NULL,'1',67,'2016-02-23 04:44:52',67,'2016-02-25 05:20:44','0000-00-00 00:00:00'),(32,61,15,'102',NULL,'0',NULL,'1',67,'2016-02-23 04:45:03',67,'2016-02-25 05:29:44','0000-00-00 00:00:00'),(33,61,15,'103',NULL,'0',NULL,'1',67,'2016-02-23 04:45:13',NULL,'2016-02-23 04:47:42','0000-00-00 00:00:00'),(34,61,16,'104',NULL,'0',NULL,'1',67,'2016-02-23 04:48:06',67,'2016-02-23 04:48:06','0000-00-00 00:00:00'),(35,61,16,'105',NULL,'0',NULL,'1',67,'2016-02-23 04:48:22',67,'2016-02-25 05:38:13','0000-00-00 00:00:00'),(36,61,16,'106',NULL,'0',NULL,'1',67,'2016-02-23 04:48:46',67,'2016-02-23 04:48:46','0000-00-00 00:00:00'),(37,58,8,'899',NULL,'0',NULL,'1',51,'2016-05-20 11:05:09',51,'2016-05-24 14:06:51','0000-00-00 00:00:00'),(38,58,8,'4444',NULL,'0',NULL,'1',51,'2016-05-20 16:43:55',51,'2016-05-20 16:47:41','0000-00-00 00:00:00'),(39,58,8,'787',NULL,'0','aaddd aaaasd asdasdsd','1',51,'2016-05-25 10:52:24',51,'2016-05-25 11:01:23','0000-00-00 00:00:00'),(40,58,8,'963',NULL,'0',NULL,'1',51,'2016-05-25 11:00:41',51,'2016-05-25 11:00:41','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

/*Data for the table `pat_admission` */

insert  into `pat_admission`(`admn_id`,`tenant_id`,`patient_id`,`encounter_id`,`status_date`,`consultant_id`,`floor_id`,`ward_id`,`room_id`,`room_type_id`,`admission_status`,`status`,`notes`,`is_swap`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (22,58,91,18,'2016-06-10 15:43:08',54,7,8,11,9,'A','1',NULL,0,51,'2016-06-10 15:43:20',51,'2016-06-10 15:43:20','0000-00-00 00:00:00');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `pat_billing_recurring` */

insert  into `pat_billing_recurring`(`recurr_id`,`tenant_id`,`encounter_id`,`patient_id`,`recurr_date`,`room_type_id`,`room_type`,`charge_item_id`,`charge_item`,`charge_amount`,`recurr_group`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`,`executed_at`) values (11,58,18,91,'2016-06-10',9,'ac',1,'Test','300.00',22,'1',51,'2016-06-10 15:43:20',51,'2016-06-10 15:43:20','0000-00-00 00:00:00',NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

insert  into `pat_document_types`(`doc_type_id`,`tenant_id`,`doc_type`,`doc_type_name`,`document_xml`,`document_xslt`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,60,'CH','Case History','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<FIELDS>\r\n    <GROUP>\r\n        <PANELHEADER>Demographic Details</PANELHEADER>\r\n        <PANELBODY>\r\n            <FIELD id=\"name\" type=\"TextBox\" label=\"Name\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">txtName</PROPERTY>\r\n                    <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    <PROPERTY name=\"name\">name</PROPERTY>\r\n                </PROPERTIES>\r\n            </FIELD>\r\n\r\n            <FIELD id=\"age\" type=\"TextBox\" label=\"Age\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">txtage</PROPERTY>\r\n                    <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                    <PROPERTY name=\"name\">age</PROPERTY>\r\n                </PROPERTIES>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"gender\" type=\"RadioButtonList\" label=\"Gender\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">gender</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Male\" id=\"RBGender1\" Selected=\"False\">Male</LISTITEM>\r\n                    <LISTITEM value=\"Female\" id=\"RBGender2\" Selected=\"False\">Female</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"address\" type=\"TextBox\" label=\"Address\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">txtAddress</PROPERTY>\r\n                    <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    <PROPERTY name=\"name\">address</PROPERTY>\r\n                </PROPERTIES>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"referral_details\" type=\"CheckBoxList\" label=\"Referral Details\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">referral_details[]</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Self\" id=\"RBRefferals1\" Selected=\"False\">Self</LISTITEM>\r\n                    <LISTITEM value=\"General Practitioner\" id=\"RBRefferals2\" Selected=\"False\">General Practitioner</LISTITEM>\r\n                    <LISTITEM value=\"Neighbours\" id=\"RBRefferals3\" Selected=\"False\">Neighbours</LISTITEM>\r\n                    <LISTITEM value=\"Traditional healer\" id=\"RBRefferals4\" Selected=\"False\">Traditional healer</LISTITEM>\r\n                    <LISTITEM value=\"Other patient\" id=\"RBRefferals5\" Selected=\"False\">Other patient</LISTITEM>\r\n                    <LISTITEM value=\"Other psychiatrist\" id=\"RBRefferals6\" Selected=\"False\">Other psychiatrist</LISTITEM>\r\n                    <LISTITEM value=\"Media\" id=\"RBRefferals7\" Selected=\"False\">Media</LISTITEM>\r\n                    <LISTITEM value=\"Others\" id=\"RBRefferals8\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'referral_details_other\');\">Others</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"referral_details_other\" type=\"TextBox\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">referral_details_other</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                        <PROPERTY name=\"name\">referral_details_other</PROPERTY>\r\n                        <PROPERTY name=\"placeholder\">Other Referral Details</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n                      \r\n            <FIELD id=\"education\" type=\"RadioButtonList\" required=\"true\" label=\"Education\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">education</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Not Educated\" id=\"RBEducation1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'educationnote\');\">Not Educated</LISTITEM>\r\n                    <LISTITEM value=\"Primary\" id=\"RBEducation2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'educationnote\');\">Primary</LISTITEM>\r\n                    <LISTITEM value=\"High School\" id=\"RBEducation3\" Selected=\"False\" onclick=\"  OThersvisible(this.id,\'educationnote\');\">High School</LISTITEM>\r\n                    <LISTITEM value=\"Graduate\" id=\"RBEducation4\" Selected=\"False\" onclick=\" OThersvisible(this.id,\'educationnote\');\">Graduate</LISTITEM>\r\n                    <LISTITEM value=\"Post Graduate\" id=\"RBEducation5\" Selected=\"False\" onclick=\" OThersvisible(this.id,\'educationnote\');\">Post Graduate</LISTITEM>\r\n                    <LISTITEM value=\"Other\" id=\"RBEducation6\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'educationnote\');\">Other</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"educationnote\" type=\"TextBox\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">educationnote</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                        <PROPERTY name=\"name\">educationnote</PROPERTY>\r\n                        <PROPERTY name=\"placeholder\">Education Notes</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n                      \r\n            <FIELD id=\"occupation\" type=\"RadioButtonList\" label=\"Occupation\" re1quired=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">occupation</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Employed\" id=\"RBoccupation1\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'occupationnote\');\">Employed</LISTITEM>\r\n                    <LISTITEM value=\"UnEmployed\" id=\"RBoccupation2\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'occupationnote\');\">UnEmployed</LISTITEM>\r\n                    <LISTITEM value=\"Homemaker\" id=\"RBoccupation3\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'occupationnote\');\">Homemaker</LISTITEM>\r\n                    <LISTITEM value=\"Student\" id=\"RBoccupation4\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'occupationnote\');\">Student</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"occupationnote\" type=\"TextBox\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">occupationnote</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                        <PROPERTY name=\"name\">occupationnote</PROPERTY>\r\n                        <PROPERTY name=\"placeholder\">Occupation Notes</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"martial_status\" type=\"RadioButtonList\" label=\"Martial Status\" required=\"true\" >\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">martial_status</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Never married\" id=\"RBMartial1\" Selected=\"False\">Never married</LISTITEM>\r\n                    <LISTITEM value=\"Married\" id=\"RBMartial2\" Selected=\"False\">Married</LISTITEM>\r\n                    <LISTITEM value=\"Separated\" id=\"RBMartial3\" Selected=\"False\">Separated</LISTITEM>\r\n                    <LISTITEM value=\"Divorced\" id=\"RBMartial4\" Selected=\"False\">Divorced</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"religion\" type=\"RadioButtonList\" label=\"Religion\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">religion</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Hindu\" id=\"RBReligion1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'religionother\',\'none\');\">Hindu</LISTITEM>\r\n                    <LISTITEM value=\"Muslim\" id=\"RBReligion2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'religionother\',\'none\');\">Muslim</LISTITEM>\r\n                    <LISTITEM value=\"Christian\" id=\"RBReligion3\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'religionother\',\'none\');\">Christian</LISTITEM>\r\n                    <LISTITEM value=\"Others\" id=\"RBReligion4\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'religionother\',\'block\');\">Others</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"religionother\" type=\"TextBox\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">religionother</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                        <PROPERTY name=\"name\">religionother</PROPERTY>\r\n                        <PROPERTY name=\"placeholder\">Religion Other</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"status\" type=\"RadioButtonList\" label=\"Status\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">status</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Lower\" id=\"RBstatus1\" Selected=\"False\">Lower</LISTITEM>\r\n                    <LISTITEM value=\"Middle\" id=\"RBstatus2\" Selected=\"False\">Middle</LISTITEM>\r\n                    <LISTITEM value=\"Upper\" id=\"RBstatus3\" Selected=\"False\">Upper</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"place_of_living\" type=\"RadioButtonList\" label=\"Place of living\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">place_of_living</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Rural\" id=\"RBliving1\" Selected=\"False\">Rural</LISTITEM>\r\n                    <LISTITEM value=\"Urban\" id=\"RBliving2\" Selected=\"False\">Urban</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD type=\"Header2\" label=\"Informant\"></FIELD>\r\n            \r\n            <FIELD id=\"relationship\" type=\"RadioButtonList\" label=\"Relationship\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">relationship</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Self\" id=\"RBRelation1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'relationshipother\',\'none\');\">Self</LISTITEM>\r\n                    <LISTITEM value=\"Father\" id=\"RBRelation2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'relationshipother\',\'none\');\">Father</LISTITEM>\r\n                    <LISTITEM value=\"Mother\" id=\"RBRelation3\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'relationshipother\',\'none\');\">Mother</LISTITEM>\r\n                    <LISTITEM value=\"Sibling\" id=\"RBRelation4\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'relationshipother\',\'none\');\">Sibling</LISTITEM>\r\n                    <LISTITEM value=\"Spouse\" id=\"RBRelation5\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'relationshipother\',\'none\');\">Spouse</LISTITEM>\r\n                    <LISTITEM value=\"Children\" id=\"RBRelation6\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'relationshipother\',\'none\');\">Children</LISTITEM>\r\n                    <LISTITEM value=\"Friend\" id=\"RBRelation7\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'relationshipother\',\'none\');\">Friend</LISTITEM>\r\n                    <LISTITEM value=\"Others\" id=\"RBRelation8\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'relationshipother\',\'block\');\">Others</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"relationshipother\" type=\"TextBox\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">relationshipother</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                        <PROPERTY name=\"name\">relationshipother</PROPERTY>\r\n                        <PROPERTY name=\"placeholder\">Relationship Other</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"primary_care_giver\" type=\"RadioButtonList\" label=\"Primary Care giver\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">primary_care_giver</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Yes\" id=\"RBPrimarycare1\" Selected=\"False\">Yes</LISTITEM>\r\n                    <LISTITEM value=\"No\" id=\"RBPrimarycare2\" Selected=\"False\">No</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"duration_of_relationship\" type=\"TextBox\" label=\"Duration of Relationship\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">txtrelduration</PROPERTY>\r\n                    <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                    <PROPERTY name=\"name\">duration_of_relationship</PROPERTY>\r\n                </PROPERTIES>\r\n                <FIELD id=\"ddlrelation\" type=\"DropDownList\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">ddlrelation</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"name\">ddlrelation</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Yrs\" Selected=\"True\">Yrs</LISTITEM>\r\n                        <LISTITEM value=\"Months\" Selected=\"False\">Months</LISTITEM>\r\n                        <LISTITEM value=\"Weeks\" Selected=\"False\">Weeks</LISTITEM>\r\n                        <LISTITEM value=\"Days\" Selected=\"False\">Days</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"information\" type=\"RadioButtonList\" label=\"Information\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">information</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Reliable\" id=\"RBInfo1\" Selected=\"False\">Reliable</LISTITEM>\r\n                    <LISTITEM value=\"Unreliable\" id=\"RBInfo2\" Selected=\"False\">Unreliable</LISTITEM>\r\n                    <LISTITEM value=\"Adequate\" id=\"RBInfo3\" Selected=\"False\">Adequate</LISTITEM>\r\n                    <LISTITEM value=\"Inadequate\" id=\"RBInfo4\" Selected=\"False\">Inadequate</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n        </PANELBODY>\r\n    </GROUP>\r\n    \r\n    <GROUP>\r\n        <PANELHEADER>Presenting Compliants (In chronological order)</PANELHEADER>\r\n        <PANELBODY>\r\n            <FIELD type=\"RadGrid\" ADDButton=\"True\" ADDButtonID=\"RGCompliantadd\" AddButtonTableId=\"RGCompliant\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">RGCompliant</PROPERTY>\r\n                    <PROPERTY name=\"class\">table table-bordered</PROPERTY>\r\n                </PROPERTIES>\r\n                <HEADER>\r\n                    <TH>Complaints</TH>\r\n                    <TH>Duration</TH>\r\n                </HEADER>\r\n                <COLUMNS>\r\n                    <FIELD id=\"txtComplaints\" type=\"TextBox\" HeaderText=\"Complaints\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txtComplaints</PROPERTY>\r\n                            <PROPERTY name=\"name\">txtComplaints</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                    <FIELD id=\"txtDuration\" type=\"TextBox\" HeaderText=\"Duration\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txtDuration</PROPERTY>\r\n                            <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                            <PROPERTY name=\"name\">txtDuration</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <FIELD id=\"DDLDuration\" type=\"DropDownList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">DDLDuration</PROPERTY>\r\n                                <PROPERTY name=\"name\">DDLDuration</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"Yrs\" Selected=\"False\">Yrs</LISTITEM>\r\n                                <LISTITEM value=\"Months\" Selected=\"False\">Months</LISTITEM>\r\n                                <LISTITEM value=\"Weeks\" Selected=\"False\">Weeks</LISTITEM>\r\n                                <LISTITEM value=\"Days\" Selected=\"False\">Days</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                    </FIELD>\r\n                </COLUMNS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"total_duration\" type=\"TextBox\" label=\"Total Duration\" required=\"true\" >\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">txtillduration</PROPERTY>\r\n                    <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                    <PROPERTY name=\"name\">total_duration</PROPERTY>\r\n                </PROPERTIES>\r\n                <FIELD id=\"ddlillduration\" type=\"DropDownList\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">ddlillduration</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"name\">ddlillduration</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Yrs\" Selected=\"False\">Yrs</LISTITEM>\r\n                        <LISTITEM value=\"Months\" Selected=\"False\">Months</LISTITEM>\r\n                        <LISTITEM value=\"Weeks\" Selected=\"False\">Weeks</LISTITEM>\r\n                        <LISTITEM value=\"Days\" Selected=\"False\">Days</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"mode_of_onset\" type=\"RadioButtonList\" label=\"Mode of Onset\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">mode_of_onset</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Abrupt\" id=\"RBmode1\" Selected=\"False\">Abrupt</LISTITEM>\r\n                    <LISTITEM value=\"Acute\" id=\"RBmode2\" Selected=\"False\">Acute</LISTITEM>\r\n                    <LISTITEM value=\"Subacute\" id=\"RBmode3\" Selected=\"False\">Subacute</LISTITEM>\r\n                    <LISTITEM value=\"Insidious\" id=\"RBmode4\" Selected=\"False\">Insidious</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"course_type\" type=\"RadioButtonList\" label=\"Course type\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">course_type</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Continuous\" id=\"RBcourse1\" Selected=\"False\">Continuous</LISTITEM>\r\n                    <LISTITEM value=\"Episodic\" id=\"RBcourse2\" Selected=\"False\">Episodic</LISTITEM>\r\n                    <LISTITEM value=\"Fluctuating\" id=\"RBcourse3\" Selected=\"False\">Fluctuating</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"precipitating_factor\" type=\"CheckBoxList\" label=\"Precipitating factor\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">precipitating_factor[]</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Bereavement\" id=\"RBpresent1\" Selected=\"False\">Bereavement</LISTITEM>\r\n                    <LISTITEM value=\"Financial loss\" id=\"RBpresent2\" Selected=\"False\">Financial loss</LISTITEM>\r\n                    <LISTITEM value=\"Family conflicts\" id=\"RBpresent3\" Selected=\"False\">Family conflicts</LISTITEM>\r\n                    <LISTITEM value=\"Difficulty at work\" id=\"RBpresent4\" Selected=\"False\">Difficulty at work</LISTITEM>\r\n                    <LISTITEM value=\"Physical ailment\" id=\"RBpresent5\" Selected=\"False\">Physical ailment</LISTITEM>\r\n                    <LISTITEM value=\"Relationship problems\" id=\"RBpresent6\" Selected=\"False\">Relationship problems</LISTITEM>\r\n                    <LISTITEM value=\"Others\" id=\"RBpresent7\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'precipitating_factor_other\');\">Others</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"precipitating_factor_other\" type=\"TextBox\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">precipitating_factor_other</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                        <PROPERTY name=\"name\">precipitating_factor_other</PROPERTY>\r\n                        <PROPERTY name=\"placeholder\">Other Precipitating Factor</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"nature\" type=\"RadioButtonList\" label=\"Nature\" required=\"true\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">nature</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Progressive\" id=\"RBnature1\" Selected=\"False\">Progressive</LISTITEM>\r\n                    <LISTITEM value=\"Improving\" id=\"RBnature2\" Selected=\"False\">Improving</LISTITEM>\r\n                    <LISTITEM value=\"Static\" id=\"RBnature3\" Selected=\"False\">Static</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n        </PANELBODY>\r\n    </GROUP>\r\n    \r\n    <GROUP>\r\n        <PANELHEADER>History Of Presenting Illness</PANELHEADER>\r\n        <PANELBODY>\r\n            <FIELD id=\"history_presenting_illness\" type=\"textareaFull\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">history_presenting_illness</PROPERTY>\r\n                    <PROPERTY name=\"name\">history_presenting_illness</PROPERTY>\r\n                    <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    <PROPERTY name=\"rows\">6</PROPERTY>\r\n                </PROPERTIES>\r\n            </FIELD>\r\n            \r\n            <FIELD type=\"Header2\" label=\"Associated Disturbances\"></FIELD>\r\n            \r\n            <FIELD id=\"sleep\" type=\"RadioButtonList\" label=\"Sleep\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">sleep</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Premorbid\" id=\"sleep1\" Selected=\"False\">Premorbid</LISTITEM>\r\n                    <LISTITEM value=\"Increased\" id=\"sleep2\" Selected=\"False\">Increased</LISTITEM>\r\n                    <LISTITEM value=\"Decreased\" id=\"sleep3\" Selected=\"False\">Decreased</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"appetite\" type=\"RadioButtonList\" label=\"Appetite\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">appetite</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Premorbid\" id=\"appetite1\" Selected=\"False\">Premorbid</LISTITEM>\r\n                    <LISTITEM value=\"Increased\" id=\"appetite2\" Selected=\"False\">Increased</LISTITEM>\r\n                    <LISTITEM value=\"Decreased\" id=\"appetite3\" Selected=\"False\">Decreased</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"weight\" type=\"RadioButtonList\" label=\"Weight\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">weight</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Premorbid\" id=\"weight1\" Selected=\"False\">Premorbid</LISTITEM>\r\n                    <LISTITEM value=\"Increased\" id=\"weight2\" Selected=\"False\">Increased</LISTITEM>\r\n                    <LISTITEM value=\"Decreased\" id=\"weight3\" Selected=\"False\">Decreased</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"sexual_functioning\" type=\"RadioButtonList\" label=\"Sexual Functioning\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">sexual_functioning</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Premorbid\" id=\"sexual_functioning1\" Selected=\"False\">Premorbid</LISTITEM>\r\n                    <LISTITEM value=\"Increased\" id=\"sexual_functioning2\" Selected=\"False\">Increased</LISTITEM>\r\n                    <LISTITEM value=\"Decreased\" id=\"sexual_functioning3\" Selected=\"False\">Decreased</LISTITEM>\r\n                </LISTITEMS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"social_functioning\" type=\"RadioButtonList\" label=\"Social Functioning\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">social_functioning</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Intact\" id=\"social_functioning1\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'social_functioning_radio_div\', \'none\');\">Intact</LISTITEM>\r\n                    <LISTITEM value=\"Impaired\" id=\"social_functioning2\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'social_functioning_radio_div\', \'block\');\">Impaired</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"social_functioning_radio\" type=\"RadioButtonList\" label=\"Severity\" Backcontrols=\"true\" Backdivid=\"social_functioning_radio_div\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">social_functioning_radio</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Mild\" id=\"social_functioning_radio1\" Selected=\"False\">Mild</LISTITEM>\r\n                        <LISTITEM value=\"Moderate\" id=\"social_functioning_radio2\" Selected=\"False\">Moderate</LISTITEM>\r\n                        <LISTITEM value=\"Severe\" id=\"social_functioning_radio3\" Selected=\"False\">Severe</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"occupational_functioning\" type=\"RadioButtonList\" label=\"Occupational Functioning\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">occupational_functioning</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"Intact\" id=\"occupational_functioning1\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'occupational_functioning_radio_div\', \'none\');\">Intact</LISTITEM>\r\n                    <LISTITEM value=\"Impaired\" id=\"occupational_functioning2\" Selected=\"False\" onclick=\"OThersvisible(this.id, \'occupational_functioning_radio_div\', \'block\');\">Impaired</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"occupational_functioning_radio\" type=\"RadioButtonList\" label=\"Severity\" Backcontrols=\"true\" Backdivid=\"occupational_functioning_radio_div\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">occupational_functioning_radio</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Mild\" id=\"occupational_functioning_radio1\" Selected=\"False\">Mild</LISTITEM>\r\n                        <LISTITEM value=\"Moderate\" id=\"occupational_functioning_radio2\" Selected=\"False\">Moderate</LISTITEM>\r\n                        <LISTITEM value=\"Severe\" id=\"occupational_functioning_radio3\" Selected=\"False\">Severe</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n            </FIELD>\r\n        </PANELBODY>\r\n    </GROUP>\r\n    \r\n    <GROUP>\r\n        <PANELHEADER>Past History</PANELHEADER>\r\n        <PANELBODY>\r\n            <FIELD type=\"Header2\" label=\"Past Psychiatric History\"></FIELD>\r\n            \r\n            <FIELD id=\"similar_episodes\" type=\"RadioButtonList\" label=\"Similar Episodes\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"name\">similar_episodes</PROPERTY>\r\n                </PROPERTIES>\r\n                <LISTITEMS>\r\n                    <LISTITEM value=\"No\" id=\"similar_episodes1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'similar_episodes_ddl_div\',\'none\');\">No</LISTITEM>\r\n                    <LISTITEM value=\"Yes\" id=\"similar_episodes2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'similar_episodes_ddl_div\',\'block\');\">Yes</LISTITEM>\r\n                </LISTITEMS>\r\n                <FIELD id=\"similar_episodes_ddl\" type=\"DropDownList\" label=\"Number of Episodes\" Backcontrols=\"true\" Backdivid=\"similar_episodes_ddl_div\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">similar_episodes_ddl</PROPERTY>\r\n                        <PROPERTY name=\"name\">similar_episodes_ddl</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"--Select--\" Selected=\"False\">--Select--</LISTITEM>\r\n                        <LISTITEM value=\"1\" Selected=\"False\">1</LISTITEM>\r\n                        <LISTITEM value=\"2\" Selected=\"False\">2</LISTITEM>\r\n                        <LISTITEM value=\"3\" Selected=\"False\">3</LISTITEM>\r\n                        <LISTITEM value=\"4\" Selected=\"False\">4</LISTITEM>\r\n                        <LISTITEM value=\"5\" Selected=\"False\">5</LISTITEM>\r\n                        <LISTITEM value=\"6\" Selected=\"False\">6</LISTITEM>\r\n                        <LISTITEM value=\"7\" Selected=\"False\">7</LISTITEM>\r\n                        <LISTITEM value=\"8\" Selected=\"False\">8</LISTITEM>\r\n                        <LISTITEM value=\"9\" Selected=\"False\">9</LISTITEM>\r\n                        <LISTITEM value=\"10\" Selected=\"False\">10</LISTITEM>\r\n                        <LISTITEM value=\"11\" Selected=\"False\">11</LISTITEM>\r\n                        <LISTITEM value=\"12\" Selected=\"False\">12</LISTITEM>\r\n                        <LISTITEM value=\"13\" Selected=\"False\">13</LISTITEM>\r\n                        <LISTITEM value=\"14\" Selected=\"False\">14</LISTITEM>\r\n                        <LISTITEM value=\"15\" Selected=\"False\">15</LISTITEM>\r\n                        <LISTITEM value=\"16\" Selected=\"False\">16</LISTITEM>\r\n                        <LISTITEM value=\"17\" Selected=\"False\">17</LISTITEM>\r\n                        <LISTITEM value=\"18\" Selected=\"False\">18</LISTITEM>\r\n                        <LISTITEM value=\"19\" Selected=\"False\">19</LISTITEM>\r\n                        <LISTITEM value=\"20\" Selected=\"False\">20</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"past_psychiatric_history\" type=\"textareaFull\" label=\"Notes\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">past_psychiatric_history</PROPERTY>\r\n                    <PROPERTY name=\"name\">past_psychiatric_history</PROPERTY>\r\n                    <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    <PROPERTY name=\"rows\">6</PROPERTY>\r\n                </PROPERTIES>\r\n            </FIELD>\r\n            \r\n            <FIELD type=\"Header2\" label=\"Past Medical History\"></FIELD>\r\n            \r\n            <FIELD type=\"RadGrid\" ADDButton=\"True\" ADDButtonID=\"RGMedHisadd\" AddButtonTableId=\"RGMedicalHistory\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">RGMedicalHistory</PROPERTY>\r\n                    <PROPERTY name=\"class\">table table-bordered</PROPERTY>\r\n                </PROPERTIES>\r\n                <HEADER>\r\n                    <TH>Complaints</TH>\r\n                    <TH>Duration</TH>\r\n                    <TH>Currently under treatment</TH>\r\n                </HEADER>\r\n                <COLUMNS>\r\n                    <FIELD id=\"DDLMedHis\" type=\"DropDownList\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">DDLMedHis</PROPERTY>\r\n                            <PROPERTY name=\"name\">DDLMedHis</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"--Select--\" Selected=\"False\">--Select--</LISTITEM>\r\n                            <LISTITEM value=\"Diabetes\" Selected=\"False\">Diabetes</LISTITEM>\r\n                            <LISTITEM value=\"Hypertension\" Selected=\"False\">Hypertension</LISTITEM>\r\n                            <LISTITEM value=\"Tuberculosis\" Selected=\"False\">Tuberculosis</LISTITEM>\r\n                            <LISTITEM value=\"Hepatitis\" Selected=\"False\">Hepatitis</LISTITEM>\r\n                            <LISTITEM value=\"Asthma\" Selected=\"False\">Asthma</LISTITEM>\r\n                            <LISTITEM value=\"Bronchitis\" Selected=\"False\">Bronchitis</LISTITEM>\r\n                            <LISTITEM value=\"Head injury/LOC\" Selected=\"False\">Head injury/LOC</LISTITEM>\r\n                            <LISTITEM value=\"Seizures\" Selected=\"False\">Seizures</LISTITEM>\r\n                            <LISTITEM value=\"Cerebrovascular Accidents\" Selected=\"False\">Cerebrovascular Accidents</LISTITEM>\r\n                            <LISTITEM value=\"Immuno compromised state\" Selected=\"False\">Immuno compromised state</LISTITEM>\r\n                            <LISTITEM value=\"Mycocardial Infarction\" Selected=\"False\">Mycocardial Infarction</LISTITEM>\r\n                            <LISTITEM value=\"Allergies\" Selected=\"False\">Allergies</LISTITEM>\r\n                            <LISTITEM value=\"IHD\" Selected=\"False\">IHD</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                    \r\n                    <FIELD id=\"TxtMedHisDuration\" type=\"TextBox\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">TxtMedHisDuration</PROPERTY>\r\n                            <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                            <PROPERTY name=\"name\">TxtMedHisDuration</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <FIELD id=\"DDLMedHisDuration\" type=\"DropDownList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">DDLMedHisDuration</PROPERTY>\r\n                                <PROPERTY name=\"name\">DDLMedHisDuration</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"Yrs\" Selected=\"False\">Yrs</LISTITEM>\r\n                                <LISTITEM value=\"Months\" Selected=\"False\">Months</LISTITEM>\r\n                                <LISTITEM value=\"Weeks\" Selected=\"False\">Weeks</LISTITEM>\r\n                                <LISTITEM value=\"Days\" Selected=\"False\">Days</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                    </FIELD>\r\n                    \r\n                    <FIELD id=\"radio_med_his_currently_under_treatment\" type=\"RadioButtonList\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"name\">radio_med_his_currently_under_treatment</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"Yes\" id=\"radio_med_his_currently_under_treatment1\" Selected=\"False\">Yes</LISTITEM>\r\n                            <LISTITEM value=\"No\" id=\"radio_med_his_currently_under_treatment2\" Selected=\"False\">No</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                </COLUMNS>\r\n            </FIELD>\r\n            \r\n            <FIELD id=\"past_medical_history_notes\" type=\"textareaFull\" label=\"Notes\">\r\n                <PROPERTIES>\r\n                    <PROPERTY name=\"id\">past_medical_history_notes</PROPERTY>\r\n                    <PROPERTY name=\"name\">past_medical_history_notes</PROPERTY>\r\n                    <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                    <PROPERTY name=\"rows\">6</PROPERTY>\r\n                </PROPERTIES>\r\n            </FIELD>\r\n            \r\n            <!-- 08/06/2016-->\r\n            <FIELD type=\"PanelBar\" label=\"Treatment History\" target_div=\"treatment_history\">\r\n                <FIELD type=\"Header2\" label=\"Phamacotherapy\"></FIELD>\r\n                \r\n                <FIELD type=\"RadGrid\" ADDButton=\"True\" ADDButtonID=\"RGPhamacoadd\" AddButtonTableId=\"RGPhamaco\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">RGPhamaco</PROPERTY>\r\n                        <PROPERTY name=\"class\">table table-bordered</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <HEADER>\r\n                        <TH>Drug name</TH>\r\n                        <TH>Duration</TH>\r\n                        <TH>Currently under treatment</TH>\r\n                        <TH>Side effects</TH>\r\n                    </HEADER>\r\n                    <COLUMNS>\r\n                        <FIELD id=\"txtPhamacoDrugName\" type=\"TextBox\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">txtPhamacoDrugName</PROPERTY>\r\n                                <PROPERTY name=\"name\">txtPhamacoDrugName</PROPERTY>\r\n                            </PROPERTIES>\r\n                        </FIELD>\r\n                        <FIELD id=\"txtPhamacoDuration\" type=\"TextBox\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">txtPhamacoDuration</PROPERTY>\r\n                                <PROPERTY name=\"onkeydown\">return isNumericKeyStroke()</PROPERTY>\r\n                                <PROPERTY name=\"name\">txtPhamacoDuration</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <FIELD id=\"DDLPhamacoDuration\" type=\"DropDownList\">\r\n                                <PROPERTIES>\r\n                                    <PROPERTY name=\"id\">DDLPhamacoDuration</PROPERTY>\r\n                                    <PROPERTY name=\"name\">DDLPhamacoDuration</PROPERTY>\r\n                                </PROPERTIES>\r\n                                <LISTITEMS>\r\n                                    <LISTITEM value=\"Yrs\" Selected=\"False\">Yrs</LISTITEM>\r\n                                    <LISTITEM value=\"Months\" Selected=\"False\">Months</LISTITEM>\r\n                                    <LISTITEM value=\"Weeks\" Selected=\"False\">Weeks</LISTITEM>\r\n                                    <LISTITEM value=\"Days\" Selected=\"False\">Days</LISTITEM>\r\n                                </LISTITEMS>\r\n                            </FIELD>\r\n                        </FIELD>\r\n                        <FIELD id=\"radioPhamacoCurrentlyUnderTreatment\" type=\"RadioButtonList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"name\">radioPhamacoCurrentlyUnderTreatment</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"Adequate\" id=\"radioPhamacoCurrentlyUnderTreatment1\" Selected=\"False\">Adequate</LISTITEM>\r\n                                <LISTITEM value=\"Inadequate\" id=\"radioPhamacoCurrentlyUnderTreatment2\" Selected=\"False\">Inadequate</LISTITEM>\r\n                                <LISTITEM value=\"Partial\" id=\"radioPhamacoCurrentlyUnderTreatment3\" Selected=\"False\">Partial</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                        <FIELD id=\"txtPhamacoSideEffects\" type=\"TextBox\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">txtPhamacoSideEffects</PROPERTY>\r\n                                <PROPERTY name=\"name\">txtPhamacoSideEffects</PROPERTY>\r\n                            </PROPERTIES>\r\n                        </FIELD>\r\n                    </COLUMNS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"rb_pb_treatmenthistory\" type=\"RadioButtonList\" label=\"Medication Compliance\" required=\"true\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">rb_pb_treatmenthistory</PROPERTY>\r\n                        <PROPERTY name=\"ToolTip\">\r\n                            In the last 3 monts:\r\n                            Continuous intake=complaint\r\n                            Missed medic for less than 1wk= partially adherent\r\n                            Missed medic for 1wk or more=non-complaint\r\n                            (Criteria used by- Olfson et al,2000)\r\n                        </PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM id=\"rb_pb_treatmenthistory1\" value=\"Non-complaint\" Selected=\"False\">Non-complaint</LISTITEM>\r\n                        <LISTITEM id=\"rb_pb_treatmenthistory2\" value=\"Complaint\" Selected=\"False\">Complaint</LISTITEM>\r\n                        <LISTITEM id=\"rb_pb_treatmenthistory3\" value=\"Partially Complaint\" Selected=\"False\">Partially Complaint</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"Header2\" label=\"Electro Convulsive therapy\"></FIELD>\r\n                \r\n                <FIELD id=\"previous_ects\" type=\"RadioButtonList\" label=\"Previous ECT\'s\" Backcontrols=\"true\" Backdivid=\"previous_ects_radio_div\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">previous_ects</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"No\" id=\"previous_ects1\"  Selected=\"False\" onclick=\"OThersvisible(this.id,\'previous_ects_radio_div\',\'none\');\">No</LISTITEM>\r\n                        <LISTITEM value=\"Yes\" id=\"previous_ects2\"  Selected=\"False\" onclick=\"OThersvisible(this.id,\'previous_ects_radio_div\',\'block\');\">Yes</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"no_of_ects_ddl\" type=\"DropDownList\" label=\"No. of ECT course(s)\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">no_of_ects_ddl</PROPERTY>\r\n                            <PROPERTY name=\"name\">no_of_ects_ddl</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"--Select--\" Selected=\"False\">--Select--</LISTITEM>\r\n                            <LISTITEM value=\"1\" Selected=\"False\">1</LISTITEM>\r\n                            <LISTITEM value=\"2\" Selected=\"False\">2</LISTITEM>\r\n                            <LISTITEM value=\"3\" Selected=\"False\">3</LISTITEM>\r\n                            <LISTITEM value=\"4\" Selected=\"False\">4</LISTITEM>\r\n                            <LISTITEM value=\"5\" Selected=\"False\">5</LISTITEM>\r\n                            <LISTITEM value=\"6\" Selected=\"False\">6</LISTITEM>\r\n                            <LISTITEM value=\"7\" Selected=\"False\">7</LISTITEM>\r\n                            <LISTITEM value=\"8\" Selected=\"False\">8</LISTITEM>\r\n                            <LISTITEM value=\"9\" Selected=\"False\">9</LISTITEM>\r\n                            <LISTITEM value=\"10\" Selected=\"False\">10</LISTITEM>\r\n                            <LISTITEM value=\"11\" Selected=\"False\">11</LISTITEM>\r\n                            <LISTITEM value=\"12\" Selected=\"False\">12</LISTITEM>\r\n                            <LISTITEM value=\"13\" Selected=\"False\">13</LISTITEM>\r\n                            <LISTITEM value=\"14\" Selected=\"False\">14</LISTITEM>\r\n                            <LISTITEM value=\"15\" Selected=\"False\">15</LISTITEM>\r\n                            <LISTITEM value=\"16\" Selected=\"False\">16</LISTITEM>\r\n                            <LISTITEM value=\"17\" Selected=\"False\">17</LISTITEM>\r\n                            <LISTITEM value=\"18\" Selected=\"False\">18</LISTITEM>\r\n                            <LISTITEM value=\"19\" Selected=\"False\">19</LISTITEM>\r\n                            <LISTITEM value=\"20\" Selected=\"False\">20</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                    <FIELD id=\"average_no_of_ects_ddl\" type=\"DropDownList\" label=\"Average no. of ECT session per course\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">average_no_of_ects_ddl</PROPERTY>\r\n                            <PROPERTY name=\"name\">average_no_of_ects_ddl</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"--Select--\" Selected=\"False\">--Select--</LISTITEM>\r\n                            <LISTITEM value=\"1\" Selected=\"False\">1</LISTITEM>\r\n                            <LISTITEM value=\"2\" Selected=\"False\">2</LISTITEM>\r\n                            <LISTITEM value=\"3\" Selected=\"False\">3</LISTITEM>\r\n                            <LISTITEM value=\"4\" Selected=\"False\">4</LISTITEM>\r\n                            <LISTITEM value=\"5\" Selected=\"False\">5</LISTITEM>\r\n                            <LISTITEM value=\"6\" Selected=\"False\">6</LISTITEM>\r\n                            <LISTITEM value=\"7\" Selected=\"False\">7</LISTITEM>\r\n                            <LISTITEM value=\"8\" Selected=\"False\">8</LISTITEM>\r\n                            <LISTITEM value=\"9\" Selected=\"False\">9</LISTITEM>\r\n                            <LISTITEM value=\"10\" Selected=\"False\">10</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                    <FIELD id=\"response_ects_ddl\" type=\"DropDownList\" label=\"Response to ECT (%)\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">response_ects_ddl</PROPERTY>\r\n                            <PROPERTY name=\"name\">response_ects_ddl</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"--Select--\" Selected=\"False\">--Select--</LISTITEM>\r\n                            <LISTITEM value=\"25\" Selected=\"False\">25</LISTITEM>\r\n                            <LISTITEM value=\"50\" Selected=\"False\">50</LISTITEM>\r\n                            <LISTITEM value=\"75\" Selected=\"False\">75</LISTITEM>\r\n                            <LISTITEM value=\"100\" Selected=\"False\">100</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"Header2\" label=\"Counselling/Psychotherapy\"></FIELD>\r\n                \r\n                <FIELD id=\"rb_pb_mostrecentepisode\" type=\"RadioButtonList\" label=\"Most recent episode\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">rb_pb_mostrecentepisode</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Yes\" id=\"rb_pb_mostrecentepisode1\" Selected=\"False\">Yes</LISTITEM>\r\n                        <LISTITEM value=\"No\" id=\"rb_pb_mostrecentepisode2\" Selected=\"False\">No</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"txt_pb_no_of_sessions\" type=\"TextBox\" label=\"No. of sessions\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">txt_pb_no_of_sessions</PROPERTY>\r\n                        <PROPERTY name=\"name\">txt_pb_no_of_sessions</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"rb_pb_Response\" type=\"RadioButtonList\" label=\"Response\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">rb_pb_Response</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Adequate\" id=\"rb_pb_Response1\" Selected=\"False\">Adequate</LISTITEM>\r\n                        <LISTITEM value=\"Inadequate\" id=\"rb_pb_Response2\" Selected=\"False\">Inadequate</LISTITEM>\r\n                        <LISTITEM value=\"Partial\" id=\"rb_pb_Response3\" Selected=\"False\">Partial</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"rb_pb_Response1\" type=\"RadioButtonList\" Backcontrols=\"true\" Backdivid=\"rb_pb_Response1_Div\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">rb_pb_Response1</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Completed\" id=\"rb_pb_Response11\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'rb_pb_Response1_Div\',\'none\');\">Completed</LISTITEM>\r\n                        <LISTITEM value=\"Discontinued\" id=\"rb_pb_Response12\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'rb_pb_Response1_Div\',\'block\');\">Discontinued</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"txt_pb_reason\" type=\"TextBox\" label=\"Reason\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"id\">txt_pb_reason</PROPERTY>\r\n                            <PROPERTY name=\"name\">txt_pb_reason</PROPERTY>\r\n                        </PROPERTIES>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"Header2\" label=\"Alternative Therapies\"></FIELD>\r\n                \r\n                <FIELD type=\"RadGrid\" ADDButton=\"True\" ADDButtonID=\"RGaltadd\" AddButtonTableId=\"RGalt\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">RGalt</PROPERTY>\r\n                        <PROPERTY name=\"class\">table table-bordered</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <HEADER>\r\n                        <TH>Therapy</TH>\r\n                        <TH>Taken</TH>\r\n                        <TH>Currently under treatment</TH>\r\n                    </HEADER>\r\n                    <COLUMNS>\r\n                        <FIELD id=\"ddl_pb_therapy\" type=\"DropDownList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">ddl_pb_therapy</PROPERTY>\r\n                                <PROPERTY name=\"name\">ddl_pb_therapy</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"--Select--\" Selected=\"False\">--Select--</LISTITEM>\r\n                                <LISTITEM value=\"Magico Religious\" Selected=\"False\">Magico Religious</LISTITEM>\r\n                                <LISTITEM value=\"Homeopathy\" Selected=\"False\">Homeopathy</LISTITEM>\r\n                                <LISTITEM value=\"Ayurveda\" Selected=\"False\">Ayurveda</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                        <FIELD id=\"radio_pb_taken\" type=\"RadioButtonList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"name\">radio_pb_taken</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"Yes\" id=\"radio_pb_taken1\" Selected=\"False\">Yes</LISTITEM>\r\n                                <LISTITEM value=\"No\" id=\"radio_pb_taken2\" Selected=\"False\">No</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                        <FIELD id=\"radio_pb_currently_under_taken\" type=\"RadioButtonList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"name\">radio_pb_currently_under_taken</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"Adequate\" id=\"radio_pb_currently_under_taken1\" Selected=\"False\">Adequate</LISTITEM>\r\n                                <LISTITEM value=\"Inadequate\" id=\"radio_pb_currently_under_taken2\" Selected=\"False\">Inadequate</LISTITEM>\r\n                                <LISTITEM value=\"Partial\" id=\"radio_pb_currently_under_taken3\" Selected=\"False\">Partial</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                        \r\n                    </COLUMNS>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"Header2\" label=\"Treatment History Notes\"></FIELD>\r\n                \r\n                <FIELD id=\"treatment_history_notes\" type=\"textareaFull\" label=\"Notes\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">treatment_history_notes</PROPERTY>\r\n                        <PROPERTY name=\"name\">treatment_history_notes</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"rows\">6</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD type=\"PanelBar\" label=\"Family History\" target_div=\"family_history\">\r\n                <FIELD id=\"RBtypeoffamily\" type=\"RadioButtonList\" label=\"Type of Family\" required=\"true\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBtypeoffamily</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Nuclear\" id=\"RBtypeoffamily1\" Selected=\"False\">Nuclear</LISTITEM>\r\n                        <LISTITEM value=\"Joint\" id=\"RBtypeoffamily2\" Selected=\"False\">Joint</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBtypeofmarriage\" type=\"RadioButtonList\" label=\"Type of Marriage\" required=\"true\" Backcontrols=\"true\" Backdivid=\"RBtypeofmarriageDiv\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBtypeofmarriage</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Consanguineous\" id=\"RBtypeofmarriage1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'RBtypeofmarriageDiv\',\'block\');\">Consanguineous</LISTITEM>\r\n                        <LISTITEM value=\"Non-Consanguineous\" id=\"RBtypeofmarriage2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'RBtypeofmarriageDiv\',\'none\');\">Non-Consanguineous</LISTITEM>\r\n                    </LISTITEMS>\r\n                    <FIELD id=\"RBdegreeofconsan\" type=\"RadioButtonList\" label=\"Degree of Consanguinity\" required=\"true\">\r\n                        <PROPERTIES>\r\n                            <PROPERTY name=\"name\">RBdegreeofconsan</PROPERTY>\r\n                        </PROPERTIES>\r\n                        <LISTITEMS>\r\n                            <LISTITEM value=\"II\" id=\"RBdegreeofconsan1\" Selected=\"False\">II</LISTITEM>\r\n                            <LISTITEM value=\"III\" id=\"RBdegreeofconsan2\" Selected=\"False\">III</LISTITEM>\r\n                        </LISTITEMS>\r\n                    </FIELD>\r\n                </FIELD>\r\n                \r\n                <FIELD type=\"RadGrid\" ADDButton=\"True\" ADDButtonID=\"RGfamilyadd\" AddButtonTableId=\"RGfamily\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">RGfamily</PROPERTY>\r\n                        <PROPERTY name=\"class\">table table-bordered</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <HEADER>\r\n                        <TH>Relation</TH>\r\n                        <TH>Illness type</TH>\r\n                        <TH>Treatment</TH>\r\n                    </HEADER>\r\n                    <COLUMNS>\r\n                        <FIELD id=\"ddl_pb_relation\" type=\"DropDownList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"id\">ddl_pb_relation</PROPERTY>\r\n                                <PROPERTY name=\"name\">ddl_pb_relation</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"--Select--\" Selected=\"False\">--Select--</LISTITEM>\r\n                                <LISTITEM value=\"GrandParents\" Selected=\"False\">GrandParents</LISTITEM>\r\n                                <LISTITEM value=\"Parents\" Selected=\"False\">Parents</LISTITEM>\r\n                                <LISTITEM value=\"Siblings\" Selected=\"False\">Siblings</LISTITEM>\r\n                                <LISTITEM value=\"Spouse\" Selected=\"False\">Spouse</LISTITEM>\r\n                                <LISTITEM value=\"Children\" Selected=\"False\">Children</LISTITEM>\r\n                                <LISTITEM value=\"Uncle/Aunt\" Selected=\"False\">Uncle/Aunt</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                        <FIELD id=\"radio_pb_illnesstype\" type=\"RadioButtonList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"name\">radio_pb_illnesstype</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"Similar Illness\" id=\"radio_pb_illnesstype1\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'radio_pb_illnesstype_note\',\'none\');\">Similar Illness</LISTITEM>\r\n                                <LISTITEM value=\"Other Illness\" id=\"radio_pb_illnesstype2\" Selected=\"False\" onclick=\"OThersvisible(this.id,\'radio_pb_illnesstype_note\',\'block\');\">Other Illness</LISTITEM>\r\n                            </LISTITEMS>\r\n                            <FIELD id=\"radio_pb_illnesstype_note\" type=\"TextBox\">\r\n                                <PROPERTIES>\r\n                                    <PROPERTY name=\"id\">radio_pb_illnesstype_note</PROPERTY>\r\n                                    <PROPERTY name=\"class\">form-control hide</PROPERTY>\r\n                                    <PROPERTY name=\"name\">radio_pb_illnesstype_note</PROPERTY>\r\n                                    <PROPERTY name=\"placeholder\">Notes</PROPERTY>\r\n                                </PROPERTIES>\r\n                            </FIELD>\r\n                        </FIELD>\r\n                        <FIELD id=\"radio_pb_treatment\" type=\"RadioButtonList\">\r\n                            <PROPERTIES>\r\n                                <PROPERTY name=\"name\">radio_pb_treatment</PROPERTY>\r\n                            </PROPERTIES>\r\n                            <LISTITEMS>\r\n                                <LISTITEM value=\"Treated\" id=\"radio_pb_treatment1\" Selected=\"False\">Treated</LISTITEM>\r\n                                <LISTITEM value=\"Untreated\" id=\"radio_pb_treatment2\" Selected=\"False\">Untreated</LISTITEM>\r\n                            </LISTITEMS>\r\n                        </FIELD>\r\n                    </COLUMNS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"RBexpressedemotion\" type=\"RadioButtonList\" label=\"Expressed emotions\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"name\">RBexpressedemotion</PROPERTY>\r\n                    </PROPERTIES>\r\n                    <LISTITEMS>\r\n                        <LISTITEM value=\"Consanguineous\" id=\"RBexpressedemotion1\" Selected=\"False\">Hostility</LISTITEM>\r\n                        <LISTITEM value=\"Criticality\" id=\"RBexpressedemotion2\" Selected=\"False\">Criticality</LISTITEM>\r\n                        <LISTITEM value=\"Over involvement\" id=\"RBexpressedemotion3\" Selected=\"False\">Over involvement</LISTITEM>\r\n                        <LISTITEM value=\"Warmth\" id=\"RBexpressedemotion4\" Selected=\"False\">Warmth</LISTITEM>\r\n                    </LISTITEMS>\r\n                </FIELD>\r\n                \r\n                <FIELD id=\"history_family\" type=\"textareaFull\" label=\"Notes\">\r\n                    <PROPERTIES>\r\n                        <PROPERTY name=\"id\">history_family</PROPERTY>\r\n                        <PROPERTY name=\"name\">history_family</PROPERTY>\r\n                        <PROPERTY name=\"class\">form-control</PROPERTY>\r\n                        <PROPERTY name=\"rows\">6</PROPERTY>\r\n                    </PROPERTIES>\r\n                </FIELD>\r\n            </FIELD>\r\n            \r\n            <FIELD type=\"PanelBar\" label=\"Personal History\" target_div=\"personal_history\">\r\n                <FIELD type=\"Header2\" label=\"Birth and Development\"></FIELD>\r\n            </FIELD>\r\n        </PANELBODY>\r\n    </GROUP>\r\n</FIELDS>','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<xsl:stylesheet xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" version=\"1.0\">\r\n    <xsl:output method=\"html\"/>\r\n    <xsl:template match=\"/\">\r\n        <script type=\"text/javascript\" src=\"js/xmlvalidation.js\">&#160;</script> \r\n        \r\n        <form method=\"post\" id=\"xmlform\">\r\n            \r\n            <xsl:for-each select=\"FIELDS/GROUP\">\r\n                <div class=\"panel panel-default\">\r\n                    <div class=\"panel-heading\">\r\n                        <b> \r\n                            <xsl:value-of select=\"PANELHEADER\" /> \r\n                        </b>\r\n                    </div>\r\n                \r\n                    <xsl:for-each select=\"PANELBODY\">\r\n                        <div class=\"panel-body\">\r\n                            <xsl:for-each select=\"FIELD\">\r\n                                <xsl:choose>\r\n                                    \r\n                                    <!-- Main Text Box -->\r\n                                    <xsl:when test=\"@type=\'TextBox\'\">\r\n                                        <div class=\"form-group\">\r\n                                            <label class=\"col-sm-3 control-label\">\r\n                                                <xsl:value-of select=\"@label\" />\r\n                                                <xsl:if test=\"@required=\'true\'\">\r\n                                                    <span class=\"required\"> *</span>\r\n                                                </xsl:if>\r\n                                            </label>\r\n                                            <div class=\"col-sm-9\">\r\n                                                <input type=\"text\">\r\n                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                        <xsl:attribute name=\"{@name}\">\r\n                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                    </xsl:for-each>\r\n                                                </input>\r\n                                                <xsl:if test=\"FIELD\">\r\n                                                    <xsl:for-each select=\"FIELD\">\r\n                                                        <xsl:choose>\r\n                                                            <xsl:when test=\"@type=\'DropDownList\'\">\r\n                                                                <select>\r\n                                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                        <xsl:attribute name=\"{@name}\">\r\n                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                        </xsl:attribute>\r\n                                                                    </xsl:for-each>\r\n                                                                    <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                        <option>\r\n                                                                            <xsl:attribute name=\"value\">\r\n                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                <xsl:attribute name=\"selected\">\r\n                                                                                    <xsl:text>selected</xsl:text>\r\n                                                                                </xsl:attribute>\r\n                                                                            </xsl:if>\r\n                                                                            <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                        </option>\r\n                                                                    </xsl:for-each>\r\n                                                                </select>\r\n                                                            </xsl:when>\r\n                                                        </xsl:choose>\r\n                                                    </xsl:for-each>\r\n                                                </xsl:if>\r\n                                            </div>\r\n                                        </div>\r\n                                        <div class=\"line line-dashed b-b line-lg \"></div>\r\n                                    </xsl:when> \r\n                                    \r\n                                    <!-- Main Radio Button -->                          \r\n                                    <xsl:when test=\"@type=\'RadioButtonList\'\">\r\n                                        <div class=\"form-group\">\r\n                                            <label class=\"col-sm-3 control-label\">\r\n                                                <xsl:value-of select=\"@label\" />\r\n                                                <xsl:if test=\"@required=\'true\'\">\r\n                                                    <span class=\"required\"> *</span>\r\n                                                </xsl:if>\r\n                                            </label>\r\n                                            <div class=\"col-sm-9\">\r\n                                                <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                    <input type=\"radio\">\r\n                                                        <xsl:attribute name=\"value\">\r\n                                                            <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:attribute name=\"id\">\r\n                                                            <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:if test=\"@Selected = \'true\'\">\r\n                                                            <xsl:attribute name=\"checked\">\r\n                                                                <xsl:text>checked</xsl:text>\r\n                                                            </xsl:attribute>\r\n                                                        </xsl:if>\r\n                                                        <xsl:attribute name=\"onclick\">\r\n                                                            <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                            </xsl:attribute>\r\n                                                        </xsl:for-each>\r\n                                                    </input>&#160;\r\n                                                    <label for=\"{@id}\">\r\n                                                        <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                    </label>&#160;&#160;\r\n                                                </xsl:for-each>\r\n                                                <xsl:if test=\"FIELD\">\r\n                                                    <xsl:for-each select=\"FIELD\">\r\n                                                        <xsl:choose>\r\n                                                            <xsl:when test=\"@type=\'TextBox\'\">\r\n                                                                <xsl:value-of select=\"@label\" />\r\n                                                                <input type=\"text\">\r\n                                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                        <xsl:attribute name=\"{@name}\">\r\n                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                        </xsl:attribute>\r\n                                                                    </xsl:for-each>\r\n                                                                </input>\r\n                                                            </xsl:when>\r\n                                                            \r\n                                                            <xsl:when test=\"@type=\'RadioButtonList\'\">\r\n                                                                <xsl:if test=\"@Backcontrols = \'true\'\">\r\n                                                                    <div>\r\n                                                                        <xsl:attribute name=\"id\">\r\n                                                                            <xsl:value-of select=\"@Backdivid\"></xsl:value-of>\r\n                                                                        </xsl:attribute>\r\n                                                                        <xsl:attribute name=\"class\">\r\n                                                                            <xsl:text>hide</xsl:text>\r\n                                                                        </xsl:attribute>\r\n                                                                        <xsl:value-of select=\"@label\" />\r\n                                                                        <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                            <input type=\"radio\">\r\n                                                                                <xsl:attribute name=\"value\">\r\n                                                                                    <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                </xsl:attribute>\r\n                                                                                <xsl:attribute name=\"id\">\r\n                                                                                    <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                                                </xsl:attribute>\r\n                                                                                <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                    <xsl:attribute name=\"checked\">\r\n                                                                                        <xsl:text>checked</xsl:text>\r\n                                                                                    </xsl:attribute>\r\n                                                                                </xsl:if>\r\n                                                                                <xsl:attribute name=\"onclick\">\r\n                                                                                    <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                                                </xsl:attribute>\r\n                                                                                <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                                                    <xsl:attribute name=\"{@name}\">\r\n                                                                                        <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                    </xsl:attribute>\r\n                                                                                </xsl:for-each>\r\n                                                                            </input>\r\n                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>&#160;\r\n                                                                        </xsl:for-each>\r\n                                                                    </div>\r\n                                                                </xsl:if>\r\n                                                            </xsl:when>\r\n                                                            \r\n                                                            <xsl:when test=\"@type=\'DropDownList\'\">\r\n                                                                <xsl:if test=\"@Backcontrols = \'true\'\">\r\n                                                                    <div>\r\n                                                                        <xsl:attribute name=\"id\">\r\n                                                                            <xsl:value-of select=\"@Backdivid\"></xsl:value-of>\r\n                                                                        </xsl:attribute>\r\n                                                                        <xsl:attribute name=\"class\">\r\n                                                                            <xsl:text>hide</xsl:text>\r\n                                                                        </xsl:attribute>\r\n                                                                        <xsl:value-of select=\"@label\" />\r\n                                                                        <select>\r\n                                                                            <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                <xsl:attribute name=\"{@name}\">\r\n                                                                                    <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                </xsl:attribute>\r\n                                                                            </xsl:for-each>\r\n                                                                            <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                <option>\r\n                                                                                    <xsl:attribute name=\"value\">\r\n                                                                                        <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                    </xsl:attribute>\r\n                                                                                    <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                        <xsl:attribute name=\"selected\">\r\n                                                                                            <xsl:text>selected</xsl:text>\r\n                                                                                        </xsl:attribute>\r\n                                                                                    </xsl:if>\r\n                                                                                    <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                </option>\r\n                                                                            </xsl:for-each>\r\n                                                                        </select>\r\n                                                                    </div>\r\n                                                                </xsl:if>\r\n                                                            </xsl:when>\r\n                                                        </xsl:choose>\r\n                                                    </xsl:for-each>\r\n                                                </xsl:if>\r\n                                            </div>\r\n                                        </div>\r\n                                        <div class=\"line line-dashed b-b line-lg \"></div>\r\n                                    </xsl:when>\r\n                                \r\n                                    <!-- Main Checkbox -->\r\n                                    <xsl:when test=\"@type=\'CheckBoxList\'\">\r\n                                        <div class=\"form-group\">\r\n                                            <label class=\"col-sm-3 control-label\">\r\n                                                <xsl:value-of select=\"@label\" />\r\n                                                <xsl:if test=\"@required=\'true\'\">\r\n                                                    <span class=\"required\"> *</span>\r\n                                                </xsl:if>\r\n                                            </label>\r\n                                            <div class=\"col-sm-9\">\r\n                                                <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                    <input type=\"checkbox\">\r\n                                                        <xsl:attribute name=\"value\">\r\n                                                            <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:attribute name=\"id\">\r\n                                                            <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:if test=\"@Selected = \'true\'\">\r\n                                                            <xsl:attribute name=\"checked\">\r\n                                                                <xsl:text>checked</xsl:text>\r\n                                                            </xsl:attribute>\r\n                                                        </xsl:if>\r\n                                                        <xsl:attribute name=\"onclick\">\r\n                                                            <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                            </xsl:attribute>\r\n                                                        </xsl:for-each>\r\n                                                    </input>\r\n                                                    <xsl:value-of select=\"current()\"></xsl:value-of>&#160;\r\n                                                </xsl:for-each>\r\n                                                <xsl:if test=\"FIELD\">\r\n                                                    <xsl:for-each select=\"FIELD\">\r\n                                                        <xsl:choose>\r\n                                                            <xsl:when test=\"@type=\'TextBox\'\">\r\n                                                                <xsl:value-of select=\"@label\" />\r\n                                                                <input type=\"text\">\r\n                                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                        <xsl:attribute name=\"{@name}\">\r\n                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                        </xsl:attribute>\r\n                                                                    </xsl:for-each>\r\n                                                                </input>\r\n                                                            </xsl:when>\r\n                                                        </xsl:choose>\r\n                                                    </xsl:for-each>\r\n                                                </xsl:if>\r\n                                            </div>\r\n                                        </div>\r\n                                        <div class=\"line line-dashed b-b line-lg \"></div>\r\n                                    </xsl:when>\r\n                                \r\n                                    \r\n                                    <!-- Main Header2 -->\r\n                                    <xsl:when test=\"@type=\'Header2\'\">\r\n                                        <h4>\r\n                                            <b> \r\n                                                <xsl:value-of select=\"@label\" /> \r\n                                            </b>\r\n                                        </h4>\r\n                                    </xsl:when>\r\n                                    \r\n                                    <!-- Main Grid -->\r\n                                    <xsl:when test=\"@type=\'RadGrid\'\">\r\n                                        <div class=\"form-group\">\r\n                                            <div class=\"col-sm-12\">\r\n                                                <xsl:if test=\"@ADDButton=\'True\'\">\r\n                                                    <input type=\"button\">\r\n                                                        <xsl:attribute name=\"class\">\r\n                                                            <xsl:text>addMore</xsl:text>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:attribute name=\"value\">\r\n                                                            <xsl:text>Add</xsl:text>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:attribute name=\"id\">\r\n                                                            <xsl:value-of select=\"@ADDButtonID\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                        <xsl:attribute name=\"data-table-id\">\r\n                                                            <xsl:value-of select=\"@AddButtonTableId\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                    </input>\r\n                                                </xsl:if>\r\n                                        \r\n                                                <table>\r\n                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                        <xsl:attribute name=\"{@name}\">\r\n                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                    </xsl:for-each>\r\n                                                    <thead>\r\n                                                        <tr>\r\n                                                            <xsl:for-each select=\"HEADER/TH\">\r\n                                                                <th>\r\n                                                                    <xsl:value-of select=\"current()\" />\r\n                                                                </th>\r\n                                                            </xsl:for-each>\r\n                                                        </tr>\r\n                                                    </thead>\r\n                                                    <tbody>\r\n                                                        <xsl:for-each select=\"COLUMNS\">\r\n                                                            <tr>\r\n                                                                <xsl:for-each select=\"FIELD\">\r\n                                                                    <td>\r\n                                                                        <xsl:choose>\r\n                                                                            <xsl:when test=\"@type=\'TextBox\'\">\r\n                                                                                <input type=\"text\">\r\n                                                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                        <xsl:attribute name=\"{@name}\">\r\n                                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                        </xsl:attribute>\r\n                                                                                    </xsl:for-each>\r\n                                                                                </input>\r\n                                                                                <xsl:if test=\"FIELD\">\r\n                                                                                    <xsl:for-each select=\"FIELD\">\r\n                                                                                        <xsl:choose>\r\n                                                                                            <xsl:when test=\"@type=\'DropDownList\'\">\r\n                                                                                                <select>\r\n                                                                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                                        <xsl:attribute name=\"{@name}\">\r\n                                                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                        </xsl:attribute>\r\n                                                                                                    </xsl:for-each>\r\n                                                                                                    <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                                        <option>\r\n                                                                                                            <xsl:attribute name=\"value\">\r\n                                                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                            <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                                <xsl:attribute name=\"selected\">\r\n                                                                                                                    <xsl:text>selected</xsl:text>\r\n                                                                                                                </xsl:attribute>\r\n                                                                                                            </xsl:if>\r\n                                                                                                            <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                        </option>\r\n                                                                                                    </xsl:for-each>\r\n                                                                                                </select>\r\n                                                                                            </xsl:when>\r\n                                                                                        </xsl:choose>\r\n                                                                                    </xsl:for-each>\r\n                                                                                </xsl:if>\r\n                                                                            </xsl:when>\r\n                                                                    \r\n                                                                            <xsl:when test=\"@type=\'DropDownList\'\">\r\n                                                                                <select>\r\n                                                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                        <xsl:attribute name=\"{@name}\">\r\n                                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                        </xsl:attribute>\r\n                                                                                    </xsl:for-each>\r\n                                                                                    <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                        <option>\r\n                                                                                            <xsl:attribute name=\"value\">\r\n                                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                            </xsl:attribute>\r\n                                                                                            <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                <xsl:attribute name=\"selected\">\r\n                                                                                                    <xsl:text>selected</xsl:text>\r\n                                                                                                </xsl:attribute>\r\n                                                                                            </xsl:if>\r\n                                                                                            <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                        </option>\r\n                                                                                    </xsl:for-each>\r\n                                                                                </select>\r\n                                                                            </xsl:when>\r\n                                                                    \r\n                                                                            <xsl:when test=\"@type=\'RadioButtonList\'\">\r\n                                                                                <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                    <input type=\"radio\">\r\n                                                                                        <xsl:attribute name=\"value\">\r\n                                                                                            <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                        </xsl:attribute>\r\n                                                                                        <xsl:attribute name=\"id\">\r\n                                                                                            <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                                                        </xsl:attribute>\r\n                                                                                        <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                            <xsl:attribute name=\"checked\">\r\n                                                                                                <xsl:text>checked</xsl:text>\r\n                                                                                            </xsl:attribute>\r\n                                                                                        </xsl:if>\r\n                                                                                        <xsl:attribute name=\"onclick\">\r\n                                                                                            <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                                                        </xsl:attribute>\r\n                                                                                        <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                            </xsl:attribute>\r\n                                                                                        </xsl:for-each>\r\n                                                                                    </input>\r\n                                                                                    <xsl:value-of select=\"current()\"></xsl:value-of>&#160;\r\n                                                                                </xsl:for-each>\r\n                                                                            </xsl:when>\r\n                                                                        </xsl:choose>\r\n                                                                    </td>\r\n                                                                </xsl:for-each>\r\n                                                            </tr>\r\n                                                        </xsl:for-each>\r\n                                                \r\n                                                    </tbody>\r\n                                                </table>\r\n                                            </div>\r\n                                        </div>\r\n                                    </xsl:when>\r\n                                    \r\n                                    <!-- Main Textarea -->\r\n                                    <xsl:when test=\"@type=\'textareaFull\'\">\r\n                                        <div class=\"form-group\">\r\n                                            <div class=\"col-sm-12\">\r\n                                                <label>\r\n                                                    <xsl:value-of select=\"@label\" />\r\n                                                </label>\r\n                                                <textarea>\r\n                                                    <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                        <xsl:attribute name=\"{@name}\">\r\n                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                        </xsl:attribute>\r\n                                                    </xsl:for-each>\r\n                                                    <xsl:value-of select=\"VALUE\"></xsl:value-of>\r\n                                                </textarea>\r\n                                            </div>\r\n                                        </div>\r\n                                        <div class=\"line line-dashed b-b line-lg \"></div>\r\n                                    </xsl:when> \r\n                                    \r\n                                    <!-- Main Panel Bar -->\r\n                                    <xsl:when test=\"@type=\'PanelBar\'\">\r\n                                        <div class=\"panel panel-default\">\r\n                                            <div class=\"panel-heading\">\r\n                                                <h4 class=\"panel-title\">\r\n                                                    <a class=\"accordion-toggle\" data-toggle=\"collapse\" data-target=\"#{@target_div}\" href=\"javascript:void(0)\">\r\n                                                        <span>\r\n                                                            <xsl:value-of select=\"@label\"></xsl:value-of>\r\n                                                        </span>\r\n                                                    </a>\r\n                                                </h4>\r\n                                            </div>\r\n                                            <div id=\"{@target_div}\" class=\"collapse panel-body\">\r\n                                                <xsl:for-each select=\"FIELD\">\r\n                                                    <xsl:choose>\r\n                                                        <xsl:when test=\"@type=\'Header2\'\">\r\n                                                            <h4>\r\n                                                                <b> \r\n                                                                    <xsl:value-of select=\"@label\" /> \r\n                                                                </b>\r\n                                                            </h4>\r\n                                                        </xsl:when>\r\n                                                        \r\n                                                        <xsl:when test=\"@type=\'RadGrid\'\">\r\n                                                            <div class=\"form-group\">\r\n                                                                <div class=\"col-sm-12\">\r\n                                                                    <xsl:if test=\"@ADDButton=\'True\'\">\r\n                                                                        <input type=\"button\">\r\n                                                                            <xsl:attribute name=\"class\">\r\n                                                                                <xsl:text>addMore</xsl:text>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:attribute name=\"value\">\r\n                                                                                <xsl:text>Add</xsl:text>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:attribute name=\"id\">\r\n                                                                                <xsl:value-of select=\"@ADDButtonID\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:attribute name=\"data-table-id\">\r\n                                                                                <xsl:value-of select=\"@AddButtonTableId\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                        </input>\r\n                                                                    </xsl:if>\r\n                                        \r\n                                                                    <table>\r\n                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                        </xsl:for-each>\r\n                                                                        <thead>\r\n                                                                            <tr>\r\n                                                                                <xsl:for-each select=\"HEADER/TH\">\r\n                                                                                    <th>\r\n                                                                                        <xsl:value-of select=\"current()\" />\r\n                                                                                    </th>\r\n                                                                                </xsl:for-each>\r\n                                                                            </tr>\r\n                                                                        </thead>\r\n                                                                        <tbody>\r\n                                                                            <xsl:for-each select=\"COLUMNS\">\r\n                                                                                <tr>\r\n                                                                                    <xsl:for-each select=\"FIELD\">\r\n                                                                                        <td>\r\n                                                                                            <xsl:choose>\r\n                                                                                                <xsl:when test=\"@type=\'TextBox\'\">\r\n                                                                                                    <input type=\"text\">\r\n                                                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                        </xsl:for-each>\r\n                                                                                                    </input>\r\n                                                                                                    <xsl:if test=\"FIELD\">\r\n                                                                                                        <xsl:for-each select=\"FIELD\">\r\n                                                                                                            <xsl:choose>\r\n                                                                                                                <xsl:when test=\"@type=\'DropDownList\'\">\r\n                                                                                                                    <select>\r\n                                                                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                                            </xsl:attribute>\r\n                                                                                                                        </xsl:for-each>\r\n                                                                                                                        <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                                                            <option>\r\n                                                                                                                                <xsl:attribute name=\"value\">\r\n                                                                                                                                    <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                                                </xsl:attribute>\r\n                                                                                                                                <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                                                    <xsl:attribute name=\"selected\">\r\n                                                                                                                                        <xsl:text>selected</xsl:text>\r\n                                                                                                                                    </xsl:attribute>\r\n                                                                                                                                </xsl:if>\r\n                                                                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                                            </option>\r\n                                                                                                                        </xsl:for-each>\r\n                                                                                                                    </select>\r\n                                                                                                                </xsl:when>\r\n                                                                                                            </xsl:choose>\r\n                                                                                                        </xsl:for-each>\r\n                                                                                                    </xsl:if>\r\n                                                                                                </xsl:when>\r\n                                                                    \r\n                                                                                                <xsl:when test=\"@type=\'DropDownList\'\">\r\n                                                                                                    <select>\r\n                                                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                        </xsl:for-each>\r\n                                                                                                        <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                                            <option>\r\n                                                                                                                <xsl:attribute name=\"value\">\r\n                                                                                                                    <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                                </xsl:attribute>\r\n                                                                                                                <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                                    <xsl:attribute name=\"selected\">\r\n                                                                                                                        <xsl:text>selected</xsl:text>\r\n                                                                                                                    </xsl:attribute>\r\n                                                                                                                </xsl:if>\r\n                                                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                            </option>\r\n                                                                                                        </xsl:for-each>\r\n                                                                                                    </select>\r\n                                                                                                </xsl:when>\r\n                                                                    \r\n                                                                                                <xsl:when test=\"@type=\'RadioButtonList\'\">\r\n                                                                                                    <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                                        <input type=\"radio\">\r\n                                                                                                            <xsl:attribute name=\"value\">\r\n                                                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                            <xsl:attribute name=\"id\">\r\n                                                                                                                <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                            <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                                <xsl:attribute name=\"checked\">\r\n                                                                                                                    <xsl:text>checked</xsl:text>\r\n                                                                                                                </xsl:attribute>\r\n                                                                                                            </xsl:if>\r\n                                                                                                            <xsl:attribute name=\"onclick\">\r\n                                                                                                                <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                            <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                                                                                <xsl:attribute name=\"{@name}\">\r\n                                                                                                                    <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                                </xsl:attribute>\r\n                                                                                                            </xsl:for-each>\r\n                                                                                                        </input>\r\n                                                                                                        <xsl:value-of select=\"current()\"></xsl:value-of>&#160;\r\n                                                                                                    </xsl:for-each>\r\n                                                                                                    <xsl:if test=\"FIELD\">\r\n                                                                                                        <xsl:for-each select=\"FIELD\">\r\n                                                                                                            <xsl:choose>\r\n                                                                                                                <xsl:when test=\"@type=\'TextBox\'\">\r\n                                                                                                                    <xsl:value-of select=\"@label\" />\r\n                                                                                                                    <input type=\"text\">\r\n                                                                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                                            </xsl:attribute>\r\n                                                                                                                        </xsl:for-each>\r\n                                                                                                                    </input>\r\n                                                                                                                </xsl:when>\r\n                                                                                                            </xsl:choose>\r\n                                                                                                        </xsl:for-each>\r\n                                                                                                    </xsl:if>\r\n                                                                                                </xsl:when>\r\n                                                                                            </xsl:choose>\r\n                                                                                        </td>\r\n                                                                                    </xsl:for-each>\r\n                                                                                </tr>\r\n                                                                            </xsl:for-each>\r\n                                                \r\n                                                                        </tbody>\r\n                                                                    </table>\r\n                                                                </div>\r\n                                                            </div>\r\n                                                        </xsl:when>\r\n                                                        \r\n                                                        <xsl:when test=\"@type=\'RadioButtonList\'\">\r\n                                                            <div class=\"form-group\">\r\n                                                                <label class=\"col-sm-3 control-label\">\r\n                                                                    <xsl:value-of select=\"@label\" />\r\n                                                                    <xsl:if test=\"@required=\'true\'\">\r\n                                                                        <span class=\"required\"> *</span>\r\n                                                                    </xsl:if>\r\n                                                                </label>\r\n                                                                <div class=\"col-sm-9\">\r\n                                                                    <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                        <input type=\"radio\">\r\n                                                                            <xsl:attribute name=\"value\">\r\n                                                                                <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:attribute name=\"id\">\r\n                                                                                <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                <xsl:attribute name=\"checked\">\r\n                                                                                    <xsl:text>checked</xsl:text>\r\n                                                                                </xsl:attribute>\r\n                                                                            </xsl:if>\r\n                                                                            <xsl:attribute name=\"onclick\">\r\n                                                                                <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                            <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                                                <xsl:attribute name=\"{@name}\">\r\n                                                                                    <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                </xsl:attribute>\r\n                                                                            </xsl:for-each>\r\n                                                                        </input>\r\n                                                                        <xsl:value-of select=\"current()\"></xsl:value-of>&#160;\r\n                                                                    </xsl:for-each>\r\n                                                                    <xsl:if test=\"FIELD\">\r\n                                                                        <div id=\"{@Backdivid}\" class=\"hide\"> \r\n                                                                            <xsl:for-each select=\"FIELD\">\r\n                                                                                <xsl:choose>\r\n                                                                                    <xsl:when test=\"@type=\'DropDownList\'\">\r\n                                                                                        <div>\r\n                                                                                            <xsl:value-of select=\"@label\" />\r\n                                                                                            <select>\r\n                                                                                                <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                                    <xsl:attribute name=\"{@name}\">\r\n                                                                                                        <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                    </xsl:attribute>\r\n                                                                                                </xsl:for-each>\r\n                                                                                                <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                                    <option>\r\n                                                                                                        <xsl:attribute name=\"value\">\r\n                                                                                                            <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                        </xsl:attribute>\r\n                                                                                                        <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                            <xsl:attribute name=\"selected\">\r\n                                                                                                                <xsl:text>selected</xsl:text>\r\n                                                                                                            </xsl:attribute>\r\n                                                                                                        </xsl:if>\r\n                                                                                                        <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                    </option>\r\n                                                                                                </xsl:for-each>\r\n                                                                                            </select>\r\n                                                                                        </div>\r\n                                                                                    </xsl:when>\r\n                                                                                    \r\n                                                                                    <xsl:when test=\"@type=\'TextBox\'\">\r\n                                                                                        <div>\r\n                                                                                            <xsl:value-of select=\"@label\" />\r\n                                                                                            <input type=\"text\">\r\n                                                                                                <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                                                    <xsl:attribute name=\"{@name}\">\r\n                                                                                                        <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                    </xsl:attribute>\r\n                                                                                                </xsl:for-each>\r\n                                                                                            </input>\r\n                                                                                        </div>\r\n                                                                                    </xsl:when>\r\n                                                                                    \r\n                                                                                    <xsl:when test=\"@type=\'RadioButtonList\'\">\r\n                                                                                        <div>\r\n                                                                                            <xsl:value-of select=\"@label\" />\r\n                                                                                            <xsl:for-each select=\"LISTITEMS/LISTITEM\">\r\n                                                                                                <input type=\"radio\">\r\n                                                                                                    <xsl:attribute name=\"value\">\r\n                                                                                                        <xsl:value-of select=\"@value\"></xsl:value-of>\r\n                                                                                                    </xsl:attribute>\r\n                                                                                                    <xsl:attribute name=\"id\">\r\n                                                                                                        <xsl:value-of select=\"@id\"></xsl:value-of>\r\n                                                                                                    </xsl:attribute>\r\n                                                                                                    <xsl:if test=\"@Selected = \'true\'\">\r\n                                                                                                        <xsl:attribute name=\"checked\">\r\n                                                                                                            <xsl:text>checked</xsl:text>\r\n                                                                                                        </xsl:attribute>\r\n                                                                                                    </xsl:if>\r\n                                                                                                    <xsl:attribute name=\"onclick\">\r\n                                                                                                        <xsl:value-of select=\"@onclick\"></xsl:value-of>\r\n                                                                                                    </xsl:attribute>\r\n                                                                                                    <xsl:for-each select=\"../../PROPERTIES/PROPERTY\">\r\n                                                                                                        <xsl:attribute name=\"{@name}\">\r\n                                                                                                            <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                                                        </xsl:attribute>\r\n                                                                                                    </xsl:for-each>\r\n                                                                                                </input>\r\n                                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>&#160;\r\n                                                                                            </xsl:for-each>\r\n                                                                                        </div>\r\n                                                                                    </xsl:when>\r\n                                                                                </xsl:choose>\r\n                                                                            </xsl:for-each>\r\n                                                                        </div>\r\n                                                                    </xsl:if>\r\n                                                                </div>\r\n                                                            </div>\r\n                                                            <div class=\"line line-dashed b-b line-lg \"></div>\r\n                                                        </xsl:when>\r\n                                                        \r\n                                                        <xsl:when test=\"@type=\'TextBox\'\">\r\n                                                            <div class=\"form-group\">\r\n                                                                <label class=\"col-sm-3 control-label\">\r\n                                                                    <xsl:value-of select=\"@label\" />\r\n                                                                    <xsl:if test=\"@required=\'true\'\">\r\n                                                                        <span class=\"required\"> *</span>\r\n                                                                    </xsl:if>\r\n                                                                </label>\r\n                                                                <div class=\"col-sm-9\">\r\n                                                                    <input type=\"text\">\r\n                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                        </xsl:for-each>\r\n                                                                    </input>\r\n                                                                </div>\r\n                                                            </div>\r\n                                                            <div class=\"line line-dashed b-b line-lg \"></div>\r\n                                                        </xsl:when>\r\n                                                        \r\n                                                        <xsl:when test=\"@type=\'textareaFull\'\">\r\n                                                            <div class=\"form-group\">\r\n                                                                <div class=\"col-sm-12\">\r\n                                                                    <label>\r\n                                                                        <xsl:value-of select=\"@label\" />\r\n                                                                    </label>\r\n                                                                    <textarea>\r\n                                                                        <xsl:for-each select=\"PROPERTIES/PROPERTY\">\r\n                                                                            <xsl:attribute name=\"{@name}\">\r\n                                                                                <xsl:value-of select=\"current()\"></xsl:value-of>\r\n                                                                            </xsl:attribute>\r\n                                                                        </xsl:for-each>\r\n                                                                        <xsl:value-of select=\"VALUE\"></xsl:value-of>\r\n                                                                    </textarea>\r\n                                                                </div>\r\n                                                            </div>\r\n                                                            <div class=\"line line-dashed b-b line-lg \"></div>\r\n                                                        </xsl:when>\r\n                                                    </xsl:choose>\r\n                                                </xsl:for-each>\r\n                                            </div>\r\n                                        </div>\r\n                                    </xsl:when>\r\n                                    \r\n                                </xsl:choose>\r\n                            </xsl:for-each>\r\n                        </div>\r\n                    </xsl:for-each>\r\n                </div>\r\n            </xsl:for-each>\r\n        </form>\r\n    </xsl:template>\r\n</xsl:stylesheet>','1',-1,'2016-05-31 11:56:21',51,'2016-06-04 11:27:37','0000-00-00 00:00:00');

/*Table structure for table `pat_documents` */

DROP TABLE IF EXISTS `pat_documents`;

CREATE TABLE `pat_documents` (
  `doc_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doc_type_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `document_xml` longtext,
  `status` enum('0','1') DEFAULT '1',
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `pat_encounter` */

insert  into `pat_encounter`(`encounter_id`,`tenant_id`,`patient_id`,`encounter_type`,`encounter_date`,`inactive_date`,`bill_no`,`finalize`,`authorize`,`discharge`,`casesheet_no`,`concession_amount`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (18,58,91,'IP','2016-06-10 15:43:08',NULL,'AH0000053',0,0,0,'1188','0.00','1',51,'2016-06-10 15:43:20',51,'2016-06-10 15:43:20','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;

/*Data for the table `pat_patient` */

insert  into `pat_patient`(`patient_id`,`patient_global_guid`,`patient_guid`,`casesheetno`,`patient_int_code`,`tenant_id`,`patient_reg_date`,`patient_title_code`,`patient_firstname`,`patient_lastname`,`patient_relation_code`,`patient_relation_name`,`patient_care_taker`,`patient_care_taker_name`,`patient_dob`,`patient_gender`,`patient_marital_status`,`patient_occupation`,`patient_blood_group`,`patient_category_id`,`patient_email`,`patient_reg_mode`,`patient_type`,`patient_ref_hospital`,`patient_ref_id`,`patient_mobile`,`patient_bill_type`,`patient_image`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (91,'76c1f817-23dd-55cf-8c39-807be316968a','56834734-c93f-5339-ba51-54c240b9ca94',NULL,'AH0000067',58,'2016-06-10 15:42:55','Mr.','Prakash Arul Mani','Paramanandam',NULL,NULL,NULL,NULL,'1991-06-10','M',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'9896911452',NULL,'data:image/png;base64,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','1',51,'2016-06-10 15:42:55',51,'2016-06-10 15:43:54','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `pat_patient_casesheet` */

insert  into `pat_patient_casesheet`(`casesheet_id`,`tenant_id`,`patient_id`,`casesheet_no`,`start_date`,`end_date`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (4,58,91,'1188','2016-06-10',NULL,'1',51,'2016-06-10 15:43:20',51,'2016-06-10 15:43:20','0000-00-00 00:00:00');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `message` varchar(255) NOT NULL,
  `ip_adderss` varchar(50) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=459 DEFAULT CHARSET=latin1;

/*Data for the table `pat_timeline` */

insert  into `pat_timeline`(`timeline_id`,`tenant_id`,`patient_id`,`date_time`,`header`,`header_sub`,`message`,`ip_adderss`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (455,58,91,'2016-06-10 15:42:55','Patient Registration','','Mr. Prakash Arul Mani Registered Successfully.','127.0.0.1','1',51,'2016-06-10 15:42:56',51,'2016-06-10 15:42:56','0000-00-00 00:00:00'),(456,58,91,'2016-06-10 15:43:20','Casesheet No.','','Casesheet No.: 1188 Added.','127.0.0.1','1',51,'2016-06-10 15:43:20',51,'2016-06-10 15:43:20','0000-00-00 00:00:00'),(457,58,91,'2016-06-10 15:43:08','Patient Admission','Encounter # 18','Patient Admitted. <br /> Bed No: <b>113 (ac)</b>','127.0.0.1','1',51,'2016-06-10 15:43:20',51,'2016-06-10 15:43:20','0000-00-00 00:00:00'),(458,58,91,'2016-06-10 15:43:54','Patient Update','','Patient Details Updated Successfully.','127.0.0.1','1',51,'2016-06-10 15:43:55',51,'2016-06-10 15:43:55','0000-00-00 00:00:00');

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
