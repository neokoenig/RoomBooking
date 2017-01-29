<cfscript>
//=====================================================================
//= 	Actions: fired by triggers
//=====================================================================

	string function getActionCFCPath(){
		return application.wheels.rootpath & application.wheels.modelpath & "/Actions";
	}

	struct function getAvailableActions(){
		local.rv={
			"components"=[],
			"actions"=[],
			"paths"= directoryList(path=getActionCFCPath(), filter="*.cfc")
		};
		for(p in local.rv.paths){
			arrayAppend(local.rv.components, listLast(p, "\,/"));
			arrayAppend(local.rv.actions, replace(listLast(p, "\,/"), ".cfc", "", "all"));
		}
		return local.rv;
	}




</cfscript>
