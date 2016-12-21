component extends="Model"
{
	function init() {
		belongsTo("user");
		belongsTo("permission");
	}
}
