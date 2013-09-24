<!--- Place code here that should be executed on the "onRequestStart" event. --->
 
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