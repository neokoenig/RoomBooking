<!--- Locations--->
<cfcomponent extends="model">
	<cffunction name="init">
		<cfscript>
			hasMany("events");
		</cfscript>
	</cffunction>
</cfcomponent>