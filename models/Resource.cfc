<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Resources--->
<cfcomponent extends="Model">
	<cffunction name="init">
		<cfscript>
			hasMany("eventresources");
		</cfscript>
	</cffunction>
</cfcomponent>