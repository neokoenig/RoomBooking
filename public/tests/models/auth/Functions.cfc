component extends="tests.Test" {

	function setup() {
	}
	function teardown() {}

	function Test_Returns_Empty_Role_Permissions_if_0(){
		auth=model("auth.Local").new();
		actual=auth.getRolePermissions();
		assert("isStruct(actual)");
		assert("structIsEmpty(actual)");
	}

	function Test_Returns_Role_Permissions(){
		auth=model("auth.Local").new();
		actual=auth.getRolePermissions(1);
		assert("isStruct(actual)");
		assert("!structIsEmpty(actual)");
		//debug("actual");
	}

	function Test_Returns_Empty_User_Permissions_if_0(){
		auth=model("auth.Local").new();
		actual=auth.getUserPermissions();
		assert("isStruct(actual)");
		assert("structIsEmpty(actual)");
	}

	function Test_Returns_User_Permissions(){
		auth=model("auth.Local").new();
		actual=auth.getUserPermissions(1);
		assert("isStruct(actual)");
		assert("!structIsEmpty(actual)");
		//debug("actual");
	}

	function Test_User_Permissions_Override_Role_Permissions(){
		auth=model("auth.Local").new();
		roleP=auth.getRolePermissions(1);
		userP=auth.getUserPermissions(1);
		actual=auth.mergePermissions(rolep,userp);
		assert("isStruct(actual)");
		assert("!structIsEmpty(actual)");
		//debug("actual");
	}
}
