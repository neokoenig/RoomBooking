<!---
    |-----------------------------------------------------------------------------------------------------|
	| Parameter               | Required | Type    | Default | Description                                |
    |-----------------------------------------------------------------------------------------------------|
	| table                   | Yes      | string  |         | Name of table to update records            |
	| where                   | No       | string  |         | Where condition                            |
	| one or more columnNames | No       | string  |         | Use column name as argument name and value |
    |-----------------------------------------------------------------------------------------------------|

    EXAMPLE:
      updateRecord(table='members',where='id=1',status='Active');
--->
<cfcomponent extends="plugins.dbmigrate.Migration" hint="Add Default Category Setting Categories">
  <cffunction name="up">
    <cfscript> 
      updateRecord(table='settings', where="id='allowLocations'",            category="Locations");
      updateRecord(table='settings', where="id='allowSettings'",             category="General");
      updateRecord(table='settings', where="id='allowThemes'",               category="Styling");
      updateRecord(table='settings', where="id='bootstraptheme'",            category="Styling");
      updateRecord(table='settings', where="id='bootstrapthemeoptions'",     category="Styling");
      updateRecord(table='settings', where="id='calendarAllDaySlot'",        category="Calendar");
      updateRecord(table='settings', where="id='calendarAllDayText'",        category="Calendar");
      updateRecord(table='settings', where="id='calendarAxisFormat'",        category="Calendar");
      updateRecord(table='settings', where="id='calendarColumnFormatDay'",   category="Calendar");
      updateRecord(table='settings', where="id='calendarColumnFormatMonth'", category="Calendar");
      updateRecord(table='settings', where="id='calendarColumnFormatWeek'",  category="Calendar"); 
      updateRecord(table='settings', where="id='calendarDefaultView'",       category="Calendar");
      updateRecord(table='settings', where="id='calendarFirstday'",          category="Calendar");
      updateRecord(table='settings', where="id='calendarHeadercenter'",      category="Calendar");
      updateRecord(table='settings', where="id='calendarHeaderleft'",        category="Calendar");
      updateRecord(table='settings', where="id='calendarHeaderright'",        category="Calendar");
      updateRecord(table='settings', where="id='calendarHiddenDays'",        category="Calendar");
      updateRecord(table='settings', where="id='calendarMintime'",           category="Calendar");
      updateRecord(table='settings', where="id='calendarSlotEventOverlap'",  category="Calendar");
      updateRecord(table='settings', where="id='calendarSlotMinutes'",       category="Calendar");
      updateRecord(table='settings', where="id='calendarTimeformat'",        category="Calendar");
      updateRecord(table='settings', where="id='calendarWeekends'",          category="Calendar");
      updateRecord(table='settings', where="id='calendarWeekNumbers'",       category="Calendar");
      updateRecord(table='settings', where="id='googleanalytics'",           category="General");
      updateRecord(table='settings', where="id='roomlayouttypes'",           category="Locations");
      updateRecord(table='settings', where="id='showlocationcolours'",       category="Locations");
      updateRecord(table='settings', where="id='showlocationfilter'",        category="Locations");
      updateRecord(table='settings', where="id='sitedescription'",           category="General");
      updateRecord(table='settings', where="id='siteEmailAddress'",          category="General");
      updateRecord(table='settings', where="id='sitelogo'",                  category="General");
      updateRecord(table='settings', where="id='sitetitle'",                 category="General");
      updateRecord(table='settings', where="id='usejavascriptfromCDN'",      category="General");
      updateRecord(table='settings', where="id='version'",                   category="General");
      updateRecord(table='settings', where="id='wheelsErrorEmailFromAddress'", category="General");
      updateRecord(table='settings', where="id='wheelsErrorEmailSubject'",   category="General");
      updateRecord(table='settings', where="id='wheelsErrorEmailToAddress'", category="General");
      updateRecord(table='settings', where="id='isDemoMode'",                category="General");
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
		updateRecord(table='settings', category="General");
    </cfscript>
  </cffunction>
</cfcomponent>
