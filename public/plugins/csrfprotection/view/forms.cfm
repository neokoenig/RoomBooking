<cffunction name="$tag" returntype="string" access="public" hint="Overrides CFWheels private `$tag` method to add authenticity token field if this is for a form with `POST` method. We're overriding this because it's common for other plugins like ColdRoute to override `startFormTag`." output="false">
	<cfscript>
		var loc = {};
		loc.coreTag = core.$tag(argumentCollection=arguments);

		if (arguments.name == "form" && ListFindNoCase("post,put,patch,delete", arguments.attributes.method)) {
			loc.coreTag &= authenticityTokenField();
		}
	</cfscript>
	<cfreturn loc.coreTag>
</cffunction>
