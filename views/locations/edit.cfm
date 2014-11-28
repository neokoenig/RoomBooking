<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Edit Location --->
<cfparam name="location">
<cfoutput>
#panel(title="Update Location")#
	#startFormTag(action="update", key=location.id, id="locationForm")#
	#includePartial("form")#
	#submitTag(value="Update Location")#
	#endFormTag()#
#panelEnd()#
</cfoutput>