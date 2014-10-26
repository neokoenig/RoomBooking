<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfcomponent extends="Controller">
	<cffunction name="init">
		<cfscript>
			filters(through="_getLocations", only="index");
			filters(through="_checkLocationsAdmin");
			filters(through="checkPermissionAndRedirect", permission="accessLocations");
 		</cfscript>
	</cffunction>

<!---================================ Views ======================================--->
	<cffunction name="add">
		<cfscript>
			location=model("location").new();
		</cfscript>
	</cffunction>

	<cffunction name="create">
	    <cfscript>
		if(structkeyexists(params, "location")){
	    	location = model("location").new(params.location);
			if ( location.save() ) {
				redirectTo(action="index", success="location successfully created");
			}
	        else {
				renderView(action="add", error="There were problems creating that location");
			}
		}
		</cfscript>
	</cffunction>

	<cffunction name="edit">
		<cfscript>
			location=model("location").findOne(where="id = #params.key#");
		</cfscript>
	</cffunction>

	<cffunction name="update">
		<cfscript>
		if(structkeyexists(params, "location")){
	    	location = model("location").findOne(where="id = #params.key#");
			location.update(params.location);
			if ( location.save() )  {
				redirectTo(action="index", success="location successfully updated");
			}
	        else {
				renderView(action="edit", error="There were problems updating that location");
			}
		}
		</cfscript>
	</cffunction>

	<cffunction name="delete">
		<cfscript>
		checkLocation=model("location").findAll();
		if(checkLocation.recordcount GT 1){
		 if(structkeyexists(params, "key")){
		    	location = model("location").findOne(where="id = #params.key#");
				if ( location.delete() )  {
					redirectTo(action="index", success="location successfully deleted");
				}
		        else {
					redirectTo(action="index", error="There were problems deleting that location");
				}
			}
		} else {

					redirectTo(action="index", error="At least one location is required.");
	}
		</cfscript>
	</cffunction>

<!---================================ Filters ======================================--->
		<cffunction name="_checkLocationsAdmin">
		<cfif !application.rbs.setting.allowLocations>
			<cfset redirectTo(route="home", error="Facility to edit locations has been disabled")>
		</cfif>
	</cffunction>

</cfcomponent>