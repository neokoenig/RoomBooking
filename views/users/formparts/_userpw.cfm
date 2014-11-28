<!--- User add pw fields--->
<cfoutput>
#panel(title="Initial Password")#
	#passwordField(objectname="user", property="password", label="Password *", required="true")#
	#passwordField(objectname="user", property="passwordConfirmation", label="Confirm Password *", required="true")#
#panelEnd()#
	</cfoutput>