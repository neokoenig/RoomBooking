<!---
    |----------------------------------------------------------------------|
	| Parameter     | Required | Type    | Default | Description           |
    |----------------------------------------------------------------------|
	| table         | Yes      | string  |         | existing table name   |
	| columnName    | Yes      | string  |         | existing column name  |
	| newColumnName | No       | string  |         | new name for column   |
    |----------------------------------------------------------------------|

    EXAMPLE:
      renameColumn(table='users', columnName='password', newColumnName='');
--->
<cfcomponent extends="[extends]" hint="[description]">
  <cffunction name="up">
    <cfscript>
	    renameColumn(table='tableName', columnName='columnName', newColumnName='newColumnName');
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
	    renameColumn(table='tableName', columnName='columnName', newColumnName='newColumnName');
    </cfscript>
  </cffunction>
</cfcomponent>