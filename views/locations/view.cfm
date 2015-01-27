<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Location View--->
<cfparam name="location">
<cfparam name="customfields">
<cfoutput>
#panel(title="Location Details")#
<cfif structKeyExists(application.rbs.templates, "location") AND structKeyExists(application.rbs.templates.location, "output")>
	 #processShortCodes(application.rbs.templates.location.output)#
<cfelse>
	<!--- Default Template--->
	<cfsavecontent variable="locationTemplate">
	<div class="row">
		<div class="col-md-3">
			<p><strong>Name:</strong> [systemoutput id="name"]</p>
			<p><strong>Description:</strong> [systemoutput id="description"]</p>
			<p><strong>Class:</strong> [systemoutput id="class"]</p>
			<p><strong>Colour:</strong> [systemoutput id="colour"]</p>
		</div>
		<div class="col-md-3">
			<cfif customfields.recordcount>
				<cfoutput>
					<cfloop query="customfields">
						<p><strong>#name#:</strong> [customoutput id="#id#"]</p>
					</cfloop>
				</cfoutput>
			</cfif>
		</div>
	</div>
	</cfsavecontent>
	#processShortCodes(locationTemplate)#
</cfif>


#panelEnd()#
</cfoutput>
