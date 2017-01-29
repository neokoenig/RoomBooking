<cfscript>
//=====================================================================
//=     Global Auth Functions
//=====================================================================
    function isAuthenticated(){
        return structKeyExists(session, "auth");
    }

    function forcelogout(){
        if(structKeyExists(session, "auth")){
            // Call Auth's built in logout() method
            session.auth.logout();
            // Destroy all auth stuff
            structDelete(session, "auth");
        }
        if(structKeyExists(session, "user")){
            // Destroy user data
            structDelete(session, "user");
        }
    }

//=====================================================================
//=     Permission System
//=====================================================================
    /*
        Manually call permission(controller='calendar', action='show')
        checks application.rbs.permissions if not logged in, otherwise session.user.permissions
        should then return a boolean, false by default;
        Automatically should default to current controller + action
        Permission is stored in db as a string, so calendar.show
        So a permission of admin.bookings.new would require admin && admin.bookings && admin.bookings.new
    */
    public function hasPermission(string permission=getDefaultPermissionString()){
        local.rv=false;
        local.arr=[];
        local.passes=[];
        local.fails=[];
        local.permissions=getPermissionArr(arguments.permission);
        for(p in getPermissionArr(arguments.permission)){
            // If auth'd check session
            if(isAuthenticated() && structKeyExists(session.user.permissions, p) && session.user.permissions[p]){
                arrayAppend(local.passes, { "#p#": true });
            } else if( structKeyExists(application.rbs.permissions, p) && application.rbs.permissions[p]){
                arrayAppend(local.passes, { "#p#": true });
            } else {
                arrayAppend(local.fails, { "#p#": false });
            }
        }
        // If user has all the permissions required, approve
        if(arraylen(local.passes) == arraylen(local.permissions) && !arraylen(local.fails)){
            local.rv=true;
        }
        //writeDump(local);
        //abort;
        return local.rv;
    }

    // Attempt to construct a default permission string by nested controller + action
    public string function getDefaultPermissionString(){
        local.string="";
        if(isDefined("params")){
            if(structKeyExists(params, "Controller")) local.string &= params.controller;
            if(structKeyExists(params, "Action") && len(params.action)) local.string &= '.' & params.action;
        }
        return local.string;
    }
    // Convert a dot notation string to an array
    public array function getPermissionArr(required string permission){
        local.rv=[];
        local.t="";
        local.arr=listToArray(lcase(arguments.permission), '.');
        for(p in local.arr){
            local.t&='.' & p;
            arrayAppend(local.rv, right(local.t, (len(local.t)-1) ) );
        }
        return local.rv;
    }
</cfscript>
