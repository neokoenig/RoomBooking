component extends="tests.Test" {

	function setup() {}
	function teardown() {}

	function Test_Returns_Default_Language(){
		assert("len(request.lang.current)");
	}

	function Test_Trim_Scope(){
		testScope={
			"foo": "bar",
			"foo2": " bar",
			"foo3": "bar  "
		}
		testScope["sub"]={
			"foo4" : " bar ",
			"foo5" : {
				"foo6": " bar"
			}
		}
		testScope=trimScope(testScope);
		assert("len(testscope.foo) == 3");
		assert("len(testscope.foo2) == 3");
		assert("len(testscope.foo3) == 3");
		assert("len(testscope.sub.foo4) == 3");
		assert("len(testscope.sub.foo5.foo6) == 3");
	}

	function Test_get_ip_address(){
		actual=getIPAddress();
		// Test might fail on mac?
		assert("actual != '0.0.0.0'");
	}
}
