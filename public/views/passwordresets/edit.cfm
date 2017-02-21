<cfoutput>

<div class="login-box">
  <div class="login-logo">
    <a href="/" style="display: block;"><img src="/images/logo_med.png" alt="logo" /></a>
    <a href="/">#application.rbs.settings.general_sitename#</a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
	#startFormTag(route="Passwordresets")#
      #passwordField(objectname="user", property="password", label=l("Password") & " *", required="true")#
      #passwordField(objectname="user", property="passwordConfirmation", label=l("Confirm Password") & " *", required="true")#
		#submitTag(value=l("Update Password"), class="btn btn-block btn-primary")#
	#endFormTag()#
  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->
</cfoutput>
