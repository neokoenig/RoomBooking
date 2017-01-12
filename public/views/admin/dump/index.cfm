
<cfdump var="#request.lang#">
<cfif structKeyExists(session, "user")>
<cfdump var="#session.user#" label="User">
</cfif>
<cfdump var="#application.rbs#" label="RBS">
<cfdump var="#server#" label="Server">
<cfscript>
//writeDump(getTZList());
</cfscript>
