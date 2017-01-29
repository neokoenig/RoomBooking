<cfscript>
//=====================================================================
//=     Global Functions
//=====================================================================
if(structKeyExists(server, "lucee")){
    include "functions/install.cfm";
    include "functions/auth.cfm";
    include "functions/utils.cfm";
    include "functions/triggers.cfm";
    include "functions/actions.cfm";
} else {
	// FIX?
    include "/events/functions/install.cfm";
    include "/events/functions/auth.cfm";
    include "/events/functions/utils.cfm";
    include "/events/functions/triggers.cfm";
    include "/events/functions/actions.cfm";
}
</cfscript>
