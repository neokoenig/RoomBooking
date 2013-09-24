<cfcomponent extends="controller">
	<cffunction name="init">
		<cfscript>
			filters(through="_getSettings");
			filters(through="_checkSettingsAdmin", except="cron");	 
		</cfscript>
	</cffunction> 

<!---================================ Views ======================================--->
	<cffunction name="edit" hint="Edit a setting">
		<cfscript>
			setting=model("setting").findOne(where="id = '#params.key#'");
			if(!isObject(setting) OR !setting.Editable){
			redirectTo(back=true, error="Sorry, that setting can't be found or isn't editable");
		}
		</cfscript>		
	</cffunction>

	<cffunction name="update" hint="Update a setting">
		<cfscript>
		if(structkeyexists(params, "setting")){
	    	setting = model("setting").findOne(where="id = '#params.key#'");
			setting.update(params.setting);
			if ( setting.save() )  {  
				redirectTo(action="index", success="Setting successfully updated - please note you will need to reload the application for this to take effect");
			}
	        else {  
				renderPage(action="edit", error="There were problems updating that setting");
			} 
		} 
		</cfscript>		
	</cffunction>
<!---================================ Filters ======================================--->
	<cffunction name="_checkSettingsAdmin" hint="Checks to see if settings are editable via web interface">
		<cfif !application.rbs.allowSettings>
			<cfset redirectTo(route="home", error="Facility to edit settings has been disabled")>
		</cfif>
	</cffunction>

<!---================================ System ======================================--->
	<cffunction name="cron" hint="Used in demo mode to reset the database every 30 mins">
		
	</cffunction>
</cfcomponent>