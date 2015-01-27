<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Custom field Shortcode --->
<cfquery dbtype="query" name="customfield">
	SELECT * FROM customfields WHERE id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#attr.id#">;
</cfquery>
<cfif customfield.recordcount>
	<cfoutput>
		<!-- Custom field #attr.id# -->
		#includePartial(partial="/customfields/fields", class=customfield.class, id=customfield.id, type=customfield.type, options=customfield.options, name=customfield.name, description=customfield.description, value=customfield.value)#
		<!-- /Custom field #attr.id# -->
	</cfoutput>
<cfelse>
	<p>Field not found?</p>
</cfif>
