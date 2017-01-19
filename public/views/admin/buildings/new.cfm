<cfoutput>
	#linkTo(route="adminBuildings", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class="btn btn-primary btn-flat")#
<hr />
	#startFormTag(route="adminBuildings")#
		#errorMessagesFor("building")#
		#includePartial("form")#
		#submitTag(value=l("Create Building"), class='btn btn-success')#
	#endFormTag()#
</cfoutput>
