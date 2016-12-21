<cfcomponent output="false">
	<cffunction name="init" returntype="struct" access="public">
		<cfscript>
			var loc = {};

			// cfwheels version string
			this.version = "1.1,1.1.1,1.1.2,1.1.3,1.1.4,1.1.5,1.1.6,1.1.7,1.1.8,1.4.5";

			// get cfwheels plugin prefix
			loc.prefix = ListChangeDelims(application[$wheelsKey()].webPath & application[$wheelsKey()].pluginPath, ".", "/");

			// initialize coldroute mapper
			application[$wheelsKey()].coldroute = CreateObject("component", "#loc.prefix#.coldroute.lib.Mapper").init();

			// set wheels setting for resource controller naming
			// NOTE: options are singular, plural, or name
			if (NOT StructKeyExists(application[$wheelsKey()], "resourceControllerNaming"))
				application[$wheelsKey()].resourceControllerNaming = "plural";

			return this;
		</cfscript>
	</cffunction>

	<cffunction name="drawRoutes" mixin="application" returntype="struct" output="false" access="public" hint="Start drawing routes">
		<cfargument name="restful" type="boolean" default="true" hint="Pass 'true' to enable RESTful routes" />
		<cfargument name="methods" type="boolean" default="#arguments.restful#" hint="Pass 'true' to enable routes distinguished by HTTP method" />
		<cfreturn application[$wheelsKey()].coldroute.draw(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="toParam" mixin="model" returntype="any" access="public" output="false" hint="Turn model object into key acceptable for use in URL. Can be overridden per model.">
		<cfscript>

			// call wheels key() method by default
			return key();
		</cfscript>
	</cffunction>

	<cffunction name="linkTo" mixin="controller" returntype="any" access="public" output="false" hint="Allow data-method and data-confirm on links">
		<cfscript>
			var loc = {};
			var coreLinkTo = core.linkTo;

			// look for passed in rest method
			if (StructKeyExists(arguments, "method")) {

				// if dealing with delete, keep robots from following link
				if (arguments.method EQ "delete") {
					if (NOT StructKeyExists(arguments, "rel"))
						arguments.rel = "";
					arguments.rel = ListAppend(arguments.rel, "no-follow", " ");
				}

				// put the method in a data attribute
				arguments["data-method"] = arguments.method;
				StructDelete(arguments, "method");
			}

			// set confirmation text for link
			if (StructKeyExists(arguments, "confirm")) {
				arguments["data-confirm"] = arguments.confirm;
				StructDelete(arguments, "confirm");
			}

			// set up remote links
			if (StructKeyExists(arguments, "remote")) {
				arguments["data-remote"] = arguments.remote;
				StructDelete(arguments, "remote");
			}

			// hyphenize any other data attributes
			for (loc.key in arguments) {
				if (REFind("^data[A-Z]", loc.key)) {
					arguments[hyphenize(loc.key)] = arguments[loc.key];
					StructDelete(arguments, loc.key);
				}
			}

			return coreLinkTo(argumentCollection=arguments);
		</cfscript>
	</cffunction>

    <cffunction name="startFormTag" mixin="controller" returntype="string" access="public" output="false" hint="Make it easy for the developer to create forms with the proper http method specified">
    	<cfscript>
        	var loc = { routeAndMethodMatch = false };
			var coreStartFormTag = core.startFormTag;

			// if we don't have a route and method passed in, just return the output from the core method
			if (!StructKeyExists(arguments, "route") || !StructKeyExists(arguments, "method"))
				return coreStartFormTag(argumentCollection=arguments);

			// throw a nice wheels error if the developer passes in a route that was not generated
			if (application[$wheelsKey()].showErrorInformation && !StructKeyExists(application[$wheelsKey()].namedRoutePositions, arguments.route))
				$throw(type="Wheels", message="Route Not Found", extendedInfo="The route specified `#arguments.route#` does not exist!");

			// check to see if the route specified has a method to match the one passed in
			for (loc.position in ListToArray(application[$wheelsKey()].namedRoutePositions[arguments.route]))
				if (StructKeyExists(application[$wheelsKey()].routes[loc.position], "methods") && ListFindNoCase(application[$wheelsKey()].routes[loc.position].methods, arguments.method))
					loc.routeAndMethodMatch = true;

			// if we don't have a match, just return the output
			if (!loc.routeAndMethodMatch)
				return coreStartFormTag(argumentCollection=arguments);

			// save the method passed in
			loc.method = arguments.method;

			if (arguments.method != "get")
				arguments.method = "post";

			loc.returnValue = coreStartFormTag(argumentCollection=arguments);

			// make it easy for the developer and add in everything they need
			if (loc.method != "get")
				loc.returnValue = loc.returnValue & hiddenFieldTag(name="_method", value=loc.method);
        </cfscript>
        <cfreturn loc.returnValue />
    </cffunction>

	<cffunction name="URLFor" returntype="string" access="public" output="false">
		<cfargument name="route" type="string" required="false" default="" hint="Name of a route that you have configured in `config/routes.cfm`.">
		<cfargument name="controller" type="string" required="false" default="" hint="Name of the controller to include in the URL.">
		<cfargument name="action" type="string" required="false" default="" hint="Name of the action to include in the URL.">
		<cfargument name="key" type="any" required="false" default="" hint="Key(s) to include in the URL.">
		<cfargument name="params" type="string" required="false" default="" hint="Any additional params to be set in the query string.">
		<cfargument name="anchor" type="string" required="false" default="" hint="Sets an anchor name to be appended to the path.">
		<cfargument name="onlyPath" type="boolean" required="false" hint="If `true`, returns only the relative URL (no protocol, host name or port).">
		<cfargument name="host" type="string" required="false" hint="Set this to override the current host.">
		<cfargument name="protocol" type="string" required="false" hint="Set this to override the current protocol.">
		<cfargument name="port" type="numeric" required="false" hint="Set this to override the current port number.">
		<cfargument name="$URLRewriting" type="string" required="false" default="#application[$wheelsKey()].URLRewriting#">
		<cfscript>
			var loc = {};
			loc.coreVariables = "controller,action,key,format";
			loc.returnValue = $args(name="URLFor", args=arguments, cachable=true);
			if (StructKeyExists(loc, "returnValue"))
				return loc.returnValue;

			// error if host or protocol are passed with onlyPath=true
			if (application[$wheelsKey()].showErrorInformation AND arguments.onlyPath AND (Len(arguments.host) OR Len(arguments.protocol)))
				$throw(type="Wheels.IncorrectArguments", message="Can't use the `host` or `protocol` arguments when `onlyPath` is `true`.", extendedInfo="Set `onlyPath` to `false` so that `linkTo` will create absolute URLs and thus allowing you to set the `host` and `protocol` on the link.");

			// Look up actual route paths instead of providing default Wheels path generation
			if (arguments.route EQ "" AND arguments.action NEQ "") {
				if (arguments.controller EQ "")
					arguments.controller = variables.params.controller;

				// determine key and look up cache structure
				loc.key = arguments.controller & "##" & arguments.action;
				loc.cache = $urlForCache();

				// if route has already been found, just use it
				if (StructKeyExists(loc.cache, loc.key)) {
					arguments.route = loc.cache[loc.key];

				} else {

					// loop over routes to find matching one
					loc.iEnd = ArrayLen(application[$wheelsKey()].routes);
					for (loc.i = 1; loc.i LTE loc.iEnd; loc.i++) {
						loc.curr = application[$wheelsKey()].routes[loc.i];

						// if found, cache the route name, set up arguments, and break from loop
						if (StructKeyExists(loc.curr, "controller") AND loc.curr.controller EQ arguments.controller AND StructKeyExists(loc.curr, "action") AND loc.curr.action EQ arguments.action) {
							arguments.route = application[$wheelsKey()].routes[loc.i].name;
							loc.cache[loc.key] = arguments.route;
							break;
						}
					}
				}
			}

			// look up route pattern to use
			if (arguments.route NEQ "") {
				loc.route = $findRoute(argumentCollection=arguments);
				loc.variables = loc.route.variables;
				loc.returnValue = loc.route.pattern;

			// use default route pattern
			} else {
				loc.route = {};
				loc.variables = loc.coreVariables;
				loc.returnValue = "/[controller]/[action]/[key].[format]";

				// set controller and action based on controller params
				if (StructKeyExists(variables, "params")) {
					if (arguments.action EQ "" AND StructKeyExists(variables.params, "action") AND (arguments.controller NEQ "" OR arguments.key NEQ "" OR StructKeyExists(arguments, "format")))
						arguments.action = variables.params.action;
					if (arguments.controller EQ "" AND StructKeyExists(variables.params, "controller"))
						arguments.controller = variables.params.controller;
				}
			}

			// replace pattern if there is no rewriting enabled
			if (arguments.$URLRewriting EQ "Off") {
				loc.variables = ListPrepend(loc.variables, loc.coreVariables);
				loc.returnValue = "?controller=[controller]&action=[action]&key=[key]&format=[format]";
			}

			// replace each params variable with the correct value
			loc.iEnd = ListLen(loc.variables);
			for (loc.i = 1; loc.i LTE loc.iEnd; loc.i++) {
				loc.property = ListGetAt(loc.variables, loc.i);
				loc.reg = "\[\*?#loc.property#\]";

				// read necessary variables from different sources
				if (StructKeyExists(arguments, loc.property) AND Len(arguments[loc.property]))
					loc.value = arguments[loc.property];
				else if (StructKeyExists(loc.route, loc.property))
					loc.value = loc.route[loc.property];
				else if (arguments.route NEQ "" AND arguments.$URLRewriting NEQ "Off")
					$throw(type="Wheels.IncorrectRoutingArguments", message="Incorrect Arguments", extendedInfo="The route chosen by Wheels `#loc.route.name#` requires the argument `#loc.property#`. Pass the argument `#loc.property#` or change your routes to reflect the proper variables needed.");
				else
					continue;

				// if value is a model object, get its key value
				if (IsObject(loc.value))
					loc.value = loc.value.toParam();

				// if property is not in pattern, store it in the params argument
				if (NOT REFind(loc.reg, loc.returnValue)) {
					if (NOT	ListFindNoCase(loc.coreVariables, loc.property))
						arguments.params = ListAppend(arguments.params, "#loc.property#=#loc.value#", "&");
					continue;
				}

				// transform value before setting it in pattern
				if (loc.property EQ "controller" OR loc.property EQ "action")
					loc.value = hyphenize(loc.value);
				else if (application[$wheelsKey()].obfuscateUrls)
					loc.value = obfuscateParam(loc.value);

				loc.returnValue = REReplace(loc.returnValue, loc.reg, loc.value);
			}

			// clean up unused keys in pattern
			loc.returnValue = REReplace(loc.returnValue, "((&|\?)\w+=|/|\.)\[\*?\w+\]", "", "ALL");

			// apply anchor and additional parameters
			if (Len(arguments.params))
				loc.returnValue = loc.returnValue & $constructParams(params=arguments.params, $URLRewriting=arguments.$URLRewriting);
			if (Len(arguments.anchor))
				loc.returnValue = loc.returnValue & "##" & arguments.anchor;

			// apply needed path prefix depending on rewrite style
			if (arguments.$URLRewriting EQ "Partial")
				loc.returnValue = application[$wheelsKey()].rewriteFile & loc.returnValue;
			else if (arguments.$URLRewriting EQ "Off")
				loc.returnValue = "index.cfm" & loc.returnValue;
			loc.returnValue = application[$wheelsKey()].webPath & loc.returnValue;
			loc.returnValue = Replace(loc.returnValue, "//", "/", "ALL");

			// prepend necessary url information
			if (NOT arguments.onlyPath){
				if (arguments.port NEQ 0)
					loc.returnValue = ":" & arguments.port & loc.returnValue; // use the port that was passed in by the developer
				else if (request.cgi.server_port NEQ 80 AND request.cgi.server_port NEQ 443)
					loc.returnValue = ":" & request.cgi.server_port & loc.returnValue; // if the port currently in use is not 80 or 443 we set it explicitly in the URL
				if (Len(arguments.host))
					loc.returnValue = arguments.host & loc.returnValue;
				else
					loc.returnValue = request.cgi.server_name & loc.returnValue;
				if (Len(arguments.protocol))
					loc.returnValue = arguments.protocol & "://" & loc.returnValue;
				else
					loc.returnValue = SpanExcluding(LCase(request.cgi.server_protocol), "/") & "://" & loc.returnValue;
			}
		</cfscript>
		<cfreturn loc.returnValue />
	</cffunction>

	<cffunction name="$urlForCache" mixin="global" returntype="struct" access="public" hint="Lazy-create a request-level cache for found routes">
		<cfscript>
			if (NOT StructKeyExists(request.wheels, "urlForCache"))
				request.wheels.urlForCache = {};
			return request.wheels.urlForCache;
		</cfscript>
	</cffunction>

	<cffunction name="$getRequestMethod" mixin="dispatch" returntype="string" access="public" hint="Determine HTTP verb used in request">
		<cfscript>
			// if request is a post, check for alternate verb
			if (cgi.request_method EQ "post" AND StructKeyExists(form, "_method"))
				return form["_method"];

			// if request is a get, check for alternate verb
			if (cgi.request_method EQ "get" AND StructKeyExists(url, "_method"))
				return url["_method"];

			return cgi.request_method;
		</cfscript>
	</cffunction>

	<cffunction name="$loadRoutes" mixin="application,dispatch" returntype="void" access="public" output="false" hint="Prevent race condition when reloading routes in design mode">
		<cfset var coreLoadRoutes = core.$loadRoutes />
		<cflock name="coldrouteLoadRoutes" timeout="5" type="exclusive">
			<cfset coreLoadRoutes() />
		</cflock>
	</cffunction>

	<cffunction name="$findMatchingRoute" mixin="dispatch" returntype="struct" access="public" hint="Help Wheels match routes using path and HTTP method">
		<cfargument name="path" type="string" required="true" />
		<cfargument name="requestMethod" type="string" required="false" default="#$getRequestMethod()#" />
		<cfscript>
			var loc = {};

			// loop over wheels routes
			loc.iEnd = ArrayLen(application[$wheelsKey()].routes);
			for (loc.i = 1; loc.i LTE loc.iEnd; loc.i++) {
				loc.route = application[$wheelsKey()].routes[loc.i];

				// if method doesn't match, skip this route
				if (StructKeyExists(loc.route, "methods") AND NOT ListFindNoCase(loc.route.methods, arguments.requestMethod))
					continue;

				// make sure route has been converted to regex
				if (NOT StructKeyExists(loc.route, "regex"))
					loc.route.regex = application[$wheelsKey()].coldroute.patternToRegex(loc.route.pattern);

				// if route matches regular expression, set it for return
				if (REFindNoCase(loc.route.regex, arguments.path) OR (arguments.path EQ "" AND loc.route.pattern EQ "/")) {
					loc.returnValue = Duplicate(application[$wheelsKey()].routes[loc.i]);
					break;
				}
			}

			// throw error if not route was found
			if (NOT StructKeyExists(loc, "returnValue"))
				$throw(type="Wheels.RouteNotFound", message="Wheels couldn't find a route that matched this request.", extendedInfo="Make sure there is a route setup in your 'config/routes.cfm' file that matches the '#arguments.path#' request.");
		</cfscript>
		<cfreturn loc.returnValue />
	</cffunction>

	<cffunction name="$mergeRoutePattern" returntype="struct" access="public" output="false" mixin="dispatch,controller" hint="Pull route variables out of path">
		<cfargument name="params" type="struct" required="true">
		<cfargument name="route" type="struct" required="true">
		<cfargument name="path" type="string" required="true">
		<cfscript>
			var loc = {};
			loc.matches = REFindNoCase(arguments.route.regex, arguments.path, 1, true);
			loc.iEnd = ArrayLen(loc.matches.pos);
			for (loc.i = 2; loc.i LTE loc.iEnd; loc.i++) {
				loc.key = ListGetAt(arguments.route.variables, loc.i - 1);
				arguments.params[loc.key] = Mid(arguments.path, loc.matches.pos[loc.i], loc.matches.len[loc.i]);
			}
			return arguments.params;
		</cfscript>
	</cffunction>

	<!--- TODO: patch this in wheels code --->
	<cffunction name="$getPathFromRequest" returntype="string" access="public" hint="Don't split incoming paths at `.` like Wheels does">
		<cfargument name="pathInfo" type="string" required="true">
		<cfargument name="scriptName" type="string" required="true">
		<cfscript>
			var returnValue = "";
			// we want the path without the leading "/" so this is why we do some checking here
			if (arguments.pathInfo == arguments.scriptName || arguments.pathInfo == "/" || arguments.pathInfo == "")
				returnValue = "";
			else
				returnValue = Right(arguments.pathInfo, Len(arguments.pathInfo)-1);
		</cfscript>
		<cfreturn returnValue>
	</cffunction>

	<cffunction name="$registerNamedRouteMethods" mixin="controller" returntype="void" access="public" hint="Filter that sets up named route helper methods">
		<cfscript>
			var loc = {};
			for (loc.key in application[$wheelsKey()].namedRoutePositions) {
				variables[loc.key & "Path"] = $namedRouteMethod;
				variables[loc.key & "Url"] = $namedRouteMethod;
			}
		</cfscript>
	</cffunction>

	<cffunction name="$namedRouteMethod" mixin="controller" returntype="string" access="public" output="false" hint="Body of all named route helper methods">
		<cfscript>
			var loc = {};

			// FIX: numbered arguments with StructDelete() are breaking in CF 9.0.1, this hack fixes it
			arguments = Duplicate(arguments);

			// determine route name and path type
			arguments.route = GetFunctionCalledName();
			if (REFindNoCase("Path$", arguments.route)) {
				arguments.route = REReplaceNoCase(arguments.route, "^(.+)Path$", "\1");
				arguments.onlyPath = true;
			} else if (REFindNoCase("Url$", arguments.route)) {
				arguments.route = REReplaceNoCase(arguments.route, "^(.+)Url$", "\1");
				arguments.onlyPath = false;
			}

			// get the matching route and any required variables
			if (StructKeyExists(application[$wheelsKey()].namedRoutePositions, arguments.route)) {
				loc.routePos = application[$wheelsKey()].namedRoutePositions[arguments.route];

				// for backwards compatibility, allow loc.routePos to be a list
				if (IsArray(loc.routePos))
					loc.pos = loc.routePos[1];
				else
					loc.pos = ListFirst(loc.routePos);

				// grab first route found
				// todo: don't just accept the first route found
				loc.route = application[$wheelsKey()].routes[loc.pos];
				loc.vars = ListToArray(loc.route.variables);

				// loop over variables needed for route
				loc.iEnd = ArrayLen(loc.vars);
				for (loc.i = 1; loc.i LTE loc.iEnd; loc.i++) {
					loc.key = loc.vars[loc.i];

					// try to find the correct argument
					if (StructKeyExists(arguments, loc.key)) {
						loc.value = arguments[loc.key];
						StructDelete(arguments, loc.key);
					} else if (StructKeyExists(arguments, loc.i)) {
						loc.value = arguments[loc.i];
						StructDelete(arguments, loc.i);
					}

					// if value was passed in
					if (StructKeyExists(loc, "value")) {

						// just assign simple values
						if (NOT IsObject(loc.value)) {
							arguments[loc.key] = loc.value;

						// if object, do special processing
						} else {

							// if the passed in object is new, link to the plural REST route instead
							if (loc.value.isNew()) {
								if (StructKeyExists(application[$wheelsKey()].namedRoutePositions, pluralize(arguments.route))) {
									arguments.route = pluralize(arguments.route);
									break;
								}

							// otherwise, use the Model#toParam method
							} else {
								arguments[loc.key] = loc.value.toParam();
							}
						}

						// remove value for next loop
						StructDelete(loc, "value");
					}
				}
			}

			// return correct url with arguments set
			return urlFor(argumentCollection=arguments);
		</cfscript>
	</cffunction>

    <!---
		James Gibson:
		These are the necessary changes to wheels to allow controllers to be nested.
		These changes have already been committed to core but have not made it into
		a release.

		These changes also fix $ensureControllerAndAction to allow "." in the action
		and controller name.
	--->

    <cffunction name="$ensureControllerAndAction" mixin="dispatch" returntype="struct" access="public" output="false" hint="ensure that the controller and action params exists and camelized">
        <cfargument name="params" type="struct" required="true">
        <cfargument name="route" type="struct" required="true">
        <cfscript>
            if (!StructKeyExists(arguments.params, "controller"))
            {
                arguments.params.controller = arguments.route.controller;
            }
            if (!StructKeyExists(arguments.params, "action"))
            {
                arguments.params.action = arguments.route.action;
            }

            // filter out illegal characters from the controller and action arguments
            arguments.params.controller = ReReplace(arguments.params.controller, "[^0-9A-Za-z-_\.]", "", "all");
            arguments.params.action = ReReplace(arguments.params.action, "[^0-9A-Za-z-_\.]", "", "all");

			arguments.params.controller = ListSetAt(arguments.params.controller, ListLen(arguments.params.controller, "."), REReplace(ListLast(arguments.params.controller, "."), "(^|-)([a-z])", "\u\2", "all"), ".");
			arguments.params.action = REReplace(arguments.params.action, "-([a-z])", "\u\1", "all");
        </cfscript>
        <cfreturn arguments.params>
    </cffunction>

    <cffunction name="$initControllerObject" mixin="controller" returntype="any" access="public" output="false">
        <cfargument name="name" type="string" required="true">
        <cfargument name="params" type="struct" required="true">
        <cfscript>
            var loc = {};

            // create a struct for storing request specific data
            variables.$instance = {};
            variables.$instance.contentFor = {};

            // include controller specific helper files if they exist, cache the file check for performance reasons
            loc.helperFileExists = false;
            if (!ListFindNoCase(application[$wheelsKey()].existingHelperFiles, arguments.name) && !ListFindNoCase(application[$wheelsKey()].nonExistingHelperFiles, arguments.name))
            {
                if (FileExists(ExpandPath("#application[$wheelsKey()].viewPath#/#LCase(ListChangeDelims(arguments.name, '/', '.'))#/helpers.cfm")))
                    loc.helperFileExists = true;
                if (application[$wheelsKey()].cacheFileChecking)
                {
                    if (loc.helperFileExists)
                        application[$wheelsKey()].existingHelperFiles = ListAppend(application[$wheelsKey()].existingHelperFiles, arguments.name);
                    else
                        application[$wheelsKey()].nonExistingHelperFiles = ListAppend(application[$wheelsKey()].nonExistingHelperFiles, arguments.name);
                }
            }
            if (ListFindNoCase(application[$wheelsKey()].existingHelperFiles, arguments.name) || loc.helperFileExists)
                $include(template="#application[$wheelsKey()].viewPath#/#ListChangeDelims(arguments.name, '/', '.')#/helpers.cfm");

            loc.executeArgs = {};
            loc.executeArgs.name = arguments.name;
            $simpleLock(name="controllerLock", type="readonly", execute="$setControllerClassData", executeArgs=loc.executeArgs);

            variables.params = arguments.params;
        </cfscript>
        <cfreturn this>
    </cffunction>

    <cffunction name="$callAction" mixin="controller" returntype="void" access="public" output="false">
        <cfargument name="action" type="string" required="true">
        <cfscript>
            var loc = {};

            if (Left(arguments.action, 1) == "$" || ListFindNoCase(application[$wheelsKey()].protectedControllerMethods, arguments.action))
                $throw(type="Wheels.ActionNotAllowed", message="You are not allowed to execute the `#arguments.action#` method as an action.", extendedInfo="Make sure your action does not have the same name as any of the built-in Wheels functions.");

            if (StructKeyExists(this, arguments.action) && IsCustomFunction(this[arguments.action]))
            {
                $invoke(method=arguments.action);
            }
            else if (StructKeyExists(this, "onMissingMethod"))
            {
                loc.invokeArgs = {};
                loc.invokeArgs.missingMethodName = arguments.action;
                loc.invokeArgs.missingMethodArguments = {};
                $invoke(method="onMissingMethod", invokeArgs=loc.invokeArgs);
            }

            if (!$performedRenderOrRedirect())
            {
                try
                {
                    renderPage();
                }
                catch(Any e)
                {
                    if (FileExists(ExpandPath("#application[$wheelsKey()].viewPath#/#LCase(ListChangeDelims(variables.$class.name, '/', '.'))#/#LCase(arguments.action)#.cfm")))
                    {
                        $throw(object=e);
                    }
                    else
                    {
                        if (application[$wheelsKey()].showErrorInformation)
                        {
                            $throw(type="Wheels.ViewNotFound", message="Could not find the view page for the `#arguments.action#` action in the `#variables.$class.name#` controller.", extendedInfo="Create a file named `#LCase(arguments.action)#.cfm` in the `views/#LCase(ListChangeDelims(variables.$class.name, '/', '.'))#` directory (create the directory as well if it doesn't already exist).");
                        }
                        else
                        {
                            $header(statusCode="404", statusText="Not Found");
                            $includeAndOutput(template="#application[$wheelsKey()].eventPath#/onmissingtemplate.cfm");
                            $abort();
                        }
                    }
                }
            }
        </cfscript>
    </cffunction>

    <cffunction name="$renderPage" mixin="controller" returntype="string" access="public" output="false">
        <cfscript>
            var loc = {};
            if (!Len(arguments.$template))
                arguments.$template = "/" & ListChangeDelims(arguments.$controller, '/', '.') & "/" & arguments.$action;
            arguments.$type = "page";
            arguments.$name = arguments.$template;
            arguments.$template = $generateIncludeTemplatePath(argumentCollection=arguments);
            loc.content = $includeFile(argumentCollection=arguments);
            loc.returnValue = $renderLayout($content=loc.content, $layout=arguments.$layout, $type=arguments.$type);
        </cfscript>
        <cfreturn loc.returnValue>
    </cffunction>

    <cffunction name="$generateIncludeTemplatePath" mixin="controller" returntype="string" access="public" output="false">
        <cfargument name="$name" type="any" required="true">
        <cfargument name="$type" type="any" required="true">
        <cfargument name="$controllerName" type="string" required="false" default="#variables.params.controller#" />
        <cfargument name="$baseTemplatePath" type="string" required="false" default="#application[$wheelsKey()].viewPath#" />
        <cfargument name="$prependWithUnderscore" type="boolean" required="false" default="true">
        <cfscript>
            var loc = {};
            loc.include = arguments.$baseTemplatePath;
            loc.fileName = ReplaceNoCase(Reverse(ListFirst(Reverse(arguments.$name), "/")), ".cfm", "", "all") & ".cfm"; // extracts the file part of the path and replace ending ".cfm"
            if (arguments.$type == "partial" && arguments.$prependWithUnderscore)
                loc.fileName = Replace("_" & loc.fileName, "__", "_", "one"); // replaces leading "_" when the file is a partial
            loc.folderName = Reverse(ListRest(Reverse(arguments.$name), "/"));
            if (Left(arguments.$name, 1) == "/")
                loc.include = loc.include & loc.folderName & "/" & loc.fileName; // Include a file in a sub folder to views
            else if (arguments.$name Contains "/")
                loc.include = loc.include & "/" & ListChangeDelims(arguments.$controllerName, '/', '.') & "/" & loc.folderName & "/" & loc.fileName; // Include a file in a sub folder of the current controller
            else
                loc.include = loc.include & "/" & ListChangeDelims(arguments.$controllerName, '/', '.') & "/" & loc.fileName; // Include a file in the current controller's view folder
        </cfscript>
        <cfreturn LCase(loc.include) />
    </cffunction>

    <cffunction name="$initControllerClass" mixin="controller" returntype="any" access="public" output="false">
        <cfargument name="name" type="string" required="false" default="">
        <cfscript>
            variables.$class.name = arguments.name;
            variables.$class.path = arguments.path;

			// the name of the controller should reflect it's pathing wherever it's located

            // if our name has pathing in it, remove it and add it to the end of of the $class.path variable
            // if (Find("/", arguments.name))
            // {
            //     variables.$class.name = ListLast(arguments.name, "/");
            //     variables.$class.path = ListAppend(arguments.path, ListDeleteAt(arguments.name, ListLen(arguments.name, "/"), "/"), "/");
            // }

            variables.$class.verifications = [];
            variables.$class.filters = [];
            variables.$class.cachableActions = [];
            variables.$class.layout = {};

            // default the controller to only respond to html
            variables.$class.formats = {};
            variables.$class.formats.default = "html";
            variables.$class.formats.actions = {};
            variables.$class.formats.existingTemplates = "";
            variables.$class.formats.nonExistingTemplates = "";

            $setFlashStorage(get("flashStorage"));
            if (StructKeyExists(variables, "init"))
                init();

			filters(through="$registerNamedRouteMethods");
        </cfscript>
        <cfreturn this>
    </cffunction>

    <cffunction name="$objectFileName" mixin="global" returntype="string" access="public" output="false">
        <cfargument name="name" type="string" required="true">
        <cfargument name="objectPath" type="string" required="true">
        <cfargument name="type" type="string" required="true" hint="Can be either `controller` or `model`." />
        <cfscript>
            var loc = {};
            loc.objectFileExists = false;

			// the code below is now handled in the dispatch object

            // if the name contains the delimiter let's capitalize the last element and append it back to the list
            // if (ListLen(arguments.name, ".") gt 1)
            //     arguments.name = ListInsertAt(arguFments.name, ListLen(arguments.name, "."), capitalize(ListLast(arguments.name, ".")), ".");
            // else
            //     arguments.name = capitalize(arguments.name);

            // we are going to store the full controller path in the existing / non-existing lists so we can have controllers in multiple places
            loc.fullObjectPath = arguments.objectPath & "/" & ListChangeDelims(arguments.name, '/', '.');

            if (!ListFindNoCase(application[$wheelsKey()].existingObjectFiles, loc.fullObjectPath) && !ListFindNoCase(application[$wheelsKey()].nonExistingObjectFiles, loc.fullObjectPath))
            {
                if (FileExists(ExpandPath("#loc.fullObjectPath#.cfc")))
                    loc.objectFileExists = true;
                if (application[$wheelsKey()].cacheFileChecking)
                {
                    if (loc.objectFileExists)
                        application[$wheelsKey()].existingObjectFiles = ListAppend(application[$wheelsKey()].existingObjectFiles, loc.fullObjectPath);
                    else
                        application[$wheelsKey()].nonExistingObjectFiles = ListAppend(application[$wheelsKey()].nonExistingObjectFiles, loc.fullObjectPath);
                }
            }
            if (ListFindNoCase(application[$wheelsKey()].existingObjectFiles, loc.fullObjectPath) || loc.objectFileExists)
                loc.returnValue = arguments.name;
            else
                loc.returnValue = capitalize(arguments.type);
        </cfscript>
        <cfreturn loc.returnValue>
    </cffunction>

	<cffunction name="$generateRenderWithTemplatePath" access="public" output="false" returntype="string" hint="">
		<cfargument name="controller" type="string" required="true">
		<cfargument name="action" type="string" required="true">
		<cfargument name="template" type="string" required="true">
		<cfargument name="contentType" type="string" required="true">
		<cfscript>
			var templateName = "";

			if (!Len(arguments.template))
				templateName = "/" & Replace(arguments.controller, ".", "/", "all") & "/" & arguments.action;
			else
				templateName = arguments.template;

			if (Len(arguments.contentType))
				templateName = templateName & "." & arguments.contentType;
		</cfscript>
		<cfreturn templateName />
	</cffunction>

	<cffunction name="$wheelsKey" returntype="string" access="public" output="false">
		<cfscript>
		var loc = {};
		loc.returnValue = "wheels";
		if (StructKeyExists(application, "$wheels"))
		{
			loc.returnValue = "$wheels";
		}
		</cfscript>
		<cfreturn loc.returnValue>
	</cffunction>
</cfcomponent>
