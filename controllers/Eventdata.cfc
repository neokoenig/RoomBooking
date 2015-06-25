//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Controller" hint="Misc Event Data"
{
	/**
	 * @hint Constructor.
	 */
	public void function init() {
		super.init();

		// Additional Permissions
		filters(through="checkPermissionAndRedirect", permission="accesscalendar");
		//filters(through="_isValidAjax");

		// Data
		filters(through="_getResources", only="getevent");

		// Verification
		verifies(only="getevent", params="key", paramsTypes="integer", route="home", error="Sorry, that event can't be found");


		// Formats
		provides("html,json");
		usesLayout(template="modal", only="getevent");
		filters(through="_setModelType");
	}

/******************** Public***********************/
	/**
	*  @hint Get Events For the provided range via ajax
	*
	* 		 There are three main type of calendar view:
	* 			index - basically everything
	* 			building - a collection of locations
	* 			location - a specific location
	*/
	public void function getevents() {
		param name="params.type" default="";

		if(structkeyexists(params, "start") AND structkeyexists(params, "end")){

	    	var sd=createDateTime(year(params.start), month(params.start), day(params.start), 00,00,00);
	    	var ed=createDateTime(year(params.end), month(params.end), day(params.end), 00,00,00);

	    		// By building
	    		if(params.type EQ "building"){
	    			data=model("event").findAll(select="id, title, locationid,  class, start, end, allday, status",
	    			where="start >= '#sd#' AND end <= '#ed#' AND locations.building = '#fromTagSafe(params.key)#'", include="location",
	    			order="start ASC");
	    		// By location
	    		} else if(params.type EQ "location"){
					data=model("event").findAll(select="id, title, locationid,  class, start, end, allday, status",
	    			where="start >= '#sd#' AND end <= '#ed#' AND locationid = '#params.key#'", include="location",
	    			order="start ASC");
	    		// All
	    		} else {
	    			data=model("event").findAll(select="id, title, locationid,  class, start, end, allday, status",
	    			where="start >= '#sd#' AND end <= '#ed#'", include="location",
	    			order="start ASC");
	    		}

	    	events=prepeventdata(data);
		    renderWith(events);
		}
		else {
			abort;
		}
	}

	/**
	*  @hint get single event via ajax, i.e for modals
	*/
	public void function getevent() {
	 	event=model("location").findAll(where="events.id = #params.key#", include="events(eventresources)");
	}
/******************** Private *********************/
 	/**
 	*  @hint Sort out event data
 	*/
 	private array function prepeventdata(data) {
 		var events=[];
 		var c=1;

 		for(event in arguments.data){
			events[c]["id"]=event.id;
			events[c]["title"]=event.title;
			events[c]["start"]=_f_d(event.start);
			events[c]["end"]=_f_d(event.end);
			events[c]["allDay"]=event.allDay;
			events[c]["className"]=event.class & ' ' & event.status;
			c++;
 		}
 		return events;
 	}
 	/**
 	*  @hint Experimental date format
 	*/
 	private string function _f_d(str) {
 	 return dateFormat(arguments.str, "YYYY-MM-DD") & "T" & timeFormat(arguments.str, "HH:MM:00");
 	}

 		/**
	*  @hint Sets the model type to use with Custom Fields + Templates
	*/
	public void function _setModelType() {
		request.modeltype="event";
	}


}