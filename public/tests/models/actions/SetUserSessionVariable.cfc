component extends="tests.Test" {

	function setup() {
		if(structKeyExists(session.user.properties, "testvar")){
			structDelete(session.user.properties, "testvar");
		}
		_model=model("actions.setusersessionvariable").new();
	}
	function teardown() {
		if(structKeyExists(session.user.properties, "testvar")){
			structDelete(session.user.properties, "testvar");
		}
	}

	function Test_New_Model_Sets_Default(){
		r=_model.properties();
		assert("structKeyExists(r, 'name')");
		assert("structKeyExists(r, 'to')");
		assert("r.name EQ 'testvar'");
		assert("r.to EQ 'Foo'");
	}
	function Test_Set_User_Property_in_Session(){
		_model.save();
		assert("structKeyExists(session.user.properties, 'testvar') EQ true");
		assert("session.user.properties.testvar EQ 'Foo' ");
	}

}
