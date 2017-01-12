component extends="Model"
{
	function init() {
		// Associations
		hasMany(name="rolepermissions");
		hasMany(name="userpermissions");
		nestedProperties(associations="rolepermissions,userpermissions", allowDelete=true);
	}
}
