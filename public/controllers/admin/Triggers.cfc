component extends="Admin"
{
	function init() {
		super.init();
		filters(through="f_getTriggers", only="index");
		filters(through="f_getActions", only="new,create,edit,update");
		verifies(except="index,new,create", params="key", paramsTypes="integer", handler="objectNotFound");
		verifies(post=true, only="create,update,delete");
	}
	function index(){
		request.pagetitle="Triggers";
	}


	function new() {
		request.pagetitle="Create New Trigger";
		trigger=model("trigger").new();
	}

	function create() {
		trigger=model("trigger").create(params.trigger);
		if(trigger.hasErrors()){
			renderPage(action="new");
		} else {
			return redirectTo(action="index", success="trigger #trigger.title# successfully created");
		}
	}

	function edit() {
		request.pagetitle="Update Trigger";
		trigger=model("trigger").findByKey(key=params.key);
	}

	function update() {
		trigger=model("trigger").findByKey(key=params.key);
		if(trigger.update(params.trigger)){
			return redirectTo(action="index", success="trigger #trigger.title# successfully updated");
		} else {
			renderPage(action="edit");
		}
	}

	function delete() {
		trigger=model("trigger").deleteByKey(key=params.key);
		return redirectTo(action="index", success="trigger successfully deleted");
	}

	function objectNotFound() {
		return redirectTo(action="index", error="That trigger wasn't found");
	}

}
