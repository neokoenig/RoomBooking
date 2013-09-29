<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
#errormessagesFor("permission")#  
<h3>#permission.id#</h3>
#checkbox(objectName="permission", property="admin")#
#checkbox(objectName="permission", property="editor")#
#checkbox(objectName="permission", property="user")#
#checkbox(objectName="permission", property="guest")#
<span class="help-block">#permission.notes#</span>
</cfoutput>