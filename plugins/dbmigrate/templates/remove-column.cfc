<!---
    |-------------------------------------------------------------------------------------------------|
	| Parameter     | Required | Type    | Default | Description                                      |
    |-------------------------------------------------------------------------------------------------|
	| table         | Yes      | string  |         | existing table name                              |
	| columnName    | No       | string  |         | existing column name                             |
	| referenceName | No       | string  |         | name of reference that was used to create column |
    |-------------------------------------------------------------------------------------------------|

    EXAMPLE:
      removeColumn(table='members',columnName='status');
--->
<cfcomponent extends="[extends]" hint="[description]">
  <cffunction name="up">
    <cfscript>
		removeColumn(table='tableName',columnName='columnName');
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
	    addColumn(table='tableName', columnType='', columnName='columnName', default='', null=true);
    </cfscript>
  </cffunction>
</cfcomponent>