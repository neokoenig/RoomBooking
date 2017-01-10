component extends="Model"
{
	function init() {
		// Associations
		belongsTo(name="user");
		belongsTo(name="permission");
	}
}
