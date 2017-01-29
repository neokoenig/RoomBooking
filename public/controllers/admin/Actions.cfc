component extends="Admin"
{
	function init() {
		super.init();
		filters(through="f_getActions", only="index");
		filters(through="f_getActionPropertiesFromParams", only="update,create");
		verifies(except="index,new,create,properties", params="key", paramsTypes="integer", handler="objectNotFound");
		verifies(post=true, only="create,update,delete");
		usesLayout(template=false, only="properties");
	}
	function index(){
		request.pagetitle="Actions";
		availableCFCs=getAvailableActions();
	}


	function new() {
		request.pagetitle="Create New Action";
		theaction=model("action").new();
	}

	function create() {
		writeDump(params);
		theaction=model("action").create(params.theaction);
		if(theaction.hasErrors()){
			renderPage(action="new");
		} else {
			return redirectTo(action="index", success="action #theaction.title# successfully created");
		}
	}

	function edit() {
		request.pagetitle="Update Action";
		theaction=model("action").findByKey(key=params.key);
	}

	function update() {
		theaction=model("action").findByKey(key=params.key);
		if(theaction.update(params.theaction)){
			return redirectTo(action="index", success="action #theaction.title# successfully updated");
		} else {
			renderPage(action="edit");
		}
	}

	function delete() {
		theaction=model("action").deleteByKey(key=params.key);
		return redirectTo(action="index", success="action successfully deleted");
	}


	function objectNotFound() {
		return redirectTo(action="index", error="That action wasn't found");
	}

	function properties(){
		if(len(params.key)){
			theaction=model("action").findByKey(key=params.key);
		} else {
			theaction=model("action").new();
		}
		renderPartial(partial="properties");
	}

	private function f_getActionPropertiesFromParams(){
		if(structKeyExists(params, "actionproperties")){
			params.theaction["propertiesjson"]=params.actionproperties;
		}
	}

}
