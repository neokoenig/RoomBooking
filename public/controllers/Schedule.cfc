component extends="Controller"
{
	function init() {
		super.init();
		filters(through="checkPermissionAndRedirect", permission="accessSchedule");
	}

	function index(){
		request.pagetitle="Schedule";
	}
}
