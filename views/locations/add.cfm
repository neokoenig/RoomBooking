<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Add Location --->
<cfparam name="location">
<cfoutput>
#panel(title="New Location")#
	#startFormTag(action="create", id="locationForm")#
	#includePartial("form")#
	#submitTag(value="Create New Location")#
	#endFormTag()#
#panelEnd()#
</cfoutput>