<cfcomponent extends="Model" output="false">
 
    <cffunction name="init">
    	<cfscript> 	   
        // This isn't working in RC1:       
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
 	</cfscript>
    </cffunction> 
 
 	<cffunction name="sanitize" hint="Sanitizes the user object">
    	<cfscript> 
		this.firstname = htmlEditFormat(this.firstname);
		this.lastname = htmlEditFormat(this.lastname);		
		this.address1 = htmlEditFormat(this.address1);		
		this.address2 = htmlEditFormat(this.address2);		
		this.state = htmlEditFormat(this.state);		
		this.postcode = htmlEditFormat(this.postcode);
		this.country = htmlEditFormat(this.country);
		this.tel = htmlEditFormat(this.tel);
		</cfscript>
    </cffunction>
    
    <cffunction name="securePassword" hint="Secures the password property before saving it">
    	<cfscript>
     	var	p={};   
		if (StructKeyExists(this, "password") AND StructKeyExists(this, "passwordConfirmation")) { 
	     	p.salt.uuid=createUUID();
	     	p.salt.encrypted=encrypt(p.salt.uuid, getAuthKey(), 'CFMX_COMPAT');
	     	p.pw.hashed=hash(this.password & p.salt.uuid, 'SHA-512');
	     	this.salt= p.salt.encrypted;
	     	this.password=p.pw.hashed;
	     } 
		</cfscript>
    </cffunction>
     
     <cffunction name="passwordToBlank">
     		 <cfscript>
			if ( StructKeyExists(this, "password") ){
				 this.password = "";
			}
			if ( StructKeyExists(this, "passwordConfirmation") ) {
				 this.passwordConfirmation = "";
            }
            </cfscript>
     </cffunction> 

     <cffunction name="setEmailConfirmationToken">
     	<Cfset this.emailConfirmationToken = generateToken()>
     </cffunction> 

     <cffunction name="createPasswordResetToken">
     	<Cfscript>
     	this.passwordResetToken = generateToken();
		this.passwordResetAt = Now();
		this.save();
     	</Cfscript>
     </cffunction>
     
     <Cffunction name="generateToken">
     	<cfreturn Replace(LCase(CreateUUID()), "-", "", "all")>
     </Cffunction>

</cfcomponent>	 