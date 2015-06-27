//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Controller" hint="Settings Controller"
{
	/**
	 * @hint Constructor.
	 */
	public void function init() {
		// Permission filters
		super.init();
		filters(through="checkPermissionAndRedirect", permission="accessSettings");
		filters(through="_checkSettingsAdmin");
		filters(through="denyInDemoMode", only="edit,update");

		// Verification
		verifies(only="edit,update", params="key", paramsTypes="string", route="home", error="Sorry, that setting can't be found");


		// Data
		filters(through="_getSettings");
	}

/******************** Public***********************/
	/**
	*  @hint Edit a setting
	*/
	public void function edit() {
		setting=model("setting").findOne(where="id = '#params.key#'");
		if(!isObject(setting) OR !setting.Editable OR application.rbs.setting.isDemoMode){
			redirectTo(back=true, error="Sorry, that setting can't be found, isn't editable or the board is in demo mode");
		}
	}

	/**
	*  @hint Update a setting
	*/
	public void function update() {
		if(structkeyexists(params, "setting")){
	    	setting = model("setting").findOne(where="id = '#params.key#'");
	    	if(!isObject(setting) OR !setting.Editable OR application.rbs.setting.isDemoMode){
	    		redirectTo(back=true, error="Sorry, that setting can't be found, isn't editable or the board is in demo mode");
	    	} else {
				setting.update(params.setting);
				if ( setting.save() )  {
					redirectTo(action="index", success="Setting successfully updated - please note you will need to reload the application for this to take effect");
				}
		        else {
					renderPage(action="edit", error="There were problems updating that setting");
				}
	    	}
		}
	}

/******************** Private *********************/
	/**
	*  @hint
	*/
	private void function _checkSettingsAdmin() {
		if(!application.rbs.setting.allowSettings){
			redirectTo(route="home", error="Facility to edit settings has been disabled");
		}
	}

}