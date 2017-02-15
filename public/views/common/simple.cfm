<cfscript>
request.bodyClass="hold-transition login-page";
if(structKeyExists(application.rbs.settings, "theme_layout")){
	request.bodyClass&=" " & application.rbs.settings.theme_layout;
}
if(structKeyExists(application.rbs.settings, "theme_skin")){
	request.bodyClass&= " " & application.rbs.settings.theme_skin;
}
</cfscript>
<cfoutput>
#includePartial("/common/layout/head")#
	#includeContent()#
#includePartial("/common/layout/footer")#
</cfoutput>
