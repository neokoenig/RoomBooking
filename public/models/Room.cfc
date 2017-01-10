component extends="Model"
{
	function init() {
		// Associations
		belongsTo(name="building", joinType="left");
		belongsTo(name="user");
		hasMany(name="calendarrooms");

		property(name="icon", defaultValue="fa-square-o");
		property(name="floor", defaultValue=0);
		property(name="allowconcurrent", defaultValue=1);
		property(name="timezone", defaultValue=application.rbs.settings.i8n_defaultTimeZone);
		afterFind("checkForDefaults");
		validatesPresenceOf(properties="title");
	}

	function checkForDefaults(){
		if(structKeyExists(arguments, "icon") && !len(arguments.icon)){
			arguments.icon="fa-square-o";
		}
		if(structKeyExists(arguments, "floor") && !len(arguments.floor)){
			arguments.floor=0;
		}
		return arguments;
	}
}
