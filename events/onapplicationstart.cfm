<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfscript>
	 	// Application Specific settings
		if(structKeyExists(application, "rbs")){
			structDelete(application, "rbs");
		}

		application.rbs={
			versionNumber="1.2",
			setting={},
			permission={},
			//roles="admin,editor,user,guest",
			templates={},
			modeltypes="event,location",
			templatetypes="form,output"
		};

		for(setting in model("setting").findAll()){
			application.rbs.setting['#setting.id#']=setting.value;
		}
		permissions=model("permission").findAll();

		rolelist=permissions.columnlist;
		rolelist=listDeleteAt(rolelist, ListFind(rolelist, "ID"));
		rolelist=listDeleteAt(rolelist, ListFind(rolelist, "NOTES"));
		application.rbs.roles=rolelist;

		for(permission in permissions){
			application.rbs.permission["#permission.id#"]={};
			for(role in listToArray(application.rbs.roles)){
				application.rbs.permission["#permission.id#"]["#role#"]=permission["#role#"];
			}
		}

		for(template in model("template").findAll()){
			application.rbs.templates["#template.parentmodel#"]["#template.type#"]=template.template;
		}

	addShortcode("field", field_callback);
	addShortcode("output", output_callback);


</cfscript>
