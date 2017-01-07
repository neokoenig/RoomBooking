<cfoutput>
	#linkTo(route="adminUsers", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class='btn btn-primary')#
<hr />
	#startFormTag(route="adminUsers")#
		#errorMessagesFor("user")#
		#includePartial("form")#
		#includePartial("password")#
		#includePartial("role")#
		#submitTag(value=l("Create User"), class='btn btn-success')#
	#endFormTag()#
</cfoutput>
