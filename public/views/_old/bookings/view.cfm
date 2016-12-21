<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfparam name="event">
<cfoutput>
#panel(title="Event Details")#
	#includePartial(partial="/eventdata/details")#
#panelEnd()#
</cfoutput>