<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
<p>#l("Please enter a new password")#.</p>
#startFormTag(action="update", key=params.key)#
#passwordField(objectName="user", property="password", label=l("New Password"))#
#passwordField(objectName="user", property="passwordConfirmation", label=l("Confirm Password"))#
#submitTag(value=l("Update Password"), class="btn btn-primary")#
#endFormTag()#
</cfoutput>