/*
SQLyog Ultimate v8.55 
MySQL - 5.5.36 : Database - ahana
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `co_login` */

CREATE TABLE `co_login` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `password_reset_token` varchar(255) DEFAULT NULL,
  `auth_token` varchar(255) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `activation_date` datetime DEFAULT NULL,
  `Inactivation_date` datetime DEFAULT NULL,
  PRIMARY KEY (`login_id`),
  KEY `FK_co_login_user` (`user_id`),
  CONSTRAINT `FK_co_login_user` FOREIGN KEY (`user_id`) REFERENCES `co_user_profile` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `co_login` */

/*Table structure for table `co_master_city` */

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `co_master_city` */

/*Table structure for table `co_master_country` */

CREATE TABLE `co_master_country` (
  `country_id` int(10) NOT NULL AUTO_INCREMENT,
  `country name` varchar(50) NOT NULL,
  `status` enum('0','1') DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`country_id`),
  UNIQUE KEY `CountryNameUnique` (`country name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `co_master_country` */

/*Table structure for table `co_master_state` */

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `co_master_state` */

/*Table structure for table `co_role` */

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
  CONSTRAINT `FK_co_role_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `co_role` */

/*Table structure for table `co_super_admin` */

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

insert  into `co_super_admin`(`su_id`,`username`,`password`,`authtoken`,`last_activity`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,'demo','$2y$13$pfNu2lorSgd3btV7foqp.uriRfXF.7lSi51b45oefB0V1NaObxEui','rYIzsfWBLWO9XOf2x7s8HL5O_ZJ151tc','0000-00-00 00:00:00',NULL,'0000-00-00 00:00:00',NULL,'0000-00-00 00:00:00');

/*Table structure for table `co_tenant` */

CREATE TABLE `co_tenant` (
  `tenant_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_guid` varchar(50) NOT NULL,
  `tenant_name` varchar(50) NOT NULL,
  `tenant_address` varchar(100) DEFAULT NULL,
  `tenant_city` int(11) DEFAULT NULL,
  `tenant_state` int(11) DEFAULT NULL,
  `tenant_country` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `co_tenant` */

/*Table structure for table `co_user_profile` */

CREATE TABLE `co_user_profile` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `tenant_id` int(11) NOT NULL,
  `title_code` enum('Mr.','Mrs.','Miss.','Dr.') DEFAULT 'Mr.',
  `name` varchar(50) NOT NULL,
  `designation` varchar(25) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `country_id` int(50) DEFAULT NULL,
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
  CONSTRAINT `FK_co_user_profile_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `co_tenant` (`tenant_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `co_user_profile` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
