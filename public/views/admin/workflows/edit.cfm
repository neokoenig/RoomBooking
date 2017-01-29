<cfoutput>
	#linkTo(route="adminWorkflows", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class="btn btn-primary btn-flat")#
	<hr />
	#startFormTag(route="adminWorkflow", key=workflow.key())#
		#hiddenFieldTag(name="_method", value="put")#
		#errorMessagesFor("workflow")#
		#includePartial("form")#
		#submitTag()#
	#endFormTag()#
</cfoutput>
