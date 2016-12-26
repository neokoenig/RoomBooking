<cfcomponent mixin="controller" output="false">
	<cffunction name="init" output="false">
		<cfset this.version = "1.4.0,1.4.1,1.4.2,1.4.3,1.4.4,1.4.5">
		<cfreturn this>
	</cffunction>

	<cfinclude template="events/onapplicationstart.cfm">
	<cfinclude template="controller/miscellaneous.cfm">
	<cfinclude template="controller/csrf.cfm">
	<cfinclude template="view/forms.cfm">
	<cfinclude template="view/csrf.cfm">

	<cfswitch expression="#application.csrf.store#">
		<!--- Session store --->
		<cfcase value="session">
			<!---
				ACF 10+ and Lucee have built in CSRF functions, so we'll defer to those if available.

				NOTE: When integrating this into core, we only need to port the logic from the `csrf_cf10.cfm`
				file.
			--->
			<cfif $hasBuiltInCsrfFunctions()>
				<cfinclude template="controller/csrf_cf10.cfm">
			<cfelse>
				<cfinclude template="controller/csrf_cf9.cfm">
			</cfif>
		</cfcase>
		<!--- Cookie store --->
		<cfcase value="cookie">
			<cfinclude template="controller/csrf_cookie.cfm">
		</cfcase>
	</cfswitch>
</cfcomponent>
