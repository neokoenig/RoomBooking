<cfoutput>
	#linkTo(route="adminTriggers", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class="btn btn-primary btn-flat")#
	<hr />
	#startFormTag(route="adminTrigger", key=trigger.key())#
		#hiddenFieldTag(name="_method", value="put")#
		#errorMessagesFor("trigger")#
		#includePartial("form")#
		#submitTag()#
	#endFormTag()#
</cfoutput>
