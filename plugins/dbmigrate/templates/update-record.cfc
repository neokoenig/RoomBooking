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
<cfcomponent extends="[extends]" hint="[description]">
  <cffunction name="up">
    <cfscript>
	    updateRecord(table='tableName',where='');
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
		updateRecord(table='tableName',where='');
    </cfscript>
  </cffunction>
</cfcomponent>