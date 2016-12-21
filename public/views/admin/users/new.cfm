<cfoutput>
	#linkTo(route="adminUsersRoot", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class='btn btn-primary')#

	#startFormTag(route="adminUsersCreate")#
		#includePartial("form")#
		#includePartial("password")#
		#includePartial("role")#
		#submitTag(value=l("Create User"), class='btn btn-success')#
	#endFormTag()#
</cfoutput>
