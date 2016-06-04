/*
SQLyog Ultimate v8.55 
MySQL - 5.6.14 : Database - hms
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `co_city` */

DROP TABLE IF EXISTS `co_city`;

CREATE TABLE `co_city` (
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
  CONSTRAINT `FK_co_master_city_state` FOREIGN KEY (`state_id`) REFERENCES `co_state` (`state_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `co_city` */

insert  into `co_city`(`city_id`,`tenant_id`,`state_id`,`city_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,NULL,1,'Madurai','1',1,'2015-12-28 15:07:51',NULL,NULL,'0000-00-00 00:00:00'),(2,NULL,1,'Chennai','1',1,'2015-12-28 16:21:17',NULL,NULL,'0000-00-00 00:00:00'),(3,NULL,2,'Cochin','1',1,'2015-12-28 17:31:33',NULL,NULL,'0000-00-00 00:00:00'),(4,18,3,'Madurai','1',1,'2016-01-12 17:03:36',1,'2016-01-12 18:06:13','0000-00-00 00:00:00'),(7,18,1,'aaa','1',1,'2016-01-12 17:21:20',1,'2016-01-12 17:21:20','2016-01-12 17:21:25');

/*Table structure for table `co_country` */

DROP TABLE IF EXISTS `co_country`;

CREATE TABLE `co_country` (
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

/*Data for the table `co_country` */

insert  into `co_country`(`country_id`,`tenant_id`,`country_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,NULL,'India','1',1,'2015-12-28 15:07:32',NULL,NULL,'0000-00-00 00:00:00'),(2,18,'Pakistann','1',1,'2015-12-28 17:30:39',1,'2016-01-12 14:00:24','0000-00-00 00:00:00'),(4,18,'test','1',1,'2016-01-12 13:56:55',1,'2016-01-22 10:24:04','0000-00-00 00:00:00'),(5,18,'testss','1',1,'2016-01-12 13:57:12',1,'2016-01-12 13:57:12','2016-01-12 13:58:43'),(7,18,'test123123','1',1,'2016-01-18 16:26:07',1,'2016-01-18 16:26:07','2016-01-18 16:26:16');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Data for the table `co_organization` */

insert  into `co_organization`(`org_id`,`org_name`,`org_description`,`org_db_host`,`org_db_username`,`org_db_password`,`org_database`,`org_domain`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (7,'Org','Org','bG9jYWxob3N0','cm9vdA==',NULL,'YWhhbmE=','http://hms.ark','1',-1,'2016-02-17 18:50:12',NULL,NULL,'0000-00-00 00:00:00'),(11,'Apollo','Apollo','bG9jYWxob3N0','cm9vdA==','','YXBvbGxv','apollo.hms.ark','1',-1,'2016-04-29 16:52:39',-1,'2016-04-29 16:52:39','0000-00-00 00:00:00'),(12,'Apollo New','Apollo New','bG9jYWxob3N0','cm9vdA==','','YXBvbGxvX25ldw==','http://apollo.local','1',-1,'2016-05-12 17:11:20',-1,'2016-05-12 17:11:20','0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=latin1;

/*Data for the table `co_resources` */

insert  into `co_resources`(`resource_id`,`parent_id`,`resource_name`,`resource_url`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,NULL,'Configuration','configuration',-1,'2015-12-29 15:11:20',NULL,NULL),(2,1,'Organization Module','organization',-1,'2015-12-29 15:11:42',NULL,NULL),(3,2,'Organization','configuration.organization',-1,'2016-01-19 15:35:50',NULL,NULL),(4,2,'Organization Module','configuration.organizationModule',-1,'2016-01-19 15:36:07',NULL,NULL),(5,1,'Administrative Module','administrative',-1,'2016-01-20 11:11:09',NULL,NULL),(6,5,'Roles','configuration.roles',-1,'2016-01-20 11:11:58',NULL,NULL),(7,5,'Role Rights','configuration.roleRights',-1,'2016-01-20 11:14:04',NULL,NULL),(8,5,'User roles','configuration.userRoles',-1,'2016-01-20 11:14:31',NULL,NULL),(9,5,'Charge Category','configuration.roomChargeCategory',-1,'2016-01-20 11:15:00',NULL,NULL),(10,1,'User Module','userModule',-1,'2016-01-20 11:16:12',NULL,NULL),(11,10,'User Registration','configuration.registration',-1,'2016-01-20 11:16:50',NULL,NULL),(12,1,'Ward Management','wardManagement',-1,'2016-01-20 11:17:42',NULL,NULL),(13,12,'Floors','configuration.floors',-1,'2016-01-20 11:18:10',NULL,NULL),(14,12,'Wards','configuration.wards',-1,'2016-01-20 11:18:25',NULL,NULL),(15,12,'Bed Type','configuration.roomType',-1,'2016-01-20 11:18:48',NULL,NULL),(16,12,'Room','configuration.room',-1,'2016-01-20 11:19:17',NULL,NULL),(17,12,'Room and Bed Type','configuration.roomTypeRoom',-1,'2016-01-20 11:20:39',NULL,NULL),(18,1,'Charges Configuration','chargesConfiguration',-1,'2016-01-20 11:21:17',NULL,NULL),(19,18,'Room Charge','configuration.roomCharge',-1,'2016-01-20 11:21:40',NULL,NULL),(20,18,'Room Maintenance','configuration.roomMaintenance',-1,'2016-01-20 11:21:59',NULL,NULL),(21,18,'Charges for Category','configuration.chargePerCategory',-1,'2016-01-20 11:22:20',NULL,NULL),(22,1,'Doctor’s Configuration','doctorsConfiguration',-1,'2016-01-20 11:22:59',NULL,NULL),(23,22,'Doctors Schedule','configuration.docSchedule',-1,'2016-01-20 11:23:20',NULL,NULL),(24,22,'Specialities','configuration.specialities',-1,'2016-01-20 11:23:39',NULL,NULL),(25,1,'Miscellaneous','miscellaneous',-1,'2016-01-20 11:24:17',NULL,NULL),(26,25,'Alerts','configuration.alerts',-1,'2016-01-20 11:24:32',NULL,NULL),(27,25,'Patient Category','configuration.patientCategories',-1,'2016-01-20 11:24:47',NULL,NULL),(28,25,'Bill-No Prefix','configuration.internalCode',-1,'2016-01-20 11:25:06',NULL,NULL),(29,25,'Master Country','configuration.countries',-1,'2016-01-20 11:25:22',NULL,NULL),(30,25,'Master State','configuration.states',-1,'2016-01-20 11:25:35',NULL,NULL),(31,25,'Master City','configuration.cities',-1,'2016-01-20 11:25:52',NULL,NULL),(32,5,'Room Charge Item','configuration.roomChargeCategoryItem',-1,'2016-02-01 12:04:21',NULL,NULL),(33,5,'Allied Charges','configuration.alliedCharge',-1,'2016-02-03 15:31:05',NULL,NULL),(34,5,'Procedures','configuration.procedure',-1,'2016-02-05 15:43:00',NULL,NULL),(35,6,'Add Role','configuration.role_create',-1,'2016-02-08 15:16:27',NULL,NULL),(36,6,'Update Role','configuration.role_update',-1,'2016-02-08 15:17:21',NULL,NULL),(37,6,'Delete Role','configuration.role_delete',-1,'2016-02-08 15:18:46',NULL,NULL),(38,9,'Add Charge Category','configuration.roomChargeCategoryCreate',-1,'2016-02-08 15:20:26',NULL,NULL),(39,9,'Update Charge Category','configuration.roomChargeCategoryUpdate',-1,'2016-02-08 15:20:26',NULL,NULL),(40,9,'Delete Charge Category','configuration.roomChargeCategoryDelete',-1,'2016-02-08 15:20:27',NULL,NULL),(41,32,'Add Room Charge Item','configuration.roomChargeCategoryItemCreate',-1,'2016-02-08 15:21:56',NULL,NULL),(42,32,'Update Room Charge Item','configuration.roomChargeCategoryItemUpdate',-1,'2016-02-08 15:21:56',NULL,NULL),(43,32,'Delete Room Charge Item','configuration.roomChargeCategoryItemDelete',-1,'2016-02-08 15:21:56',NULL,NULL),(44,33,'Add Allied Charges','configuration.alliedChargeCreate',-1,'2016-02-08 15:31:45',NULL,NULL),(45,33,'Update Allied Charges','configuration.alliedChargeUpdate',-1,'2016-02-08 15:31:45',NULL,NULL),(46,33,'Delete Allied Charges','configuration.alliedChargeDelete',-1,'2016-02-08 15:31:45',NULL,NULL),(47,34,'Add Procedures','configuration.procedureChargeCreate',-1,'2016-02-08 15:38:42',NULL,NULL),(48,34,'Update Procedures','configuration.procedureChargeUpdate',-1,'2016-02-08 15:38:42',NULL,NULL),(49,34,'Delete Procedures','configuration.procedureChargeDelete',-1,'2016-02-08 15:38:42',NULL,NULL),(54,11,'Add User','configuration.user_create',-1,'2016-02-08 15:41:39',NULL,NULL),(55,11,'Update User','configuration.user_update',-1,'2016-02-08 15:41:39',NULL,NULL),(56,11,'Delete User','configuration.user_delete',-1,'2016-02-08 15:41:39',NULL,NULL),(57,11,'Add/Update Login','configuration.login_update',-1,'2016-02-08 15:41:39',NULL,NULL),(58,13,'Add Floor','configuration.floor_create',-1,'2016-02-08 15:49:25',NULL,NULL),(59,13,'Update Floor','configuration.floor_update',-1,'2016-02-08 15:49:25',NULL,NULL),(60,13,'Delete Floor','configuration.floor_delete',-1,'2016-02-08 15:49:25',NULL,NULL),(61,14,'Add Ward','configuration.ward_create',-1,'2016-02-08 15:50:14',NULL,NULL),(62,14,'Update Ward','configuration.ward_update',-1,'2016-02-08 15:50:14',NULL,NULL),(63,14,'Delete Ward','configuration.ward_delete',-1,'2016-02-08 15:50:14',NULL,NULL),(64,15,'Add Bed Type','configuration.roomTypeCreate',-1,'2016-02-08 15:51:19',NULL,NULL),(65,15,'Update Bed Type','configuration.roomTypeUpdate',-1,'2016-02-08 15:51:19',NULL,NULL),(66,15,'Delete Bed Type','configuration.roomTypeDelete',-1,'2016-02-08 15:51:19',NULL,NULL),(67,16,'Add Room','configuration.roomCreate',-1,'2016-02-08 15:52:21',NULL,NULL),(68,16,'Update Room','configuration.roomUpdate',-1,'2016-02-08 15:52:21',NULL,NULL),(69,16,'Delete Room','configuration.roomDelete',-1,'2016-02-08 15:52:21',NULL,NULL),(70,17,'Assign Room and Bed Types','configuration.roomTypeRoomUpdate',-1,'2016-02-08 15:53:47',NULL,NULL),(71,19,'Create RoomCharge','configuration.roomChargeCreate',-1,'2016-02-08 15:55:00',NULL,NULL),(72,19,'Update RoomCharge','configuration.roomChargeUpdate',-1,'2016-02-08 15:55:00',NULL,NULL),(73,19,'Delete RoomCharge','configuration.roomChargeDelete',-1,'2016-02-08 15:55:00',NULL,NULL),(74,20,'Create Room Maintenance','configuration.roomMaintenanceCreate',-1,'2016-02-08 15:55:59',NULL,NULL),(75,20,'Update Room Maintenance','configuration.roomMaintenanceUpdate',-1,'2016-02-08 15:55:59',NULL,NULL),(76,20,'Delete Room Maintenance','configuration.roomMaintenanceDelete',-1,'2016-02-08 15:55:59',NULL,NULL),(77,21,'Create Charges for Category','configuration.chargePerCategoryCreate',-1,'2016-02-08 16:00:51',NULL,NULL),(78,22,'Create Doctor Schedule','configuration.docScheduleCreate',-1,'2016-02-08 16:02:26',NULL,NULL),(79,22,'Update Doctor Schedule','configuration.docScheduleUpdate',-1,'2016-02-08 16:02:26',NULL,NULL),(80,22,'Delete Doctor Schedule','configuration.docScheduleDelete',-1,'2016-02-08 16:02:26',NULL,NULL),(81,24,'Create Speciality','configuration.specialityCreate',-1,'2016-02-08 16:03:14',NULL,NULL),(82,24,'Update Speciality','configuration.specialityUpdate',-1,'2016-02-08 16:03:14',NULL,NULL),(83,24,'Delete Speciality','configuration.specialityDelete',-1,'2016-02-08 16:03:14',NULL,NULL),(84,26,'Create Alerts','configuration.alertCreate',-1,'2016-02-08 16:04:00',NULL,NULL),(85,26,'Update Alerts','configuration.alertUpdate',-1,'2016-02-08 16:04:00',NULL,NULL),(86,26,'Delete Alerts','configuration.alertDelete',-1,'2016-02-08 16:04:00',NULL,NULL),(87,27,'Create Patient Category','configuration.patientCategoryCreate',-1,'2016-02-08 16:04:42',NULL,NULL),(88,27,'Update Patient Category','configuration.patientCategoryUpdate',-1,'2016-02-08 16:04:42',NULL,NULL),(89,27,'Delete Patient Category','configuration.patientCategoryDelete',-1,'2016-02-08 16:04:42',NULL,NULL),(90,29,'Create Country','configuration.countryCreate',-1,'2016-02-08 16:05:26',NULL,NULL),(91,29,'Update Country','configuration.countryUpdate',-1,'2016-02-08 16:05:27',NULL,NULL),(92,29,'Delete Country','configuration.countryDelete',-1,'2016-02-08 16:05:27',NULL,NULL),(93,30,'Create State','configuration.stateCreate',-1,'2016-02-08 16:06:03',NULL,NULL),(94,30,'Update State','configuration.stateUpdate',-1,'2016-02-08 16:06:03',NULL,NULL),(95,30,'Delete State','configuration.stateDelete',-1,'2016-02-08 16:06:03',NULL,NULL),(96,31,'Create City','configuration.cityCreate',-1,'2016-02-08 16:06:59',NULL,NULL),(97,31,'Update City','configuration.cityUpdate',-1,'2016-02-08 16:06:59',NULL,NULL),(98,31,'Delete City','configuration.cityDelete',-1,'2016-02-08 16:06:59',NULL,NULL),(99,NULL,'Patient','patient',-1,'2016-02-09 12:15:31',NULL,NULL),(100,99,'Details','patient.view',-1,'2016-02-09 12:16:49',NULL,NULL),(101,99,'Timeline','patient.timeLine',-1,'2016-02-09 12:17:35',NULL,NULL),(102,99,'Documents','patient.documents',-1,'2016-02-09 12:17:43',NULL,NULL),(103,99,'Encounter','patient.encounter',-1,'2016-02-09 12:17:57',NULL,NULL),(104,99,'Notes','patient.notes',-1,'2016-02-09 12:18:01',NULL,NULL),(105,99,'Consultant','patient.consultant',-1,'2016-02-09 12:18:12',NULL,NULL),(106,99,'Procedure','patient.procedure',-1,'2016-02-09 12:18:22',NULL,NULL),(107,99,'Prescription','patient.prescription',-1,'2016-02-09 12:18:45',NULL,NULL),(108,99,'Alert','patient.alert',-1,'2016-02-09 12:18:55',NULL,NULL),(109,99,'Update Patient','patient.update',-1,'2016-03-29 19:16:49',NULL,NULL),(110,104,'Create Note','patient.noteCreate',-1,'2016-03-29 19:17:30',NULL,NULL),(111,104,'Update Note','patient.noteUpdate',-1,'2016-03-29 19:17:55',NULL,NULL),(112,104,'View Note','patient.noteView',-1,'2016-03-29 19:18:15',NULL,NULL),(113,105,'Create Consultant','patient.consultantCreate',-1,'2016-03-29 19:18:58',NULL,NULL),(114,105,'Update Consultant','patient.consultantUpdate',-1,'2016-03-29 19:23:26',NULL,NULL),(115,105,'Delete Consultant','patient.consultantDelete',-1,'2016-03-29 19:23:58',NULL,NULL),(116,106,'Add Procedure','patient.add_procedure',-1,'2016-03-29 19:24:29',NULL,NULL),(117,106,'Update Procedure','patient.edit_procedure',-1,'2016-03-29 19:24:54',NULL,NULL),(118,106,'Delete Procedure','patient.delete_procedure',-1,'2016-03-29 19:25:10',NULL,NULL),(119,108,'Create Alert','patient.alertCreate',-1,'2016-03-29 19:25:45',NULL,NULL),(120,108,'Update Alert','patient.alertUpdate',-1,'2016-03-29 19:26:03',NULL,NULL),(121,103,'Create Admission','patient.admission',-1,'2016-03-29 19:30:01',NULL,NULL),(122,103,'Create Appointment','patient.appointment',-1,'2016-03-29 19:30:22',NULL,NULL),(123,103,'Transfer','patient.transfer',-1,'2016-03-29 19:31:07',NULL,NULL),(124,103,'Discharge','patient.discharge',-1,'2016-03-29 19:31:31',NULL,NULL),(125,103,'Swapping','patient.swapping',-1,'2016-03-29 19:31:51',NULL,NULL),(126,103,'Change Appointment status','patient.changeStatus',-1,'2016-03-29 19:32:47',NULL,NULL),(127,103,'Cancel Appointment','patient.cancelAppointment',-1,'2016-03-29 19:33:56',NULL,NULL),(128,103,'Edit Doctor Fee','patient.editDoctorFee',-1,'2016-03-29 19:34:57',NULL,NULL),(129,99,'Billing','patient.billing',-1,'2016-03-29 19:38:05',NULL,NULL),(130,129,'Add Other Charges','patient.addOtherCharge',-1,'2016-03-29 19:38:32',NULL,NULL),(131,129,'Edit Other Charges','patient.editOtherCharge',-1,'2016-03-29 19:39:06',NULL,NULL),(132,129,'Add Extra Amount','patient.addExtraAmount',-1,'2016-03-29 19:39:36',NULL,NULL),(133,129,'Add Concession Amount','patient.addConcessionAmount',-1,'2016-03-29 19:39:59',NULL,NULL),(134,129,'Add Payment','patient.addPayment',-1,'2016-03-29 19:40:24',NULL,NULL),(135,129,'Edit Payment','patient.editPayment',-1,'2016-03-29 19:41:15',NULL,NULL),(136,129,'Delete Payment','patient.deletePayment',-1,'2016-03-29 19:41:53',NULL,NULL),(137,129,'Add Room Concession','patient.roomConcession',-1,'2016-03-29 19:42:17',NULL,NULL),(138,129,'Finalize','patient.finalize',-1,'2016-03-29 19:42:39',NULL,NULL),(139,129,'Unfinalize','patient.unfinalize',-1,'2016-03-29 19:42:54',NULL,NULL),(140,129,'Authorize','patient.authorize',-1,'2016-03-29 19:43:19',NULL,NULL),(141,129,'Unauthorize','patient.unathorize',-1,'2016-03-29 19:44:04',NULL,NULL),(142,99,'In-Patient','patient.inPatients',-1,'2016-05-12 11:20:52',NULL,NULL),(143,99,'Out-Patient','patient.outPatients',-1,'2016-05-12 11:21:47',NULL,NULL),(144,NULL,'Pharmacy','pharmacy',-1,'2016-05-12 12:32:29',NULL,NULL),(145,144,'Purchase','pharmacy.purchase',-1,'2016-05-12 12:43:50',NULL,NULL),(146,145,'Add Purchase','pharmacy.purchaseCreate',-1,'2016-05-12 12:32:51',NULL,NULL),(147,145,'Edit Purchase','pharmacy.purchaseUpdate',-1,'2016-05-12 12:33:27',NULL,NULL),(148,144,'Purchase Return','pharmacy.purchaseReturn',-1,'2016-05-12 12:44:58',NULL,NULL),(149,148,'Add Purchase Return','pharmacy.purchaseReturnCreate',-1,'2016-05-12 12:45:42',NULL,NULL),(150,148,'Edit Purchase Return','pharmacy.purchaseReturnUpdate',-1,'2016-05-12 12:46:08',NULL,NULL),(151,144,'Sale','pharmacy.sales',-1,'2016-05-12 12:46:55',NULL,NULL),(152,151,'Add Sale','pharmacy.saleCreate',-1,'2016-05-12 12:47:06',NULL,NULL),(153,151,'Edit Sale','pharmacy.saleUpdate',-1,'2016-05-12 12:51:53',NULL,NULL),(154,144,'Sale Return','pharmacy.saleReturn',-1,'2016-05-12 12:52:48',NULL,NULL),(155,154,'Add Sale Return','pharmacy.saleReturnCreate',-1,'2016-05-12 12:53:07',NULL,NULL),(156,154,'Edit Sale Return','pharmacy.saleReturnUpdate',-1,'2016-05-12 12:53:49',NULL,NULL),(157,144,'Reports','pharmacy.report',-1,'2016-05-12 12:57:49',NULL,NULL),(158,144,'Stock Detail','pharmacy.stock',-1,'2016-05-12 12:59:19',NULL,NULL),(159,158,'Batch Details','pharmacy.batchDetails',-1,'2016-05-12 12:59:38',NULL,NULL),(160,158,'Stock Adjust','pharmacy.stockAdjust',-1,'2016-05-12 12:59:57',NULL,NULL),(161,144,'Configuration','pharmacy.configuration',-1,'2016-05-12 13:00:41',NULL,NULL),(162,161,'Brand','pharmacy.brand',-1,'2016-05-12 13:01:25',NULL,NULL),(163,161,'Brand Rep','pharmacy.brandrep',-1,'2016-05-12 13:01:45',NULL,NULL),(164,161,'Products','pharmacy.products',-1,'2016-05-12 13:02:11',NULL,NULL),(165,161,'Supplier','pharmacy.supplier',-1,'2016-05-12 13:02:28',NULL,NULL),(166,162,'Add Brand','pharmacy.brandCreate',-1,'2016-05-12 13:03:07',NULL,NULL),(167,162,'Edit Brand','pharmacy.brandUpdate',-1,'2016-05-12 13:03:27',NULL,NULL),(168,163,'Add Brand Rep','pharmacy.brandrepCreate',-1,'2016-05-12 13:03:47',NULL,NULL),(169,163,'Edit Brand Rep','pharmacy.brandrepUpdate',-1,'2016-05-12 13:04:04',NULL,NULL),(170,164,'Add Product','pharmacy.productAdd',-1,'2016-05-12 13:05:09',NULL,NULL),(171,164,'Edit Product','pharmacy.productEdit',-1,'2016-05-12 13:05:22',NULL,NULL),(172,165,'Add Supplier','pharmacy.supplierCreate',-1,'2016-05-12 13:05:46',NULL,NULL),(173,165,'Edit Supplier','pharmacy.supplierUpdate',-1,'2016-05-12 13:05:58',NULL,NULL),(174,161,'Brand Division','pharmacy.brandDivision',-1,'2016-05-12 13:06:54',NULL,NULL),(175,174,'Add Brand Division','pharmacy.brandDivisionCreate',-1,'2016-05-12 13:08:16',NULL,NULL),(176,174,'Edit Brand Division','pharmacy.brandDivisionUpdate',-1,'2016-05-12 13:08:42',NULL,NULL),(177,161,'Drug Class','pharmacy.drugclass',-1,'2016-05-12 13:17:33',NULL,NULL),(178,177,'Add Drug Class','pharmacy.drugclassCreate',-1,'2016-05-12 13:17:58',NULL,NULL),(179,177,'Edit Drug Class','pharmacy.drugclassUpdate',-1,'2016-05-12 13:18:57',NULL,NULL),(180,161,'Generic Names','pharmacy.drugclass',-1,'2016-05-12 13:19:41',NULL,NULL),(181,180,'Add Generic Name','pharmacy.genericNameCreate',-1,'2016-05-12 13:20:14',NULL,NULL),(182,180,'Edit Generic Name','pharmacy.genericNameUpdate',-1,'2016-05-12 13:20:32',NULL,NULL),(183,161,'Drug Class & Generic','pharmacy.drugGeneric',-1,'2016-05-12 13:21:01',NULL,NULL),(184,183,'Add Drug Class & Generic','pharmacy.drugGenericCreate',-1,'2016-05-12 13:21:46',NULL,NULL),(185,183,'Edit Drug Class & Generic','pharmacy.drugGenericUpdate',-1,'2016-05-12 13:22:09',NULL,NULL),(186,161,'Product Description','pharmacy.prodesc',-1,'2016-05-12 13:22:52',NULL,NULL),(187,186,'Add Product Description','pharmacy.prodescCreate',-1,'2016-05-12 13:23:15',NULL,NULL),(188,186,'Edit Product Description','pharmacy.prodescUpdate',-1,'2016-05-12 13:23:41',NULL,NULL),(189,161,'Vat','pharmacy.vat',-1,'2016-05-12 13:24:16',NULL,NULL),(190,189,'Add Vat','pharmacy.vatCreate',-1,'2016-05-12 13:24:35',NULL,NULL),(191,189,'Edit Vat','pharmacy.vatUpdate',-1,'2016-05-12 13:24:47',NULL,NULL),(192,161,'Packing Unit','pharmacy.packingUnit',-1,'2016-05-12 13:25:22',NULL,NULL),(193,192,'Add Packing Unit','pharmacy.packingUnitCreate',-1,'2016-05-12 13:25:39',NULL,NULL),(194,192,'Edit Packing Unit','pharmacy.packingUnitUpdate',-1,'2016-05-12 13:25:56',NULL,NULL),(195,99,'Patient Registration','patient.registration',-1,'2016-05-12 17:39:56',NULL,NULL),(196,129,'Administrative Discharge','patient.admindischarge',-1,'2016-05-13 11:16:11',NULL,NULL),(197,103,'Future Appointment','patient.futureAppointment',-1,'2016-05-18 15:24:32',NULL,NULL),(198,103,'Future Appointment List','patient.futureAppointmentList',-1,'2016-05-18 15:24:53',NULL,NULL),(199,99,'Vitals','patient.vitals',-1,'2016-05-18 15:25:36',NULL,NULL),(200,199,'Add Vitals','patient.vitalCreate',-1,'2016-05-18 15:28:20',NULL,NULL),(201,99,'Modify Casesheet No.','patient.modifyCaseSheetNo',-1,'2016-05-20 13:07:44',NULL,NULL),(202,99,'Modify Admission','patient.update_admission',-1,'2016-05-20 13:39:02',NULL,NULL),(203,99,'Backdate appointments','patient.backdateappointment',-1,'2016-05-21 16:36:48',NULL,NULL),(204,144,'Sale Billing','pharmacy.makePayment',-1,'2016-05-23 12:23:20',NULL,NULL),(205,103,'Cancel Last Encounter','patient.cancelLastEncounter',-1,'2016-05-24 17:34:12',NULL,NULL),(206,103,'Cancel Admission','patient.cancelAdmission',-1,'2016-05-24 17:37:21',NULL,NULL),(207,16,'Room Maintanance','configuration.updateMaintenance',-1,'2016-05-31 15:27:55',NULL,NULL),(208,99,'Documents','patient.document',-1,'2016-05-31 15:28:11',NULL,NULL),(209,208,'Add Document','patient.addDocument',-1,'2016-05-31 16:51:45',NULL,NULL),(210,208,'Edit Document','patient.editDocument',-1,'2016-05-31 16:52:05',NULL,NULL);

/*Table structure for table `co_state` */

DROP TABLE IF EXISTS `co_state`;

CREATE TABLE `co_state` (
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
  CONSTRAINT `FK_co_master_state_country` FOREIGN KEY (`country_id`) REFERENCES `co_country` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `co_state` */

insert  into `co_state`(`state_id`,`tenant_id`,`country_id`,`state_name`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (1,NULL,1,'Tamil Nadu','1',1,'2015-12-28 15:07:43',NULL,NULL,'0000-00-00 00:00:00'),(2,NULL,1,'Kerala','1',1,'2015-12-28 17:30:49',NULL,NULL,'0000-00-00 00:00:00'),(3,NULL,2,'Islamabad','1',1,'2015-12-28 17:31:13',NULL,NULL,'0000-00-00 00:00:00'),(4,18,1,'Test','1',1,'2016-01-12 15:44:25',1,'2016-01-12 18:07:08','0000-00-00 00:00:00'),(6,18,1,'Tester','1',1,'2016-01-12 15:47:54',1,'2016-01-12 15:49:00','2016-01-12 16:22:25');

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

insert  into `co_super_admin`(`su_id`,`username`,`password`,`authtoken`,`last_activity`,`created_by`,`created_at`,`modified_by`,`modified_at`) values (1,'demo','$2y$13$pfNu2lorSgd3btV7foqp.uriRfXF.7lSi51b45oefB0V1NaObxEui','ZGVtbzE0NjMwNTM1NDI3MDQw','0000-00-00 00:00:00',NULL,'0000-00-00 00:00:00',-1,'2016-01-07 11:46:28');

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
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;

/*Data for the table `co_tenant` */

insert  into `co_tenant`(`tenant_id`,`org_id`,`tenant_guid`,`tenant_name`,`tenant_address`,`tenant_city_id`,`tenant_state_id`,`tenant_country_id`,`tenant_contact1`,`tenant_contact2`,`tenant_fax`,`tenant_mobile`,`tenant_email`,`tenant_url`,`slug`,`status`,`created_by`,`created_at`,`modified_by`,`modified_at`,`deleted_at`) values (58,7,'','Ahana','Gandhi Nagar 2 ',1,1,1,'123',NULL,NULL,NULL,'vikhram@ahana.com','http://ahana.com','','1',-1,'2016-02-02 22:26:38',-1,'2016-03-01 13:41:11','0000-00-00 00:00:00'),(59,7,'','Ark Infotec','Bye-pass',4,3,2,'123','','','','gayatri@ark.com','http://ark.com','','0',-1,'2016-02-02 22:43:11',-1,'2016-03-01 13:46:12','0000-00-00 00:00:00'),(60,7,'','Radianz','rad',2,1,1,'123123',NULL,NULL,NULL,'abc@radianz.com',NULL,'','1',-1,'2016-02-17 06:28:38',-1,'2016-03-01 13:46:25','0000-00-00 00:00:00'),(61,7,NULL,'test','test',1,8,7,'99999999',NULL,NULL,NULL,'test.t@gm.xc','http://ahanahospitals.in/',NULL,'1',-1,'2016-02-21 23:16:05',-1,'2016-02-21 23:16:05','0000-00-00 00:00:00'),(62,0,NULL,'test test','test',5,8,7,'2323232323','',NULL,NULL,'34343@3444.3',NULL,NULL,'1',-1,'2016-02-29 02:00:01',-1,'2016-02-29 02:08:44','0000-00-00 00:00:00'),(63,8,NULL,'Apollo','Apollo',1,1,1,'1232313123',NULL,NULL,NULL,'test@test.com',NULL,NULL,'1',-1,'2016-03-01 13:34:42',-1,'2016-03-01 13:45:30','0000-00-00 00:00:00'),(64,9,NULL,'Apollo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',-1,'2016-04-29 16:40:49',-1,'2016-04-29 16:40:49','0000-00-00 00:00:00'),(65,10,NULL,'Apollo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',-1,'2016-04-29 16:45:21',-1,'2016-04-29 16:45:21','0000-00-00 00:00:00'),(66,11,NULL,'Apollo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1',-1,'2016-04-29 16:52:40',-1,'2016-04-29 16:52:40','0000-00-00 00:00:00'),(67,12,NULL,'Apollo New','adsdsadasd',1,1,1,'2312323123',NULL,NULL,NULL,'adsd!@adasd.com',NULL,NULL,'1',-1,'2016-05-12 17:11:20',-1,'2016-05-12 17:16:11','0000-00-00 00:00:00');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
