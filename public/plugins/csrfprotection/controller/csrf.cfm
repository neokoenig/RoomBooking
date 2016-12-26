<cffunction name="protectFromForgery" hint="Controller initializer for setting up CSRF protection in the controller. Call this method within a controller's `init` method, preferrably the base `Controller.cfc` file to protect the entire application." output="false">
	<cfargument name="with" type="string" required="false" default="exception" hint="How to handle invalid authenticity token checks. Valid values are `error` (throws a `Wheels.InvalidAuthenticityToken` error) and `abort` (aborts the request silently and sends a blank response to the client).">
	<cfargument name="only" type="string" required="false" default="" hint="List of actions that this check should only run on. Leave blank for all.">
	<cfargument name="except" type="string" required="false" default="" hint="List of actions that this check should be omitted from running on. Leave blank for no exceptions.">
	<cfscript>
		// Store `with` setting for this controller in `application` scope for later use.
		variables.$class.csrf.type = arguments.with;

		// Initialize filters.
		filters(
			argumentCollection=arguments,
			through="$storeAuthenticityToken,$flagRequestAsProtected,$setAuthenticityToken,$verifyAuthenticityToken",
			type="before"
		);
	</cfscript>
</cffunction>

<cffunction name="$flagRequestAsProtected" hint="Flags this request as protected from CSRF. If the filter that triggers this method is not run, then other functionality can omit the protection." output="false">
	<cfset request.$wheels.protectedFromForgery = true>
</cffunction>

<cffunction name="$verifyAuthenticityToken" hint="Verifies CSRF token and throws an exception if verification fails." output="false">
	<cfset var loc = {}>

	<cfif not $isVerifiedRequest()>
		<cfswitch expression="#variables.$class.csrf.type#">
			<cfcase value="abort">
				<cfabort>
			</cfcase>
			<cfdefaultcase>
				<cfthrow
					message="This POSTed request was attempted without a valid authenticity token."
					type="Wheels.InvalidAuthenticityToken"
				>
			</cfdefaultcase>
		</cfswitch>
	</cfif>
</cffunction>

<cffunction name="$isVerifiedRequest" returntype="boolean" hint="Returns whether or not this request passes CSRF protection." output="false">
	<cfreturn
		isGet()
		or isHead()
		or isOptions()
		or $isAnyAuthenticityTokenValid()
	>
</cffunction>

<cffunction name="$isRequestProtectedFromForgery" returntype="boolean" hint="Returns whether or not the request has been protected from forgery." output="false">
	<cfreturn
		StructKeyExists(request.$wheels, "protectedFromForgery")
		and IsBoolean(request.$wheels.protectedFromForgery)
		and request.$wheels.protectedFromForgery
	>
</cffunction>

<cffunction name="$setAuthenticityToken" hint="Ensures authenticity token is set at `params.authenticityToken` if it's `POST`ed or included in the `X-CSRF-Token` header." output="false">
	<cfscript>
		var loc = {};

		if (!$isVerifiedRequest() && isAjax()) {
			loc.headers = GetHttpRequestData().headers;

			if (StructKeyExists(loc.headers, "X-CSRF-Token")) {
				params.authenticityToken = loc.headers["X-CSRF-Token"];
			}
		}
	</cfscript>
</cffunction>

<cffunction name="$storeAuthenticityToken" hint="Generates and stores an authenticity token in the session." output="false">
	<cfset $generateAuthenticityToken()>
</cffunction>

<cffunction name="$hasBuiltInCsrfFunctions" returntype="boolean" hint="Returns whether or not this ColdFusion install has the built-in `CsrfGenerateToken` and `CsrfVerifyToken` functions." output="false">
	<cfscript>
		var loc = {};

		// Inspect CFML engine and version.
		if (StructKeyExists(server, "lucee")) {
			loc.serverName = "Lucee";
			loc.serverVersion = server.lucee.version;
		}
		else if (StructKeyExists(server, "railo")) {
			loc.serverName = "Railo";
			loc.serverVersion = server.railo.version;
		}
		else {
			loc.serverName = "Adobe ColdFusion";
			loc.serverVersion = server.coldfusion.productVersion;
		}
	</cfscript>

	<cfreturn
		loc.serverName is "Lucee"
		or (
			loc.serverName is "Adobe ColdFusion"
			and Int(ListFirst(loc.serverVersion, ".,")) gte 10
		)
	>
</cffunction>
