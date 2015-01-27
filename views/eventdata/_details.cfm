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

	<!---================= Details =================--->
	<h4>#h(event.title)#</h4>
	<p>#_formatDateRange(d1=event.start, d2=event.end, allday=event.allday)#
	<p>Location: #h(event.name)#<br />#h(event.description)#</p>
	<cfif len(event.description)>
		<p>#h(event.eventdescription)#</p>
	</cfif>
	<p>(#event.layoutstyle# Style)</p>

	<!---================= Contact =================--->
	<cfif len(event.contactname) OR len(event.contactemail) OR len(event.contactno)>
	<hr />
	<h4>Contact Details:</h4>
		<p>
		<cfif len(event.contactname)>
			#h(event.contactname)#<br />
		</cfif>
		<cfif len(event.contactemail)>
			#autolink(event.contactemail)#<br />
		</cfif>
		<cfif len(event.contactno)>
			#h(event.contactno)#
		</cfif>
	</p>
	</cfif>

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
