<cfcomponent output="false">
	<cfinclude template="#application[$wheelsKey()].webPath#/wheels/global/functions.cfm" />
	
	<cffunction name="init" returntype="struct" access="public">
		<cfargument name="restful" type="boolean" default="true" hint="Pass 'true' to enable RESTful routes" />
		<cfargument name="methods" type="boolean" default="#arguments.restful#" hint="Pass 'true' to enable routes distinguished by HTTP method" />
		<cfscript>
			
			// set up control variables
			variables.scopeStack = ArrayNew(1);
			variables.restful = arguments.restful;
			variables.methods = arguments.restful OR arguments.methods;
			
			// set up default variable constraints
			variables.constraints = {};
			variables.constraints["format"] = "\w+";
			variables.constraints["controller"] = "[^/]+";
			
			// set up constraint for globbed routes
			variables.constraints["\*\w+"] = ".+";
			
			// fix naming collision with cfwheels get() and controller() methods
			this.get = variables.$get;
			this.controller = variables.$controller;
			
			return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="draw" returntype="struct" access="public">
		<cfargument name="restful" type="boolean" default="#variables.restful#" hint="Pass 'true' to enable RESTful routes" />
		<cfargument name="methods" type="boolean" default="#variables.methods#" hint="Pass 'true' to enable routes distinguished by HTTP method" />
		<cfscript>
			variables.restful = arguments.restful;
			variables.methods = arguments.restful OR arguments.methods;
			
			// start with clean scope stack
			// TODO: resolve any race conditions
			variables.scopeStack = ArrayNew(1);
			ArrayPrepend(scopeStack, StructNew());
			variables.scopeStack[1].$call = "draw";
			
			return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="end" returntype="struct" access="public">
		<cfscript>
			// if last action was a resource, set up REST routes
			// TODO: consider non-restful routes
			// create plural resource routes
			if (scopeStack[1].$call EQ "resources") {
				collection();
					if (ListFind(scopeStack[1].actions, "index"))
						$get(pattern="(.[format])", action="index");
					if (ListFindNoCase(scopeStack[1].actions, "create"))
						post(pattern="(.[format])", action="create");
				end();
				if (ListFindNoCase(scopeStack[1].actions, "new")) {
					scope(path=scopeStack[1].collectionPath, $call="new");
						$get(pattern="new(.[format])", action="new", name="new");
					end();
				}
				member();
					if (ListFind(scopeStack[1].actions, "edit"))
						$get(pattern="edit(.[format])", action="edit", name="edit");
					if (ListFind(scopeStack[1].actions, "show"))
						$get(pattern="(.[format])", action="show");
					if (ListFind(scopeStack[1].actions, "update"))
						put(pattern="(.[format])", action="update");
					if (ListFind(scopeStack[1].actions, "delete"))
						delete(pattern="(.[format])", action="delete");
				end();
				
			// create singular resource routes
			} else if (scopeStack[1].$call EQ "resource") {
				if (ListFind(scopeStack[1].actions, "create")) {
					collection();
						post(pattern="(.[format])", action="create");
					end();
				}
				if (ListFind(scopeStack[1].actions, "new")) {
					scope(path=scopeStack[1].memberPath, $call="new");
						$get(pattern="new(.[format])", action="new", name="new");
					end();
				}
				member();
					if (ListFind(scopeStack[1].actions, "edit"))
						$get(pattern="edit(.[format])", action="edit", name="edit");
					if (ListFind(scopeStack[1].actions, "show"))
						$get(pattern="(.[format])", action="show");
					if (ListFind(scopeStack[1].actions, "update"))
						put(pattern="(.[format])", action="update");
					if (ListFind(scopeStack[1].actions, "delete"))
						delete(pattern="(.[format])", action="delete");
				end();
			}
			
			// remove top of stack to end nesting
			ArrayDeleteAt(scopeStack, 1);
			return this;
		</cfscript>
	</cffunction>
	
	<!---------------------
	--- Simple Matching ---
	---------------------->
	
	<cffunction name="match" returntype="struct" access="public" hint="Match a url">
		<cfargument name="name" type="string" required="false" hint="Name for route. Used for path helpers." />
		<cfargument name="pattern" type="string" required="false" hint="Pattern to match for route" />
		<cfargument name="to" type="string" required="false" hint="Set controller##action for route" />
		<cfargument name="methods" type="string" required="false" hint="HTTP verbs that match route" />
		<cfargument name="module" type="string" required="false" hint="Namespace to append to controller" />
		<cfargument name="on" type="string" default="" hint="Created resource route under 'member' or 'collection'" />
		<cfargument name="constraints" type="struct" default="#StructNew()#" />
		<cfscript>
			var loc = {};
			
			// evaluate match on member or collection
			if (arguments.on EQ "member")
				return member().match(argumentCollection=arguments, on="").end();
			if (arguments.on EQ "collection")
				return collection().match(argumentCollection=arguments, on="").end();
			
			// use scoped controller if found
			if (StructKeyExists(scopeStack[1], "controller") AND NOT StructKeyExists(arguments, "controller"))
				arguments.controller = scopeStack[1].controller;
			
			// use scoped module if found
			if (StructKeyExists(scopeStack[1], "module")) {
				if (StructKeyExists(arguments, "module"))
					arguments.module &= "." & scopeStack[1].module;
				else
					arguments.module = scopeStack[1].module;
			}
			
			// interpret 'to' as 'controller#action'
			if (StructKeyExists(arguments, "to")) {
				arguments.controller = ListFirst(arguments.to, "##");
				arguments.action = ListLast(arguments.to, "##");
				StructDelete(arguments, "to");
			}
			
			// pull route name from arguments if it exists
			loc.name = "";
			if (StructKeyExists(arguments, "name")) {
				loc.name = arguments.name;
				
				// guess pattern and/or action
				if (NOT StructKeyExists(arguments, "pattern"))
					arguments.pattern = hyphenize(arguments.name);
				if (NOT StructKeyExists(arguments, "action") AND Find("[action]", arguments.pattern) EQ 0)
					arguments.action = arguments.name;
			}
			
			// die if pattern is not defined
			if (NOT StructKeyExists(arguments, "pattern"))
				throw("Either 'pattern' or 'name' must be defined.");
			
			// accept either 'method' or 'methods'
			if (StructKeyExists(arguments, "method")) {
				arguments.methods = arguments.method;
				StructDelete(arguments, "method");
			}
			
			// remove 'methods' argument if settings disable it
			if (NOT variables.methods AND StructKeyExists(arguments, "methods"))
				StructDelete(arguments, "methods");
			
			// use constraints from stack
			if (StructKeyExists(scopeStack[1], "constraints"))
				StructAppend(arguments.constraints, scopeStack[1].constraints, false);
			
			// add shallow path to pattern
			if ($shallow())
				arguments.pattern = $shallowPathForCall() & "/" & arguments.pattern;
			
			// or, add scoped path to pattern
			else if (StructKeyExists(scopeStack[1], "path"))
				arguments.pattern = scopeStack[1].path & "/" & arguments.pattern;
			
			// if both module and controller are set, combine them
			if (StructKeyExists(arguments, "module") AND StructKeyExists(arguments, "controller")) {
				arguments.controller = arguments.module & "." & arguments.controller;
				StructDelete(arguments, "module");
			}
			
			// build named routes in correct order according to rails conventions
			switch (scopeStack[1].$call) {
				case "resource":
				case "resources":
				case "collection":
					loc.nameStruct = [loc.name, iif($shallow(), "$shallowNameForCall()", "$scopeName()"), $collection()];
					break;
				case "member":
				case "new":
					loc.nameStruct = [loc.name, iif($shallow(), "$shallowNameForCall()", "$scopeName()"), $member()];
					break;
				default:
					loc.nameStruct = [$scopeName(), $collection(), loc.name];
			}
			
			// transform array into named route
			loc.name = ArrayToList(loc.nameStruct);
			loc.name = REReplace(loc.name, "^,+|,+$", "", "ALL");
			loc.name = REReplace(loc.name, ",+(\w)", "\U\1", "ALL");
			loc.name = REReplace(loc.name, ",", "", "ALL");
				
			// if we have a name, add it to arguments
			if (loc.name NEQ "")
				arguments.name = loc.name;
			
			// handle optional pattern segments
			if (arguments.pattern CONTAINS "(") {
				
				// confirm nesting of optional segments
				if (REFind("\).*\(", arguments.pattern))
					$throw(type="Wheels.InvalidRoute", message="Optional pattern segments must be nested.");
				
				// strip closing parens from pattern
				loc.pattern = Replace(arguments.pattern, ")", "", "ALL");
				
				// loop over all possible patterns
				while (loc.pattern NEQ "") {
					
					// add current route to wheels
					$addRoute(argumentCollection=arguments, pattern=Replace(loc.pattern, "(", "", "ALL"));
					
					// remove last optional segment
					loc.pattern = REReplace(loc.pattern, "(^|\()[^(]+$", "");
				}
				
			} else {
				
				// add route to wheels as is
				$addRoute(argumentCollection=arguments);
			}
			
			return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="$get" returntype="struct" access="public" hint="Match a GET url">
		<cfargument name="name" type="string" required="false" />
		<cfreturn match(method="get", argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="post" returntype="struct" access="public" hint="Match a POST url">
		<cfargument name="name" type="string" required="false" />
		<cfreturn match(method="post", argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="put" returntype="struct" access="public" hint="Match a PUT url">
		<cfargument name="name" type="string" required="false" />
		<cfreturn match(method="put", argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="delete" returntype="struct" access="public" hint="Match a DELETE url">
		<cfargument name="name" type="string" required="false" />
		<cfreturn match(method="delete", argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="root" returntype="struct" access="public" hint="Match root directory">
		<cfargument name="to" type="string" required="false" />
		<cfreturn match(name="root", pattern="/(.[format])", argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="wildcard" returntype="struct" access="public" hint="Special wildcard matching">
		<cfargument name="action" default="index" hint="Default action for wildcard patterns" />
		<cfscript>
			if (StructKeyExists(scopeStack[1], "controller")) {
				match(name="wildcard", pattern="[action]/[key](.[format])", action=arguments.action);
				match(name="wildcard", pattern="[action](.[format])", action=arguments.action);
			} else {
				match(name="wildcard", pattern="[controller]/[action]/[key](.[format])", action=arguments.action);
				match(name="wildcard", pattern="[controller](/[action](.[format]))", action=arguments.action);
			}
			return this;
		</cfscript>
	</cffunction>
	
	<!-------------
	--- Scoping ---
	-------------->
	
	<cffunction name="scope" returntype="struct" access="public" hint="Set certain parameters for future calls">
		<cfargument name="name" type="string" required="false" hint="Named route prefix" />
		<cfargument name="path" type="string" required="false" hint="Path prefix" />
		<cfargument name="module" type="string" required="false" hint="Namespace to append to controllers" />
		<cfargument name="controller" type="string" required="false" hint="Controller to use in routes" />
		<cfargument name="shallow" type="boolean" required="false" hint="Turn on shallow resources" />
		<cfargument name="shallowPath" type="string" required="false" hint="Shallow path prefix" />
		<cfargument name="shallowName" type="string" required="false" hint="Shallow name prefix" />
		<cfargument name="constraints" type="struct" required="false" hint="Variable patterns to use for matching" />
		<cfargument name="$call" type="string" default="scope" />
		<cfscript>
			
			// set shallow path and prefix if not in a resource
			if (NOT ListFindNoCase("resource,resources", scopeStack[1].$call)) {
				if (NOT StructKeyExists(arguments, "shallowPath") AND StructKeyExists(arguments, "path"))
					arguments.shallowPath = arguments.path;
				if (NOT StructKeyExists(arguments, "shallowName") AND StructKeyExists(arguments, "name"))
					arguments.shallowName = arguments.name;
			}
			
			// combine path with scope path
			if (StructKeyExists(scopeStack[1], "path") AND StructKeyExists(arguments, "path"))
				arguments.path = normalizePattern(scopeStack[1].path & "/" & arguments.path);
			
			// combine module with scope module
			if (StructKeyExists(scopeStack[1], "module") AND StructKeyExists(arguments, "module"))
				arguments.module = scopeStack[1].module & "." & arguments.module;
				
			// combine name with scope name
			if (StructKeyExists(arguments, "name") AND StructKeyExists(scopeStack[1], "name"))
				arguments.name = scopeStack[1].name & capitalize(arguments.name);
				
			// combine shallow path with scope shallow path
			if (StructKeyExists(scopeStack[1], "shallowPath") AND StructKeyExists(arguments, "shallowPath"))
				arguments.shallowPath = normalizePattern(scopeStack[1].shallowPath & "/" & arguments.shallowPath);
				
			// copy existing constraints if they were previously set
			if (StructKeyExists(scopeStack[1], "constraints") AND StructKeyExists(arguments, "constraints"))
				StructAppend(arguments.constraints, scopeStack[1].constraints, false);
			
			// put scope arguments on the stack
			StructAppend(arguments, scopeStack[1], false);
			ArrayPrepend(scopeStack, arguments);
			return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="namespace" returntype="struct" access="public" hint="Set up namespace for future calls">
		<cfargument name="module" type="string" required="true" />
		<cfargument name="name" type="string" default="#arguments.module#" />
		<cfargument name="path" type="string" default="#hyphenize(arguments.module)#" />
		<cfreturn scope(argumentCollection=arguments, $call="namespace") />
	</cffunction>
	
	<cffunction name="$controller" returntype="struct" access="public" hint="Set up controller for future calls">
		<cfargument name="controller" type="string" required="true" />
		<cfargument name="name" type="string" default="#arguments.controller#" />
		<cfargument name="path" type="string" default="#hyphenize(arguments.controller)#" />
		<cfreturn scope(argumentCollection=arguments, $call="controller") />
	</cffunction>
	
	<cffunction name="constraints" returntype="struct" access="public" hint="Set variable patterns to use for matching">
		<cfreturn scope(constraints=arguments, $call="constraints") />
	</cffunction>
	
	<!---------------
	--- Resources ---
	---------------->
	
	<cffunction name="resource" returntype="struct" access="public" hint="Set up singular REST resource">
		<cfargument name="name" type="string" required="true" hint="Name of resource" />
		<cfargument name="nested" type="boolean" default="false" hint="Whether or not additional calls will be nested" />
		<cfargument name="path" type="string" default="#hyphenize(arguments.name)#" hint="Path for resource" />
		<cfargument name="controller" type="string" required="false" hint="Override controller used by resource" />
		<cfargument name="singular" type="string" required="false" hint="Override singularize() result in plural resources" />
		<cfargument name="plural" type="string" required="false" hint="Override pluralize() result in singular resource" />
		<cfargument name="only" type="string" default="" hint="List of REST routes to generate" />
		<cfargument name="except" type="string" default="" hint="List of REST routes not to generate, takes priority over only" />
		<cfargument name="shallow" type="boolean" required="false" hint="Turn on shallow resources" />
		<cfargument name="shallowPath" type="string" required="false" hint="Shallow path prefix" />
		<cfargument name="shallowName" type="string" required="false" hint="Shallow name prefix" />
		<cfargument name="constraints" type="struct" required="false" hint="Variable patterns to use for matching" />
		<cfargument name="$call" type="string" default="resource" />
		<cfargument name="$plural" type="boolean" default="false" />
		<cfscript>
			var loc = {};
			loc.args = {};
			
			// if name is a list, add each of the resources in the list
			if (arguments.name CONTAINS ",") {
				
				// error if the user asked for a nested resource
				if (arguments.nested)
					$throw(type="Wheels.InvalidResource", message="Multiple resources in same declaration cannot be nested.");
					
				// remove path so new resources do not break
				StructDelete(arguments, "path");
					
				// build each new resource
				loc.names = ListToArray(arguments.name);
				loc.iEnd = ArrayLen(loc.names);
				for (loc.i = 1; loc.i LTE loc.iEnd; loc.i++)
					resource(name=loc.names[loc.i], argumentCollection=arguments);
				return this;
			}
			
			// if plural resource
			if (arguments.$plural) {
				
				// setup singular and plural words
				if (NOT StructKeyExists(arguments, "singular"))
					arguments.singular = singularize(arguments.name);
				arguments.plural = arguments.name;
				
				// set collection and scoped paths
				loc.args.collection = arguments.plural;
				loc.args.nestedPath = "#arguments.path#/[#arguments.singular#Key]";
				loc.args.memberPath = "#arguments.path#/[key]";
				
				// for uncountable plurals, append "Index"
				if (arguments.singular EQ arguments.plural)
					loc.args.collection &= "Index";
				
				// setup loc.args.actions
				loc.args.actions = "index,new,create,show,edit,update,delete";
				
			// if singular resource
			} else {
				
				// setup singular and plural words
				arguments.singular = arguments.name;
				if (NOT StructKeyExists(arguments, "plural"))
					arguments.plural = pluralize(arguments.name);
				
				// set collection and scoped paths
				loc.args.collection = arguments.singular;
				loc.args.memberPath = arguments.path;
				loc.args.nestedPath = arguments.path;
				
				// setup loc.args.actions
				loc.args.actions = "new,create,show,edit,update,delete";
			}
			
			// set member name
			loc.args.member = arguments.singular;
			
			// set collection path
			loc.args.collectionPath = arguments.path;
			
			// consider only / except REST routes for resources
			// allow arguments.only to override loc.args.only
			if (ListLen(arguments.only) GT 0)
				loc.args.actions = LCase(arguments.only);
			
			// remove unwanted routes from loc.args.only
			if (ListLen(arguments.except) GT 0) {
				loc.except = ListToArray(arguments.except);
				loc.iEnd = ArrayLen(loc.except);
				for (loc.i=1; loc.i LTE loc.iEnd; loc.i++)
					loc.args.actions = REReplace(loc.args.actions, "\b#loc.except[loc.i]#\b(,?|$)", "");
			}
			
			// if controller name was passed, use it
			if (StructKeyExists(arguments, "controller")) {
				loc.args.controller = arguments.controller;
				
			} else {
				
				// set controller name based on naming preference
				switch (application[$wheelsKey()].resourceControllerNaming) {
					case "name": loc.args.controller = arguments.name; break;
					case "singular": loc.args.controller = arguments.singular; break;
					default: loc.args.controller = arguments.plural;
				}
			}
			
			// if parent resource is found
			if (StructKeyExists(scopeStack[1], "member")) {
				
				// use member and nested path
				loc.args.name = scopeStack[1].member;
				loc.args.path = scopeStack[1].nestedPath;
				
				// store parent resource (and avoid too deep nesting)
				loc.args.parentResource = Duplicate(scopeStack[1]);
				if (StructKeyExists(loc.args.parentResource, "parentResource"))
					StructDelete(loc.args.parentResource, "parentResource");
			}
			
			// pass along shallow route options
			if (StructKeyExists(arguments, "shallow"))
				loc.args.shallow = arguments.shallow;
			if (StructKeyExists(arguments, "shallowPath"))
				loc.args.shallowPath = arguments.shallowPath;
			if (StructKeyExists(arguments, "shallowName"))
				loc.args.shallowName = arguments.shallowName;
			
			// pass along constraints
			if (StructKeyExists(arguments, "constraints"))
				loc.args.constraints = arguments.constraints;
			
			// scope the resource
			scope($call=arguments.$call, argumentCollection=loc.args);
				
			// call end() automatically unless this is a nested call
			// NOTE: see 'end()' source for the resource routes logic
			if (NOT arguments.nested)
				end();
				
			return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="resources" returntype="struct" access="public" hint="Set up REST plural resource">
		<cfargument name="name" type="string" required="true" />
		<cfargument name="nested" type="boolean" default="false" />
		<cfreturn resource($plural=true, $call="resources", argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="member" returntype="struct" access="public" hint="Apply routes to resource member">
		<cfreturn scope(path=scopeStack[1].memberPath, $call="member") />
	</cffunction>
	
	<cffunction name="collection" returntype="struct" access="public" hint="Apply routes to resource collection">
		<cfreturn scope(path=scopeStack[1].collectionPath, $call="collection") />
	</cffunction>
	
	<!---------------
	--- Utilities ---
	---------------->
	
	<cffunction name="normalizePattern" returntype="string" access="public" hint="Force leading slashes, remove trailing and duplicate slashes">
		<cfargument name="pattern" type="string" required="true" />
		<cfscript>
			var loc = {};
			loc.pattern = REReplace(arguments.pattern, "(^/+|/+$)", "", "ALL");
			loc.pattern = REReplace(loc.pattern, "/+\.", ".", "ALL");
			return "/" & Replace(loc.pattern, "//", "/", "ALL");
		</cfscript>
	</cffunction>
	
	<cffunction name="patternToRegex" returntype="string" access="public" hint="Transform route pattern into regular expression">
		<cfargument name="pattern" type="string" required="true" />
		<cfargument name="constraints" type="struct" default="#StructNew()#" />
		<cfscript>
			var loc = {};
			
			// escape any dots in pattern, and further mask pattern variables
			// NOTE: this keeps constraint patterns from being replaced twice
			loc.regex = REReplace(arguments.pattern, "([.])", "\\1", "ALL");
			loc.regex = REReplace(loc.regex, "\[(\*?\w+)\]", ":::\1:::", "ALL");
			
			// replace known variable keys using constraints
			loc.constraints = StructCopy(arguments.constraints);
			StructAppend(loc.constraints, variables.constraints, false);
			for (loc.key in loc.constraints)
				loc.regex = REReplaceNoCase(loc.regex, ":::#loc.key#:::", "(#loc.constraints[loc.key]#)", "ALL");
			
			// replace remaining variables with default regex
			loc.regex = REReplace(loc.regex, ":::\w+:::", "([^./]+)", "ALL");
			return REReplace(loc.regex, "^/*(.*)/*$", "^\1/?$");
		</cfscript>
	</cffunction>
	
	<cffunction name="stripRouteVariables" returntype="string" access="public" hint="Pull list of variables out of route pattern">
		<cfargument name="pattern" type="string" required="true" />
		<cfreturn REReplace(ArrayToList(REMatch("\[\*?(\w+)\]", arguments.pattern)), "[\*\[\]]", "", "ALL") />
	</cffunction>
	
	<!---------------------
	--- Private Methods ---
	---------------------->
	
	<cffunction name="$addRoute" returntype="void" access="private" hint="Add route to cfwheels, removing useless params">
		<cfscript>
					
			// remove controller and action if they are route variables
			if (Find("[controller]", arguments.pattern) AND StructKeyExists(arguments, "controller"))
				StructDelete(arguments, "controller");
			if (Find("[action]", arguments.pattern) AND StructKeyExists(arguments, "action"))
				StructDelete(arguments, "action");
				
			// normalize pattern, convert to regex, and strip out variable names
			arguments.pattern = normalizePattern(arguments.pattern);
			arguments.regex = patternToRegex(arguments.pattern, arguments.constraints);
			arguments.variables = stripRouteVariables(arguments.pattern);
				
			// add route to cfwheels
			ArrayAppend(application[$wheelsKey()].routes, arguments);
		</cfscript>
	</cffunction>
	
	<cffunction name="$member" returntype="string" access="private" hint="Get member name if defined">
		<cfreturn iif(StructKeyExists(scopeStack[1], "member"), "scopeStack[1].member", DE("")) />
	</cffunction>
	
	<cffunction name="$collection" returntype="string" access="private" hint="Get collection name if defined">
		<cfreturn iif(StructKeyExists(scopeStack[1], "collection"), "scopeStack[1].collection", DE("")) />
	</cffunction>
	
	<cffunction name="$scopeName" returntype="string" access="private" hint="Get scoped route name if defined">
		<cfreturn iif(StructKeyExists(scopeStack[1], "name"), "scopeStack[1].name", DE("")) />
	</cffunction>
	
	<cffunction name="$shallow" returntype="boolean" access="private" hint="See if resource is shallow">
		<cfreturn StructKeyExists(scopeStack[1], "shallow") AND scopeStack[1].shallow EQ true />
	</cffunction>
	
	<cffunction name="$shallowName" returntype="string" access="private" hint="Get scoped shallow route name if defined">
		<cfreturn iif(StructKeyExists(scopeStack[1], "shallowName"), "scopeStack[1].shallowName", DE("")) />
	</cffunction>
	
	<cffunction name="$shallowPath" returntype="string" access="private" hint="Get scoped shallow path if defined">
		<cfreturn iif(StructKeyExists(scopeStack[1], "shallowPath"), "scopeStack[1].shallowPath", DE("")) />
	</cffunction>
	
	<cffunction name="$shallowNameForCall" returntype="string" access="private">
		<cfscript>
			if (ListFindNoCase("collection,new", scopeStack[1].$call) AND StructKeyExists(scopeStack[1], "parentResource"))
				return ListAppend($shallowName(), scopeStack[1].parentResource.member);
			return $shallowName();
		</cfscript>
		<cfreturn iif(StructKeyExists(scopeStack[1], "shallowPath"), "scopeStack[1].shallowPath", DE("")) />
	</cffunction>
	
	<cffunction name="$shallowPathForCall" returntype="string" access="private">
		<cfscript>
			var path = "";
			switch (scopeStack[1].$call) {
				case "member":
					path = scopeStack[1].memberPath;
					break;
				case "collection":
				case "new":
					if (StructKeyExists(scopeStack[1], "parentResource"))
						path = scopeStack[1].parentResource.nestedPath;
					path &= "/" & scopeStack[1].collectionPath;
					break;
			}
			return $shallowPath() & "/" & path;
		</cfscript>
		<cfreturn iif(StructKeyExists(scopeStack[1], "shallowPath"), "scopeStack[1].shallowPath", DE("")) />
	</cffunction>

	<cffunction name="$wheelsKey" returntype="string" access="private" output="false">
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