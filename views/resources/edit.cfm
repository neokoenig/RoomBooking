<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Edit Location --->
<cfparam name="resource">
<cfoutput>
#panel(title=l("Update Resource"))#
	#startFormTag(action="update", key=resource.id, id="resourceForm")#
	#includePartial("form")#
	#submitTag(value=l("Update Resource"))#
	#endFormTag()#
#panelEnd()#
</cfoutput>