component extends="controllers.Controller"
{
	function init() {
		// Shouldn't go via central permissions, so we don't call super.init
		usesLayout("/common/static");
		filters(through="abortifinstalled");
	}

	function create(){
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
		redirectTo(route="root", params="reload=true&password=#get('reloadpassword')#");
		} else {
			abort;
		}
	}
}
