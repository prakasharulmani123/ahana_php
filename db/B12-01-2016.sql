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
  `alert_name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `co_alert` */

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `co_floor` */

insert  into `co_floor`(`floor_id`,`tenant_id`,`floor_name`,`floor_code`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (2,18,'asdsd','AA','1',1,'2016-01-09 12:37:26',1,'2016-01-09 12:37:26','2016-01-09 16:03:13'),(3,18,'ASAAA11','AA','1',1,'2016-01-09 12:37:41',1,'2016-01-09 13:32:49','2016-01-09 15:54:15'),(4,1,'test','EE','0',1,'2016-01-09 16:03:23',1,'2016-01-09 16:46:46','0000-00-00 00:00:00'),(5,18,'New','FL','1',1,'2016-01-09 19:31:41',1,'2016-01-09 19:31:41','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

/*Data for the table `co_login` */

insert  into `co_login`(`login_id`,`user_id`,`username`,`password`,`password_reset_token`,`authtoken`,`created_by`,`created_at`,`modified_by`,`modified_at`,`activation_date`,`Inactivation_date`) values (1,1,'123123','$2y$13$f1.ldgwKkkr8GcHPoSmrou4sXjLpJTaQlGxgXnmqS0ubWJvu0/yLu',NULL,'MTIzMTIzMTQ1MjQ4OTI5Mjc0MTg=',0,'2015-12-29 12:40:15',NULL,'2016-01-11 10:44:52',NULL,NULL),(2,2,'test','$2y$13$z5IIhq7WgWa.mttlXvPfU.rj7ECjwe0XO0qYotm/KGYGVLofIGW7q',NULL,NULL,-1,'2015-12-29 13:27:23',NULL,NULL,NULL,NULL),(6,6,'test','$2y$13$26z8fSgBVSaDk6dSc4tEouKnZSoYbMxq/4rBobSP/QSQfBvdvTNFW',NULL,NULL,-1,'2015-12-30 17:04:14',NULL,NULL,NULL,NULL),(7,7,'123123','$2y$13$UuCYLvsFlDJ8z4c4rQ1HjOborIk4kQSn/BUZN3o4IQXVZXh3yuqSK',NULL,NULL,-1,'2015-12-30 20:29:03',NULL,NULL,NULL,NULL),(8,8,'123123','$2y$13$43E8tZWtjPeBgmNSPyT9J.D5eaI0YzYhz6gcDIPIivUiAnfhxIdsm',NULL,NULL,-1,'2015-12-30 20:29:03',NULL,NULL,NULL,NULL),(9,9,'123123','$2y$13$1y2enmiOKrzYyjqcFwVUE.8RCejtYcGZZL4jm98Wk3wE9CCMR3Ymu',NULL,NULL,-1,'2015-12-30 20:29:03',NULL,NULL,NULL,NULL),(10,10,'123123','$2y$13$012PM43tycVN7OcYlB/0x.fdiI61LZUtIozbAxKhnWbr1IyFDBcRi',NULL,NULL,-1,'2015-12-30 20:29:03',NULL,NULL,NULL,NULL),(11,11,'123123','$2y$13$MTPatpVSg6AKyJZS0ClJcucw1aRwGnFyfTn.W2QURueLyRU6GHF3K',NULL,NULL,-1,'2015-12-30 20:29:03',NULL,NULL,NULL,NULL),(12,12,'test','$2y$13$3HYt/nfAibfzt7d.CHnDKOpmYuyMq8lFsU6ZpvAgZyfRsTvRtEZz.',NULL,NULL,-1,'2015-12-30 20:43:30',NULL,NULL,NULL,NULL),(13,13,'sdfsdf','$2y$13$eq47HcHN6RRpmsuZFScU2u23AfUZp47a2taPaTh3ZkLaoMN7c1fOC',NULL,NULL,-1,'2015-12-30 20:50:23',NULL,NULL,NULL,NULL),(15,15,'tester','$2y$13$9FPvHeqEZGuIvcifzJVs4.w5iX6ZY.ezbqQ1u0.F8l.lYrfemR/ym',NULL,NULL,-1,'2015-12-31 19:28:42',NULL,NULL,NULL,NULL),(16,16,'test','$2y$13$1.GJ18v3tsxpv/pQ4mZq6u3ShXkHIosNo.KFzIo4r3YEP.TQ83L4i',NULL,NULL,-1,'2016-01-02 15:07:37',NULL,NULL,NULL,NULL),(17,17,'test','$2y$13$Rh4dpklxDBQyC3q9JtCf2.N334ZUVjq2XDwUq7mmYpvypWCWfL8Xi',NULL,NULL,-1,'2016-01-02 15:52:35',NULL,NULL,NULL,NULL),(18,18,'test','$2y$13$38DMc9wOBSj.gMx8oFfAv.hrHH1frzKERGTY1.pSLYv6kJT61Zmr.',NULL,NULL,-1,'2016-01-02 16:03:13',NULL,NULL,NULL,NULL),(19,19,'test','$2y$13$jbSCihxnnDHl8gLkYPdteO/XtRWrKEHQnlL2l5cvh1Lj1z1W55pPS',NULL,NULL,-1,'2016-01-02 18:20:39',NULL,NULL,NULL,NULL),(20,20,'test','$2y$13$2rWaKGPs0CPD5UGgsuaOoumTt8cz7AKjKjD6Zg/oAylVT9lJpiyRe',NULL,NULL,-1,'2016-01-02 19:16:53',NULL,NULL,NULL,NULL),(21,21,'test','123123',NULL,NULL,0,'2016-01-07 12:15:40',NULL,NULL,NULL,NULL),(22,22,'aaaa','aaa',NULL,NULL,0,'2016-01-07 16:00:58',NULL,NULL,NULL,NULL),(23,23,'aaaa','aaa',NULL,NULL,0,'2016-01-07 16:03:32',NULL,NULL,NULL,NULL),(24,24,'aaaa','aaa',NULL,NULL,0,'2016-01-07 16:09:30',NULL,NULL,NULL,NULL),(25,25,'aaaa','aaa',NULL,NULL,0,'2016-01-07 16:11:01',NULL,NULL,NULL,NULL),(26,26,'aaaa','aaa',NULL,NULL,-1,'2016-01-07 16:12:48',1,'2016-01-08 12:56:42','2016-01-04','2016-01-07'),(29,27,'123123','123123',NULL,NULL,1,'2016-01-08 13:50:32',1,'2016-01-08 13:50:32',NULL,NULL);

/*Table structure for table `co_master_city` */

DROP TABLE IF EXISTS `co_master_city`;

CREATE TABLE `co_master_city` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `state_id` int(11) NOT NULL,
  `city_name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`city_id`),
  KEY `FK_co_master_city_state` (`state_id`),
  CONSTRAINT `FK_co_master_city_state` FOREIGN KEY (`state_id`) REFERENCES `co_master_state` (`state_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `co_master_city` */

insert  into `co_master_city`(`city_id`,`state_id`,`city_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,1,'Madurai','1',1,'2015-12-28 15:07:51',NULL,NULL),(2,1,'Chennai','1',1,'2015-12-28 16:21:17',NULL,NULL),(3,2,'Cochin','1',1,'2015-12-28 17:31:33',NULL,NULL);

/*Table structure for table `co_master_country` */

DROP TABLE IF EXISTS `co_master_country`;

CREATE TABLE `co_master_country` (
  `country_id` int(10) NOT NULL AUTO_INCREMENT,
  `country_name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`country_id`),
  UNIQUE KEY `CountryNameUnique` (`country_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `co_master_country` */

insert  into `co_master_country`(`country_id`,`country_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,'India','1',1,'2015-12-28 15:07:32',NULL,NULL),(2,'Pakistan','1',1,'2015-12-28 17:30:39',NULL,NULL);

/*Table structure for table `co_master_state` */

DROP TABLE IF EXISTS `co_master_state`;

CREATE TABLE `co_master_state` (
  `state_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) NOT NULL,
  `state_name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`state_id`),
  KEY `FK_co_master_state_country` (`country_id`),
  CONSTRAINT `FK_co_master_state_country` FOREIGN KEY (`country_id`) REFERENCES `co_master_country` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `co_master_state` */

insert  into `co_master_state`(`state_id`,`country_id`,`state_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,1,'Tamil Nadu','1',1,'2015-12-28 15:07:43',NULL,NULL),(2,1,'Kerala','1',1,'2015-12-28 17:30:49',NULL,NULL),(3,2,'Islamabad','1',1,'2015-12-28 17:31:13',NULL,NULL);

/*Table structure for table `co_patient_category` */

DROP TABLE IF EXISTS `co_patient_category`;

CREATE TABLE `co_patient_category` (
  `patient_cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `patient_cat_name` varchar(50) NOT NULL,
  `patient_cat_label` varchar(10) DEFAULT NULL,
  `patient_cat_color` varchar(10) NOT NULL,
  `patient_cat_activate_time` time DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`patient_cat_id`),
  KEY `FK_co_patient_category_tenant` (`tenant_id`),
  CONSTRAINT `FK_co_patient_category_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `co_patient_category` */

/*Table structure for table `co_procedure` */

DROP TABLE IF EXISTS `co_procedure`;

CREATE TABLE `co_procedure` (
  `procedure_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `procedure_name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`procedure_id`),
  KEY `co_procedure_tenant` (`tenant_id`),
  CONSTRAINT `FK_co_procedure_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `co_procedure` */

/*Table structure for table `co_resources` */

DROP TABLE IF EXISTS `co_resources`;

CREATE TABLE `co_resources` (
  `resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `resource_name` varchar(50) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`resource_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `co_resources` */

insert  into `co_resources`(`resource_id`,`parent_id`,`resource_name`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,NULL,'Module 1',-1,'2015-12-29 15:11:20',NULL,NULL),(2,1,'Module 1- Sub 1',-1,'2015-12-29 15:11:42',NULL,NULL),(3,NULL,'Modue 2',-1,'2015-12-30 11:48:25',NULL,NULL),(4,3,'Module 2- Sub 1',-1,'2015-12-30 11:48:42',NULL,NULL),(9,3,'Module 2 - Sub 2',-1,'2015-12-30 18:16:13',NULL,NULL);

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
  PRIMARY KEY (`role_id`),
  KEY `FK_co_role_tenant` (`tenant_id`),
  CONSTRAINT `FK_co_role_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

/*Data for the table `co_role` */

insert  into `co_role`(`role_id`,`tenant_id`,`description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,18,'Role22','1',-1,'2015-12-29 12:40:14',1,'2016-01-07 12:40:40'),(2,19,'test','1',-1,'2015-12-29 13:27:21',NULL,NULL),(6,23,'test','1',-1,'2015-12-30 17:04:13',NULL,NULL),(7,24,'nwww','1',-1,'2015-12-30 20:29:01',NULL,NULL),(8,25,'nwww','1',-1,'2015-12-30 20:29:01',NULL,NULL),(9,26,'nwww','1',-1,'2015-12-30 20:29:01',NULL,NULL),(10,27,'nwww','1',-1,'2015-12-30 20:29:01',NULL,NULL),(11,28,'nwww','1',-1,'2015-12-30 20:29:01',NULL,NULL),(12,29,'Test','1',-1,'2015-12-30 20:43:29',NULL,NULL),(13,30,'sfdsfd','1',-1,'2015-12-30 20:50:21',NULL,NULL),(15,32,'test','1',-1,'2015-12-31 19:28:41',NULL,NULL),(16,33,'test','1',-1,'2016-01-02 15:07:36',NULL,NULL),(17,34,'test','1',-1,'2016-01-02 15:52:34',NULL,NULL),(18,35,'test','1',-1,'2016-01-02 16:03:11',NULL,NULL),(19,36,'test','1',-1,'2016-01-02 18:20:37',-1,'2016-01-07 11:57:34'),(20,37,'test','1',-1,'2016-01-02 19:16:51',1,'2016-01-07 11:20:47'),(21,38,'asdsad','1',-1,'2016-01-07 12:15:40',-1,'2016-01-07 12:15:40'),(22,18,'tttt','1',1,'2016-01-07 12:58:06',1,'2016-01-07 12:58:06'),(23,18,'aaaaa','1',1,'2016-01-07 12:58:23',1,'2016-01-07 12:58:23'),(25,18,'aasds','1',1,'2016-01-07 13:00:14',1,'2016-01-07 13:00:14'),(26,39,'aaaa','1',-1,'2016-01-07 16:00:58',-1,'2016-01-07 16:00:58'),(27,40,'aaaa','1',-1,'2016-01-07 16:03:32',-1,'2016-01-07 16:03:32'),(28,41,'aaaa','1',-1,'2016-01-07 16:09:29',-1,'2016-01-07 16:09:29'),(29,42,'aaaa','1',-1,'2016-01-07 16:11:00',-1,'2016-01-07 16:11:00'),(30,43,'aaaa','1',-1,'2016-01-07 16:12:48',-1,'2016-01-07 16:12:48'),(31,18,'asdasdasd','1',1,'2016-01-07 19:57:54',1,'2016-01-07 19:57:54'),(32,18,'aaa','1',1,'2016-01-09 11:41:10',1,'2016-01-09 11:41:10');

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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;

/*Data for the table `co_roles_resources` */

insert  into `co_roles_resources`(`role_perm_id`,`tenant_id`,`role_id`,`resource_id`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (5,23,6,3,'1',-1,'2015-12-30 17:04:15',NULL,NULL),(7,23,6,1,'1',-1,'2015-12-30 17:04:15',NULL,NULL),(8,23,6,9,'1',-1,'2015-12-30 17:04:15',NULL,NULL),(9,23,6,2,'1',-1,'2015-12-30 18:17:39',NULL,NULL),(10,24,7,3,'1',-1,'2015-12-30 20:29:04',NULL,NULL),(11,30,13,3,'1',-1,'2015-12-30 20:50:23',NULL,NULL),(29,32,15,3,'1',-1,'2016-01-02 10:58:20',NULL,NULL),(30,32,15,4,'1',-1,'2016-01-02 10:58:20',NULL,NULL),(31,32,15,9,'1',-1,'2016-01-02 10:58:21',NULL,NULL),(32,33,16,1,'1',-1,'2016-01-02 15:07:37',NULL,NULL),(33,33,16,2,'1',-1,'2016-01-02 15:07:37',NULL,NULL),(34,33,16,3,'1',-1,'2016-01-02 15:07:38',NULL,NULL),(35,33,16,4,'1',-1,'2016-01-02 15:07:38',NULL,NULL),(36,36,19,1,'1',-1,'2016-01-02 18:20:39',NULL,NULL),(37,36,19,2,'1',-1,'2016-01-02 18:20:39',NULL,NULL),(38,36,19,3,'1',-1,'2016-01-02 18:20:40',NULL,NULL),(39,36,19,4,'1',-1,'2016-01-02 18:20:40',NULL,NULL),(40,37,20,1,'1',-1,'2016-01-02 19:16:55',NULL,NULL),(41,37,20,2,'1',-1,'2016-01-02 19:16:55',NULL,NULL),(42,37,20,3,'1',-1,'2016-01-02 19:16:56',NULL,NULL),(43,37,20,9,'1',-1,'2016-01-02 19:16:56',NULL,NULL),(44,38,21,3,'1',-1,'2016-01-07 12:15:40',NULL,NULL),(45,38,21,4,'1',-1,'2016-01-07 12:15:41',NULL,NULL),(46,38,21,9,'1',-1,'2016-01-07 12:15:41',NULL,NULL),(47,39,26,3,'1',-1,'2016-01-07 16:00:58',NULL,NULL),(48,39,26,4,'1',-1,'2016-01-07 16:00:58',NULL,NULL),(49,40,27,3,'1',-1,'2016-01-07 16:03:33',NULL,NULL),(50,40,27,4,'1',-1,'2016-01-07 16:03:33',NULL,NULL),(51,41,28,3,'1',-1,'2016-01-07 16:09:30',NULL,NULL),(52,41,28,4,'1',-1,'2016-01-07 16:09:30',NULL,NULL),(53,42,29,3,'1',-1,'2016-01-07 16:11:01',NULL,NULL),(54,42,29,4,'1',-1,'2016-01-07 16:11:01',NULL,NULL),(55,43,30,3,'1',-1,'2016-01-07 16:12:48',NULL,NULL),(57,43,30,1,'1',-1,'2016-01-07 16:43:07',NULL,NULL),(58,43,30,2,'1',-1,'2016-01-07 16:43:07',NULL,NULL),(60,43,30,4,'1',-1,'2016-01-07 17:13:37',NULL,NULL),(63,43,30,9,'1',-1,'2016-01-07 17:25:52',NULL,NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `co_room` */

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

insert  into `co_room_charge`(`charge_id`,`tenant_id`,`charge_item_id`,`room_type_id`,`charge`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,2,1,'500.00','1',1,'2016-01-11 11:40:57',1,'2016-01-11 12:16:20','2016-01-11 12:17:31'),(2,18,2,1,'500.00','1',1,'2016-01-11 12:17:48',1,'2016-01-11 15:15:35','0000-00-00 00:00:00');

/*Table structure for table `co_room_charge_category` */

DROP TABLE IF EXISTS `co_room_charge_category`;

CREATE TABLE `co_room_charge_category` (
  `charge_cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_charge_category` */

insert  into `co_room_charge_category`(`charge_cat_id`,`tenant_id`,`charge_cat_name`,`charge_cat_code`,`charge_cat_description`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,'123123 AAAA','123123','33123123','1',1,'2016-01-09 18:27:21',1,'2016-01-09 18:31:20','2016-01-09 18:33:08'),(2,18,'test','test','test','1',1,'2016-01-09 18:33:29',NULL,'2016-01-09 18:33:40','2016-01-11 12:18:30'),(4,18,'Allied Charges','AL','Allied Charges','1',1,'2016-01-11 12:23:01',1,'2016-01-11 13:05:09','0000-00-00 00:00:00'),(9,18,'Professional Charge',NULL,'Professional Charge','1',1,'2016-01-11 13:38:57',1,'2016-01-11 13:38:57','0000-00-00 00:00:00'),(10,18,'test',NULL,'aaaa','1',1,'2016-01-11 16:48:23',1,'2016-01-11 16:48:23','0000-00-00 00:00:00'),(11,18,'asdsd',NULL,'dasdsadsad','1',1,'2016-01-11 18:12:01',1,'2016-01-11 18:12:01','0000-00-00 00:00:00'),(12,18,'asdsad',NULL,'dsad','1',1,'2016-01-11 18:13:28',1,'2016-01-11 18:13:28','0000-00-00 00:00:00'),(13,18,'asdsdas','asdsad','dsadsd','1',1,'2016-01-11 18:14:32',1,'2016-01-11 18:41:07','0000-00-00 00:00:00');

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
  KEY `co_room_cat_tenant` (`tenant_id`),
  KEY `FK_co_room_charge_subcategory_category` (`charge_cat_id`),
  CONSTRAINT `FK_co_room_charge_subcategory_category` FOREIGN KEY (`charge_cat_id`) REFERENCES `co_room_charge_category` (`charge_cat_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_co_room_subcat_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `co_room_charge_subcategory` */

insert  into `co_room_charge_subcategory`(`charge_subcat_id`,`tenant_id`,`charge_cat_id`,`charge_subcat_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (10,18,13,'111111','1',1,'2016-01-11 18:14:33',1,'2016-01-11 18:41:07','0000-00-00 00:00:00'),(11,18,13,'adadasdsad','1',1,'2016-01-11 18:41:08',1,'2016-01-11 18:41:08','0000-00-00 00:00:00');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `co_room_maintenance` */

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
  `modified_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`room_type_room_id`),
  KEY `FK_room_types_rooms_tenane` (`tenant_id`),
  KEY `FK_room_types_rooms` (`room_type_id`),
  KEY `FK_room_types_rooms_room` (`room_id`),
  CONSTRAINT `FK_room_types_rooms` FOREIGN KEY (`room_type_id`) REFERENCES `co_room_type` (`room_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_room_types_rooms_room` FOREIGN KEY (`room_id`) REFERENCES `co_room` (`room_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_room_types_rooms_tenane` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `co_room_types_rooms` */

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
  PRIMARY KEY (`speciality_id`),
  KEY `co_speciality_tenant` (`tenant_id`),
  CONSTRAINT `FK_co_speciality_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `co_speciality` */

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

insert  into `co_super_admin`(`su_id`,`username`,`password`,`authtoken`,`last_activity`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,'demo','$2y$13$pfNu2lorSgd3btV7foqp.uriRfXF.7lSi51b45oefB0V1NaObxEui','ZGVtbzE0NTIzNDE0NzY0NDU4','0000-00-00 00:00:00',NULL,'0000-00-00 00:00:00',-1,'2016-01-07 11:46:28');

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
  PRIMARY KEY (`tenant_id`),
  UNIQUE KEY `TenantNameUnique` (`tenant_name`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;

/*Data for the table `co_tenant` */

insert  into `co_tenant`(`tenant_id`,`tenant_guid`,`tenant_name`,`tenant_address`,`tenant_city_id`,`tenant_state_id`,`tenant_country_id`,`tenant_contact1`,`tenant_contact2`,`tenant_fax`,`tenant_mobile`,`tenant_email`,`tenant_url`,`slug`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,'','Ahana Hospitals','No.11 Subraman Street,Gandhi Nagar',NULL,NULL,NULL,'0452-253444','','0452253311','9677725588','','','','1',0,'2015-12-24 16:13:39',NULL,NULL),(2,'','Radianz','611 K.K. Nagar',NULL,NULL,NULL,'','','','','','','','1',0,'2015-12-24 16:13:39',NULL,NULL),(3,'','Acute Care','Development',NULL,NULL,NULL,'Development','Development','Development','Development','Development@dev.org','','','1',0,'2015-12-24 16:13:39',NULL,NULL),(4,'','CMACS','CMACS',NULL,NULL,NULL,'CMACS','CMACS','CMACS','CMACS','CMACS@CMACS.com','','','1',0,'2015-12-24 16:13:39',NULL,NULL),(5,'','Bodhi','No,1 Ayathampatti Village,Alagarkoil,Melur(TK)',NULL,NULL,NULL,'0452 3202014','9500969661','','9629911352','info@msctrust.org','','','1',0,'2015-12-24 16:13:39',NULL,NULL),(6,'','ArkTestOrg','test',NULL,NULL,NULL,'12121212','12121211','1212121','3232323232','arktest@gmail.com','','','1',0,'2015-12-24 16:13:39',NULL,NULL),(13,'','asdd','asdasd',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-28 18:50:12',NULL,NULL),(14,'','test','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-28 18:50:36',NULL,NULL),(18,'','Org','Hi asasdasdasdasdasd',2,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-29 12:40:14',-1,'2016-01-07 16:25:27'),(19,'','Orge','asdsd',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-29 13:27:21',NULL,NULL),(23,'','New Orrr','asdasd',3,2,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-30 17:04:13',NULL,NULL),(24,'','Testaaaaa','asdsad',1,1,1,'adasd','asdasd','12321321','3213213','test@test.com','http://asdas.com','','1',0,'2015-12-30 20:29:01',NULL,NULL),(25,'','Testaaaaawewew','asdsad',1,1,1,'adasd','asdasd','12321321','3213213','test@test.com','http://asdas.com','','1',0,'2015-12-30 20:29:01',NULL,NULL),(26,'','sfsdfsfd','asdsad',1,1,1,'adasd','asdasd','12321321','3213213','test@test.com','http://asdas.com','','1',0,'2015-12-30 20:29:01',NULL,NULL),(27,'','sfsdfsfdsfdsf','asdsad',1,1,1,'adasd','asdasd','12321321','3213213','test@test.com','http://asdas.com','','1',0,'2015-12-30 20:29:01',NULL,NULL),(28,'','sfsdfsfdsfdsfddf','asdsad',1,1,1,'adasd','asdasd','12321321','3213213','test@test.com','http://asdas.com','','1',0,'2015-12-30 20:29:01',NULL,NULL),(29,'','sdfsdf','sdfsdf',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-30 20:43:29',NULL,NULL),(30,'','sdfsdfs','sdfsdfsdf',2,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-30 20:50:21',NULL,NULL),(32,'','Teest','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2015-12-31 19:28:41',NULL,NULL),(33,'','Testttt','test',1,1,1,'test','test',NULL,NULL,NULL,NULL,'','1',0,'2016-01-02 15:07:36',NULL,NULL),(34,'','test111','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2016-01-02 15:52:34',NULL,NULL),(35,'','yrsd','asddasd',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2016-01-02 16:03:11',NULL,NULL),(36,'','asdasd','adasdasd',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2016-01-02 18:20:36',NULL,NULL),(37,'','test 123123','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',0,'2016-01-02 19:16:51',NULL,NULL),(38,'','asdsd','asdsad',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-07 12:15:40',-1,'2016-01-07 12:15:40'),(39,'','testaaa','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-07 16:00:58',-1,'2016-01-07 16:00:58'),(40,'','testaaasss','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-07 16:03:32',-1,'2016-01-07 16:03:32'),(41,'','testaaasssasdad','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-07 16:09:29',-1,'2016-01-07 16:09:29'),(42,'','testaaasssaaaasdad','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-07 16:11:00',-1,'2016-01-07 16:11:00'),(43,'','testaaasssaaaasdaddsad','test',1,1,1,NULL,NULL,NULL,NULL,NULL,NULL,'','1',-1,'2016-01-07 16:12:48',-1,'2016-01-07 16:12:48');

/*Table structure for table `co_user` */

DROP TABLE IF EXISTS `co_user`;

CREATE TABLE `co_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `title_code` enum('Mr.','Mrs.','Miss.','Dr.') DEFAULT 'Mr.',
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
  PRIMARY KEY (`user_id`),
  KEY `FK_co_user_profile_tenant` (`tenant_id`),
  CONSTRAINT `FK_co_user_profile_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

/*Data for the table `co_user` */

insert  into `co_user`(`user_id`,`tenant_id`,`title_code`,`name`,`designation`,`address`,`city_id`,`state_id`,`zip`,`country_id`,`contact1`,`contact2`,`mobile`,`email`,`speciality_id`,`care_provider`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,18,'Mr.','Test Oregaaa','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12323123','test@test.com',NULL,'0','1',-1,'2015-12-29 12:40:14',1,'2016-01-08 11:07:01'),(2,19,'Mr.','test','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'test','test',NULL,'0','1',-1,'2015-12-29 13:27:22',NULL,NULL),(6,23,'Mr.','asdsd','dasdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1233123','test@test.com',NULL,'0','1',-1,'2015-12-30 17:04:13',NULL,NULL),(7,24,'Mr.','test','test','23123123',1,1,'625020',1,'321323','23123','123123','test@test.com',NULL,'0','1',-1,'2015-12-30 20:29:01',NULL,NULL),(8,25,'Mr.','test','test','23123123',1,1,'625020',1,'321323','23123','123123','test@test.com',NULL,'0','1',-1,'2015-12-30 20:29:01',NULL,NULL),(9,26,'Mr.','test','test','23123123',1,1,'625020',1,'321323','23123','123123','test@test.com',NULL,'0','1',-1,'2015-12-30 20:29:01',NULL,NULL),(10,27,'Mr.','test','test','23123123',1,1,'625020',1,'321323','23123','123123','test@test.com',NULL,'0','1',-1,'2015-12-30 20:29:01',NULL,NULL),(11,28,'Mr.','test','test','23123123',1,1,'625020',1,'321323','23123','123123','test@test.com',NULL,'0','1',-1,'2015-12-30 20:29:01',NULL,NULL),(12,29,'Mr.','sdfsfd','sfdsf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'11111111','test@t.com',NULL,'0','1',-1,'2015-12-30 20:43:29',NULL,NULL),(13,30,'Mrs.','sdfsdf','sfdsf',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'f111111','test@te.com',NULL,'0','1',-1,'2015-12-30 20:50:21',NULL,NULL),(15,32,'Mr.','rwar','asdsdsd',NULL,NULL,NULL,NULL,1,'asdasda','sdasd','asdasd','test@test.com',NULL,'0','1',-1,'2015-12-31 19:28:41',NULL,NULL),(16,33,'Mr.','asdasd','asdsadsd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'12323212','ts2test@tt.com',NULL,'0','1',-1,'2016-01-02 15:07:36',NULL,NULL),(17,34,'Mr.','tess','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'test','test@test.com',NULL,'0','1',-1,'2016-01-02 15:52:34',NULL,NULL),(18,18,'Mrs.','asda','sdasd',NULL,1,1,NULL,1,NULL,NULL,'asdasd','test@test.com',NULL,'0','1',-1,'2016-01-02 16:03:11',1,'2016-01-08 12:59:19'),(19,36,'Mr.','test','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'123213','tasd@gmail.com',NULL,'0','1',-1,'2016-01-02 18:20:37',NULL,NULL),(20,37,'Mr.','test','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'23123123','test@test.com',NULL,'0','1',-1,'2016-01-02 19:16:52',NULL,NULL),(21,38,'Mr.','test','test',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'test','test@test.com',NULL,'0','1',0,'2016-01-07 12:15:40',NULL,NULL),(22,39,'Mr.','asdsad','adsdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a123123','asdas@asdasd.com',NULL,'0','1',0,'2016-01-07 16:00:58',NULL,NULL),(23,40,'Mr.','asdsad','adsdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a123123','asdas@asdasd.com',NULL,'0','1',0,'2016-01-07 16:03:32',NULL,NULL),(24,41,'Mr.','asdsad','adsdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a123123','asdas@asdasd.com',NULL,'0','1',0,'2016-01-07 16:09:29',NULL,NULL),(25,42,'Mr.','asdsad','adsdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a123123','asdas@asdasd.com',NULL,'0','1',-1,'2016-01-07 16:11:00',-1,'2016-01-07 16:11:00'),(26,43,'Mr.','asdsad','adsdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'a123123','asdas@asdasd.com',NULL,'0','1',-1,'2016-01-07 16:12:48',-1,'2016-01-07 16:12:48'),(27,18,'Mr.','Test Oreg11','test',NULL,2,1,NULL,1,NULL,NULL,'12323123','test@test.com',NULL,'0','1',1,'2016-01-08 10:36:38',1,'2016-01-08 12:59:38'),(28,18,'Mrs.','asd','asdasd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'123213','sdasd@asdas.comn',NULL,'0','1',1,'2016-01-08 17:43:52',1,'2016-01-08 17:43:52');

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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

/*Data for the table `co_users_roles` */

insert  into `co_users_roles`(`user_role_id`,`tenant_id`,`user_id`,`role_id`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,18,1,1,1,'2015-12-30 16:07:24',NULL,NULL),(3,23,6,6,0,'2015-12-30 17:04:15',NULL,NULL),(4,24,7,7,-1,'2015-12-30 20:29:03',NULL,NULL),(5,25,8,8,-1,'2015-12-30 20:39:55',NULL,NULL),(6,26,9,9,-1,'2015-12-30 20:40:45',NULL,NULL),(7,27,10,10,-1,'2015-12-30 20:41:39',NULL,NULL),(8,28,11,11,-1,'2015-12-30 20:42:29',NULL,NULL),(9,29,12,12,-1,'2015-12-30 20:43:31',NULL,NULL),(10,30,13,13,-1,'2015-12-30 20:50:23',NULL,NULL),(12,32,15,15,-1,'2015-12-31 19:28:42',NULL,NULL),(13,33,16,16,-1,'2016-01-02 15:07:37',NULL,NULL),(14,34,17,17,-1,'2016-01-02 15:52:35',NULL,NULL),(15,35,18,18,-1,'2016-01-02 16:03:13',NULL,NULL),(16,36,19,19,-1,'2016-01-02 18:20:39',NULL,NULL),(17,37,20,20,-1,'2016-01-02 19:16:53',NULL,NULL),(18,38,21,21,-1,'2016-01-07 12:15:40',NULL,NULL),(19,39,22,26,-1,'2016-01-07 16:00:58',NULL,NULL),(20,40,23,27,-1,'2016-01-07 16:03:33',NULL,NULL),(21,41,24,28,-1,'2016-01-07 16:09:30',NULL,NULL),(22,42,25,29,-1,'2016-01-07 16:11:01',NULL,NULL),(23,43,26,30,-1,'2016-01-07 16:12:48',NULL,NULL),(26,18,1,22,1,'2016-01-08 19:16:22',NULL,NULL),(28,18,18,1,1,'2016-01-08 19:57:42',NULL,NULL),(29,18,18,22,1,'2016-01-08 19:57:43',NULL,NULL),(30,18,1,31,1,'2016-01-09 10:43:47',NULL,NULL),(32,18,27,1,0,'2016-01-09 10:46:36',1,'2016-01-09 10:46:36'),(33,18,27,31,0,'2016-01-09 10:46:36',1,'2016-01-09 10:46:36'),(34,18,27,25,0,'2016-01-09 10:46:36',1,'2016-01-09 10:46:36'),(35,18,28,1,0,'2016-01-09 10:48:02',1,'2016-01-09 10:48:02'),(36,18,28,22,0,'2016-01-09 10:48:02',1,'2016-01-09 10:48:02'),(37,18,27,23,0,'2016-01-09 11:00:27',1,'2016-01-09 11:00:27');

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
  UNIQUE KEY `WardNameUnique` (`tenant_id`,`ward_name`),
  KEY `FK_co_ward_floor` (`floor_id`),
  CONSTRAINT `FK_co_ward_floor` FOREIGN KEY (`floor_id`) REFERENCES `co_floor` (`floor_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_co_ward_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `co_ward` */

insert  into `co_ward`(`ward_id`,`tenant_id`,`floor_id`,`ward_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,18,2,'Test 111','1',1,'2016-01-09 17:00:19',1,'2016-01-09 17:00:33','2016-01-09 17:00:41'),(2,18,3,'Test','1',1,'2016-01-09 17:15:17',NULL,'2016-01-09 20:52:26','0000-00-00 00:00:00');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
