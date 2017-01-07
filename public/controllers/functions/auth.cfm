<cfscript>
	//=====================================================================
	//= 	Global Authentication Methods
	//=====================================================================
	function checkPermission(string permission=""){
		if(len(permission)){
			if(isAuthenticated()){
			 	return session.user.permissions[permission];
			} else {
				return application.rbs.permissions[permission];
			}
		} else {
			return false;
		}
	}

	function checkPermissionAndRedirect(required string permission){
		if(!checkPermission(permission)){
			redirectTo(route="authenticationDenied");
		}
	}

	function isAuthenticated(){
		return structKeyExists(session, "auth");
	}

	function forcelogout(){
		if(structKeyExists(session, "auth")){
			// Call Auth's built in logout() method
			session.auth.logout();
			// Destroy all auth stuff
			structDelete(session, "auth");
		}
		if(structKeyExists(session, "user")){
			// Destroy user data
			structDelete(session, "user");
		}
	}
</cfscript>
