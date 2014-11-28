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
</cfscript>