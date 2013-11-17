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
<cfcomponent extends="plugins.dbmigrate.Migration" hint="Add Default Date & Time Format">
  <cffunction name="up">
    <cfscript>
	     addRecord(table='settings',id='defaultDateFormat', value='DD MMM YYYY', notes='Default Date Format (agenda view etc)', fieldtype='string', editable=1);
       addRecord(table='settings',id='defaultTimeFormat', value='HH:MM', notes='Default Time Format (agenda view etc)', fieldtype='string', editable=1);
      
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
		removeRecord(table='settings',where='id="defaultDateFormat"');
    removeRecord(table='settings',where='id="defaultTimeFormat"');
    </cfscript>
  </cffunction>
</cfcomponent>
