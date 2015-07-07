<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Add Location --->
<cfparam name="resource">
<cfoutput>
#panel(title=l("New Resource"))#
	#startFormTag(action="create", id="resourceForm")#
	#includePartial("form")#
	#submitTag(value=l("Create New Resource"))#
	#endFormTag()#
#panelEnd()#
</cfoutput>