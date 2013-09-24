<!---
    |-------------------------------------------------------------------------------------------|
	| Parameter     | Required | Type    | Default | Description                                |
    |-------------------------------------------------------------------------------------------|
	| table         | Yes      | string  |         | Name of table to add record to             |
	| columnNames   | Yes      | string  |         | Use column name as argument name and value |
    |-------------------------------------------------------------------------------------------|

    EXAMPLE:
      addRecord(table='members',id=1,username='admin',password='#Hash("admin")#');
 
--->
<cfcomponent extends="plugins.dbmigrate.Migration" hint="Add Default Settings">
  <cffunction name="up">
    <cfscript>
	    addRecord(table='settings',id='allowLocations', value='1', notes='setting to zero will disable the facility to edit all locations via the web interface', fieldtype='boolean', editable=1);
      addRecord(table='settings',id='allowSettings', value='1', notes='Warning - setting to zero will disable the facility to edit all settings via the web interface, and will only be editable via the database directly', fieldtype='boolean', editable=1);
      addRecord(table='settings',id='allowThemes', value='1', notes='setting to zero will disable the theme preview dropdown', fieldtype='boolean', editable=1);
      addRecord(table='settings',id='bootstraptheme', value='cosmo', notes='Current bootstrap bootswatch theme to use - requires using CDN option', fieldtype='string', editable=1);
      addRecord(table='settings',id='bootstrapthemeoptions', value='amelia,cerulean,cosmo,cyborg,flatly,journal,readable,simplex,slate,spacelab,united', notes='List of possible Bootstrap 3 theme names', fieldtype='string', editable=0);
      addRecord(table='settings',id='calendarAllDaySlot', value='1', notes='Determines if the "all-day" slot is displayed at the top of the calendar.', fieldtype='boolean', editable=1);
      addRecord(table='settings',id='calendarAllDayText', value='all-day', notes='The text titling the "all-day" slot at the top of the calendar.', fieldtype='string', editable=1);
      addRecord(table='settings',id='calendarAxisFormat', value='h(:mm)tt', notes='Determines the time-text that will be displayed on the vertical axis of the agenda views', fieldtype='string', editable=1);
      addRecord(table='settings',id='calendarColumnFormatDay', value='dddd d/M', notes='Column format for day', fieldtype='string', editable=1);
      addRecord(table='settings',id='calendarColumnFormatMonth', value='ddd', notes='Column format for month', fieldtype='string', editable=1);
      addRecord(table='settings',id='calendarColumnFormatWeek', value='ddd d/M', notes='Column format for week', fieldtype='string', editable=1);
      addRecord(table='settings',id='calendarDefaultView', value='month', notes='Calendar Default View - Can be month, basicWeek, basicDay etc', fieldtype='string', editable=1);
      addRecord(table='settings',id='calendarFirstday', value='1', notes='Start Calendar on this day of the week: 1 = Monday, 0 = Sunday', fieldtype='boolean', editable=1);
      addRecord(table='settings',id='calendarHeadercenter', value='title', notes='Calendar Header Display, center - see http://arshaw.com/fullcalendar/docs/display/header/', fieldtype='string', editable=1);
      addRecord(table='settings',id='calendarHeaderleft', value='prev,next today', notes='Calendar Header Display, left - see http://arshaw.com/fullcalendar/docs/display/header/', fieldtype='string', editable=1);
      addRecord(table='settings',id='calendarHeaderright', value='month,agendaWeek,agendaDay', notes='Calendar Header Display, right - see http://arshaw.com/fullcalendar/docs/display/header/', fieldtype='string', editable=1);
      addRecord(table='settings',id='calendarHiddenDays', value='[]', notes='Hide certain days (Comma Delim List in array, i.e [1,3,5] )', fieldtype='string', editable=1);
      addRecord(table='settings',id='calendarMintime', value='7am', notes='Calendar Minimum Time to display', fieldtype='string', editable=1);
      addRecord(table='settings',id='calendarSlotEventOverlap', value='1', notes='Determines if timed events in agenda view should visually overlap', fieldtype='boolean', editable=1);
      addRecord(table='settings',id='calendarSlotMinutes', value='15', notes='Calendar No of minutes to increment minutes in (integer)', fieldtype='string', editable=1);
      addRecord(table='settings',id='calendarTimeformat', value='H:mm', notes='Calendar Time Format', fieldtype='string', editable=1);
      addRecord(table='settings',id='calendarWeekends', value='1', notes='Calendar Whether to show weekends', fieldtype='boolean', editable=1);
      addRecord(table='settings',id='calendarWeekNumbers', value='0', notes='Determines if week numbers should be displayed on the calendar.', fieldtype='boolean', editable=1);
      addRecord(table='settings',id='googleanalytics', value='UA-', notes='Google Anayltics Tracking Code (format: UA-XXXXX-X), set to UA- to omit', fieldtype='string', editable=1);
      addRecord(table='settings',id='roomlayouttypes', value='Standard,Boardroom,Lecture', notes='Room Layout Types (Comma Deliminated List of Values)', fieldtype='string', editable=1);
      addRecord(table='settings',id='showlocationcolours', value='1', notes='Whether to display calendar entries with their location colour', fieldtype='boolean', editable=1);
      addRecord(table='settings',id='showlocationfilter', value='1', notes='Whether to show the Location Filter Bar on the Main Calendar Page', fieldtype='boolean', editable=1);
      addRecord(table='settings',id='sitedescription', value='Room Booking System', notes='Site Meta Description', fieldtype='string', editable=1);
      addRecord(table='settings',id='siteEmailAddress', value='bookings@domain.com', notes='Main Site email address - used in  booking notifications', fieldtype='string', editable=1);
      addRecord(table='settings',id='sitelogo', value='/', notes='Path or Full URL to your Site Logo, 20px x 20px recommended', fieldtype='string', editable=1);
      addRecord(table='settings',id='sitetitle', value='Room Booking System', notes='The Main Site Title', fieldtype='string', editable=1);
      addRecord(table='settings',id='usejavascriptfromCDN', value='1', notes='Use Javascript Libraries and CSS from CDN whereever possible', fieldtype='boolean', editable=1);
      addRecord(table='settings',id='version', value='1.0', notes='Version Number', fieldtype='string', editable=1);
      addRecord(table='settings',id='wheelsErrorEmailFromAddress', value='error@domain.com', notes='Production mode error email address (from)', fieldtype='string', editable=1);
      addRecord(table='settings',id='wheelsErrorEmailSubject', value='[Error - Room Booking]', notes='Production mode error email subject', fieldtype='string', editable=1);
      addRecord(table='settings',id='wheelsErrorEmailToAddress', value='error@domain.com', notes='Production mode error email address (to)', fieldtype='string', editable=1);

    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript> 
      removeRecord(table="settings");
    /*removeRecord(table="settings", where="id = 'allowLocations'");
    removeRecord(table="settings", where="id = 'allowSettings");
    removeRecord(table="settings", where="id = 'allowThemes'");
    removeRecord(table="settings", where="id = 'bootstraptheme'");
    removeRecord(table="settings", where="id = 'bootstrapthemeoptions'");
    removeRecord(table="settings", where="id = 'calendarAllDaySlot'");
    removeRecord(table="settings", where="id = 'calendarAllDayText'");
    removeRecord(table="settings", where="id = 'calendarAxisFormat'");
    removeRecord(table="settings", where="id = 'calendarColumnFormatDay'");
    removeRecord(table="settings", where="id = 'calendarColumnFormatMonth'");
    removeRecord(table="settings", where="id = 'calendarColumnFormatWeek'");
    removeRecord(table="settings", where="id = 'calendarDefaultView'");
    removeRecord(table="settings", where="id = 'calendarFirstday'");
    removeRecord(table="settings", where="id = 'calendarHeadercenter'");
    removeRecord(table="settings", where="id = 'calendarHeaderleft'");
    removeRecord(table="settings", where="id = 'calendarHeaderright'");
    removeRecord(table="settings", where="id = 'calendarHiddenDays'");
    removeRecord(table="settings", where="id = 'calendarMintime'");
    removeRecord(table="settings", where="id = 'calendarSlotEventOverlap'");
    removeRecord(table="settings", where="id = 'calendarSlotMinutes'");
    removeRecord(table="settings", where="id = 'calendarTimeformat'");
    removeRecord(table="settings", where="id = 'calendarWeekends'");
    removeRecord(table="settings", where="id = 'calendarWeekNumbers'");
    removeRecord(table="settings", where="id = 'googleanalytics'");
    removeRecord(table="settings", where="id = 'roomlayouttypes'");
    removeRecord(table="settings", where="id = 'showlocationcolours'");
    removeRecord(table="settings", where="id = 'showlocationfilter'");
    removeRecord(table="settings", where="id = 'sitedescription'");
    removeRecord(table="settings", where="id = 'siteEmailAddress'");
    removeRecord(table="settings", where="id = 'sitelogo'");
    removeRecord(table="settings", where="id = 'sitetitle'");
    removeRecord(table="settings", where="id = 'usejavascriptfromCDN'");
    removeRecord(table="settings", where="id = 'version'");
    removeRecord(table="settings", where="id = 'wheelsErrorEmailFromAddress'");
    removeRecord(table="settings", where="id = 'wheelsErrorEmailSubject'");
    removeRecord(table="settings", where="id = 'wheelsErrorEmailToAddress'"); */
    </cfscript>
  </cffunction>
</cfcomponent>
