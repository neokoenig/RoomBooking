/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50525
Source Host           : localhost:3306
Source Database       : roombooking

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2014-10-25 10:01:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for events
-- ----------------------------
DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `allday` int(11) NOT NULL DEFAULT '0',
  `url` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `className` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `locationid` int(11) NOT NULL DEFAULT '0',
  `contactname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactno` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactemail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `layoutstyle` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Standard',
  `createdat` datetime DEFAULT NULL,
  `updatedat` datetime DEFAULT NULL,
  `deletedat` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of events
-- ----------------------------

-- ----------------------------
-- Table structure for locations
-- ----------------------------
DROP TABLE IF EXISTS `locations`;
CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `class` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `colour` varchar(7) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of locations
-- ----------------------------
INSERT INTO `locations` VALUES ('1', 'Lecture Theatre', 'First Floor', 'lt', '#cc0000');
INSERT INTO `locations` VALUES ('2', 'Seminar Room 1', 'Ground Floor', 'sm1', '#2c86ff');
INSERT INTO `locations` VALUES ('3', 'Seminar Room 2', 'Ground Floor', 'sm2', '#a1a100');
INSERT INTO `locations` VALUES ('4', 'Conference Room', 'Ground Floor', 'gfcr', '#FF6600');
INSERT INTO `locations` VALUES ('5', 'Café', 'First Floor', 'cafe', '#800080');
INSERT INTO `locations` VALUES ('6', 'AV Suite', 'Basement', 'avsuite', '#167362');

-- ----------------------------
-- Table structure for logfiles
-- ----------------------------
DROP TABLE IF EXISTS `logfiles`;
CREATE TABLE `logfiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `ipaddress` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `userid` int(11) NOT NULL DEFAULT '0',
  `createdat` datetime DEFAULT NULL,
  `updatedat` datetime DEFAULT NULL,
  `deletedat` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3387 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `admin` int(1) NOT NULL DEFAULT '0',
  `editor` int(1) NOT NULL DEFAULT '0',
  `user` int(1) NOT NULL DEFAULT '0',
  `guest` int(1) NOT NULL DEFAULT '0',
  `notes` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of permissions
-- ----------------------------
INSERT INTO `permissions` VALUES ('accessApplication', '1', '1', '1', '1', 'Allow access to the application');
INSERT INTO `permissions` VALUES ('accessCalendar', '1', '1', '1', '1', 'Allow access to the calendar');
INSERT INTO `permissions` VALUES ('viewRoomBooking', '1', '1', '1', '1', 'View Room Booking Details');
INSERT INTO `permissions` VALUES ('allowAPI', '1', '1', '1', '1', 'Reserved for future use');
INSERT INTO `permissions` VALUES ('allowiCal', '1', '1', '1', '1', 'Reserved for future use');
INSERT INTO `permissions` VALUES ('allowRSS', '1', '1', '1', '1', 'Reserved for future use');
INSERT INTO `permissions` VALUES ('allowRoomBooking', '1', '1', '1', '0', 'Allow Facility to create events');
INSERT INTO `permissions` VALUES ('updateOwnAccount', '1', '1', '1', '0', 'Allows a user to update their own details');
INSERT INTO `permissions` VALUES ('accessLocations', '1', '1', '0', '0', 'Allow access to Locations Editing');
INSERT INTO `permissions` VALUES ('accessSettings', '1', '1', '0', '0', 'Allow access to Settings');
INSERT INTO `permissions` VALUES ('accessLogfiles', '1', '0', '0', '0', 'Allow access to Logfiles');
INSERT INTO `permissions` VALUES ('accessPermissions', '1', '0', '0', '0', 'Allow access to Permissions');
INSERT INTO `permissions` VALUES ('accessUsers', '1', '0', '0', '0', 'Allow access to User Accounts');

-- ----------------------------
-- Table structure for settings
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `notes` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fieldtype` varchar(55) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'integer',
  `editable` int(1) NOT NULL DEFAULT '1',
  `category` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'general',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of settings
-- ----------------------------
INSERT INTO `settings` VALUES ('allowLocations', '1', 'setting to zero will disable the facility to edit all locations via the web interface', 'boolean', '1', 'Locations');
INSERT INTO `settings` VALUES ('allowSettings', '1', 'Warning - setting to zero will disable the facility to edit all settings via the web interface, and will only be editable via the database directly', 'boolean', '1', 'General');
INSERT INTO `settings` VALUES ('allowThemes', '1', 'setting to zero will disable the theme preview dropdown', 'boolean', '1', 'Styling');
INSERT INTO `settings` VALUES ('bootstraptheme', 'cosmo', 'Current bootstrap bootswatch theme to use - requires using CDN option', 'string', '1', 'Styling');
INSERT INTO `settings` VALUES ('bootstrapthemeoptions', 'amelia,cerulean,cosmo,cyborg,flatly,journal,readable,simplex,slate,spacelab,united', 'List of possible Bootstrap 3 theme names', 'string', '0', 'Styling');
INSERT INTO `settings` VALUES ('calendarAllDaySlot', '1', 'Determines if the \"all-day\" slot is displayed at the top of the calendar.', 'boolean', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarAllDayText', 'all-day', 'The text titling the \"all-day\" slot at the top of the calendar.', 'string', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarAxisFormat', 'h(:mm)tt', 'Determines the time-text that will be displayed on the vertical axis of the agenda views', 'string', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarColumnFormatDay', 'dddd d/M', 'Column format for day', 'string', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarColumnFormatMonth', 'ddd', 'Column format for month', 'string', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarColumnFormatWeek', 'ddd d/M', 'Column format for week', 'string', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarDefaultView', 'month', 'Calendar Default View - Can be month, basicWeek, basicDay etc', 'string', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarFirstday', '1', 'Start Calendar on this day of the week: 1 = Monday, 0 = Sunday', 'boolean', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarHeadercenter', 'title', 'Calendar Header Display, center - see http://arshaw.com/fullcalendar/docs/display/header/', 'string', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarHeaderleft', 'prev,next today', 'Calendar Header Display, left - see http://arshaw.com/fullcalendar/docs/display/header/', 'string', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarHeaderright', 'month,agendaWeek,agendaDay', 'Calendar Header Display, right - see http://arshaw.com/fullcalendar/docs/display/header/', 'string', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarHiddenDays', '[]', 'Hide certain days (Comma Delim List in array, i.e [1,3,5] )', 'string', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarMintime', '7am', 'Calendar Minimum Time to display', 'string', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarSlotEventOverlap', '1', 'Determines if timed events in agenda view should visually overlap', 'boolean', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarSlotMinutes', '15', 'Calendar No of minutes to increment minutes in (integer)', 'string', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarTimeformat', 'H:mm', 'Calendar Time Format', 'string', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarWeekends', '1', 'Calendar Whether to show weekends', 'boolean', '1', 'Calendar');
INSERT INTO `settings` VALUES ('calendarWeekNumbers', '0', 'Determines if week numbers should be displayed on the calendar.', 'boolean', '1', 'Calendar');
INSERT INTO `settings` VALUES ('defaultDateFormat', 'DD MMM YYYY', 'Default Date Format (agenda view etc)', 'string', '1', 'general');
INSERT INTO `settings` VALUES ('defaultTimeFormat', 'HH:MM', 'Default Time Format (agenda view etc)', 'string', '1', 'general');
INSERT INTO `settings` VALUES ('googleanalytics', 'UA-', 'Google Anayltics Tracking Code (format: UA-XXXXX-X), set to UA- to omit', 'string', '1', 'General');
INSERT INTO `settings` VALUES ('isDemoMode', '0', 'Put the board into demo mode', 'boolean', '0', 'General');
INSERT INTO `settings` VALUES ('roomlayouttypes', 'Standard,Boardroom,Lecture', 'Room Layout Types (Comma Deliminated List of Values)', 'string', '1', 'Locations');
INSERT INTO `settings` VALUES ('showlocationcolours', '1', 'Whether to display calendar entries with their location colour', 'boolean', '1', 'Locations');
INSERT INTO `settings` VALUES ('showlocationfilter', '1', 'Whether to show the Location Filter Bar on the Main Calendar Page', 'boolean', '1', 'Locations');
INSERT INTO `settings` VALUES ('sitedescription', 'Room Booking System', 'Site Meta Description', 'string', '1', 'General');
INSERT INTO `settings` VALUES ('siteEmailAddress', 'bookings@domain.com', 'Main Site email address - used in  booking notifications', 'string', '1', 'General');
INSERT INTO `settings` VALUES ('sitelogo', '/', 'Path or Full URL to your Site Logo, 20px x 20px recommended', 'string', '1', 'General');
INSERT INTO `settings` VALUES ('sitetitle', 'Room Booking System', 'The Main Site Title', 'string', '1', 'General');
INSERT INTO `settings` VALUES ('usejavascriptfromCDN', '1', 'Use Javascript Libraries and CSS from CDN whereever possible', 'boolean', '1', 'General');
INSERT INTO `settings` VALUES ('version', '1.1', 'Version Number', 'string', '1', 'General');
INSERT INTO `settings` VALUES ('wheelsErrorEmailFromAddress', 'error@domain.com', 'Production mode error email address (from)', 'string', '1', 'General');
INSERT INTO `settings` VALUES ('wheelsErrorEmailSubject', '[Error - Room Booking]', 'Production mode error email subject', 'string', '1', 'General');
INSERT INTO `settings` VALUES ('wheelsErrorEmailToAddress', 'error@domain.com', 'Production mode error email address (to)', 'string', '1', 'General');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `firstname` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `lastname` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `role` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'user',
  `password` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `salt` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address1` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address2` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `passwordresettoken` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postcode` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tel` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `passwordresetat` datetime DEFAULT NULL,
  `createdat` datetime DEFAULT NULL,
  `updatedat` datetime DEFAULT NULL,
  `deletedat` datetime DEFAULT NULL,
  `apitoken` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
