component extends="Model"
{
	function init() {
		// Inherit Triggers
		super.init();
		// Associations
		belongsTo(name="building");
		belongsTo(name="room");
	}
}
