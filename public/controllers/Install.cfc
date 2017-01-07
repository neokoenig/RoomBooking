component extends="Controller"
{
	/*
		Installer

		Several Checks needed, and various initial errors to catch;
		1) Any model call to a non existant datasource will error
		2) Settings won't be loaded into application scope
		3) Any error emails without a smtp handler will error out
		4) Any missing plugins will create a problem (this shouldn't be an issue in 2.x)
		5) If DB exists, but is at "0" this will also throw errors
		6) key [CURRENT] doesn't exist: language onRequestStart

		So we need to:

		1) Check the datasource exists;
		2) Run the DB migrations -> Latest to populate the Database
		3) Create an initial sysadmin user
		4) Test for SMTP?

	*/
	function init() {
		usesLayout("/common/static");
		filters(through="abortifinstalled", only="rundbmigrate,createsysadmin");
	}

	function index(){
	}

	function rundbmigrate(){
		application.wheels.plugins.dbmigrate.migrateTo(application.rbs.dbmigrate.latest);
		redirectTo(route="installIndex", params="reload=true&password=#get('reloadpassword')#");
	}

	function createsysadmin(){
		if(application.rbs.allowSysadminCreation){
		// Doing this manually here to bypass all the model verifications etc.
		sysadminQ = queryExecute("
			INSERT INTO users (firstname,lastname,password,username,email,roleid)
			VALUES (?,?,?,?,?,?);",
		    ["Default",
		    "Sysadmin",
		    application.bCrypt.hashpw(params.password, application.bCrypt.gensalt()),
		    "sysadmin",
		    "test@test.com",
		    1
		    ],
		    {
		        datasource    = application.wheels.datasourcename
		    }
		);
		redirectTo(route="installIndex", params="reload=true&password=#get('reloadpassword')#");
		} else {
			abort;
		}
	}

	function abortifinstalled(){
		if(application.rbs.installed){
			abort;
		}
	}
}
