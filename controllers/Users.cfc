<cfcomponent extends="Controller">

<cffunction name="init" access="public" returntype="string">
	 <cfscript>  
		filters(through="_checkLoggedIn"); 
		//filters(through="_checkAdmin", except="mycustomers,myaccount,updateaccount,mypassword,updatepassword,myprofile,myprofileupdate");
		filters(through="getCurrentUser", only="myaccount,updateaccount,updatepassword");
		filters(through="logFlash", type="after");
		filters(through="_getRoles", only="index,add,edit,delete,update,create");

		filters(through="checkPermissionAndRedirect", permission="accessUsers", except="myaccount,updateaccount,updatepassword");   
		filters(through="checkPermissionAndRedirect", permission="updateOwnAccount", only="myaccount,updateaccount,updatepassword");   
		filters(through="denyInDemoMode", only="create,update,updateaccount,updatepassword,assumeuser");
 	 </cfscript>accessUsers
</cffunction>

<!-------------------------------User level---------------------------------->
 

<cffunction name="updateaccount" hint="Main Account Update"> 
	<cfscript>  
	if(structKeyExists(params, "password")){
		structDelete(params, "password");
		structDelete(params, "passwordConfirmation");
	}
	if(structKeyExists(params, "user")){ 
		structDelete(params.user, "role");
		user.update(params.user);
		if(user.save()){
			redirectTo(route="myaccount", success="Personal account details successfully updated");
		}
		else {
			renderView(action="myaccount");
		}
	}
	</cfscript>
</cffunction>  

<cffunction name="updatepassword" hint="Seperate PW change update">
	<cfscript>
	if(structKeyExists(params, "password") AND structKeyExists(params, "passwordConfirmation")
		AND (params.password EQ params.passwordConfirmation)){ 
		user.update(
			password=hashPassword(params.password, decryptSalt(user.salt))
		);
		if(user.save()){
			redirectTo(action="myaccount", success="Password successfully updated");
		}
		else {
			renderView(action="myaccount");
		}
	} 
	else {
		redirectTo(action="myaccount", error="Password and Password Confirmation must match");
	}
	</cfscript>
</cffunction>
 
 
<!-------------------------------Admin level only / manageaccounts---------------------------------->

<cffunction name="assumeUser" hint="Login as targeted user">
	<cfscript>
	if(!application.rbs.setting.isdemomode){
		if(structKeyExists(params, "key")){
			user=model("user").findOne(where="id = #params.key#"); 
			_createUserInScope(user);
		} 
	}
	else {
		redirectTo( controller="users", action="index", success="Not allowed in demo mode");
	}
	</cfscript>	
</cffunction>

<cffunction name="index" hint="Administrators only, account listings">    	
	<cfparam name="params.page" default="1"> 
    <cfset users=model("user").findAll( group="id", includeSoftDeletes=false, perPage=25, page=params.page)>   
</cffunction>
  

<cffunction name="add" hint="Add Screen for account">
    <cfscript>
    	user=model("user").new();   
    </cfscript>
</cffunction>

<cffunction name="edit" hint="Edit Screen for Acount">
	<cfscript>		 
    	user=model("user").findOne(where="id = #params.key#"); 
	</cfscript> 

</cffunction>
    
<cffunction name="create" hint="Create an Account">
    <cfscript> 
	if(structkeyexists(params, "user")){
    	user = model("user").new(params.user);
		if ( user.save() ) {    
			redirectTo( controller="users", action="index", success="User account successfully created");
		}
        else {  
			renderView( controller="users", action="add", error="");
		} 
	}
	</cfscript>
</cffunction>
    
<cffunction name="update" hint="Update an Account">
    <cfscript> 
    if(!application.rbs.setting.isdemomode){
	if(structkeyexists(params, "user")){
    	user = model("user").findOne(where="id = #params.key#");
		user.update(params.user);
		if ( user.save() )  {   
			redirectTo( controller="users", action="index", success="User account successfully updated");
		}
        else { 
			flashInsert(error="There were problems updating that user");
			renderView( controller="users", action="edit");
		} 
	}
} else {redirectTo( controller="users", action="index", success="Not updated in demo mode");}
	</cfscript>
</cffunction>
     
<cffunction name="delete" hint="Soft Delete an Account">
	 <cfscript>
	 	 if(!application.rbs.setting.isdemomode){
	 if(structkeyexists(params, "key")){
    	user = model("user").findOne(where="id = #params.key#"); 
		if ( user.delete() )  {  
			redirectTo( controller="users", action="index", success="user successfully deleted");
		}
        else {  
			redirectTo(controller="users", action="index", error="There were problems deleting that user");
		} 
	}
}else {redirectTo( controller="users", action="index", success="Not updated in demo mode");}
	</cfscript>
</cffunction>

<cffunction name="recover" hint="Recover a deleted Account">
	 <cfscript>
	 if(structkeyexists(params, "key")){
    	user = model("user").findOne(where="id = #params.key#", includeSoftDeletes=true);
		user.deletedAt="";
		if ( user.save() )  {  
			redirectTo( controller="users", action="index", success="user successfully recovered");
		}
        else {  
			redirectTo(controller="users", action="index", error="There were problems recovering that user");
		} 
	}
	</cfscript>
</cffunction>   

<!---================= API Keys===========================--->
<cffunction name="generateAPIKey" hint="Generates An API Key for a user account">
	<cfscript>
	if(structKeyExists(params, "key") AND isnumeric(params.key)){
		user=model("user").findOneByID(params.key);
		if(isObject(user)){
			user.apitoken=_generateApiKey();
			user.save();
			redirectTo(controller="users", action="index", success="Key generation successful");
		} else {
			redirectTo(controller="users", action="index", error="Key generation failed - User not found");
		}
	} else {
 		redirectTo(controller="users", action="index", error="Key generation failed - Key not specified");
	}
	</cfscript>
	
</cffunction>
 
</cfcomponent>