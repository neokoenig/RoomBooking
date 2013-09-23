<cfcomponent extends="controller">
	<cffunction name="init">
		<cfscript>
			filters(through="_getLocations", only="index,add,edit,create,update");
		</cfscript>
	</cffunction>

	<cffunction name="index" hint="Displays what's on today - main dashboard"> 
	</cffunction>

	<cffunction name="add">
        <cfscript>
        	 event=model("event").new();
        	 
        	 // Listen out for event date & location passed in URL via JS 
        	 if(structKeyExists(params, "d")){
        	 //2015-09-25T00:00:00+01:00
        	 	qDate=createDateTime(listFirst(params.d, '-'),ListGetAt(params.d, 2, '-'),ListGetAt(params.d, 3, '-'),00,00,00);
        	 	event.start=qDate; 
        	 }
        	 if(structKeyExists(params, "key") AND isNumeric(params.key)){
        	 	event.locationid=params.key;
        	}

        </cfscript>>  
    </cffunction>
    
    <cffunction name="edit">
    	<cfset event=model("event").findOne(where="id = #params.key#")>
    </cffunction>
    
    <cffunction name="create">
    <cfscript> 
	if(structkeyexists(params, "event")){
    	event = model("event").new(params.event);
 
		if ( event.save() ) {  
			// Check for bulk create events
			if(structKeyExists(params, "repeat") 
				AND params.repeat NEQ "none" 
				AND structKeyExists(params, "repeatno") 
				AND isnumeric(params.repeatno) 
				AND params.repeatno GTE 1)
			{
				for (i = 1; i lte params.repeatno; i = i + 1){
					//create placeholderevent
					nevent = model("event").new(params.event);
					//increment date as appropriate
					if(params.repeat EQ "week"){
						nevent.start = dateAdd("d", (i * 7), nevent.start);
						if(isDate(nevent.end)){
							nevent.end = dateAdd("d", (i * 7), nevent.end);
						}
				  		
					}
					if(params.repeat EQ "month"){
						nevent.start = dateAdd("m", i, nevent.start);
						if(isDate(nevent.end)){
					  		nevent.end = dateAdd("m", i, nevent.end); 
					  	}
					}
					// Save the child event 
					nevent.save();
				}
			}
			// Send Confirmation email if appropriate
			if(structKeyExists(params.event, "emailContact") AND isValid("email", event.contactemail)){
				sendEmail(
					    to="#event.contactname# <#event.contactemail#>",
					    from="#application.rbs.sitetitle# <#application.rbs.siteEmailAddress#>",
					    template="/email/bookingNotify",
					    subject="Room Booking Confirmation", 
					    event=event
					);
			}
			redirectTo(action="index", success="Event successfully created");
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