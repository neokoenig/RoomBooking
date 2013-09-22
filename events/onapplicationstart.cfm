<cfscript>
	// Room Booking Application Specific settings 
 	application.roombooking={}
	// Get all settings from database
	application.roombooking.query=model("setting").findAll();
</cfscript>
<cfloop query="application.roombooking.query"> 
		<cfset application.roombooking["#id#"]=application.roombooking.query["value"]> 
</cfloop>