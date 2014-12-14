//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Controller" hint="Manage Logfiles"
{
	/**
	 * @hint Constructor.
	 */
	public void function init() {
		// Permission filters
		super.init();
		// Additional Permissions
		filters(through="checkPermissionAndRedirect", permission="accesslogfiles");
	}

/******************** Public***********************/
	/**
	*  @hint Log viewer
	*/
	public void function index() {
		param name="params.type" type="string" default="";
		param name="params.userid" default="";
		param name="params.rows" type="numeric" default=250;
		LogFileTypes=_getLogFileTypes();
		users=model("user").findAll(select="id,email", order="lastname");
		var wc = arrayNew(1);
		if(structKeyExists(params, "type") AND Len(params.type)){
			arrayAppend(wc, "type = '#params.type#'");
		}
		if(structKeyExists(params, "userid") AND len(params.userid)){
			arrayAppend(wc, "userid = #params.userid#");
		}
		if(arrayLen(wc)){
			wc = arrayToList(wc, " AND ");
			logfiles=model("logfiles").findAll(where="#wc#", maxrows=params.rows,  order="createdAt DESC", includeSoftDeletes=true);
		}
		else {
			logfiles=model("logfiles").findAll(maxrows=500,  maxrows=params.rows, order="createdAt DESC", includeSoftDeletes=true);
		}
	}
/******************** Admin ***********************/

/******************** Private *********************/
	/**
	*  @hint
	*/
	public string function _getLogFileTypes() {
		return "login,success,error,ajax,cookie";
	}
}
