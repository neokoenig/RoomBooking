component extends="tests.Test" {

	function setup() {}
	function teardown() {}

	function Test_Countries_Exist(){
		countries=model("countries").findAll();
		assert("countries.recordcount GT 1");
	}
}
