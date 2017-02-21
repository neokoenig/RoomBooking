component extends="Wheels"
{
	function init(boolean includeForgeryProtection=true) {
		// CSRF
		if(arguments.includeForgeryProtection){
			protectFromForgery();
		}
		// Check Permission for any given controller + action
		filters(through="checkPermissionAndRedirect");
		// Should this be done in appl scope?
		filters(through="f_getCalendars");
		//filters(through="controllerTrigger");
	}

	function controllerTrigger(){
		firetrigger(
			name=replace(getMetaData(this)['fullname'], 'wheelsMapping....', '', 'all'),
			type="controller",
			when=listLast(getDefaultPermissionString(), ".")
		);
	}
	include "functions/auth.cfm";
	include "functions/filters.cfm";
	include "functions/dates.cfm";
	include "functions/locations.cfm";
	include "functions/utils.cfm";

}
