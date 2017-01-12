component extends="Admin"
{
	function init() {
		super.init();
		filters(through="f_getCountries,f_getbuildings", only="index,new,create,edit,update");
		filters(through="f_getRoles", only="new,create,edit,update");
		filters(through="f_getUsers", only="new,create,edit,update");
		verifies(except="index,new,create", params="key", paramsTypes="integer", handler="objectNotFound");
		verifies(post=true, only="create,update,delete");
	}
	function index(){
		request.pagetitle="Rooms";
		rooms=model("room").findAll(include="building");
	}

	function show() {
		request.pagetitle="Room Information";
		room=model("room").findByKey(params.key);
		if(!isObject(room)){
			objectNotFound();
		}
	}

	function new() {
		request.pagetitle="Create New Room";
		room=model("room").new();
	}

	function create() {
		room=model("room").create(params.room);
		if(room.hasErrors()){
			renderPage(action="new");
		} else {
			return redirectTo(action="index", success="room #room.title# successfully created");
		}
	}

	function edit() {
		request.pagetitle="Update Room";
		room=model("room").findByKey(params.key);
	}

	function update() {
		room=model("room").findByKey(params.key);
		if(room.update(params.room)){
			return redirectTo(action="index", success="room #room.title# successfully updated");
		} else {
			renderPage(action="edit");
		}
	}

	function delete() {
		room=model("room").deleteByKey(params.key);
		return redirectTo(action="index", success="room successfully deleted");
	}

	function objectNotFound() {
		return redirectTo(action="index", error="That room wasn't found");
	}

}
