<cfcomponent output="false" mixin="none" environment="design,development,maintenance">
	<!---
	This is a sort of "bridging" script for Commandbox to interact with dbmigrate via cfhttp and JSON
	--->
	<cffunction name="init">
		<cfset this.version = "2.0"> 
		<cfreturn this>
	</cffunction>

</cfcomponent> 