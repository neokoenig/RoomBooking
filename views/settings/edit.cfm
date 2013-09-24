<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Edit setting --->
<cfparam name="setting"> 
<cfoutput>
#panel(title="Update setting")#
	#startFormTag(action="update", key=setting.id)# 
	#includePartial("form")#
	#submitTag(value="Update setting")#
	#endFormTag()#
#panelEnd()#
</cfoutput>