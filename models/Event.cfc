<!--- Events --->
<cfcomponent extends="model">
	<cffunction name="init">
		<cfscript>
			belongsTo("location");
		</cfscript>
	</cffunction>
</cfcomponent>