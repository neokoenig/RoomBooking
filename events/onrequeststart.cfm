<!--- Place code here that should be executed on the "onRequestStart" event. --->

 <!--- Set defaults for non cookie enabled browsers--->
<cfset request.cookie=structnew()>
<cfset request.cookie.username="">

<!--- If cookie exists, get its values and update the request struct--->
<cfif !structkeyexists(cookie, 'RBS_UN')>
	<!--- Set initial cookie--->
	<cfcookie name = "RBS_UN" expires="360" value="" httponly="true">
<cfelse>
	<cfset request.cookie.username=cookie.RBS_UN>
</cfif>

<!--- trim form and url scopes --->
<cfif StructCount(form)>
	<cfloop collection="#form#" item="key">
		<cfset form[key] = Trim(form[key])>
	</cfloop>
</cfif>
<cfif StructCount(url)>
	<cfloop collection="#url#" item="key">
		<cfset url[key] = Trim(url[key])>
	</cfloop>
</cfif>

<!--- Other default request level vars--->
<cfset request.showNavBar="true">