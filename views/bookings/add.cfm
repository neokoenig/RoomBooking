<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Add --->
<cfoutput>
#panel(title="Create New Event")#
#errorMessagesFor("event")#
	#startFormTag(action="create", id="bookingform")#
		#includePartial("form")#
		<!--- If approval process is on, and user is allowed to bypass approval --->
		<cfif application.rbs.setting.approveBooking AND checkPermission("bypassApproveBooking")>
			#submitTag(value="Create And Auto-approve Booking", class="btn btn-block btn-primary btn-lg")#
		<!--- If approval process in on and user can't bypass --->
		<cfelseif application.rbs.setting.approveBooking>
			#submitTag(value="Request Booking", class="btn btn-block btn-primary btn-lg")#
		<!--- Approval process off --->
		<cfelse>
			#submitTag(value="Create Booking", class="btn btn-block btn-primary btn-lg")#
		</cfif>
	#endFormTag()#
#panelend()#
</cfoutput>
