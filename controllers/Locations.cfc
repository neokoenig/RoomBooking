<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfcomponent extends="controller">
	<cffunction name="init">
		<cfscript>
			filters(through="_getLocations", only="index"); 
			filters(through="_checkLocationsAdmin");	 
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
				renderPage(action="add", error="There were problems creating that location");
			} 
		}
		</cfscript>		
	</cffunction>

	<cffunction name="edit">
		<cfscript>
			location=model("location").findOne(where="id = #params.key#")
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
				renderPage(action="edit", error="There were problems updating that location");
			} 
		} 
		</cfscript>		
	</cffunction>

	<cffunction name="delete">
		<cfscript>
		 if(structkeyexists(params, "key")){
		    	location = model("location").findOne(where="id = #params.key#"); 
				if ( location.delete() )  {  
					redirectTo(action="index", success="location successfully deleted");
				}
		        else {  
					redirectTo(action="index", error="There were problems deleting that location");
				} 
			}
		</cfscript>		
	</cffunction>

<!---================================ Filters ======================================--->
		<cffunction name="_checkLocationsAdmin">
		<cfif !application.rbs.allowLocations>
			<cfset redirectTo(route="home", error="Facility to edit locations has been disabled")>
		</cfif>
	</cffunction>
 
</cfcomponent>