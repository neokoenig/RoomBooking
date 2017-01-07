<cfscript>
checks=[
	{
		"title": "Setup Datasource",
		"checkname": "datasource",
		"description": "A Database with the name <code>#application.wheels.dataSourceName#</code> needs to be setup in the lucee or ACF administrator"
	},
	{
		"title": "Run Database Migration Scripts",
		"checkname": "dbmigrate",
		"description": "We need to make sure your database schema is up to date",
		"partial": "rundbmigrate"
	},
	{
		"title": "Check for main Administrator Account",
		"checkname": "sysadmin",
		"description": "At least one sysadmin level account is required",
		"partial": "createsysadmin"
	}
];
if(arraylen(application.rbs.setupchecks.errors)){
	for(check in checks){
		for(error in application.rbs.setupchecks.errors){
			if(error.checkname == check.checkname){
				check.errors=error;
			}
		}
	}
}
if(arraylen(application.rbs.setupchecks.passes)){
	for(check in checks){
		for(pass in application.rbs.setupchecks.passes){
			if(pass.checkname == check.checkname){
				check.passes=pass;
			}
		}
	}
}
//writeDump(checks);
//writeDump(application.rbs);

</cfscript>
<cfoutput>

<div class="login-box">
  <div class="login-logo">
    <a href="/"><b>OxAlto</b>RBS</a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
	<cfloop from="1" to="#arraylen(checks)#" index="i">
		<cfscript>
		teststatus="muted";
		icon="";

		if(structKeyExists(checks[i], "passes")){
			teststatus = "success";
			icon="check"
		}
		if(structKeyExists(checks[i], "errors")){
			teststatus = "danger";
			icon="times"
		}
		</cfscript>

			<h4 class="text-#teststatus#">
				<cfif len(icon)>
				<i class="fa fa-#icon#"></i>
				</cfif> #checks[i]["title"]#
			</h4>
			<cfif teststatus == "muted">
				<p class="text-muted">#checks[i]["description"]#</p>
			</cfif>
			<cfif teststatus == "success">
				<p>#checks[i]["description"]#</p>
				<p class="text-success"><strong>#checks[i]["passes"]["message"]#</strong></p>
			</cfif>
			<cfif teststatus == "danger">
				<p>#checks[i]["description"]#</p>
				<p class="text-danger"><strong>#checks[i]["errors"]["message"]#</strong></p>
				<cfif structKeyExists(checks[i], "partial")>
					#includePartial(checks[i]["partial"])#
				</cfif>
			</cfif>
			<hr />
	</cfloop>
	<cfif arraylen(application.rbs.setupchecks.errors)>
		<p><a class="btn btn-primary" href="/install/?reload=production&password=#get('reloadpassword')#"><i class="fa fa-refresh"></i> Reload Application and Re-test</a></p>
	<cfelse>
		<p><a class="btn btn-success" href="/?reload=production&password=#get('reloadpassword')#"><i class="fa fa-check"></i> Go to Application</a></p>

	</cfif>


  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

</cfoutput>
