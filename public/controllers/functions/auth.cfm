<cfscript>

	// Used as a filter, and will redirect to login if not auth'd
	// If logged in, deny with 403.
	function checkPermissionAndRedirect(){
		if(!hasPermission())
			if(isAuthenticated()){
				useslayout("/common/denied");
			} else {
				redirectTo(route="login", error="Login Required");
			}
	}

</cfscript>
