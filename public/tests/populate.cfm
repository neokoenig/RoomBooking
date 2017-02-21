<cfscript>
// NB, when moving to wheels 2.x, all instances
// of application.wheels.dbmigrate will need to change
// to wheels.dbmigrate

// Use DB migrate to populate the test DB Structure
include "../wheels/dbmigrate/basefunctions.cfm";
dbmigrate = application.wheels.dbmigrate;

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
dbmigrate.migrateTo(0);
// Repopulate
dbmigrate.migrateTo(data.lastVersion);

// Test Data
testUser = queryExecute("
	INSERT INTO users (firstname,lastname,password,email,locale,timezone,roleid)
	VALUES (?,?,?,?,?,?,?);",
    ["Joe","Bloggs",application.bCrypt.hashpw("validPassword", application.bCrypt.gensalt()),"test@test.com","Europe/London","UTC",1],
    {
        datasource    = "rbstesting"
    }
);

// Add a user permission
testUserPermission = queryExecute("
	INSERT INTO userpermissions (userid,permissionid)
	VALUES (?,?);",
    [1,1],
    {
        datasource    = "rbstesting"
    }
);

auth=model("auth.Local").new();
auth.setProperties({"email": "test@test.com",
	"password": "validPassword"});
assert("auth.login()");

</cfscript>
