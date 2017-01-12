<cfscript>

	// Used as a filter, and will redirect awayfrom a denied URL
	// If logged in, deny with 403; otherwise, redirect to login
	function checkPermissionAndRedirect(){
		if(!hasPermission())
			if(isAuthenticated()){
				redirectTo(route="authenticationDenied", error="Access Denied");
			} else {
				redirectTo(route="authenticationLogin", error="Login Required");
			}
	}

</cfscript>
