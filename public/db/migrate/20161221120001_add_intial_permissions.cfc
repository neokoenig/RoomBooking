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
<cfcomponent extends="plugins.dbmigrate.Migration" hint="Add Default Permissions">
  <cffunction name="up">
  	<cfset hasError = false />
  	<cftransaction>
	    <cfscript>
	    	try{
				addRecord(table='permissions', name='accessApplication', description='Base Level Application Access. Set to false to force users to login');
				addRecord(table='rolepermissions', roleid=1, permissionid=1, value=1);
				addRecord(table='rolepermissions', roleid=2, permissionid=1, value=1);
				addRecord(table='rolepermissions', roleid=3, permissionid=1, value=1);
				addRecord(table='rolepermissions', roleid=4, permissionid=1, value=1);
				addRecord(table='rolepermissions', roleid=5, permissionid=1, value=1);
				addRecord(table='rolepermissions', roleid=6, permissionid=1, value=1);
				addRecord(table='permissions', name='accessLogs', description='Allow Administrative Access to Logs');
				addRecord(table='rolepermissions', roleid=1, permissionid=2, value=1);
				addRecord(table='rolepermissions', roleid=2, permissionid=2, value=1);
				addRecord(table='rolepermissions', roleid=3, permissionid=2, value=0);
				addRecord(table='rolepermissions', roleid=4, permissionid=2, value=0);
				addRecord(table='rolepermissions', roleid=5, permissionid=2, value=0);
				addRecord(table='rolepermissions', roleid=6, permissionid=2, value=0);
				addRecord(table='permissions', name='accessPermissions', description='Allow Administrative Access to Permissions');
				addRecord(table='rolepermissions', roleid=1, permissionid=3, value=1);
				addRecord(table='rolepermissions', roleid=2, permissionid=3, value=0);
				addRecord(table='rolepermissions', roleid=3, permissionid=3, value=0);
				addRecord(table='rolepermissions', roleid=4, permissionid=3, value=0);
				addRecord(table='rolepermissions', roleid=5, permissionid=3, value=0);
				addRecord(table='rolepermissions', roleid=6, permissionid=3, value=0);
				addRecord(table='permissions', name='accessSettings', description='Allow Administrative Access to Settings');
				addRecord(table='rolepermissions', roleid=1, permissionid=4, value=1);
				addRecord(table='rolepermissions', roleid=2, permissionid=4, value=0);
				addRecord(table='rolepermissions', roleid=3, permissionid=4, value=0);
				addRecord(table='rolepermissions', roleid=4, permissionid=4, value=0);
				addRecord(table='rolepermissions', roleid=5, permissionid=4, value=0);
				addRecord(table='rolepermissions', roleid=6, permissionid=4, value=0);
				addRecord(table='permissions', name='accessUsers', description='Allow Administrative Access to Users');
				addRecord(table='rolepermissions', roleid=1, permissionid=5, value=1);
				addRecord(table='rolepermissions', roleid=2, permissionid=5, value=1);
				addRecord(table='rolepermissions', roleid=3, permissionid=5, value=0);
				addRecord(table='rolepermissions', roleid=4, permissionid=5, value=0);
				addRecord(table='rolepermissions', roleid=5, permissionid=5, value=0);
				addRecord(table='rolepermissions', roleid=6, permissionid=5, value=0);
				addRecord(table='permissions', name='allowAssume', description='Allow User to Assume other users (requires accessUsers)');
				addRecord(table='rolepermissions', roleid=1, permissionid=6, value=1);
				addRecord(table='rolepermissions', roleid=2, permissionid=6, value=0);
				addRecord(table='rolepermissions', roleid=3, permissionid=6, value=0);
				addRecord(table='rolepermissions', roleid=4, permissionid=6, value=0);
				addRecord(table='rolepermissions', roleid=5, permissionid=6, value=0);
				addRecord(table='rolepermissions', roleid=6, permissionid=6, value=0);
				addRecord(table='permissions', name='accessResources', description='Allow Administrative Access to Resources');
				addRecord(table='rolepermissions', roleid=1, permissionid=7, value=1);
				addRecord(table='rolepermissions', roleid=2, permissionid=7, value=1);
				addRecord(table='rolepermissions', roleid=3, permissionid=7, value=1);
				addRecord(table='rolepermissions', roleid=4, permissionid=7, value=0);
				addRecord(table='rolepermissions', roleid=5, permissionid=7, value=0);
				addRecord(table='rolepermissions', roleid=6, permissionid=7, value=0);
				addRecord(table='permissions', name='accessBuildings', description='Allow Administrative Access to Buildings');
				addRecord(table='rolepermissions', roleid=1, permissionid=8, value=1);
				addRecord(table='rolepermissions', roleid=2, permissionid=8, value=1);
				addRecord(table='rolepermissions', roleid=3, permissionid=8, value=1);
				addRecord(table='rolepermissions', roleid=4, permissionid=8, value=0);
				addRecord(table='rolepermissions', roleid=5, permissionid=8, value=0);
				addRecord(table='rolepermissions', roleid=6, permissionid=8, value=0);
				addRecord(table='permissions', name='accessRooms', description='Allow Administrative Access to Rooms');
				addRecord(table='rolepermissions', roleid=1, permissionid=9, value=1);
				addRecord(table='rolepermissions', roleid=2, permissionid=9, value=1);
				addRecord(table='rolepermissions', roleid=3, permissionid=9, value=1);
				addRecord(table='rolepermissions', roleid=4, permissionid=9, value=0);
				addRecord(table='rolepermissions', roleid=5, permissionid=9, value=0);
				addRecord(table='rolepermissions', roleid=6, permissionid=9, value=0);
				addRecord(table='permissions', name='canCreateBooking', description='Allow User to create a booking');
				addRecord(table='rolepermissions', roleid=1, permissionid=10, value=1);
				addRecord(table='rolepermissions', roleid=2, permissionid=10, value=1);
				addRecord(table='rolepermissions', roleid=3, permissionid=10, value=1);
				addRecord(table='rolepermissions', roleid=4, permissionid=10, value=1);
				addRecord(table='rolepermissions', roleid=5, permissionid=10, value=1);
				addRecord(table='rolepermissions', roleid=6, permissionid=10, value=0);
				addRecord(table='permissions', name='canBypassBookingApproval', description='Allow User to bypass booking approval');
				addRecord(table='rolepermissions', roleid=1, permissionid=11, value=1);
				addRecord(table='rolepermissions', roleid=2, permissionid=11, value=1);
				addRecord(table='rolepermissions', roleid=3, permissionid=11, value=1);
				addRecord(table='rolepermissions', roleid=4, permissionid=11, value=0);
				addRecord(table='rolepermissions', roleid=5, permissionid=11, value=0);
				addRecord(table='rolepermissions', roleid=6, permissionid=11, value=0);
				addRecord(table='permissions', name='accessCalendar', description='Allow User to access the Calendar');
				addRecord(table='rolepermissions', roleid=1, permissionid=12, value=1);
				addRecord(table='rolepermissions', roleid=2, permissionid=12, value=1);
				addRecord(table='rolepermissions', roleid=3, permissionid=12, value=1);
				addRecord(table='rolepermissions', roleid=4, permissionid=12, value=1);
				addRecord(table='rolepermissions', roleid=5, permissionid=12, value=1);
				addRecord(table='rolepermissions', roleid=6, permissionid=12, value=1);
				addRecord(table='permissions', name='accessSchedule', description='Allow User to access the Scehdule');
				addRecord(table='rolepermissions', roleid=1, permissionid=13, value=1);
				addRecord(table='rolepermissions', roleid=2, permissionid=13, value=1);
				addRecord(table='rolepermissions', roleid=3, permissionid=13, value=1);
				addRecord(table='rolepermissions', roleid=4, permissionid=13, value=1);
				addRecord(table='rolepermissions', roleid=5, permissionid=13, value=1);
				addRecord(table='rolepermissions', roleid=6, permissionid=13, value=1);
				addRecord(table='permissions', name='accessBookings', description='Allow Administrative Access to Bookings');
				addRecord(table='rolepermissions', roleid=1, permissionid=14, value=1);
				addRecord(table='rolepermissions', roleid=2, permissionid=14, value=1);
				addRecord(table='rolepermissions', roleid=3, permissionid=14, value=1);
				addRecord(table='rolepermissions', roleid=4, permissionid=14, value=0);
				addRecord(table='rolepermissions', roleid=5, permissionid=14, value=0);
				addRecord(table='rolepermissions', roleid=6, permissionid=14, value=0);
	    	} 	catch (any ex){
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
				removeRecord(table='permissions');
				removeRecord(table='rolepermissions');
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


