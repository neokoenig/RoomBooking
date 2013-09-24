<!---
    |----------------------------------------------------------------------------------------------|
	| Parameter  | Required | Type    | Default | Description                                      |
    |----------------------------------------------------------------------------------------------|
	| oldName    | Yes      | string  |         | existing table name                              |
	| newName    | Yes      | string  |         | new table name                              |
    |----------------------------------------------------------------------------------------------|

    EXAMPLE:
      renameTable(oldName='employees', newName='users');
--->
<cfcomponent extends="[extends]" hint="[description]">
  <cffunction name="up">
    <cfscript>
    renameTable(oldName='',newName='');
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
    renameTable(oldName='',newName='');
    </cfscript>
  </cffunction>
</cfcomponent>