component extends="tests.Test" {

	function setup(){
	}

	function teardown(){

	}

	function Test_Quick_Test(){
		_params = {
			controller="v1",
			action="test"
		};
		_controller = controller(name="api.v1", params=_params);
		actual=_controller.test();
		expected="Hello World";
		assert("actual eq expected");
		debug("actual");
	}
}
