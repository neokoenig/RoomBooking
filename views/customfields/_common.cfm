<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Custom Fields --->
<cfif customfields.recordcount>
	<cfoutput>
		<fieldset>
			<legend>Additional Information</legend>
			<cfloop query="customfields">
				#includePartial(partial="/customfields/fields")#
			</cfloop>
		</fieldset>
	</cfoutput>
</cfif>
