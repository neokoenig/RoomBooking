component extends="Admin"
{
	function init() {
		super.init();
		filters(through="checkPermissionAndRedirect", permission="accessResources");
	}
	function index(){
		request.pagetitle="Resources";
	}
}
