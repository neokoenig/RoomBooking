component extends="Admin"
{
	function init() {
		super.init();
		filters(through="checkPermissionAndRedirect", permission="accessBuildings");
		filters(through="f_getBuildings", only="index");
		filters(through="f_getCountries", only="index,new,create,edit,update");
		filters(through="f_getUsers", only="new,create,edit,update");
		verifies(except="index,new,create", params="key", paramsTypes="integer", handler="objectNotFound");
		verifies(post=true, only="create,update,delete");
	}
	function index(){
		request.pagetitle="Buildings";
	}

	function show() {
		request.pagetitle="Building Information";
		building=model("building").findByKey(params.key);
		if(!isObject(building)){
			objectNotFound();
		}
	}

	function new() {
		request.pagetitle="Create New Building";
		building=model("building").new();
	}

	function create() {
		building=model("building").create(params.building);
		if(building.hasErrors()){
			renderPage(action="new");
		} else {
			return redirectTo(action="index", success="building #building.title# successfully created");
		}
	}

	function edit() {
		request.pagetitle="Update Building";
		building=model("building").findByKey(params.key);
	}

	function update() {
		building=model("building").findByKey(params.key);
		if(building.update(params.building)){
			return redirectTo(action="index", success="building #building.title# successfully updated");
		} else {
			renderPage(action="edit");
		}
	}

	function delete() {
		building=model("building").deleteByKey(params.key);
		return redirectTo(action="index", success="building successfully deleted");
	}

	function objectNotFound() {
		return redirectTo(action="index", error="That building wasn't found");
	}

}
