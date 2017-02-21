component extends="Admin" {

	function init() {
		super.init();
		verifies(except="index,new,create,assume,recover", params="key", paramsTypes="integer", handler="objectNotFound");
		verifies(post=true, only="create,update,delete");
		filters(through="f_getRoles", only="index,new,create,edit,update");
		filters(through="f_getCountries", only="index,new,create,edit,update");
	}

	function index() {
		param name="params.roleid" default="";
		param name="params.status" default="active";
		param name="params.page" default=1;
		param name="params.perpage" default=50;
		request.pagetitle="All Users";
		local.includesoftdeletes=false;
		local.where=[];
		// By Role
	    if(structKeyExists(params, "roleid") && isnumeric(params.roleid)){
	      ArrayAppend(local.where, "roleid = #params.roleid#");
	    }
	    // By Status: deliberately not using includesoftdeletes here
	    switch(params.status){
	    	case "active":
	    	local.includesoftdeletes=false;
	    	break;
	    	case "disabled":
	    	ArrayAppend(local.where, "deletedAt IS NOT NULL");
	    	local.includesoftdeletes=true;
	    	break;
	    	default:
	    	local.includesoftdeletes=true;
	    	//ArrayAppend(local.where, "status = #params.status#");
	    }

		users=model("user").findAll(where=whereify(local.where), include="role", includesoftdeletes=local.includesoftdeletes, page=params.page, perpage=params.perpage);
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
		return redirectTo(action="index", success="User successfully disabled");
	}

	function recover() {
		user=model("user").findByKey(key=params.key, includesoftdeletes=true);
		user.deletedAt="";
		user.save();
		return redirectTo(action="index", success="User successfully recovered");
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
