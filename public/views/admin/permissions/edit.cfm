<cfoutput>
	#linkTo(route="adminPermissions", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class='btn btn-primary')#
	<hr />

	#startFormTag(route="adminPermission", key=permission.key())#
		#hiddenFieldTag(name="_method", value="put")#
		#includePartial("form")#
		#submitTag()#
	#endFormTag()#
</cfoutput>
