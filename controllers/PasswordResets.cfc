<cfcomponent extends="controller">
		 
	<cffunction name="init">
		<cfscript>
		filters(through="logFlash", type="after"); 
		filters(through="redirectIfLoggedIn"); 
 		</cfscript>
	</cffunction> 

	<cffunction name="create">
		<cfscript>
		user = model("user").findOneByEmail(params.email);
		if ( isObject(user) ) { 
			user.createPasswordResetToken();
			sendEmail(to=user.email, 
				from="#application.rbs.setting.sitetitle# <#application.rbs.setting.siteemailaddress#>", 
				subject="[#application.rbs.setting.sitetitle#] Password Reset Request", 
				template="/email/passwordReset", 
				user=user);
			flashInsert(success="We've sent you an email with password reset instructions!");
			redirectTo(route="login"); 
		} else {
			flashInsert(error="Hmm... we couldn't find an account for that address");
			redirectTo(action="new");
		}
		
		</cfscript>
	</cffunction>
 
	<cffunction name="edit">
		<cfscript>
		user = model("user").findOneByPasswordResetToken(params.key);
		if ( isObject(user) ) {
			if ( DateDiff("h", user.passwordResetAt, Now()) > 2 ) {
				redirectTo(action="new", error="Password reset has expired. [PR2]");	
			}
			else {
				user.passwordToBlank();
			}
		}
		</cfscript>
 	</cffunction>

 	<cffunction name="update">
 		<cfscript>
		user = model("user").findOneByPasswordResetToken(params.key);
		user.salt=createSalt();
		user.password=hashPassword(user.password, user.salt);
		if ( isObject(user) && user.update(params.user) ) {
			addLogLine(type="login", success="Password reset successfully.");
			_createUserInScope(user);  
		}
		else {
			redirectTo(route="home", error="Sorry, that request failed [PR1]");
		}
 		</cfscript>
 	</cffunction>
</cfcomponent>
  
  