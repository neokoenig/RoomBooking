<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- User add pw fields--->
<cfoutput>
#panel(title="Initial Password")#
	#passwordField(objectname="user", property="password", label=l("Password") & " *", required="true")#
	#passwordField(objectname="user", property="passwordConfirmation", label=l("Confirm Password") & " *", required="true")#
#panelEnd()#
	</cfoutput>