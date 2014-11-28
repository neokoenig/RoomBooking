<!---================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Wheels" hint="Global Controller"
{
	/**
	 * @hint Constructor.
	 */
	public void function init() {
		// Deny everything by default
		filters(through="checkPermissionAndRedirect", permission="accessapplication");
		// Log everything by default
		filters(through="logFlash", type="after");
	}

/******************** Global Filters***********************/
 	/**
 	*  @hint Return all room locations
 	*/
 	public void function _getLocations() {
 		locations=model("location").findAll(order="name");
 	}

 	/**
 	*  @hint Return all settings
 	*/
 	public void function _getSettings() {
 		settings=model("setting").findAll(order="category,id");
 	}

 	/**
 	*  @hint Return All Resources
 	*/
 	public void function _getResources() {
 		resources=model("resource").findAll(order="type,name");
 	}

 	/**
 	*  @hint Check is valid ajax request in filter
 	*/
 	public void function _isValidAjax() {
 		if(!isAjax()){
 			abort;
 		}
 	}
}