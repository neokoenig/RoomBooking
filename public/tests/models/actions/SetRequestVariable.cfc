component extends="tests.Test" {

	function setup() {
		if(structKeyExists(request, "testvar")){
			structDelete(request, "testvar");
		}
		_model=model("actions.setrequestvariable").new();
	}
	function teardown() {
		if(structKeyExists(request, "testvar")){
			structDelete(request, "testvar");
		}
	}

	function Test_New_Model_Sets_Default(){
		r=_model.properties();
		assert("structKeyExists(r, 'name')");
		assert("structKeyExists(r, 'to')");
		assert("r.name EQ 'testvar'");
		assert("r.to EQ 'Foo'");
	}
	function Test_Set_Request_Variable(){
		_model.save();
		assert("structKeyExists(request, 'testvar') EQ true");
		assert("request.testvar EQ 'Foo' ");
	}

}
