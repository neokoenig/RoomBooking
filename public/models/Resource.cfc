component extends="Model"
{
	function init() {
		belongsTo("building");
		belongsTo("room");
	}
}
