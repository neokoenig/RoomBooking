<cfcomponent extends="controller">
	<cffunction name="init">
		<cfscript>
			filters(through="_getSettings");	 
		</cfscript>
	</cffunction>
	<cffunction name="index">
		
	</cffunction>

	<cffunction name="edit">
		<cfscript>
			setting=model("setting").findOne(where="id = '#params.key#'");
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
</cfcomponent>