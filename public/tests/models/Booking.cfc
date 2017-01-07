component extends="tests.Test" {

	function setup() {
		booking=model("booking").new();
		properties={
			"title": "Test Event",
			"startUTC": now(),
			"duration": 30,
			"userid": 1,
			"buildingid": 1,
			"isrepeat": 0,
			"repeatpattern": ""
		}
	}
	function teardown() {}

	function Test_Booking_passes_Validation(){
		booking.setProperties(properties);
		booking.valid();
		actual = booking.allErrors();
	    assert("!arraylen(actual)");
		//debug("actual");
	}
	function Test_Booking_fails_Validation(){
		booking.setProperties({});
		booking.valid();
		actual = booking.allErrors();
	    assert("arraylen(actual)");
		//debug("actual");
	}
	function Test_Booking_startDate_Is_Before_EndDate_Pass(){
		booking.setProperties({
			"title": "Test Event EndDate_Pass",
			"startUTC": now(),
			"endUTC": dateAdd("d", 1, now()),
			"userid": 1,
			"buildingid": 1
		});
		booking.valid();
		actual = booking.allErrors();
		//debug("actual");
	    assert("arraylen(actual) EQ 0");
	}
	function Test_Booking_has_owner(){
		booking.setProperties(properties);
		booking.valid();
		actual = booking.allErrors();
		//debug("actual");
	    assert("arraylen(actual) EQ 0");
	}
	function Test_Booking_requires_either_buildingid_or_roomid_passes_1(){
		booking.setProperties({
			"title": "Test Event",
			"startUTC": now(),
			"endUTC": now(),
			"userid": 1,
			"buildingid": 1
		});
		booking.valid();
		actual = booking.allErrors();
		//debug("actual");
	    assert("arraylen(actual) EQ 0");
	}
	function Test_Booking_requires_either_buildingid_or_roomid_passes_2(){
		booking.setProperties({
			"title": "Test Event",
			"startUTC": now(),
			"endUTC": now(),
			"userid": 1,
			"roomid": 1
		});
		booking.valid();
		actual = booking.allErrors();
		//debug("actual");
	    assert("arraylen(actual) EQ 0");
	}
	function Test_Booking_requires_either_buildingid_or_roomid_fails(){
		booking.setProperties({
			"title": "Test Event",
			"startUTC": now(),
			"endUTC": now(),
			"userid": 1
		});
		booking.valid();
		actual = booking.allErrors();
		//debug("actual");
	    assert("arraylen(actual) GT 0");
	}
}
