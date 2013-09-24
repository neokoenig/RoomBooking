<!---
    |----------------------------------------------------------------------------------------------|
	| Parameter  | Required | Type    | Default | Description                                      |
    |----------------------------------------------------------------------------------------------|
	| name       | Yes      | string  |         | existing table name                              |
    |----------------------------------------------------------------------------------------------|

    EXAMPLE:
      t = changeTable(name='employees');
      t.string(columnNames="fullName", default="", null=true, limit="255");
      t.change();
--->
<cfcomponent extends="[extends]" hint="[description]">
  <cffunction name="up">
    <cfscript>
    t = changeTable('tableName');
    
    t.change();
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
    removeColumn(table='tableName',columnName='columnName');
    </cfscript>
  </cffunction>
</cfcomponent>