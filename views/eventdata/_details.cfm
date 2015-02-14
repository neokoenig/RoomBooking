<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
<cfparam name="resources">
<cfif checkPermission("allowRoomBooking")>
	<div class="btn-group btn-group-justified">
		#linkTo(action="edit", key=event.eventid, text="<span class='glyphicon glyphicon-pencil'></span> Edit", controller="bookings", class="btn btn-info btn-sm")#
		#linkTo(action="clone", key=event.eventid, text="<span class='glyphicon glyphicon-repeat'></span> Clone", controller="bookings", class="btn btn-warning btn-sm")#
		#linkTo(action="delete", key=event.eventid, text="<span class='glyphicon glyphicon-trash'></span> Delete", controller="bookings", class="btn btn-danger btn-sm", confirm="Are you sure?")#
	</div>
</cfif>
<cfif checkPermission("viewRoomBooking")>
<cfif structKeyExists(application.rbs.templates, "event") AND structKeyExists(application.rbs.templates.event, "output")>
	 #processShortCodes(application.rbs.templates.event.output)#
<cfelse>
	<!--- Default Template--->
	<cfsavecontent variable="eventTemplate">
		<h4>[output id="title"]</h4>
		<div class="row">
			<div class="col-sm-2">
				<p><strong>From</strong></p>
			</div>
			<div class="col-sm-10">
				[output id="start"]
			</div>
		</div>

		<div class="row">
			<div class="col-sm-2">
				<p><strong>To</strong></p>
			</div>
			<div class="col-sm-10">
				[output id="end"]
			</div>
		</div>

		<div class="row">
			<div class="col-sm-2">
				<p><strong>Location</strong></p>
			</div>
			<div class="col-sm-10">
				[output   id="name" append=","] [output id="description"] ([output id="layoutstyle"] style)
			</div>
		</div>

		<p>[output label="Contact" id="contactname"] [output id="contactemail" prepend="(", append=")"] [output id="contactno" prepend="(", append=")"]</p>

		[output id="eventdescription", prepend="<div class='well'>", append="</div>"]

	</cfsavecontent>
	#processShortCodes(eventTemplate)#
</cfif>

<!---================= Resources =================--->
	<cfif application.rbs.setting.allowResources AND len(event.resourceid)>
	<hr />
	<h4>Requested Resources:</h4>
		<cfloop query="event">
			<cfloop query="resources">
				<cfif event.resourceid EQ resources.id[currentrow]>
					<p><strong>#h(name)#</strong><br /><small>#h(description)#</small></p>
				</cfif>
			</cfloop>
		</cfloop>
	</cfif>



<cfelse>
	<p>You're not allowed to view the booking details</p>
</cfif></cfoutput>
