
-- ----------------------------
-- Table structure for customfieldjoins
-- ----------------------------
DROP TABLE IF EXISTS `customfieldjoins`;
CREATE TABLE `customfieldjoins` (
  `customfieldsid` int(11) NOT NULL,
  `customfieldchildid` int(11) NOT NULL,
  `customfieldvalueid` int(11) NOT NULL,
  PRIMARY KEY (`customfieldsid`,`customfieldchildid`,`customfieldvalueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for customfields
-- ----------------------------
DROP TABLE IF EXISTS `customfields`;
CREATE TABLE `customfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `parentmodel` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `options` longtext COLLATE utf8_unicode_ci,
  `class` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sortorder` smallint(5) NOT NULL DEFAULT '0',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for customfieldvalues
-- ----------------------------
DROP TABLE IF EXISTS `customfieldvalues`;
CREATE TABLE `customfieldvalues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for templates
-- ----------------------------
DROP TABLE IF EXISTS `templates`;
CREATE TABLE `templates` (
  `parentmodel` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `template` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`parentmodel`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- update Settings
-- ----------------------------
UPDATE settings SET `value` = "1.2" WHERE id = "version";
UPDATE settings SET `category` = "Email" WHERE id = "siteEmailAddress";
INSERT INTO `settings` VALUES ('bccAllEmail', '0', 'Whether the BCC all email to alternative address (except password resets)', 'boolean', '1', 'Email');
INSERT INTO `settings` VALUES ('bccAllEmailTo', 'admin@domain.com', 'BCC All sent email to this address', 'string', '1', 'Email');
INSERT INTO `settings` VALUES ('approveBooking', '1', 'Whether to force new bookings to be approved by a user with the allowApproveBooking permission', 'boolean', '1', 'General');

-- ----------------------------
-- update Permissions
-- ----------------------------
INSERT INTO `permissions` (`id`, `admin`, `notes`) VALUES ('accessCustomFields', '1', 'Allow configuration of custom fields and templates');
INSERT INTO `permissions` (`id`, `admin`, `editor`, `notes`) VALUES ('allowApproveBooking','1', '1', 'Allow user to approve bookings');
INSERT INTO `permissions` (`id`, `admin`, `editor`, `notes`) VALUES ('bypassApproveBooking','1', '1', 'Allow user to automatically bypass booking approval');
-- ----------------------------
-- update events
-- ----------------------------
ALTER TABLE `events`
ADD COLUMN `status`  varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'pending' AFTER `deletedAt`;

UPDATE `events` SET `status` = "approved";
-- ----------------------------
-- update locations
-- ----------------------------
ALTER TABLE `locations`
ADD COLUMN `building`  varchar(255) NULL AFTER `colour`;

ALTER TABLE `locations`
ADD COLUMN `layouts` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL AFTER `building`;