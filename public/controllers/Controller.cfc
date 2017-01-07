//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Wheels" hint="Global Controller"
{
	function init(boolean includeForgeryProtection=true) {
		// CSRF
		if(arguments.includeForgeryProtection){
			protectFromForgery();
		}
		// Allow Basic Application Access
		filters(through="checkPermissionAndRedirect", permission="accessApplication");
	}

	include template="functions/auth.cfm";
	include template="functions/filters.cfm";
	include template="functions/dates.cfm";
	include template="functions/utils.cfm";

}
