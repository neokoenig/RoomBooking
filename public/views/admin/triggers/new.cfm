<cfoutput>
	#linkTo(route="adminTriggers", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class="btn btn-primary btn-flat")#
<hr />
	#startFormTag(route="adminTriggers")#
		#errorMessagesFor("trigger")#
		#includePartial("form")#
		#submitTag(value=l("Create Trigger"), class='btn btn-success')#
	#endFormTag()#
</cfoutput>
