<cfscript>

// Use DB migrate to populate the test DB Structure
include "../plugins/dbmigrate/basefunctions.cfm";
dbmigrate = application.wheels.plugins.dbmigrate;

"data"={
	"currentVersion" 	= dbmigrate.getCurrentMigrationVersion(),
	"databaseType"   	= $getDBType(),
	"migrations"    	= dbmigrate.getAvailableMigrations(),
	"lastVersion"    	= 0
};
if(ArrayLen(data.migrations)){
	data.lastVersion = data.migrations[ArrayLen(data.migrations)].version;
}
// Delete generated SQL
if (DirectoryExists(expandPath("/db/sql/"))) {
	DirectoryDelete(expandPath("/db/sql/"), true);
}
// Reset
writeDump(dbmigrate.migrateTo(0));
// Repopulate
writeDump(dbmigrate.migrateTo(data.lastVersion));

// Test Data
testUser = queryExecute("
	INSERT INTO users (firstname,lastname,password,email,locale,timezone,roleid)
	VALUES (?,?,?,?,?,?,?);",
    ["Joe","Bloggs",application.bCrypt.hashpw("validPassword", application.bCrypt.gensalt()),"test@test.com","Europe/London","UTC",1],
    {
        datasource    = "rbs_test"
    }
);

// Add a user permission
testUserPermission = queryExecute("
	INSERT INTO userpermissions (userid,permissionid,value)
	VALUES (?,?,?);",
    [1,1,1],
    {
        datasource    = "rbs_test"
    }
);

</cfscript>
<!---<cfquery datasource="rbs_test">
INSERT INTO `bookings` (`id`, `title`, `startUTC`, `endUTC`, `userid`, `buildingid`, `roomid`, `approvedby`, `approved`, `usernotes`, `createdat`, `updatedat`, `isrepeat`, `repeatpattern`)
VALUES
(1, 'Test Event One', '2017-06-12 15:59:15', '2017-06-12 17:59:15', 1, 1, 1, 1, 1, 'ligula pellentesque ultrices', '2017-06-12 15:59:15', '2017-06-12 15:59:15'),
(2, 'praesent blandit lacinia', '2016-01-19 11:50:25', '2016-01-19 13:50:25', 1, 1, 1, 1, 1, 'eget', '2016-01-19 11:50:25', '2016-01-19 11:50:25'),
(3, 'suspendisse', '2017-04-26 06:49:42', '2017-04-26 08:49:42', 1, 1, 1, 1, 1, 'tellus nisi eu', '2017-04-26 06:49:42', '2017-04-26 06:49:42'),
(4, 'pulvinar lobortis', '2017-07-26 22:48:52', '2017-07-27 00:48:52', 1, 1, 1, 1, 1, 'ac lobortis vel', '2017-07-26 22:48:52', '2017-07-26 22:48:52'),
(5, 'blandit lacinia', '2017-07-19 17:15:29', '2017-07-19 19:15:29', 1, 1, 1, 1, 1, 'nibh', '2017-07-19 17:15:29', '2017-07-19 17:15:29'),
(6, 'diam erat', '2017-06-06 15:38:45', '2017-06-06 17:38:45', 1, 1, 1, 1, 1, 'in', '2017-06-06 15:38:45', '2017-06-06 15:38:45'),
(7, 'lacinia eget', '2016-08-18 05:47:21', '2016-08-18 07:47:21', 1, 1, 1, 1, 1, 'sapien', '2016-08-18 05:47:21', '2016-08-18 05:47:21'),
(8, 'lorem ipsum dolor', '2016-08-28 10:38:18', '2016-08-28 12:38:18', 1, 1, 1, 1, 1, 'ante ipsum primis in faucibus', '2016-08-28 10:38:18', '2016-08-28 10:38:18'),
(9, 'vestibulum proin eu', '2016-02-01 04:10:53', '2016-02-01 06:10:53', 1, 1, 1, 1, 1, 'lobortis sapien', '2016-02-01 04:10:53', '2016-02-01 04:10:53'),
(10, 'consequat nulla nisl', '2017-03-14 08:25:41', '2017-03-14 10:25:41', 1, 1, 1, 1, 1, 'vestibulum aliquet', '2017-03-14 08:25:41', '2017-03-14 08:25:41'),
(11, 'orci', '2017-02-14 11:16:54', '2017-02-14 13:16:54', 1, 1, 1, 1, 1, 'integer non', '2017-02-14 11:16:54', '2017-02-14 11:16:54'),
(12, 'nulla pede ullamcorper', '2016-06-27 17:40:40', '2016-06-27 19:40:40', 1, 1, 1, 1, 1, 'turpis nec euismod', '2016-06-27 17:40:40', '2016-06-27 17:40:40'),
(13, 'diam nam tristique', '2016-03-06 10:25:08', '2016-03-06 12:25:08', 1, 1, 1, 1, 1, 'sed vestibulum sit amet', '2016-03-06 10:25:08', '2016-03-06 10:25:08'),
(14, 'justo morbi', '2016-01-06 15:18:45', '2016-01-06 17:18:45', 1, 1, 1, 1, 1, 'cubilia curae', '2016-01-06 15:18:45', '2016-01-06 15:18:45'),
(15, 'nulla pede ullamcorper augue', '2017-08-08 03:58:57', '2017-08-08 05:58:57', 1, 1, 1, 1, 1, 'ipsum ac tellus semper', '2017-08-08 03:58:57', '2017-08-08 03:58:57'),
(16, 'eu tincidunt in', '2016-11-30 13:32:30', '2016-11-30 15:32:30', 1, 1, 1, 1, 1, 'massa quis augue luctus', '2016-11-30 13:32:30', '2016-11-30 13:32:30'),
(17, 'eget eleifend luctus ultricies', '2017-08-23 11:21:57', '2017-08-23 13:21:57', 1, 1, 1, 1, 1, 'mauris morbi', '2017-08-23 11:21:57', '2017-08-23 11:21:57'),
(18, 'quis turpis sed', '2017-05-29 23:07:06', '2017-05-30 01:07:06', 1, 1, 1, 1, 1, 'at feugiat non', '2017-05-29 23:07:06', '2017-05-29 23:07:06'),
(19, 'placerat ante nulla', '2017-05-21 19:13:32', '2017-05-21 21:13:32', 1, 1, 1, 1, 1, 'platea dictumst morbi vestibulum', '2017-05-21 19:13:32', '2017-05-21 19:13:32'),
(20, 'nam ultrices libero', '2016-05-25 11:25:22', '2016-05-25 13:25:22', 1, 1, 1, 1, 1, 'id lobortis convallis', '2016-05-25 11:25:22', '2016-05-25 11:25:22'),
;
</cfquery>--->
