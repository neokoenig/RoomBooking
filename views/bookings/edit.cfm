<!--- Add --->
<cfoutput> 
#panel(title="Editing Event")#
#errorMessagesFor("event")#
	#startFormTag(action="update", key=event.id)#
		#includePartial("form")#
		#submitTag(value="Update Booking")#
	#endFormTag()#
#panelend()#
</cfoutput>
