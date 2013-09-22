<!--- Add --->
<cfoutput>
#panel(title="Create New Event")#
#errorMessagesFor("event")#
#startFormTag(action="create")#
<div class="row">
	<div class="col-lg-8">
		#includePartial("form")#
		#checkbox(objectName="event", property="emailContact", label="Send Confirmation Email to Contact")# 
	</div>
	<div class="col-lg-4">
		#includePartial("repeat")#
	</div>
</div>
	
	#submitTag(value="Create Booking")#
#endFormTag()#
#panelend()#
</cfoutput>
