<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Locations--->
<cfcomponent extends="model">
	<cffunction name="init">
		<cfscript>
			hasMany("events");
		</cfscript>
	</cffunction>
</cfcomponent>