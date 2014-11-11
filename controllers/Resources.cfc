<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfcomponent extends="Controller">
	<cffunction name="init">
		<cfscript>
			filters(through="_getresources", only="index");
			filters(through="checkPermissionAndRedirect", permission="accessresources");
			filters(through="_checkResourcesAdmin");
			filters(through="_getLocations");
			provides("html,json");
 		</cfscript>
	</cffunction>

<!---================================ Views ======================================--->
	<cffunction name="add">
		<cfscript>
			resource=model("resource").new();
		</cfscript>
	</cffunction>

	<cffunction name="create">
	    <cfscript>
		if(structkeyexists(params, "resource")){
	    	resource = model("resource").new(params.resource);
			if ( resource.save() ) {
				redirectTo(action="index", success="resource successfully created");
			}
	        else {
				renderPage(action="add", error="There were problems creating that resource");
			}
		}
		</cfscript>
	</cffunction>

	<cffunction name="edit">
		<cfscript>
			resource=model("resource").findOne(where="id = #params.key#");
		</cfscript>
	</cffunction>

	<cffunction name="update">
		<cfscript>
		if(structkeyexists(params, "resource")){
	    	resource = model("resource").findOne(where="id = #params.key#");
			resource.update(params.resource);
			if ( resource.save() )  {
				redirectTo(action="index", success="resource successfully updated");
			}
	        else {
				renderPage(action="edit", error="There were problems updating that resource");
			}
		}
		</cfscript>
	</cffunction>

	<cffunction name="delete">
		<cfscript>
		 	 if(structkeyexists(params, "key")){
		    	resource = model("resource").findOne(where="id = #params.key#");
				if ( resource.delete() )  {
					redirectTo(action="index", success="resource successfully deleted");
				}
		        else {
					redirectTo(action="index", error="There were problems deleting that resource");
				}
			}
		</cfscript>
	</cffunction>
<!---================================ Ajax ======================================--->
	<cffunction name="checkavailability" hint="Check for resource concurrency">
		<cfparam name="params.id" default="">
		<cfparam name="params.eventid" default="">
		<cfparam name="params.start" default="">
		<cfparam name="params.end" default="">
		<cfscript>
		if(!isDate(params.end)){
			params.end=dateAdd("h", 1, params.start);
		}
		// Check for any events which may have booked the unique resource in the given timeframe, excluding the event itself
		checkEvent=model("event").findAll(
			where="start <= '#params.start#' AND end >= '#params.end#' AND id != #params.eventid# AND resourceid = #params.id#",
			include="eventresources");
		/* Check for events with an All Day flag which might have incorrect timings set; this shouldn't affect events which span multiple days, as the above check (should) pick them up;*/
			tempstart=dateFormat(params.start, "yyyy-mm-dd") & ' ' & timeFormat(params.start, "00:00");
			tempend=dateFormat(params.end, "yyyy-mm-dd") & ' ' & timeFormat(params.end, "23:59");
		checkEvent2=model("event").findAll(
			where="start >= '#tempstart#' AND end <= '#tempend#' AND id != #params.eventid# AND allday=1 AND resourceid=#params.id#",
			include="eventresources");

		if(checkEvent.recordCount OR checkEvent2.recordcount){
			renderText(0);
		} else {
			renderText(1);
		}
		</cfscript>
	</cffunction>
<!---================================ Filters ======================================--->
		<cffunction name="_checkResourcesAdmin">
		<cfif !application.rbs.setting.allowResources>
			<cfset redirectTo(route="home", error="Facility to add/edit resources has been disabled")>
		</cfif>
	</cffunction>

</cfcomponent>