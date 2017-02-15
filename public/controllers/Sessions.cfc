component extends="Controller"
{
	function init() {
		// Shouldn't go via central permissions, so we don't call super.init
		verifies(post=true, only="create");
		usesLayout("/common/simple");
		//filters(through="logTrigger", name="Authentication.cfc");
	}

	function new(){
		auth=model("auth." & application.rbs.settings.authentication_gateway).new();
	}

	function create(){
		auth=model("auth." & application.rbs.settings.authentication_gateway).new(params.auth);
		if(!auth.hasErrors() && auth.login()){
			redirectTo(route="root", success=l("Successfully Logged In"));
		} else {
			renderPage(action="new");
		}
	}

	function delete(){
		forcelogout();
		redirectTo(route="root", success=l("You have been logged out"));
	}
}
