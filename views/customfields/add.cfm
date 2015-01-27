<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Add Custom Field--->
<cfparam name="customfield">
<cfoutput>
#panel(title="Create Customfield")#
	#startFormTag(action="create",  id="customfieldForm")#
	#includePartial("form")#
	#submitTag(id="customfieldSubmit", value="Create Customfield")#
	#endFormTag()#
#panelEnd()#
</cfoutput>