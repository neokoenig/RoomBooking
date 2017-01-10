component extends="models.Model"
/*
	Authentication Tableless Model
	All these actions need to operate outside the central permissions system
*/
{
	function init() {
		table(false);
		property(name="name", defaultValue="Local Authentication Gateway");
		property(name="allowPasswordReset", defaultValue=true);
		property(name="allowRememberMe", defaultValue=true);
		validatesPresenceOf(properties="email,password");
		validatesLengthOf(properties="email,password", minimum=5);
		//validatesFormatOf(properties="email", type="email") "Email can acutally be username"
	}

	// Authenticates and if ok, saves the auth obj to session
	boolean function login(){
		if(this.valid() && this.authenticate() && this.save()){
			return true;
		} else {
			return false;
		}
	}

	function logout(){
		// Called when attempting to log a user out: it might be that an external/other authentiation method
		// Needs to do something else here. For local auth we'll just log the action probably
	}

	// Save resultant Auth Object to Session
	boolean function save(){
		session.auth=this;
		return true;
	}

	// Returns true is authentication is successful
	// For an external auth method, this might include LDAP/Remote stuff
	boolean function authenticate(){
		// Find the local user account
		if(this.email CONTAINS "@"){
			local.user=model("user").findOne(where="email = '#this.email#'");
		} else {
			local.user=model("user").findOne(where="username = '#this.email#'");
		}
		if(!isObject(local.user)){
			this.addError(property="email", message=l("Unknown User Account"));
			return false;
		} else {
			// If Found, check the pw
			if(local.user.checkPassword(this.password)){
				assignPermissions(local.user);
				return true;
			} else {
				this.addError(property="password", message=l("Password does not match user account"));
				return false;
			}
		}
	}

	function assignPermissions(user){
		// If coming from an external auth source, it might be that the the roleid is set in active directory (for instance)
		local.rolePermissions=getRolePermissions(arguments.user.roleid);
		// Get User Permissions from local user account which override Role based permissions
		local.userPermissions=getUserPermissions(arguments.user.id);
		// Merge Permissions in Scope
		local.permissions=mergePermissions(local.rolePermissions, local.userPermissions);
	 	// Store convienient data in Session Scope
		session["user"]={
			"permissions"= {},
			"properties" = arguments.user.properties()
		};
		for(permission in local.permissions){
			session["user"]["permissions"][permission]=local.permissions[permission]["value"];
		}
		// Mark last login time
		arguments.user.lastloggedinat=now();
		arguments.user.save();
	}

	include "functions.cfm";

}
