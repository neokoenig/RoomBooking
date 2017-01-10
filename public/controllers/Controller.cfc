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

	include "functions/auth.cfm";
	include "functions/filters.cfm";
	include "functions/dates.cfm";
	include "functions/utils.cfm";

}
