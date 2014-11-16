<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfcomponent extends="Controller">
	<cffunction name="init">
		<cfscript>
			filters(through="_getLocations", only="index,add,edit,clone,create,update,list,day");
			filters(through="_getResources", only="index,add,edit,clone,create,update,list");
			filters(through="checkPermissionAndRedirect", permission="accessapplication");
			filters(through="checkPermissionAndRedirect", permission="accesscalendar");
			filters(through="checkPermissionAndRedirect", permission="allowRoomBooking", except="index,list,day");
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
        	 nEventResources=model("eventresource").new();
        	 event=model("event").new(eventresources=nEventResources);

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
        	 event=model("event").findOne(where="id = #params.key#", include="eventresources");
        	 renderPage(action="add");
        </cfscript>
    </cffunction>

    <cffunction name="edit">
    	<cfset event=model("event").findOne(where="id = #params.key#", include="eventresources")>
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
    	event = model("event").findOne(where="id = #params.key#", include="eventresources");
		event.update(params.event);
		event.save();
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
    	event = model("event").findOne(where="id = #params.key#", include="eventresources");
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

	<cffunction name="day" hint="Alternative Day View">
		<cfparam name="params.y" default="#year(now())#">
		<cfparam name="params.m" default="#month(now())#">
		<cfparam name="params.d" default="#day(now())#">
		<cfscript>
			events=model("event").findAll(where="#_dayListWC()#", order="start", include="location");
			allDay=model("event").findAll(where="#_dayListWC(allday=1)#", order="start", include="location");
			day={}
			day.thedate=createDate(params.y, params.m, params.d);
			// Used in Prev/Next paging
			day.yesterday=dateAdd("d", -1, day.thedate);
			day.tomorrow=dateAdd("d", 1, day.thedate);
			// Use user prefs in calculating time
			day.starttime=CreateTime(_timeParse(application.rbs.setting.calendarMinTime), 0, 0);
			day.endtime=CreateTime(_timeParse(application.rbs.setting.calendarMaxTime), 59, 0);
			// Placeholder arrays
			m=[];
			e=[];
			tempid=0;
		</cfscript>
	 	<cfloop query="locations">
 		<cfloop from="#day.starttime#" to="#day.endtime#" index="i" step="#CreateTimeSpan(0,0,application.rbs.setting.calendarSlotMinutes,0)#">
 			<cfscript>
		 	t={};
 			t.timeslot=createDateTime(year(day.thedate), month(day.thedate), day(day.thedate), TimeFormat(i, "H"), TimeFormat(i, "m"), 0);
 			</cfscript>
		 	<cfquery dbtype="query" name="locationEvents">
			SELECT * FROM events WHERE locationid = <cfqueryparam cfsqltype="cf_sql_numeric" value="#id#">
			AND start <=
			<cfqueryparam cfsqltype="cf_sql_timestamp" value="#t.timeslot#">
			AND end >
			<cfqueryparam cfsqltype="cf_sql_timestamp" value="#t.timeSlot#">
			AND allday = 0;
			</cfquery>
			<cfscript>
				if(locationEvents.recordcount){
					 if(tempid NEQ locationEvents.id){
						// First tablecell of event
						t.duration=DateDiff("n", locationEvents.start, locationEvents.end);
						t.rowspan=ceiling(t.duration / 15);
						t.content="<strong>"
						& linkTo( class="remote-modal", controller='eventdata', action='getEvent',  key=locationEvents.id, text=h(locationEvents.title))
						& "</strong><br />"
						& h(locationEvents.name) & "<br />"
						& "#timeFormat(locationEvents.start, "HH:MM")# - #timeFormat(locationEvents.end, "HH:MM")# "
						& _durationString(t.duration);
						t.class="booked first #class#";
						if(locationEvents.recordcount GT 1) {
							t.content=t.content & "<br /><span class='label label-danger'><i class='glyphicon glyphicon-warning-sign'></i> Overlapping Event!</span>";
						}
					 } else {
						// Subsequent cells
						t.content="";
						t.class="booked #class#";
						t.rowspan=0;
					}
					tempid=locationEvents.id;
				}
				else {
					t.class="free"
					t.content="";
					t.rowspan=1;
				}
			arrayAppend(e, t);
			</cfscript>
	 	</cfloop>
	 	<cfset arrayAppend(m, e)>
	 	<cfset e=[]>
	</cfloop>
	</cffunction>

<!---================================ Private ======================================--->
	<cffunction name="_dayListWC" access="private">
		<cfargument name="allday" default="0">
	 	<cfscript>
	 		var sd="";
	 		var td="";
			var wc=[];
			// Date Filter

				if(structKeyExists(params, "m")
					AND structKeyExists(params, "y")
					AND structKeyExists(params, "d")
					AND len(params.m) GT 0
					AND len(params.y) EQ 4
					AND len(params.d) GT 0
					AND isNumeric(params.m)
					AND isNumeric(params.y)
					AND isNumeric(params.d)
				){
					if(arguments.allday){
					// Get all day events from other days too...
						sd=createDateTime(params.y, params.m, params.d, 00,00,00);
						td=createDateTime(params.y, params.m, params.d, 23,59,59);
						arrayAppend(wc, "end > '#sd#'");
						arrayAppend(wc, "start < '#td#'");
					} else {
						sd=createDateTime(params.y, params.m, params.d, 00,00,00);
						td=createDateTime(params.y, params.m, params.d, 23,59,59);
						arrayAppend(wc, "end > '#sd#'");
						arrayAppend(wc, "start < '#td#'");
					}
				}

			arrayAppend(wc, "allday = #arguments.allday#");
			if(arrayLen(wc)){
				return arrayToList(wc, " AND ");
			} else {
				return "";
			}
			</cfscript>
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
	</cffunction>

	<cffunction name="_timeParse" hint="Must be a better way of doing this...Turns say, 7pm into 19 " access="private">
		<cfargument name="string">
		<cfset var r="">
		<cfset r=replaceNoCase(arguments.string, "am", "", "all")>
		<cfset r=replaceNoCase(r, "pm", "", "all")>
		<cfif arguments.string CONTAINS "pm">
			<cfset r=(r + 12)>
		</cfif>
		<cfreturn r>
	</cffunction>

	<cffunction name="_durationString" hint="Convert mins into time string">
		<cfargument name="d">
		<cfset var h=(arguments.d\60)>
		<cfset var m=numberformat(arguments.d % 60, "0")>
		<cfset var r="">

		<cfswitch expression="#h#">
			<cfcase value="0">
			</cfcase>
			<cfcase value="1">
				<cfset r=r & "#h# hour">
			</cfcase>
			<cfdefaultcase>
				<cfset r=r & "#h# hours">
			</cfdefaultcase>
		</cfswitch>

		<cfif m NEQ 0>
			<cfset r = r & " #m# mins">
		</cfif>
		<cfreturn "(" & r & ")" />
	</cffunction>


</cfcomponent>