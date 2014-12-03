<cfoutput><cfparam name="params.email" default="#request.cookie.username#">
<cfparam name="savedemail" default="false">
<cfif len(params.email)>
	<cfset savedemail = true>
</cfif>
	<!--- User Login --->
	<cfif application.rbs.setting.isdemomode>
	<p><strong>Demo Login:</strong></p>
<pre>
admin@domain.com</pre>
	<p>Password: <pre>roombooking100</pre></p>
	</cfif>
		#startFormTag(route="attemptlogin", id="signinForm")#
		<cfif savedemail>
			<p>Welcome back <strong>#h(params.email)#</strong>. (#linkTo(text="Not You?", route="forgetme")#)</p>
			#hiddenFieldTag(name="email", value=params.email, label="E-mail")#
		<cfelse>
			#textFieldTag(name="email", value=params.email, label="E-mail",   required="true", type="email")#
		</Cfif>
		#passwordFieldTag(name="password", label="Password",  required="true", append="", class="form-control append")#
		<cfif !savedemail>
			#checkBoxTag(name="rememberme", label="Remember my email",  checked=savedemail)#
		</cfif>
			#submitTag(value="Sign in",  class="btn btn-primary btn-block append")#
			#linkTo(text="Forgot your password?",  controller="passwordResets", action="new")#
		#endFormTag()#
 		</div></div>
</cfoutput>