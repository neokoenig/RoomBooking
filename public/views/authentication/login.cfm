<cfoutput>

<div class="login-box">
  <div class="login-logo">
    <a href="/" style="display: block;"><img src="/images/logo_med.png" alt="logo" /></a>
    <a href="/">#application.rbs.settings.general_sitename#</a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
	#startFormTag(route="authenticationAuthenticate")#
		#errorMessagesFor("auth")#
		#textField(objectname="auth", property="email", label=l("Email or Username"))#
		#passwordField(objectname="auth", property="password")#
  	<cfif auth.allowRememberMe>
  	 	#checkboxTag(name="rememberme", label="Remember Me")#
  	</cfif>
		#submitTag(value=l("Login"), class="btn btn-block btn-primary")#
	#endFormTag()#
	<cfif auth.allowPasswordReset>
		<p style="margin-top:10px;">#linkTo(route="passwordresetForgot", text=l("I forgot my password"))#</a></p>
	</cfif>
  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->
</cfoutput>
