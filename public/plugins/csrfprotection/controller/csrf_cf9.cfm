<cffunction name="$isAnyAuthenticityTokenValid" returntype="boolean" hint="Returns whether or not `params.authenticityToken` is valid and stored based on user's session." output="false">
	<cfscript>
		var loc = {};

		if ($isRequestProtectedFromForgery() && StructKeyExists(params, "authenticityToken")) {
			if (!StructKeyExists(session, "$wheels")) {
				session.$wheels = {};
			}

			loc.isValid = StructKeyExists(session.$wheels, "authenticityToken")
				&& session.$wheels.authenticityToken == params.authenticityToken;
		}
		else {
			loc.isValid = false;
		}
	</cfscript>
	<cfreturn loc.isValid>
</cffunction>

<cffunction name="$generateAuthenticityToken" returntype="string" hint="Stores authenticity token for request in session." output="false">
	<cfparam name="session.$wheels.authenticityToken" type="string" default="#GenerateSecretKey("AES")#">
	<cfreturn session.$wheels.authenticityToken>
</cffunction>
