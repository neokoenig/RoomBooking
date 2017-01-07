<cfoutput>
	#linkTo(route="adminRooms", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class='btn btn-primary')#
	<hr />
	#startFormTag(route="adminRoom", key=room.key())#
		#hiddenFieldTag(name="_method", value="put")#
		#errorMessagesFor("room")#
		#includePartial("form")#
		#submitTag()#
	#endFormTag()#
</cfoutput>
