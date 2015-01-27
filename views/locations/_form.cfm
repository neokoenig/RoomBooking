<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Location Form--->
<cfoutput>
#errorMessagesFor("location")#
<cfif structKeyExists(application.rbs.templates, "location") AND structKeyExists(application.rbs.templates.location, "form")>
	 #processShortCodes(application.rbs.templates.location.form)#
<cfelse>

	<!--- Default Template--->
	<cfsavecontent variable="locationTemplate">
	<div class="row">
		<div class="col-md-3">
			[systemfield id="name"]
		</div>
		<div class="col-md-3">
			[systemfield id="description"]
 		</div>
		<div class="col-md-3">
			[systemfield id="class"]
 		</div>
		<div class="col-md-3">
			[systemfield id="colour"]
		</div>
	</div>
	#includePartial(partial="/customfields/common")#
	</cfsavecontent>

	#processShortCodes(locationTemplate)#
</cfif>

</cfoutput>