component extends="Model"
{
	function init() {
		// Inherit Triggers
		super.init();
		// Associations
		hasMany(name="rolepermissions");
		hasMany(name="userpermissions");
		nestedProperties(associations="rolepermissions,userpermissions", allowDelete=true);
	}
}
