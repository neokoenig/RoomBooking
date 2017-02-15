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
<cfif structkeyexists(request, "js")>
<cfloop list="#structKeyList(request.js)#" index="key">
<cfoutput>
<!-- #key# -->
#request.js[key]#
</cfoutput>
</cfloop></cfif>

<!--- JS noty based flash messages --->
<cfif structKeyExists(session, "flash")>
<script>
var flashMessages=<cfoutput>#serializeJSON(session.flash)#</cfoutput>
if(!$.isEmptyObject(flashMessages)){
  for(m in flashMessages){
    noty({
      layout: 'topCenter',
      theme: 'metroui',
      text: flashMessages[m],
      type: m,
       animation: {
          open: {height: 'toggle'}, // or Animate.css class names like: 'animated bounceInLeft'
          close: {height: 'toggle'}, // or Animate.css class names like: 'animated bounceOutLeft'
          easing: 'swing',
          speed: 500 // opening & closing animation speed
        },
      timeout: 4000, // [integer|boolean] delay for closing event in milliseconds. Set false for sticky notifications
      progressBar: true, // [boolean] - displays a progress bar
    });
  }
}
</script>
</cfif>

<!--- User JS Overrides --->
#javascriptIncludeTag("custom")#

</body>
</html>
</cfoutput>
