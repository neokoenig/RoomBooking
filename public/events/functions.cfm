<cfscript>
//=====================================================================
//= 	Locale & i8n
//=====================================================================
    public string function getCurrentLanguage() {
        if(structKeyExists(session, "lang") AND len(session.lang)){
            return session.lang;
        } else {
            return "en_GB";
        }
    }

</cfscript>
