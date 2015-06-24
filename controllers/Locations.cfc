//================= Room Booking System / https://github.com/neokoenig =======================--->
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
		filters(through="checkPermissionAndRedirect", permission="accessLocations", except="list,view");
		filters(through="checkPermissionAndRedirect", permission="accessCalendar", except="list,view");
		filters(through="_setModelType");
		// Data
		filters(through="_getLocations", only="index,list");

		// Verification
		verifies(only="view,edit,update,delete", params="key", paramsTypes="integer", route="home", error="Sorry, that event can't be found");

	}

/******************** Admin ***********************/
	/**
	*  @hint Public Location List
	*/
	public void function list() {
	}

	/**
	*  @hint
	*/
	public void function view() {
		location=model("location").findOne(where="id = #params.key#");
		customfields=getCustomFields(objectname=request.modeltype, key=location.key());
	}
/******************** Admin ***********************/
	/**
	*  @hint Add Location
	*/
	public void function add() {
		location=model("location").new();
		customfields=getCustomFields(objectname=request.modeltype, key=location.key());
	}

	/**
	*  @hint Create Location
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
	*  @hint Edit  Location
	*/
	public void function edit() {
		location=model("location").findOne(where="id = #params.key#");
		request.modeltype="location";
		customfields=getCustomFields(objectname=request.modeltype, key=params.key);

	}

	/**
	*  @hint Update Location
	*/
	public void function update() {
		if(structkeyexists(params, "location")){
	    	location = model("location").findOne(where="id = #params.key#");
			location.update(params.location);
			if ( location.save() )  {
				if(structkeyexists(params, "customfields")){
					customfields=updateCustomFields(objectname="location", key=params.key, customfields=params.customfields);
				}
				redirectTo(action="index", success="Location successfully updated");
			}
	        else {
				renderPage(action="edit", error="There were problems updating that Location");
			}
		}
	}

	/**
	*  @hint Delete Location
	*/
	public void function delete() {
		checkLocation=model("location").findAll();
		if(checkLocation.recordcount GT 1){
		 if(structkeyexists(params, "key")){
		    	location = model("location").findOne(where="id = #params.key#");
				if ( location.delete() )  {
					redirectTo(action="index", success="Location successfully deleted");
				}
		        else {
					redirectTo(action="index", error="There were problems deleting that Location");
				}
			}
		} else {
 			redirectTo(action="index", error="At least one Location is required.");
		}
	}
/******************** Private *********************/
	/**
	*  @hint Whether to allow access
	*/
	public void function f_checkLocationsAdmin() {
		if(!application.rbs.setting.allowLocations){
			redirectTo(route="home", error="Facility to edit Locations has been disabled");
		}
	}

	/**
	*  @hint Sets the model type to use with Custom Fields + Templates
	*/
	public void function _setModelType() {
		request.modeltype="location";
	}
}