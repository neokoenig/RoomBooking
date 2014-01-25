<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfcomponent extends="Wheels">
 
	<cffunction name="init">
		<cfscript> 
		</cfscript>
	</cffunction>

<!---================================ Global Auth Functions ======================================--->
	<cffunction name="getCurrentUser">
        <cfscript>
        user=model("user").findOne(where="id=#session.currentUser.id# AND email = '#session.currentUser.email#'"); 
        if(!isObject(user)){
            redirectTo(route="home", error="Sorry, we couldn't find your account..");
        }
        </cfscript>
    </cffunction>

    <cffunction name="_createUserInScope" access="private" hint="Basically loads all user details and permissions into session scope for easy reference">
        <cfargument name="user" required="true">
        <cfscript>
            var scope=structNew();   
            scope.id=user.id;
            scope.firstname=user.firstname;
            scope.lastname=user.lastname;   
            scope.email=user.email;
            scope.role=user.role;   
            scope.apitoken=user.apitoken;
            session.currentuser=scope;  
            redirectTo(route="home");
        </cfscript>
    </cffunction>

    <cffunction name="isLoggedIn" hint="Returns true if session exists / useful for simple checks">
        <cfscript>
            return StructKeyExists(session, "currentUser");             
        </cfscript>
    </cffunction>
 

    <cffunction name="userIsInRole" hint="Returns true if user is a specified role">
        <cfargument name="role" required="true" type="string">
        <cfif isLoggedin()>
            <cfif structKeyExists(session.currentUser, "role")>
                <cfif session.currentUser.role EQ arguments.role>
                    <Cfreturn true>
                <Cfelse>
                    <cfreturn false>
                </cfif>
            <cfelse>
                <cfreturn false>
            </cfif>
        <Cfelse>
            <cfreturn false>
        </cfif>
    </cffunction>   

    <cffunction name="_checkLoggedIn" hint="Used in filters">
       <cfscript>
        if(!isLoggedIn()){
            redirectTo(route="login");
        }
        </cfscript>
    </cffunction>

    <cffunction name="_getRoles" hint="Returns a list of potential roles">
        <cfset roles="admin,editor,user,guest">        
    </cffunction>

    <cffunction name="redirectIfLoggedIn" hint="Shoves auth'd user elsewhere">
        <cfscript>
        if(isLoggedIn()){
            redirectTo(route="home");
        }
        </cfscript>
    </cffunction>



<!---================================ Logging ======================================--->

    <Cffunction name="addlogline" hint="Quick way to add a logline">
        <cfargument name="userid" default="0">
        <cfscript>
            if(isLoggedIn()){
                arguments.userid=session.currentuser.id;
            } 
            arguments.ipaddress=getIPAddress();
            l=model("logfile").create(arguments);
        </cfscript>
    </Cffunction>

    <cffunction name="logFlash" hint="Grabs the message in the flash scope and logs it">
        <cfscript> 
            if(structkeyexists(session,"flash")){
                if(structkeyexists(session.flash, "error")){
                    addLogLine(message=session.flash.error, type="error");
                }
                if(structkeyexists(session.flash, "success")){
                    addLogLine(message=session.flash.success, type="success");
                }
        } 
        </cfscript>  
    </cffunction>  

<!---================================ Cookies ======================================--->
<!--
     
    Cookie:RBS_UN : The Username (string)
        Request: request.cookie.username
---> 
    <cffunction name="setCookieRememberUsername" hint="Sets a cookie which remembers the login">
        <cfargument name="username">
        <cfcookie name = "RBS_UN" expires="360" value="#arguments.username#" httpOnly="true">
        <cfset addlogline(message="#arguments.username# used cookie remember email", type="Cookie")>      
    </cffunction>

    <Cffunction name="setCookieForgetUsername" hint="Remove the username cookie">
         <cfcookie  name = "RBS_UN" expires = "NOW"  httpOnly="true">
        <cfset addlogline(message="Cookie remember email removed", type="Cookie")>      
    </Cffunction>

<!---================================ Global Filters ======================================--->
 	<cffunction name="_getLocations" hint="Return all room locations">
		<cfset locations=model("location").findAll(order="name")>
	</cffunction>

	<cffunction name="_getSettings" hint="Return all settings">
		<cfset settings=model("setting").findAll(order="category,id")>
	</cffunction>
	
	
</cfcomponent> 