component extends="Model"
{
	function init() {
		// Inherit Triggers
		super.init();
		// Associations
		belongsTo(name="role");
		belongsTo(name="permission");
	}
}
