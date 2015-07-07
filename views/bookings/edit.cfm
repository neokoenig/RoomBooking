<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Add --->
<cfoutput>
#panel(title=l("Editing Event"))#
#errorMessagesFor("event")#
	#startFormTag(action="update", key=event.id,  id="bookingform")#
		#includePartial("form")#
		#submitTag(value=l("Update Booking"),  class="btn btn-block btn-primary btn-lg")#
	#endFormTag()#
#panelend()#
</cfoutput>
