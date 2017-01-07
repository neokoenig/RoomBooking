<cfoutput>
	#linkTo(route="adminUsers", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class='btn btn-primary')#
	<hr />
	#startFormTag(route="adminUser", key=user.key())#
		#hiddenFieldTag(name="_method", value="put")#
		#errorMessagesFor("user")#
		#includePartial("form")#
		#includePartial("role")#
		#submitTag()#
	#endFormTag()#
</cfoutput>
