<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Add Location --->
<cfparam name="location">
<cfoutput>
#panel(title=l("New Location"))#
	#startFormTag(action="create", id="locationForm")#
	#includePartial("form")#
	#submitTag(value=l("Create New Location"))#
	#endFormTag()#
#panelEnd()#
</cfoutput>