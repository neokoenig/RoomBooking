<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Default Custom field loop --->
<cfif customfields.recordcount>
	<cfoutput>
		<cfsavecontent variable="customFieldTemplate">
			<fieldset>
			<legend>#l("Additional Information")#</legend>
			<cfloop query="customfields">
				[field id=#id#]
			</cfloop>
		</fieldset>
		</cfsavecontent>
		#processShortCodes(customFieldTemplate)#

	</cfoutput>
</cfif>