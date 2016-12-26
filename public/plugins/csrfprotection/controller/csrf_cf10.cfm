<cffunction name="$isAnyAuthenticityTokenValid" returntype="boolean" hint="Returns whether or not `params.authenticityToken` is valid and stored based on user's session." output="false">
	<cfscript>
		var loc = {};

		if ($isRequestProtectedFromForgery() && StructKeyExists(params, "authenticityToken")) {
			loc.isValid = CsrfVerifyToken(params.authenticityToken);
		}
		else {
			loc.isValid = false;
		}
	</cfscript>
	<cfreturn loc.isValid>
</cffunction>

<cffunction name="$generateAuthenticityToken" returntype="string" hint="Stores authenticity token for request in session." output="false">
	<cfreturn CSRFGenerateToken()>
</cffunction>
