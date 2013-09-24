<!---
    |-------------------------------------------------------------------------------------------|
	| Parameter     | Required | Type    | Default | Description                                |
    |-------------------------------------------------------------------------------------------|
	| table         | Yes      | string  |         | Name of table to remove records from       |
	| where         | No       | string  |         | Where condition                            |
    |-------------------------------------------------------------------------------------------|

    EXAMPLE:
      removeRecord(table='members',where='id=1');
--->
<cfcomponent extends="[extends]" hint="[description]">
  <cffunction name="up">
    <cfscript>
		removeRecord(table='tableName',where='');
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
	    addRecord(table='tableName',field='');
    </cfscript>
  </cffunction>
</cfcomponent>