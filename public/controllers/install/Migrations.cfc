component extends="controllers.Controller"
{
	function init() {
		// Shouldn't go via central permissions, so we don't call super.init
		usesLayout("/common/static");
		filters(through="abortifinstalled");
	}

	function create(){
		application.wheels.plugins.dbmigrate.migrateTo(application.rbs.dbmigrate.latest);
		redirectTo(route="install", params="reload=true&password=#get('reloadpassword')#");
	}

}
