<cfoutput>
	#linkTo(route="adminCalendars", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class="btn btn-primary btn-flat")#
	<hr />
	#startFormTag(route="adminCalendar", key=calendar.key())#
		#hiddenFieldTag(name="_method", value="put")#
		#errorMessagesFor("calendar")#
		#includePartial("form")#
		#submitTag()#
	#endFormTag()#
</cfoutput>
