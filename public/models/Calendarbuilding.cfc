component extends="Model"
{
	function init() {
		// Associations
		belongsTo(name="calendar");
		belongsTo(name="building");
	}
}
