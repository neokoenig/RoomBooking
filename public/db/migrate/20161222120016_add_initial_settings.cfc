<!---
    |----------------------------------------------------------------------------------------------|
	| Parameter  | Required | Type    | Default | Description                                      |
    |----------------------------------------------------------------------------------------------|
	| name       | Yes      | string  |         | table name, in pluralized form                   |
	| force      | No       | boolean | false   | drop existing table of same name before creating |
	| id         | No       | boolean | true    | if false, defines a table with no primary key    |
	| primaryKey | No       | string  | id      | overrides default primary key name
    |----------------------------------------------------------------------------------------------|

    EXAMPLE:
      t = createTable(name='employees',force=false,code=true,primaryKey='empId');
      t.string(columnNames='name', default='', null=true, limit='255');
      t.text(columnNames='bio', default='', null=true);
      t.time(columnNames='lunchStarts', default='', null=true);
      t.datetime(columnNames='employmentStarted', default='', null=true);
      t.integer(columnNames='age', default='', null=true, limit='1');
      t.decimal(columnNames='hourlyWage', default='', null=true, precision='1', scale='2');
      t.date(columnNames='dateOfBirth', default='', null=true);
--->
<cfcomponent extends="plugins.dbmigrate.Migration" hint="Add Default Roles">
  <cffunction name="up">
  	<cfset hasError = false />
  	<cftransaction>
	    <cfscript>
	    	try{

	      // Auth
          addRecord(table='settings', name="authentication_gateway", description="Authentication Gateway: set to local for standard local user accounts",  type="select", options="local,LDAP,External", value="local");
          addRecord(table='settings', name="authentication_defaultRole", description="Default Role for new accounts",
            type="select", options="[[getRoleDropdownList()]]", value="4");

          // i8n
          addRecord(table='settings', name="i8n_defaultLanguage", description="Default Language for the main interface",
            type="select", options="[[request.lang.availablelanguages]]", value="en_GB");
          addRecord(table='settings', name="i8n_defaultLocale", description="Default Locale for the main interface: changes date/time/currency formatting etc",
            type="select", options="[[getLocaleListDropDown()]]", value="English (United Kingdom)");
          addRecord(table='settings', name="i8n_defaultTimeZone", description="Default Timezone for all buildings,users,rooms",
            type="select", options="[[getTZListDropDown()]]", value="Europe/London");

          // Misc
          addRecord(table='settings', name="general_sitename", description="General Site Name",
            type="textfield", value="OxAlto RoomBooking System");
	       addRecord(table='settings', name="general_shortname", description="General Site Name (used in sidebar)",
            type="textfield", value="OxAltoRBS");
	       addRecord(table='settings', name="general_copyright", description="Footer Copyright Notice",
            type="textfield", value="OxAlto RoomBooking System.");

	       // Theme
	       addRecord(table='settings', name="theme_layout", description="Theme Layout",
            type="select", options="[[getThemeLayoutDropDown()]]", value="layout-boxed");
	       addRecord(table='settings', name="theme_skin", description="Theme Skin: 'Light' variants have a lighter sidebar",
            type="select", options="[[getThemeSkinDropDown()]]", value="skin-black-light");

	       // Calendar
	       addRecord(table='settings', name="calendar_headerLeft", description="Calendar Header Top Left Buttons",
            type="textfield", value=" cPrev,today,cNext title", docs="https://fullcalendar.io/docs/display/header/");
	       addRecord(table='settings', name="calendar_headerCenter", description="Calendar Header Center",
            type="textfield", value="", docs="https://fullcalendar.io/docs/display/header/");
	       addRecord(table='settings', name="calendar_headerRight", description="Calendar Header Right (note, custom buttons)",
            type="textfield", value="cMonth cAgendaWeek,cAgendaDay cListYear,cListMonth,cListWeek,cListDay cTimelineDay,cTimelineWeek,cTimelineMonth", docs="https://fullcalendar.io/docs/display/header/");
	       addRecord(table='settings', name="calendar_eventLimit", description="Allow 'more' link when too many events",
            type="select", options="0,1,2,3,4,5,6,7,8,9", value="6", docs="https://fullcalendar.io/docs/display/eventLimit/");
	       addRecord(table='settings', name="calendar_firstDay", description="The day that each week begins",
            type="select", options="0,1,2,3,4,5,6", value="1", docs="https://fullcalendar.io/docs/display/firstDay/");
	       addRecord(table='settings', name="calendar_weekends", description="Whether to include Saturday/Sunday columns in any of the calendar views.",
            type="boolean", value="true", docs="https://fullcalendar.io/docs/display/weekends/");
	       addRecord(table='settings', name="calendar_hiddenDays", description="Exclude certain days-of-the-week from being displayed.",
            type="textfield", value="[]", docs="https://fullcalendar.io/docs/display/hiddenDays/");
	       addRecord(table='settings', name="calendar_fixedWeekCount", description="Determines the number of weeks displayed in a month view.",
            type="boolean", value="true", docs="https://fullcalendar.io/docs/display/fixedWeekCount/");
	       addRecord(table='settings', name="calendar_weekNumbers", description="Determines if week numbers should be displayed on the calendar.",
            type="boolean", value="false", docs="https://fullcalendar.io/docs/display/weekNumbers/");
	       addRecord(table='settings', name="calendar_weekNumbersWithinDays", description="Determines the styling for week numbers in month view and the basic views.",
            type="boolean", value="false", docs="https://fullcalendar.io/docs/display/weekNumbersWithinDays/");

	      }
    	catch (any ex){
    		hasError = true;
	      	catchObject = ex;
    	}

	    </cfscript>
	     <cfif hasError>
	    	<cftransaction action="rollback" />
	    	<cfthrow
			    detail = "#catchObject.detail#"
			    errorCode = "1"
			    message = "#catchObject.message#"
			    type = "Any">
	    <cfelse>
	    	<cftransaction action="commit" />
	    </cfif>
	 </cftransaction>
  </cffunction>
  <cffunction name="down">
  	<cfset hasError = false />
  	<cftransaction>
	    <cfscript>
	    	try{
				removeRecord(table='settings');
	    	}
	    	catch (any ex){
	    		hasError = true;
		      	catchObject = ex;
	    	}

	    </cfscript>
	    <cfif hasError>
	    	<cftransaction action="rollback" />
	    	<cfthrow
			    detail = "#catchObject.detail#"
			    errorCode = "1"
			    message = "#catchObject.message#"
			    type = "Any">
	    <cfelse>
	    	<cftransaction action="commit" />
	    </cfif>
	 </cftransaction>
  </cffunction>
</cfcomponent>


