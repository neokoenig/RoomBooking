<cffunction name="$isAnyAuthenticityTokenValid" returntype="boolean" hint="Returns whether or not `params.authenticityToken` is valid and stored based on user's cookie." output="false">
	<cfscript>
		var loc = {};

		if ($isRequestProtectedFromForgery() && StructKeyExists(params, "authenticityToken")) {
			loc.authenticityToken = $generateAuthenticityToken();
			return Len(loc.authenticityToken) && loc.authenticityToken == params.authenticityToken;
		}
		else {
			return false;
		}
	</cfscript>
</cffunction>

<cffunction name="$generateAuthenticityToken" returntype="string" hint="Stores authenticity token for request in cookie." output="false">
	<cfset var loc = {}>
	<cfset loc.authenticityToken = $readAuthenticityTokenFromCookie()>

	<!--- If cookie doesn't yet exist, create it --->
	<cfif not Len(loc.authenticityToken)>
		<cfscript>
			loc.authenticityToken = GenerateSecretKey(application.csrf.encryptionAlgorithm);

			loc.value = SerializeJson({
				sessionId=CreateUuid(),
				authenticityToken=loc.authenticityToken
			});

			loc.value = Encrypt(
				loc.value,
				application.csrf.encryptionSecretKey,
				application.csrf.encryptionAlgorithm,
				application.csrf.encryptionEncoding
			);
		</cfscript>

		<cfcookie
			name="#application.csrf.cookieName#"
			attributeCollection="#$csrfCookieAttributeCollection()#"
			value="#loc.value#"
		>
	</cfif>

	<cfreturn loc.authenticityToken>
</cffunction>

<cffunction name="$readAuthenticityTokenFromCookie" returntype="string" hint="Returns authenticity token from cookie store if one exists. Otherwise, returns empty string." output="false">
	<cfscript>
		var loc = {};
		loc.cookieName = application.csrf.cookieName;

		// Cookie is there. Read it in
		if (StructKeyExists(cookie, loc.cookieName)) {
			try {
				loc.cookieAttrs = Decrypt(
					cookie[loc.cookieName],
					application.csrf.encryptionSecretKey,
					application.csrf.encryptionAlgorithm,
					"Base64"
				);
			}
			// If cookie is corrupted, return empty string.
			catch (any e) {
				return "";
			}

			loc.cookieAttrs = DeserializeJson(loc.cookieAttrs);
			return loc.cookieAttrs.authenticityToken;
		}
		// No cookie, return empty string.
		else {
			return "";
		}
	</cfscript>
</cffunction>

<cffunction name="$csrfCookieAttributeCollection" returntype="struct" hint="Builds struct based on CSRF settings and returns it." output="false">
	<cfscript>
		var loc = {};

		loc.cookieStruct = {
			encodeValue=application.csrf.cookieEncodeValue,
			httpOnly=application.csrf.cookieHttpOnly,
			preserveCase=application.csrf.cookiePreserveCase,
			secure=application.csrf.cookieSecure
		};

		if (Len(application.csrf.cookieDomain)) {
			loc.cookieStruct.domain = application.csrf.cookieDomain;
		}

		if (Len(application.csrf.cookiePath)) {
			loc.cookieStruct.path = application.csrf.cookiePath;
		}
	</cfscript>
	<cfreturn loc.cookieStruct>
</cffunction>
