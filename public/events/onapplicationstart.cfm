<cfscript>
//=====================================================================
//= 	Application Level Settings: the rbs struct contains all the things.
//=====================================================================
	if(structKeyExists(application, "rbs")){
		structDelete(application, "rbs");
	}

	// BCrypt library
	application.bCrypt = CreateObject( "java", "BCrypt" );

	application.rbs={
		version="2.0",
		settings={}
	};
</cfscript>
