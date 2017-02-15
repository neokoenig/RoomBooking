<cfscript>
 	drawRoutes()
 	/*
 	drawRoutes()
  .namespace("install")
    .post(name="migrate", controller="migrations", action="create") // If you can, you'll want to
                                                                    // post to this because it
                                                                    // changes app state
    .post(name="systemAdmin", controller="systemAdmins", action="create")
  .end()

  .get(name="install", controller="installations", action="new")

  .get(name="login", controller="sessions", action="new")
  .get(name="logout", controller="sessions", action="delete")
  .post(name="authenticate", controller="sessions", action="create")
  // Consider just rendering an "access denied" message when access is denied, rather than
  // redirecting to this. A before filter should be able to do that.
  .get(name="denied", controller="sessions", action="denied")

  .resource(name="password", only="new,create,edit,update") // These could be pathed differently,
                                                            // I suppose, but it goes like this:
                                                            // new/create = Forgot password
                                                            // edit/update = Reset password
.end()*/
 		//.controller("install")
 		//	.get("index")
 		//	.get("rundbmigrate")
 		//	.post("createsysadmin")
 		//.end()

 		// Installer
 		.namespace("install")
 			.post(name="migrate", controller="migrations", action="create")
 			.post(name="systemAdmin", controller="systemAdmins", action="create")
 		.end()
 		.get(name="install", controller="installations", action="new")

 		// Authentication
	  	.get(name="login", controller="sessions", action="new")
	  	.get(name="logout", controller="sessions", action="delete")
  		.post(name="authenticate", controller="sessions", action="create")

  		// Password Resets
  		.resource(name="passwordReset", only="new,create,edit,update")
 		//.controller(controller="passwordreset", path="auth")
		//    .get(name="forgot",  action="forgot")
		//    .post(name="create",  action="create")
		//    .get(name="recover", pattern="recover/[token]",  action="recover")
		//    .post(name="reset",  action="reset")
 		//.end()

	 	//.namespace("api")
	    //    .controller("v1")
	    //        .get("environment")
	    //        .post("authenticate")
	    //        .get("users")
	    //        .root(action="index")
	    //    .end()
	    //.end()

	 	.namespace("admin")
	 		.resources("buildings")
	 		.resources("bookings")
 				.put(name="approve", pattern="bookings/approve/[key]", controller="bookings", action="approve")
	 		.resources("calendars")
	 		.resources("rooms")
	 		.resources("resources")
	 		.resources("logs")
	 		.resources("roles")
	 		.resources("permissions")
	 		.resources("settings")
	 		.resources("workflows")
	 		.controller("workflowtriggers")
	 			.get(name="index", pattern="[key]", action="index")
	 			.post(name="create",  action="create")
	 			.delete(name="delete", action="delete")
	 			.end()
 			.resources("triggers")
 			.resources("actions")
 				.get(name="properties", pattern="properties/", controller="actions", action="properties")
	 		.resources("users")
 				.get(name="assume", pattern="users/assume/[key]", controller="users", action="assume")
 				.get(name="recover", pattern="users/recover/[key]", controller="users", action="recover")
	 		.resources("dump")
 			.get(name="index", controller="admin", action="index")
	    .end()

		.scope(module="public")
			.resource(name="bookings", only="new,create")

			.controller("calendar")
				.get(name="fullcalendardata",  pattern="data/full/")
				.get(name="fullcalendarresources", pattern="resources/full/")
				.get(name="fullcalendarfilters", pattern="filters/full/")
				//.get(name="yearcalendardata", pattern="data/year/")
				.get(name="show", pattern="show/[key]")
				.get(name="detail", pattern="detail/[key]")
				.get("index")
			.end()



			.controller("language")
				.get(name="switch", pattern="[lang]", action="index")
			.end()

			.controller("my")
				.get(name="account", pattern="account", action="account")
				.post(name="account", pattern="account", action="accountupdate")
				.get(name="bookings", pattern="bookings", action="bookings")
			.end()
			.root(to="calendar##index", method="get")
		.end()

 	.end();
 </cfscript>
