<cfscript>

//=====================================================================
//=     Global Utils
//=====================================================================
    // Trim whitespace from incoming URL/Form scopes
	public function trimScope(struct scope){
		if(structCount(scope)){
			for(key in scope){
				if(isSimpleValue(scope[key])){
					scope[key] = Trim(scope[key]);
				} else {
                    trimScope(scope[key]);
                }
			}
		}
		return scope;
	}

	// Get Current Session Language
    public string function getCurrentLanguage() {
        if(structKeyExists(session, "lang") && len(session.lang)){
            return session.lang;
        } else {
            return "en_GB";
        }
    }

    // Get Current IP address (don't trust CGI scope for this)
    public string function getIPAddress() {
       local.rv="0.0.0.0";
       local.myHeaders = GetHttpRequestData();
       // Try for x-forwarded-for
        if(structKeyExists(local.myHeaders, "headers") && structKeyExists(local.myHeaders.headers, "x-forwarded-for")){
            local.rv=local.myHeaders.headers["x-forwarded-for"];
       // Fall back to host
        } else if(structKeyExists(local.myHeaders, "headers") && structKeyExists(local.myHeaders.headers, "host")){
            local.rv=listFirst(local.myHeaders.headers["host"], ":");
        }
        return local.rv;
    }

    // Return a list of available locales from Java
    public function getLocaleListDropDown(){
        local.rv=server.coldfusion.supportedlocales;
        local.rv=listSort(local.rv, "textnocase");
        return local.rv;
    }

    // List of available theme layouts
    public function getThemeLayoutDropDown(){
         return "fixed,layout-boxed,layout-top-nav,sidebar-collapse,sidebar-mini";
    }

    // List of available theme skins
    public function getThemeSkinDropDown(){
         return "skin-blue,skin-black,skin-purple,skin-yellow,skin-red,skin-green,skin-blue-light,skin-black-light,skin-purple-light,skin-yellow-light,skin-red-light,skin-green-light";
    }

    // List of available roles
    public function getRoleDropdownList(){
        return model("role").findAll();
    }

   struct function convertStringToStruct(required string key, required any value, string delimiter = ".") {
        var obj = StructNew();
        var first = ListFirst(arguments.key, arguments.delimiter);
        var rest = ListRest(arguments.key, arguments.delimiter);

        if (Len(rest)) {
            obj[first] = convertStringToStruct(rest, arguments.value, arguments.delimiter);
        } else {
            obj[first] = arguments.value;
        }

        return obj;
    }



    /**
 * Sorts an array of structures based on a key in the structures.
 *
 * @param aofS   Array of structures. (Required)
 * @param key    Key to sort by. (Required)
 * @param sortOrder      Order to sort by, asc or desc. (Optional)
 * @param sortType   Text, textnocase, or numeric. (Optional)
 * @param delim      Delimiter used for temporary data storage. Must not exist in data. Defaults to a period. (Optional)
 * @return Returns a sorted array.
 * @author Nathan Dintenfass (nathan@changemedia.com)
 * @version 1, April 4, 2013
 */
function arrayOfStructsSort(aOfS,key){
        //by default we'll use an ascending sort
        var sortOrder = "asc";
        //by default, we'll use a textnocase sort
        var sortType = "textnocase";
        //by default, use ascii character 30 as the delim
        var delim = ".";
        //make an array to hold the sort stuff
        var sortArray = arraynew(1);
        //make an array to return
        var returnArray = arraynew(1);
        //grab the number of elements in the array (used in the loops)
        var count = arrayLen(aOfS);
        //make a variable to use in the loop
        var ii = 1;
        //if there is a 3rd argument, set the sortOrder
        if(arraylen(arguments) GT 2)
            sortOrder = arguments[3];
        //if there is a 4th argument, set the sortType
        if(arraylen(arguments) GT 3)
            sortType = arguments[4];
        //if there is a 5th argument, set the delim
        if(arraylen(arguments) GT 4)
            delim = arguments[5];
        //loop over the array of structs, building the sortArray
        for(ii = 1; ii lte count; ii = ii + 1)
            sortArray[ii] = aOfS[ii][key] & delim & ii;
        //now sort the array
        arraySort(sortArray,sortType,sortOrder);
        //now build the return array
        for(ii = 1; ii lte count; ii = ii + 1)
            returnArray[ii] = aOfS[listLast(sortArray[ii],delim)];
        //return the array
        return returnArray;
}

        //writeDump(label="Conversion Examples",var={
    //  "0-local-tz": getSystemTZ()
    //  ,"1-local-now": now()
    //  ,"2-utc-now": toUTC(now())
    //  ,"3-eastern-now": TZtoTZ( getSystemTZ(), now(), "America/New_York" )
    //  ,"4-pacific-now": TZfromTZ( "America/Los_Angeles", now() )
    //  ,"5-phoenix-now": TZfromTZ( "America/Phoenix", now() )
    //});
    //writeDump(label="Avaialable Time Zones",var=getTZList());
    //=======================================================
    function getSystemTZ(){
        return createObject("java", "java.util.TimeZone").getDefault().getId();
    }
    function toUTC( required time, tz = "America/New_York" ){
        var timezone = createObject("java", "java.util.TimeZone").getTimezone( tz );
        var ms = timezone.getOffset( getTickCount() ); //get this timezone's current offset from UTC
        var seconds = ms / 1000;
        return dateAdd( 's', -1 * seconds, time );
    }
    function UTCtoTZ( required time, required string tz ){
        var timezone = createObject("java", "java.util.TimeZone").getTimezone( tz );
        var ms = timezone.getOffset( getTickCount() ); //get this timezone's current offset from UTC
        var seconds = ms / 1000;
        return dateAdd( 's', seconds, time );
    }
    function TZtoTZ( localtz, time, targettz ){
        return UTCtoTZ( toUTC(time, localtz), targettz );
    }
    function TZfromTZ( targettz, time, sourcetz = getSystemTZ() ){
        return TZtoTZ( sourcetz, time, targettz );
    }
    function getTZList(){
        var list = createObject("java", "java.util.TimeZone").getAvailableIDs();
        var data = {};
        for (tz in list){
            var ms = createObject("java", "java.util.TimeZone").getTimezone( tz ).getOffset( getTickCount() );
            data[ tz ] = readableOffset( ms );
        }
        return data;
    }

    function getTZListDropDown(){
        var list = createObject("java", "java.util.TimeZone").getAvailableIDs();
        var data = {};
        for (tz in list){
            var ms = createObject("java", "java.util.TimeZone").getTimezone( tz ).getOffset( getTickCount() );
            data[ tz ] = tz & " [" & readableOffset( ms ) & "]";
        }
        return data;
    }
    function readableOffset( offset ){
        var h = offset / 1000 / 60 / 60; //raw hours (decimal) offset
        var hh = fix( h ); //int hours
        var mm = ( hh == h ? ":00" : ":" & abs(round((h-hh)*60)) ); //hours modulo used to determine minutes
        var rep = ( h >= 0 ? "+" : "" ) & hh & mm;
        return rep;
    }

    struct function parseRRuleString(string rrule){
        local.rr=replace(rrule, "RRULE:", "", "ALL");
        local.rr=listToArray(local.rr, ";");
        local.rv={};
        for(i in local.rr){
            local.rv[listFirst(i, "=")]=listLast(i, "=");
        }
        return local.rv;
    }

    public string function ISODateFormat(required date datetime){
        return(
            dateFormat( datetime, "yyyy-mm-dd" ) &
            "T" &
            timeFormat( datetime, "HH:mm:ss" ) &
            "Z"
        );
    }

</cfscript>
