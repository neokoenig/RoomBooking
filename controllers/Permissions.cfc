//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Controller" hint="Permissions Controller"
{
	/**
	 * @hint Constructor.
	 */
	public void function init() {
		// Permission filters
		super.init();
		filters(through="checkPermissionAndRedirect", permission="accessPermissions");
		filters(through="denyInDemoMode", only="edit,update");
		// Verification
		verifies(only="edit,update", params="key", paramsTypes="string", route="home", error="Sorry, that permission can't be found");

	}

/******************** Public***********************/
	/**
	*  @hint List Permissions
	*/
	public void function index() {
		permissions=model("permission").findAll(order="id");
	}

	/**
	*  @hint Edit Form
	*/
	public void function edit() {
		permission=model("permission").findOne(where="id = '#params.key#'");
		if(!isObject(permission)){
			redirectTo(back=true, error="Sorry, that permission can't be found, isn't editable or the board is in demo mode");
		}
	}

	/**
	*  @hint Update
	*/
	public void function update() {
		if(structkeyexists(params, "permission")){
	    	permission = model("permission").findOne(where="id = '#params.key#'");
	    	if(!isObject(permission)){
	    		redirectTo(back=true, error="Sorry, that permission can't be found, isn't editable or the board is in demo mode");
	    	} else {
				permission.update(params.permission);
				if ( permission.save() )  {
					redirectTo(action="index", success="permission successfully updated - please note you will need to reload the application for this to take effect");
				}
		        else {
					renderPage(action="edit", error="There were problems updating that permission");
				}
	    	}
		}
	}

}

