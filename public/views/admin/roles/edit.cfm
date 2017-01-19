<cfoutput>
	#linkTo(route="adminRoles", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class="btn btn-primary btn-flat")#
	<hr />
	#startFormTag(route="adminRole", key=role.key())#
		#hiddenFieldTag(name="_method", value="put")#
		#errorMessagesFor("role")#
		#includePartial("form")#
		#submitTag()#
	#endFormTag()#
</cfoutput>
