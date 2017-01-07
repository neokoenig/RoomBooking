component extends="Controller"
{
	function init() {
		super.init();
	}

	function index(){
		param name="lang" default="en_GB";
		structDelete(session, "lang");
		session.lang=params.lang;
		redirectTo(back=true);
	}
}


