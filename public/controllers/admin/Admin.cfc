component extends="app.controllers.Controller"
{
	function init() {
		super.init();
	}

	function index(){
		param name="params.page" default="1";
		param name="params.perpage" default="10";
		pendingBookings=model("booking").findAll(page=params.page, perpage=params.perpage, where="isapproved = 0", include="user,room,building");
	}
}
