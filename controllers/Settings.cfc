<cfcomponent extends="controller">
	<cffunction name="init">
		<cfscript>
			filters(through="_getSettings");
			filters(through="_checkSettingsAdmin");	 
		</cfscript>
	</cffunction>
	<cffunction name="index">
		
	</cffunction>

	<cffunction name="edit">
		<cfscript>
			setting=model("setting").findOne(where="id = '#params.key#'");
			if(!isObject(setting) OR !setting.Editable){
			redirectTo(back=true, error="Sorry, that setting can't be found or isn't editable");
		}
		</cfscript>		
	</cffunction>

	<cffunction name="update">
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

	<cffunction name="_checkSettingsAdmin">
		<cfif !application.rbs.allowSettings>
			<cfset redirectTo(route="home", error="Facility to edit settings has been disabled")>
		</cfif>
	</cffunction>
</cfcomponent>