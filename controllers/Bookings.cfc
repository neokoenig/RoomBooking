<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfcomponent extends="Controller">
	<cffunction name="init">
		<cfscript>
			filters(through="_getLocations", only="index,add,edit,clone,create,update,list");
			filters(through="checkPermissionAndRedirect", permission="accessapplication");
			filters(through="checkPermissionAndRedirect", permission="accesscalendar");
			filters(through="checkPermissionAndRedirect", permission="allowRoomBooking", except="index,list");
			filters(through="checkPermissionAndRedirect", permission="viewRoomBooking", only="list,view");
		</cfscript>
	</cffunction>


<!---================================ Views ======================================--->
	<cffunction name="view" hint="Static display of a single event, mainly used in RSS permalinks etc">
		<cfscript>
		if(structKeyExists(params, "key") AND isNumeric(params.key)){
			event=model("location").findAll(where="events.id = #params.key#", include="events");
		} else {
			redirectTo(route="home", error="No event specified");
		}
		</cfscript>
	</cffunction>

	<cffunction name="add">
        <cfscript>
        	 event=model("event").new();

        	 // Listen out for event date & location passed in URL via JS
        	 if(structKeyExists(params, "d")){
        	 //2015-09-25T00:00:00+01:00
        	 	qDate=createDateTime(listFirst(params.d, '-'),ListGetAt(params.d, 2, '-'),ListGetAt(params.d, 3, '-'),00,00,00);
        	 	event.start=dateFormat(qDate, "YYYY-MM-DD") & ' ' & timeFormat(qDate, "HH:MM");
        	 }
        	 if(structKeyExists(params, "key") AND isNumeric(params.key)){
        	 	event.locationid=params.key;
        	}

        </cfscript>
    </cffunction>

	<cffunction name="clone">
        <cfscript>
        	// Event to clone from
        	 event=model("event").findOne(where="id = #params.key#")

			renderPage(action="add");

        </cfscript>
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
			if(structKeyExists(params.event, "emailContact") AND params.event.emailContact AND isValid("email", event.contactemail) AND !application.rbs.setting.isDemoMode){
				sendEmail(
					    to="#event.contactname# <#event.contactemail#>",
					    from="#application.rbs.setting.sitetitle# <#application.rbs.setting.siteEmailAddress#>",
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


<!---================================ Agenda Views ======================================--->
	<cffunction name="list" hint="Shows Agenda style view table for a given month">
		<cfparam name="params.m" default="#month(now())#">
		<cfparam name="params.y" default="#year(now())#">
		<cfset events=model("location").findAll(where="#_agendaListWC()#", include="events", order="start")>
	</cffunction>

	<cffunction name="_agendaListWC" access="private">
	 	<cfscript>
	 		var sd="";
	 		var td="";
			var wc=[];
			// Date Filter
			if(structKeyExists(params, "m")
				AND structKeyExists(params, "Y")
				AND len(params.m) GT 0
				AND len(params.y) EQ 4
				AND isNumeric(params.m)
				AND isNumeric(params.y)){
					sd=createDateTime(params.y, params.m, 1, 00,00,00);
					td=createDateTime(params.y, params.m, DaysInMonth(sd), 23,59,59);
					arrayAppend(wc, "start > '#sd#'");
					arrayAppend(wc, "start < '#td#'");
			}
			// Location Filter
			if(structKeyExists(params, "location") AND isNumeric(params.location)){
				arrayAppend(wc, "locationid = #params.location#");
			}
			if(arrayLen(wc)){
				return arrayToList(wc, " AND ");
			} else {
				return "";
			}
			</cfscript>
		<cfset events=model("location").findAll(include="events", order="start")>
	</cffunction>
</cfcomponent>