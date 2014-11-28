<!---================================ Global Auth Functions ======================================--->
<cfscript>
    /**
    *  @hint Get logged in user
    */
    public void function getCurrentUser() {
        user=model("user").findOne(where="id=#session.currentUser.id# AND email = '#session.currentUser.email#'");
        if(!isObject(user)){
            redirectTo(route="home", error="Sorry, we couldn't find your account..");
        }
    }

    /**
    *  @hint Basically loads all user details and permissions into session scope for easy reference
    */
    private void function _createUserInScope(required user) {
        var scope=structNew();
        scope.id=user.id;
        scope.firstname=user.firstname;
        scope.lastname=user.lastname;
        scope.email=user.email;
        scope.role=user.role;
        scope.apitoken=user.apitoken;
        session.currentuser=scope;
        redirectTo(route="home");
    }

    /**
    *  @hint Returns true if session exists / useful for simple checks
    */
    public boolean function isLoggedIn() {
        return StructKeyExists(session, "currentUser");
    }

    /**
    *  @hint Returns true if user is a specified role
    */
    public boolean function userIsInRole(required string role) {
        var r=false;
        if(isLoggedin()){
            if(structKeyExists(session.currentuser, "role") AND (session.currentUser.role EQ arguments.role)){
                r=true;
            }
        }
        return r;
    }

    /**
    *  @hint Used in filters
    */
    public void function _checkLoggedIn() {
        if(!isLoggedIn()){
            redirectTo(route="login");
        }
    }

    /**
    *  @hint Returns a list of potential roles
    */
    public void function _getRoles() {
        roles="admin,editor,user,guest";
    }

    /**
    *  @hint Shoves auth'd user elsewhere
    */
    public void function redirectIfLoggedIn() {
         if(isLoggedIn()){
            redirectTo(route="home");
        }
    }

    /**
    *  @hint Returns the current signed in user
    */
    public struct function currentUser() {
        if ( isLoggedIn() ) {
            currentUser = model("user").findByKey(session.currentUser.id);
            return currentUser;
        }
    }

    /**
    *  @hint Signs out the user
    */
    public void function signOut() {
        if (isLoggedIn() ) {
           StructDelete(session, "currentUser");
        }
    }

    /*
    Notes on salting / hashing:
    Password is hashed using a salt
    Salt is encrypted with a unique key (AuthKey)

    So to compare a password hash, you need to decrypt the salt first

    The authKey is unique per installation; It's useful as you can invalidate all the site passwords in one go by just changing it
    */

    /**
    *  @hint Returns a semi-unique key per installation
    */
    public string function getAuthKey() {
        var authkeyLocation=expandPath("/config/auth.cfm");
        var authkeyDefault=createUUID();
        if(fileExists(authkeyLocation)){
            return fileRead(authkeyLocation);
        } else {
            fileWrite(authkeyLocation, authkeyDefault);
            return authkeyDefault;
        }
    }

    /**
    *  @hint Generate an API Key
    */
    public string function _generateApiKey(){
        return hash(createUUID() & getAuthKey(), 'SHA-512');
    }

    /**
    *  @hint Create Salt using authkey
    */
    public string function createSalt() {
        return encrypt(createUUID(), getAuthKey(), 'CFMX_COMPAT');
    }

    /**
    *  @hint Get salt using authkey
    */
    public string function decryptSalt(required string salt) {
        return decrypt(arguments.salt, getAuthKey(), 'CFMX_COMPAT');
    }

    /**
    *  @hint Hash Password using SHA512
    */
    public string function hashPassword(required string password, required string salt) {
        return hash(arguments.password & arguments.salt, 'SHA-512');
    }

    /**
    *  @hint Checks a permission against permissions loaded into application scope for the user
    */
    public boolean function checkPermission(required string permission) {
        var retValue=0;
        if(_permissionsSetup() AND structKeyExists(application.rbs.permission, arguments.permission)){
            retValue = application.rbs.permission[arguments.permission][_returnUserRole()];
            if(retValue == 1){
                return true;
            } else {
                return false;
            }
        }
    }

    /**
    *  @hint Checks a permission and redirects away to access denied, useful for use in filters etc
    */
    public void function checkPermissionAndRedirect(required string permission) {
       if(!checkPermission(arguments.permission)){
            redirectTo(route="denied", error="Sorry, you have insufficient permission to access this. If you believe this to be an error, please contact an administrator.");
        }
    }

    /**
    *  @hint Checks for the relevant permissions structs in application scope
    */
    public boolean function _permissionsSetup() {
        if(structKeyExists(application, "rbs") AND structKeyExists(application.rbs, "permission")){
                return true;
        }  else {
            return false;
        }
    }

    /**
    *  @hint Looks for user role in session, returns guest otherwise
    */
    public string function _returnUserRole() {
        if(_permissionsSetup() AND isLoggedIn() AND structKeyExists(session.currentuser, "role")){
            return session.currentuser.role;
        } else {
            return "guest";
        }
    }

    /**
    *  @hint Used to redirect away in demo mode
    */
    public void function denyInDemoMode() {
        if(application.rbs.setting.isdemomode){
            redirectTo(route="home", error="Disabled in Demo Mode");
        }
    }
</cfscript>