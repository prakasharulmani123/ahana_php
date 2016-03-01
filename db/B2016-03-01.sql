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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `co_charge_per_category` */

insert  into `co_charge_per_category`(`charge_id`,`tenant_id`,`charge_cat_type`,`charge_cat_id`,`charge_code_id`,`charge_default`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (6,18,'C',14,1,NULL,'2016-01-22 12:59:35',1,'2016-01-22 12:59:35',1,'0000-00-00 00:00:00'),(7,18,'C',14,2,NULL,'2016-01-22 13:02:55',1,'2016-01-22 13:02:55',1,'0000-00-00 00:00:00'),(8,18,'P',-1,28,'100','2016-02-18 11:14:22',1,'2016-02-18 11:14:22',1,'0000-00-00 00:00:00'),(9,18,'P',-1,27,'100','2016-02-18 15:33:43',1,'2016-02-18 15:33:43',1,'0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

/*Data for the table `co_charge_per_subcategory` */

insert  into `co_charge_per_subcategory`(`sub_charge_id`,`charge_id`,`charge_type`,`charge_link_id`,`charge_amount`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (3,6,'OP',1,'100.00','2016-01-22 12:59:36',1,'2016-01-22 13:02:31',1,'0000-00-00 00:00:00'),(4,6,'OP',2,'200.00','2016-01-22 12:59:36',1,'2016-01-22 12:59:36',1,'0000-00-00 00:00:00'),(5,6,'OP',3,'300.00','2016-01-22 12:59:36',1,'2016-01-22 13:02:33',1,'0000-00-00 00:00:00'),(6,6,'OP',4,'899.00','2016-01-22 12:59:36',1,'2016-02-11 15:26:50',1,'0000-00-00 00:00:00'),(7,6,'IP',1,'500.00','2016-01-22 12:59:36',1,'2016-01-22 13:02:29',1,'0000-00-00 00:00:00'),(8,7,'OP',1,'100.00','2016-01-22 13:02:55',1,'2016-01-22 13:02:55',1,'0000-00-00 00:00:00'),(9,7,'OP',2,'200.00','2016-01-22 13:02:55',1,'2016-01-22 13:02:55',1,'0000-00-00 00:00:00'),(10,7,'OP',3,'300.00','2016-01-22 13:02:55',1,'2016-01-22 13:02:55',1,'0000-00-00 00:00:00'),(11,7,'OP',4,'400.00','2016-01-22 13:02:56',1,'2016-01-22 13:02:56',1,'0000-00-00 00:00:00'),(12,7,'IP',1,'600.00','2016-01-22 13:02:56',1,'2016-01-22 13:02:56',1,'0000-00-00 00:00:00'),(13,8,'OP',1,'200.00','2016-02-18 11:14:23',1,'2016-02-18 11:14:23',1,'0000-00-00 00:00:00'),(14,8,'OP',2,'300.00','2016-02-18 11:14:23',1,'2016-02-18 11:14:23',1,'0000-00-00 00:00:00'),(15,8,'OP',3,'400.00','2016-02-18 11:14:23',1,'2016-02-18 11:14:23',1,'0000-00-00 00:00:00'),(16,8,'OP',4,'500.00','2016-02-18 11:14:23',1,'2016-02-18 11:14:23',1,'0000-00-00 00:00:00'),(17,8,'OP',5,'600.00','2016-02-18 11:14:23',1,'2016-02-18 11:14:23',1,'0000-00-00 00:00:00'),(18,8,'IP',1,'200.00','2016-02-18 11:14:23',1,'2016-02-18 11:14:23',1,'0000-00-00 00:00:00'),(19,8,'IP',2,'600.00','2016-02-18 11:14:23',1,'2016-02-18 11:14:23',1,'0000-00-00 00:00:00'),(20,9,'OP',1,'100.00','2016-02-18 15:33:44',1,'2016-02-18 15:33:44',1,'0000-00-00 00:00:00'),(21,9,'OP',2,'20.00','2016-02-18 15:33:44',1,'2016-02-18 15:33:44',1,'0000-00-00 00:00:00'),(22,9,'OP',3,'30.00','2016-02-18 15:33:44',1,'2016-02-18 15:33:44',1,'0000-00-00 00:00:00'),(23,9,'OP',4,'40.00','2016-02-18 15:33:44',1,'2016-02-18 15:33:44',1,'0000-00-00 00:00:00'),(24,9,'OP',5,'4.00','2016-02-18 15:33:44',1,'2016-02-18 15:33:44',1,'0000-00-00 00:00:00'),(25,9,'IP',1,'4.00','2016-02-18 15:33:44',1,'2016-02-18 15:33:44',1,'0000-00-00 00:00:00'),(26,9,'IP',2,'4.00','2016-02-18 15:33:44',1,'2016-02-18 15:33:44',1,'0000-00-00 00:00:00');

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

insert  into `co_doctor_schedule`(`schedule_id`,`tenant_id`,`user_id`,`schedule_day`,`schedule_time_in`,`schedule_time_out`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (1,18,28,'-1','01:00:00','01:30:00','2016-01-21 15:21:57',1,'2016-01-22 11:03:02',1,'0000-00-00 00:00:00'),(2,18,28,'-1','06:30:00','11:30:00','2016-01-21 15:22:28',1,'2016-01-21 15:22:28',1,'2016-01-21 15:22:37'),(3,18,28,'1','00:30:00','04:00:00','2016-01-21 15:22:53',1,'2016-01-21 15:22:53',1,'0000-00-00 00:00:00'),(4,18,28,'2','06:00:00','07:30:00','2016-01-21 19:11:37',1,'2016-01-21 19:11:37',1,'0000-00-00 00:00:00'),(5,18,28,'-1','00:00:00','00:30:00','2016-02-05 15:48:55',1,'2016-02-05 15:48:55',1,'0000-00-00 00:00:00'),(6,18,27,'-1','00:00:00','02:00:00','2016-02-05 15:49:12',1,'2016-02-06 16:20:52',1,'0000-00-00 00:00:00'),(7,18,27,'-1','02:00:00','02:00:00','2016-02-06 12:04:00',1,'2016-02-18 13:38:11',1,'0000-00-00 00:00:00'),(8,18,27,'-1','05:00:00','05:00:00','2016-02-06 12:04:00',1,'2016-02-06 12:04:00',1,'0000-00-00 00:00:00');

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
  KEY `FK_co_internal_code` (`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `co_internal_code` */

insert  into `co_internal_code`(`internal_code_id`,`tenant_id`,`code_type`,`code_prefix`,`code`,`code_padding`,`code_suffix`,`status`,`created_at`,`created_by`,`modified_at`,`modified_by`,`deleted_at`) values (1,18,'B','B',1,7,NULL,'1','2016-02-02 10:56:12',1,NULL,NULL,'0000-00-00 00:00:00'),(2,18,'P','PAT',3,7,NULL,'1','2016-02-04 13:44:13',1,'2016-02-04 13:44:13',1,'0000-00-00 00:00:00'),(3,46,'B','TE',1,7,NULL,'1','2016-02-16 17:18:39',-1,'2016-02-16 17:18:39',-1,'0000-00-00 00:00:00'),(4,46,'P','TE',1,7,NULL,'1','2016-02-16 17:18:39',-1,'2016-02-16 17:18:39',-1,'0000-00-00 00:00:00'),(5,47,'B','OR',1,7,NULL,'1','2016-02-16 17:47:11',-1,'2016-02-16 17:47:11',-1,'0000-00-00 00:00:00'),(6,47,'P','OR',1,7,NULL,'1','2016-02-16 17:47:11',-1,'2016-02-16 17:47:11',-1,'0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

/*Data for the table `co_login` */

insert  into `co_login`(`login_id`,`user_id`,`username`,`password`,`password_reset_token`,`authtoken`,`created_by`,`created_at`,`modified_by`,`modified_at`,`activation_date`,`Inactivation_date`,`logged_tenant_id`) values (1,1,'123123','$2y$13$f1.ldgwKkkr8GcHPoSmrou4sXjLpJTaQlGxgXnmqS0ubWJvu0/yLu',NULL,'',0,'2015-12-29 12:40:15',1,'2016-02-29 12:05:14',NULL,NULL,NULL),(2,2,'test','$2y$13$z5IIhq7WgWa.mttlXvPfU.rj7ECjwe0XO0qYotm/KGYGVLofIGW7q',NULL,NULL,-1,'2015-12-29 13:27:23',NULL,NULL,NULL,NULL,NULL),(6,6,'test','$2y$13$26z8fSgBVSaDk6dSc4tEouKnZSoYbMxq/4rBobSP/QSQfBvdvTNFW',NULL,NULL,-1,'2015-12-30 17:04:14',NULL,NULL,NULL,NULL,NULL),(7,7,'123123','$2y$13$UuCYLvsFlDJ8z4c4rQ1HjOborIk4kQSn/BUZN3o4IQXVZXh3yuqSK',NULL,NULL,-1,'2015-12-30 20:29:03',NULL,NULL,NULL,NULL,NULL),(8,8,'123123','$2y$13$43E8tZWtjPeBgmNSPyT9J.D5eaI0YzYhz6gcDIPIivUiAnfhxIdsm',NULL,NULL,-1,'2015-12-30 20:29:03',NULL,NULL,NULL,NULL,NULL),(9,9,'123123','$2y$13$1y2enmiOKrzYyjqcFwVUE.8RCejtYcGZZL4jm98Wk3wE9CCMR3Ymu',NULL,NULL,-1,'2015-12-30 20:29:03',NULL,NULL,NULL,NULL,NULL),(10,10,'123123','$2y$13$012PM43tycVN7OcYlB/0x.fdiI61LZUtIozbAxKhnWbr1IyFDBcRi',NULL,NULL,-1,'2015-12-30 20:29:03',NULL,NULL,NULL,NULL,NULL),(11,11,'123123','$2y$13$MTPatpVSg6AKyJZS0ClJcucw1aRwGnFyfTn.W2QURueLyRU6GHF3K',NULL,NULL,-1,'2015-12-30 20:29:03',NULL,NULL,NULL,NULL,NULL),(12,12,'test','$2y$13$3HYt/nfAibfzt7d.CHnDKOpmYuyMq8lFsU6ZpvAgZyfRsTvRtEZz.',NULL,NULL,-1,'2015-12-30 20:43:30',NULL,NULL,NULL,NULL,NULL),(13,13,'sdfsdf','$2y$13$eq47HcHN6RRpmsuZFScU2u23AfUZp47a2taPaTh3ZkLaoMN7c1fOC',NULL,NULL,-1,'2015-12-30 20:50:23',NULL,NULL,NULL,NULL,NULL),(15,15,'tester','$2y$13$9FPvHeqEZGuIvcifzJVs4.w5iX6ZY.ezbqQ1u0.F8l.lYrfemR/ym',NULL,NULL,-1,'2015-12-31 19:28:42',NULL,NULL,NULL,NULL,NULL),(16,16,'test','$2y$13$1.GJ18v3tsxpv/pQ4mZq6u3ShXkHIosNo.KFzIo4r3YEP.TQ83L4i',NULL,NULL,-1,'2016-01-02 15:07:37',NULL,NULL,NULL,NULL,NULL),(17,17,'test','$2y$13$Rh4dpklxDBQyC3q9JtCf2.N334ZUVjq2XDwUq7mmYpvypWCWfL8Xi',NULL,NULL,-1,'2016-01-02 15:52:35',NULL,NULL,NULL,NULL,NULL),(18,18,'test','$2y$13$38DMc9wOBSj.gMx8oFfAv.hrHH1frzKERGTY1.pSLYv6kJT61Zmr.',NULL,NULL,-1,'2016-01-02 16:03:13',NULL,NULL,NULL,NULL,NULL),(19,19,'test','$2y$13$jbSCihxnnDHl8gLkYPdteO/XtRWrKEHQnlL2l5cvh1Lj1z1W55pPS',NULL,NULL,-1,'2016-01-02 18:20:39',NULL,NULL,NULL,NULL,NULL),(20,20,'test','$2y$13$2rWaKGPs0CPD5UGgsuaOoumTt8cz7AKjKjD6Zg/oAylVT9lJpiyRe',NULL,NULL,-1,'2016-01-02 19:16:53',NULL,NULL,NULL,NULL,NULL),(21,21,'test','123123',NULL,NULL,0,'2016-01-07 12:15:40',NULL,NULL,NULL,NULL,NULL),(22,22,'aaaa','aaa',NULL,NULL,0,'2016-01-07 16:00:58',NULL,NULL,NULL,NULL,NULL),(23,23,'aaaa','aaa',NULL,NULL,0,'2016-01-07 16:03:32',NULL,NULL,NULL,NULL,NULL),(24,24,'aaaa','aaa',NULL,NULL,0,'2016-01-07 16:09:30',NULL,NULL,NULL,NULL,NULL),(25,25,'aaaa','aaa',NULL,NULL,0,'2016-01-07 16:11:01',NULL,NULL,NULL,NULL,NULL),(26,26,'aaaa','aaa',NULL,NULL,-1,'2016-01-07 16:12:48',1,'2016-01-08 12:56:42','2016-01-04','2016-01-07',NULL),(29,27,'111222','123123',NULL,NULL,1,'2016-01-08 13:50:32',1,'2016-02-03 16:36:13','2016-02-22','2016-02-23',NULL),(30,29,'qddaaaa','',NULL,NULL,-1,'2016-01-18 12:49:52',-1,'2016-02-06 12:45:43','2016-01-18','2016-03-01',NULL),(31,28,'adasd123123','$2y$13$r9gzEy/Lgy3v.9erlGGYZeUqz2UmEQsGdbpwB3sV5w7j5o53F.0VC',NULL,NULL,1,'2016-02-06 10:59:08',1,'2016-02-10 13:53:36','2016-02-06','2016-02-06',NULL),(32,31,'username','$2y$13$9PazUQwS/Dx6OdDQoF6P2.CyQ0QJ9EaeGoLQbZfe3IxuotkW5OwCK',NULL,NULL,0,'2016-02-16 12:35:57',NULL,NULL,NULL,NULL,NULL),(33,32,'testing','$2y$13$Z1k6wj9ndsohl24s3GOC5OaYgxLZ4E7FqyjpoJs1SPJiOVjHQiIEi',NULL,NULL,0,'2016-02-16 13:15:42',NULL,NULL,NULL,NULL,NULL),(34,33,'testing','$2y$13$E6uBnfPCwQRmzqVaDacBn.4mlFCWeb4zduIEoyPsbRReyfsxsqwCy',NULL,NULL,0,'2016-02-16 13:17:04',NULL,NULL,NULL,NULL,NULL),(35,34,'testing','$2y$13$nPm0nEsOjYTCg69RdaJFWumxobXk8Sa55fSN6eFueI.jw5jCOt.Qe',NULL,NULL,0,'2016-02-16 13:18:43',NULL,NULL,NULL,NULL,NULL),(36,35,'Test123','$2y$13$yDzBTj7t7Vu0M4T8Fx5ht.ylTYGzVY.nV74T55buGDlT78MLnUY1a',NULL,NULL,-1,'2016-02-16 13:57:56',-1,'2016-02-16 13:57:56',NULL,NULL,NULL),(37,36,'test12345','$2y$13$dUDuYgjXeRQhtWuyZooSs.SOSpBNvcxMNRQbiAYCWsLch1Mw4kvuu',NULL,NULL,-1,'2016-02-16 17:18:41',-1,'2016-02-16 17:18:41',NULL,NULL,NULL),(38,37,'test123456','$2y$13$DrCgspj6x6bZnYBTNnB/QOzTX08J2iMcjUmke/uKF.T5cr4MVuMMa',NULL,NULL,-1,'2016-02-16 17:47:12',-1,'2016-02-16 17:47:12',NULL,NULL,NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `co_organization` */

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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;

/*Data for the table `co_role` */

insert  into `co_role`(`role_id`,`tenant_id`,`description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'Role22','1',-1,'2015-12-29 12:40:14',1,'2016-01-07 12:40:40','2016-01-14 18:01:04'),(2,19,'test','1',-1,'2015-12-29 13:27:21',NULL,NULL,'0000-00-00 00:00:00'),(6,23,'test','1',-1,'2015-12-30 17:04:13',NULL,NULL,'0000-00-00 00:00:00'),(7,24,'nwww','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(8,25,'nwww','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(9,26,'nwww','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(10,27,'nwww','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(11,28,'nwww','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(12,29,'Test','1',-1,'2015-12-30 20:43:29',NULL,NULL,'0000-00-00 00:00:00'),(13,30,'sfdsfd','1',-1,'2015-12-30 20:50:21',NULL,NULL,'0000-00-00 00:00:00'),(15,32,'test','1',-1,'2015-12-31 19:28:41',NULL,NULL,'0000-00-00 00:00:00'),(16,33,'test','1',-1,'2016-01-02 15:07:36',NULL,NULL,'0000-00-00 00:00:00'),(17,34,'test','1',-1,'2016-01-02 15:52:34',NULL,NULL,'0000-00-00 00:00:00'),(18,35,'test','1',-1,'2016-01-02 16:03:11',NULL,NULL,'0000-00-00 00:00:00'),(19,36,'test','1',-1,'2016-01-02 18:20:37',-1,'2016-01-07 11:57:34','0000-00-00 00:00:00'),(20,37,'test','1',-1,'2016-01-02 19:16:51',1,'2016-01-07 11:20:47','0000-00-00 00:00:00'),(21,38,'asdsad','1',-1,'2016-01-07 12:15:40',-1,'2016-01-07 12:15:40','0000-00-00 00:00:00'),(22,18,'tttt','1',1,'2016-01-07 12:58:06',1,'2016-01-07 12:58:06','0000-00-00 00:00:00'),(23,18,'aaaaa','1',1,'2016-01-07 12:58:23',1,'2016-01-07 12:58:23','0000-00-00 00:00:00'),(25,18,'aasds','1',1,'2016-01-07 13:00:14',1,'2016-01-07 13:00:14','0000-00-00 00:00:00'),(26,39,'aaaa','1',-1,'2016-01-07 16:00:58',-1,'2016-01-07 16:00:58','0000-00-00 00:00:00'),(27,40,'aaaa','1',-1,'2016-01-07 16:03:32',-1,'2016-01-07 16:03:32','0000-00-00 00:00:00'),(28,41,'aaaa','1',-1,'2016-01-07 16:09:29',-1,'2016-01-07 16:09:29','0000-00-00 00:00:00'),(29,42,'aaaa','1',-1,'2016-01-07 16:11:00',-1,'2016-01-07 16:11:00','0000-00-00 00:00:00'),(30,43,'aaaa','1',-1,'2016-01-07 16:12:48',-1,'2016-01-07 16:12:48','0000-00-00 00:00:00'),(31,18,'asdasdasd','1',1,'2016-01-07 19:57:54',1,'2016-01-07 19:57:54','0000-00-00 00:00:00'),(32,18,'aaa','1',1,'2016-01-09 11:41:10',1,'2016-01-09 11:41:10','0000-00-00 00:00:00'),(33,44,'Admin','1',-1,'2016-01-18 12:49:52',-1,'2016-01-18 12:49:52','0000-00-00 00:00:00'),(35,18,'asddass','1',1,'2016-02-02 17:41:58',1,'2016-02-02 17:41:58','0000-00-00 00:00:00'),(36,18,'asdsdasdad','1',1,'2016-02-02 17:42:07',1,'2016-02-02 17:42:07','0000-00-00 00:00:00'),(37,18,'bbbbbbbbbdd','1',1,'2016-02-02 17:42:28',1,'2016-02-18 18:17:16','0000-00-00 00:00:00'),(38,4,'Super Admin','1',0,'2016-02-16 12:15:33',NULL,NULL,'0000-00-00 00:00:00'),(39,6,'Super Admin','1',0,'2016-02-16 12:35:01',NULL,NULL,'0000-00-00 00:00:00'),(40,7,'Super Admin','1',0,'2016-02-16 12:35:56',NULL,NULL,'0000-00-00 00:00:00'),(41,8,'Super Admin','1',0,'2016-02-16 13:15:42',NULL,NULL,'0000-00-00 00:00:00'),(42,9,'Super Admin','1',0,'2016-02-16 13:17:02',NULL,NULL,'0000-00-00 00:00:00'),(43,10,'Super Admin','1',0,'2016-02-16 13:18:43',NULL,NULL,'0000-00-00 00:00:00'),(44,12,'super admin','1',-1,'2016-02-16 13:57:54',-1,'2016-02-16 13:57:54','0000-00-00 00:00:00'),(45,46,'Super Admin','1',-1,'2016-02-16 17:18:39',-1,'2016-02-16 17:18:39','0000-00-00 00:00:00'),(46,47,'Super Admin','1',-1,'2016-02-16 17:47:11',-1,'2016-02-16 17:47:11','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=422 DEFAULT CHARSET=latin1;

/*Data for the table `co_roles_resources` */

insert  into `co_roles_resources`(`role_perm_id`,`tenant_id`,`role_id`,`resource_id`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,18,1,1,'1',-1,'2016-02-08 18:50:54',NULL,NULL),(2,18,1,2,'1',-1,'2016-02-08 18:50:54',NULL,NULL),(3,18,1,3,'1',-1,'2016-02-08 18:50:54',NULL,NULL),(4,18,1,4,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(5,18,1,5,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(6,18,1,6,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(7,18,1,7,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(8,18,1,8,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(9,18,1,9,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(10,18,1,10,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(11,18,1,11,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(18,18,1,18,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(19,18,1,19,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(20,18,1,20,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(21,18,1,21,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(22,18,1,22,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(23,18,1,23,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(24,18,1,24,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(25,18,1,25,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(26,18,1,26,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(27,18,1,27,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(28,18,1,28,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(29,18,1,29,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(30,18,1,30,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(31,18,1,31,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(32,18,1,32,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(33,18,1,33,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(34,18,1,34,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(35,18,1,35,'1',-1,'2016-02-08 18:50:55',NULL,NULL),(36,18,1,36,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(37,18,1,37,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(38,18,1,38,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(39,18,1,39,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(40,18,1,40,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(41,18,1,41,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(42,18,1,42,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(43,18,1,43,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(44,18,1,44,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(45,18,1,45,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(46,18,1,46,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(47,18,1,47,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(48,18,1,48,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(49,18,1,49,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(50,18,1,54,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(51,18,1,55,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(52,18,1,56,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(53,18,1,57,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(67,18,1,71,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(68,18,1,72,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(69,18,1,73,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(70,18,1,74,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(71,18,1,75,'1',-1,'2016-02-08 18:50:56',NULL,NULL),(72,18,1,76,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(73,18,1,77,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(74,18,1,78,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(75,18,1,79,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(76,18,1,80,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(77,18,1,81,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(78,18,1,82,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(79,18,1,83,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(80,18,1,84,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(81,18,1,85,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(82,18,1,86,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(83,18,1,87,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(84,18,1,88,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(85,18,1,89,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(86,18,1,90,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(87,18,1,91,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(88,18,1,92,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(89,18,1,93,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(90,18,1,94,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(91,18,1,95,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(92,18,1,96,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(93,18,1,97,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(94,18,1,98,'1',-1,'2016-02-08 18:50:57',NULL,NULL),(100,18,1,12,'1',-1,'2016-02-09 11:55:04',NULL,NULL),(101,18,1,13,'1',-1,'2016-02-09 11:55:04',NULL,NULL),(102,18,1,14,'1',-1,'2016-02-09 11:55:04',NULL,NULL),(103,18,1,15,'1',-1,'2016-02-09 11:55:04',NULL,NULL),(104,18,1,16,'1',-1,'2016-02-09 11:55:04',NULL,NULL),(105,18,1,17,'1',-1,'2016-02-09 11:55:04',NULL,NULL),(106,18,1,59,'1',-1,'2016-02-09 11:55:04',NULL,NULL),(107,18,1,60,'1',-1,'2016-02-09 11:55:04',NULL,NULL),(108,18,1,61,'1',-1,'2016-02-09 11:55:04',NULL,NULL),(109,18,1,62,'1',-1,'2016-02-09 11:55:04',NULL,NULL),(110,18,1,63,'1',-1,'2016-02-09 11:55:04',NULL,NULL),(111,18,1,64,'1',-1,'2016-02-09 11:55:05',NULL,NULL),(112,18,1,65,'1',-1,'2016-02-09 11:55:05',NULL,NULL),(113,18,1,66,'1',-1,'2016-02-09 11:55:05',NULL,NULL),(114,18,1,67,'1',-1,'2016-02-09 11:55:05',NULL,NULL),(115,18,1,68,'1',-1,'2016-02-09 11:55:05',NULL,NULL),(116,18,1,69,'1',-1,'2016-02-09 11:55:05',NULL,NULL),(117,18,1,70,'1',-1,'2016-02-09 11:55:05',NULL,NULL),(118,18,1,99,'1',-1,'2016-02-09 12:19:12',NULL,NULL),(119,18,1,100,'1',-1,'2016-02-09 12:19:12',NULL,NULL),(120,18,1,101,'1',-1,'2016-02-09 12:19:12',NULL,NULL),(121,18,1,102,'1',-1,'2016-02-09 12:19:12',NULL,NULL),(122,18,1,103,'1',-1,'2016-02-09 12:19:13',NULL,NULL),(123,18,1,104,'1',-1,'2016-02-09 12:19:13',NULL,NULL),(124,18,1,105,'1',-1,'2016-02-09 12:19:13',NULL,NULL),(125,18,1,106,'1',-1,'2016-02-09 12:19:13',NULL,NULL),(126,18,1,107,'1',-1,'2016-02-09 12:19:13',NULL,NULL),(127,18,1,108,'1',-1,'2016-02-09 12:19:13',NULL,NULL),(128,12,44,1,'1',-1,'2016-02-16 13:57:57',NULL,NULL),(129,12,44,2,'1',-1,'2016-02-16 13:57:57',NULL,NULL),(130,12,44,3,'1',-1,'2016-02-16 13:57:57',NULL,NULL),(131,12,44,4,'1',-1,'2016-02-16 13:57:57',NULL,NULL),(132,12,44,5,'1',-1,'2016-02-16 13:57:57',NULL,NULL),(133,12,44,6,'1',-1,'2016-02-16 13:57:57',NULL,NULL),(134,12,44,7,'1',-1,'2016-02-16 13:57:57',NULL,NULL),(135,12,44,8,'1',-1,'2016-02-16 13:57:57',NULL,NULL),(136,12,44,9,'1',-1,'2016-02-16 13:57:57',NULL,NULL),(137,12,44,10,'1',-1,'2016-02-16 13:57:57',NULL,NULL),(138,12,44,11,'1',-1,'2016-02-16 13:57:57',NULL,NULL),(139,12,44,12,'1',-1,'2016-02-16 13:57:57',NULL,NULL),(140,12,44,13,'1',-1,'2016-02-16 13:57:57',NULL,NULL),(141,12,44,14,'1',-1,'2016-02-16 13:57:57',NULL,NULL),(142,12,44,15,'1',-1,'2016-02-16 13:57:58',NULL,NULL),(143,12,44,16,'1',-1,'2016-02-16 13:57:58',NULL,NULL),(144,12,44,17,'1',-1,'2016-02-16 13:57:58',NULL,NULL),(145,12,44,18,'1',-1,'2016-02-16 13:57:58',NULL,NULL),(146,12,44,19,'1',-1,'2016-02-16 13:57:58',NULL,NULL),(147,12,44,20,'1',-1,'2016-02-16 13:57:58',NULL,NULL),(148,12,44,21,'1',-1,'2016-02-16 13:57:58',NULL,NULL),(149,12,44,22,'1',-1,'2016-02-16 13:57:58',NULL,NULL),(150,12,44,23,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(151,12,44,24,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(152,12,44,25,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(153,12,44,26,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(154,12,44,27,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(155,12,44,28,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(156,12,44,29,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(157,12,44,30,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(158,12,44,31,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(159,12,44,32,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(160,12,44,33,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(161,12,44,34,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(162,12,44,35,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(163,12,44,36,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(164,12,44,37,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(165,12,44,38,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(166,12,44,39,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(167,12,44,40,'1',-1,'2016-02-16 13:57:59',NULL,NULL),(168,12,44,41,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(169,12,44,42,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(170,12,44,43,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(171,12,44,44,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(172,12,44,45,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(173,12,44,46,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(174,12,44,47,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(175,12,44,48,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(176,12,44,49,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(177,12,44,54,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(178,12,44,55,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(179,12,44,56,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(180,12,44,57,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(181,12,44,58,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(182,12,44,59,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(183,12,44,60,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(184,12,44,61,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(185,12,44,62,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(186,12,44,63,'1',-1,'2016-02-16 13:58:00',NULL,NULL),(187,12,44,64,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(188,12,44,65,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(189,12,44,66,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(190,12,44,67,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(191,12,44,68,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(192,12,44,69,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(193,12,44,70,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(194,12,44,71,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(195,12,44,72,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(196,12,44,73,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(197,12,44,74,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(198,12,44,75,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(199,12,44,76,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(200,12,44,77,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(201,12,44,78,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(202,12,44,79,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(203,12,44,80,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(204,12,44,81,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(205,12,44,82,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(206,12,44,83,'1',-1,'2016-02-16 13:58:01',NULL,NULL),(207,12,44,84,'1',-1,'2016-02-16 13:58:02',NULL,NULL),(208,12,44,85,'1',-1,'2016-02-16 13:58:02',NULL,NULL),(209,12,44,86,'1',-1,'2016-02-16 13:58:02',NULL,NULL),(210,12,44,87,'1',-1,'2016-02-16 13:58:02',NULL,NULL),(211,12,44,88,'1',-1,'2016-02-16 13:58:02',NULL,NULL),(212,12,44,89,'1',-1,'2016-02-16 13:58:02',NULL,NULL),(213,12,44,90,'1',-1,'2016-02-16 13:58:02',NULL,NULL),(214,12,44,91,'1',-1,'2016-02-16 13:58:02',NULL,NULL),(215,12,44,92,'1',-1,'2016-02-16 13:58:02',NULL,NULL),(216,12,44,93,'1',-1,'2016-02-16 13:58:02',NULL,NULL),(217,12,44,94,'1',-1,'2016-02-16 13:58:02',NULL,NULL),(218,12,44,95,'1',-1,'2016-02-16 13:58:02',NULL,NULL),(219,12,44,96,'1',-1,'2016-02-16 13:58:02',NULL,NULL),(220,12,44,97,'1',-1,'2016-02-16 13:58:02',NULL,NULL),(221,12,44,98,'1',-1,'2016-02-16 13:58:02',NULL,NULL),(222,46,45,1,'1',-1,'2016-02-16 17:18:41',NULL,NULL),(223,46,45,2,'1',-1,'2016-02-16 17:18:41',NULL,NULL),(224,46,45,3,'1',-1,'2016-02-16 17:18:41',NULL,NULL),(225,46,45,4,'1',-1,'2016-02-16 17:18:41',NULL,NULL),(226,46,45,5,'1',-1,'2016-02-16 17:18:41',NULL,NULL),(227,46,45,6,'1',-1,'2016-02-16 17:18:41',NULL,NULL),(228,46,45,7,'1',-1,'2016-02-16 17:18:41',NULL,NULL),(229,46,45,8,'1',-1,'2016-02-16 17:18:41',NULL,NULL),(230,46,45,9,'1',-1,'2016-02-16 17:18:41',NULL,NULL),(231,46,45,10,'1',-1,'2016-02-16 17:18:41',NULL,NULL),(232,46,45,11,'1',-1,'2016-02-16 17:18:42',NULL,NULL),(233,46,45,12,'1',-1,'2016-02-16 17:18:42',NULL,NULL),(234,46,45,13,'1',-1,'2016-02-16 17:18:42',NULL,NULL),(235,46,45,14,'1',-1,'2016-02-16 17:18:42',NULL,NULL),(236,46,45,15,'1',-1,'2016-02-16 17:18:42',NULL,NULL),(237,46,45,16,'1',-1,'2016-02-16 17:18:42',NULL,NULL),(238,46,45,17,'1',-1,'2016-02-16 17:18:42',NULL,NULL),(239,46,45,18,'1',-1,'2016-02-16 17:18:42',NULL,NULL),(240,46,45,19,'1',-1,'2016-02-16 17:18:42',NULL,NULL),(241,46,45,20,'1',-1,'2016-02-16 17:18:42',NULL,NULL),(242,46,45,21,'1',-1,'2016-02-16 17:18:42',NULL,NULL),(243,46,45,22,'1',-1,'2016-02-16 17:18:42',NULL,NULL),(244,46,45,23,'1',-1,'2016-02-16 17:18:42',NULL,NULL),(245,46,45,24,'1',-1,'2016-02-16 17:18:42',NULL,NULL),(246,46,45,25,'1',-1,'2016-02-16 17:18:42',NULL,NULL),(247,46,45,26,'1',-1,'2016-02-16 17:18:43',NULL,NULL),(248,46,45,27,'1',-1,'2016-02-16 17:18:43',NULL,NULL),(249,46,45,28,'1',-1,'2016-02-16 17:18:43',NULL,NULL),(250,46,45,29,'1',-1,'2016-02-16 17:18:43',NULL,NULL),(251,46,45,30,'1',-1,'2016-02-16 17:18:43',NULL,NULL),(252,46,45,31,'1',-1,'2016-02-16 17:18:43',NULL,NULL),(253,46,45,32,'1',-1,'2016-02-16 17:18:43',NULL,NULL),(254,46,45,33,'1',-1,'2016-02-16 17:18:43',NULL,NULL),(255,46,45,34,'1',-1,'2016-02-16 17:18:43',NULL,NULL),(256,46,45,35,'1',-1,'2016-02-16 17:18:43',NULL,NULL),(257,46,45,36,'1',-1,'2016-02-16 17:18:43',NULL,NULL),(258,46,45,37,'1',-1,'2016-02-16 17:18:43',NULL,NULL),(259,46,45,38,'1',-1,'2016-02-16 17:18:43',NULL,NULL),(260,46,45,39,'1',-1,'2016-02-16 17:18:43',NULL,NULL),(261,46,45,40,'1',-1,'2016-02-16 17:18:43',NULL,NULL),(262,46,45,41,'1',-1,'2016-02-16 17:18:43',NULL,NULL),(263,46,45,42,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(264,46,45,43,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(265,46,45,44,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(266,46,45,45,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(267,46,45,46,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(268,46,45,47,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(269,46,45,48,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(270,46,45,49,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(271,46,45,54,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(272,46,45,55,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(273,46,45,56,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(274,46,45,57,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(275,46,45,58,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(276,46,45,59,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(277,46,45,60,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(278,46,45,61,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(279,46,45,62,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(280,46,45,63,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(281,46,45,64,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(282,46,45,65,'1',-1,'2016-02-16 17:18:44',NULL,NULL),(283,46,45,66,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(284,46,45,67,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(285,46,45,68,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(286,46,45,69,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(287,46,45,70,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(288,46,45,71,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(289,46,45,72,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(290,46,45,73,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(291,46,45,74,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(292,46,45,75,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(293,46,45,76,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(294,46,45,77,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(295,46,45,78,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(296,46,45,79,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(297,46,45,80,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(298,46,45,81,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(299,46,45,82,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(300,46,45,83,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(301,46,45,84,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(302,46,45,85,'1',-1,'2016-02-16 17:18:45',NULL,NULL),(303,46,45,86,'1',-1,'2016-02-16 17:18:46',NULL,NULL),(304,46,45,87,'1',-1,'2016-02-16 17:18:46',NULL,NULL),(305,46,45,88,'1',-1,'2016-02-16 17:18:46',NULL,NULL),(306,46,45,89,'1',-1,'2016-02-16 17:18:46',NULL,NULL),(307,46,45,90,'1',-1,'2016-02-16 17:18:46',NULL,NULL),(308,46,45,91,'1',-1,'2016-02-16 17:18:46',NULL,NULL),(309,46,45,92,'1',-1,'2016-02-16 17:18:46',NULL,NULL),(310,46,45,93,'1',-1,'2016-02-16 17:18:46',NULL,NULL),(311,46,45,94,'1',-1,'2016-02-16 17:18:46',NULL,NULL),(312,46,45,95,'1',-1,'2016-02-16 17:18:46',NULL,NULL),(313,46,45,96,'1',-1,'2016-02-16 17:18:46',NULL,NULL),(314,46,45,97,'1',-1,'2016-02-16 17:18:46',NULL,NULL),(315,46,45,98,'1',-1,'2016-02-16 17:18:46',NULL,NULL),(316,47,46,1,'1',-1,'2016-02-16 17:47:12',NULL,NULL),(317,47,46,2,'1',-1,'2016-02-16 17:47:12',NULL,NULL),(318,47,46,3,'1',-1,'2016-02-16 17:47:12',NULL,NULL),(319,47,46,4,'1',-1,'2016-02-16 17:47:12',NULL,NULL),(320,47,46,5,'1',-1,'2016-02-16 17:47:12',NULL,NULL),(321,47,46,6,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(322,47,46,7,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(323,47,46,8,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(324,47,46,9,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(325,47,46,10,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(326,47,46,11,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(327,47,46,12,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(328,47,46,13,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(329,47,46,14,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(330,47,46,15,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(331,47,46,16,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(332,47,46,17,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(333,47,46,18,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(334,47,46,19,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(335,47,46,20,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(336,47,46,21,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(337,47,46,22,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(338,47,46,23,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(339,47,46,24,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(340,47,46,25,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(341,47,46,26,'1',-1,'2016-02-16 17:47:13',NULL,NULL),(342,47,46,27,'1',-1,'2016-02-16 17:47:14',NULL,NULL),(343,47,46,28,'1',-1,'2016-02-16 17:47:14',NULL,NULL),(344,47,46,29,'1',-1,'2016-02-16 17:47:14',NULL,NULL),(345,47,46,30,'1',-1,'2016-02-16 17:47:14',NULL,NULL),(346,47,46,31,'1',-1,'2016-02-16 17:47:14',NULL,NULL),(347,47,46,32,'1',-1,'2016-02-16 17:47:14',NULL,NULL),(348,47,46,33,'1',-1,'2016-02-16 17:47:14',NULL,NULL),(349,47,46,34,'1',-1,'2016-02-16 17:47:14',NULL,NULL),(350,47,46,35,'1',-1,'2016-02-16 17:47:14',NULL,NULL),(351,47,46,36,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(352,47,46,37,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(353,47,46,38,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(354,47,46,39,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(355,47,46,40,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(356,47,46,41,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(357,47,46,42,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(358,47,46,43,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(359,47,46,44,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(360,47,46,45,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(361,47,46,46,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(362,47,46,47,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(363,47,46,48,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(364,47,46,49,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(365,47,46,54,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(366,47,46,55,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(367,47,46,56,'1',-1,'2016-02-16 17:47:15',NULL,NULL),(368,47,46,57,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(369,47,46,58,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(370,47,46,59,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(371,47,46,60,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(372,47,46,61,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(373,47,46,62,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(374,47,46,63,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(375,47,46,64,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(376,47,46,65,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(377,47,46,66,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(378,47,46,67,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(379,47,46,68,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(380,47,46,69,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(381,47,46,70,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(382,47,46,71,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(383,47,46,72,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(384,47,46,73,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(385,47,46,74,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(386,47,46,75,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(387,47,46,76,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(388,47,46,77,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(389,47,46,78,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(390,47,46,79,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(391,47,46,80,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(392,47,46,81,'1',-1,'2016-02-16 17:47:16',NULL,NULL),(393,47,46,82,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(394,47,46,83,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(395,47,46,84,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(396,47,46,85,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(397,47,46,86,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(398,47,46,87,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(399,47,46,88,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(400,47,46,89,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(401,47,46,90,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(402,47,46,91,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(403,47,46,92,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(404,47,46,93,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(405,47,46,94,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(406,47,46,95,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(407,47,46,96,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(408,47,46,97,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(409,47,46,98,'1',-1,'2016-02-16 17:47:17',NULL,NULL),(410,18,32,1,'1',1,'2016-02-19 16:35:29',NULL,NULL),(411,18,32,2,'1',1,'2016-02-19 16:35:29',NULL,NULL),(412,18,32,3,'1',1,'2016-02-19 16:35:29',NULL,NULL),(416,18,25,1,'1',1,'2016-02-19 17:21:42',NULL,NULL),(417,18,25,2,'1',1,'2016-02-19 17:21:42',NULL,NULL),(418,18,25,3,'1',1,'2016-02-19 17:21:42',NULL,NULL),(419,18,25,4,'1',1,'2016-02-19 17:21:42',NULL,NULL),(420,18,25,5,'1',1,'2016-02-19 17:21:55',NULL,NULL),(421,18,25,6,'1',1,'2016-02-19 17:21:55',NULL,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `co_room` */

insert  into `co_room`(`room_id`,`tenant_id`,`ward_id`,`bed_name`,`maintain_id`,`occupied_status`,`notes`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,4,'121',1,'1',NULL,'1',1,'2016-01-18 16:21:53',1,'2016-02-10 15:22:35','0000-00-00 00:00:00'),(2,18,4,'122',1,'1',NULL,'1',1,'2016-01-18 16:50:57',NULL,'2016-02-10 15:20:21','0000-00-00 00:00:00'),(3,18,4,'125',1,'1',NULL,'1',1,'2016-02-02 15:51:20',1,'2016-02-17 17:05:45','0000-00-00 00:00:00'),(4,18,4,'129',1,'1',NULL,'1',1,'2016-02-05 12:36:04',1,'2016-02-17 18:47:51','0000-00-00 00:00:00');

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

insert  into `co_room_charge_category`(`charge_cat_id`,`tenant_id`,`charge_cat_name`,`charge_cat_code`,`charge_cat_description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,NULL,'Procedures','PRC','Procedures','1',1,'2016-01-28 15:34:22',NULL,NULL,'0000-00-00 00:00:00'),(2,NULL,'Allied Charges','ALC','Allied Charges','1',1,'2016-01-28 15:35:12',NULL,NULL,'0000-00-00 00:00:00'),(3,18,'asdsad',NULL,'asdsad','1',1,'2016-02-08 10:36:48',1,'2016-02-08 10:36:48','0000-00-00 00:00:00'),(4,18,'asdsdas',NULL,'asdsdas','0',1,'2016-02-08 10:37:13',NULL,'2016-02-18 18:17:30','0000-00-00 00:00:00');

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

insert  into `co_room_charge_subcategory`(`charge_subcat_id`,`tenant_id`,`charge_cat_id`,`charge_subcat_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (28,18,2,'ATEST1','1',1,'2016-01-28 15:47:23',1,'2016-02-03 15:29:36','0000-00-00 00:00:00'),(29,18,2,'CANTEEN CHARGES','1',1,'2016-01-28 15:47:25',1,'2016-01-28 15:47:25','0000-00-00 00:00:00'),(30,18,2,'AIRBED CHARGES','1',1,'2016-01-28 15:47:27',1,'2016-01-28 15:47:27','0000-00-00 00:00:00'),(31,18,1,'Stomach Wash','1',1,'2016-01-28 18:19:23',1,'2016-02-03 16:01:45','0000-00-00 00:00:00'),(32,18,1,'Aversion','1',1,'2016-01-28 18:19:48',1,'2016-01-28 18:19:48','0000-00-00 00:00:00'),(33,18,2,'aaaaa','1',1,'2016-02-03 15:09:12',1,'2016-02-03 15:09:12','0000-00-00 00:00:00'),(34,18,2,'asdasdasd','0',1,'2016-02-03 15:14:15',NULL,'2016-02-03 15:40:36','0000-00-00 00:00:00'),(35,18,2,'test test','1',1,'2016-02-03 15:31:55',1,'2016-02-03 15:31:55','2016-02-03 15:33:49'),(36,18,1,'aaaa 111','1',1,'2016-02-03 16:08:12',1,'2016-02-03 16:09:10','2016-02-03 16:09:16'),(37,18,3,'tetss','1',1,'2016-02-08 10:36:49',1,'2016-02-08 10:36:49','0000-00-00 00:00:00'),(38,18,4,'adasdasd','1',1,'2016-02-08 10:37:14',1,'2016-02-18 18:32:30','0000-00-00 00:00:00'),(39,18,2,'aaadddd','1',1,'2016-02-08 15:29:55',1,'2016-02-08 15:29:55','0000-00-00 00:00:00'),(40,18,1,'aaa vvvv','1',1,'2016-02-08 15:30:11',1,'2016-02-08 15:30:11','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_type` */

insert  into `co_room_type`(`room_type_id`,`tenant_id`,`room_type_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'AC','1',1,'2016-01-11 10:46:47',1,'2016-02-09 10:36:52','0000-00-00 00:00:00'),(2,18,'Non AC','1',1,'2016-02-10 10:32:30',1,'2016-02-10 10:32:30','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_types_rooms` */

insert  into `co_room_types_rooms`(`room_type_room_id`,`tenant_id`,`room_type_id`,`room_id`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,18,1,1,1,'2016-01-18 16:50:30',1,'2016-01-18 16:50:30'),(2,18,1,2,1,'2016-01-18 16:51:07',1,'2016-01-18 16:51:07'),(3,18,1,3,1,'2016-02-02 15:51:54',1,'2016-02-02 15:51:54'),(4,18,1,4,1,'2016-02-05 12:36:42',1,'2016-02-05 12:36:42'),(5,18,2,4,1,'2016-02-10 10:32:38',1,'2016-02-10 10:32:38');

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

insert  into `co_super_admin`(`su_id`,`username`,`password`,`authtoken`,`last_activity`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,'demo','$2y$13$pfNu2lorSgd3btV7foqp.uriRfXF.7lSi51b45oefB0V1NaObxEui','ZGVtbzE0NTU1MTU4NzY5MzU1','0000-00-00 00:00:00',NULL,'0000-00-00 00:00:00',-1,'2016-01-07 11:46:28');

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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

/*Data for the table `co_tenant` */

insert  into `co_tenant`(`tenant_id`,`org_id`,`tenant_guid`,`tenant_name`,`tenant_address`,`tenant_city_id`,`tenant_state_id`,`tenant_country_id`,`tenant_contact1`,`tenant_contact2`,`tenant_fax`,`tenant_mobile`,`tenant_email`,`tenant_url`,`slug`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,0,'','Ahana Hospitals','No.11 Subraman Street,Gandhi Nagar',NULL,NULL,NULL,'0452-253444','','0452253311','9677725588','','','','1',0,'2015-12-24 16:13:39',NULL,'2016-02-03 10:29:56','0000-00-00 00:00:00'),(2,0,'','Radianz','611 K.K. Nagar',NULL,NULL,NULL,'','','','','','','','1',0,'2015-12-24 16:13:39',NULL,NULL,'0000-00-00 00:00:00'),(3,0,'','Acute Care','Development',NULL,NULL,NULL,'Development','Development','Development','Development','Development@dev.org','','','1',0,'2015-12-24 16:13:39',NULL,NULL,'0000-00-00 00:00:00'),(4,0,'','CMACS','CMACS',NULL,NULL,NULL,'CMACS','CMACS','CMACS','CMACS','CMACS@CMACS.com','','','1',0,'2015-12-24 16:13:39',NULL,NULL,'0000-00-00 00:00:00'),(5,0,'','Bodhi','No,1 Ayathampatti Village,Alagarkoil,Melur(TK)',NULL,NULL,NULL,'0452 3202014','9500969661','','9629911352','info@msctrust.org','','','1',0,'2015-12-24 16:13:39',NULL,NULL,'0000-00-00 00:00:00'),(6,0,'','ArkTestOrg','test',NULL,NULL,NULL,'12121212','12121211','1212121','3232323232','arktest@gmail.com','','','1',0,'2015-12-24 16:13:39',NULL,NULL,'0000-00-00 00:00:00'),(13,0,'','asdd','asdasd',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-28 18:50:12',NULL,NULL,'0000-00-00 00:00:00'),(14,0,'','test','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-28 18:50:36',NULL,NULL,'0000-00-00 00:00:00'),(18,0,'','Org','Hi asasdasdasdasdasd',2,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-29 12:40:14',-1,'2016-01-07 16:25:27','0000-00-00 00:00:00'),(19,0,'','Orge','asdsd',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-29 13:27:21',NULL,NULL,'0000-00-00 00:00:00'),(23,0,'','New Orrr','asdasd',3,2,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-30 17:04:13',NULL,NULL,'0000-00-00 00:00:00'),(24,0,'','Testaaaaa','asdsad',1,1,1,'adasd','asdasd','12321321','3213213','test@test.com','http://asdas.com','','1',0,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(25,0,'','Testaaaaawewew','asdsad',1,1,1,'adasd','asdasd','12321321','3213213','test@test.com','http://asdas.com','','1',0,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(26,0,'','sfsdfsfd','asdsad',1,1,1,'adasd','asdasd','12321321','3213213','test@test.com','http://asdas.com','','1',0,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(27,0,'','sfsdfsfdsfdsf','asdsad',1,1,1,'adasd','asdasd','12321321','3213213','test@test.com','http://asdas.com','','1',0,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(28,0,'','sfsdfsfdsfdsfddf','asdsad',1,1,1,'adasd','asdasd','12321321','3213213','test@test.com','http://asdas.com','','1',0,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(29,0,'','sdfsdf','sdfsdf',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-30 20:43:29',NULL,NULL,'0000-00-00 00:00:00'),(30,0,'','sdfsdfs','sdfsdfsdf',2,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-30 20:50:21',NULL,NULL,'0000-00-00 00:00:00'),(32,0,'','Teest','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-31 19:28:41',NULL,NULL,'0000-00-00 00:00:00'),(33,0,'','Testttt','test',1,1,1,'test','test',NULL,NULL,NULL,NULL,'','1',0,'2016-01-02 15:07:36',NULL,NULL,'0000-00-00 00:00:00'),(34,0,'','test111','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2016-01-02 15:52:34',NULL,NULL,'0000-00-00 00:00:00'),(35,0,'','yrsd','asddasd',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2016-01-02 16:03:11',NULL,'2016-02-10 12:31:31','0000-00-00 00:00:00'),(36,0,'','asdasd','adasdasd',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2016-01-02 18:20:36',NULL,NULL,'0000-00-00 00:00:00'),(37,0,'','test 123123','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2016-01-02 19:16:51',NULL,NULL,'0000-00-00 00:00:00'),(38,0,'','asdsd','asdsad',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-07 12:15:40',-1,'2016-01-07 12:15:40','0000-00-00 00:00:00'),(39,0,'','testaaa','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-07 16:00:58',-1,'2016-01-07 16:00:58','0000-00-00 00:00:00'),(40,0,'','testaaasss','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-07 16:03:32',-1,'2016-01-07 16:03:32','0000-00-00 00:00:00'),(41,0,'','testaaasssasdad','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-07 16:09:29',-1,'2016-01-07 16:09:29','0000-00-00 00:00:00'),(42,0,'','testaaasssaaaasdad','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-07 16:11:00',-1,'2016-01-07 16:11:00','0000-00-00 00:00:00'),(43,0,'','testaaasssaaaasdaddsad','test',1,1,1,'12323123',NULL,NULL,NULL,'test@ete.com',NULL,'','1',-1,'2016-01-07 16:12:48',-1,'2016-02-03 11:05:26','0000-00-00 00:00:00'),(44,0,'','New Organization 111','New',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','0',-1,'2016-01-18 12:49:52',NULL,'2016-02-10 12:31:36','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

/*Data for the table `co_user` */

insert  into `co_user`(`user_id`,`tenant_id`,`org_id`,`title_code`,`name`,`designation`,`address`,`city_id`,`state_id`,`zip`,`country_id`,`contact1`,`contact2`,`mobile`,`email`,`speciality_id`,`care_provider`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,0,'Mr.','Test Oregaaa','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12323123','test@test.com',NULL,'0','1',-1,'2015-12-29 12:40:14',1,'2016-01-08 11:07:01','0000-00-00 00:00:00'),(2,19,0,'Mr.','test','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'test','test',NULL,'0','1',-1,'2015-12-29 13:27:22',NULL,NULL,'0000-00-00 00:00:00'),(6,23,0,'Mr.','asdsd','dasdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1233123','test@test.com',NULL,'0','1',-1,'2015-12-30 17:04:13',NULL,NULL,'0000-00-00 00:00:00'),(7,24,0,'Mr.','test','test','23123123',1,1,'625020',1,'321323','23123','123123','test@test.com',NULL,'0','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(8,25,0,'Mr.','test','test','23123123',1,1,'625020',1,'321323','23123','123123','test@test.com',NULL,'0','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(9,26,0,'Mr.','test','test','23123123',1,1,'625020',1,'321323','23123','123123','test@test.com',NULL,'0','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(10,27,0,'Mr.','test','test','23123123',1,1,'625020',1,'321323','23123','123123','test@test.com',NULL,'0','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(11,28,0,'Mr.','test','test','23123123',1,1,'625020',1,'321323','23123','123123','test@test.com',NULL,'0','1',-1,'2015-12-30 20:29:01',NULL,NULL,'0000-00-00 00:00:00'),(12,29,0,'Mr.','sdfsfd','sfdsf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'11111111','test@t.com',NULL,'0','1',-1,'2015-12-30 20:43:29',NULL,NULL,'0000-00-00 00:00:00'),(13,30,0,'Mrs.','sdfsdf','sfdsf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'f111111','test@te.com',NULL,'0','1',-1,'2015-12-30 20:50:21',NULL,NULL,'0000-00-00 00:00:00'),(15,32,0,'Mr.','rwar','asdsdsd',NULL,NULL,NULL,NULL,1,'asdasda','sdasd','asdasd','test@test.com',NULL,'0','1',-1,'2015-12-31 19:28:41',NULL,NULL,'0000-00-00 00:00:00'),(16,33,0,'Mr.','asdasd','asdsadsd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12323212','ts2test@tt.com',NULL,'0','1',-1,'2016-01-02 15:07:36',NULL,NULL,'0000-00-00 00:00:00'),(17,34,0,'Mr.','tess','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'test','test@test.com',NULL,'0','1',-1,'2016-01-02 15:52:34',NULL,NULL,'0000-00-00 00:00:00'),(18,18,0,'Mrs.','asda','sdasd',NULL,1,1,NULL,1,NULL,NULL,'asdasd','test@test.com',NULL,'0','1',-1,'2016-01-02 16:03:11',1,'2016-01-08 12:59:19','0000-00-00 00:00:00'),(19,36,0,'Mr.','test','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'123213','tasd@gmail.com',NULL,'0','1',-1,'2016-01-02 18:20:37',NULL,NULL,'0000-00-00 00:00:00'),(20,37,0,'Mr.','test','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'23123123','test@test.com',NULL,'0','1',-1,'2016-01-02 19:16:52',NULL,NULL,'0000-00-00 00:00:00'),(21,38,0,'Mr.','test','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'test','test@test.com',NULL,'0','1',0,'2016-01-07 12:15:40',NULL,NULL,'0000-00-00 00:00:00'),(22,39,0,'Mr.','asdsad','adsdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a123123','asdas@asdasd.com',NULL,'0','1',0,'2016-01-07 16:00:58',NULL,NULL,'0000-00-00 00:00:00'),(23,40,0,'Mr.','asdsad','adsdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a123123','asdas@asdasd.com',NULL,'0','1',0,'2016-01-07 16:03:32',NULL,NULL,'0000-00-00 00:00:00'),(24,41,0,'Mr.','asdsad','adsdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a123123','asdas@asdasd.com',NULL,'0','1',0,'2016-01-07 16:09:29',NULL,NULL,'0000-00-00 00:00:00'),(25,42,0,'Mr.','asdsad','adsdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a123123','asdas@asdasd.com',NULL,'0','1',-1,'2016-01-07 16:11:00',-1,'2016-01-07 16:11:00','0000-00-00 00:00:00'),(26,43,0,'Mr.','asdsad','adsdasd','aaaaa',1,1,'344433',1,NULL,NULL,'a123123','asdas@asdasd.com',NULL,'0','1',-1,'2016-01-07 16:12:48',-1,'2016-02-10 11:18:40','0000-00-00 00:00:00'),(27,18,0,'Mr.','Doctor 2','test',NULL,2,1,NULL,1,NULL,NULL,'12323123','test@test.com',NULL,'1','1',1,'2016-01-08 10:36:38',1,'2016-01-08 12:59:38','0000-00-00 00:00:00'),(28,18,0,'Mrs.','Doctor 1','asdasd','test',1,1,'625002',1,NULL,NULL,'123213','sdasd@asdas.comn',1,'1','1',1,'2016-01-08 17:43:52',1,'2016-02-06 12:53:26','0000-00-00 00:00:00'),(29,44,0,'Mr.','Rajesh','Admin',NULL,1,1,'625002',1,'9561515415','5541521541','52655626','admin@admin.com',NULL,'0','1',-1,'2016-01-18 12:49:52',-1,'2016-01-18 16:17:38','0000-00-00 00:00:00'),(30,6,0,'Mr.','Name','Designation','Test',1,1,'1234586',1,NULL,NULL,'123','test@gmail.com',NULL,'0','1',0,'2016-02-16 12:35:01',NULL,NULL,'0000-00-00 00:00:00'),(31,7,0,'Mr.','Name','Designation','Test',1,1,'1234586',1,NULL,NULL,'123','test@gmail.com',NULL,'0','1',0,'2016-02-16 12:35:56',NULL,NULL,'0000-00-00 00:00:00'),(32,8,0,'Mr.','Test','test','TEst',1,1,'123',1,NULL,NULL,'123','test@gmail.com',NULL,'0','1',0,'2016-02-16 13:15:42',NULL,NULL,'0000-00-00 00:00:00'),(33,9,0,'Mr.','Test','test','TEst',1,1,'123',1,NULL,NULL,'123','test@gmail.com',NULL,'0','1',0,'2016-02-16 13:17:03',NULL,NULL,'0000-00-00 00:00:00'),(34,10,0,'Mr.','Test','test','TEst',1,1,'123',1,NULL,NULL,'123','test@gmail.com',NULL,'0','1',0,'2016-02-16 13:18:43',NULL,NULL,'0000-00-00 00:00:00'),(35,12,0,'Mr.','Test','design','Test',1,1,'123',1,NULL,NULL,'123','test@gmail.com',NULL,'0','1',-1,'2016-02-16 13:57:54',-1,'2016-02-16 13:57:54','0000-00-00 00:00:00'),(36,46,0,'Mr.','Test','test','Test',1,1,'123',1,NULL,NULL,'123456','test@gmail.com',NULL,'0','1',-1,'2016-02-16 17:18:39',-1,'2016-02-16 17:18:39','0000-00-00 00:00:00'),(37,47,0,'Mr.','Test','Des','Test',1,1,'123456',1,NULL,NULL,'123','test@gmail.com',NULL,'0','1',-1,'2016-02-16 17:47:11',-1,'2016-02-16 17:47:11','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

/*Data for the table `co_users_roles` */

insert  into `co_users_roles`(`user_role_id`,`tenant_id`,`user_id`,`role_id`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,18,1,1,1,'2015-12-30 16:07:24',NULL,NULL),(3,23,6,6,0,'2015-12-30 17:04:15',NULL,NULL),(4,24,7,7,-1,'2015-12-30 20:29:03',NULL,NULL),(5,25,8,8,-1,'2015-12-30 20:39:55',NULL,NULL),(6,26,9,9,-1,'2015-12-30 20:40:45',NULL,NULL),(7,27,10,10,-1,'2015-12-30 20:41:39',NULL,NULL),(8,28,11,11,-1,'2015-12-30 20:42:29',NULL,NULL),(9,29,12,12,-1,'2015-12-30 20:43:31',NULL,NULL),(10,30,13,13,-1,'2015-12-30 20:50:23',NULL,NULL),(12,32,15,15,-1,'2015-12-31 19:28:42',NULL,NULL),(13,33,16,16,-1,'2016-01-02 15:07:37',NULL,NULL),(14,34,17,17,-1,'2016-01-02 15:52:35',NULL,NULL),(15,35,18,18,-1,'2016-01-02 16:03:13',NULL,NULL),(16,36,19,19,-1,'2016-01-02 18:20:39',NULL,NULL),(17,37,20,20,-1,'2016-01-02 19:16:53',NULL,NULL),(18,38,21,21,-1,'2016-01-07 12:15:40',NULL,NULL),(19,39,22,26,-1,'2016-01-07 16:00:58',NULL,NULL),(20,40,23,27,-1,'2016-01-07 16:03:33',NULL,NULL),(21,41,24,28,-1,'2016-01-07 16:09:30',NULL,NULL),(22,42,25,29,-1,'2016-01-07 16:11:01',NULL,NULL),(23,43,26,30,-1,'2016-01-07 16:12:48',NULL,NULL),(26,18,1,22,1,'2016-01-08 19:16:22',NULL,NULL),(28,18,18,1,1,'2016-01-08 19:57:42',NULL,NULL),(29,18,18,22,1,'2016-01-08 19:57:43',NULL,NULL),(30,18,1,31,1,'2016-01-09 10:43:47',NULL,NULL),(32,18,27,1,0,'2016-01-09 10:46:36',1,'2016-01-09 10:46:36'),(33,18,27,31,0,'2016-01-09 10:46:36',1,'2016-01-09 10:46:36'),(34,18,27,25,0,'2016-01-09 10:46:36',1,'2016-01-09 10:46:36'),(35,18,28,1,0,'2016-01-09 10:48:02',1,'2016-01-09 10:48:02'),(36,18,28,22,0,'2016-01-09 10:48:02',1,'2016-01-09 10:48:02'),(37,18,27,23,0,'2016-01-09 11:00:27',1,'2016-01-09 11:00:27'),(38,18,18,23,0,'2016-01-13 10:35:06',1,'2016-01-13 10:35:06'),(39,44,29,33,-1,'2016-01-18 12:49:52',NULL,NULL),(40,12,35,44,-1,'2016-02-16 13:57:56',NULL,NULL),(41,46,36,45,-1,'2016-02-16 17:18:41',NULL,NULL),(42,47,37,46,-1,'2016-02-16 17:47:12',NULL,NULL);

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

insert  into `co_ward`(`ward_id`,`tenant_id`,`floor_id`,`ward_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,2,'Test 111','1',1,'2016-01-09 17:00:19',1,'2016-01-09 17:00:33','2016-01-09 17:00:41'),(2,18,3,'Test','1',1,'2016-01-09 17:15:17',NULL,'2016-01-09 20:52:26','2016-01-18 16:20:40'),(4,18,5,'test123','1',1,'2016-01-18 16:20:58',1,'2016-01-18 17:51:06','0000-00-00 00:00:00'),(5,18,6,'aaaa','1',1,'2016-01-18 17:51:18',1,'2016-01-18 17:51:18','0000-00-00 00:00:00'),(11,18,6,'aaaa2','1',1,'2016-02-06 12:58:54',1,'2016-02-09 10:36:26','0000-00-00 00:00:00'),(14,18,5,'aaaa2','1',1,'2016-02-06 13:02:53',1,'2016-02-09 10:36:20','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

/*Data for the table `pat_admission` */

insert  into `pat_admission`(`admn_id`,`tenant_id`,`patient_id`,`encounter_id`,`status_date`,`consultant_id`,`floor_id`,`ward_id`,`room_id`,`room_type_id`,`admission_status`,`status`,`notes`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (23,18,5,7,'2016-02-04 13:28:12',27,5,4,1,1,'A','1',NULL,1,'2016-02-04 13:28:27',1,'2016-02-04 13:28:27','0000-00-00 00:00:00'),(24,18,5,7,'2016-02-04 13:38:14',28,5,4,1,1,'TD','1',NULL,1,'2016-02-04 13:39:56',1,'2016-02-04 13:39:56','0000-00-00 00:00:00'),(25,18,6,8,'2016-02-04 13:55:45',27,5,4,2,1,'A','1',NULL,1,'2016-02-04 13:55:59',1,'2016-02-04 13:55:59','0000-00-00 00:00:00'),(26,18,5,7,'2016-02-05 11:30:50',28,5,4,1,1,'D','1',NULL,1,'2016-02-05 11:31:08',1,'2016-02-05 11:31:08','0000-00-00 00:00:00'),(27,18,5,10,'2016-02-05 12:16:21',27,5,4,3,1,'A','1',NULL,1,'2016-02-05 12:19:47',1,'2016-02-05 12:19:47','0000-00-00 00:00:00'),(28,18,5,10,'2016-02-05 12:34:58',28,5,4,3,1,'TD','1',NULL,1,'2016-02-05 12:35:04',1,'2016-02-05 12:35:04','0000-00-00 00:00:00'),(29,18,5,10,'2016-02-05 12:36:54',28,5,4,4,1,'TR','1',NULL,1,'2016-02-05 12:37:04',1,'2016-02-05 12:37:04','0000-00-00 00:00:00'),(30,18,5,10,'2016-02-05 12:39:57',28,5,4,2,1,'TR','1',NULL,1,'2016-02-05 12:40:02',1,'2016-02-05 12:40:02','0000-00-00 00:00:00'),(31,18,6,8,'2016-02-05 12:39:57',27,5,4,4,1,'TR','1',NULL,1,'2016-02-05 12:40:02',1,'2016-02-05 12:40:02','0000-00-00 00:00:00'),(32,18,5,10,'2016-02-05 13:13:34',28,5,4,2,1,'D','1',NULL,1,'2016-02-05 13:13:41',1,'2016-02-05 13:13:41','0000-00-00 00:00:00'),(33,18,5,12,'2016-02-05 18:30:26',27,5,4,3,1,'A','1',NULL,1,'2016-02-05 18:30:34',1,'2016-02-05 18:30:34','0000-00-00 00:00:00'),(34,18,5,12,'2016-02-08 10:41:45',28,5,4,3,1,'TD','1',NULL,1,'2016-02-08 10:41:55',1,'2016-02-08 10:41:55','0000-00-00 00:00:00'),(35,18,5,12,'2016-02-17 17:05:37',28,5,4,3,1,'D','1',NULL,1,'2016-02-17 17:05:44',1,'2016-02-17 17:05:44','0000-00-00 00:00:00'),(36,18,6,8,'2016-02-17 18:47:48',27,5,4,4,1,'D','1',NULL,1,'2016-02-17 18:47:51',1,'2016-02-17 18:47:51','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=latin1;

/*Data for the table `pat_appointment` */

insert  into `pat_appointment`(`appt_id`,`tenant_id`,`patient_id`,`encounter_id`,`status_date`,`status_time`,`consultant_id`,`appt_status`,`status`,`amount`,`notes`,`patient_cat_id`,`patient_bill_type`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,5,9,'2016-02-05','01:05:00',28,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-05 11:34:09',1,'2016-02-05 11:34:09','0000-00-00 00:00:00'),(2,18,5,9,'2016-02-05','01:05:00',28,'A','1','0.00',NULL,NULL,NULL,1,'2016-02-05 11:34:09',1,'2016-02-05 11:34:09','0000-00-00 00:00:00'),(3,18,5,9,'2016-02-03','02:10:00',28,'S','1','100.00',NULL,NULL,NULL,1,'2016-02-05 12:13:17',1,'2016-02-05 12:13:17','0000-00-00 00:00:00'),(4,18,5,11,'2016-02-05','01:00:00',28,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-05 13:14:34',1,'2016-02-05 13:14:34','0000-00-00 00:00:00'),(5,18,5,11,'2016-02-05','01:00:00',28,'A','1','0.00',NULL,NULL,NULL,1,'2016-02-05 13:14:34',1,'2016-02-05 13:14:34','0000-00-00 00:00:00'),(6,18,5,11,'2016-02-03','06:30:00',28,'S','1','60.00',NULL,NULL,NULL,1,'2016-02-05 18:15:21',1,'2016-02-05 18:15:21','0000-00-00 00:00:00'),(7,18,5,13,'2016-02-17','00:00:00',28,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-17 17:06:15',1,'2016-02-17 17:06:15','0000-00-00 00:00:00'),(8,18,5,13,'2016-02-17','17:42:04',28,'A','1','0.00',NULL,NULL,NULL,1,'2016-02-17 17:42:10',1,'2016-02-17 17:42:10','0000-00-00 00:00:00'),(9,18,6,14,'2016-02-17','00:10:00',28,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-17 18:48:02',1,'2016-02-17 18:48:02','0000-00-00 00:00:00'),(10,18,5,13,'2016-02-17','18:49:02',28,'C','1','0.00',NULL,NULL,NULL,1,'2016-02-17 18:49:02',1,'2016-02-17 18:49:02','0000-00-00 00:00:00'),(11,18,5,15,'2016-02-17','07:50:00',28,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-17 18:50:30',1,'2016-02-17 18:50:30','0000-00-00 00:00:00'),(12,18,5,15,'2016-02-17','18:50:41',28,'C','1','0.00',NULL,NULL,NULL,1,'2016-02-17 18:50:41',1,'2016-02-17 18:50:41','0000-00-00 00:00:00'),(13,18,5,16,'2016-02-17','00:20:00',28,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-17 19:02:51',1,'2016-02-17 19:02:51','0000-00-00 00:00:00'),(14,18,5,16,'2016-02-17','19:03:01',28,'C','1','0.00',NULL,NULL,NULL,1,'2016-02-17 19:03:01',1,'2016-02-17 19:03:01','0000-00-00 00:00:00'),(15,18,5,17,'2016-02-17','07:30:00',28,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-17 19:05:19',1,'2016-02-17 19:05:19','0000-00-00 00:00:00'),(16,18,5,17,'2016-02-17','19:05:30',28,'C','1','0.00',NULL,NULL,NULL,1,'2016-02-17 19:05:30',1,'2016-02-17 19:05:30','0000-00-00 00:00:00'),(17,18,5,18,'2016-02-18','01:15:00',27,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-18 10:14:09',1,'2016-02-18 10:14:09','0000-00-00 00:00:00'),(18,18,5,18,'2016-02-02','05:25:00',27,'A','1','0.00',NULL,NULL,NULL,1,'2016-02-18 10:20:31',1,'2016-02-18 10:20:31','0000-00-00 00:00:00'),(24,18,6,14,'2016-02-18','11:14:37',28,'S','1','0.00',NULL,3,NULL,1,'2016-02-18 11:14:51',1,'2016-02-18 11:14:51','0000-00-00 00:00:00'),(25,18,5,19,'2016-02-18','01:25:00',27,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-18 11:49:06',1,'2016-02-18 11:49:06','0000-00-00 00:00:00'),(26,18,6,20,'2016-02-18','01:15:00',27,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-18 11:49:32',1,'2016-02-18 11:49:32','0000-00-00 00:00:00'),(27,18,6,20,'2016-02-18','11:49:43',27,'A','1','0.00',NULL,NULL,NULL,1,'2016-02-18 11:49:45',1,'2016-02-18 11:49:45','0000-00-00 00:00:00'),(28,18,6,20,'2016-02-18','11:49:56',27,'C','1','0.00',NULL,NULL,NULL,1,'2016-02-18 11:49:57',1,'2016-02-18 11:49:57','0000-00-00 00:00:00'),(29,18,6,21,'2016-02-18','00:05:00',27,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-18 11:50:10',1,'2016-02-18 11:50:10','0000-00-00 00:00:00'),(30,18,6,21,'2016-02-18','11:50:18',27,'A','1','0.00',NULL,NULL,NULL,1,'2016-02-18 11:50:21',1,'2016-02-18 11:50:21','0000-00-00 00:00:00'),(31,18,5,18,'2016-02-18','15:33:57',27,'S','1','60.00',NULL,1,NULL,1,'2016-02-18 15:34:03',1,'2016-02-18 15:34:03','0000-00-00 00:00:00'),(32,18,6,22,'2016-02-18','00:00:00',27,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-18 15:36:11',1,'2016-02-18 15:36:11','0000-00-00 00:00:00'),(34,18,6,22,'2016-02-18','17:01:00',27,'A','1','0.00',NULL,NULL,NULL,1,'2016-02-18 17:01:35',1,'2016-02-18 17:01:35','0000-00-00 00:00:00'),(35,18,6,22,'2016-02-18','17:03:39',27,'S','1','100.00',NULL,1,NULL,1,'2016-02-18 17:03:45',1,'2016-02-18 17:03:45','0000-00-00 00:00:00'),(36,18,6,23,'2016-02-18','07:20:00',28,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-18 17:03:57',1,'2016-02-18 17:03:57','0000-00-00 00:00:00'),(41,18,6,23,'2016-02-18','18:14:00',28,'A','1','0.00',NULL,NULL,NULL,1,'2016-02-18 18:14:11',1,'2016-02-18 18:14:11','0000-00-00 00:00:00'),(42,18,5,24,'2016-02-20','07:45:00',28,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-20 13:06:54',1,'2016-02-20 13:06:54','0000-00-00 00:00:00'),(43,18,5,24,'2016-02-20','15:03:50',28,'A','1','0.00',NULL,NULL,NULL,1,'2016-02-20 15:03:52',1,'2016-02-20 15:03:52','0000-00-00 00:00:00'),(44,18,5,24,'2016-02-20','15:04:07',28,'S','1','200.00',NULL,1,NULL,1,'2016-02-20 15:04:17',1,'2016-02-20 15:04:17','0000-00-00 00:00:00'),(45,18,5,25,'2016-02-20','07:50:00',28,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-20 15:04:36',1,'2016-02-20 15:04:36','0000-00-00 00:00:00'),(46,18,5,25,'2016-02-20','18:03:58',28,'C','1','0.00',NULL,NULL,NULL,1,'2016-02-20 18:03:58',1,'2016-02-20 18:03:58','0000-00-00 00:00:00'),(47,18,5,26,'2016-02-25','00:10:00',28,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-25 13:18:55',1,'2016-02-25 13:18:55','0000-00-00 00:00:00'),(48,18,5,26,'2016-02-25','13:22:16',28,'A','1','0.00',NULL,NULL,NULL,1,'2016-02-25 13:22:33',1,'2016-02-25 13:22:33','0000-00-00 00:00:00'),(49,18,5,26,'2016-02-25','13:22:41',28,'S','1','0.00',NULL,1,'N',1,'2016-02-25 13:23:29',1,'2016-02-25 13:23:29','0000-00-00 00:00:00'),(50,18,5,27,'2016-02-25','00:05:00',28,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-25 13:26:24',1,'2016-02-25 13:26:24','0000-00-00 00:00:00'),(51,18,5,27,'2016-02-25','00:05:00',28,'A','1','0.00',NULL,NULL,NULL,1,'2016-02-25 13:26:24',1,'2016-02-25 13:26:24','0000-00-00 00:00:00'),(52,18,5,27,'2016-02-25','14:00:52',28,'S','1','0.00',NULL,1,'F',1,'2016-02-25 14:00:59',1,'2016-02-25 14:00:59','0000-00-00 00:00:00'),(53,18,5,28,'2016-02-25','00:05:00',28,'B','1','0.00',NULL,NULL,NULL,1,'2016-02-25 14:01:21',1,'2016-02-25 14:01:21','0000-00-00 00:00:00');

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
  CONSTRAINT `FK_pat_consultant_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_pat_consultant_user` FOREIGN KEY (`consultant_id`) REFERENCES `co_user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `pat_consultant` */

insert  into `pat_consultant`(`pat_consult_id`,`tenant_id`,`encounter_id`,`patient_id`,`consultant_id`,`consult_date`,`notes`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,7,5,28,'2016-02-04 18:16:35','test','1',1,'2016-02-04 15:56:15',1,'2016-02-04 16:35:09','2016-02-04 18:16:35'),(2,18,12,5,27,'2016-02-03 02:10:00','test test','1',1,'2016-02-06 15:31:11',1,'2016-02-06 15:31:11','0000-00-00 00:00:00'),(3,18,21,6,27,'2016-02-02 05:25:00','Test','1',1,'2016-02-18 12:02:32',1,'2016-02-18 12:02:32','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

/*Data for the table `pat_encounter` */

insert  into `pat_encounter`(`encounter_id`,`tenant_id`,`patient_id`,`encounter_type`,`encounter_date`,`inactive_date`,`finalize`,`authorize`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (7,18,5,'IP','2016-02-04 13:28:12',NULL,0,0,'0',1,'2016-02-04 13:28:27',1,'2016-02-05 11:31:08','0000-00-00 00:00:00'),(8,18,6,'IP','2016-02-04 13:55:45',NULL,0,0,'0',1,'2016-02-04 13:55:59',1,'2016-02-17 18:47:51','0000-00-00 00:00:00'),(9,18,5,'OP','2016-02-05 00:00:00',NULL,0,0,'0',1,'2016-02-05 11:34:09',1,'2016-02-05 12:13:17','0000-00-00 00:00:00'),(10,18,5,'IP','2016-02-05 12:16:21',NULL,0,0,'0',1,'2016-02-05 12:19:47',1,'2016-02-05 13:13:41','0000-00-00 00:00:00'),(11,18,5,'OP','2016-02-05 00:00:00',NULL,0,0,'0',1,'2016-02-05 13:14:34',1,'2016-02-05 18:15:21','0000-00-00 00:00:00'),(12,18,5,'IP','2016-02-05 18:30:26',NULL,0,0,'0',1,'2016-02-05 18:30:34',1,'2016-02-17 17:05:45','0000-00-00 00:00:00'),(13,18,5,'OP','2016-02-17 00:00:00',NULL,0,0,'0',1,'2016-02-17 17:06:15',1,'2016-02-17 18:49:02','0000-00-00 00:00:00'),(14,18,6,'OP','2016-02-17 00:00:00',NULL,0,0,'0',1,'2016-02-17 18:48:02',1,'2016-02-18 11:14:51','0000-00-00 00:00:00'),(15,18,5,'OP','2016-02-17 00:00:00',NULL,0,0,'0',1,'2016-02-17 18:50:30',1,'2016-02-17 18:50:41','0000-00-00 00:00:00'),(16,18,5,'OP','2016-02-17 00:00:00',NULL,0,0,'0',1,'2016-02-17 19:02:51',1,'2016-02-17 19:03:01','0000-00-00 00:00:00'),(17,18,5,'OP','2016-02-17 00:00:00',NULL,0,0,'0',1,'2016-02-17 19:05:19',1,'2016-02-17 19:05:31','0000-00-00 00:00:00'),(18,18,5,'OP','2016-02-18 00:00:00',NULL,0,0,'0',1,'2016-02-18 10:14:09',1,'2016-02-18 15:34:03','0000-00-00 00:00:00'),(19,18,5,'OP','2016-02-18 00:00:00',NULL,0,0,'0',1,'2016-02-18 11:49:06',1,'2016-02-18 11:49:06','0000-00-00 00:00:00'),(20,18,6,'OP','2016-02-18 00:00:00',NULL,0,0,'0',1,'2016-02-18 11:49:32',1,'2016-02-18 11:49:57','0000-00-00 00:00:00'),(21,18,6,'OP','2016-02-18 00:00:00',NULL,0,0,'0',1,'2016-02-18 11:50:10',1,'2016-02-18 11:50:10','0000-00-00 00:00:00'),(22,18,6,'OP','2016-02-18 00:00:00',NULL,0,0,'0',1,'2016-02-18 15:36:11',1,'2016-02-18 17:03:45','0000-00-00 00:00:00'),(23,18,6,'OP','2016-02-18 00:00:00',NULL,0,0,'1',1,'2016-02-18 17:03:57',1,'2016-02-18 17:03:57','0000-00-00 00:00:00'),(24,18,5,'OP','2016-02-20 00:00:00',NULL,0,0,'0',1,'2016-02-20 13:06:53',1,'2016-02-20 15:04:17','0000-00-00 00:00:00'),(25,18,5,'OP','2016-02-20 00:00:00',NULL,0,0,'0',1,'2016-02-20 15:04:36',1,'2016-02-20 18:03:59','0000-00-00 00:00:00'),(26,18,5,'OP','2016-02-25 00:00:00',NULL,0,0,'0',1,'2016-02-25 13:18:55',1,'2016-02-25 13:23:29','0000-00-00 00:00:00'),(27,18,5,'OP','2016-02-25 00:00:00',NULL,0,0,'0',1,'2016-02-25 13:26:24',1,'2016-02-25 14:00:59','0000-00-00 00:00:00'),(28,18,5,'OP','2016-02-25 00:00:00',NULL,0,0,'1',1,'2016-02-25 14:01:21',1,'2016-02-25 14:01:21','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `pat_notes` */

insert  into `pat_notes`(`pat_note_id`,`tenant_id`,`encounter_id`,`patient_id`,`notes`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,11,5,'Hi','1',1,'2016-02-05 16:02:56',1,'2016-02-05 16:02:56','0000-00-00 00:00:00'),(2,18,21,6,'Note','1',1,'2016-02-18 12:02:15',1,'2016-02-18 12:02:15','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `pat_patient` */

insert  into `pat_patient`(`patient_id`,`patient_guid`,`casesheetno`,`patient_int_code`,`tenant_id`,`patient_reg_date`,`patient_title_code`,`patient_firstname`,`patient_lastname`,`patient_relation_code`,`patient_relation_name`,`patient_care_taker`,`patient_care_taker_name`,`patient_dob`,`patient_gender`,`patient_marital_status`,`patient_occupation`,`patient_blood_group`,`patient_category_id`,`patient_email`,`patient_reg_mode`,`patient_type`,`patient_ref_hospital`,`patient_ref_id`,`patient_mobile`,`patient_bill_type`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (5,'efca45b2-6ef3-5c87-8169-de33af43',NULL,'PAT0000001',18,'2016-02-04 07:51:01','Mr.','Prakash arul mani','Paramanandam',NULL,NULL,NULL,NULL,'1990-07-31','M','S',NULL,NULL,1,NULL,'NO',NULL,NULL,NULL,'9894688122','N','1',1,'2016-02-04 12:21:01',1,'2016-02-18 15:15:27','0000-00-00 00:00:00'),(6,'0029a7d6-6a11-56c4-82e0-e5b8a3bd',NULL,'PAT0000002',18,'2016-02-04 09:14:13','Mr.','Nadesh','Subramanian',NULL,NULL,NULL,NULL,'1990-04-04','M',NULL,NULL,NULL,1,NULL,'IP',NULL,NULL,NULL,'9894622733',NULL,'1',1,'2016-02-04 13:44:13',1,'2016-02-18 12:00:10','0000-00-00 00:00:00');

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

insert  into `pat_patient_address`(`addr_id`,`patient_id`,`addr_current_address`,`addr_country_id`,`addr_state_id`,`addr_city_id`,`addr_zip`,`addr_perm_address`,`addr_perm_country_id`,`addr_perm_state_id`,`addr_perm_city_id`,`addr_perm_zip`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (6,5,'aa dddd aasdasdasd ddddaa',1,1,2,'625002','aa dddd aasdasdasd ddddaa',1,1,2,'625002',1,'2016-02-04 12:21:02',1,'2016-02-08 10:40:07','0000-00-00 00:00:00'),(7,6,NULL,1,1,1,NULL,NULL,1,1,2,NULL,1,'2016-02-04 13:44:13',1,'2016-02-18 12:00:10','0000-00-00 00:00:00');

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

insert  into `pha_brand`(`brand_id`,`tenant_id`,`brand_name`,`brand_code`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'SUN','SU053','1',1,'2016-02-09 15:36:54',NULL,'2016-02-19 11:25:49','0000-00-00 00:00:00'),(2,18,'UNICHEM','UN012','1',1,'2016-02-19 11:25:44',NULL,'2016-02-19 11:26:10','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `pha_brand_division` */

insert  into `pha_brand_division`(`division_id`,`tenant_id`,`division_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'SYNERGY','1',1,'2016-02-09 16:23:58',1,'2016-02-09 16:25:26','2016-02-09 16:25:49'),(2,18,'SYNERGY','1',1,'2016-02-09 16:27:07',1,'2016-02-19 11:27:29','0000-00-00 00:00:00'),(3,18,'GENERAL','1',1,'2016-02-19 11:27:42',1,'2016-02-19 11:27:42','0000-00-00 00:00:00');

/*Table structure for table `pha_drug_class` */

DROP TABLE IF EXISTS `pha_drug_class`;

CREATE TABLE `pha_drug_class` (
  `drug_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `drug_name` varchar(255) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`drug_id`),
  UNIQUE KEY `PhadrugUnique` (`tenant_id`,`drug_name`,`deleted_at`),
  CONSTRAINT `FK_pha_drug_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `pha_drug_class` */

insert  into `pha_drug_class`(`drug_id`,`tenant_id`,`drug_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'Test','1',1,'2016-02-09 16:54:56',1,'2016-02-09 16:54:56','0000-00-00 00:00:00');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pha_generic` */

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `pha_package_unit` */

insert  into `pha_package_unit`(`package_id`,`tenant_id`,`package_name`,`package_unit`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'10','10','1',1,'2016-02-09 17:22:10',1,'2016-02-09 17:24:52','2016-02-09 17:25:22'),(2,18,'10s','10','1',1,'2016-02-10 10:07:48',1,'2016-02-10 10:07:48','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `pha_supplier` */

insert  into `pha_supplier`(`supplier_id`,`tenant_id`,`supplier_name`,`supplier_code`,`supplier_address`,`city_id`,`state_id`,`country_id`,`zip`,`supplier_mobile`,`supplier_phone`,`cst_no`,`tin_no`,`drug_license`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'SRI NARAYANA TRADING COMPANY','SR0211','as asda sdasdsadasd',4,3,2,'12323','1231231231','23123123','1231232','3123123123',NULL,'1',1,'2016-02-10 13:45:35',1,'2016-02-10 13:50:20','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `pha_vat` */

insert  into `pha_vat`(`vat_id`,`tenant_id`,`vat`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'14.50','1',1,'2016-02-19 15:55:37',1,'2016-02-19 15:56:01','0000-00-00 00:00:00');

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

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_encounter` AS select `a`.`appt_id` AS `id`,`c`.`encounter_id` AS `encounter_id`,concat(`a`.`status_date`,' ',`a`.`status_time`) AS `date`,(case `a`.`appt_status` when 'B' then 'Booked' when 'A' then 'Arived' when 'S' then 'Seen' else NULL end) AS `type`,'\nOP' AS `details`,concat(`b`.`title_code`,`b`.`name`) AS `doctor`,`c`.`patient_id` AS `patient_id`,`d`.`patient_guid` AS `patient_guid`,`c`.`encounter_type` AS `encounter_type`,`c`.`status` AS `status`,`a`.`status_date` AS `date_time` from (((`pat_appointment` `a` join `co_user` `b` on((`b`.`user_id` = `a`.`consultant_id`))) join `pat_encounter` `c` on((`c`.`encounter_id` = `a`.`encounter_id`))) join `pat_patient` `d` on((`d`.`patient_id` = `c`.`patient_id`))) union all select `a`.`admn_id` AS `id`,`c`.`encounter_id` AS `encounter_id`,`a`.`status_date` AS `date`,(case `a`.`admission_status` when 'A' then 'Admission' when 'D' then 'Discharge' when 'TR' then 'Transfer (Room)' when 'TD' then 'Transfer (Doctor)' else NULL end) AS `type`,concat('IP: ',`d`.`floor_name`,' > ',`e`.`ward_name`,' > ',`f`.`bed_name`,'  (',`g`.`room_type_name`,')') AS `details`,concat(`b`.`title_code`,`b`.`name`) AS `doctor`,`c`.`patient_id` AS `patient_id`,`h`.`patient_guid` AS `patient_guid`,`c`.`encounter_type` AS `encounter_type`,`c`.`status` AS `status`,`a`.`status_date` AS `date_time` from (((((((`pat_admission` `a` join `co_user` `b` on((`b`.`user_id` = `a`.`consultant_id`))) join `pat_encounter` `c` on((`c`.`encounter_id` = `a`.`encounter_id`))) left join `co_floor` `d` on((`d`.`floor_id` = `a`.`floor_id`))) left join `co_ward` `e` on((`e`.`ward_id` = `a`.`ward_id`))) left join `co_room` `f` on((`f`.`room_id` = `a`.`room_id`))) left join `co_room_type` `g` on((`g`.`room_type_id` = `a`.`room_type_id`))) join `pat_patient` `h` on((`h`.`patient_id` = `c`.`patient_id`))) order by `encounter_id` desc,`date_time` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
