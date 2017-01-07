component extends="Admin"
{
	function init() {
		super.init();
		filters(through="checkPermissionAndRedirect", permission="accessSettings");
		verifies(except="index", params="key", paramsTypes="integer", handler="objectNotFound");
		verifies(post=true, only="update");
	}

	function index(){
		request.pagetitle="Settings";
		settings=model("setting").findAll(order="name");
		settingCategories=[];
		for(setting in settings){
			var s=listFirst(setting.name, "_");
			if(!arrayFind(settingCategories, s)){
				arrayAppend(settingCategories, s);
			}
		}
	}

	function edit() {
		request.pagetitle="Update Setting";
		setting=model("setting").findByKey(params.key);
	}

	function update() {
		setting=model("setting").findByKey(params.key);
		if(setting.update(params.setting)){
			// Refresh Application Scope Settings
			getRBSApplicationSettings();
			return redirectTo(route="adminSettings", success="Setting #setting.name# successfully updated");
		} else {
			renderPage(action="edit");
		}
	}

	function objectNotFound() {
		return redirectTo(route="adminSettings", error="That Setting wasn't found");
	}

}
