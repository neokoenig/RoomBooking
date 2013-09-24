<cfcomponent extends="plugins.dbmigrate.Migration" hint="create a user table">
  <cffunction name="up">
    <cfscript>
    t = createTable('users');
    t.string(columnNames='firstname',limit=255);
    t.string(columnNames='lastname',limit=255);
    t.string(columnNames='title',limit=255);
    t.string(columnNames='email',limit=255);
    t.string(columnNames='password',limit=255);
    t.boolean(columnNames='islocked',default=false,null=false);
    t.integer(columnNames='invalidloginattempts',default=0);
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

