<!---
    |----------------------------------------------------------------------------------------------------------------------------|
	| Parameter     | Required | Type    | Default | Description                                                                 |
    |----------------------------------------------------------------------------------------------------------------------------|
	| table         | Yes      | string  |         | table name                                                                  |
	| columnNames   | Yes      | string  |         | one or more column names to index, comma separated                          |
	| unique        | No       | boolean |  false  | if true will create a unique index constraint                               |
	| indexName     | No       | string  |         | use for index name. Defaults to table name + underscore + first column name |
    |----------------------------------------------------------------------------------------------------------------------------|

    EXAMPLE:
      addIndex(table='members',columnNames='username',unique=true);
--->
<cfcomponent extends="[extends]" hint="[description]">
  <cffunction name="up">
    <cfscript>
		addIndex(table='tableName',columnNames='columnName',unique=true);
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
	    removeIndex(table='tableName', indexName='');
    </cfscript>
  </cffunction>
</cfcomponent>