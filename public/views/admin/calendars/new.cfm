<cfoutput>
	#linkTo(route="adminCalendars", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class="btn btn-primary btn-flat")#
<hr />
	#startFormTag(route="adminCalendars")#
		#errorMessagesFor("calendar")#
		#includePartial("form")#
		#submitTag(value=l("Create Calendar"), class='btn btn-success')#
	#endFormTag()#
</cfoutput>
