<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!---

Notes
	This CFC should provide json, xml, rss, ical, (+ rendered html?) data dependent on url strings being passed in.
	@format: one of
--->
<cfcomponent extends="Controller" output="false">
	<cffunction name="init">
		<cfscript>
			provides("json,xml,html");
			filters(through="isValidAPIRequest", except="index");
			filters(through="checkPermissionAndRedirect", permission="allowAPI", only="index");
			filters(through="checkPermissionAndRedirect", permission="accessapplication", only="index");
			filters(through="_getLocations", only="index");
			usesLayout(template="false", only="ical");
			//filters(through="checkPermissionAndRedirect", permission="allowRSS", only="rss");
			//filters(through="checkPermissionAndRedirect", permission="allowiCAL", only="ical");
		</cfscript>
	</cffunction>

<!---================================ Display available options ======================================--->
	<cffunction name="index" hint="Displays all possible feeds etc">

	</cffunction>

<!---================================ Feeds, authentication via token ======================================--->

	<cffunction name="rss2" output="false" hint="RSS2 Feed Defaults to 25 rows, but you can add maxrows=x to override">
		<cfparam name="params.maxrows" default="25" type="numeric">
		<cfparam name="params.format" default="xml" type="string">
		<cfscript>
			if(structKeyExists(params, "location") AND isnumeric(params.location)){
				events=model("location").findAll(where="start > '#now()#' AND id = #params.location#", include="events", order="start", maxrows=params.maxrows);
			}
			else {
				events=model("location").findAll(where="start > '#now()#'", include="events", order="start", maxrows=params.maxrows);
			}
			renderWith(data=events);
		</cfscript>
	</cffunction>

	<cffunction name="ical" output="false" hint="iCal feed - Bit of an experiment! based on cflib.org USiCal()">
		<cfparam name="params.maxrows" default="25" type="numeric">
		<cfscript>
		var vCal = "";
		var CRLF=chr(13)&chr(10);
		data = "";
		if(structKeyExists(params, "location") AND isnumeric(params.location)){
			events=model("location").findAll(where="start > '#now()#' AND id = #params.location#", include="events", order="start", maxrows=params.maxrows);
		}
		else {
			events=model("location").findAll(where="start > '#now()#'", include="events", order="start", maxrows=params.maxrows);
		}
		vCal = "BEGIN:VCALENDAR" & CRLF;
		vCal = vCal & "PRODID: -//#application.rbs.setting.sitetitle#//Room Booking System//EN" & CRLF;
		vCal = vCal & "VERSION:2.0" & CRLF;
		vCal = vCal & "METHOD:PUBLISH" & CRLF;
		vCal = vCal & "X-WR-TIMEZONE:UTC" & CRLF;
		vCal = vCal & "X-WR-CALDESC:#application.rbs.setting.sitetitle# Events" & CRLF;
		</cfscript>
		<cfloop query="events">
		<cfscript>
			vCal = vCal & "BEGIN:VEVENT" & CRLF;
			vCal = vCal & "UID:#createUUID()#_#application.rbs.setting.siteEmailAddress#" & CRLF;  // creates a unique identifier
			vCal = vCal & "ORGANIZER;CN=#application.rbs.setting.sitetitle#:MAILTO:#application.rbs.setting.siteEmailAddress#" & CRLF;
			vCal = vCal & "DTSTAMP:" &
					DateFormat(now(),"yyyymmdd") & "T" &
					TimeFormat(now(), "HHmmss") & CRLF;
			vCal = vCal & "DTSTART;TZID=Eastern Time:" &
					DateFormat(start,"yyyymmdd") & "T" &
					TimeFormat(start, "HHmmss") & CRLF;
			vCal = vCal & "DTEND;TZID=Eastern Time:" &
					DateFormat(end,"yyyymmdd") & "T" &
					TimeFormat(end, "HHmmss") & CRLF;
			vCal = vCal & "SUMMARY:#title#" & CRLF;
			vCal = vCal & "LOCATION:#name# - #description#" & CRLF;
			vCal = vCal & "DESCRIPTION:#striptags(eventdescription)#" & CRLF;
			vCal = vCal & "PRIORITY:1" & CRLF;
			vCal = vCal & "TRANSP:OPAQUE" & CRLF;
			vCal = vCal & "CLASS:PUBLIC" & CRLF;
			vCal = vCal & "END:VEVENT" & CRLF;
		</cfscript>
		</cfloop>
		<cfscript>
		vCal = vCal & "END:VCALENDAR";
		data  = vCal;
		renderWith(data=data);
		</cfscript>
	</cffunction>

<!---================================ API Token Authentication ======================================--->
	<cffunction name="isValidAPIRequest" hint="Authenticates an API request via token">
		<cfscript>
		var r=false;
		if(structKeyExists(params, "token") AND len(params.token) GT 25){
			if(model("user").exists(where="apitoken='#params.token#'")){
				r=true;
			}
		}

		if(!r){
			redirectTo(route="denied", error="No API Authentication Token Present");
		}
		</cfscript>
	</cffunction>
 </cfcomponent>