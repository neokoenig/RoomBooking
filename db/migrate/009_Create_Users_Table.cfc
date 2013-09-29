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
<cfcomponent extends="plugins.dbmigrate.Migration" hint="Create Users Table">
  <cffunction name="up">
    <cfscript>
      t = createTable(name='users', id=true);
      t.string(columnNames='email', default='', null=false, limit='255');
      t.string(columnNames='firstname', default='', null=false, limit='100');
      t.string(columnNames='lastname', default='', null=false, limit='100');
      t.string(columnNames='role', default='user', null=false, limit='50');
      t.string(columnNames='password,salt,address1,address2,passwordresettoken', default='', null=true, limit='500');
      t.string(columnNames='state,country', default='', null=true, limit='100');
      t.string(columnNames='postcode,tel', default='', null=true, limit='50');
      t.datetime(columnNames='passwordresetat', default='', null=true);
      t.timestamps();
      t.create();
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
      dropTable('users');
    </cfscript>
  </cffunction>
</cfcomponent>
