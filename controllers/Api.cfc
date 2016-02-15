//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Controller" hint="RSS/ICal Etc"
{
	/**
	 * @hint Constructor.
	 */
	public void function init() {

		// Permissions (no super.init())
		filters(through="f_isValidAPIRequest", except="index");
		filters(through="checkPermissionAndRedirect", permission="allowAPI", only="index");

		// Data
		filters(through="_getLocations", only="index");

		// Format
		provides("json,xml,html");
		usesLayout(template="false", only="ical");
		usesLayout(template="displayboard", only="display");
	}

/******************** Public***********************/
	/**
	*  @hint Full Screen Display/digital signage
	*/
	public void function display() {
		param name="params.maxrows" default="5" type="numeric";
		param name="params.today" default=0 type="numeric";
		param name="params.status" default="approved" type="string";
		request.bodyClass="displayBoard";
		var sd=createDateTime(year(now()), month(now()), day(now()), 00, 00, 00);
		var ed=createDateTime(year(now()), month(now()), day(now()), 23, 59, 00);
		if(structkeyexists(params, "today") && params.today){
			params.start=sd;
			params.end=ed;
		} else {
			params.start=sd;
			params.end=dateAdd("yyyy", 1, ed);
		}
		if(structKeyExists(params, "location") AND isnumeric(params.location)){
			isSingleLocation=true;
		} 
		//	if(structKeyExists(params, "location") AND isnumeric(params.location)){
		//		isSingleLocation=true; 	
		//		events=model("location").findAll(where="status = 'approved' AND startsat > '#sd#' AND endsAt < '#ed#' AND id = #params.location#", include="events", order="startsat", maxrows=params.maxrows);
		//	}
		//	else {
		//		events=model("location").findAll(where="status = 'approved' AND startsat > '#sd#' AND endsAt < '#ed#'", include="events", order="startsat", maxrows=params.maxrows);
		//	}
		//} else {
		//	if(structKeyExists(params, "location") AND isnumeric(params.location)){
		//		isSingleLocation=true;
		//		events=model("location").findAll(where="status = 'approved' AND startsat > '#now()#' AND id = #params.location#", include="events", order="startsat", maxrows=params.maxrows);
		//	}
		//	else {
		//		events=model("location").findAll(where="status = 'approved' AND startsat > '#now()#'", include="events", order="startsat", maxrows=params.maxrows);
		//	}
		//}

		events=parseEventsForCalendar(events=getEventsForRange(), viewPortStartDate=params.start, viewPortEndDate=params.end); 


	}

	/**
	*  @hint RSS2 Feed Defaults to 25 rows, but you can add maxrows=x to override
	*/
	public void function rss2() {
		param name="params.maxrows" default="25" type="numeric";
		param name="params.format" default="xml" type="string";
		param name="params.status" default="approved" type="string";
		param name="params.start" default="#now()#";
		param name="params.end" default="#dateAdd("m", 3, now())#";
		events=parseEventsForCalendar(events=getEventsForRange(), viewPortStartDate=params.start, viewPortEndDate=params.end);  
		renderWith(data=events);
	}

	/**
	*  @hint iCal feed - Bit of an experiment! based on cflib.org USiCal()
	*/
	public void function ical() {
		param name="params.maxrows" default="25" type="numeric";
		var vCal = "";
		var CRLF=chr(13)&chr(10);
		data = "";
		events=parseEventsForCalendar(events=getEventsForRange(), viewPortStartDate=params.start, viewPortEndDate=params.end);
		//if(structKeyExists(params, "location") AND isnumeric(params.location)){
		//	events=model("location").findAll(where="status = 'approved' AND startsat > '#now()#' AND id = #params.location#", include="events", order="startsat", maxrows=params.maxrows);
		//}
		//else {
		//	events=model("location").findAll(where="status = 'approved' AND startsat > '#now()#'", include="events", order="startsat", maxrows=params.maxrows);
		//}
		vCal = "BEGIN:VCALENDAR" & CRLF;
		vCal = vCal & "PRODID: -//#application.rbs.setting.sitetitle#//Room Booking System//EN" & CRLF;
		vCal = vCal & "VERSION:2.0" & CRLF;
		vCal = vCal & "METHOD:PUBLISH" & CRLF;
		vCal = vCal & "X-WR-TIMEZONE:UTC" & CRLF;
		vCal = vCal & "X-WR-CALDESC:#application.rbs.setting.sitetitle# Events" & CRLF;
		for(event in events){
			vCal = vCal & "BEGIN:VEVENT" & CRLF;
			vCal = vCal & "UID:#createUUID()#_#application.rbs.setting.siteEmailAddress#" & CRLF;  // creates a unique identifier
			vCal = vCal & "ORGANIZER;CN=#application.rbs.setting.sitetitle#:MAILTO:#application.rbs.setting.siteEmailAddress#" & CRLF;
			vCal = vCal & "DTSTAMP:" &
					DateFormat(now(),"yyyymmdd") & "T" &
					TimeFormat(now(), "HHmmss") & CRLF;
			vCal = vCal & "DTSTART;TZID=Eastern Time:" &
					DateFormat(event.start,"yyyymmdd") & "T" &
					TimeFormat(event.start, "HHmmss") & CRLF;
			vCal = vCal & "DTEND;TZID=Eastern Time:" &
					DateFormat(event.end,"yyyymmdd") & "T" &
					TimeFormat(event.end, "HHmmss") & CRLF;
			vCal = vCal & "SUMMARY:#event.title#" & CRLF;
			vCal = vCal & "LOCATION:#event.name# - #event.description#" & CRLF;
			vCal = vCal & "DESCRIPTION:#striptags(event.description)#" & CRLF;
			vCal = vCal & "PRIORITY:1" & CRLF;
			vCal = vCal & "TRANSP:OPAQUE" & CRLF;
			vCal = vCal & "CLASS:PUBLIC" & CRLF;
			vCal = vCal & "END:VEVENT" & CRLF;
		}
		vCal = vCal & "END:VCALENDAR";
		data  = vCal;
		writeDump(data);
		abort;
		//renderWith(data=data);
	}
/******************** Private *********************/
	/**
	*  @hint Whether the URL has a valid API token
	*/
	private void function f_isValidAPIRequest() {
		var r=false;
		if(structKeyExists(params, "token") AND len(params.token) GT 25){
			if(model("user").exists(where="apitoken='#params.token#'")){
				r=true;
			}
		}
		if(!r){
			redirectTo(route="denied", error="No API Authentication Token Present");
		}
	}

}

