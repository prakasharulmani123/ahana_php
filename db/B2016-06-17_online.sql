/*
SQLyog Ultimate v8.55 
MySQL - 5.5.48-37.8 : Database - rajencba_ahanademo
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
  `code` varchar(10) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `app_configuration` */

insert  into `app_configuration`(`config_id`,`tenant_id`,`code`,`key`,`value`,`notes`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'RC','ROOM_CHARGE_CONFIG','11',NULL,'0',0,'2016-05-02 18:16:02',51,'2016-05-03 12:43:57','2016-05-03 12:43:57'),(2,58,'ET','ELAPSED_TIME','1212','seconds','1',0,'2016-05-02 18:28:32',51,'2016-06-15 05:18:41','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `co_alert` */

insert  into `co_alert`(`alert_id`,`tenant_id`,`alert_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'new','1',51,'2016-02-19 01:33:25',51,'2016-02-19 01:33:25','0000-00-00 00:00:00'),(2,60,'Warning','1',59,'2016-02-21 22:31:39',59,'2016-02-21 22:31:39','0000-00-00 00:00:00'),(3,60,'new','1',59,'2016-02-21 22:31:47',59,'2016-02-21 22:31:47','0000-00-00 00:00:00'),(4,60,'waiting','1',59,'2016-02-21 22:31:55',59,'2016-02-21 22:31:55','0000-00-00 00:00:00'),(5,61,'test','1',67,'2016-02-23 02:20:48',67,'2016-02-23 02:20:48','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

/*Data for the table `co_charge_per_category` */

insert  into `co_charge_per_category`(`charge_id`,`tenant_id`,`charge_cat_type`,`charge_cat_id`,`charge_code_id`,`charge_default`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (3,58,'C',1,22,'150','2016-02-04 22:36:47',51,'2016-02-20 04:31:58',62,'0000-00-00 00:00:00'),(4,58,'C',5,26,'150','2016-02-09 02:22:54',51,'2016-02-20 04:23:56',62,'0000-00-00 00:00:00'),(5,58,'C',5,25,NULL,'2016-02-09 02:24:37',51,'2016-02-09 02:24:37',51,'0000-00-00 00:00:00'),(6,58,'P',-1,56,'352','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(7,58,'P',-1,54,'300','2016-02-17 04:36:29',51,'2016-03-03 03:59:30',51,'0000-00-00 00:00:00'),(8,60,'P',-1,65,'200','2016-02-19 07:53:17',59,'2016-02-19 07:53:17',59,'0000-00-00 00:00:00'),(9,60,'P',-1,60,'100','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(10,60,'P',-1,61,'100','2016-02-19 23:22:28',59,'2016-02-19 23:22:28',59,'0000-00-00 00:00:00'),(11,58,'P',-1,58,'100','2016-02-20 02:17:57',62,'2016-02-20 02:17:57',62,'0000-00-00 00:00:00'),(12,60,'C',1,35,'100','2016-02-20 03:29:39',59,'2016-02-20 03:29:39',59,'0000-00-00 00:00:00'),(13,61,'P',-1,68,'200','2016-02-22 00:01:27',67,'2016-02-23 02:19:20',67,'0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;

/*Data for the table `co_charge_per_subcategory` */

insert  into `co_charge_per_subcategory`(`sub_charge_id`,`charge_id`,`charge_type`,`charge_link_id`,`charge_amount`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (1,3,'IP',9,'111.00','2016-02-04 22:36:48',51,'2016-02-04 22:36:48',51,'0000-00-00 00:00:00'),(2,3,'IP',10,'111.00','2016-02-04 22:36:48',51,'2016-02-04 22:36:48',51,'0000-00-00 00:00:00'),(3,3,'IP',11,'111.00','2016-02-04 22:36:48',51,'2016-02-04 22:36:48',51,'0000-00-00 00:00:00'),(4,4,'IP',9,'1000.00','2016-02-09 02:22:55',51,'2016-02-09 02:22:55',51,'0000-00-00 00:00:00'),(5,4,'IP',10,'1200.00','2016-02-09 02:22:55',51,'2016-02-09 02:22:55',51,'0000-00-00 00:00:00'),(6,4,'IP',11,'1500.00','2016-02-09 02:22:55',51,'2016-02-09 02:22:55',51,'0000-00-00 00:00:00'),(7,4,'IP',12,'1900.00','2016-02-09 02:22:55',51,'2016-02-09 02:22:55',51,'0000-00-00 00:00:00'),(8,4,'IP',13,'2000.00','2016-02-09 02:22:55',51,'2016-02-09 02:22:55',51,'0000-00-00 00:00:00'),(9,5,'IP',9,'1111.00','2016-02-09 02:24:57',51,'2016-02-09 02:24:57',51,'0000-00-00 00:00:00'),(10,5,'IP',10,'11111.00','2016-02-09 02:24:57',51,'2016-02-09 02:24:57',51,'0000-00-00 00:00:00'),(11,5,'IP',11,'222.00','2016-02-09 02:24:57',51,'2016-03-03 04:09:46',51,'0000-00-00 00:00:00'),(12,5,'IP',12,'11111.00','2016-02-09 02:24:57',51,'2016-02-09 02:24:57',51,'0000-00-00 00:00:00'),(13,5,'IP',13,'2222.00','2016-02-09 02:24:57',51,'2016-02-09 02:24:57',51,'0000-00-00 00:00:00'),(14,6,'OP',4,'100.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(15,6,'OP',5,'200.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(16,6,'OP',6,'300.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(17,6,'IP',9,'1100.00','2016-02-17 04:35:32',51,'2016-03-03 04:15:20',51,'0000-00-00 00:00:00'),(18,6,'IP',10,'20.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(19,6,'IP',11,'33.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(20,6,'IP',12,'11.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(21,6,'IP',13,'15.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(22,7,'OP',4,'100.00','2016-02-17 04:36:29',51,'2016-02-17 04:36:29',51,'0000-00-00 00:00:00'),(23,7,'OP',5,'100.00','2016-02-17 04:36:29',51,'2016-02-17 04:36:29',51,'0000-00-00 00:00:00'),(24,7,'OP',6,'100.00','2016-02-17 04:36:29',51,'2016-02-17 04:36:29',51,'0000-00-00 00:00:00'),(25,7,'IP',9,'1200.00','2016-02-17 04:36:29',51,'2016-02-25 04:10:27',51,'0000-00-00 00:00:00'),(26,7,'IP',10,'8200.00','2016-02-17 04:36:29',51,'2016-02-25 04:10:44',51,'0000-00-00 00:00:00'),(27,7,'IP',11,'120.00','2016-02-17 04:36:29',51,'2016-02-25 04:10:33',51,'0000-00-00 00:00:00'),(28,7,'IP',12,'200.00','2016-02-17 04:36:29',51,'2016-02-17 04:36:29',51,'0000-00-00 00:00:00'),(29,7,'IP',13,'200.00','2016-02-17 04:36:29',51,'2016-02-17 04:36:29',51,'0000-00-00 00:00:00'),(30,6,'OP',7,'400.00','2016-02-19 07:45:04',51,'2016-02-19 07:45:04',51,'0000-00-00 00:00:00'),(31,8,'OP',8,'100.00','2016-02-19 07:53:18',59,'2016-02-19 07:53:18',59,'0000-00-00 00:00:00'),(32,8,'OP',9,'100.00','2016-02-19 07:53:18',59,'2016-02-19 07:53:18',59,'0000-00-00 00:00:00'),(33,8,'OP',10,'101.00','2016-02-19 07:53:18',59,'2016-02-19 07:53:18',59,'0000-00-00 00:00:00'),(34,8,'OP',11,'102.00','2016-02-19 07:53:18',59,'2016-02-19 07:53:18',59,'0000-00-00 00:00:00'),(35,8,'OP',12,'103.00','2016-02-19 07:53:18',59,'2016-02-19 07:53:18',59,'0000-00-00 00:00:00'),(36,9,'OP',8,'101.00','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(37,9,'OP',9,'102.00','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(38,9,'OP',10,'103.00','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(39,9,'OP',11,'104.00','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(40,9,'OP',12,'105.00','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(41,10,'OP',8,'101.00','2016-02-19 23:29:21',59,'2016-02-19 23:29:21',59,'0000-00-00 00:00:00'),(42,3,'OP',4,'500.00','2016-02-20 01:21:12',62,'2016-02-20 01:21:12',62,'0000-00-00 00:00:00'),(43,3,'OP',5,'600.00','2016-02-20 01:21:22',62,'2016-02-20 01:21:22',62,'0000-00-00 00:00:00'),(44,11,'OP',4,'100.00','2016-02-20 02:17:57',62,'2016-02-20 02:17:57',62,'0000-00-00 00:00:00'),(45,12,'OP',8,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(46,12,'OP',9,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(47,12,'OP',10,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(48,12,'OP',11,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(49,12,'OP',12,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(50,12,'IP',14,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(51,12,'IP',15,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(52,12,'IP',16,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(53,13,'OP',14,'200.00','2016-02-23 04:52:20',67,'2016-02-23 04:52:20',67,'0000-00-00 00:00:00');

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

insert  into `co_doctor_schedule`(`schedule_id`,`tenant_id`,`user_id`,`schedule_day`,`schedule_time_in`,`schedule_time_out`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (1,58,54,'-1','07:30:00','08:00:00','2016-02-04 22:40:42',51,'2016-02-04 22:40:42',51,'2016-02-04 22:41:31'),(2,58,54,'-1','05:00:00','07:30:00','2016-02-04 22:40:42',51,'2016-02-04 22:40:42',51,'2016-02-04 22:41:31'),(3,58,56,'-1','11:00:00','12:00:00','2016-02-17 00:45:37',51,'2016-02-17 00:45:37',51,'0000-00-00 00:00:00'),(4,60,60,'-1','09:00:00','10:00:00','2016-02-17 06:33:58',59,'2016-02-17 06:33:58',59,'0000-00-00 00:00:00'),(5,60,61,'-1','00:30:00','03:00:00','2016-02-19 23:24:54',59,'2016-02-19 23:24:54',59,'0000-00-00 00:00:00'),(6,60,65,'-1','16:00:00','18:00:00','2016-02-20 03:30:18',59,'2016-02-20 03:30:18',59,'0000-00-00 00:00:00'),(7,60,64,'-1','22:30:00','23:00:00','2016-02-20 03:30:32',59,'2016-02-20 03:30:32',59,'0000-00-00 00:00:00'),(8,61,68,'-1','01:00:00','00:00:00','2016-02-21 23:26:35',67,'2016-02-21 23:26:35',19,'2016-02-21 23:34:57'),(9,61,68,'-1','02:00:00','00:00:00','2016-02-21 23:27:24',67,'2016-02-21 23:27:24',19,'2016-02-21 23:34:55'),(10,61,68,'-1','10:30:00','23:30:00','2016-02-21 23:35:20',67,'2016-02-21 23:35:20',19,'2016-02-23 05:12:53'),(11,58,54,'-1','01:30:00','02:00:00','2016-03-16 09:21:55',51,'2016-03-23 02:28:34',51,'0000-00-00 00:00:00'),(12,58,54,'-1','00:30:00','02:00:00','2016-03-16 09:21:55',51,'2016-03-16 09:21:55',51,'0000-00-00 00:00:00'),(13,58,54,'1','00:30:00','01:00:00','2016-03-23 02:28:54',51,'2016-03-23 02:28:54',51,'0000-00-00 00:00:00'),(14,58,54,'3','00:30:00','01:00:00','2016-03-23 02:28:54',51,'2016-03-23 02:28:54',51,'0000-00-00 00:00:00');

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

insert  into `co_floor`(`floor_id`,`tenant_id`,`floor_name`,`floor_code`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (7,58,'Ground Floor','1','1',51,'2016-02-04 07:15:34',51,'2016-02-04 07:15:34','0000-00-00 00:00:00'),(8,58,'Floor 1','2','1',51,'2016-02-04 07:15:44',51,'2016-02-04 07:15:44','0000-00-00 00:00:00'),(9,58,'Floor 2','3','1',51,'2016-02-04 07:15:54',51,'2016-02-04 07:15:54','0000-00-00 00:00:00'),(10,59,'1','1','1',52,'2016-02-05 06:47:59',52,'2016-02-05 06:47:59','0000-00-00 00:00:00'),(14,58,'111','90','1',51,'2016-02-15 06:49:27',51,'2016-02-15 06:49:27','0000-00-00 00:00:00'),(15,58,'11231','9','1',51,'2016-02-15 07:17:28',51,'2016-02-15 07:17:28','0000-00-00 00:00:00'),(16,60,'Ground Floor','01','1',59,'2016-02-19 22:25:45',59,'2016-02-19 22:25:45','0000-00-00 00:00:00'),(17,60,'First Floor','02','1',59,'2016-02-20 01:10:57',59,'2016-02-20 01:10:57','0000-00-00 00:00:00'),(18,60,'Second Floor','03','1',59,'2016-02-20 01:13:41',59,'2016-02-20 01:13:41','0000-00-00 00:00:00'),(19,61,'Floor1','F1','1',67,'2016-02-23 02:33:20',67,'2016-02-23 02:33:20','0000-00-00 00:00:00'),(20,61,'Floor2','F2','1',67,'2016-02-23 02:33:36',67,'2016-02-23 02:33:36','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

/*Data for the table `co_internal_code` */

insert  into `co_internal_code`(`internal_code_id`,`tenant_id`,`code_type`,`code_prefix`,`code`,`code_padding`,`code_suffix`,`status`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (2,58,'B','AH',17,7,NULL,'1','2016-06-13 06:08:31',-1,'2016-06-13 06:08:31',51,'0000-00-00 00:00:00'),(3,58,'P','AH',53,7,NULL,'1','2016-06-11 05:00:22',-1,'2016-06-11 05:00:22',51,'0000-00-00 00:00:00'),(4,59,'B','AR',1,7,NULL,'1','2016-02-02 22:43:11',-1,'2016-02-02 22:43:11',-1,'0000-00-00 00:00:00'),(5,59,'P','AR',1,7,NULL,'1','2016-02-02 22:43:11',-1,'2016-02-02 22:43:11',-1,'0000-00-00 00:00:00'),(6,60,'B','RA',1,7,NULL,'1','2016-02-17 06:28:38',-1,'2016-02-17 06:28:38',-1,'0000-00-00 00:00:00'),(7,60,'P','RA',5,7,NULL,'1','2016-02-20 03:31:26',-1,'2016-02-20 03:31:26',59,'0000-00-00 00:00:00'),(8,61,'B','TE',34343434,7,NULL,'1','2016-02-23 02:20:29',-1,'2016-02-23 02:20:29',67,'0000-00-00 00:00:00'),(9,61,'P','TE',2,7,NULL,'1','2016-02-21 23:20:06',-1,'2016-02-21 23:20:06',67,'0000-00-00 00:00:00'),(10,62,'B','TE',1,7,NULL,'1','2016-02-29 02:00:01',-1,'2016-02-29 02:00:01',-1,'0000-00-00 00:00:00'),(11,62,'P','TE',1,7,NULL,'1','2016-02-29 02:00:01',-1,'2016-02-29 02:00:01',-1,'0000-00-00 00:00:00'),(12,58,'PU','PU',21,7,NULL,'1','2016-05-09 23:35:00',-1,'2016-05-09 23:35:00',51,'0000-00-00 00:00:00'),(13,58,'PR','PU-R',1,7,NULL,'1','2016-03-15 09:18:19',-1,NULL,NULL,'0000-00-00 00:00:00'),(14,23,'B','TE',1,7,NULL,'1','2016-03-23 00:28:59',-1,'2016-03-23 00:28:59',-1,'0000-00-00 00:00:00'),(15,23,'P','TE',1,7,NULL,'1','2016-03-23 00:28:59',-1,'2016-03-23 00:28:59',-1,'0000-00-00 00:00:00'),(16,23,'PU','TE',1,7,NULL,'1','2016-03-23 00:28:59',-1,'2016-03-23 00:28:59',-1,'0000-00-00 00:00:00'),(17,23,'PR','TE',1,7,NULL,'1','2016-03-23 00:28:59',-1,'2016-03-23 00:28:59',-1,'0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

/*Data for the table `co_login` */

insert  into `co_login`(`login_id`,`user_id`,`username`,`password`,`password_reset_token`,`authtoken`,`created_by`,`created_at`,`modified_by`,`modified_at`,`activation_date`,`Inactivation_date`,`logged_tenant_id`) values (10,51,'vikhram','$2y$13$e3src5J6OjoHz4KhRp5Lxu/UxYR7KnyhKVU0JdwEqPeLNdmDqgYsS','jRNVGTgBdvZzSTbhziiNYh2zoXtUNGrH_1462989854','dmlraHJhbTE0NjYxNDY5NDUxMDUx',-1,'2016-02-02 22:26:39',NULL,'2016-06-17 02:02:25',NULL,NULL,58),(11,52,'ark','$2y$13$4T7TlDr8in4ydQTVxEfTke.donWnYhKLOJG8r/c78g.UXuXeqfNFO',NULL,'YXJrMTQ1NDk5MDU0NTE1MTg=',-1,'2016-02-02 22:43:12',NULL,'2016-02-08 22:02:25',NULL,NULL,NULL),(12,54,'John','123',NULL,NULL,51,'2016-02-04 07:07:43',51,'2016-02-04 07:07:43','2016-02-04','2016-02-28',NULL),(13,56,'surya','$2y$13$ME5XmmGNPPwWKo5iyFHNieGkVido4tU6oTPE6fWvEsWb9DVk84hOK',NULL,'c3VyeWExNDYxODM2NDExNTEyNQ==',51,'2016-02-05 22:50:58',NULL,'2016-04-28 04:40:11','2016-02-06','2016-04-30',58),(14,59,'gayatri','$2y$13$ZEtwkbrJqouJw3KqMkoEzO6JIGFyuOUA3mba5AENqyYe7jX5HmpTe',NULL,'Z2F5YXRyaTE0NTYxNDM0MTYyNDgz',-1,'2016-02-17 06:28:39',NULL,'2016-02-22 06:16:56',NULL,NULL,60),(15,62,'prakash','$2y$13$X9agaug8aC21f9ujjR9vzOze3nqFNsuaLPf0kgOwwI06tsqX35IrW','NL1d9yF5P8WFIy1ZpXV7NmPt1dinrYQs_1458733869','cHJha2FzaDE0NTk3NDY3OTUzNTM4',51,'2016-02-19 07:08:27',NULL,'2016-04-04 00:13:15','2016-02-19','2016-02-19',58),(16,63,'nadesh','$2y$13$xQjS./o.sUYsBoawcqm0j.7yFw4F8xmAfmkcerupnls4C7KZsnLhu',NULL,'',51,'2016-02-19 07:09:05',51,'2016-03-14 06:03:40','2016-02-19','2016-02-19',NULL),(17,65,'test','$2y$13$A4KhMKHUYaMb4m0MoTBNVufbQu4gkBcTc0zV.vSkFiuv..QlAhfh2',NULL,NULL,59,'2016-02-19 07:49:44',59,'2016-02-19 07:49:44','2016-02-19','2016-02-19',NULL),(18,66,'prakash2','$2y$13$mfGVdp/.Cst1GsGHSo/Vv.q9.gxFCaecIokQmbF29OnIw9WS8aIX.',NULL,'cHJha2FzaDIxNDU1OTcyNTk2NDA5Nw==',59,'2016-02-20 05:10:18',NULL,'2016-02-20 06:49:56','2016-02-20','2016-02-20',60),(19,67,'paramesh','$2y$13$u.tSO2LUiafMwxi19midCOlGruWNOIR1lD3gqsGnYhXnSbNYHqvqC','PesQVUlVvEHGH91eUfoeQlPQsnMy8dyp_1458136903','',-1,'2016-02-21 23:16:05',NULL,'2016-03-16 09:01:43',NULL,NULL,NULL),(20,73,'parames','$2y$13$1TsRqCJ5ThWc.Pp2vVrdQecg1tFoqsKPGJRCwII5QZqlpB2AtSn86',NULL,NULL,-1,'2016-02-29 02:00:02',-1,'2016-02-29 02:00:02',NULL,NULL,NULL),(21,74,'tester1','$2y$13$/dnk0r3vqf41NTXAhqy0V.ljdN20iCDcKXm2Fbv8qlg4Ss5MPFTka',NULL,NULL,51,'2016-03-23 00:59:34',51,'2016-03-23 00:59:34','2016-03-23','2016-03-23',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `co_master_country` */

insert  into `co_master_country`(`country_id`,`tenant_id`,`country_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (7,NULL,'India','1',-1,'2016-01-22 08:11:40',NULL,NULL,'0000-00-00 00:00:00'),(11,58,'USA','1',51,'2016-02-05 00:58:16',51,'2016-02-05 00:59:15','0000-00-00 00:00:00');

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

insert  into `co_organization`(`org_id`,`org_name`,`org_description`,`org_db_host`,`org_db_username`,`org_db_password`,`org_database`,`org_domain`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (7,'Org','Org','localhost','rajencba_ahana','s6(Srsh7_qQL','rajencba_ahanademo','http://demo.arkinfotec.in/ahana/demo','1',-1,'2016-02-17 18:50:12',NULL,'2016-02-19 12:53:45','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Data for the table `co_patient_category` */

insert  into `co_patient_category`(`patient_cat_id`,`tenant_id`,`patient_cat_name`,`patient_cat_color`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (4,58,'BUSINESS','#44ae58','1',51,'2016-02-05 00:50:24',51,'2016-02-17 06:45:37','0000-00-00 00:00:00'),(5,58,'VIP','#df9a26','1',51,'2016-02-05 00:50:43',51,'2016-02-17 06:45:23','0000-00-00 00:00:00'),(6,58,'Standrad','#FFFFFF','1',51,'2016-02-09 01:52:26',51,'2016-02-17 06:45:14','0000-00-00 00:00:00'),(7,58,'VVIP','#FFFFFF','1',51,'2016-02-17 06:45:45',51,'2016-02-17 06:45:45','0000-00-00 00:00:00'),(8,60,'vip','#FFFFFF','1',59,'2016-02-17 23:15:35',59,'2016-02-17 23:15:35','0000-00-00 00:00:00'),(9,60,'business','#FFFFFF','1',59,'2016-02-17 23:15:42',59,'2016-02-17 23:15:42','0000-00-00 00:00:00'),(10,60,'free','#FFFFFF','1',59,'2016-02-17 23:15:48',59,'2016-02-17 23:15:48','0000-00-00 00:00:00'),(11,60,'standard','#FFFFFF','1',59,'2016-02-17 23:15:56',59,'2016-02-17 23:15:56','0000-00-00 00:00:00'),(12,60,'vvip','#FFFFFF','1',59,'2016-02-17 23:16:04',59,'2016-02-17 23:16:04','0000-00-00 00:00:00'),(13,58,'classic','#d01e1e','1',51,'2016-02-19 01:34:56',51,'2016-02-19 01:34:56','0000-00-00 00:00:00'),(14,61,'Standard','#FFFFFF','1',67,'2016-02-23 02:22:51',67,'2016-02-23 02:22:51','0000-00-00 00:00:00'),(15,58,'FREE','#beb32c','1',51,'2016-04-29 05:04:17',51,'2016-04-29 05:04:17','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=latin1;

/*Data for the table `co_resources` */

insert  into `co_resources`(`resource_id`,`parent_id`,`resource_name`,`resource_url`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,NULL,'Configuration','configuration',-1,'2015-12-29 15:11:20',NULL,NULL),(2,1,'Organization Module','organization',-1,'2015-12-29 15:11:42',NULL,NULL),(3,2,'Organization','configuration.organization',-1,'2016-01-19 15:35:50',NULL,NULL),(4,2,'Organization Module','configuration.organizationModule',-1,'2016-01-19 15:36:07',NULL,NULL),(5,1,'Administrative Module','administrative',-1,'2016-01-20 11:11:09',NULL,NULL),(6,5,'Roles','configuration.roles',-1,'2016-01-20 11:11:58',NULL,NULL),(7,5,'Role Rights','configuration.roleRights',-1,'2016-01-20 11:14:04',NULL,NULL),(8,5,'User roles','configuration.userRoles',-1,'2016-01-20 11:14:31',NULL,NULL),(9,5,'Charge Category','configuration.roomChargeCategory',-1,'2016-01-20 11:15:00',NULL,NULL),(10,1,'User Module','userModule',-1,'2016-01-20 11:16:12',NULL,NULL),(11,10,'User Registration','configuration.registration',-1,'2016-01-20 11:16:50',NULL,NULL),(12,1,'Ward Management','wardManagement',-1,'2016-01-20 11:17:42',NULL,NULL),(13,12,'Floors','configuration.floors',-1,'2016-01-20 11:18:10',NULL,NULL),(14,12,'Wards','configuration.wards',-1,'2016-01-20 11:18:25',NULL,NULL),(15,12,'Bed Type','configuration.roomType',-1,'2016-01-20 11:18:48',NULL,NULL),(16,12,'Room','configuration.room',-1,'2016-01-20 11:19:17',NULL,NULL),(17,12,'Room and Bed Type','configuration.roomTypeRoom',-1,'2016-01-20 11:20:39',NULL,NULL),(18,1,'Charges Configuration','chargesConfiguration',-1,'2016-01-20 11:21:17',NULL,NULL),(19,18,'Room Charge','configuration.roomCharge',-1,'2016-01-20 11:21:40',NULL,NULL),(20,18,'Room Maintenance','configuration.roomMaintenance',-1,'2016-01-20 11:21:59',NULL,NULL),(21,18,'Charges for Category','configuration.chargePerCategory',-1,'2016-01-20 11:22:20',NULL,NULL),(22,1,'Doctor’s Configuration','doctorsConfiguration',-1,'2016-01-20 11:22:59',NULL,NULL),(23,22,'Doctors Schedule','configuration.docSchedule',-1,'2016-01-20 11:23:20',NULL,NULL),(24,22,'Specialities','configuration.specialities',-1,'2016-01-20 11:23:39',NULL,NULL),(25,1,'Miscellaneous','miscellaneous',-1,'2016-01-20 11:24:17',NULL,NULL),(26,25,'Alerts','configuration.alerts',-1,'2016-01-20 11:24:32',NULL,NULL),(27,25,'Patient Category','configuration.patientCategories',-1,'2016-01-20 11:24:47',NULL,NULL),(28,25,'Bill-No Prefix','configuration.internalCode',-1,'2016-01-20 11:25:06',NULL,NULL),(29,25,'Master Country','configuration.countries',-1,'2016-01-20 11:25:22',NULL,NULL),(30,25,'Master State','configuration.states',-1,'2016-01-20 11:25:35',NULL,NULL),(31,25,'Master City','configuration.cities',-1,'2016-01-20 11:25:52',NULL,NULL),(32,5,'Room Charge Item','configuration.roomChargeCategoryItem',-1,'2016-02-01 12:04:21',NULL,NULL),(33,5,'Allied Charges','configuration.alliedCharge',-1,'2016-02-03 15:31:05',NULL,NULL),(34,5,'Procedures','configuration.procedure',-1,'2016-02-05 15:43:00',NULL,NULL),(35,6,'Add Role','configuration.role_create',-1,'2016-02-08 15:16:27',NULL,NULL),(36,6,'Update Role','configuration.role_update',-1,'2016-02-08 15:17:21',NULL,NULL),(37,6,'Delete Role','configuration.role_delete',-1,'2016-02-08 15:18:46',NULL,NULL),(38,9,'Add Charge Category','configuration.roomChargeCategoryCreate',-1,'2016-02-08 15:20:26',NULL,NULL),(39,9,'Update Charge Category','configuration.roomChargeCategoryUpdate',-1,'2016-02-08 15:20:26',NULL,NULL),(40,9,'Delete Charge Category','configuration.roomChargeCategoryDelete',-1,'2016-02-08 15:20:27',NULL,NULL),(41,32,'Add Room Charge Item','configuration.roomChargeCategoryItemCreate',-1,'2016-02-08 15:21:56',NULL,NULL),(42,32,'Update Room Charge Item','configuration.roomChargeCategoryItemUpdate',-1,'2016-02-08 15:21:56',NULL,NULL),(43,32,'Delete Room Charge Item','configuration.roomChargeCategoryItemDelete',-1,'2016-02-08 15:21:56',NULL,NULL),(44,33,'Add Allied Charges','configuration.alliedChargeCreate',-1,'2016-02-08 15:31:45',NULL,NULL),(45,33,'Update Allied Charges','configuration.alliedChargeUpdate',-1,'2016-02-08 15:31:45',NULL,NULL),(46,33,'Delete Allied Charges','configuration.alliedChargeDelete',-1,'2016-02-08 15:31:45',NULL,NULL),(47,34,'Add Procedures','configuration.procedureChargeCreate',-1,'2016-02-08 15:38:42',NULL,NULL),(48,34,'Update Procedures','configuration.procedureChargeUpdate',-1,'2016-02-08 15:38:42',NULL,NULL),(49,34,'Delete Procedures','configuration.procedureChargeDelete',-1,'2016-02-08 15:38:42',NULL,NULL),(54,11,'Add User','configuration.user_create',-1,'2016-02-08 15:41:39',NULL,NULL),(55,11,'Update User','configuration.user_update',-1,'2016-02-08 15:41:39',NULL,NULL),(56,11,'Delete User','configuration.user_delete',-1,'2016-02-08 15:41:39',NULL,NULL),(57,11,'Add/Update Login','configuration.login_update',-1,'2016-02-08 15:41:39',NULL,NULL),(58,13,'Add Floor','configuration.floor_create',-1,'2016-02-08 15:49:25',NULL,NULL),(59,13,'Update Floor','configuration.floor_update',-1,'2016-02-08 15:49:25',NULL,NULL),(60,13,'Delete Floor','configuration.floor_delete',-1,'2016-02-08 15:49:25',NULL,NULL),(61,14,'Add Ward','configuration.ward_create',-1,'2016-02-08 15:50:14',NULL,NULL),(62,14,'Update Ward','configuration.ward_update',-1,'2016-02-08 15:50:14',NULL,NULL),(63,14,'Delete Ward','configuration.ward_delete',-1,'2016-02-08 15:50:14',NULL,NULL),(64,15,'Add Bed Type','configuration.roomTypeCreate',-1,'2016-02-08 15:51:19',NULL,NULL),(65,15,'Update Bed Type','configuration.roomTypeUpdate',-1,'2016-02-08 15:51:19',NULL,NULL),(66,15,'Delete Bed Type','configuration.roomTypeDelete',-1,'2016-02-08 15:51:19',NULL,NULL),(67,16,'Add Room','configuration.roomCreate',-1,'2016-02-08 15:52:21',NULL,NULL),(68,16,'Update Room','configuration.roomUpdate',-1,'2016-02-08 15:52:21',NULL,NULL),(69,16,'Delete Room','configuration.roomDelete',-1,'2016-02-08 15:52:21',NULL,NULL),(70,17,'Assign Room and Bed Types','configuration.roomTypeRoomUpdate',-1,'2016-02-08 15:53:47',NULL,NULL),(71,19,'Create RoomCharge','configuration.roomChargeCreate',-1,'2016-02-08 15:55:00',NULL,NULL),(72,19,'Update RoomCharge','configuration.roomChargeUpdate',-1,'2016-02-08 15:55:00',NULL,NULL),(73,19,'Delete RoomCharge','configuration.roomChargeDelete',-1,'2016-02-08 15:55:00',NULL,NULL),(74,20,'Create Room Maintenance','configuration.roomMaintenanceCreate',-1,'2016-02-08 15:55:59',NULL,NULL),(75,20,'Update Room Maintenance','configuration.roomMaintenanceUpdate',-1,'2016-02-08 15:55:59',NULL,NULL),(76,20,'Delete Room Maintenance','configuration.roomMaintenanceDelete',-1,'2016-02-08 15:55:59',NULL,NULL),(77,21,'Create Charges for Category','configuration.chargePerCategoryCreate',-1,'2016-02-08 16:00:51',NULL,NULL),(78,22,'Create Doctor Schedule','configuration.docScheduleCreate',-1,'2016-02-08 16:02:26',NULL,NULL),(79,22,'Update Doctor Schedule','configuration.docScheduleUpdate',-1,'2016-02-08 16:02:26',NULL,NULL),(80,22,'Delete Doctor Schedule','configuration.docScheduleDelete',-1,'2016-02-08 16:02:26',NULL,NULL),(81,24,'Create Speciality','configuration.specialityCreate',-1,'2016-02-08 16:03:14',NULL,NULL),(82,24,'Update Speciality','configuration.specialityUpdate',-1,'2016-02-08 16:03:14',NULL,NULL),(83,24,'Delete Speciality','configuration.specialityDelete',-1,'2016-02-08 16:03:14',NULL,NULL),(84,26,'Create Alerts','configuration.alertCreate',-1,'2016-02-08 16:04:00',NULL,NULL),(85,26,'Update Alerts','configuration.alertUpdate',-1,'2016-02-08 16:04:00',NULL,NULL),(86,26,'Delete Alerts','configuration.alertDelete',-1,'2016-02-08 16:04:00',NULL,NULL),(87,27,'Create Patient Category','configuration.patientCategoryCreate',-1,'2016-02-08 16:04:42',NULL,NULL),(88,27,'Update Patient Category','configuration.patientCategoryUpdate',-1,'2016-02-08 16:04:42',NULL,NULL),(89,27,'Delete Patient Category','configuration.patientCategoryDelete',-1,'2016-02-08 16:04:42',NULL,NULL),(90,29,'Create Country','configuration.countryCreate',-1,'2016-02-08 16:05:26',NULL,NULL),(91,29,'Update Country','configuration.countryUpdate',-1,'2016-02-08 16:05:27',NULL,NULL),(92,29,'Delete Country','configuration.countryDelete',-1,'2016-02-08 16:05:27',NULL,NULL),(93,30,'Create State','configuration.stateCreate',-1,'2016-02-08 16:06:03',NULL,NULL),(94,30,'Update State','configuration.stateUpdate',-1,'2016-02-08 16:06:03',NULL,NULL),(95,30,'Delete State','configuration.stateDelete',-1,'2016-02-08 16:06:03',NULL,NULL),(96,31,'Create City','configuration.cityCreate',-1,'2016-02-08 16:06:59',NULL,NULL),(97,31,'Update City','configuration.cityUpdate',-1,'2016-02-08 16:06:59',NULL,NULL),(98,31,'Delete City','configuration.cityDelete',-1,'2016-02-08 16:06:59',NULL,NULL),(99,NULL,'Patient','patient',-1,'2016-02-09 12:15:31',NULL,NULL),(100,99,'Details','patient.view',-1,'2016-02-09 12:16:49',NULL,NULL),(101,99,'Timeline','patient.timeLine',-1,'2016-02-09 12:17:35',NULL,NULL),(102,99,'Documents','patient.documents',-1,'2016-02-09 12:17:43',NULL,NULL),(103,99,'Encounter','patient.encounter',-1,'2016-02-09 12:17:57',NULL,NULL),(104,99,'Notes','patient.notes',-1,'2016-02-09 12:18:01',NULL,NULL),(105,99,'Consultant','patient.consultant',-1,'2016-02-09 12:18:12',NULL,NULL),(106,99,'Procedure','patient.procedure',-1,'2016-02-09 12:18:22',NULL,NULL),(107,99,'Prescription','patient.prescription',-1,'2016-02-09 12:18:45',NULL,NULL),(108,99,'Alert','patient.alert',-1,'2016-02-09 12:18:55',NULL,NULL),(109,99,'Update Patient','patient.update',-1,'2016-03-29 19:16:49',NULL,NULL),(110,104,'Create Note','patient.noteCreate',-1,'2016-03-29 19:17:30',NULL,NULL),(111,104,'Update Note','patient.noteUpdate',-1,'2016-03-29 19:17:55',NULL,NULL),(112,104,'View Note','patient.noteView',-1,'2016-03-29 19:18:15',NULL,NULL),(113,105,'Create Consultant','patient.consultantCreate',-1,'2016-03-29 19:18:58',NULL,NULL),(114,105,'Update Consultant','patient.consultantUpdate',-1,'2016-03-29 19:23:26',NULL,NULL),(115,105,'Delete Consultant','patient.consultantDelete',-1,'2016-03-29 19:23:58',NULL,NULL),(116,106,'Add Procedure','patient.add_procedure',-1,'2016-03-29 19:24:29',NULL,NULL),(117,106,'Update Procedure','patient.edit_procedure',-1,'2016-03-29 19:24:54',NULL,NULL),(118,106,'Delete Procedure','patient.delete_procedure',-1,'2016-03-29 19:25:10',NULL,NULL),(119,108,'Create Alert','patient.alertCreate',-1,'2016-03-29 19:25:45',NULL,NULL),(120,108,'Update Alert','patient.alertUpdate',-1,'2016-03-29 19:26:03',NULL,NULL),(121,103,'Create Admission','patient.admission',-1,'2016-03-29 19:30:01',NULL,NULL),(122,103,'Create Appointment','patient.appointment',-1,'2016-03-29 19:30:22',NULL,NULL),(123,103,'Transfer','patient.transfer',-1,'2016-03-29 19:31:07',NULL,NULL),(124,103,'Discharge','patient.discharge',-1,'2016-03-29 19:31:31',NULL,NULL),(125,103,'Swapping','patient.swapping',-1,'2016-03-29 19:31:51',NULL,NULL),(126,103,'Change Appointment status','patient.changeStatus',-1,'2016-03-29 19:32:47',NULL,NULL),(127,103,'Cancel Appointment','patient.cancelAppointment',-1,'2016-03-29 19:33:56',NULL,NULL),(128,103,'Edit Doctor Fee','patient.editDoctorFee',-1,'2016-03-29 19:34:57',NULL,NULL),(129,99,'Billing','patient.billing',-1,'2016-03-29 19:38:05',NULL,NULL),(130,129,'Add Other Charges','patient.addOtherCharge',-1,'2016-03-29 19:38:32',NULL,NULL),(131,129,'Edit Other Charges','patient.editOtherCharge',-1,'2016-03-29 19:39:06',NULL,NULL),(132,129,'Add Extra Amount','patient.addExtraAmount',-1,'2016-03-29 19:39:36',NULL,NULL),(133,129,'Add Concession Amount','patient.addConcessionAmount',-1,'2016-03-29 19:39:59',NULL,NULL),(134,129,'Add Payment','patient.addPayment',-1,'2016-03-29 19:40:24',NULL,NULL),(135,129,'Edit Payment','patient.editPayment',-1,'2016-03-29 19:41:15',NULL,NULL),(136,129,'Delete Payment','patient.deletePayment',-1,'2016-03-29 19:41:53',NULL,NULL),(137,129,'Add Room Concession','patient.roomConcession',-1,'2016-03-29 19:42:17',NULL,NULL),(138,129,'Finalize','patient.finalize',-1,'2016-03-29 19:42:39',NULL,NULL),(139,129,'Unfinalize','patient.unfinalize',-1,'2016-03-29 19:42:54',NULL,NULL),(140,129,'Authorize','patient.authorize',-1,'2016-03-29 19:43:19',NULL,NULL),(141,129,'Unauthorize','patient.unathorize',-1,'2016-03-29 19:44:04',NULL,NULL),(142,99,'In-Patient','patient.inPatients',-1,'2016-05-12 11:20:52',NULL,NULL),(143,99,'Out-Patient','patient.outPatients',-1,'2016-05-12 11:21:47',NULL,NULL),(144,NULL,'Pharmacy','pharmacy',-1,'2016-05-12 12:32:29',NULL,NULL),(145,144,'Purchase','pharmacy.purchase',-1,'2016-05-12 12:43:50',NULL,NULL),(146,145,'Add Purchase','pharmacy.purchaseCreate',-1,'2016-05-12 12:32:51',NULL,NULL),(147,145,'Edit Purchase','pharmacy.purchaseUpdate',-1,'2016-05-12 12:33:27',NULL,NULL),(148,144,'Purchase Return','pharmacy.purchaseReturn',-1,'2016-05-12 12:44:58',NULL,NULL),(149,148,'Add Purchase Return','pharmacy.purchaseReturnCreate',-1,'2016-05-12 12:45:42',NULL,NULL),(150,148,'Edit Purchase Return','pharmacy.purchaseReturnUpdate',-1,'2016-05-12 12:46:08',NULL,NULL),(151,144,'Sale','pharmacy.sales',-1,'2016-05-12 12:46:55',NULL,NULL),(152,151,'Add Sale','pharmacy.saleCreate',-1,'2016-05-12 12:47:06',NULL,NULL),(153,151,'Edit Sale','pharmacy.saleUpdate',-1,'2016-05-12 12:51:53',NULL,NULL),(154,144,'Sale Return','pharmacy.saleReturn',-1,'2016-05-12 12:52:48',NULL,NULL),(155,154,'Add Sale Return','pharmacy.saleReturnCreate',-1,'2016-05-12 12:53:07',NULL,NULL),(156,154,'Edit Sale Return','pharmacy.saleReturnUpdate',-1,'2016-05-12 12:53:49',NULL,NULL),(157,144,'Reports','pharmacy.report',-1,'2016-05-12 12:57:49',NULL,NULL),(158,144,'Stock Detail','pharmacy.stock',-1,'2016-05-12 12:59:19',NULL,NULL),(159,158,'Batch Details','pharmacy.batchDetails',-1,'2016-05-12 12:59:38',NULL,NULL),(160,158,'Stock Adjust','pharmacy.stockAdjust',-1,'2016-05-12 12:59:57',NULL,NULL),(161,144,'Configuration','pharmacy.configuration',-1,'2016-05-12 13:00:41',NULL,NULL),(162,161,'Brand','pharmacy.brand',-1,'2016-05-12 13:01:25',NULL,NULL),(163,161,'Brand Rep','pharmacy.brandrep',-1,'2016-05-12 13:01:45',NULL,NULL),(164,161,'Products','pharmacy.products',-1,'2016-05-12 13:02:11',NULL,NULL),(165,161,'Supplier','pharmacy.supplier',-1,'2016-05-12 13:02:28',NULL,NULL),(166,162,'Add Brand','pharmacy.brandCreate',-1,'2016-05-12 13:03:07',NULL,NULL),(167,162,'Edit Brand','pharmacy.brandUpdate',-1,'2016-05-12 13:03:27',NULL,NULL),(168,163,'Add Brand Rep','pharmacy.brandrepCreate',-1,'2016-05-12 13:03:47',NULL,NULL),(169,163,'Edit Brand Rep','pharmacy.brandrepUpdate',-1,'2016-05-12 13:04:04',NULL,NULL),(170,164,'Add Product','pharmacy.productAdd',-1,'2016-05-12 13:05:09',NULL,NULL),(171,164,'Edit Product','pharmacy.productEdit',-1,'2016-05-12 13:05:22',NULL,NULL),(172,165,'Add Supplier','pharmacy.supplierCreate',-1,'2016-05-12 13:05:46',NULL,NULL),(173,165,'Edit Supplier','pharmacy.supplierUpdate',-1,'2016-05-12 13:05:58',NULL,NULL),(174,161,'Brand Division','pharmacy.brandDivision',-1,'2016-05-12 13:06:54',NULL,NULL),(175,174,'Add Brand Division','pharmacy.brandDivisionCreate',-1,'2016-05-12 13:08:16',NULL,NULL),(176,174,'Edit Brand Division','pharmacy.brandDivisionUpdate',-1,'2016-05-12 13:08:42',NULL,NULL),(177,161,'Drug Class','pharmacy.drugclass',-1,'2016-05-12 13:17:33',NULL,NULL),(178,177,'Add Drug Class','pharmacy.drugclassCreate',-1,'2016-05-12 13:17:58',NULL,NULL),(179,177,'Edit Drug Class','pharmacy.drugclassUpdate',-1,'2016-05-12 13:18:57',NULL,NULL),(180,161,'Generic Names','pharmacy.drugclass',-1,'2016-05-12 13:19:41',NULL,NULL),(181,180,'Add Generic Name','pharmacy.genericNameCreate',-1,'2016-05-12 13:20:14',NULL,NULL),(182,180,'Edit Generic Name','pharmacy.genericNameUpdate',-1,'2016-05-12 13:20:32',NULL,NULL),(183,161,'Drug Class & Generic','pharmacy.drugGeneric',-1,'2016-05-12 13:21:01',NULL,NULL),(184,183,'Add Drug Class & Generic','pharmacy.drugGenericCreate',-1,'2016-05-12 13:21:46',NULL,NULL),(185,183,'Edit Drug Class & Generic','pharmacy.drugGenericUpdate',-1,'2016-05-12 13:22:09',NULL,NULL),(186,161,'Product Description','pharmacy.prodesc',-1,'2016-05-12 13:22:52',NULL,NULL),(187,186,'Add Product Description','pharmacy.prodescCreate',-1,'2016-05-12 13:23:15',NULL,NULL),(188,186,'Edit Product Description','pharmacy.prodescUpdate',-1,'2016-05-12 13:23:41',NULL,NULL),(189,161,'Vat','pharmacy.vat',-1,'2016-05-12 13:24:16',NULL,NULL),(190,189,'Add Vat','pharmacy.vatCreate',-1,'2016-05-12 13:24:35',NULL,NULL),(191,189,'Edit Vat','pharmacy.vatUpdate',-1,'2016-05-12 13:24:47',NULL,NULL),(192,161,'Packing Unit','pharmacy.packingUnit',-1,'2016-05-12 13:25:22',NULL,NULL),(193,192,'Add Packing Unit','pharmacy.packingUnitCreate',-1,'2016-05-12 13:25:39',NULL,NULL),(194,192,'Edit Packing Unit','pharmacy.packingUnitUpdate',-1,'2016-05-12 13:25:56',NULL,NULL),(195,99,'Patient Registration','patient.registration',-1,'2016-05-12 17:39:56',NULL,NULL),(196,129,'Administrative Discharge','patient.admindischarge',-1,'2016-05-13 11:16:11',NULL,NULL),(197,103,'Future Appointment','patient.futureAppointment',-1,'2016-05-18 15:24:32',NULL,NULL),(198,103,'Future Appointment List','patient.futureAppointmentList',-1,'2016-05-18 15:24:53',NULL,NULL),(199,99,'Vitals','patient.vitals',-1,'2016-05-18 15:25:36',NULL,NULL),(200,199,'Add Vitals','patient.vitalCreate',-1,'2016-05-18 15:28:20',NULL,NULL),(201,99,'Modify Casesheet No.','patient.modifyCaseSheetNo',-1,'2016-05-20 13:07:44',NULL,NULL),(202,99,'Modify Admission','patient.update_admission',-1,'2016-05-20 13:39:02',NULL,NULL),(203,99,'Backdate appointments','patient.backdateappointment',-1,'2016-05-21 16:36:48',NULL,NULL),(204,144,'Sale Billing','pharmacy.makePayment',-1,'2016-05-23 12:23:20',NULL,NULL),(205,103,'Cancel Last Encounter','patient.cancelLastEncounter',-1,'2016-05-24 17:34:12',NULL,NULL),(206,103,'Cancel Admission','patient.cancelAdmission',-1,'2016-05-24 17:37:21',NULL,NULL),(207,16,'Room Maintanance','configuration.updateMaintenance',-1,'2016-05-25 10:39:23',NULL,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=latin1;

/*Data for the table `co_role` */

insert  into `co_role`(`role_id`,`tenant_id`,`description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (64,58,'Administrator','1',-1,'2016-02-02 22:26:38',-1,'2016-02-02 22:26:38','0000-00-00 00:00:00'),(65,59,'Administrator','1',-1,'2016-02-02 22:43:11',-1,'2016-02-02 22:43:11','0000-00-00 00:00:00'),(66,58,'Admin','1',51,'2016-02-04 07:02:50',51,'2016-02-04 07:02:50','0000-00-00 00:00:00'),(67,58,'Cashier','1',51,'2016-02-04 07:03:04',51,'2016-02-04 07:03:04','0000-00-00 00:00:00'),(68,58,'Nurse','1',51,'2016-02-05 22:27:45',51,'2016-02-05 22:27:45','0000-00-00 00:00:00'),(69,60,'admin','1',-1,'2016-02-17 06:28:38',-1,'2016-02-17 06:28:38','0000-00-00 00:00:00'),(72,60,'Sub-Admin','1',59,'2016-02-19 03:57:13',59,'2016-02-19 07:38:06','0000-00-00 00:00:00'),(73,60,'Chief Cashier','1',59,'2016-02-19 04:17:31',59,'2016-02-19 04:31:12','0000-00-00 00:00:00'),(74,60,'Doctor','1',59,'2016-02-19 04:17:46',59,'2016-02-19 04:17:46','0000-00-00 00:00:00'),(79,60,'Nurse','1',59,'2016-02-19 04:22:36',59,'2016-02-19 04:29:12','0000-00-00 00:00:00'),(80,60,'Receptionist','0',59,'2016-02-19 04:22:48',59,'2016-02-19 04:23:14','0000-00-00 00:00:00'),(81,60,'Accountant','1',59,'2016-02-19 04:26:33',59,'2016-02-19 04:29:23','0000-00-00 00:00:00'),(82,60,'PRO','1',59,'2016-02-19 04:27:34',59,'2016-02-19 04:27:58','0000-00-00 00:00:00'),(84,60,'Human Resource','1',59,'2016-02-19 04:31:40',59,'2016-02-19 04:48:00','0000-00-00 00:00:00'),(85,60,'Director','0',59,'2016-02-19 04:43:23',59,'2016-02-19 04:54:09','0000-00-00 00:00:00'),(86,60,'Psychologist','1',59,'2016-02-19 04:43:59',59,'2016-02-19 04:54:02','0000-00-00 00:00:00'),(87,60,'Pharmacy','1',59,'2016-02-19 04:45:43',59,'2016-02-19 04:53:53','0000-00-00 00:00:00'),(88,60,'Supervisor','1',59,'2016-02-19 04:47:28',59,'2016-02-19 04:53:40','0000-00-00 00:00:00'),(89,60,'manager','1',59,'2016-02-19 04:54:33',59,'2016-02-19 04:54:33','0000-00-00 00:00:00'),(90,60,'Care Provider','1',59,'2016-02-19 07:12:03',59,'2016-02-19 07:12:30','0000-00-00 00:00:00'),(91,61,'admin','1',-1,'2016-02-21 23:16:05',-1,'2016-02-21 23:16:05','0000-00-00 00:00:00'),(92,61,'Administrator','1',67,'2016-02-23 02:28:08',67,'2016-02-25 04:59:00','0000-00-00 00:00:00'),(93,62,'admin','1',-1,'2016-02-29 02:00:01',-1,'2016-02-29 02:00:01','0000-00-00 00:00:00'),(94,0,'Tester','1',51,'2016-03-23 01:00:31',51,'2016-03-23 01:00:31','0000-00-00 00:00:00'),(95,23,'Tester','1',51,'2016-03-23 01:37:27',51,'2016-03-23 01:37:27','0000-00-00 00:00:00'),(96,58,'Doctor','1',51,'2016-04-29 05:00:24',51,'2016-05-25 00:17:59','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=780 DEFAULT CHARSET=latin1;

/*Data for the table `co_roles_resources` */

insert  into `co_roles_resources`(`role_perm_id`,`tenant_id`,`role_id`,`resource_id`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (459,58,64,1,'1',-1,'2016-05-12 17:11:23',NULL,NULL),(460,58,64,2,'1',-1,'2016-05-12 17:11:23',NULL,NULL),(461,58,64,3,'1',-1,'2016-05-12 17:11:23',NULL,NULL),(462,58,64,4,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(463,58,64,5,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(464,58,64,6,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(465,58,64,7,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(466,58,64,8,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(467,58,64,9,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(468,58,64,10,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(469,58,64,11,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(470,58,64,12,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(471,58,64,13,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(472,58,64,14,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(473,58,64,15,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(474,58,64,16,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(475,58,64,17,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(476,58,64,18,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(477,58,64,19,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(478,58,64,20,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(479,58,64,21,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(480,58,64,22,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(481,58,64,23,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(482,58,64,24,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(483,58,64,25,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(484,58,64,26,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(485,58,64,27,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(486,58,64,28,'1',-1,'2016-05-12 17:11:24',NULL,NULL),(487,58,64,29,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(488,58,64,30,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(489,58,64,31,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(490,58,64,32,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(491,58,64,33,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(492,58,64,34,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(493,58,64,35,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(494,58,64,36,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(495,58,64,37,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(496,58,64,38,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(497,58,64,39,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(498,58,64,40,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(499,58,64,41,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(500,58,64,42,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(501,58,64,43,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(502,58,64,44,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(503,58,64,45,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(504,58,64,46,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(505,58,64,47,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(506,58,64,48,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(507,58,64,49,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(508,58,64,54,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(509,58,64,55,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(510,58,64,56,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(511,58,64,57,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(512,58,64,58,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(513,58,64,59,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(514,58,64,60,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(515,58,64,61,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(516,58,64,62,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(517,58,64,63,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(518,58,64,64,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(519,58,64,65,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(520,58,64,66,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(521,58,64,67,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(522,58,64,68,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(523,58,64,69,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(524,58,64,70,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(525,58,64,71,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(526,58,64,72,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(527,58,64,73,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(528,58,64,74,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(529,58,64,75,'1',-1,'2016-05-12 17:11:25',NULL,NULL),(530,58,64,76,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(531,58,64,77,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(532,58,64,78,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(533,58,64,79,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(534,58,64,80,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(535,58,64,81,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(536,58,64,82,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(537,58,64,83,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(538,58,64,84,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(539,58,64,85,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(540,58,64,86,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(541,58,64,87,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(542,58,64,88,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(543,58,64,89,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(544,58,64,90,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(545,58,64,91,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(546,58,64,92,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(547,58,64,93,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(548,58,64,94,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(549,58,64,95,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(550,58,64,96,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(551,58,64,97,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(552,58,64,98,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(553,58,64,99,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(554,58,64,100,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(555,58,64,101,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(556,58,64,102,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(557,58,64,103,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(558,58,64,104,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(559,58,64,105,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(560,58,64,106,'1',-1,'2016-05-12 17:11:26',NULL,NULL),(561,58,64,107,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(562,58,64,108,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(563,58,64,109,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(564,58,64,110,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(565,58,64,111,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(566,58,64,112,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(567,58,64,113,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(568,58,64,114,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(569,58,64,115,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(570,58,64,116,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(571,58,64,117,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(572,58,64,118,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(573,58,64,119,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(574,58,64,120,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(575,58,64,121,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(576,58,64,122,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(577,58,64,123,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(578,58,64,124,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(579,58,64,125,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(580,58,64,126,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(581,58,64,127,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(582,58,64,128,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(583,58,64,129,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(584,58,64,130,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(585,58,64,131,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(586,58,64,132,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(587,58,64,133,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(588,58,64,134,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(589,58,64,135,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(590,58,64,136,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(591,58,64,137,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(592,58,64,138,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(593,58,64,139,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(594,58,64,140,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(595,58,64,141,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(596,58,64,142,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(597,58,64,143,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(598,58,64,144,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(599,58,64,145,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(600,58,64,146,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(601,58,64,147,'1',-1,'2016-05-12 17:11:27',NULL,NULL),(602,58,64,148,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(603,58,64,149,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(604,58,64,150,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(605,58,64,151,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(606,58,64,152,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(607,58,64,153,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(608,58,64,154,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(609,58,64,155,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(610,58,64,156,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(611,58,64,157,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(612,58,64,158,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(613,58,64,159,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(614,58,64,160,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(615,58,64,161,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(616,58,64,162,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(617,58,64,163,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(618,58,64,164,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(619,58,64,165,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(620,58,64,166,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(621,58,64,167,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(622,58,64,168,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(623,58,64,169,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(624,58,64,170,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(625,58,64,171,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(626,58,64,172,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(627,58,64,173,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(628,58,64,174,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(629,58,64,175,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(630,58,64,176,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(631,58,64,177,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(632,58,64,178,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(633,58,64,179,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(634,58,64,180,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(635,58,64,181,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(636,58,64,182,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(637,58,64,183,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(638,58,64,184,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(639,58,64,185,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(640,58,64,186,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(641,58,64,187,'1',-1,'2016-05-12 17:11:28',NULL,NULL),(642,58,64,188,'1',-1,'2016-05-12 17:11:29',NULL,NULL),(643,58,64,189,'1',-1,'2016-05-12 17:11:29',NULL,NULL),(644,58,64,190,'1',-1,'2016-05-12 17:11:29',NULL,NULL),(645,58,64,191,'1',-1,'2016-05-12 17:11:29',NULL,NULL),(646,58,64,192,'1',-1,'2016-05-12 17:11:29',NULL,NULL),(647,58,64,193,'1',-1,'2016-05-12 17:11:29',NULL,NULL),(648,58,64,194,'1',-1,'2016-05-12 17:11:29',NULL,NULL),(649,58,64,195,'1',-1,'2016-05-12 17:41:02',NULL,NULL),(650,58,64,196,'1',-1,'2016-05-13 11:16:42',NULL,NULL),(651,58,64,197,'1',-1,'2016-05-18 15:26:36',NULL,NULL),(652,58,64,198,'1',-1,'2016-05-18 15:26:43',NULL,NULL),(653,58,64,199,'1',-1,'2016-05-18 15:26:48',NULL,NULL),(654,58,64,200,'1',-1,'2016-05-18 15:28:48',NULL,NULL),(655,58,96,1,'1',51,'2016-05-18 16:24:09',NULL,NULL),(656,58,96,2,'1',51,'2016-05-18 16:24:09',NULL,NULL),(657,58,96,3,'1',51,'2016-05-18 16:24:09',NULL,NULL),(658,58,96,4,'1',51,'2016-05-18 16:24:09',NULL,NULL),(659,58,96,5,'1',51,'2016-05-18 16:24:09',NULL,NULL),(660,58,96,6,'1',51,'2016-05-18 16:24:09',NULL,NULL),(661,58,96,7,'1',51,'2016-05-18 16:24:09',NULL,NULL),(662,58,96,8,'1',51,'2016-05-18 16:24:09',NULL,NULL),(663,58,96,9,'1',51,'2016-05-18 16:24:09',NULL,NULL),(664,58,96,10,'1',51,'2016-05-18 16:24:09',NULL,NULL),(665,58,96,11,'1',51,'2016-05-18 16:24:09',NULL,NULL),(666,58,96,12,'1',51,'2016-05-18 16:24:09',NULL,NULL),(667,58,96,13,'1',51,'2016-05-18 16:24:09',NULL,NULL),(668,58,96,14,'1',51,'2016-05-18 16:24:09',NULL,NULL),(669,58,96,15,'1',51,'2016-05-18 16:24:09',NULL,NULL),(670,58,96,16,'1',51,'2016-05-18 16:24:09',NULL,NULL),(671,58,96,17,'1',51,'2016-05-18 16:24:09',NULL,NULL),(672,58,96,18,'1',51,'2016-05-18 16:24:09',NULL,NULL),(673,58,96,19,'1',51,'2016-05-18 16:24:09',NULL,NULL),(674,58,96,20,'1',51,'2016-05-18 16:24:09',NULL,NULL),(675,58,96,21,'1',51,'2016-05-18 16:24:09',NULL,NULL),(676,58,96,22,'1',51,'2016-05-18 16:24:09',NULL,NULL),(677,58,96,23,'1',51,'2016-05-18 16:24:09',NULL,NULL),(678,58,96,24,'1',51,'2016-05-18 16:24:09',NULL,NULL),(679,58,96,25,'1',51,'2016-05-18 16:24:10',NULL,NULL),(680,58,96,26,'1',51,'2016-05-18 16:24:10',NULL,NULL),(681,58,96,27,'1',51,'2016-05-18 16:24:10',NULL,NULL),(682,58,96,28,'1',51,'2016-05-18 16:24:10',NULL,NULL),(683,58,96,29,'1',51,'2016-05-18 16:24:10',NULL,NULL),(684,58,96,30,'1',51,'2016-05-18 16:24:10',NULL,NULL),(685,58,96,31,'1',51,'2016-05-18 16:24:10',NULL,NULL),(686,58,96,32,'1',51,'2016-05-18 16:24:10',NULL,NULL),(687,58,96,33,'1',51,'2016-05-18 16:24:10',NULL,NULL),(688,58,96,34,'1',51,'2016-05-18 16:24:10',NULL,NULL),(689,58,96,78,'1',51,'2016-05-18 16:24:10',NULL,NULL),(690,58,96,79,'1',51,'2016-05-18 16:24:10',NULL,NULL),(691,58,96,80,'1',51,'2016-05-18 16:24:10',NULL,NULL),(692,58,96,99,'1',51,'2016-05-18 16:24:10',NULL,NULL),(693,58,96,100,'1',51,'2016-05-18 16:24:10',NULL,NULL),(694,58,96,101,'1',51,'2016-05-18 16:24:10',NULL,NULL),(695,58,96,102,'1',51,'2016-05-18 16:24:10',NULL,NULL),(696,58,96,103,'1',51,'2016-05-18 16:24:10',NULL,NULL),(697,58,96,104,'1',51,'2016-05-18 16:24:10',NULL,NULL),(698,58,96,105,'1',51,'2016-05-18 16:24:10',NULL,NULL),(699,58,96,106,'1',51,'2016-05-18 16:24:10',NULL,NULL),(700,58,96,107,'1',51,'2016-05-18 16:24:10',NULL,NULL),(701,58,96,108,'1',51,'2016-05-18 16:24:10',NULL,NULL),(702,58,96,109,'1',51,'2016-05-18 16:24:10',NULL,NULL),(703,58,96,110,'1',51,'2016-05-18 16:24:10',NULL,NULL),(704,58,96,111,'1',51,'2016-05-18 16:24:10',NULL,NULL),(705,58,96,112,'1',51,'2016-05-18 16:24:10',NULL,NULL),(706,58,96,113,'1',51,'2016-05-18 16:24:10',NULL,NULL),(707,58,96,114,'1',51,'2016-05-18 16:24:10',NULL,NULL),(708,58,96,115,'1',51,'2016-05-18 16:24:10',NULL,NULL),(709,58,96,116,'1',51,'2016-05-18 16:24:10',NULL,NULL),(710,58,96,117,'1',51,'2016-05-18 16:24:10',NULL,NULL),(711,58,96,118,'1',51,'2016-05-18 16:24:11',NULL,NULL),(712,58,96,119,'1',51,'2016-05-18 16:24:11',NULL,NULL),(713,58,96,120,'1',51,'2016-05-18 16:24:11',NULL,NULL),(714,58,96,121,'1',51,'2016-05-18 16:24:11',NULL,NULL),(715,58,96,122,'1',51,'2016-05-18 16:24:11',NULL,NULL),(716,58,96,123,'1',51,'2016-05-18 16:24:11',NULL,NULL),(717,58,96,124,'1',51,'2016-05-18 16:24:11',NULL,NULL),(718,58,96,125,'1',51,'2016-05-18 16:24:11',NULL,NULL),(719,58,96,126,'1',51,'2016-05-18 16:24:11',NULL,NULL),(720,58,96,127,'1',51,'2016-05-18 16:24:11',NULL,NULL),(721,58,96,128,'1',51,'2016-05-18 16:24:11',NULL,NULL),(722,58,96,129,'1',51,'2016-05-18 16:24:11',NULL,NULL),(723,58,96,130,'1',51,'2016-05-18 16:24:11',NULL,NULL),(724,58,96,131,'1',51,'2016-05-18 16:24:11',NULL,NULL),(725,58,96,132,'1',51,'2016-05-18 16:24:11',NULL,NULL),(726,58,96,133,'1',51,'2016-05-18 16:24:11',NULL,NULL),(727,58,96,134,'1',51,'2016-05-18 16:24:11',NULL,NULL),(728,58,96,135,'1',51,'2016-05-18 16:24:11',NULL,NULL),(729,58,96,136,'1',51,'2016-05-18 16:24:11',NULL,NULL),(730,58,96,137,'1',51,'2016-05-18 16:24:11',NULL,NULL),(731,58,96,138,'1',51,'2016-05-18 16:24:11',NULL,NULL),(732,58,96,139,'1',51,'2016-05-18 16:24:11',NULL,NULL),(733,58,96,140,'1',51,'2016-05-18 16:24:11',NULL,NULL),(734,58,96,141,'1',51,'2016-05-18 16:24:11',NULL,NULL),(735,58,96,142,'1',51,'2016-05-18 16:24:11',NULL,NULL),(736,58,96,143,'1',51,'2016-05-18 16:24:11',NULL,NULL),(737,58,96,144,'1',51,'2016-05-18 16:24:11',NULL,NULL),(738,58,96,145,'1',51,'2016-05-18 16:24:11',NULL,NULL),(739,58,96,146,'1',51,'2016-05-18 16:24:11',NULL,NULL),(740,58,96,147,'1',51,'2016-05-18 16:24:11',NULL,NULL),(741,58,96,148,'1',51,'2016-05-18 16:24:11',NULL,NULL),(742,58,96,149,'1',51,'2016-05-18 16:24:11',NULL,NULL),(743,58,96,150,'1',51,'2016-05-18 16:24:11',NULL,NULL),(744,58,96,151,'1',51,'2016-05-18 16:24:11',NULL,NULL),(745,58,96,152,'1',51,'2016-05-18 16:24:11',NULL,NULL),(746,58,96,153,'1',51,'2016-05-18 16:24:11',NULL,NULL),(747,58,96,154,'1',51,'2016-05-18 16:24:11',NULL,NULL),(748,58,96,155,'1',51,'2016-05-18 16:24:11',NULL,NULL),(749,58,96,156,'1',51,'2016-05-18 16:24:12',NULL,NULL),(750,58,96,157,'1',51,'2016-05-18 16:24:12',NULL,NULL),(751,58,96,158,'1',51,'2016-05-18 16:24:12',NULL,NULL),(752,58,96,159,'1',51,'2016-05-18 16:24:12',NULL,NULL),(753,58,96,160,'1',51,'2016-05-18 16:24:12',NULL,NULL),(754,58,96,161,'1',51,'2016-05-18 16:24:12',NULL,NULL),(755,58,96,162,'1',51,'2016-05-18 16:24:12',NULL,NULL),(756,58,96,163,'1',51,'2016-05-18 16:24:12',NULL,NULL),(757,58,96,164,'1',51,'2016-05-18 16:24:12',NULL,NULL),(758,58,96,165,'1',51,'2016-05-18 16:24:12',NULL,NULL),(759,58,96,174,'1',51,'2016-05-18 16:24:12',NULL,NULL),(760,58,96,177,'1',51,'2016-05-18 16:24:12',NULL,NULL),(761,58,96,180,'1',51,'2016-05-18 16:24:12',NULL,NULL),(762,58,96,183,'1',51,'2016-05-18 16:24:12',NULL,NULL),(763,58,96,186,'1',51,'2016-05-18 16:24:12',NULL,NULL),(764,58,96,189,'1',51,'2016-05-18 16:24:12',NULL,NULL),(765,58,96,192,'1',51,'2016-05-18 16:24:12',NULL,NULL),(766,58,96,195,'1',51,'2016-05-18 16:24:12',NULL,NULL),(767,58,96,196,'1',51,'2016-05-18 16:24:12',NULL,NULL),(768,58,96,197,'1',51,'2016-05-18 16:24:12',NULL,NULL),(769,58,96,198,'1',51,'2016-05-18 16:24:12',NULL,NULL),(770,58,96,199,'1',51,'2016-05-18 16:24:12',NULL,NULL),(771,58,96,200,'1',51,'2016-05-18 16:24:12',NULL,NULL),(772,58,96,201,'1',51,'2016-05-20 13:08:04',NULL,NULL),(773,58,64,201,'1',51,'2016-05-20 13:09:12',NULL,NULL),(774,58,64,202,'1',51,'2016-05-20 13:39:28',NULL,NULL),(775,58,64,203,'1',51,'2016-05-21 16:37:57',NULL,NULL),(776,58,64,204,'1',51,'2016-05-23 12:23:46',NULL,NULL),(777,58,64,205,'1',51,'2016-05-24 17:38:08',NULL,NULL),(778,58,64,206,'1',51,'2016-05-24 17:38:12',NULL,NULL),(779,58,64,207,'1',51,'2016-05-25 10:40:23',NULL,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

/*Data for the table `co_room` */

insert  into `co_room`(`room_id`,`tenant_id`,`ward_id`,`bed_name`,`maintain_id`,`occupied_status`,`notes`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (9,58,8,'2112',5,'0',NULL,'0',51,'2016-02-04 07:30:53',NULL,'2016-03-31 05:30:28','0000-00-00 00:00:00'),(10,58,9,'112',7,'1',NULL,'1',51,'2016-02-05 06:12:21',51,'2016-05-10 08:11:19','0000-00-00 00:00:00'),(11,58,8,'113',5,'1','','1',51,'2016-02-05 06:41:04',51,'2016-05-02 06:02:38','0000-00-00 00:00:00'),(12,58,8,'112',6,'1',NULL,'1',51,'2016-02-05 06:41:15',51,'2016-05-24 03:34:14','0000-00-00 00:00:00'),(17,58,8,'909',NULL,'0','','0',62,'2016-02-20 03:50:45',51,'2016-05-25 00:18:11','0000-00-00 00:00:00'),(18,60,12,'999',NULL,'1',NULL,'1',59,'2016-02-20 06:03:54',59,'2016-02-20 06:40:01','0000-00-00 00:00:00'),(19,60,12,'4234',NULL,'1','','1',59,'2016-02-20 06:05:14',59,'2016-02-21 22:50:16','0000-00-00 00:00:00'),(20,60,13,'2342',NULL,'1',NULL,'1',59,'2016-02-20 06:05:25',59,'2016-02-20 06:48:56','0000-00-00 00:00:00'),(21,60,14,'111',NULL,'1',NULL,'1',59,'2016-02-20 06:06:12',59,'2016-02-20 07:31:03','0000-00-00 00:00:00'),(23,60,13,'111',NULL,'0',NULL,'1',59,'2016-02-20 06:07:42',66,'2016-02-20 07:51:08','0000-00-00 00:00:00'),(30,60,13,'11',NULL,'0',NULL,'1',66,'2016-02-20 07:56:03',66,'2016-02-20 07:56:03','0000-00-00 00:00:00'),(31,61,15,'101',NULL,'0',NULL,'1',67,'2016-02-23 04:44:52',67,'2016-02-25 05:20:44','0000-00-00 00:00:00'),(32,61,15,'102',NULL,'1',NULL,'1',67,'2016-02-23 04:45:03',67,'2016-02-25 05:29:44','0000-00-00 00:00:00'),(33,61,15,'103',NULL,'0',NULL,'1',67,'2016-02-23 04:45:13',NULL,'2016-02-23 04:47:42','0000-00-00 00:00:00'),(34,61,16,'104',NULL,'0',NULL,'1',67,'2016-02-23 04:48:06',67,'2016-02-23 04:48:06','0000-00-00 00:00:00'),(35,61,16,'105',NULL,'1',NULL,'1',67,'2016-02-23 04:48:22',67,'2016-02-25 05:38:13','0000-00-00 00:00:00'),(36,61,16,'106',NULL,'0',NULL,'1',67,'2016-02-23 04:48:46',67,'2016-02-23 04:48:46','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_charge` */

insert  into `co_room_charge`(`charge_id`,`tenant_id`,`charge_item_id`,`room_type_id`,`charge`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,1,9,'120.00','1',51,'2016-02-04 22:29:18',51,'2016-02-04 22:29:18','0000-00-00 00:00:00'),(2,58,2,11,'300.00','1',51,'2016-02-04 22:29:50',51,'2016-04-13 02:12:18','0000-00-00 00:00:00'),(3,58,1,13,'100.00','1',51,'2016-02-09 02:04:38',51,'2016-02-09 02:04:38','0000-00-00 00:00:00'),(4,58,3,10,'1000.00','1',51,'2016-02-09 02:38:16',51,'2016-05-13 05:29:27','0000-00-00 00:00:00'),(5,58,3,11,'2000.00','1',51,'2016-02-09 02:39:16',51,'2016-02-09 02:39:16','0000-00-00 00:00:00'),(6,60,4,14,'878.00','1',59,'2016-02-20 03:28:47',59,'2016-02-20 03:28:47','0000-00-00 00:00:00'),(7,60,5,15,'215.00','1',59,'2016-02-20 03:28:57',59,'2016-02-20 03:28:57','0000-00-00 00:00:00'),(8,60,6,16,'1255.00','1',59,'2016-02-20 03:29:12',59,'2016-02-20 03:29:12','0000-00-00 00:00:00'),(9,61,7,19,'450.00','1',67,'2016-02-23 04:49:52',67,'2016-02-23 04:49:52','0000-00-00 00:00:00'),(10,61,7,20,'500.00','1',67,'2016-02-23 04:50:26',67,'2016-02-23 04:51:21','0000-00-00 00:00:00');

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

insert  into `co_room_charge_category`(`charge_cat_id`,`tenant_id`,`charge_cat_name`,`charge_cat_code`,`charge_cat_description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,NULL,'Procedures','PRC','Procedures','1',1,'2016-01-28 15:34:22',NULL,NULL,'0000-00-00 00:00:00'),(2,NULL,'Allied Charges','ALC','Allied Charges','1',1,'2016-01-28 15:35:12',NULL,NULL,'0000-00-00 00:00:00'),(3,58,'Miscellaneous','12','Miscellaneous','0',51,'2016-02-04 07:04:17',NULL,'2016-03-22 05:17:29','0000-00-00 00:00:00'),(4,58,'Procedures','1234','2000','0',51,'2016-02-09 01:47:49',NULL,'2016-03-22 05:17:30','0000-00-00 00:00:00'),(5,58,'Room Charges','123','Chargers for Rooms','1',51,'2016-02-09 02:19:45',51,'2016-02-09 02:19:45','0000-00-00 00:00:00'),(6,60,'Dummy Charges',NULL,'charges','1',59,'2016-02-17 23:09:11',59,'2016-02-19 07:51:09','0000-00-00 00:00:00'),(8,60,'Dummy2 charges',NULL,'Dummy2 Charges','1',59,'2016-02-17 23:12:06',59,'2016-02-19 07:51:53','0000-00-00 00:00:00'),(9,61,'test','tsest','tes','1',67,'2016-02-23 04:36:28',67,'2016-02-23 04:36:28','0000-00-00 00:00:00');

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

insert  into `co_room_charge_item`(`charge_item_id`,`tenant_id`,`charge_item_name`,`charge_item_code`,`charge_item_description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'Test','TE','Testing','1',51,'2016-02-03 00:46:31',51,'2016-02-03 00:46:31','0000-00-00 00:00:00'),(2,58,'doppler','2389','doppler','1',51,'2016-02-04 22:38:37',51,'2016-02-04 22:38:37','0000-00-00 00:00:00'),(3,58,'Room Rent','123','Rent for Rooms','1',51,'2016-02-09 02:37:57',51,'2016-02-09 02:37:57','0000-00-00 00:00:00'),(4,60,'DMO','1','DMO','1',59,'2016-02-19 07:28:13',59,'2016-02-19 07:28:13','0000-00-00 00:00:00'),(5,60,'NURSING CHARGES','2','NURSING CHARGES','1',59,'2016-02-19 07:28:24',59,'2016-02-19 07:28:24','0000-00-00 00:00:00'),(6,60,'ROOM RENT','3','ROOM RENT','1',59,'2016-02-19 07:28:39',59,'2016-02-19 07:28:39','0000-00-00 00:00:00'),(7,61,'DMO','DMO','DMO','1',67,'2016-02-23 02:30:10',67,'2016-02-23 02:30:10','0000-00-00 00:00:00'),(8,58,'Oxygen inducer','123','Oxygen inducer','1',51,'2016-04-29 05:05:01',51,'2016-04-29 05:05:01','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_charge_subcategory` */

insert  into `co_room_charge_subcategory`(`charge_subcat_id`,`tenant_id`,`charge_cat_id`,`charge_subcat_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (20,58,3,'misc1','1',51,'2016-02-04 07:04:18',51,'2016-02-04 07:04:18','0000-00-00 00:00:00'),(21,58,3,'misc2','1',51,'2016-02-04 07:04:18',51,'2016-02-04 07:04:18','0000-00-00 00:00:00'),(22,58,1,'stomach wash','1',51,'2016-02-04 22:34:10',51,'2016-02-04 22:34:10','0000-00-00 00:00:00'),(23,58,2,'Food expenses','1',51,'2016-02-05 06:22:39',51,'2016-05-07 04:51:04','0000-00-00 00:00:00'),(24,58,4,'Challenge test','1',51,'2016-02-09 01:47:51',51,'2016-02-09 01:48:48','0000-00-00 00:00:00'),(25,58,5,'DMO','1',51,'2016-02-09 02:19:46',51,'2016-03-22 08:35:22','0000-00-00 00:00:00'),(26,58,5,'Room Rent','1',51,'2016-02-09 02:19:46',51,'2016-03-22 05:55:34','0000-00-00 00:00:00'),(27,60,8,'vikhram','1',59,'2016-02-17 23:12:07',14,'2016-02-17 23:12:07','2016-02-19 07:51:27'),(28,60,8,'mary','1',59,'2016-02-17 23:12:07',14,'2016-02-17 23:12:07','2016-02-19 07:51:29'),(29,60,8,'jayant','1',59,'2016-02-17 23:12:07',14,'2016-02-17 23:12:07','2016-02-19 07:51:30'),(30,60,1,'Pulse Check','1',59,'2016-02-18 01:01:49',59,'2016-02-18 01:01:49','0000-00-00 00:00:00'),(31,60,2,'CANTEEN CHARGES','1',59,'2016-02-19 07:24:55',59,'2016-02-19 07:24:55','0000-00-00 00:00:00'),(32,60,2,'DRESSING CHARGES','1',59,'2016-02-19 07:25:25',59,'2016-02-19 07:25:25','0000-00-00 00:00:00'),(33,60,2,'MONITOR CHARGES','1',59,'2016-02-19 07:25:26',59,'2016-02-19 07:25:26','0000-00-00 00:00:00'),(34,60,2,'NEBULIZATION CHARGES','1',59,'2016-02-19 07:25:28',59,'2016-02-19 07:25:28','0000-00-00 00:00:00'),(35,60,1,'Aversion','1',59,'2016-02-19 07:25:54',59,'2016-02-19 07:25:54','0000-00-00 00:00:00'),(36,60,1,'Challenge Test','1',59,'2016-02-19 07:26:01',59,'2016-02-19 07:26:01','0000-00-00 00:00:00'),(37,60,1,'Treatment Charges','1',59,'2016-02-19 07:26:31',59,'2016-02-19 07:26:31','0000-00-00 00:00:00'),(38,61,9,'test','1',67,'2016-02-23 04:36:30',67,'2016-02-23 04:36:30','0000-00-00 00:00:00'),(39,58,2,'Dressing charges','1',51,'2016-05-07 04:51:13',51,'2016-05-07 04:51:13','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_types_rooms` */

insert  into `co_room_types_rooms`(`room_type_room_id`,`tenant_id`,`room_type_id`,`room_id`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (11,58,9,9,51,'2016-02-04 07:31:07',51,'2016-02-04 07:31:07'),(13,58,10,10,51,'2016-02-05 06:39:43',51,'2016-02-05 06:39:43'),(14,58,11,10,51,'2016-02-05 06:39:43',51,'2016-02-05 06:39:43'),(15,58,11,9,51,'2016-02-05 06:39:58',51,'2016-02-05 06:39:58'),(17,58,10,11,51,'2016-02-05 06:42:02',51,'2016-02-05 06:42:02'),(18,58,11,11,51,'2016-02-05 06:42:02',51,'2016-02-05 06:42:02'),(20,58,12,12,51,'2016-02-05 06:42:11',51,'2016-02-05 06:42:11'),(21,58,9,12,51,'2016-02-15 07:12:36',51,'2016-02-15 07:12:36'),(22,60,16,23,59,'2016-02-20 06:07:58',59,'2016-02-20 06:07:58'),(23,60,14,21,59,'2016-02-20 06:08:06',59,'2016-02-20 06:08:06'),(24,60,18,21,59,'2016-02-20 06:08:06',59,'2016-02-20 06:08:06'),(25,60,15,20,59,'2016-02-20 06:08:14',59,'2016-02-20 06:08:14'),(26,60,17,20,59,'2016-02-20 06:08:14',59,'2016-02-20 06:08:14'),(27,60,15,19,59,'2016-02-20 06:08:22',59,'2016-02-20 06:08:22'),(28,60,18,19,59,'2016-02-20 06:08:22',59,'2016-02-20 06:08:22'),(29,60,14,18,59,'2016-02-20 06:08:32',59,'2016-02-20 06:08:32'),(30,60,16,18,59,'2016-02-20 06:08:32',59,'2016-02-20 06:08:32'),(31,61,19,31,67,'2016-02-23 04:49:09',67,'2016-02-23 04:49:09'),(32,61,20,31,67,'2016-02-23 04:49:09',67,'2016-02-23 04:49:09'),(33,61,19,32,67,'2016-02-23 04:49:18',67,'2016-02-23 04:49:18'),(34,61,20,34,67,'2016-02-23 04:49:30',67,'2016-02-23 04:49:30'),(35,61,19,34,67,'2016-02-23 04:49:30',67,'2016-02-23 04:49:30'),(36,61,19,35,67,'2016-02-23 05:28:01',67,'2016-02-23 05:28:01'),(37,61,20,35,67,'2016-02-23 05:28:01',67,'2016-02-23 05:28:01'),(38,61,19,36,67,'2016-02-23 05:29:43',67,'2016-02-23 05:29:43'),(39,61,20,36,67,'2016-02-23 05:29:43',67,'2016-02-23 05:29:43'),(40,61,19,33,67,'2016-02-23 05:29:55',67,'2016-02-23 05:29:55'),(41,61,20,33,67,'2016-02-23 05:29:55',67,'2016-02-23 05:29:55'),(42,58,12,10,51,'2016-05-20 05:46:09',51,'2016-05-20 05:46:09'),(43,58,9,10,51,'2016-05-20 05:46:09',51,'2016-05-20 05:46:09');

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `co_speciality` */

insert  into `co_speciality`(`speciality_id`,`tenant_id`,`speciality_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'General physician','1',51,'2016-02-05 22:49:38',NULL,'2016-03-21 02:53:33','0000-00-00 00:00:00'),(2,60,'gyno','1',59,'2016-02-17 06:31:51',59,'2016-02-17 06:31:51','0000-00-00 00:00:00'),(3,60,'pediat','1',59,'2016-02-17 06:32:00',59,'2016-02-17 06:32:00','0000-00-00 00:00:00'),(4,60,'Anaesthetist','1',59,'2016-02-19 07:17:05',59,'2016-02-19 07:17:05','0000-00-00 00:00:00'),(5,60,'Dentist','1',59,'2016-02-19 07:17:22',59,'2016-02-19 07:17:22','0000-00-00 00:00:00'),(6,60,'Endocrinologist','1',59,'2016-02-19 07:17:40',59,'2016-02-19 07:17:40','0000-00-00 00:00:00'),(7,60,'Nephrologist','1',59,'2016-02-19 07:17:57',59,'2016-02-19 07:17:57','0000-00-00 00:00:00'),(8,60,'Opthomologist','1',59,'2016-02-19 07:18:07',59,'2016-02-19 07:18:07','0000-00-00 00:00:00'),(9,60,'Physiotherapist','1',59,'2016-02-19 07:18:16',59,'2016-02-19 07:18:28','0000-00-00 00:00:00'),(10,60,'Psychiatrist','1',59,'2016-02-19 07:18:45',59,'2016-02-19 07:18:45','0000-00-00 00:00:00'),(11,61,'psychiatrist','1',67,'2016-02-21 23:21:54',NULL,'2016-02-21 23:23:41','0000-00-00 00:00:00'),(12,61,'testasdfasdfadsfads','1',67,'2016-02-23 02:13:53',67,'2016-02-23 02:14:12','0000-00-00 00:00:00'),(13,58,'Gynaecologist','1',51,'2016-04-29 05:01:25',51,'2016-04-29 05:01:25','0000-00-00 00:00:00'),(14,58,'Cardiologist','1',51,'2016-04-29 05:01:48',51,'2016-04-29 05:01:48','0000-00-00 00:00:00');

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

insert  into `co_super_admin`(`su_id`,`username`,`password`,`authtoken`,`last_activity`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,'demo','$2y$13$pfNu2lorSgd3btV7foqp.uriRfXF.7lSi51b45oefB0V1NaObxEui','ZGVtbzE0NTY5ODY0Njc3NTY5','0000-00-00 00:00:00',NULL,'0000-00-00 00:00:00',-1,'2016-01-07 11:46:28');

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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;

/*Data for the table `co_tenant` */

insert  into `co_tenant`(`tenant_id`,`org_id`,`tenant_guid`,`tenant_name`,`tenant_address`,`tenant_city_id`,`tenant_state_id`,`tenant_country_id`,`tenant_contact1`,`tenant_contact2`,`tenant_fax`,`tenant_mobile`,`tenant_email`,`tenant_url`,`slug`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (23,7,'','Testing','Testing Address',1,1,1,'123456','','','','tester@gmail.com','','','',-1,'0000-00-00 00:00:00',-1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(58,7,'','Gandhi Nagar','aaa bbb',1,1,1,'123213','','','','careers@arkinfotec.com','','','1',-1,'2016-02-02 22:26:38',0,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(59,7,'','Ark Infotec','Bye-pass',1,8,7,'123','','','','gayatri@ark.com','http://ark.com','','0',-1,'2016-02-02 22:43:11',NULL,'2016-02-15 05:46:14','0000-00-00 00:00:00'),(60,7,'','Radianz','rad',1,8,7,'123123',NULL,NULL,NULL,'abc@radianz.com',NULL,'','1',-1,'2016-02-17 06:28:38',NULL,'2016-02-21 03:28:09','0000-00-00 00:00:00'),(61,7,NULL,'test','test',1,8,7,'99999999',NULL,NULL,NULL,'test.t@gm.xc','http://ahanahospitals.in/',NULL,'1',-1,'2016-02-21 23:16:05',-1,'2016-02-21 23:16:05','0000-00-00 00:00:00'),(62,0,NULL,'test test','test',5,8,7,'2323232323','',NULL,NULL,'34343@3444.3',NULL,NULL,'1',-1,'2016-02-29 02:00:01',-1,'2016-02-29 02:08:44','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=latin1;

/*Data for the table `co_user` */

insert  into `co_user`(`user_id`,`tenant_id`,`org_id`,`title_code`,`name`,`designation`,`address`,`city_id`,`state_id`,`zip`,`country_id`,`contact1`,`contact2`,`mobile`,`email`,`speciality_id`,`care_provider`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (51,0,7,'Dr.','Vikhram','Doctor','Anna Nagar',1,8,'625008',7,NULL,NULL,'8989898989','vikhram@ahana.com',NULL,'0','1',-1,'2016-02-02 22:26:38',-1,'2016-02-02 22:26:38','0000-00-00 00:00:00'),(52,59,0,'Miss.','Gayatri','HR','Byepass',1,8,'625010',7,NULL,NULL,'7878787878','gayatri@ark.com',NULL,'0','1',-1,'2016-02-02 22:43:11',-1,'2016-02-04 05:55:51','0000-00-00 00:00:00'),(53,58,0,'Mr.','Gayatri','HR','11231',1,8,'1231231',7,NULL,NULL,'1121212','gayatri@gmail.com',NULL,'0','1',51,'2016-02-03 01:04:06',51,'2016-02-03 01:04:06','0000-00-00 00:00:00'),(54,58,0,'Dr.','John','Doctor','abc',1,8,'123123',7,NULL,NULL,'123123','john@a.com',NULL,'1','1',51,'2016-02-04 07:06:51',51,'2016-02-05 22:58:11','0000-00-00 00:00:00'),(55,58,0,'Mr.','sadasd','asdasd','asasd',1,8,'123123',7,NULL,NULL,'123123123','a@abc.com',NULL,'0','1',51,'2016-02-04 07:29:11',51,'2016-02-04 07:29:11','0000-00-00 00:00:00'),(56,58,0,'Dr.','Surya','Doctor','abc',1,8,'234234',7,NULL,NULL,'123123123','surya@gmail.com',1,'1','1',51,'2016-02-05 22:50:38',51,'2016-02-06 02:23:28','0000-00-00 00:00:00'),(57,58,0,'Mr.','2341234','sdf','sdfsdf',1,8,'12341234',7,'2341234','1234','2341234','sadfsad@asdf.com',1,'0','1',51,'2016-02-15 06:48:47',51,'2016-02-15 06:48:47','0000-00-00 00:00:00'),(58,58,0,'Mrs.','Jo','Doctor','sdfa',4,10,'123123',11,'123','123','123','dg@adf.com',1,'1','1',51,'2016-02-15 07:14:24',51,'2016-02-15 07:14:24','0000-00-00 00:00:00'),(59,60,0,'Miss.','Gayatri','doctor','12341243',1,8,'2341234',7,NULL,NULL,'1342134','g@abc.com',NULL,'0','1',-1,'2016-02-17 06:28:38',-1,'2016-02-17 06:28:38','0000-00-00 00:00:00'),(60,60,0,'Dr.','Gayatri','doctor','park st.',1,8,'12341234',7,NULL,NULL,'1342134234','g@yopmail.com',3,'1','1',59,'2016-02-17 06:32:40',59,'2016-02-18 03:08:22','0000-00-00 00:00:00'),(61,60,0,'Dr.','Sagar','Doctor','sfsdfa',1,8,'12123',7,NULL,NULL,'12313','abc@gmail.com',3,'1','1',59,'2016-02-18 00:59:09',59,'2016-02-18 00:59:09','0000-00-00 00:00:00'),(62,58,0,'Mr.','Prakash','ARK','test test',1,8,'625002',7,NULL,NULL,'9555652154','prakash.paramanandam@arkinfotec.com',NULL,'0','1',51,'2016-02-19 07:08:10',51,'2016-02-19 07:08:10','0000-00-00 00:00:00'),(63,58,0,'Mr.','Nadesh','ARK','asdasdsa',1,8,'625010',7,NULL,NULL,'12312312323','nadesh@arkinfotec.com',NULL,'0','1',51,'2016-02-19 07:08:55',51,'2016-02-19 07:08:55','0000-00-00 00:00:00'),(64,60,0,'Dr.','Jessi','Doctor','aaa',1,8,'123123',7,NULL,NULL,'1231231231','jess@abc.com',2,'1','1',59,'2016-02-19 07:29:45',59,'2016-02-19 07:29:45','0000-00-00 00:00:00'),(65,60,0,'Dr.','Neeraj','Doctor','abcd',4,10,'121212',11,NULL,NULL,'1231231231','neeraj@gmail.com',4,'1','1',59,'2016-02-19 07:30:54',59,'2016-02-19 07:52:43','0000-00-00 00:00:00'),(66,60,0,'Mr.','Prakash Arulmani','ARK','test test',1,8,'952021',7,NULL,NULL,'9569562512','prakash@gmail.com',NULL,'0','1',59,'2016-02-20 05:10:04',59,'2016-02-20 05:10:04','0000-00-00 00:00:00'),(67,61,0,'Mrs.','Paramesh','Testor','test',1,8,'33434',7,NULL,NULL,'9789654321','parames.31390@gmail.com',NULL,'0','1',-1,'2016-02-21 23:16:05',-1,'2016-02-27 06:07:08','0000-00-00 00:00:00'),(68,61,0,'Dr.','Vikhram Vikhram  Vikhram  Vikhram  Vikhram  Vikh','psychiatrist','test',1,8,'625001',7,NULL,NULL,'9876543210','vikhram@ahanahospitals.in',11,'1','1',67,'2016-02-21 23:25:03',67,'2016-02-27 07:46:51','0000-00-00 00:00:00'),(69,61,0,'Dr.','CRS','Phychartist','test',1,8,'62555',7,NULL,NULL,'9876543210','CRS@ahana.in',11,'1','1',67,'2016-02-25 02:19:05',67,'2016-02-25 02:19:05','0000-00-00 00:00:00'),(70,61,0,'Dr.','Panjanathan','GMO','asdfasd',1,8,'322',7,NULL,NULL,'343343434','test@test.coo',12,'1','1',67,'2016-02-27 07:40:49',67,'2016-02-27 07:40:49','0000-00-00 00:00:00'),(71,61,0,'Dr.','Raja Raja Raja Raja Raja Raja Raja Raja Raja','DMO','test',1,8,'34343',7,NULL,NULL,'03934030','raja@ahana.in',11,'1','1',67,'2016-02-27 07:42:02',67,'2016-02-27 07:45:35','0000-00-00 00:00:00'),(72,61,0,'Dr.','Gopi Gopi Gopi Gopi Gopi Gopi Gopi','Counseller','DFDFD',1,8,'34',7,NULL,NULL,'344','gopi@ahana.in',11,'1','1',67,'2016-02-27 07:42:51',67,'2016-02-27 07:44:37','0000-00-00 00:00:00'),(73,62,0,'Mrs.','Paramesh','testor','34343',5,8,'343434',7,NULL,NULL,'3434343434','test@test.com',NULL,'0','1',-1,'2016-02-29 02:00:01',-1,'2016-02-29 02:00:01','0000-00-00 00:00:00'),(74,23,7,'Mr.','Test User','Tester','Tester 1 address',1,8,'123456',7,NULL,NULL,'123456','tester1@gmail.com',NULL,'0','1',51,'2016-03-23 00:59:03',51,'2016-03-23 00:59:03','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

/*Data for the table `co_users_roles` */

insert  into `co_users_roles`(`user_role_id`,`tenant_id`,`user_id`,`role_id`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,58,51,64,-1,'2016-02-02 22:26:39',NULL,NULL),(2,59,52,65,-1,'2016-02-02 22:43:12',NULL,NULL),(3,58,53,66,0,'2016-02-04 07:03:39',51,'2016-02-04 07:03:39'),(4,58,56,66,0,'2016-02-05 22:59:29',51,'2016-02-05 22:59:29'),(5,60,59,69,-1,'2016-02-17 06:28:39',NULL,NULL),(6,58,62,66,0,'2016-02-19 07:09:22',51,'2016-02-19 07:09:22'),(7,58,62,67,0,'2016-02-19 07:09:22',51,'2016-02-19 07:09:22'),(8,58,62,68,0,'2016-02-19 07:09:22',51,'2016-02-19 07:09:22'),(9,58,63,66,0,'2016-02-19 07:09:27',51,'2016-02-19 07:09:27'),(10,58,63,67,0,'2016-02-19 07:09:27',51,'2016-02-19 07:09:27'),(11,58,63,68,0,'2016-02-19 07:09:27',51,'2016-02-19 07:09:27'),(12,60,60,74,0,'2016-02-19 07:32:09',59,'2016-02-19 07:32:09'),(13,60,60,84,0,'2016-02-19 07:32:09',59,'2016-02-19 07:32:09'),(14,60,61,90,0,'2016-02-19 07:32:17',59,'2016-02-19 07:32:17'),(15,60,61,81,0,'2016-02-19 07:32:17',59,'2016-02-19 07:32:17'),(16,60,64,79,0,'2016-02-19 07:32:22',59,'2016-02-19 07:32:22'),(17,60,65,89,0,'2016-02-19 07:32:30',59,'2016-02-19 07:32:30'),(18,60,65,88,0,'2016-02-19 07:32:30',59,'2016-02-19 07:32:30'),(19,60,65,82,0,'2016-02-19 07:32:30',59,'2016-02-19 07:32:30'),(20,60,66,81,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(21,60,66,90,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(22,60,66,73,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(23,60,66,84,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(24,60,66,74,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(25,60,66,89,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(26,60,66,79,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(27,60,66,87,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(28,60,66,86,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(29,60,66,82,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(30,60,66,72,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(31,60,66,88,0,'2016-02-20 05:10:50',59,'2016-02-20 05:10:50'),(32,61,67,91,-1,'2016-02-21 23:16:05',NULL,NULL),(33,62,73,93,-1,'2016-02-29 02:00:02',NULL,NULL);

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

insert  into `co_ward`(`ward_id`,`tenant_id`,`floor_id`,`ward_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (8,58,7,'100','1',51,'2016-02-04 07:16:14',51,'2016-02-04 07:16:14','0000-00-00 00:00:00'),(9,58,8,'201','1',51,'2016-02-04 07:16:24',51,'2016-02-04 07:16:24','0000-00-00 00:00:00'),(10,58,9,'301','1',51,'2016-02-04 07:16:34',NULL,'2016-03-21 08:02:54','0000-00-00 00:00:00'),(11,58,8,'301','1',51,'2016-02-15 06:37:18',NULL,'2016-03-21 08:01:29','0000-00-00 00:00:00'),(12,60,16,'G1','1',59,'2016-02-20 01:14:02',59,'2016-02-20 01:14:02','0000-00-00 00:00:00'),(13,60,17,'F1','1',59,'2016-02-20 01:14:42',59,'2016-02-20 01:14:54','0000-00-00 00:00:00'),(14,60,18,'S1','1',59,'2016-02-20 01:15:07',59,'2016-02-20 01:15:07','0000-00-00 00:00:00'),(15,61,19,'ward1','1',67,'2016-02-23 04:43:00',67,'2016-02-23 04:43:00','0000-00-00 00:00:00'),(16,61,19,'Ward2','1',67,'2016-02-23 04:43:12',67,'2016-02-23 04:43:12','0000-00-00 00:00:00'),(17,61,19,'Ward3','1',67,'2016-02-23 04:43:25',67,'2016-02-23 04:43:25','0000-00-00 00:00:00'),(18,61,20,'Ward4','0',67,'2016-02-23 04:43:38',67,'2016-02-23 04:43:38','0000-00-00 00:00:00'),(19,61,20,'ward5','1',67,'2016-02-23 04:44:07',67,'2016-02-23 04:44:07','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=latin1;

/*Data for the table `pat_admission` */

insert  into `pat_admission`(`admn_id`,`tenant_id`,`patient_id`,`encounter_id`,`status_date`,`consultant_id`,`floor_id`,`ward_id`,`room_id`,`room_type_id`,`admission_status`,`status`,`notes`,`is_swap`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,60,33,36,'2016-02-20 18:01:24',60,16,12,18,16,'A','1',NULL,0,59,'2016-02-20 06:31:36',59,'2016-02-20 06:31:36','0000-00-00 00:00:00'),(2,60,33,36,'2016-02-20 18:01:54',61,16,12,18,16,'','1',NULL,0,59,'2016-02-20 06:32:06',59,'2016-02-20 06:32:06','0000-00-00 00:00:00'),(3,60,33,36,'2016-02-20 18:04:45',61,16,12,18,16,'D','1',NULL,0,59,'2016-02-20 06:35:01',59,'2016-02-20 06:35:01','0000-00-00 00:00:00'),(4,60,33,37,'2016-02-20 18:14:26',60,16,12,19,18,'A','1',NULL,0,59,'2016-02-20 06:44:38',59,'2016-02-20 06:44:38','0000-00-00 00:00:00'),(5,60,33,37,'2016-02-20 18:14:48',60,17,13,20,17,'','1',NULL,0,59,'2016-02-20 06:45:04',59,'2016-02-20 06:45:04','0000-00-00 00:00:00'),(6,60,33,37,'2016-02-20 18:18:45',60,17,13,20,17,'D','1',NULL,0,59,'2016-02-20 06:48:56',59,'2016-02-20 06:48:56','0000-00-00 00:00:00'),(7,60,33,38,'2016-02-20 18:21:27',61,18,14,21,14,'A','1',NULL,0,59,'2016-02-20 06:51:37',59,'2016-02-20 06:51:37','0000-00-00 00:00:00'),(8,60,35,39,'2016-02-20 18:35:42',60,16,12,19,15,'A','1',NULL,0,59,'2016-02-20 07:05:54',59,'2016-02-20 07:05:54','0000-00-00 00:00:00'),(9,60,35,39,'2016-02-20 18:47:12',60,18,14,21,14,'','1',NULL,0,59,'2016-02-20 07:17:40',59,'2016-02-20 07:17:40','0000-00-00 00:00:00'),(10,60,33,38,'2016-02-20 18:47:12',61,16,12,19,15,'','1',NULL,0,59,'2016-02-20 07:17:40',59,'2016-02-20 07:17:40','0000-00-00 00:00:00'),(11,60,35,39,'2016-02-20 18:47:56',60,16,12,19,18,'','1',NULL,0,59,'2016-02-20 07:18:26',59,'2016-02-20 07:18:26','0000-00-00 00:00:00'),(12,60,33,38,'2016-02-20 18:47:56',61,18,14,21,18,'','1',NULL,0,59,'2016-02-20 07:18:26',59,'2016-02-20 07:18:26','0000-00-00 00:00:00'),(13,60,34,40,'2016-02-20 18:52:46',60,17,13,23,16,'A','1',NULL,0,66,'2016-02-20 07:23:01',66,'2016-02-20 07:23:01','0000-00-00 00:00:00'),(14,60,34,40,'2016-02-20 18:53:28',60,17,13,23,16,'D','1',NULL,0,66,'2016-02-20 07:23:34',66,'2016-02-20 07:23:34','0000-00-00 00:00:00'),(15,60,35,39,'2016-02-20 18:58:51',60,18,14,21,14,'','1',NULL,0,59,'2016-02-20 07:31:03',59,'2016-02-20 07:31:03','0000-00-00 00:00:00'),(16,60,33,38,'2016-02-20 18:58:51',61,16,12,19,18,'','1',NULL,0,59,'2016-02-20 07:31:03',59,'2016-02-20 07:31:03','0000-00-00 00:00:00'),(17,60,34,41,'2016-02-20 19:20:28',60,17,13,23,16,'A','1',NULL,0,66,'2016-02-20 07:50:48',66,'2016-02-20 07:50:48','0000-00-00 00:00:00'),(18,60,34,41,'2016-02-20 19:21:02',60,17,13,23,16,'D','1',NULL,0,66,'2016-02-20 07:51:08',66,'2016-02-20 07:51:08','0000-00-00 00:00:00'),(19,60,33,38,'2016-02-20 19:50:02',61,16,12,19,18,'D','1',NULL,0,59,'2016-02-20 08:20:10',59,'2016-02-20 08:20:10','0000-00-00 00:00:00'),(20,60,33,43,'2016-02-22 10:20:06',60,16,12,19,15,'A','1',NULL,0,59,'2016-02-21 22:50:16',59,'2016-02-21 22:50:16','0000-00-00 00:00:00'),(21,58,37,51,'2016-02-22 14:04:36',56,7,8,12,12,'A','1',NULL,0,51,'2016-02-22 02:35:00',51,'2016-02-22 02:35:00','0000-00-00 00:00:00'),(22,58,37,51,'2016-02-22 14:14:37',56,7,8,12,12,'D','1',NULL,0,51,'2016-02-22 02:44:41',51,'2016-02-22 02:44:41','0000-00-00 00:00:00'),(23,58,37,54,'2016-02-22 14:32:20',54,7,8,12,12,'A','1',NULL,0,51,'2016-02-22 03:02:39',51,'2016-02-22 03:02:39','0000-00-00 00:00:00'),(24,58,37,54,'2016-02-22 18:04:28',54,7,8,12,12,'D','1',NULL,0,51,'2016-02-22 06:34:32',51,'2016-02-22 06:34:32','0000-00-00 00:00:00'),(25,61,36,55,'2016-02-23 16:49:16',68,19,15,31,19,'A','1',NULL,0,67,'2016-02-23 05:19:43',67,'2016-02-23 05:19:43','0000-00-00 00:00:00'),(26,61,36,55,'2016-02-25 16:50:01',69,19,15,31,19,'','1',NULL,0,67,'2016-02-25 05:20:15',67,'2016-02-25 05:20:15','0000-00-00 00:00:00'),(27,61,36,55,'2016-02-25 16:50:28',69,19,16,35,20,'','1',NULL,0,67,'2016-02-25 05:20:44',67,'2016-02-25 05:20:44','0000-00-00 00:00:00'),(28,61,24,59,'2016-02-25 16:58:08',69,19,15,32,19,'A','1',NULL,0,67,'2016-02-25 05:28:29',67,'2016-02-25 05:28:29','0000-00-00 00:00:00'),(29,61,24,59,'2016-02-25 16:59:28',69,19,16,35,20,'','1',NULL,0,67,'2016-02-25 05:29:44',67,'2016-02-25 05:29:44','0000-00-00 00:00:00'),(30,61,36,55,'2016-02-25 16:59:28',69,19,15,32,19,'','1',NULL,0,67,'2016-02-25 05:29:44',67,'2016-02-25 05:29:44','0000-00-00 00:00:00'),(31,61,24,59,'2016-02-25 16:59:54',69,19,16,35,20,'D','1',NULL,0,67,'2016-02-25 05:30:03',67,'2016-02-25 05:30:03','0000-00-00 00:00:00'),(32,61,24,60,'2016-02-25 17:07:55',69,19,16,35,19,'A','1',NULL,0,67,'2016-02-25 05:38:13',67,'2016-02-25 05:38:13','0000-00-00 00:00:00'),(33,58,20,62,'2016-03-04 10:01:51',54,7,8,12,12,'A','1',NULL,0,51,'2016-03-03 22:32:11',51,'2016-03-03 22:32:11','0000-00-00 00:00:00'),(34,58,20,62,'2016-03-04 10:31:26',54,7,8,12,12,'D','1',NULL,0,51,'2016-03-03 23:01:33',51,'2016-03-03 23:01:33','0000-00-00 00:00:00'),(35,58,34,64,'2016-03-04 12:38:02',56,8,9,10,10,'A','1',NULL,0,51,'2016-03-04 01:09:27',51,'2016-03-04 01:09:27','0000-00-00 00:00:00'),(36,58,34,64,'2016-03-23 15:38:26',56,8,9,10,10,'D','1',NULL,0,51,'2016-03-23 05:08:28',51,'2016-03-23 05:08:28','0000-00-00 00:00:00'),(37,58,34,85,'2016-03-23 15:38:31',56,7,8,12,12,'A','1',NULL,0,51,'2016-03-23 05:08:56',51,'2016-03-23 05:08:56','0000-00-00 00:00:00'),(38,58,34,85,'2016-03-23 15:39:05',56,7,8,12,12,'D','1',NULL,0,51,'2016-03-23 05:09:08',51,'2016-03-23 05:09:08','0000-00-00 00:00:00'),(39,58,22,86,'2016-03-23 16:22:00',54,7,8,12,12,'A','1',NULL,0,62,'2016-03-23 05:52:12',62,'2016-03-23 05:52:12','0000-00-00 00:00:00'),(40,58,44,88,'2016-03-31 12:25:43',54,7,8,11,11,'A','1',NULL,0,51,'2016-03-31 01:58:09',51,'2016-03-31 01:58:09','0000-00-00 00:00:00'),(41,58,44,88,'2016-03-31 12:31:18',54,7,8,11,11,'D','1',NULL,0,51,'2016-03-31 02:01:20',51,'2016-03-31 02:01:20','0000-00-00 00:00:00'),(42,58,44,89,'2016-03-31 12:31:23',54,7,8,11,10,'A','1',NULL,0,51,'2016-03-31 02:01:35',51,'2016-03-31 02:01:35','0000-00-00 00:00:00'),(43,58,44,89,'2016-03-31 12:38:28',54,7,8,11,10,'D','1',NULL,0,51,'2016-03-31 02:08:30',51,'2016-03-31 02:08:30','0000-00-00 00:00:00'),(44,58,44,91,'2016-03-31 12:40:29',56,8,9,10,10,'A','1',NULL,0,51,'2016-03-31 02:10:40',51,'2016-03-31 02:10:40','0000-00-00 00:00:00'),(45,58,44,91,'2016-03-31 12:41:53',56,8,9,10,10,'D','1',NULL,0,51,'2016-03-31 02:11:58',51,'2016-03-31 02:11:58','0000-00-00 00:00:00'),(46,58,22,86,'2016-04-01 09:55:47',54,7,8,12,12,'D','1',NULL,0,51,'2016-03-31 23:25:48',51,'2016-03-31 23:25:48','0000-00-00 00:00:00'),(47,58,20,96,'2016-04-04 10:50:05',54,7,8,12,12,'A','1',NULL,0,51,'2016-04-04 00:20:20',51,'2016-04-04 00:20:20','0000-00-00 00:00:00'),(48,58,20,96,'2016-04-04 10:50:31',58,7,8,12,12,'TD','1',NULL,0,51,'2016-04-04 00:21:08',51,'2016-04-04 00:21:08','0000-00-00 00:00:00'),(49,58,20,96,'2016-04-04 10:51:26',58,7,8,12,12,'D','1',NULL,0,51,'2016-04-04 00:21:28',51,'2016-04-04 00:21:28','0000-00-00 00:00:00'),(50,58,20,97,'2016-04-04 15:44:32',54,7,8,11,9,'A','1',NULL,0,51,'2016-04-04 05:14:40',51,'2016-04-04 05:14:40','0000-00-00 00:00:00'),(51,58,37,98,'2016-04-05 10:53:56',54,7,8,12,12,'A','1',NULL,0,51,'2016-04-05 00:24:10',51,'2016-04-05 00:24:10','0000-00-00 00:00:00'),(52,58,20,97,'2016-04-06 15:11:10',54,7,8,11,9,'D','1',NULL,0,51,'2016-04-06 04:41:06',51,'2016-04-06 04:41:06','0000-00-00 00:00:00'),(53,58,42,99,'2016-04-13 12:34:39',54,8,9,10,11,'A','1',NULL,0,51,'2016-04-13 02:05:01',51,'2016-04-13 02:05:01','0000-00-00 00:00:00'),(54,58,42,99,'2016-04-15 15:24:02',54,7,8,12,12,'TR','1','{\"encounter_id\":98,\"patient_id\":37,\"floor_id\":8,\"ward_id\":9,\"room_id\":10,\"room_type_id\":10}',1,51,'2016-04-15 04:54:21',51,'2016-04-15 04:54:21','0000-00-00 00:00:00'),(55,58,37,98,'2016-04-15 15:24:02',54,8,9,10,10,'TR','1','{\"encounter_id\":\"99\",\"patient_id\":42,\"floor_id\":7,\"ward_id\":8,\"room_id\":12,\"room_type_id\":12}',1,51,'2016-04-15 04:54:21',51,'2016-04-15 04:54:21','0000-00-00 00:00:00'),(56,58,42,99,'2016-04-15 15:24:46',54,7,8,12,12,'D','1',NULL,0,51,'2016-04-15 04:54:54',51,'2016-04-15 04:54:54','0000-00-00 00:00:00'),(57,58,42,100,'2016-04-16 11:55:00',54,7,8,11,11,'A','1',NULL,0,51,'2016-04-15 06:35:58',51,'2016-04-15 06:35:58','0000-00-00 00:00:00'),(58,58,42,100,'2016-04-23 09:43:20',54,7,8,11,11,'D','1',NULL,0,51,'2016-04-22 23:13:23',51,'2016-04-22 23:13:23','0000-00-00 00:00:00'),(59,58,42,101,'2016-04-23 09:49:11',54,7,8,12,12,'A','1',NULL,0,51,'2016-04-22 23:19:20',51,'2016-04-22 23:19:20','0000-00-00 00:00:00'),(60,58,42,101,'2016-04-25 14:45:00',54,7,8,12,12,'D','1',NULL,0,51,'2016-04-25 04:15:42',51,'2016-04-25 04:15:42','0000-00-00 00:00:00'),(61,58,42,101,'2016-04-25 14:52:44',54,7,8,12,12,'D','1',NULL,0,51,'2016-04-25 04:22:44',51,'2016-04-25 04:22:44','0000-00-00 00:00:00'),(62,58,42,102,'2016-04-25 14:52:51',54,7,8,12,12,'A','1',NULL,0,51,'2016-04-25 04:28:24',51,'2016-04-25 04:28:24','0000-00-00 00:00:00'),(63,58,42,102,'2016-04-25 15:10:06',54,7,8,12,12,'D','1',NULL,0,51,'2016-04-25 04:40:08',51,'2016-04-25 04:40:08','0000-00-00 00:00:00'),(64,58,42,102,'2016-04-25 15:10:33',54,7,8,12,12,'D','1',NULL,0,51,'2016-04-25 04:40:33',51,'2016-04-25 04:40:33','0000-00-00 00:00:00'),(65,58,37,98,'2016-04-26 15:12:36',54,8,9,10,10,'D','1',NULL,0,51,'2016-04-26 04:42:39',51,'2016-04-26 04:42:39','0000-00-00 00:00:00'),(66,58,37,98,'2016-04-26 15:13:14',54,8,9,10,10,'D','1',NULL,0,51,'2016-04-26 04:43:14',51,'2016-04-26 04:43:14','0000-00-00 00:00:00'),(67,58,34,105,'2016-04-27 17:11:09',54,8,9,10,10,'A','1',NULL,0,51,'2016-04-27 06:41:59',51,'2016-04-27 06:41:59','0000-00-00 00:00:00'),(68,58,46,115,'2016-05-02 15:44:51',54,7,8,12,12,'A','1',NULL,0,51,'2016-05-02 05:15:14',51,'2016-05-02 05:15:14','0000-00-00 00:00:00'),(69,58,46,115,'2016-05-02 15:45:21',54,7,8,12,12,'CD','1',NULL,0,51,'2016-05-02 05:15:23',51,'2016-05-02 05:15:23','0000-00-00 00:00:00'),(70,58,46,115,'2016-05-02 16:03:28',54,7,8,12,12,'D','1',NULL,0,51,'2016-05-02 05:33:28',51,'2016-05-02 05:33:28','0000-00-00 00:00:00'),(71,58,46,116,'2016-05-02 16:03:49',54,7,8,12,12,'A','1',NULL,0,51,'2016-05-02 05:34:03',51,'2016-05-02 05:34:03','0000-00-00 00:00:00'),(72,58,37,117,'2016-05-02 16:32:26',54,7,8,11,9,'A','1',NULL,0,51,'2016-05-02 06:02:38',51,'2016-05-02 06:02:38','0000-00-00 00:00:00'),(73,58,46,116,'2016-05-02 17:19:40',54,7,8,12,12,'CD','1',NULL,0,51,'2016-05-02 06:49:42',51,'2016-05-02 06:49:42','0000-00-00 00:00:00'),(74,58,46,116,'2016-05-02 17:21:31',54,7,8,12,12,'D','1',NULL,0,51,'2016-05-02 06:51:31',51,'2016-05-02 06:51:31','0000-00-00 00:00:00'),(75,58,34,105,'2016-05-04 15:23:15',54,8,9,10,10,'CD','1',NULL,0,51,'2016-05-04 04:53:17',51,'2016-05-04 04:53:17','0000-00-00 00:00:00'),(76,58,34,105,'2016-05-04 15:27:54',54,8,9,10,10,'D','1',NULL,0,51,'2016-05-04 04:57:54',51,'2016-05-04 04:57:54','0000-00-00 00:00:00'),(77,58,34,121,'2016-05-04 16:27:43',54,7,8,12,9,'A','1',NULL,0,51,'2016-05-04 05:57:56',51,'2016-05-04 05:57:56','0000-00-00 00:00:00'),(78,58,34,121,'2016-05-04 16:28:02',54,7,8,12,9,'CD','1',NULL,0,51,'2016-05-04 05:58:04',51,'2016-05-04 05:58:04','0000-00-00 00:00:00'),(79,58,46,122,'2016-05-04 23:00:00',56,8,9,10,11,'A','1',NULL,0,51,'2016-05-04 12:35:24',51,'2016-05-04 12:35:24','0000-00-00 00:00:00'),(80,58,46,122,'2016-05-06 10:04:18',56,8,9,10,11,'CD','1',NULL,0,51,'2016-05-05 23:34:21',51,'2016-05-05 23:34:21','0000-00-00 00:00:00'),(81,58,46,122,'2016-05-06 10:25:43',56,8,9,10,11,'D','1',NULL,0,51,'2016-05-05 23:55:43',51,'2016-05-05 23:55:43','0000-00-00 00:00:00'),(82,58,46,126,'2016-05-06 10:28:42',58,8,9,10,10,'A','1',NULL,0,51,'2016-05-05 23:59:00',51,'2016-05-05 23:59:00','0000-00-00 00:00:00'),(83,58,46,126,'2016-05-10 18:36:50',58,8,9,10,10,'CD','1',NULL,0,51,'2016-05-10 08:06:52',51,'2016-05-10 08:06:52','0000-00-00 00:00:00'),(84,58,46,126,'2016-05-10 18:37:26',58,8,9,10,10,'D','1',NULL,0,51,'2016-05-10 08:07:26',51,'2016-05-10 08:07:26','0000-00-00 00:00:00'),(85,58,46,128,'2016-05-09 01:05:00',56,8,9,10,10,'A','1',NULL,0,51,'2016-05-10 08:11:19',51,'2016-05-10 08:11:19','0000-00-00 00:00:00'),(86,58,34,121,'2016-05-24 13:58:39',54,7,8,12,9,'AC','1','Admission Cancelled',0,51,'2016-05-24 03:28:40',51,'2016-05-24 03:28:40','0000-00-00 00:00:00'),(87,58,34,141,'2016-05-24 13:58:43',54,7,8,12,12,'A','1',NULL,0,51,'2016-05-24 03:28:58',51,'2016-05-24 03:28:58','0000-00-00 00:00:00'),(88,58,34,141,'2016-05-24 14:03:56',54,7,8,12,12,'AC','1','Admission Cancelled',0,51,'2016-05-24 03:33:56',51,'2016-05-24 03:33:56','0000-00-00 00:00:00'),(89,58,34,142,'2016-05-24 14:04:03',54,7,8,12,9,'A','1',NULL,0,51,'2016-05-24 03:34:14',51,'2016-05-24 03:34:14','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `pat_alert` */

insert  into `pat_alert`(`pat_alert_id`,`tenant_id`,`alert_id`,`patient_id`,`alert_description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,60,2,33,'Bill payment','1',59,'2016-02-21 22:33:07',59,'2016-02-21 22:33:07','0000-00-00 00:00:00'),(2,60,3,35,'new patient','1',59,'2016-02-21 22:51:06',59,'2016-02-21 22:51:06','0000-00-00 00:00:00'),(3,58,1,37,'sd','1',51,'2016-02-22 03:21:56',51,'2016-02-22 03:21:56','0000-00-00 00:00:00'),(4,61,5,24,'adfasfas','1',67,'2016-02-25 05:30:23',67,'2016-02-25 05:30:23','0000-00-00 00:00:00'),(5,61,5,24,'34434  343 434','1',67,'2016-02-27 07:47:40',67,'2016-02-27 07:47:40','0000-00-00 00:00:00'),(6,58,1,34,'ssssssssd AS ADS AAS FASDF ASD','1',51,'2016-03-14 02:24:48',51,'2016-03-14 02:24:48','0000-00-00 00:00:00'),(7,58,1,20,'latest alert','1',51,'2016-04-26 05:10:06',51,'2016-04-26 05:10:06','0000-00-00 00:00:00'),(8,58,1,45,'test tstv tewadsfasdfasd das','1',51,'2016-05-04 12:47:51',51,'2016-05-04 12:48:17','0000-00-00 00:00:00'),(9,58,1,46,'pament','1',51,'2016-05-05 00:00:19',51,'2016-05-05 00:00:19','0000-00-00 00:00:00'),(10,58,1,34,'hi','1',51,'2016-06-11 06:03:20',51,'2016-06-11 06:03:20','0000-00-00 00:00:00'),(11,58,1,34,'ppp','1',51,'2016-06-11 06:03:59',51,'2016-06-11 06:03:59','0000-00-00 00:00:00'),(12,58,1,46,'3232sdsds','1',51,'2016-06-16 12:44:46',51,'2016-06-16 12:44:46','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=307 DEFAULT CHARSET=latin1;

/*Data for the table `pat_appointment` */

insert  into `pat_appointment`(`appt_id`,`tenant_id`,`patient_id`,`encounter_id`,`status_date`,`status_time`,`consultant_id`,`appt_status`,`status`,`amount`,`notes`,`patient_cat_id`,`patient_bill_type`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,18,1,'2016-02-16','05:00:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-16 06:31:03',51,'2016-02-16 06:31:03','0000-00-00 00:00:00'),(2,58,18,1,'2016-02-16','05:00:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-16 06:31:03',51,'2016-02-16 06:31:03','0000-00-00 00:00:00'),(3,58,24,2,'2016-02-17','05:05:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 00:18:11',51,'2016-02-17 00:18:11','0000-00-00 00:00:00'),(4,58,24,2,'2016-02-17','05:05:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 00:18:11',51,'2016-02-17 00:18:11','0000-00-00 00:00:00'),(5,58,28,3,'2016-02-17','11:55:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 01:15:34',51,'2016-02-17 01:15:34','0000-00-00 00:00:00'),(6,58,28,3,'2016-02-17','11:10:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 01:18:59',51,'2016-02-17 01:18:59','0000-00-00 00:00:00'),(7,58,28,3,'2016-02-17','00:00:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 01:19:13',51,'2016-02-17 01:19:13','0000-00-00 00:00:00'),(8,58,28,4,'2016-02-17','11:35:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 01:27:48',51,'2016-02-17 01:27:48','0000-00-00 00:00:00'),(9,58,28,4,'2016-02-17','11:35:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 01:27:48',51,'2016-02-17 01:27:48','0000-00-00 00:00:00'),(10,58,20,5,'2016-02-17','05:35:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 02:54:27',51,'2016-02-17 02:54:27','0000-00-00 00:00:00'),(11,58,20,5,'2016-02-17','05:35:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 02:54:27',51,'2016-02-17 02:54:27','0000-00-00 00:00:00'),(12,60,29,6,'2016-02-17','09:05:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-17 06:34:19',59,'2016-02-17 06:34:19','0000-00-00 00:00:00'),(13,60,29,6,'2016-02-17','09:05:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 06:34:19',59,'2016-02-17 06:34:19','0000-00-00 00:00:00'),(14,58,30,7,'2016-02-17','06:20:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 06:42:33',51,'2016-02-17 06:42:33','0000-00-00 00:00:00'),(15,58,30,7,'2016-02-17','18:12:42',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 06:43:01',51,'2016-02-17 06:43:01','0000-00-00 00:00:00'),(16,58,30,7,'2016-02-17','18:17:58',54,'S','1','122.00',NULL,4,NULL,51,'2016-02-17 06:49:37',51,'2016-02-17 06:49:37','0000-00-00 00:00:00'),(17,58,20,5,'2016-02-03','01:10:00',54,'S','1','600.00',NULL,4,NULL,51,'2016-02-17 06:59:09',51,'2016-02-17 06:59:09','0000-00-00 00:00:00'),(18,58,20,8,'2016-02-17','05:50:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 07:07:13',51,'2016-02-17 07:07:13','0000-00-00 00:00:00'),(19,58,20,8,'2016-02-17','05:50:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 07:07:13',51,'2016-02-17 07:07:13','0000-00-00 00:00:00'),(20,60,25,9,'2016-02-17','09:55:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-17 07:29:20',59,'2016-02-17 07:29:20','0000-00-00 00:00:00'),(21,60,25,9,'2016-02-17','09:55:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 07:29:20',59,'2016-02-17 07:29:20','0000-00-00 00:00:00'),(22,60,30,10,'2016-02-18','10:00:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-17 07:29:52',59,'2016-02-17 07:29:52','0000-00-00 00:00:00'),(23,60,30,10,'2016-02-17','19:00:44',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 07:30:49',59,'2016-02-17 07:30:49','0000-00-00 00:00:00'),(24,60,30,10,'2016-02-17','00:00:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 07:30:57',59,'2016-02-17 07:30:57','0000-00-00 00:00:00'),(25,60,19,11,'2016-02-17','09:35:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-17 07:34:52',59,'2016-02-17 07:34:52','0000-00-00 00:00:00'),(26,60,19,11,'2016-02-17','09:35:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 07:34:53',59,'2016-02-17 07:34:53','0000-00-00 00:00:00'),(27,58,24,2,'2016-02-17','19:21:17',54,'C','1','0.00',NULL,NULL,NULL,51,'2016-02-17 07:51:17',51,'2016-02-17 07:51:17','0000-00-00 00:00:00'),(28,58,24,12,'2016-02-17','11:35:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 07:57:52',51,'2016-02-17 07:57:52','0000-00-00 00:00:00'),(29,58,24,12,'2016-02-17','19:28:09',56,'C','1','0.00',NULL,NULL,NULL,51,'2016-02-17 07:58:09',51,'2016-02-17 07:58:09','0000-00-00 00:00:00'),(30,58,20,13,'2016-02-18','11:05:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 22:41:36',51,'2016-02-17 22:41:36','0000-00-00 00:00:00'),(31,58,26,14,'2016-02-18','11:10:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 22:42:12',51,'2016-02-17 22:42:12','0000-00-00 00:00:00'),(32,58,26,14,'2016-02-18','10:12:54',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 22:43:00',51,'2016-02-17 22:43:00','0000-00-00 00:00:00'),(33,58,26,14,'2016-02-18','00:00:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 22:43:26',51,'2016-02-17 22:43:26','0000-00-00 00:00:00'),(34,58,26,14,'2016-02-18','00:00:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 22:48:18',51,'2016-02-17 22:48:18','0000-00-00 00:00:00'),(35,58,26,14,'2016-02-18','00:00:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 22:51:07',51,'2016-02-17 22:51:07','0000-00-00 00:00:00'),(36,58,25,15,'2016-02-18','11:10:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 23:05:04',51,'2016-02-17 23:05:04','0000-00-00 00:00:00'),(37,60,21,16,'2016-02-18','09:10:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:07:13',59,'2016-02-17 23:07:13','0000-00-00 00:00:00'),(38,60,21,16,'2016-02-18','10:37:26',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:07:39',59,'2016-02-17 23:07:39','0000-00-00 00:00:00'),(39,60,21,16,'2016-02-18','00:00:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:07:47',59,'2016-02-17 23:07:47','0000-00-00 00:00:00'),(40,60,27,17,'2016-02-18','09:05:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:14:58',59,'2016-02-17 23:14:58','0000-00-00 00:00:00'),(41,60,27,17,'2016-02-18','09:05:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:14:58',59,'2016-02-17 23:14:58','0000-00-00 00:00:00'),(42,60,21,16,'2016-02-18','10:51:14',60,'C','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:21:15',59,'2016-02-17 23:21:15','0000-00-00 00:00:00'),(43,60,21,18,'2016-02-18','09:05:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:21:46',59,'2016-02-17 23:21:46','0000-00-00 00:00:00'),(44,60,21,18,'2016-02-18','10:51:55',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:21:58',59,'2016-02-17 23:21:58','0000-00-00 00:00:00'),(45,60,21,18,'2016-02-18','00:00:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:22:26',59,'2016-02-17 23:22:26','0000-00-00 00:00:00'),(46,60,21,18,'2016-02-18','00:00:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:22:35',59,'2016-02-17 23:22:35','0000-00-00 00:00:00'),(47,58,31,19,'2016-02-18','05:15:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-18 04:50:00',51,'2016-02-18 04:50:00','0000-00-00 00:00:00'),(48,58,31,19,'2016-02-18','05:15:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-18 04:50:00',51,'2016-02-18 04:50:00','0000-00-00 00:00:00'),(49,58,32,20,'2016-02-19','11:30:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-19 00:47:36',51,'2016-02-19 00:47:36','0000-00-00 00:00:00'),(50,58,32,20,'2016-02-19','12:18:08',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-19 00:48:13',51,'2016-02-19 00:48:13','0000-00-00 00:00:00'),(51,60,33,21,'2016-02-19','09:00:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-19 00:52:08',59,'2016-02-19 00:52:08','0000-00-00 00:00:00'),(52,60,33,21,'2016-02-19','12:29:58',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-19 01:00:08',59,'2016-02-19 01:00:08','0000-00-00 00:00:00'),(53,60,33,21,'2016-02-19','13:10:56',60,'C','1','0.00',NULL,NULL,NULL,59,'2016-02-19 01:40:56',59,'2016-02-19 01:40:56','0000-00-00 00:00:00'),(54,60,33,22,'2016-02-19','09:30:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-19 01:41:20',59,'2016-02-19 01:41:20','0000-00-00 00:00:00'),(55,60,33,22,'2016-02-19','13:37:56',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-19 02:08:03',59,'2016-02-19 02:08:03','0000-00-00 00:00:00'),(56,60,33,22,'2016-02-19','13:38:15',60,'C','1','0.00',NULL,NULL,NULL,59,'2016-02-19 02:08:16',59,'2016-02-19 02:08:16','0000-00-00 00:00:00'),(57,60,33,23,'2016-02-19','09:00:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-19 02:08:47',59,'2016-02-19 02:08:47','0000-00-00 00:00:00'),(58,60,33,23,'2016-02-19','13:39:11',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-19 02:09:18',59,'2016-02-19 02:09:18','0000-00-00 00:00:00'),(59,58,34,24,'2016-02-19','05:00:00',54,'B','1','0.00',NULL,NULL,NULL,62,'2016-02-19 07:19:03',62,'2016-02-19 07:19:03','0000-00-00 00:00:00'),(60,58,34,24,'2016-02-19','18:49:09',54,'A','1','0.00',NULL,NULL,NULL,62,'2016-02-19 07:19:15',62,'2016-02-19 07:19:15','0000-00-00 00:00:00'),(61,58,34,24,'2016-02-19','18:49:22',54,'S','1','100.00',NULL,4,NULL,62,'2016-02-19 07:19:35',62,'2016-02-19 07:19:35','0000-00-00 00:00:00'),(62,58,34,25,'2016-02-19','05:05:00',54,'B','1','0.00',NULL,NULL,NULL,62,'2016-02-19 07:21:43',62,'2016-02-19 07:21:43','0000-00-00 00:00:00'),(63,58,34,25,'2016-02-19','18:53:36',54,'C','1','0.00',NULL,NULL,NULL,62,'2016-02-19 07:23:36',62,'2016-02-19 07:23:36','0000-00-00 00:00:00'),(64,58,34,26,'2016-02-19','05:25:00',54,'B','1','0.00',NULL,NULL,NULL,62,'2016-02-19 07:25:56',62,'2016-02-19 07:25:56','0000-00-00 00:00:00'),(65,58,34,26,'2016-02-19','18:57:00',54,'A','1','0.00',NULL,NULL,NULL,62,'2016-02-19 07:27:06',62,'2016-02-19 07:27:06','0000-00-00 00:00:00'),(66,60,30,10,'2016-02-20','00:00:00',60,'S','1','100.00',NULL,8,NULL,59,'2016-02-19 23:23:58',59,'2016-02-19 23:23:58','0000-00-00 00:00:00'),(67,60,30,27,'2016-02-20','02:50:00',61,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-19 23:25:13',59,'2016-02-19 23:25:13','0000-00-00 00:00:00'),(68,60,30,27,'2016-02-20','10:55:25',61,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-19 23:25:30',59,'2016-02-19 23:25:30','0000-00-00 00:00:00'),(69,60,30,27,'2016-02-20','10:59:51',61,'S','1','121.00',NULL,8,NULL,59,'2016-02-19 23:30:02',59,'2016-02-19 23:30:02','0000-00-00 00:00:00'),(70,60,30,28,'2016-02-20','09:55:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-19 23:30:52',59,'2016-02-19 23:30:52','0000-00-00 00:00:00'),(71,60,30,28,'2016-02-20','09:55:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-19 23:30:52',59,'2016-02-19 23:30:52','0000-00-00 00:00:00'),(72,58,34,26,'2016-02-20','12:52:44',54,'S','1','100.00',NULL,4,NULL,62,'2016-02-20 01:22:50',62,'2016-02-20 01:22:50','0000-00-00 00:00:00'),(73,58,34,29,'2016-02-20','05:00:00',54,'B','1','0.00',NULL,NULL,NULL,62,'2016-02-20 01:23:02',62,'2016-02-20 01:23:02','0000-00-00 00:00:00'),(74,58,34,29,'2016-02-20','12:53:24',54,'A','1','0.00',NULL,NULL,NULL,62,'2016-02-20 01:23:26',62,'2016-02-20 01:23:26','0000-00-00 00:00:00'),(75,60,35,30,'2016-02-20','16:00:00',65,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-20 03:32:49',59,'2016-02-20 03:32:49','0000-00-00 00:00:00'),(76,60,35,30,'2016-02-20','15:03:02',65,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-20 03:33:07',59,'2016-02-20 03:33:07','0000-00-00 00:00:00'),(77,60,35,30,'2016-02-20','15:04:23',65,'S','1','102.00',NULL,11,NULL,59,'2016-02-20 03:34:28',59,'2016-02-20 03:34:28','0000-00-00 00:00:00'),(78,58,34,29,'2016-02-20','15:11:34',54,'S','1','100.00',NULL,6,NULL,62,'2016-02-20 03:41:39',62,'2016-02-20 03:41:39','0000-00-00 00:00:00'),(79,58,34,31,'2016-02-20','11:00:00',56,'B','1','0.00',NULL,NULL,NULL,62,'2016-02-20 03:52:56',62,'2016-02-20 03:52:56','0000-00-00 00:00:00'),(80,58,34,31,'2016-02-20','15:23:03',56,'A','1','0.00',NULL,NULL,NULL,62,'2016-02-20 03:53:12',62,'2016-02-20 03:53:12','0000-00-00 00:00:00'),(84,58,34,31,'2016-02-20','15:38:28',56,'S','1','300.00',NULL,6,'N',62,'2016-02-20 04:08:40',62,'2016-02-20 04:08:40','0000-00-00 00:00:00'),(85,58,34,32,'2016-02-20','06:00:00',54,'B','1','0.00',NULL,NULL,NULL,62,'2016-02-20 04:44:16',62,'2016-02-20 04:44:16','0000-00-00 00:00:00'),(86,58,34,32,'2016-02-20','06:00:00',54,'A','1','0.00',NULL,NULL,NULL,62,'2016-02-20 04:44:16',62,'2016-02-20 04:44:16','0000-00-00 00:00:00'),(87,58,34,32,'2016-02-20','16:17:13',54,'S','1','100.00',NULL,4,'N',62,'2016-02-20 04:49:34',62,'2016-02-20 04:49:34','0000-00-00 00:00:00'),(88,60,33,23,'2016-02-20','16:21:29',60,'S','1','104.00',NULL,11,'N',59,'2016-02-20 04:51:34',59,'2016-02-20 04:51:34','0000-00-00 00:00:00'),(89,60,30,28,'2016-02-20','16:47:26',60,'S','1','101.00',NULL,8,'N',66,'2016-02-20 05:17:32',66,'2016-02-20 05:17:32','0000-00-00 00:00:00'),(90,60,29,6,'2016-02-20','17:41:00',60,'S','1','102.00',NULL,9,'N',59,'2016-02-20 06:11:08',59,'2016-02-20 06:11:08','0000-00-00 00:00:00'),(91,60,29,33,'2016-02-20','01:35:00',61,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-20 06:11:30',59,'2016-02-20 06:11:30','0000-00-00 00:00:00'),(92,60,29,33,'2016-02-20','01:35:00',61,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-20 06:11:30',59,'2016-02-20 06:11:30','0000-00-00 00:00:00'),(93,60,33,34,'2016-02-20','17:00:00',65,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-20 06:14:45',59,'2016-02-20 06:14:45','0000-00-00 00:00:00'),(94,60,33,34,'2016-02-20','17:45:43',65,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-20 06:15:47',59,'2016-02-20 06:15:47','0000-00-00 00:00:00'),(95,60,33,34,'2016-02-20','17:45:56',65,'S','1','102.00',NULL,11,'N',59,'2016-02-20 06:16:28',59,'2016-02-20 06:16:28','0000-00-00 00:00:00'),(96,60,33,35,'2016-02-20','09:00:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-20 06:30:15',59,'2016-02-20 06:30:15','0000-00-00 00:00:00'),(97,60,33,35,'2016-02-20','18:00:28',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-20 06:30:31',59,'2016-02-20 06:30:31','0000-00-00 00:00:00'),(98,60,33,35,'2016-02-20','18:00:39',60,'S','1','103.00',NULL,0,'N',59,'2016-02-20 06:31:16',59,'2016-02-20 06:31:16','0000-00-00 00:00:00'),(99,60,33,42,'2016-02-22','10:00:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-21 22:48:54',59,'2016-02-21 22:48:54','0000-00-00 00:00:00'),(100,60,33,42,'2016-02-22','10:19:37',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-21 22:49:41',59,'2016-02-21 22:49:41','0000-00-00 00:00:00'),(101,60,33,42,'2016-02-22','10:19:48',60,'S','1','104.00',NULL,11,'F',59,'2016-02-21 22:49:58',59,'2016-02-21 22:49:58','0000-00-00 00:00:00'),(102,61,36,44,'2016-02-27','11:50:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:35:47',67,'2016-02-21 23:35:47','0000-00-00 00:00:00'),(103,61,36,45,'2016-02-22','10:40:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:38:22',67,'2016-02-21 23:38:22','0000-00-00 00:00:00'),(104,61,36,44,'2016-02-22','11:17:57',68,'C','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:47:58',67,'2016-02-21 23:47:58','0000-00-00 00:00:00'),(105,61,36,44,'2016-02-22','11:17:58',68,'C','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:47:59',67,'2016-02-21 23:47:59','0000-00-00 00:00:00'),(106,61,36,44,'2016-02-22','11:17:58',68,'C','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:48:00',67,'2016-02-21 23:48:00','0000-00-00 00:00:00'),(107,61,36,45,'2016-02-22','11:19:11',68,'C','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:49:13',67,'2016-02-21 23:49:13','0000-00-00 00:00:00'),(108,61,36,46,'2016-02-23','12:00:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:50:08',67,'2016-02-21 23:50:08','0000-00-00 00:00:00'),(109,61,36,46,'2016-02-22','11:20:43',68,'A','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:50:46',67,'2016-02-21 23:50:46','0000-00-00 00:00:00'),(110,61,36,46,'2016-02-22','11:21:00',68,'C','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:51:02',67,'2016-02-21 23:51:02','0000-00-00 00:00:00'),(111,61,36,47,'2016-03-05','10:30:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:51:51',67,'2016-02-21 23:51:51','0000-00-00 00:00:00'),(112,61,36,48,'2016-02-26','10:40:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:52:41',67,'2016-02-21 23:52:41','0000-00-00 00:00:00'),(113,61,30,49,'2016-02-22','12:00:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:57:20',67,'2016-02-21 23:57:20','0000-00-00 00:00:00'),(114,61,30,49,'2016-02-22','11:29:33',68,'A','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:59:35',67,'2016-02-21 23:59:35','0000-00-00 00:00:00'),(115,61,36,47,'2016-02-22','11:30:33',68,'A','1','0.00',NULL,NULL,NULL,67,'2016-02-22 00:00:35',67,'2016-02-22 00:00:35','0000-00-00 00:00:00'),(116,61,36,47,'2016-02-22','12:01:25',68,'S','1','500.00',NULL,0,'N',67,'2016-02-22 00:31:30',67,'2016-02-22 00:31:30','0000-00-00 00:00:00'),(117,61,36,48,'2016-02-22','12:01:39',68,'A','1','0.00',NULL,NULL,NULL,67,'2016-02-22 00:31:41',67,'2016-02-22 00:31:41','0000-00-00 00:00:00'),(118,61,36,48,'2016-02-22','12:01:49',68,'S','1','500.00',NULL,0,'N',67,'2016-02-22 00:31:53',67,'2016-02-22 00:31:53','0000-00-00 00:00:00'),(119,58,37,50,'2016-02-22','11:00:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-22 02:32:54',51,'2016-02-22 02:32:54','0000-00-00 00:00:00'),(120,58,37,50,'2016-02-22','11:00:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-22 02:32:54',51,'2016-02-22 02:32:54','0000-00-00 00:00:00'),(121,58,37,50,'2016-02-22','14:03:35',56,'S','1','1030.00',NULL,4,'N',51,'2016-02-22 02:34:21',51,'2016-02-22 02:34:21','0000-00-00 00:00:00'),(122,58,37,52,'2016-02-22','11:45:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-22 02:44:53',51,'2016-02-22 02:44:53','0000-00-00 00:00:00'),(123,58,37,52,'2016-02-22','14:15:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-22 02:45:29',51,'2016-02-22 02:45:29','0000-00-00 00:00:00'),(124,58,37,52,'2016-02-22','14:17:01',56,'C','1','0.00',NULL,NULL,NULL,51,'2016-02-22 02:47:03',51,'2016-02-22 02:47:03','0000-00-00 00:00:00'),(125,58,37,53,'2016-02-22','06:10:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-22 02:49:10',51,'2016-02-22 02:49:10','0000-00-00 00:00:00'),(126,58,37,53,'2016-02-22','14:19:17',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-22 02:49:21',51,'2016-02-22 02:49:21','0000-00-00 00:00:00'),(127,58,37,53,'2016-02-22','14:32:16',54,'C','1','0.00',NULL,NULL,NULL,51,'2016-02-22 03:02:18',51,'2016-02-22 03:02:18','0000-00-00 00:00:00'),(128,61,30,49,'2016-02-25','13:09:25',68,'S','1','200.00',NULL,14,'F',67,'2016-02-25 01:39:43',67,'2016-02-25 01:39:43','0000-00-00 00:00:00'),(129,61,30,56,'2016-02-25','10:30:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-25 01:42:49',67,'2016-02-25 01:42:49','0000-00-00 00:00:00'),(130,61,30,57,'2016-02-25','10:30:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-25 01:43:14',67,'2016-02-25 01:43:14','0000-00-00 00:00:00'),(131,61,30,56,'2016-02-25','16:25:29',68,'A','1','0.00',NULL,NULL,NULL,67,'2016-02-25 04:55:43',67,'2016-02-25 04:55:43','0000-00-00 00:00:00'),(132,61,30,56,'2016-02-25','16:26:18',68,'C','1','0.00',NULL,NULL,NULL,67,'2016-02-25 04:56:22',67,'2016-02-25 04:56:22','0000-00-00 00:00:00'),(133,61,30,56,'2016-02-25','16:26:20',68,'C','1','0.00',NULL,NULL,NULL,67,'2016-02-25 04:56:24',67,'2016-02-25 04:56:24','0000-00-00 00:00:00'),(134,61,30,57,'2016-02-25','16:26:32',68,'A','1','0.00',NULL,NULL,NULL,67,'2016-02-25 04:56:37',67,'2016-02-25 04:56:37','0000-00-00 00:00:00'),(135,61,30,57,'2016-02-25','16:26:47',68,'S','1','200.00',NULL,4,'N',67,'2016-02-25 04:56:55',67,'2016-02-25 04:56:55','0000-00-00 00:00:00'),(136,61,30,58,'2016-02-25','10:40:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-25 05:09:56',67,'2016-02-25 05:09:56','0000-00-00 00:00:00'),(137,61,30,58,'2016-02-25','16:42:00',68,'A','1','0.00',NULL,NULL,NULL,67,'2016-02-25 05:13:01',67,'2016-02-25 05:13:01','0000-00-00 00:00:00'),(138,58,38,61,'2016-02-25','05:00:00',54,'B','1','0.00',NULL,NULL,NULL,63,'2016-02-25 07:13:43',63,'2016-02-25 07:13:43','0000-00-00 00:00:00'),(139,58,38,61,'2016-02-25','18:43:51',54,'A','1','0.00',NULL,NULL,NULL,63,'2016-02-25 07:13:54',63,'2016-02-25 07:13:54','0000-00-00 00:00:00'),(140,58,26,14,'2016-02-29','17:48:36',56,'C','1','0.00',NULL,NULL,NULL,51,'2016-02-29 06:18:36',51,'2016-02-29 06:18:36','0000-00-00 00:00:00'),(141,58,20,8,'2016-03-04','10:01:14',54,'S','1','100.00',NULL,4,'N',51,'2016-03-03 22:31:18',51,'2016-03-03 22:31:18','0000-00-00 00:00:00'),(142,58,20,13,'2016-03-04','10:01:32',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-03 22:31:35',51,'2016-03-03 22:31:35','0000-00-00 00:00:00'),(143,58,20,13,'2016-03-04','10:01:43',56,'S','1','100.00',NULL,4,'N',51,'2016-03-03 22:31:47',51,'2016-03-03 22:31:47','0000-00-00 00:00:00'),(144,58,20,63,'2016-03-04','11:10:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-03 23:02:09',51,'2016-03-03 23:02:09','0000-00-00 00:00:00'),(145,58,20,63,'2016-03-04','10:33:42',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-03 23:03:45',51,'2016-03-03 23:03:45','0000-00-00 00:00:00'),(146,58,39,65,'2016-03-04','11:30:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-04 01:17:45',51,'2016-03-04 01:17:45','0000-00-00 00:00:00'),(147,58,39,65,'2016-03-04','12:48:01',56,'C','1','0.00',NULL,NULL,NULL,51,'2016-03-04 01:18:04',51,'2016-03-04 01:18:04','0000-00-00 00:00:00'),(148,58,20,63,'2016-03-12','15:09:58',56,'S','1','100.00',NULL,4,'N',51,'2016-03-12 03:40:03',51,'2016-03-12 03:40:03','0000-00-00 00:00:00'),(149,58,20,66,'2016-03-12','11:50:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-12 03:40:25',51,'2016-03-12 03:40:25','0000-00-00 00:00:00'),(150,58,20,66,'2016-03-12','16:02:52',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-12 04:32:55',51,'2016-03-12 04:32:55','0000-00-00 00:00:00'),(151,58,20,66,'2016-03-12','16:03:05',56,'S','1','100.00',NULL,4,'N',51,'2016-03-12 04:33:10',51,'2016-03-12 04:33:10','0000-00-00 00:00:00'),(152,58,20,67,'2016-03-12','06:20:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-12 04:34:23',51,'2016-03-12 04:34:23','0000-00-00 00:00:00'),(153,58,20,67,'2016-03-12','16:16:33',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-12 04:46:39',51,'2016-03-12 04:46:39','0000-00-00 00:00:00'),(154,58,20,67,'2016-03-12','16:16:47',54,'S','1','100.00',NULL,4,'N',51,'2016-03-12 04:47:02',51,'2016-03-12 04:47:02','0000-00-00 00:00:00'),(155,58,40,68,'2016-03-17','05:05:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-14 02:28:07',51,'2016-03-14 02:28:07','0000-00-00 00:00:00'),(156,58,41,69,'2016-03-14','05:00:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-14 03:02:26',51,'2016-03-14 03:02:26','0000-00-00 00:00:00'),(157,58,42,70,'2016-03-14','05:05:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-14 03:03:44',51,'2016-03-14 03:03:44','0000-00-00 00:00:00'),(158,58,41,69,'2016-03-14','15:45:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-14 05:15:28',51,'2016-03-14 05:15:28','0000-00-00 00:00:00'),(159,58,43,71,'2016-03-14','05:30:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-14 05:18:28',51,'2016-03-14 05:18:28','0000-00-00 00:00:00'),(160,58,43,71,'2016-03-14','05:30:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-14 05:18:28',51,'2016-03-14 05:18:28','0000-00-00 00:00:00'),(161,58,20,72,'2016-03-16','11:55:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-15 00:39:12',51,'2016-03-15 00:39:12','0000-00-00 00:00:00'),(162,58,20,72,'2016-03-01','01:05:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-15 00:39:59',51,'2016-03-15 00:39:59','0000-00-00 00:00:00'),(163,58,20,72,'2016-03-01','01:10:00',56,'S','1','100.00',NULL,4,'N',51,'2016-03-15 00:40:21',51,'2016-03-15 00:40:21','0000-00-00 00:00:00'),(164,58,40,68,'2016-03-15','15:40:13',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-15 05:10:20',51,'2016-03-15 05:10:20','0000-00-00 00:00:00'),(165,58,40,68,'2016-03-15','15:40:34',54,'S','1','100.00',NULL,6,'N',51,'2016-03-15 05:10:39',51,'2016-03-15 05:10:39','0000-00-00 00:00:00'),(166,58,40,73,'2016-03-16','05:00:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-16 09:12:00',51,'2016-03-16 09:12:00','0000-00-00 00:00:00'),(167,58,40,74,'2016-03-16','05:30:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-16 09:17:56',51,'2016-03-16 09:17:56','0000-00-00 00:00:00'),(168,58,28,75,'2016-03-17','11:45:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-17 03:26:20',51,'2016-03-17 03:26:20','0000-00-00 00:00:00'),(169,58,28,75,'2016-03-17','11:45:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-17 03:26:20',51,'2016-03-17 03:26:20','0000-00-00 00:00:00'),(170,58,20,76,'2016-03-21','11:15:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-21 02:15:51',51,'2016-03-21 02:15:51','0000-00-00 00:00:00'),(171,58,20,76,'2016-03-21','11:15:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-21 02:15:51',51,'2016-03-21 02:15:51','0000-00-00 00:00:00'),(172,58,20,77,'2016-03-21','11:15:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-21 02:16:55',51,'2016-03-21 02:16:55','0000-00-00 00:00:00'),(173,58,20,78,'2016-03-21','11:05:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-21 02:18:50',51,'2016-03-21 02:18:50','0000-00-00 00:00:00'),(174,58,39,79,'2016-03-21','01:50:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-21 02:59:07',51,'2016-03-21 02:59:07','0000-00-00 00:00:00'),(175,58,39,80,'2016-03-21','01:50:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-21 03:00:04',51,'2016-03-21 03:00:04','0000-00-00 00:00:00'),(176,58,26,81,'2016-03-21','01:50:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-21 03:02:41',51,'2016-03-21 03:02:41','0000-00-00 00:00:00'),(177,58,26,82,'2016-03-21','01:50:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-21 03:04:39',51,'2016-03-21 03:04:39','0000-00-00 00:00:00'),(178,58,20,78,'2016-03-21','11:05:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-21 07:57:43',51,'2016-03-21 07:57:43','0000-00-00 00:00:00'),(179,58,20,77,'2016-03-21','11:15:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-21 07:58:00',51,'2016-03-21 07:58:00','0000-00-00 00:00:00'),(180,58,37,83,'2016-03-22','01:50:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-22 01:57:48',51,'2016-03-22 01:57:48','0000-00-00 00:00:00'),(181,58,37,83,'2016-03-22','12:29:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-22 01:59:06',51,'2016-03-22 01:59:06','0000-00-00 00:00:00'),(182,58,37,83,'2016-03-22','12:29:15',54,'S','1','100.00',NULL,4,'N',51,'2016-03-22 01:59:20',51,'2016-03-22 01:59:20','0000-00-00 00:00:00'),(183,58,37,84,'2016-03-23','11:55:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-23 04:56:08',51,'2016-03-23 04:56:08','0000-00-00 00:00:00'),(184,58,37,84,'2016-03-23','15:32:10',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-23 05:02:13',51,'2016-03-23 05:02:13','0000-00-00 00:00:00'),(185,58,37,84,'2016-03-23','15:32:25',56,'S','1','225.00',NULL,4,'N',51,'2016-03-23 05:02:33',51,'2016-03-23 05:02:46','0000-00-00 00:00:00'),(186,58,34,87,'2016-03-24','01:35:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-24 07:23:35',51,'2016-03-24 07:23:35','0000-00-00 00:00:00'),(187,58,34,87,'2016-03-24','17:55:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-24 07:25:08',51,'2016-03-24 07:25:08','0000-00-00 00:00:00'),(188,58,34,87,'2016-03-24','18:11:42',54,'S','1','200.00',NULL,6,'N',51,'2016-03-24 07:41:51',51,'2016-03-24 07:44:19','0000-00-00 00:00:00'),(189,58,44,90,'2016-03-31','01:50:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-31 02:09:01',51,'2016-03-31 02:09:01','0000-00-00 00:00:00'),(190,58,44,90,'2016-03-31','01:50:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-31 02:09:11',51,'2016-03-31 02:09:11','0000-00-00 00:00:00'),(191,58,44,90,'2016-03-31','12:39:18',54,'S','1','100.00',NULL,4,NULL,51,'2016-03-31 02:09:23',51,'2016-03-31 02:09:23','0000-00-00 00:00:00'),(192,58,44,92,'2016-03-31','01:50:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-31 02:12:05',51,'2016-03-31 02:12:05','0000-00-00 00:00:00'),(193,58,34,93,'2016-03-31','02:00:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-31 05:02:18',51,'2016-03-31 05:02:18','0000-00-00 00:00:00'),(194,58,34,93,'2016-03-31','16:43:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-31 06:13:26',51,'2016-03-31 06:13:26','0000-00-00 00:00:00'),(195,58,34,93,'2016-03-31','16:43:36',54,'S','1','100.00',NULL,6,'N',51,'2016-03-31 06:14:03',51,'2016-03-31 06:14:03','0000-00-00 00:00:00'),(196,58,22,94,'2016-04-01','01:55:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-31 23:26:22',51,'2016-03-31 23:26:22','0000-00-00 00:00:00'),(197,58,22,95,'2016-04-01','11:55:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-31 23:27:23',51,'2016-03-31 23:27:23','0000-00-00 00:00:00'),(198,58,42,70,'2016-04-02','10:27:14',54,'C','1','0.00',NULL,NULL,NULL,51,'2016-04-01 23:57:19',51,'2016-04-01 23:57:19','0000-00-00 00:00:00'),(199,58,20,76,'2016-04-04','10:42:43',56,'S','1','100.00',NULL,4,'N',51,'2016-04-04 00:12:48',51,'2016-04-04 00:12:48','0000-00-00 00:00:00'),(200,58,20,77,'2016-04-04','10:42:56',56,'S','1','100.00',NULL,4,'N',51,'2016-04-04 00:12:59',51,'2016-04-04 00:12:59','0000-00-00 00:00:00'),(201,58,20,78,'2016-04-04','10:49:57',56,'S','1','100.00',NULL,4,'N',51,'2016-04-04 00:20:00',51,'2016-04-04 00:20:00','0000-00-00 00:00:00'),(202,58,25,15,'2016-04-05','09:59:56',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-04-04 23:29:59',51,'2016-04-04 23:29:59','0000-00-00 00:00:00'),(203,58,25,15,'2016-04-05','10:00:08',56,'S','1','200.00',NULL,5,NULL,51,'2016-04-04 23:30:13',51,'2016-04-04 23:30:13','0000-00-00 00:00:00'),(204,58,42,103,'2016-04-25','02:00:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-04-25 04:41:22',51,'2016-04-25 04:41:22','0000-00-00 00:00:00'),(205,58,42,103,'2016-04-25','02:00:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-04-25 04:41:32',51,'2016-04-25 04:41:32','0000-00-00 00:00:00'),(206,58,42,103,'2016-04-25','15:11:49',54,'S','1','100.00',NULL,5,'F',51,'2016-04-25 04:41:53',51,'2016-04-25 04:41:53','0000-00-00 00:00:00'),(207,58,42,103,'2016-04-25','15:13:45',54,'S','1','100.00',NULL,5,'F',51,'2016-04-25 04:43:48',51,'2016-04-25 04:43:48','0000-00-00 00:00:00'),(208,58,42,103,'2016-04-25','15:14:11',54,'S','1','100.00',NULL,5,'F',51,'2016-04-25 04:44:15',51,'2016-04-25 04:44:15','0000-00-00 00:00:00'),(209,58,42,103,'2016-04-26','12:11:21',54,'S','1','100.00',NULL,5,'F',51,'2016-04-26 01:41:25',51,'2016-04-26 01:41:25','0000-00-00 00:00:00'),(210,58,20,104,'2016-04-26','12:00:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-04-26 04:58:05',51,'2016-04-26 04:58:05','0000-00-00 00:00:00'),(211,58,20,104,'2016-04-26','15:28:13',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-04-26 04:58:15',51,'2016-04-26 04:58:15','0000-00-00 00:00:00'),(212,58,20,104,'2016-04-26','15:28:24',56,'S','1','100.00',NULL,4,'N',51,'2016-04-26 04:58:26',51,'2016-04-26 04:58:26','0000-00-00 00:00:00'),(213,58,20,104,'2016-04-26','15:28:41',56,'S','1','100.00',NULL,4,'N',51,'2016-04-26 04:58:43',51,'2016-04-26 04:58:43','0000-00-00 00:00:00'),(214,58,20,104,'2016-04-26','16:16:47',56,'S','1','100.00',NULL,4,'N',51,'2016-04-26 05:46:50',51,'2016-04-26 05:46:50','0000-00-00 00:00:00'),(215,58,37,106,'2016-04-28','11:55:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-04-28 00:55:17',51,'2016-04-28 00:55:17','0000-00-00 00:00:00'),(216,58,37,106,'2016-04-28','11:55:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-04-28 00:55:26',51,'2016-04-28 00:55:26','0000-00-00 00:00:00'),(217,58,37,106,'2016-04-28','12:17:00',56,'S','1','100.00',NULL,4,'N',51,'2016-04-28 01:47:03',51,'2016-04-28 01:47:03','0000-00-00 00:00:00'),(218,58,37,106,'2016-04-28','12:17:19',56,'C','1','0.00',NULL,NULL,NULL,51,'2016-04-28 01:47:19',51,'2016-04-28 01:47:19','0000-00-00 00:00:00'),(219,58,42,103,'2016-04-30','19:25:21',54,'C','1','0.00',NULL,NULL,NULL,51,'2016-04-30 08:55:23',51,'2016-04-30 08:55:23','0000-00-00 00:00:00'),(220,58,39,80,'2016-04-30','19:25:50',54,'C','1','0.00',NULL,NULL,NULL,51,'2016-04-30 08:55:52',51,'2016-04-30 08:55:52','0000-00-00 00:00:00'),(221,58,42,107,'2016-04-30','01:55:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-04-30 08:56:33',51,'2016-04-30 08:56:33','0000-00-00 00:00:00'),(222,58,42,107,'2016-04-30','01:55:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-04-30 08:56:33',51,'2016-04-30 08:56:33','0000-00-00 00:00:00'),(223,58,40,74,'2016-04-30','19:37:39',54,'C','1','0.00',NULL,NULL,NULL,51,'2016-04-30 09:07:41',51,'2016-04-30 09:07:41','0000-00-00 00:00:00'),(224,58,43,71,'2016-04-30','19:38:24',54,'C','1','0.00',NULL,NULL,NULL,51,'2016-04-30 09:08:26',51,'2016-04-30 09:08:26','0000-00-00 00:00:00'),(225,58,43,108,'2016-04-30','01:45:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-04-30 09:08:42',51,'2016-04-30 09:08:42','0000-00-00 00:00:00'),(226,58,32,20,'2016-04-30','19:39:35',56,'C','1','0.00',NULL,NULL,NULL,51,'2016-04-30 09:09:38',51,'2016-04-30 09:09:38','0000-00-00 00:00:00'),(227,58,32,109,'2016-04-30','01:20:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-04-30 09:10:26',51,'2016-04-30 09:10:26','0000-00-00 00:00:00'),(228,58,43,108,'2016-04-30','19:43:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-04-30 09:13:17',51,'2016-04-30 09:13:17','0000-00-00 00:00:00'),(229,58,43,108,'2016-04-30','19:43:22',54,'S','1','100.00',NULL,4,'N',51,'2016-04-30 09:13:26',51,'2016-04-30 09:13:26','0000-00-00 00:00:00'),(230,58,20,104,'2016-05-02','15:09:00',56,'S','1','100.00',NULL,4,'N',51,'2016-05-02 04:39:02',51,'2016-05-02 04:39:02','0000-00-00 00:00:00'),(231,58,20,110,'2016-05-02','11:20:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-02 04:39:46',51,'2016-05-02 04:39:46','0000-00-00 00:00:00'),(232,58,20,110,'2016-05-02','15:09:57',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-02 04:40:41',51,'2016-05-02 04:40:41','0000-00-00 00:00:00'),(233,58,20,110,'2016-05-02','15:10:48',56,'S','1','100.00',NULL,4,'N',51,'2016-05-02 04:40:50',51,'2016-05-02 04:40:50','0000-00-00 00:00:00'),(234,58,20,111,'2016-05-02','11:25:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-02 04:43:21',51,'2016-05-02 04:43:21','0000-00-00 00:00:00'),(235,58,20,111,'2016-05-02','15:13:47',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-02 04:43:53',51,'2016-05-02 04:43:53','0000-00-00 00:00:00'),(236,58,20,111,'2016-05-02','15:14:08',56,'S','1','100.00',NULL,4,'N',51,'2016-05-02 04:44:11',51,'2016-05-02 04:44:11','0000-00-00 00:00:00'),(237,58,20,112,'2016-05-02','11:55:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-02 04:46:48',51,'2016-05-02 04:46:48','0000-00-00 00:00:00'),(238,58,20,112,'2016-05-02','15:16:57',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-02 04:47:01',51,'2016-05-02 04:47:01','0000-00-00 00:00:00'),(239,58,20,112,'2016-05-02','15:17:12',56,'C','1','0.00',NULL,NULL,NULL,51,'2016-05-02 04:47:12',51,'2016-05-02 04:47:12','0000-00-00 00:00:00'),(240,58,20,113,'2016-05-02','11:55:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-02 04:49:45',51,'2016-05-02 04:49:45','0000-00-00 00:00:00'),(241,58,20,113,'2016-05-02','15:19:56',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-02 04:49:59',51,'2016-05-02 04:49:59','0000-00-00 00:00:00'),(242,58,20,113,'2016-05-02','15:20:07',56,'S','1','100.00',NULL,4,'N',51,'2016-05-02 04:50:22',51,'2016-05-02 04:50:22','0000-00-00 00:00:00'),(243,58,26,82,'2016-05-02','15:21:47',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-02 04:51:49',51,'2016-05-02 04:51:49','0000-00-00 00:00:00'),(244,58,26,82,'2016-05-02','15:22:12',54,'S','1','100.00',NULL,5,NULL,51,'2016-05-02 04:52:17',51,'2016-05-02 04:52:17','0000-00-00 00:00:00'),(245,58,26,81,'2016-03-21','01:50:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-02 04:59:19',51,'2016-05-02 04:59:19','0000-00-00 00:00:00'),(246,58,46,114,'2016-05-03','07:30:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-02 05:13:07',51,'2016-05-02 05:13:07','0000-00-00 00:00:00'),(247,58,46,114,'2016-05-03','07:30:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-02 05:13:17',51,'2016-05-02 05:13:17','0000-00-00 00:00:00'),(248,58,46,114,'2016-05-02','15:43:21',54,'S','1','100.00',NULL,6,NULL,51,'2016-05-02 05:13:25',51,'2016-05-02 05:13:25','0000-00-00 00:00:00'),(249,58,37,106,'2016-05-02','16:32:16',56,'C','1','0.00',NULL,NULL,NULL,51,'2016-05-02 06:02:16',51,'2016-05-02 06:02:16','0000-00-00 00:00:00'),(250,58,46,118,'2016-05-02','01:55:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-02 08:16:47',51,'2016-05-02 08:16:47','0000-00-00 00:00:00'),(251,58,46,118,'2016-05-02','18:48:07',54,'C','1','0.00',NULL,NULL,NULL,51,'2016-05-02 08:18:07',51,'2016-05-02 08:18:07','0000-00-00 00:00:00'),(252,58,46,119,'2016-05-17','01:50:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-02 08:18:26',51,'2016-05-02 08:18:26','0000-00-00 00:00:00'),(253,58,46,119,'2016-05-17','01:50:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-02 08:19:59',51,'2016-05-02 08:19:59','0000-00-00 00:00:00'),(254,58,46,119,'2016-05-02','18:50:03',54,'S','1','100.00',NULL,5,NULL,51,'2016-05-02 08:20:08',51,'2016-05-02 08:20:08','0000-00-00 00:00:00'),(255,58,34,120,'2016-05-04','01:55:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-04 05:02:57',51,'2016-05-04 05:02:57','0000-00-00 00:00:00'),(256,58,34,120,'2016-05-04','15:33:05',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-04 05:03:09',51,'2016-05-04 05:03:09','0000-00-00 00:00:00'),(257,58,34,120,'2016-05-04','15:33:19',54,'S','1','100.00',NULL,6,'N',51,'2016-05-04 05:03:25',51,'2016-05-04 05:03:25','0000-00-00 00:00:00'),(258,58,28,75,'2016-05-04','23:01:51',56,'C','1','0.00',NULL,NULL,NULL,51,'2016-05-04 12:31:53',51,'2016-05-04 12:31:53','0000-00-00 00:00:00'),(259,58,39,79,'2016-03-21','01:50:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-04 12:32:36',51,'2016-05-04 12:32:36','0000-00-00 00:00:00'),(260,58,45,123,'2016-05-04','01:55:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-04 12:38:42',51,'2016-05-04 12:38:42','0000-00-00 00:00:00'),(261,58,45,123,'2016-05-04','23:08:49',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-04 12:38:54',51,'2016-05-04 12:38:54','0000-00-00 00:00:00'),(262,58,45,123,'2016-05-04','23:09:00',54,'S','1','3300.00',NULL,13,'N',51,'2016-05-04 12:39:08',51,'2016-05-04 12:39:27','0000-00-00 00:00:00'),(263,58,45,124,'2016-05-04','01:50:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-04 12:42:40',51,'2016-05-04 12:42:40','0000-00-00 00:00:00'),(264,58,46,125,'2016-05-06','01:55:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-05 23:56:21',51,'2016-05-05 23:56:21','0000-00-00 00:00:00'),(265,58,46,125,'2016-05-06','01:55:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-05 23:56:56',51,'2016-05-05 23:56:56','0000-00-00 00:00:00'),(266,58,46,125,'2016-05-06','10:27:34',54,'S','1','100.00',NULL,5,NULL,51,'2016-05-05 23:57:40',51,'2016-05-05 23:58:30','0000-00-00 00:00:00'),(267,58,20,127,'2016-05-07','12:00:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-07 04:54:42',51,'2016-05-07 04:54:42','0000-00-00 00:00:00'),(268,58,49,129,'2016-05-11','11:00:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-11 00:53:17',51,'2016-05-11 00:53:17','0000-00-00 00:00:00'),(269,58,49,129,'2016-05-11','11:23:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-11 00:53:37',51,'2016-05-11 00:53:37','0000-00-00 00:00:00'),(270,58,49,129,'2016-05-11','11:24:04',56,'S','1','200.00',NULL,5,'N',51,'2016-05-11 00:54:15',51,'2016-05-11 00:54:15','0000-00-00 00:00:00'),(271,58,49,130,'2016-05-11','12:00:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-11 00:56:00',51,'2016-05-11 00:56:00','0000-00-00 00:00:00'),(272,58,49,130,'2016-05-11','11:26:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-11 00:56:59',51,'2016-05-11 00:56:59','0000-00-00 00:00:00'),(273,58,49,130,'2016-05-11','15:38:27',56,'S','1','200.00',NULL,5,'N',51,'2016-05-11 05:08:20',51,'2016-05-11 05:08:20','0000-00-00 00:00:00'),(274,58,42,107,'2016-05-11','23:47:44',54,'C','1','0.00',NULL,NULL,NULL,51,'2016-05-11 13:17:47',51,'2016-05-11 13:17:47','0000-00-00 00:00:00'),(275,58,42,131,'2016-05-11','06:50:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-11 13:18:28',51,'2016-05-11 13:18:28','0000-00-00 00:00:00'),(276,58,41,69,'2016-05-11','23:50:10',54,'C','1','0.00',NULL,NULL,NULL,51,'2016-05-11 13:20:13',51,'2016-05-11 13:20:13','0000-00-00 00:00:00'),(277,58,50,132,'2016-05-13','11:45:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-13 06:16:47',51,'2016-05-13 06:16:47','0000-00-00 00:00:00'),(278,58,38,61,'2016-05-13','16:52:57',54,'C','1','0.00',NULL,NULL,NULL,51,'2016-05-13 06:22:56',51,'2016-05-13 06:22:56','0000-00-00 00:00:00'),(279,58,23,133,'2016-05-20','00:30:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-20 05:19:26',51,'2016-05-20 05:19:26','0000-00-00 00:00:00'),(280,58,18,134,'2016-05-27','00:30:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-20 07:05:57',51,'2016-05-20 07:05:57','0000-00-00 00:00:00'),(281,58,23,133,'2016-05-20','17:40:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-20 07:10:27',51,'2016-05-20 07:10:27','0000-00-00 00:00:00'),(282,58,51,135,'2016-05-24','01:00:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-23 23:23:07',51,'2016-05-23 23:23:07','0000-00-00 00:00:00'),(283,58,51,135,'2016-05-24','01:00:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-23 23:23:52',51,'2016-05-23 23:23:52','0000-00-00 00:00:00'),(284,58,51,135,'2016-05-24','09:57:05',54,'C','1','0.00',NULL,NULL,NULL,51,'2016-05-23 23:27:06',51,'2016-05-23 23:27:06','0000-00-00 00:00:00'),(285,58,51,136,'2016-05-24','01:30:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-23 23:27:21',51,'2016-05-23 23:27:21','0000-00-00 00:00:00'),(286,58,51,136,'2016-05-24','09:57:31',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-23 23:27:36',51,'2016-05-23 23:27:36','0000-00-00 00:00:00'),(287,58,51,136,'2016-05-24','09:57:46',54,'C','1','0.00',NULL,NULL,NULL,51,'2016-05-23 23:27:46',51,'2016-05-23 23:27:46','0000-00-00 00:00:00'),(288,58,51,137,'2016-05-24','02:00:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-23 23:27:58',51,'2016-05-23 23:27:58','0000-00-00 00:00:00'),(289,58,51,137,'2016-05-24','09:58:06',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-23 23:28:11',51,'2016-05-23 23:28:11','0000-00-00 00:00:00'),(290,58,51,137,'2016-05-24','09:58:29',54,'S','1','100.00',NULL,4,NULL,51,'2016-05-23 23:28:35',51,'2016-05-23 23:28:35','0000-00-00 00:00:00'),(291,58,51,138,'2016-05-24','02:00:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-23 23:28:45',51,'2016-05-23 23:28:45','0000-00-00 00:00:00'),(292,58,51,138,'2016-05-24','02:00:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-23 23:28:51',51,'2016-05-23 23:28:51','0000-00-00 00:00:00'),(293,58,51,138,'2016-05-24','09:59:36',54,'S','1','300.00',NULL,0,'N',51,'2016-05-23 23:29:45',51,'2016-05-23 23:29:45','0000-00-00 00:00:00'),(294,58,51,139,'2016-05-24','01:45:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-23 23:30:07',51,'2016-05-23 23:30:07','0000-00-00 00:00:00'),(295,58,47,140,'2016-05-24','12:00:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-05-23 23:30:44',51,'2016-05-23 23:30:44','0000-00-00 00:00:00'),(296,58,51,139,'2016-05-31','15:15:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-05-24 03:12:14',51,'2016-05-24 03:12:14','0000-00-00 00:00:00'),(297,58,52,143,'2016-06-01','11:00:00',56,'B','1','0.00','Appointment rescheduled',NULL,NULL,51,'2016-05-31 00:21:59',51,'2016-05-31 00:26:29','0000-00-00 00:00:00'),(298,58,53,144,'2016-06-01','11:05:00',56,'B','1','0.00','Appointment rescheduled',NULL,NULL,51,'2016-05-31 00:25:32',51,'2016-05-31 00:26:29','0000-00-00 00:00:00'),(299,58,54,145,'2016-06-07','01:55:00',54,'B','1','0.00','Appointment rescheduled',NULL,NULL,51,'2016-06-06 05:12:14',51,'2016-06-06 05:15:09','0000-00-00 00:00:00'),(300,58,55,146,'2016-06-06','02:00:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-06-06 05:20:53',51,'2016-06-06 05:20:53','0000-00-00 00:00:00'),(301,58,54,145,'2016-06-06','15:55:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-06-06 05:25:30',51,'2016-06-06 05:25:30','0000-00-00 00:00:00'),(302,58,54,145,'2016-06-06','15:58:27',54,'S','1','100.00',NULL,4,NULL,51,'2016-06-06 05:28:33',51,'2016-06-06 05:28:33','0000-00-00 00:00:00'),(303,58,56,147,'2016-06-09','12:00:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-06-09 00:04:09',51,'2016-06-09 00:04:09','0000-00-00 00:00:00'),(304,58,56,147,'2016-06-09','10:52:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-06-09 00:22:27',51,'2016-06-09 00:22:27','0000-00-00 00:00:00'),(305,58,56,147,'2016-06-09','10:52:32',56,'S','1','0.00',NULL,6,'F',51,'2016-06-09 00:22:41',51,'2016-06-09 00:22:41','0000-00-00 00:00:00'),(306,58,57,148,'2016-06-11','12:00:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-06-11 05:00:52',51,'2016-06-11 05:00:52','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `pat_billing_extra_concession` */

insert  into `pat_billing_extra_concession`(`ec_id`,`tenant_id`,`encounter_id`,`patient_id`,`ec_type`,`link_id`,`extra_amount`,`concession_amount`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,86,22,'P',22,'200.00','0.00','1',51,'2016-03-31 01:14:20',51,'2016-03-31 01:14:20','0000-00-00 00:00:00'),(2,58,99,42,'P',22,'100.00','10000.00','1',51,'2016-04-13 07:57:21',51,'2016-04-13 07:58:48','0000-00-00 00:00:00'),(3,58,117,37,'C',54,'6000.00','4000000.00','1',51,'2016-05-04 12:55:02',51,'2016-05-04 12:55:38','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `pat_billing_other_charges` */

insert  into `pat_billing_other_charges`(`other_charge_id`,`tenant_id`,`encounter_id`,`patient_id`,`charge_cat_id`,`charge_subcat_id`,`charge_amount`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,86,22,2,23,'22323.00','1',51,'2016-03-24 07:16:50',51,'2016-03-24 07:16:50','0000-00-00 00:00:00'),(2,58,99,42,2,23,'2000.00','1',51,'2016-04-13 08:21:30',51,'2016-04-15 06:34:21','0000-00-00 00:00:00'),(3,58,70,42,2,23,'350.00','1',51,'2016-04-15 01:53:29',51,'2016-04-15 01:53:29','0000-00-00 00:00:00'),(4,58,100,42,2,23,'500.00','1',51,'2016-04-22 23:14:41',51,'2016-04-22 23:14:41','0000-00-00 00:00:00'),(5,58,103,42,2,23,'10000.00','1',51,'2016-04-25 05:07:06',51,'2016-04-25 05:07:06','0000-00-00 00:00:00'),(6,58,115,46,2,23,'1000.00','1',51,'2016-05-02 05:17:11',51,'2016-05-02 05:17:11','0000-00-00 00:00:00'),(7,58,121,34,2,23,'100.00','1',51,'2016-05-04 07:27:45',51,'2016-05-04 07:27:45','0000-00-00 00:00:00'),(8,58,122,46,2,23,'100.00','1',51,'2016-05-04 23:42:59',51,'2016-05-04 23:42:59','0000-00-00 00:00:00'),(9,58,126,46,2,23,'500.00','1',51,'2016-05-06 00:03:05',51,'2016-05-06 00:03:05','0000-00-00 00:00:00'),(10,58,128,46,2,39,'500.00','1',51,'2016-05-23 23:50:55',51,'2016-05-23 23:50:55','0000-00-00 00:00:00'),(11,58,128,46,2,23,'500.00','1',51,'2016-05-24 00:02:54',51,'2016-05-24 00:02:54','0000-00-00 00:00:00'),(12,58,142,34,2,39,'1000.00','1',51,'2016-05-24 03:35:07',51,'2016-05-24 03:35:07','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `pat_billing_payment` */

insert  into `pat_billing_payment`(`payment_id`,`tenant_id`,`encounter_id`,`patient_id`,`payment_date`,`payment_amount`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,86,22,'2016-03-24 17:46:55','2200.00','1',51,'2016-03-24 07:17:07',51,'2016-03-24 07:17:07','0000-00-00 00:00:00'),(2,58,97,20,'2016-04-04 15:46:26','10000.00','1',51,'2016-04-04 05:16:33',51,'2016-04-04 05:16:33','0000-00-00 00:00:00'),(3,58,98,37,'2016-04-05 10:55:20','10000.00','1',51,'2016-04-05 00:25:27',51,'2016-04-05 00:25:27','0000-00-00 00:00:00'),(4,58,99,42,'2016-04-13 18:41:17','500.00','1',51,'2016-04-13 08:11:28',51,'2016-04-13 08:11:28','0000-00-00 00:00:00'),(5,58,70,42,'2016-04-15 12:22:26','7000.00','1',51,'2016-04-15 01:52:36',51,'2016-04-15 01:52:36','0000-00-00 00:00:00'),(6,58,100,42,'2016-04-23 09:43:54','10000.00','1',51,'2016-04-22 23:14:00',51,'2016-04-22 23:14:00','0000-00-00 00:00:00'),(7,58,98,37,'2016-04-26 10:50:03','10000.00','1',51,'2016-04-26 00:20:08',51,'2016-04-26 00:20:08','0000-00-00 00:00:00'),(8,58,115,46,'2016-05-02 15:47:19','2000.00','1',51,'2016-05-02 05:17:23',51,'2016-05-02 05:17:23','0000-00-00 00:00:00'),(9,58,117,37,'2016-05-04 23:28:36','2.00','1',51,'2016-05-04 12:58:44',51,'2016-05-04 12:58:44','0000-00-00 00:00:00'),(10,58,121,34,'2016-05-07 10:39:50','100.00','1',51,'2016-05-07 00:09:54',51,'2016-05-07 00:09:54','0000-00-00 00:00:00'),(11,58,128,46,'2016-05-13 15:58:15','8000.00','1',51,'2016-05-13 05:28:44',51,'2016-05-13 05:28:44','0000-00-00 00:00:00'),(12,58,142,34,'2016-05-30 22:45:32','200.00','1',51,'2016-05-30 12:15:42',51,'2016-05-30 12:15:42','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=latin1;

/*Data for the table `pat_billing_recurring` */

insert  into `pat_billing_recurring`(`recurr_id`,`tenant_id`,`encounter_id`,`patient_id`,`recurr_date`,`room_type_id`,`room_type`,`charge_item_id`,`charge_item`,`charge_amount`,`recurr_group`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`,`executed_at`) values (1,58,91,44,'2016-03-31',10,'Non AC',3,'Room Rent','2000.00',44,'1',51,'2016-03-31 02:10:40',51,'2016-03-31 02:10:40','0000-00-00 00:00:00',NULL),(2,58,97,20,'2016-04-04',9,'ac',1,'Test','120.00',50,'1',51,'2016-04-04 05:14:40',51,'2016-04-04 05:14:40','0000-00-00 00:00:00',NULL),(3,58,99,42,'2016-04-13',11,'Deluxe',1,'Test','300.00',53,'1',51,'2016-04-13 02:05:01',51,'2016-04-13 02:05:01','0000-00-00 00:00:00',NULL),(4,58,99,42,'2016-04-13',11,'Deluxe',3,'Room Rent','2000.00',53,'1',51,'2016-04-13 02:05:01',51,'2016-04-13 02:05:01','0000-00-00 00:00:00',NULL),(5,58,98,37,'2016-04-15',10,'Non AC',3,'Room Rent','2000.00',55,'1',51,'2016-04-15 04:54:22',51,'2016-04-15 04:54:22','0000-00-00 00:00:00',NULL),(6,58,100,42,'2016-04-16',11,'Deluxe',2,'doppler','300.00',57,'1',51,'2016-04-15 06:35:58',51,'2016-04-15 06:35:58','0000-00-00 00:00:00',NULL),(7,58,100,42,'2016-04-16',11,'Deluxe',3,'Room Rent','2000.00',57,'1',51,'2016-04-15 06:35:58',51,'2016-04-15 06:35:58','0000-00-00 00:00:00',NULL),(8,58,98,37,'2016-04-23',10,'Non AC',3,'Room Rent','2000.00',55,'1',NULL,'2016-04-23 05:30:22',NULL,'2016-04-23 05:30:22','0000-00-00 00:00:00',NULL),(9,58,98,37,'2016-04-24',10,'Non AC',3,'Room Rent','2000.00',55,'1',NULL,'2016-04-23 22:00:15',NULL,'2016-04-23 22:00:15','0000-00-00 00:00:00',NULL),(10,58,98,37,'2016-04-25',10,'Non AC',3,'Room Rent','2000.00',55,'1',NULL,'2016-04-24 22:00:12',NULL,'2016-04-24 22:00:12','0000-00-00 00:00:00',NULL),(11,58,98,37,'2016-04-26',10,'Non AC',3,'Room Rent','2000.00',55,'1',NULL,'2016-04-25 22:00:14',NULL,'2016-04-25 22:00:14','0000-00-00 00:00:00',NULL),(12,58,105,34,'2016-04-27',10,'Non AC',3,'Room Rent','2000.00',67,'1',51,'2016-04-27 06:41:59',51,'2016-04-27 06:41:59','0000-00-00 00:00:00',NULL),(13,58,105,34,'2016-04-28',10,'Non AC',3,'Room Rent','2000.00',67,'1',NULL,'2016-04-27 22:00:14',NULL,'2016-04-27 22:00:14','0000-00-00 00:00:00',NULL),(14,58,105,34,'2016-04-29',10,'Non AC',3,'Room Rent','2000.00',67,'1',NULL,'2016-04-28 22:00:13',NULL,'2016-04-28 22:00:13','0000-00-00 00:00:00',NULL),(15,58,105,34,'2016-04-30',10,'Non AC',3,'Room Rent','2000.00',67,'1',NULL,'2016-04-29 22:00:14',NULL,'2016-04-29 22:00:14','0000-00-00 00:00:00',NULL),(16,58,105,34,'2016-05-01',10,'Non AC',3,'Room Rent','2000.00',67,'1',NULL,'2016-04-30 22:00:14',NULL,'2016-04-30 22:00:14','0000-00-00 00:00:00',NULL),(17,58,105,34,'2016-05-02',10,'Non AC',3,'Room Rent','2000.00',67,'1',NULL,'2016-05-01 22:00:13',NULL,'2016-05-01 22:00:13','0000-00-00 00:00:00',NULL),(18,58,117,37,'2016-05-02',9,'ac',1,'Test','120.00',72,'1',51,'2016-05-02 06:02:38',51,'2016-05-02 06:02:38','0000-00-00 00:00:00',NULL),(19,58,105,34,'2016-05-03',10,'Non AC',3,'Room Rent','2000.00',67,'1',NULL,'2016-05-02 22:00:13',NULL,'2016-05-02 22:00:13','0000-00-00 00:00:00',NULL),(20,58,117,37,'2016-05-03',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-02 22:00:13',NULL,'2016-05-02 22:00:13','0000-00-00 00:00:00',NULL),(21,58,105,34,'2016-05-04',10,'Non AC',3,'Room Rent','2000.00',67,'1',NULL,'2016-05-03 22:00:14',NULL,'2016-05-03 22:00:14','0000-00-00 00:00:00',NULL),(22,58,117,37,'2016-05-04',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-03 22:00:14',NULL,'2016-05-03 22:00:14','0000-00-00 00:00:00',NULL),(23,58,121,34,'2016-05-04',9,'ac',1,'Test','120.00',77,'1',51,'2016-05-04 05:57:56',51,'2016-05-04 05:57:56','0000-00-00 00:00:00',NULL),(24,58,122,46,'2016-05-04',11,'Deluxe',2,'doppler','300.00',79,'1',51,'2016-05-04 12:35:24',51,'2016-05-04 12:35:24','0000-00-00 00:00:00',NULL),(25,58,122,46,'2016-05-04',11,'Deluxe',3,'Room Rent','2000.00',79,'1',51,'2016-05-04 12:35:24',51,'2016-05-04 12:35:24','0000-00-00 00:00:00',NULL),(26,58,117,37,'2016-05-05',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-04 22:00:13',NULL,'2016-05-04 22:00:13','0000-00-00 00:00:00',NULL),(27,58,121,34,'2016-05-05',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-04 22:00:13',NULL,'2016-05-04 22:00:13','0000-00-00 00:00:00',NULL),(28,58,122,46,'2016-05-05',11,'Deluxe',2,'doppler','300.00',79,'1',NULL,'2016-05-04 22:00:13',NULL,'2016-05-04 22:00:13','0000-00-00 00:00:00',NULL),(29,58,122,46,'2016-05-05',11,'Deluxe',3,'Room Rent','2000.00',79,'1',NULL,'2016-05-04 22:00:13',NULL,'2016-05-04 22:00:13','0000-00-00 00:00:00',NULL),(30,58,117,37,'2016-05-06',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-05 22:00:13',NULL,'2016-05-05 22:00:13','0000-00-00 00:00:00',NULL),(31,58,121,34,'2016-05-06',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-05 22:00:13',NULL,'2016-05-05 22:00:13','0000-00-00 00:00:00',NULL),(32,58,122,46,'2016-05-06',11,'Deluxe',2,'doppler','300.00',79,'1',NULL,'2016-05-05 22:00:13',NULL,'2016-05-05 22:00:13','0000-00-00 00:00:00',NULL),(33,58,122,46,'2016-05-06',11,'Deluxe',3,'Room Rent','2000.00',79,'1',NULL,'2016-05-05 22:00:13',NULL,'2016-05-05 22:00:13','0000-00-00 00:00:00',NULL),(34,58,126,46,'2016-05-06',10,'Non AC',3,'Room Rent','2000.00',82,'1',51,'2016-05-05 23:59:00',51,'2016-05-05 23:59:00','0000-00-00 00:00:00',NULL),(35,58,117,37,'2016-05-07',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-06 22:00:12',NULL,'2016-05-06 22:00:12','0000-00-00 00:00:00',NULL),(36,58,121,34,'2016-05-07',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-06 22:00:12',NULL,'2016-05-06 22:00:12','0000-00-00 00:00:00',NULL),(37,58,126,46,'2016-05-07',10,'Non AC',3,'Room Rent','2000.00',82,'1',NULL,'2016-05-06 22:00:12',NULL,'2016-05-06 22:00:12','0000-00-00 00:00:00',NULL),(38,58,117,37,'2016-05-08',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-07 22:00:12',NULL,'2016-05-07 22:00:12','0000-00-00 00:00:00',NULL),(39,58,121,34,'2016-05-08',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-07 22:00:12',NULL,'2016-05-07 22:00:12','0000-00-00 00:00:00',NULL),(40,58,126,46,'2016-05-08',10,'Non AC',3,'Room Rent','2000.00',82,'1',NULL,'2016-05-07 22:00:12',NULL,'2016-05-07 22:00:12','0000-00-00 00:00:00',NULL),(41,58,117,37,'2016-05-09',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-08 22:00:13',NULL,'2016-05-08 22:00:13','0000-00-00 00:00:00',NULL),(42,58,121,34,'2016-05-09',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-08 22:00:13',NULL,'2016-05-08 22:00:13','0000-00-00 00:00:00',NULL),(43,58,126,46,'2016-05-09',10,'Non AC',3,'Room Rent','2000.00',82,'1',NULL,'2016-05-08 22:00:13',NULL,'2016-05-08 22:00:13','0000-00-00 00:00:00',NULL),(44,58,117,37,'2016-05-10',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-09 22:00:15',NULL,'2016-05-09 22:00:15','0000-00-00 00:00:00',NULL),(45,58,121,34,'2016-05-10',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-09 22:00:15',NULL,'2016-05-09 22:00:15','0000-00-00 00:00:00',NULL),(46,58,126,46,'2016-05-10',10,'Non AC',3,'Room Rent','2000.00',82,'1',NULL,'2016-05-09 22:00:15',NULL,'2016-05-09 22:00:15','0000-00-00 00:00:00',NULL),(47,58,128,46,'2016-05-09',10,'Non AC',3,'Room Rent','2000.00',85,'1',51,'2016-05-10 08:11:19',51,'2016-05-10 08:11:19','0000-00-00 00:00:00',NULL),(48,58,117,37,'2016-05-11',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-10 22:00:15',NULL,'2016-05-10 22:00:15','0000-00-00 00:00:00',NULL),(49,58,121,34,'2016-05-11',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-10 22:00:15',NULL,'2016-05-10 22:00:15','0000-00-00 00:00:00',NULL),(50,58,128,46,'2016-05-11',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-10 22:00:15',NULL,'2016-05-10 22:00:15','0000-00-00 00:00:00',NULL),(51,58,117,37,'2016-05-12',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-11 22:00:15',NULL,'2016-05-11 22:00:15','0000-00-00 00:00:00',NULL),(52,58,121,34,'2016-05-12',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-11 22:00:15',NULL,'2016-05-11 22:00:15','0000-00-00 00:00:00',NULL),(53,58,128,46,'2016-05-12',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-11 22:00:15',NULL,'2016-05-11 22:00:15','0000-00-00 00:00:00',NULL),(54,58,117,37,'2016-05-13',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-12 22:00:14',NULL,'2016-05-12 22:00:14','0000-00-00 00:00:00',NULL),(55,58,121,34,'2016-05-13',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-12 22:00:14',NULL,'2016-05-12 22:00:14','0000-00-00 00:00:00',NULL),(56,58,128,46,'2016-05-13',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-12 22:00:14',NULL,'2016-05-12 22:00:14','0000-00-00 00:00:00',NULL),(57,58,117,37,'2016-05-14',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-13 22:00:12',NULL,'2016-05-13 22:00:12','0000-00-00 00:00:00',NULL),(58,58,121,34,'2016-05-14',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-13 22:00:12',NULL,'2016-05-13 22:00:12','0000-00-00 00:00:00',NULL),(59,58,128,46,'2016-05-14',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-13 22:00:12',NULL,'2016-05-13 22:00:12','0000-00-00 00:00:00',NULL),(60,58,117,37,'2016-05-15',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-14 22:00:15',NULL,'2016-05-14 22:00:15','0000-00-00 00:00:00',NULL),(61,58,121,34,'2016-05-15',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-14 22:00:15',NULL,'2016-05-14 22:00:15','0000-00-00 00:00:00',NULL),(62,58,128,46,'2016-05-15',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-14 22:00:15',NULL,'2016-05-14 22:00:15','0000-00-00 00:00:00',NULL),(63,58,117,37,'2016-05-16',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-15 22:00:13',NULL,'2016-05-15 22:00:13','0000-00-00 00:00:00',NULL),(64,58,121,34,'2016-05-16',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-15 22:00:13',NULL,'2016-05-15 22:00:13','0000-00-00 00:00:00',NULL),(65,58,128,46,'2016-05-16',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-15 22:00:13',NULL,'2016-05-15 22:00:13','0000-00-00 00:00:00',NULL),(66,58,117,37,'2016-05-17',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-16 22:00:14',NULL,'2016-05-16 22:00:14','0000-00-00 00:00:00',NULL),(67,58,121,34,'2016-05-17',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-16 22:00:14',NULL,'2016-05-16 22:00:14','0000-00-00 00:00:00',NULL),(68,58,128,46,'2016-05-17',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-16 22:00:14',NULL,'2016-05-16 22:00:14','0000-00-00 00:00:00',NULL),(69,58,117,37,'2016-05-18',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-17 22:00:16',NULL,'2016-05-17 22:00:16','0000-00-00 00:00:00',NULL),(70,58,121,34,'2016-05-18',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-17 22:00:16',NULL,'2016-05-17 22:00:16','0000-00-00 00:00:00',NULL),(71,58,128,46,'2016-05-18',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-17 22:00:16',NULL,'2016-05-17 22:00:16','0000-00-00 00:00:00',NULL),(72,58,117,37,'2016-05-19',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-18 22:00:14',NULL,'2016-05-18 22:00:14','0000-00-00 00:00:00',NULL),(73,58,121,34,'2016-05-19',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-18 22:00:14',NULL,'2016-05-18 22:00:14','0000-00-00 00:00:00',NULL),(74,58,128,46,'2016-05-19',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-18 22:00:14',NULL,'2016-05-18 22:00:14','0000-00-00 00:00:00',NULL),(75,58,117,37,'2016-05-20',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-19 22:00:14',NULL,'2016-05-19 22:00:14','0000-00-00 00:00:00',NULL),(76,58,121,34,'2016-05-20',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-19 22:00:14',NULL,'2016-05-19 22:00:14','0000-00-00 00:00:00',NULL),(77,58,128,46,'2016-05-20',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-19 22:00:14',NULL,'2016-05-19 22:00:14','0000-00-00 00:00:00',NULL),(78,58,117,37,'2016-05-21',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-20 22:00:14',NULL,'2016-05-20 22:00:14','0000-00-00 00:00:00',NULL),(79,58,121,34,'2016-05-21',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-20 22:00:14',NULL,'2016-05-20 22:00:14','0000-00-00 00:00:00',NULL),(80,58,128,46,'2016-05-21',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-20 22:00:14',NULL,'2016-05-20 22:00:14','0000-00-00 00:00:00',NULL),(81,58,117,37,'2016-05-22',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-21 22:00:17',NULL,'2016-05-21 22:00:17','0000-00-00 00:00:00',NULL),(82,58,121,34,'2016-05-22',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-21 22:00:17',NULL,'2016-05-21 22:00:17','0000-00-00 00:00:00',NULL),(83,58,128,46,'2016-05-22',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-21 22:00:17',NULL,'2016-05-21 22:00:17','0000-00-00 00:00:00',NULL),(84,58,117,37,'2016-05-23',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-22 22:00:15',NULL,'2016-05-22 22:00:15','0000-00-00 00:00:00',NULL),(85,58,121,34,'2016-05-23',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-22 22:00:15',NULL,'2016-05-22 22:00:15','0000-00-00 00:00:00',NULL),(86,58,128,46,'2016-05-23',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-22 22:00:15',NULL,'2016-05-22 22:00:15','0000-00-00 00:00:00',NULL),(87,58,117,37,'2016-05-24',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-23 22:00:13',NULL,'2016-05-23 22:00:13','0000-00-00 00:00:00',NULL),(88,58,121,34,'2016-05-24',9,'ac',1,'Test','120.00',77,'1',NULL,'2016-05-23 22:00:13',NULL,'2016-05-23 22:00:13','0000-00-00 00:00:00',NULL),(89,58,128,46,'2016-05-24',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-23 22:00:13',NULL,'2016-05-23 22:00:13','0000-00-00 00:00:00',NULL),(90,58,142,34,'2016-05-24',9,'ac',1,'Test','120.00',89,'1',51,'2016-05-24 03:34:14',51,'2016-05-24 03:34:14','0000-00-00 00:00:00',NULL),(91,58,117,37,'2016-05-25',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-24 22:00:13',NULL,'2016-05-24 22:00:13','0000-00-00 00:00:00',NULL),(92,58,128,46,'2016-05-25',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-24 22:00:13',NULL,'2016-05-24 22:00:13','0000-00-00 00:00:00',NULL),(93,58,142,34,'2016-05-25',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-05-24 22:00:13',NULL,'2016-05-24 22:00:13','0000-00-00 00:00:00',NULL),(94,58,117,37,'2016-05-26',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-25 22:00:13',NULL,'2016-05-25 22:00:13','0000-00-00 00:00:00',NULL),(95,58,128,46,'2016-05-26',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-25 22:00:13',NULL,'2016-05-25 22:00:13','0000-00-00 00:00:00',NULL),(96,58,142,34,'2016-05-26',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-05-25 22:00:13',NULL,'2016-05-25 22:00:13','0000-00-00 00:00:00',NULL),(97,58,117,37,'2016-05-27',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-26 22:00:17',NULL,'2016-05-26 22:00:17','0000-00-00 00:00:00',NULL),(98,58,128,46,'2016-05-27',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-26 22:00:17',NULL,'2016-05-26 22:00:17','0000-00-00 00:00:00',NULL),(99,58,142,34,'2016-05-27',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-05-26 22:00:17',NULL,'2016-05-26 22:00:17','0000-00-00 00:00:00',NULL),(100,58,117,37,'2016-05-28',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-27 22:00:15',NULL,'2016-05-27 22:00:15','0000-00-00 00:00:00',NULL),(101,58,128,46,'2016-05-28',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-27 22:00:15',NULL,'2016-05-27 22:00:15','0000-00-00 00:00:00',NULL),(102,58,142,34,'2016-05-28',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-05-27 22:00:15',NULL,'2016-05-27 22:00:15','0000-00-00 00:00:00',NULL),(103,58,117,37,'2016-05-29',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-28 22:00:15',NULL,'2016-05-28 22:00:15','0000-00-00 00:00:00',NULL),(104,58,128,46,'2016-05-29',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-28 22:00:15',NULL,'2016-05-28 22:00:15','0000-00-00 00:00:00',NULL),(105,58,142,34,'2016-05-29',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-05-28 22:00:15',NULL,'2016-05-28 22:00:15','0000-00-00 00:00:00',NULL),(106,58,117,37,'2016-05-30',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-29 22:00:14',NULL,'2016-05-29 22:00:14','0000-00-00 00:00:00',NULL),(107,58,128,46,'2016-05-30',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-29 22:00:14',NULL,'2016-05-29 22:00:14','0000-00-00 00:00:00',NULL),(108,58,142,34,'2016-05-30',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-05-29 22:00:14',NULL,'2016-05-29 22:00:14','0000-00-00 00:00:00',NULL),(109,58,117,37,'2016-05-31',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-30 22:00:15',NULL,'2016-05-30 22:00:15','0000-00-00 00:00:00',NULL),(110,58,128,46,'2016-05-31',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-30 22:00:15',NULL,'2016-05-30 22:00:15','0000-00-00 00:00:00',NULL),(111,58,142,34,'2016-05-31',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-05-30 22:00:15',NULL,'2016-05-30 22:00:15','0000-00-00 00:00:00',NULL),(112,58,117,37,'2016-06-01',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-05-31 22:00:15',NULL,'2016-05-31 22:00:15','0000-00-00 00:00:00',NULL),(113,58,128,46,'2016-06-01',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-05-31 22:00:15',NULL,'2016-05-31 22:00:15','0000-00-00 00:00:00',NULL),(114,58,142,34,'2016-06-01',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-05-31 22:00:15',NULL,'2016-05-31 22:00:15','0000-00-00 00:00:00',NULL),(115,58,117,37,'2016-06-02',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-06-01 22:00:15',NULL,'2016-06-01 22:00:15','0000-00-00 00:00:00',NULL),(116,58,128,46,'2016-06-02',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-06-01 22:00:15',NULL,'2016-06-01 22:00:15','0000-00-00 00:00:00',NULL),(117,58,142,34,'2016-06-02',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-06-01 22:00:15',NULL,'2016-06-01 22:00:15','0000-00-00 00:00:00',NULL),(118,58,117,37,'2016-06-03',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-06-02 22:00:15',NULL,'2016-06-02 22:00:15','0000-00-00 00:00:00',NULL),(119,58,128,46,'2016-06-03',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-06-02 22:00:15',NULL,'2016-06-02 22:00:15','0000-00-00 00:00:00',NULL),(120,58,142,34,'2016-06-03',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-06-02 22:00:15',NULL,'2016-06-02 22:00:15','0000-00-00 00:00:00',NULL),(121,58,117,37,'2016-06-04',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-06-03 22:00:15',NULL,'2016-06-03 22:00:15','0000-00-00 00:00:00',NULL),(122,58,128,46,'2016-06-04',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-06-03 22:00:15',NULL,'2016-06-03 22:00:15','0000-00-00 00:00:00',NULL),(123,58,142,34,'2016-06-04',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-06-03 22:00:15',NULL,'2016-06-03 22:00:15','0000-00-00 00:00:00',NULL),(124,58,117,37,'2016-06-05',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-06-04 22:00:14',NULL,'2016-06-04 22:00:14','0000-00-00 00:00:00',NULL),(125,58,128,46,'2016-06-05',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-06-04 22:00:14',NULL,'2016-06-04 22:00:14','0000-00-00 00:00:00',NULL),(126,58,142,34,'2016-06-05',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-06-04 22:00:14',NULL,'2016-06-04 22:00:14','0000-00-00 00:00:00',NULL),(127,58,117,37,'2016-06-06',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-06-05 22:00:15',NULL,'2016-06-05 22:00:15','0000-00-00 00:00:00',NULL),(128,58,128,46,'2016-06-06',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-06-05 22:00:15',NULL,'2016-06-05 22:00:15','0000-00-00 00:00:00',NULL),(129,58,142,34,'2016-06-06',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-06-05 22:00:15',NULL,'2016-06-05 22:00:15','0000-00-00 00:00:00',NULL),(130,58,117,37,'2016-06-07',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-06-06 22:00:16',NULL,'2016-06-06 22:00:16','0000-00-00 00:00:00',NULL),(131,58,128,46,'2016-06-07',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-06-06 22:00:16',NULL,'2016-06-06 22:00:16','0000-00-00 00:00:00',NULL),(132,58,142,34,'2016-06-07',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-06-06 22:00:16',NULL,'2016-06-06 22:00:16','0000-00-00 00:00:00',NULL),(133,58,117,37,'2016-06-08',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-06-07 22:00:15',NULL,'2016-06-07 22:00:15','0000-00-00 00:00:00',NULL),(134,58,128,46,'2016-06-08',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-06-07 22:00:15',NULL,'2016-06-07 22:00:15','0000-00-00 00:00:00',NULL),(135,58,142,34,'2016-06-08',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-06-07 22:00:15',NULL,'2016-06-07 22:00:15','0000-00-00 00:00:00',NULL),(136,58,117,37,'2016-06-09',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-06-08 22:00:14',NULL,'2016-06-08 22:00:14','0000-00-00 00:00:00',NULL),(137,58,128,46,'2016-06-09',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-06-08 22:00:14',NULL,'2016-06-08 22:00:14','0000-00-00 00:00:00',NULL),(138,58,142,34,'2016-06-09',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-06-08 22:00:14',NULL,'2016-06-08 22:00:14','0000-00-00 00:00:00',NULL),(139,58,117,37,'2016-06-10',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-06-09 22:00:16',NULL,'2016-06-09 22:00:16','0000-00-00 00:00:00',NULL),(140,58,128,46,'2016-06-10',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-06-09 22:00:16',NULL,'2016-06-09 22:00:16','0000-00-00 00:00:00',NULL),(141,58,142,34,'2016-06-10',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-06-09 22:00:16',NULL,'2016-06-09 22:00:16','0000-00-00 00:00:00',NULL),(142,58,117,37,'2016-06-11',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-06-10 22:00:16',NULL,'2016-06-10 22:00:16','0000-00-00 00:00:00',NULL),(143,58,128,46,'2016-06-11',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-06-10 22:00:17',NULL,'2016-06-10 22:00:17','0000-00-00 00:00:00',NULL),(144,58,142,34,'2016-06-11',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-06-10 22:00:17',NULL,'2016-06-10 22:00:17','0000-00-00 00:00:00',NULL),(145,58,117,37,'2016-06-12',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-06-11 22:00:16',NULL,'2016-06-11 22:00:16','0000-00-00 00:00:00',NULL),(146,58,128,46,'2016-06-12',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-06-11 22:00:16',NULL,'2016-06-11 22:00:16','0000-00-00 00:00:00',NULL),(147,58,142,34,'2016-06-12',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-06-11 22:00:16',NULL,'2016-06-11 22:00:16','0000-00-00 00:00:00',NULL),(148,58,117,37,'2016-06-13',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-06-12 22:00:16',NULL,'2016-06-12 22:00:16','0000-00-00 00:00:00',NULL),(149,58,128,46,'2016-06-13',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-06-12 22:00:16',NULL,'2016-06-12 22:00:16','0000-00-00 00:00:00',NULL),(150,58,142,34,'2016-06-13',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-06-12 22:00:16',NULL,'2016-06-12 22:00:16','0000-00-00 00:00:00',NULL),(151,58,117,37,'2016-06-14',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-06-13 22:00:16',NULL,'2016-06-13 22:00:16','0000-00-00 00:00:00',NULL),(152,58,128,46,'2016-06-14',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-06-13 22:00:17',NULL,'2016-06-13 22:00:17','0000-00-00 00:00:00',NULL),(153,58,142,34,'2016-06-14',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-06-13 22:00:17',NULL,'2016-06-13 22:00:17','0000-00-00 00:00:00',NULL),(154,58,117,37,'2016-06-15',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-06-14 22:00:18',NULL,'2016-06-14 22:00:18','0000-00-00 00:00:00',NULL),(155,58,128,46,'2016-06-15',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-06-14 22:00:18',NULL,'2016-06-14 22:00:18','0000-00-00 00:00:00',NULL),(156,58,142,34,'2016-06-15',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-06-14 22:00:18',NULL,'2016-06-14 22:00:18','0000-00-00 00:00:00',NULL),(157,58,117,37,'2016-06-16',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-06-15 22:00:17',NULL,'2016-06-15 22:00:17','0000-00-00 00:00:00',NULL),(158,58,128,46,'2016-06-16',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-06-15 22:00:17',NULL,'2016-06-15 22:00:17','0000-00-00 00:00:00',NULL),(159,58,142,34,'2016-06-16',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-06-15 22:00:17',NULL,'2016-06-15 22:00:17','0000-00-00 00:00:00',NULL),(160,58,117,37,'2016-06-17',9,'ac',1,'Test','120.00',72,'1',NULL,'2016-06-16 22:00:16',NULL,'2016-06-16 22:00:16','0000-00-00 00:00:00',NULL),(161,58,128,46,'2016-06-17',10,'Non AC',3,'Room Rent','2000.00',85,'1',NULL,'2016-06-16 22:00:16',NULL,'2016-06-16 22:00:16','0000-00-00 00:00:00',NULL),(162,58,142,34,'2016-06-17',9,'ac',1,'Test','120.00',89,'1',NULL,'2016-06-16 22:00:16',NULL,'2016-06-16 22:00:16','0000-00-00 00:00:00',NULL);

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
  CONSTRAINT `FK_pat_consultant_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `pat_encounter` (`encounter_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;

/*Data for the table `pat_consultant` */

insert  into `pat_consultant`(`pat_consult_id`,`tenant_id`,`encounter_id`,`patient_id`,`consultant_id`,`consult_date`,`notes`,`charge_amount`,`proc_id`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,7,5,28,'2016-02-04 18:16:35','test','0.00',0,'1',1,'2016-02-04 15:56:15',1,'2016-02-04 16:35:09','2016-02-04 18:16:35'),(2,18,12,5,27,'2016-02-03 02:10:00','test test','0.00',0,'1',1,'2016-02-06 15:31:11',1,'2016-02-06 15:31:11','0000-00-00 00:00:00'),(3,58,5,20,54,'2016-02-10 01:05:00','aaa ddddd','0.00',0,'1',51,'2016-02-17 05:30:16',51,'2016-02-17 05:30:16','0000-00-00 00:00:00'),(4,58,5,20,54,'2016-02-11 01:05:00','aa ddd','0.00',0,'1',51,'2016-02-17 05:30:35',51,'2016-02-17 05:30:45','0000-00-00 00:00:00'),(5,58,5,20,54,'2016-02-03 06:10:00','aaadddd','0.00',0,'1',51,'2016-02-17 06:58:21',51,'2016-02-17 06:58:21','0000-00-00 00:00:00'),(6,58,8,20,56,'2016-02-07 09:50:00','test','0.00',0,'1',51,'2016-02-17 07:12:31',51,'2016-02-17 07:12:31','0000-00-00 00:00:00'),(7,60,6,29,60,'2016-02-18 14:00:00','intravenous','0.00',0,'1',59,'2016-02-18 00:35:43',59,'2016-02-18 00:35:43','0000-00-00 00:00:00'),(8,60,6,29,61,'2016-02-18 06:30:00','give coldmine syrup','0.00',0,'1',59,'2016-02-18 00:59:55',59,'2016-02-18 01:00:51','0000-00-00 00:00:00'),(9,60,6,29,61,'2016-02-18 07:35:00','follow up syrup','0.00',0,'1',59,'2016-02-18 01:00:23',59,'2016-02-18 01:00:23','0000-00-00 00:00:00'),(10,58,54,37,54,'2016-02-22 13:25:00','rf4rf4rf4f','0.00',0,'1',51,'2016-02-22 03:15:04',51,'2016-02-22 03:15:04','0000-00-00 00:00:00'),(11,58,54,37,54,'2016-03-03 10:30:00','gt56yyf','0.00',0,'1',51,'2016-02-22 03:16:35',51,'2016-02-22 03:16:35','0000-00-00 00:00:00'),(12,58,54,37,56,'2016-02-25 14:30:00','hbtgvrfcdx','0.00',0,'1',51,'2016-02-22 03:16:59',51,'2016-02-22 03:16:59','0000-00-00 00:00:00'),(13,61,56,30,68,'2016-02-25 10:10:00','test','0.00',0,'1',67,'2016-02-25 02:04:08',67,'2016-02-25 02:04:08','0000-00-00 00:00:00'),(14,61,56,30,68,'2016-03-10 11:35:00','asdfdf vad a adf asdfsda asdfsad a asfdasdfa','0.00',0,'1',67,'2016-02-25 02:05:22',67,'2016-02-25 02:06:52','0000-00-00 00:00:00'),(15,58,86,22,54,'2016-03-23 16:22:24','Consulted for Procedure (stomach wash)','100.00',10,'1',62,'2016-03-23 05:52:33',62,'2016-03-23 05:52:33','0000-00-00 00:00:00'),(16,58,86,22,56,'2016-03-23 16:22:24','Consulted for Procedure (stomach wash)','100.00',10,'1',62,'2016-03-23 05:52:33',62,'2016-03-23 05:52:33','0000-00-00 00:00:00'),(17,58,86,22,54,'2016-03-24 14:55:00','ddfdfd','100.00',0,'1',51,'2016-03-24 07:15:01',51,'2016-03-24 07:15:01','0000-00-00 00:00:00'),(18,58,97,20,54,'2016-04-04 15:44:53','Consulted for Procedure (stomach wash)','100.00',11,'1',51,'2016-04-04 05:14:58',51,'2016-04-04 05:14:58','0000-00-00 00:00:00'),(19,58,97,20,58,'2016-04-06 10:50:00',NULL,'100.00',0,'1',51,'2016-04-04 05:15:43',51,'2016-04-04 05:15:43','0000-00-00 00:00:00'),(20,58,97,20,54,'2016-04-06 10:25:00',NULL,'100.00',0,'1',51,'2016-04-04 23:25:37',51,'2016-04-04 23:25:37','0000-00-00 00:00:00'),(21,58,98,37,56,'2016-04-05 10:54:31','Consulted for Procedure (stomach wash)','100.00',12,'1',51,'2016-04-05 00:24:39',51,'2016-04-05 00:24:39','0000-00-00 00:00:00'),(22,58,98,37,54,'2016-04-05 10:54:31','Consulted for Procedure (stomach wash)','100.00',12,'1',51,'2016-04-05 00:24:39',51,'2016-04-05 00:24:39','0000-00-00 00:00:00'),(23,58,98,37,58,'2016-04-05 10:55:58',NULL,'100.00',0,'1',51,'2016-04-05 00:25:58',51,'2016-04-05 00:25:58','0000-00-00 00:00:00'),(24,58,99,42,56,'2016-04-13 12:37:54','Consulted for Procedure (stomach wash)','200.00',13,'1',51,'2016-04-13 02:08:16',51,'2016-04-13 02:08:16','0000-00-00 00:00:00'),(25,58,99,42,54,'2016-04-13 12:37:54','Consulted for Procedure (stomach wash)','100.00',13,'1',51,'2016-04-13 02:08:16',51,'2016-04-13 02:08:16','0000-00-00 00:00:00'),(26,58,99,42,58,'2016-04-13 12:37:54','Consulted for Procedure (stomach wash)','100.00',13,'1',51,'2016-04-13 02:08:16',51,'2016-04-13 02:08:16','0000-00-00 00:00:00'),(27,58,99,42,56,'2016-04-13 15:55:00','test','200.00',0,'1',51,'2016-04-13 02:09:09',51,'2016-04-13 02:09:09','0000-00-00 00:00:00'),(28,58,101,42,56,'2016-04-23 09:49:32','Consulted for Procedure (stomach wash)','200.00',14,'1',51,'2016-04-22 23:19:48',51,'2016-04-22 23:19:48','0000-00-00 00:00:00'),(29,58,101,42,54,'2016-04-23 09:49:32','Consulted for Procedure (stomach wash)','100.00',14,'1',51,'2016-04-22 23:19:48',51,'2016-04-22 23:19:48','0000-00-00 00:00:00'),(30,58,105,34,54,'2016-04-14 14:30:00','2323','100.00',0,'1',51,'2016-04-28 04:33:32',51,'2016-04-28 04:33:32','0000-00-00 00:00:00'),(31,58,108,43,54,'2016-04-04 01:05:00','2','100.00',0,'1',51,'2016-04-30 09:12:40',51,'2016-04-30 09:12:40','0000-00-00 00:00:00'),(32,58,117,37,54,'2016-06-01 14:50:00','sdwds','100.00',0,'1',51,'2016-05-04 12:54:30',51,'2016-05-04 12:54:30','0000-00-00 00:00:00'),(33,58,122,46,56,'2016-05-03 05:25:00',NULL,'352.00',0,'1',51,'2016-05-04 23:46:55',51,'2016-05-04 23:46:55','0000-00-00 00:00:00'),(34,58,122,46,58,'2016-05-03 05:25:00',NULL,'100.00',0,'1',51,'2016-05-04 23:47:10',51,'2016-05-04 23:47:10','0000-00-00 00:00:00'),(35,58,126,46,54,'2016-05-07 13:22:12','Consulted for Procedure (stomach wash)','300.00',15,'1',51,'2016-05-07 02:52:20',51,'2016-05-07 02:52:20','0000-00-00 00:00:00'),(36,58,130,49,56,'2016-05-11 11:26:22','Consulted for Procedure (stomach wash)','352.00',16,'1',51,'2016-05-11 00:56:31',51,'2016-05-11 00:56:31','0000-00-00 00:00:00'),(37,58,128,46,54,'2016-04-30 22:35:00',NULL,'300.00',0,'1',51,'2016-05-23 23:44:52',51,'2016-05-23 23:44:52','0000-00-00 00:00:00'),(38,58,128,46,56,'2016-05-24 11:05:27','Consulted for Procedure (stomach wash)','352.00',17,'1',51,'2016-05-24 00:35:36',51,'2016-06-16 12:43:04','0000-00-00 00:00:00'),(39,58,128,46,58,'2016-06-16 23:13:20','Consulted for Procedure (stomach wash)','100.00',18,'1',51,'2016-06-16 12:43:43',51,'2016-06-16 12:43:43','0000-00-00 00:00:00'),(40,58,128,46,56,'2016-06-16 23:13:20','Consulted for Procedure (stomach wash)','352.00',18,'1',51,'2016-06-16 12:43:43',51,'2016-06-16 12:43:43','0000-00-00 00:00:00'),(41,58,128,46,54,'2016-06-16 23:13:20','Consulted for Procedure (stomach wash)','300.00',18,'1',51,'2016-06-16 12:43:43',51,'2016-06-16 12:43:43','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=latin1;

/*Data for the table `pat_encounter` */

insert  into `pat_encounter`(`encounter_id`,`tenant_id`,`patient_id`,`encounter_type`,`encounter_date`,`inactive_date`,`bill_no`,`finalize`,`authorize`,`discharge`,`casesheet_no`,`concession_amount`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,18,'OP','2016-02-16 00:00:00',NULL,NULL,0,0,0,'','0.00','1',51,'2016-02-16 06:31:03',51,'2016-02-16 06:31:03','0000-00-00 00:00:00'),(2,58,24,'OP','2016-02-17 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-02-17 00:18:11',51,'2016-02-17 07:51:17','0000-00-00 00:00:00'),(3,58,28,'OP','2016-02-17 00:00:00',NULL,NULL,0,0,0,'','0.00','1',51,'2016-02-17 01:15:34',51,'2016-02-17 01:15:34','0000-00-00 00:00:00'),(4,58,28,'OP','2016-02-17 00:00:00',NULL,NULL,0,0,0,'','0.00','1',51,'2016-02-17 01:27:48',51,'2016-02-17 01:27:48','0000-00-00 00:00:00'),(5,58,20,'OP','2016-02-17 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-02-17 02:54:27',51,'2016-02-17 06:59:09','0000-00-00 00:00:00'),(6,60,29,'OP','2016-02-17 00:00:00',NULL,NULL,0,0,0,'','0.00','0',59,'2016-02-17 06:34:19',59,'2016-02-20 06:11:08','0000-00-00 00:00:00'),(7,58,30,'OP','2016-02-17 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-02-17 06:42:33',51,'2016-02-17 06:49:37','0000-00-00 00:00:00'),(8,58,20,'OP','2016-02-17 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-02-17 07:07:13',51,'2016-03-03 22:31:18','0000-00-00 00:00:00'),(9,60,25,'OP','2016-02-17 00:00:00',NULL,NULL,0,0,0,'','0.00','1',59,'2016-02-17 07:29:20',59,'2016-02-17 07:29:20','0000-00-00 00:00:00'),(10,60,30,'OP','2016-02-18 00:00:00',NULL,NULL,0,0,0,'','0.00','0',59,'2016-02-17 07:29:52',59,'2016-02-19 23:23:58','0000-00-00 00:00:00'),(11,60,19,'OP','2016-02-17 00:00:00',NULL,NULL,0,0,0,'','0.00','1',59,'2016-02-17 07:34:52',59,'2016-02-17 07:34:52','0000-00-00 00:00:00'),(12,58,24,'OP','2016-02-17 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-02-17 07:57:52',51,'2016-02-17 07:58:09','0000-00-00 00:00:00'),(13,58,20,'OP','2016-02-18 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-02-17 22:41:36',51,'2016-03-03 22:31:47','0000-00-00 00:00:00'),(14,58,26,'OP','2016-02-18 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-02-17 22:42:12',51,'2016-02-29 06:18:36','0000-00-00 00:00:00'),(15,58,25,'OP','2016-02-18 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-02-17 23:05:03',51,'2016-04-04 23:30:13','0000-00-00 00:00:00'),(16,60,21,'OP','2016-02-18 00:00:00',NULL,NULL,0,0,0,'','0.00','0',59,'2016-02-17 23:07:13',59,'2016-02-17 23:21:15','0000-00-00 00:00:00'),(17,60,27,'OP','2016-02-18 00:00:00',NULL,NULL,0,0,0,'','0.00','1',59,'2016-02-17 23:14:58',59,'2016-02-17 23:14:58','0000-00-00 00:00:00'),(18,60,21,'OP','2016-02-18 00:00:00',NULL,NULL,0,0,0,'','0.00','1',59,'2016-02-17 23:21:46',59,'2016-02-17 23:21:46','0000-00-00 00:00:00'),(19,58,31,'OP','2016-02-18 00:00:00',NULL,NULL,0,0,0,'','0.00','1',51,'2016-02-18 04:50:00',51,'2016-02-18 04:50:00','0000-00-00 00:00:00'),(20,58,32,'OP','2016-02-19 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-02-19 00:47:36',51,'2016-04-30 09:09:38','0000-00-00 00:00:00'),(21,60,33,'OP','2016-02-19 00:00:00',NULL,NULL,0,0,0,'','0.00','0',59,'2016-02-19 00:52:08',59,'2016-02-19 01:40:56','0000-00-00 00:00:00'),(22,60,33,'OP','2016-02-19 00:00:00',NULL,NULL,0,0,0,'','0.00','0',59,'2016-02-19 01:41:20',59,'2016-02-19 02:08:16','0000-00-00 00:00:00'),(23,60,33,'OP','2016-02-19 00:00:00',NULL,NULL,0,0,0,'','0.00','0',59,'2016-02-19 02:08:47',59,'2016-02-20 04:51:34','0000-00-00 00:00:00'),(24,58,34,'OP','2016-02-19 00:00:00',NULL,NULL,0,0,0,'','0.00','0',62,'2016-02-19 07:19:03',62,'2016-02-19 07:19:35','0000-00-00 00:00:00'),(25,58,34,'OP','2016-02-19 00:00:00',NULL,NULL,0,0,0,'','0.00','0',62,'2016-02-19 07:21:43',62,'2016-02-19 07:23:36','0000-00-00 00:00:00'),(26,58,34,'OP','2016-02-19 00:00:00',NULL,NULL,0,0,0,'','0.00','0',62,'2016-02-19 07:25:56',62,'2016-02-20 01:22:50','0000-00-00 00:00:00'),(27,60,30,'OP','2016-02-20 00:00:00',NULL,NULL,0,0,0,'','0.00','0',59,'2016-02-19 23:25:13',59,'2016-02-19 23:30:02','0000-00-00 00:00:00'),(28,60,30,'OP','2016-02-20 00:00:00',NULL,NULL,0,0,0,'','0.00','0',59,'2016-02-19 23:30:52',66,'2016-02-20 05:17:32','0000-00-00 00:00:00'),(29,58,34,'OP','2016-02-20 00:00:00',NULL,NULL,0,0,0,'','0.00','0',62,'2016-02-20 01:23:02',62,'2016-02-20 03:41:39','0000-00-00 00:00:00'),(30,60,35,'OP','2016-02-20 00:00:00',NULL,NULL,0,0,0,'','0.00','0',59,'2016-02-20 03:32:49',59,'2016-02-20 03:34:28','0000-00-00 00:00:00'),(31,58,34,'OP','2016-02-20 00:00:00',NULL,NULL,0,0,0,'','0.00','0',62,'2016-02-20 03:52:56',62,'2016-02-20 04:08:40','0000-00-00 00:00:00'),(32,58,34,'OP','2016-02-20 00:00:00',NULL,NULL,0,0,0,'','0.00','0',62,'2016-02-20 04:44:16',62,'2016-02-20 04:49:34','0000-00-00 00:00:00'),(33,60,29,'OP','2016-02-20 00:00:00',NULL,NULL,0,0,0,'','0.00','1',59,'2016-02-20 06:11:30',59,'2016-02-20 06:11:30','0000-00-00 00:00:00'),(34,60,33,'OP','2016-02-20 00:00:00',NULL,NULL,0,0,0,'','0.00','0',59,'2016-02-20 06:14:45',59,'2016-02-20 06:16:29','0000-00-00 00:00:00'),(35,60,33,'OP','2016-02-20 00:00:00',NULL,NULL,0,0,0,'','0.00','0',59,'2016-02-20 06:30:15',59,'2016-02-20 06:31:16','0000-00-00 00:00:00'),(36,60,33,'IP','2016-02-20 18:01:24',NULL,NULL,0,0,0,'','0.00','0',59,'2016-02-20 06:31:36',59,'2016-02-20 06:35:01','0000-00-00 00:00:00'),(37,60,33,'IP','2016-02-20 18:14:26',NULL,NULL,0,0,0,'','0.00','0',59,'2016-02-20 06:44:38',59,'2016-02-20 06:48:56','0000-00-00 00:00:00'),(38,60,33,'IP','2016-02-20 18:21:27',NULL,NULL,0,0,0,'','0.00','0',59,'2016-02-20 06:51:37',59,'2016-02-20 08:20:10','0000-00-00 00:00:00'),(39,60,35,'IP','2016-02-20 18:35:42',NULL,NULL,0,0,0,'','0.00','1',59,'2016-02-20 07:05:54',59,'2016-02-20 07:05:54','0000-00-00 00:00:00'),(40,60,34,'IP','2016-02-20 18:52:46',NULL,NULL,0,0,0,'','0.00','0',66,'2016-02-20 07:23:01',66,'2016-02-20 07:23:34','0000-00-00 00:00:00'),(41,60,34,'IP','2016-02-20 19:20:28',NULL,NULL,0,0,0,'','0.00','0',66,'2016-02-20 07:50:48',66,'2016-02-20 07:51:08','0000-00-00 00:00:00'),(42,60,33,'OP','2016-02-22 00:00:00',NULL,NULL,0,0,0,'','0.00','0',59,'2016-02-21 22:48:54',59,'2016-02-21 22:49:58','0000-00-00 00:00:00'),(43,60,33,'IP','2016-02-22 10:20:06',NULL,NULL,0,0,0,'','0.00','1',59,'2016-02-21 22:50:16',59,'2016-02-21 22:50:16','0000-00-00 00:00:00'),(44,61,36,'OP','2016-02-27 00:00:00',NULL,NULL,0,0,0,'','0.00','0',67,'2016-02-21 23:35:47',67,'2016-02-21 23:48:00','0000-00-00 00:00:00'),(45,61,36,'OP','2016-02-22 00:00:00',NULL,NULL,0,0,0,'','0.00','0',67,'2016-02-21 23:38:22',67,'2016-02-21 23:49:13','0000-00-00 00:00:00'),(46,61,36,'OP','2016-02-23 00:00:00',NULL,NULL,0,0,0,'','0.00','0',67,'2016-02-21 23:50:08',67,'2016-02-21 23:51:02','0000-00-00 00:00:00'),(47,61,36,'OP','2016-03-05 00:00:00',NULL,NULL,0,0,0,'','0.00','0',67,'2016-02-21 23:51:51',67,'2016-02-22 00:31:30','0000-00-00 00:00:00'),(48,61,36,'OP','2016-02-26 00:00:00',NULL,NULL,0,0,0,'','0.00','0',67,'2016-02-21 23:52:41',67,'2016-02-22 00:31:53','0000-00-00 00:00:00'),(49,61,30,'OP','2016-02-22 00:00:00',NULL,NULL,0,0,0,'','0.00','0',67,'2016-02-21 23:57:20',67,'2016-02-25 01:39:43','0000-00-00 00:00:00'),(50,58,37,'OP','2016-02-22 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-02-22 02:32:54',51,'2016-02-22 02:34:21','0000-00-00 00:00:00'),(51,58,37,'IP','2016-02-22 14:04:36',NULL,NULL,0,0,0,'','0.00','0',51,'2016-02-22 02:35:00',51,'2016-02-22 02:44:41','0000-00-00 00:00:00'),(52,58,37,'OP','2016-02-22 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-02-22 02:44:53',51,'2016-02-22 02:47:03','0000-00-00 00:00:00'),(53,58,37,'OP','2016-02-22 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-02-22 02:49:10',51,'2016-02-22 03:02:18','0000-00-00 00:00:00'),(54,58,37,'IP','2016-02-22 14:32:20',NULL,NULL,0,0,0,'','0.00','0',51,'2016-02-22 03:02:39',51,'2016-02-22 06:34:32','0000-00-00 00:00:00'),(55,61,36,'IP','2016-02-23 16:49:16',NULL,NULL,0,0,0,'','0.00','1',67,'2016-02-23 05:19:43',67,'2016-02-23 05:19:43','0000-00-00 00:00:00'),(56,61,30,'OP','2016-02-25 00:00:00',NULL,NULL,0,0,0,'','0.00','0',67,'2016-02-25 01:42:49',67,'2016-02-25 04:56:24','0000-00-00 00:00:00'),(57,61,30,'OP','2016-02-25 00:00:00',NULL,NULL,0,0,0,'','0.00','0',67,'2016-02-25 01:43:14',67,'2016-02-25 04:56:55','0000-00-00 00:00:00'),(58,61,30,'OP','2016-02-25 00:00:00',NULL,NULL,0,0,0,'','0.00','1',67,'2016-02-25 05:09:56',67,'2016-02-25 05:09:56','0000-00-00 00:00:00'),(59,61,24,'IP','2016-02-25 16:58:08',NULL,NULL,0,0,0,'','0.00','0',67,'2016-02-25 05:28:29',67,'2016-02-25 05:30:03','0000-00-00 00:00:00'),(60,61,24,'IP','2016-02-25 17:07:55',NULL,NULL,0,0,0,'','0.00','1',67,'2016-02-25 05:38:13',67,'2016-02-25 05:38:13','0000-00-00 00:00:00'),(61,58,38,'OP','2016-02-25 00:00:00',NULL,NULL,0,0,0,'','0.00','0',63,'2016-02-25 07:13:43',51,'2016-05-13 06:22:56','0000-00-00 00:00:00'),(62,58,20,'IP','2016-03-04 10:01:51',NULL,NULL,0,0,0,'','0.00','0',51,'2016-03-03 22:32:11',51,'2016-03-03 23:01:33','0000-00-00 00:00:00'),(63,58,20,'OP','2016-03-04 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-03-03 23:02:09',51,'2016-03-12 03:40:03','0000-00-00 00:00:00'),(64,58,34,'IP','2016-03-04 12:38:02',NULL,NULL,0,0,0,'','0.00','0',51,'2016-03-04 01:09:27',51,'2016-03-23 05:08:28','0000-00-00 00:00:00'),(65,58,39,'OP','2016-03-04 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-03-04 01:17:45',51,'2016-03-04 01:18:04','0000-00-00 00:00:00'),(66,58,20,'OP','2016-03-12 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-03-12 03:40:25',51,'2016-03-12 04:33:10','0000-00-00 00:00:00'),(67,58,20,'OP','2016-03-12 00:00:00',NULL,NULL,0,0,0,'AXNWLEJ123','0.00','0',51,'2016-03-12 04:34:23',51,'2016-03-12 04:47:02','0000-00-00 00:00:00'),(68,58,40,'OP','2016-03-17 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-03-14 02:28:07',51,'2016-03-15 05:10:39','0000-00-00 00:00:00'),(69,58,41,'OP','2016-03-14 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-03-14 03:02:26',51,'2016-05-11 13:20:13','0000-00-00 00:00:00'),(70,58,42,'OP','2016-03-14 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-03-14 03:03:44',51,'2016-04-01 23:57:19','0000-00-00 00:00:00'),(71,58,43,'OP','2016-03-14 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-03-14 05:18:28',51,'2016-04-30 09:08:26','0000-00-00 00:00:00'),(72,58,20,'OP','2016-03-16 00:00:00',NULL,NULL,0,0,0,'AXNWLEJ123','0.00','0',51,'2016-03-15 00:39:12',51,'2016-03-15 00:40:21','0000-00-00 00:00:00'),(73,58,40,'OP','2016-03-16 00:00:00',NULL,NULL,0,0,0,'','0.00','1',51,'2016-03-16 09:12:00',51,'2016-03-16 09:12:00','0000-00-00 00:00:00'),(74,58,40,'OP','2016-03-16 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-03-16 09:17:56',51,'2016-04-30 09:07:41','0000-00-00 00:00:00'),(75,58,28,'OP','2016-03-17 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-03-17 03:26:20',51,'2016-05-04 12:31:53','0000-00-00 00:00:00'),(76,58,20,'OP','2016-03-21 00:00:00',NULL,NULL,0,0,0,'AXNWLEJ123','0.00','0',51,'2016-03-21 02:15:50',51,'2016-04-04 00:12:48','0000-00-00 00:00:00'),(77,58,20,'OP','2016-03-21 00:00:00',NULL,NULL,0,0,0,'AXNWLEJ123','0.00','0',51,'2016-03-21 02:16:55',51,'2016-04-04 00:12:59','0000-00-00 00:00:00'),(78,58,20,'OP','2016-03-21 00:00:00',NULL,NULL,0,0,0,'AXNWLEJ123','0.00','0',51,'2016-03-21 02:18:50',51,'2016-04-04 00:20:00','0000-00-00 00:00:00'),(79,58,39,'OP','2016-03-21 00:00:00',NULL,NULL,0,0,0,'','0.00','1',51,'2016-03-21 02:59:07',51,'2016-03-21 02:59:07','0000-00-00 00:00:00'),(80,58,39,'OP','2016-03-21 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-03-21 03:00:04',51,'2016-04-30 08:55:52','0000-00-00 00:00:00'),(81,58,26,'OP','2016-03-21 00:00:00',NULL,NULL,0,0,0,'','0.00','1',51,'2016-03-21 03:02:41',51,'2016-03-21 03:02:41','0000-00-00 00:00:00'),(82,58,26,'OP','2016-03-21 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-03-21 03:04:39',51,'2016-05-02 04:52:17','0000-00-00 00:00:00'),(83,58,37,'OP','2016-03-22 00:00:00',NULL,NULL,0,0,0,'A','0.00','0',51,'2016-03-22 01:57:48',51,'2016-03-22 01:59:20','0000-00-00 00:00:00'),(84,58,37,'OP','2016-03-23 00:00:00',NULL,NULL,0,0,0,'A','0.00','0',51,'2016-03-23 04:56:08',51,'2016-03-23 05:02:33','0000-00-00 00:00:00'),(85,58,34,'IP','2016-03-23 15:38:31',NULL,NULL,0,0,0,'AUCPG123','0.00','0',51,'2016-03-23 05:08:56',51,'2016-03-23 05:09:08','0000-00-00 00:00:00'),(86,58,22,'IP','2016-03-23 16:22:00',NULL,NULL,0,0,0,'158510','0.00','0',62,'2016-03-23 05:52:12',51,'2016-03-31 23:25:48','0000-00-00 00:00:00'),(87,58,34,'OP','2016-03-24 00:00:00',NULL,NULL,0,0,0,'AUCPG123','0.00','0',51,'2016-03-24 07:23:35',51,'2016-03-24 07:41:51','0000-00-00 00:00:00'),(88,58,44,'IP','2016-03-31 12:25:43',NULL,NULL,0,0,0,'AUC12345','0.00','0',51,'2016-03-31 01:58:09',51,'2016-03-31 02:01:20','0000-00-00 00:00:00'),(89,58,44,'IP','2016-03-31 12:31:23',NULL,NULL,0,0,0,'AUC12345','0.00','0',51,'2016-03-31 02:01:35',51,'2016-03-31 02:08:30','0000-00-00 00:00:00'),(90,58,44,'OP','2016-03-31 00:00:00',NULL,NULL,0,0,0,'AUC12345','0.00','0',51,'2016-03-31 02:09:01',51,'2016-03-31 02:09:23','0000-00-00 00:00:00'),(91,58,44,'IP','2016-03-31 12:40:29',NULL,NULL,0,0,0,'AUC12345','0.00','0',51,'2016-03-31 02:10:40',51,'2016-03-31 02:11:58','0000-00-00 00:00:00'),(92,58,44,'OP','2016-03-31 00:00:00',NULL,NULL,0,0,0,'AUC12345','0.00','1',51,'2016-03-31 02:12:05',51,'2016-03-31 02:12:05','0000-00-00 00:00:00'),(93,58,34,'OP','2016-03-31 00:00:00',NULL,NULL,0,0,0,'111111','0.00','0',51,'2016-03-31 05:02:18',51,'2016-03-31 06:14:03','0000-00-00 00:00:00'),(94,58,22,'OP','2016-04-01 00:00:00',NULL,NULL,0,0,0,'1111','0.00','1',51,'2016-03-31 23:26:22',51,'2016-03-31 23:26:22','0000-00-00 00:00:00'),(95,58,22,'OP','2016-04-01 00:00:00',NULL,NULL,0,0,0,'1111','0.00','1',51,'2016-03-31 23:27:23',51,'2016-03-31 23:27:23','0000-00-00 00:00:00'),(96,58,20,'IP','2016-04-04 10:50:05',NULL,NULL,0,0,0,'AXNWLEJ123','0.00','0',51,'2016-04-04 00:20:20',51,'2016-04-04 00:21:28','0000-00-00 00:00:00'),(97,58,20,'IP','2016-04-04 15:44:32',NULL,NULL,51,51,0,'AXNWLEJ123','10.00','0',51,'2016-04-04 05:14:40',51,'2016-04-06 04:41:06','0000-00-00 00:00:00'),(98,58,37,'IP','2016-04-05 10:53:56',NULL,NULL,51,51,51,'A','1000000.00','0',51,'2016-04-05 00:24:10',51,'2016-04-26 04:43:14','0000-00-00 00:00:00'),(99,58,42,'IP','2016-04-13 12:34:39',NULL,NULL,0,0,0,'233232','300.00','0',51,'2016-04-13 02:05:01',51,'2016-04-15 05:08:51','0000-00-00 00:00:00'),(100,58,42,'IP','2016-04-16 11:55:00',NULL,NULL,0,0,0,'233232','300.00','0',51,'2016-04-15 06:35:58',51,'2016-04-22 23:15:03','0000-00-00 00:00:00'),(101,58,42,'IP','2016-04-23 09:49:11',NULL,NULL,51,51,51,'233232','0.00','0',51,'2016-04-22 23:19:20',51,'2016-04-25 04:22:44','0000-00-00 00:00:00'),(102,58,42,'IP','2016-04-25 14:52:51',NULL,NULL,51,51,51,'233232','0.00','0',51,'2016-04-25 04:28:24',51,'2016-04-25 04:40:33','0000-00-00 00:00:00'),(103,58,42,'OP','2016-04-25 00:00:00',NULL,NULL,0,0,0,'233232','11000.00','0',51,'2016-04-25 04:41:22',51,'2016-04-30 08:55:23','0000-00-00 00:00:00'),(104,58,20,'OP','2016-04-26 00:00:00',NULL,NULL,0,0,0,'AXNWLEJ123','100.00','0',51,'2016-04-26 04:58:05',51,'2016-05-02 04:39:02','0000-00-00 00:00:00'),(105,58,34,'IP','2016-04-27 17:11:09',NULL,NULL,51,51,51,'111111','8000.00','0',51,'2016-04-27 06:41:59',51,'2016-05-04 04:57:54','0000-00-00 00:00:00'),(106,58,37,'OP','2016-04-28 00:00:00',NULL,NULL,0,0,0,'A','0.00','0',51,'2016-04-28 00:55:17',51,'2016-05-02 06:02:16','0000-00-00 00:00:00'),(107,58,42,'OP','2016-04-30 00:00:00',NULL,NULL,0,0,0,'233232','0.00','0',51,'2016-04-30 08:56:33',51,'2016-05-11 13:17:47','0000-00-00 00:00:00'),(108,58,43,'OP','2016-04-30 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-04-30 09:08:42',51,'2016-04-30 09:13:26','0000-00-00 00:00:00'),(109,58,32,'OP','2016-04-30 00:00:00',NULL,NULL,0,0,0,'','0.00','1',51,'2016-04-30 09:10:26',51,'2016-04-30 09:10:26','0000-00-00 00:00:00'),(110,58,20,'OP','2016-05-02 00:00:00',NULL,NULL,0,0,0,'AXNWLEJ123','0.00','0',51,'2016-05-02 04:39:46',51,'2016-05-02 04:40:50','0000-00-00 00:00:00'),(111,58,20,'OP','2016-05-02 00:00:00',NULL,NULL,0,0,0,'AXNWLEJ123','0.00','0',51,'2016-05-02 04:43:21',51,'2016-05-02 04:44:11','0000-00-00 00:00:00'),(112,58,20,'OP','2016-05-02 00:00:00',NULL,NULL,0,0,0,'AXNWLEJ123','0.00','0',51,'2016-05-02 04:46:48',51,'2016-05-02 04:47:12','0000-00-00 00:00:00'),(113,58,20,'OP','2016-05-02 00:00:00',NULL,NULL,0,0,0,'AXNWLEJ123','0.00','0',51,'2016-05-02 04:49:45',51,'2016-05-02 04:50:22','0000-00-00 00:00:00'),(114,58,46,'OP','2016-05-03 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-05-02 05:13:07',51,'2016-05-02 05:13:25','0000-00-00 00:00:00'),(115,58,46,'IP','2016-05-02 15:44:51',NULL,NULL,51,51,51,'11111','0.00','0',51,'2016-05-02 05:15:14',51,'2016-05-02 05:33:28','0000-00-00 00:00:00'),(116,58,46,'IP','2016-05-02 16:03:49',NULL,NULL,51,51,51,'11111','0.00','0',51,'2016-05-02 05:34:03',51,'2016-05-02 06:51:31','0000-00-00 00:00:00'),(117,58,37,'IP','2016-05-02 16:32:26',NULL,NULL,0,0,0,'A','360.00','1',51,'2016-05-02 06:02:38',51,'2016-05-04 12:52:53','0000-00-00 00:00:00'),(118,58,46,'OP','2016-05-02 00:00:00',NULL,NULL,0,0,0,'11111','0.00','0',51,'2016-05-02 08:16:47',51,'2016-05-02 08:18:07','0000-00-00 00:00:00'),(119,58,46,'OP','2016-05-17 00:00:00',NULL,NULL,0,0,0,'11111','0.00','0',51,'2016-05-02 08:18:26',51,'2016-05-02 08:20:08','0000-00-00 00:00:00'),(120,58,34,'OP','2016-05-04 00:00:00',NULL,NULL,0,0,0,'111111','0.00','0',51,'2016-05-04 05:02:57',51,'2016-05-04 05:03:25','0000-00-00 00:00:00'),(121,58,34,'IP','2016-05-04 16:27:43',NULL,NULL,0,0,0,'111111','0.00','0',51,'2016-05-04 05:57:56',51,'2016-05-24 03:28:40','0000-00-00 00:00:00'),(122,58,46,'IP','2016-05-04 23:00:00',NULL,NULL,51,51,51,'11111','0.00','0',51,'2016-05-04 12:35:24',51,'2016-05-05 23:55:43','0000-00-00 00:00:00'),(123,58,45,'OP','2016-05-04 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-05-04 12:38:42',51,'2016-05-04 12:39:08','0000-00-00 00:00:00'),(124,58,45,'OP','2016-05-04 00:00:00',NULL,NULL,0,0,0,'','0.00','1',51,'2016-05-04 12:42:40',51,'2016-05-04 12:42:40','0000-00-00 00:00:00'),(125,58,46,'OP','2016-05-06 00:00:00',NULL,NULL,0,0,0,'111ABC','0.00','0',51,'2016-05-05 23:56:21',51,'2016-05-05 23:57:40','0000-00-00 00:00:00'),(126,58,46,'IP','2016-05-06 10:28:42',NULL,NULL,51,51,51,'111ABC','0.00','0',51,'2016-05-05 23:59:00',51,'2016-05-10 08:07:26','0000-00-00 00:00:00'),(127,58,20,'OP','2016-05-07 00:00:00',NULL,NULL,0,0,0,'AXNWLEJ123','0.00','1',51,'2016-05-07 04:54:42',51,'2016-05-07 04:54:42','0000-00-00 00:00:00'),(128,58,46,'IP','2016-05-09 01:05:00',NULL,NULL,0,0,0,'111ABC','30000.00','1',51,'2016-05-10 08:11:19',51,'2016-05-23 23:50:18','0000-00-00 00:00:00'),(129,58,49,'OP','2016-05-11 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-05-11 00:53:17',51,'2016-05-11 00:54:15','0000-00-00 00:00:00'),(130,58,49,'OP','2016-05-11 00:00:00',NULL,NULL,0,0,0,'','0.00','0',51,'2016-05-11 00:56:00',51,'2016-05-11 05:08:20','0000-00-00 00:00:00'),(131,58,42,'OP','2016-05-11 00:00:00',NULL,NULL,0,0,0,'233232','0.00','1',51,'2016-05-11 13:18:28',51,'2016-05-11 13:18:28','0000-00-00 00:00:00'),(132,58,50,'OP','2016-05-13 00:00:00',NULL,NULL,0,0,0,'','0.00','1',51,'2016-05-13 06:16:47',51,'2016-05-13 06:16:47','0000-00-00 00:00:00'),(133,58,23,'OP','2016-05-20 00:00:00',NULL,NULL,0,0,0,'','0.00','1',51,'2016-05-20 05:19:26',51,'2016-05-20 05:19:26','0000-00-00 00:00:00'),(134,58,18,'OP','2016-05-27 00:00:00',NULL,NULL,0,0,0,'','0.00','1',51,'2016-05-20 07:05:57',51,'2016-05-20 07:05:57','0000-00-00 00:00:00'),(135,58,51,'OP','2016-05-24 00:00:00',NULL,NULL,0,0,0,'AHA9001','0.00','0',51,'2016-05-23 23:23:07',51,'2016-05-23 23:27:06','0000-00-00 00:00:00'),(136,58,51,'OP','2016-05-24 00:00:00',NULL,NULL,0,0,0,'AHA9001','0.00','0',51,'2016-05-23 23:27:21',51,'2016-05-23 23:27:46','0000-00-00 00:00:00'),(137,58,51,'OP','2016-05-24 00:00:00',NULL,NULL,0,0,0,'AHA9001','0.00','0',51,'2016-05-23 23:27:58',51,'2016-05-23 23:28:35','0000-00-00 00:00:00'),(138,58,51,'OP','2016-05-24 00:00:00',NULL,NULL,0,0,0,'AHA9001','0.00','0',51,'2016-05-23 23:28:45',51,'2016-05-23 23:29:45','0000-00-00 00:00:00'),(139,58,51,'OP','2016-05-24 00:00:00',NULL,NULL,0,0,0,'AHA9001','0.00','1',51,'2016-05-23 23:30:07',51,'2016-05-23 23:30:07','0000-00-00 00:00:00'),(140,58,47,'OP','2016-05-24 00:00:00',NULL,NULL,0,0,0,'AHA60001','0.00','1',51,'2016-05-23 23:30:44',51,'2016-05-23 23:30:44','0000-00-00 00:00:00'),(141,58,34,'IP','2016-05-24 13:58:43',NULL,'AH0000012',0,0,0,'111','0.00','0',51,'2016-05-24 03:28:58',51,'2016-05-24 03:33:56','0000-00-00 00:00:00'),(142,58,34,'IP','2016-05-24 14:04:03',NULL,'AH0000013',0,0,0,'111','840.00','1',51,'2016-05-24 03:34:14',51,'2016-05-30 12:17:59','0000-00-00 00:00:00'),(143,58,52,'OP','2016-05-31 00:00:00',NULL,NULL,0,0,0,'AHA5006','0.00','1',51,'2016-05-31 00:21:59',51,'2016-05-31 00:21:59','0000-00-00 00:00:00'),(144,58,53,'OP','2016-05-31 00:00:00',NULL,NULL,0,0,0,'AHA4002','0.00','1',51,'2016-05-31 00:25:32',51,'2016-05-31 00:25:32','0000-00-00 00:00:00'),(145,58,54,'OP','2016-06-06 00:00:00',NULL,NULL,0,0,0,'UVW12345','0.00','0',51,'2016-06-06 05:12:14',51,'2016-06-06 05:28:33','0000-00-00 00:00:00'),(146,58,55,'OP','2016-06-06 00:00:00',NULL,NULL,0,0,0,'DSS3434','0.00','1',51,'2016-06-06 05:20:53',51,'2016-06-06 05:20:53','0000-00-00 00:00:00'),(147,58,56,'OP','2016-06-09 00:00:00',NULL,NULL,0,0,0,'ADBN2300','0.00','0',51,'2016-06-09 00:04:09',51,'2016-06-09 00:22:41','0000-00-00 00:00:00'),(148,58,57,'OP','2016-06-11 00:00:00',NULL,NULL,0,0,0,'opopop','0.00','1',51,'2016-06-11 05:00:52',51,'2016-06-11 05:00:52','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

/*Data for the table `pat_notes` */

insert  into `pat_notes`(`pat_note_id`,`tenant_id`,`encounter_id`,`patient_id`,`notes`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,5,20,'Testtt','1',51,'2016-02-17 05:26:01',51,'2016-02-17 05:26:01','0000-00-00 00:00:00'),(2,58,5,20,'aa dddd aaaa','1',51,'2016-02-17 06:58:36',51,'2016-02-17 06:58:36','0000-00-00 00:00:00'),(3,60,6,29,'need to check doppler for pulse','1',59,'2016-02-18 00:32:43',59,'2016-02-18 00:33:30','0000-00-00 00:00:00'),(4,58,54,37,'rfreferfr yhy6hy yhy6h rfreferfr yhy6hy yhy6h rfreferfr yhy6hy yhy6h rfreferfr yhy6hy yhy6hrfreferfr yhy6hy yhy6hrfreferfr yhy6hy yhy6hrfreferfr yhy6hy yhy6hrfreferfr yhy6hy yhy6h a\n\nA\n A\n\nDA\nasd\nda\n\nasd\n\nas\nda\nsd\na\ns\nad\n\nas\nd\nas\nd\nasd\nas\nd\nas\ndas\n\nddas\n\ndsa\nasd\nasd\nf\nasdf\nasd\nf\nasd\nffsda\nd','1',51,'2016-02-22 03:10:05',51,'2016-04-17 01:26:34','0000-00-00 00:00:00'),(5,61,56,30,'test assdffhs sdafhdsafghggh asdkfnjkasdhhfi kasdfjkashdf  jashkksdfk k saasjkhfasdhhjsad h asjdfkasfuihsa kssffhaskdhfjshf sdfkasjdhfjkash hkjahdfkjhsdkf assjkhh kasdhfkhsdafhsdjff  jshhiasdjhfaskj asdmbfnasdb ashfa dhs asddjsadf  s asdjfasdj \nasdfj;asdfj;lasjf\nsadf jsadlfkasdljf\nasdffjasdj klasd\nsadkfjlkasdjflkasj lka jlkjsjdkjfasdjflasdj jasd\ndsfakjasdlkkj askdjjllasd\nasdkf lkasdjfs askfh asdjfaks jkasdjasd\nasdkfjaskdl jassd\nasdfkjkasdk \nasjdasfkjdaslfjads\nasdjf \nasdf','1',67,'2016-02-25 01:57:32',67,'2016-02-25 01:58:28','0000-00-00 00:00:00'),(6,58,86,22,'34343343','1',51,'2016-03-24 07:16:00',51,'2016-03-24 07:16:00','0000-00-00 00:00:00'),(7,58,71,43,'test','1',51,'2016-04-05 05:08:15',51,'2016-04-05 05:08:15','0000-00-00 00:00:00'),(8,58,98,37,'Hello All','1',51,'2016-04-28 00:54:19',51,'2016-04-28 00:54:19','0000-00-00 00:00:00'),(9,58,105,34,'hi','1',51,'2016-04-28 07:45:04',51,'2016-04-28 07:45:04','0000-00-00 00:00:00'),(10,58,126,46,'recovering','1',51,'2016-05-06 00:01:46',51,'2016-05-06 00:01:46','0000-00-00 00:00:00'),(11,58,130,49,'dfsgsdfgsdf','1',51,'2016-05-11 00:56:06',51,'2016-05-11 00:56:06','0000-00-00 00:00:00'),(12,58,128,46,'cfcf','1',51,'2016-05-12 05:30:34',51,'2016-05-20 06:11:05','0000-00-00 00:00:00'),(13,58,142,34,'hello','1',51,'2016-06-15 04:25:16',51,'2016-06-15 04:25:16','0000-00-00 00:00:00'),(14,58,142,34,'vinoth','1',51,'2016-06-15 04:25:28',51,'2016-06-15 04:25:28','0000-00-00 00:00:00'),(15,58,128,46,'testdffddf','1',51,'2016-06-16 12:26:01',51,'2016-06-16 12:35:23','0000-00-00 00:00:00'),(16,58,128,46,'sddsd','1',51,'2016-06-16 12:40:05',51,'2016-06-16 12:40:05','0000-00-00 00:00:00'),(17,58,128,46,'asdfsadfdsaf','1',51,'2016-06-16 12:40:11',51,'2016-06-16 12:40:11','0000-00-00 00:00:00'),(18,58,128,46,'sdfsadfsadf','1',51,'2016-06-16 12:40:15',51,'2016-06-16 12:40:15','0000-00-00 00:00:00'),(19,58,128,46,'sadfasdfdasf','1',51,'2016-06-16 12:40:20',51,'2016-06-16 12:40:20','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

/*Data for the table `pat_patient` */

insert  into `pat_patient`(`patient_id`,`patient_guid`,`casesheetno`,`patient_int_code`,`tenant_id`,`patient_reg_date`,`patient_title_code`,`patient_firstname`,`patient_lastname`,`patient_relation_code`,`patient_relation_name`,`patient_care_taker`,`patient_care_taker_name`,`patient_dob`,`patient_gender`,`patient_marital_status`,`patient_occupation`,`patient_blood_group`,`patient_category_id`,`patient_email`,`patient_reg_mode`,`patient_type`,`patient_ref_hospital`,`patient_ref_id`,`patient_mobile`,`patient_bill_type`,`patient_image`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (18,'a7a0e519-73e7-5494-a4db-e53b12fa291d',NULL,'AH0000018',58,'2016-02-16 06:30:51','Mr.','George','Mike',NULL,NULL,NULL,NULL,'1977-08-09','M',NULL,NULL,NULL,4,NULL,'OP',NULL,NULL,NULL,'9856145115','N',NULL,'1',51,'2016-02-16 06:30:51',51,'2016-02-16 06:30:51','0000-00-00 00:00:00'),(19,'7fc6a659-f2b4-5ca3-bdfc-73ec118ac5d1',NULL,'AH0000019',58,'2016-02-16 22:07:14','Miss.','Gayatri','S',NULL,NULL,NULL,NULL,'2001-01-01','F','M',NULL,NULL,6,NULL,'OP',NULL,NULL,NULL,'9898989898','N',NULL,'1',51,'2016-02-16 22:07:14',51,'2016-02-17 02:41:37','0000-00-00 00:00:00'),(20,'67d1e40d-dd8b-595f-8e72-8d2d5d642cce',NULL,'AH0000020',58,'2016-02-16 22:10:56','Mr.','Rahul','S',NULL,NULL,NULL,NULL,'1993-06-03','M',NULL,NULL,NULL,4,NULL,'IP',NULL,NULL,NULL,'676767676','N',NULL,'1',51,'2016-02-16 22:10:56',51,'2016-02-16 22:10:56','0000-00-00 00:00:00'),(21,'733b973b-dbde-588b-beab-bbb7eb827fe5',NULL,'AH0000021',58,'2016-02-16 22:15:06','Mr.','Brendan','Fraiser',NULL,NULL,NULL,NULL,'1981-08-25','M',NULL,NULL,NULL,5,NULL,'NO',NULL,NULL,NULL,'823423451243','N',NULL,'1',51,'2016-02-16 22:15:06',51,'2016-02-16 22:15:06','0000-00-00 00:00:00'),(22,'47197d1b-6f58-53a7-a33d-982b4e28c3c9',NULL,'AH0000022',58,'2016-02-17 00:14:58','Mr.','sdf','asdf',NULL,NULL,NULL,NULL,'2003-03-31','M',NULL,NULL,NULL,4,NULL,'OP',NULL,NULL,NULL,'1112121212','N',NULL,'1',51,'2016-02-17 00:14:58',51,'2016-03-31 01:52:49','0000-00-00 00:00:00'),(23,'561369b0-198f-552b-a7fb-fbb253abd8b3',NULL,'AH0000023',58,'2016-02-17 00:15:03','Mr.','sdf','asdf',NULL,NULL,NULL,NULL,'2016-02-01','M',NULL,NULL,NULL,4,NULL,'OP',NULL,NULL,NULL,'234234234','N',NULL,'1',51,'2016-02-17 00:15:03',51,'2016-02-17 00:15:03','0000-00-00 00:00:00'),(24,'648af167-5aaa-5b7a-b86b-43681c64bc2f',NULL,'AH0000024',58,'2016-02-17 00:17:40','Mr.','Test','test',NULL,NULL,NULL,NULL,'2016-02-17','M',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'23213123123',NULL,NULL,'1',51,'2016-02-17 00:17:40',51,'2016-02-17 00:17:40','0000-00-00 00:00:00'),(25,'75e7dc21-f072-535d-8b92-c2f0cf925e09',NULL,'AH0000025',58,'2016-02-17 00:20:10','Miss.','Radha','Ram',NULL,NULL,NULL,NULL,'2016-02-17','F',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'3423242349',NULL,NULL,'1',51,'2016-02-17 00:20:10',51,'2016-03-21 04:49:04','0000-00-00 00:00:00'),(26,'10d8bbb6-ceb9-5fa1-8081-4c267a88d3e1',NULL,'AH0000026',58,'2016-02-17 00:21:54','Mr.','rajesh','s',NULL,NULL,NULL,NULL,'2016-02-17','F',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'2342342',NULL,NULL,'1',51,'2016-02-17 00:21:54',51,'2016-02-17 00:21:54','0000-00-00 00:00:00'),(27,'ac0bb59b-7035-5e0a-a2c0-94b0526f0b0a',NULL,'AH0000027',58,'2016-02-17 00:24:22','Mr.','meena','k',NULL,NULL,NULL,NULL,'2016-02-17','F',NULL,NULL,NULL,6,NULL,'OP',NULL,NULL,NULL,'234234234',NULL,NULL,'1',51,'2016-02-17 00:24:22',51,'2016-02-17 00:24:22','0000-00-00 00:00:00'),(28,'55afd83b-e251-5849-a3dc-eff6022b8d4b',NULL,'AH0000028',58,'2016-02-17 01:13:02','Mr.','Anshul','Sharma',NULL,NULL,NULL,NULL,'2016-02-17','M',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'21341234',NULL,NULL,'1',51,'2016-02-17 01:13:02',51,'2016-02-17 01:13:02','0000-00-00 00:00:00'),(29,'28dccf7d-dcc4-5d12-aa56-66854cab3dd3',NULL,'RA0000001',60,'2016-02-17 06:30:17','Miss.','Tanvi','S',NULL,NULL,NULL,NULL,'1985-01-01','F','M',NULL,NULL,9,NULL,'OP',NULL,NULL,NULL,'9898989898','N',NULL,'1',59,'2016-02-17 06:30:17',59,'2016-02-20 06:10:28','0000-00-00 00:00:00'),(30,'a119e459-436d-54be-8c2b-aeb1394c2478',NULL,'AH0000029',61,'2016-02-17 06:42:16','Mr.','Rajendran','Subramanian',NULL,NULL,NULL,NULL,'1986-02-17','M',NULL,NULL,NULL,4,NULL,'OP',NULL,NULL,NULL,'9894837443','N',NULL,'1',51,'2016-02-17 06:42:16',67,'2016-02-25 05:12:49','0000-00-00 00:00:00'),(31,'ef1d7840-2282-5792-b4f4-17f044405315',NULL,'RA0000002',60,'2016-02-18 03:33:58','Mr.','zakir','h',NULL,NULL,NULL,NULL,'2016-02-18','M',NULL,NULL,NULL,8,NULL,'OP',NULL,NULL,NULL,'1231231231','F',NULL,'1',59,'2016-02-18 03:33:58',59,'2016-02-18 03:33:58','0000-00-00 00:00:00'),(32,'04022771-5394-5872-95f8-5dd1eb7c6008',NULL,'AH0000030',58,'2016-02-19 00:46:42','Miss.','Yami','Gautam',NULL,NULL,NULL,NULL,'2016-02-19','F',NULL,NULL,NULL,5,NULL,'IP',NULL,NULL,NULL,'5647364756','F',NULL,'1',51,'2016-02-19 00:46:42',51,'2016-02-19 00:46:42','0000-00-00 00:00:00'),(33,'df0b579b-ad18-58c8-b9cf-49765a1f22a8',NULL,'RA0000003',60,'2016-02-19 00:51:10','Mrs.','Anamika',NULL,NULL,NULL,NULL,NULL,'2016-02-19','F',NULL,NULL,NULL,11,NULL,'OP',NULL,NULL,NULL,'3434343434','N',NULL,'1',59,'2016-02-19 00:51:10',59,'2016-02-19 00:51:10','0000-00-00 00:00:00'),(34,'821f513c-c6be-518f-af3d-f8450327bcae',NULL,'AH0000031',58,'2016-02-19 07:18:51','Mr.','Prakash','Arul Mani',NULL,NULL,NULL,NULL,'1990-01-31','M','M',NULL,NULL,6,NULL,'OP',NULL,NULL,NULL,'9865565668','N',NULL,'1',62,'2016-02-19 07:18:51',51,'2016-06-15 05:19:59','0000-00-00 00:00:00'),(35,'e073430e-d892-56b5-a23b-274f4b004f49',NULL,'RA0000004',60,'2016-02-20 03:31:26','Mr.','Dinesh','G',NULL,NULL,NULL,NULL,'2016-02-20','M',NULL,NULL,NULL,11,NULL,'OP',NULL,NULL,NULL,'4515245245','N',NULL,'1',59,'2016-02-20 03:31:26',59,'2016-02-20 03:31:26','0000-00-00 00:00:00'),(36,'5db1d5bb-fcca-5eba-bc7a-ff584882146d',NULL,'TE0000001',61,'2016-02-21 23:20:05','Mr.','manoj','vinoth',NULL,NULL,NULL,NULL,'1981-04-13','M',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'9879606806','N',NULL,'1',67,'2016-02-21 23:20:05',67,'2016-02-21 23:46:02','0000-00-00 00:00:00'),(37,'b29bfeb7-a538-5952-9f20-48c7bea9dd91',NULL,'AH0000032',58,'2016-02-22 02:32:19','Mr.','rajesh','sub',NULL,NULL,NULL,NULL,'1990-02-22','M',NULL,NULL,NULL,4,NULL,'OP',NULL,NULL,NULL,'1231231231','N',NULL,'1',51,'2016-02-22 02:32:19',51,'2016-04-17 01:23:29','0000-00-00 00:00:00'),(38,'de5ffdee-4098-5cf5-acae-9c9610e7aac3',NULL,'AH0000033',58,'2016-02-25 07:05:33','Mr.','Testing',NULL,NULL,NULL,NULL,NULL,'2014-10-13','M',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'1234567890',NULL,NULL,'1',63,'2016-02-25 07:05:33',63,'2016-02-25 07:05:33','0000-00-00 00:00:00'),(39,'d760e220-c707-59ee-84ad-2da3e62dfce3',NULL,'AH0000034',58,'2016-03-04 01:17:24','Mrs.','Vimala','Senthil',NULL,NULL,NULL,NULL,'1990-03-30','F',NULL,NULL,'AB?',4,NULL,'OP',NULL,NULL,NULL,'9789033433','N',NULL,'1',51,'2016-03-04 01:17:24',51,'2016-03-04 01:17:24','0000-00-00 00:00:00'),(40,'265a9c36-8c45-5dbf-b629-7254e166b5a5',NULL,'AH0000035',58,'2016-03-14 02:27:40','Mr.','VIJAY','TEST',NULL,NULL,NULL,NULL,'1983-01-11','M',NULL,NULL,'B?',6,NULL,'OP',NULL,NULL,NULL,'9877887999','N',NULL,'1',51,'2016-03-14 02:27:40',51,'2016-03-14 02:27:40','0000-00-00 00:00:00'),(41,'174ad7d0-1c03-5c24-b4f1-f4c68467c12e',NULL,'AH0000036',58,'2016-03-14 03:01:44','Mr.','kamal',NULL,NULL,NULL,NULL,NULL,'1981-11-03','M',NULL,NULL,'A?',13,NULL,'NO',NULL,NULL,NULL,'0976565454','F',NULL,'1',51,'2016-03-14 03:01:44',51,'2016-03-14 03:01:44','0000-00-00 00:00:00'),(42,'4403f329-5162-5e4e-ab30-aaf1a668df24',NULL,'AH0000037',58,'2016-03-14 03:03:23','Mr.','paramesh','',NULL,NULL,NULL,NULL,'1990-07-09','F',NULL,NULL,'O+',5,NULL,'OP',NULL,NULL,NULL,'3234232323','F',NULL,'1',51,'2016-03-14 03:03:23',51,'2016-03-14 03:03:23','0000-00-00 00:00:00'),(43,'6acc8bd8-5fdc-54e5-a63a-7db349d1ae2a',NULL,'AH0000038',58,'2016-03-14 05:18:04','Mrs.','Cinna thayee',NULL,NULL,NULL,NULL,NULL,'1969-01-28','F',NULL,NULL,'A?',4,NULL,'OP',NULL,NULL,NULL,'4344343434','N',NULL,'1',51,'2016-03-14 05:18:04',51,'2016-03-14 05:18:04','0000-00-00 00:00:00'),(44,'0dfc55bb-999c-54a5-bdc3-4e8b52f4bbb3',NULL,'AH0000039',58,'2016-03-31 12:25:10','Mr.','Dinesh','Shravan',NULL,NULL,NULL,NULL,'2001-01-03','M','M',NULL,NULL,4,NULL,'OP',NULL,NULL,NULL,'1234567890','N',NULL,'1',51,'2016-03-31 01:55:10',51,'2016-03-31 05:18:16','0000-00-00 00:00:00'),(45,'5fa71b1f-8d51-5db6-a35b-78ce8c67344c',NULL,'AH0000040',58,'2016-04-30 19:50:38','Mr.','test','t',NULL,NULL,NULL,NULL,'2016-04-29','F',NULL,NULL,'AB?',5,NULL,'OP',NULL,NULL,NULL,'9778927829','N',NULL,'1',51,'2016-04-30 09:20:39',51,'2016-05-04 12:45:26','0000-00-00 00:00:00'),(46,'5ca1d7da-163c-5017-967e-cda3a62d57cc',NULL,'AH0000041',58,'2016-05-02 15:42:36','Mr.','Vishal',NULL,NULL,NULL,NULL,NULL,'1994-05-03','M',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'3542345345',NULL,NULL,'1',51,'2016-05-02 05:12:36',51,'2016-05-02 05:12:36','0000-00-00 00:00:00'),(47,'3d7b7d92-3c19-5fa2-8641-214e356e96c3',NULL,'AH0000042',58,'2016-05-09 15:28:56','Miss.','Niranjana',NULL,NULL,NULL,NULL,NULL,'1986-05-09','F',NULL,NULL,'B+',13,NULL,'OP',NULL,NULL,NULL,'9159154005','N',NULL,'1',51,'2016-05-09 04:58:56',51,'2016-05-09 04:58:56','0000-00-00 00:00:00'),(48,'116f6190-cab5-534f-8774-f1b43bd532e7',NULL,'AH0000043',58,'2016-05-09 18:02:24','Mr.','Lilly',NULL,NULL,NULL,NULL,NULL,'1950-06-03','F',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'9865656532',NULL,NULL,'1',51,'2016-05-09 07:32:24',51,'2016-05-09 07:32:24','0000-00-00 00:00:00'),(49,'c40ee8ca-f058-5a8a-954f-cb56c1c5aa79',NULL,'AH0000044',58,'2016-05-11 11:22:35','Miss.','Sonali',NULL,NULL,NULL,NULL,NULL,'1994-06-01','F',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'9876456767',NULL,NULL,'1',51,'2016-05-11 00:52:35',51,'2016-05-11 00:53:53','0000-00-00 00:00:00'),(50,'ce51f406-8c68-5148-88a5-97f5227b0ab4',NULL,'AH0000045',58,'2016-05-13 16:46:39','Mr.','pooja',NULL,NULL,NULL,NULL,NULL,'2016-05-01','F',NULL,NULL,NULL,13,NULL,'OP',NULL,NULL,NULL,'4343333333',NULL,NULL,'1',51,'2016-05-13 06:16:39',51,'2016-05-13 06:27:45','0000-00-00 00:00:00'),(51,'c7dd536c-9491-5820-abc5-0d5fa17f46a7',NULL,'AH0000046',58,'2016-05-24 09:51:08','Mr.','Amit',NULL,NULL,NULL,NULL,NULL,'1981-01-31','M',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'9786786578',NULL,NULL,'1',51,'2016-05-23 23:21:08',51,'2016-05-23 23:21:08','0000-00-00 00:00:00'),(52,'013eac64-6c9d-5149-835d-3b25fc5227a5',NULL,'AH0000047',58,'2016-05-31 10:22:44','Miss.','Swati','',NULL,NULL,NULL,NULL,'2001-01-01','F',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'8888888888',NULL,NULL,'1',51,'2016-05-30 23:52:44',51,'2016-05-30 23:52:44','0000-00-00 00:00:00'),(53,'f3022607-21df-537a-ae49-d48d2c6fb71d',NULL,'AH0000048',58,'2016-05-31 10:54:14','Mr.','Kishore',NULL,NULL,NULL,NULL,NULL,'2003-01-29','M',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'5555555555',NULL,NULL,'1',51,'2016-05-31 00:24:14',51,'2016-05-31 00:24:14','0000-00-00 00:00:00'),(54,'a8fd87db-bb71-5b06-b6db-e53f2ecead47',NULL,'AH0000049',58,'2016-06-06 15:41:50','Mr.','Rose',NULL,NULL,NULL,NULL,NULL,'2016-06-06','F',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'6655555555',NULL,NULL,'1',51,'2016-06-06 05:11:50',51,'2016-06-06 05:11:50','0000-00-00 00:00:00'),(55,'835fc635-5524-59ab-8d03-be2729119e2a',NULL,'AH0000050',58,'2016-06-06 15:50:38','Mrs.','Rihaana',NULL,NULL,NULL,NULL,NULL,'1921-02-28','F',NULL,NULL,'O+',4,NULL,'OP',NULL,NULL,NULL,'8756567656','N',NULL,'1',51,'2016-06-06 05:20:38',51,'2016-06-06 05:20:38','0000-00-00 00:00:00'),(56,'f9314e48-6e2f-51f5-bb5f-a5c916981ac0',NULL,'AH0000051',58,'2016-06-09 10:17:32','Mr.','Yash',NULL,NULL,NULL,NULL,NULL,'2016-06-09','M',NULL,NULL,'O+',6,NULL,'OP',NULL,NULL,NULL,'1212121212',NULL,NULL,'1',51,'2016-06-08 23:47:32',51,'2016-06-09 00:05:29','0000-00-00 00:00:00'),(57,'50325109-4eee-5ce6-9200-f544b887f923',NULL,'AH0000052',58,'2016-06-11 15:30:22','Mr.','sdsd',NULL,NULL,NULL,NULL,NULL,'2016-05-29','M',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'6565656555',NULL,NULL,'1',51,'2016-06-11 05:00:22',51,'2016-06-11 05:00:22','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=latin1;

/*Data for the table `pat_patient_address` */

insert  into `pat_patient_address`(`addr_id`,`patient_id`,`addr_current_address`,`addr_country_id`,`addr_state_id`,`addr_city_id`,`addr_zip`,`addr_perm_address`,`addr_perm_country_id`,`addr_perm_state_id`,`addr_perm_city_id`,`addr_perm_zip`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (18,18,'Test test test',11,10,4,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-16 06:30:51',51,'2016-02-16 06:30:51','0000-00-00 00:00:00'),(19,19,'anna nagar',11,10,4,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-16 22:07:14',51,'2016-02-17 02:41:37','0000-00-00 00:00:00'),(20,20,'abc avenue',7,8,1,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-16 22:10:56',51,'2016-02-16 22:10:56','0000-00-00 00:00:00'),(21,21,'top lane',11,10,4,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-16 22:15:06',51,'2016-02-16 22:15:06','0000-00-00 00:00:00'),(22,22,'sdfas',7,8,1,'32424','sdfas',7,8,1,'32424',51,'2016-02-17 00:14:58',51,'2016-03-31 01:52:49','0000-00-00 00:00:00'),(23,23,'sdfas',7,8,1,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-17 00:15:03',51,'2016-02-17 00:15:03','0000-00-00 00:00:00'),(24,24,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-17 00:17:40',51,'2016-02-17 00:17:40','0000-00-00 00:00:00'),(25,25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-17 00:20:10',51,'2016-03-21 04:49:04','0000-00-00 00:00:00'),(26,26,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-17 00:21:54',51,'2016-02-17 00:21:54','0000-00-00 00:00:00'),(27,27,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-17 00:24:22',51,'2016-02-17 00:24:22','0000-00-00 00:00:00'),(28,28,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-17 01:13:02',51,'2016-02-17 01:13:02','0000-00-00 00:00:00'),(29,29,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,59,'2016-02-17 06:30:17',59,'2016-02-20 06:10:28','0000-00-00 00:00:00'),(30,30,'Test',7,8,1,'625002','Test',7,8,1,'625002',51,'2016-02-17 06:42:16',51,'2016-02-19 06:17:53','0000-00-00 00:00:00'),(31,31,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,59,'2016-02-18 03:33:58',59,'2016-02-18 03:33:58','0000-00-00 00:00:00'),(32,32,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-19 00:46:42',51,'2016-02-19 00:46:42','0000-00-00 00:00:00'),(33,33,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,59,'2016-02-19 00:51:10',59,'2016-02-19 00:51:10','0000-00-00 00:00:00'),(34,34,'Test test',7,8,1,NULL,NULL,NULL,NULL,NULL,NULL,62,'2016-02-19 07:18:51',51,'2016-06-15 05:19:59','0000-00-00 00:00:00'),(35,35,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,59,'2016-02-20 03:31:26',59,'2016-02-20 03:31:26','0000-00-00 00:00:00'),(36,36,'test',7,8,1,'632222','test',7,8,1,'632222',67,'2016-02-21 23:20:06',67,'2016-02-21 23:46:02','0000-00-00 00:00:00'),(37,37,'test',7,8,1,NULL,'test',7,8,1,NULL,51,'2016-02-22 02:32:19',51,'2016-04-17 01:23:29','0000-00-00 00:00:00'),(38,38,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'2016-02-25 07:05:33',63,'2016-02-25 07:05:33','0000-00-00 00:00:00'),(39,39,'ttest',7,8,1,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-03-04 01:17:24',51,'2016-03-04 01:17:24','0000-00-00 00:00:00'),(40,40,'TEST',7,8,1,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-03-14 02:27:40',51,'2016-03-14 02:27:40','0000-00-00 00:00:00'),(41,41,'34',7,8,1,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-03-14 03:01:44',51,'2016-03-14 03:01:44','0000-00-00 00:00:00'),(42,42,'test',7,8,1,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-03-14 03:03:23',51,'2016-03-14 03:03:23','0000-00-00 00:00:00'),(43,43,'vinoth',7,8,5,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-03-14 05:18:04',51,'2016-03-14 05:18:04','0000-00-00 00:00:00'),(44,44,'ghjkghkj',7,8,1,'232323','ghjkghkj',7,8,1,'232323',51,'2016-03-31 01:55:10',51,'2016-03-31 05:18:16','0000-00-00 00:00:00'),(45,45,'te',7,8,1,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-04-30 09:20:39',51,'2016-05-04 12:45:26','0000-00-00 00:00:00'),(46,46,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-05-02 05:12:36',51,'2016-05-02 05:12:36','0000-00-00 00:00:00'),(47,47,NULL,7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-05-09 04:58:56',51,'2016-05-09 04:58:56','0000-00-00 00:00:00'),(48,48,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-05-09 07:32:24',51,'2016-05-09 07:32:24','0000-00-00 00:00:00'),(49,49,NULL,7,8,1,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-05-11 00:52:35',51,'2016-05-11 00:53:53','0000-00-00 00:00:00'),(50,50,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-05-13 06:16:39',51,'2016-05-13 06:27:45','0000-00-00 00:00:00'),(51,51,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-05-23 23:21:08',51,'2016-05-23 23:21:08','0000-00-00 00:00:00'),(52,52,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-05-30 23:52:44',51,'2016-05-30 23:52:44','0000-00-00 00:00:00'),(53,53,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-05-31 00:24:14',51,'2016-05-31 00:24:14','0000-00-00 00:00:00'),(54,54,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-06-06 05:11:50',51,'2016-06-06 05:11:50','0000-00-00 00:00:00'),(55,55,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-06-06 05:20:38',51,'2016-06-06 05:20:38','0000-00-00 00:00:00'),(56,56,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-06-08 23:47:32',51,'2016-06-09 00:05:29','0000-00-00 00:00:00'),(57,57,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-06-11 05:00:22',51,'2016-06-11 05:00:22','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

/*Data for the table `pat_patient_casesheet` */

insert  into `pat_patient_casesheet`(`casesheet_id`,`tenant_id`,`patient_id`,`casesheet_no`,`start_date`,`end_date`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,20,'AXNWLEJ123','2016-03-12',NULL,'1',51,'2016-03-12 04:33:25',51,'2016-03-12 04:33:25','0000-00-00 00:00:00'),(2,58,37,'A','2016-03-22',NULL,'1',51,'2016-03-22 01:57:48',51,'2016-03-22 01:57:48','0000-00-00 00:00:00'),(3,58,34,'AUCPG123','2016-03-23','2016-03-24','0',51,'2016-03-23 05:06:57',51,'2016-03-24 07:42:08','0000-00-00 00:00:00'),(4,58,24,'1500','2016-03-23',NULL,'1',62,'2016-03-23 05:48:48',62,'2016-03-23 05:48:48','0000-00-00 00:00:00'),(5,58,22,'158510','2016-03-23','2016-03-24','0',62,'2016-03-23 05:52:12',51,'2016-03-24 07:10:04','0000-00-00 00:00:00'),(6,58,22,'1111','2016-03-24',NULL,'1',51,'2016-03-24 07:10:04',51,'2016-03-24 07:10:04','0000-00-00 00:00:00'),(7,58,34,'111111','2016-03-24','2016-05-04','0',51,'2016-03-24 07:42:08',51,'2016-05-04 12:25:14','0000-00-00 00:00:00'),(8,58,44,'AUC12345','2016-03-31',NULL,'1',51,'2016-03-31 01:58:09',51,'2016-03-31 01:58:09','0000-00-00 00:00:00'),(9,58,42,'233232','2016-04-02',NULL,'1',51,'2016-04-02 00:06:42',51,'2016-04-02 00:06:42','0000-00-00 00:00:00'),(10,58,46,'11111','2016-05-02','2016-05-05','0',51,'2016-05-02 05:15:14',51,'2016-05-05 00:28:06','0000-00-00 00:00:00'),(11,58,34,'111','2016-05-04','2016-06-11','0',51,'2016-05-04 12:25:14',51,'2016-06-11 06:02:50','0000-00-00 00:00:00'),(12,58,46,'111ABC','2016-05-05','2016-06-15','0',51,'2016-05-05 00:28:06',51,'2016-06-15 05:17:01','0000-00-00 00:00:00'),(13,58,51,'AHA9001','2016-05-24',NULL,'1',51,'2016-05-23 23:23:07',51,'2016-05-23 23:23:07','0000-00-00 00:00:00'),(14,58,47,'AHA60001','2016-05-24',NULL,'1',51,'2016-05-23 23:30:44',51,'2016-05-23 23:30:44','0000-00-00 00:00:00'),(15,58,52,'AHA5006','2016-05-31',NULL,'1',51,'2016-05-31 00:21:59',51,'2016-05-31 00:21:59','0000-00-00 00:00:00'),(16,58,53,'AHA4002','2016-05-31',NULL,'1',51,'2016-05-31 00:25:32',51,'2016-05-31 00:25:32','0000-00-00 00:00:00'),(17,58,54,'UVW12345','2016-06-06',NULL,'1',51,'2016-06-06 05:12:14',51,'2016-06-06 05:12:14','0000-00-00 00:00:00'),(18,58,55,'DSS3434','2016-06-06',NULL,'1',51,'2016-06-06 05:20:53',51,'2016-06-06 05:20:53','0000-00-00 00:00:00'),(19,58,56,'ADBN2300','2016-06-09',NULL,'1',51,'2016-06-09 00:04:09',51,'2016-06-09 00:04:09','0000-00-00 00:00:00'),(20,58,57,'opopop','2016-06-11',NULL,'1',51,'2016-06-11 05:00:51',51,'2016-06-11 05:00:51','0000-00-00 00:00:00'),(21,58,34,'45454','2016-06-11',NULL,'1',51,'2016-06-11 06:02:50',51,'2016-06-11 06:02:50','0000-00-00 00:00:00'),(22,58,46,'435345','2016-06-15','2016-06-16','0',51,'2016-06-15 05:17:01',51,'2016-06-16 12:31:19','0000-00-00 00:00:00'),(23,58,46,'4353','2016-06-16',NULL,'1',51,'2016-06-16 12:31:19',51,'2016-06-16 12:31:19','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `pat_prescription` */

insert  into `pat_prescription`(`pres_id`,`tenant_id`,`encounter_id`,`patient_id`,`pres_date`,`consultant_id`,`number_of_days`,`notes`,`next_visit`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,101,42,'2016-04-23 16:46:57',54,NULL,NULL,'2016-04-23','1',62,'2016-04-23 06:16:57',62,'2016-04-23 06:16:57','0000-00-00 00:00:00'),(2,58,103,42,'2016-04-25 15:18:10',54,NULL,NULL,'2016-04-25','1',62,'2016-04-25 04:48:11',62,'2016-04-25 04:48:11','0000-00-00 00:00:00'),(3,58,98,37,'2016-04-28 11:09:57',54,NULL,NULL,'2016-04-28','1',51,'2016-04-28 00:39:58',51,'2016-04-28 00:39:58','0000-00-00 00:00:00'),(4,58,98,37,'2016-04-28 11:15:20',54,NULL,NULL,'2016-04-28','1',51,'2016-04-28 00:45:20',51,'2016-04-28 00:45:20','0000-00-00 00:00:00'),(5,58,119,46,'2016-05-02 18:52:54',54,NULL,NULL,'2016-05-02','1',51,'2016-05-02 08:22:55',51,'2016-05-02 08:22:55','0000-00-00 00:00:00'),(6,58,119,46,'2016-05-02 18:55:12',54,NULL,NULL,'2016-05-02','1',51,'2016-05-02 08:25:13',51,'2016-05-02 08:25:13','0000-00-00 00:00:00'),(7,58,119,46,'2016-05-02 19:00:06',54,NULL,NULL,'2016-05-02','1',51,'2016-05-02 08:30:06',51,'2016-05-02 08:30:06','0000-00-00 00:00:00'),(8,58,119,46,'2016-05-02 19:00:46',54,NULL,NULL,'2016-05-02','1',51,'2016-05-02 08:30:47',51,'2016-05-02 08:30:47','0000-00-00 00:00:00'),(9,58,119,46,'2016-05-02 19:01:25',56,NULL,NULL,'2016-05-02','1',51,'2016-05-02 08:31:25',51,'2016-05-02 08:31:25','0000-00-00 00:00:00'),(10,58,119,46,'2016-05-02 19:02:56',54,NULL,NULL,'2016-05-02','1',51,'2016-05-02 08:32:57',51,'2016-05-02 08:32:57','0000-00-00 00:00:00'),(11,58,128,46,'2016-05-11 11:18:53',56,NULL,NULL,'2016-05-11','1',51,'2016-05-11 00:48:53',51,'2016-05-11 00:48:53','0000-00-00 00:00:00'),(12,58,128,46,'2016-05-12 15:59:32',54,NULL,NULL,'2016-05-12','1',51,'2016-05-12 05:29:33',51,'2016-05-12 05:29:33','0000-00-00 00:00:00'),(13,58,128,46,'2016-05-12 16:22:27',56,NULL,NULL,'2016-05-12','1',51,'2016-05-12 05:52:28',51,'2016-05-12 05:52:28','0000-00-00 00:00:00'),(14,58,128,46,'2016-05-13 15:05:01',54,NULL,NULL,'2016-05-13','1',51,'2016-05-13 04:34:59',51,'2016-05-13 04:34:59','0000-00-00 00:00:00'),(15,58,143,52,'2016-05-31 12:55:30',54,NULL,NULL,'2016-05-31','1',51,'2016-05-31 02:25:31',51,'2016-05-31 02:25:31','0000-00-00 00:00:00'),(16,58,142,34,'2016-06-15 15:03:28',54,9,NULL,'2016-06-24','1',51,'2016-06-15 04:33:24',51,'2016-06-15 04:33:24','0000-00-00 00:00:00'),(17,58,128,46,'2016-06-16 22:51:24',54,NULL,NULL,'2016-06-16','1',51,'2016-06-16 12:21:26',51,'2016-06-16 12:21:26','0000-00-00 00:00:00'),(18,58,128,46,'2016-06-16 23:11:39',56,NULL,NULL,'2016-06-16','1',51,'2016-06-16 12:41:42',51,'2016-06-16 12:41:42','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `pat_prescription_favourite` */

insert  into `pat_prescription_favourite`(`pres_fav_id`,`tenant_id`,`encounter_id`,`patient_id`,`product_id`,`product_name`,`generic_id`,`drug_class_id`,`consultant_id`,`pres_id`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,119,46,1,'test | 1 | ML',1,1,54,10,'1',51,'2016-05-02 08:30:06',51,'2016-05-02 08:32:57','0000-00-00 00:00:00'),(2,58,119,46,1,'test | 1 | ML',1,1,56,9,'0',51,'2016-05-02 08:31:25',51,'2016-06-16 12:39:36','0000-00-00 00:00:00'),(3,58,128,46,2,'BEXOL DT | 1 | MG',2,3,54,17,'0',51,'2016-05-13 04:35:00',51,'2016-06-16 12:25:49','0000-00-00 00:00:00'),(4,58,143,52,2,'BEXOL DT | 1 | MG',2,3,54,15,'1',51,'2016-05-31 02:25:31',51,'2016-05-31 02:25:31','0000-00-00 00:00:00'),(5,58,128,46,2,'BEXOL DT | 1 | MG',2,3,56,18,'1',51,'2016-06-16 12:41:42',51,'2016-06-16 12:41:42','0000-00-00 00:00:00');

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
  CONSTRAINT `FK_pat_prescription_frequency_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `pat_prescription_frequency` */

insert  into `pat_prescription_frequency`(`freq_id`,`tenant_id`,`freq_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'1-1-1','1',62,'2016-04-23 06:16:57',62,'2016-04-23 06:16:57','0000-00-00 00:00:00'),(2,58,'0-1-0','1',51,'2016-06-15 04:33:24',51,'2016-06-15 04:33:24','0000-00-00 00:00:00'),(3,58,'1-2-1','1',51,'2016-06-15 04:33:24',51,'2016-06-15 04:33:24','0000-00-00 00:00:00'),(4,58,'0-0-1','1',51,'2016-06-16 12:21:26',51,'2016-06-16 12:21:26','0000-00-00 00:00:00'),(5,58,'0-1-1','1',51,'2016-06-16 12:41:42',51,'2016-06-16 12:41:42','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

/*Data for the table `pat_prescription_items` */

insert  into `pat_prescription_items`(`pres_item_id`,`tenant_id`,`pres_id`,`product_id`,`product_name`,`generic_id`,`generic_name`,`drug_class_id`,`drug_name`,`route_id`,`freq_id`,`number_of_days`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,1,4,'Coldmine | 1 | ML',3,'OXAZEPAM',3,'ANTIPSYCHOTICS',1,1,10,'1',62,'2016-04-23 06:16:57',62,'2016-04-23 06:16:57','0000-00-00 00:00:00'),(2,58,2,4,'Coldmine | 1 | ML',3,'OXAZEPAM',3,'ANTIPSYCHOTICS',2,1,10,'1',62,'2016-04-25 04:48:11',62,'2016-04-25 04:48:11','0000-00-00 00:00:00'),(3,58,3,2,'BEXOL DT | 1 | MG',2,'MULTIVITAMINS WITH MINERALS',3,'ANTIPSYCHOTICS',1,1,10,'1',51,'2016-04-28 00:39:58',51,'2016-04-28 00:39:58','0000-00-00 00:00:00'),(4,58,4,2,'BEXOL DT | 1 | MG',2,'MULTIVITAMINS WITH MINERALS',3,'ANTIPSYCHOTICS',1,1,10,'1',51,'2016-04-28 00:45:20',51,'2016-04-28 00:45:20','0000-00-00 00:00:00'),(5,58,5,2,'BEXOL DT | 1 | MG',2,'MULTIVITAMINS WITH MINERALS',3,'ANTIPSYCHOTICS',1,1,10,'1',51,'2016-05-02 08:22:55',51,'2016-05-02 08:22:55','0000-00-00 00:00:00'),(6,58,5,5,'Metformin | 1 | MG',5,'IRON FOLIC ACID VITAMIN B & ZINC',3,'ANTIPSYCHOTICS',1,1,30,'1',51,'2016-05-02 08:22:55',51,'2016-05-02 08:22:55','0000-00-00 00:00:00'),(7,58,6,2,'BEXOL DT | 1 | MG',2,'MULTIVITAMINS WITH MINERALS',3,'ANTIPSYCHOTICS',1,1,10,'1',51,'2016-05-02 08:25:13',51,'2016-05-02 08:25:13','0000-00-00 00:00:00'),(8,58,6,3,'Crocin | 1 | MG',2,'MULTIVITAMINS WITH MINERALS',3,'ANTIPSYCHOTICS',1,1,30,'1',51,'2016-05-02 08:25:13',51,'2016-05-02 08:25:13','0000-00-00 00:00:00'),(9,58,7,1,'test | 1 | ML',1,'generic 1',1,'class1',1,1,30,'1',51,'2016-05-02 08:30:06',51,'2016-05-02 08:30:06','0000-00-00 00:00:00'),(10,58,8,1,'test | 1 | ML',1,'generic 1',1,'class1',1,1,30,'1',51,'2016-05-02 08:30:47',51,'2016-05-02 08:30:47','0000-00-00 00:00:00'),(11,58,9,1,'test | 1 | ML',1,'generic 1',1,'class1',1,1,10,'1',51,'2016-05-02 08:31:25',51,'2016-05-02 08:31:25','0000-00-00 00:00:00'),(12,58,10,1,'test | 1 | ML',1,'generic 1',1,'class1',3,1,30,'1',51,'2016-05-02 08:32:57',51,'2016-05-02 08:32:57','0000-00-00 00:00:00'),(13,58,11,2,'BEXOL DT | 1 | MG',2,'MULTIVITAMINS WITH MINERALS',3,'ANTIPSYCHOTICS',1,1,12,'1',51,'2016-05-11 00:48:53',51,'2016-05-11 00:48:53','0000-00-00 00:00:00'),(14,58,12,2,'BEXOL DT | 1 | MG',2,'MULTIVITAMINS WITH MINERALS',3,'ANTIPSYCHOTICS',1,1,10,'1',51,'2016-05-12 05:29:33',51,'2016-05-12 05:29:33','0000-00-00 00:00:00'),(15,58,13,2,'BEXOL DT | 1 | MG',2,'MULTIVITAMINS WITH MINERALS',3,'ANTIPSYCHOTICS',1,1,10,'1',51,'2016-05-12 05:52:28',51,'2016-05-12 05:52:28','0000-00-00 00:00:00'),(16,58,14,2,'BEXOL DT | 1 | MG',2,'MULTIVITAMINS WITH MINERALS',3,'ANTIPSYCHOTICS',1,1,12,'1',51,'2016-05-13 04:35:00',51,'2016-05-13 04:35:00','0000-00-00 00:00:00'),(17,58,15,2,'BEXOL DT | 1 | MG',2,'MULTIVITAMINS WITH MINERALS',3,'ANTIPSYCHOTICS',3,1,12,'1',51,'2016-05-31 02:25:31',51,'2016-05-31 02:25:31','0000-00-00 00:00:00'),(18,58,16,2,'BEXOL DT | 1 | MG',2,'MULTIVITAMINS WITH MINERALS',3,'ANTIPSYCHOTICS',4,2,1,'1',51,'2016-06-15 04:33:24',51,'2016-06-15 04:33:24','0000-00-00 00:00:00'),(19,58,16,3,'Crocin | 1 | MG',3,'OXAZEPAM',7,'antidepression',5,3,12,'1',51,'2016-06-15 04:33:24',51,'2016-06-15 04:33:24','0000-00-00 00:00:00'),(20,58,17,1,'test | 1 | ML',1,'generic 1',1,'class1',4,4,3,'1',51,'2016-06-16 12:21:26',51,'2016-06-16 12:21:26','0000-00-00 00:00:00'),(21,58,17,2,'BEXOL DT | 1 | MG',2,'MULTIVITAMINS WITH MINERALS',3,'ANTIPSYCHOTICS',4,1,1,'1',51,'2016-06-16 12:21:26',51,'2016-06-16 12:21:26','0000-00-00 00:00:00'),(22,58,18,2,'BEXOL DT | 1 | MG',2,'MULTIVITAMINS WITH MINERALS',3,'ANTIPSYCHOTICS',4,5,1,'1',51,'2016-06-16 12:41:42',51,'2016-06-16 12:41:42','0000-00-00 00:00:00');

/*Table structure for table `pat_prescription_route` */

DROP TABLE IF EXISTS `pat_prescription_route`;

CREATE TABLE `pat_prescription_route` (
  `route_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `route_name` varbinary(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`route_id`),
  KEY `FK_pat_prescription_route_tenant` (`tenant_id`),
  CONSTRAINT `FK_pat_prescription_route_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `pat_prescription_route` */

insert  into `pat_prescription_route`(`route_id`,`tenant_id`,`route_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'Mouth','1',62,'2016-04-23 06:16:57',62,'2016-04-23 06:16:57','0000-00-00 00:00:00'),(2,58,'PO','1',62,'2016-04-25 04:48:11',62,'2016-04-25 04:48:11','0000-00-00 00:00:00'),(3,58,'mouth','1',51,'2016-05-02 08:32:57',51,'2016-05-02 08:32:57','0000-00-00 00:00:00'),(4,58,'iv','1',51,'2016-06-15 04:33:24',51,'2016-06-15 04:33:24','0000-00-00 00:00:00'),(5,58,'sad','1',51,'2016-06-15 04:33:24',51,'2016-06-15 04:33:24','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `pat_procedure` */

insert  into `pat_procedure`(`proc_id`,`tenant_id`,`encounter_id`,`patient_id`,`charge_subcat_id`,`proc_date`,`proc_consultant_ids`,`proc_description`,`charge_amount`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,5,20,22,'2016-02-17 18:27:45','[54,56]','Test test','0.00','1',51,'2016-02-17 06:58:00',51,'2016-02-17 06:58:00','0000-00-00 00:00:00'),(2,60,6,29,30,'2016-02-18 12:32:11','[60,61]','give vizylac','0.00','1',59,'2016-02-18 01:03:03',59,'2016-02-18 01:03:03','0000-00-00 00:00:00'),(3,60,6,29,22,'2016-02-18 12:33:15','[61]','report normal...repeat test on monday\nneed to follow up\naversion test next wednesday\nthursday blood level sugar','0.00','1',59,'2016-02-18 01:03:40',59,'2016-02-18 01:04:33','0000-00-00 00:00:00'),(4,58,54,37,22,'2016-02-22 14:47:51','[56]','rgvg5g6g yy6hy6h 6yhy6h6 6yh6h6yh 6yh6yhy6h 6yhy6hy6','0.00','1',51,'2016-02-22 03:18:09',51,'2016-02-22 03:20:05','0000-00-00 00:00:00'),(5,61,57,30,22,'2016-02-25 13:38:00','[68,69]','test','0.00','1',67,'2016-02-25 02:08:24',67,'2016-02-25 02:20:47','0000-00-00 00:00:00'),(6,61,60,24,22,'2016-02-27 19:13:07','[68,69,70,71,72]','TEST','0.00','1',67,'2016-02-27 07:43:40',67,'2016-02-27 07:43:40','0000-00-00 00:00:00'),(7,58,64,34,35,'2016-03-07 17:12:06','[56,54]',NULL,'0.00','1',51,'2016-03-07 05:42:55',51,'2016-03-07 05:42:55','0000-00-00 00:00:00'),(8,58,64,34,22,'2016-03-07 17:14:26','[]',NULL,'0.00','1',51,'2016-03-07 05:44:34',51,'2016-03-07 05:44:34','0000-00-00 00:00:00'),(9,58,64,34,30,'2016-03-23 15:12:49','[54,58]',NULL,'0.00','1',51,'2016-03-23 04:43:23',51,'2016-03-23 04:43:23','0000-00-00 00:00:00'),(10,58,86,22,22,'2016-03-23 16:22:24','[54,56]','Test test tessss','150.00','1',62,'2016-03-23 05:52:33',62,'2016-03-23 05:52:33','0000-00-00 00:00:00'),(11,58,97,20,22,'2016-04-04 15:44:53','[54]',NULL,'111.00','1',51,'2016-04-04 05:14:58',51,'2016-04-04 05:14:58','0000-00-00 00:00:00'),(12,58,98,37,22,'2016-04-05 10:54:31','[56,54]',NULL,'150.00','1',51,'2016-04-05 00:24:39',51,'2016-04-05 00:24:39','0000-00-00 00:00:00'),(13,58,99,42,22,'2016-04-13 12:37:54','[56,54,58]','test','111.00','1',51,'2016-04-13 02:08:16',51,'2016-04-13 02:08:16','0000-00-00 00:00:00'),(14,58,101,42,22,'2016-04-23 09:49:32','[56,54]',NULL,'150.00','1',51,'2016-04-22 23:19:48',51,'2016-04-22 23:19:48','0000-00-00 00:00:00'),(15,58,126,46,22,'2016-05-07 13:22:12','[54]',NULL,'111.00','1',51,'2016-05-07 02:52:20',51,'2016-05-07 02:52:20','0000-00-00 00:00:00'),(16,58,130,49,22,'2016-05-11 11:26:22','[56]',NULL,'150.00','1',51,'2016-05-11 00:56:31',51,'2016-05-11 00:56:31','0000-00-00 00:00:00'),(17,58,128,46,22,'2016-05-24 11:05:27','[54]',NULL,'111.00','1',51,'2016-05-24 00:35:36',51,'2016-05-24 00:35:36','0000-00-00 00:00:00'),(18,58,128,46,22,'2016-06-16 23:13:20','[58,56,54]','fszf','111.00','1',51,'2016-06-16 12:43:43',51,'2016-06-16 12:43:43','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=285 DEFAULT CHARSET=latin1;

/*Data for the table `pat_timeline` */

insert  into `pat_timeline`(`timeline_id`,`tenant_id`,`patient_id`,`date_time`,`header`,`header_sub`,`message`,`ip_adderss`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,22,'2016-02-17 00:14:58','Patient Update','','Patient Details Updated Successfully.','220.158.141.31','1',51,'2016-03-31 01:52:49',51,'2016-03-31 01:52:49','0000-00-00 00:00:00'),(2,58,44,'2016-03-31 12:25:10','Patient Registration','','Mr. Dinesh Registered Successfully.','220.158.141.31','1',51,'2016-03-31 01:55:10',51,'2016-03-31 01:55:10','0000-00-00 00:00:00'),(3,58,44,'2016-03-31 01:58:09','Casesheet No.','','Casesheet No.: AUC12345 Added.','220.158.141.31','1',51,'2016-03-31 01:58:09',51,'2016-03-31 01:58:09','0000-00-00 00:00:00'),(4,58,44,'2016-03-31 12:25:43','Patient Admission','Encounter # 88','Patient Admitted. <br /> Bed No: <b>113 (Deluxe)</b>','220.158.141.31','1',51,'2016-03-31 01:58:09',51,'2016-03-31 01:58:09','0000-00-00 00:00:00'),(5,58,44,'2016-03-31 12:31:18','Discharge','Encounter # 88','Patient Discharged. <br /> Bed No: <b>113 (Deluxe)</b>','220.158.141.31','1',51,'2016-03-31 02:01:20',51,'2016-03-31 02:01:20','0000-00-00 00:00:00'),(6,58,44,'2016-03-31 12:31:23','Patient Admission','Encounter # 89','Patient Admitted. <br /> Bed No: <b>113 (Non AC)</b>','220.158.141.31','1',51,'2016-03-31 02:01:35',51,'2016-03-31 02:01:35','0000-00-00 00:00:00'),(7,58,44,'2016-03-31 12:38:28','Discharge','Encounter # 89','Patient Discharged. <br /> Bed No: <b>113 (Non AC)</b>','220.158.141.31','1',51,'2016-03-31 02:08:30',51,'2016-03-31 02:08:30','0000-00-00 00:00:00'),(8,58,44,'2016-03-31 01:50:00','Appoinment Booked','Encounter # 90','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-03-31 02:09:01',51,'2016-03-31 02:09:01','0000-00-00 00:00:00'),(9,58,44,'2016-03-31 01:50:00','Patient Arrived','Encounter # 90','Patient Arrived. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-03-31 02:09:11',51,'2016-03-31 02:09:11','0000-00-00 00:00:00'),(10,58,44,'2016-03-31 12:39:18','Doctor Seen','Encounter # 90','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-03-31 02:09:23',51,'2016-03-31 02:09:23','0000-00-00 00:00:00'),(11,58,44,'2016-03-31 12:40:29','Patient Admission','Encounter # 91','Patient Admitted. <br /> Bed No: <b>112 (Non AC)</b>','220.158.141.31','1',51,'2016-03-31 02:10:40',51,'2016-03-31 02:10:40','0000-00-00 00:00:00'),(12,58,44,'2016-03-31 12:41:53','Discharge','Encounter # 91','Patient Discharged. <br /> Bed No: <b>112 (Non AC)</b>','220.158.141.31','1',51,'2016-03-31 02:11:58',51,'2016-03-31 02:11:58','0000-00-00 00:00:00'),(13,58,44,'2016-03-31 01:50:00','Appoinment Booked','Encounter # 92','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-03-31 02:12:05',51,'2016-03-31 02:12:05','0000-00-00 00:00:00'),(14,58,34,'2016-03-31 02:00:00','Appoinment Booked','Encounter # 93','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','1.39.21.47','1',51,'2016-03-31 05:02:18',51,'2016-03-31 05:02:18','0000-00-00 00:00:00'),(15,58,44,'2016-03-31 12:25:10','Patient Update','','Patient Details Updated Successfully.','122.164.202.15','1',51,'2016-03-31 05:14:08',51,'2016-03-31 05:14:08','0000-00-00 00:00:00'),(16,58,44,'2016-03-31 12:25:10','Patient Update','','Patient Details Updated Successfully.','122.164.202.15','1',51,'2016-03-31 05:15:02',51,'2016-03-31 05:15:02','0000-00-00 00:00:00'),(17,58,44,'2016-03-31 12:25:10','Patient Update','','Patient Details Updated Successfully.','122.164.202.15','1',51,'2016-03-31 05:18:16',51,'2016-03-31 05:18:16','0000-00-00 00:00:00'),(18,58,34,'2016-03-31 16:43:00','Patient Arrived','Encounter # 93','Patient Arrived. <br />Consultant : <b>Dr. John</b>','1.39.62.142','1',51,'2016-03-31 06:13:26',51,'2016-03-31 06:13:26','0000-00-00 00:00:00'),(19,58,34,'2016-03-31 16:43:36','Doctor Seen','Encounter # 93','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','1.39.62.142','1',51,'2016-03-31 06:14:03',51,'2016-03-31 06:14:03','0000-00-00 00:00:00'),(20,58,22,'2016-04-01 09:55:47','Discharge','Encounter # 86','Patient Discharged. <br /> Bed No: <b>112 (Suite)</b>','122.164.10.181','1',51,'2016-03-31 23:25:48',51,'2016-03-31 23:25:48','0000-00-00 00:00:00'),(21,58,22,'2016-04-01 01:55:00','Appoinment Booked','Encounter # 94','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','122.164.10.181','1',51,'2016-03-31 23:26:22',51,'2016-03-31 23:26:22','0000-00-00 00:00:00'),(22,58,22,'2016-04-01 11:55:00','Appoinment Booked','Encounter # 95','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','122.164.10.181','1',51,'2016-03-31 23:27:23',51,'2016-03-31 23:27:23','0000-00-00 00:00:00'),(23,58,42,'2016-04-02 10:27:14','Appointment Cancel','Encounter # 70','Appointment Cancelled. <br />Consultant : <b>Dr. John</b>','1.39.20.204','1',51,'2016-04-01 23:57:19',51,'2016-04-01 23:57:19','0000-00-00 00:00:00'),(24,58,42,'2016-04-02 00:06:42','Casesheet No.','','Casesheet No.: 233232 Added.','1.39.20.204','1',51,'2016-04-02 00:06:42',51,'2016-04-02 00:06:42','0000-00-00 00:00:00'),(25,58,20,'2016-04-04 10:42:43','Doctor Seen','Encounter # 76','Seen by Consultant. <br />Consultant : <b>Dr. Surya</b>','122.164.196.192','1',51,'2016-04-04 00:12:48',51,'2016-04-04 00:12:48','0000-00-00 00:00:00'),(26,58,20,'2016-04-04 10:42:56','Doctor Seen','Encounter # 77','Seen by Consultant. <br />Consultant : <b>Dr. Surya</b>','122.164.196.192','1',51,'2016-04-04 00:12:59',51,'2016-04-04 00:12:59','0000-00-00 00:00:00'),(27,58,20,'2016-04-04 10:49:57','Doctor Seen','Encounter # 78','Seen by Consultant. <br />Consultant : <b>Dr. Surya</b>','122.164.196.192','1',51,'2016-04-04 00:20:00',51,'2016-04-04 00:20:00','0000-00-00 00:00:00'),(28,58,20,'2016-04-04 10:50:05','Patient Admission','Encounter # 96','Patient Admitted. <br /> Bed No: <b>112 (Suite)</b>','122.164.196.192','1',51,'2016-04-04 00:20:20',51,'2016-04-04 00:20:20','0000-00-00 00:00:00'),(29,58,20,'2016-04-04 10:50:31','Doctor Transfer','Encounter # 96','Patient\'s Doctor Transfered. <br />Consultant Incharge: Mrs. Jo','122.164.196.192','1',51,'2016-04-04 00:21:08',51,'2016-04-04 00:21:08','0000-00-00 00:00:00'),(30,58,20,'2016-04-04 10:51:26','Discharge','Encounter # 96','Patient Discharged. <br /> Bed No: <b>112 (Suite)</b>','122.164.196.192','1',51,'2016-04-04 00:21:28',51,'2016-04-04 00:21:28','0000-00-00 00:00:00'),(31,58,20,'2016-04-04 15:44:32','Patient Admission','Encounter # 97','Patient Admitted. <br /> Bed No: <b>113 (ac)</b>','122.164.196.192','1',51,'2016-04-04 05:14:40',51,'2016-04-04 05:14:40','0000-00-00 00:00:00'),(32,58,20,'2016-04-04 15:44:53','Procedure','','Procedure : <b>stomach wash</b>','122.164.196.192','1',51,'2016-04-04 05:14:58',51,'2016-04-04 05:14:58','0000-00-00 00:00:00'),(33,58,20,'2016-04-04 15:44:53','Consultation','','Consulted for Procedure (stomach wash) <br /> Consultant : <b>Dr. John</b>','122.164.196.192','1',51,'2016-04-04 05:14:58',51,'2016-04-04 05:14:58','0000-00-00 00:00:00'),(34,58,20,'2016-04-06 10:50:00','Consultation','','Consultant : <b>Mrs. Jo</b>','122.164.196.192','1',51,'2016-04-04 05:15:43',51,'2016-04-04 05:15:43','0000-00-00 00:00:00'),(35,58,20,'2016-04-04 15:49:01','Bill Finalize','Encounter # 97','Bill Finalized By Dr. Vikhram','122.164.196.192','1',51,'2016-04-04 05:19:01',51,'2016-04-04 05:19:01','0000-00-00 00:00:00'),(36,58,20,'2016-04-04 15:49:14','Bill Finalize','Encounter # 97','Bill Finalized By Dr. Vikhram','122.164.196.192','1',51,'2016-04-04 05:19:14',51,'2016-04-04 05:19:14','0000-00-00 00:00:00'),(37,58,20,'2016-04-04 15:49:26','Bill Authorize','Encounter # 97','Bill Authorize By Dr. Vikhram','122.164.196.192','1',51,'2016-04-04 05:19:26',51,'2016-04-04 05:19:26','0000-00-00 00:00:00'),(38,58,20,'2016-04-06 10:25:00','Consultation','','Consultant : <b>Dr. John</b>','122.164.177.146','1',51,'2016-04-04 23:25:37',51,'2016-04-04 23:25:37','0000-00-00 00:00:00'),(39,58,25,'2016-04-05 09:59:56','Patient Arrived','Encounter # 15','Patient Arrived. <br />Consultant : <b>Dr. Surya</b>','122.164.177.146','1',51,'2016-04-04 23:29:59',51,'2016-04-04 23:29:59','0000-00-00 00:00:00'),(40,58,25,'2016-04-05 10:00:08','Doctor Seen','Encounter # 15','Seen by Consultant. <br />Consultant : <b>Dr. Surya</b>','122.164.177.146','1',51,'2016-04-04 23:30:13',51,'2016-04-04 23:30:13','0000-00-00 00:00:00'),(41,58,37,'2016-04-05 10:53:56','Patient Admission','Encounter # 98','Patient Admitted. <br /> Bed No: <b>112 (Suite)</b>','122.164.177.146','1',51,'2016-04-05 00:24:10',51,'2016-04-05 00:24:10','0000-00-00 00:00:00'),(42,58,37,'2016-04-05 10:54:31','Procedure','','Procedure : <b>stomach wash</b>','122.164.177.146','1',51,'2016-04-05 00:24:39',51,'2016-04-05 00:24:39','0000-00-00 00:00:00'),(43,58,37,'2016-04-05 10:54:31','Consultation','','Consulted for Procedure (stomach wash) <br /> Consultant : <b>Dr. Surya</b>','122.164.177.146','1',51,'2016-04-05 00:24:39',51,'2016-04-05 00:24:39','0000-00-00 00:00:00'),(44,58,37,'2016-04-05 10:54:31','Consultation','','Consulted for Procedure (stomach wash) <br /> Consultant : <b>Dr. John</b>','122.164.177.146','1',51,'2016-04-05 00:24:39',51,'2016-04-05 00:24:39','0000-00-00 00:00:00'),(45,58,37,'2016-04-05 10:55:58','Consultation','','Consultant : <b>Mrs. Jo</b>','122.164.177.146','1',51,'2016-04-05 00:25:58',51,'2016-04-05 00:25:58','0000-00-00 00:00:00'),(46,58,20,'2016-04-06 15:11:10','Discharge','Encounter # 97','Patient Discharged. <br /> Bed No: <b>113 (ac)</b>','220.158.141.31','1',51,'2016-04-06 04:41:06',51,'2016-04-06 04:41:06','0000-00-00 00:00:00'),(47,58,42,'2016-04-13 12:34:39','Patient Admission','Encounter # 99','Patient Admitted. <br /> Bed No: <b>112 (Deluxe)</b>','1.39.60.48','1',51,'2016-04-13 02:05:01',51,'2016-04-13 02:05:01','0000-00-00 00:00:00'),(48,58,42,'2016-04-13 12:37:54','Procedure','','test <br /> Procedure : <b>stomach wash</b>','1.39.60.48','1',51,'2016-04-13 02:08:16',51,'2016-04-13 02:08:16','0000-00-00 00:00:00'),(49,58,42,'2016-04-13 12:37:54','Consultation','','Consulted for Procedure (stomach wash) <br /> Consultant : <b>Dr. Surya</b>','1.39.60.48','1',51,'2016-04-13 02:08:16',51,'2016-04-13 02:08:16','0000-00-00 00:00:00'),(50,58,42,'2016-04-13 12:37:54','Consultation','','Consulted for Procedure (stomach wash) <br /> Consultant : <b>Dr. John</b>','1.39.60.48','1',51,'2016-04-13 02:08:16',51,'2016-04-13 02:08:16','0000-00-00 00:00:00'),(51,58,42,'2016-04-13 12:37:54','Consultation','','Consulted for Procedure (stomach wash) <br /> Consultant : <b>Mrs. Jo</b>','1.39.60.48','1',51,'2016-04-13 02:08:16',51,'2016-04-13 02:08:16','0000-00-00 00:00:00'),(52,58,42,'2016-04-13 15:55:00','Consultation','','test <br /> Consultant : <b>Dr. Surya</b>','1.39.60.48','1',51,'2016-04-13 02:09:09',51,'2016-04-13 02:09:09','0000-00-00 00:00:00'),(53,58,42,'2016-04-15 15:24:02','Room Transfer','Encounter # 99','Patient Room Transfered. <br /> Bed No: <b>112 (Suite)</b>','122.164.11.10','1',51,'2016-04-15 04:54:21',51,'2016-04-15 04:54:21','0000-00-00 00:00:00'),(54,58,37,'2016-04-15 15:24:02','Room Transfer','Encounter # 98','Patient Room Transfered. <br /> Bed No: <b>112 (Non AC)</b>','122.164.11.10','1',51,'2016-04-15 04:54:21',51,'2016-04-15 04:54:21','0000-00-00 00:00:00'),(55,58,42,'2016-04-15 15:24:46','Discharge','Encounter # 99','Patient Discharged. <br /> Bed No: <b>112 (Suite)</b>','122.164.11.10','1',51,'2016-04-15 04:54:54',51,'2016-04-15 04:54:54','0000-00-00 00:00:00'),(56,58,42,'2016-04-16 11:55:00','Patient Admission','Encounter # 100','Patient Admitted. <br /> Bed No: <b>113 (Deluxe)</b>','1.39.60.66','1',51,'2016-04-15 06:35:58',51,'2016-04-15 06:35:58','0000-00-00 00:00:00'),(57,58,37,'2016-02-22 02:32:19','Patient Update','','Patient Details Updated Successfully.','1.39.20.214','1',51,'2016-04-17 01:22:14',51,'2016-04-17 01:22:14','0000-00-00 00:00:00'),(58,58,37,'2016-02-22 02:32:19','Patient Update','','Patient Details Updated Successfully.','1.39.20.214','1',51,'2016-04-17 01:22:27',51,'2016-04-17 01:22:27','0000-00-00 00:00:00'),(59,58,37,'2016-02-22 02:32:19','Patient Update','','Patient Details Updated Successfully.','1.39.20.214','1',51,'2016-04-17 01:22:52',51,'2016-04-17 01:22:52','0000-00-00 00:00:00'),(60,58,37,'2016-02-22 02:32:19','Patient Update','','Patient Details Updated Successfully.','1.39.20.214','1',51,'2016-04-17 01:23:29',51,'2016-04-17 01:23:29','0000-00-00 00:00:00'),(61,58,42,'2016-04-23 09:43:20','Discharge','Encounter # 100','Patient Discharged. <br /> Bed No: <b>113 (Deluxe)</b>','122.164.149.101','1',51,'2016-04-22 23:13:23',51,'2016-04-22 23:13:23','0000-00-00 00:00:00'),(62,58,42,'2016-04-23 09:49:11','Patient Admission','Encounter # 101','Patient Admitted. <br /> Bed No: <b>112 (Suite)</b>','122.164.149.101','1',51,'2016-04-22 23:19:20',51,'2016-04-22 23:19:20','0000-00-00 00:00:00'),(63,58,42,'2016-04-23 09:49:32','Procedure','','Procedure : <b>stomach wash</b>','122.164.149.101','1',51,'2016-04-22 23:19:48',51,'2016-04-22 23:19:48','0000-00-00 00:00:00'),(64,58,42,'2016-04-23 09:49:32','Consultation','','Consulted for Procedure (stomach wash) <br /> Consultant : <b>Dr. Surya</b>','122.164.149.101','1',51,'2016-04-22 23:19:48',51,'2016-04-22 23:19:48','0000-00-00 00:00:00'),(65,58,42,'2016-04-23 09:49:32','Consultation','','Consulted for Procedure (stomach wash) <br /> Consultant : <b>Dr. John</b>','122.164.149.101','1',51,'2016-04-22 23:19:48',51,'2016-04-22 23:19:48','0000-00-00 00:00:00'),(66,58,42,'2016-04-25 14:45:00','Administrative Discharge','Encounter # 101','Patient Administrative Discharged. <br /> Bed No: <b>112 (Suite)</b>','220.158.141.31','1',51,'2016-04-25 04:15:42',51,'2016-04-25 04:15:42','0000-00-00 00:00:00'),(67,58,42,'2016-04-25 14:46:34','Bill Finalize','Encounter # 101','Bill Finalized By Dr. Vikhram','220.158.141.31','1',51,'2016-04-25 04:16:34',51,'2016-04-25 04:16:34','0000-00-00 00:00:00'),(68,58,42,'2016-04-25 14:52:32','Bill Authorize','Encounter # 101','Bill Authorize By Dr. Vikhram','220.158.141.31','1',51,'2016-04-25 04:22:32',51,'2016-04-25 04:22:32','0000-00-00 00:00:00'),(69,58,42,'2016-04-25 14:52:44','Administrative Discharge','Encounter # 101','Patient Administrative Discharged. <br /> Bed No: <b>112 (Suite)</b>','220.158.141.31','1',51,'2016-04-25 04:22:44',51,'2016-04-25 04:22:44','0000-00-00 00:00:00'),(70,58,42,'2016-04-25 14:52:44','Administrative Discharge','Encounter # 101','Administrative Discharge By Dr. Vikhram','220.158.141.31','1',51,'2016-04-25 04:22:44',51,'2016-04-25 04:22:44','0000-00-00 00:00:00'),(71,58,42,'2016-04-25 14:52:51','Patient Admission','Encounter # 102','Patient Admitted. <br /> Bed No: <b>112 (Suite)</b>','220.158.141.31','1',51,'2016-04-25 04:28:24',51,'2016-04-25 04:28:24','0000-00-00 00:00:00'),(72,58,42,'2016-04-25 15:10:06','Administrative Discharge','Encounter # 102','Patient Administrative Discharged. <br /> Bed No: <b>112 (Suite)</b>','220.158.141.31','1',51,'2016-04-25 04:40:08',51,'2016-04-25 04:40:08','0000-00-00 00:00:00'),(73,58,42,'2016-04-25 15:10:19','Bill Finalize','Encounter # 102','Bill Finalized By Dr. Vikhram','220.158.141.31','1',51,'2016-04-25 04:40:19',51,'2016-04-25 04:40:19','0000-00-00 00:00:00'),(74,58,42,'2016-04-25 15:10:26','Bill Authorize','Encounter # 102','Bill Authorize By Dr. Vikhram','220.158.141.31','1',51,'2016-04-25 04:40:26',51,'2016-04-25 04:40:26','0000-00-00 00:00:00'),(75,58,42,'2016-04-25 15:10:33','Administrative Discharge','Encounter # 102','Patient Administrative Discharged. <br /> Bed No: <b>112 (Suite)</b>','220.158.141.31','1',51,'2016-04-25 04:40:33',51,'2016-04-25 04:40:33','0000-00-00 00:00:00'),(76,58,42,'2016-04-25 15:10:33','Administrative Discharge','Encounter # 102','Administrative Discharge By Dr. Vikhram','220.158.141.31','1',51,'2016-04-25 04:40:33',51,'2016-04-25 04:40:33','0000-00-00 00:00:00'),(77,58,42,'2016-04-25 02:00:00','Appoinment Booked','Encounter # 103','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-04-25 04:41:22',51,'2016-04-25 04:41:22','0000-00-00 00:00:00'),(78,58,42,'2016-04-25 02:00:00','Patient Arrived','Encounter # 103','Patient Arrived. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-04-25 04:41:32',51,'2016-04-25 04:41:32','0000-00-00 00:00:00'),(79,58,42,'2016-04-25 15:11:49','Doctor Seen','Encounter # 103','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-04-25 04:41:53',51,'2016-04-25 04:41:53','0000-00-00 00:00:00'),(80,58,42,'2016-04-25 15:13:45','Doctor Seen','Encounter # 103','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-04-25 04:43:48',51,'2016-04-25 04:43:48','0000-00-00 00:00:00'),(81,58,42,'2016-04-25 15:14:11','Doctor Seen','Encounter # 103','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-04-25 04:44:15',51,'2016-04-25 04:44:15','0000-00-00 00:00:00'),(82,58,42,'2016-04-26 12:11:21','Doctor Seen','Encounter # 103','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-04-26 01:41:25',51,'2016-04-26 01:41:25','0000-00-00 00:00:00'),(83,58,37,'2016-04-26 15:12:36','Administrative Discharge','Encounter # 98','Patient Administrative Discharged. <br /> Bed No: <b>112 (Non AC)</b>','220.158.141.31','1',51,'2016-04-26 04:42:39',51,'2016-04-26 04:42:39','0000-00-00 00:00:00'),(84,58,37,'2016-04-26 15:13:00','Bill Finalize','Encounter # 98','Bill Finalized By Dr. Vikhram','220.158.141.31','1',51,'2016-04-26 04:43:00',51,'2016-04-26 04:43:00','0000-00-00 00:00:00'),(85,58,37,'2016-04-26 15:13:07','Bill Authorize','Encounter # 98','Bill Authorize By Dr. Vikhram','220.158.141.31','1',51,'2016-04-26 04:43:07',51,'2016-04-26 04:43:07','0000-00-00 00:00:00'),(86,58,37,'2016-04-26 15:13:14','Administrative Discharge','Encounter # 98','Patient Administrative Discharged. <br /> Bed No: <b>112 (Non AC)</b>','220.158.141.31','1',51,'2016-04-26 04:43:14',51,'2016-04-26 04:43:14','0000-00-00 00:00:00'),(87,58,37,'2016-04-26 15:13:14','Administrative Discharge','Encounter # 98','Administrative Discharge By Dr. Vikhram','220.158.141.31','1',51,'2016-04-26 04:43:14',51,'2016-04-26 04:43:14','0000-00-00 00:00:00'),(88,58,20,'2016-04-26 12:00:00','Appoinment Booked','Encounter # 104','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-04-26 04:58:05',51,'2016-04-26 04:58:05','0000-00-00 00:00:00'),(89,58,20,'2016-04-26 15:28:13','Patient Arrived','Encounter # 104','Patient Arrived. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-04-26 04:58:15',51,'2016-04-26 04:58:15','0000-00-00 00:00:00'),(90,58,20,'2016-04-26 15:28:24','Doctor Seen','Encounter # 104','Seen by Consultant. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-04-26 04:58:26',51,'2016-04-26 04:58:26','0000-00-00 00:00:00'),(91,58,20,'2016-04-26 15:28:41','Doctor Seen','Encounter # 104','Seen by Consultant. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-04-26 04:58:43',51,'2016-04-26 04:58:43','0000-00-00 00:00:00'),(92,58,20,'2016-04-26 05:10:06','Patient Alert','','Patient Alert (latest alert) added.','220.158.141.31','1',51,'2016-04-26 05:10:06',51,'2016-04-26 05:10:06','0000-00-00 00:00:00'),(93,58,20,'2016-04-26 16:16:47','Doctor Seen','Encounter # 104','Seen by Consultant. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-04-26 05:46:50',51,'2016-04-26 05:46:50','0000-00-00 00:00:00'),(94,58,34,'2016-04-27 17:11:09','Patient Admission','Encounter # 105','Patient Admitted. <br /> Bed No: <b>112 (Non AC)</b>','61.3.213.132','1',51,'2016-04-27 06:41:59',51,'2016-04-27 06:41:59','0000-00-00 00:00:00'),(95,58,37,'2016-04-28 11:55:00','Appoinment Booked','Encounter # 106','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-04-28 00:55:17',51,'2016-04-28 00:55:17','0000-00-00 00:00:00'),(96,58,37,'2016-04-28 11:55:00','Patient Arrived','Encounter # 106','Patient Arrived. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-04-28 00:55:26',51,'2016-04-28 00:55:26','0000-00-00 00:00:00'),(97,58,37,'2016-04-28 12:17:00','Doctor Seen','Encounter # 106','Seen by Consultant. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-04-28 01:47:03',51,'2016-04-28 01:47:03','0000-00-00 00:00:00'),(98,58,37,'2016-04-28 12:17:19','Appointment Cancel','Encounter # 106','Appointment Cancelled. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-04-28 01:47:19',51,'2016-04-28 01:47:19','0000-00-00 00:00:00'),(99,58,34,'2016-04-14 14:30:00','Consultation','','2323 <br /> Consultant : <b>Dr. John</b>','117.245.149.94','1',51,'2016-04-28 04:33:32',51,'2016-04-28 04:33:32','0000-00-00 00:00:00'),(100,58,42,'2016-04-30 19:25:21','Appointment Cancel','Encounter # 103','Appointment Cancelled. <br />Consultant : <b>Dr. John</b>','1.39.61.102','1',51,'2016-04-30 08:55:23',51,'2016-04-30 08:55:23','0000-00-00 00:00:00'),(101,58,39,'2016-04-30 19:25:50','Appointment Cancel','Encounter # 80','Appointment Cancelled. <br />Consultant : <b>Dr. John</b>','1.39.61.102','1',51,'2016-04-30 08:55:52',51,'2016-04-30 08:55:52','0000-00-00 00:00:00'),(102,58,42,'2016-04-30 01:55:00','Appoinment Booked','Encounter # 107','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','1.39.61.102','1',51,'2016-04-30 08:56:33',51,'2016-04-30 08:56:33','0000-00-00 00:00:00'),(103,58,42,'2016-04-30 01:55:00','Patient Arrived','Encounter # 107','Patient Arrived. <br />Consultant : <b>Dr. John</b>','1.39.61.102','1',51,'2016-04-30 08:56:33',51,'2016-04-30 08:56:33','0000-00-00 00:00:00'),(104,58,40,'2016-04-30 19:37:39','Appointment Cancel','Encounter # 74','Appointment Cancelled. <br />Consultant : <b>Dr. John</b>','1.39.61.102','1',51,'2016-04-30 09:07:41',51,'2016-04-30 09:07:41','0000-00-00 00:00:00'),(105,58,43,'2016-04-30 19:38:24','Appointment Cancel','Encounter # 71','Appointment Cancelled. <br />Consultant : <b>Dr. John</b>','1.39.61.102','1',51,'2016-04-30 09:08:26',51,'2016-04-30 09:08:26','0000-00-00 00:00:00'),(106,58,43,'2016-04-30 01:45:00','Appoinment Booked','Encounter # 108','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','1.39.61.102','1',51,'2016-04-30 09:08:42',51,'2016-04-30 09:08:42','0000-00-00 00:00:00'),(107,58,32,'2016-04-30 19:39:35','Appointment Cancel','Encounter # 20','Appointment Cancelled. <br />Consultant : <b>Dr. Surya</b>','1.39.61.102','1',51,'2016-04-30 09:09:38',51,'2016-04-30 09:09:38','0000-00-00 00:00:00'),(108,58,32,'2016-04-30 01:20:00','Appoinment Booked','Encounter # 109','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','1.39.61.102','1',51,'2016-04-30 09:10:27',51,'2016-04-30 09:10:27','0000-00-00 00:00:00'),(109,58,43,'2016-04-04 01:05:00','Consultation','','2 <br /> Consultant : <b>Dr. John</b>','1.39.61.102','1',51,'2016-04-30 09:12:40',51,'2016-04-30 09:12:40','0000-00-00 00:00:00'),(110,58,43,'2016-04-30 19:43:00','Patient Arrived','Encounter # 108','Patient Arrived. <br />Consultant : <b>Dr. John</b>','1.39.61.102','1',51,'2016-04-30 09:13:17',51,'2016-04-30 09:13:17','0000-00-00 00:00:00'),(111,58,43,'2016-04-30 19:43:22','Doctor Seen','Encounter # 108','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','1.39.61.102','1',51,'2016-04-30 09:13:26',51,'2016-04-30 09:13:26','0000-00-00 00:00:00'),(112,58,45,'2016-04-30 19:50:38','Patient Registration','','Mr. test Registered Successfully.','1.39.61.102','1',51,'2016-04-30 09:20:39',51,'2016-04-30 09:20:39','0000-00-00 00:00:00'),(113,58,20,'2016-05-02 15:09:00','Doctor Seen','Encounter # 104','Seen by Consultant. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-02 04:39:02',51,'2016-05-02 04:39:02','0000-00-00 00:00:00'),(114,58,20,'2016-05-02 11:20:00','Appoinment Booked','Encounter # 110','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-02 04:39:46',51,'2016-05-02 04:39:46','0000-00-00 00:00:00'),(115,58,20,'2016-05-02 15:09:57','Patient Arrived','Encounter # 110','Patient Arrived. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-02 04:40:41',51,'2016-05-02 04:40:41','0000-00-00 00:00:00'),(116,58,20,'2016-05-02 15:10:48','Doctor Seen','Encounter # 110','Seen by Consultant. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-02 04:40:50',51,'2016-05-02 04:40:50','0000-00-00 00:00:00'),(117,58,20,'2016-05-02 11:25:00','Appoinment Booked','Encounter # 111','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-02 04:43:21',51,'2016-05-02 04:43:21','0000-00-00 00:00:00'),(118,58,20,'2016-05-02 15:13:47','Patient Arrived','Encounter # 111','Patient Arrived. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-02 04:43:53',51,'2016-05-02 04:43:53','0000-00-00 00:00:00'),(119,58,20,'2016-05-02 15:14:08','Doctor Seen','Encounter # 111','Seen by Consultant. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-02 04:44:11',51,'2016-05-02 04:44:11','0000-00-00 00:00:00'),(120,58,20,'2016-05-02 11:55:00','Appoinment Booked','Encounter # 112','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-02 04:46:48',51,'2016-05-02 04:46:48','0000-00-00 00:00:00'),(121,58,20,'2016-05-02 15:16:57','Patient Arrived','Encounter # 112','Patient Arrived. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-02 04:47:01',51,'2016-05-02 04:47:01','0000-00-00 00:00:00'),(122,58,20,'2016-05-02 15:17:12','Appointment Cancel','Encounter # 112','Appointment Cancelled. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-02 04:47:12',51,'2016-05-02 04:47:12','0000-00-00 00:00:00'),(123,58,20,'2016-05-02 11:55:00','Appoinment Booked','Encounter # 113','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-02 04:49:45',51,'2016-05-02 04:49:45','0000-00-00 00:00:00'),(124,58,20,'2016-05-02 15:19:56','Patient Arrived','Encounter # 113','Patient Arrived. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-02 04:49:59',51,'2016-05-02 04:49:59','0000-00-00 00:00:00'),(125,58,20,'2016-05-02 15:20:07','Doctor Seen','Encounter # 113','Seen by Consultant. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-02 04:50:22',51,'2016-05-02 04:50:22','0000-00-00 00:00:00'),(126,58,26,'2016-05-02 15:21:47','Patient Arrived','Encounter # 82','Patient Arrived. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-02 04:51:49',51,'2016-05-02 04:51:49','0000-00-00 00:00:00'),(127,58,26,'2016-05-02 15:22:12','Doctor Seen','Encounter # 82','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-02 04:52:17',51,'2016-05-02 04:52:17','0000-00-00 00:00:00'),(128,58,26,'2016-03-21 01:50:00','Patient Arrived','Encounter # 81','Patient Arrived. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-02 04:59:19',51,'2016-05-02 04:59:19','0000-00-00 00:00:00'),(129,58,46,'2016-05-02 15:42:36','Patient Registration','','Mr. Vishal Registered Successfully.','220.158.141.31','1',51,'2016-05-02 05:12:36',51,'2016-05-02 05:12:36','0000-00-00 00:00:00'),(130,58,46,'2016-05-03 07:30:00','Appoinment Booked','Encounter # 114','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-02 05:13:07',51,'2016-05-02 05:13:07','0000-00-00 00:00:00'),(131,58,46,'2016-05-03 07:30:00','Patient Arrived','Encounter # 114','Patient Arrived. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-02 05:13:17',51,'2016-05-02 05:13:17','0000-00-00 00:00:00'),(132,58,46,'2016-05-02 15:43:21','Doctor Seen','Encounter # 114','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-02 05:13:25',51,'2016-05-02 05:13:25','0000-00-00 00:00:00'),(133,58,46,'2016-05-02 05:15:14','Casesheet No.','','Casesheet No.: 11111 Added.','220.158.141.31','1',51,'2016-05-02 05:15:14',51,'2016-05-02 05:15:14','0000-00-00 00:00:00'),(134,58,46,'2016-05-02 15:44:51','Patient Admission','Encounter # 115','Patient Admitted. <br /> Bed No: <b>112 (Suite)</b>','220.158.141.31','1',51,'2016-05-02 05:15:14',51,'2016-05-02 05:15:14','0000-00-00 00:00:00'),(135,58,46,'2016-05-02 15:45:21','Clinical Discharge','Encounter # 115','Patient Clinical Discharged. <br /> Bed No: <b>112 (Suite)</b>','220.158.141.31','1',51,'2016-05-02 05:15:23',51,'2016-05-02 05:15:23','0000-00-00 00:00:00'),(136,58,46,'2016-05-02 16:03:02','Bill Finalize','Encounter # 115','Bill Finalized By Dr. Vikhram','220.158.141.31','1',51,'2016-05-02 05:33:02',51,'2016-05-02 05:33:02','0000-00-00 00:00:00'),(137,58,46,'2016-05-02 16:03:12','Bill Authorize','Encounter # 115','Bill Authorize By Dr. Vikhram','220.158.141.31','1',51,'2016-05-02 05:33:12',51,'2016-05-02 05:33:12','0000-00-00 00:00:00'),(138,58,46,'2016-05-02 16:03:28','Administrative Discharge','Encounter # 115','Patient Administrative Discharged. <br /> Bed No: <b>112 (Suite)</b>','220.158.141.31','1',51,'2016-05-02 05:33:28',51,'2016-05-02 05:33:28','0000-00-00 00:00:00'),(139,58,46,'2016-05-02 16:03:28','Administrative Discharge','Encounter # 115','Administrative Discharge By Dr. Vikhram','220.158.141.31','1',51,'2016-05-02 05:33:28',51,'2016-05-02 05:33:28','0000-00-00 00:00:00'),(140,58,46,'2016-05-02 16:03:49','Patient Admission','Encounter # 116','Patient Admitted. <br /> Bed No: <b>112 (Suite)</b>','220.158.141.31','1',51,'2016-05-02 05:34:03',51,'2016-05-02 05:34:03','0000-00-00 00:00:00'),(141,58,37,'2016-05-02 16:32:16','Appointment Cancel','Encounter # 106','Appointment Cancelled. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-02 06:02:17',51,'2016-05-02 06:02:17','0000-00-00 00:00:00'),(142,58,37,'2016-05-02 16:32:26','Patient Admission','Encounter # 117','Patient Admitted. <br /> Bed No: <b>113 (ac)</b>','220.158.141.31','1',51,'2016-05-02 06:02:38',51,'2016-05-02 06:02:38','0000-00-00 00:00:00'),(143,58,46,'2016-05-02 17:19:40','Clinical Discharge','Encounter # 116','Patient Clinical Discharged. <br /> Bed No: <b>112 (Suite)</b>','220.158.141.31','1',51,'2016-05-02 06:49:42',51,'2016-05-02 06:49:42','0000-00-00 00:00:00'),(144,58,46,'2016-05-02 17:20:07','Bill Finalize','Encounter # 116','Bill Finalized By Dr. Vikhram','220.158.141.31','1',51,'2016-05-02 06:50:07',51,'2016-05-02 06:50:07','0000-00-00 00:00:00'),(145,58,46,'2016-05-02 17:20:32','Bill Authorize','Encounter # 116','Bill Authorize By Dr. Vikhram','220.158.141.31','1',51,'2016-05-02 06:50:32',51,'2016-05-02 06:50:32','0000-00-00 00:00:00'),(146,58,46,'2016-05-02 17:21:31','Administrative Discharge','Encounter # 116','Patient Administrative Discharged. <br /> Bed No: <b>112 (Suite)</b>','220.158.141.31','1',51,'2016-05-02 06:51:31',51,'2016-05-02 06:51:31','0000-00-00 00:00:00'),(147,58,46,'2016-05-02 17:21:31','Administrative Discharge','Encounter # 116','Administrative Discharge By Dr. Vikhram','220.158.141.31','1',51,'2016-05-02 06:51:31',51,'2016-05-02 06:51:31','0000-00-00 00:00:00'),(148,58,46,'2016-05-02 01:55:00','Appoinment Booked','Encounter # 118','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-02 08:16:47',51,'2016-05-02 08:16:47','0000-00-00 00:00:00'),(149,58,46,'2016-05-02 18:48:07','Appointment Cancel','Encounter # 118','Appointment Cancelled. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-02 08:18:08',51,'2016-05-02 08:18:08','0000-00-00 00:00:00'),(150,58,46,'2016-05-17 01:50:00','Appoinment Booked','Encounter # 119','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-02 08:18:26',51,'2016-05-02 08:18:26','0000-00-00 00:00:00'),(151,58,46,'2016-05-17 01:50:00','Patient Arrived','Encounter # 119','Patient Arrived. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-02 08:19:59',51,'2016-05-02 08:19:59','0000-00-00 00:00:00'),(152,58,46,'2016-05-02 18:50:03','Doctor Seen','Encounter # 119','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-02 08:20:08',51,'2016-05-02 08:20:08','0000-00-00 00:00:00'),(153,58,34,'2016-05-04 15:23:15','Clinical Discharge','Encounter # 105','Patient Clinical Discharged. <br /> Bed No: <b>112 (Non AC)</b>','220.158.141.31','1',51,'2016-05-04 04:53:17',51,'2016-05-04 04:53:17','0000-00-00 00:00:00'),(154,58,34,'2016-05-04 15:27:31','Bill Finalize','Encounter # 105','Bill Finalized By Dr. Vikhram','220.158.141.31','1',51,'2016-05-04 04:57:31',51,'2016-05-04 04:57:31','0000-00-00 00:00:00'),(155,58,34,'2016-05-04 15:27:38','Bill Finalize','Encounter # 105','Bill Finalized By Dr. Vikhram','220.158.141.31','1',51,'2016-05-04 04:57:38',51,'2016-05-04 04:57:38','0000-00-00 00:00:00'),(156,58,34,'2016-05-04 15:27:47','Bill Authorize','Encounter # 105','Bill Authorize By Dr. Vikhram','220.158.141.31','1',51,'2016-05-04 04:57:47',51,'2016-05-04 04:57:47','0000-00-00 00:00:00'),(157,58,34,'2016-05-04 15:27:54','Administrative Discharge','Encounter # 105','Patient Administrative Discharged. <br /> Bed No: <b>112 (Non AC)</b>','220.158.141.31','1',51,'2016-05-04 04:57:54',51,'2016-05-04 04:57:54','0000-00-00 00:00:00'),(158,58,34,'2016-05-04 15:27:54','Administrative Discharge','Encounter # 105','Administrative Discharge By Dr. Vikhram','220.158.141.31','1',51,'2016-05-04 04:57:54',51,'2016-05-04 04:57:54','0000-00-00 00:00:00'),(159,58,34,'2016-05-04 01:55:00','Appoinment Booked','Encounter # 120','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-04 05:02:57',51,'2016-05-04 05:02:57','0000-00-00 00:00:00'),(160,58,34,'2016-05-04 15:33:05','Patient Arrived','Encounter # 120','Patient Arrived. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-04 05:03:09',51,'2016-05-04 05:03:09','0000-00-00 00:00:00'),(161,58,34,'2016-05-04 15:33:19','Doctor Seen','Encounter # 120','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-04 05:03:25',51,'2016-05-04 05:03:25','0000-00-00 00:00:00'),(162,58,34,'2016-05-04 16:27:43','Patient Admission','Encounter # 121','Patient Admitted. <br /> Bed No: <b>112 (ac)</b>','220.158.141.31','1',51,'2016-05-04 05:57:56',51,'2016-05-04 05:57:56','0000-00-00 00:00:00'),(163,58,34,'2016-05-04 16:28:02','Clinical Discharge','Encounter # 121','Patient Clinical Discharged. <br /> Bed No: <b>112 (ac)</b>','220.158.141.31','1',51,'2016-05-04 05:58:04',51,'2016-05-04 05:58:04','0000-00-00 00:00:00'),(164,58,34,'2016-05-04 12:25:14','Casesheet No.','','Casesheet No.: 111 Added.','1.39.21.83','1',51,'2016-05-04 12:25:14',51,'2016-05-04 12:25:14','0000-00-00 00:00:00'),(165,58,28,'2016-05-04 23:01:51','Appointment Cancel','Encounter # 75','Appointment Cancelled. <br />Consultant : <b>Dr. Surya</b>','1.39.21.83','1',51,'2016-05-04 12:31:53',51,'2016-05-04 12:31:53','0000-00-00 00:00:00'),(166,58,39,'2016-03-21 01:50:00','Patient Arrived','Encounter # 79','Patient Arrived. <br />Consultant : <b>Dr. John</b>','1.39.21.83','1',51,'2016-05-04 12:32:36',51,'2016-05-04 12:32:36','0000-00-00 00:00:00'),(167,58,46,'2016-05-04 23:00:00','Patient Admission','Encounter # 122','Patient Admitted. <br /> Bed No: <b>112 (Deluxe)</b>','1.39.21.83','1',51,'2016-05-04 12:35:24',51,'2016-05-04 12:35:24','0000-00-00 00:00:00'),(168,58,45,'2016-05-04 01:55:00','Appoinment Booked','Encounter # 123','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','1.39.21.83','1',51,'2016-05-04 12:38:42',51,'2016-05-04 12:38:42','0000-00-00 00:00:00'),(169,58,45,'2016-05-04 23:08:49','Patient Arrived','Encounter # 123','Patient Arrived. <br />Consultant : <b>Dr. John</b>','1.39.21.83','1',51,'2016-05-04 12:38:54',51,'2016-05-04 12:38:54','0000-00-00 00:00:00'),(170,58,45,'2016-05-04 23:09:00','Doctor Seen','Encounter # 123','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','1.39.21.83','1',51,'2016-05-04 12:39:08',51,'2016-05-04 12:39:08','0000-00-00 00:00:00'),(171,58,45,'2016-05-04 23:09:00','Doctor Seen','Encounter # 123','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','1.39.21.83','1',51,'2016-05-04 12:39:27',51,'2016-05-04 12:39:27','0000-00-00 00:00:00'),(172,58,45,'2016-05-04 01:50:00','Appoinment Booked','Encounter # 124','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','1.39.21.83','1',51,'2016-05-04 12:42:40',51,'2016-05-04 12:42:40','0000-00-00 00:00:00'),(173,58,45,'2016-04-30 19:50:38','Patient Update','','Patient Details Updated Successfully.','1.39.21.83','1',51,'2016-05-04 12:45:26',51,'2016-05-04 12:45:26','0000-00-00 00:00:00'),(174,58,45,'2016-05-04 12:47:51','Patient Alert','','Patient Alert (asdfsadfdasfa asdf as) added.','1.39.21.83','1',51,'2016-05-04 12:47:51',51,'2016-05-04 12:47:51','0000-00-00 00:00:00'),(175,58,45,'2016-05-04 12:47:51','Patient Alert','','Patient Alert (test tstv tewadsfasdfasd das) updated.','1.39.21.83','1',51,'2016-05-04 12:48:17',51,'2016-05-04 12:48:17','0000-00-00 00:00:00'),(176,58,37,'2016-06-01 14:50:00','Consultation','','sdwds <br /> Consultant : <b>Dr. John</b>','1.39.21.83','1',51,'2016-05-04 12:54:30',51,'2016-05-04 12:54:30','0000-00-00 00:00:00'),(177,58,46,'2016-05-03 05:25:00','Consultation','','Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-04 23:46:55',51,'2016-05-04 23:46:55','0000-00-00 00:00:00'),(178,58,46,'2016-05-03 05:25:00','Consultation','','Consultant : <b>Mrs. Jo</b>','220.158.141.31','1',51,'2016-05-04 23:47:10',51,'2016-05-04 23:47:10','0000-00-00 00:00:00'),(179,58,46,'2016-05-05 00:00:19','Patient Alert','','Patient Alert (pament) added.','220.158.141.31','1',51,'2016-05-05 00:00:19',51,'2016-05-05 00:00:19','0000-00-00 00:00:00'),(180,58,46,'2016-05-05 00:28:06','Casesheet No.','','Casesheet No.: 111ABC Added.','220.158.141.31','1',51,'2016-05-05 00:28:06',51,'2016-05-05 00:28:06','0000-00-00 00:00:00'),(181,58,46,'2016-05-06 10:04:18','Clinical Discharge','Encounter # 122','Patient Clinical Discharged. <br /> Bed No: <b>112 (Deluxe)</b>','220.158.141.31','1',51,'2016-05-05 23:34:21',51,'2016-05-05 23:34:21','0000-00-00 00:00:00'),(182,58,46,'2016-05-06 10:25:25','Bill Finalize','Encounter # 122','Bill Finalized By Dr. Vikhram','220.158.141.31','1',51,'2016-05-05 23:55:25',51,'2016-05-05 23:55:25','0000-00-00 00:00:00'),(183,58,46,'2016-05-06 10:25:33','Bill Authorize','Encounter # 122','Bill Authorize By Dr. Vikhram','220.158.141.31','1',51,'2016-05-05 23:55:33',51,'2016-05-05 23:55:33','0000-00-00 00:00:00'),(184,58,46,'2016-05-06 10:25:43','Administrative Discharge','Encounter # 122','Patient Administrative Discharged. <br /> Bed No: <b>112 (Deluxe)</b>','220.158.141.31','1',51,'2016-05-05 23:55:43',51,'2016-05-05 23:55:43','0000-00-00 00:00:00'),(185,58,46,'2016-05-06 10:25:43','Administrative Discharge','Encounter # 122','Administrative Discharge By Dr. Vikhram','220.158.141.31','1',51,'2016-05-05 23:55:43',51,'2016-05-05 23:55:43','0000-00-00 00:00:00'),(186,58,46,'2016-05-06 01:55:00','Appoinment Booked','Encounter # 125','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-05 23:56:21',51,'2016-05-05 23:56:21','0000-00-00 00:00:00'),(187,58,46,'2016-05-06 01:55:00','Patient Arrived','Encounter # 125','Patient Arrived. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-05 23:56:56',51,'2016-05-05 23:56:56','0000-00-00 00:00:00'),(188,58,46,'2016-05-06 10:27:34','Doctor Seen','Encounter # 125','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-05 23:57:40',51,'2016-05-05 23:57:40','0000-00-00 00:00:00'),(189,58,46,'2016-05-06 10:27:34','Doctor Seen','Encounter # 125','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-05 23:58:30',51,'2016-05-05 23:58:30','0000-00-00 00:00:00'),(190,58,46,'2016-05-06 10:28:42','Patient Admission','Encounter # 126','Patient Admitted. <br /> Bed No: <b>112 (Non AC)</b>','220.158.141.31','1',51,'2016-05-05 23:59:00',51,'2016-05-05 23:59:00','0000-00-00 00:00:00'),(191,58,46,'2016-05-07 13:22:12','Procedure','','Procedure : <b>stomach wash</b>','220.158.141.31','1',51,'2016-05-07 02:52:20',51,'2016-05-07 02:52:20','0000-00-00 00:00:00'),(192,58,46,'2016-05-07 13:22:12','Consultation','','Consulted for Procedure (stomach wash) <br /> Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-07 02:52:20',51,'2016-05-07 02:52:20','0000-00-00 00:00:00'),(193,58,20,'2016-05-07 12:00:00','Appoinment Booked','Encounter # 127','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-07 04:54:42',51,'2016-05-07 04:54:42','0000-00-00 00:00:00'),(194,58,47,'2016-05-09 15:28:56','Patient Registration','','Miss. Niranjana Registered Successfully.','122.164.153.178','1',51,'2016-05-09 04:58:56',51,'2016-05-09 04:58:56','0000-00-00 00:00:00'),(195,58,48,'2016-05-09 18:02:24','Patient Registration','','Mr. Lilly Registered Successfully.','220.158.141.31','1',51,'2016-05-09 07:32:24',51,'2016-05-09 07:32:24','0000-00-00 00:00:00'),(196,58,46,'2016-05-10 18:36:50','Clinical Discharge','Encounter # 126','Patient Clinical Discharged. <br /> Bed No: <b>112 (Non AC)</b>','220.158.141.31','1',51,'2016-05-10 08:06:52',51,'2016-05-10 08:06:52','0000-00-00 00:00:00'),(197,58,46,'2016-05-10 18:37:08','Bill Finalize','Encounter # 126','Bill Finalized By Dr. Vikhram','220.158.141.31','1',51,'2016-05-10 08:07:08',51,'2016-05-10 08:07:08','0000-00-00 00:00:00'),(198,58,46,'2016-05-10 18:37:18','Bill Authorize','Encounter # 126','Bill Authorize By Dr. Vikhram','220.158.141.31','1',51,'2016-05-10 08:07:18',51,'2016-05-10 08:07:18','0000-00-00 00:00:00'),(199,58,46,'2016-05-10 18:37:26','Administrative Discharge','Encounter # 126','Patient Administrative Discharged. <br /> Bed No: <b>112 (Non AC)</b>','220.158.141.31','1',51,'2016-05-10 08:07:26',51,'2016-05-10 08:07:26','0000-00-00 00:00:00'),(200,58,46,'2016-05-10 18:37:26','Administrative Discharge','Encounter # 126','Administrative Discharge By Dr. Vikhram','220.158.141.31','1',51,'2016-05-10 08:07:26',51,'2016-05-10 08:07:26','0000-00-00 00:00:00'),(201,58,46,'2016-05-09 01:05:00','Patient Admission','Encounter # 128','Patient Admitted. <br /> Bed No: <b>112 (Non AC)</b>','220.158.141.31','1',51,'2016-05-10 08:11:19',51,'2016-05-10 08:11:19','0000-00-00 00:00:00'),(202,58,49,'2016-05-11 11:22:35','Patient Registration','','Mr. Sonali Registered Successfully.','220.158.141.31','1',51,'2016-05-11 00:52:35',51,'2016-05-11 00:52:35','0000-00-00 00:00:00'),(203,58,49,'2016-05-11 11:00:00','Appoinment Booked','Encounter # 129','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-11 00:53:17',51,'2016-05-11 00:53:17','0000-00-00 00:00:00'),(204,58,49,'2016-05-11 11:23:00','Patient Arrived','Encounter # 129','Patient Arrived. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-11 00:53:37',51,'2016-05-11 00:53:37','0000-00-00 00:00:00'),(205,58,49,'2016-05-11 11:22:35','Patient Update','','Patient Details Updated Successfully.','220.158.141.31','1',51,'2016-05-11 00:53:53',51,'2016-05-11 00:53:53','0000-00-00 00:00:00'),(206,58,49,'2016-05-11 11:24:04','Doctor Seen','Encounter # 129','Seen by Consultant. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-11 00:54:15',51,'2016-05-11 00:54:15','0000-00-00 00:00:00'),(207,58,49,'2016-05-11 12:00:00','Appoinment Booked','Encounter # 130','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-11 00:56:00',51,'2016-05-11 00:56:00','0000-00-00 00:00:00'),(208,58,49,'2016-05-11 11:26:22','Procedure','','Procedure : <b>stomach wash</b>','220.158.141.31','1',51,'2016-05-11 00:56:31',51,'2016-05-11 00:56:31','0000-00-00 00:00:00'),(209,58,49,'2016-05-11 11:26:22','Consultation','','Consulted for Procedure (stomach wash) <br /> Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-11 00:56:31',51,'2016-05-11 00:56:31','0000-00-00 00:00:00'),(210,58,49,'2016-05-11 11:26:00','Patient Arrived','Encounter # 130','Patient Arrived. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-05-11 00:56:59',51,'2016-05-11 00:56:59','0000-00-00 00:00:00'),(211,58,49,'2016-05-11 15:38:27','Doctor Seen','Encounter # 130','Seen by Consultant. <br />Consultant : <b>Dr. Surya</b>','122.174.127.39','1',51,'2016-05-11 05:08:20',51,'2016-05-11 05:08:20','0000-00-00 00:00:00'),(212,58,42,'2016-05-11 23:47:44','Appointment Cancel','Encounter # 107','Appointment Cancelled. <br />Consultant : <b>Dr. John</b>','1.39.62.238','1',51,'2016-05-11 13:17:47',51,'2016-05-11 13:17:47','0000-00-00 00:00:00'),(213,58,42,'2016-05-11 06:50:00','Appoinment Booked','Encounter # 131','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','1.39.62.238','1',51,'2016-05-11 13:18:28',51,'2016-05-11 13:18:28','0000-00-00 00:00:00'),(214,58,41,'2016-05-11 23:50:10','Appointment Cancel','Encounter # 69','Appointment Cancelled. <br />Consultant : <b>Dr. John</b>','1.39.62.238','1',51,'2016-05-11 13:20:13',51,'2016-05-11 13:20:13','0000-00-00 00:00:00'),(215,58,50,'2016-05-13 16:46:39','Patient Registration','','Mr. pooja Registered Successfully.','122.164.146.92','1',51,'2016-05-13 06:16:39',51,'2016-05-13 06:16:39','0000-00-00 00:00:00'),(216,58,50,'2016-05-13 11:45:00','Appoinment Booked','Encounter # 132','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','122.164.146.92','1',51,'2016-05-13 06:16:47',51,'2016-05-13 06:16:47','0000-00-00 00:00:00'),(217,58,38,'2016-05-13 16:52:57','Appointment Cancel','Encounter # 61','Appointment Cancelled. <br />Consultant : <b>Dr. John</b>','122.164.146.92','1',51,'2016-05-13 06:22:56',51,'2016-05-13 06:22:56','0000-00-00 00:00:00'),(218,58,50,'2016-05-13 16:46:39','Patient Update','','Patient Details Updated Successfully.','122.164.146.92','1',51,'2016-05-13 06:27:45',51,'2016-05-13 06:27:45','0000-00-00 00:00:00'),(219,58,23,'2016-05-20 00:30:00','Appoinment Booked','Encounter # 133','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','122.164.158.143','1',51,'2016-05-20 05:19:26',51,'2016-05-20 05:19:26','0000-00-00 00:00:00'),(220,58,18,'2016-05-27 00:30:00','Appoinment Booked','Encounter # 134','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','122.164.158.143','1',51,'2016-05-20 07:05:58',51,'2016-05-20 07:05:58','0000-00-00 00:00:00'),(221,58,23,'2016-05-20 17:40:00','Patient Arrived','Encounter # 133','Patient Arrived. <br />Consultant : <b>Dr. John</b>','122.164.158.143','1',51,'2016-05-20 07:10:27',51,'2016-05-20 07:10:27','0000-00-00 00:00:00'),(222,58,51,'2016-05-24 09:51:08','Patient Registration','','Mr. Amit Registered Successfully.','122.164.34.104','1',51,'2016-05-23 23:21:08',51,'2016-05-23 23:21:08','0000-00-00 00:00:00'),(223,58,51,'2016-05-23 23:23:07','Casesheet No.','','Casesheet No.: AHA9001 Added.','122.164.34.104','1',51,'2016-05-23 23:23:07',51,'2016-05-23 23:23:07','0000-00-00 00:00:00'),(224,58,51,'2016-05-24 01:00:00','Appoinment Booked','Encounter # 135','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','122.164.34.104','1',51,'2016-05-23 23:23:07',51,'2016-05-23 23:23:07','0000-00-00 00:00:00'),(225,58,51,'2016-05-24 01:00:00','Patient Arrived','Encounter # 135','Patient Arrived. <br />Consultant : <b>Dr. John</b>','122.164.34.104','1',51,'2016-05-23 23:23:52',51,'2016-05-23 23:23:52','0000-00-00 00:00:00'),(226,58,51,'2016-05-24 09:57:05','Appointment Cancel','Encounter # 135','Appointment Cancelled. <br />Consultant : <b>Dr. John</b>','122.164.34.104','1',51,'2016-05-23 23:27:06',51,'2016-05-23 23:27:06','0000-00-00 00:00:00'),(227,58,51,'2016-05-24 01:30:00','Appoinment Booked','Encounter # 136','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','122.164.34.104','1',51,'2016-05-23 23:27:21',51,'2016-05-23 23:27:21','0000-00-00 00:00:00'),(228,58,51,'2016-05-24 09:57:31','Patient Arrived','Encounter # 136','Patient Arrived. <br />Consultant : <b>Dr. John</b>','122.164.34.104','1',51,'2016-05-23 23:27:36',51,'2016-05-23 23:27:36','0000-00-00 00:00:00'),(229,58,51,'2016-05-24 09:57:46','Appointment Cancel','Encounter # 136','Appointment Cancelled. <br />Consultant : <b>Dr. John</b>','122.164.34.104','1',51,'2016-05-23 23:27:46',51,'2016-05-23 23:27:46','0000-00-00 00:00:00'),(230,58,51,'2016-05-24 02:00:00','Appoinment Booked','Encounter # 137','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','122.164.34.104','1',51,'2016-05-23 23:27:58',51,'2016-05-23 23:27:58','0000-00-00 00:00:00'),(231,58,51,'2016-05-24 09:58:06','Patient Arrived','Encounter # 137','Patient Arrived. <br />Consultant : <b>Dr. John</b>','122.164.34.104','1',51,'2016-05-23 23:28:11',51,'2016-05-23 23:28:11','0000-00-00 00:00:00'),(232,58,51,'2016-05-24 09:58:29','Doctor Seen','Encounter # 137','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','122.164.34.104','1',51,'2016-05-23 23:28:35',51,'2016-05-23 23:28:35','0000-00-00 00:00:00'),(233,58,51,'2016-05-24 02:00:00','Appoinment Booked','Encounter # 138','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','122.164.34.104','1',51,'2016-05-23 23:28:45',51,'2016-05-23 23:28:45','0000-00-00 00:00:00'),(234,58,51,'2016-05-24 02:00:00','Patient Arrived','Encounter # 138','Patient Arrived. <br />Consultant : <b>Dr. John</b>','122.164.34.104','1',51,'2016-05-23 23:28:51',51,'2016-05-23 23:28:51','0000-00-00 00:00:00'),(235,58,51,'2016-05-24 09:59:36','Doctor Seen','Encounter # 138','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','122.164.34.104','1',51,'2016-05-23 23:29:45',51,'2016-05-23 23:29:45','0000-00-00 00:00:00'),(236,58,51,'2016-05-24 01:45:00','Appoinment Booked','Encounter # 139','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','122.164.34.104','1',51,'2016-05-23 23:30:07',51,'2016-05-23 23:30:07','0000-00-00 00:00:00'),(237,58,47,'2016-05-23 23:30:44','Casesheet No.','','Casesheet No.: AHA60001 Added.','122.164.34.104','1',51,'2016-05-23 23:30:44',51,'2016-05-23 23:30:44','0000-00-00 00:00:00'),(238,58,47,'2016-05-24 12:00:00','Appoinment Booked','Encounter # 140','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','122.164.34.104','1',51,'2016-05-23 23:30:44',51,'2016-05-23 23:30:44','0000-00-00 00:00:00'),(239,58,46,'2016-04-30 22:35:00','Consultation','','Consultant : <b>Dr. John</b>','122.164.34.104','1',51,'2016-05-23 23:44:52',51,'2016-05-23 23:44:52','0000-00-00 00:00:00'),(240,58,46,'2016-05-24 11:05:27','Procedure','','Procedure : <b>stomach wash</b>','122.164.34.104','1',51,'2016-05-24 00:35:36',51,'2016-05-24 00:35:36','0000-00-00 00:00:00'),(241,58,46,'2016-05-24 11:05:27','Consultation','','Consulted for Procedure (stomach wash) <br /> Consultant : <b>Dr. John</b>','122.164.34.104','1',51,'2016-05-24 00:35:36',51,'2016-05-24 00:35:36','0000-00-00 00:00:00'),(242,58,51,'2016-05-31 15:15:00','Patient Arrived','Encounter # 139','Patient Arrived. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-05-24 03:12:15',51,'2016-05-24 03:12:15','0000-00-00 00:00:00'),(243,58,34,'2016-05-24 13:58:39','Admission Cancel','Encounter # 121','Admission Cancelled','220.158.141.31','1',51,'2016-05-24 03:28:40',51,'2016-05-24 03:28:40','0000-00-00 00:00:00'),(244,58,34,'2016-05-24 13:58:43','Patient Admission','Encounter # 141','Patient Admitted. <br /> Bed No: <b>112 (Suite)</b>','220.158.141.31','1',51,'2016-05-24 03:28:58',51,'2016-05-24 03:28:58','0000-00-00 00:00:00'),(245,58,34,'2016-05-24 14:03:56','Admission Cancel','Encounter # 141','Admission Cancelled','220.158.141.31','1',51,'2016-05-24 03:33:56',51,'2016-05-24 03:33:56','0000-00-00 00:00:00'),(246,58,34,'2016-05-24 14:04:03','Patient Admission','Encounter # 142','Patient Admitted. <br /> Bed No: <b>112 (ac)</b>','220.158.141.31','1',51,'2016-05-24 03:34:14',51,'2016-05-24 03:34:14','0000-00-00 00:00:00'),(247,58,52,'2016-05-31 10:22:44','Patient Registration','','Miss. Swati Registered Successfully.','122.164.153.77','1',51,'2016-05-30 23:52:44',51,'2016-05-30 23:52:44','0000-00-00 00:00:00'),(248,58,52,'2016-05-31 00:21:59','Casesheet No.','','Casesheet No.: AHA5006 Added.','122.164.153.77','1',51,'2016-05-31 00:21:59',51,'2016-05-31 00:21:59','0000-00-00 00:00:00'),(249,58,52,'2016-05-31 12:00:00','Appoinment Booked','Encounter # 143','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','122.164.153.77','1',51,'2016-05-31 00:21:59',51,'2016-05-31 00:21:59','0000-00-00 00:00:00'),(250,58,53,'2016-05-31 10:54:14','Patient Registration','','Mr. Kishore Registered Successfully.','122.164.153.77','1',51,'2016-05-31 00:24:14',51,'2016-05-31 00:24:14','0000-00-00 00:00:00'),(251,58,53,'2016-05-31 00:25:32','Casesheet No.','','Casesheet No.: AHA4002 Added.','122.164.153.77','1',51,'2016-05-31 00:25:32',51,'2016-05-31 00:25:32','0000-00-00 00:00:00'),(252,58,53,'2016-05-31 11:00:00','Appoinment Booked','Encounter # 144','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','122.164.153.77','1',51,'2016-05-31 00:25:32',51,'2016-05-31 00:25:32','0000-00-00 00:00:00'),(253,58,52,'2016-06-01 11:00:00','Appoinment Booked','Encounter # 143','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','122.164.153.77','1',51,'2016-05-31 00:26:29',51,'2016-05-31 00:26:29','0000-00-00 00:00:00'),(254,58,53,'2016-06-01 11:05:00','Appoinment Booked','Encounter # 144','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','122.164.153.77','1',51,'2016-05-31 00:26:29',51,'2016-05-31 00:26:29','0000-00-00 00:00:00'),(255,58,54,'2016-06-06 15:41:50','Patient Registration','','Mr. Rose Registered Successfully.','220.158.141.31','1',51,'2016-06-06 05:11:50',51,'2016-06-06 05:11:50','0000-00-00 00:00:00'),(256,58,54,'2016-06-06 05:12:14','Casesheet No.','','Casesheet No.: UVW12345 Added.','220.158.141.31','1',51,'2016-06-06 05:12:14',51,'2016-06-06 05:12:14','0000-00-00 00:00:00'),(257,58,54,'2016-06-06 12:00:00','Appoinment Booked','Encounter # 145','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-06-06 05:12:14',51,'2016-06-06 05:12:14','0000-00-00 00:00:00'),(258,58,54,'2016-06-07 01:55:00','Appoinment Booked','Encounter # 145','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-06-06 05:15:09',51,'2016-06-06 05:15:09','0000-00-00 00:00:00'),(259,58,55,'2016-06-06 15:50:38','Patient Registration','','Mrs. Rihaana Registered Successfully.','220.158.141.31','1',51,'2016-06-06 05:20:38',51,'2016-06-06 05:20:38','0000-00-00 00:00:00'),(260,58,55,'2016-06-06 05:20:53','Casesheet No.','','Casesheet No.: DSS3434 Added.','220.158.141.31','1',51,'2016-06-06 05:20:53',51,'2016-06-06 05:20:53','0000-00-00 00:00:00'),(261,58,55,'2016-06-06 02:00:00','Appoinment Booked','Encounter # 146','Appoinment Booked. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-06-06 05:20:53',51,'2016-06-06 05:20:53','0000-00-00 00:00:00'),(262,58,54,'2016-06-06 15:55:00','Patient Arrived','Encounter # 145','Patient Arrived. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-06-06 05:25:30',51,'2016-06-06 05:25:30','0000-00-00 00:00:00'),(263,58,54,'2016-06-06 15:58:27','Doctor Seen','Encounter # 145','Seen by Consultant. <br />Consultant : <b>Dr. John</b>','220.158.141.31','1',51,'2016-06-06 05:28:33',51,'2016-06-06 05:28:33','0000-00-00 00:00:00'),(264,58,56,'2016-06-09 10:17:32','Patient Registration','','Mr. Yash Registered Successfully.','220.158.141.31','1',51,'2016-06-08 23:47:32',51,'2016-06-08 23:47:32','0000-00-00 00:00:00'),(265,58,56,'2016-06-09 00:04:09','Casesheet No.','','Casesheet No.: ADBN2300 Added.','220.158.141.31','1',51,'2016-06-09 00:04:09',51,'2016-06-09 00:04:09','0000-00-00 00:00:00'),(266,58,56,'2016-06-09 12:00:00','Appoinment Booked','Encounter # 147','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-06-09 00:04:09',51,'2016-06-09 00:04:09','0000-00-00 00:00:00'),(267,58,56,'2016-06-09 10:17:32','Patient Update','','Patient Details Updated Successfully.','220.158.141.31','1',51,'2016-06-09 00:04:48',51,'2016-06-09 00:04:48','0000-00-00 00:00:00'),(268,58,56,'2016-06-09 10:17:32','Patient Update','','Patient Details Updated Successfully.','220.158.141.31','1',51,'2016-06-09 00:05:29',51,'2016-06-09 00:05:29','0000-00-00 00:00:00'),(269,58,56,'2016-06-09 10:52:00','Patient Arrived','Encounter # 147','Patient Arrived. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-06-09 00:22:27',51,'2016-06-09 00:22:27','0000-00-00 00:00:00'),(270,58,56,'2016-06-09 10:52:32','Doctor Seen','Encounter # 147','Seen by Consultant. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-06-09 00:22:41',51,'2016-06-09 00:22:41','0000-00-00 00:00:00'),(271,58,57,'2016-06-11 15:30:22','Patient Registration','','Mr. sdsd Registered Successfully.','220.158.141.31','1',51,'2016-06-11 05:00:22',51,'2016-06-11 05:00:22','0000-00-00 00:00:00'),(272,58,57,'2016-06-11 05:00:52','Casesheet No.','','Casesheet No.: opopop Added.','220.158.141.31','1',51,'2016-06-11 05:00:52',51,'2016-06-11 05:00:52','0000-00-00 00:00:00'),(273,58,57,'2016-06-11 12:00:00','Appoinment Booked','Encounter # 148','Appoinment Booked. <br />Consultant : <b>Dr. Surya</b>','220.158.141.31','1',51,'2016-06-11 05:00:52',51,'2016-06-11 05:00:52','0000-00-00 00:00:00'),(274,58,34,'2016-06-11 06:02:50','Casesheet No.','','Casesheet No.: 45454 Added.','220.158.141.31','1',51,'2016-06-11 06:02:50',51,'2016-06-11 06:02:50','0000-00-00 00:00:00'),(275,58,34,'2016-06-11 06:03:20','Patient Alert','','Patient Alert (hi) added.','220.158.141.31','1',51,'2016-06-11 06:03:20',51,'2016-06-11 06:03:20','0000-00-00 00:00:00'),(276,58,34,'2016-06-11 06:03:59','Patient Alert','','Patient Alert (ppp) added.','220.158.141.31','1',51,'2016-06-11 06:03:59',51,'2016-06-11 06:03:59','0000-00-00 00:00:00'),(277,58,46,'2016-06-15 05:17:01','Casesheet No.','','Casesheet No.: 435345 Added.','220.158.141.31','1',51,'2016-06-15 05:17:01',51,'2016-06-15 05:17:01','0000-00-00 00:00:00'),(278,58,34,'2016-02-19 07:18:51','Patient Update','','Patient Details Updated Successfully.','220.158.141.31','1',51,'2016-06-15 05:19:59',51,'2016-06-15 05:19:59','0000-00-00 00:00:00'),(279,58,46,'2016-06-16 12:31:19','Casesheet No.','','Casesheet No.: 4353 Added.','223.234.134.81','1',51,'2016-06-16 12:31:19',51,'2016-06-16 12:31:19','0000-00-00 00:00:00'),(280,58,46,'2016-06-16 23:13:20','Procedure','','fszf <br /> Procedure : <b>stomach wash</b>','223.234.134.81','1',51,'2016-06-16 12:43:43',51,'2016-06-16 12:43:43','0000-00-00 00:00:00'),(281,58,46,'2016-06-16 23:13:20','Consultation','','Consulted for Procedure (stomach wash) <br /> Consultant : <b>Mrs. Jo</b>','223.234.134.81','1',51,'2016-06-16 12:43:43',51,'2016-06-16 12:43:43','0000-00-00 00:00:00'),(282,58,46,'2016-06-16 23:13:20','Consultation','','Consulted for Procedure (stomach wash) <br /> Consultant : <b>Dr. Surya</b>','223.234.134.81','1',51,'2016-06-16 12:43:43',51,'2016-06-16 12:43:43','0000-00-00 00:00:00'),(283,58,46,'2016-06-16 23:13:20','Consultation','','Consulted for Procedure (stomach wash) <br /> Consultant : <b>Dr. John</b>','223.234.134.81','1',51,'2016-06-16 12:43:43',51,'2016-06-16 12:43:43','0000-00-00 00:00:00'),(284,58,46,'2016-06-16 12:44:46','Patient Alert','','Patient Alert (3232sdsds) added.','223.234.134.81','1',51,'2016-06-16 12:44:46',51,'2016-06-16 12:44:46','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `pat_vitals` */

insert  into `pat_vitals`(`vital_id`,`tenant_id`,`encounter_id`,`patient_id`,`vital_time`,`temperature`,`blood_pressure`,`pulse_rate`,`weight`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,101,42,'2016-04-25 14:38:31','100dsfgsdf','120','2342','sdfsf','1',51,'2016-04-25 04:08:56',51,'2016-04-25 04:08:56','0000-00-00 00:00:00'),(2,58,101,42,'2016-04-25 14:39:43','100','120/80','12','212','1',51,'2016-04-25 04:10:05',51,'2016-04-25 04:10:05','0000-00-00 00:00:00'),(3,58,106,37,'2016-04-28 11:25:32','100','111','11','122','1',51,'2016-04-28 00:55:46',51,'2016-04-28 00:55:46','0000-00-00 00:00:00'),(4,58,106,37,'2016-04-28 11:25:50','sadf','sdf','asdf','sdf','1',51,'2016-04-28 00:55:57',51,'2016-04-28 00:55:57','0000-00-00 00:00:00'),(5,58,105,34,'2016-04-28 14:57:25','70','788','77','70','1',51,'2016-04-28 04:28:21',51,'2016-04-28 04:28:21','0000-00-00 00:00:00'),(6,58,117,37,'2016-06-15 18:22:17','23','4345','4545','4545','1',51,'2016-06-15 07:53:16',51,'2016-06-15 07:53:16','0000-00-00 00:00:00'),(7,58,117,37,'2016-06-15 18:23:28','34','53434','345345345345','34534534','1',51,'2016-06-15 07:53:40',51,'2016-06-15 07:53:40','0000-00-00 00:00:00'),(8,58,128,46,'2016-06-16 22:57:27','23','23','3','333','1',51,'2016-06-16 12:27:40',51,'2016-06-16 12:27:40','0000-00-00 00:00:00'),(9,58,128,46,'2016-06-16 22:57:48','11','1111','11','111','1',51,'2016-06-16 12:28:08',51,'2016-06-16 12:28:08','0000-00-00 00:00:00'),(10,58,128,46,'2016-06-16 23:00:17','323','32','2234','444','1',51,'2016-06-16 12:30:29',51,'2016-06-16 12:30:29','0000-00-00 00:00:00'),(11,58,128,46,'2016-06-16 23:00:43','23','5','45','44','1',51,'2016-06-16 12:30:54',51,'2016-06-16 12:30:54','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Data for the table `pha_brand` */

insert  into `pha_brand`(`brand_id`,`tenant_id`,`brand_name`,`brand_code`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'test','test','1',51,'2016-03-14 05:35:44',NULL,'2016-03-14 05:35:48','0000-00-00 00:00:00'),(2,58,'SUN','SN12345','1',51,'2016-03-22 01:18:13',51,'2016-03-22 01:18:13','0000-00-00 00:00:00'),(3,58,'ABBOT','AB89459','1',51,'2016-03-22 01:18:27',51,'2016-03-22 01:18:27','0000-00-00 00:00:00'),(4,58,'CIPLA','CP46584','1',51,'2016-03-22 01:18:42',NULL,'2016-03-26 06:24:21','0000-00-00 00:00:00'),(5,58,'test','3434','1',51,'2016-03-23 01:52:33',51,'2016-03-23 01:52:33','0000-00-00 00:00:00'),(6,58,'linux','9','1',51,'2016-05-07 06:30:38',51,'2016-05-07 06:30:38','0000-00-00 00:00:00'),(7,58,'torrent','10','1',51,'2016-05-07 06:31:02',51,'2016-05-07 06:31:02','0000-00-00 00:00:00'),(8,58,'vegus','11','0',51,'2016-05-07 06:34:39',51,'2016-05-07 06:34:39','0000-00-00 00:00:00'),(9,58,'fdc','78','1',51,'2016-05-07 06:46:05',51,'2016-05-07 06:46:05','0000-00-00 00:00:00'),(10,58,'USV','1','1',51,'2016-05-07 06:47:56',51,'2016-05-07 06:47:56','0000-00-00 00:00:00'),(11,58,'FOURTS','67','1',51,'2016-05-07 06:50:25',51,'2016-05-07 06:50:25','0000-00-00 00:00:00'),(12,58,'la pharma','56','1',51,'2016-05-08 05:44:24',51,'2016-05-08 05:44:24','0000-00-00 00:00:00'),(13,58,'icon','5','1',51,'2016-05-08 05:55:22',51,'2016-05-08 05:55:22','0000-00-00 00:00:00'),(14,58,'la pharma','34','1',51,'2016-05-08 06:05:55',51,'2016-05-08 06:05:55','0000-00-00 00:00:00'),(15,58,'knesiss','34','1',51,'2016-05-09 05:48:45',51,'2016-05-09 05:48:45','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `pha_brand_division` */

insert  into `pha_brand_division`(`division_id`,`tenant_id`,`division_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'division1','1',51,'2016-03-14 05:36:29',51,'2016-03-14 05:39:12','0000-00-00 00:00:00'),(2,58,'General Health','1',51,'2016-03-22 01:06:02',51,'2016-03-22 01:06:14','0000-00-00 00:00:00'),(3,58,'SYNERGY','1',51,'2016-03-22 01:26:42',51,'2016-03-22 01:26:42','0000-00-00 00:00:00'),(4,58,'Ortho','1',51,'2016-03-23 01:53:06',51,'2016-03-23 01:53:06','0000-00-00 00:00:00'),(5,58,'DIABETIC','1',51,'2016-05-07 06:48:20',51,'2016-05-07 06:48:20','0000-00-00 00:00:00'),(6,58,'anxiety','1',51,'2016-05-08 05:46:20',51,'2016-05-08 05:46:20','0000-00-00 00:00:00'),(7,58,'icon','1',51,'2016-05-08 05:55:47',51,'2016-05-08 05:55:47','0000-00-00 00:00:00'),(8,58,'sun','1',51,'2016-05-09 05:35:11',51,'2016-05-09 05:35:11','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `pha_brand_representative` */

insert  into `pha_brand_representative`(`rep_id`,`tenant_id`,`brand_id`,`division_id`,`rep_1_name`,`rep_1_contact`,`rep_1_designation`,`rep_2_name`,`rep_2_contact`,`rep_2_designation`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,1,1,'test1','test1','test1','test2','test2','test2','1',51,'2016-03-14 05:42:37',51,'2016-03-14 05:42:37','0000-00-00 00:00:00'),(2,58,2,2,'Ramesh','32423423453','Senior Rep Exec',NULL,NULL,NULL,'1',51,'2016-03-22 01:20:27',51,'2016-03-22 01:22:00','0000-00-00 00:00:00'),(3,58,4,2,'Rohan','9589398499','Rep',NULL,NULL,NULL,'1',51,'2016-03-22 01:21:52',51,'2016-03-22 01:21:52','0000-00-00 00:00:00'),(4,58,3,2,'Shankar','55555555','exec',NULL,NULL,NULL,'1',51,'2016-03-22 01:23:29',51,'2016-03-22 01:23:29','0000-00-00 00:00:00'),(5,58,4,3,'Deepak','435345345','representative',NULL,NULL,NULL,'1',51,'2016-03-22 01:27:14',51,'2016-03-22 01:27:14','0000-00-00 00:00:00');

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
  CONSTRAINT `FK_pha_drug_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `pha_drug_class` */

insert  into `pha_drug_class`(`drug_class_id`,`tenant_id`,`drug_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'class1','1',51,'2016-03-14 05:36:40',NULL,'2016-03-14 05:40:27','0000-00-00 00:00:00'),(2,58,'ANALGESICS &ANTIPYETICS','1',51,'2016-03-22 01:09:44',51,'2016-03-22 01:09:44','0000-00-00 00:00:00'),(3,58,'ANTIPSYCHOTICS','1',51,'2016-03-22 01:09:55',51,'2016-03-22 01:09:55','0000-00-00 00:00:00'),(4,58,'PENICILLINS','1',51,'2016-03-22 01:10:04',51,'2016-03-22 01:10:04','0000-00-00 00:00:00'),(5,58,'anxiety','1',51,'2016-05-08 05:58:23',51,'2016-05-08 05:58:23','0000-00-00 00:00:00'),(6,58,'antibiotic','1',51,'2016-05-08 05:58:41',51,'2016-05-08 05:58:41','0000-00-00 00:00:00'),(7,58,'antidepression','1',51,'2016-05-08 05:59:07',51,'2016-05-08 05:59:07','0000-00-00 00:00:00'),(8,58,'szchizopernia','1',51,'2016-05-08 06:00:36',51,'2016-05-08 06:00:36','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `pha_drug_generic` */

insert  into `pha_drug_generic`(`drug_generic_id`,`tenant_id`,`drug_class_id`,`generic_id`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,1,1,'1',51,'2016-03-14 05:40:54',51,'2016-03-14 05:40:54','0000-00-00 00:00:00'),(2,58,3,2,'1',51,'2016-03-22 01:10:58',51,'2016-03-22 01:10:58','0000-00-00 00:00:00'),(3,58,3,3,'1',51,'2016-03-22 01:10:58',51,'2016-03-22 01:10:58','0000-00-00 00:00:00'),(5,58,3,5,'1',51,'2016-03-22 01:10:58',51,'2016-03-22 01:10:58','0000-00-00 00:00:00'),(6,58,3,4,'1',51,'2016-03-22 01:11:46',51,'2016-03-22 01:11:46','0000-00-00 00:00:00');

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
  CONSTRAINT `FK_pha_brand_generic_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `pha_generic` */

insert  into `pha_generic`(`generic_id`,`tenant_id`,`generic_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'generic 1','1',51,'2016-03-14 05:40:06',51,'2016-03-14 05:40:06','0000-00-00 00:00:00'),(2,58,'MULTIVITAMINS WITH MINERALS','1',51,'2016-03-22 01:06:41',51,'2016-03-22 01:09:22','0000-00-00 00:00:00'),(3,58,'OXAZEPAM','1',51,'2016-03-22 01:06:51',51,'2016-03-22 01:09:09','0000-00-00 00:00:00'),(4,58,'METADOXINE','1',51,'2016-03-22 01:07:02',51,'2016-03-22 01:08:59','0000-00-00 00:00:00'),(5,58,'IRON FOLIC ACID VITAMIN B & ZINC','1',51,'2016-03-22 01:07:51',51,'2016-03-22 01:08:48','0000-00-00 00:00:00'),(6,58,'Timber','1',51,'2016-03-22 02:11:40',51,'2016-03-22 02:11:40','0000-00-00 00:00:00'),(7,58,'Folic acid','1',51,'2016-03-23 01:53:28',51,'2016-03-23 01:53:28','0000-00-00 00:00:00'),(8,58,'clozapine','1',51,'2016-05-07 06:37:11',51,'2016-05-07 06:37:11','0000-00-00 00:00:00'),(9,58,'flunarazine','1',51,'2016-05-07 06:46:39',51,'2016-05-07 06:46:39','0000-00-00 00:00:00'),(10,58,'METFORMIN','1',51,'2016-05-07 06:48:43',51,'2016-05-07 06:48:43','0000-00-00 00:00:00'),(11,58,'nitrazepam','1',51,'2016-05-08 05:46:41',51,'2016-05-08 05:46:41','0000-00-00 00:00:00'),(12,58,'lorazepam','1',51,'2016-05-08 06:06:40',51,'2016-05-08 06:06:40','0000-00-00 00:00:00');

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

insert  into `pha_package_unit`(`package_id`,`tenant_id`,`package_name`,`package_unit`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'10s','10','1',51,'2016-03-14 05:41:50',51,'2016-03-14 05:41:50','0000-00-00 00:00:00'),(2,58,'15s','15','1',51,'2016-03-14 05:42:00',51,'2016-03-14 05:42:00','0000-00-00 00:00:00'),(3,58,'12s','12','0',51,'2016-03-22 01:14:49',NULL,'2016-03-22 01:15:37','0000-00-00 00:00:00'),(4,58,'10s','1','1',51,'2016-05-07 06:38:00',51,'2016-05-07 06:38:00','0000-00-00 00:00:00'),(5,58,'1.s','1.','1',51,'2016-05-07 06:38:31',51,'2016-05-07 06:38:31','0000-00-00 00:00:00');

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
  `product_reorder` smallint(6) NOT NULL,
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
  CONSTRAINT `FK_pha_product_brand` FOREIGN KEY (`brand_id`) REFERENCES `pha_brand` (`brand_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_description` FOREIGN KEY (`product_description_id`) REFERENCES `pha_product_description` (`description_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_division` FOREIGN KEY (`division_id`) REFERENCES `pha_brand_division` (`division_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_generic` FOREIGN KEY (`generic_id`) REFERENCES `pha_generic` (`generic_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_purchase_packing_unit` FOREIGN KEY (`purchase_package_id`) REFERENCES `pha_package_unit` (`package_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_purchase_vat` FOREIGN KEY (`purchase_vat_id`) REFERENCES `pha_vat` (`vat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_sales_packing_unit` FOREIGN KEY (`sales_package_id`) REFERENCES `pha_package_unit` (`package_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_sales_vat` FOREIGN KEY (`sales_vat_id`) REFERENCES `pha_vat` (`vat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_product_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Data for the table `pha_product` */

insert  into `pha_product`(`product_id`,`tenant_id`,`product_code`,`product_name`,`product_unit`,`product_unit_count`,`product_description_id`,`product_reorder`,`product_price`,`product_location`,`brand_id`,`division_id`,`generic_id`,`drug_class_id`,`purchase_vat_id`,`purchase_package_id`,`sales_vat_id`,`sales_package_id`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'0AZPIY','test','ML','1',1,50,'40.00','223',1,1,1,1,1,1,1,1,'1',51,'2016-03-14 05:43:44',51,'2016-03-14 05:43:44','0000-00-00 00:00:00'),(2,58,'LHIWD2','BEXOL DT','MG','1',2,50,'100.00',NULL,2,3,2,3,1,1,2,1,'1',51,'2016-03-22 02:07:38',51,'2016-03-22 02:07:38','0000-00-00 00:00:00'),(3,58,'PAEFK8','Crocin','MG','1',2,50,'300.00',NULL,2,2,2,3,2,1,2,1,'1',51,'2016-03-22 23:22:23',51,'2016-03-22 23:22:23','0000-00-00 00:00:00'),(4,58,'LG6RDL','Coldmine','ML','1',5,50,'800.00',NULL,4,3,3,3,3,2,3,2,'1',51,'2016-03-22 23:40:09',51,'2016-03-22 23:40:09','0000-00-00 00:00:00'),(5,58,'A7CAZH','Metformin','MG','1',2,50,'1000.00',NULL,3,3,5,3,4,2,3,2,'1',51,'2016-03-22 23:43:33',51,'2016-03-22 23:43:33','0000-00-00 00:00:00'),(6,58,'IUGOP4','zaporil 100','MG','100',2,50,'0.00','12',3,2,8,NULL,1,1,1,5,'0',51,'2016-05-07 06:38:40',51,'2016-05-07 06:38:40','0000-00-00 00:00:00'),(7,58,'TDTNFA','flunarin 5mg','MG','100',2,50,'0.00','43',9,2,9,NULL,1,1,1,5,'1',51,'2016-05-07 06:46:48',51,'2016-05-07 06:46:48','0000-00-00 00:00:00'),(8,58,'NOVH06','GLYCOMET 500MG','MG','100',2,50,'0.00','42',10,5,10,NULL,1,1,1,5,'1',51,'2016-05-07 06:48:52',51,'2016-05-07 06:48:52','0000-00-00 00:00:00'),(9,58,'QTHNYK','NEFROSAVE','MG','100',2,50,'0.00','41',11,2,4,3,1,1,1,5,'1',51,'2016-05-07 06:51:14',51,'2016-05-07 06:51:14','0000-00-00 00:00:00'),(10,58,'TDSQOR','FLUNARINE','MG','10',2,50,'0.00','41',9,2,9,1,1,1,1,5,'1',51,'2016-05-07 06:52:26',51,'2016-05-07 06:52:26','0000-00-00 00:00:00'),(11,58,'8LZDR9','nipam','MG','10',2,500,'0.00','58',12,6,11,NULL,1,1,1,5,'1',51,'2016-05-08 05:47:03',51,'2016-05-08 05:47:03','0000-00-00 00:00:00'),(12,58,'LL7PKV','zaporil','MG','50',2,50,'0.00','59',13,7,8,NULL,1,1,1,5,'1',51,'2016-05-08 05:56:02',51,'2016-05-08 05:56:02','0000-00-00 00:00:00'),(13,58,'I1VGHN','zepnap 2mg','MG','10',2,50,'0.00','60',14,1,12,NULL,1,1,1,5,'1',51,'2016-05-08 06:07:31',51,'2016-05-08 06:07:31','0000-00-00 00:00:00'),(14,58,'VF6WFA','abdifer','MG','10',3,200,'0.00','1',15,2,5,3,5,1,5,1,'1',51,'2016-05-09 05:50:17',51,'2016-05-09 05:50:17','0000-00-00 00:00:00'),(15,58,'2B0VZC','ILOBRIL','MG','2',2,50,'0.00',NULL,11,4,7,NULL,2,1,2,1,'1',51,'2016-05-09 23:14:21',51,'2016-05-09 23:14:21','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

/*Data for the table `pha_product_batch` */

insert  into `pha_product_batch`(`batch_id`,`tenant_id`,`product_id`,`batch_no`,`expiry_date`,`total_qty`,`available_qty`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,1,'kkkkkk','2016-03-01',57,35,'1',51,'2016-03-15 09:24:44',51,'2016-04-07 07:59:30','0000-00-00 00:00:00'),(2,58,1,'www','2016-08-01',5800,5457,'1',51,'2016-03-17 01:26:56',51,'2016-03-17 06:44:38','0000-00-00 00:00:00'),(3,58,1,'ed','2016-01-01',200,197,'1',51,'2016-03-17 01:38:48',51,'2016-05-30 12:33:26','0000-00-00 00:00:00'),(4,58,1,'wwq','2016-04-01',44,44,'1',51,'2016-03-17 01:38:48',51,'2016-03-17 01:38:48','0000-00-00 00:00:00'),(5,58,3,'1234','2017-12-01',12,12,'1',51,'2016-03-22 23:36:07',51,'2016-05-06 05:55:42','0000-00-00 00:00:00'),(6,58,2,'7887','2017-11-01',50,-17,'1',51,'2016-03-22 23:36:07',51,'2016-06-13 06:07:22','0000-00-00 00:00:00'),(7,58,5,'uvwxyz12345','2018-09-01',10,10,'1',51,'2016-03-22 23:48:53',51,'2016-03-22 23:48:53','0000-00-00 00:00:00'),(8,58,2,'122','2016-04-01',34,24,'1',51,'2016-04-26 05:02:37',51,'2016-06-13 06:08:31','0000-00-00 00:00:00'),(9,58,5,'uvwxyz12345','2016-10-01',336,336,'1',51,'2016-04-30 09:29:20',51,'2016-04-30 09:29:20','0000-00-00 00:00:00'),(10,58,3,'eee','2016-08-01',18,18,'1',51,'2016-05-05 00:13:58',51,'2016-05-05 00:13:58','0000-00-00 00:00:00'),(11,58,6,'1601','2017-12-01',142,92,'1',51,'2016-05-07 06:43:12',51,'2016-05-10 01:32:00','0000-00-00 00:00:00'),(12,58,2,'124','2018-05-01',6,6,'1',51,'2016-05-07 06:43:12',51,'2016-05-07 06:43:12','0000-00-00 00:00:00'),(13,58,2,'gkt291','2016-12-01',49,49,'1',51,'2016-05-09 03:46:52',51,'2016-05-09 03:46:52','0000-00-00 00:00:00'),(14,58,3,'gtk2435','2016-12-01',79,79,'1',51,'2016-05-09 03:52:01',51,'2016-05-09 03:52:01','0000-00-00 00:00:00'),(15,58,4,'568','2016-05-01',58,25,'1',51,'2016-05-09 03:59:10',51,'2016-05-30 12:33:26','0000-00-00 00:00:00'),(16,58,15,'ddd','2016-12-01',20,20,'1',51,'2016-05-09 23:17:14',51,'2016-05-09 23:17:14','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

/*Data for the table `pha_product_batch_rate` */

insert  into `pha_product_batch_rate`(`batch_rate_id`,`tenant_id`,`batch_id`,`mrp`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,1,'150.00','1',51,'2016-03-15 09:24:44',51,'2016-04-02 00:01:49','0000-00-00 00:00:00'),(2,58,2,'23.00','1',51,'2016-03-17 01:26:56',51,'2016-03-17 01:39:29','0000-00-00 00:00:00'),(3,58,3,'60.00','1',51,'2016-03-17 01:38:48',51,'2016-03-17 01:38:48','0000-00-00 00:00:00'),(4,58,4,'50.00','1',51,'2016-03-17 01:38:48',51,'2016-03-17 01:38:48','0000-00-00 00:00:00'),(5,58,5,'500.00','1',51,'2016-03-22 23:36:07',51,'2016-05-06 05:55:42','0000-00-00 00:00:00'),(6,58,6,'500.00','1',51,'2016-03-22 23:36:07',51,'2016-05-05 00:11:13','0000-00-00 00:00:00'),(7,58,7,'1200.00','1',51,'2016-03-22 23:48:53',51,'2016-03-22 23:48:53','0000-00-00 00:00:00'),(8,58,8,'100.00','1',51,'2016-04-26 05:02:37',51,'2016-05-07 01:29:44','0000-00-00 00:00:00'),(9,58,9,'3.00','1',51,'2016-04-30 09:29:20',51,'2016-04-30 09:29:20','0000-00-00 00:00:00'),(10,58,10,'10.00','1',51,'2016-05-05 00:13:58',51,'2016-05-05 00:13:58','0000-00-00 00:00:00'),(11,58,11,'85.00','1',51,'2016-05-07 06:43:12',51,'2016-05-10 00:42:00','0000-00-00 00:00:00'),(12,58,12,'100.00','1',51,'2016-05-07 06:43:12',51,'2016-05-07 06:43:12','0000-00-00 00:00:00'),(13,58,13,'89.00','1',51,'2016-05-09 03:46:52',51,'2016-05-09 03:46:52','0000-00-00 00:00:00'),(14,58,14,'78.00','1',51,'2016-05-09 03:52:01',51,'2016-05-09 03:52:01','0000-00-00 00:00:00'),(15,58,15,'45.00','1',51,'2016-05-09 03:59:10',51,'2016-05-09 03:59:10','0000-00-00 00:00:00'),(16,58,16,'12.00','1',51,'2016-05-09 23:17:14',51,'2016-05-09 23:17:14','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `pha_product_description` */

insert  into `pha_product_description`(`description_id`,`tenant_id`,`description_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'IP','1',51,'2016-03-14 05:41:17',51,'2016-03-14 05:41:17','0000-00-00 00:00:00'),(2,58,'tablet','1',51,'2016-03-22 01:12:03',51,'2016-03-22 01:12:03','0000-00-00 00:00:00'),(3,58,'capsule','1',51,'2016-03-22 01:12:11',51,'2016-03-22 01:12:11','0000-00-00 00:00:00'),(4,58,'spray','1',51,'2016-03-22 01:12:20',51,'2016-03-22 01:12:20','0000-00-00 00:00:00'),(5,58,'syrup','1',51,'2016-03-22 02:09:17',51,'2016-03-22 02:09:17','0000-00-00 00:00:00'),(6,58,'434www','1',51,'2016-03-23 01:51:45',51,'2016-03-23 01:51:45','0000-00-00 00:00:00'),(7,58,'nitrazepam','1',51,'2016-05-08 05:43:27',51,'2016-05-08 05:43:27','0000-00-00 00:00:00');

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
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`purchase_id`),
  KEY `FK_pha_purchase_tenant` (`tenant_id`),
  KEY `FK_pha_purchase_supplier` (`supplier_id`),
  CONSTRAINT `FK_pha_purchase_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `pha_supplier` (`supplier_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pha_purchase_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

/*Data for the table `pha_purchase` */

insert  into `pha_purchase`(`purchase_id`,`tenant_id`,`purchase_code`,`invoice_date`,`invoice_no`,`payment_type`,`supplier_id`,`total_item_purchase_amount`,`total_item_vat_amount`,`total_item_discount_amount`,`before_disc_amount`,`discount_percent`,`discount_amount`,`after_disc_amount`,`roundoff_amount`,`net_amount`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'PU0000001','2016-03-15','123456','CA',1,'100.00','5.00','0.00','105.00',NULL,'0.00','105.00','0.00','105.00','1',51,'2016-03-15 09:24:44',51,'2016-03-15 09:24:44','0000-00-00 00:00:00'),(2,58,'PU0000002','2016-03-17','22323','CR',1,'3783.00','195.00','117.00','3978.00','4.00','151.32','3826.68','0.32','3827.00','1',51,'2016-03-17 01:26:56',51,'2016-03-17 01:26:56','0000-00-00 00:00:00'),(3,58,'PU0000003','2016-03-17','test1','CR',1,'4750.00','250.00','250.00','5000.00','2.00','95.00','4905.00','0.00','4905.00','1',51,'2016-03-17 01:28:12',51,'2016-03-17 01:39:29','0000-00-00 00:00:00'),(4,58,'PU0000004','2016-03-17','test1','CR',1,'11982.96','622.60','469.04','12605.56','34.00','4074.21','8531.35','0.35','8531.00','1',51,'2016-03-17 01:38:48',51,'2016-03-17 01:38:48','0000-00-00 00:00:00'),(5,58,'PU0000005','2016-03-23','3333','CA',2,'5700.00','450.00','300.00','6150.00','12.00','684.00','5466.00','0.00','5466.00','1',51,'2016-03-22 23:36:07',51,'2016-03-22 23:37:50','0000-00-00 00:00:00'),(6,58,'PU0000006','2016-03-23','34434','CR',3,'9000.00','863.00','1000.00','9863.00','10.00','900.00','8963.00','0.00','8963.00','1',51,'2016-03-22 23:48:53',51,'2016-03-22 23:48:53','0000-00-00 00:00:00'),(7,58,'PU0000007','2016-04-02','2232','CR',2,'220.00','11.00','0.00','231.00',NULL,'0.00','231.00','0.00','231.00','1',51,'2016-04-02 00:01:48',51,'2016-04-02 00:01:48','0000-00-00 00:00:00'),(8,58,'PU0000008','2016-04-26','111','CA',2,'960.00','48.00','0.00','1008.00',NULL,'0.00','1008.00','0.00','1008.00','1',51,'2016-04-26 05:02:37',51,'2016-04-26 05:02:37','0000-00-00 00:00:00'),(9,58,'PU0000009','2016-04-30','3322','CA',3,'6.00','0.52','0.00','6.52',NULL,'0.00','6.52','0.48','7.00','1',51,'2016-04-30 09:29:20',51,'2016-04-30 09:29:20','0000-00-00 00:00:00'),(10,58,'PU0000010','2016-05-03','444','CA',3,'500.00','25.00','0.00','525.00',NULL,'0.00','525.00','0.00','525.00','1',51,'2016-05-03 00:05:07',51,'2016-05-03 00:09:35','0000-00-00 00:00:00'),(11,58,'PU0000011','2016-05-05','333','CR',2,'50.00','2.50','0.00','52.50',NULL,'0.00','52.50','0.50','53.00','1',51,'2016-05-05 00:11:13',51,'2016-05-05 00:11:13','0000-00-00 00:00:00'),(12,58,'PU0000012','2016-05-05','333','CR',2,'80.00','8.00','0.00','88.00',NULL,'0.00','88.00','0.00','88.00','1',51,'2016-05-05 00:13:58',51,'2016-05-05 00:13:58','0000-00-00 00:00:00'),(13,58,'PU0000013','2016-05-06','123456','CA',2,'400.00','40.00','0.00','440.00',NULL,'0.00','440.00','0.00','440.00','1',51,'2016-05-06 05:55:42',51,'2016-05-06 05:55:42','0000-00-00 00:00:00'),(14,58,'PU0000014','2016-05-07','123','CR',2,'784.00','40.00','16.00','824.00',NULL,'0.00','824.00','0.00','824.00','1',51,'2016-05-07 01:29:44',51,'2016-05-07 01:29:44','0000-00-00 00:00:00'),(15,58,'PU0000015','2016-05-07','12787','CA',4,'1525.12','77.94','33.68','1603.06',NULL,'0.00','1603.06','0.06','1603.00','1',51,'2016-05-07 06:43:12',51,'2016-05-07 06:43:12','0000-00-00 00:00:00'),(16,58,'PU0000016','2016-05-09','2580','CA',2,'848.75','43.75','26.25','892.50','2.00','16.98','875.52','0.48','876.00','1',51,'2016-05-09 03:46:52',51,'2016-05-09 03:46:52','0000-00-00 00:00:00'),(17,58,'PU0000017','2016-05-09','2580','CA',2,'4280.64','436.80','87.36','4717.44','2.00','85.61','4631.83','0.17','4632.00','1',51,'2016-05-09 03:52:01',51,'2016-05-09 03:52:01','0000-00-00 00:00:00'),(18,58,'PU0000018','2016-05-09','23','CA',5,'1543.50','196.88','31.50','1740.38','2.00','30.87','1709.51','0.49','1710.00','1',51,'2016-05-09 03:59:10',51,'2016-05-09 03:59:10','0000-00-00 00:00:00'),(19,58,'PU0000019','2016-05-10','123','CA',6,'100.00','10.00','0.00','110.00',NULL,'0.00','110.00','0.00','110.00','1',51,'2016-05-09 23:17:14',51,'2016-05-09 23:17:14','0000-00-00 00:00:00'),(20,58,'PU0000020','2016-05-10','3333','CA',6,'90.00','5.00','10.00','95.00',NULL,'0.00','95.00','0.00','95.00','1',51,'2016-05-09 23:35:00',51,'2016-05-10 00:42:00','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

/*Data for the table `pha_purchase_item` */

insert  into `pha_purchase_item`(`purchase_item_id`,`tenant_id`,`purchase_id`,`product_id`,`batch_id`,`quantity`,`free_quantity`,`free_quantity_unit`,`mrp`,`purchase_rate`,`purchase_amount`,`discount_percent`,`discount_amount`,`total_amount`,`package_name`,`vat_amount`,`vat_percent`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,1,1,1,10,0,0,'150.00','10.00','100.00','0.00','0.00','100.00','10s','5.00','5.00','1',51,'2016-03-15 09:24:44',51,'2016-03-15 09:24:44','0000-00-00 00:00:00'),(2,58,2,1,2,300,40,0,'23.00','13.00','3900.00','3.00','117.00','3783.00','10s','195.00','5.00','1',51,'2016-03-17 01:26:56',51,'2016-03-17 01:26:56','0000-00-00 00:00:00'),(3,58,3,1,2,500,20,0,'23.00','10.00','5000.00','5.00','250.00','4750.00','10s','250.00','5.00','1',51,'2016-03-17 01:28:12',51,'2016-03-17 01:39:29','0000-00-00 00:00:00'),(4,58,4,1,3,200,10,0,'60.00','55.00','11000.00','4.00','440.00','10560.00','10s','550.00','5.00','1',51,'2016-03-17 01:38:48',51,'2016-03-17 01:38:48','0000-00-00 00:00:00'),(5,58,4,1,4,44,30,0,'50.00','33.00','1452.00','2.00','29.04','1422.96','15s','72.60','5.00','1',51,'2016-03-17 01:38:48',51,'2016-03-17 01:38:48','0000-00-00 00:00:00'),(6,58,5,3,5,10,0,0,'500.00','300.00','3000.00','10.00','300.00','2700.00','10s','300.00','10.00','1',51,'2016-03-22 23:36:07',51,'2016-03-22 23:37:50','0000-00-00 00:00:00'),(7,58,5,2,6,10,0,0,'500.00','300.00','3000.00','0.00','0.00','3000.00','15s','150.00','5.00','1',51,'2016-03-22 23:36:07',51,'2016-03-22 23:37:50','0000-00-00 00:00:00'),(8,58,6,5,7,10,0,0,'1200.00','1000.00','10000.00','10.00','1000.00','9000.00','10s','863.00','8.63','1',51,'2016-03-22 23:48:53',51,'2016-03-22 23:48:53','0000-00-00 00:00:00'),(9,58,7,1,1,11,1,0,'150.00','20.00','220.00','0.00','0.00','220.00','10s','11.00','5.00','1',51,'2016-04-02 00:01:49',51,'2016-04-02 00:01:49','0000-00-00 00:00:00'),(10,58,8,2,8,12,10,0,'100.00','80.00','960.00','0.00','0.00','960.00','10s','48.00','5.00','1',51,'2016-04-26 05:02:37',51,'2016-04-26 05:02:37','0000-00-00 00:00:00'),(11,58,9,5,9,3,333,333,'3.00','2.00','6.00','0.00','0.00','6.00','10s','0.52','8.63','1',51,'2016-04-30 09:29:20',51,'2016-04-30 09:29:20','0000-00-00 00:00:00'),(12,58,10,2,6,10,20,0,'500.00','50.00','500.00','0.00','0.00','500.00','10s','25.00','5.00','1',51,'2016-05-03 00:05:07',51,'2016-05-03 00:09:35','0000-00-00 00:00:00'),(13,58,11,2,6,5,5,0,'500.00','10.00','50.00','0.00','0.00','50.00','10s','2.50','5.00','1',51,'2016-05-05 00:11:13',51,'2016-05-05 00:11:13','0000-00-00 00:00:00'),(14,58,12,3,10,10,8,0,'10.00','8.00','80.00','0.00','0.00','80.00','10s','8.00','10.00','1',51,'2016-05-05 00:13:58',51,'2016-05-05 00:13:58','0000-00-00 00:00:00'),(15,58,13,3,5,2,0,0,'500.00','200.00','400.00','0.00','0.00','400.00','10s','40.00','10.00','1',51,'2016-05-06 05:55:42',51,'2016-05-06 05:55:42','0000-00-00 00:00:00'),(16,58,14,2,8,10,2,0,'100.00','80.00','800.00','2.00','16.00','784.00','10s','40.00','5.00','1',51,'2016-05-07 01:29:44',51,'2016-05-07 01:29:44','0000-00-00 00:00:00'),(17,58,15,6,11,20,10,0,'85.00','65.44','1308.80','2.00','26.18','1282.62','10s','65.44','5.00','1',51,'2016-05-07 06:43:12',51,'2016-05-07 06:43:12','0000-00-00 00:00:00'),(18,58,15,2,12,5,1,0,'100.00','50.00','250.00','3.00','7.50','242.50','10s','12.50','5.00','1',51,'2016-05-07 06:43:12',51,'2016-05-07 06:43:12','0000-00-00 00:00:00'),(19,58,16,2,13,25,24,0,'89.00','35.00','875.00','3.00','26.25','848.75','10s','43.75','5.00','1',51,'2016-05-09 03:46:52',51,'2016-05-09 03:46:52','0000-00-00 00:00:00'),(20,58,17,3,14,56,23,0,'78.00','78.00','4368.00','2.00','87.36','4280.64','10s','436.80','10.00','1',51,'2016-05-09 03:52:01',51,'2016-05-09 03:52:01','0000-00-00 00:00:00'),(21,58,18,4,15,35,23,0,'45.00','45.00','1575.00','2.00','31.50','1543.50','10s','196.88','12.50','1',51,'2016-05-09 03:59:10',51,'2016-05-09 03:59:10','0000-00-00 00:00:00'),(22,58,19,15,16,10,10,0,'12.00','10.00','100.00','0.00','0.00','100.00','10s','10.00','10.00','1',51,'2016-05-09 23:17:14',51,'2016-05-09 23:17:14','0000-00-00 00:00:00'),(23,58,20,6,11,10,2,0,'85.00','10.00','100.00','10.00','10.00','90.00','10s','5.00','5.00','1',51,'2016-05-09 23:35:00',51,'2016-05-10 00:42:00','0000-00-00 00:00:00');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pha_purchase_return` */

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pha_purchase_return_item` */

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `pha_sale` */

insert  into `pha_sale`(`sale_id`,`tenant_id`,`bill_no`,`patient_id`,`mobile_no`,`consultant_id`,`sale_date`,`payment_type`,`total_item_vat_amount`,`total_item_sale_amount`,`total_item_discount_percent`,`total_item_discount_amount`,`total_item_amount`,`welfare_amount`,`roundoff_amount`,`bill_amount`,`payment_status`,`encounter_id`,`patient_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'AH0000003',22,'234234234',54,'2016-03-17','CA','394.45','7889.00','100.00','7889.00','394.45','3.00','0.45','397.00','C',NULL,NULL,'1',51,'2016-03-17 06:42:32',51,'2016-03-17 06:44:38','0000-00-00 00:00:00'),(2,58,'AH0000004',20,'676767676',56,'2016-04-07','COD','165.00','3300.00',NULL,'0.00','3465.00',NULL,'0.00','3465.00','P',NULL,NULL,'1',51,'2016-04-07 07:59:30',51,'2016-04-07 07:59:30','0000-00-00 00:00:00'),(3,58,'AH0000005',18,'9856145115',54,'2016-05-09','CA','0.00','0.00',NULL,'0.00','0.00',NULL,'0.00','0.00','C',NULL,NULL,'1',51,'2016-05-09 03:19:13',51,'2016-05-09 03:19:13','0000-00-00 00:00:00'),(4,58,'AH0000006',18,'9856145115',54,'2016-05-09','CA','85.00','1700.00',NULL,'0.00','1785.00',NULL,'0.00','1785.00','C',NULL,NULL,'1',51,'2016-05-09 03:27:07',51,'2016-05-09 03:27:07','0000-00-00 00:00:00'),(5,58,'AH0000007',47,'9159154005',56,'2016-05-09','COD','106.25','2125.00',NULL,'0.00','2231.25',NULL,'0.25','2231.00','P',NULL,NULL,'1',51,'2016-05-09 05:02:36',51,'2016-05-09 05:02:36','0000-00-00 00:00:00'),(6,58,'AH0000008',18,'9856145115',54,'2016-05-09','CA','1750.00','17500.00','2.00','350.00','18900.00',NULL,'0.00','18900.00','C',NULL,NULL,'1',51,'2016-05-09 05:28:44',51,'2016-05-09 05:28:44','0000-00-00 00:00:00'),(7,58,'AH0000009',19,'9898989898',54,'2016-05-10','CR','8.50','170.00',NULL,'0.00','178.50',NULL,'0.50','179.00','C',NULL,NULL,'1',51,'2016-05-10 01:21:47',51,'2016-05-13 04:23:19','0000-00-00 00:00:00'),(8,58,'AH0000010',19,'9898989898',54,'2016-05-19','CR','12.75','255.00',NULL,'0.00','267.75',NULL,'0.25','268.00','PC',NULL,NULL,'1',51,'2016-05-10 01:23:17',51,'2016-05-13 04:56:32','0000-00-00 00:00:00'),(9,58,'AH0000011',18,'9856145115',54,'2016-05-13','CA','600.00','6000.00',NULL,'0.00','6600.00',NULL,'0.00','6600.00','C',NULL,NULL,'1',51,'2016-05-13 01:06:29',51,'2016-05-13 01:06:29','0000-00-00 00:00:00'),(10,58,'AH0000014',18,'9856145115',54,'2016-05-30','COD','194.63','1665.00','99.00','1648.35','211.28','59.00','0.28','270.00','C',134,'George','1',51,'2016-05-30 12:33:26',51,'2016-06-02 01:41:05','0000-00-00 00:00:00'),(11,58,'AH0000015',25,NULL,56,'2016-06-13','CA','500.00','5000.00',NULL,'0.00','5500.00',NULL,'0.00','5500.00','C',15,'Radha','1',51,'2016-06-13 06:07:22',51,'2016-06-13 06:07:22','0000-00-00 00:00:00'),(12,58,'AH0000016',32,NULL,54,'2016-06-13','COD','100.00','1000.00',NULL,'0.00','1100.00',NULL,'0.00','1100.00','P',109,'Yami','1',51,'2016-06-13 06:08:31',51,'2016-06-13 06:08:31','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `pha_sale_billing` */

insert  into `pha_sale_billing`(`sale_billing_id`,`sale_id`,`tenant_id`,`paid_date`,`paid_amount`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,3,58,'2016-05-09','0.00','1',51,'2016-05-09 03:19:13',51,'2016-05-09 03:19:13','0000-00-00 00:00:00'),(2,4,58,'2016-05-09','1785.00','1',51,'2016-05-09 03:27:07',51,'2016-05-09 03:27:07','0000-00-00 00:00:00'),(3,6,58,'2016-05-09','18900.00','1',51,'2016-05-09 05:28:44',51,'2016-05-09 05:28:44','0000-00-00 00:00:00'),(4,7,58,'2016-05-12','100.00','1',51,'2016-05-12 04:23:10',51,'2016-05-12 04:23:10','0000-00-00 00:00:00'),(5,9,58,'2016-05-13','6600.00','1',51,'2016-05-13 01:06:29',51,'2016-05-13 01:06:29','0000-00-00 00:00:00'),(6,7,58,'2016-05-13','79.00','1',51,'2016-05-13 04:23:19',51,'2016-05-13 04:23:19','0000-00-00 00:00:00'),(7,8,58,'2016-05-13','100.00','1',51,'2016-05-13 04:56:32',51,'2016-05-13 04:56:32','0000-00-00 00:00:00'),(8,10,58,'2016-05-30','270.00','1',51,'2016-05-30 12:35:00',51,'2016-05-30 12:35:00','0000-00-00 00:00:00'),(9,11,58,'2016-06-13','5500.00','1',51,'2016-06-13 06:07:22',51,'2016-06-13 06:07:22','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `pha_sale_item` */

insert  into `pha_sale_item`(`sale_item_id`,`tenant_id`,`sale_id`,`product_id`,`batch_id`,`quantity`,`package_name`,`mrp`,`item_amount`,`vat_amount`,`vat_percent`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,1,1,2,333,'10s','23.00','7659.00','382.95','5.00','1',51,'2016-03-17 06:42:32',51,'2016-03-17 06:44:38','0000-00-00 00:00:00'),(2,58,1,1,2,10,'10s','23.00','230.00','11.50','5.00','1',51,'2016-03-17 06:44:38',51,'2016-03-17 06:44:38','0000-00-00 00:00:00'),(3,58,2,1,1,22,'10s','150.00','3300.00','165.00','5.00','1',51,'2016-04-07 07:59:30',51,'2016-04-07 07:59:30','0000-00-00 00:00:00'),(4,58,3,2,6,10,'10s','500.00','0.00','0.00','10.00','1',51,'2016-05-09 03:19:13',51,'2016-05-09 03:19:13','0000-00-00 00:00:00'),(5,58,4,6,11,20,'1.s','85.00','1700.00','85.00','5.00','1',51,'2016-05-09 03:27:07',51,'2016-05-09 03:27:07','0000-00-00 00:00:00'),(6,58,5,6,11,25,'1.s','85.00','2125.00','106.25','5.00','1',51,'2016-05-09 05:02:36',51,'2016-05-09 05:02:36','0000-00-00 00:00:00'),(7,58,6,2,6,35,'10s','500.00','17500.00','1750.00','10.00','1',51,'2016-05-09 05:28:44',51,'2016-05-09 05:28:44','0000-00-00 00:00:00'),(8,58,7,6,11,2,'1.s','85.00','170.00','8.50','5.00','1',51,'2016-05-10 01:21:47',51,'2016-05-10 01:21:47','0000-00-00 00:00:00'),(9,58,8,6,11,3,'1.s','85.00','255.00','12.75','5.00','1',51,'2016-05-10 01:23:17',51,'2016-05-10 01:23:17','0000-00-00 00:00:00'),(10,58,9,2,6,12,'10s','500.00','6000.00','600.00','10.00','1',51,'2016-05-13 01:06:29',51,'2016-05-13 01:06:29','0000-00-00 00:00:00'),(11,58,10,1,3,3,'10s','60.00','180.00','9.00','5.00','1',51,'2016-05-30 12:33:26',51,'2016-05-30 12:33:26','0000-00-00 00:00:00'),(12,58,10,4,15,33,'15s','45.00','1485.00','185.63','12.50','1',51,'2016-05-30 12:33:26',51,'2016-05-30 12:33:26','0000-00-00 00:00:00'),(13,58,11,2,6,10,'10s','500.00','5000.00','500.00','10.00','1',51,'2016-06-13 06:07:22',51,'2016-06-13 06:07:22','0000-00-00 00:00:00'),(14,58,12,2,8,10,'10s','100.00','1000.00','100.00','10.00','1',51,'2016-06-13 06:08:31',51,'2016-06-13 06:08:31','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `pha_supplier` */

insert  into `pha_supplier`(`supplier_id`,`tenant_id`,`supplier_name`,`supplier_code`,`supplier_address`,`city_id`,`state_id`,`country_id`,`zip`,`supplier_mobile`,`supplier_phone`,`cst_no`,`tin_no`,`drug_license`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'test','test','test',1,8,7,'3434','3443434',NULL,'','',NULL,'1',51,'2016-03-14 05:44:21',51,'2016-03-14 05:44:21','0000-00-00 00:00:00'),(2,58,'GODSON PHARMA','aaa123','qwerty',1,8,7,'123123','56757576567',NULL,'','',NULL,'1',51,'2016-03-22 02:13:48',51,'2016-03-22 02:13:48','0000-00-00 00:00:00'),(3,58,'MUTHUS MEDICKAL AGENCIES','mmm123','abc',NULL,NULL,NULL,NULL,'',NULL,'','',NULL,'1',51,'2016-03-22 02:14:37',51,'2016-03-22 02:14:37','0000-00-00 00:00:00'),(4,58,'sri vignesh pharma','23','naicker new street',1,8,7,'0','9842329801',NULL,'','',NULL,'1',51,'2016-05-07 06:30:01',51,'2016-05-07 06:30:01','0000-00-00 00:00:00'),(5,58,'sri narayanan agency','24','masi street',1,8,7,'0','9600680240',NULL,'','',NULL,'1',51,'2016-05-07 06:32:36',51,'2016-05-07 06:32:36','0000-00-00 00:00:00'),(6,58,'SRI NAGAPPA AGENCY','25','masi street',1,8,7,'0','9942980814',NULL,'','',NULL,'1',51,'2016-05-07 06:54:23',51,'2016-05-07 06:54:23','0000-00-00 00:00:00'),(7,58,'vasantha marketing','33','north masi street',1,8,7,'0','9942405476',NULL,'','',NULL,'1',51,'2016-05-08 06:04:44',51,'2016-05-08 06:04:44','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `pha_vat` */

insert  into `pha_vat`(`vat_id`,`tenant_id`,`vat`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'5.00','1',51,'2016-03-14 05:41:30',51,'2016-03-14 05:41:30','0000-00-00 00:00:00'),(2,58,'10.00','1',51,'2016-03-22 01:12:38',51,'2016-03-22 01:12:38','0000-00-00 00:00:00'),(3,58,'12.50','1',51,'2016-03-22 23:38:36',51,'2016-03-22 23:38:36','0000-00-00 00:00:00'),(4,58,'8.63','1',51,'2016-03-22 23:42:32',51,'2016-03-22 23:42:32','0000-00-00 00:00:00'),(5,58,'14.00','1',51,'2016-03-23 01:53:53',51,'2016-03-23 01:53:53','0000-00-00 00:00:00');

/*Table structure for table `v_billing_advance_charges` */

DROP TABLE IF EXISTS `v_billing_advance_charges`;

/*!50001 DROP VIEW IF EXISTS `v_billing_advance_charges` */;
/*!50001 DROP TABLE IF EXISTS `v_billing_advance_charges` */;

/*!50001 CREATE TABLE  `v_billing_advance_charges`(
 `tenant_id` int(11) ,
 `encounter_id` int(11) ,
 `patient_id` int(11) ,
 `payment_id` int(11) ,
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
 `date` varchar(19) ,
 `type` varchar(17) ,
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

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`rajencba`@`%` SQL SECURITY DEFINER VIEW `v_billing_advance_charges` AS (select `a`.`tenant_id` AS `tenant_id`,`a`.`encounter_id` AS `encounter_id`,`a`.`patient_id` AS `patient_id`,`a`.`payment_id` AS `payment_id`,'Advance Charge' AS `category`,concat('Payment(',`a`.`payment_id`,')') AS `headers`,0 AS `charge`,0 AS `visit_count`,'C' AS `trans_mode`,`a`.`payment_amount` AS `total_charge`,0 AS `extra_amount`,0 AS `concession_amount` from `pat_billing_payment` `a` where ((`a`.`status` = '1') and (`a`.`deleted_at` = '0000-00-00 00:00:00'))) */;

/*View structure for view v_billing_other_charges */

/*!50001 DROP TABLE IF EXISTS `v_billing_other_charges` */;
/*!50001 DROP VIEW IF EXISTS `v_billing_other_charges` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`rajencba`@`%` SQL SECURITY DEFINER VIEW `v_billing_other_charges` AS (select `a`.`tenant_id` AS `tenant_id`,`a`.`encounter_id` AS `encounter_id`,`a`.`patient_id` AS `patient_id`,`a`.`charge_subcat_id` AS `category_id`,`b`.`charge_cat_name` AS `category`,`c`.`charge_subcat_name` AS `headers`,`a`.`charge_amount` AS `charge`,0 AS `visit_count`,'D' AS `trans_mode`,`a`.`charge_amount` AS `total_charge`,0 AS `extra_amount`,0 AS `concession_amount`,`a`.`other_charge_id` AS `other_charge_id` from ((`pat_billing_other_charges` `a` join `co_room_charge_category` `b` on((`b`.`charge_cat_id` = `a`.`charge_cat_id`))) join `co_room_charge_subcategory` `c` on((`c`.`charge_subcat_id` = `a`.`charge_subcat_id`))) where ((`a`.`status` = '1') and (`a`.`deleted_at` = '0000-00-00 00:00:00'))) */;

/*View structure for view v_billing_procedures */

/*!50001 DROP TABLE IF EXISTS `v_billing_procedures` */;
/*!50001 DROP VIEW IF EXISTS `v_billing_procedures` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`rajencba`@`%` SQL SECURITY DEFINER VIEW `v_billing_procedures` AS (select `a`.`tenant_id` AS `tenant_id`,`a`.`encounter_id` AS `encounter_id`,`a`.`patient_id` AS `patient_id`,`a`.`charge_subcat_id` AS `category_id`,'Procedure Charges' AS `category`,`b`.`charge_subcat_name` AS `headers`,truncate(avg(`a`.`charge_amount`),2) AS `charge`,count(`a`.`proc_id`) AS `visit_count`,'D' AS `trans_mode`,sum(`a`.`charge_amount`) AS `total_charge`,ifnull((select `c`.`extra_amount` from `pat_billing_extra_concession` `c` where ((`c`.`encounter_id` = `a`.`encounter_id`) and (`c`.`patient_id` = `a`.`patient_id`) and (`c`.`link_id` = `a`.`charge_subcat_id`) and (`c`.`ec_type` = 'P'))),0) AS `extra_amount`,ifnull((select `c`.`concession_amount` from `pat_billing_extra_concession` `c` where ((`c`.`encounter_id` = `a`.`encounter_id`) and (`c`.`patient_id` = `a`.`patient_id`) and (`c`.`link_id` = `a`.`charge_subcat_id`) and (`c`.`ec_type` = 'P'))),0) AS `concession_amount`,ifnull((select `c`.`ec_id` from `pat_billing_extra_concession` `c` where ((`c`.`encounter_id` = `a`.`encounter_id`) and (`c`.`patient_id` = `a`.`patient_id`) and (`c`.`link_id` = `a`.`charge_subcat_id`) and (`c`.`ec_type` = 'P')) limit 1),0) AS `ec_id`,ifnull((select `c`.`ec_type` from `pat_billing_extra_concession` `c` where ((`c`.`encounter_id` = `a`.`encounter_id`) and (`c`.`patient_id` = `a`.`patient_id`) and (`c`.`link_id` = `a`.`charge_subcat_id`) and (`c`.`ec_type` = 'P')) limit 1),0) AS `ec_type` from (`pat_procedure` `a` join `co_room_charge_subcategory` `b` on((`b`.`charge_subcat_id` = `a`.`charge_subcat_id`))) where ((`a`.`status` = '1') and (`a`.`deleted_at` = '0000-00-00 00:00:00')) group by `a`.`encounter_id`,`a`.`charge_subcat_id`) */;

/*View structure for view v_billing_professionals */

/*!50001 DROP TABLE IF EXISTS `v_billing_professionals` */;
/*!50001 DROP VIEW IF EXISTS `v_billing_professionals` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`rajencba`@`%` SQL SECURITY DEFINER VIEW `v_billing_professionals` AS (select `a`.`tenant_id` AS `tenant_id`,`a`.`encounter_id` AS `encounter_id`,`a`.`patient_id` AS `patient_id`,`a`.`consultant_id` AS `category_id`,'Professional Charges' AS `category`,concat(`b`.`title_code`,' ',`b`.`name`) AS `headers`,truncate(avg(`a`.`charge_amount`),2) AS `charge`,count(`a`.`pat_consult_id`) AS `visit_count`,'D' AS `trans_mode`,sum(`a`.`charge_amount`) AS `total_charge`,ifnull((select `c`.`extra_amount` from `pat_billing_extra_concession` `c` where ((`c`.`encounter_id` = `a`.`encounter_id`) and (`c`.`patient_id` = `a`.`patient_id`) and (`c`.`link_id` = `a`.`consultant_id`) and (`c`.`ec_type` = 'C'))),0) AS `extra_amount`,ifnull((select `c`.`concession_amount` from `pat_billing_extra_concession` `c` where ((`c`.`encounter_id` = `a`.`encounter_id`) and (`c`.`patient_id` = `a`.`patient_id`) and (`c`.`link_id` = `a`.`consultant_id`) and (`c`.`ec_type` = 'C'))),0) AS `concession_amount`,ifnull((select `c`.`ec_id` from `pat_billing_extra_concession` `c` where ((`c`.`encounter_id` = `a`.`encounter_id`) and (`c`.`patient_id` = `a`.`patient_id`) and (`c`.`link_id` = `a`.`consultant_id`) and (`c`.`ec_type` = 'C')) limit 1),0) AS `ec_id`,ifnull((select `c`.`ec_type` from `pat_billing_extra_concession` `c` where ((`c`.`encounter_id` = `a`.`encounter_id`) and (`c`.`patient_id` = `a`.`patient_id`) and (`c`.`link_id` = `a`.`consultant_id`) and (`c`.`ec_type` = 'C')) limit 1),0) AS `ec_type` from (`pat_consultant` `a` join `co_user` `b` on((`b`.`user_id` = `a`.`consultant_id`))) where ((`a`.`status` = '1') and (`a`.`deleted_at` = '0000-00-00 00:00:00')) group by `a`.`encounter_id`,`a`.`consultant_id`) */;

/*View structure for view v_billing_recurring */

/*!50001 DROP TABLE IF EXISTS `v_billing_recurring` */;
/*!50001 DROP VIEW IF EXISTS `v_billing_recurring` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`rajencba`@`%` SQL SECURITY DEFINER VIEW `v_billing_recurring` AS (select `pat_billing_recurring`.`tenant_id` AS `tenant_id`,`pat_billing_recurring`.`encounter_id` AS `encounter_id`,`pat_billing_recurring`.`room_type_id` AS `room_type_id`,`pat_billing_recurring`.`room_type` AS `room_type`,`pat_billing_recurring`.`charge_item_id` AS `charge_item_id`,`pat_billing_recurring`.`charge_item` AS `charge_item`,min(`pat_billing_recurring`.`recurr_date`) AS `from_date`,max(`pat_billing_recurring`.`recurr_date`) AS `to_date`,((to_days(max(`pat_billing_recurring`.`recurr_date`)) - to_days(min(`pat_billing_recurring`.`recurr_date`))) + 1) AS `duration`,truncate((sum(`pat_billing_recurring`.`charge_amount`) / ((to_days(max(`pat_billing_recurring`.`recurr_date`)) - to_days(min(`pat_billing_recurring`.`recurr_date`))) + 1)),2) AS `charge_amount`,sum(`pat_billing_recurring`.`charge_amount`) AS `total_charge` from `pat_billing_recurring` group by `pat_billing_recurring`.`encounter_id`,`pat_billing_recurring`.`room_type_id`,`pat_billing_recurring`.`recurr_group`,`pat_billing_recurring`.`charge_item_id`) */;

/*View structure for view v_encounter */

/*!50001 DROP TABLE IF EXISTS `v_encounter` */;
/*!50001 DROP VIEW IF EXISTS `v_encounter` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`rajencba`@`%` SQL SECURITY DEFINER VIEW `v_encounter` AS select `a`.`appt_id` AS `id`,`c`.`encounter_id` AS `encounter_id`,concat(`a`.`status_date`,' ',`a`.`status_time`) AS `date`,(case `a`.`appt_status` when 'B' then 'Booked' when 'A' then 'Arrived' when 'S' then 'Seen' when 'C' then 'Cancelled' else NULL end) AS `type`,'\nOP' AS `details`,concat(`b`.`title_code`,`b`.`name`) AS `doctor`,`c`.`patient_id` AS `patient_id`,`d`.`patient_guid` AS `patient_guid`,`c`.`encounter_type` AS `encounter_type`,`c`.`status` AS `status`,`a`.`status_date` AS `date_time`,`a`.`appt_status` AS `row_sts`,0 AS `is_swap`,`a`.`consultant_id` AS `consultant_id` from (((`pat_appointment` `a` join `co_user` `b` on((`b`.`user_id` = `a`.`consultant_id`))) join `pat_encounter` `c` on((`c`.`encounter_id` = `a`.`encounter_id`))) join `pat_patient` `d` on((`d`.`patient_id` = `c`.`patient_id`))) union all select `a`.`admn_id` AS `id`,`c`.`encounter_id` AS `encounter_id`,`a`.`status_date` AS `date`,(case `a`.`admission_status` when 'A' then 'Admission' when 'D' then 'Discharge' when 'TR' then 'Transfer (Room)' when 'TD' then 'Transfer (Doctor)' when 'C' then 'Cancelled' else NULL end) AS `type`,concat('IP: ',`d`.`floor_name`,' > ',`e`.`ward_name`,' > ',`f`.`bed_name`,'  (',`g`.`room_type_name`,')') AS `details`,concat(`b`.`title_code`,`b`.`name`) AS `doctor`,`c`.`patient_id` AS `patient_id`,`h`.`patient_guid` AS `patient_guid`,`c`.`encounter_type` AS `encounter_type`,`c`.`status` AS `status`,`a`.`status_date` AS `date_time`,`a`.`admission_status` AS `row_sts`,`a`.`is_swap` AS `is_swap`,`a`.`consultant_id` AS `consultant_id` from (((((((`pat_admission` `a` join `co_user` `b` on((`b`.`user_id` = `a`.`consultant_id`))) join `pat_encounter` `c` on((`c`.`encounter_id` = `a`.`encounter_id`))) left join `co_floor` `d` on((`d`.`floor_id` = `a`.`floor_id`))) left join `co_ward` `e` on((`e`.`ward_id` = `a`.`ward_id`))) left join `co_room` `f` on((`f`.`room_id` = `a`.`room_id`))) left join `co_room_type` `g` on((`g`.`room_type_id` = `a`.`room_type_id`))) join `pat_patient` `h` on((`h`.`patient_id` = `c`.`patient_id`))) where (`a`.`status` = '1') order by `encounter_id` desc,`date_time` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
