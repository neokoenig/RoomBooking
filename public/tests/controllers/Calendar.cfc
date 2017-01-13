component extends="tests.Test" {

	function setup() {
		_bookings=model("booking").findAll(perpage=10, page=1, order="startUTC ASC", include="building,room", returnAS="structs");

		start=createDateTime(2017, 01, 01, 00, 00, 00);
		end=createDateTime(2017, 02, 15, 00, 00, 00);

	}
	function teardown() {}

	// Main Calendar Page
	/*function Test_index_basic_render(){
		_params = {route="calendarIndex", controller="calendar", action="index"};
		_controller = controller("calendar", _params);
		_controller.$processAction('index', _params);
		r=_controller.response();
		assert('r CONTAINS "<div id=""calendar""></div>"');
	}*/

	// Clicked Event Detail
	function Test_display_booking_detail_not_found(){
		_params = {route="calendarDetail", controller="calendar", action="detail", key=987987};
		_controller = controller("calendar", _params);
		_controller.$processAction('detail', _params);
		r=_controller.response();
		assert('r EQ "Booking Not Found"');
	}
	function Test_display_booking_detail_renders(){
		_params = {route="calendarDetail", controller="calendar", action="detail", key=1};
		_controller = controller("calendar", _params);
		_controller.$processAction('detail', _params);
		r=_controller.response();
		//assert('r EQ "Booking Not Found"');
	}

	// Full Calendar Data
	function Test_fullcalendar_data_returns_valid_json(){
		_params = {route="fullcalendardata", controller="calendar", action="fullcalendardata", key=1};
		_controller = controller("calendar", _params);
		_controller.$processAction('fullcalendardata', _params);
		r=_controller.response();
		shouldfail=Find("ALLDAY", r);
		shouldfail2=Find("allday", r);
		shouldpass=Find("allDay", r);
		$header(name="content-type", value="text/html" , charset="utf-8");
		assert('shouldfail EQ 0');
		assert('shouldfail2 EQ 0');
		assert('shouldpass GT 0');
		assert('isJSON(r)');
	}

}
