component extends="tests.Test" {

	function setup() {}
	function teardown() {}

	function test_users_index(){
	  _params = {
	    route="adminUsers",
	    controller="admin.users",
	    action="index"
	  };
	  _controller = controller(name="admin.users", params=_params);
	  _controller.$processAction();
	}

	function test_users_show_should_redirect_to_index_if_no_key(){
	  _params = {
	    route="adminUsers",
	    controller="admin.users",
	    action="show"
	  };
	  _controller = controller(name="admin.users", params=_params);
	  //_controller.$runfilters(type="before", action="show", params=_params);
	  //_controller.$runverifications(action="show", params=_params);
	  //_controller.$callAction("show");
	  //redirect = _controller.$getRedirect();
	  //t=_controller.$performedRedirect();
	  debug("_controller.init()");
	  debug("_controller.$PERFORMEDRENDERORREDIRECT()");
	  //debug("_controller.$LOCATION()");
	  debug("_controller.$RUNFILTERS(type='before', action='show')");
	  //debug("t");
	}

	function test_users_new(){
	  _params = {
	    route="adminUsers",
	    controller="admin.users",
	    action="new"
	  };
	  _controller = controller(name="admin.users", params=_params);
	  _controller.$processAction();
	}

	//function test_users_show_should_redirect_If_user_not_found(){
	//  _params = {
	//    route="adminUsers",
	//    controller="admin.users",
	//    action="show",
	//    key=9999999999999999999
	//  };
	//  _controller = controller(name="admin.users", params=_params);
	//  _controller.$processAction();
	//  redirect = _controller.$getRedirect();
	//  debug("redirect");
	//}
//

	/*function test_users_should_redirect_to_index_after_create_success() {
	  // define the controller and action we are testing
	  _params = {
	    controller="admin.users",
	    action="create"
	  };

	  // set the user params for creating a user
	  _params.user = {
	      firstName="Hugh",
	      lastName="Dunnit",
	      email="hugh@somedomain.com",
	      username="myusername",
	      password="foobar",
	      passwordConfirmation="foobar"
	  };

	  // create an instance of the controller
	  _controller = controller(name="admin.users", params=_params);

	  // process the create action of the controller
	  _controller.$processAction();

	  // get the information about the redirect that should have happened
	  redirect = _controller.$getRedirect();

	  // make sure that the redirect happened
	  assert('isStruct(redirect) && !structIsEmpty(redirect)');
	  debug("redirect");
	}*/

}
