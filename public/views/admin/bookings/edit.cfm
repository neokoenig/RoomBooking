<cfoutput>
	#linkTo(route="adminbookings", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class='btn btn-primary')#
	<hr />
	#startFormTag(route="adminbooking", key=booking.key())#
		#hiddenFieldTag(name="_method", value="put")#
		#errorMessagesFor("booking")#
		#includePartial("form")#
		#submitTag()#
	#endFormTag()#
</cfoutput>
