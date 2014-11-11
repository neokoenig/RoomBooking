<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Event Resources --->
<cfcomponent extends="Model">
	<cffunction name="init">
		<cfscript>
			belongsTo("event");
			belongsTo("resource");
		</cfscript>
	</cffunction>
</cfcomponent>