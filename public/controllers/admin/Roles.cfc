component extends="Admin"
{
	function init() {
		super.init();
		filters(through="f_getRoles", only="index");
		verifies(except="index,new,create", params="key", paramsTypes="integer", handler="objectNotFound");
		verifies(post=true, only="create,update,delete");
	}
	function index(){
		request.pagetitle="Roles";
	}


	function new() {
		request.pagetitle="Create New Role";
		role=model("role").new();
	}

	function create() {
		role=model("role").create(params.role);
		if(role.hasErrors()){
			renderPage(action="new");
		} else {
			return redirectTo(action="index", success="role #role.name# successfully created");
		}
	}

	function edit() {
		request.pagetitle="Update Role";
		role=model("role").findByKey(params.key);
	}

	function update() {
		role=model("role").findByKey(params.key);
		if(role.update(params.role)){
			return redirectTo(action="index", success="role #role.name# successfully updated");
		} else {
			renderPage(action="edit");
		}
	}

	function delete() {
		role=model("role").deleteByKey(params.key);
		return redirectTo(action="index", success="role successfully deleted");
	}

	function objectNotFound() {
		return redirectTo(action="index", error="That role wasn't found");
	}

}
