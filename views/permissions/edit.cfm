<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Edit setting --->
<cfparam name="permission"> 
<cfoutput>
#panel(title="Update Permission")#
	#startFormTag(action="update", key=permission.id)# 
	#includePartial("form")#
	#submitTag(value="Update Permission")#
	#endFormTag()#
#panelEnd()#
</cfoutput>