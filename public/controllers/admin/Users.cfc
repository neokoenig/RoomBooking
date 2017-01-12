component extends="Admin" {

	function init() {
		super.init();
		verifies(except="index,new,create,assume,show", params="key", paramsTypes="integer", handler="objectNotFound");
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
		user=model("user").new(params.user);
		// Allow assigning of role here as they should have the accessUsers permission
		user.roleid=params.user.roleid;
		if(!user.save()){
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
		// Allow assigning of role here as they should have the accessUsers permission
		user.roleid=params.user.roleid;
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

	function recover() {
	//	user=model("user").deleteByKey(params.key);
	//	return redirectTo(action="index", success="User successfully deleted");
	}

	function assume() {
		userToAssume=model("user").findByKey(params.key);
		if(isObject(userToAssume)){
			session.auth.assignPermissions(userToAssume);
			redirectTo(route="root", success=l("Assumed User") & ' ' &  userToAssume.email);
			//if(auth.login()){
			//	return redirectTo(route="root", success=l("Assumed User") & ' ' &  userToAssume.email);
			//} else {
			//	writeDump(auth.allErrors());
			//	abort;
			//}
		} else {
			objectNotFound();
		}
	}

	function objectNotFound() {
		return redirectTo(action="index", error="That User wasn't found", delay=true);
	}

}
