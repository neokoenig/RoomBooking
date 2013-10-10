<!---================= Room Booking System / https://github.com/neokoenig =======================--->

 <cftry>
 	<cfset loadSettings()>
 	<cfcatch type="any">
 		<cflocation url="/rewrite.cfm?controller=wheels&action=wheels&view=plugins&name=dbmigrate">
 	</cfcatch>
 </cftry>
 
 <cfset createInitialUser()>
  
 	 
<cffunction name="createInitialUser">
	<cfscript>
	// If user table is empty, we need to generate an admin user with some default values.
	// As each installation has it's own authkey used to encrypt the password/salt, we can't do this in DBMigrate 
	adminU=model("user").findAll(where="role = 'admin'");
	if(adminU.recordcount LT 1){
		// Create Default Admin User
		u=model("user").create(
				email="admin@domain.com",
				firstname="Default",
				lastname="Administrator",
				role="admin",
				password="roombooking100",
				passwordConfirmation="roombooking100",
				address1="",
				address2="",
				state="",
				postcode="",
				country="",
				tel=""
			); 
		if(!u.save()){
			// This should really never trigger..
			writeDump(u.allErrors());
			abort;
		}
	}
	</cfscript>	
</cffunction>

<cffunction name="loadSettings">
 	<cfscript>
	// Application Specific settings 
	if(structKeyExists(application, "rbs")){
		structDelete(application, "rbs");
	}
	// PLaceholder Structs
	application.rbs={};
	application.rbs.setting={};
	application.rbs.permission={};
	// Get all settings & permissions from database - this will fail if dbmigrate plugin hasn't been run, hence the cflocation uptop.
	application.rbs.settingsQuery=model("setting").findAll();
	application.rbs.permissionsQuery=model("permission").findAll();
	</cfscript>
	<cfloop query="application.rbs.settingsQuery"> 
		<cfset application.rbs.setting["#id#"]=application.rbs.settingsQuery["value"]> 
	</cfloop> 
	<cfloop query="application.rbs.permissionsQuery"> 
		<cfscript>
			 application.rbs.permission["#id#"]={};
			 // TO do, would be nice in the future to not hard code this and allow for user created roles, but for now these should suffice
			 application.rbs.permission["#id#"]["admin"]=application.rbs.permissionsQuery["admin"];
			 application.rbs.permission["#id#"]["editor"]=application.rbs.permissionsQuery["editor"];
			 application.rbs.permission["#id#"]["user"]=application.rbs.permissionsQuery["user"];
			 application.rbs.permission["#id#"]["guest"]=application.rbs.permissionsQuery["guest"];
		</cfscript>
	</cfloop> 
	<cfscript>
		// No need to keep the query in memory, let's get rid of it 
		structDelete(application.rbs, "settingsQuery");
		structDelete(application.rbs, "permissionsQuery");
	</cfscript>
 </cffunction>
