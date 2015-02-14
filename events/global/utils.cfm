<cfscript>
//================= Generic Functions =======================--->

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
    public string function returnStringFromBoolean(required string boo) {
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