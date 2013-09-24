<!---
    |----------------------------------------------------------------------------------------------|
	| Parameter  | Required | Type    | Default | Description                                      |
    |----------------------------------------------------------------------------------------------|
	| name       | Yes      | string  |         | table name to drop                               |
    |----------------------------------------------------------------------------------------------|

    EXAMPLE:
      dropTable(name='employees');
--->
<cfcomponent extends="[extends]" hint="[description]">
  <cffunction name="up">
    <cfscript>
	    dropTable(name='tableName');
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
	    t = createTable(name='tableName');
	   
	    t.timestamps();
	    t.create();
    </cfscript>
  </cffunction>
</cfcomponent>