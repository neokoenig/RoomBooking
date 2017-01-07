<cfscript>
// Default Page Title
request.pagetitle="";
// Default Body Class
request.bodyClass="hold-transition";

// Trim Form and URL scopes
url=trimScope(url);
form=trimScope(form);
//=====================================================================
//= 	Languages
//=====================================================================
/* Languages are selected in the following precendent:
	application.i8n_defaultLanguage (default)
	session.lang (currently selected in session from dropdown)
	session.user.properties.lang (user pref)
*/
if(application.rbs.installed){

	request.allCalendars=model("calendar").findAll(order="title");

	request.lang={};

	// Languages with a translation file
	request.lang.availableLanguages=localizatorGetLanguages();

	// As a list for lang dropdown
	request.lang.languages=structKeyList(request.lang.availableLanguages);

	// Set Default Language
	if(structKeyExists(application.rbs.settings, "i8n_defaultLanguage")){
		request.lang.current=application.rbs.settings.i8n_defaultLanguage;
		request.lang.setby="Default";
	}
	// If Language appears in Session, override
	if(structKeyExists(session, "lang")){
		request.lang.current=session.lang;
		request.lang.setby="Session";
	}
	// If Language appears in User session, override
	if(structKeyExists(session, "user")
		&& structKeyExists(session.user, "properties")
		&& structKeyExists(session.user.properties, "lang")
		&& len(session.user.properties.lang)){
		request.lang.current=session.user.properties.lang;
	}
	// Language override = if ?language=en_GB exists in URL, use that language for this request only
	if(structKeyExists(url, "language") AND len(url.language)){
		request.lang.current=trim(xmlFormat(url.language));
		request.lang.setby="User Session";
	}

	// Current lang as 2 letter code
	request.lang.currentCode=listFirst(request.lang.current, "_");

	// Current lang as 2 letter code with sub-language if appropriate)
	if(listFirst(request.lang.current, '_') EQ ListLast(request.lang.current, "_")){
		request.lang.currentCodeWithSub=lcase(request.lang.currentCode);
	} else {
		request.lang.currentCodeWithSub=replace(lcase(request.lang.current), '_', '-', 'all');
	}

	SetLocale(request.lang.current);

	// Themes
	if(structKeyExists(application.rbs.settings, "theme_layout")){
		request.bodyClass&=" " & application.rbs.settings.theme_layout;
	}
	if(structKeyExists(application.rbs.settings, "theme_skin")){
		request.bodyClass&= " " & application.rbs.settings.theme_skin;
	}
}

</cfscript>
