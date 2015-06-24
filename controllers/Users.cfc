//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Controller" hint="Main User Controller"
{
	/**
	 * @hint Constructor.
	 */
	public void function init() {
		// Permission filters
		super.init();
		filters(through="_checkLoggedIn");
		filters(through="checkPermissionAndRedirect", permission="accessUsers", except="myaccount,updateaccount,updatepassword");
		filters(through="checkPermissionAndRedirect", permission="updateOwnAccount", only="myaccount,updateaccount,updatepassword");
		filters(through="denyInDemoMode", only="create,update,updateaccount,updatepassword,assumeuser,generateAPIKey");

		// Verification
		verifies(only="edit,update,delete,assumeUser,recover,generateAPIKey", params="key", paramsTypes="integer", route="home", error="Sorry, that user can't be found");


		// Data
		filters(through="getCurrentUser", only="myaccount,updateaccount,updatepassword");
		filters(through="_getRoles", only="index,add,edit,delete,update,create");
	}

/******************** Public***********************/
	/**
	*  @hint Main Account Update
	*/
	public void function updateaccount() {
		if(structKeyExists(params, "password")){
			structDelete(params, "password");
			structDelete(params, "passwordConfirmation");
		}
		if(structKeyExists(params, "user")){
			structDelete(params.user, "role");
			user.update(params.user);
			if(user.save()){
				redirectTo(route="myaccount", success="Personal account details successfully updated");
			}
			else {
				renderPage(action="myaccount");
			}
		}
	}

	/**
	*  @hint Seperate PW change update
	*/
	public void function updatepassword() {
		if(structKeyExists(params, "password") AND structKeyExists(params, "passwordConfirmation")
			AND (params.password EQ params.passwordConfirmation)){
			user.update(
				password=hashPassword(params.password, decryptSalt(user.salt))
			);
			if(user.save()){
				redirectTo(action="myaccount", success="Password successfully updated");
			}
			else {
				renderPage(action="myaccount");
			}
		}
		else {
			redirectTo(action="myaccount", error="Password and Password Confirmation must match");
		}
	}
/******************** Admin ***********************/
	/**
	*  @hint Login as targeted user
	*/
	public void function assumeUser() {
		if(!application.rbs.setting.isdemomode){
				user=model("user").findOne(where="id = #params.key#");
				_createUserInScope(user);
		}
		else {
			redirectTo( controller="users", action="index", success="Not allowed in demo mode");
		}
	}
	/**
	*  @hint Administrators only, account listings
	*/
	public void function index() {
		param name="params.page" default=1;
		users=model("user").findAll( group="id", includeSoftDeletes=false, perPage=25, page=params.page);
	}
	/**
	*  @hint Add New User
	*/
	public void function add() {
		user=model("user").new();
	}
	/**
	*  @hint Edit User
	*/
	public void function edit() {
		user=model("user").findOne(where="id = #params.key#");
	}
	/**
	*  @hint Create Account
	*/
	public void function create() {
		if(structkeyexists(params, "user")){
	    	user = model("user").new(params.user);
			if ( user.save() ) {
				redirectTo( controller="users", action="index", success="User account successfully created");
			}
	        else {
				renderPage( controller="users", action="add", error="");
			}
		}
	}
	/**
	*  @hint
	*/
	public void function update() {
		if(!application.rbs.setting.isdemomode){
			if(structkeyexists(params, "user")){
				user = model("user").findOne(where="id = #params.key#");
				user.update(params.user);
				if ( user.save() )  {
					redirectTo( controller="users", action="index", success="User account successfully updated");
				}
				else {
					flashInsert(error="There were problems updating that user");
					renderPage( controller="users", action="edit");
				}
			}
		} else {
			redirectTo( controller="users", action="index", success="Not updated in demo mode");
		}
	}
	/**
	*  @hint Soft Delete an Account
	*/
	public void function delete() {
	 	if(!application.rbs.setting.isdemomode){
		 if(structkeyexists(params, "key")){
	    	user = model("user").findOne(where="id = #params.key#");
			if ( user.delete() )  {
				redirectTo( controller="users", action="index", success="user successfully deleted");
			}
	        else {
				redirectTo(controller="users", action="index", error="There were problems deleting that user");
			}
		}
		} else {
			redirectTo( controller="users", action="index", success="Not updated in demo mode");
		}
	}
	/**
	*  @hint Recover a deleted Account
	*/
	public void function recover() {
		if(structkeyexists(params, "key")){
	    	user = model("user").findOne(where="id = #params.key#", includeSoftDeletes=true);
			user.deletedAt="";
			if ( user.save() )  {
				redirectTo( controller="users", action="index", success="user successfully recovered");
			}
	        else {
				redirectTo(controller="users", action="index", error="There were problems recovering that user");
			}
		}
	}

/******************** Ajax/Remote/Misc*************/
	/**
	*  @hint Generates An API Key for a user account
	*/
	public void function generateAPIKey() {
			user=model("user").findOneByID(params.key);
			if(isObject(user)){
				user.apitoken=_generateApiKey();
				user.save();
				redirectTo(controller="users", action="index", success="Key generation successful");
			} else {
				redirectTo(controller="users", action="index", error="Key generation failed - User not found");
			}
	}
}