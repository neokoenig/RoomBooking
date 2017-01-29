component extends="tests.Test" {

	function setup() {
		_params = {
	    route="adminUsers",
	    controller="admin.users",
	    action="index"
	  };
		_controller=controller(name="controller", params=_params);
	}
	function teardown() {}

	function Test_Trigger(){
		//_controller.logTrigger(name="foo");
		//debug("request.triggers");
	}
}
