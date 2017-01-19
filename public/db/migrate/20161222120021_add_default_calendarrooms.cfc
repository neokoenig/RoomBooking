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
<cfcomponent extends="plugins.dbmigrate.Migration" hint="Add Default Roles">
  <cffunction name="up">
  	<cfset hasError = false />
  	<cftransaction>
	    <cfscript>
	    	try{
				addRecord(table='calendarrooms', calendarid=1, roomid=1);
				addRecord(table='calendarrooms', calendarid=1, roomid=2);
				addRecord(table='calendarrooms', calendarid=1, roomid=3);
				addRecord(table='calendarrooms', calendarid=1, roomid=4);
				addRecord(table='calendarrooms', calendarid=1, roomid=5);


				addRecord(table='calendarrooms', calendarid=2, roomid=6);
				addRecord(table='calendarrooms', calendarid=2, roomid=7);
				addRecord(table='calendarrooms', calendarid=2, roomid=8);
				addRecord(table='calendarrooms', calendarid=2, roomid=9);
				addRecord(table='calendarrooms', calendarid=2, roomid=10);
				addRecord(table='calendarrooms', calendarid=2, roomid=11);
				addRecord(table='calendarrooms', calendarid=2, roomid=12);
				addRecord(table='calendarrooms', calendarid=2, roomid=13);
				addRecord(table='calendarrooms', calendarid=2, roomid=14);
				addRecord(table='calendarrooms', calendarid=2, roomid=15);
				addRecord(table='calendarrooms', calendarid=2, roomid=5);

				addRecord(table='calendarrooms', calendarid=2, roomid=16);
				addRecord(table='calendarrooms', calendarid=2, roomid=17);
				addRecord(table='calendarrooms', calendarid=2, roomid=18);
				addRecord(table='calendarrooms', calendarid=2, roomid=19);
				addRecord(table='calendarrooms', calendarid=2, roomid=20);
				addRecord(table='calendarrooms', calendarid=2, roomid=21);
				addRecord(table='calendarrooms', calendarid=2, roomid=22);
				addRecord(table='calendarrooms', calendarid=2, roomid=23);
				addRecord(table='calendarrooms', calendarid=2, roomid=24);
				addRecord(table='calendarrooms', calendarid=2, roomid=25);

				addRecord(table='calendarrooms', calendarid=2, roomid=26);
				addRecord(table='calendarrooms', calendarid=2, roomid=27);
				addRecord(table='calendarrooms', calendarid=2, roomid=28);
				addRecord(table='calendarrooms', calendarid=2, roomid=29);
				addRecord(table='calendarrooms', calendarid=2, roomid=30);
				addRecord(table='calendarrooms', calendarid=2, roomid=31);
				addRecord(table='calendarrooms', calendarid=2, roomid=32);
				addRecord(table='calendarrooms', calendarid=2, roomid=33);
				addRecord(table='calendarrooms', calendarid=2, roomid=34);
				addRecord(table='calendarrooms', calendarid=2, roomid=35);
				addRecord(table='calendarrooms', calendarid=2, roomid=36);
				addRecord(table='calendarrooms', calendarid=2, roomid=37);
				addRecord(table='calendarrooms', calendarid=2, roomid=38);
				addRecord(table='calendarrooms', calendarid=2, roomid=39);
				addRecord(table='calendarrooms', calendarid=2, roomid=40);
				addRecord(table='calendarrooms', calendarid=2, roomid=41);
				addRecord(table='calendarrooms', calendarid=2, roomid=42);
				addRecord(table='calendarrooms', calendarid=2, roomid=43);
				addRecord(table='calendarrooms', calendarid=2, roomid=44);
				addRecord(table='calendarrooms', calendarid=2, roomid=45);

				addRecord(table='calendarrooms', calendarid=2, roomid=46);
				addRecord(table='calendarrooms', calendarid=2, roomid=47);
				addRecord(table='calendarrooms', calendarid=2, roomid=48);
				addRecord(table='calendarrooms', calendarid=2, roomid=49);
				addRecord(table='calendarrooms', calendarid=2, roomid=50);
				addRecord(table='calendarrooms', calendarid=2, roomid=51);
				addRecord(table='calendarrooms', calendarid=2, roomid=52);
				addRecord(table='calendarrooms', calendarid=2, roomid=53);

				addRecord(table='calendarrooms', calendarid=3, roomid=54);
				addRecord(table='calendarrooms', calendarid=3, roomid=55);
				addRecord(table='calendarrooms', calendarid=3, roomid=56);
				addRecord(table='calendarrooms', calendarid=3, roomid=57);
				addRecord(table='calendarrooms', calendarid=3, roomid=58);
				addRecord(table='calendarrooms', calendarid=3, roomid=59);

				addRecord(table='calendarrooms', calendarid=4, roomid=60);
				addRecord(table='calendarrooms', calendarid=4, roomid=61);
				addRecord(table='calendarrooms', calendarid=4, roomid=62);
				addRecord(table='calendarrooms', calendarid=4, roomid=5);


	    	}
	    	catch (any ex){
	    		hasError = true;
		      	catchObject = ex;
	    	}

	    </cfscript>
	     <cfif hasError>
	    	<cftransaction action="rollback" />
	    	<cfthrow
			    detail = "#catchObject.detail#"
			    errorCode = "1"
			    message = "#catchObject.message#"
			    type = "Any">
	    <cfelse>
	    	<cftransaction action="commit" />
	    </cfif>
	 </cftransaction>
  </cffunction>
  <cffunction name="down">
  	<cfset hasError = false />
  	<cftransaction>
	    <cfscript>
	    	try{
				removeRecord(table='calendarrooms');
	    	}
	    	catch (any ex){
	    		hasError = true;
		      	catchObject = ex;
	    	}

	    </cfscript>
	    <cfif hasError>
	    	<cftransaction action="rollback" />
	    	<cfthrow
			    detail = "#catchObject.detail#"
			    errorCode = "1"
			    message = "#catchObject.message#"
			    type = "Any">
	    <cfelse>
	    	<cftransaction action="commit" />
	    </cfif>
	 </cftransaction>
  </cffunction>
</cfcomponent>


