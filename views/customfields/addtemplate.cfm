<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Add Template--->
<cfparam name="template">
<cfoutput>
<cfset template.parentmodel=params.key>
<cfset template.type=params.type>
#panel(title=l("Create") & " #h(params.key)# #h(params.type)# " & l("Template"))#
	#startFormTag(action="createtemplate",  id="templateForm")#
	#hiddenField(objectname="template", property="parentmodel")#
	#includePartial("templateform")#
	#submitTag(id="templateSubmit", value=l("Create Template"))#
	#endFormTag()#
#panelEnd()#
</cfoutput>