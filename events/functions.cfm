<cfscript>
//================= Room Booking System / https://github.com/neokoenig =======================--->
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


//================================ Date Utils ======================================
    /**
    *  @hint Given any start date, repeat x times with step, starting after start date
    */
    public array function dateCalcIterations(
        required date eventStart,
        required date eventEnd,
        required numeric step=1,
        required numeric iterations=10,
        required string daysOfWeek="",
        required string datePart="d"
    ) {
        var r=[];
        var x=0;
        var lDate= dateAdd("d", 0, eventStart); // doing this as sometimes this is coming through as a string
        var eventDuration=dateDiff("n", eventStart, eventEnd);

        while (x LT iterations) {
            x++;
            if(listlen(daysOfWeek)){
                if(listFind(daysOfWeek, dayOfWeek(lDate))){
                     arrayAppend(r, {
                        start: lDate,
                        end:  dateAdd("n", eventDuration, lDate)
                    });
                } else {
                    x--; // didn't find a valid date, reset counter back by 1
                }
            } else {
                 arrayAppend(r, {
                    start: lDate,
                    end:  dateAdd("n", eventDuration, lDate)
                });
            }
            lDate=dateAdd(datePart, step, lDate);
        }

        return r;
    }


    /**
    *  @hint Used for Monthly/Yearly by DOM etc.
    */
    public array function dateCalcIterationsWithSkip(
        required date eventStart,
        required date eventEnd,
        required numeric step=0,
        required string dow="",
        required numeric iterations=10,
        required string datePart="d",
        required string rule="dom",
        optional numeric weekskip=1
    ) {
        var r=[];
        var x=0;
        var lDate= dateAdd("d", 0, eventStart); // doing this as sometimes this is coming through as a string
        var eventDuration=dateDiff("n", eventStart, eventEnd);
        var dow    = dayOfWeek(lDate);
        var week   = week(lDate);
        var month  = month(lDate);
        var year   = year(lDate);

        while (x LT iterations) {
            x++;
             if(rule EQ "dow"){
                // Work out whether the date is the 1st/2nd/3rd/4th/5th occurance in the month. If 5th, make it the 'last' appearance. otherwise use 1-4.
                firstX =  firstXDayOfMonth(dow, month, year);
                firstx1 = dateAdd("d", (1 * 7), firstX );
                firstx2 = dateAdd("d", (2 * 7), firstX );
                firstx3 = dateAdd("d", (3 * 7), firstX );
                firstx4 = dateAdd("d", (4 * 7), firstX );
                if(dateFormat(lDate, "dd") EQ dateFormat(firstX, "dd")){
                    isXinMonth=1;
                }
                if(dateFormat(lDate, "dd") EQ dateFormat(firstX1, "dd")){
                    isXinMonth=2;
                }
                if(dateFormat(lDate, "dd") EQ dateFormat(firstX2, "dd")){
                    isXinMonth=3;
                }
                if(dateFormat(lDate, "dd") EQ dateFormat(firstX3, "dd")){
                    isXinMonth=4;
                }
                if(dateFormat(lDate, "dd") EQ dateFormat(firstX4, "dd")){
                    isXinMonth=5;
                }
               // Exception Clause: IF user has selected the '5th' thursday, always give them the LAST thursday (which may be the 4th OR the 5th)
                if(isXinMonth NEQ 5){
                    nDate=GetNthDayOfMonth(lDate, dow, isXinMonth);
                } else {
                    nDate=GetLastDayOfWeekOfMonth(lDate, dow);
                }

                nDate=dateFormat(nDate, "yyyy-mm-dd") & " " & timeFormat(eventStart, "HH:MM");

                arrayAppend(r, {
                    start: dateAdd("d", 0, nDate),
                    end:   dateAdd("n", eventDuration, nDate)
                });
                lDate=dateAdd(datePart, step, lDate);
             } else if(rule EQ "dom") {
                // Standard simple loop
                arrayAppend(r, {
                    start: lDate,
                    end:  dateAdd("n", eventDuration, lDate)
                });
                lDate=dateAdd(datePart, step, lDate);
             } else if(rule EQ "weekonskip"){
                // Custom logic for looping over certain days in a week and skipping weeks
                if(dayOfWeek(lDate) EQ 7){
                    lDate=dateAdd("ww", weekstep, lDate);
                }
                 if(listlen(dow)){
                    if(listFind(daysOfWeek, dayOfWeek(lDate))){
                         arrayAppend(r, {
                            start: lDate,
                            end:  dateAdd("n", eventDuration, lDate)
                        });
                    } else {
                        x--; // didn't find a valid date, reset counter back by 1
                    }
                 }
                lDate=dateAdd(datePart, step, lDate);
             }
        } // End while

        return r;
    }

    /**
    *  @hint Days of Week filter
    */
    public boolean function dowFilter(required string dow, required date lDate ) {
        if(listlen(dow)){
           if(listFind(dow, dayOfWeek(lDate))){
                return true;
           }
        }
        return false;
    }

    /**
    *  @hint Given any start and end date, return an array of calculated dates starting after start date
    *
    *   eventStart  = The Master Event Start Date/Time
    *   eventEnd    = The Master Event End Date/Time
    *   rangeStart = The repeating range start date
    *   rangeEnd   = The repeating range end date
    *   dow  = limit results to these days of the week
    *   step        = incremenet each loop by
    *   datePart    = step increment date part
    */
    public array function dateCalcRange(
        required date eventStart,
        required date eventEnd,
        required numeric step=1,
        required string dow,
        required string datePart="d",
        required date rangeStart,
        required date rangeEnd
    ) {
        var r=[];                   // Result Array
        var lDate=dateAdd("d", 0, eventStart);   // Main Loop Date
        var eventDuration=dateDiff("n", eventStart, eventEnd); // store duration to add to end date

        // lDate=dateAdd("d", 0, rangeStart);
        // Loop can't also start before rangeStart or go after rangeEnd, as that's not what we've asked for
        while(dateCompare(lDate, dateAdd("d", 1, rangeEnd)) LTE 0){

            // If lDate if after rangeStart
            if(dateCompare(lDate, rangeStart) GTE 0){

                if(listlen(dow)){
                    if(dowFilter(dow, lDate)){
                         arrayAppend(r, {
                            start: lDate,
                            end:  dateAdd("n", eventDuration, lDate)
                        });
                    }
                }
                 else {
                    arrayAppend(r, {
                        start: lDate,
                        end:  dateAdd("n", eventDuration, lDate)
                    });
                }
            }
            // Increment Loop by one day
            lDate=dateAdd(datePart, step, lDate);
        }
        return r;
    }

     /**
    *  @hint Used for Monthly/Yearly by DOM etc.
    */
    public array function dateCalcRangeWithSkip(
        required date eventStart,
        required date eventEnd,
        required date rangeStart,
        required date rangeEnd,
        required numeric step=0,
        required string dow,
        required string datePart="d",
        required string rule="dom"
    ){
        var r=[];
        var x=0;
        var lDate= dateAdd("d", 0, eventStart); // doing this as sometimes this is coming through as a string
        var eventDuration=dateDiff("n", eventStart, eventEnd);
        var dow    = dayOfWeek(lDate);
        var month  = month(lDate);
        var year   = year(lDate);

        while(dateCompare(lDate, dateAdd("d", 1, rangeEnd)) LTE 0){
            if(dateCompare(lDate, rangeStart) GTE 0){
                if(rule EQ "dow"){
                // Work out whether the date is the 1st/2nd/3rd/4th/5th occurance in the month. If 5th, make it the 'last' appearance. otherwise use 1-4.
                firstX =  firstXDayOfMonth(dow, month, year);
                firstx1 = dateAdd("d", (1 * 7), firstX );
                firstx2 = dateAdd("d", (2 * 7), firstX );
                firstx3 = dateAdd("d", (3 * 7), firstX );
                firstx4 = dateAdd("d", (4 * 7), firstX );
                if(dateFormat(lDate, "dd") EQ dateFormat(firstX, "dd")){
                    isXinMonth=1;
                }
                if(dateFormat(lDate, "dd") EQ dateFormat(firstX1, "dd")){
                    isXinMonth=2;
                }
                if(dateFormat(lDate, "dd") EQ dateFormat(firstX2, "dd")){
                    isXinMonth=3;
                }
                if(dateFormat(lDate, "dd") EQ dateFormat(firstX3, "dd")){
                    isXinMonth=4;
                }
                if(dateFormat(lDate, "dd") EQ dateFormat(firstX4, "dd")){
                    isXinMonth=5;
                }
               // Exception Clause: IF user has selected the '5th' thursday, always give them the LAST thursday (which may be the 4th OR the 5th)
                if(isXinMonth NEQ 5){
                    nDate=GetNthDayOfMonth(lDate, dow, isXinMonth);
                } else {
                    nDate=GetLastDayOfWeekOfMonth(lDate, dow);
                }

                nDate=dateFormat(nDate, "yyyy-mm-dd") & " " & timeFormat(eventStart, "HH:MM");

                arrayAppend(r, {
                    start: dateAdd("d", 0, nDate),
                    end:   dateAdd("n", eventDuration, nDate)
                });

             } else if(rule EQ "dom") {
                // Standard simple loop
                arrayAppend(r, {
                    start: lDate,
                    end:  dateAdd("n", eventDuration, lDate)
                });
             } else if(rule EQ "weekonskip"){
                // Custom logic for looping over certain days in a week and skipping weeks
                if(dowFilter(dow, lDate)){
                     arrayAppend(r, {
                        start: lDate,
                        end:  dateAdd("n", eventDuration, lDate)
                    });
                }
             }

            lDate=dateAdd(datePart, step, lDate);
            }
        }

        return r;
    }


    /**
     * Returns a date object of the first occurrence of a specified day in the given month and year.
     * v1.0 by Troy Pullis
     * v1.1 by Adam Cameron (improved/simplified logic, added error handling)
     *
     * @param dayOfWeek      An integer in the range 1 - 7. 1=Sun, 2=Mon, 3=Tue, 4=Wed, 5=Thu, 6=Fri, 7=Sat. (Required)
     * @param month      Month value.  (Required)
     * @param year   Year value. (Required)
     * @return The date of the first [dayOfWeek] of the specified month/year
     * @author Troy Pullis (tpullis@yahoo.com)
     * @version 1.1, July 6, 2014
     */
    date function firstXDayOfMonth(required numeric dayOfWeek, required numeric month, required numeric year){
        if (dayOfWeek < 1 || dayOfWeek > 7){
            throw(type="InvalidDayOfWeekException", message="Invalid day of week value", detail="the dayOfWeek argument must be between 1-7 (inclusive).");
        }
        var firstOfMonth    = createDate(year, month,1);
        var dowOfFirst      = dayOfWeek(firstOfMonth);
        var daysToAdd       = (7 - (dowOfFirst - dayOfWeek)) MOD 7;
        var dow = dateAdd("d", daysToAdd, firstOfMonth);
        return dow;
    }



//================================ Lang ======================================
    /**
    *  @hint
    */
    public string function getCurrentLanguage() {
        if(structKeyExists(session, "lang") AND len(session.lang)){
            return session.lang;
        } else {
            return "en_GB";
        }
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

<cffunction
    name="GetLastDayOfWeekOfMonth"
    access="public"
    returntype="date"
    output="false"
    hint="Returns the date of the last given weekday of the given month.">

    <!--- Define arguments. --->
    <cfargument
        name="Date"
        type="date"
        required="true"
        hint="Any date in the given month we are going to be looking at."
        />

    <cfargument
        name="DayOfWeek"
        type="numeric"
        required="true"
        hint="The day of the week of which we want to find the last monthly occurence."
        />

    <!--- Define the local scope. --->
    <cfset var LOCAL = StructNew() />

    <!--- Get the current month based on the given date. --->
    <cfset LOCAL.ThisMonth = CreateDate(
        Year( ARGUMENTS.Date ),
        Month( ARGUMENTS.Date ),
        1
        ) />

    <!---
        Now, get the last day of the current month. We
        can get this by subtracting 1 from the first day
        of the next month.
    --->
    <cfset LOCAL.LastDay = (
        DateAdd( "m", 1, LOCAL.ThisMonth ) -
        1
        ) />

    <!---
        Now, the last day of the month is part of the last
        week of the month. However, there is no guarantee
        that the target day of this week will be in the current
        month. Regardless, let's get the date of the target day
        so that at least we have something to work with.
    --->
    <cfset LOCAL.Day = (
        LOCAL.LastDay -
        DayOfWeek( LOCAL.LastDay ) +
        ARGUMENTS.DayOfWeek
        ) />


    <!---
        Now, we have the target date, but we are not exactly
        sure if the target date is in the current month. if
        is not, then we know it is the first of that type of
        the next month, in which case, subracting 7 days (one
        week) from it will give us the last occurence of it in
        the current Month.
    --->
    <cfif (Month( LOCAL.Day ) NEQ Month( LOCAL.ThisMonth ))>

        <!--- Subract a week. --->
        <cfset LOCAL.Day = (LOCAL.Day - 7) />

    </cfif>


    <!--- Return the given day. --->
    <cfreturn DateFormat( LOCAL.Day ) />
</cffunction>

<cffunction
    name="GetNthDayOfMonth"
    access="public"
    returntype="any"
    output="false"
    hint="I return the Nth instance of the given day of the week for the given month (ex. 2nd Sunday of the month).">

    <!--- Define arguments. --->
    <cfargument
        name="Month"
        type="date"
        required="true"
        hint="I am the month for which we are gathering date information."
        />

    <cfargument
        name="DayOfWeek"
        type="numeric"
        required="true"
        hint="I am the day of the week (1-7) that we are locating."
        />

    <cfargument
        name="Nth"
        type="numeric"
        required="false"
        default="1"
        hint="I am the Nth instance of the given day of the week for the given month."
        />

    <!--- Define the local scope. --->
    <cfset var LOCAL = {} />

    <!---
        First, we need to make sure that the date we were given
        was actually the first of the month.
    --->
    <cfset ARGUMENTS.Month = CreateDate(
        Year( ARGUMENTS.Month ),
        Month( ARGUMENTS.Month ),
        1
        ) />


    <!---
        Now that we have the correct start date of the month, we
        need to find the first instance of the given day of the
        week.
    --->
    <cfif (DayOfWeek( ARGUMENTS.Month ) LTE ARGUMENTS.DayOfWeek)>

        <!---
            The first of the month falls on or before the first
            instance of our target day of the week. This means we
            won't have to leave the current week to hit the first
            instance.
        --->
        <cfset LOCAL.Date = (
            ARGUMENTS.Month +
            (ARGUMENTS.DayOfWeek - DayOfWeek( ARGUMENTS.Month ))
            ) />

    <cfelse>

        <!---
            The first of the month falls after the first instance
            of our target day of the week. This means we will
            have to move to the next week to hit the first target
            instance.
        --->
        <cfset LOCAL.Date = (
            ARGUMENTS.Month +
            (7 - DayOfWeek( ARGUMENTS.Month )) +
            ARGUMENTS.DayOfWeek
            ) />

    </cfif>


    <!---
        At this point, our Date is the first occurrence of our
        target day of the week. Now, we have to navigate to the
        target occurence.
    --->
    <cfset LOCAL.Date += (7 * (ARGUMENTS.Nth - 1)) />

    <!---
        Return the given date. There is a chance that this date
        will be in the NEXT month of someone put in an Nth value
        that was too large for the current month to handle.
    --->
    <cfreturn DateFormat( LOCAL.Date ) />
</cffunction>

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