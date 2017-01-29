component extends="Model"
{
	function init() {
		// Inherit Triggers
		super.init();
		// Associations
		belongsTo(name="workflow", jointype="left");
		belongsTo(name="trigger", jointype="left");
		belongsTo(name="action", jointype="left");
	}
}
