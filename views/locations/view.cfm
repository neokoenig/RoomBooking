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
			<p>[output label="Name" id="name"]</p>
			<p>[output label="Description" id="description"]</p>
			<p>[output label="Class" id="class"]</p>
			<p>[output label="Colour" id="colour"]</p>
		</div>
		<div class="col-md-3">
			<cfif customfields.recordcount>
				<cfoutput>
					<cfloop query="customfields">
						<p>[output label="#name#" id="#id#"]</p>
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
