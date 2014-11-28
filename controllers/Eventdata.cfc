<!---================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Controller" hint="Misc Event Data"
{
	/**
	 * @hint Constructor.
	 */
	public void function init() {
		super.init();

		// Additional Permissions
		filters(through="checkPermissionAndRedirect", permission="accesscalendar");
		filters(through="_isValidAjax");

		// Data
		filters(through="_getResources", only="getevent");

		// Formats
		provides("html,json");
		usesLayout(template="modal", only="getevent");
	}

/******************** Public***********************/
	/**
	*  @hint Get Events For the provided range via ajax
	*/
	public void function getEvents() {
		if(structkeyexists(params, "start") AND structkeyexists(params, "end")){

	    	var sd=createDateTime(year(params.start), month(params.start), day(params.start), 00,00,00);
	    	var ed=createDateTime(year(params.end), month(params.end), day(params.end), 00,00,00);

	    	if(structKeyExists(params, "key")){
		    	//data=model("event").findAll(where="locations.id = #params.key#", include="location");
		    		data=model("event").findAll(select="id, title, locationid,  class, start, end, allday",
	    			where="start >= '#sd#' AND end <= '#ed#' AND locationid = '#params.key#'", include="location",
	    			order="start ASC");
 	    	} else {
	    		data=model("event").findAll(select="id, title, locationid,  class, start, end, allday",
	    			where="start >= '#sd#' AND end <= '#ed#'", include="location",
	    			order="start ASC");
	    	}
	    	events=prepEventData(data);
		    renderWith(events);
		}
		else {
			abort;
		}
	}

	/**
	*  @hint get single event via ajax, i.e for modals
	*/
	public void function getEvent() {
		if(structKeyExists(params, "key")){
		 	event=model("location").findAll(where="events.id = #params.key#", include="events(eventresources)");
		}
	}
/******************** Private *********************/
 	/**
 	*  @hint Sort out event data
 	*/
 	private array function prepEventData(data) {
 		var events=[];
 		var c=1;
 		for(event in arguments.data){
			events[c]["id"]=event.id;
			events[c]["title"]=event.title;
			events[c]["start"]=_f_d(event.start);
			events[c]["end"]=_f_d(event.end);
			events[c]["allDay"]=event.allDay;
			events[c]["className"]=event.class;
			c++;
 		}
 		return events;
 	}
 	/**
 	*  @hint Experimental date format
 	*/
 	private string function _f_d(str) {
 	 return dateFormat(arguments.str, "YYYY-MM-DD") & "T" & timeFormat(arguments.str, "HH:MM:00")
 	}

}