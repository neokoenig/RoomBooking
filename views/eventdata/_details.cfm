<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
<cfparam name="resources">
<cfif checkPermission("allowRoomBooking")>

<div class="btn-group">
	#linkTo(action="edit", key=event.eventid, text="Edit", controller="bookings", class="btn btn-info")#
	#linkTo(action="clone", key=event.eventid, text="Clone", controller="bookings", class="btn btn-warning")#
	#linkTo(action="delete", key=event.eventid, text="Delete", controller="bookings", class="btn btn-danger", confirm="Are you sure?")#
</div>
</cfif>
<cfif checkPermission("viewRoomBooking")>
<h4>#h(event.title)#</h4>
<p>#_formatDateRange(d1=event.start, d2=event.end)# <cfif event.allday>
	(ALL DAY)
</cfif></p>
<p>Location: #h(event.name)#<br />#h(event.description)#</p>
<cfif len(event.description)><p>#h(event.eventdescription)#</p></cfif>
<p>(#event.layoutstyle# Style)</p>
<cfif application.rbs.setting.allowResources>
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
<hr />
<h4>Contact Details:</h4>
<cfif len(event.contactname) OR len(event.contactemail) OR len(event.contactno)>
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
	<cfelse>
		<p>None provided</p>
</cfif>
<cfelse>
	<p>You're not allowed to view the booking details</p>
</cfif></cfoutput>
