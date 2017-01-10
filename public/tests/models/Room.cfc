component extends="tests.Test" {

	function setup() {

	  // create an instance of our model
	  room = model("room").new();
	    properties = {
	      title="Test Room"
	  	};
	}
	function teardown() {}

	function Test_room_passes_validation(){
		room.setProperties(properties);
		room.valid();
	    actual = room.allErrors();
	    assert("!arraylen(actual)");
	}

	function Test_room_sets_default_icon(){
		room.setProperties(properties);
	    assert("room.icon EQ 'fa-square-o'");
	}
	function Test_room_sets_default_floor(){
		room.setProperties(properties);
	    assert("room.floor EQ 0");
	}
	function Test_room_inherits_timezone_if_not_set(){
		room.setProperties(properties);
	    assert("room.timezone EQ 'Europe/London'");
	}

}
