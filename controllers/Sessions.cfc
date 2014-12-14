//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Controller" hint="Sessions Controller"
{
	/**
	 * @hint Constructor.
	 */
	public void function init() {
		// Permission filters - NB, doesn't go via super.init()
		filters(through="redirectIfLoggedIn", only="new,attemptlogin");
	}

/******************** Public***********************/
	/**
	*  @hint Login procedure
	*/
	public void function attemptlogin() {
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
					RedirectTo(error="We could not sign you in. Please try that again.", route="login");;
				}
			}
			else {
				addLogline(type="Login", message="Bad Login [User isn't object, searched for #h(params.email)#]");
				RedirectTo(error="We could not sign you in. Please try that again.", route="login");
				}
		}
		else {
			addLogline(type="Login", message="Bad Login [Need Email and Password]");
			RedirectTo(error="We could not sign you in. Please try that again.", route="login");
		}
	}

	/**
	*  @hint Logout a user
	*/
	public void function logout() {
		StructDelete(session, "currentUser");
		redirectTo(route="home", success="You have been successfully signed out");
	}

	/**
	*  @hint Forget Users cookie
	*/
	public void function forgetme() {
		setCookieForgetUsername();
		redirectTo(route="login");
	}


}