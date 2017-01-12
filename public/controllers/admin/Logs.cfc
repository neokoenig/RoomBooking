component extends="Admin"
{
	function init() {
		super.init();
		//filters(through="checkPermissionAndRedirect", permission="accessLogs");
	}
	function index(){
		request.pagetitle="Logs";
	}
}
