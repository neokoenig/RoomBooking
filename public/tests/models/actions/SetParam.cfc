component extends="tests.Test" {

	function setup() {
		_model=model("actions.setparam").new();
	}
	function teardown() {
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
		assert("structKeyExists(request.wheels.params, 'testvar') EQ true");
		assert("request.wheels.params.testvar EQ 'Foo' ");
	}
	function Test_Honours_Nested(){
		_prop={
			"name": "bish.bash",
			"to": "bosh"
		}
		_model.setProperties(_prop);
		_model.save();
		//debug("request.wheels.params");
		assert("structKeyExists(request.wheels.params, 'bish.bash') NEQ true");
		assert("structKeyExists(request.wheels.params, 'bish') EQ true");
		assert("structKeyExists(request.wheels.params.bish, 'bash') EQ true");
	}
	function Test_Honours_Nested_with_Other_Keys(){
		//debug("request.wheels.params");
		request.wheels.params["bish"]["foo"]="bar";
		_prop={
			"name": "bish.bash",
			"to": "foobar"
		}
		_model.setProperties(_prop);
		_model.save();
		//debug("request.wheels.params");
		assert("structKeyExists(request.wheels.params, 'bish.bash') NEQ true");
		assert("structKeyExists(request.wheels.params, 'bish') EQ true");
		assert("structKeyExists(request.wheels.params.bish, 'bash') EQ true");
		assert("structKeyExists(request.wheels.params.bish, 'foo') EQ true");
	}
}
