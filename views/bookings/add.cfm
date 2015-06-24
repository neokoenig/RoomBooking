<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Add --->
<cfoutput>
#panel(title="Create New Event")#
#errorMessagesFor("event")#
	#startFormTag(action="create", id="bookingform")#
		#includePartial("form")#
		<cfif application.rbs.setting.approveBooking>
			#submitTag(value="Request Booking", class="btn btn-block btn-primary btn-lg")#
		<cfelse>
			#submitTag(value="Create Booking", class="btn btn-block btn-primary btn-lg")#
		</cfif>
	#endFormTag()#
#panelend()#
</cfoutput>
