-- ----------------------------
-- Table structure for repeatrules
-- ----------------------------
DROP TABLE IF EXISTS `repeatrules`;
CREATE TABLE `repeatrules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eventid` int(11) NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `starts` datetime DEFAULT NULL,
  `isNever` tinyint(1) NOT NULL DEFAULT '0',
  `endsAfter` tinyint(2) DEFAULT NULL,
  `endsOn` datetime DEFAULT NULL,
  `repeatEvery` tinyint(2) DEFAULT NULL,
  `repeatOn` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `repeatBy` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
