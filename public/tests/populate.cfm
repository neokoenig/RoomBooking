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

auth=model("auth.Local").new();
auth.setProperties({"email": "test@test.com",
	"password": "validPassword"});
assert("auth.login()");
</cfscript>
