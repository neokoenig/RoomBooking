<cfoutput>

<div class="login-box">
  <div class="login-logo">
    <a href="/"><b>OxAlto</b>RBS</a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
	#startFormTag(route="passwordresetCreate")#
		#textFieldTag(name="email", label=l("Email"))#
		#submitTag(value=l("Send Password Reset Email"), class="btn btn-block btn-primary")#
	#endFormTag()#
	<p style="margin-top:10px;">#linkTo(route="authenticationLogin", text=l("Cancel"))#</p>
  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->
</cfoutput>
hi
