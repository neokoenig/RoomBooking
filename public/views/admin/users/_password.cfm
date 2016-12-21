<cfoutput>
#box(title=l("Initial Password"))#
	<div class="row">
		<div class="col-md-4">
			#passwordField(objectname="user", property="password", label=l("Password") & " *", required="true")#
		</div>
		<div class="col-md-4">
			#passwordField(objectname="user", property="passwordConfirmation", label=l("Confirm Password") & " *", required="true")#
		</div>
	</div>
#boxEnd()#
</cfoutput>
