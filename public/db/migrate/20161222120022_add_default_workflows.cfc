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
<cfcomponent extends="wheels.dbmigrate.Migration" hint="Add Default Roles">
  <cffunction name="up">
  	<cfset hasError = false />
  	<cftransaction>
	    <cfscript>
	    	try{
				addRecord(table='workflows', title='Default Workflow', isactive=1);

				addRecord(table='actions', title='Abort',
					description="Abort the Application",
					componentcfc="Abort",
					propertiesjson=""
				);

				addRecord(table='actions', title='Say Hello World',
					description="Inserts Hello World into the flash",
					componentcfc="FlashNotification",
					propertiesjson=serializeJSON({"type": "info", "message": "Hello World!"})
				);

				addRecord(table='actions', title='Set Testvar in Users Session to Foo',
					description="Sets user.properties.testvar in Users Session to Foo",
					componentcfc="SetUserSessionVariable",
					propertiesjson=serializeJSON({"name": "testvar", "to": "Foo"})
				);

				addRecord(table='actions', title='Sets Pagetitle to Foo',
					description="Sets request.pagetitle to Foo",
					componentcfc="SetRequestVariable",
					propertiesjson=serializeJSON({"name": "pagetitle", "to": "Foo"})
				);
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
				removeRecord(table='workflows');
				removeRecord(table='triggers');
				removeRecord(table='actions');
				removeRecord(table='workflowtriggers');
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


