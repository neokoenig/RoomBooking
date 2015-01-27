<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Add Template--->
<cfparam name="template">
<cfoutput>
<cfset template.parentmodel=params.key>
<cfset template.type=params.type>
#panel(title="Create #h(params.key)# #h(params.type)# Template")#
	#startFormTag(action="createtemplate",  id="templateForm")#
	#hiddenField(objectname="template", property="parentmodel")#
	#includePartial("templateform")#
	#submitTag(id="templateSubmit", value="Create Template")#
	#endFormTag()#
#panelEnd()#
</cfoutput>