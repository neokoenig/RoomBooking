component extends="Admin"
{
	function init() {
		super.init();
		verifies(except="index,new,create", params="key", paramsTypes="integer", handler="objectNotFound");
		verifies(post=true, only="create,update,delete");
		filters(through="f_getBuildings", only="index");
		filters(through="f_getRooms", only="index");
		filters(through="f_getUsers", only="index,new,edit,create,update");
	}

	function index(){
		param name="params.sort" default="startUTC";
		param name="params.sortorder" default="ASC";
		param name="params.key" default="1";
		param name="params.from" default=dateFormat(now(), 'YYYY-MM-DD');
		param name="params.to" default=dateFormat(dateAdd("m", 1, now()), 'YYYY-MM-DD');
		param name="params.buildingid" default="";
		param name="params.roomid" default="";
		param name="params.includeRepeats" default=0;
		param name="params.status" default="";
		request.pagetitle="Bookings";
		bookings=getEventsForRange(start=params.from, end=params.to, includeRepeats=params.includerepeats);
	}

	function show() {
		request.pagetitle="Booking Information";
		booking=model("booking").findByKey(params.key);
		if(!isObject(booking)){
			objectNotFound();
		}
	}

	function new() {
		request.pagetitle="Create New Booking";
		booking=model("booking").new();
		booking.email=session.user.properties.email;
		booking.tel=session.user.properties.tel;
	}

	function create() {
		booking=model("booking").create(params.booking);
		if(booking.hasErrors()){
			renderPage(action="new");
		} else {
			return redirectTo(action="index", success="booking #booking.title# successfully created");
		}
	}

	function edit() {
		request.pagetitle="Update Booking";
		booking=model("booking").findByKey(params.key);
		if(!isObject(booking)){
			objectNotFound();
		}
	}

	function update() {
		booking=model("booking").findByKey(params.key);
		if(booking.update(params.booking)){
			return redirectTo(action="index", success="booking #booking.title# successfully updated");
		} else {
			renderPage(action="edit");
		}
	}

	function clone(){
		// Not Yet Implemented
	}

	/* Triggered from JS */
	function approve() {
		booking=model("booking").UpdateByKey(key=params.key, isapproved=1, approvedby=session.user.properties.id);
		flashInsert(success="Booking Approved");
		redirectTo(back=true);
	}

	/* Triggered from JS */
	function delete() {
		booking=model("booking").deleteByKey(params.key);
		flashInsert(success="Booking successfully deleted");
		redirectTo(back=true);
	}

	function objectNotFound() {
		return redirectTo(action="index", error="That booking wasn't found");
	}

}
