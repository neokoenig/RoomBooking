<cfoutput>
	<!--- Reset ---> 
	#startFormTag(action="create")# 
	<p>Enter your e-mail address to receive instructions for resetting your password.</p> 
	#textFieldTag(name="email", label="Email Address")# 
	<div class="btn-group"> 
	#submitTag(value="Send Reset Email", class="btn btn-primary")#
	#linkTo(text="Cancel", controller="sessions", action="new",  class="btn btn-default")#
	</div>
	#endFormTag()# 

</cfoutput>