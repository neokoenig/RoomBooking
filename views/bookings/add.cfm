<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Add --->
<cfoutput>
#panel(title="Create New Event")#
#errorMessagesFor("event")#
	#startFormTag(action="create")#
		#includePartial("form")#
		#submitTag(value="Create Booking")#
	#endFormTag()#
#panelend()#
</cfoutput>
