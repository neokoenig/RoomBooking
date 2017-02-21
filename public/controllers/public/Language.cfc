component extends="app.controllers.Controller"
{
	function init() {
		// Shouldn't go via central permissions, so we don't call super.init
	}

	function index(){
		param name="lang" default="en_GB";
		structDelete(session, "lang");
		session.lang=params.lang;
		redirectTo(back=true);
	}
}


