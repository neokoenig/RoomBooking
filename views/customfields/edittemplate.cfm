<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Add Template--->
<cfparam name="template">
<cfoutput>
#panel(title=l("Edit") & " #template.parentmodel# " & l("Template"))#
	#startFormTag(action="updatetemplate",  id="templateForm", key=template.parentmodel, params="type=#params.type#")#
	#includePartial("templateform")#
	#submitTag(id="templateSubmit", value=l("Update Template"))#
	#endFormTag()#
#panelEnd()#
</cfoutput>