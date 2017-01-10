component extends="Model"
{
	function init() {
		// Associations
		belongsTo(name="role");
		belongsTo(name="permission");
	}
}
