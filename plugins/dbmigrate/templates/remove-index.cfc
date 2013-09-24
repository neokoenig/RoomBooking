<!---
    |----------------------------------------------------------------------------|
	| Parameter     | Required | Type    | Default | Description                 |
    |----------------------------------------------------------------------------|
	| table         | Yes      | string  |         | table name                  |
	| indexName     | Yes      | string  |         | name of the index to remove |
    |----------------------------------------------------------------------------|

    EXAMPLE:
      removeIndex(table='members',indexName='members_username');
--->
<cfcomponent extends="[extends]" hint="[description]">
  <cffunction name="up">
    <cfscript>
	    removeIndex(table='tableName', indexName='');
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
		addIndex(table='tableName',columnNames='columnName',unique=true);
    </cfscript>
  </cffunction>
</cfcomponent>