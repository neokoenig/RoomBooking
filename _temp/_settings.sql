/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50525
Source Host           : localhost:3306
Source Database       : roombooking

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2013-09-24 10:04:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `_settings`
-- ----------------------------
DROP TABLE IF EXISTS `_settings`;
CREATE TABLE `_settings` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `notes` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fieldtype` varchar(55) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'integer',
  `editable` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of _settings
-- ----------------------------
INSERT INTO `_settings` VALUES ('allowLocations', '1', 'setting to zero will disable the facility to edit all locations via the web interface', 'boolean', '1');
INSERT INTO `_settings` VALUES ('allowSettings', '1', 'Warning - setting to zero will disable the facility to edit all settings via the web interface, and will only be editable via the database directly', 'boolean', '1');
INSERT INTO `_settings` VALUES ('allowThemes', '1', 'setting to zero will disable the theme preview dropdown', 'boolean', '1');
INSERT INTO `_settings` VALUES ('bootstraptheme', 'cosmo', 'Current bootstrap bootswatch theme to use - requires using CDN option', 'string', '1');
INSERT INTO `_settings` VALUES ('bootstrapthemeoptions', 'amelia,cerulean,cosmo,cyborg,flatly,journal,readable,simplex,slate,spacelab,united', 'List of possible Bootstrap 3 theme names', 'string', '0');
INSERT INTO `_settings` VALUES ('calendarAllDaySlot', '1', 'Determines if the \"all-day\" slot is displayed at the top of the calendar.', 'boolean', '1');
INSERT INTO `_settings` VALUES ('calendarAllDayText', 'all-day', 'The text titling the \"all-day\" slot at the top of the calendar.', 'string', '1');
INSERT INTO `_settings` VALUES ('calendarAxisFormat', 'h(:mm)tt', 'Determines the time-text that will be displayed on the vertical axis of the agenda views.', 'string', '1');
INSERT INTO `_settings` VALUES ('calendarColumnFormatDay', 'dddd d/M', 'columnFormat: day', 'string', '1');
INSERT INTO `_settings` VALUES ('calendarColumnFormatMonth', 'ddd', 'columnFormat: month', 'string', '1');
INSERT INTO `_settings` VALUES ('calendarColumnFormatWeek', 'ddd d/M', 'columnFormat: week', 'string', '1');
INSERT INTO `_settings` VALUES ('calendarDefaultView', 'month', 'Calendar Default View - Can be month, basicWeek, basicDay etc', 'string', '1');
INSERT INTO `_settings` VALUES ('calendarFirstday', '1', 'Start Calendar on this day of the week: 1 = Monday, 0 = Sunday', 'boolean', '1');
INSERT INTO `_settings` VALUES ('calendarHeadercenter', 'title', 'Calendar Header Display, center - see http://arshaw.com/fullcalendar/docs/display/header/', 'string', '1');
INSERT INTO `_settings` VALUES ('calendarHeaderleft', 'prev,next today', 'Calendar Header Display, left side - see http://arshaw.com/fullcalendar/docs/display/header/', 'string', '1');
INSERT INTO `_settings` VALUES ('calendarHeaderright', 'month,agendaWeek,agendaDay', 'Calendar Header Display, right - see http://arshaw.com/fullcalendar/docs/display/header/', 'string', '1');
INSERT INTO `_settings` VALUES ('calendarHiddenDays', '[]', 'Hide certain days (Comma Delim List in array, i.e [1,3,5] )', 'string', '1');
INSERT INTO `_settings` VALUES ('calendarMintime', '7:00am', 'Calendar Minimum Time to display', 'string', '1');
INSERT INTO `_settings` VALUES ('calendarSlotEventOverlap', '1', 'Determines if timed events in agenda view should visually overlap.', 'boolean', '1');
INSERT INTO `_settings` VALUES ('calendarSlotMinutes', '15', 'Calendar No of minutes to increment minutes in (integer) ', 'integer', '1');
INSERT INTO `_settings` VALUES ('calendarTimeformat', 'H:mm', 'Calendar Time Format', 'string', '1');
INSERT INTO `_settings` VALUES ('calendarWeekends', '1', 'Calendar Whether to show weekends', 'boolean', '1');
INSERT INTO `_settings` VALUES ('calendarWeekNumbers', '0', 'Determines if week numbers should be displayed on the calendar.', 'boolean', '1');
INSERT INTO `_settings` VALUES ('googleanalytics', 'UA-', 'Google Anayltics Tracking Code (format: UA-XXXXX-X), set to UA- to omit', 'string', '1');
INSERT INTO `_settings` VALUES ('roomlayouttypes', 'Standard,Boardroom,Lecture', 'Room Layout Types (Comma Deliminated List of Values)', 'string', '1');
INSERT INTO `_settings` VALUES ('showlocationcolours', '1', 'Whether to display calendar entries with their location colour', 'boolean', '1');
INSERT INTO `_settings` VALUES ('showlocationfilter', '1', 'Whether to show the Location Filter Bar on the Main Calendar Page', 'boolean', '1');
INSERT INTO `_settings` VALUES ('sitedescription', 'Room Booking System', 'Site Meta Description', 'string', '1');
INSERT INTO `_settings` VALUES ('siteEmailAddress', 'roombooking@domain.com', 'Main Site email address - used in  booking notifications', 'string', '1');
INSERT INTO `_settings` VALUES ('sitelogo', '/', 'Path or Full URL to your Site Logo, 20px x 20px recommended', 'string', '1');
INSERT INTO `_settings` VALUES ('sitetitle', 'Room Booking', 'The Main Site Title', 'string', '1');
INSERT INTO `_settings` VALUES ('usejavascriptfromCDN', '1', 'Use Javascript Libraries and CSS from CDN whereever possible', 'boolean', '1');
INSERT INTO `_settings` VALUES ('version', '1.0', 'Database scheme version', 'string', '0');
INSERT INTO `_settings` VALUES ('wheelsErrorEmailFromAddress', 'error@domain.com', 'Production mode error email address (from)', 'string', '1');
INSERT INTO `_settings` VALUES ('wheelsErrorEmailSubject', '[Error - Room Booking]', 'Production mode error email subject', 'string', '1');
INSERT INTO `_settings` VALUES ('wheelsErrorEmailToAddress', 'error@domain.com', 'Production mode error email address (to)', 'string', '1');
