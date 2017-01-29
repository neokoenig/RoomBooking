<cfoutput>
	#linkTo(route="adminActions", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class="btn btn-primary btn-flat")#
	<hr />
	#startFormTag(route="adminAction", key=theaction.key())#
		#hiddenFieldTag(name="_method", value="put")#
		#errorMessagesFor("theaction")#
		#includePartial("form")#
		#submitTag()#
	#endFormTag()#
</cfoutput>
