component extends="Admin" {

	function init() {
		super.init();
		filters(through="checkPermissionAndRedirect", permission="accessUsers");

		verifies(except="index,new,create", params="key", paramsTypes="integer", handler="objectNotFound");
		verifies(post=true, only="create,update,delete");

		filters(through="f_getRoles", only="index,new,create,edit,update");
		filters(through="f_getCountries", only="index,new,create,edit,update");
	}

	function index() {
		request.pagetitle="All Users";
		users=model("user").findAll(include="role");
	}

	function show() {
		request.pagetitle="User Profile";
		user=model("user").findByKey(params.key);
		if(!isObject(user)){
			objectNotFound();
		}
	}

	function new() {
		request.pagetitle="Create New User";
		user=model("user").new();
	}

	function create() {
		user=model("user").create(params.user);
		if(user.hasErrors()){
			renderPage(action="new");
		} else {
			return redirectTo(action="index", success="User #user.firstname# #user.lastname# successfully created");
		}
	}

	function edit() {
		request.pagetitle="Update User";
		user=model("user").findByKey(params.key);
	}

	function update() {
		user=model("user").findByKey(params.key);
		if(user.update(params.user)){
			return redirectTo(action="index", success="User #user.firstname# #user.lastname# successfully updated");
		} else {
			renderPage(action="edit");
		}
	}

	function delete() {
		user=model("user").deleteByKey(params.key);
		return redirectTo(action="index", success="User successfully deleted");
	}

	function objectNotFound() {
		return redirectTo(action="index", error="That User wasn't found");
	}

}
