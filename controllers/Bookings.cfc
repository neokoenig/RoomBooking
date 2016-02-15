//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Controller" hint="Main Events/Bookings Controller"
{
	/**
	 * @hint Constructor.
	 */
	public void function init() {
		super.init();

		// Additional Permissions
		filters(through="checkPermissionAndRedirect", permission="accesscalendar");
		filters(through="checkPermissionAndRedirect", permission="allowRoomBooking", except="index,list,day,building,location,check");
		filters(through="checkPermissionAndRedirect", permission="viewRoomBooking", only="list,view");
		filters(through="checkPermissionAndRedirect", permission="allowApproveBooking", only="approve,deny");

		// Verification
		verifies(only="approve,deny,view,clone,edit,delete", params="key", paramsTypes="integer", route="home", error="Sorry, that event can't be found");

		// Data
		filters(through="_getLocations", only="index,building,location,add,edit,clone,create,update,list,day");
		filters(through="_getResources", only="index,building,location,add,edit,clone,create,update,list,view");
		filters(through="_setModelType");

		// Ajax
		usesLayout(template=false, only="check");
	}

/******************** Views ***********************/
	/**
	*  @hint Static display of a single event, mainly used in RSS permalinks etc
	*/
	public void function view() {
		event=model("location").findAll(where="events.id = #params.key#", include="events(eventresources)");
		customfields=getCustomFields(objectname=request.modeltype, key=event.id);
	}

	/**
	*  @hint By Building
	*/
	public void function building() {
		renderPage(action="index");
	}
	/**
	*  @hint By Location
	*/
	public void function location() {
		renderPage(action="index");
	}
	/**
	*  @hint Shows Agenda style view table for a given month
	*/
	public void function list() {
		param name="params.start" default="#dateFormat(now(), 'YYYY-MM-DD')#";
		param name="params.end" 	 default="#dateFormat(dateAdd('m', 1, now()), 'YYYY-MM-DD')#";
		param name="params.location" default="";
		param name="params.q"		 default="";
		events=parseEventsForCalendar(events=getEventsForRange(), viewPortStartDate=params.start, viewPortEndDate=params.end);  
	} 

/******************** Admin ***********************/


	/**
	*  @hint Approve a listing
	*/
	public void function approve() {
		event=model("event").findOne(where="id = #params.key#");
		if(isObject(event)){
			event.status="approved";
			event.save();
			notifyContact(event);
		}
		redirectTo(success="#event.title# was approved", back=true);
	}

	/**
	*  @hint Deny a listing (can also delete)
	*/
	public void function deny() {
		event=model("event").findOne(where="id = #params.key#");
		if(isObject(event)){
			event.status="denied";
			event.save();
			// Notify Contact if Appropriate
			notifyContact(event);
			if(structKeyExists(params, "delete") AND params.delete){
				event.delete();
				redirectTo(success="#event.title# was denied & deleted", back=true);
			} else {
				redirectTo(success="#event.title# was denied", back=true);
			}
		}
	}

	/**
	*  @hint Shortcut to duplicating a booking
	*/
	public void function clone() {
	 	event=model("event").findOne(where="id = #params.key#", include="eventresources");
    	customfields=getCustomFields(objectname="event", key=event.key());
        renderPage(action="add");
	}

	/**
	*  @hint Event CRUD
	*/
	public void function edit() {
		event=model("event").findOne(where="id = #params.key#", include="eventresources");
		customfields=getCustomFields(objectname=request.modeltype, key=params.key);
	}

	/**
	*  @hint Add a new booking
	*/
	public void function add() {
		 nEventResources = model("eventresource").new(); 
    	 event           = model("event").new(eventresources=nEventResources);
    	 customfields    = getCustomFields(objectname="event", key=event.key());
    	 $checkForEventDefaultsinURL();
	}

	/**
	*  @hint Fill some defaults if passed in by URL
	*/
	public void function $checkForEventDefaultsinURL() {
		var qDate="";
	 	 // Listen out for event date & location passed in URL via JS
    	 if(structKeyExists(params, "d")){
    	 	qDate=createDateTime(listFirst(params.d, '-'),ListGetAt(params.d, 2, '-'),ListGetAt(params.d, 3, '-'),hour(now()),00,00);
    	 	event.startsat=LSdateFormat(qDate, "YYYY-MM-DD") & ' ' & LStimeFormat(qDate, "HH:mm");
    	 	// Give it an end date of +1h
    	 	event.endsat=dateAdd("h", 1, event.startsat);
    	 }
    	 if(structKeyExists(params, "key") AND isNumeric(params.key)){
    	 	event.locationid=params.key;
    	}
	}

	/**
	*  @hint Event CRUD
	*/
	public void function create() {
		if(structkeyexists(params, "event")){
	    	event = model("event").new(properties=params.event);
			if ( event.save() ) {
				// Update approval status if allowed to bypass
				if(application.rbs.setting.approveBooking AND checkPermission("bypassApproveBooking")){
					event.status="approved";
					event.save();
				}
				// Send Confirmation email if appropriate
				if(structKeyExists(params.event, "emailContact") AND params.event.emailContact){
					notifyContact(event);
				}
				redirectTo(action="index", success="Event successfully created");
			}
	        else {
	        	customfields    = getCustomFields(objectname="event", key=event.key());
				renderPage(action="add", error="There were problems creating that event");
			}
		}
	}



	/**
	*  @hint Email to send on approval/denial etc.
	*/
	public void function notifyContact(required struct event) {
		if( isValid("email", arguments.event.contactemail)
			AND !application.rbs.setting.isDemoMode){
			// Get the location for reference
			eventlocation=model("location").findOne(where="id = #arguments.event.locationid#");
			sendEmail(
			    to="#arguments.event.contactname# <#arguments.event.contactemail#>",
			    bcc=iif(application.rbs.setting.bccAllEmail, '"#application.rbs.setting.bccAllEmailTo#"', ''),
			    from="#application.rbs.setting.sitetitle# <#application.rbs.setting.siteEmailAddress#>",
			    template="/email/bookingNotify",
			    subject="Room Booking Notification (#event.status#)",
			    event=arguments.event
			);
		}
	}

	/**
	*  @hint Event CRUD
	*/
	public void function update() {
		if(structkeyexists(params, "event")){

	    	event = model("event").findOne(where="id = #params.key#", include="eventresources");
			event.update(params.event);

			if ( event.save() )  {

				if(structKeyExists(params, "customfields")){
					customfields=updateCustomFields(objectname=request.modeltype, key=event.key(), customfields=params.customfields);
				}
				redirectTo(action="index", success="event successfully updated");
			}
	        else { 
				customfields=getCustomFields(objectname=request.modeltype, key=params.key);
				renderPage(action="edit", error="There were problems updating that event"); 
			}
		}
	}

	/**
	*  @hint Event CRUD
	*/
	public void function delete() {
    	event = model("event").findOne(where="id = #params.key#", include="eventresources");
		if ( event.delete() )  {
			redirectTo(action="index", success="event successfully deleted");
		}
        else {
			redirectTo(action="index", error="There were problems deleting that event");
		}
	}
/******************** Private *********************/
	 


	/**
	*  @hint Sets the model type to use with Custom Fields + Templates
	*/
	public void function _setModelType() {
		request.modeltype="event";
	}

	/**
	*  @hint Remote concurrency Check: gets all events for that day for that location and then narrows it down again.
	*/
	public void function check() {
		if(structKeyExists(params, "start")
			AND structKeyExists(params, "end")
			AND structKeyExists(params, "location")
			AND structKeyExists(params, "id")){
  		params.excludeeventid=params.id;
  		var loc={};
  			// get all for that day, including infinite repeats, excluding the current event if editing
  			loc.events=getEventsForRange(excludestatus="denied", start=dateFormat(params.start, "YYYY-MM-DD"), end=dateFormat(params.end, "YYYY-MM-DD") & " 23:59");
  			// generate repeats etc
  			loc.eventsArray=parseEventsForCalendar(events=getEventsForRange(), viewPortStartDate=dateFormat(params.start, "YYYY-MM-DD"), viewPortEndDate=end=dateFormat(params.end, "YYYY-MM-DD") & " 23:59"); 
  	 		
			eCheck=[]; 
  	 		for(potentialClash in loc.eventsArray){
  	 			var allow=0; 
  	 			if(len(potentialClash.type)){
  	 				if(isTimeClash(start1=params.start,end1=params.end,start2=potentialClash.repeat.start,end2=potentialClash.repeat.end)){
  	 					 allow=1
  	 				} 
  	 			} else {
  	 				if(isTimeClash(start1=params.start,end1=params.end,start2=potentialClash.start,end2=potentialClash.end)){
  	 					allow=1 
  	 				}  
  	 			}
	  	 		// Skip All Day events if in settings 
  	 			if(!application.rbs.setting.includeAllDayEventsinConcurrency && potentialClash.allDay){
  	 				allow=0;
  	 			}
  	 			if(allow){
  	 				arrayAppend(eCheck, potentialClash); 
  	 			}
  	 		}  
		}
	}

}