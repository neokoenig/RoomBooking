<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Add --->
<cfoutput>
#panel(title="Editing Event")#
#errorMessagesFor("event")#
	#startFormTag(action="update", key=event.id,  id="bookingform")#
		#includePartial("form")#
		#submitTag(value="Update Booking",  class="btn btn-block btn-primary btn-lg")#
	#endFormTag()#
#panelend()#
</cfoutput>
