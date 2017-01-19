<cfoutput>
	#linkTo(route="adminRooms", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class="btn btn-primary btn-flat")#
<hr />
	#startFormTag(route="adminRooms")#
		#errorMessagesFor("room")#
		#includePartial("form")#
		#submitTag(value=l("Create Room"), class='btn btn-success')#
	#endFormTag()#
</cfoutput>
