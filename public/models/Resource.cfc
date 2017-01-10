component extends="Model"
{
	function init() {
		// Associations
		belongsTo(name="building");
		belongsTo(name="room");
	}
}
