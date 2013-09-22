<!--- Add Location --->
<cfparam name="location">
<cfoutput>
#panel(title="New Location")#
	#startFormTag(action="create")# 
	#includePartial("form")#
	#submitTag(value="Create New Location")#
	#endFormTag()#
#panelEnd()#
</cfoutput>