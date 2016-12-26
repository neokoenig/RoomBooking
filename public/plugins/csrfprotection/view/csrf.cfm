<cffunction name="csrfMetaTags" returntype="string" hint="Returns meta tags to be picked up by JavaScript for non-`GET` requests." output="false">
	<cfset var loc = {}>

	<cfsavecontent variable="loc.metaTags">
		<cfoutput>
			<meta name="csrf-param" content="authenticityToken" />
			<meta name="csrf-token" content="#$generateAuthenticityToken()#" />
		</cfoutput>
	</cfsavecontent>

	<cfreturn Trim(loc.metaTags)>
</cffunction>

<cffunction name="authenticityTokenField" returntype="string" hint="Generates authenticity token and returns HTML markup for a hidden field containing its contents." output="false">
	<cfset var loc = {}>

	<!--- Store a new authenticity token. --->
	<cfset loc.authenticityToken = $generateAuthenticityToken()>

	<!--- Return hidden field containing new authenticity token. --->
	<cfreturn hiddenFieldTag(name="authenticityToken", value=loc.authenticityToken)>
</cffunction>
