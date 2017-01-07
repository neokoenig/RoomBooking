component extends="Controller"
{
	function init() {
		//super.init();
		verifies(post=true, only="authenticate,resetaction");
		usesLayout("/common/simple");
	}

	function login(){
		auth=model("auth." & application.rbs.settings.authentication_gateway).new();
	}

	function authenticate(){
		auth=model("auth." & application.rbs.settings.authentication_gateway).new(params.auth);
		if(!auth.hasErrors() && auth.login()){
			redirectTo(route="root", success=l("Successfully Logged In"));
		} else {
			renderPage(action="login");
		}
	}

	function logout(){
		forcelogout();
		redirectTo(route="root", success=l("You have been logged out"));
	}

}
