<cfcomponent extends="Controller">

	<cffunction name="init">
		<cfscript>
		filters(through="logFlash", type="after");
		filters(through="redirectIfLoggedIn", only="new");

 		</cfscript>
	</cffunction>

	<cffunction name="new" hint="Create New Session">

	</cffunction>

	<cffunction name="attemptlogin" hint="Main Login Method">
		<cfscript>
		var p={};
		if(structkeyexists(params, "email") AND structkeyexists(params, "password")){
			user = model("user").findOneByEmail(params.email);

			  if(isObject(user)){
				p.salt.decrypted=decrypt(user.salt, getAuthKey(), 'CFMX_COMPAT');
				p.password.hashed = hash(params.password & p.salt.decrypted, 'SHA-512');

				if(p.password.hashed EQ user.password){
					// This cookie is only set AFTER a successful login, to prevent mistyped email
					if(structkeyexists(params, "rememberme")){
						setCookieRememberUsername(params.email);
					}
					addlogline(type="Login", message="#user.email# successfully logged in", userid=user.id);
					_createUserInScope(user);
				}
				else {
					addLogline(type="Login", message="PW doesn't match hashed");
					_badLogin();
				}
			}
			else {
				addLogline(type="Login", message="Bad Login [User isn't object, searched for #h(params.email)#]");
					_badLogin();
				}
		}
	else {
		addLogline(type="Login", message="Bad Login [Need Email and Password]");
		 _badLogin();
	}
		</cfscript>
	</cffunction>

	<cffunction name="logout" hint="Logs out a user">
		<cfscript>
			StructDelete(session, "currentUser");
			redirectTo(route="home", success="You have been successfully signed out");
		</cfscript>
	</cffunction>

	<cffunction name="forgetme" hint="Kills Cookie">
		<cfscript>
			setCookieForgetUsername();
			redirectTo(route="login");
		</cfscript>
	</cffunction>

	<cffunction name="denied" hint="Access Denied">

	</cffunction>

	<cffunction name="_badLogin" access="private">
		<cfscript>
			RedirectTo(error="We could not sign you in. Please try that again.", route="login");
		</cfscript>
	</cffunction>
</cfcomponent>

