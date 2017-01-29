component extends="tests.Test" {

	function setup() {
	}
	function teardown() {

	}

	function Test_Get_Actions(){
		r=getAvailableActions();
		assert("arrayFind(r.components, 'TestAction.cfc')");
		assert("arrayFind(r.actions, 'TestAction')");
		//debug("r");
	}

	function Test_Init_Returns_Required_Properties(){
		r=model("Actions.TestAction").new();
		//debug("r.properties()");
		assert("structKeyExists(r, 'email')");
		assert("structKeyExists(r, 'name')");
	}
}
