component extends="Admin"
{
	function init() {
		super.init();
		filters(through="checkPermissionAndRedirect", permission="accessLogs");
		filters(through="f_getRoles", only="index");
		filters(through="f_getPermissions", only="index");
	}
	function index(){
		request.pagetitle="Permissions";
		permissions=model("permission").findAll(include="rolepermissions", order="permissions.name,rolepermissions.roleid");
	}
}
