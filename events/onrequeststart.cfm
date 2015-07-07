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

// Languages
request.lang={};
request.lang.availableLanguages=localizatorGetLanguages();
request.lang.languages=structKeyList(request.lang.availableLanguages);
request.lang.current=getCurrentLanguage();

//Other default request level vars
request.showNavBar="true"
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
