<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfcomponent extends="Controller">

	<cffunction name="init">
		<cfscript>
		filters(through="checkPermissionAndRedirect", permission="accessPermissions");
		filters(through="denyInDemoMode", only="edit,update");
 		</cfscript>
	</cffunction>



<!---================================ Views ======================================--->

	<cffunction name="index">
		<cfset permissions=model("permission").findAll(order="id")>
	</cffunction>

	<cffunction name="edit" hint="Edit a permission">
		<cfscript>
		permission=model("permission").findOne(where="id = '#params.key#'");
		if(!isObject(permission)  OR application.rbs.setting.isDemoMode){
			redirectTo(back=true, error="Sorry, that permission can't be found, isn't editable or the board is in demo mode");
		}
		</cfscript>
	</cffunction>

	<cffunction name="update" hint="Update a permission">
		<cfscript>
		if(structkeyexists(params, "permission")){
	    	permission = model("permission").findOne(where="id = '#params.key#'");
	    	if(!isObject(permission)  OR application.rbs.setting.isDemoMode){
	    		redirectTo(back=true, error="Sorry, that permission can't be found, isn't editable or the board is in demo mode");
	    	} else {
				permission.update(params.permission);
				if ( permission.save() )  {
					redirectTo(action="index", success="permission successfully updated - please note you will need to reload the application for this to take effect");
				}
		        else {
					renderPage(action="edit", error="There were problems updating that permission");
				}
	    	}
		}
		</cfscript>
	</cffunction>
</cfcomponent>

