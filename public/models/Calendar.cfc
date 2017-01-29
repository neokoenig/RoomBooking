component extends="Model"
{
	function init() {
		// Inherit Triggers
		super.init();
		// Associations
		belongsTo(name="user");
		hasMany(name="bookings");
		hasMany(name="calendarbuildings");
		hasMany(name="calendarrooms");
		hasMany(name="calendarsettings");
		nestedProperties(associations="calendarrooms,calendarbuildings", allowDelete=true);

		property(name="icon", defaultValue="fa-calendar");
		afterFind("checkForIcon");
		validatesPresenceOf(properties="title");
	}

	function checkForIcon(){
		if(structKeyExists(arguments, "icon") && !len(arguments.icon)){
			arguments.icon="fa-calendar";
		}
		return arguments;
	}
}
