component extends="Model"
{
	function init() {
		hasMany("rolepermissions");
		hasMany("userpermissions");
	}
}
