<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Add --->
<cfoutput>
#panel(title="Create New Event")#
#errorMessagesFor("event")#
	#startFormTag(action="create", id="bookingform")#
		#includePartial("form")#
		#submitTag(value="Create Booking", class="btn btn-block btn-primary btn-lg")#
	#endFormTag()#
#panelend()#
</cfoutput>
