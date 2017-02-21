component extends="Controller"
{
	function init() {
		// Shouldn't go via central permissions, so we don't call super.init
		usesLayout("/common/simple");
		verifies(post=true, only="create,reset");
		verifies(only="edit", params="token", paramsTypes="string", handler="objectNotFound");
	}

	// Forgot password form
	function new(){
		request.pagetitle="Reset Password";
	}

	// Create password reset token
	function create(){
		if(structKeyExists(params, "email")){
			user=model("user").findOneByEmail(params.email);
			if(!isObject(user)){
				// This should probably return a more generic authentication message,
				// as it basically reveals if the acc exists or not.
				return redirectTo(route="newPasswordReset", error="Sorry, account not found");
			} else {
				user.generatePasswordResetToken();
				user.save();
				return redirectTo(route="login", success="A password reset email has been sent to you!");
			}
		}
	}

	// Load user from password reset token
	function edit(){
		request.pagetitle="Use Password Reset Token";

	}

	// Finally, reset the password
	function update(){

	}

	function objectNotFound() {
		return redirectTo(route="passwordreset", error="You have followed an outdated or incorrect reset code");
	}

}
