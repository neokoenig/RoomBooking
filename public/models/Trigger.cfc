component extends="Model"
{
	function init() {
		// Inherit Triggers
		super.init();
		// Associations
		hasMany(name="workflowtriggers", jointype="left");
		hasMany(name="triggeractions", jointype="left");
		nestedProperties(name="triggeractions", allowDelete=true);

		validatesPresenceOf(properties="title,triggeron,triggertype,triggerwhen");
	}
}
