<!--- Edit Location --->
<cfparam name="location"> 
<cfoutput>
#panel(title="Update Location")#
	#startFormTag(action="update", key=location.id)# 
	#includePartial("form")#
	#submitTag(value="Update Location")#
	#endFormTag()#
#panelEnd()#
</cfoutput>