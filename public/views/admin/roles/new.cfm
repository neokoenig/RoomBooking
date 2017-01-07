<cfoutput>
	#linkTo(route="adminRoles", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class='btn btn-primary')#
<hr />
	#startFormTag(route="adminRoles")#
		#errorMessagesFor("role")#
		#includePartial("form")#
		#submitTag(value=l("Create Role"), class='btn btn-success')#
	#endFormTag()#
</cfoutput>
