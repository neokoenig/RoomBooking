<cfscript>
//=====================================================================
//=     Installation
//=====================================================================
    public function getRBSApplicationSettings(){
        local.settings=model("setting").findAll();
        for(var setting in local.settings){
            application.rbs.settings[setting.name]=setting.value;
        }
        local.permissions=model("permission").findAll(include="rolepermissions", where="roleid=6");
        for(var permission in local.permissions){
            application.rbs.permissions[permission.name]=true;
        }
       // local.workflow=model("workflow").findAll(
       //     where="workflows.isactive=1", include="workflowtriggers(trigger,action)");
       // local.triggers={};
       // for(var trigger in local.workflow){
       //     if(len(trigger.componentcfc)){
       //         if(!structKeyExists(local.triggers, trigger.triggeron))
       //             local.triggers[trigger.triggeron]={};
       //         if(!structKeyExists(local.triggers[trigger.triggeron], trigger.triggerwhen))
       //             local.triggers[trigger.triggeron][trigger.triggerwhen]=[];
       //         arrayAppend(local.triggers[trigger.triggeron][trigger.triggerwhen], {
       //             "title" = trigger.actiontitle,
       //             "description" = trigger.description,
       //             "componentcfc"= trigger.componentcfc,
       //             "properties" = trigger.propertiesjson
       //         });
       //     }
       // }
       // application.rbs.triggers=local.triggers;
    }

    // Install check for sysadmin
    public boolean function checkForAtLeastOneSysAdmin(){
        var local.sys=model("user").findAll(where="roles.name='sysadmin'", include="role");
        if(!local.sys.recordcount){
            return false;
        } else {
            return true;
        }
    }
</cfscript>
