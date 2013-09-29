<!---
    |----------------------------------------------------------------------------------------------|
	| Parameter  | Required | Type    | Default | Description                                      |
    |----------------------------------------------------------------------------------------------|
	| name       | Yes      | string  |         | table name, in pluralized form                   |
	| force      | No       | boolean | false   | drop existing table of same name before creating |
	| id         | No       | boolean | true    | if false, defines a table with no primary key    |
	| primaryKey | No       | string  | id      | overrides default primary key name
    |----------------------------------------------------------------------------------------------|

    EXAMPLE:
      t = createTable(name='employees',force=false,id=true,primaryKey='empId');
      t.string(columnNames='name', default='', null=true, limit='255');
      t.text(columnNames='bio', default='', null=true);
      t.time(columnNames='lunchStarts', default='', null=true);
      t.datetime(columnNames='employmentStarted', default='', null=true);
      t.integer(columnNames='age', default='', null=true, limit='1');
      t.decimal(columnNames='hourlyWage', default='', null=true, precision='1', scale='2');
      t.date(columnNames='dateOfBirth', default='', null=true);
--->
<cfcomponent extends="plugins.dbmigrate.Migration" hint="Create Permissions Table">
  <cffunction name="up">
    <cfscript>
      t = createTable(name='permissions', id=false); 
      t.primaryKey(name="id",limit='255', type="string");
      t.integer(columnNames='admin', default='0', null=false, limit='1');
      t.integer(columnNames='editor', default='0', null=false, limit='1');
      t.integer(columnNames='user', default='0', null=false, limit='1');
      t.integer(columnNames='guest', default='0', null=false, limit='1');
      t.string(columnNames='notes', default='', null=true, limit='1000');   
      t.create();
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
      dropTable('permissions');
    </cfscript>
  </cffunction>
</cfcomponent>
