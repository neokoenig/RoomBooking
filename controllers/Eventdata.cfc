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
	    			// Get all repeating events with 'never'
	    			//repeatingEvents=model("event").findAll(
	    			//	where="repeatrules.isnever = 1",
	    			//	include="repeatrule");
	    			//standardEvents=model("event").findAll(
	    			//	select="id, title, locationid,  class, start, end, allday, status",
	    			//	where="start >= '#sd#' AND end <= '#ed#' AND locations.building = '#fromTagSafe(params.key)#'",
	    			//	include="location",
	    			//	order="start ASC");
	    		// By location
	    		} else if(params.type EQ "location"){
	    			// Get all repeating events with 'never'
	    			//repeatingEvents=model("event").findAll(
	    			//	where="repeatrules.isnever = 1",
	    			//	include="repeatrule");
					//standardEvents=model("event").findAll(
					//	select="id, title, locationid,  class, start, end, allday, status",
	    			//	where="start >= '#sd#' AND end <= '#ed#' AND locationid = '#params.key#'",
	    			//	include="location",
	    			//	order="start ASC");
	    		// All
	    		} else {
	    			// Get Events for eg 2015-06-29 -> 2015-08-10
	    			sEvents=model("event").findAll(
	    				select="id, title, locationid, eventid,  class, start, end, allday, status, type, starts, isnever, endsafter, endson, repeatEvery, repeatOn, repeatBy",
	    				where="start >= '#sd#' AND end <= '#ed#' AND type IS NULL",
	    				include="location,repeatrule",
	    				order="start ASC");
	    			// Get all repeating events - we have to get these seperately,  as they may fall outside the current date range; We need to look for events which have a repeatstart BEFORE the current range
	    			rEvents=model("event").findAll(
	    				select="id, title, locationid, eventid,  class, start, end, allday, status, type, starts, isnever, endsafter, endson, repeatEvery, repeatOn, repeatBy",
	    			where="repeatrules.starts < '#ed#' AND type IS NOT NULL",
	    			include="location,repeatrule");

	    		}
	    	//events       = $generateRepeatingEvents(sEvents, sd, ed);
	    	repeatEvents = $generateRepeatingEvents(rEvents, sd, ed);

	    	events=[];
	    	for(event in repeatEvents){
	    		arrayAppend(events, event);
	    	}
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
	*  @hint
	*/
	private array function $generateRepeatingEvents(events, sd, ed) {
		var dateArray=[];
		var result=[];
		var c=1;
		for(event in events){
			// Skip if normal event
			if(len(event.type)){
			/*

			Firstly, work out whether this is a repeat which is
				1) A Never ending repeat
				2) An event which has a strict number of iterations
				3) Or ends on a certain date.

				An event can only have one of these repeating end conditions
			*/
			if(event.isNever){
				repeatType="never";
				// If never, set the range end date to the end of the current viewable range
				event.endsOn=ed;
			}
			if(len(event.endsafter)){
				repeatType="iteration";
			}
			if(len(event.endsOn)){
				repeatType="range";
			}

			// Doublecheck we've got a start date, if not, set the event start as the repeat start date
			if(!isDate(event.starts)){
				event.starts=event.start;
			}
			/*
				Next, match up the repeat end type with the repeat rule type
			*/
			switch(repeatType){
			 	case "iteration":
			 		switch(event.type){
						case "day":
							dateArray=dateCalcIterations(eventStart=event.start, eventEnd=event.end, step=event.repeatevery,dow="",  iterations=event.endsafter);
						break;
						case "weekday":
							dateArray=dateCalcIterations(eventStart=event.start, eventEnd=event.end, iterations=event.endsafter, dow="2,3,4,5,6");
						break;
						case "mwf":
							dateArray=dateCalcIterations(eventStart=event.start, eventEnd=event.end,  iterations=event.endsafter, dow="2,4,6");
						break;
						case "tt":
							dateArray=dateCalcIterations(eventStart=event.start, eventEnd=event.end,   iterations=event.endsafter, dow="3,5");
						break;
						case "week":
							dateArray=dateCalcIterations(eventStart=event.start, eventEnd=event.end,   step=event.repeatevery,  dow=event.repeaton, iterations=event.endsafter);
						break;
						case "month":
							dateArray=dateCalcIterationsWithSkip(eventStart=event.start, eventEnd=event.end, iterations=event.endsafter,dow="",  datePart="m", step=event.repeatevery, rule=event.repeatby);
						break;
						case "year":
							dateArray=dateCalcIterationsWithSkip(eventStart=event.start, eventEnd=event.end, iterations=event.endsafter,dow="",  datePart="yyyy", step=event.repeatevery);
						break;
	    			}
				break;
				// If it's not an iteration, assume a range.
				// Range can either be implicitedly set  by user, or generated as a never expiring date
				default:
					switch(event.type){
						case "day":
							dateArray=dateCalcRange(rangeStart=event.starts, rangeEnd=event.endsOn, eventStart=event.start, eventEnd=event.end, dow="",  step=event.repeatevery);
						break;
						case "weekday":
							dateArray=dateCalcRange(rangeStart=event.starts, rangeEnd=event.endsOn, eventStart=event.start, eventEnd=event.end, dow="2,3,4,5,6");
						break;event.endsOn
 						case "mwf":
							dateArray=dateCalcRange(rangeStart=event.starts, rangeEnd=event.endsOn, eventStart=event.start, eventEnd=event.end,  dow="2,4,6");
						break;
						case "tt":
							dateArray=dateCalcRange(rangeStart=event.starts, rangeEnd=event.endsOn, eventStart=event.start, eventEnd=event.end,  dow="3,5");
						break;
						case "week":
							dateArray=dateCalcRange(rangeStart=event.starts, rangeEnd=event.endsOn, eventStart=event.start, eventEnd=event.end,  step=event.repeatevery,  dow=event.repeaton);
						break;
						case "month":
							dateArray=dateCalcRangeWithSkip(rangeStart=event.starts, rangeEnd=event.endsOn, eventStart=event.start, eventEnd=event.end,  dow="", datePart="m", step=event.repeatevery, rule=event.repeatby);
						break;
						case "year":
							dateArray=dateCalcRangeWithSkip(rangeStart=event.starts, rangeEnd=event.endsOn, eventStart=event.start, eventEnd=event.end,  dow="", datePart="yyyy", step=event.repeatevery);
						break;
	    			}
				break;
			}

    		if(arrayLen(dateArray)){
	    		for (calcDate in dateArray){
	    			// Check we only return events which are in a designated range
	    			if(
	    				(dateCompare(calcDate.start, sd) GTE 0) AND
	    				(dateCompare(calcDate.end, ed) LTE 0)
	    			){
						result[c]["id"]       	=	event.id;
						result[c]["title"]    	=	event.title;
						result[c]["start"]    	=	_f_d(calcDate.start);
						result[c]["end"]      	=	_f_d(calcDate.end);
						result[c]["allDay"]   	=	event.allDay;
						result[c]["className"]	=	event.class & ' ' & event.status & ' repeater';
						result[c]["rEnds"]	=	event.endson;
						c++;
					}
				}
    		}
    		dateArray=[];
    		}
    		else {
    			// Standard Event
				result[c]["id"]       	=	event.id;
				result[c]["title"]    	=	event.title;
				result[c]["start"]    	=	_f_d(event.start);
				result[c]["end"]      	=	_f_d(event.end);
				result[c]["allDay"]   	=	event.allDay;
				result[c]["className"]	=	event.class & ' ' & event.status;
    		}
	    }
	    return result;
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