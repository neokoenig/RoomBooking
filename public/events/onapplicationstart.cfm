<cfscript>
//=====================================================================
//= 	Application Level Settings: the rbs struct contains all the things.
//=====================================================================

	if(structKeyExists(application, "rbs")){
		structDelete(application, "rbs");
	}

	// BCrypt library
	application.bCrypt = CreateObject( "java", "BCrypt" );

	// Application Settings
	application["rbs"]={
		"version"="2.0.0-alpha",
		"settings" = {},
		"permissions" = {},
		"setupchecks" = {},
		"installed" = false,
		"allowSysadminCreation"=false
	};

	// Before we load the application, we need to check some basic stuff.
	// Basically, we're going to try and dquery a database, and see if what we get
	application.rbs.setupchecks["errors"]=[];
	application.rbs.setupchecks["passes"]=[];

//=====================================================================
//= 	Datasource checks
//=====================================================================
	// If this returns a query with a record, the datasource should at least be setup
	// If this fails, it might be that the DB is not yet setup
	// In production mode this will just give "Error! etc"
	// So for the install script, we need to catch this gracefully
	try {
		request.rbs.dbinfo=$dbinfo(
			type="version",
			datasource=application.wheels.dataSourceName,
			username=application.wheels.dataSourceUserName,
			password=application.wheels.dataSourcePassword);
		if(request.rbs.dbinfo.recordcount){
			arrayAppend(application.rbs.setupchecks.passes,
			{
				"checkname": "datasource",
				"message": "Datasource Found"
			}
			);
		}

	} catch(any e){
		arrayAppend(application.rbs.setupchecks.errors,
			{
				"checkname": "datasource",
				"message": e.message
			}
		);
	}
//=====================================================================
//= 	DBmigrate checks
//=====================================================================
if(arraylen(application.rbs.setupchecks.errors) == 0){
	// Get Current Version
	application.rbs.dbmigrate.current=application.wheels.plugins.dbmigrate.getCurrentMigrationVersion();
	// Get Migration Array
	application.rbs.dbmigrate.migrations=application.wheels.plugins.dbmigrate.getAvailableMigrations();
	// If there's migrations available, get the latest
	if(arraylen(application.rbs.dbmigrate.migrations)){
		application.rbs.dbmigrate.latest=application.rbs.dbmigrate.migrations[ArrayLen(application.rbs.dbmigrate.migrations)].version;
	} else {
		application.rbs.dbmigrate.latest=0;
	}

	if(application.rbs.dbmigrate.current != application.rbs.dbmigrate.latest){
		arrayAppend(application.rbs.setupchecks.errors,
			{
				"checkname": "dbmigrate",
				"message": "Database migration script needs running: Current version is <code>#application.rbs.dbmigrate.current#</code> and <code>#application.rbs.dbmigrate.latest#</code> is available"
			}
		);
	} else {
		arrayAppend(application.rbs.setupchecks.passes,
			{
				"checkname": "dbmigrate",
				"message": "Datasource Version is ok - running <code>#application.rbs.dbmigrate.current#</code>"
			}
			);
	}
	// No need to keep this in application scope, can get a little big.
	structDelete(application.rbs.dbmigrate, "migrations");
}

//=====================================================================
//= 	Ensure there's at least one sysadmin user;
//=		unlock ability to create a sysadmin if this fails - don't run if DB not setup
//=====================================================================
if(arraylen(application.rbs.setupchecks.errors) == 0){
	if(!checkForAtLeastOneSysAdmin()){
		arrayAppend(application.rbs.setupchecks.errors,
			{
				"checkname": "sysadmin",
				"message": "No Sysadmin user has been found/created"
			}
		);
		application.rbs.allowSysadminCreation=true;
	} else {
		arrayAppend(application.rbs.setupchecks.passes,
			{
				"checkname": "sysadmin",
				"message": "At least one Sysadmin has been found"
			}
		);
	}
}
//=====================================================================
//= 	Apply Application Settings
//=====================================================================

// All Checks above passed? Cool. Load the app
if(!arraylen(application.rbs.setupchecks.errors)){
	getRBSApplicationSettings();
	application.rbs.installed=true;
} else {
	// redirect to the installer; url flag is to stop looping redirect
	if(!isDefined("url.redirected")){
		location("/install/?redirected", false);
	}
	//abort;
}

</cfscript>
