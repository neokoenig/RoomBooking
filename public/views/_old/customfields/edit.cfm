<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Edit Custom Field--->
<cfparam name="customfield">
<cfoutput>
#panel(title=l("Update Customfield"))#
	#startFormTag(action="update", key=customfield.key(), id="customfieldForm")#
	#includePartial("form")#
	#submitTag(id="customfieldSubmit", value=l("Update Customfield"))#
	#endFormTag()#
#panelEnd()#
</cfoutput>