//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Controller" hint="Misc Event Data"
{
	/*
	 * @hint Constructor.
	 */
	public void function init() {
		super.init();

		// Additional Permissions
		filters(through="checkPermissionAndRedirect", permission="accesscalendar");
		filters(through="_isValidAjax");

		// Data
		filters(through="_getResources", only="getevent");

		// Verification
		verifies(only="getevent", params="key", paramsTypes="integer", route="home", error="Sorry, that event can't be found");

		// Formats
		provides("html,json");
		usesLayout(template="modal", only="getevent");
		filters(through="_setModelType");
	}

//=====================================================================
//= 	Public
//=====================================================================
	/*
	 * @hint Get Events For the provided range via ajax
	*/
	public void function getevents() {
		param name="params.start" 	default="#now()#";
		param name="params.end" 	default="#dateAdd("ww", 6, now())#";
    	renderWith(parseEventsForCalendar(getEventsForRange(), params.start, params.end));
	}

	/*
	 * @hint get single event via ajax, i.e for modals
	*/
	public void function getevent() {
	 	event=model("location").findAll(where="events.id = #params.key#", include="events(eventresources)");
	}

 	/*
	* @hint Sets the model type to use with Custom Fields + Templates
	*/
	private void function _setModelType() {
		request.modeltype="event";
	}


}
