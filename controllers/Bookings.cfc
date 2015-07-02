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
		param name="params.datefrom" default="#dateFormat(now(), 'DD MMM YYYY')#";
		param name="params.dateto" 	 default="#dateFormat(dateAdd('m', 1, now()), 'DD MMM YYYY')#";
		param name="params.location" default="";
		param name="params.q"		 default="";
		events=model("location").findAll(where="#_agendaListWC()#", include="events", order="start");
	}

	/**
	*  @hint Alternative Day View: deprecated in 1.2
	*/
	public void function day() {
		param name="params.y" default=year(now());
		param name="params.m" default=month(now());
		param name="params.d" default=day(now());

		var slotMin=application.rbs.setting.calendarSlotMinutes;
		var calStart=application.rbs.setting.calendarMinTime;
		var calEnd=application.rbs.setting.calendarMaxTime;

		events=model("event").findAll(where="#_dayListWC()#", order="start", include="location");
		allDay=model("event").findAll(where="#_dayListWC(allday=1)#", order="start", include="location");

		day={
			thedate=createDate(params.y, params.m, params.d),
			starttime=createDateTime(params.y, params.m, params.d, timeFormat(calStart, 'H'),timeFormat(calStart, 'M'),0),
			endtime=createDateTime(params.y, params.m, params.d, timeFormat(calEnd, 'H'),timeFormat(calEnd, 'M'),0)
		};
		day.yesterday=dateAdd("d", -1, day.thedate);
		day.tomorrow=dateAdd("d", 	1, day.thedate);
		// Placeholder arrays
		m=[];
		e=[];
		tempid=0;

		for(location in locations){
			day.counter=day.starttime;
			do {
				t={
					timeslot=createDateTime(year(day.thedate), month(day.thedate), day(day.thedate), TimeFormat(day.counter, "H"), TimeFormat(day.counter, "m"), 0)
				};
			    eventsQ = new Query();
			    eventsQ.setDBType('query');
			    eventsQ.setAttributes(rs=events); // needed for QoQ
			    eventsQ.addParam(name='locationid', value=location.id, cfsqltype='cf_sql_numeric');
			    eventsQ.addParam(name='start', value=t.timeslot, cfsqltype='cf_sql_timestamp');
			    eventsQ.addParam(name='end', value=t.timeslot, cfsqltype='cf_sql_timestamp');
			    eventsQ.setSQL('SELECT * FROM rs WHERE locationid =:locationid AND start <= :start AND [end] > :end AND allday = 0');
			    locationEvents = eventsQ.execute().getResult();
 				if(locationEvents.recordcount){
					 if(tempid NEQ locationEvents.id){
					 	// Check for multiday event
					 	if(day(locationEvents.start) != day(locationEvents.end)){
					 		t.isMultiday=true;
					 	} else {
					 		t.isMultiday=false;
					 	}
					 	// Check for multiday event with specific end time
					 	if(t.isMultiday	AND	(day(day.thedate) EQ day(locationEvents.end))){
					 		t.duration=DateDiff("n", t.timeslot, locationEvents.end);
					 	} else if(t.isMultiday AND (day(day.thedate) EQ day(locationEvents.start))) {
							t.duration=DateDiff("n",day.thedate, locationEvents.start);
					 	} else {
					 		t.duration=DateDiff("n", locationEvents.start, locationEvents.end);
					 	}
					 	// Set rowspan dependent on duration
						t.rowspan=ceiling(t.duration / timeFormat(SlotMin, 'M'));
						t.content="<strong>"
						& linkTo( class="remote-modal", route='getEvent',  key=locationEvents.id, text=h(locationEvents.title))
						& "</strong><br />"
						& h(locationEvents.name) & "<br />";
						if(t.isMultiday){
							t.content=t.content & "Multiday event";
						} else {
							t.content=t.content & "#timeFormat(locationEvents.start, "HH:MM")# - #timeFormat(locationEvents.end, "HH:MM")# "
									& _durationString(t.duration);
						}
						t.class="booked first #location.class# #locationEvents.status#";
						if(locationEvents.recordcount GT 1) {
							t.content=t.content & "<br /><span class='label label-danger'><i class='glyphicon glyphicon-warning-sign'></i> Overlapping Event!</span>";
						}
					 } else {
						// Subsequent cells
						t.content="";
						t.class="booked #location.class#";
						t.rowspan=0;
					}
					tempid=locationEvents.id;
				}
				else {
					// Empty Cell
					t.class="free";
					t.content="";
					t.rowspan=1;
				}
				arrayAppend(e, t);
				day.counter = dateAdd('n',15,day.counter);
				// end nested loop
			} while(day.counter LTE day.endtime);

		arrayAppend(m, e);
		e=[];
		// end location loop
		}
	}

/******************** Admin ***********************/
	/**
	*  @hint Add a new booking
	*/
	public void function add() {
		 nEventResources=model("eventresource").new();
    	 event=model("event").new(eventresources=nEventResources);
    	 customfields=getCustomFields(objectname="event", key=event.key());
    	 // Listen out for event date & location passed in URL via JS
    	 if(structKeyExists(params, "d")){
    	 	qDate=createDateTime(listFirst(params.d, '-'),ListGetAt(params.d, 2, '-'),ListGetAt(params.d, 3, '-'),hour(now()),00,00);
    	 	event.start=dateFormat(qDate, "DD MMM YYYY") & ' ' & timeFormat(qDate, "HH:mm");
    	 }
    	 if(structKeyExists(params, "key") AND isNumeric(params.key)){
    	 	event.locationid=params.key;
    	}
	}

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
	*  @hint Event CRUD
	*/
	public void function create() {
		if(structkeyexists(params, "event")){
	    	event = model("event").new(params.event);
			if ( event.save() ) {
				// Update approval status if allowed to bypass
				if(application.rbs.setting.approveBooking AND checkPermission("bypassApproveBooking")){
					event.status="approved";
					event.save();
				}

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
						// Save the child event: NB, repeated events can't/don't save customfield metadata
						nevent.save();
					}
				}
				// Send Confirmation email if appropriate
				if(structKeyExists(params.event, "emailContact") AND params.event.emailContact){
					notifyContact(event);
				}
				redirectTo(action="index", success="Event successfully created");
			}
	        else {
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
	*  @hint Conditional Where Clause for Day Listing: deprecated in 1.2
	*/
	private string function _dayListWC(numeric allday="0") {
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
	}

	/**
	*  @hint Custom Q for List view
	*/
	private string function _agendaListWC() {
		var sd="";
	 		var td="";
			var wc=[];
			// Date Filter
			if(structKeyExists(params, "datefrom")
				AND structKeyExists(params, "dateto")
				){
					sd=createDateTime(year(params.datefrom), month(params.datefrom), day(params.datefrom), 00,00,00);
					td=createDateTime(year(params.dateto), month(params.dateto), day(params.dateto), 23,59,59);
					arrayAppend(wc, "start > '#sd#'");
					arrayAppend(wc, "start < '#td#'");
			}
			// Status Filter
			if(structKeyExists(params, "status") AND len(params.status)){
				arrayAppend(wc, "status = '#params.status#'");
			}

			// Location Filter
			if(structKeyExists(params, "location") AND len(params.location)){
				arrayAppend(wc, "FIND_IN_SET(locationid, '#params.location#')");
			}

			// Keyword filter
			if(structKeyExists(params, "q") AND len(params.q)){
				params.q=striptags(params.q);
				arrayAppend(wc, "title LIKE '%#params.q#%' OR description LIKE '%#params.q#%'");

			}

			if(arrayLen(wc)){
				return arrayToList(wc, " AND ");
			} else {
				return "";
			}

	}


	/**
	*  @hint Sets the model type to use with Custom Fields + Templates
	*/
	public void function _setModelType() {
		request.modeltype="event";
	}

	/**
	*  @hint Remote concurrency Check
	*/
	public void function check() {
		if(structKeyExists(params, "start")
			AND structKeyExists(params, "end")
			AND structKeyExists(params, "location")
			AND structKeyExists(params, "id")){
			// We need to check for any events which overlap with the requested timerange
			// If editing, check we don't bring up the actual event
			// Don't register denied events
			if(len(params.id)){
				eCheck=model("event").findAll(where="status != 'denied' AND id != #params.id# AND start <= '#params.start#' AND end >= '#params.start#' AND locationid = #params.location#");
			} else {
				eCheck=model("event").findAll(where="status != 'denied' AND start <= '#params.start#' AND end >= '#params.start#' AND locationid = #params.location#");
			}

		}
	}

}