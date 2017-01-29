component extends="Model"
{
	function init() {
		// Inherit Triggers
		super.init();
		// Associations
		belongsTo(name="user");
		belongsTo(name="permission");
	}
}
