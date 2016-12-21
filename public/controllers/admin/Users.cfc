component extends="Admin" {

	function init() {
		verifies(except="index,new,create", params="key", paramsTypes="integer", handler="objectNotFound");
	}

	/**
	*  @hint View all |ObjectNamePluralC|
	*/
	function index() {
		request.pagetitle="All Users";
		users=model("user").findAll();
	}

	/**
	*  @hint View User
	*/
	function show() {
		request.pagetitle="User Profile";
		user=model("user").findByKey(params.key);
	}

	/**
	*  @hint Add New User
	*/
	function new() {
		request.pagetitle="Create New User";
		user=model("user").new();
	}

	/**
	*  @hint Create User
	*/
	function create() {
		user=model("user").create(params.user);
		if(user.hasErrors()){
			renderPage(action="new");
		} else {
			redirectTo(action="index", success="User successfully created");
		}
	}

	/**
	*  @hint Edit User
	*/
	function edit() {
		request.pagetitle="Update User";
		user=model("user").findByKey(params.key);
	}

	/**
	*  @hint Update User
	*/
	function update() {
		user=model("user").findByKey(params.key);
		if(user.update(params.user)){
			redirectTo(action="index", success="User successfully updated");
		} else {
			renderPage(action="edit");
		}
	}

	/**
	*  @hint Delete User
	*/
	function delete() {
		user=model("user").deleteByKey(params.key);
		redirectTo(action="index", success="User successfully deleted");
	}

	/**
	*  @hint Redirect away if verifies fails, or if an object can't be found
	*/
	function objectNotFound() {
		redirectTo(action="index", error="That User wasn't found");
	}

}
