component extends="Admin"
{
	function init() {
		super.init();
		filters(through="f_getRoles", only="index,edit,update");
		filters(through="f_getPermissions", only="index");
	}
	function index(){
		request.pagetitle="Permissions";
		permissions=model("permission").findAll(include="rolepermissions(role)", order="permissions.name,rolepermissions.roleid");
	}
	function edit() {
		request.pagetitle="Update Permission";
		permission=model("permission").findByKey(key=params.key, include="rolepermissions");
	}

	function update() {
		permission=model("permission").findByKey(params.key);
		if(permission.update(params.permission)){
			return redirectTo(route="adminPermissions", success="Permission #permission.name# successfully updated");
		} else {
			renderPage(action="edit");
		}
	}

	function objectNotFound() {
		return redirectTo(route="adminPermissions", error="That Permission wasn't found");
	}

}
