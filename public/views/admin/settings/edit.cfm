<cfoutput>
	#linkTo(route="adminSettings", text="<i class='fa fa-chevron-circle-left'></i> #l('Return to Listing')#", class="btn btn-primary btn-flat")#
	<hr />

	#startFormTag(route="adminSetting", key=setting.key())#
		#hiddenFieldTag(name="_method", value="put")#
		#includePartial("form")#
		#submitTag()#
	#endFormTag()#
</cfoutput>
