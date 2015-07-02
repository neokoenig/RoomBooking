<!---================= Room Booking System / https://github.com/neokoenig =======================--->

<cfscript>

//================================ Global Auth Functions ======================================
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
        var scope={
            id=user.id,
            firstname=user.firstname,
            lastname=user.lastname,
            email=user.email,
            role=user.role,
            apitoken=user.apitoken
        };
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
        roles=application.rbs.roles;
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
        var authkeyLocation=expandPath("config/auth.cfm");
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

//================================ Shortcodes ======================================
      /**
  * @hint Render a  field
  **/
    function field_callback(attr) {
        var result="";
        var path="#application.wheels.webPath#/#application.wheels.viewPath#/shortcodes/field.cfm";
        savecontent variable="result" {
           include path;
        }
        return result;
    }

  /**
  * @hint Render a  field
  **/
    function output_callback(attr) {
        var result="";
        var path="#application.wheels.webPath#/#application.wheels.viewPath#/shortcodes/output.cfm";
        savecontent variable="result" {
           include path;
        }
        return result;
    }

//================================ Utils ======================================
  /**
    *  @hint Get IP
    */
    public string function getIPAddress() {
        var result="127.0.0.1";
        var myHeaders = GetHttpRequestData();
        if(structKeyExists(myHeaders, "headers") AND structKeyExists(myHeaders.headers, "x-forwarded-for")){
        result=myHeaders.headers["x-forwarded-for"];
        }
        return result;
    }
    /**
    *  @hint I know this is stupid, but it's a hack with the way I'm doing the settings in the db
    */
    public string function returnStringFromBoolean(required boo) {
        if(arguments.boo){
            return "true";
        } else {
            return "false";
        }
    }

//================================ Logging ======================================
    /**
    *  @hint Quick way to add a logline
    */
    public void function addlogline() {
        if(isLoggedIn()){
            arguments.userid=session.currentuser.id;
        }
        arguments.ipaddress=getIPAddress();
        l=model("logfile").create(arguments);
    }
    /**
    *  @hint Log the flash via filter
    */
    public void function logFlash() {
        if(structkeyexists(session,"flash")){
            if(structkeyexists(session.flash, "error")){
                addLogLine(message=session.flash.error, type="error");
            }
            if(structkeyexists(session.flash, "success")){
                addLogLine(message=session.flash.success, type="success");
            }
        }
    }

    /**
 * Combines structFindKey() and structFindValue()
 * v1.0 by Adam Cameron
 * v1.01 by Adam Cameron (fixing logic error in scope-handling)
 *
 * @param struct     Struct to check (Required)
 * @param key    Key to find (Required)
 * @param value      Value to find for key (Required)
 * @param scope      Whether to find ONE (default) or ALL matches (Optional)
 * @return Returns an array as per structFindValue()
 * @author Adam Cameron (dac.cfml@gmail.com)
 * @version 1.01, September 9, 2013
 */
public array function structFindKeyWithValue(required struct struct, required string key, required string value, string scope="ONE"){
    if (!isValid("regex", arguments.scope, "(?i)one|all")){
        throw(type="InvalidArgumentException", message="Search scope #arguments.scope# must be ""one"" or ""all"".");
    }
    var keyResult = structFindKey(struct, key, "all");
    var valueResult = [];
    for (var i=1; i <= arrayLen(keyResult); i++){
        if (keyResult[i].value == value){
            arrayAppend(valueResult, keyResult[i]);
            if (scope == "one"){
                break;
            }
        }
    }
    return valueResult;
}

</cfscript>
<!---================================ Cookies ======================================--->
<!--

    Cookie:RBS_UN : The Username (string)
        Request: request.cookie.username

        Keep this in tag form as for some reason I can never really get this to work in script form.
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

<cfif listFirst(server.coldfusion.productVersion) LTE "10">
    <!---
 Backport of QueryExecute in CF11 to CF9 &amp; CF10

 @param sql_statement    SQL. (Required)
 @param queryParams      Struct of query param values. (Optional)
 @param queryOptions     Query options. (Optional)
 @return Returns a query.
 @author Henry Ho (henryho167@gmail.com)
 @version 1, September 22, 2014
--->
<cffunction name="QueryExecute" output="false"
            hint="
                * result struct is returned to the caller by utilizing URL scope (no prefix needed) *
                https://wikidocs.adobe.com/wiki/display/coldfusionen/QueryExecute">
    <cfargument name="sql_statement" required="true">
    <cfargument name="queryParams"  default="#structNew()#">
    <cfargument name="queryOptions" default="#structNew()#">

    <cfset var parameters = []>

    <cfif isArray(queryParams)>
        <cfloop array="#queryParams#" index="local.param">
            <cfif isSimpleValue(param)>
                <cfset arrayAppend(parameters, {value=param})>
            <cfelse>
                <cfset arrayAppend(parameters, param)>
            </cfif>
        </cfloop>
    <cfelseif isStruct(queryParams)>
        <cfloop collection="#queryParams#" item="local.key">
            <cfif isSimpleValue(queryParams[key])>
                <cfset arrayAppend(parameters, {name=local.key, value=queryParams[key]})>
            <cfelse>
                <cfset var parameter = {name=key}>
                <cfset structAppend(parameter, queryParams[key])>
                <cfset arrayAppend(parameters, parameter)>
            </cfif>
        </cfloop>
    <cfelse>
        <cfthrow message="unexpected type for queryParams">
    </cfif>

    <cfif structKeyExists(queryOptions, "result")>
        <!--- strip scope, not supported --->
        <cfset queryOptions.result = listLast(queryOptions.result, '.')>
    </cfif>

    <cfset var executeResult = new Query(sql=sql_statement, parameters=parameters, argumentCollection=queryOptions).execute()>

    <cfif structKeyExists(queryOptions, "result")>
        <!--- workaround for passing result struct value out to the caller by utilizing URL scope (no prefix needed) --->
        <cfset URL[queryOptions.result] = executeResult.getPrefix()>
    </cfif>

    <cfreturn executeResult.getResult()>
</cffunction>
</cfif>