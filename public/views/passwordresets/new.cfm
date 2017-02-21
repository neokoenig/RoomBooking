<cfoutput>

<div class="login-box">
  <div class="login-logo">
    <a href="/" style="display: block;"><img src="/images/logo_med.png" alt="logo" /></a>
    <a href="/">#application.rbs.settings.general_sitename#</a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
	#startFormTag(route="Passwordresets")#
		#textFieldTag(name="email", label=l("Email"))#
		#submitTag(value=l("Send Password Reset Email"), class="btn btn-block btn-primary")#
	#endFormTag()#
	<p style="margin-top:10px;">#linkTo(route="login", text=l("Cancel"))#</p>
  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->
</cfoutput>
