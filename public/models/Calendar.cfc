component extends="Model"
{
	function init() {
		belongsTo("user");
		hasMany("bookings");
		hasMany("calendarbuildings");
		hasMany("calendarrooms");
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
