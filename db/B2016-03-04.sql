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

insert  into `co_charge_per_category`(`charge_id`,`tenant_id`,`charge_cat_type`,`charge_cat_id`,`charge_code_id`,`charge_default`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (3,58,'C',1,22,'250','2016-02-04 22:36:47',51,'2016-03-02 12:55:14',51,'0000-00-00 00:00:00'),(4,58,'C',5,26,'150','2016-02-09 02:22:54',51,'2016-02-20 04:23:56',62,'0000-00-00 00:00:00'),(5,58,'C',5,25,NULL,'2016-02-09 02:24:37',51,'2016-02-09 02:24:37',51,'0000-00-00 00:00:00'),(6,58,'P',-1,56,'352','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(7,58,'P',-1,54,'900','2016-02-17 04:36:29',51,'2016-03-02 12:55:07',51,'0000-00-00 00:00:00'),(8,60,'P',-1,65,'200','2016-02-19 07:53:17',59,'2016-02-19 07:53:17',59,'0000-00-00 00:00:00'),(9,60,'P',-1,60,'100','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(10,60,'P',-1,61,'100','2016-02-19 23:22:28',59,'2016-02-19 23:22:28',59,'0000-00-00 00:00:00'),(11,58,'P',-1,58,'100','2016-02-20 02:17:57',62,'2016-02-20 02:17:57',62,'0000-00-00 00:00:00'),(12,60,'C',1,35,'100','2016-02-20 03:29:39',59,'2016-02-20 03:29:39',59,'0000-00-00 00:00:00'),(13,61,'P',-1,68,'200','2016-02-22 00:01:27',67,'2016-02-23 02:19:20',67,'0000-00-00 00:00:00');

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

insert  into `co_charge_per_subcategory`(`sub_charge_id`,`charge_id`,`charge_type`,`charge_link_id`,`charge_amount`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (1,3,'IP',9,'111.00','2016-02-04 22:36:48',51,'2016-02-04 22:36:48',51,'0000-00-00 00:00:00'),(2,3,'IP',10,'111.00','2016-02-04 22:36:48',51,'2016-02-04 22:36:48',51,'0000-00-00 00:00:00'),(3,3,'IP',11,'111.00','2016-02-04 22:36:48',51,'2016-02-04 22:36:48',51,'0000-00-00 00:00:00'),(4,4,'IP',9,'1000.00','2016-02-09 02:22:55',51,'2016-02-09 02:22:55',51,'0000-00-00 00:00:00'),(5,4,'IP',10,'1200.00','2016-02-09 02:22:55',51,'2016-02-09 02:22:55',51,'0000-00-00 00:00:00'),(6,4,'IP',11,'1500.00','2016-02-09 02:22:55',51,'2016-02-09 02:22:55',51,'0000-00-00 00:00:00'),(7,4,'IP',12,'1900.00','2016-02-09 02:22:55',51,'2016-02-09 02:22:55',51,'0000-00-00 00:00:00'),(8,4,'IP',13,'2000.00','2016-02-09 02:22:55',51,'2016-02-09 02:22:55',51,'0000-00-00 00:00:00'),(9,5,'IP',9,'1111.00','2016-02-09 02:24:57',51,'2016-02-09 02:24:57',51,'0000-00-00 00:00:00'),(10,5,'IP',10,'11111.00','2016-02-09 02:24:57',51,'2016-02-09 02:24:57',51,'0000-00-00 00:00:00'),(11,5,'IP',11,'1111.00','2016-02-09 02:24:57',51,'2016-02-09 02:24:57',51,'0000-00-00 00:00:00'),(12,5,'IP',12,'11111.00','2016-02-09 02:24:57',51,'2016-02-09 02:24:57',51,'0000-00-00 00:00:00'),(13,5,'IP',13,'2222.00','2016-02-09 02:24:57',51,'2016-02-09 02:24:57',51,'0000-00-00 00:00:00'),(14,6,'OP',4,'100.00','2016-02-17 04:35:32',51,'2016-03-02 12:54:38',51,'0000-00-00 00:00:00'),(15,6,'OP',5,'200.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(16,6,'OP',6,'300.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(17,6,'IP',9,'100.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(18,6,'IP',10,'20.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(19,6,'IP',11,'33.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(20,6,'IP',12,'11.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(21,6,'IP',13,'15.00','2016-02-17 04:35:32',51,'2016-02-17 04:35:32',51,'0000-00-00 00:00:00'),(22,7,'OP',4,'100.00','2016-02-17 04:36:29',51,'2016-02-17 04:36:29',51,'0000-00-00 00:00:00'),(23,7,'OP',5,'100.00','2016-02-17 04:36:29',51,'2016-02-17 04:36:29',51,'0000-00-00 00:00:00'),(24,7,'OP',6,'100.00','2016-02-17 04:36:29',51,'2016-02-17 04:36:29',51,'0000-00-00 00:00:00'),(25,7,'IP',9,'1200.00','2016-02-17 04:36:29',51,'2016-02-25 04:10:27',51,'0000-00-00 00:00:00'),(26,7,'IP',10,'8200.00','2016-02-17 04:36:29',51,'2016-02-25 04:10:44',51,'0000-00-00 00:00:00'),(27,7,'IP',11,'120.00','2016-02-17 04:36:29',51,'2016-02-25 04:10:33',51,'0000-00-00 00:00:00'),(28,7,'IP',12,'200.00','2016-02-17 04:36:29',51,'2016-02-17 04:36:29',51,'0000-00-00 00:00:00'),(29,7,'IP',13,'200.00','2016-02-17 04:36:29',51,'2016-02-17 04:36:29',51,'0000-00-00 00:00:00'),(30,6,'OP',7,'400.00','2016-02-19 07:45:04',51,'2016-02-19 07:45:04',51,'0000-00-00 00:00:00'),(31,8,'OP',8,'100.00','2016-02-19 07:53:18',59,'2016-02-19 07:53:18',59,'0000-00-00 00:00:00'),(32,8,'OP',9,'100.00','2016-02-19 07:53:18',59,'2016-02-19 07:53:18',59,'0000-00-00 00:00:00'),(33,8,'OP',10,'101.00','2016-02-19 07:53:18',59,'2016-02-19 07:53:18',59,'0000-00-00 00:00:00'),(34,8,'OP',11,'102.00','2016-02-19 07:53:18',59,'2016-02-19 07:53:18',59,'0000-00-00 00:00:00'),(35,8,'OP',12,'103.00','2016-02-19 07:53:18',59,'2016-02-19 07:53:18',59,'0000-00-00 00:00:00'),(36,9,'OP',8,'101.00','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(37,9,'OP',9,'102.00','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(38,9,'OP',10,'103.00','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(39,9,'OP',11,'104.00','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(40,9,'OP',12,'105.00','2016-02-19 07:58:12',59,'2016-02-19 07:58:12',59,'0000-00-00 00:00:00'),(41,10,'OP',8,'101.00','2016-02-19 23:29:21',59,'2016-02-19 23:29:21',59,'0000-00-00 00:00:00'),(42,3,'OP',4,'500.00','2016-02-20 01:21:12',62,'2016-02-20 01:21:12',62,'0000-00-00 00:00:00'),(43,3,'OP',5,'600.00','2016-02-20 01:21:22',62,'2016-02-20 01:21:22',62,'0000-00-00 00:00:00'),(44,11,'OP',4,'100.00','2016-02-20 02:17:57',62,'2016-02-20 02:17:57',62,'0000-00-00 00:00:00'),(45,12,'OP',8,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(46,12,'OP',9,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(47,12,'OP',10,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(48,12,'OP',11,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(49,12,'OP',12,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(50,12,'IP',14,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(51,12,'IP',15,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(52,12,'IP',16,'123.00','2016-02-20 03:29:40',59,'2016-02-20 03:29:40',59,'0000-00-00 00:00:00'),(53,13,'OP',14,'200.00','2016-02-23 04:52:20',67,'2016-02-23 04:52:20',67,'0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `co_doctor_schedule` */

insert  into `co_doctor_schedule`(`schedule_id`,`tenant_id`,`user_id`,`schedule_day`,`schedule_time_in`,`schedule_time_out`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (1,58,54,'-1','07:30:00','08:00:00','2016-02-04 22:40:42',51,'2016-02-04 22:40:42',51,'2016-02-04 22:41:31'),(2,58,54,'-1','05:00:00','07:30:00','2016-02-04 22:40:42',51,'2016-02-04 22:40:42',51,'2016-02-04 22:41:31'),(3,58,56,'-1','11:00:00','12:00:00','2016-02-17 00:45:37',51,'2016-02-17 00:45:37',51,'0000-00-00 00:00:00'),(4,60,60,'-1','09:00:00','10:00:00','2016-02-17 06:33:58',59,'2016-02-17 06:33:58',59,'0000-00-00 00:00:00'),(5,60,61,'-1','00:30:00','03:00:00','2016-02-19 23:24:54',59,'2016-02-19 23:24:54',59,'0000-00-00 00:00:00'),(6,60,65,'-1','16:00:00','18:00:00','2016-02-20 03:30:18',59,'2016-02-20 03:30:18',59,'0000-00-00 00:00:00'),(7,60,64,'-1','22:30:00','23:00:00','2016-02-20 03:30:32',59,'2016-02-20 03:30:32',59,'0000-00-00 00:00:00'),(8,61,68,'-1','01:00:00','00:00:00','2016-02-21 23:26:35',67,'2016-02-21 23:26:35',19,'2016-02-21 23:34:57'),(9,61,68,'-1','02:00:00','00:00:00','2016-02-21 23:27:24',67,'2016-02-21 23:27:24',19,'2016-02-21 23:34:55'),(10,61,68,'-1','10:30:00','23:30:00','2016-02-21 23:35:20',67,'2016-02-21 23:35:20',19,'2016-02-23 05:12:53');

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

insert  into `co_floor`(`floor_id`,`tenant_id`,`floor_name`,`floor_code`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (7,58,'Ground Floor','1','1',51,'2016-02-04 07:15:34',51,'2016-02-04 07:15:34','0000-00-00 00:00:00'),(8,58,'Floor 1','2','1',51,'2016-02-04 07:15:44',51,'2016-02-04 07:15:44','0000-00-00 00:00:00'),(9,58,'Floor 2','3','1',51,'2016-02-04 07:15:54',51,'2016-02-04 07:15:54','0000-00-00 00:00:00'),(10,59,'1','1','1',52,'2016-02-05 06:47:59',52,'2016-02-05 06:47:59','0000-00-00 00:00:00'),(14,58,'111','90','1',51,'2016-02-15 06:49:27',51,'2016-02-15 06:49:27','0000-00-00 00:00:00'),(15,58,'11231','9','1',51,'2016-02-15 07:17:28',NULL,'2016-03-02 16:46:33','0000-00-00 00:00:00'),(16,60,'Ground Floor','01','1',59,'2016-02-19 22:25:45',59,'2016-02-19 22:25:45','0000-00-00 00:00:00'),(17,60,'First Floor','02','1',59,'2016-02-20 01:10:57',59,'2016-02-20 01:10:57','0000-00-00 00:00:00'),(18,60,'Second Floor','03','1',59,'2016-02-20 01:13:41',59,'2016-02-20 01:13:41','0000-00-00 00:00:00'),(19,61,'Floor1','F1','1',67,'2016-02-23 02:33:20',67,'2016-02-23 02:33:20','0000-00-00 00:00:00'),(20,61,'Floor2','F2','1',67,'2016-02-23 02:33:36',67,'2016-02-23 02:33:36','0000-00-00 00:00:00');

/*Table structure for table `co_internal_code` */

DROP TABLE IF EXISTS `co_internal_code`;

CREATE TABLE `co_internal_code` (
  `internal_code_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `code_type` char(1) NOT NULL DEFAULT 'B' COMMENT 'B - Bill, P - Patient',
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `co_internal_code` */

insert  into `co_internal_code`(`internal_code_id`,`tenant_id`,`code_type`,`code_prefix`,`code`,`code_padding`,`code_suffix`,`status`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (2,58,'B','AH',3,7,NULL,'1','2016-02-06 04:51:18',-1,'2016-02-06 04:51:18',51,'0000-00-00 00:00:00'),(3,58,'P','AH',35,7,NULL,'1','2016-03-02 15:36:36',-1,'2016-03-02 15:36:36',51,'0000-00-00 00:00:00'),(4,59,'B','AR',1,7,NULL,'1','2016-02-02 22:43:11',-1,'2016-02-02 22:43:11',-1,'0000-00-00 00:00:00'),(5,59,'P','AR',1,7,NULL,'1','2016-02-02 22:43:11',-1,'2016-02-02 22:43:11',-1,'0000-00-00 00:00:00'),(6,60,'B','RA',1,7,NULL,'1','2016-02-17 06:28:38',-1,'2016-02-17 06:28:38',-1,'0000-00-00 00:00:00'),(7,60,'P','RA',5,7,NULL,'1','2016-02-20 03:31:26',-1,'2016-02-20 03:31:26',59,'0000-00-00 00:00:00'),(8,61,'B','TE',34343434,7,NULL,'1','2016-02-23 02:20:29',-1,'2016-02-23 02:20:29',67,'0000-00-00 00:00:00'),(9,61,'P','TE',2,7,NULL,'1','2016-02-21 23:20:06',-1,'2016-02-21 23:20:06',67,'0000-00-00 00:00:00'),(10,62,'B','TE',1,7,NULL,'1','2016-02-29 02:00:01',-1,'2016-02-29 02:00:01',-1,'0000-00-00 00:00:00'),(11,62,'P','TE',1,7,NULL,'1','2016-02-29 02:00:01',-1,'2016-02-29 02:00:01',-1,'0000-00-00 00:00:00');

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

insert  into `co_login`(`login_id`,`user_id`,`username`,`password`,`password_reset_token`,`authtoken`,`created_by`,`created_at`,`modified_by`,`modified_at`,`activation_date`,`Inactivation_date`,`logged_tenant_id`) values (10,51,'vikhram','$2y$13$Mx2BsH38QbNovq0QGCsI8Ov2gWIojvuWLcJV0UEvdr1LCJyi9mRwW',NULL,'dmlraHJhbTE0NTcwMDYzNTMxMjQx',-1,'2016-02-02 22:26:39',NULL,'2016-03-03 17:29:13',NULL,NULL,58),(11,52,'ark','$2y$13$4T7TlDr8in4ydQTVxEfTke.donWnYhKLOJG8r/c78g.UXuXeqfNFO',NULL,'YXJrMTQ1NDk5MDU0NTE1MTg=',-1,'2016-02-02 22:43:12',NULL,'2016-02-08 22:02:25',NULL,NULL,NULL),(12,54,'John','123',NULL,NULL,51,'2016-02-04 07:07:43',51,'2016-02-04 07:07:43','2016-02-04','2016-02-28',NULL),(13,56,'surya','$2y$13$lpvuN2LSd2zOqt5Mx4TdmeuGcgBa7YuOsBwRdHLtKQrd3uioJioeq',NULL,'c3VyeWExNDU1NTQxODM1ODkwOQ==',51,'2016-02-05 22:50:58',NULL,'2016-02-15 07:10:35','2016-02-06','2016-04-30',NULL),(14,59,'gayatri','$2y$13$ZEtwkbrJqouJw3KqMkoEzO6JIGFyuOUA3mba5AENqyYe7jX5HmpTe',NULL,'Z2F5YXRyaTE0NTYxNDM0MTYyNDgz',-1,'2016-02-17 06:28:39',NULL,'2016-02-22 06:16:56',NULL,NULL,60),(15,62,'prakash','$2y$13$X9agaug8aC21f9ujjR9vzOze3nqFNsuaLPf0kgOwwI06tsqX35IrW',NULL,'',51,'2016-02-19 07:08:27',62,'2016-03-03 17:28:56','2016-02-19','2016-02-19',NULL),(16,63,'nadesh','$2y$13$X9agaug8aC21f9ujjR9vzOze3nqFNsuaLPf0kgOwwI06tsqX35IrW',NULL,'',51,'2016-02-19 07:09:05',63,'2016-02-29 06:16:28','2016-02-19','2016-02-19',NULL),(17,65,'test','$2y$13$A4KhMKHUYaMb4m0MoTBNVufbQu4gkBcTc0zV.vSkFiuv..QlAhfh2',NULL,NULL,59,'2016-02-19 07:49:44',59,'2016-02-19 07:49:44','2016-02-19','2016-02-19',NULL),(18,66,'prakash2','$2y$13$mfGVdp/.Cst1GsGHSo/Vv.q9.gxFCaecIokQmbF29OnIw9WS8aIX.',NULL,'cHJha2FzaDIxNDU1OTcyNTk2NDA5Nw==',59,'2016-02-20 05:10:18',NULL,'2016-02-20 06:49:56','2016-02-20','2016-02-20',60),(19,67,'paramesh','$2y$13$u.tSO2LUiafMwxi19midCOlGruWNOIR1lD3gqsGnYhXnSbNYHqvqC','2NCgwIefzaenjPjYtE2lCd_M9eLzyfsQ_1456575065','',-1,'2016-02-21 23:16:05',67,'2016-02-29 02:01:25',NULL,NULL,NULL),(20,73,'parames','$2y$13$1TsRqCJ5ThWc.Pp2vVrdQecg1tFoqsKPGJRCwII5QZqlpB2AtSn86',NULL,NULL,-1,'2016-02-29 02:00:02',-1,'2016-02-29 02:00:02',NULL,NULL,NULL);

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

insert  into `co_patient_category`(`patient_cat_id`,`tenant_id`,`patient_cat_name`,`patient_cat_color`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (4,58,'BUSINESS','#44ae58','1',51,'2016-02-05 00:50:24',51,'2016-02-17 06:45:37','0000-00-00 00:00:00'),(5,58,'VIP','#df9a26','1',51,'2016-02-05 00:50:43',51,'2016-02-17 06:45:23','0000-00-00 00:00:00'),(6,58,'Standrad','#FFFFFF','1',51,'2016-02-09 01:52:26',51,'2016-02-17 06:45:14','0000-00-00 00:00:00'),(7,58,'VVIP','#FFFFFF','1',51,'2016-02-17 06:45:45',51,'2016-02-17 06:45:45','0000-00-00 00:00:00'),(8,60,'vip','#FFFFFF','1',59,'2016-02-17 23:15:35',59,'2016-02-17 23:15:35','0000-00-00 00:00:00'),(9,60,'business','#FFFFFF','1',59,'2016-02-17 23:15:42',59,'2016-02-17 23:15:42','0000-00-00 00:00:00'),(10,60,'free','#FFFFFF','1',59,'2016-02-17 23:15:48',59,'2016-02-17 23:15:48','0000-00-00 00:00:00'),(11,60,'standard','#FFFFFF','1',59,'2016-02-17 23:15:56',59,'2016-02-17 23:15:56','0000-00-00 00:00:00'),(12,60,'vvip','#FFFFFF','1',59,'2016-02-17 23:16:04',59,'2016-02-17 23:16:04','0000-00-00 00:00:00'),(13,58,'classic','#d01e1e','1',51,'2016-02-19 01:34:56',51,'2016-02-19 01:34:56','0000-00-00 00:00:00'),(14,61,'Standard','#FFFFFF','1',67,'2016-02-23 02:22:51',67,'2016-02-23 02:22:51','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=latin1;

/*Data for the table `co_resources` */

insert  into `co_resources`(`resource_id`,`parent_id`,`resource_name`,`resource_url`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,NULL,'Configuration','configuration',-1,'2015-12-29 15:11:20',NULL,NULL),(2,1,'Organization Module','organization',-1,'2015-12-29 15:11:42',NULL,NULL),(3,2,'Organization','configuration.organization',-1,'2016-01-19 15:35:50',NULL,NULL),(4,2,'Organization Module','configuration.organizationModule',-1,'2016-01-19 15:36:07',NULL,NULL),(5,1,'Administrative Module','administrative',-1,'2016-01-20 11:11:09',NULL,NULL),(6,5,'Roles','configuration.roles',-1,'2016-01-20 11:11:58',NULL,NULL),(7,5,'Role Rights','configuration.roleRights',-1,'2016-01-20 11:14:04',NULL,NULL),(8,5,'User roles','configuration.userRoles',-1,'2016-01-20 11:14:31',NULL,NULL),(9,5,'Charge Category','configuration.roomChargeCategory',-1,'2016-01-20 11:15:00',NULL,NULL),(10,1,'User Module','userModule',-1,'2016-01-20 11:16:12',NULL,NULL),(11,10,'User Registration','configuration.registration',-1,'2016-01-20 11:16:50',NULL,NULL),(12,1,'Ward Management','wardManagement',-1,'2016-01-20 11:17:42',NULL,NULL),(13,12,'Floors','configuration.floors',-1,'2016-01-20 11:18:10',NULL,NULL),(14,12,'Wards','configuration.wards',-1,'2016-01-20 11:18:25',NULL,NULL),(15,12,'Bed Type','configuration.roomType',-1,'2016-01-20 11:18:48',NULL,NULL),(16,12,'Room','configuration.room',-1,'2016-01-20 11:19:17',NULL,NULL),(17,12,'Room and Bed Type','configuration.roomTypeRoom',-1,'2016-01-20 11:20:39',NULL,NULL),(18,1,'Charges Configuration','chargesConfiguration',-1,'2016-01-20 11:21:17',NULL,NULL),(19,18,'Room Charge','configuration.roomCharge',-1,'2016-01-20 11:21:40',NULL,NULL),(20,18,'Room Maintenance','configuration.roomMaintenance',-1,'2016-01-20 11:21:59',NULL,NULL),(21,18,'Charges for Category','configuration.chargePerCategory',-1,'2016-01-20 11:22:20',NULL,NULL),(22,1,'Doctor’s Configuration','doctorsConfiguration',-1,'2016-01-20 11:22:59',NULL,NULL),(23,22,'Doctors Schedule','configuration.docSchedule',-1,'2016-01-20 11:23:20',NULL,NULL),(24,22,'Specialities','configuration.specialities',-1,'2016-01-20 11:23:39',NULL,NULL),(25,1,'Miscellaneous','miscellaneous',-1,'2016-01-20 11:24:17',NULL,NULL),(26,25,'Alerts','configuration.alerts',-1,'2016-01-20 11:24:32',NULL,NULL),(27,25,'Patient Category','configuration.patientCategories',-1,'2016-01-20 11:24:47',NULL,NULL),(28,25,'Bill-No Prefix','configuration.internalCode',-1,'2016-01-20 11:25:06',NULL,NULL),(29,25,'Master Country','configuration.countries',-1,'2016-01-20 11:25:22',NULL,NULL),(30,25,'Master State','configuration.states',-1,'2016-01-20 11:25:35',NULL,NULL),(31,25,'Master City','configuration.cities',-1,'2016-01-20 11:25:52',NULL,NULL),(32,5,'Room Charge Item','configuration.roomChargeCategoryItem',-1,'2016-02-01 12:04:21',NULL,NULL),(33,5,'Allied Charges','configuration.alliedCharge',-1,'2016-02-03 15:31:05',NULL,NULL),(34,5,'Procedures','configuration.procedure',-1,'2016-02-05 15:43:00',NULL,NULL),(35,6,'Add Role','configuration.role_create',-1,'2016-02-08 15:16:27',NULL,NULL),(36,6,'Update Role','configuration.role_update',-1,'2016-02-08 15:17:21',NULL,NULL),(37,6,'Delete Role','configuration.role_delete',-1,'2016-02-08 15:18:46',NULL,NULL),(38,9,'Add Charge Category','configuration.roomChargeCategoryCreate',-1,'2016-02-08 15:20:26',NULL,NULL),(39,9,'Update Charge Category','configuration.roomChargeCategoryUpdate',-1,'2016-02-08 15:20:26',NULL,NULL),(40,9,'Delete Charge Category','configuration.roomChargeCategoryDelete',-1,'2016-02-08 15:20:27',NULL,NULL),(41,32,'Add Room Charge Item','configuration.roomChargeCategoryItemCreate',-1,'2016-02-08 15:21:56',NULL,NULL),(42,32,'Update Room Charge Item','configuration.roomChargeCategoryItemUpdate',-1,'2016-02-08 15:21:56',NULL,NULL),(43,32,'Delete Room Charge Item','configuration.roomChargeCategoryItemDelete',-1,'2016-02-08 15:21:56',NULL,NULL),(44,33,'Add Allied Charges','configuration.alliedChargeCreate',-1,'2016-02-08 15:31:45',NULL,NULL),(45,33,'Update Allied Charges','configuration.alliedChargeUpdate',-1,'2016-02-08 15:31:45',NULL,NULL),(46,33,'Delete Allied Charges','configuration.alliedChargeDelete',-1,'2016-02-08 15:31:45',NULL,NULL),(47,34,'Add Procedures','configuration.procedureChargeCreate',-1,'2016-02-08 15:38:42',NULL,NULL),(48,34,'Update Procedures','configuration.procedureChargeUpdate',-1,'2016-02-08 15:38:42',NULL,NULL),(49,34,'Delete Procedures','configuration.procedureChargeDelete',-1,'2016-02-08 15:38:42',NULL,NULL),(54,11,'Add User','configuration.user_create',-1,'2016-02-08 15:41:39',NULL,NULL),(55,11,'Update User','configuration.user_update',-1,'2016-02-08 15:41:39',NULL,NULL),(56,11,'Delete User','configuration.user_delete',-1,'2016-02-08 15:41:39',NULL,NULL),(57,11,'Add/Update Login','configuration.login_update',-1,'2016-02-08 15:41:39',NULL,NULL),(58,13,'Add Floor','configuration.floor_create',-1,'2016-02-08 15:49:25',NULL,NULL),(59,13,'Update Floor','configuration.floor_update',-1,'2016-02-08 15:49:25',NULL,NULL),(60,13,'Delete Floor','configuration.floor_delete',-1,'2016-02-08 15:49:25',NULL,NULL),(61,14,'Add Ward','configuration.ward_create',-1,'2016-02-08 15:50:14',NULL,NULL),(62,14,'Update Ward','configuration.ward_update',-1,'2016-02-08 15:50:14',NULL,NULL),(63,14,'Delete Ward','configuration.ward_delete',-1,'2016-02-08 15:50:14',NULL,NULL),(64,15,'Add Bed Type','configuration.roomTypeCreate',-1,'2016-02-08 15:51:19',NULL,NULL),(65,15,'Update Bed Type','configuration.roomTypeUpdate',-1,'2016-02-08 15:51:19',NULL,NULL),(66,15,'Delete Bed Type','configuration.roomTypeDelete',-1,'2016-02-08 15:51:19',NULL,NULL),(67,16,'Add Room','configuration.roomCreate',-1,'2016-02-08 15:52:21',NULL,NULL),(68,16,'Update Room','configuration.roomUpdate',-1,'2016-02-08 15:52:21',NULL,NULL),(69,16,'Delete Room','configuration.roomDelete',-1,'2016-02-08 15:52:21',NULL,NULL),(70,17,'Assign Room and Bed Types','configuration.roomTypeRoomUpdate',-1,'2016-02-08 15:53:47',NULL,NULL),(71,19,'Create RoomCharge','configuration.roomChargeCreate',-1,'2016-02-08 15:55:00',NULL,NULL),(72,19,'Update RoomCharge','configuration.roomChargeUpdate',-1,'2016-02-08 15:55:00',NULL,NULL),(73,19,'Delete RoomCharge','configuration.roomChargeDelete',-1,'2016-02-08 15:55:00',NULL,NULL),(74,20,'Create Room Maintenance','configuration.roomMaintenanceCreate',-1,'2016-02-08 15:55:59',NULL,NULL),(75,20,'Update Room Maintenance','configuration.roomMaintenanceUpdate',-1,'2016-02-08 15:55:59',NULL,NULL),(76,20,'Delete Room Maintenance','configuration.roomMaintenanceDelete',-1,'2016-02-08 15:55:59',NULL,NULL),(77,21,'Create Charges for Category','configuration.chargePerCategoryCreate',-1,'2016-02-08 16:00:51',NULL,NULL),(78,22,'Create Doctor Schedule','configuration.docScheduleCreate',-1,'2016-02-08 16:02:26',NULL,NULL),(79,22,'Update Doctor Schedule','configuration.docScheduleUpdate',-1,'2016-02-08 16:02:26',NULL,NULL),(80,22,'Delete Doctor Schedule','configuration.docScheduleDelete',-1,'2016-02-08 16:02:26',NULL,NULL),(81,24,'Create Speciality','configuration.specialityCreate',-1,'2016-02-08 16:03:14',NULL,NULL),(82,24,'Update Speciality','configuration.specialityUpdate',-1,'2016-02-08 16:03:14',NULL,NULL),(83,24,'Delete Speciality','configuration.specialityDelete',-1,'2016-02-08 16:03:14',NULL,NULL),(84,26,'Create Alerts','configuration.alertCreate',-1,'2016-02-08 16:04:00',NULL,NULL),(85,26,'Update Alerts','configuration.alertUpdate',-1,'2016-02-08 16:04:00',NULL,NULL),(86,26,'Delete Alerts','configuration.alertDelete',-1,'2016-02-08 16:04:00',NULL,NULL),(87,27,'Create Patient Category','configuration.patientCategoryCreate',-1,'2016-02-08 16:04:42',NULL,NULL),(88,27,'Update Patient Category','configuration.patientCategoryUpdate',-1,'2016-02-08 16:04:42',NULL,NULL),(89,27,'Delete Patient Category','configuration.patientCategoryDelete',-1,'2016-02-08 16:04:42',NULL,NULL),(90,29,'Create Country','configuration.countryCreate',-1,'2016-02-08 16:05:26',NULL,NULL),(91,29,'Update Country','configuration.countryUpdate',-1,'2016-02-08 16:05:27',NULL,NULL),(92,29,'Delete Country','configuration.countryDelete',-1,'2016-02-08 16:05:27',NULL,NULL),(93,30,'Create State','configuration.stateCreate',-1,'2016-02-08 16:06:03',NULL,NULL),(94,30,'Update State','configuration.stateUpdate',-1,'2016-02-08 16:06:03',NULL,NULL),(95,30,'Delete State','configuration.stateDelete',-1,'2016-02-08 16:06:03',NULL,NULL),(96,31,'Create City','configuration.cityCreate',-1,'2016-02-08 16:06:59',NULL,NULL),(97,31,'Update City','configuration.cityUpdate',-1,'2016-02-08 16:06:59',NULL,NULL),(98,31,'Delete City','configuration.cityDelete',-1,'2016-02-08 16:06:59',NULL,NULL),(99,NULL,'Patient','patient',-1,'2016-02-09 12:15:31',NULL,NULL),(100,99,'Details','patient.view',-1,'2016-02-09 12:16:49',NULL,NULL),(101,99,'Timeline','patient.timeline',-1,'2016-02-09 12:17:35',NULL,NULL),(102,99,'Documents','patient.documents',-1,'2016-02-09 12:17:43',NULL,NULL),(103,99,'Encounter','patient.encounter',-1,'2016-02-09 12:17:57',NULL,NULL),(104,99,'Notes','patient.notes',-1,'2016-02-09 12:18:01',NULL,NULL),(105,99,'Consultant','patient.consultant',-1,'2016-02-09 12:18:12',NULL,NULL),(106,99,'Procedure','patient.procedure',-1,'2016-02-09 12:18:22',NULL,NULL),(107,99,'Prescription','patient.prescription',-1,'2016-02-09 12:18:45',NULL,NULL),(108,99,'Alert','patient.alert',-1,'2016-02-09 12:18:55',NULL,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=latin1;

/*Data for the table `co_role` */

insert  into `co_role`(`role_id`,`tenant_id`,`description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (64,58,'Administrator','1',-1,'2016-02-02 22:26:38',-1,'2016-02-02 22:26:38','0000-00-00 00:00:00'),(65,59,'Administrator','1',-1,'2016-02-02 22:43:11',-1,'2016-02-02 22:43:11','0000-00-00 00:00:00'),(66,58,'Admin','1',51,'2016-02-04 07:02:50',51,'2016-02-04 07:02:50','0000-00-00 00:00:00'),(67,58,'Cashier','1',51,'2016-02-04 07:03:04',51,'2016-02-04 07:03:04','0000-00-00 00:00:00'),(68,58,'Nurse','1',51,'2016-02-05 22:27:45',51,'2016-02-05 22:27:45','0000-00-00 00:00:00'),(69,60,'admin','1',-1,'2016-02-17 06:28:38',-1,'2016-02-17 06:28:38','0000-00-00 00:00:00'),(72,60,'Sub-Admin','1',59,'2016-02-19 03:57:13',59,'2016-02-19 07:38:06','0000-00-00 00:00:00'),(73,60,'Chief Cashier','1',59,'2016-02-19 04:17:31',59,'2016-02-19 04:31:12','0000-00-00 00:00:00'),(74,60,'Doctor','1',59,'2016-02-19 04:17:46',59,'2016-02-19 04:17:46','0000-00-00 00:00:00'),(79,60,'Nurse','1',59,'2016-02-19 04:22:36',59,'2016-02-19 04:29:12','0000-00-00 00:00:00'),(80,60,'Receptionist','0',59,'2016-02-19 04:22:48',59,'2016-02-19 04:23:14','0000-00-00 00:00:00'),(81,60,'Accountant','1',59,'2016-02-19 04:26:33',59,'2016-02-19 04:29:23','0000-00-00 00:00:00'),(82,60,'PRO','1',59,'2016-02-19 04:27:34',59,'2016-02-19 04:27:58','0000-00-00 00:00:00'),(84,60,'Human Resource','1',59,'2016-02-19 04:31:40',59,'2016-02-19 04:48:00','0000-00-00 00:00:00'),(85,60,'Director','0',59,'2016-02-19 04:43:23',59,'2016-02-19 04:54:09','0000-00-00 00:00:00'),(86,60,'Psychologist','1',59,'2016-02-19 04:43:59',59,'2016-02-19 04:54:02','0000-00-00 00:00:00'),(87,60,'Pharmacy','1',59,'2016-02-19 04:45:43',59,'2016-02-19 04:53:53','0000-00-00 00:00:00'),(88,60,'Supervisor','1',59,'2016-02-19 04:47:28',59,'2016-02-19 04:53:40','0000-00-00 00:00:00'),(89,60,'manager','1',59,'2016-02-19 04:54:33',59,'2016-02-19 04:54:33','0000-00-00 00:00:00'),(90,60,'Care Provider','1',59,'2016-02-19 07:12:03',59,'2016-02-19 07:12:30','0000-00-00 00:00:00'),(91,61,'admin','1',-1,'2016-02-21 23:16:05',-1,'2016-02-21 23:16:05','0000-00-00 00:00:00'),(92,61,'Administrator','1',67,'2016-02-23 02:28:08',67,'2016-02-25 04:59:00','0000-00-00 00:00:00'),(93,62,'admin','1',-1,'2016-02-29 02:00:01',-1,'2016-02-29 02:00:01','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=459 DEFAULT CHARSET=latin1;

/*Data for the table `co_roles_resources` */

insert  into `co_roles_resources`(`role_perm_id`,`tenant_id`,`role_id`,`resource_id`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,58,64,1,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(2,58,64,2,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(3,58,64,3,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(4,58,64,4,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(5,58,64,5,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(6,58,64,6,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(7,58,64,7,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(8,58,64,8,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(9,58,64,9,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(10,58,64,10,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(11,58,64,11,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(18,58,64,18,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(19,58,64,19,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(20,58,64,20,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(21,58,64,21,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(22,58,64,22,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(23,58,64,23,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(24,58,64,24,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(25,58,64,25,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(26,58,64,26,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(27,58,64,27,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(28,58,64,28,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(29,58,64,29,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(30,58,64,30,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(31,58,64,31,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(32,58,64,32,'1',-1,'2016-02-02 22:26:39',NULL,NULL),(33,59,65,1,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(34,59,65,5,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(35,59,65,6,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(36,59,65,7,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(37,59,65,8,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(38,59,65,9,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(39,59,65,12,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(40,59,65,13,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(41,59,65,14,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(42,59,65,15,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(43,59,65,16,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(44,59,65,17,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(45,59,65,18,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(46,59,65,19,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(47,59,65,20,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(48,59,65,21,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(49,59,65,32,'1',-1,'2016-02-02 22:43:12',NULL,NULL),(50,58,66,1,'1',51,'2016-02-04 07:03:24',NULL,NULL),(51,58,66,5,'1',51,'2016-02-04 07:03:24',NULL,NULL),(52,58,66,6,'1',51,'2016-02-04 07:03:24',NULL,NULL),(53,58,66,7,'1',51,'2016-02-04 07:03:24',NULL,NULL),(54,58,66,8,'1',51,'2016-02-04 07:03:24',NULL,NULL),(55,58,66,9,'1',51,'2016-02-04 07:03:24',NULL,NULL),(56,59,65,2,'1',-1,'2016-02-05 01:12:33',NULL,NULL),(57,59,65,3,'1',-1,'2016-02-05 01:12:33',NULL,NULL),(58,59,65,4,'1',-1,'2016-02-05 01:12:33',NULL,NULL),(59,59,65,10,'1',-1,'2016-02-05 01:12:33',NULL,NULL),(60,59,65,11,'1',-1,'2016-02-05 01:12:33',NULL,NULL),(61,59,65,22,'1',-1,'2016-02-05 01:12:33',NULL,NULL),(62,59,65,23,'1',-1,'2016-02-05 01:12:33',NULL,NULL),(63,59,65,24,'1',-1,'2016-02-05 01:12:33',NULL,NULL),(64,59,65,25,'1',-1,'2016-02-05 01:12:33',NULL,NULL),(65,59,65,26,'1',-1,'2016-02-05 01:12:33',NULL,NULL),(66,59,65,27,'1',-1,'2016-02-05 01:12:33',NULL,NULL),(67,59,65,28,'1',-1,'2016-02-05 01:12:33',NULL,NULL),(68,59,65,29,'1',-1,'2016-02-05 01:12:33',NULL,NULL),(69,59,65,30,'1',-1,'2016-02-05 01:12:33',NULL,NULL),(70,59,65,31,'1',-1,'2016-02-05 01:12:33',NULL,NULL),(71,58,68,1,'1',51,'2016-02-05 22:29:47',NULL,NULL),(72,58,68,25,'1',51,'2016-02-05 22:29:47',NULL,NULL),(73,58,68,26,'1',51,'2016-02-05 22:29:47',NULL,NULL),(74,58,68,27,'1',51,'2016-02-05 22:29:47',NULL,NULL),(75,58,68,28,'1',51,'2016-02-05 22:29:47',NULL,NULL),(76,58,64,12,'1',-1,'2016-02-05 22:36:45',NULL,NULL),(77,58,64,13,'1',-1,'2016-02-05 22:36:45',NULL,NULL),(78,58,64,14,'1',-1,'2016-02-05 22:36:45',NULL,NULL),(79,58,64,15,'1',-1,'2016-02-05 22:36:45',NULL,NULL),(80,58,64,16,'1',-1,'2016-02-05 22:36:45',NULL,NULL),(81,58,64,17,'1',-1,'2016-02-05 22:36:45',NULL,NULL),(82,58,64,33,'1',-1,'2016-02-06 04:15:10',NULL,NULL),(83,58,64,34,'1',-1,'2016-02-06 04:15:16',NULL,NULL),(84,60,69,1,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(85,60,69,2,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(86,60,69,3,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(87,60,69,4,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(88,60,69,5,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(89,60,69,6,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(90,60,69,7,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(91,60,69,8,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(92,60,69,9,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(93,60,69,10,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(94,60,69,11,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(95,60,69,12,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(96,60,69,13,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(97,60,69,14,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(98,60,69,15,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(99,60,69,16,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(100,60,69,17,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(101,60,69,18,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(102,60,69,19,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(103,60,69,20,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(104,60,69,21,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(105,60,69,22,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(106,60,69,23,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(107,60,69,24,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(108,60,69,25,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(109,60,69,26,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(110,60,69,27,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(111,60,69,28,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(112,60,69,29,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(113,60,69,30,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(114,60,69,31,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(115,60,69,32,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(116,60,69,33,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(117,60,69,34,'1',-1,'2016-02-17 06:28:39',NULL,NULL),(118,60,74,1,'1',59,'2016-02-19 04:24:00',NULL,NULL),(122,60,74,5,'1',59,'2016-02-19 04:24:00',NULL,NULL),(123,60,74,6,'1',59,'2016-02-19 04:24:00',NULL,NULL),(124,60,74,7,'1',59,'2016-02-19 04:24:00',NULL,NULL),(125,60,74,8,'1',59,'2016-02-19 04:24:00',NULL,NULL),(126,60,74,9,'1',59,'2016-02-19 04:24:00',NULL,NULL),(127,60,74,10,'1',59,'2016-02-19 04:24:00',NULL,NULL),(128,60,74,11,'1',59,'2016-02-19 04:24:00',NULL,NULL),(149,60,74,32,'1',59,'2016-02-19 04:24:00',NULL,NULL),(150,60,74,33,'1',59,'2016-02-19 04:24:00',NULL,NULL),(151,60,74,34,'1',59,'2016-02-19 04:24:00',NULL,NULL),(152,60,73,1,'1',59,'2016-02-19 04:29:38',NULL,NULL),(153,60,73,2,'1',59,'2016-02-19 04:29:38',NULL,NULL),(154,60,73,3,'1',59,'2016-02-19 04:29:38',NULL,NULL),(155,60,73,4,'1',59,'2016-02-19 04:29:38',NULL,NULL),(169,60,73,18,'1',59,'2016-02-19 04:29:38',NULL,NULL),(170,60,73,19,'1',59,'2016-02-19 04:29:38',NULL,NULL),(171,60,73,20,'1',59,'2016-02-19 04:29:38',NULL,NULL),(172,60,73,21,'1',59,'2016-02-19 04:29:38',NULL,NULL),(173,60,73,22,'1',59,'2016-02-19 04:29:38',NULL,NULL),(174,60,73,23,'1',59,'2016-02-19 04:29:38',NULL,NULL),(175,60,73,24,'1',59,'2016-02-19 04:29:38',NULL,NULL),(176,60,73,25,'1',59,'2016-02-19 04:29:38',NULL,NULL),(177,60,73,26,'1',59,'2016-02-19 04:29:38',NULL,NULL),(178,60,73,27,'1',59,'2016-02-19 04:29:38',NULL,NULL),(179,60,73,28,'1',59,'2016-02-19 04:29:38',NULL,NULL),(180,60,73,29,'1',59,'2016-02-19 04:29:38',NULL,NULL),(181,60,73,30,'1',59,'2016-02-19 04:29:38',NULL,NULL),(182,60,73,31,'1',59,'2016-02-19 04:29:38',NULL,NULL),(186,60,81,1,'1',59,'2016-02-19 04:42:38',NULL,NULL),(187,60,81,2,'1',59,'2016-02-19 04:42:38',NULL,NULL),(188,60,81,3,'1',59,'2016-02-19 04:42:38',NULL,NULL),(197,60,81,12,'1',59,'2016-02-19 04:42:38',NULL,NULL),(198,60,81,13,'1',59,'2016-02-19 04:42:38',NULL,NULL),(199,60,81,14,'1',59,'2016-02-19 04:42:38',NULL,NULL),(200,60,81,15,'1',59,'2016-02-19 04:42:38',NULL,NULL),(201,60,81,16,'1',59,'2016-02-19 04:42:38',NULL,NULL),(202,60,81,17,'1',59,'2016-02-19 04:42:38',NULL,NULL),(203,60,81,18,'1',59,'2016-02-19 04:42:38',NULL,NULL),(204,60,81,19,'1',59,'2016-02-19 04:42:38',NULL,NULL),(205,60,81,20,'1',59,'2016-02-19 04:42:38',NULL,NULL),(206,60,81,21,'1',59,'2016-02-19 04:42:38',NULL,NULL),(207,60,81,22,'1',59,'2016-02-19 04:42:38',NULL,NULL),(208,60,81,23,'1',59,'2016-02-19 04:42:38',NULL,NULL),(209,60,81,24,'1',59,'2016-02-19 04:42:38',NULL,NULL),(210,60,81,25,'1',59,'2016-02-19 04:42:38',NULL,NULL),(211,60,81,26,'1',59,'2016-02-19 04:42:38',NULL,NULL),(212,60,81,27,'1',59,'2016-02-19 04:42:38',NULL,NULL),(213,60,81,28,'1',59,'2016-02-19 04:42:38',NULL,NULL),(214,60,81,29,'1',59,'2016-02-19 04:42:38',NULL,NULL),(215,60,81,30,'1',59,'2016-02-19 04:42:38',NULL,NULL),(216,60,81,31,'1',59,'2016-02-19 04:42:38',NULL,NULL),(220,60,74,2,'1',59,'2016-02-19 04:46:31',NULL,NULL),(221,60,74,3,'1',59,'2016-02-19 04:46:31',NULL,NULL),(223,60,74,12,'1',59,'2016-02-19 04:46:31',NULL,NULL),(224,60,74,13,'1',59,'2016-02-19 04:46:31',NULL,NULL),(225,60,74,14,'1',59,'2016-02-19 04:46:31',NULL,NULL),(226,60,74,15,'1',59,'2016-02-19 04:46:31',NULL,NULL),(227,60,74,16,'1',59,'2016-02-19 04:46:31',NULL,NULL),(228,60,74,17,'1',59,'2016-02-19 04:46:31',NULL,NULL),(229,60,74,18,'1',59,'2016-02-19 04:46:31',NULL,NULL),(230,60,74,19,'1',59,'2016-02-19 04:46:31',NULL,NULL),(231,60,74,20,'1',59,'2016-02-19 04:46:31',NULL,NULL),(232,60,74,21,'1',59,'2016-02-19 04:46:31',NULL,NULL),(233,60,74,22,'1',59,'2016-02-19 04:46:31',NULL,NULL),(234,60,74,23,'1',59,'2016-02-19 04:46:31',NULL,NULL),(235,60,74,24,'1',59,'2016-02-19 04:46:31',NULL,NULL),(236,60,74,25,'1',59,'2016-02-19 04:46:31',NULL,NULL),(237,60,74,26,'1',59,'2016-02-19 04:46:31',NULL,NULL),(238,60,74,27,'1',59,'2016-02-19 04:46:31',NULL,NULL),(239,60,74,28,'1',59,'2016-02-19 04:46:31',NULL,NULL),(240,60,74,29,'1',59,'2016-02-19 04:46:31',NULL,NULL),(241,60,74,30,'1',59,'2016-02-19 04:46:31',NULL,NULL),(242,60,74,31,'1',59,'2016-02-19 04:46:31',NULL,NULL),(243,60,84,1,'1',59,'2016-02-19 04:48:22',NULL,NULL),(244,60,84,18,'1',59,'2016-02-19 04:48:22',NULL,NULL),(245,60,84,19,'1',59,'2016-02-19 04:48:22',NULL,NULL),(246,60,84,20,'1',59,'2016-02-19 04:48:22',NULL,NULL),(247,60,84,21,'1',59,'2016-02-19 04:48:22',NULL,NULL),(248,60,72,1,'1',59,'2016-02-19 04:49:37',NULL,NULL),(249,60,72,2,'1',59,'2016-02-19 04:49:37',NULL,NULL),(250,60,72,3,'1',59,'2016-02-19 04:49:37',NULL,NULL),(251,60,72,4,'1',59,'2016-02-19 04:49:37',NULL,NULL),(252,60,72,5,'1',59,'2016-02-19 04:49:37',NULL,NULL),(253,60,72,6,'1',59,'2016-02-19 04:49:37',NULL,NULL),(254,60,72,7,'1',59,'2016-02-19 04:49:37',NULL,NULL),(255,60,72,8,'1',59,'2016-02-19 04:49:37',NULL,NULL),(256,60,72,9,'1',59,'2016-02-19 04:49:37',NULL,NULL),(257,60,72,10,'1',59,'2016-02-19 04:49:37',NULL,NULL),(258,60,72,11,'1',59,'2016-02-19 04:49:37',NULL,NULL),(259,60,72,12,'1',59,'2016-02-19 04:49:37',NULL,NULL),(260,60,72,13,'1',59,'2016-02-19 04:49:37',NULL,NULL),(261,60,72,14,'1',59,'2016-02-19 04:49:37',NULL,NULL),(262,60,72,15,'1',59,'2016-02-19 04:49:37',NULL,NULL),(263,60,72,16,'1',59,'2016-02-19 04:49:37',NULL,NULL),(264,60,72,17,'1',59,'2016-02-19 04:49:37',NULL,NULL),(265,60,72,18,'1',59,'2016-02-19 04:49:37',NULL,NULL),(266,60,72,19,'1',59,'2016-02-19 04:49:37',NULL,NULL),(267,60,72,20,'1',59,'2016-02-19 04:49:37',NULL,NULL),(268,60,72,21,'1',59,'2016-02-19 04:49:37',NULL,NULL),(269,60,72,22,'1',59,'2016-02-19 04:49:37',NULL,NULL),(270,60,72,23,'1',59,'2016-02-19 04:49:37',NULL,NULL),(271,60,72,24,'1',59,'2016-02-19 04:49:37',NULL,NULL),(272,60,72,25,'1',59,'2016-02-19 04:49:37',NULL,NULL),(273,60,72,26,'1',59,'2016-02-19 04:49:37',NULL,NULL),(274,60,72,27,'1',59,'2016-02-19 04:49:37',NULL,NULL),(275,60,72,28,'1',59,'2016-02-19 04:49:37',NULL,NULL),(276,60,72,29,'1',59,'2016-02-19 04:49:37',NULL,NULL),(277,60,72,30,'1',59,'2016-02-19 04:49:37',NULL,NULL),(278,60,72,31,'1',59,'2016-02-19 04:49:37',NULL,NULL),(279,60,72,32,'1',59,'2016-02-19 04:49:37',NULL,NULL),(280,60,72,33,'1',59,'2016-02-19 04:49:37',NULL,NULL),(281,60,72,34,'1',59,'2016-02-19 04:49:37',NULL,NULL),(282,60,81,5,'1',59,'2016-02-19 07:14:21',NULL,NULL),(283,60,81,6,'1',59,'2016-02-19 07:14:21',NULL,NULL),(284,60,81,7,'1',59,'2016-02-19 07:14:21',NULL,NULL),(285,60,81,8,'1',59,'2016-02-19 07:14:21',NULL,NULL),(286,60,81,9,'1',59,'2016-02-19 07:14:21',NULL,NULL),(287,60,81,32,'1',59,'2016-02-19 07:14:21',NULL,NULL),(288,60,81,33,'1',59,'2016-02-19 07:14:21',NULL,NULL),(289,60,81,34,'1',59,'2016-02-19 07:14:21',NULL,NULL),(290,60,90,1,'1',59,'2016-02-19 07:14:35',NULL,NULL),(291,60,90,18,'1',59,'2016-02-19 07:14:35',NULL,NULL),(292,60,90,19,'1',59,'2016-02-19 07:14:35',NULL,NULL),(293,60,90,20,'1',59,'2016-02-19 07:14:35',NULL,NULL),(294,60,90,21,'1',59,'2016-02-19 07:14:35',NULL,NULL),(295,60,87,1,'1',59,'2016-02-19 07:14:44',NULL,NULL),(296,60,87,18,'1',59,'2016-02-19 07:14:44',NULL,NULL),(297,60,87,19,'1',59,'2016-02-19 07:14:44',NULL,NULL),(298,60,87,20,'1',59,'2016-02-19 07:14:44',NULL,NULL),(299,60,87,21,'1',59,'2016-02-19 07:14:44',NULL,NULL),(300,60,79,1,'1',59,'2016-02-19 07:15:00',NULL,NULL),(301,60,79,12,'1',59,'2016-02-19 07:15:00',NULL,NULL),(302,60,79,13,'1',59,'2016-02-19 07:15:00',NULL,NULL),(303,60,79,14,'1',59,'2016-02-19 07:15:00',NULL,NULL),(304,60,79,15,'1',59,'2016-02-19 07:15:00',NULL,NULL),(305,60,79,16,'1',59,'2016-02-19 07:15:00',NULL,NULL),(306,60,79,17,'1',59,'2016-02-19 07:15:00',NULL,NULL),(307,60,82,1,'1',59,'2016-02-19 07:15:09',NULL,NULL),(308,60,82,25,'1',59,'2016-02-19 07:15:09',NULL,NULL),(309,60,82,26,'1',59,'2016-02-19 07:15:09',NULL,NULL),(310,60,82,27,'1',59,'2016-02-19 07:15:09',NULL,NULL),(311,60,82,28,'1',59,'2016-02-19 07:15:09',NULL,NULL),(312,60,82,29,'1',59,'2016-02-19 07:15:09',NULL,NULL),(313,60,82,30,'1',59,'2016-02-19 07:15:09',NULL,NULL),(314,60,82,31,'1',59,'2016-02-19 07:15:09',NULL,NULL),(315,60,74,4,'1',59,'2016-02-19 07:31:58',NULL,NULL),(316,58,66,2,'1',51,'2016-02-19 07:32:36',NULL,NULL),(317,58,66,3,'1',51,'2016-02-19 07:32:36',NULL,NULL),(318,58,68,29,'1',51,'2016-02-19 07:33:39',NULL,NULL),(319,58,67,1,'1',51,'2016-02-19 07:33:51',NULL,NULL),(320,58,67,5,'1',51,'2016-02-19 07:33:51',NULL,NULL),(321,58,67,6,'1',51,'2016-02-19 07:33:51',NULL,NULL),(322,58,67,7,'1',51,'2016-02-19 07:33:51',NULL,NULL),(323,58,67,8,'1',51,'2016-02-19 07:33:51',NULL,NULL),(324,58,67,9,'1',51,'2016-02-19 07:33:51',NULL,NULL),(325,58,67,32,'1',51,'2016-02-19 07:33:51',NULL,NULL),(326,58,67,33,'1',51,'2016-02-19 07:33:51',NULL,NULL),(327,58,67,34,'1',51,'2016-02-19 07:33:51',NULL,NULL),(328,61,91,1,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(329,61,91,2,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(330,61,91,3,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(331,61,91,4,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(332,61,91,5,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(333,61,91,6,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(334,61,91,7,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(335,61,91,8,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(336,61,91,9,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(337,61,91,10,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(338,61,91,11,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(339,61,91,12,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(340,61,91,13,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(341,61,91,14,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(342,61,91,15,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(343,61,91,16,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(344,61,91,17,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(345,61,91,18,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(346,61,91,19,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(347,61,91,20,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(348,61,91,21,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(349,61,91,22,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(350,61,91,23,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(351,61,91,24,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(352,61,91,25,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(353,61,91,26,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(354,61,91,27,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(355,61,91,28,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(356,61,91,29,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(357,61,91,30,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(358,61,91,31,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(359,61,91,32,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(360,61,91,33,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(361,61,91,34,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(362,61,91,78,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(363,61,91,79,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(364,61,91,80,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(365,61,91,99,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(366,61,91,100,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(367,61,91,101,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(368,61,91,102,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(369,61,91,103,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(370,61,91,104,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(371,61,91,105,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(372,61,91,106,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(373,61,91,107,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(374,61,91,108,'1',-1,'2016-02-21 23:16:05',NULL,NULL),(375,61,92,1,'1',67,'2016-02-23 02:28:24',NULL,NULL),(376,61,92,2,'1',67,'2016-02-23 02:28:24',NULL,NULL),(377,61,92,3,'1',67,'2016-02-23 02:28:24',NULL,NULL),(378,61,92,4,'1',67,'2016-02-23 02:28:24',NULL,NULL),(379,61,92,5,'1',67,'2016-02-23 02:28:24',NULL,NULL),(380,61,92,6,'1',67,'2016-02-23 02:28:24',NULL,NULL),(381,61,92,7,'1',67,'2016-02-23 02:28:24',NULL,NULL),(382,61,92,8,'1',67,'2016-02-23 02:28:24',NULL,NULL),(383,61,92,9,'1',67,'2016-02-23 02:28:24',NULL,NULL),(384,61,92,10,'1',67,'2016-02-23 02:28:24',NULL,NULL),(385,61,92,11,'1',67,'2016-02-23 02:28:24',NULL,NULL),(386,61,92,12,'1',67,'2016-02-23 02:28:24',NULL,NULL),(387,61,92,13,'1',67,'2016-02-23 02:28:24',NULL,NULL),(388,61,92,14,'1',67,'2016-02-23 02:28:24',NULL,NULL),(389,61,92,15,'1',67,'2016-02-23 02:28:24',NULL,NULL),(390,61,92,16,'1',67,'2016-02-23 02:28:24',NULL,NULL),(391,61,92,17,'1',67,'2016-02-23 02:28:24',NULL,NULL),(392,61,92,18,'1',67,'2016-02-23 02:28:24',NULL,NULL),(393,61,92,19,'1',67,'2016-02-23 02:28:24',NULL,NULL),(394,61,92,20,'1',67,'2016-02-23 02:28:24',NULL,NULL),(395,61,92,21,'1',67,'2016-02-23 02:28:24',NULL,NULL),(396,61,92,22,'1',67,'2016-02-23 02:28:24',NULL,NULL),(397,61,92,23,'1',67,'2016-02-23 02:28:24',NULL,NULL),(398,61,92,24,'1',67,'2016-02-23 02:28:24',NULL,NULL),(399,61,92,25,'1',67,'2016-02-23 02:28:24',NULL,NULL),(400,61,92,26,'1',67,'2016-02-23 02:28:24',NULL,NULL),(401,61,92,27,'1',67,'2016-02-23 02:28:24',NULL,NULL),(402,61,92,28,'1',67,'2016-02-23 02:28:24',NULL,NULL),(403,61,92,29,'1',67,'2016-02-23 02:28:24',NULL,NULL),(404,61,92,30,'1',67,'2016-02-23 02:28:24',NULL,NULL),(405,61,92,31,'1',67,'2016-02-23 02:28:24',NULL,NULL),(406,61,92,32,'1',67,'2016-02-23 02:28:24',NULL,NULL),(407,61,92,33,'1',67,'2016-02-23 02:28:24',NULL,NULL),(408,61,92,34,'1',67,'2016-02-23 02:28:24',NULL,NULL),(409,61,92,78,'1',67,'2016-02-23 02:28:24',NULL,NULL),(410,61,92,79,'1',67,'2016-02-23 02:28:24',NULL,NULL),(411,61,92,80,'1',67,'2016-02-23 02:28:24',NULL,NULL),(412,62,93,1,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(413,62,93,2,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(414,62,93,3,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(415,62,93,4,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(416,62,93,5,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(417,62,93,6,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(418,62,93,7,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(419,62,93,8,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(420,62,93,9,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(421,62,93,10,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(422,62,93,11,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(423,62,93,12,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(424,62,93,13,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(425,62,93,14,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(426,62,93,15,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(427,62,93,16,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(428,62,93,17,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(429,62,93,18,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(430,62,93,19,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(431,62,93,20,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(432,62,93,21,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(433,62,93,22,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(434,62,93,23,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(435,62,93,24,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(436,62,93,25,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(437,62,93,26,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(438,62,93,27,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(439,62,93,28,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(440,62,93,29,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(441,62,93,30,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(442,62,93,31,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(443,62,93,32,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(444,62,93,33,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(445,62,93,34,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(446,62,93,78,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(447,62,93,79,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(448,62,93,80,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(449,62,93,99,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(450,62,93,100,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(451,62,93,101,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(452,62,93,102,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(453,62,93,103,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(454,62,93,104,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(455,62,93,105,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(456,62,93,106,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(457,62,93,107,'1',-1,'2016-02-29 02:00:02',NULL,NULL),(458,62,93,108,'1',-1,'2016-02-29 02:00:02',NULL,NULL);

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

insert  into `co_room`(`room_id`,`tenant_id`,`ward_id`,`bed_name`,`maintain_id`,`occupied_status`,`notes`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (9,58,8,'2112',5,'0',NULL,'1',51,'2016-02-04 07:30:53',51,'2016-02-04 07:30:53','0000-00-00 00:00:00'),(10,58,9,'112',7,'0',NULL,'1',51,'2016-02-05 06:12:21',51,'2016-02-05 06:12:21','0000-00-00 00:00:00'),(11,58,8,'113',5,'0','','1',51,'2016-02-05 06:41:04',51,'2016-03-02 19:42:21','0000-00-00 00:00:00'),(12,58,8,'112',6,'1',NULL,'1',51,'2016-02-05 06:41:15',51,'2016-03-02 19:42:05','0000-00-00 00:00:00'),(17,58,8,'909',NULL,'0','','0',62,'2016-02-20 03:50:45',NULL,'2016-02-22 03:35:39','0000-00-00 00:00:00'),(18,60,12,'999',NULL,'1',NULL,'1',59,'2016-02-20 06:03:54',59,'2016-02-20 06:40:01','0000-00-00 00:00:00'),(19,60,12,'4234',NULL,'1','','1',59,'2016-02-20 06:05:14',59,'2016-02-21 22:50:16','0000-00-00 00:00:00'),(20,60,13,'2342',NULL,'1',NULL,'1',59,'2016-02-20 06:05:25',59,'2016-02-20 06:48:56','0000-00-00 00:00:00'),(21,60,14,'111',NULL,'1',NULL,'1',59,'2016-02-20 06:06:12',59,'2016-02-20 07:31:03','0000-00-00 00:00:00'),(23,60,13,'111',NULL,'0',NULL,'1',59,'2016-02-20 06:07:42',66,'2016-02-20 07:51:08','0000-00-00 00:00:00'),(30,60,13,'11',NULL,'0',NULL,'1',66,'2016-02-20 07:56:03',66,'2016-02-20 07:56:03','0000-00-00 00:00:00'),(31,61,15,'101',NULL,'0',NULL,'1',67,'2016-02-23 04:44:52',67,'2016-02-25 05:20:44','0000-00-00 00:00:00'),(32,61,15,'102',NULL,'1',NULL,'1',67,'2016-02-23 04:45:03',67,'2016-02-25 05:29:44','0000-00-00 00:00:00'),(33,61,15,'103',NULL,'0',NULL,'1',67,'2016-02-23 04:45:13',NULL,'2016-02-23 04:47:42','0000-00-00 00:00:00'),(34,61,16,'104',NULL,'0',NULL,'1',67,'2016-02-23 04:48:06',67,'2016-02-23 04:48:06','0000-00-00 00:00:00'),(35,61,16,'105',NULL,'1',NULL,'1',67,'2016-02-23 04:48:22',67,'2016-02-25 05:38:13','0000-00-00 00:00:00'),(36,61,16,'106',NULL,'0',NULL,'1',67,'2016-02-23 04:48:46',67,'2016-02-23 04:48:46','0000-00-00 00:00:00');

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

insert  into `co_room_charge`(`charge_id`,`tenant_id`,`charge_item_id`,`room_type_id`,`charge`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,1,9,'120.00','1',51,'2016-02-04 22:29:18',51,'2016-02-04 22:29:18','0000-00-00 00:00:00'),(2,58,1,11,'300.00','1',51,'2016-02-04 22:29:50',51,'2016-02-04 22:29:50','0000-00-00 00:00:00'),(3,58,1,13,'100.00','1',51,'2016-02-09 02:04:38',51,'2016-02-09 02:04:38','0000-00-00 00:00:00'),(4,58,3,10,'2000.00','1',51,'2016-02-09 02:38:16',51,'2016-02-09 02:38:16','0000-00-00 00:00:00'),(5,58,3,11,'2000.00','1',51,'2016-02-09 02:39:16',51,'2016-02-09 02:39:16','0000-00-00 00:00:00'),(6,60,4,14,'878.00','1',59,'2016-02-20 03:28:47',59,'2016-02-20 03:28:47','0000-00-00 00:00:00'),(7,60,5,15,'215.00','1',59,'2016-02-20 03:28:57',59,'2016-02-20 03:28:57','0000-00-00 00:00:00'),(8,60,6,16,'1255.00','1',59,'2016-02-20 03:29:12',59,'2016-02-20 03:29:12','0000-00-00 00:00:00'),(9,61,7,19,'450.00','1',67,'2016-02-23 04:49:52',67,'2016-02-23 04:49:52','0000-00-00 00:00:00'),(10,61,7,20,'500.00','1',67,'2016-02-23 04:50:26',67,'2016-02-23 04:51:21','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_charge_item` */

insert  into `co_room_charge_item`(`charge_item_id`,`tenant_id`,`charge_item_name`,`charge_item_code`,`charge_item_description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'Test','TE','Testing','1',51,'2016-02-03 00:46:31',51,'2016-02-03 00:46:31','0000-00-00 00:00:00'),(2,58,'doppler','2389','doppler','1',51,'2016-02-04 22:38:37',51,'2016-02-04 22:38:37','0000-00-00 00:00:00'),(3,58,'Room Rent','123','Rent for Rooms','1',51,'2016-02-09 02:37:57',51,'2016-02-09 02:37:57','0000-00-00 00:00:00'),(4,60,'DMO','1','DMO','1',59,'2016-02-19 07:28:13',59,'2016-02-19 07:28:13','0000-00-00 00:00:00'),(5,60,'NURSING CHARGES','2','NURSING CHARGES','1',59,'2016-02-19 07:28:24',59,'2016-02-19 07:28:24','0000-00-00 00:00:00'),(6,60,'ROOM RENT','3','ROOM RENT','1',59,'2016-02-19 07:28:39',59,'2016-02-19 07:28:39','0000-00-00 00:00:00'),(7,61,'DMO','DMO','DMO','1',67,'2016-02-23 02:30:10',67,'2016-02-23 02:30:10','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_charge_subcategory` */

insert  into `co_room_charge_subcategory`(`charge_subcat_id`,`tenant_id`,`charge_cat_id`,`charge_subcat_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (20,58,3,'misc1','1',51,'2016-02-04 07:04:18',51,'2016-02-04 07:04:18','0000-00-00 00:00:00'),(21,58,3,'misc2','1',51,'2016-02-04 07:04:18',51,'2016-02-04 07:04:18','0000-00-00 00:00:00'),(22,58,1,'stomach wash','1',51,'2016-02-04 22:34:10',51,'2016-02-04 22:34:10','0000-00-00 00:00:00'),(23,58,2,'Alied','1',51,'2016-02-05 06:22:39',51,'2016-02-05 06:22:39','0000-00-00 00:00:00'),(24,58,4,'Challenge test','1',51,'2016-02-09 01:47:51',51,'2016-02-09 01:48:48','0000-00-00 00:00:00'),(25,58,5,'DMO','1',51,'2016-02-09 02:19:46',51,'2016-02-09 02:19:46','0000-00-00 00:00:00'),(26,58,5,'Room Rent','1',51,'2016-02-09 02:19:46',51,'2016-02-09 02:19:46','0000-00-00 00:00:00'),(27,60,8,'vikhram','1',59,'2016-02-17 23:12:07',14,'2016-02-17 23:12:07','2016-02-19 07:51:27'),(28,60,8,'mary','1',59,'2016-02-17 23:12:07',14,'2016-02-17 23:12:07','2016-02-19 07:51:29'),(29,60,8,'jayant','1',59,'2016-02-17 23:12:07',14,'2016-02-17 23:12:07','2016-02-19 07:51:30'),(30,60,1,'Pulse Check','1',59,'2016-02-18 01:01:49',59,'2016-02-18 01:01:49','0000-00-00 00:00:00'),(31,60,2,'CANTEEN CHARGES','1',59,'2016-02-19 07:24:55',59,'2016-02-19 07:24:55','0000-00-00 00:00:00'),(32,60,2,'DRESSING CHARGES','1',59,'2016-02-19 07:25:25',59,'2016-02-19 07:25:25','0000-00-00 00:00:00'),(33,60,2,'MONITOR CHARGES','1',59,'2016-02-19 07:25:26',59,'2016-02-19 07:25:26','0000-00-00 00:00:00'),(34,60,2,'NEBULIZATION CHARGES','1',59,'2016-02-19 07:25:28',59,'2016-02-19 07:25:28','0000-00-00 00:00:00'),(35,60,1,'Aversion','1',59,'2016-02-19 07:25:54',59,'2016-02-19 07:25:54','0000-00-00 00:00:00'),(36,60,1,'Challenge Test','1',59,'2016-02-19 07:26:01',59,'2016-02-19 07:26:01','0000-00-00 00:00:00'),(37,60,1,'Treatment Charges','1',59,'2016-02-19 07:26:31',59,'2016-02-19 07:26:31','0000-00-00 00:00:00'),(38,61,9,'test','1',67,'2016-02-23 04:36:30',67,'2016-02-23 04:36:30','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_types_rooms` */

insert  into `co_room_types_rooms`(`room_type_room_id`,`tenant_id`,`room_type_id`,`room_id`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (11,58,9,9,51,'2016-02-04 07:31:07',51,'2016-02-04 07:31:07'),(13,58,10,10,51,'2016-02-05 06:39:43',51,'2016-02-05 06:39:43'),(14,58,11,10,51,'2016-02-05 06:39:43',51,'2016-02-05 06:39:43'),(15,58,11,9,51,'2016-02-05 06:39:58',51,'2016-02-05 06:39:58'),(16,58,9,11,51,'2016-02-05 06:42:02',51,'2016-02-05 06:42:02'),(17,58,10,11,51,'2016-02-05 06:42:02',51,'2016-02-05 06:42:02'),(18,58,11,11,51,'2016-02-05 06:42:02',51,'2016-02-05 06:42:02'),(19,58,12,11,51,'2016-02-05 06:42:02',51,'2016-02-05 06:42:02'),(20,58,12,12,51,'2016-02-05 06:42:11',51,'2016-02-05 06:42:11'),(21,58,9,12,51,'2016-02-15 07:12:36',51,'2016-02-15 07:12:36'),(22,60,16,23,59,'2016-02-20 06:07:58',59,'2016-02-20 06:07:58'),(23,60,14,21,59,'2016-02-20 06:08:06',59,'2016-02-20 06:08:06'),(24,60,18,21,59,'2016-02-20 06:08:06',59,'2016-02-20 06:08:06'),(25,60,15,20,59,'2016-02-20 06:08:14',59,'2016-02-20 06:08:14'),(26,60,17,20,59,'2016-02-20 06:08:14',59,'2016-02-20 06:08:14'),(27,60,15,19,59,'2016-02-20 06:08:22',59,'2016-02-20 06:08:22'),(28,60,18,19,59,'2016-02-20 06:08:22',59,'2016-02-20 06:08:22'),(29,60,14,18,59,'2016-02-20 06:08:32',59,'2016-02-20 06:08:32'),(30,60,16,18,59,'2016-02-20 06:08:32',59,'2016-02-20 06:08:32'),(31,61,19,31,67,'2016-02-23 04:49:09',67,'2016-02-23 04:49:09'),(32,61,20,31,67,'2016-02-23 04:49:09',67,'2016-02-23 04:49:09'),(33,61,19,32,67,'2016-02-23 04:49:18',67,'2016-02-23 04:49:18'),(34,61,20,34,67,'2016-02-23 04:49:30',67,'2016-02-23 04:49:30'),(35,61,19,34,67,'2016-02-23 04:49:30',67,'2016-02-23 04:49:30'),(36,61,19,35,67,'2016-02-23 05:28:01',67,'2016-02-23 05:28:01'),(37,61,20,35,67,'2016-02-23 05:28:01',67,'2016-02-23 05:28:01'),(38,61,19,36,67,'2016-02-23 05:29:43',67,'2016-02-23 05:29:43'),(39,61,20,36,67,'2016-02-23 05:29:43',67,'2016-02-23 05:29:43'),(40,61,19,33,67,'2016-02-23 05:29:55',67,'2016-02-23 05:29:55'),(41,61,20,33,67,'2016-02-23 05:29:55',67,'2016-02-23 05:29:55'),(42,58,10,12,51,'2016-03-02 19:18:23',51,'2016-03-02 19:18:23'),(43,58,13,12,51,'2016-03-02 19:18:23',51,'2016-03-02 19:18:23'),(44,58,11,12,51,'2016-03-02 19:18:24',51,'2016-03-02 19:18:24');

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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;

/*Data for the table `co_tenant` */

insert  into `co_tenant`(`tenant_id`,`org_id`,`tenant_guid`,`tenant_name`,`tenant_address`,`tenant_city_id`,`tenant_state_id`,`tenant_country_id`,`tenant_contact1`,`tenant_contact2`,`tenant_fax`,`tenant_mobile`,`tenant_email`,`tenant_url`,`slug`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (58,7,'','Ahana','Gandhi Nagar',1,1,1,'123','','','','vikhram@ahana.com','http://ahana.com','','1',-1,'2016-02-02 22:26:38',-1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(59,7,'','Ark Infotec','Bye-pass',4,3,2,'123','','','','gayatri@ark.com','http://ark.com','','0',-1,'2016-02-02 22:43:11',-1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(60,7,'','Radianz','rad',2,1,1,'123123','','','','abc@radianz.com','','','1',-1,'2016-02-17 06:28:38',-1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(61,7,NULL,'test','test',1,8,7,'99999999',NULL,NULL,NULL,'test.t@gm.xc','http://ahanahospitals.in/',NULL,'1',-1,'2016-02-21 23:16:05',-1,'2016-02-21 23:16:05','0000-00-00 00:00:00'),(62,0,NULL,'test test','test',5,8,7,'2323232323','',NULL,NULL,'34343@3444.3',NULL,NULL,'1',-1,'2016-02-29 02:00:01',-1,'2016-02-29 02:08:44','0000-00-00 00:00:00');

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

insert  into `co_user`(`user_id`,`tenant_id`,`org_id`,`title_code`,`name`,`designation`,`address`,`city_id`,`state_id`,`zip`,`country_id`,`contact1`,`contact2`,`mobile`,`email`,`speciality_id`,`care_provider`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (51,58,0,'Dr.','Vikhram','Doctor','Anna Nagar',1,8,'625008',7,NULL,NULL,'8989898989','vikhram@ahana.com',NULL,'0','1',-1,'2016-02-02 22:26:38',-1,'2016-02-02 22:26:38','0000-00-00 00:00:00'),(52,59,0,'Miss.','Gayatri','HR','Byepass',1,8,'625010',7,NULL,NULL,'7878787878','gayatri@ark.com',NULL,'0','1',-1,'2016-02-02 22:43:11',-1,'2016-02-04 05:55:51','0000-00-00 00:00:00'),(53,58,0,'Mr.','Gayatri','HR','11231',1,8,'1231231',7,NULL,NULL,'1121212','gayatri@gmail.com',NULL,'0','1',51,'2016-02-03 01:04:06',51,'2016-02-03 01:04:06','0000-00-00 00:00:00'),(54,58,0,'Dr.','John','Doctor','abc',1,8,'123123',7,NULL,NULL,'123123','john@a.com',NULL,'1','1',51,'2016-02-04 07:06:51',51,'2016-02-05 22:58:11','0000-00-00 00:00:00'),(55,58,0,'Mr.','sadasd','asdasd','asasd',1,8,'123123',7,NULL,NULL,'123123123','a@abc.com',NULL,'0','1',51,'2016-02-04 07:29:11',51,'2016-02-04 07:29:11','0000-00-00 00:00:00'),(56,58,0,'Dr.','Surya','Doctor','abc',1,8,'234234',7,NULL,NULL,'123123123','surya@gmail.com',1,'1','1',51,'2016-02-05 22:50:38',51,'2016-02-06 02:23:28','0000-00-00 00:00:00'),(57,58,0,'Mr.','2341234','sdf','sdfsdf',1,8,'12341234',7,'2341234','1234','2341234','sadfsad@asdf.com',1,'0','1',51,'2016-02-15 06:48:47',51,'2016-02-15 06:48:47','0000-00-00 00:00:00'),(58,58,0,'Mrs.','Jo','Doctor','sdfa',4,10,'123123',11,'123','123','123','dg@adf.com',1,'1','1',51,'2016-02-15 07:14:24',51,'2016-02-15 07:14:24','0000-00-00 00:00:00'),(59,60,0,'Miss.','Gayatri','doctor','12341243',1,8,'2341234',7,NULL,NULL,'1342134','g@abc.com',NULL,'0','1',-1,'2016-02-17 06:28:38',-1,'2016-02-17 06:28:38','0000-00-00 00:00:00'),(60,60,0,'Dr.','Gayatri','doctor','park st.',1,8,'12341234',7,NULL,NULL,'1342134234','g@yopmail.com',3,'1','1',59,'2016-02-17 06:32:40',59,'2016-02-18 03:08:22','0000-00-00 00:00:00'),(61,60,0,'Dr.','Sagar','Doctor','sfsdfa',1,8,'12123',7,NULL,NULL,'12313','abc@gmail.com',3,'1','1',59,'2016-02-18 00:59:09',59,'2016-02-18 00:59:09','0000-00-00 00:00:00'),(62,58,0,'Mr.','Prakash','ARK','test test',1,8,'625002',7,NULL,NULL,'9555652154','prakash.paramanandam@arkinfotec.com',NULL,'0','1',51,'2016-02-19 07:08:10',51,'2016-02-19 07:08:10','0000-00-00 00:00:00'),(63,58,0,'Mr.','Nadesh','ARK','asdasdsa',1,8,'625010',7,NULL,NULL,'12312312323','nadesh@arkinfotec.com',NULL,'0','1',51,'2016-02-19 07:08:55',51,'2016-02-19 07:08:55','0000-00-00 00:00:00'),(64,60,0,'Dr.','Jessi','Doctor','aaa',1,8,'123123',7,NULL,NULL,'1231231231','jess@abc.com',2,'1','1',59,'2016-02-19 07:29:45',59,'2016-02-19 07:29:45','0000-00-00 00:00:00'),(65,60,0,'Dr.','Neeraj','Doctor','abcd',4,10,'121212',11,NULL,NULL,'1231231231','neeraj@gmail.com',4,'1','1',59,'2016-02-19 07:30:54',59,'2016-02-19 07:52:43','0000-00-00 00:00:00'),(66,60,0,'Mr.','Prakash Arulmani','ARK','test test',1,8,'952021',7,NULL,NULL,'9569562512','prakash@gmail.com',NULL,'0','1',59,'2016-02-20 05:10:04',59,'2016-02-20 05:10:04','0000-00-00 00:00:00'),(67,61,0,'Mrs.','Paramesh','Testor','test',1,8,'33434',7,NULL,NULL,'9789654321','parames.31390@gmail.com',NULL,'0','1',-1,'2016-02-21 23:16:05',-1,'2016-02-27 06:07:08','0000-00-00 00:00:00'),(68,61,0,'Dr.','Vikhram Vikhram  Vikhram  Vikhram  Vikhram  Vikh','psychiatrist','test',1,8,'625001',7,NULL,NULL,'9876543210','vikhram@ahanahospitals.in',11,'1','1',67,'2016-02-21 23:25:03',67,'2016-02-27 07:46:51','0000-00-00 00:00:00'),(69,61,0,'Dr.','CRS','Phychartist','test',1,8,'62555',7,NULL,NULL,'9876543210','CRS@ahana.in',11,'1','1',67,'2016-02-25 02:19:05',67,'2016-02-25 02:19:05','0000-00-00 00:00:00'),(70,61,0,'Dr.','Panjanathan','GMO','asdfasd',1,8,'322',7,NULL,NULL,'343343434','test@test.coo',12,'1','1',67,'2016-02-27 07:40:49',67,'2016-02-27 07:40:49','0000-00-00 00:00:00'),(71,61,0,'Dr.','Raja Raja Raja Raja Raja Raja Raja Raja Raja','DMO','test',1,8,'34343',7,NULL,NULL,'03934030','raja@ahana.in',11,'1','1',67,'2016-02-27 07:42:02',67,'2016-02-27 07:45:35','0000-00-00 00:00:00'),(72,61,0,'Dr.','Gopi Gopi Gopi Gopi Gopi Gopi Gopi','Counseller','DFDFD',1,8,'34',7,NULL,NULL,'344','gopi@ahana.in',11,'1','1',67,'2016-02-27 07:42:51',67,'2016-02-27 07:44:37','0000-00-00 00:00:00'),(73,62,0,'Mrs.','Paramesh','testor','34343',5,8,'343434',7,NULL,NULL,'3434343434','test@test.com',NULL,'0','1',-1,'2016-02-29 02:00:01',-1,'2016-02-29 02:00:01','0000-00-00 00:00:00');

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
  `admission_status` varchar(2) NOT NULL DEFAULT 'A' COMMENT 'A - Admission, D-Discharge, TD- Transfer Doctor, TR - Transfer Room',
  `status` enum('0','1') DEFAULT '1',
  `notes` text,
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
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;

/*Data for the table `pat_admission` */

insert  into `pat_admission`(`admn_id`,`tenant_id`,`patient_id`,`encounter_id`,`status_date`,`consultant_id`,`floor_id`,`ward_id`,`room_id`,`room_type_id`,`admission_status`,`status`,`notes`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,60,33,36,'2016-02-20 18:01:24',60,16,12,18,16,'A','1',NULL,59,'2016-02-20 06:31:36',59,'2016-02-20 06:31:36','0000-00-00 00:00:00'),(2,60,33,36,'2016-02-20 18:01:54',61,16,12,18,16,'','1',NULL,59,'2016-02-20 06:32:06',59,'2016-02-20 06:32:06','0000-00-00 00:00:00'),(3,60,33,36,'2016-02-20 18:04:45',61,16,12,18,16,'D','1',NULL,59,'2016-02-20 06:35:01',59,'2016-02-20 06:35:01','0000-00-00 00:00:00'),(4,60,33,37,'2016-02-20 18:14:26',60,16,12,19,18,'A','1',NULL,59,'2016-02-20 06:44:38',59,'2016-02-20 06:44:38','0000-00-00 00:00:00'),(5,60,33,37,'2016-02-20 18:14:48',60,17,13,20,17,'','1',NULL,59,'2016-02-20 06:45:04',59,'2016-02-20 06:45:04','0000-00-00 00:00:00'),(6,60,33,37,'2016-02-20 18:18:45',60,17,13,20,17,'D','1',NULL,59,'2016-02-20 06:48:56',59,'2016-02-20 06:48:56','0000-00-00 00:00:00'),(7,60,33,38,'2016-02-20 18:21:27',61,18,14,21,14,'A','1',NULL,59,'2016-02-20 06:51:37',59,'2016-02-20 06:51:37','0000-00-00 00:00:00'),(8,60,35,39,'2016-02-20 18:35:42',60,16,12,19,15,'A','1',NULL,59,'2016-02-20 07:05:54',59,'2016-02-20 07:05:54','0000-00-00 00:00:00'),(9,60,35,39,'2016-02-20 18:47:12',60,18,14,21,14,'','1',NULL,59,'2016-02-20 07:17:40',59,'2016-02-20 07:17:40','0000-00-00 00:00:00'),(10,60,33,38,'2016-02-20 18:47:12',61,16,12,19,15,'','1',NULL,59,'2016-02-20 07:17:40',59,'2016-02-20 07:17:40','0000-00-00 00:00:00'),(11,60,35,39,'2016-02-20 18:47:56',60,16,12,19,18,'','1',NULL,59,'2016-02-20 07:18:26',59,'2016-02-20 07:18:26','0000-00-00 00:00:00'),(12,60,33,38,'2016-02-20 18:47:56',61,18,14,21,18,'','1',NULL,59,'2016-02-20 07:18:26',59,'2016-02-20 07:18:26','0000-00-00 00:00:00'),(13,60,34,40,'2016-02-20 18:52:46',60,17,13,23,16,'A','1',NULL,66,'2016-02-20 07:23:01',66,'2016-02-20 07:23:01','0000-00-00 00:00:00'),(14,60,34,40,'2016-02-20 18:53:28',60,17,13,23,16,'D','1',NULL,66,'2016-02-20 07:23:34',66,'2016-02-20 07:23:34','0000-00-00 00:00:00'),(15,60,35,39,'2016-02-20 18:58:51',60,18,14,21,14,'','1',NULL,59,'2016-02-20 07:31:03',59,'2016-02-20 07:31:03','0000-00-00 00:00:00'),(16,60,33,38,'2016-02-20 18:58:51',61,16,12,19,18,'','1',NULL,59,'2016-02-20 07:31:03',59,'2016-02-20 07:31:03','0000-00-00 00:00:00'),(17,60,34,41,'2016-02-20 19:20:28',60,17,13,23,16,'A','1',NULL,66,'2016-02-20 07:50:48',66,'2016-02-20 07:50:48','0000-00-00 00:00:00'),(18,60,34,41,'2016-02-20 19:21:02',60,17,13,23,16,'D','1',NULL,66,'2016-02-20 07:51:08',66,'2016-02-20 07:51:08','0000-00-00 00:00:00'),(19,60,33,38,'2016-02-20 19:50:02',61,16,12,19,18,'D','1',NULL,59,'2016-02-20 08:20:10',59,'2016-02-20 08:20:10','0000-00-00 00:00:00'),(20,60,33,43,'2016-02-22 10:20:06',60,16,12,19,15,'A','1',NULL,59,'2016-02-21 22:50:16',59,'2016-02-21 22:50:16','0000-00-00 00:00:00'),(21,58,37,51,'2016-02-22 14:04:36',56,7,8,12,12,'A','1',NULL,51,'2016-02-22 02:35:00',51,'2016-02-22 02:35:00','0000-00-00 00:00:00'),(22,58,37,51,'2016-02-22 14:14:37',56,7,8,12,12,'D','1',NULL,51,'2016-02-22 02:44:41',51,'2016-02-22 02:44:41','0000-00-00 00:00:00'),(23,58,37,54,'2016-02-22 14:32:20',54,7,8,12,12,'A','1',NULL,51,'2016-02-22 03:02:39',51,'2016-02-22 03:02:39','0000-00-00 00:00:00'),(24,58,37,54,'2016-02-22 18:04:28',54,7,8,12,12,'D','1',NULL,51,'2016-02-22 06:34:32',51,'2016-02-22 06:34:32','0000-00-00 00:00:00'),(25,61,36,55,'2016-02-23 16:49:16',68,19,15,31,19,'A','1',NULL,67,'2016-02-23 05:19:43',67,'2016-02-23 05:19:43','0000-00-00 00:00:00'),(26,61,36,55,'2016-02-25 16:50:01',69,19,15,31,19,'','1',NULL,67,'2016-02-25 05:20:15',67,'2016-02-25 05:20:15','0000-00-00 00:00:00'),(27,61,36,55,'2016-02-25 16:50:28',69,19,16,35,20,'','1',NULL,67,'2016-02-25 05:20:44',67,'2016-02-25 05:20:44','0000-00-00 00:00:00'),(28,61,24,59,'2016-02-25 16:58:08',69,19,15,32,19,'A','1',NULL,67,'2016-02-25 05:28:29',67,'2016-02-25 05:28:29','0000-00-00 00:00:00'),(29,61,24,59,'2016-02-25 16:59:28',69,19,16,35,20,'','1',NULL,67,'2016-02-25 05:29:44',67,'2016-02-25 05:29:44','0000-00-00 00:00:00'),(30,61,36,55,'2016-02-25 16:59:28',69,19,15,32,19,'','1',NULL,67,'2016-02-25 05:29:44',67,'2016-02-25 05:29:44','0000-00-00 00:00:00'),(31,61,24,59,'2016-02-25 16:59:54',69,19,16,35,20,'D','1',NULL,67,'2016-02-25 05:30:03',67,'2016-02-25 05:30:03','0000-00-00 00:00:00'),(32,61,24,60,'2016-02-25 17:07:55',69,19,16,35,19,'A','1',NULL,67,'2016-02-25 05:38:13',67,'2016-02-25 05:38:13','0000-00-00 00:00:00'),(33,58,39,63,'2016-03-02 16:00:02',54,7,8,12,12,'A','1',NULL,51,'2016-03-02 16:00:11',51,'2016-03-02 16:00:11','0000-00-00 00:00:00'),(34,58,39,63,'2016-03-02 16:04:45',54,7,8,12,12,'D','1',NULL,51,'2016-03-02 16:04:49',51,'2016-03-02 16:04:49','0000-00-00 00:00:00'),(35,58,39,66,'2016-03-02 16:59:19',54,7,8,12,12,'A','1',NULL,51,'2016-03-02 16:59:27',51,'2016-03-02 16:59:27','0000-00-00 00:00:00'),(36,58,39,66,'2016-03-02 17:30:41',54,7,8,12,12,'D','1',NULL,51,'2016-03-02 17:30:47',51,'2016-03-02 17:30:47','0000-00-00 00:00:00'),(37,58,39,68,'2016-03-02 17:57:52',54,7,8,12,12,'A','1',NULL,51,'2016-03-02 17:58:01',51,'2016-03-02 17:58:01','0000-00-00 00:00:00'),(38,58,26,69,'2016-03-02 18:33:20',54,7,8,11,9,'A','1',NULL,51,'2016-03-02 18:33:33',51,'2016-03-02 18:33:33','0000-00-00 00:00:00'),(39,58,39,68,'2016-03-02 19:07:04',54,7,8,11,12,'TR','1',NULL,51,'2016-03-02 19:08:45',51,'2016-03-02 19:08:45','0000-00-00 00:00:00'),(40,58,26,69,'2016-03-02 19:07:04',54,7,8,12,9,'TR','1',NULL,51,'2016-03-02 19:08:45',51,'2016-03-02 19:08:45','0000-00-00 00:00:00'),(41,58,39,68,'2016-03-02 19:09:38',54,7,8,12,12,'TR','1',NULL,51,'2016-03-02 19:09:50',51,'2016-03-02 19:09:50','0000-00-00 00:00:00'),(42,58,26,69,'2016-03-02 19:09:38',54,7,8,11,10,'TR','1',NULL,51,'2016-03-02 19:09:50',51,'2016-03-02 19:09:50','0000-00-00 00:00:00'),(43,58,39,68,'2016-03-02 19:18:30',54,7,8,11,12,'TR','1',NULL,51,'2016-03-02 19:18:39',51,'2016-03-02 19:18:39','0000-00-00 00:00:00'),(44,58,26,69,'2016-03-02 19:18:30',54,7,8,12,10,'TR','1',NULL,51,'2016-03-02 19:18:40',51,'2016-03-02 19:18:40','0000-00-00 00:00:00'),(45,58,39,68,'2016-03-02 19:19:08',54,7,8,12,12,'TR','1',NULL,51,'2016-03-02 19:20:34',51,'2016-03-02 19:20:34','0000-00-00 00:00:00'),(46,58,26,69,'2016-03-02 19:19:08',54,7,8,11,10,'TR','1',NULL,51,'2016-03-02 19:20:34',51,'2016-03-02 19:20:34','0000-00-00 00:00:00'),(47,58,39,68,'2016-03-02 19:20:48',54,7,8,11,10,'TR','1',NULL,51,'2016-03-02 19:20:58',51,'2016-03-02 19:20:58','0000-00-00 00:00:00'),(48,58,26,69,'2016-03-02 19:20:48',54,7,8,12,9,'TR','1',NULL,51,'2016-03-02 19:20:58',51,'2016-03-02 19:20:58','0000-00-00 00:00:00'),(49,58,39,68,'2016-03-02 19:35:43',54,7,8,12,10,'TR','1',NULL,51,'2016-03-02 19:37:21',51,'2016-03-02 19:37:21','0000-00-00 00:00:00'),(50,58,26,69,'2016-03-02 19:35:43',54,7,8,11,9,'TR','1',NULL,51,'2016-03-02 19:37:21',51,'2016-03-02 19:37:21','0000-00-00 00:00:00'),(51,58,39,68,'2016-03-02 19:40:17',54,7,8,11,11,'TR','1',NULL,51,'2016-03-02 19:42:05',51,'2016-03-02 19:42:05','0000-00-00 00:00:00'),(52,58,26,69,'2016-03-02 19:40:17',54,7,8,12,12,'TR','1',NULL,51,'2016-03-02 19:42:05',51,'2016-03-02 19:42:05','0000-00-00 00:00:00'),(53,58,39,68,'2016-03-02 19:42:16',54,7,8,11,11,'D','1',NULL,51,'2016-03-02 19:42:21',51,'2016-03-02 19:42:21','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `pat_alert` */

insert  into `pat_alert`(`pat_alert_id`,`tenant_id`,`alert_id`,`patient_id`,`alert_description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,60,2,33,'Bill payment','1',59,'2016-02-21 22:33:07',59,'2016-02-21 22:33:07','0000-00-00 00:00:00'),(2,60,3,35,'new patient','1',59,'2016-02-21 22:51:06',59,'2016-02-21 22:51:06','0000-00-00 00:00:00'),(3,58,1,37,'sd','1',51,'2016-02-22 03:21:56',51,'2016-02-22 03:21:56','0000-00-00 00:00:00'),(4,61,5,24,'adfasfas','1',67,'2016-02-25 05:30:23',67,'2016-02-25 05:30:23','0000-00-00 00:00:00'),(5,61,5,24,'34434  343 434','1',67,'2016-02-27 07:47:40',67,'2016-02-27 07:47:40','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=latin1;

/*Data for the table `pat_appointment` */

insert  into `pat_appointment`(`appt_id`,`tenant_id`,`patient_id`,`encounter_id`,`status_date`,`status_time`,`consultant_id`,`appt_status`,`status`,`amount`,`notes`,`patient_cat_id`,`patient_bill_type`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,18,1,'2016-02-16','05:00:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-16 06:31:03',51,'2016-02-16 06:31:03','0000-00-00 00:00:00'),(2,58,18,1,'2016-02-16','05:00:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-16 06:31:03',51,'2016-02-16 06:31:03','0000-00-00 00:00:00'),(3,58,24,2,'2016-02-17','05:05:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 00:18:11',51,'2016-02-17 00:18:11','0000-00-00 00:00:00'),(4,58,24,2,'2016-02-17','05:05:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 00:18:11',51,'2016-02-17 00:18:11','0000-00-00 00:00:00'),(5,58,28,3,'2016-02-17','11:55:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 01:15:34',51,'2016-02-17 01:15:34','0000-00-00 00:00:00'),(6,58,28,3,'2016-02-17','11:10:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 01:18:59',51,'2016-02-17 01:18:59','0000-00-00 00:00:00'),(7,58,28,3,'2016-02-17','00:00:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 01:19:13',51,'2016-02-17 01:19:13','0000-00-00 00:00:00'),(8,58,28,4,'2016-02-17','11:35:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 01:27:48',51,'2016-02-17 01:27:48','0000-00-00 00:00:00'),(9,58,28,4,'2016-02-17','11:35:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 01:27:48',51,'2016-02-17 01:27:48','0000-00-00 00:00:00'),(10,58,20,5,'2016-02-17','05:35:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 02:54:27',51,'2016-02-17 02:54:27','0000-00-00 00:00:00'),(11,58,20,5,'2016-02-17','05:35:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 02:54:27',51,'2016-02-17 02:54:27','0000-00-00 00:00:00'),(12,60,29,6,'2016-02-17','09:05:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-17 06:34:19',59,'2016-02-17 06:34:19','0000-00-00 00:00:00'),(13,60,29,6,'2016-02-17','09:05:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 06:34:19',59,'2016-02-17 06:34:19','0000-00-00 00:00:00'),(14,58,30,7,'2016-02-17','06:20:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 06:42:33',51,'2016-02-17 06:42:33','0000-00-00 00:00:00'),(15,58,30,7,'2016-02-17','18:12:42',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 06:43:01',51,'2016-02-17 06:43:01','0000-00-00 00:00:00'),(16,58,30,7,'2016-02-17','18:17:58',54,'S','1','122.00',NULL,4,NULL,51,'2016-02-17 06:49:37',51,'2016-02-17 06:49:37','0000-00-00 00:00:00'),(17,58,20,5,'2016-02-03','01:10:00',54,'S','1','600.00',NULL,4,NULL,51,'2016-02-17 06:59:09',51,'2016-02-17 06:59:09','0000-00-00 00:00:00'),(18,58,20,8,'2016-02-17','05:50:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 07:07:13',51,'2016-02-17 07:07:13','0000-00-00 00:00:00'),(19,58,20,8,'2016-02-17','05:50:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 07:07:13',51,'2016-02-17 07:07:13','0000-00-00 00:00:00'),(20,60,25,9,'2016-02-17','09:55:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-17 07:29:20',59,'2016-02-17 07:29:20','0000-00-00 00:00:00'),(21,60,25,9,'2016-02-17','09:55:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 07:29:20',59,'2016-02-17 07:29:20','0000-00-00 00:00:00'),(22,60,30,10,'2016-02-18','10:00:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-17 07:29:52',59,'2016-02-17 07:29:52','0000-00-00 00:00:00'),(23,60,30,10,'2016-02-17','19:00:44',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 07:30:49',59,'2016-02-17 07:30:49','0000-00-00 00:00:00'),(24,60,30,10,'2016-02-17','00:00:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 07:30:57',59,'2016-02-17 07:30:57','0000-00-00 00:00:00'),(25,60,19,11,'2016-02-17','09:35:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-17 07:34:52',59,'2016-02-17 07:34:52','0000-00-00 00:00:00'),(26,60,19,11,'2016-02-17','09:35:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 07:34:53',59,'2016-02-17 07:34:53','0000-00-00 00:00:00'),(27,58,24,2,'2016-02-17','19:21:17',54,'C','1','0.00',NULL,NULL,NULL,51,'2016-02-17 07:51:17',51,'2016-02-17 07:51:17','0000-00-00 00:00:00'),(28,58,24,12,'2016-02-17','11:35:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 07:57:52',51,'2016-02-17 07:57:52','0000-00-00 00:00:00'),(29,58,24,12,'2016-02-17','19:28:09',56,'C','1','0.00',NULL,NULL,NULL,51,'2016-02-17 07:58:09',51,'2016-02-17 07:58:09','0000-00-00 00:00:00'),(30,58,20,13,'2016-02-18','11:05:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 22:41:36',51,'2016-02-17 22:41:36','0000-00-00 00:00:00'),(31,58,26,14,'2016-02-18','11:10:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 22:42:12',51,'2016-02-17 22:42:12','0000-00-00 00:00:00'),(32,58,26,14,'2016-02-18','10:12:54',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 22:43:00',51,'2016-02-17 22:43:00','0000-00-00 00:00:00'),(33,58,26,14,'2016-02-18','00:00:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 22:43:26',51,'2016-02-17 22:43:26','0000-00-00 00:00:00'),(34,58,26,14,'2016-02-18','00:00:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 22:48:18',51,'2016-02-17 22:48:18','0000-00-00 00:00:00'),(35,58,26,14,'2016-02-18','00:00:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-17 22:51:07',51,'2016-02-17 22:51:07','0000-00-00 00:00:00'),(36,58,25,15,'2016-02-18','11:10:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-17 23:05:04',51,'2016-02-17 23:05:04','0000-00-00 00:00:00'),(37,60,21,16,'2016-02-18','09:10:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:07:13',59,'2016-02-17 23:07:13','0000-00-00 00:00:00'),(38,60,21,16,'2016-02-18','10:37:26',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:07:39',59,'2016-02-17 23:07:39','0000-00-00 00:00:00'),(39,60,21,16,'2016-02-18','00:00:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:07:47',59,'2016-02-17 23:07:47','0000-00-00 00:00:00'),(40,60,27,17,'2016-02-18','09:05:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:14:58',59,'2016-02-17 23:14:58','0000-00-00 00:00:00'),(41,60,27,17,'2016-02-18','09:05:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:14:58',59,'2016-02-17 23:14:58','0000-00-00 00:00:00'),(42,60,21,16,'2016-02-18','10:51:14',60,'C','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:21:15',59,'2016-02-17 23:21:15','0000-00-00 00:00:00'),(43,60,21,18,'2016-02-18','09:05:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:21:46',59,'2016-02-17 23:21:46','0000-00-00 00:00:00'),(44,60,21,18,'2016-02-18','10:51:55',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:21:58',59,'2016-02-17 23:21:58','0000-00-00 00:00:00'),(45,60,21,18,'2016-02-18','00:00:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:22:26',59,'2016-02-17 23:22:26','0000-00-00 00:00:00'),(46,60,21,18,'2016-02-18','00:00:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-17 23:22:35',59,'2016-02-17 23:22:35','0000-00-00 00:00:00'),(47,58,31,19,'2016-02-18','05:15:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-18 04:50:00',51,'2016-02-18 04:50:00','0000-00-00 00:00:00'),(48,58,31,19,'2016-02-18','05:15:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-18 04:50:00',51,'2016-02-18 04:50:00','0000-00-00 00:00:00'),(49,58,32,20,'2016-02-19','11:30:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-19 00:47:36',51,'2016-02-19 00:47:36','0000-00-00 00:00:00'),(50,58,32,20,'2016-02-19','12:18:08',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-19 00:48:13',51,'2016-02-19 00:48:13','0000-00-00 00:00:00'),(51,60,33,21,'2016-02-19','09:00:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-19 00:52:08',59,'2016-02-19 00:52:08','0000-00-00 00:00:00'),(52,60,33,21,'2016-02-19','12:29:58',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-19 01:00:08',59,'2016-02-19 01:00:08','0000-00-00 00:00:00'),(53,60,33,21,'2016-02-19','13:10:56',60,'C','1','0.00',NULL,NULL,NULL,59,'2016-02-19 01:40:56',59,'2016-02-19 01:40:56','0000-00-00 00:00:00'),(54,60,33,22,'2016-02-19','09:30:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-19 01:41:20',59,'2016-02-19 01:41:20','0000-00-00 00:00:00'),(55,60,33,22,'2016-02-19','13:37:56',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-19 02:08:03',59,'2016-02-19 02:08:03','0000-00-00 00:00:00'),(56,60,33,22,'2016-02-19','13:38:15',60,'C','1','0.00',NULL,NULL,NULL,59,'2016-02-19 02:08:16',59,'2016-02-19 02:08:16','0000-00-00 00:00:00'),(57,60,33,23,'2016-02-19','09:00:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-19 02:08:47',59,'2016-02-19 02:08:47','0000-00-00 00:00:00'),(58,60,33,23,'2016-02-19','13:39:11',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-19 02:09:18',59,'2016-02-19 02:09:18','0000-00-00 00:00:00'),(59,58,34,24,'2016-02-19','05:00:00',54,'B','1','0.00',NULL,NULL,NULL,62,'2016-02-19 07:19:03',62,'2016-02-19 07:19:03','0000-00-00 00:00:00'),(60,58,34,24,'2016-02-19','18:49:09',54,'A','1','0.00',NULL,NULL,NULL,62,'2016-02-19 07:19:15',62,'2016-02-19 07:19:15','0000-00-00 00:00:00'),(61,58,34,24,'2016-02-19','18:49:22',54,'S','1','100.00',NULL,4,NULL,62,'2016-02-19 07:19:35',62,'2016-02-19 07:19:35','0000-00-00 00:00:00'),(62,58,34,25,'2016-02-19','05:05:00',54,'B','1','0.00',NULL,NULL,NULL,62,'2016-02-19 07:21:43',62,'2016-02-19 07:21:43','0000-00-00 00:00:00'),(63,58,34,25,'2016-02-19','18:53:36',54,'C','1','0.00',NULL,NULL,NULL,62,'2016-02-19 07:23:36',62,'2016-02-19 07:23:36','0000-00-00 00:00:00'),(64,58,34,26,'2016-02-19','05:25:00',54,'B','1','0.00',NULL,NULL,NULL,62,'2016-02-19 07:25:56',62,'2016-02-19 07:25:56','0000-00-00 00:00:00'),(65,58,34,26,'2016-02-19','18:57:00',54,'A','1','0.00',NULL,NULL,NULL,62,'2016-02-19 07:27:06',62,'2016-02-19 07:27:06','0000-00-00 00:00:00'),(66,60,30,10,'2016-02-20','00:00:00',60,'S','1','100.00',NULL,8,NULL,59,'2016-02-19 23:23:58',59,'2016-02-19 23:23:58','0000-00-00 00:00:00'),(67,60,30,27,'2016-02-20','02:50:00',61,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-19 23:25:13',59,'2016-02-19 23:25:13','0000-00-00 00:00:00'),(68,60,30,27,'2016-02-20','10:55:25',61,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-19 23:25:30',59,'2016-02-19 23:25:30','0000-00-00 00:00:00'),(69,60,30,27,'2016-02-20','10:59:51',61,'S','1','121.00',NULL,8,NULL,59,'2016-02-19 23:30:02',59,'2016-02-19 23:30:02','0000-00-00 00:00:00'),(70,60,30,28,'2016-02-20','09:55:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-19 23:30:52',59,'2016-02-19 23:30:52','0000-00-00 00:00:00'),(71,60,30,28,'2016-02-20','09:55:00',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-19 23:30:52',59,'2016-02-19 23:30:52','0000-00-00 00:00:00'),(72,58,34,26,'2016-02-20','12:52:44',54,'S','1','100.00',NULL,4,NULL,62,'2016-02-20 01:22:50',62,'2016-02-20 01:22:50','0000-00-00 00:00:00'),(73,58,34,29,'2016-02-20','05:00:00',54,'B','1','0.00',NULL,NULL,NULL,62,'2016-02-20 01:23:02',62,'2016-02-20 01:23:02','0000-00-00 00:00:00'),(74,58,34,29,'2016-02-20','12:53:24',54,'A','1','0.00',NULL,NULL,NULL,62,'2016-02-20 01:23:26',62,'2016-02-20 01:23:26','0000-00-00 00:00:00'),(75,60,35,30,'2016-02-20','16:00:00',65,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-20 03:32:49',59,'2016-02-20 03:32:49','0000-00-00 00:00:00'),(76,60,35,30,'2016-02-20','15:03:02',65,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-20 03:33:07',59,'2016-02-20 03:33:07','0000-00-00 00:00:00'),(77,60,35,30,'2016-02-20','15:04:23',65,'S','1','102.00',NULL,11,NULL,59,'2016-02-20 03:34:28',59,'2016-02-20 03:34:28','0000-00-00 00:00:00'),(78,58,34,29,'2016-02-20','15:11:34',54,'S','1','100.00',NULL,6,NULL,62,'2016-02-20 03:41:39',62,'2016-02-20 03:41:39','0000-00-00 00:00:00'),(79,58,34,31,'2016-02-20','11:00:00',56,'B','1','0.00',NULL,NULL,NULL,62,'2016-02-20 03:52:56',62,'2016-02-20 03:52:56','0000-00-00 00:00:00'),(80,58,34,31,'2016-02-20','15:23:03',56,'A','1','0.00',NULL,NULL,NULL,62,'2016-02-20 03:53:12',62,'2016-02-20 03:53:12','0000-00-00 00:00:00'),(84,58,34,31,'2016-02-20','15:38:28',56,'S','1','300.00',NULL,6,'N',62,'2016-02-20 04:08:40',62,'2016-02-20 04:08:40','0000-00-00 00:00:00'),(85,58,34,32,'2016-02-20','06:00:00',54,'B','1','0.00',NULL,NULL,NULL,62,'2016-02-20 04:44:16',62,'2016-02-20 04:44:16','0000-00-00 00:00:00'),(86,58,34,32,'2016-02-20','06:00:00',54,'A','1','0.00',NULL,NULL,NULL,62,'2016-02-20 04:44:16',62,'2016-02-20 04:44:16','0000-00-00 00:00:00'),(87,58,34,32,'2016-02-20','16:17:13',54,'S','1','100.00',NULL,4,'N',62,'2016-02-20 04:49:34',62,'2016-02-20 04:49:34','0000-00-00 00:00:00'),(88,60,33,23,'2016-02-20','16:21:29',60,'S','1','104.00',NULL,11,'N',59,'2016-02-20 04:51:34',59,'2016-02-20 04:51:34','0000-00-00 00:00:00'),(89,60,30,28,'2016-02-20','16:47:26',60,'S','1','101.00',NULL,8,'N',66,'2016-02-20 05:17:32',66,'2016-02-20 05:17:32','0000-00-00 00:00:00'),(90,60,29,6,'2016-02-20','17:41:00',60,'S','1','102.00',NULL,9,'N',59,'2016-02-20 06:11:08',59,'2016-02-20 06:11:08','0000-00-00 00:00:00'),(91,60,29,33,'2016-02-20','01:35:00',61,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-20 06:11:30',59,'2016-02-20 06:11:30','0000-00-00 00:00:00'),(92,60,29,33,'2016-02-20','01:35:00',61,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-20 06:11:30',59,'2016-02-20 06:11:30','0000-00-00 00:00:00'),(93,60,33,34,'2016-02-20','17:00:00',65,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-20 06:14:45',59,'2016-02-20 06:14:45','0000-00-00 00:00:00'),(94,60,33,34,'2016-02-20','17:45:43',65,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-20 06:15:47',59,'2016-02-20 06:15:47','0000-00-00 00:00:00'),(95,60,33,34,'2016-02-20','17:45:56',65,'S','1','102.00',NULL,11,'N',59,'2016-02-20 06:16:28',59,'2016-02-20 06:16:28','0000-00-00 00:00:00'),(96,60,33,35,'2016-02-20','09:00:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-20 06:30:15',59,'2016-02-20 06:30:15','0000-00-00 00:00:00'),(97,60,33,35,'2016-02-20','18:00:28',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-20 06:30:31',59,'2016-02-20 06:30:31','0000-00-00 00:00:00'),(98,60,33,35,'2016-02-20','18:00:39',60,'S','1','103.00',NULL,0,'N',59,'2016-02-20 06:31:16',59,'2016-02-20 06:31:16','0000-00-00 00:00:00'),(99,60,33,42,'2016-02-22','10:00:00',60,'B','1','0.00',NULL,NULL,NULL,59,'2016-02-21 22:48:54',59,'2016-02-21 22:48:54','0000-00-00 00:00:00'),(100,60,33,42,'2016-02-22','10:19:37',60,'A','1','0.00',NULL,NULL,NULL,59,'2016-02-21 22:49:41',59,'2016-02-21 22:49:41','0000-00-00 00:00:00'),(101,60,33,42,'2016-02-22','10:19:48',60,'S','1','104.00',NULL,11,'F',59,'2016-02-21 22:49:58',59,'2016-02-21 22:49:58','0000-00-00 00:00:00'),(102,61,36,44,'2016-02-27','11:50:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:35:47',67,'2016-02-21 23:35:47','0000-00-00 00:00:00'),(103,61,36,45,'2016-02-22','10:40:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:38:22',67,'2016-02-21 23:38:22','0000-00-00 00:00:00'),(104,61,36,44,'2016-02-22','11:17:57',68,'C','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:47:58',67,'2016-02-21 23:47:58','0000-00-00 00:00:00'),(105,61,36,44,'2016-02-22','11:17:58',68,'C','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:47:59',67,'2016-02-21 23:47:59','0000-00-00 00:00:00'),(106,61,36,44,'2016-02-22','11:17:58',68,'C','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:48:00',67,'2016-02-21 23:48:00','0000-00-00 00:00:00'),(107,61,36,45,'2016-02-22','11:19:11',68,'C','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:49:13',67,'2016-02-21 23:49:13','0000-00-00 00:00:00'),(108,61,36,46,'2016-02-23','12:00:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:50:08',67,'2016-02-21 23:50:08','0000-00-00 00:00:00'),(109,61,36,46,'2016-02-22','11:20:43',68,'A','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:50:46',67,'2016-02-21 23:50:46','0000-00-00 00:00:00'),(110,61,36,46,'2016-02-22','11:21:00',68,'C','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:51:02',67,'2016-02-21 23:51:02','0000-00-00 00:00:00'),(111,61,36,47,'2016-03-05','10:30:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:51:51',67,'2016-02-21 23:51:51','0000-00-00 00:00:00'),(112,61,36,48,'2016-02-26','10:40:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:52:41',67,'2016-02-21 23:52:41','0000-00-00 00:00:00'),(113,61,30,49,'2016-02-22','12:00:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:57:20',67,'2016-02-21 23:57:20','0000-00-00 00:00:00'),(114,61,30,49,'2016-02-22','11:29:33',68,'A','1','0.00',NULL,NULL,NULL,67,'2016-02-21 23:59:35',67,'2016-02-21 23:59:35','0000-00-00 00:00:00'),(115,61,36,47,'2016-02-22','11:30:33',68,'A','1','0.00',NULL,NULL,NULL,67,'2016-02-22 00:00:35',67,'2016-02-22 00:00:35','0000-00-00 00:00:00'),(116,61,36,47,'2016-02-22','12:01:25',68,'S','1','500.00',NULL,0,'N',67,'2016-02-22 00:31:30',67,'2016-02-22 00:31:30','0000-00-00 00:00:00'),(117,61,36,48,'2016-02-22','12:01:39',68,'A','1','0.00',NULL,NULL,NULL,67,'2016-02-22 00:31:41',67,'2016-02-22 00:31:41','0000-00-00 00:00:00'),(118,61,36,48,'2016-02-22','12:01:49',68,'S','1','500.00',NULL,0,'N',67,'2016-02-22 00:31:53',67,'2016-02-22 00:31:53','0000-00-00 00:00:00'),(119,58,37,50,'2016-02-22','11:00:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-22 02:32:54',51,'2016-02-22 02:32:54','0000-00-00 00:00:00'),(120,58,37,50,'2016-02-22','11:00:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-22 02:32:54',51,'2016-02-22 02:32:54','0000-00-00 00:00:00'),(121,58,37,50,'2016-02-22','14:03:35',56,'S','1','1030.00',NULL,4,'N',51,'2016-02-22 02:34:21',51,'2016-02-22 02:34:21','0000-00-00 00:00:00'),(122,58,37,52,'2016-02-22','11:45:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-22 02:44:53',51,'2016-02-22 02:44:53','0000-00-00 00:00:00'),(123,58,37,52,'2016-02-22','14:15:00',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-22 02:45:29',51,'2016-02-22 02:45:29','0000-00-00 00:00:00'),(124,58,37,52,'2016-02-22','14:17:01',56,'C','1','0.00',NULL,NULL,NULL,51,'2016-02-22 02:47:03',51,'2016-02-22 02:47:03','0000-00-00 00:00:00'),(125,58,37,53,'2016-02-22','06:10:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-02-22 02:49:10',51,'2016-02-22 02:49:10','0000-00-00 00:00:00'),(126,58,37,53,'2016-02-22','14:19:17',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-02-22 02:49:21',51,'2016-02-22 02:49:21','0000-00-00 00:00:00'),(127,58,37,53,'2016-02-22','14:32:16',54,'C','1','0.00',NULL,NULL,NULL,51,'2016-02-22 03:02:18',51,'2016-02-22 03:02:18','0000-00-00 00:00:00'),(128,61,30,49,'2016-02-25','13:09:25',68,'S','1','200.00',NULL,14,'F',67,'2016-02-25 01:39:43',67,'2016-02-25 01:39:43','0000-00-00 00:00:00'),(129,61,30,56,'2016-02-25','10:30:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-25 01:42:49',67,'2016-02-25 01:42:49','0000-00-00 00:00:00'),(130,61,30,57,'2016-02-25','10:30:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-25 01:43:14',67,'2016-02-25 01:43:14','0000-00-00 00:00:00'),(131,61,30,56,'2016-02-25','16:25:29',68,'A','1','0.00',NULL,NULL,NULL,67,'2016-02-25 04:55:43',67,'2016-02-25 04:55:43','0000-00-00 00:00:00'),(132,61,30,56,'2016-02-25','16:26:18',68,'C','1','0.00',NULL,NULL,NULL,67,'2016-02-25 04:56:22',67,'2016-02-25 04:56:22','0000-00-00 00:00:00'),(133,61,30,56,'2016-02-25','16:26:20',68,'C','1','0.00',NULL,NULL,NULL,67,'2016-02-25 04:56:24',67,'2016-02-25 04:56:24','0000-00-00 00:00:00'),(134,61,30,57,'2016-02-25','16:26:32',68,'A','1','0.00',NULL,NULL,NULL,67,'2016-02-25 04:56:37',67,'2016-02-25 04:56:37','0000-00-00 00:00:00'),(135,61,30,57,'2016-02-25','16:26:47',68,'S','1','200.00',NULL,4,'N',67,'2016-02-25 04:56:55',67,'2016-02-25 04:56:55','0000-00-00 00:00:00'),(136,61,30,58,'2016-02-25','10:40:00',68,'B','1','0.00',NULL,NULL,NULL,67,'2016-02-25 05:09:56',67,'2016-02-25 05:09:56','0000-00-00 00:00:00'),(137,61,30,58,'2016-02-25','16:42:00',68,'A','1','0.00',NULL,NULL,NULL,67,'2016-02-25 05:13:01',67,'2016-02-25 05:13:01','0000-00-00 00:00:00'),(138,58,38,61,'2016-02-25','05:00:00',54,'B','1','0.00',NULL,NULL,NULL,63,'2016-02-25 07:13:43',63,'2016-02-25 07:13:43','0000-00-00 00:00:00'),(139,58,38,61,'2016-02-25','18:43:51',54,'A','1','0.00',NULL,NULL,NULL,63,'2016-02-25 07:13:54',63,'2016-02-25 07:13:54','0000-00-00 00:00:00'),(140,58,26,14,'2016-02-29','17:48:36',56,'C','1','0.00',NULL,NULL,NULL,51,'2016-02-29 06:18:36',51,'2016-02-29 06:18:36','0000-00-00 00:00:00'),(141,58,26,62,'2016-03-02','06:10:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-02 13:13:34',51,'2016-03-02 13:13:34','0000-00-00 00:00:00'),(142,58,26,62,'2016-03-02','10:00:00',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-02 13:45:14',51,'2016-03-02 13:45:14','0000-00-00 00:00:00'),(143,58,39,64,'2016-03-02','11:50:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-02 16:05:00',51,'2016-03-02 16:05:00','0000-00-00 00:00:00'),(157,58,39,64,'2016-03-02','16:24:57',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-02 16:24:59',51,'2016-03-02 16:24:59','0000-00-00 00:00:00'),(158,58,39,64,'2016-03-02','16:25:04',56,'S','1','100.00',NULL,4,'N',51,'2016-03-02 16:25:09',51,'2016-03-02 16:25:09','0000-00-00 00:00:00'),(159,58,39,65,'2016-03-02','06:20:00',54,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-02 16:25:30',51,'2016-03-02 16:25:30','0000-00-00 00:00:00'),(164,58,39,65,'2016-03-02','09:30:39',54,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-02 16:30:42',51,'2016-03-02 16:30:42','0000-00-00 00:00:00'),(166,58,39,65,'2016-03-02','16:59:09',54,'S','1','100.00',NULL,4,'N',51,'2016-03-02 16:59:12',51,'2016-03-02 16:59:12','0000-00-00 00:00:00'),(167,58,39,67,'2016-03-02','11:10:00',56,'B','1','0.00',NULL,NULL,NULL,51,'2016-03-02 17:30:56',51,'2016-03-02 17:30:56','0000-00-00 00:00:00'),(168,58,39,67,'2016-03-02','17:57:27',56,'A','1','0.00',NULL,NULL,NULL,51,'2016-03-02 17:57:29',51,'2016-03-02 17:57:29','0000-00-00 00:00:00'),(169,58,39,67,'2016-03-02','17:57:34',56,'S','1','100.00',NULL,4,'N',51,'2016-03-02 17:57:37',51,'2016-03-02 17:57:37','0000-00-00 00:00:00'),(170,58,26,62,'2016-03-02','18:33:07',54,'S','1','100.00',NULL,4,'F',51,'2016-03-02 18:33:12',51,'2016-03-02 18:33:12','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `pat_consultant` */

insert  into `pat_consultant`(`pat_consult_id`,`tenant_id`,`encounter_id`,`patient_id`,`consultant_id`,`consult_date`,`notes`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,7,5,28,'2016-02-04 18:16:35','test','1',1,'2016-02-04 15:56:15',1,'2016-02-04 16:35:09','2016-02-04 18:16:35'),(2,18,12,5,27,'2016-02-03 02:10:00','test test','1',1,'2016-02-06 15:31:11',1,'2016-02-06 15:31:11','0000-00-00 00:00:00'),(3,58,5,20,54,'2016-02-10 01:05:00','aaa ddddd','1',51,'2016-02-17 05:30:16',51,'2016-02-17 05:30:16','0000-00-00 00:00:00'),(4,58,5,20,54,'2016-02-11 01:05:00','aa ddd','1',51,'2016-02-17 05:30:35',51,'2016-02-17 05:30:45','0000-00-00 00:00:00'),(5,58,5,20,54,'2016-02-03 06:10:00','aaadddd','1',51,'2016-02-17 06:58:21',51,'2016-02-17 06:58:21','0000-00-00 00:00:00'),(6,58,8,20,56,'2016-02-07 09:50:00','test','1',51,'2016-02-17 07:12:31',51,'2016-02-17 07:12:31','0000-00-00 00:00:00'),(7,60,6,29,60,'2016-02-18 14:00:00','intravenous','1',59,'2016-02-18 00:35:43',59,'2016-02-18 00:35:43','0000-00-00 00:00:00'),(8,60,6,29,61,'2016-02-18 06:30:00','give coldmine syrup','1',59,'2016-02-18 00:59:55',59,'2016-02-18 01:00:51','0000-00-00 00:00:00'),(9,60,6,29,61,'2016-02-18 07:35:00','follow up syrup','1',59,'2016-02-18 01:00:23',59,'2016-02-18 01:00:23','0000-00-00 00:00:00'),(10,58,54,37,54,'2016-02-22 13:25:00','rf4rf4rf4f','1',51,'2016-02-22 03:15:04',51,'2016-02-22 03:15:04','0000-00-00 00:00:00'),(11,58,54,37,54,'2016-03-03 10:30:00','gt56yyf','1',51,'2016-02-22 03:16:35',51,'2016-02-22 03:16:35','0000-00-00 00:00:00'),(12,58,54,37,56,'2016-02-25 14:30:00','hbtgvrfcdx','1',51,'2016-02-22 03:16:59',51,'2016-02-22 03:16:59','0000-00-00 00:00:00'),(13,61,56,30,68,'2016-02-25 10:10:00','test','1',67,'2016-02-25 02:04:08',67,'2016-02-25 02:04:08','0000-00-00 00:00:00'),(14,61,56,30,68,'2016-03-10 11:35:00','asdfdf vad a adf asdfsda asdfsad a asfdasdfa','1',67,'2016-02-25 02:05:22',67,'2016-02-25 02:06:52','0000-00-00 00:00:00');

/*Table structure for table `pat_encounter` */

DROP TABLE IF EXISTS `pat_encounter`;

CREATE TABLE `pat_encounter` (
  `encounter_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `encounter_type` varchar(5) NOT NULL,
  `encounter_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `inactive_date` timestamp NULL DEFAULT NULL,
  `finalize` tinyint(1) NOT NULL DEFAULT '0',
  `authorize` tinyint(1) NOT NULL DEFAULT '0',
  `casesheet_no` varchar(50) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=latin1;

/*Data for the table `pat_encounter` */

insert  into `pat_encounter`(`encounter_id`,`tenant_id`,`patient_id`,`encounter_type`,`encounter_date`,`inactive_date`,`finalize`,`authorize`,`casesheet_no`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,18,'OP','2016-02-16 00:00:00',NULL,0,0,'0','1',51,'2016-02-16 06:31:03',51,'2016-02-16 06:31:03','0000-00-00 00:00:00'),(2,58,24,'OP','2016-02-17 00:00:00',NULL,0,0,'0','0',51,'2016-02-17 00:18:11',51,'2016-02-17 07:51:17','0000-00-00 00:00:00'),(3,58,28,'OP','2016-02-17 00:00:00',NULL,0,0,'0','1',51,'2016-02-17 01:15:34',51,'2016-02-17 01:15:34','0000-00-00 00:00:00'),(4,58,28,'OP','2016-02-17 00:00:00',NULL,0,0,'0','1',51,'2016-02-17 01:27:48',51,'2016-02-17 01:27:48','0000-00-00 00:00:00'),(5,58,20,'OP','2016-02-17 00:00:00',NULL,0,0,'0','0',51,'2016-02-17 02:54:27',51,'2016-02-17 06:59:09','0000-00-00 00:00:00'),(6,60,29,'OP','2016-02-17 00:00:00',NULL,0,0,'0','0',59,'2016-02-17 06:34:19',59,'2016-02-20 06:11:08','0000-00-00 00:00:00'),(7,58,30,'OP','2016-02-17 00:00:00',NULL,0,0,'0','0',51,'2016-02-17 06:42:33',51,'2016-02-17 06:49:37','0000-00-00 00:00:00'),(8,58,20,'OP','2016-02-17 00:00:00',NULL,0,0,'0','1',51,'2016-02-17 07:07:13',51,'2016-02-17 07:07:13','0000-00-00 00:00:00'),(9,60,25,'OP','2016-02-17 00:00:00',NULL,0,0,'0','1',59,'2016-02-17 07:29:20',59,'2016-02-17 07:29:20','0000-00-00 00:00:00'),(10,60,30,'OP','2016-02-18 00:00:00',NULL,0,0,'0','0',59,'2016-02-17 07:29:52',59,'2016-02-19 23:23:58','0000-00-00 00:00:00'),(11,60,19,'OP','2016-02-17 00:00:00',NULL,0,0,'0','1',59,'2016-02-17 07:34:52',59,'2016-02-17 07:34:52','0000-00-00 00:00:00'),(12,58,24,'OP','2016-02-17 00:00:00',NULL,0,0,'0','0',51,'2016-02-17 07:57:52',51,'2016-02-17 07:58:09','0000-00-00 00:00:00'),(13,58,20,'OP','2016-02-18 00:00:00',NULL,0,0,'0','1',51,'2016-02-17 22:41:36',51,'2016-02-17 22:41:36','0000-00-00 00:00:00'),(14,58,26,'OP','2016-02-18 00:00:00',NULL,0,0,'0','0',51,'2016-02-17 22:42:12',51,'2016-02-29 06:18:36','0000-00-00 00:00:00'),(15,58,25,'OP','2016-02-18 00:00:00',NULL,0,0,'0','1',51,'2016-02-17 23:05:03',51,'2016-02-17 23:05:03','0000-00-00 00:00:00'),(16,60,21,'OP','2016-02-18 00:00:00',NULL,0,0,'0','0',59,'2016-02-17 23:07:13',59,'2016-02-17 23:21:15','0000-00-00 00:00:00'),(17,60,27,'OP','2016-02-18 00:00:00',NULL,0,0,'0','1',59,'2016-02-17 23:14:58',59,'2016-02-17 23:14:58','0000-00-00 00:00:00'),(18,60,21,'OP','2016-02-18 00:00:00',NULL,0,0,'0','1',59,'2016-02-17 23:21:46',59,'2016-02-17 23:21:46','0000-00-00 00:00:00'),(19,58,31,'OP','2016-02-18 00:00:00',NULL,0,0,'0','1',51,'2016-02-18 04:50:00',51,'2016-02-18 04:50:00','0000-00-00 00:00:00'),(20,58,32,'OP','2016-02-19 00:00:00',NULL,0,0,'0','1',51,'2016-02-19 00:47:36',51,'2016-02-19 00:47:36','0000-00-00 00:00:00'),(21,60,33,'OP','2016-02-19 00:00:00',NULL,0,0,'0','0',59,'2016-02-19 00:52:08',59,'2016-02-19 01:40:56','0000-00-00 00:00:00'),(22,60,33,'OP','2016-02-19 00:00:00',NULL,0,0,'0','0',59,'2016-02-19 01:41:20',59,'2016-02-19 02:08:16','0000-00-00 00:00:00'),(23,60,33,'OP','2016-02-19 00:00:00',NULL,0,0,'0','0',59,'2016-02-19 02:08:47',59,'2016-02-20 04:51:34','0000-00-00 00:00:00'),(24,58,34,'OP','2016-02-19 00:00:00',NULL,0,0,'0','0',62,'2016-02-19 07:19:03',62,'2016-02-19 07:19:35','0000-00-00 00:00:00'),(25,58,34,'OP','2016-02-19 00:00:00',NULL,0,0,'0','0',62,'2016-02-19 07:21:43',62,'2016-02-19 07:23:36','0000-00-00 00:00:00'),(26,58,34,'OP','2016-02-19 00:00:00',NULL,0,0,'0','0',62,'2016-02-19 07:25:56',62,'2016-02-20 01:22:50','0000-00-00 00:00:00'),(27,60,30,'OP','2016-02-20 00:00:00',NULL,0,0,'0','0',59,'2016-02-19 23:25:13',59,'2016-02-19 23:30:02','0000-00-00 00:00:00'),(28,60,30,'OP','2016-02-20 00:00:00',NULL,0,0,'0','0',59,'2016-02-19 23:30:52',66,'2016-02-20 05:17:32','0000-00-00 00:00:00'),(29,58,34,'OP','2016-02-20 00:00:00',NULL,0,0,'0','0',62,'2016-02-20 01:23:02',62,'2016-02-20 03:41:39','0000-00-00 00:00:00'),(30,60,35,'OP','2016-02-20 00:00:00',NULL,0,0,'0','0',59,'2016-02-20 03:32:49',59,'2016-02-20 03:34:28','0000-00-00 00:00:00'),(31,58,34,'OP','2016-02-20 00:00:00',NULL,0,0,'0','0',62,'2016-02-20 03:52:56',62,'2016-02-20 04:08:40','0000-00-00 00:00:00'),(32,58,34,'OP','2016-02-20 00:00:00',NULL,0,0,'0','0',62,'2016-02-20 04:44:16',62,'2016-02-20 04:49:34','0000-00-00 00:00:00'),(33,60,29,'OP','2016-02-20 00:00:00',NULL,0,0,'0','1',59,'2016-02-20 06:11:30',59,'2016-02-20 06:11:30','0000-00-00 00:00:00'),(34,60,33,'OP','2016-02-20 00:00:00',NULL,0,0,'0','0',59,'2016-02-20 06:14:45',59,'2016-02-20 06:16:29','0000-00-00 00:00:00'),(35,60,33,'OP','2016-02-20 00:00:00',NULL,0,0,'0','0',59,'2016-02-20 06:30:15',59,'2016-02-20 06:31:16','0000-00-00 00:00:00'),(36,60,33,'IP','2016-02-20 18:01:24',NULL,0,0,'0','0',59,'2016-02-20 06:31:36',59,'2016-02-20 06:35:01','0000-00-00 00:00:00'),(37,60,33,'IP','2016-02-20 18:14:26',NULL,0,0,'0','0',59,'2016-02-20 06:44:38',59,'2016-02-20 06:48:56','0000-00-00 00:00:00'),(38,60,33,'IP','2016-02-20 18:21:27',NULL,0,0,'0','0',59,'2016-02-20 06:51:37',59,'2016-02-20 08:20:10','0000-00-00 00:00:00'),(39,60,35,'IP','2016-02-20 18:35:42',NULL,0,0,'0','1',59,'2016-02-20 07:05:54',59,'2016-02-20 07:05:54','0000-00-00 00:00:00'),(40,60,34,'IP','2016-02-20 18:52:46',NULL,0,0,'0','0',66,'2016-02-20 07:23:01',66,'2016-02-20 07:23:34','0000-00-00 00:00:00'),(41,60,34,'IP','2016-02-20 19:20:28',NULL,0,0,'0','0',66,'2016-02-20 07:50:48',66,'2016-02-20 07:51:08','0000-00-00 00:00:00'),(42,60,33,'OP','2016-02-22 00:00:00',NULL,0,0,'0','0',59,'2016-02-21 22:48:54',59,'2016-02-21 22:49:58','0000-00-00 00:00:00'),(43,60,33,'IP','2016-02-22 10:20:06',NULL,0,0,'0','1',59,'2016-02-21 22:50:16',59,'2016-02-21 22:50:16','0000-00-00 00:00:00'),(44,61,36,'OP','2016-02-27 00:00:00',NULL,0,0,'0','0',67,'2016-02-21 23:35:47',67,'2016-02-21 23:48:00','0000-00-00 00:00:00'),(45,61,36,'OP','2016-02-22 00:00:00',NULL,0,0,'0','0',67,'2016-02-21 23:38:22',67,'2016-02-21 23:49:13','0000-00-00 00:00:00'),(46,61,36,'OP','2016-02-23 00:00:00',NULL,0,0,'0','0',67,'2016-02-21 23:50:08',67,'2016-02-21 23:51:02','0000-00-00 00:00:00'),(47,61,36,'OP','2016-03-05 00:00:00',NULL,0,0,'0','0',67,'2016-02-21 23:51:51',67,'2016-02-22 00:31:30','0000-00-00 00:00:00'),(48,61,36,'OP','2016-02-26 00:00:00',NULL,0,0,'0','0',67,'2016-02-21 23:52:41',67,'2016-02-22 00:31:53','0000-00-00 00:00:00'),(49,61,30,'OP','2016-02-22 00:00:00',NULL,0,0,'0','0',67,'2016-02-21 23:57:20',67,'2016-02-25 01:39:43','0000-00-00 00:00:00'),(50,58,37,'OP','2016-02-22 00:00:00',NULL,0,0,'0','0',51,'2016-02-22 02:32:54',51,'2016-02-22 02:34:21','0000-00-00 00:00:00'),(51,58,37,'IP','2016-02-22 14:04:36',NULL,0,0,'0','0',51,'2016-02-22 02:35:00',51,'2016-02-22 02:44:41','0000-00-00 00:00:00'),(52,58,37,'OP','2016-02-22 00:00:00',NULL,0,0,'0','0',51,'2016-02-22 02:44:53',51,'2016-02-22 02:47:03','0000-00-00 00:00:00'),(53,58,37,'OP','2016-02-22 00:00:00',NULL,0,0,'0','0',51,'2016-02-22 02:49:10',51,'2016-02-22 03:02:18','0000-00-00 00:00:00'),(54,58,37,'IP','2016-02-22 14:32:20',NULL,0,0,'0','0',51,'2016-02-22 03:02:39',51,'2016-02-22 06:34:32','0000-00-00 00:00:00'),(55,61,36,'IP','2016-02-23 16:49:16',NULL,0,0,'0','1',67,'2016-02-23 05:19:43',67,'2016-02-23 05:19:43','0000-00-00 00:00:00'),(56,61,30,'OP','2016-02-25 00:00:00',NULL,0,0,'0','0',67,'2016-02-25 01:42:49',67,'2016-02-25 04:56:24','0000-00-00 00:00:00'),(57,61,30,'OP','2016-02-25 00:00:00',NULL,0,0,'0','0',67,'2016-02-25 01:43:14',67,'2016-02-25 04:56:55','0000-00-00 00:00:00'),(58,61,30,'OP','2016-02-25 00:00:00',NULL,0,0,'0','1',67,'2016-02-25 05:09:56',67,'2016-02-25 05:09:56','0000-00-00 00:00:00'),(59,61,24,'IP','2016-02-25 16:58:08',NULL,0,0,'0','0',67,'2016-02-25 05:28:29',67,'2016-02-25 05:30:03','0000-00-00 00:00:00'),(60,61,24,'IP','2016-02-25 17:07:55',NULL,0,0,'0','1',67,'2016-02-25 05:38:13',67,'2016-02-25 05:38:13','0000-00-00 00:00:00'),(61,58,38,'OP','2016-02-25 00:00:00',NULL,0,0,'0','1',63,'2016-02-25 07:13:43',63,'2016-02-25 07:13:43','0000-00-00 00:00:00'),(62,58,26,'OP','2016-03-02 00:00:00',NULL,0,0,'0','0',51,'2016-03-02 13:13:33',51,'2016-03-02 18:33:12','0000-00-00 00:00:00'),(63,58,39,'IP','2016-03-02 16:00:02',NULL,0,0,'0','0',51,'2016-03-02 16:00:11',51,'2016-03-02 16:04:49','0000-00-00 00:00:00'),(64,58,39,'OP','2016-03-02 00:00:00',NULL,0,0,'0','0',51,'2016-03-02 16:05:00',51,'2016-03-02 16:25:09','0000-00-00 00:00:00'),(65,58,39,'OP','2016-03-02 00:00:00',NULL,0,0,'0','0',51,'2016-03-02 16:25:30',51,'2016-03-02 16:59:12','0000-00-00 00:00:00'),(66,58,39,'IP','2016-03-02 16:59:19',NULL,0,0,'0','0',51,'2016-03-02 16:59:27',51,'2016-03-02 17:30:47','0000-00-00 00:00:00'),(67,58,39,'OP','2016-03-02 00:00:00',NULL,0,0,'0','0',51,'2016-03-02 17:30:56',51,'2016-03-02 17:57:37','0000-00-00 00:00:00'),(68,58,39,'IP','2016-03-02 17:57:52',NULL,0,0,'0','0',51,'2016-03-02 17:58:00',51,'2016-03-02 19:42:21','0000-00-00 00:00:00'),(69,58,26,'IP','2016-03-02 18:33:20',NULL,0,0,'0','1',51,'2016-03-02 18:33:33',51,'2016-03-02 18:33:33','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `pat_notes` */

insert  into `pat_notes`(`pat_note_id`,`tenant_id`,`encounter_id`,`patient_id`,`notes`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,5,20,'Testtt','1',51,'2016-02-17 05:26:01',51,'2016-02-17 05:26:01','0000-00-00 00:00:00'),(2,58,5,20,'aa dddd aaaa','1',51,'2016-02-17 06:58:36',51,'2016-02-17 06:58:36','0000-00-00 00:00:00'),(3,60,6,29,'need to check doppler for pulse','1',59,'2016-02-18 00:32:43',59,'2016-02-18 00:33:30','0000-00-00 00:00:00'),(4,58,54,37,'rfreferfr yhy6hy yhy6h rfreferfr yhy6hy yhy6h rfreferfr yhy6hy yhy6h rfreferfr yhy6hy yhy6hrfreferfr yhy6hy yhy6hrfreferfr yhy6hy yhy6hrfreferfr yhy6hy yhy6hrfreferfr yhy6hy yhy6h','1',51,'2016-02-22 03:10:05',51,'2016-02-22 03:20:39','0000-00-00 00:00:00'),(5,61,56,30,'test assdffhs sdafhdsafghggh asdkfnjkasdhhfi kasdfjkashdf  jashkksdfk k saasjkhfasdhhjsad h asjdfkasfuihsa kssffhaskdhfjshf sdfkasjdhfjkash hkjahdfkjhsdkf assjkhh kasdhfkhsdafhsdjff  jshhiasdjhfaskj asdmbfnasdb ashfa dhs asddjsadf  s asdjfasdj \nasdfj;asdfj;lasjf\nsadf jsadlfkasdljf\nasdffjasdj klasd\nsadkfjlkasdjflkasj lka jlkjsjdkjfasdjflasdj jasd\ndsfakjasdlkkj askdjjllasd\nasdkf lkasdjfs askfh asdjfaks jkasdjasd\nasdkfjaskdl jassd\nasdfkjkasdk \nasjdasfkjdaslfjads\nasdjf \nasdf','1',67,'2016-02-25 01:57:32',67,'2016-02-25 01:58:28','0000-00-00 00:00:00');

/*Table structure for table `pat_patient` */

DROP TABLE IF EXISTS `pat_patient`;

CREATE TABLE `pat_patient` (
  `patient_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_guid` varchar(50) NOT NULL,
  `casesheetno` int(11) DEFAULT NULL,
  `patient_int_code` varchar(30) NOT NULL,
  `tenant_id` int(11) NOT NULL,
  `patient_reg_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `patient_title_code` varchar(10) NOT NULL,
  `patient_firstname` varchar(50) NOT NULL,
  `patient_lastname` varchar(50) DEFAULT NULL,
  `patient_relation_code` varchar(2) DEFAULT NULL,
  `patient_relation_name` varchar(50) DEFAULT NULL,
  `patient_care_taker` int(11) DEFAULT NULL,
  `patient_care_taker_name` varchar(50) DEFAULT NULL,
  `patient_dob` date DEFAULT NULL,
  `patient_gender` varchar(2) NOT NULL,
  `patient_marital_status` varchar(2) DEFAULT NULL,
  `patient_occupation` varchar(50) DEFAULT NULL,
  `patient_blood_group` varchar(5) DEFAULT NULL,
  `patient_category_id` int(11) DEFAULT NULL,
  `patient_email` varchar(50) DEFAULT NULL,
  `patient_reg_mode` varchar(2) NOT NULL,
  `patient_type` varchar(2) DEFAULT NULL,
  `patient_ref_hospital` varchar(255) DEFAULT NULL,
  `patient_ref_id` varchar(50) DEFAULT NULL,
  `patient_mobile` varchar(50) DEFAULT NULL,
  `patient_bill_type` varchar(2) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`patient_id`),
  UNIQUE KEY `PatientCasesheetUnique` (`casesheetno`,`tenant_id`),
  KEY `FK_pat_patient_tenant` (`tenant_id`),
  CONSTRAINT `FK_pat_patient_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

/*Data for the table `pat_patient` */

insert  into `pat_patient`(`patient_id`,`patient_guid`,`casesheetno`,`patient_int_code`,`tenant_id`,`patient_reg_date`,`patient_title_code`,`patient_firstname`,`patient_lastname`,`patient_relation_code`,`patient_relation_name`,`patient_care_taker`,`patient_care_taker_name`,`patient_dob`,`patient_gender`,`patient_marital_status`,`patient_occupation`,`patient_blood_group`,`patient_category_id`,`patient_email`,`patient_reg_mode`,`patient_type`,`patient_ref_hospital`,`patient_ref_id`,`patient_mobile`,`patient_bill_type`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (18,'a7a0e519-73e7-5494-a4db-e53b12fa291d',NULL,'AH0000018',58,'2016-02-16 06:30:51','Mr.','George','Mike',NULL,NULL,NULL,NULL,'1977-08-09','M',NULL,NULL,NULL,4,NULL,'OP',NULL,NULL,NULL,'9856145115','N','1',51,'2016-02-16 06:30:51',51,'2016-02-16 06:30:51','0000-00-00 00:00:00'),(19,'7fc6a659-f2b4-5ca3-bdfc-73ec118ac5d1',NULL,'AH0000019',58,'2016-02-16 22:07:14','Miss.','Gayatri','S',NULL,NULL,NULL,NULL,'2001-01-01','F','M',NULL,NULL,6,NULL,'OP',NULL,NULL,NULL,'9898989898','N','1',51,'2016-02-16 22:07:14',51,'2016-02-17 02:41:37','0000-00-00 00:00:00'),(20,'67d1e40d-dd8b-595f-8e72-8d2d5d642cce',NULL,'AH0000020',58,'2016-02-16 22:10:56','Mr.','Rahul','S',NULL,NULL,NULL,NULL,'1993-06-03','M',NULL,NULL,NULL,4,NULL,'IP',NULL,NULL,NULL,'676767676','N','1',51,'2016-02-16 22:10:56',51,'2016-02-16 22:10:56','0000-00-00 00:00:00'),(21,'733b973b-dbde-588b-beab-bbb7eb827fe5',NULL,'AH0000021',58,'2016-02-16 22:15:06','Mr.','Brendan','Fraiser',NULL,NULL,NULL,NULL,'1981-08-25','M',NULL,NULL,NULL,5,NULL,'NO',NULL,NULL,NULL,'823423451243','N','1',51,'2016-02-16 22:15:06',51,'2016-02-16 22:15:06','0000-00-00 00:00:00'),(22,'47197d1b-6f58-53a7-a33d-982b4e28c3c9',NULL,'AH0000022',58,'2016-02-17 00:14:58','Mr.','sdf','asdf',NULL,NULL,NULL,NULL,'2016-02-01','M',NULL,NULL,NULL,4,NULL,'OP',NULL,NULL,NULL,'234234234','N','1',51,'2016-02-17 00:14:58',51,'2016-02-17 00:14:58','0000-00-00 00:00:00'),(23,'561369b0-198f-552b-a7fb-fbb253abd8b3',NULL,'AH0000023',58,'2016-02-17 00:15:03','Mr.','sdf','asdf',NULL,NULL,NULL,NULL,'2016-02-01','M',NULL,NULL,NULL,4,NULL,'OP',NULL,NULL,NULL,'234234234','N','1',51,'2016-02-17 00:15:03',51,'2016-02-17 00:15:03','0000-00-00 00:00:00'),(24,'648af167-5aaa-5b7a-b86b-43681c64bc2f',NULL,'AH0000024',58,'2016-02-17 00:17:40','Mr.','Test','test',NULL,NULL,NULL,NULL,'2016-02-17','M',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'23213123123',NULL,'1',51,'2016-02-17 00:17:40',51,'2016-02-17 00:17:40','0000-00-00 00:00:00'),(25,'75e7dc21-f072-535d-8b92-c2f0cf925e09',NULL,'AH0000025',58,'2016-02-17 00:20:10','Miss.','Radha','Ram',NULL,NULL,NULL,NULL,'2016-02-17','F',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'342324234',NULL,'1',51,'2016-02-17 00:20:10',51,'2016-02-17 00:20:10','0000-00-00 00:00:00'),(26,'10d8bbb6-ceb9-5fa1-8081-4c267a88d3e1',NULL,'AH0000026',58,'2016-02-17 00:21:54','Mr.','rajesh','s',NULL,NULL,NULL,NULL,'2016-02-17','F',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'2342342',NULL,'1',51,'2016-02-17 00:21:54',51,'2016-02-17 00:21:54','0000-00-00 00:00:00'),(27,'ac0bb59b-7035-5e0a-a2c0-94b0526f0b0a',NULL,'AH0000027',58,'2016-02-17 00:24:22','Mr.','meena','k',NULL,NULL,NULL,NULL,'2016-02-17','F',NULL,NULL,NULL,6,NULL,'OP',NULL,NULL,NULL,'234234234',NULL,'1',51,'2016-02-17 00:24:22',51,'2016-02-17 00:24:22','0000-00-00 00:00:00'),(28,'55afd83b-e251-5849-a3dc-eff6022b8d4b',NULL,'AH0000028',58,'2016-02-17 01:13:02','Mr.','Anshul','Sharma',NULL,NULL,NULL,NULL,'2016-02-17','M',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'21341234',NULL,'1',51,'2016-02-17 01:13:02',51,'2016-02-17 01:13:02','0000-00-00 00:00:00'),(29,'28dccf7d-dcc4-5d12-aa56-66854cab3dd3',NULL,'RA0000001',60,'2016-02-17 06:30:17','Miss.','Tanvi','S',NULL,NULL,NULL,NULL,'1985-01-01','F','M',NULL,NULL,9,NULL,'OP',NULL,NULL,NULL,'9898989898','N','1',59,'2016-02-17 06:30:17',59,'2016-02-20 06:10:28','0000-00-00 00:00:00'),(30,'a119e459-436d-54be-8c2b-aeb1394c2478',NULL,'AH0000029',61,'2016-02-17 06:42:16','Mr.','Rajendran','Subramanian',NULL,NULL,NULL,NULL,'1986-02-17','M',NULL,NULL,NULL,4,NULL,'OP',NULL,NULL,NULL,'9894837443','N','1',51,'2016-02-17 06:42:16',67,'2016-02-25 05:12:49','0000-00-00 00:00:00'),(31,'ef1d7840-2282-5792-b4f4-17f044405315',NULL,'RA0000002',60,'2016-02-18 03:33:58','Mr.','zakir','h',NULL,NULL,NULL,NULL,'2016-02-18','M',NULL,NULL,NULL,8,NULL,'OP',NULL,NULL,NULL,'1231231231','F','1',59,'2016-02-18 03:33:58',59,'2016-02-18 03:33:58','0000-00-00 00:00:00'),(32,'04022771-5394-5872-95f8-5dd1eb7c6008',NULL,'AH0000030',58,'2016-02-19 00:46:42','Miss.','Yami','Gautam',NULL,NULL,NULL,NULL,'2016-02-19','F',NULL,NULL,NULL,5,NULL,'IP',NULL,NULL,NULL,'5647364756','F','1',51,'2016-02-19 00:46:42',51,'2016-02-19 00:46:42','0000-00-00 00:00:00'),(33,'df0b579b-ad18-58c8-b9cf-49765a1f22a8',NULL,'RA0000003',60,'2016-02-19 00:51:10','Mrs.','Anamika',NULL,NULL,NULL,NULL,NULL,'2016-02-19','F',NULL,NULL,NULL,11,NULL,'OP',NULL,NULL,NULL,'3434343434','N','1',59,'2016-02-19 00:51:10',59,'2016-02-19 00:51:10','0000-00-00 00:00:00'),(34,'821f513c-c6be-518f-af3d-f8450327bcae',NULL,'AH0000031',58,'2016-02-19 07:18:51','Mr.','Prakash','Arul Mani',NULL,NULL,NULL,NULL,'1990-01-31','M',NULL,NULL,NULL,6,NULL,'OP',NULL,NULL,NULL,'9865565668','N','1',62,'2016-02-19 07:18:51',62,'2016-02-19 07:28:51','0000-00-00 00:00:00'),(35,'e073430e-d892-56b5-a23b-274f4b004f49',NULL,'RA0000004',60,'2016-02-20 03:31:26','Mr.','Dinesh','G',NULL,NULL,NULL,NULL,'2016-02-20','M',NULL,NULL,NULL,11,NULL,'OP',NULL,NULL,NULL,'4515245245','N','1',59,'2016-02-20 03:31:26',59,'2016-02-20 03:31:26','0000-00-00 00:00:00'),(36,'5db1d5bb-fcca-5eba-bc7a-ff584882146d',NULL,'TE0000001',61,'2016-02-21 23:20:05','Mr.','manoj','vinoth',NULL,NULL,NULL,NULL,'1981-04-13','M',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'9879606806','N','1',67,'2016-02-21 23:20:05',67,'2016-02-21 23:46:02','0000-00-00 00:00:00'),(37,'b29bfeb7-a538-5952-9f20-48c7bea9dd91',NULL,'AH0000032',58,'2016-02-22 02:32:19','Mr.','raje','sub',NULL,NULL,NULL,NULL,'1996-02-22','M',NULL,NULL,NULL,4,NULL,'OP',NULL,NULL,NULL,'1231231231','N','1',51,'2016-02-22 02:32:19',51,'2016-02-22 02:55:50','0000-00-00 00:00:00'),(38,'de5ffdee-4098-5cf5-acae-9c9610e7aac3',NULL,'AH0000033',58,'2016-02-25 07:05:33','Mr.','Testing',NULL,NULL,NULL,NULL,NULL,'2014-10-13','M',NULL,NULL,NULL,NULL,NULL,'OP',NULL,NULL,NULL,'1234567890',NULL,'1',63,'2016-02-25 07:05:33',63,'2016-02-25 07:05:33','0000-00-00 00:00:00'),(39,'6ff83cfb-ae86-588e-bbfd-bd45fa0ce95a',NULL,'AH0000034',58,'2016-03-02 11:06:36','Mr.','Prakash Arul Mani',NULL,NULL,NULL,NULL,NULL,'1990-01-31','M',NULL,NULL,'O?',4,NULL,'NO',NULL,NULL,NULL,'9566695006',NULL,'1',51,'2016-03-02 15:36:36',51,'2016-03-02 17:55:22','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

/*Data for the table `pat_patient_address` */

insert  into `pat_patient_address`(`addr_id`,`patient_id`,`addr_current_address`,`addr_country_id`,`addr_state_id`,`addr_city_id`,`addr_zip`,`addr_perm_address`,`addr_perm_country_id`,`addr_perm_state_id`,`addr_perm_city_id`,`addr_perm_zip`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (18,18,'Test test test',11,10,4,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-16 06:30:51',51,'2016-02-16 06:30:51','0000-00-00 00:00:00'),(19,19,'anna nagar',11,10,4,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-16 22:07:14',51,'2016-02-17 02:41:37','0000-00-00 00:00:00'),(20,20,'abc avenue',7,8,1,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-16 22:10:56',51,'2016-02-16 22:10:56','0000-00-00 00:00:00'),(21,21,'top lane',11,10,4,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-16 22:15:06',51,'2016-02-16 22:15:06','0000-00-00 00:00:00'),(22,22,'sdfas',7,8,1,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-17 00:14:58',51,'2016-02-17 00:14:58','0000-00-00 00:00:00'),(23,23,'sdfas',7,8,1,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-17 00:15:03',51,'2016-02-17 00:15:03','0000-00-00 00:00:00'),(24,24,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-17 00:17:40',51,'2016-02-17 00:17:40','0000-00-00 00:00:00'),(25,25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-17 00:20:10',51,'2016-02-17 00:20:10','0000-00-00 00:00:00'),(26,26,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-17 00:21:54',51,'2016-02-17 00:21:54','0000-00-00 00:00:00'),(27,27,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-17 00:24:22',51,'2016-02-17 00:24:22','0000-00-00 00:00:00'),(28,28,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-17 01:13:02',51,'2016-02-17 01:13:02','0000-00-00 00:00:00'),(29,29,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,59,'2016-02-17 06:30:17',59,'2016-02-20 06:10:28','0000-00-00 00:00:00'),(30,30,'Test',7,8,1,'625002','Test',7,8,1,'625002',51,'2016-02-17 06:42:16',51,'2016-02-19 06:17:53','0000-00-00 00:00:00'),(31,31,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,59,'2016-02-18 03:33:58',59,'2016-02-18 03:33:58','0000-00-00 00:00:00'),(32,32,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-19 00:46:42',51,'2016-02-19 00:46:42','0000-00-00 00:00:00'),(33,33,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,59,'2016-02-19 00:51:10',59,'2016-02-19 00:51:10','0000-00-00 00:00:00'),(34,34,'Test test',7,8,1,NULL,NULL,NULL,NULL,NULL,NULL,62,'2016-02-19 07:18:51',62,'2016-02-19 07:18:51','0000-00-00 00:00:00'),(35,35,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,59,'2016-02-20 03:31:26',59,'2016-02-20 03:31:26','0000-00-00 00:00:00'),(36,36,'test',7,8,1,'632222','test',7,8,1,'632222',67,'2016-02-21 23:20:06',67,'2016-02-21 23:46:02','0000-00-00 00:00:00'),(37,37,'test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-02-22 02:32:19',51,'2016-02-22 02:55:50','0000-00-00 00:00:00'),(38,38,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,63,'2016-02-25 07:05:33',63,'2016-02-25 07:05:33','0000-00-00 00:00:00'),(39,39,NULL,11,10,4,NULL,NULL,NULL,NULL,NULL,NULL,51,'2016-03-02 15:36:36',51,'2016-03-02 15:36:36','0000-00-00 00:00:00');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pat_patient_casesheet` */

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `pat_procedure` */

insert  into `pat_procedure`(`proc_id`,`tenant_id`,`encounter_id`,`patient_id`,`charge_subcat_id`,`proc_date`,`proc_consultant_ids`,`proc_description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,5,20,22,'2016-02-17 18:27:45','[54,56]','Test test','1',51,'2016-02-17 06:58:00',51,'2016-02-17 06:58:00','0000-00-00 00:00:00'),(2,60,6,29,30,'2016-02-18 12:32:11','[60,61]','give vizylac','1',59,'2016-02-18 01:03:03',59,'2016-02-18 01:03:03','0000-00-00 00:00:00'),(3,60,6,29,22,'2016-02-18 12:33:15','[61]','report normal...repeat test on monday\nneed to follow up\naversion test next wednesday\nthursday blood level sugar','1',59,'2016-02-18 01:03:40',59,'2016-02-18 01:04:33','0000-00-00 00:00:00'),(4,58,54,37,22,'2016-02-22 14:47:51','[56]','rgvg5g6g yy6hy6h 6yhy6h6 6yh6h6yh 6yh6yhy6h 6yhy6hy6','1',51,'2016-02-22 03:18:09',51,'2016-02-22 03:20:05','0000-00-00 00:00:00'),(5,61,57,30,22,'2016-02-25 13:38:00','[68,69]','test','1',67,'2016-02-25 02:08:24',67,'2016-02-25 02:20:47','0000-00-00 00:00:00'),(6,61,60,24,22,'2016-02-27 19:13:07','[68,69,70,71,72]','TEST','1',67,'2016-02-27 07:43:40',67,'2016-02-27 07:43:40','0000-00-00 00:00:00');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pha_brand` */

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pha_brand_division` */

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
  CONSTRAINT `FK_pha_drug_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `pha_drug_class` */

insert  into `pha_drug_class`(`drug_class_id`,`tenant_id`,`drug_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'Drug Class - 1','1',51,'2016-03-03 15:10:20',51,'2016-03-03 15:10:28','0000-00-00 00:00:00'),(2,58,'Druf class - 2','1',51,'2016-03-04 15:11:48',51,'2016-03-04 15:11:48','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `pha_drug_generic` */

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `pha_generic` */

insert  into `pha_generic`(`generic_id`,`tenant_id`,`generic_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,58,'Generic - 1','1',51,'2016-03-03 18:20:16',51,'2016-03-03 18:20:16','0000-00-00 00:00:00'),(2,58,'Generic - 2','1',51,'2016-03-04 13:48:40',51,'2016-03-04 13:48:40','0000-00-00 00:00:00');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pha_package_unit` */

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pha_product_description` */

/*Table structure for table `pha_supplier` */

DROP TABLE IF EXISTS `pha_supplier`;

CREATE TABLE `pha_supplier` (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `supplier_name` varchar(100) NOT NULL,
  `supplier_code` varchar(50) NOT NULL,
  `supplier_address` text,
  `city_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `zip` varchar(30) DEFAULT NULL,
  `supplier_mobile` varchar(50) DEFAULT NULL,
  `supplier_phone` varchar(50) DEFAULT NULL,
  `cst_no` varchar(100) DEFAULT NULL,
  `tin_no` varchar(100) DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pha_supplier` */

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pha_vat` */

/*Table structure for table `v_encounter` */

DROP TABLE IF EXISTS `v_encounter`;

/*!50001 DROP VIEW IF EXISTS `v_encounter` */;
/*!50001 DROP TABLE IF EXISTS `v_encounter` */;

/*!50001 CREATE TABLE  `v_encounter`(
 `id` int(11) ,
 `encounter_id` int(11) ,
 `date` varchar(21) ,
 `type` varchar(17) ,
 `details` varchar(214) ,
 `doctor` varchar(60) ,
 `patient_id` int(11) ,
 `patient_guid` varchar(50) ,
 `encounter_type` varchar(5) ,
 `status` varchar(1) ,
 `date_time` datetime 
)*/;

/*View structure for view v_encounter */

/*!50001 DROP TABLE IF EXISTS `v_encounter` */;
/*!50001 DROP VIEW IF EXISTS `v_encounter` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_encounter` AS select `a`.`appt_id` AS `id`,`c`.`encounter_id` AS `encounter_id`,concat(`a`.`status_date`,' ',`a`.`status_time`) AS `date`,(case `a`.`appt_status` when 'B' then 'Booked' when 'A' then 'Arived' when 'S' then 'Seen' when 'C' then 'Cancelled' else NULL end) AS `type`,'\nOP' AS `details`,concat(`b`.`title_code`,`b`.`name`) AS `doctor`,`c`.`patient_id` AS `patient_id`,`d`.`patient_guid` AS `patient_guid`,`c`.`encounter_type` AS `encounter_type`,`c`.`status` AS `status`,`a`.`status_date` AS `date_time` from (((`pat_appointment` `a` join `co_user` `b` on((`b`.`user_id` = `a`.`consultant_id`))) join `pat_encounter` `c` on((`c`.`encounter_id` = `a`.`encounter_id`))) join `pat_patient` `d` on((`d`.`patient_id` = `c`.`patient_id`))) union all select `a`.`admn_id` AS `id`,`c`.`encounter_id` AS `encounter_id`,`a`.`status_date` AS `date`,(case `a`.`admission_status` when 'A' then 'Admission' when 'D' then 'Discharge' when 'TR' then 'Transfer (Room)' when 'TD' then 'Transfer (Doctor)' else NULL end) AS `type`,concat('IP: ',`d`.`floor_name`,' > ',`e`.`ward_name`,' > ',`f`.`bed_name`,'  (',`g`.`room_type_name`,')') AS `details`,concat(`b`.`title_code`,`b`.`name`) AS `doctor`,`c`.`patient_id` AS `patient_id`,`h`.`patient_guid` AS `patient_guid`,`c`.`encounter_type` AS `encounter_type`,`c`.`status` AS `status`,`a`.`status_date` AS `date_time` from (((((((`pat_admission` `a` join `co_user` `b` on((`b`.`user_id` = `a`.`consultant_id`))) join `pat_encounter` `c` on((`c`.`encounter_id` = `a`.`encounter_id`))) left join `co_floor` `d` on((`d`.`floor_id` = `a`.`floor_id`))) left join `co_ward` `e` on((`e`.`ward_id` = `a`.`ward_id`))) left join `co_room` `f` on((`f`.`room_id` = `a`.`room_id`))) left join `co_room_type` `g` on((`g`.`room_type_id` = `a`.`room_type_id`))) join `pat_patient` `h` on((`h`.`patient_id` = `c`.`patient_id`))) order by `encounter_id` desc,`date_time` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
