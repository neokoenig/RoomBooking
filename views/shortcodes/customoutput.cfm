<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Custom Field Output--->
<cfoutput>
	<!--- Must be a better way of doing this? customfields["value"]["#attr.id#"] doesn't appear to work--->
	<cfquery dbtype="query" name="customfieldoutput">
		SELECT * from customfields WHERE id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#attr.id#">;
	</cfquery>
	<cfif customfieldoutput.recordcount>
		#h(customfieldoutput.value)#
	</cfif>
</cfoutput>