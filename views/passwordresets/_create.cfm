<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
	<!--- Reset --->
	#startFormTag(action="create", id="pwresetForm")#
		#textFieldTag(name="email", label=l("Email Address"), type="email", required="true")#
		<p class="help-block append">#l("Enter your e-mail address to receive instructions for resetting your password")#.</p>
		<div class="btn-group">
			#submitTag(value=l("Send Reset Email"), class="btn btn-primary")#
			#linkTo(text=l("Cancel"), controller="sessions", action="new",  class="btn btn-default")#
		</div>
	#endFormTag()#
</cfoutput>