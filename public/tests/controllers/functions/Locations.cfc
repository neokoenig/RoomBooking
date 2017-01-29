component extends="tests.Test" {

	function setup() {
		_params={"controller"="","action"=""};
		_controller=controller(name="controller", params=_params);
	}
	function teardown() {

	}

	// powers the dropdown filters in calendar view
	function Test_mergeLocations_by_CalendarID_1(){
		_buildings=model("calendarbuilding").findAll(where="calendarid =1", include="building", order="title");
		_rooms=model("calendarroom").findAll(where="calendarid =1", include="room", order="title");
		r=_controller.mergeLocations(_buildings, _rooms);
		assert("arrayLen(r) EQ 3");
		assert("arrayLen(r[1]['groupby']['basement']) EQ 1");
		assert("arrayLen(r[1]['groupby']['ground']) EQ 1");
		assert("!structKeyExists(r[3], 'groupby')");
		//debug("r");
	}

	function Test_Buildings_As_Array_for_LocationPicker(){
		r=_controller.getBuildingArray();
		assert("arrayLen(r) GT 1");
		assert("r[1]['id'] EQ 0");
		assert("r[2]['title'] EQ '58 Wall Street'");
		//debug("r");
	}
	function Test_Rooms_As_Array_for_LocationPicker(){
		r=_controller.getRoomArray();
		assert("arrayLen(r) GT 1");
		assert("r[1]['id'] EQ 30");
		assert("r[1]['title'] EQ '101'");
		//debug("r");
	}
	function Test_Merge_Buildings_Rooms_As_Array(){
		ba=_controller.getBuildingArray();
		ra=_controller.getRoomArray();
		r=_controller.getLocationsAsNestedArray(
			ba, ra
		);
		assert("arrayLen(r) EQ 7");
		assert("arrayLen(r[1]['children']) EQ 4");
		//debug("r");
	}
}