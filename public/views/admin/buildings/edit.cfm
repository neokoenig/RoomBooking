<cfoutput>
	#linkTo(route="adminBuildings", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class="btn btn-primary btn-flat")#
	<hr />
	#startFormTag(route="adminBuilding", key=building.key())#
		#hiddenFieldTag(name="_method", value="put")#
		#errorMessagesFor("building")#
		#includePartial("form")#
		#submitTag()#
	#endFormTag()#
</cfoutput>
