<!---
	Here you can add routes to your application and edit the default one.
	The default route is the one that will be called on your application's "home" page.
--->
<cfscript>

	// Customer Routes
	addRoute(name="updateaccount", 	pattern="/my/account/u", 	controller="users", action="updateaccount");
	addRoute(name="myaccount", 		pattern="/my/account", 		controller="users", action="myaccount");
	addRoute(name="updatepassword", pattern="/my/password/u", 	controller="users", action="updatepassword");
	addRoute(name="mypassword", 	pattern="/my/password", 	controller="users", action="mypassword");

	// Login/Out
	addRoute(name="logout", 		pattern="/logout", 			controller="sessions", action="logout");
	addRoute(name="attemptlogin", 	pattern="/login/a/", 		controller="sessions", action="attemptlogin");
	addRoute(name="login", 			pattern="/login", 			controller="sessions", action="new");
 	addRoute(name="forgetme", 		pattern="/forgetme", 		controller="sessions", action="forgetme");
	addRoute(name="denied", 		pattern="/denied", 			controller="sessions", action="denied");

	// Remote Data
	addRoute(name="getEvents", 		pattern="/eventdata/getevents/[type]/[key]", action="getevents", controller="eventdata");
	addRoute(name="getEvent", 		pattern="/eventdata/getevent/[key]", action="getevent", controller="eventdata");

 	// Default
 	addRoute(name="home", pattern="", controller="bookings", action="index");
</cfscript>
