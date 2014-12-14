//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Model" hint="User Model"
{
	/**
	 * @hint Constructor
	 */
	public void function init() {
		property(name="fullname", sql="CONCAT(firstname, ' ', lastname)");
		beforeSave("sanitize,securePassword");
		validatesFormatOf(property="email", type="email");
		validatesFormatOf(property="password",
			regEx="^.*(?=.{6,})(?=.*\d)(?=.*[a-z]).*$",
			message="Your password must be at least 6 characters long and contain a mixture of numbers and letters.");
		validatesPresenceOf("firstname,lastname,email");
		validatesConfirmationOf(properties="password", message="Your passwords must match!");
		validatesPresenceOf(properties="password", message="You must enter a password");
		validatesUniquenessOf("email");
	}

	/**
	*  @hint Sanitize inputs
	*/
	public void function sanitize() {
		this.firstname = htmlEditFormat(this.firstname);
		this.lastname = htmlEditFormat(this.lastname);
		this.address1 = htmlEditFormat(this.address1);
		this.address2 = htmlEditFormat(this.address2);
		this.state = htmlEditFormat(this.state);
		this.postcode = htmlEditFormat(this.postcode);
		this.country = htmlEditFormat(this.country);
		this.tel = htmlEditFormat(this.tel);
	}

	/**
	*  @hint Secure Password
	*/
	public void function securePassword() {
	  	var	p={};
		if (StructKeyExists(this, "password") AND StructKeyExists(this, "passwordConfirmation")) {
	     	p.salt.uuid=createUUID();
	     	p.salt.encrypted=encrypt(p.salt.uuid, getAuthKey(), 'CFMX_COMPAT');
	     	p.pw.hashed=hash(this.password & p.salt.uuid, 'SHA-512');
	     	this.salt= p.salt.encrypted;
	     	this.password=p.pw.hashed;
	     }
	}

	/**
	*  @hint Password to blank
	*/
	public void function passwordToBlank() {
		if ( StructKeyExists(this, "password") ){
			this.password = "";
		}
		if ( StructKeyExists(this, "passwordConfirmation") ) {
			this.passwordConfirmation = "";
		}
	}

	/**
	*  @hint Set Email conf token (not actually used)
	*/
	public void function setEmailConfirmationToken() {
		this.emailConfirmationToken = generateToken();
	}

	/**
	*  @hint Set PW reset token
	*/
	public void function createPasswordResetToken() {
		this.passwordResetToken = generateToken();
		this.passwordResetAt = Now();
		this.save();
	}

	/**
	*  @hint make unique token
	*/
	public string function generateToken() {
		return Replace(LCase(CreateUUID()), "-", "", "all");
	}
}
