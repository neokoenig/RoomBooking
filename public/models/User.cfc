component extends="Model"
{
	function init() {
		hasOne("role");
		hasMany("userpermissions");
		property(name="roleid", defaultValue=0);
		beforeValidation("validatePasswords");
		validatesPresenceOf(properties="firstname,lastname,email");
        validatesLengthOf(properties="firstName,lastName", maximum=50);
        validatesUniquenessOf(property="email");
        validatesConfirmationOf(property="password");
	}

	public void function validatePasswords() {
		if(structKeyExists(this, "password") AND structKeyExists(this, "passwordConfirmation")){
			if(this.password EQ this.passwordConfirmation){
				if(len(this.password) LT 6 OR len(this.password) GT 55){
					this.addError(property="password", message="Your password must be at least 6 characters");
				}
			} else {
				this.addError(property="password", message="Passwords must match!");
			}
		}
	}
}
