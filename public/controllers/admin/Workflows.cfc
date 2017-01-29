component extends="Admin"
{
	function init() {
		super.init();
		filters(through="f_getWorkflows", only="index");
		verifies(except="index,new,create", params="key", paramsTypes="integer", handler="objectNotFound");
		verifies(post=true, only="create,update,delete");
	}
	function index(){
		request.pagetitle="Workflows";
	}


	function new() {
		request.pagetitle="Create New Workflow";
		workflow=model("workflow").new();
	}

	function create() {
		workflow=model("workflow").create(params.workflow);
		if(workflow.hasErrors()){
			renderPage(action="new");
		} else {
			return redirectTo(action="index", success="workflow #workflow.title# successfully created");
		}
	}

	function edit() {
		request.pagetitle="Update Workflow";
		workflow=model("workflow").findByKey(key=params.key);
	}

	function update() {
		workflow=model("workflow").findByKey(key=params.key);
		if(workflow.update(params.workflow)){
			return redirectTo(action="index", success="workflow #workflow.title# successfully updated");
		} else {
			renderPage(action="edit");
		}
	}

	function delete() {
		workflow=model("workflow").deleteByKey(key=params.key);
		return redirectTo(action="index", success="workflow successfully deleted");
	}

	function objectNotFound() {
		return redirectTo(action="index", error="That workflow wasn't found");
	}

}
