<cfoutput>
	#linkTo(route="adminWorkflows", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class="btn btn-primary btn-flat")#
<hr />
	#startFormTag(route="adminWorkflows")#
		#errorMessagesFor("workflow")#
		#includePartial("form")#
		#submitTag(value=l("Create Workflow"), class='btn btn-success')#
	#endFormTag()#
</cfoutput>
