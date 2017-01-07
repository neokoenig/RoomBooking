<cfoutput>
	#linkTo(route="adminbookings", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class='btn btn-primary')#
<hr />
	#startFormTag(route="adminBookings")#
		#errorMessagesFor("booking")#
		#includePartial("form")#
		#submitTag(value=l("Create Booking"), class='btn btn-success')#
	#endFormTag()#
</cfoutput>
