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
		};
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

	/*
		is there a repeat rule?
			if there's an UNTIL rrule:
				- END =  until date + add duration
			if there's a COUNT rrule:
				- END = Calculate Last Possible date + add duration
			if there's no rrule end date (UNTIL), and no COUNT
				- END = 9999-12-31, i.e MaxDate
		no repeat rule?
			END = start + duration

		finally, is it an allday?
			Set time to be 00:00 -> 23:59

	*/
	function Test_calculate_endUTC_no_repeat_rule_not_allday(){
		booking.setProperties(properties);
		booking.startUTC=createDateTime(2017,01,01,10,00,00);
		booking.duration=120;
		booking.calculateEndUTC();
		//debug("Booking.properties()");
	    assert("booking.endUTC EQ '2017-01-01 12:00:00'");
	}
	function Test_calculate_endUTC_no_repeat_rule_is_allday(){
		booking.setProperties(properties);
		booking.isallday=1;
		booking.startUTC=createDateTime(2017,01,01,10,00,00);
		booking.duration=120;
		booking.calculateEndUTC();
		//debug("Booking.properties()");
	    assert("booking.startUTC EQ '2017-01-01 00:00:00'");
	    assert("booking.endUTC EQ '2017-01-01 23:59:59'");
	}
	function Test_calculate_endUTC_no_repeat_rule_is_allday_multiday(){
		booking.setProperties(properties);
		booking.isallday=1;
		booking.startUTC=createDateTime(2017,01,01,10,00,00);
		booking.duration=14400; // 10 days
		booking.calculateEndUTC();
		//debug("Booking.properties()");
	    assert("booking.startUTC EQ '2017-01-01 00:00:00'");
	    assert("booking.endUTC EQ '2017-01-10 23:59:59'");
	}
	function Test_calculate_endUTC_repeat_rule_daily_forever_not_allday(){
		booking.setProperties(properties);
		booking.startUTC=createDateTime(2017,01,01,10,00,00);
		booking.duration=120;
		booking.isrepeat=1;
		booking.repeatpattern="FREQ:DAILY";
		booking.calculateEndUTC();
		//debug("Booking.properties()");
	    assert("booking.startUTC EQ '2017-01-01 10:00:00'");
	    assert("booking.endUTC EQ '9999-12-31 23:59:59'");
	}
	function Test_calculate_endUTC_repeat_rule_daily_forever_is_allday(){
		booking.setProperties(properties);
		booking.isallday=1;
		booking.startUTC=createDateTime(2017,01,01,10,00,00);
		booking.duration=120;
		booking.isrepeat=1;
		booking.repeatpattern="FREQ:DAILY";
		booking.calculateEndUTC();
		//debug("Booking.properties()");
	    assert("booking.startUTC EQ '2017-01-01 00:00:00'");
	    assert("booking.endUTC EQ '9999-12-31 23:59:59'");
	}
	function Test_calculate_endUTC_repeat_rule_daily_forever_is_allday_multiday(){
		booking.setProperties(properties);
		booking.isallday=1;
		booking.startUTC=createDateTime(2017,01,01,10,00,00);
		booking.isrepeat=1;
		booking.repeatpattern="FREQ:DAILY";
		booking.duration=14400; // 10 days
		booking.calculateEndUTC();
		//debug("Booking.properties()");
	    assert("booking.startUTC EQ '2017-01-01 00:00:00'");
	    assert("booking.endUTC EQ '9999-12-31 23:59:59'");
	}
}
