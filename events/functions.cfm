<!---================= Room Booking System / https://github.com/neokoenig =======================--->

<cffunction name="getIPAddress" hint="Gets IP address even from Railo" returntype="String">
	<cfscript>
	var result="127.0.0.1";
	var myHeaders = GetHttpRequestData();
    if(structKeyExists(myHeaders, "headers") AND structKeyExists(myHeaders.headers, "x-forwarded-for")){
      result=myHeaders.headers["x-forwarded-for"]; 
    }
    return result;
	</cfscript>
</cffunction>
 
 <cffunction name="returnStringFromBoolean" output="false" hint="I know this is stupid, but it's a hack with the way I'm doing the settings in the db">
 	<cfargument  name="boo">
 	<cfif arguments.boo>
 		<cfreturn "true">
 	<cfelse>
 		<cfreturn "false">
 	</cfif>
 </cffunction>