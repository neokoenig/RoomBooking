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
    include "#application.wheels.webpath#events/functions/install.cfm";
    include "#application.wheels.webpath#events/functions/auth.cfm";
    include "#application.wheels.webpath#events/functions/utils.cfm";
    include "#application.wheels.webpath#events/functions/triggers.cfm";
    include "#application.wheels.webpath#events/functions/actions.cfm";
}
</cfscript>
