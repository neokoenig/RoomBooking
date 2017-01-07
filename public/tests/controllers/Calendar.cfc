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
		assert('r == "Booking Not Found"');
	}

	// Event Data
	function Test_data_returns_valid_json(){
		_params = {route="calendarDetail", controller="calendar", action="data"};
		_controller = controller("calendar", _params);
		_controller.$processAction('data', _params);
		r=_controller.response();
		// Force the rest of this response to be HTML
		$header(name="content-type", value="text/html" , charset="utf-8");
		//debug("r");
		assert('isJSON(r)');
	}
}
