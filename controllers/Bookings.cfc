<cfcomponent extends="controller">
	<cffunction name="init">
		<cfscript>
			filters(through="_getLocations", only="index,add,edit,create,update");
		</cfscript>
	</cffunction>

	<cffunction name="index" hint="Displays what's on today - main dashboard">

	</cffunction>

	<cffunction name="add">
        <cfset event=model("event").new()>  
    </cffunction>
    
    <cffunction name="edit">
    	<cfset event=model("event").findOne(where="id = #params.key#")>
    </cffunction>
    
    <cffunction name="create">
    <cfscript>
	if(structkeyexists(params, "event")){
    	event = model("event").new(params.event);
		if ( event.save() ) {  
			redirectTo(action="index", success="event successfully created");
		}
        else { 
			renderPage(action="add", error="There were problems creating that event");
		} 
	}
	</cfscript>
    </cffunction>
    
    <cffunction name="update">
    <cfscript>
	if(structkeyexists(params, "event")){
    	event = model("event").findOne(where="id = #params.key#");
		event.update(params.event);
		if ( event.save() )  {  
			redirectTo(action="index", success="event successfully updated");
		}
        else {  
			renderPage(action="edit", error="There were problems updating that event");
		} 
	}
	</cfscript>
    </cffunction>
     
	 
	 <cffunction name="delete">
	 <cfscript>
	 if(structkeyexists(params, "key")){
    	event = model("event").findOne(where="id = #params.key#");
		 
		if ( event.delete() )  {  
			redirectTo(action="index", success="event successfully deleted");
		}
        else {  
			redirectTo(action="index", error="There were problems deleting that event");
		} 
	}
	</cfscript>
	 </cffunction>
</cfcomponent>