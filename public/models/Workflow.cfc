component extends="Model"
{
	function init() {
		// Inherit Triggers
		super.init();
		// Associations
		hasMany(name="workflowtriggers", jointype="left");
		nestedproperties(associations="workflowtriggers", allowdelete=true);

		property(name="isactive", defaultValue=0);
		validatesPresenceOf(properties="title");
	}
}
