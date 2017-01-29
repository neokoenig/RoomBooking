component extends="Model"
{
	function init() {
		// Inherit Triggers
		super.init();
		// Associations
		hasMany(name="rolepermissions");
	}
}
