<cffunction name="isHead" returntype="boolean" hint="Returns whether or not this is an HTTP `HEAD` request." output="false">
	<cfreturn request.cgi.request_method eq "head">
</cffunction>

<cffunction name="isOptions" returntype="boolean" hint="Returns whether or not this is an HTTP `OPTIONS` request." output="false">
	<cfreturn request.cgi.request_method eq "options">
</cffunction>
