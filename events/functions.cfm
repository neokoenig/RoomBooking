<!---================= Room Booking System / https://github.com/neokoenig =======================--->

<!---================= Generic Functions =======================--->
<cffunction name="getIPAddress" hint="Gets IP address even from Railo" returntype="String">
	<cfscript>
	var result="127.0.0.1";
	var myHeaders = GetHttpRequestData();
    if(structKeyExists(myHeaders, "headers") AND structKeyExists(myHeaders.headers, "x-forwarded-for")){
      result=myHeaders.headers["x-forwarded-for"]; 
    }
    return result;
	</cfscript>
</cffunction>
 
 <cffunction name="returnStringFromBoolean" output="false" hint="I know this is stupid, but it's a hack with the way I'm doing the settings in the db">
 	<cfargument  name="boo">
 	<cfif arguments.boo>
 		<cfreturn "true">
 	<cfelse>
 		<cfreturn "false">
 	</cfif>
 </cffunction>

<!---================= Auth Functions =======================--->
<cffunction name="currentUser" hint="Returns the current signed in user">
	<cfscript>
	if ( isLoggedIn() ) {
			currentUser = model("user").findByKey(session.currentUser.id);
			return currentUser;
		}
	</cfscript> 
</cffunction>

<cffunction name="signOut" hint="Signs out the user">
	<cfscript>
	if (isLoggedIn() ) {
		 		StructDelete(session, "currentUser");
		 	}
	</cfscript> 
</cffunction>

<!--- Notes on salting / hashing:
	Password is hashed using a salt
	Salt is encrypted with a unique key (AuthKey) 

	So to compare a password hash, you need to decrypt the salt first

	The authKey is unique per installation; It's useful as you can invalidate all the site passwords in one go by just changing it
	--->
  
<cffunction name="getAuthKey" hint="Returns a semi-unique key per installation">
	<!--- Check for key, if it exists return, otherwise create--->
	<cfscript>
		var authkeyLocation=expandPath("/config/auth.cfm");
		var authkeyDefault=createUUID();
	</cfscript>
	<cfif fileExists(authkeyLocation)>
		<cffile action="read" file="#authkeyLocation#" variable="authkey">
		<cfreturn authkey>
	<cfelse>
		<cffile action="write" file="#authkeyLocation#" output="#authkeyDefault#">
		<cfreturn authkeyDefault>
	</cfif>
</cffunction>

<cffunction name="createSalt" hint="Create Salt using authkey">
	<cfscript>
	 return encrypt(createUUID(), getAuthKey(), 'CFMX_COMPAT');
	</cfscript> 
</cffunction>

<cffunction name="decryptSalt" hint="Get salt using authkey">
	<cfargument name="string" required="true">
	<cfscript>
	return decrypt(arguments.string, getAuthKey(), 'CFMX_COMPAT');
	</cfscript> 
</cffunction>

<cffunction name="hashPassword" hint="Hash Password using SHA512">
	<cfargument name="string" required="true">
	<cfargument name="salt" required="true">
	<cfscript>
	return hash(arguments.string & arguments.salt, 'SHA-512');
	</cfscript> 
</cffunction>

<!---================= Permission Functions =======================--->
<cffunction name="checkPermission" hint="Checks a permission against permissions loaded into application scope for the user" returntype="boolean">
	<cfargument name="permission" required="true" hint="The permission name to check against">
	<cfscript> 
		if(_permissionsSetup() AND structKeyExists(application.rbs.permission, arguments.permission)){
			var retValue = application.rbs.permission[arguments.permission][_returnUserRole()];
			if(retValue == 1){
				return true;
			} else {
				return false;
			}
			//return application.rbs.permission[arguments.permission][_returnUserRole()];
		} 
	</cfscript>
</cffunction>

<cffunction name="checkPermissionAndRedirect" hint="Checks a permission and redirects away to access denied, useful for use in filters etc">
	<cfargument name="permission" required="true" hint="The permission name to check against">
	<cfscript> 
		if(!checkPermission(arguments.permission)){
			redirectTo(route="denied", error="Sorry, you have insufficient permission to access this. If you believe this to be an error, please contact an administrator.");
		}
	</cfscript>
</cffunction>


<cffunction name="_permissionsSetup" hint="Checks for the relevant permissions structs in application scope">
	<cfscript>
		if(structKeyExists(application, "rbs") AND structKeyExists(application.rbs, "permission")){
				return true;
		} 
		else 
		{
			return false;
		}
	</cfscript>
</cffunction>

<cffunction name="_returnUserRole" hint="Looks for user role in session, returns guest otherwise">
	<cfscript>
		if(_permissionsSetup() AND isLoggedIn() AND structKeyExists(session.currentuser, "role")){
			return session.currentuser.role;
		} else {
			return "guest";
		}
	</cfscript>
</cffunction>

<cffunction name="denyInDemoMode" hint="Used to redirect away in demo mode">
	<cfif application.rbs.setting.isdemomode>
		<cfset redirectTo(route="home", error="Disabled in Demo Mode")>
	</cfif>
</cffunction>
