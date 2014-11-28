<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Edit Location --->
<cfparam name="resource">
<cfoutput>
#panel(title="Update resource")#
	#startFormTag(action="update", key=resource.id, id="resourceForm")#
	#includePartial("form")#
	#submitTag(value="Update Resource")#
	#endFormTag()#
#panelEnd()#
</cfoutput>