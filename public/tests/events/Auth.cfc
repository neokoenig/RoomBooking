component extends="tests.Test" {


	function setup() {
	}
	function teardown() {
	}

	function Test_getDefaultPermissionString_without_returns_empty(){
		params={"controller"="","action"=""};
		r=getDefaultPermissionString();
		assert("len(r) EQ 0");
	}

	function Test_getDefaultPermissionString_with_simple_controller_string(){
		params={"controller"="Test","action"=""};
		r=getDefaultPermissionString();
		assert("len(r) EQ 4");
	}
	function Test_getDefaultPermissionString_with_dotted_controller_string(){
		params={"controller"="Test.Test","action"=""};
		r=getDefaultPermissionString();
		assert("len(r) EQ 9");
	}
	function Test_getDefaultPermissionString_with_simple_controller_with_action(){
		params={"controller"="Test","action"="Foo"};
		r=getDefaultPermissionString();
		assert("len(r) EQ 8");
	}
	function Test_getDefaultPermissionString_with_dotted_controller_with_action(){
		params={"controller"="Test.Foo","action"="Bar"};
		r=getDefaultPermissionString();
		assert("len(r) EQ 12");
	}
	function Test_getPermissionArr_with_simple_string(){
		r=getPermissionArr("Test");
		assert("arraylen(r) EQ 1");
		assert("r[1] EQ 'test'");
	}
	function Test_getPermissionArr_with_dotted_string2(){
		r=getPermissionArr("Test.Test");
		assert("arraylen(r) EQ 2");
		assert("r[1] EQ 'test'");
		assert("r[2] EQ 'test.test'");
	}
	function Test_getPermissionArr_with_dotted_string3(){
		r=getPermissionArr("Test.Foo.Bar");
		assert("arraylen(r) EQ 3");
		assert("r[1] EQ 'test'");
		assert("r[2] EQ 'test.foo'");
		assert("r[3] EQ 'test.foo.bar'");

	}
	function Test_getPermissionArr_with_dotted_string4(){
		r=getPermissionArr("Test.Foo.bar.poi");
		assert("arraylen(r) EQ 4");
		assert("r[1] EQ 'test'");
		assert("r[2] EQ 'test.foo'");
		assert("r[3] EQ 'test.foo.bar'");
		assert("r[4] EQ 'test.foo.bar.poi'");
	}
	function Test_hasPermission_with_admin(){
		r=hasPermission("admin");
		assert("r EQ true");
	}
	function Test_hasPermission_with_admin_admin(){
		r=hasPermission("admin.admin");
		assert("r EQ true");
	}
	function Test_hasPermission_with_admin_calendar_index(){
		r=hasPermission("admin.calendars.index");
		assert("r EQ true");
	}
	function Test_hasPermission_with_ifail(){
		r=hasPermission("ifail");
		assert("r EQ false");
	}
}
