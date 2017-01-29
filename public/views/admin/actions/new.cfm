<cfoutput>
	#linkTo(route="adminActions", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class="btn btn-primary btn-flat")#
<hr />
	#startFormTag(route="adminActions")#
		#errorMessagesFor("theaction")#
		#includePartial("form")#
		#submitTag(value=l("Create Action"), class='btn btn-success')#
	#endFormTag()#
</cfoutput>
