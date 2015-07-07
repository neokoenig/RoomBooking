<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- My Account --->
<cfoutput>
#errorMessagesFor("user")#
<div class="row">
	<div class="col-md-9">
	#startFormTag(route="updateaccount")#
		#includePartial("formparts/main")#
		#submitTag(value=l("Update My Details"))#
	#endFormTag()#
	</div>
	<div class="col-md-3">
		#panel(title=l("Change Password"))#
		<cfif application.rbs.setting.isDemoMode>
			<em>#l("Disabled in Demo Mode")#</em>
		<cfelse>
			#startFormTag(route="updatepassword")#
				#passwordFieldTag(name="password", label=l("Password"), required=true)#
				#passwordFieldTag(name="passwordConfirmation", label=l("Confirm Password"), required=true)#
				#submitTag(value=l("Update Password"))#
			#endFormTag()#
		</cfif>
		#panelend()#
	</div>
</div>
</cfoutput>

