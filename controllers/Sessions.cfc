//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Controller" hint="Sessions Controller"
{
	/*
	 * @hint Constructor.
	 */
	public void function init() {
		// Permission filters - NB, doesn't go via super.init()
		filters(through="redirectIfLoggedIn", only="new,attemptlogin");
	}

/******************** Public***********************/
	/*
	 * @hint Switch language
	*/
	public void function langswitch() {
		param name="lang" default="en_GB";
		structDelete(session, "lang");
		session.lang=params.lang;
		redirectTo(back=true);
	}
	/**
	*
	*  @hint Login procedure
	*/
	public void function attemptlogin() {
		
		if(structkeyexists(params, "email") AND structkeyexists(params, "password")){
			if(application.rbs.setting.useExternalAuthentication 
				&& len(application.rbs.setting.authenticationEndPoint) 
				&& application.rbs.setting.authenticationEndPoint != "N/A"){
				// Try for external authentication
				extAuth();
			} else if(application.rbs.setting.useLocalUserAccounts) {
				localAuth();
			} else { 
				addLogline(type="Login", message="Auth attempted, but no authentication methods setup");
				RedirectTo(error="We could not sign you in. No Autentication Methods Found.", route="login");
			}
		}
		else {
			addLogline(type="Login", message="Bad Login [Need Email and Password]");
			RedirectTo(error="We could not sign you in. Please try that again.", route="login");
		}
	}

	/*
	* @hint: Attempt to send credentials to an external API Endpoint: expects a JSON object back, 
	* i.e {"id":"B123456","full_name":"John Doe","firstname":"John","lastname":"Doe","email":"jdoe@mailz.com","role":"user"}
	* This data then loaded into user's session scope.
	* NB: id, firstname, lastname, email, role are required for a successful login - any other response is assumed to be a incorrect login
	*/
	public void function extAuth() {
		var loc={
			endpoint=application.rbs.setting.authenticationEndPoint,
			authService = new http()
		}; 
		try{
			loc.authService.setMethod("post"); 
		    loc.authService.setCharset("utf-8"); 
		    loc.authService.setUrl(loc.endpoint);  
		    loc.authService.addParam(type="formfield",name="email",		value=trim(params.email)); 
		    loc.authService.addParam(type="formfield",name="user",		value=trim(params.email)); 
		    loc.authService.addParam(type="formfield",name="password",	value=trim(params.password));   
		    loc.authResult = loc.authService.send().getPrefix(); 
		    // Try for JSON, then XML, then die 
		    if(isJSON(loc.authResult.filecontent)){ 
			    loc.result=deserializeJSON(loc.authResult.filecontent);
			    if( structKeyExists(loc.result, "id") &&
					structKeyExists(loc.result, "firstname") &&
					structKeyExists(loc.result, "lastname") &&
					structKeyExists(loc.result, "email") &&
					structKeyExists(loc.result, "role") ){ 
				    // External auth not going to use API key 
				    if(!structKeyExists(loc.result, "apitoken")){
				    	loc.result.apitoken="";
				    }
				    // This cookie is only set AFTER a successful login, to prevent mistyped email
					if(structkeyexists(params, "rememberme")){
						setCookieRememberUsername(params.email);
					}
					
					addlogline(type="Login", message="#loc.result.id# - #loc.result.email# successfully logged in via External Auth", userid=loc.result.id);
				    _createUserInScope(loc.result);
			    } else { 
		    		addLogline(type="Login", message="Bad Login [Incorrect Login?]");
					redirectTo(error="We could not sign you in. Please try that again.", route="login");
			    }  
		    } else {  
		    	addLogline(type="Login", message="Bad Login [External API not returning JSON]");
				RedirectTo(error="We could not sign you in. Please try that again.", route="login");
		    } 
		} catch(any e){
			throw(message="Attempt to use External Authentcation Endpoint Failed", detail=e.message);
		} 
	}

	/*
	* @hint: Local User Account Authentication
	*/
	public void function localAuth() {
		var p={};
		var user = model("user").findOneByEmail(params.email); 
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
					RedirectTo(error="We could not sign you in. Please try that again.", route="login");;
				}
			}
			else {
				addLogline(type="Login", message="Bad Login [User isn't object, searched for #h(params.email)#]");
				RedirectTo(error="We could not sign you in. Please try that again.", route="login");
			}
	}

	/*
	 * @hint Logout a user
	*/
	public void function logout() {
		StructDelete(session, "currentUser");
		redirectTo(route="home", success="You have been successfully signed out");
	}

	/*
	 * @hint Forget Users cookie
	*/
	public void function forgetme() {
		setCookieForgetUsername();
		redirectTo(route="login");
	}


}