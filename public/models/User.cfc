component extends="Model"
{
	function init() {
		// Associations
		belongsTo(name="role", joinType="left");
		hasMany(name="bookings");
		hasMany(name="buildings");
		hasMany(name="rooms");
		hasMany(name="userpermissions");

		property(name="roleid", defaultValue=0);
		property(name="fullname", sql="CONCAT(firstname, ' ', lastname)");
		protectedProperties("passwordresettoken,apikey,roleid");

		beforeValidation(methods="validatePasswords", condition="structKeyExists(this,'passwordConfirmation')");
		beforeCreate(methods="generateAPIKey");
		beforeSave(methods="encryptPasswordCheck");

		validatesPresenceOf(properties="firstname,lastname,email");
        validatesLengthOf(properties="firstName,lastName", maximum=50);
        validatesUniquenessOf(property="email");
        validatesConfirmationOf(property="password");
        validatesFormatOf(property="password", regEx="^.*(?=.{8,})(?=.*\d)(?=.*[a-z]).*$", message="Your password must be at least 8 characters long and contain a mixture of numbers and letters.");
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

	public function encryptPasswordCheck(){
		if(structKeyExists(this, "password") && structKeyExists(this, "passwordConfirmation")){
			this.password=this.encryptPassword();
			this.pwlastresetat=now();
		} else {
			structDelete(this, "password");
		}
	}
	public string function encryptPassword(){
		return application.bCrypt.hashpw(this.password, application.bCrypt.gensalt());
	}

	public boolean function checkPassword(required string password){
		return application.bCrypt.checkpw(arguments.password, this.password);
	}

	public function generateAPIKey(){
		this.apikey=this.generatePassword(60);
	}

	public function generatePasswordResetToken(){
		this.passwordresettoken=generatePassword(20);
		this.pwresettokenat=now();
	}

	public string function generatePassword(numeric length=10){
		// Remove potentially confusing chars i, o, l
		local.lcase = "abcdefghjkmnpqrstuvwxyz";
		local.ucase = uCase(local.lcase);
		local.numbers = "0123456789";
		local.all = local.lcase & local.ucase & local.numbers;
		local.result = [];
		ArrayAppend(local.result, Mid(local.lcase, RandRange(1, len(local.lcase)), 1)); // 1 lowercase
		ArrayAppend(local.result, Mid(local.ucase, RandRange(1, len(local.ucase)), 1)); // 1 uppercase
		ArrayAppend(local.result, Mid(local.numbers, RandRange(1, len(local.numbers)), 1)); // 1 number
		for (i=1;i LTE (length -3);i=i+1) {
			ArrayAppend(local.result, Mid(local.all, RandRange(1, len(local.all)), 1));
		}
		return ArrayToList(local.result, "");
		CreateObject("java", "java.util.Collections").Shuffle(local.result);
		return ArrayToList(local.result, "");
	}
}
