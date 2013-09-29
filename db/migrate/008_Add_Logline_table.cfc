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
<cfcomponent extends="plugins.dbmigrate.Migration" hint="Add Logline table">
  <cffunction name="up">
    <cfscript>
      t = createTable(name='logfiles', id=true);
      t.string(columnNames='message',  null=false, limit='500');
      t.text(columnNames='data', default='', null=true);
      t.string(columnNames='ipaddress,type',  null=false, limit='16');
      t.integer(columnNames='userid', default='0', null=false, limit='11');
      t.timestamps();
      t.create();
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
      dropTable('logfiles');
    </cfscript>
  </cffunction>
</cfcomponent>
