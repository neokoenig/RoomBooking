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
<cfcomponent extends="plugins.dbmigrate.Migration" hint="Create Events Table">
  <cffunction name="up">
    <cfscript>
      t = createTable(name='events', id=true);
      t.string(columnNames='title', default='', null=false, limit='500');
      t.datetime(columnNames='start', default='', null=true);
      t.datetime(columnNames='end', default='', null=true);
      t.integer(columnNames='allday', default='0', null=false, limit='0');
      t.string(columnNames='url', default='', null=true, limit='500');
      t.string(columnNames='className', default='', null=true, limit='255');
      t.text(columnNames='description', default='', null=true);
      t.integer(columnNames='locationid', default='0', null=false); 
      t.string(columnNames='contactname', default='', null=true, limit='255');
      t.string(columnNames='contactno', default='', null=true, limit='255');
      t.string(columnNames='contactemail', default='', null=true, limit='255'); 
      t.string(columnNames='layoutstyle', default='Standard', null=true, limit='255');
      
      t.timestamps();
      t.create();
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
      dropTable('tableName');
    </cfscript>
  </cffunction>
</cfcomponent>
