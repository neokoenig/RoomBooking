<cfscript>
//=====================================================================
//= 	Global Filters
//=====================================================================
	function f_getRoles(){
		allroles=model("role").findAll();
	}
	function f_getPermissions(){
		allpermissions=model("permission").findAll(order="name");
	}
	function f_getRolePermissions(){
		allrolepermissions=model("rolepermission").findAll();
	}
	function f_getCountries(){
		allcountries=model("country").findAll(order="sortorder");
	}
	function f_getBuildings(){
		allbuildings=model("building").findAll(order="title");
	}
	function f_getRooms(){
		allrooms=model("room").findAll(order="title");
	}
	function f_getUsers(){
		allusers=model("user").findAll(order="lastname");
	}
	function f_getCalendars(){
		allcalendars=model("calendar").findAll(order="title");
	}
	function f_getWorkflows(){
		allworkflows=model("workflow").findAll(order="title");
	}
	function f_getTriggers(){
		alltriggers=model("trigger").findAll(order="title");
	}
	function f_getActions(){
		allactions=model("action").findAll(order="title");
	}
	function f_getLocations(){
		locations=mergeLocations(
			model("calendarbuilding").findAll(include="building", order="title", group="id"),
			model("calendarroom").findAll(include="room", order="title", group="id")
		);
	}

	function abortifinstalled(){
		if(application.rbs.installed){
			abort;
		}
	}
</cfscript>
