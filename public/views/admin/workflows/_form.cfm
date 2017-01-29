<cfoutput>
#box(title=l("Workflow Details"))#
	#textField(objectname="workflow", property="title", label=l("Title") & " *", placeholder="My New Workflow", required="true")#
	#checkBox(objectname="workflow", property="isactive", label=l("Active"))#
#boxEnd()#

</cfoutput>
