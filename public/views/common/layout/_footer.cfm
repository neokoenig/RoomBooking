<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfoutput>
</div><!-- ./wrapper -->

<!--- If not in production mode, load non min sources --->
<cfif get("environment") EQ "production">
	#javascriptIncludeTag("cms.min")#
<cfelse>
	#javascriptIncludeTag("cms")#
</cfif>

<!--- Locale Specific Overrides --->
<cfif request.lang.currentCode NEQ "en">
	#javascriptIncludeTag(
		"locales/datepicker/bootstrap-datepicker.#request.lang.currentCode#,locales/fullcalendar/#request.lang.currentCode#")#
</cfif>

<!--- Dynamic Javascript Set in Page --->
<cfif structkeyexists(request, "js")><cfloop list="#structKeyList(request.js)#" index="key"><cfoutput>#request.js[key]#</cfoutput></cfloop></cfif>

<!--- User JS Overrides --->
#javascriptIncludeTag("custom")#

</body>
</html>
</cfoutput>
