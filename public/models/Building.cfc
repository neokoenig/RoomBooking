component extends="Model"
{
	function init() {
		// Associations
		hasMany(name="rooms");
		belongsTo(name="user");
		hasMany(name="calendarbuildings");

		property(name="icon", defaultValue="fa-building");
		property(name="timezone", defaultValue=application.rbs.settings.i8n_defaultTimeZone);
		afterFind("checkForIcon");
		validatesPresenceOf(properties="title");
	}

	function checkForIcon(){
		if(structKeyExists(arguments, "icon") && !len(arguments.icon)){
			arguments.icon="fa-building";
		}
		return arguments;
	}
}
