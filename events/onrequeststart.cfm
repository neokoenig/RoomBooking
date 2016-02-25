<cfscript>
//================= Room Booking System / https://github.com/neokoenig =======================--->

//Set defaults for non cookie enabled browsers
request.cookie={
	username=""
};

// Trim Form and URL scopes
if(structCount(url)){
	for(key in url){
		url[key] = Trim(url[key]);
	}
}
if(StructCount(form)){
	for(key in form){
		if(isSimpleValue(form[key])){
			form[key] = Trim(form[key]);
		}
	}
}

//=====================================================================
//= 	Languages
//=====================================================================
request.lang={};

// Languages with a translation file
request.lang.availableLanguages=localizatorGetLanguages();

// As a list for lang dropdown
request.lang.languages=structKeyList(request.lang.availableLanguages);

// Current lang in en_GB format
request.lang.current=getCurrentLanguage();

// Language override = if ?language=en_GB exists in URL, use that language for this request only
if(structKeyExists(url, "language") AND len(url.language)){
	request.lang.current=trim(xmlFormat(url.language));
}

// Current lang as 2 letter code
request.lang.currentCode=listFirst(request.lang.current, "_");

// Current lang as 2 letter code with sub-language if appropriate)
if(listFirst(request.lang.current, '_') EQ ListLast(request.lang.current, "_")){
	request.lang.currentCodeWithSub=lcase(request.lang.currentCode);
} else {
	request.lang.currentCodeWithSub=replace(lcase(request.lang.current), '_', '-', 'all');
}

//=====================================================================
//= 	Other Request Level Vars
//=====================================================================
request.showNavBar="true";
SetLocale(request.lang.current);
</cfscript>

<!---
	If cookie exists, get its values and update the request struct
	NB, breaking out of cfscript as I can never get cfcookie working in CF10 in script form
--->
<cfif !structkeyexists(cookie, 'RBS_UN')>
	<!--- Set initial cookie--->
	<cfcookie name = "RBS_UN" expires="360" value="" httponly="true">
<cfelse>
	<cfset request.cookie.username=cookie.RBS_UN>
</cfif>
