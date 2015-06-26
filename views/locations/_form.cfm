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
			<div class="col-sm-4">
				[field id="name"]
			</div>
			<div class="col-sm-4">
				[field id="building"]
			</div>
			<div class="col-sm-4">
	 			[field id="description"]
			</div>
		</div>
	<div class="row">
		<div class="col-md-3">
			[field id="class"]
 		</div>
		<div class="col-md-3">
			[field id="colour"]
		</div>
		<div class="col-md-3">
			[field id="layouts"]
		</div>
	</div>
	#includePartial(partial="/common/form/customfields")#
	</cfsavecontent>

	#processShortCodes(locationTemplate)#
</cfif>

</cfoutput>