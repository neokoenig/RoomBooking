<cfscript>
//=====================================================================
//=     triggers
//=====================================================================
/*
    # Workflows, Triggers, Actions

    You can have as many workflows as you need. They might be seperated via function,
    or in any other way.

    So you could have a workflow which just deals with notifications; That workflow
    then has multiple "trigger" points, which in turn execute specific "actions".

    Triggers tell the workflow when to do something. They are automatically called from from
    almost all controllers and model functions. There are two trigger types, model & controller.

    ## Controller Triggers

    For controllers, they are setup as a before filter, and will try and look for a corresponding
    trigger/action for that combination of controller + method.

    Controllers must call super.init() for this functionality.

    i.e, if the controller was in "/controllers/admin/bookings.cfc", and you wanted to do something before
    the show() method page was called, then you'd set up a trigger with:

    Title : "Before Showing a booking, do this"
    Type: controller
    On: controllers.admin.bookings
    When: show

    ## Model Triggers

    Any model which extends the main wheels model will will look for a
    trigger on the following hook points:

        afterCreate
        afterDelete
        afterInitialization
        (nb afterFind deliberately left out due to potential overhead)
        afterNew
        afterSave
        afterUpdate
        afterValidation
        afterValidationOnCreate
        afterValidationOnUpdate
        beforeCreate
        beforeDelete
        beforeSave
        beforeUpdate
        beforeValidation
        beforeValidationOnCreate
        beforeValidationOnUpdate

    i.e, if the model was in "/models/admin/Booking.cfc", and you wanted to do something before a booking was created (i.e, saved for the first time) then you'd set up a trigger with:

    Title : "Before Creating a booking, do this"
    Type: model
    On: admin.bookings
    When: beforeCreate

    So a workflow is a mixture of Triggers and actions which essentially tell the workflow
    "When (Trigger)" to do "What (Action)".

    Only triggers which are registered in application.rbs.triggers will be
    actually executed.

    # Creating your own actions

    Actions are tableless models, so have a CFC all themselves in `/models/Actions/`.

    Actions require you to have at least two functions `describe()` and `save()`;

    `describe()` is used to create the properties which that action might have.

    `describe()` should return an array of structs, with `name,type,required` as a minimum

    function describe(){
        return [
            {
                "name": "name",
                "type": "text",
                "required": false
            },
            {
                "name": "email",
                "type": "text",
                "validate": "email",
                "required": false
            }
        ];
    }

    `save()` executes the action, and should `return true;` as an absolute minimum (unless you're doing
    something crazy like aborting the application), but will basically be where you're doing the "grunt" work of that particular action.
*/
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
