<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfscript>
	// Room Booking Application Specific settings 
	if(structKeyExists(application, "rbs")){
		structDelete(application, "rbs");
	}
 	application.rbs={}
	// Get all settings from database
	application.rbs.query=model("setting").findAll();
</cfscript>
<cfloop query="application.rbs.query"> 
	<cfset application.rbs["#id#"]=application.rbs.query["value"]> 
</cfloop>