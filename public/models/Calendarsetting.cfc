component extends="Model"
{
	function init() {
		// Inherit Triggers
		super.init();
		// Associations
		belongsTo(name="calendar");
		belongsTo(name="setting");
	}
}
