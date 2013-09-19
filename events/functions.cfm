<!--- Place functions here that should be globally available in your application. --->

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
 