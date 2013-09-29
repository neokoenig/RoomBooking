<cfoutput> 
<p>Please enter a new password.</p> 
#startFormTag(action="update", key=params.key)#
#passwordField(objectName="user", property="password", label="New Password")#
#passwordField(objectName="user", property="passwordConfirmation", label="Confirm Password")#
#submitTag(value="Update Password", class="btn btn-primary")#
#endFormTag()# 
</cfoutput>  