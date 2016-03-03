-- ----------------------------
-- Table structure for repeatrules
-- ---------------------------- 
ALTER TABLE `events` 
ADD COLUMN `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
ADD COLUMN  `isNever` tinyint(1) NOT NULL DEFAULT '0',
ADD COLUMN `repeatstartsat` datetime DEFAULT NULL,
ADD COLUMN  `repeatendsAfter` tinyint(2) DEFAULT NULL,
ADD COLUMN  `repeatendsat` datetime DEFAULT NULL,
ADD COLUMN  `repeatEvery` tinyint(2) DEFAULT NULL,
ADD COLUMN  `repeatOn` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
ADD COLUMN  `repeatBy` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL ,
ADD COLUMN `ownerid`  varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL ;
CHANGE COLUMN `starts` `startsat`  datetime NULL DEFAULT NULL AFTER `title`,
CHANGE COLUMN `endsat` `endsat`  datetime NULL DEFAULT NULL AFTER `startsat`; 


INSERT INTO `settings` VALUES ('doConcurrencyCheckForBookings', '1', 'Whether to do concurrency checks when booking an event', 'boolean', '1', 'General');
INSERT INTO `settings` VALUES ('allowOverlappingBookings', '1', 'Whether to allow overlapping bookings to be created', 'boolean', '1', 'General');  
INSERT INTO `settings` VALUES ('includeAllDayEventsinConcurrency', '0', 'Whether to include all day events in concurrency checks', 'boolean', '1', 'General'); 
INSERT INTO `settings` VALUES ('useExternalAuthentication', '0', 'Whether to use local or external authentication', 'boolean', '1', 'Authentication');
INSERT INTO `settings` VALUES ('useLocalUserAccounts', '1', 'Whether to use local user accounts', 'boolean', '1', 'Authentication');
INSERT INTO `settings` VALUES ('authenticationEndPoint', 'N/A', 'External Authentication API Endpoint', 'string', '1', 'Authentication');
INSERT INTO `permissions` (`id`, `admin`, `editor`, `notes`) VALUES ('editAnyBooking', '1', '1', 'Allow user to edit any booking, not just their own');

DROP TABLE IF EXISTS `eventexceptions`;
CREATE TABLE `eventexceptions` (
  `eventid` int(11) NOT NULL,
  `exceptiondate` date NOT NULL,
  PRIMARY KEY (`eventid`,`exceptiondate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
