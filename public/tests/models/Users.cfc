component extends="tests.Test" {

	function setup() {
	  // create an instance of our model
	  user = model("user").new();

	  // a structure containing some default properties for the model
	  properties = {
	      firstname="Hugh",
	      lastname="Dunnit",
	      email="hugh@example.com",
	      password="foobar",
	      passwordConfirmation="foobar"
	  };
	}

	function teardown(){

	}

	function test_should_have_default_roleid_of_0(){
	   user.setProperties({});
	   assert("structKeyExists(user, 'roleid')");
	   assert("user.roleid == 0");
	}

	function test_should_fail_without_firstname(){
	   user.setProperties({});
	   user.valid();
	   actual = user.allErrors()[1].message;
	   expected= "Firstname can't be empty";
	   assert("actual EQ expected");

	}

	function test_should_fail_without_Lastname(){
	   user.setProperties({});
	   user.valid();
	   actual = user.allErrors()[2].message;
	   expected= "Lastname can't be empty";
	   assert("actual EQ expected");
	}

	function test_should_fail_without_email(){
	   user.setProperties({});
	   user.valid();
	   actual = user.allErrors()[3].message;
	   expected= "Email can't be empty";
	   assert("actual EQ expected");
	}

	function test_requires_confirmation_if_password_present(){
	   user.setProperties(properties);
	   user.valid();
	   assert("structKeyExists(user, 'passwordconfirmation')");
	   assert("user.passwordconfirmation == 'foobar'");
	}

	function test_fails_confirmation_if_password_present(){
	   user.setProperties({password: "foo", passwordConfirmation: "NOTMATCHING"});
	   user.valid();
	   actual = user.allErrors()[8].message;
	   expected= "Password should match confirmation";
	   assert("actual EQ expected");
	}
}
