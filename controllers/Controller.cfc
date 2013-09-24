<!---
	This is the parent controller file that all your controllers should extend.
	You can add functions to this file to make them globally available in all your controllers.
	Do not delete this file.
--->
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
		<cfset settings=model("setting").findAll()>
	</cffunction>
	
	
</cfcomponent>