<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Add Template--->
<cfparam name="template">
<cfoutput>
#panel(title="Edit #template.parentmodel# Template")#
	#startFormTag(action="updatetemplate",  id="templateForm", key=template.parentmodel, params="type=#params.type#")#
	#includePartial("templateform")#
	#submitTag(id="templateSubmit", value="Update Template")#
	#endFormTag()#
#panelEnd()#
</cfoutput>