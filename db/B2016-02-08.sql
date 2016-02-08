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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `co_alert` */

insert  into `co_alert`(`alert_id`,`tenant_id`,`alert_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'New 111','1',1,'2016-01-12 17:59:46',1,'2016-01-12 18:05:05','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `co_charge_per_category` */

insert  into `co_charge_per_category`(`charge_id`,`tenant_id`,`charge_cat_type`,`charge_cat_id`,`charge_code_id`,`charge_default`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (6,18,'C',14,1,NULL,'2016-01-22 12:59:35',1,'2016-01-22 12:59:35',1,'0000-00-00 00:00:00'),(7,18,'C',14,2,NULL,'2016-01-22 13:02:55',1,'2016-01-22 13:02:55',1,'0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `co_charge_per_subcategory` */

insert  into `co_charge_per_subcategory`(`sub_charge_id`,`charge_id`,`charge_type`,`charge_link_id`,`charge_amount`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (3,6,'OP',1,'100.00','2016-01-22 12:59:36',1,'2016-01-22 13:02:31',1,'0000-00-00 00:00:00'),(4,6,'OP',2,'200.00','2016-01-22 12:59:36',1,'2016-01-22 12:59:36',1,'0000-00-00 00:00:00'),(5,6,'OP',3,'300.00','2016-01-22 12:59:36',1,'2016-01-22 13:02:33',1,'0000-00-00 00:00:00'),(6,6,'OP',4,'400.00','2016-01-22 12:59:36',1,'2016-01-22 12:59:36',1,'0000-00-00 00:00:00'),(7,6,'IP',1,'500.00','2016-01-22 12:59:36',1,'2016-01-22 13:02:29',1,'0000-00-00 00:00:00'),(8,7,'OP',1,'100.00','2016-01-22 13:02:55',1,'2016-01-22 13:02:55',1,'0000-00-00 00:00:00'),(9,7,'OP',2,'200.00','2016-01-22 13:02:55',1,'2016-01-22 13:02:55',1,'0000-00-00 00:00:00'),(10,7,'OP',3,'300.00','2016-01-22 13:02:55',1,'2016-01-22 13:02:55',1,'0000-00-00 00:00:00'),(11,7,'OP',4,'400.00','2016-01-22 13:02:56',1,'2016-01-22 13:02:56',1,'0000-00-00 00:00:00'),(12,7,'IP',1,'600.00','2016-01-22 13:02:56',1,'2016-01-22 13:02:56',1,'0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `co_doctor_schedule` */

insert  into `co_doctor_schedule`(`schedule_id`,`tenant_id`,`user_id`,`schedule_day`,`schedule_time_in`,`schedule_time_out`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (1,18,28,'-1','01:00:00','01:30:00','2016-01-21 15:21:57',1,'2016-01-22 11:03:02',1,'0000-00-00 00:00:00'),(2,18,28,'-1','06:30:00','11:30:00','2016-01-21 15:22:28',1,'2016-01-21 15:22:28',1,'2016-01-21 15:22:37'),(3,18,28,'1','00:30:00','04:00:00','2016-01-21 15:22:53',1,'2016-01-21 15:22:53',1,'0000-00-00 00:00:00'),(4,18,28,'2','06:00:00','07:30:00','2016-01-21 19:11:37',1,'2016-01-21 19:11:37',1,'0000-00-00 00:00:00'),(5,18,28,'-1','00:00:00','00:30:00','2016-02-05 15:48:55',1,'2016-02-05 15:48:55',1,'0000-00-00 00:00:00'),(6,18,27,'-1','00:00:00','02:00:00','2016-02-05 15:49:12',1,'2016-02-06 16:20:52',1,'0000-00-00 00:00:00'),(7,18,27,'-1','02:00:00','02:00:00','2016-02-06 12:04:00',1,'2016-02-06 12:04:00',1,'0000-00-00 00:00:00'),(8,18,27,'-1','05:00:00','05:00:00','2016-02-06 12:04:00',1,'2016-02-06 12:04:00',1,'0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `co_floor` */

insert  into `co_floor`(`floor_id`,`tenant_id`,`floor_name`,`floor_code`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (2,18,'Ground Floor','AA','1',1,'2016-01-09 12:37:26',1,'2016-01-09 12:37:26','2016-01-09 16:03:13'),(3,18,'ASAAA11','AA','1',1,'2016-01-09 12:37:41',1,'2016-01-09 13:32:49','2016-01-09 15:54:15'),(4,1,'test','EE','0',1,'2016-01-09 16:03:23',1,'2016-01-09 16:46:46','0000-00-00 00:00:00'),(5,18,'New','FL','1',1,'2016-01-09 19:31:41',NULL,'2016-02-01 15:20:17','0000-00-00 00:00:00'),(6,18,'Floor 2',NULL,'1',1,'2016-01-12 12:45:15',NULL,'2016-01-21 19:27:47','0000-00-00 00:00:00'),(7,18,'Floor 3',NULL,'1',1,'2016-01-12 12:45:31',1,'2016-01-12 12:45:31','2016-01-12 12:45:39');

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
  KEY `FK_co_internal_code` (`tenant_id`),
  CONSTRAINT `FK_co_internal_code` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `co_internal_code` */

insert  into `co_internal_code`(`internal_code_id`,`tenant_id`,`code_type`,`code_prefix`,`code`,`code_padding`,`code_suffix`,`status`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (1,18,'B','B',1,7,NULL,'1','2016-02-02 10:56:12',1,NULL,NULL,'0000-00-00 00:00:00'),(2,18,'P','PAT',3,7,NULL,'1','2016-02-04 13:44:13',1,'2016-02-04 13:44:13',1,'0000-00-00 00:00:00');

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
  PRIMARY KEY (`login_id`),
  KEY `FK_co_login_user` (`user_id`),
  CONSTRAINT `FK_co_login_user` FOREIGN KEY (`user_id`) REFERENCES `co_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

/*Data for the table `co_login` */

insert  into `co_login`(`login_id`,`user_id`,`username`,`password`,`password_reset_token`,`authtoken`,`created_by`,`created_at`,`modified_by`,`modified_at`,`activation_date`,`Inactivation_date`) values (1,1,'123123','$2y$13$f1.ldgwKkkr8GcHPoSmrou4sXjLpJTaQlGxgXnmqS0ubWJvu0/yLu',NULL,'MTIzMTIzMTQ1NDkyNDM3NjYwNzM=',0,'2015-12-29 12:40:15',NULL,'2016-02-08 15:09:36',NULL,NULL),(2,2,'test','$2y$13$z5IIhq7WgWa.mttlXvPfU.rj7ECjwe0XO0qYotm/KGYGVLofIGW7q',NULL,NULL,-1,'2015-12-29 13:27:23',NULL,NULL,NULL,NULL),(6,6,'test','$2y$13$26z8fSgBVSaDk6dSc4tEouKnZSoYbMxq/4rBobSP/QSQfBvdvTNFW',NULL,NULL,-1,'2015-12-30 17:04:14',NULL,NULL,NULL,NULL),(7,7,'123123','$2y$13$UuCYLvsFlDJ8z4c4rQ1HjOborIk4kQSn/BUZN3o4IQXVZXh3yuqSK',NULL,NULL,-1,'2015-12-30 20:29:03',NULL,NULL,NULL,NULL),(8,8,'123123','$2y$13$43E8tZWtjPeBgmNSPyT9J.D5eaI0YzYhz6gcDIPIivUiAnfhxIdsm',NULL,NULL,-1,'2015-12-30 20:29:03',NULL,NULL,NULL,NULL),(9,9,'123123','$2y$13$1y2enmiOKrzYyjqcFwVUE.8RCejtYcGZZL4jm98Wk3wE9CCMR3Ymu',NULL,NULL,-1,'2015-12-30 20:29:03',NULL,NULL,NULL,NULL),(10,10,'123123','$2y$13$012PM43tycVN7OcYlB/0x.fdiI61LZUtIozbAxKhnWbr1IyFDBcRi',NULL,NULL,-1,'2015-12-30 20:29:03',NULL,NULL,NULL,NULL),(11,11,'123123','$2y$13$MTPatpVSg6AKyJZS0ClJcucw1aRwGnFyfTn.W2QURueLyRU6GHF3K',NULL,NULL,-1,'2015-12-30 20:29:03',NULL,NULL,NULL,NULL),(12,12,'test','$2y$13$3HYt/nfAibfzt7d.CHnDKOpmYuyMq8lFsU6ZpvAgZyfRsTvRtEZz.',NULL,NULL,-1,'2015-12-30 20:43:30',NULL,NULL,NULL,NULL),(13,13,'sdfsdf','$2y$13$eq47HcHN6RRpmsuZFScU2u23AfUZp47a2taPaTh3ZkLaoMN7c1fOC',NULL,NULL,-1,'2015-12-30 20:50:23',NULL,NULL,NULL,NULL),(15,15,'tester','$2y$13$9FPvHeqEZGuIvcifzJVs4.w5iX6ZY.ezbqQ1u0.F8l.lYrfemR/ym',NULL,NULL,-1,'2015-12-31 19:28:42',NULL,NULL,NULL,NULL),(16,16,'test','$2y$13$1.GJ18v3tsxpv/pQ4mZq6u3ShXkHIosNo.KFzIo4r3YEP.TQ83L4i',NULL,NULL,-1,'2016-01-02 15:07:37',NULL,NULL,NULL,NULL),(17,17,'test','$2y$13$Rh4dpklxDBQyC3q9JtCf2.N334ZUVjq2XDwUq7mmYpvypWCWfL8Xi',NULL,NULL,-1,'2016-01-02 15:52:35',NULL,NULL,NULL,NULL),(18,18,'test','$2y$13$38DMc9wOBSj.gMx8oFfAv.hrHH1frzKERGTY1.pSLYv6kJT61Zmr.',NULL,NULL,-1,'2016-01-02 16:03:13',NULL,NULL,NULL,NULL),(19,19,'test','$2y$13$jbSCihxnnDHl8gLkYPdteO/XtRWrKEHQnlL2l5cvh1Lj1z1W55pPS',NULL,NULL,-1,'2016-01-02 18:20:39',NULL,NULL,NULL,NULL),(20,20,'test','$2y$13$2rWaKGPs0CPD5UGgsuaOoumTt8cz7AKjKjD6Zg/oAylVT9lJpiyRe',NULL,NULL,-1,'2016-01-02 19:16:53',NULL,NULL,NULL,NULL),(21,21,'test','123123',NULL,NULL,0,'2016-01-07 12:15:40',NULL,NULL,NULL,NULL),(22,22,'aaaa','aaa',NULL,NULL,0,'2016-01-07 16:00:58',NULL,NULL,NULL,NULL),(23,23,'aaaa','aaa',NULL,NULL,0,'2016-01-07 16:03:32',NULL,NULL,NULL,NULL),(24,24,'aaaa','aaa',NULL,NULL,0,'2016-01-07 16:09:30',NULL,NULL,NULL,NULL),(25,25,'aaaa','aaa',NULL,NULL,0,'2016-01-07 16:11:01',NULL,NULL,NULL,NULL),(26,26,'aaaa','aaa',NULL,NULL,-1,'2016-01-07 16:12:48',1,'2016-01-08 12:56:42','2016-01-04','2016-01-07'),(29,27,'111222','123123',NULL,NULL,1,'2016-01-08 13:50:32',1,'2016-02-03 16:36:13','2016-02-22','2016-02-23'),(30,29,'qddaaaa','',NULL,NULL,-1,'2016-01-18 12:49:52',-1,'2016-02-06 12:45:43','2016-01-18','2016-03-01'),(31,28,'adasd123123','$2y$13$bZtCDhi8lEBT7AIVt8t7J.6w5FFD1Gv/FBplfDY331neVdBgY.VMG',NULL,NULL,1,'2016-02-06 10:59:08',1,'2016-02-06 11:36:46','2016-02-06','2016-02-06');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `co_master_city` */

insert  into `co_master_city`(`city_id`,`tenant_id`,`state_id`,`city_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,NULL,1,'Madurai','1',1,'2015-12-28 15:07:51',NULL,NULL,'0000-00-00 00:00:00'),(2,NULL,1,'Chennai','1',1,'2015-12-28 16:21:17',NULL,NULL,'0000-00-00 00:00:00'),(3,NULL,2,'Cochin','1',1,'2015-12-28 17:31:33',NULL,NULL,'0000-00-00 00:00:00'),(4,18,3,'Madurai','1',1,'2016-01-12 17:03:36',1,'2016-01-12 18:06:13','0000-00-00 00:00:00'),(7,18,1,'aaa','1',1,'2016-01-12 17:21:20',1,'2016-01-12 17:21:20','2016-01-12 17:21:25');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `co_master_country` */

insert  into `co_master_country`(`country_id`,`tenant_id`,`country_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,NULL,'India','1',1,'2015-12-28 15:07:32',NULL,NULL,'0000-00-00 00:00:00'),(2,18,'Pakistann','1',1,'2015-12-28 17:30:39',1,'2016-01-12 14:00:24','0000-00-00 00:00:00'),(4,18,'test','1',1,'2016-01-12 13:56:55',1,'2016-01-22 10:24:04','0000-00-00 00:00:00'),(5,18,'testss','1',1,'2016-01-12 13:57:12',1,'2016-01-12 13:57:12','2016-01-12 13:58:43'),(7,18,'test123123','1',1,'2016-01-18 16:26:07',1,'2016-01-18 16:26:07','2016-01-18 16:26:16');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `co_master_state` */

insert  into `co_master_state`(`state_id`,`tenant_id`,`country_id`,`state_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,NULL,1,'Tamil Nadu','1',1,'2015-12-28 15:07:43',NULL,NULL,'0000-00-00 00:00:00'),(2,NULL,1,'Kerala','1',1,'2015-12-28 17:30:49',NULL,NULL,'0000-00-00 00:00:00'),(3,NULL,2,'Islamabad','1',1,'2015-12-28 17:31:13',NULL,NULL,'0000-00-00 00:00:00'),(4,18,1,'Test','1',1,'2016-01-12 15:44:25',1,'2016-01-12 18:07:08','0000-00-00 00:00:00'),(6,18,1,'Tester','1',1,'2016-01-12 15:47:54',1,'2016-01-12 15:49:00','2016-01-12 16:22:25');

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
  KEY `FK_co_patient_category_tenant` (`tenant_id`),
  CONSTRAINT `FK_co_patient_category_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `co_patient_category` */

insert  into `co_patient_category`(`patient_cat_id`,`tenant_id`,`patient_cat_name`,`patient_cat_color`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'New','#e90d72','1',1,'2016-01-13 10:16:29',1,'2016-01-13 10:16:29','0000-00-00 00:00:00'),(2,18,'Standard - Default','#6c5454','1',1,'2016-01-13 12:03:25',1,'2016-01-13 12:03:25','0000-00-00 00:00:00'),(3,18,'Cate 3','#FFFFFF','1',1,'2016-01-13 18:35:59',1,'2016-01-13 18:35:59','0000-00-00 00:00:00'),(4,18,'Cate 4','#FFFFFF','1',1,'2016-01-13 20:26:17',1,'2016-01-13 20:26:17','0000-00-00 00:00:00'),(5,18,'New Patient category','#140c37','1',1,'2016-02-05 15:47:56',1,'2016-02-05 15:48:15','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=latin1;

/*Data for the table `co_resources` */

insert  into `co_resources`(`resource_id`,`parent_id`,`resource_name`,`resource_url`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,NULL,'Configuration','configuration',-1,'2015-12-29 15:11:20',NULL,NULL),(2,1,'Organization Module','organization',-1,'2015-12-29 15:11:42',NULL,NULL),(3,2,'Organization','configuration.organization',-1,'2016-01-19 15:35:50',NULL,NULL),(4,2,'Organization Module','configuration.organizationModule',-1,'2016-01-19 15:36:07',NULL,NULL),(5,1,'Administrative Module','administrative',-1,'2016-01-20 11:11:09',NULL,NULL),(6,5,'Roles','configuration.roles',-1,'2016-01-20 11:11:58',NULL,NULL),(7,5,'Role Rights','configuration.roleRights',-1,'2016-01-20 11:14:04',NULL,NULL),(8,5,'User roles','configuration.userRoles',-1,'2016-01-20 11:14:31',NULL,NULL),(9,5,'Charge Category','configuration.roomChargeCategory',-1,'2016-01-20 11:15:00',NULL,NULL),(10,1,'User Module','userModule',-1,'2016-01-20 11:16:12',NULL,NULL),(11,10,'User Registration','configuration.registration',-1,'2016-01-20 11:16:50',NULL,NULL),(12,1,'Ward Management','wardManagement',-1,'2016-01-20 11:17:42',NULL,NULL),(13,12,'Floors','configuration.floors',-1,'2016-01-20 11:18:10',NULL,NULL),(14,12,'Wards','configuration.wards',-1,'2016-01-20 11:18:25',NULL,NULL),(15,12,'Bed Type','configuration.roomType',-1,'2016-01-20 11:18:48',NULL,NULL),(16,12,'Room','configuration.room',-1,'2016-01-20 11:19:17',NULL,NULL),(17,12,'Room and Bed Type','configuration.roomTypeRoom',-1,'2016-01-20 11:20:39',NULL,NULL),(18,1,'Charges Configuration','chargesConfiguration',-1,'2016-01-20 11:21:17',NULL,NULL),(19,18,'Room Charge','configuration.roomCharge',-1,'2016-01-20 11:21:40',NULL,NULL),(20,18,'Room Maintenance','configuration.roomMaintenance',-1,'2016-01-20 11:21:59',NULL,NULL),(21,18,'Charges for Category','configuration.chargePerCategory',-1,'2016-01-20 11:22:20',NULL,NULL),(22,1,'Doctor’s Configuration','doctorsConfiguration',-1,'2016-01-20 11:22:59',NULL,NULL),(23,22,'Doctors Schedule','configuration.docSchedule',-1,'2016-01-20 11:23:20',NULL,NULL),(24,22,'Specialities','configuration.specialities',-1,'2016-01-20 11:23:39',NULL,NULL),(25,1,'Miscellaneous','miscellaneous',-1,'2016-01-20 11:24:17',NULL,NULL),(26,25,'Alerts','configuration.alerts',-1,'2016-01-20 11:24:32',NULL,NULL),(27,25,'Patient Category','configuration.patientCategories',-1,'2016-01-20 11:24:47',NULL,NULL),(28,25,'Bill-No Prefix','configuration.internalCode',-1,'2016-01-20 11:25:06',NULL,NULL),(29,25,'Master Country','configuration.countries',-1,'2016-01-20 11:25:22',NULL,NULL),(30,25,'Master State','configuration.states',-1,'2016-01-20 11:25:35',NULL,NULL),(31,25,'Master City','configuration.cities',-1,'2016-01-20 11:25:52',NULL,NULL),(32,5,'Room Charge Item','configuration.roomChargeCategoryItem',-1,'2016-02-01 12:04:21',NULL,NULL),(33,5,'Allied Charges','configuration.alliedCharge',-1,'2016-02-03 15:31:05',NULL,NULL),(34,5,'Procedures','configuration.procedure',-1,'2016-02-05 15:43:00',NULL,NULL),(35,6,'Add Role','configuration.role_create',-1,'2016-02-08 15:16:27',NULL,NULL),(36,6,'Update Role','configuration.role_update',-1,'2016-02-08 15:17:21',NULL,NULL),(37,6,'Delete Role','configuration.role_delete',-1,'2016-02-08 15:18:46',NULL,NULL),(38,9,'Add Charge Category','configuration.roomChargeCategoryCreate',-1,'2016-02-08 15:20:26',NULL,NULL),(39,9,'Update Charge Category','configuration.roomChargeCategoryUpdate',-1,'2016-02-08 15:20:26',NULL,NULL),(40,9,'Delete Charge Category','configuration.roomChargeCategoryDelete',-1,'2016-02-08 15:20:27',NULL,NULL),(41,32,'Add Room Charge Item','configuration.roomChargeCategoryItemCreate',-1,'2016-02-08 15:21:56',NULL,NULL),(42,32,'Update Room Charge Item','configuration.roomChargeCategoryItemUpdate',-1,'2016-02-08 15:21:56',NULL,NULL),(43,32,'Delete Room Charge Item','configuration.roomChargeCategoryItemDelete',-1,'2016-02-08 15:21:56',NULL,NULL),(44,33,'Add Allied Charges','configuration.alliedChargeCreate',-1,'2016-02-08 15:31:45',NULL,NULL),(45,33,'Update Allied Charges','configuration.alliedChargeUpdate',-1,'2016-02-08 15:31:45',NULL,NULL),(46,33,'Delete Allied Charges','configuration.alliedChargeDelete',-1,'2016-02-08 15:31:45',NULL,NULL),(47,34,'Add Procedures','configuration.procedureChargeCreate',-1,'2016-02-08 15:38:42',NULL,NULL),(48,34,'Update Procedures','configuration.procedureChargeUpdate',-1,'2016-02-08 15:38:42',NULL,NULL),(49,34,'Delete Procedures','configuration.procedureChargeDelete',-1,'2016-02-08 15:38:42',NULL,NULL),(54,11,'Add User','configuration.user_create',-1,'2016-02-08 15:41:39',NULL,NULL),(55,11,'Update User','configuration.user_update',-1,'2016-02-08 15:41:39',NULL,NULL),(56,11,'Delete User','configuration.user_delete',-1,'2016-02-08 15:41:39',NULL,NULL),(57,11,'Add/Update Login','configuration.login_update',-1,'2016-02-08 15:41:39',NULL,NULL),(58,13,'Add Floor','configuration.floor_create',-1,'2016-02-08 15:49:25',NULL,NULL),(59,13,'Update Floor','configuration.floor_update',-1,'2016-02-08 15:49:25',NULL,NULL),(60,13,'Delete Floor','configuration.floor_delete',-1,'2016-02-08 15:49:25',NULL,NULL),(61,14,'Add Ward','configuration.ward_create',-1,'2016-02-08 15:50:14',NULL,NULL),(62,14,'Update Ward','configuration.ward_update',-1,'2016-02-08 15:50:14',NULL,NULL),(63,14,'Delete Ward','configuration.ward_delete',-1,'2016-02-08 15:50:14',NULL,NULL),(64,15,'Add Bed Type','configuration.roomTypeCreate',-1,'2016-02-08 15:51:19',NULL,NULL),(65,15,'Update Bed Type','configuration.roomTypeUpdate',-1,'2016-02-08 15:51:19',NULL,NULL),(66,15,'Delete Bed Type','configuration.roomTypeDelete',-1,'2016-02-08 15:51:19',NULL,NULL),(67,16,'Add Room','configuration.roomCreate',-1,'2016-02-08 15:52:21',NULL,NULL),(68,16,'Update Room','configuration.roomUpdate',-1,'2016-02-08 15:52:21',NULL,NULL),(69,16,'Delete Room','configuration.roomDelete',-1,'2016-02-08 15:52:21',NULL,NULL),(70,17,'Assign Room and Bed Types','configuration.roomTypeRoomUpdate',-1,'2016-02-08 15:53:47',NULL,NULL),(71,19,'Create RoomCharge','configuration.roomChargeCreate',-1,'2016-02-08 15:55:00',NULL,NULL),(72,19,'Update RoomCharge','configuration.roomChargeUpdate',-1,'2016-02-08 15:55:00',NULL,NULL),(73,19,'Delete RoomCharge','configuration.roomChargeDelete',-1,'2016-02-08 15:55:00',NULL,NULL),(74,20,'Create Room Maintenance','configuration.roomMaintenanceCreate',-1,'2016-02-08 15:55:59',NULL,NULL),(75,20,'Update Room Maintenance','configuration.roomMaintenanceUpdate',-1,'2016-02-08 15:55:59',NULL,NULL),(76,20,'Delete Room Maintenance','configuration.roomMaintenanceDelete',-1,'2016-02-08 15:55:59',NULL,NULL),(77,21,'Create Charges for Category','configuration.chargePerCategoryCreate',-1,'2016-02-08 16:00:51',NULL,NULL),(78,22,'Create Doctor Schedule','configuration.docScheduleCreate',-1,'2016-02-08 16:02:26',NULL,NULL),(79,22,'Update Doctor Schedule','configuration.docScheduleUpdate',-1,'2016-02-08 16:02:26',NULL,NULL),(80,22,'Delete Doctor Schedule','configuration.docScheduleDelete',-1,'2016-02-08 16:02:26',NULL,NULL),(81,24,'Create Speciality','configuration.specialityCreate',-1,'2016-02-08 16:03:14',NULL,NULL),(82,24,'Update Speciality','configuration.specialityUpdate',-1,'2016-02-08 16:03:14',NULL,NULL),(83,24,'Delete Speciality','configuration.specialityDelete',-1,'2016-02-08 16:03:14',NULL,NULL),(84,26,'Create Alerts','configuration.alertCreate',-1,'2016-02-08 16:04:00',NULL,NULL),(85,26,'Update Alerts','configuration.alertUpdate',-1,'2016-02-08 16:04:00',NULL,NULL),(86,26,'Delete Alerts','configuration.alertDelete',-1,'2016-02-08 16:04:00',NULL,NULL),(87,27,'Create Patient Category','configuration.patientCategoryCreate',-1,'2016-02-08 16:04:42',NULL,NULL),(88,27,'Update Patient Category','configuration.patientCategoryUpdate',-1,'2016-02-08 16:04:42',NULL,NULL),(89,27,'Delete Patient Category','configuration.patientCategoryDelete',-1,'2016-02-08 16:04:42',NULL,NULL),(90,29,'Create Country','configuration.countryCreate',-1,'2016-02-08 16:05:26',NULL,NULL),(91,29,'Update Country','configuration.countryUpdate',-1,'2016-02-08 16:05:27',NULL,NULL),(92,29,'Delete Country','configuration.countryDelete',-1,'2016-02-08 16:05:27',NULL,NULL),(93,30,'Create State','configuration.stateCreate',-1,'2016-02-08 16:06:03',NULL,NULL),(94,30,'Update State','configuration.stateUpdate',-1,'2016-02-08 16:06:03',NULL,NULL),(95,30,'Delete State','configuration.stateDelete',-1,'2016-02-08 16:06:03',NULL,NULL),(96,31,'Create City','configuration.cityCreate',-1,'2016-02-08 16:06:59',NULL,NULL),(97,31,'Update City','configuration.cityUpdate',-1,'2016-02-08 16:06:59',NULL,NULL),(98,31,'Delete City','configuration.cityDelete',-1,'2016-02-08 16:06:59',NULL,NULL);

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
  UNIQUE KEY `CoRoleUnique` (`tenant_id`,`description`,`deleted_at`),
  CONSTRAINT `FK_co_role_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

/*Data for the table `co_role` */

insert  into `co_role`(`role_id`,`tenant_id`,`description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'Role22','1',-1,'2015-12-29 12:40:14',1,'2016-01-07 12:40:40','2016-01-14 18:01:04'),(2,19,'test','1',-1,'2015-12-29 13:27:21',NULL,NULL,'0000-00-00 00:00:00'),(6,23,'test','1',-1,'2015-12-30 17:04:13',NULL,NULL,'0000-00-00 00:00:00'),(7,24,'nwww','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(8,25,'nwww','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(9,26,'nwww','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(10,27,'nwww','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(11,28,'nwww','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(12,29,'Test','1',-1,'2015-12-30 20:43:29',NULL,NULL,'0000-00-00 00:00:00'),(13,30,'sfdsfd','1',-1,'2015-12-30 20:50:21',NULL,NULL,'0000-00-00 00:00:00'),(15,32,'test','1',-1,'2015-12-31 19:28:41',NULL,NULL,'0000-00-00 00:00:00'),(16,33,'test','1',-1,'2016-01-02 15:07:36',NULL,NULL,'0000-00-00 00:00:00'),(17,34,'test','1',-1,'2016-01-02 15:52:34',NULL,NULL,'0000-00-00 00:00:00'),(18,35,'test','1',-1,'2016-01-02 16:03:11',NULL,NULL,'0000-00-00 00:00:00'),(19,36,'test','1',-1,'2016-01-02 18:20:37',-1,'2016-01-07 11:57:34','0000-00-00 00:00:00'),(20,37,'test','1',-1,'2016-01-02 19:16:51',1,'2016-01-07 11:20:47','0000-00-00 00:00:00'),(21,38,'asdsad','1',-1,'2016-01-07 12:15:40',-1,'2016-01-07 12:15:40','0000-00-00 00:00:00'),(22,18,'tttt','1',1,'2016-01-07 12:58:06',1,'2016-01-07 12:58:06','0000-00-00 00:00:00'),(23,18,'aaaaa','1',1,'2016-01-07 12:58:23',1,'2016-01-07 12:58:23','0000-00-00 00:00:00'),(25,18,'aasds','1',1,'2016-01-07 13:00:14',1,'2016-01-07 13:00:14','0000-00-00 00:00:00'),(26,39,'aaaa','1',-1,'2016-01-07 16:00:58',-1,'2016-01-07 16:00:58','0000-00-00 00:00:00'),(27,40,'aaaa','1',-1,'2016-01-07 16:03:32',-1,'2016-01-07 16:03:32','0000-00-00 00:00:00'),(28,41,'aaaa','1',-1,'2016-01-07 16:09:29',-1,'2016-01-07 16:09:29','0000-00-00 00:00:00'),(29,42,'aaaa','1',-1,'2016-01-07 16:11:00',-1,'2016-01-07 16:11:00','0000-00-00 00:00:00'),(30,43,'aaaa','1',-1,'2016-01-07 16:12:48',-1,'2016-01-07 16:12:48','0000-00-00 00:00:00'),(31,18,'asdasdasd','1',1,'2016-01-07 19:57:54',1,'2016-01-07 19:57:54','0000-00-00 00:00:00'),(32,18,'aaa','1',1,'2016-01-09 11:41:10',1,'2016-01-09 11:41:10','0000-00-00 00:00:00'),(33,44,'Admin','1',-1,'2016-01-18 12:49:52',-1,'2016-01-18 12:49:52','0000-00-00 00:00:00'),(35,18,'asddass','1',1,'2016-02-02 17:41:58',1,'2016-02-02 17:41:58','0000-00-00 00:00:00'),(36,18,'asdsdasdad','1',1,'2016-02-02 17:42:07',1,'2016-02-02 17:42:07','0000-00-00 00:00:00'),(37,18,'bbbbbbbbbdd','1',1,'2016-02-02 17:42:28',1,'2016-02-08 10:21:31','0000-00-00 00:00:00');

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
  CONSTRAINT `FK_co_role_permissions_role` FOREIGN KEY (`role_id`) REFERENCES `co_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_co_role_permissions_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=latin1;

/*Data for the table `co_roles_resources` */

insert  into `co_roles_resources`(`role_perm_id`,`tenant_id`,`role_id`,`resource_id`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (7,23,6,1,'1',-1,'2015-12-30 17:04:15',NULL,NULL),(9,23,6,2,'1',-1,'2015-12-30 18:17:39',NULL,NULL),(32,33,16,1,'1',-1,'2016-01-02 15:07:37',NULL,NULL),(33,33,16,2,'1',-1,'2016-01-02 15:07:37',NULL,NULL),(36,36,19,1,'1',-1,'2016-01-02 18:20:39',NULL,NULL),(37,36,19,2,'1',-1,'2016-01-02 18:20:39',NULL,NULL),(40,37,20,1,'1',-1,'2016-01-02 19:16:55',NULL,NULL),(41,37,20,2,'1',-1,'2016-01-02 19:16:55',NULL,NULL),(57,43,30,1,'1',-1,'2016-01-07 16:43:07',NULL,NULL),(58,43,30,2,'1',-1,'2016-01-07 16:43:07',NULL,NULL),(64,44,33,1,'1',-1,'2016-01-18 12:49:52',NULL,NULL),(70,44,33,4,'1',-1,'2016-01-19 15:47:47',NULL,NULL),(71,44,33,2,'1',-1,'2016-01-19 15:51:43',NULL,NULL),(72,44,33,3,'1',-1,'2016-01-19 15:51:43',NULL,NULL),(73,18,1,1,'1',-1,'2016-01-19 18:06:11',NULL,NULL),(83,18,1,4,'1',-1,'2016-01-19 19:50:53',NULL,NULL),(84,18,1,2,'1',1,'2016-01-19 19:54:18',NULL,NULL),(85,18,1,3,'1',1,'2016-01-20 11:53:59',NULL,NULL),(86,18,1,5,'1',1,'2016-01-20 11:54:00',NULL,NULL),(87,18,1,6,'1',1,'2016-01-20 11:54:00',NULL,NULL),(88,18,1,7,'1',1,'2016-01-20 11:54:00',NULL,NULL),(89,18,1,8,'1',1,'2016-01-20 11:54:00',NULL,NULL),(90,18,1,9,'1',1,'2016-01-20 11:54:01',NULL,NULL),(91,18,1,10,'1',1,'2016-01-20 11:54:01',NULL,NULL),(92,18,1,11,'1',1,'2016-01-20 11:54:01',NULL,NULL),(93,18,1,12,'1',1,'2016-01-20 11:54:01',NULL,NULL),(94,18,1,13,'1',1,'2016-01-20 11:54:01',NULL,NULL),(95,18,1,14,'1',1,'2016-01-20 11:54:01',NULL,NULL),(96,18,1,15,'1',1,'2016-01-20 11:54:01',NULL,NULL),(97,18,1,16,'1',1,'2016-01-20 11:54:01',NULL,NULL),(98,18,1,17,'1',1,'2016-01-20 11:54:01',NULL,NULL),(99,18,1,18,'1',1,'2016-01-20 11:54:01',NULL,NULL),(100,18,1,19,'1',1,'2016-01-20 11:54:01',NULL,NULL),(101,18,1,20,'1',1,'2016-01-20 11:54:01',NULL,NULL),(102,18,1,21,'1',1,'2016-01-20 11:54:01',NULL,NULL),(103,18,1,22,'1',1,'2016-01-20 11:54:01',NULL,NULL),(104,18,1,23,'1',1,'2016-01-20 11:54:01',NULL,NULL),(105,18,1,24,'1',1,'2016-01-20 11:54:01',NULL,NULL),(106,18,1,25,'1',1,'2016-01-20 11:54:01',NULL,NULL),(107,18,1,26,'1',1,'2016-01-20 11:54:01',NULL,NULL),(108,18,1,27,'1',1,'2016-01-20 11:54:01',NULL,NULL),(109,18,1,28,'1',1,'2016-01-20 11:54:02',NULL,NULL),(110,18,1,29,'1',1,'2016-01-20 11:54:02',NULL,NULL),(111,18,1,30,'1',1,'2016-01-20 11:54:02',NULL,NULL),(112,18,1,31,'1',1,'2016-01-20 11:54:02',NULL,NULL),(113,18,31,1,'1',1,'2016-01-22 12:04:33',NULL,NULL),(114,18,31,12,'1',1,'2016-01-22 12:04:33',NULL,NULL),(115,18,31,13,'1',1,'2016-01-22 12:04:33',NULL,NULL),(116,18,31,14,'1',1,'2016-01-22 12:04:33',NULL,NULL),(117,18,31,15,'1',1,'2016-01-22 12:04:33',NULL,NULL),(118,18,31,18,'1',1,'2016-01-22 12:04:33',NULL,NULL),(119,18,31,19,'1',1,'2016-01-22 12:04:33',NULL,NULL),(120,18,31,22,'1',1,'2016-01-22 12:04:33',NULL,NULL),(121,18,31,23,'1',1,'2016-01-22 12:04:33',NULL,NULL),(122,18,31,25,'1',1,'2016-01-22 12:04:33',NULL,NULL),(123,18,31,31,'1',1,'2016-01-22 12:04:33',NULL,NULL),(124,18,1,32,'1',1,'2016-02-01 12:06:05',NULL,NULL),(125,18,1,33,'1',1,'2016-02-03 15:31:37',NULL,NULL),(126,18,1,34,'1',1,'2016-02-06 16:19:22',NULL,NULL);

/*Table structure for table `co_room` */

DROP TABLE IF EXISTS `co_room`;

CREATE TABLE `co_room` (
  `room_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `ward_id` int(11) NOT NULL,
  `bed_name` varchar(50) NOT NULL,
  `maintain_id` int(11) NOT NULL,
  `occupied_status` enum('0','1') DEFAULT '0',
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
  CONSTRAINT `FK_co_room_maintenance` FOREIGN KEY (`maintain_id`) REFERENCES `co_room_maintenance` (`maintain_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_co_room_ward` FOREIGN KEY (`ward_id`) REFERENCES `co_ward` (`ward_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `co_room` */

insert  into `co_room`(`room_id`,`tenant_id`,`ward_id`,`bed_name`,`maintain_id`,`occupied_status`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,4,'121',1,'1','1',1,'2016-01-18 16:21:53',1,'2016-02-05 11:31:08','0000-00-00 00:00:00'),(2,18,4,'122',1,'1','1',1,'2016-01-18 16:50:57',1,'2016-02-05 13:13:41','0000-00-00 00:00:00'),(3,18,4,'125',1,'1','1',1,'2016-02-02 15:51:20',1,'2016-02-08 10:41:55','0000-00-00 00:00:00'),(4,18,4,'129',1,'1','1',1,'2016-02-05 12:36:04',1,'2016-02-05 12:40:02','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_charge` */

insert  into `co_room_charge`(`charge_id`,`tenant_id`,`charge_item_id`,`room_type_id`,`charge`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,2,1,'500.00','1',1,'2016-01-11 11:40:57',1,'2016-01-11 12:16:20','2016-01-11 12:17:31'),(2,18,2,1,'500.00','1',1,'2016-01-11 12:17:48',1,'2016-01-30 16:44:43','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_charge_category` */

insert  into `co_room_charge_category`(`charge_cat_id`,`tenant_id`,`charge_cat_name`,`charge_cat_code`,`charge_cat_description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,NULL,'Procedures','PRC','Procedures','1',1,'2016-01-28 15:34:22',NULL,NULL,'0000-00-00 00:00:00'),(2,NULL,'Allied Charges','ALC','Allied Charges','1',1,'2016-01-28 15:35:12',NULL,NULL,'0000-00-00 00:00:00'),(3,18,'asdsad',NULL,'asdsad','1',1,'2016-02-08 10:36:48',1,'2016-02-08 10:36:48','0000-00-00 00:00:00'),(4,18,'asdsdas',NULL,'asdsdas','1',1,'2016-02-08 10:37:13',1,'2016-02-08 10:37:13','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_charge_item` */

insert  into `co_room_charge_item`(`charge_item_id`,`tenant_id`,`charge_item_name`,`charge_item_code`,`charge_item_description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'teete','',NULL,'1',1,'2016-01-09 20:19:04',NULL,'2016-01-09 20:29:44','2016-01-09 20:32:07'),(2,18,'DMO','DM','DMO','1',1,'2016-01-09 20:29:29',1,'2016-01-11 15:15:15','0000-00-00 00:00:00'),(3,18,'NURSING CHARGE','','','1',1,'2016-01-11 15:50:23',1,'2016-01-11 15:50:23','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_charge_subcategory` */

insert  into `co_room_charge_subcategory`(`charge_subcat_id`,`tenant_id`,`charge_cat_id`,`charge_subcat_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (28,18,2,'ATEST1','1',1,'2016-01-28 15:47:23',1,'2016-02-03 15:29:36','0000-00-00 00:00:00'),(29,18,2,'CANTEEN CHARGES','1',1,'2016-01-28 15:47:25',1,'2016-01-28 15:47:25','0000-00-00 00:00:00'),(30,18,2,'AIRBED CHARGES','1',1,'2016-01-28 15:47:27',1,'2016-01-28 15:47:27','0000-00-00 00:00:00'),(31,18,1,'Stomach Wash','1',1,'2016-01-28 18:19:23',1,'2016-02-03 16:01:45','0000-00-00 00:00:00'),(32,18,1,'Aversion','1',1,'2016-01-28 18:19:48',1,'2016-01-28 18:19:48','0000-00-00 00:00:00'),(33,18,2,'aaaaa','1',1,'2016-02-03 15:09:12',1,'2016-02-03 15:09:12','0000-00-00 00:00:00'),(34,18,2,'asdasdasd','0',1,'2016-02-03 15:14:15',NULL,'2016-02-03 15:40:36','0000-00-00 00:00:00'),(35,18,2,'test test','1',1,'2016-02-03 15:31:55',1,'2016-02-03 15:31:55','2016-02-03 15:33:49'),(36,18,1,'aaaa 111','1',1,'2016-02-03 16:08:12',1,'2016-02-03 16:09:10','2016-02-03 16:09:16'),(37,18,3,'tetss','1',1,'2016-02-08 10:36:49',1,'2016-02-08 10:36:49','0000-00-00 00:00:00'),(38,18,4,'adasdasd','1',1,'2016-02-08 10:37:14',1,'2016-02-08 10:37:14','0000-00-00 00:00:00'),(39,18,2,'aaadddd','1',1,'2016-02-08 15:29:55',1,'2016-02-08 15:29:55','0000-00-00 00:00:00'),(40,18,1,'aaa vvvv','1',1,'2016-02-08 15:30:11',1,'2016-02-08 15:30:11','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_maintenance` */

insert  into `co_room_maintenance`(`maintain_id`,`tenant_id`,`maintain_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'Cleaning','1',1,'2016-01-18 16:21:33',1,'2016-01-18 16:21:33','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_type` */

insert  into `co_room_type`(`room_type_id`,`tenant_id`,`room_type_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'AC','1',1,'2016-01-11 10:46:47',1,'2016-01-11 10:46:47','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_types_rooms` */

insert  into `co_room_types_rooms`(`room_type_room_id`,`tenant_id`,`room_type_id`,`room_id`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,18,1,1,1,'2016-01-18 16:50:30',1,'2016-01-18 16:50:30'),(2,18,1,2,1,'2016-01-18 16:51:07',1,'2016-01-18 16:51:07'),(3,18,1,3,1,'2016-02-02 15:51:54',1,'2016-02-02 15:51:54'),(4,18,1,4,1,'2016-02-05 12:36:42',1,'2016-02-05 12:36:42');

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
  KEY `co_speciality_tenant` (`tenant_id`),
  CONSTRAINT `FK_co_speciality_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `co_speciality` */

insert  into `co_speciality`(`speciality_id`,`tenant_id`,`speciality_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'Test','1',1,'2016-01-12 13:00:01',1,'2016-01-12 13:00:01','0000-00-00 00:00:00');

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

insert  into `co_super_admin`(`su_id`,`username`,`password`,`authtoken`,`last_activity`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,'demo','$2y$13$pfNu2lorSgd3btV7foqp.uriRfXF.7lSi51b45oefB0V1NaObxEui','ZGVtbzE0NTQ3MzM3MzY1MDM5','0000-00-00 00:00:00',NULL,'0000-00-00 00:00:00',-1,'2016-01-07 11:46:28');

/*Table structure for table `co_tenant` */

DROP TABLE IF EXISTS `co_tenant`;

CREATE TABLE `co_tenant` (
  `tenant_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_guid` varchar(50) NOT NULL,
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
  `slug` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`tenant_id`),
  UNIQUE KEY `TenantNameUnique` (`tenant_name`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

/*Data for the table `co_tenant` */

insert  into `co_tenant`(`tenant_id`,`tenant_guid`,`tenant_name`,`tenant_address`,`tenant_city_id`,`tenant_state_id`,`tenant_country_id`,`tenant_contact1`,`tenant_contact2`,`tenant_fax`,`tenant_mobile`,`tenant_email`,`tenant_url`,`slug`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,'','Ahana Hospitals','No.11 Subraman Street,Gandhi Nagar',NULL,NULL,NULL,'0452-253444','','0452253311','9677725588','','','','1',0,'2015-12-24 16:13:39',NULL,'2016-02-03 10:29:56','0000-00-00 00:00:00'),(2,'','Radianz','611 K.K. Nagar',NULL,NULL,NULL,'','','','','','','','1',0,'2015-12-24 16:13:39',NULL,NULL,'0000-00-00 00:00:00'),(3,'','Acute Care','Development',NULL,NULL,NULL,'Development','Development','Development','Development','Development@dev.org','','','1',0,'2015-12-24 16:13:39',NULL,NULL,'0000-00-00 00:00:00'),(4,'','CMACS','CMACS',NULL,NULL,NULL,'CMACS','CMACS','CMACS','CMACS','CMACS@CMACS.com','','','1',0,'2015-12-24 16:13:39',NULL,NULL,'0000-00-00 00:00:00'),(5,'','Bodhi','No,1 Ayathampatti Village,Alagarkoil,Melur(TK)',NULL,NULL,NULL,'0452 3202014','9500969661','','9629911352','info@msctrust.org','','','1',0,'2015-12-24 16:13:39',NULL,NULL,'0000-00-00 00:00:00'),(6,'','ArkTestOrg','test',NULL,NULL,NULL,'12121212','12121211','1212121','3232323232','arktest@gmail.com','','','1',0,'2015-12-24 16:13:39',NULL,NULL,'0000-00-00 00:00:00'),(13,'','asdd','asdasd',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-28 18:50:12',NULL,NULL,'0000-00-00 00:00:00'),(14,'','test','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-28 18:50:36',NULL,NULL,'0000-00-00 00:00:00'),(18,'','Org','Hi asasdasdasdasdasd',2,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-29 12:40:14',-1,'2016-01-07 16:25:27','0000-00-00 00:00:00'),(19,'','Orge','asdsd',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-29 13:27:21',NULL,NULL,'0000-00-00 00:00:00'),(23,'','New Orrr','asdasd',3,2,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-30 17:04:13',NULL,NULL,'0000-00-00 00:00:00'),(24,'','Testaaaaa','asdsad',1,1,1,'adasd','asdasd','12321321','3213213','test@test.com','http://asdas.com','','1',0,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(25,'','Testaaaaawewew','asdsad',1,1,1,'adasd','asdasd','12321321','3213213','test@test.com','http://asdas.com','','1',0,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(26,'','sfsdfsfd','asdsad',1,1,1,'adasd','asdasd','12321321','3213213','test@test.com','http://asdas.com','','1',0,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(27,'','sfsdfsfdsfdsf','asdsad',1,1,1,'adasd','asdasd','12321321','3213213','test@test.com','http://asdas.com','','1',0,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(28,'','sfsdfsfdsfdsfddf','asdsad',1,1,1,'adasd','asdasd','12321321','3213213','test@test.com','http://asdas.com','','1',0,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(29,'','sdfsdf','sdfsdf',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-30 20:43:29',NULL,NULL,'0000-00-00 00:00:00'),(30,'','sdfsdfs','sdfsdfsdf',2,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-30 20:50:21',NULL,NULL,'0000-00-00 00:00:00'),(32,'','Teest','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-31 19:28:41',NULL,NULL,'0000-00-00 00:00:00'),(33,'','Testttt','test',1,1,1,'test','test',NULL,NULL,NULL,NULL,'','1',0,'2016-01-02 15:07:36',NULL,NULL,'0000-00-00 00:00:00'),(34,'','test111','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2016-01-02 15:52:34',NULL,NULL,'0000-00-00 00:00:00'),(35,'','yrsd','asddasd',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','0',0,'2016-01-02 16:03:11',NULL,'2016-01-21 19:59:28','0000-00-00 00:00:00'),(36,'','asdasd','adasdasd',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2016-01-02 18:20:36',NULL,NULL,'0000-00-00 00:00:00'),(37,'','test 123123','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2016-01-02 19:16:51',NULL,NULL,'0000-00-00 00:00:00'),(38,'','asdsd','asdsad',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-07 12:15:40',-1,'2016-01-07 12:15:40','0000-00-00 00:00:00'),(39,'','testaaa','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-07 16:00:58',-1,'2016-01-07 16:00:58','0000-00-00 00:00:00'),(40,'','testaaasss','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-07 16:03:32',-1,'2016-01-07 16:03:32','0000-00-00 00:00:00'),(41,'','testaaasssasdad','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-07 16:09:29',-1,'2016-01-07 16:09:29','0000-00-00 00:00:00'),(42,'','testaaasssaaaasdad','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-07 16:11:00',-1,'2016-01-07 16:11:00','0000-00-00 00:00:00'),(43,'','testaaasssaaaasdaddsad','test',1,1,1,'12323123',NULL,NULL,NULL,'test@ete.com',NULL,'','1',-1,'2016-01-07 16:12:48',-1,'2016-02-03 11:05:26','0000-00-00 00:00:00'),(44,'','New Organization 111','New',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-18 12:49:52',-1,'2016-01-18 16:17:15','0000-00-00 00:00:00');

/*Table structure for table `co_user` */

DROP TABLE IF EXISTS `co_user`;

CREATE TABLE `co_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
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
  KEY `FK_co_user_profile_tenant` (`tenant_id`),
  CONSTRAINT `FK_co_user_profile_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

/*Data for the table `co_user` */

insert  into `co_user`(`user_id`,`tenant_id`,`title_code`,`name`,`designation`,`address`,`city_id`,`state_id`,`zip`,`country_id`,`contact1`,`contact2`,`mobile`,`email`,`speciality_id`,`care_provider`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'Mr.','Test Oregaaa','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12323123','test@test.com',NULL,'0','1',-1,'2015-12-29 12:40:14',1,'2016-01-08 11:07:01','0000-00-00 00:00:00'),(2,19,'Mr.','test','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'test','test',NULL,'0','1',-1,'2015-12-29 13:27:22',NULL,NULL,'0000-00-00 00:00:00'),(6,23,'Mr.','asdsd','dasdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1233123','test@test.com',NULL,'0','1',-1,'2015-12-30 17:04:13',NULL,NULL,'0000-00-00 00:00:00'),(7,24,'Mr.','test','test','23123123',1,1,'625020',1,'321323','23123','123123','test@test.com',NULL,'0','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(8,25,'Mr.','test','test','23123123',1,1,'625020',1,'321323','23123','123123','test@test.com',NULL,'0','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(9,26,'Mr.','test','test','23123123',1,1,'625020',1,'321323','23123','123123','test@test.com',NULL,'0','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(10,27,'Mr.','test','test','23123123',1,1,'625020',1,'321323','23123','123123','test@test.com',NULL,'0','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(11,28,'Mr.','test','test','23123123',1,1,'625020',1,'321323','23123','123123','test@test.com',NULL,'0','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(12,29,'Mr.','sdfsfd','sfdsf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'11111111','test@t.com',NULL,'0','1',-1,'2015-12-30 20:43:29',NULL,NULL,'0000-00-00 00:00:00'),(13,30,'Mrs.','sdfsdf','sfdsf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'f111111','test@te.com',NULL,'0','1',-1,'2015-12-30 20:50:21',NULL,NULL,'0000-00-00 00:00:00'),(15,32,'Mr.','rwar','asdsdsd',NULL,NULL,NULL,NULL,1,'asdasda','sdasd','asdasd','test@test.com',NULL,'0','1',-1,'2015-12-31 19:28:41',NULL,NULL,'0000-00-00 00:00:00'),(16,33,'Mr.','asdasd','asdsadsd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12323212','ts2test@tt.com',NULL,'0','1',-1,'2016-01-02 15:07:36',NULL,NULL,'0000-00-00 00:00:00'),(17,34,'Mr.','tess','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'test','test@test.com',NULL,'0','1',-1,'2016-01-02 15:52:34',NULL,NULL,'0000-00-00 00:00:00'),(18,18,'Mrs.','asda','sdasd',NULL,1,1,NULL,1,NULL,NULL,'asdasd','test@test.com',NULL,'0','1',-1,'2016-01-02 16:03:11',1,'2016-01-08 12:59:19','0000-00-00 00:00:00'),(19,36,'Mr.','test','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'123213','tasd@gmail.com',NULL,'0','1',-1,'2016-01-02 18:20:37',NULL,NULL,'0000-00-00 00:00:00'),(20,37,'Mr.','test','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'23123123','test@test.com',NULL,'0','1',-1,'2016-01-02 19:16:52',NULL,NULL,'0000-00-00 00:00:00'),(21,38,'Mr.','test','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'test','test@test.com',NULL,'0','1',0,'2016-01-07 12:15:40',NULL,NULL,'0000-00-00 00:00:00'),(22,39,'Mr.','asdsad','adsdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a123123','asdas@asdasd.com',NULL,'0','1',0,'2016-01-07 16:00:58',NULL,NULL,'0000-00-00 00:00:00'),(23,40,'Mr.','asdsad','adsdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a123123','asdas@asdasd.com',NULL,'0','1',0,'2016-01-07 16:03:32',NULL,NULL,'0000-00-00 00:00:00'),(24,41,'Mr.','asdsad','adsdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a123123','asdas@asdasd.com',NULL,'0','1',0,'2016-01-07 16:09:29',NULL,NULL,'0000-00-00 00:00:00'),(25,42,'Mr.','asdsad','adsdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a123123','asdas@asdasd.com',NULL,'0','1',-1,'2016-01-07 16:11:00',-1,'2016-01-07 16:11:00','0000-00-00 00:00:00'),(26,43,'Mr.','asdsad','adsdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a123123','asdas@asdasd.com',NULL,'0','1',-1,'2016-01-07 16:12:48',-1,'2016-01-07 16:12:48','0000-00-00 00:00:00'),(27,18,'Mr.','Doctor 2','test',NULL,2,1,NULL,1,NULL,NULL,'12323123','test@test.com',NULL,'1','1',1,'2016-01-08 10:36:38',1,'2016-01-08 12:59:38','0000-00-00 00:00:00'),(28,18,'Mrs.','Doctor 1','asdasd','test',1,1,'625002',1,NULL,NULL,'123213','sdasd@asdas.comn',1,'1','1',1,'2016-01-08 17:43:52',1,'2016-02-06 12:53:26','0000-00-00 00:00:00'),(29,44,'Mr.','Rajesh','Admin',NULL,1,1,'625002',1,'9561515415','5541521541','52655626','admin@admin.com',NULL,'0','1',-1,'2016-01-18 12:49:52',-1,'2016-01-18 16:17:38','0000-00-00 00:00:00');

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
  CONSTRAINT `FK_co_user_roles_role` FOREIGN KEY (`role_id`) REFERENCES `co_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_co_user_roles_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

/*Data for the table `co_users_roles` */

insert  into `co_users_roles`(`user_role_id`,`tenant_id`,`user_id`,`role_id`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,18,1,1,1,'2015-12-30 16:07:24',NULL,NULL),(3,23,6,6,0,'2015-12-30 17:04:15',NULL,NULL),(4,24,7,7,-1,'2015-12-30 20:29:03',NULL,NULL),(5,25,8,8,-1,'2015-12-30 20:39:55',NULL,NULL),(6,26,9,9,-1,'2015-12-30 20:40:45',NULL,NULL),(7,27,10,10,-1,'2015-12-30 20:41:39',NULL,NULL),(8,28,11,11,-1,'2015-12-30 20:42:29',NULL,NULL),(9,29,12,12,-1,'2015-12-30 20:43:31',NULL,NULL),(10,30,13,13,-1,'2015-12-30 20:50:23',NULL,NULL),(12,32,15,15,-1,'2015-12-31 19:28:42',NULL,NULL),(13,33,16,16,-1,'2016-01-02 15:07:37',NULL,NULL),(14,34,17,17,-1,'2016-01-02 15:52:35',NULL,NULL),(15,35,18,18,-1,'2016-01-02 16:03:13',NULL,NULL),(16,36,19,19,-1,'2016-01-02 18:20:39',NULL,NULL),(17,37,20,20,-1,'2016-01-02 19:16:53',NULL,NULL),(18,38,21,21,-1,'2016-01-07 12:15:40',NULL,NULL),(19,39,22,26,-1,'2016-01-07 16:00:58',NULL,NULL),(20,40,23,27,-1,'2016-01-07 16:03:33',NULL,NULL),(21,41,24,28,-1,'2016-01-07 16:09:30',NULL,NULL),(22,42,25,29,-1,'2016-01-07 16:11:01',NULL,NULL),(23,43,26,30,-1,'2016-01-07 16:12:48',NULL,NULL),(26,18,1,22,1,'2016-01-08 19:16:22',NULL,NULL),(28,18,18,1,1,'2016-01-08 19:57:42',NULL,NULL),(29,18,18,22,1,'2016-01-08 19:57:43',NULL,NULL),(30,18,1,31,1,'2016-01-09 10:43:47',NULL,NULL),(32,18,27,1,0,'2016-01-09 10:46:36',1,'2016-01-09 10:46:36'),(33,18,27,31,0,'2016-01-09 10:46:36',1,'2016-01-09 10:46:36'),(34,18,27,25,0,'2016-01-09 10:46:36',1,'2016-01-09 10:46:36'),(35,18,28,1,0,'2016-01-09 10:48:02',1,'2016-01-09 10:48:02'),(36,18,28,22,0,'2016-01-09 10:48:02',1,'2016-01-09 10:48:02'),(37,18,27,23,0,'2016-01-09 11:00:27',1,'2016-01-09 11:00:27'),(38,18,18,23,0,'2016-01-13 10:35:06',1,'2016-01-13 10:35:06'),(39,44,29,33,-1,'2016-01-18 12:49:52',NULL,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `co_ward` */

insert  into `co_ward`(`ward_id`,`tenant_id`,`floor_id`,`ward_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,2,'Test 111','1',1,'2016-01-09 17:00:19',1,'2016-01-09 17:00:33','2016-01-09 17:00:41'),(2,18,3,'Test','1',1,'2016-01-09 17:15:17',NULL,'2016-01-09 20:52:26','2016-01-18 16:20:40'),(4,18,5,'test123','1',1,'2016-01-18 16:20:58',1,'2016-01-18 17:51:06','0000-00-00 00:00:00'),(5,18,6,'aaaa','1',1,'2016-01-18 17:51:18',1,'2016-01-18 17:51:18','0000-00-00 00:00:00'),(11,18,6,'aaaa2','1',1,'2016-02-06 12:58:54',1,'2016-02-06 12:59:00','0000-00-00 00:00:00'),(14,18,5,'aaaa2','1',1,'2016-02-06 13:02:53',1,'2016-02-06 13:02:53','0000-00-00 00:00:00');

/*Table structure for table `pat_admission` */

DROP TABLE IF EXISTS `pat_admission`;

CREATE TABLE `pat_admission` (
  `admn_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `status_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

/*Data for the table `pat_admission` */

insert  into `pat_admission`(`admn_id`,`tenant_id`,`patient_id`,`encounter_id`,`status_date`,`consultant_id`,`floor_id`,`ward_id`,`room_id`,`room_type_id`,`admission_status`,`status`,`notes`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (23,18,5,7,'2016-02-04 13:28:12',27,5,4,1,1,'A','1',NULL,1,'2016-02-04 13:28:27',1,'2016-02-04 13:28:27','0000-00-00 00:00:00'),(24,18,5,7,'2016-02-04 13:38:14',28,5,4,1,1,'TD','1',NULL,1,'2016-02-04 13:39:56',1,'2016-02-04 13:39:56','0000-00-00 00:00:00'),(25,18,6,8,'2016-02-04 13:55:45',27,5,4,2,1,'A','1',NULL,1,'2016-02-04 13:55:59',1,'2016-02-04 13:55:59','0000-00-00 00:00:00'),(26,18,5,7,'2016-02-05 11:30:50',28,5,4,1,1,'D','1',NULL,1,'2016-02-05 11:31:08',1,'2016-02-05 11:31:08','0000-00-00 00:00:00'),(27,18,5,10,'2016-02-05 12:16:21',27,5,4,3,1,'A','1',NULL,1,'2016-02-05 12:19:47',1,'2016-02-05 12:19:47','0000-00-00 00:00:00'),(28,18,5,10,'2016-02-05 12:34:58',28,5,4,3,1,'TD','1',NULL,1,'2016-02-05 12:35:04',1,'2016-02-05 12:35:04','0000-00-00 00:00:00'),(29,18,5,10,'2016-02-05 12:36:54',28,5,4,4,1,'TR','1',NULL,1,'2016-02-05 12:37:04',1,'2016-02-05 12:37:04','0000-00-00 00:00:00'),(30,18,5,10,'2016-02-05 12:39:57',28,5,4,2,1,'TR','1',NULL,1,'2016-02-05 12:40:02',1,'2016-02-05 12:40:02','0000-00-00 00:00:00'),(31,18,6,8,'2016-02-05 12:39:57',27,5,4,4,1,'TR','1',NULL,1,'2016-02-05 12:40:02',1,'2016-02-05 12:40:02','0000-00-00 00:00:00'),(32,18,5,10,'2016-02-05 13:13:34',28,5,4,2,1,'D','1',NULL,1,'2016-02-05 13:13:41',1,'2016-02-05 13:13:41','0000-00-00 00:00:00'),(33,18,5,12,'2016-02-05 18:30:26',27,5,4,3,1,'A','1',NULL,1,'2016-02-05 18:30:34',1,'2016-02-05 18:30:34','0000-00-00 00:00:00'),(34,18,5,12,'2016-02-08 10:41:45',28,5,4,3,1,'TD','1',NULL,1,'2016-02-08 10:41:55',1,'2016-02-08 10:41:55','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `pat_appointment` */

insert  into `pat_appointment`(`appt_id`,`tenant_id`,`patient_id`,`encounter_id`,`status_date`,`status_time`,`consultant_id`,`appt_status`,`status`,`amount`,`notes`,`patient_cat_id`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,5,9,'2016-02-05','01:05:00',28,'B','1','0.00',NULL,NULL,1,'2016-02-05 11:34:09',1,'2016-02-05 11:34:09','0000-00-00 00:00:00'),(2,18,5,9,'2016-02-05','01:05:00',28,'A','1','0.00',NULL,NULL,1,'2016-02-05 11:34:09',1,'2016-02-05 11:34:09','0000-00-00 00:00:00'),(3,18,5,9,'2016-02-03','02:10:00',28,'S','1','100.00',NULL,NULL,1,'2016-02-05 12:13:17',1,'2016-02-05 12:13:17','0000-00-00 00:00:00'),(4,18,5,11,'2016-02-05','01:00:00',28,'B','1','0.00',NULL,NULL,1,'2016-02-05 13:14:34',1,'2016-02-05 13:14:34','0000-00-00 00:00:00'),(5,18,5,11,'2016-02-05','01:00:00',28,'A','1','0.00',NULL,NULL,1,'2016-02-05 13:14:34',1,'2016-02-05 13:14:34','0000-00-00 00:00:00'),(6,18,5,11,'2016-02-03','06:30:00',28,'S','1','60.00',NULL,NULL,1,'2016-02-05 18:15:21',1,'2016-02-05 18:15:21','0000-00-00 00:00:00');

/*Table structure for table `pat_consultant` */

DROP TABLE IF EXISTS `pat_consultant`;

CREATE TABLE `pat_consultant` (
  `pat_consult_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `consultant_id` int(11) NOT NULL,
  `consult_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  CONSTRAINT `FK_pat_consultant_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_consultant_user` FOREIGN KEY (`consultant_id`) REFERENCES `co_user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `pat_consultant` */

insert  into `pat_consultant`(`pat_consult_id`,`tenant_id`,`encounter_id`,`patient_id`,`consultant_id`,`consult_date`,`notes`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,7,5,28,'2016-02-04 18:16:35','test','1',1,'2016-02-04 15:56:15',1,'2016-02-04 16:35:09','2016-02-04 18:16:35'),(2,18,12,5,27,'2016-02-03 02:10:00','test test','1',1,'2016-02-06 15:31:11',1,'2016-02-06 15:31:11','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `pat_encounter` */

insert  into `pat_encounter`(`encounter_id`,`tenant_id`,`patient_id`,`encounter_type`,`encounter_date`,`inactive_date`,`finalize`,`authorize`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (7,18,5,'IP','2016-02-04 13:28:12',NULL,0,0,'0',1,'2016-02-04 13:28:27',1,'2016-02-05 11:31:08','0000-00-00 00:00:00'),(8,18,6,'IP','2016-02-04 13:55:45',NULL,0,0,'1',1,'2016-02-04 13:55:59',1,'2016-02-04 13:55:59','0000-00-00 00:00:00'),(9,18,5,'OP','2016-02-05 00:00:00',NULL,0,0,'0',1,'2016-02-05 11:34:09',1,'2016-02-05 12:13:17','0000-00-00 00:00:00'),(10,18,5,'IP','2016-02-05 12:16:21',NULL,0,0,'0',1,'2016-02-05 12:19:47',1,'2016-02-05 13:13:41','0000-00-00 00:00:00'),(11,18,5,'OP','2016-02-05 00:00:00',NULL,0,0,'0',1,'2016-02-05 13:14:34',1,'2016-02-05 18:15:21','0000-00-00 00:00:00'),(12,18,5,'IP','2016-02-05 18:30:26',NULL,0,0,'1',1,'2016-02-05 18:30:34',1,'2016-02-05 18:30:34','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `pat_notes` */

insert  into `pat_notes`(`pat_note_id`,`tenant_id`,`encounter_id`,`patient_id`,`notes`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,11,5,'Hi','1',1,'2016-02-05 16:02:56',1,'2016-02-05 16:02:56','0000-00-00 00:00:00');

/*Table structure for table `pat_patient` */

DROP TABLE IF EXISTS `pat_patient`;

CREATE TABLE `pat_patient` (
  `patient_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_guid` varchar(32) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `pat_patient` */

insert  into `pat_patient`(`patient_id`,`patient_guid`,`casesheetno`,`patient_int_code`,`tenant_id`,`patient_reg_date`,`patient_title_code`,`patient_firstname`,`patient_lastname`,`patient_relation_code`,`patient_relation_name`,`patient_care_taker`,`patient_care_taker_name`,`patient_dob`,`patient_gender`,`patient_marital_status`,`patient_occupation`,`patient_blood_group`,`patient_category_id`,`patient_email`,`patient_reg_mode`,`patient_type`,`patient_ref_hospital`,`patient_ref_id`,`patient_mobile`,`patient_bill_type`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (5,'efca45b2-6ef3-5c87-8169-de33af43',NULL,'PAT0000001',18,'2016-02-04 07:51:01','Mr.','Prakash arul mani','Paramanandam',NULL,NULL,NULL,NULL,'1990-07-31','M','S',NULL,NULL,1,NULL,'NO',NULL,NULL,NULL,'9566699580','N','1',1,'2016-02-04 12:21:01',1,'2016-02-08 10:40:07','0000-00-00 00:00:00'),(6,'0029a7d6-6a11-56c4-82e0-e5b8a3bd',NULL,'PAT0000002',18,'2016-02-04 09:14:13','Mr.','Nadesh','Subramanian',NULL,NULL,NULL,NULL,'1990-02-28','M',NULL,NULL,NULL,1,NULL,'IP',NULL,NULL,NULL,'9894622733',NULL,'1',1,'2016-02-04 13:44:13',1,'2016-02-06 16:00:55','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `pat_patient_address` */

insert  into `pat_patient_address`(`addr_id`,`patient_id`,`addr_current_address`,`addr_country_id`,`addr_state_id`,`addr_city_id`,`addr_zip`,`addr_perm_address`,`addr_perm_country_id`,`addr_perm_state_id`,`addr_perm_city_id`,`addr_perm_zip`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (6,5,'aa dddd aasdasdasd ddddaa',1,1,2,'625002','aa dddd aasdasdasd ddddaa',1,1,2,'625002',1,'2016-02-04 12:21:02',1,'2016-02-08 10:40:07','0000-00-00 00:00:00'),(7,6,NULL,1,1,1,NULL,NULL,1,1,2,NULL,1,'2016-02-04 13:44:13',1,'2016-02-06 16:00:55','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `pat_procedure` */

insert  into `pat_procedure`(`proc_id`,`tenant_id`,`encounter_id`,`patient_id`,`charge_subcat_id`,`proc_date`,`proc_consultant_ids`,`proc_description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,11,5,31,'2016-02-05 21:25:00','[27,28]','aaaaa','1',1,'2016-02-05 16:41:35',1,'2016-02-05 16:50:51','0000-00-00 00:00:00'),(2,18,11,5,32,'2016-02-05 00:00:00','[27]','aaaaa','1',1,'2016-02-05 16:43:15',1,'2016-02-05 16:43:15','0000-00-00 00:00:00'),(3,18,11,5,31,'2016-02-05 00:00:00','[27,28]','aad asdasdsd','1',1,'2016-02-05 16:44:04',1,'2016-02-05 16:44:04','0000-00-00 00:00:00'),(4,18,12,5,31,'2016-02-05 18:32:22','[27]','test test123123','1',1,'2016-02-05 18:32:32',1,'2016-02-05 18:33:11','2016-02-05 18:33:19');

/*Table structure for table `v_encounter` */

DROP TABLE IF EXISTS `v_encounter`;

/*!50001 DROP VIEW IF EXISTS `v_encounter` */;
/*!50001 DROP TABLE IF EXISTS `v_encounter` */;

/*!50001 CREATE TABLE  `v_encounter`(
 `id` int(11) ,
 `encounter_id` int(11) ,
 `date` varchar(10) ,
 `type` varchar(17) ,
 `details` varchar(214) ,
 `doctor` varchar(60) ,
 `patient_id` int(11) ,
 `patient_guid` varchar(32) ,
 `encounter_type` varchar(5) ,
 `status` varchar(1) ,
 `date_time` datetime 
)*/;

/*View structure for view v_encounter */

/*!50001 DROP TABLE IF EXISTS `v_encounter` */;
/*!50001 DROP VIEW IF EXISTS `v_encounter` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_encounter` AS select `a`.`appt_id` AS `id`,`c`.`encounter_id` AS `encounter_id`,date_format(`a`.`status_date`,'%Y-%m-%d') AS `date`,(case `a`.`appt_status` when 'B' then 'Booked' when 'A' then 'Arived' when 'S' then 'Seen' else NULL end) AS `type`,'\nOP' AS `details`,concat(`b`.`title_code`,`b`.`name`) AS `doctor`,`c`.`patient_id` AS `patient_id`,`d`.`patient_guid` AS `patient_guid`,`c`.`encounter_type` AS `encounter_type`,`c`.`status` AS `status`,`a`.`status_date` AS `date_time` from (((`pat_appointment` `a` join `co_user` `b` on((`b`.`user_id` = `a`.`consultant_id`))) join `pat_encounter` `c` on((`c`.`encounter_id` = `a`.`encounter_id`))) join `pat_patient` `d` on((`d`.`patient_id` = `c`.`patient_id`))) union all select `a`.`admn_id` AS `id`,`c`.`encounter_id` AS `encounter_id`,date_format(`a`.`status_date`,'%Y-%m-%d') AS `date`,(case `a`.`admission_status` when 'A' then 'Admission' when 'D' then 'Discharge' when 'TR' then 'Transfer (Room)' when 'TD' then 'Transfer (Doctor)' else NULL end) AS `type`,concat('IP: ',`d`.`floor_name`,' > ',`e`.`ward_name`,' > ',`f`.`bed_name`,'  (',`g`.`room_type_name`,')') AS `details`,concat(`b`.`title_code`,`b`.`name`) AS `doctor`,`c`.`patient_id` AS `patient_id`,`h`.`patient_guid` AS `patient_guid`,`c`.`encounter_type` AS `encounter_type`,`c`.`status` AS `status`,`a`.`status_date` AS `date_time` from (((((((`pat_admission` `a` join `co_user` `b` on((`b`.`user_id` = `a`.`consultant_id`))) join `pat_encounter` `c` on((`c`.`encounter_id` = `a`.`encounter_id`))) left join `co_floor` `d` on((`d`.`floor_id` = `a`.`floor_id`))) left join `co_ward` `e` on((`e`.`ward_id` = `a`.`ward_id`))) left join `co_room` `f` on((`f`.`room_id` = `a`.`room_id`))) left join `co_room_type` `g` on((`g`.`room_type_id` = `a`.`room_type_id`))) join `pat_patient` `h` on((`h`.`patient_id` = `c`.`patient_id`))) order by `encounter_id` desc,`date_time` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
