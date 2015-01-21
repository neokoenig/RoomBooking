<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfscript>
	try{
		_loadSettings();
	} catch(any){
		throw message="Could not load settings - please check your datasource";
	}

	/**
	*  @hint Load Application Settings
	*/
	public void function _loadSettings() {
	 	// Application Specific settings
		if(structKeyExists(application, "rbs")){
			structDelete(application, "rbs");
		}

		application.rbs={};
		application.rbs.setting={};
		application.rbs.permission={};

		application.rbs.roles="admin,editor,user,guest";

		for(setting in model("setting").findAll()){
			application.rbs.setting['#setting.id#']=setting.value;
		}

		for(permission in model("permission").findAll()){

			application.rbs.permission["#permission.id#"]={};
			for(role in listToArray(application.rbs.roles)){
				application.rbs.permission["#permission.id#"]["#role#"]=permission["#role#"];
			}
		}
	}

</cfscript>
