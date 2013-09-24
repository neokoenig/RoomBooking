<!---================= Room Booking System / https://github.com/neokoenig =======================--->
 <cftry>
 	<cfset loadSettings()>
 	<cfcatch type="any">
 		<cflocation url="/rewrite.cfm?controller=wheels&action=wheels&view=plugins&name=dbmigrate">
 	</cfcatch>
 </cftry>
 <cffunction name="loadSettings">
 	<cfscript>
	// Application Specific settings 
	if(structKeyExists(application, "rbs")){
		structDelete(application, "rbs");
	}
	application.rbs={}
	// Get all settings from database - this will fail if dbmigrate plugin hasn't been run.
	application.rbs.query=model("setting").findAll();
	</cfscript>
	<cfloop query="application.rbs.query"> 
		<cfset application.rbs["#id#"]=application.rbs.query["value"]> 
	</cfloop> 
 </cffunction>
