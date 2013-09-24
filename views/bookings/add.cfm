<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Add --->
<cfoutput>
#panel(title="Create New Event")#
#errorMessagesFor("event")#
#startFormTag(action="create")#
 
		#includePartial("form")#
		#checkbox(objectName="event", property="emailContact", label="Send Confirmation Email to Contact")# 
		<cfif application.rbs.isDemoMode>
			<p class="help-block">No emails will be sent in demo mode</p>
		</cfif> 
		#includePartial("repeat")#
 
	
	#submitTag(value="Create Booking")#
#endFormTag()#
#panelend()#
</cfoutput>
