component extends="tests.Test" {

	function setup() {
		_params={"controller"="","action"=""};
		_controller=controller(name="controller", params=_params);
	}
	function teardown() {

	}

	function Test_getDefaultPermissionString_without_returns_empty(){
		_params={"controller"="","action"=""};
		_controller=controller(name="controller", params=_params);
		r=_controller.getDefaultPermissionString();
		assert("len(r) EQ 0");
	}

	function Test_getDefaultPermissionString_with_simple_controller_string(){
		_params={"controller"="Test","action"=""};
		_controller=controller(name="controller", params=_params);
		r=_controller.getDefaultPermissionString();
		//debug("r");
		assert("len(r) EQ 4");
	}
	function Test_getDefaultPermissionString_with_dotted_controller_string(){
		_params={"controller"="Test.Test","action"=""};
		_controller=controller(name="controller", params=_params);
		r=_controller.getDefaultPermissionString();
		//debug("r");
		assert("len(r) EQ 9");
	}
	function Test_getDefaultPermissionString_with_simple_controller_with_action(){
		_params={"controller"="Test","action"="Foo"};
		_controller=controller(name="controller", params=_params);
		r=_controller.getDefaultPermissionString();
		//debug("r");
		assert("len(r) EQ 8");
	}
	function Test_getDefaultPermissionString_with_dotted_controller_with_action(){
		_params={"controller"="Test.Foo","action"="Bar"};
		_controller=controller(name="controller", params=_params);
		r=_controller.getDefaultPermissionString();
		//debug("r");
		assert("len(r) EQ 12");
	}
	function Test_getPermissionArr_with_simple_string(){
		r=_controller.getPermissionArr("Test");
		//debug("r");
		assert("arraylen(r) EQ 1");
		assert("r[1] EQ 'test'");
	}
	function Test_getPermissionArr_with_dotted_string2(){
		r=_controller.getPermissionArr("Test.Test");
		//debug("r");
		assert("arraylen(r) EQ 2");
		assert("r[1] EQ 'test'");
		assert("r[2] EQ 'test.test'");
	}
	function Test_getPermissionArr_with_dotted_string3(){
		r=_controller.getPermissionArr("Test.Foo.Bar");
		//debug("r");
		assert("arraylen(r) EQ 3");
		assert("r[1] EQ 'test'");
		assert("r[2] EQ 'test.foo'");
		assert("r[3] EQ 'test.foo.bar'");

	}
	function Test_getPermissionArr_with_dotted_string4(){
		r=_controller.getPermissionArr("Test.Foo.bar.poi");
		//debug("r");
		assert("arraylen(r) EQ 4");
		assert("r[1] EQ 'test'");
		assert("r[2] EQ 'test.foo'");
		assert("r[3] EQ 'test.foo.bar'");
		assert("r[4] EQ 'test.foo.bar.poi'");

	}
	function Test_hasPermission_with_admin(){
		r=_controller.hasPermission("admin");
		debug("r");
		//assert("arraylen(r) EQ 1");
		//assert("r[1] EQ 'test'");
	}
	function Test_hasPermission_with_admin_admin(){
		r=_controller.hasPermission("admin.admin");
		debug("r");
		//assert("arraylen(r) EQ 2");
		//assert("r[1] EQ 'test'");
		//assert("r[2] EQ 'test'");
	}
	function Test_hasPermission_with_admin_calendar_index(){
		r=_controller.hasPermission("admin.calendar.index");
		debug("r");
		//assert("arraylen(r) EQ 3");
		//assert("r[1] EQ 'test'");
	}
	function Test_hasPermission_with_ifail(){
		r=_controller.hasPermission("ifail");
		assert("r EQ false");
	}
}
