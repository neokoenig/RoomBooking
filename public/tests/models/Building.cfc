component extends="tests.Test" {

	function setup() {

	  // create an instance of our model
	  building = model("building").new();
	    properties = {
	      title="Test Building"
	  	};
	}
	function teardown() {}

	function Test_building_passes_validation(){
		building.setProperties(properties);
		building.valid();
	    actual = building.allErrors();
	    assert("!arraylen(actual)");
	}

	function Test_building_sets_default_icon(){
		building.setProperties(properties);
	    assert("building.icon EQ 'fa-building'");
	}

	function Test_building_inherits_timezone_if_not_set(){
		building.setProperties(properties);
	    assert("building.timezone EQ 'Europe/London'");
	}
}
