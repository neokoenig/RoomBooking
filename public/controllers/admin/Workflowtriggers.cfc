component extends="Admin"
{
	function init() {
		super.init();
		verifies(post=true, only="create,delete");
		filters(through="f_getTriggers", only="index");
		filters(through="f_getActions", only="index");
		verifies(only="index", params="key", paramsTypes="integer", handler="objectNotFound");
		verifies(only="create,delete", params="workflowid", paramsTypes="integer",	handler="incompleteParams");
		verifies(only="create,delete", params="triggerid", paramsTypes="integer",	handler="incompleteParams");
		verifies(only="create,delete", params="actionid", paramsTypes="integer",	handler="incompleteParams");
	}
	function index(){
		workflow=model("workflow").findByKey(key=params.key);
		workflowtriggers=model("workflowtrigger").findAll(where="workflowid = #params.key#", include="trigger,action");
	}
	function create() {
		if(!model("workflowtrigger").exists(where="
				workflowid=#params.workflowid# AND
				triggerid=#params.triggerid# AND
				actionid=#params.actionid#")){
			workflowtrigger=model("workflowtrigger").create(
				workflowid=params.workflowid,
				triggerid=params.triggerid,
				actionid=params.actionid
			);
			return redirectTo(back=true, success="Workflow trigger successfully created");
		} else {
			return redirectTo(back=true, error="Workflow trigger already exists");
		}

	}

	function delete() {
		workflowtrigger=model("workflowtrigger").deleteByKey("#params.workflowid#,#params.triggerid#,#params.actionid#");
		return redirectTo(back=true, success="workflow trigger successfully deleted");
	}
	function objectNotFound() {
		return redirectTo(back=true, error="Triggers for that workflow were not found");
	}
	function incompleteParams() {
		return redirectTo(back=true, error="Params required");
	}

}
