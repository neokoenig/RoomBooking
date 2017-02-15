<cfscript>
//=====================================================================
//=     triggers
//=====================================================================

    function setupTriggerLog(){
    	if(!structKeyExists(request, "triggers")) request.triggers=[];
    }
    function fireTrigger(string name="", string type="", string when=""){
        local["name"]=lcase(arguments.name);
        local["type"]=singularize(listFirst(arguments.name, '.'));
        local["when"]=arguments.when;
        logTrigger(argumentCollection=local);
        matchTrigger(argumentCollection=local);
    }

    function logTrigger(string name, string type){
    	setupTriggerLog();
        arrayAppend(request.triggers, arguments);
    }

    function matchTrigger(name, when){
        local.triggers=application.rbs.triggers;
        local.prop={};
        if(structKeyExists(local.triggers, arguments.name)
            && structKeyExists(local.triggers[arguments.name], arguments.when)
        ){
            local.triggers[arguments.name][arguments.when];
             logTrigger(argumentCollection=local);
            for(f in local.triggers[arguments.name][arguments.when]){
                // Create a new instance of the action;
                // If there are properties stored, pass them in
                if(isStruct(deserializeJSON(f.properties))){
                    local.prop=deserializeJSON(f.properties);
                }
                var a=model("Actions." & f.componentcfc).new(local.prop);
                // Execute it.
                    a.save();
            }
        }
    }

</cfscript>
