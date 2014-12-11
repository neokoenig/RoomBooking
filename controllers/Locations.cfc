<!---================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Controller" hint="Locations Controller"
{
	/**
	 * @hint Constructor.
	 */
	public void function init() {
		// Permission filters
		super.init();

		// Permissions
		filters(through="f_checkLocationsAdmin");
		filters(through="checkPermissionAndRedirect", permission="accessLocations");

		// Data
		filters(through="_getLocations", only="index");
	}

/******************** Admin ***********************/
	/**
	*  @hint
	*/
	public void function add() {
		location=model("location").new();
	}

	/**
	*  @hint
	*/
	public void function create() {
		if(structkeyexists(params, "location")){
	    	location = model("location").new(params.location);
			if ( location.save() ) {
				redirectTo(action="index", success="location successfully created");
			}
	        else {
				renderPage(action="add", error="There were problems creating that location");
			}
		}
	}

	/**
	*  @hint
	*/
	public void function edit() {
		location=model("location").findOne(where="id = #params.key#");
	}

	/**
	*  @hint
	*/
	public void function update() {
		if(structkeyexists(params, "location")){
	    	location = model("location").findOne(where="id = #params.key#");
			location.update(params.location);
			if ( location.save() )  {
				redirectTo(action="index", success="location successfully updated");
			}
	        else {
				renderPage(action="edit", error="There were problems updating that location");
			}
		}
	}

	/**
	*  @hint
	*/
	public void function delete() {
		checkLocation=model("location").findAll();
		if(checkLocation.recordcount GT 1){
		 if(structkeyexists(params, "key")){
		    	location = model("location").findOne(where="id = #params.key#");
				if ( location.delete() )  {
					redirectTo(action="index", success="location successfully deleted");
				}
		        else {
					redirectTo(action="index", error="There were problems deleting that location");
				}
			}
		} else {
 			redirectTo(action="index", error="At least one location is required.");
		}
	}
/******************** Private *********************/
	/**
	*  @hint Whether to allow access
	*/
	public void function f_checkLocationsAdmin() {
		if(!application.rbs.setting.allowLocations){
			redirectTo(route="home", error="Facility to edit locations has been disabled");
		}
	}

}