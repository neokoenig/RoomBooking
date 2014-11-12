<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Add --->
<cfoutput>
#panel(title="Editing Event")#
#errorMessagesFor("event")#
	#startFormTag(action="update", key=event.id)#
		#includePartial("form")#
		#submitTag(value="Update Booking",  class="btn btn-block btn-primary")#
	#endFormTag()#
#panelend()#
</cfoutput>
