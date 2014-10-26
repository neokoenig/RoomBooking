<!---================= Room Booking System / https://github.com/neokoenig =======================--->

<cftry>
	<cfset _loadSettings()>
	<cfcatch type="any">
		<cfthrow message="Could not load settings - please check your datasource">
	</cfcatch>
</cftry>


<cffunction name="_loadSettings">
 	<cfscript>
	// Application Specific settings
	if(structKeyExists(application, "rbs")){
		structDelete(application, "rbs");
	}

	application.rbs={};
	application.rbs.setting={};
	application.rbs.permission={};

	application.rbs.roles="admin,editor,user,guest";

	for(setting in model("setting").findAll()){
		application.rbs.setting['#setting.id#']=setting.value;
	}

	for(permission in model("permission").findAll()){

		application.rbs.permission["#permission.id#"]={};
		for(role in listToArray(application.rbs.roles)){
			application.rbs.permission["#permission.id#"]["#role#"]=permission["#role#"];
		}
	}
	</cfscript>

 </cffunction>
