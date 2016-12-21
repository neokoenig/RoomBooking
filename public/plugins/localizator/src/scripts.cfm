<cfoutput>
	<cfscript>
		loc = {};

		loc.congig        = {};
		loc.message       = {};
		loc.localizations = {};

		loc.config.settings = localizatorGetPluginSettings();

		loc.config.url = "#CGI.script_name#?controller=wheels&action=wheels&view=plugins&name=#loc.config.settings.plugin.name#";

		if ( loc.config.settings.isDB ) {
			localizationForm  = model(loc.config.settings.localizationtable).new();
		}

		// GENERATE LOCALIZATION FILES
		if ( isDefined("params.type") && params.type == "todatabase" && loc.config.settings.isDB ) {
			loc.message.generator = generateLocalizationDatabase();
		}

		// GENERATE LOCALIZATION FILES
		if ( isDefined("params.type") && params.type == "tofile" && loc.config.settings.isDB ) {
			loc.message.generator = generateLocalizationFiles();
		}

		// ADD LOCALIZATION
		if ( isDefined("params.type") && params.type == "add") {
			localizationForm = addTranslation(params);
		}

		// EDIT LOCALIZATION
		if ( isDefined("params.type") && params.type == "edit" ) {
			localizationForm = editTranslation(params);
		}

		// UPDATE LOCALIZATION
		if ( isDefined("params.type") && params.type == "update") {
			localizationForm = updateTranslation(params);
		}

		// DELETE LOCALIZATION
		if ( isDefined("params.type") && params.type == "delete" ) {
			localizationForm = deleteTranslation(params);
		}

		// ADD LANGUAGE
		if ( isDefined("params.type") && params.type == "addLanguage" ) {
			createdLanguage = localizatorAddLocaleid(params.locales.localeid);

			loc.config.settings = localizatorGetPluginSettings();
			
			if ( createdLanguage ) {
				flashInsert(message=l("Language created successfully"), messageType="success");

			} else {
				flashInsert(message=l("That language is already configured"), messageType="error");
			}
		}

		// DELETE LANGUAGE
		if ( isDefined("params.type") && params.type == "deleteLanguage" ) {
			deletedLanguage = localizatorDeleteLocaleid(params.locales.localeid);

			loc.config.settings = localizatorGetPluginSettings();

			if ( deletedLanguage ) {
				flashInsert(message=l("Language deleted successfully"), messageType="success");

			} else {
				flashInsert(message=l("Unable to delete this language"), messageType="error");
			}
		}

		// GET TEXTS
		if ( loc.config.settings.isDB ) {
			loc.localizations = getLocalizationsFromDatabase(params.letter);
			loc.fromFile      = false;

			if ( !loc.localizations.texts.recordCount ) {
				loc.localizations = getLocalizationsFromFile(params.letter);
				loc.fromFile      = true;
			}

		} else {
			loc.localizations = getLocalizationsFromFile(params.letter);

			if ( isStruct(loc.localizations) ) {
				loc.fromFile = true;
			
			} else {
				loc.fromFile = false;
			}
		}

		if ( loc.config.settings.isDB ) {
			loc.countDatabase = getLocalizationsFromDatabase(params.letter).texts.recordCount;
		
		} else {
			loc.countDatabase = 0;
		}

		loc.countFile = getLocalizationsFromFile(params.letter);

		if ( isStruct(loc.countFile) ) {
			loc.countFile = loc.countFile.texts.recordCount;
		
		} else {
			loc.countFile = 0;
		}

	</cfscript>
</cfoutput>