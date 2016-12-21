<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Edit Location --->
<cfparam name="location">
<cfoutput>
#panel(title=l("Update Location"))#
	#startFormTag(action="update", key=location.id, id="locationForm")#
	#includePartial("form")#
	#submitTag(value=l("Update Location"))#
	#endFormTag()#
#panelEnd()#
</cfoutput>