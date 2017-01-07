component extends="Controller"
{
	function init() {
		usesLayout("/common/simple");
		verifies(post=true, only="create,reset");
		verifies(only="recover", params="token", paramsTypes="string", handler="objectNotFound");
	}

	// Forgot password form
	function forgot(){
		request.pagetitle="Reset Password";
	}

	// Create password reset token
	function create(){
		if(structKeyExists(params, "email")){
			user=model("user").findOneByEmail(params.email);
			if(!isObject(user)){
				// This should probably return a more generic authentication message, as it basically reveals if the acc exists or not.
				return redirectTo(route="passwordresetForgot", error="Sorry, account not found");
			} else {
				user.generatePasswordResetToken();
				user.save();
				return redirectTo(route="authenticationLogin", success="A password reset email has been sent to you!");
			}
		}
	}

	// Load user from password reset token
	function recover(){
		request.pagetitle="Use Password Reset Token";

	}

	// Finally, reset the password
	function reset(){

	}

	function objectNotFound() {
		return redirectTo(route="passwordresetForgot", error="You have followed an outdated or incorrect reset code");
	}

}
