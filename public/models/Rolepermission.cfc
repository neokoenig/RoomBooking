component extends="Model"
{
	function init() {
		belongsTo("role");
		belongsTo("permission");
	}
}
