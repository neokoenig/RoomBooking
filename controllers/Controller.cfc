<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfcomponent extends="Wheels">
 
	<cffunction name="init">
		<cfscript> 
		</cfscript>
	</cffunction>

<!---================================ Global Filters ======================================--->
	<cffunction name="_getLocations" hint="Return all room locations">
		<cfset locations=model("location").findAll(order="name")>
	</cffunction>

	<cffunction name="_getSettings" hint="Return all settings">
		<cfset settings=model("setting").findAll(order="category,id")>
	</cffunction>
	
	
</cfcomponent>