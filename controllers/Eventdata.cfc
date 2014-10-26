<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfcomponent extends="Controller">
<!--- All things events related, mostly called via ajax --->
	<cffunction name="init">
		<cfscript>
			provides("html,json");
			usesLayout(template="modal", only="getevent");
			filters(through="checkPermissionAndRedirect", permission="accessapplication");
			filters(through="checkPermissionAndRedirect", permission="accesscalendar");
		</cfscript>
	</cffunction>

<!---================================ Views via Ajax ======================================--->
	<cffunction name="getEvents" hint="Get Events For the provided range">
	    <cfscript>
	    if(isAjax() AND structkeyexists(params, "start") AND structkeyexists(params, "end")){
	    	if(structKeyExists(params, "key")){
		    	data=model("location").findAll(where="start > '#eToLocal(params.start)#' AND id = #params.key#", include="events");
 	    	} else {
	    		data=model("location").findAll(where="start > '#eToLocal(params.start)#'", include="events");
	    	}
	    	events=prepEventData(data);
		    renderWith(events);
		}
		else {
			abort;
		}
	    </cfscript>
	</cffunction>


	<cffunction name="getEvent" hint="Get Single Clicked Event">
		<cfscript>
		if(isAjax() AND structKeyExists(params, "key")){
		 	event=model("location").findAll(where="events.id = #params.key#", include="events");
		}
		</cfscript>
	</cffunction>

<!---================================ Private ======================================--->
	<cffunction name="prepEventData" access="private">
		<cfargument name="data">
		<cfset var events=[]>
		<cfloop query="arguments.data">
			<cfscript>
				events[currentrow]["id"]=arguments.data.eventid[currentrow];
				events[currentrow]["title"]=arguments.data.title[currentrow];
				events[currentrow]["start"]=arguments.data.start[currentrow];
				events[currentrow]["end"]=arguments.data.end[currentrow];
				events[currentrow]["allDay"]=arguments.data.allDay[currentrow];
				events[currentrow]["location"]=arguments.data.name[currentrow];
				events[currentrow]["ldescription"]=arguments.data.description[currentrow];
				events[currentrow]["edescription"]=arguments.data.eventdescription[currentrow];
				events[currentrow]["className"]=arguments.data.class[currentrow];
				events[currentrow]["createdAt"]=arguments.data.createdAt[currentrow];
				events[currentrow]["updatedAt"]=arguments.data.updatedAt[currentrow];
			</cfscript>
		</cfloop>
		<cfreturn events />
	</cffunction>


</cfcomponent>