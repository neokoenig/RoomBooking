<cffunction name="flash" mixin="controller" returntype="any" access="public" output="false" hint="Returns the value of a specific key in the Flash (or the entire Flash as a struct if no key is passed in)."
	examples=
	'
		<!--- Display "message" item in flash --->
		<cfoutput>
			<cfif flashKeyExists("message")>
				<p class="message">
					##flash("message")##
				</p>
			</cfif>
		</cfoutput>

		<!--- Display all flash items --->
		<cfoutput>
			<cfset allFlash = flash()>
			<cfloop list="##StructKeyList(allFlash)##" index="flashItem">
				<p class="##flashItem##">
					##flash(flashItem)##
				</p>
			</cfloop>
		</cfoutput>
	'
	categories="controller-request,flash" chapters="using-the-flash" functions="flashClear,flashCount,flashDelete,flashInsert,flashIsEmpty,flashKeep,flashKeyExists,flashMessages">
	<cfargument name="key" type="string" required="false" hint="The key to get the value for.">
	<cfargument name="prepend" required="false" hint="String to prepend to the flash. Useful to wrap the flash with HTML tags.">
	<cfargument name="append" required="false" hint="String to append to the flash. Useful to wrap the flash with HTML tags.">
	<cfscript>
		
		var $flash = $readFlash();
		$args(name="flash", args=arguments);
		if (StructKeyExists(arguments, "key"))
		{
			if (StructKeyExists(arguments, "prepend"))
			{
				// if flash key name is one of set values, add corresponding Twitter Bootstrap class
				switch(arguments.key)
				{
					case "error":
						arguments.prepend = ReReplace(arguments.prepend, "class=('|"")alert('|"")", "class=""alert alert-error""");
						break;
					case "info":
						arguments.prepend = ReReplace(arguments.prepend, "class=('|"")alert('|"")", "class=""alert alert-info""");
						break;
					case "success":
						arguments.prepend = ReReplace(arguments.prepend, "class=('|"")alert('|"")", "class=""alert alert-success""");
						break;
				}
			}
			
			if (flashKeyExists(key=arguments.key, $flash=$flash))
				$flash = $flash[arguments.key];
			else
				$flash = "";
		}
		
		// Only add prepend and append values to the flash if its value is not empty.
		if ($flash == "")
		{
			return $flash;
		}
		else
		{
			if (StructKeyExists(arguments, "prepend") && StructKeyExists(arguments, "append"))
			{
				return arguments.prepend & $flash & arguments.append;
			}
			else if (StructKeyExists(arguments, "prepend"))
			{
				return arguments.prepend & $flash;
			}
			else if (StructKeyExists(arguments, "append"))
			{
				return $flash & arguments.append;
			}
			else
			{
				return $flash;
			}
		}
	</cfscript>
</cffunction>

<cffunction name="flashMessages" mixin="controller" returntype="string" access="public" output="false" hint="Displays a marked-up listing of messages that exists in the Flash."
	examples=
	'
		<!--- In the controller action --->
		<cfset flashInsert(success="Your post was successfully submitted.")>
		<cfset flashInsert(alert="Don''t forget to tweet about this post!")>
		<cfset flashInsert(error="This is an error message.")>

		<!--- In the layout or view --->
		<cfoutput>
			##flashMessages()##
		</cfoutput>
		<!---
			Generates this (sorted alphabetically):
			<div class="flashMessages">
				<p class="alertMessage">
					Don''t forget to tweet about this post!
				</p>
				<p class="errorMessage">
					This is an error message.
				</p>
				<p class="successMessage">
					Your post was successfully submitted.
				</p>
			</div>
		--->

		<!--- Only show the "success" key in the view --->
		<cfoutput>
			##flashMessages(key="success")##
		</cfoutput>
		<!---
			Generates this:
			<div class="flashMessage">
				<p class="successMessage">
					Your post was successfully submitted.
				</p>
			</div>
		--->

		<!--- Show only the "success" and "alert" keys in the view, in that order --->
		<cfoutput>
			##flashMessages(keys="success,alert")##
		</cfoutput>
		<!---
			Generates this (sorted alphabetically):
			<div class="flashMessages">
				<p class="successMessage">
					Your post was successfully submitted.
				</p>
				<p class="alertMessage">
					Don''t forget to tweet about this post!
				</p>
			</div>
		--->
	'
	categories="controller-request,flash" chapters="using-the-flash" functions="flash,flashClear,flashCount,flashDelete,flashInsert,flashIsEmpty,flashKeep,flashKeyExists">
	<cfargument name="keys" type="string" required="false" hint="The key (or list of keys) to show the value for. You can also use the `key` argument instead for better readability when accessing a single key.">
	<cfargument name="class" type="string" required="false" hint="HTML `class` to set on the `div` element that contains the messages.">
	<cfargument name="includeEmptyContainer" type="boolean" required="false" hint="Includes the DIV container even if the flash is empty.">
	<cfargument name="lowerCaseDynamicClassValues" type="boolean" required="false" hint="Outputs all class attribute values in lower case (except the main one).">
	<cfargument name="prependToValue" required="false" hint="String to prepend to each flash value. Useful to wrap each flash value with HTML tags.">
	<cfargument name="appendToValue" required="false" hint="String to append to each flash value. Useful to wrap each flash value with HTML tags.">
	<cfscript>
		// Initialization
		var loc = {};
		loc.$flash = $readFlash();
		loc.returnValue = "";

		$args(name="flashMessages", args=arguments);
		$combineArguments(args=arguments, combine="keys,key", required=false);

		// If no keys are requested, populate with everything stored in the Flash and sort them
		if (!StructKeyExists(arguments, "keys"))
		{
			loc.flashKeys = StructKeyList(loc.$flash);
			loc.flashKeys = ListSort(loc.flashKeys, "textnocase");
		}
		// Otherwise, generate list based on what was passed as `arguments.keys`
		else
		{
			loc.flashKeys = arguments.keys;
		}

		// Generate markup for each Flash item in the list
		loc.listItems = "";
		loc.iEnd = ListLen(loc.flashKeys);
		for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
		{
			loc.item = ListGetAt(loc.flashKeys, loc.i);
			loc.class = loc.item & "Message";
			if (arguments.lowerCaseDynamicClassValues)
				loc.class = LCase(loc.class);
			loc.attributes = {class=loc.class};
			if (!StructKeyExists(arguments, "key") || arguments.key == loc.item)
			{
				loc.content = loc.$flash[loc.item];
				if (IsSimpleValue(loc.content))
				{
					if (StructKeyExists(arguments, "prependToValue"))
					{
						// if flash key name is one of set values, add corresponding Twitter Bootstrap class
						loc.prependToValue = arguments.prependToValue;
						switch(loc.item)
						{
							case "error":
								loc.prependToValue = ReReplace(arguments.prependToValue, "class=('|"")alert('|"")", "class=""alert alert-error""");
								break;
							case "info":
								loc.prependToValue = ReReplace(arguments.prependToValue, "class=('|"")alert('|"")", "class=""alert alert-info""");
								break;
							case "success":
								loc.prependToValue = ReReplace(arguments.prependToValue, "class=('|"")alert('|"")", "class=""alert alert-success""");
								break;
						}
					}
					if (StructKeyExists(arguments, "prependToValue") && StructKeyExists(arguments, "appendToValue"))
					{
						loc.listItems = loc.listItems & loc.prependToValue & $element(name="div", content=loc.content, attributes=loc.attributes) & arguments.appendToValue;
					}
					else if (StructKeyExists(arguments, "prependToValue"))
					{
						loc.listItems = loc.listItems & loc.prependToValue & $element(name="div", content=loc.content, attributes=loc.attributes);
					}
					else if (StructKeyExists(arguments, "appendToValue"))
					{
						loc.listItems = loc.listItems & $element(name="div", content=loc.content, attributes=loc.attributes) & arguments.appendToValue;
					}
					else
					{
						loc.listItems = loc.listItems & $element(name="div", content=loc.content, attributes=loc.attributes);
					}
				}
			}
		}

		if (Len(loc.listItems) || arguments.includeEmptyContainer)
		{
			loc.returnValue = $element(name="div", skip="key,keys,includeEmptyContainer,lowerCaseDynamicClassValues,prependToValue,appendToValue", content=loc.listItems, attributes=arguments);
		}
		return loc.returnValue;
	</cfscript>
</cffunction>