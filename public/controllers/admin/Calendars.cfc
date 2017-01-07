component extends="Admin"
{
	function init() {
		super.init();
		filters(through="checkPermissionAndRedirect", permission="accessSettings");
		filters(through="f_getUsers", only="new,create,edit,update");
		verifies(except="index,new,create", params="key", paramsTypes="integer", handler="objectNotFound");
		verifies(post=true, only="create,update,delete");
	}
	function index(){
		request.pagetitle="Calendars";
		allcalendars=request.allcalendars;
	}

	function show() {
		request.pagetitle="Calendar Information";
		calendar=model("calendar").findByKey(params.key);
		if(!isObject(calendar)){
			objectNotFound();
		}
	}

	function new() {
		request.pagetitle="Create New Calendar";
		calendar=model("calendar").new();
	}

	function create() {
		calendar=model("calendar").create(params.calendar);
		if(calendar.hasErrors()){
			renderPage(action="new");
		} else {
			return redirectTo(action="index", success="calendar #calendar.title# successfully created");
		}
	}

	function edit() {
		request.pagetitle="Update Calendar";
		calendar=model("calendar").findByKey(params.key);
	}

	function update() {
		calendar=model("calendar").findByKey(params.key);
		if(calendar.update(params.calendar)){
			return redirectTo(action="index", success="calendar #calendar.title# successfully updated");
		} else {
			renderPage(action="edit");
		}
	}

	function delete() {
		calendar=model("calendar").deleteByKey(params.key);
		return redirectTo(action="index", success="calendar successfully deleted");
	}

	function objectNotFound() {
		return redirectTo(action="index", error="That calendar wasn't found");
	}

}
