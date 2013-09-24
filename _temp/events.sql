/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50525
Source Host           : localhost:3306
Source Database       : roombooking

Target Server Type    : MYSQL
Target Server Version : 50525
File Encoding         : 65001

Date: 2013-09-24 10:49:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `events`
-- ----------------------------
DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime DEFAULT NULL,
  `allday` tinyint(1) NOT NULL DEFAULT '0',
  `url` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `className` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `locationid` int(11) NOT NULL DEFAULT '0',
  `contactname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactno` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contactemail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `layoutstyle` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Standard',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of events
-- ----------------------------
INSERT INTO `events` VALUES ('68', 'Test Event 1', '2013-09-23 13:30:00', '2013-09-23 14:30:00', '0', null, null, 'This is a test event description', '2013-09-23 13:31:04', '2013-09-23 13:31:04', '6', 'Test Contact', '01234 654654', 'foo@foo.com', 'Lecture');
INSERT INTO `events` VALUES ('69', 'Test Event 1', '2013-10-23 13:30:00', '2013-10-23 14:30:00', '0', null, null, 'This is a test event description', '2013-09-23 13:31:04', '2013-09-23 13:31:04', '6', 'Test Contact', '01234 654654', 'foo@foo.com', 'Lecture');
INSERT INTO `events` VALUES ('70', 'Test Event 1', '2013-11-23 13:30:00', '2013-11-23 14:30:00', '0', null, null, 'This is a test event description', '2013-09-23 13:31:04', '2013-09-23 13:31:04', '6', 'Test Contact', '01234 654654', 'foo@foo.com', 'Lecture');
INSERT INTO `events` VALUES ('71', 'Test Event 1', '2013-12-23 13:30:00', '2013-12-23 14:30:00', '0', null, null, 'This is a test event description', '2013-09-23 13:31:04', '2013-09-23 13:31:04', '6', 'Test Contact', '01234 654654', 'foo@foo.com', 'Lecture');
INSERT INTO `events` VALUES ('72', 'Test Event 1', '2014-01-23 13:30:00', '2014-01-23 14:30:00', '0', null, null, 'This is a test event description', '2013-09-23 13:31:04', '2013-09-23 13:31:04', '6', 'Test Contact', '01234 654654', 'foo@foo.com', 'Lecture');
INSERT INTO `events` VALUES ('73', 'Test Event 1', '2014-02-23 13:30:00', '2014-02-23 14:30:00', '0', null, null, 'This is a test event description', '2013-09-23 13:31:04', '2013-09-23 13:31:04', '6', 'Test Contact', '01234 654654', 'foo@foo.com', 'Lecture');
INSERT INTO `events` VALUES ('74', 'Test Event 1', '2014-03-23 13:30:00', '2014-03-23 14:30:00', '0', null, null, 'This is a test event description', '2013-09-23 13:31:04', '2013-09-23 13:31:04', '6', 'Test Contact', '01234 654654', 'foo@foo.com', 'Lecture');
INSERT INTO `events` VALUES ('75', 'Test Event 1', '2014-04-23 13:30:00', '2014-04-23 14:30:00', '0', null, null, 'This is a test event description', '2013-09-23 13:31:04', '2013-09-23 13:31:04', '6', 'Test Contact', '01234 654654', 'foo@foo.com', 'Lecture');
INSERT INTO `events` VALUES ('76', 'Test Event 1', '2014-05-23 13:30:00', '2014-05-23 14:30:00', '0', null, null, 'This is a test event description', '2013-09-23 13:31:04', '2013-09-23 13:31:04', '6', 'Test Contact', '01234 654654', 'foo@foo.com', 'Lecture');
INSERT INTO `events` VALUES ('77', 'Test Event 1', '2014-06-23 13:30:00', '2014-06-23 14:30:00', '0', null, null, 'This is a test event description', '2013-09-23 13:31:04', '2013-09-23 13:31:04', '6', 'Test Contact', '01234 654654', 'foo@foo.com', 'Lecture');
INSERT INTO `events` VALUES ('78', 'Test Event 1', '2014-07-23 13:30:00', '2014-07-23 14:30:00', '0', null, null, 'This is a test event description', '2013-09-23 13:31:04', '2013-09-23 13:31:04', '6', 'Test Contact', '01234 654654', 'foo@foo.com', 'Lecture');
INSERT INTO `events` VALUES ('79', 'Test Event 1', '2014-08-23 13:30:00', '2014-08-23 14:30:00', '0', null, null, 'This is a test event description', '2013-09-23 13:31:04', '2013-09-23 13:31:04', '6', 'Test Contact', '01234 654654', 'foo@foo.com', 'Lecture');
INSERT INTO `events` VALUES ('80', 'Test Event 1', '2014-09-23 13:30:00', '2014-09-23 14:30:00', '0', null, null, 'This is a test event description', '2013-09-23 13:31:04', '2013-09-23 13:31:04', '6', 'Test Contact', '01234 654654', 'foo@foo.com', 'Lecture');
INSERT INTO `events` VALUES ('81', 'Test Event 1', '2014-10-23 13:30:00', '2014-10-23 14:30:00', '0', null, null, 'This is a test event description', '2013-09-23 13:31:04', '2013-09-23 13:31:04', '6', 'Test Contact', '01234 654654', 'foo@foo.com', 'Lecture');
INSERT INTO `events` VALUES ('82', 'Test Event 1', '2014-11-23 13:30:00', '2014-11-23 14:30:00', '0', null, null, 'This is a test event description', '2013-09-23 13:31:04', '2013-09-23 13:31:04', '6', 'Test Contact', '01234 654654', 'foo@foo.com', 'Lecture');
INSERT INTO `events` VALUES ('83', 'Test Event 1', '2014-12-23 13:30:00', '2014-12-23 14:30:00', '0', null, null, 'This is a test event description', '2013-09-23 13:31:04', '2013-09-23 13:31:04', '6', 'Test Contact', '01234 654654', 'foo@foo.com', 'Lecture');
INSERT INTO `events` VALUES ('84', 'Test Event 2', '2013-09-23 13:31:00', '2013-09-25 13:31:00', '1', null, null, 'Test Event 2', '2013-09-23 13:31:59', '2013-09-23 13:31:59', '5', 'Test Contact', '01234 654654', 'foo@foo.com', 'Boardroom');
INSERT INTO `events` VALUES ('85', 'Test Event 2', '2013-09-30 13:31:00', '2013-10-02 13:31:00', '1', null, null, 'Test Event 2', '2013-09-23 13:31:59', '2013-09-23 13:31:59', '5', 'Test Contact', '01234 654654', 'foo@foo.com', 'Boardroom');
INSERT INTO `events` VALUES ('86', 'Test Event 2', '2013-10-10 13:30:00', '2013-10-25 13:30:00', '1', null, null, 'Test Event 2', '2013-09-23 13:31:59', '2013-09-23 14:12:04', '5', 'Test Contact', '01234 654654', 'foo@foo.com', 'Boardroom');
INSERT INTO `events` VALUES ('87', 'Test Event 2', '2013-10-14 13:31:00', '2013-10-16 13:31:00', '1', null, null, 'Test Event 2', '2013-09-23 13:31:59', '2013-09-23 13:31:59', '5', 'Test Contact', '01234 654654', 'foo@foo.com', 'Boardroom');
INSERT INTO `events` VALUES ('88', 'Test Event 2', '2013-10-21 13:31:00', '2013-10-23 13:31:00', '1', null, null, 'Test Event 2', '2013-09-23 13:31:59', '2013-09-23 13:31:59', '5', 'Test Contact', '01234 654654', 'foo@foo.com', 'Boardroom');
INSERT INTO `events` VALUES ('89', 'Test Event 2', '2013-10-28 13:31:00', '2013-10-30 13:31:00', '1', null, null, 'Test Event 2', '2013-09-23 13:31:59', '2013-09-23 13:31:59', '5', 'Test Contact', '01234 654654', 'foo@foo.com', 'Boardroom');
INSERT INTO `events` VALUES ('90', 'Test Event 2', '2013-11-04 13:31:00', '2013-11-06 13:31:00', '1', null, null, 'Test Event 2', '2013-09-23 13:31:59', '2013-09-23 13:31:59', '5', 'Test Contact', '01234 654654', 'foo@foo.com', 'Boardroom');
INSERT INTO `events` VALUES ('91', 'Test Event 2', '2013-11-11 13:31:00', '2013-11-13 13:31:00', '1', null, null, 'Test Event 2', '2013-09-23 13:31:59', '2013-09-23 13:31:59', '5', 'Test Contact', '01234 654654', 'foo@foo.com', 'Boardroom');
INSERT INTO `events` VALUES ('92', 'Test Event 2', '2013-11-18 13:31:00', '2013-11-20 13:31:00', '1', null, null, 'Test Event 2', '2013-09-23 13:31:59', '2013-09-23 13:31:59', '5', 'Test Contact', '01234 654654', 'foo@foo.com', 'Boardroom');
INSERT INTO `events` VALUES ('93', 'Test Event 2', '2013-11-25 13:31:00', '2013-11-27 13:31:00', '1', null, null, 'Test Event 2', '2013-09-23 13:31:59', '2013-09-23 13:31:59', '5', 'Test Contact', '01234 654654', 'foo@foo.com', 'Boardroom');
INSERT INTO `events` VALUES ('94', 'Test Event 2', '2013-12-02 13:31:00', '2013-12-04 13:31:00', '1', null, null, 'Test Event 2', '2013-09-23 13:31:59', '2013-09-23 13:31:59', '5', 'Test Contact', '01234 654654', 'foo@foo.com', 'Boardroom');
INSERT INTO `events` VALUES ('95', 'Test Event 2', '2013-12-09 13:31:00', '2013-12-11 13:31:00', '1', null, null, 'Test Event 2', '2013-09-23 13:31:59', '2013-09-23 13:31:59', '5', 'Test Contact', '01234 654654', 'foo@foo.com', 'Boardroom');
INSERT INTO `events` VALUES ('96', 'Test Event 2', '2013-12-16 13:31:00', '2013-12-18 13:31:00', '1', null, null, 'Test Event 2', '2013-09-23 13:31:59', '2013-09-23 13:31:59', '5', 'Test Contact', '01234 654654', 'foo@foo.com', 'Boardroom');
INSERT INTO `events` VALUES ('97', 'Test Event 2', '2013-12-23 13:31:00', '2013-12-25 13:31:00', '1', null, null, 'Test Event 2', '2013-09-23 13:31:59', '2013-09-23 13:31:59', '5', 'Test Contact', '01234 654654', 'foo@foo.com', 'Boardroom');
INSERT INTO `events` VALUES ('98', 'Test Event 2', '2013-12-30 13:31:00', '2014-01-01 13:31:00', '1', null, null, 'Test Event 2', '2013-09-23 13:31:59', '2013-09-23 13:31:59', '5', 'Test Contact', '01234 654654', 'foo@foo.com', 'Boardroom');
INSERT INTO `events` VALUES ('99', 'Test Event 2', '2014-01-06 13:31:00', '2014-01-08 13:31:00', '1', null, null, 'Test Event 2', '2013-09-23 13:31:59', '2013-09-23 13:31:59', '5', 'Test Contact', '01234 654654', 'foo@foo.com', 'Boardroom');
INSERT INTO `events` VALUES ('100', 'Test Event 3', '2013-09-26 13:30:00', '2013-09-26 14:34:00', '0', null, null, null, '2013-09-23 13:32:44', '2013-09-23 13:32:44', '1', null, null, null, 'Lecture');
INSERT INTO `events` VALUES ('101', 'Test Event 3', '2013-10-03 13:30:00', '2013-10-03 14:34:00', '0', null, null, null, '2013-09-23 13:32:44', '2013-09-23 13:32:44', '1', null, null, null, 'Lecture');
INSERT INTO `events` VALUES ('102', 'Test Event 3', '2013-10-10 13:30:00', '2013-10-10 14:34:00', '0', null, null, null, '2013-09-23 13:32:44', '2013-09-23 13:37:13', '2', null, null, null, 'Lecture');
INSERT INTO `events` VALUES ('103', 'Test Event 3', '2013-10-17 13:30:00', '2013-10-17 14:34:00', '0', null, null, null, '2013-09-23 13:32:44', '2013-09-23 13:32:44', '1', null, null, null, 'Lecture');
INSERT INTO `events` VALUES ('104', 'Test Event 3', '2013-10-24 13:30:00', '2013-10-24 14:34:00', '0', null, null, null, '2013-09-23 13:32:44', '2013-09-23 13:37:22', '2', null, null, null, 'Lecture');
INSERT INTO `events` VALUES ('105', 'Test Event 3', '2013-10-31 13:30:00', '2013-10-31 14:34:00', '0', null, null, null, '2013-09-23 13:32:44', '2013-09-23 13:32:44', '1', null, null, null, 'Lecture');
INSERT INTO `events` VALUES ('106', 'Test Event 3', '2013-11-07 13:30:00', '2013-11-07 14:34:00', '0', null, null, null, '2013-09-23 13:32:44', '2013-09-23 13:32:44', '1', null, null, null, 'Lecture');
INSERT INTO `events` VALUES ('107', 'Test Event 3', '2013-11-14 13:30:00', '2013-11-14 14:34:00', '0', null, null, null, '2013-09-23 13:32:44', '2013-09-23 13:32:44', '1', null, null, null, 'Lecture');
INSERT INTO `events` VALUES ('108', 'Test Event 3', '2013-11-21 13:30:00', '2013-11-21 14:34:00', '0', null, null, null, '2013-09-23 13:32:44', '2013-09-23 13:32:44', '1', null, null, null, 'Lecture');
INSERT INTO `events` VALUES ('109', 'Test Event 3', '2013-11-28 13:30:00', '2013-11-28 14:34:00', '0', null, null, null, '2013-09-23 13:32:44', '2013-09-23 13:32:44', '1', null, null, null, 'Lecture');
INSERT INTO `events` VALUES ('110', 'Test Event 3', '2013-12-05 13:30:00', '2013-12-05 14:34:00', '0', null, null, null, '2013-09-23 13:32:44', '2013-09-23 13:32:44', '1', null, null, null, 'Lecture');
INSERT INTO `events` VALUES ('111', 'Test Event 3', '2013-12-12 13:30:00', '2013-12-12 14:34:00', '0', null, null, null, '2013-09-23 13:32:45', '2013-09-23 13:32:45', '1', null, null, null, 'Lecture');
INSERT INTO `events` VALUES ('112', 'Test Event 3', '2013-12-19 13:30:00', '2013-12-19 14:34:00', '0', null, null, null, '2013-09-23 13:32:45', '2013-09-23 13:32:45', '1', null, null, null, 'Lecture');
INSERT INTO `events` VALUES ('113', 'Test Event 3', '2013-12-26 13:30:00', '2013-12-26 14:34:00', '0', null, null, null, '2013-09-23 13:32:45', '2013-09-23 13:32:45', '1', null, null, null, 'Lecture');
INSERT INTO `events` VALUES ('114', 'Test Event 3', '2014-01-02 13:30:00', '2014-01-02 14:34:00', '0', null, null, null, '2013-09-23 13:32:45', '2013-09-23 13:32:45', '1', null, null, null, 'Lecture');
INSERT INTO `events` VALUES ('115', 'Test Event 3', '2014-01-09 13:30:00', '2014-01-09 14:34:00', '0', null, null, null, '2013-09-23 13:32:45', '2013-09-23 13:32:45', '1', null, null, null, 'Lecture');
INSERT INTO `events` VALUES ('116', 'Quick Meeting', '2013-09-24 09:25:00', '2013-09-24 09:42:00', '0', null, null, null, '2013-09-23 13:33:30', '2013-09-23 13:33:30', '4', null, null, null, 'Boardroom');
INSERT INTO `events` VALUES ('117', 'Quick Meeting', '2013-10-01 09:25:00', '2013-10-01 09:42:00', '0', null, null, null, '2013-09-23 13:33:31', '2013-09-23 13:33:31', '4', null, null, null, 'Boardroom');
INSERT INTO `events` VALUES ('118', 'Quick Meeting', '2013-10-08 09:25:00', '2013-10-08 09:42:00', '0', null, null, null, '2013-09-23 13:33:31', '2013-09-23 13:33:31', '4', null, null, null, 'Boardroom');
INSERT INTO `events` VALUES ('119', 'Quick Meeting Changed', '2013-10-15 09:25:00', '2013-10-15 09:42:00', '0', null, null, null, '2013-09-23 13:33:31', '2013-09-23 13:37:00', '4', null, null, null, 'Boardroom');
INSERT INTO `events` VALUES ('120', 'Quick Meeting', '2013-10-22 09:25:00', '2013-10-22 09:42:00', '0', null, null, null, '2013-09-23 13:33:31', '2013-09-23 13:33:31', '4', null, null, null, 'Boardroom');
INSERT INTO `events` VALUES ('121', 'Quick Meeting', '2013-10-29 09:25:00', '2013-10-29 09:42:00', '0', null, null, null, '2013-09-23 13:33:31', '2013-09-23 13:33:31', '4', null, null, null, 'Boardroom');
INSERT INTO `events` VALUES ('122', 'Quick Meeting', '2013-11-05 09:25:00', '2013-11-05 09:42:00', '0', null, null, null, '2013-09-23 13:33:31', '2013-09-23 13:33:31', '4', null, null, null, 'Boardroom');
INSERT INTO `events` VALUES ('123', 'Quick Meeting', '2013-11-12 09:25:00', '2013-11-12 09:42:00', '0', null, null, null, '2013-09-23 13:33:31', '2013-09-23 13:33:31', '4', null, null, null, 'Boardroom');
INSERT INTO `events` VALUES ('124', 'Quick Meeting', '2013-11-19 09:25:00', '2013-11-19 09:42:00', '0', null, null, null, '2013-09-23 13:33:31', '2013-09-23 13:33:31', '4', null, null, null, 'Boardroom');
INSERT INTO `events` VALUES ('125', 'Quick Meeting', '2013-11-26 09:25:00', '2013-11-26 09:42:00', '0', null, null, null, '2013-09-23 13:33:31', '2013-09-23 13:33:31', '4', null, null, null, 'Boardroom');
INSERT INTO `events` VALUES ('126', 'Quick Meeting', '2013-12-03 09:25:00', '2013-12-03 09:42:00', '0', null, null, null, '2013-09-23 13:33:31', '2013-09-23 13:33:31', '4', null, null, null, 'Boardroom');
INSERT INTO `events` VALUES ('127', 'Quick Meeting', '2013-12-10 09:25:00', '2013-12-10 09:42:00', '0', null, null, null, '2013-09-23 13:33:31', '2013-09-23 13:33:31', '4', null, null, null, 'Boardroom');
INSERT INTO `events` VALUES ('128', 'Quick Meeting', '2013-12-17 09:25:00', '2013-12-17 09:42:00', '0', null, null, null, '2013-09-23 13:33:31', '2013-09-23 13:33:31', '4', null, null, null, 'Boardroom');
INSERT INTO `events` VALUES ('129', 'Quick Meeting', '2013-12-24 09:25:00', '2013-12-24 09:42:00', '0', null, null, null, '2013-09-23 13:33:31', '2013-09-23 13:33:31', '4', null, null, null, 'Boardroom');
INSERT INTO `events` VALUES ('130', 'Quick Meeting', '2013-12-31 09:25:00', '2013-12-31 09:42:00', '0', null, null, null, '2013-09-23 13:33:31', '2013-09-23 13:33:31', '4', null, null, null, 'Boardroom');
INSERT INTO `events` VALUES ('131', 'Quick Meeting', '2014-01-07 09:25:00', '2014-01-07 09:42:00', '0', null, null, null, '2013-09-23 13:33:31', '2013-09-23 13:33:31', '4', null, null, null, 'Boardroom');
INSERT INTO `events` VALUES ('132', 'Random Event 1', '2013-09-23 13:35:00', '2013-09-23 13:35:00', '0', null, null, null, '2013-09-23 13:33:46', '2013-09-23 13:33:46', '6', null, null, null, 'Standard');
INSERT INTO `events` VALUES ('133', 'Random Event 1', '2013-10-03 17:30:00', '2013-10-03 17:30:00', '0', null, null, null, '2013-09-23 13:33:57', '2013-09-23 13:33:57', '6', null, null, null, 'Standard');
INSERT INTO `events` VALUES ('134', 'Long Event', '2013-10-10 13:35:00', '2013-10-24 13:35:00', '1', null, null, null, '2013-09-23 13:34:28', '2013-09-23 13:34:28', '3', null, null, null, 'Standard');
