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

		    	for (i=1;i LTE 10;i=i+1) {
		    		addRecord(table='bookings', title="Test Booking #i#", startUTC=dateAdd('d', i, now()), endUTC=dateAdd('n', 30, dateAdd('d', i, now())), userid=1, duration=30,
		    			buildingid=1, roomid=1, isapproved=1, approvedby=1, isrepeat=0, adminnotes="Added via DB Migration", createdAt=now());

				}
				for (i=1;i LTE 5;i=i+1) {
		    		addRecord(table='bookings', title="Engine Test #i#", startUTC=dateAdd('ww', i, now()), endUTC=dateAdd('n', 600, dateAdd('ww', i, now())), userid=1, duration=600,
		    			buildingid=6, roomid=59, isapproved=1, approvedby=1, isrepeat=0, adminnotes="Added via DB Migration", createdAt=now());

				}

				addRecord(table='bookings', title="Joe Bloggs", startUTC=dateAdd('ww', 1, now()), endUTC=dateAdd('ww', 2, now()), isallday=1, userid=1, duration=(7 * 1440),
		    			buildingid=3, roomid=26, isapproved=1, approvedby=1, isrepeat=0, adminnotes="Added via DB Migration", createdAt=now());
				addRecord(table='bookings', title="Joe Bloggs", startUTC=dateAdd('ww', 1, now()), endUTC=dateAdd('ww', 2, now()), isallday=1, userid=1, duration=(7 * 1440),
		    			buildingid=3, roomid=27, isapproved=1, approvedby=1, isrepeat=0, adminnotes="Added via DB Migration", createdAt=now());
				addRecord(table='bookings', title="Joe Bloggs", startUTC=dateAdd('ww', 2, now()), endUTC=dateAdd('ww', 3, now()), isallday=1, userid=1, duration=(7 * 1440),
		    			buildingid=3, roomid=45, isapproved=1, approvedby=1, isrepeat=0, adminnotes="Added via DB Migration", createdAt=now());
				addRecord(table='bookings', title="Joe Bloggs", startUTC=dateAdd('ww', 6, now()), endUTC=dateAdd('ww', 8, now()), isallday=1, userid=1, duration=(14 * 1440),
		    			buildingid=3, roomid=46, isapproved=1, approvedby=1, isrepeat=0, adminnotes="Added via DB Migration", createdAt=now());

		    	for (p=1;p LTE 10;p=p+1) {
		    		addRecord(table='bookings', title="Test Booking 1_#p#", startUTC=dateAdd('d', p, now()), endUTC=dateAdd('n', 90, dateAdd('d', p, now())), userid=1, duration=90,
		    			buildingid=0, roomid=2, isapproved=1, approvedby=1, isrepeat=0, adminnotes="Added via DB Migration", createdAt=now());
				}
				addRecord(table='bookings', title="MultiDay Event", startUTC=now(), endUTC=dateAdd('n', 2880, now()), userid=1, duration=2880,
		    			buildingid=2, roomid=4, isallday=1, isapproved=1, approvedby=1, isrepeat=0,  adminnotes="Added via DB Migration", createdAt=now());

				addRecord(table='bookings', title="Daily Forever", startUTC=createDateTime(2013,10,1,09,00,00), endUTC=createDateTime(9999,12,31,09,00,00), userid=1, duration=120,
		    			buildingid=2, roomid=4, isapproved=1, approvedby=1, isrepeat=1, repeatpattern="RRULE:FREQ=DAILY", adminnotes="Added via DB Migration", createdAt=now());
				addRecord(table='bookings', title="Weekly Forever", startUTC=createDateTime(2016,10,1,09,00,00), endUTC=createDateTime(9999,12,31,09,00,00), userid=1, duration=300,
		    			buildingid=0, roomid=5, isapproved=1, approvedby=1, isrepeat=1, repeatpattern="RRULE:FREQ=WEEKLY", adminnotes="Added via DB Migration", createdAt=now());
				addRecord(table='bookings', title="Weekly on WED Forever", startUTC=createDateTime(2016,12,30,13,00,00), endUTC=createDateTime(9999,12,31,09,00,00), userid=1, duration=300,
		    			buildingid=0, roomid=5, isapproved=1, approvedby=1, isrepeat=1, repeatpattern="RRULE:FREQ=WEEKLY;BYDAY=WE", adminnotes="Added via DB Migration", createdAt=now());
				addRecord(table='bookings', title="Monthly on 2nd Forever", startUTC=createDateTime(2016,12,02,15,00,00), endUTC=createDateTime(9999,12,31,09,00,00), userid=1, duration=120,
		    			buildingid=2, roomid=3, isapproved=1, approvedby=1, isrepeat=1, repeatpattern="RRULE:FREQ=MONTHLY;BYMONTHDAY=2", adminnotes="Added via DB Migration", createdAt=now());
				addRecord(table='bookings', title="Every 2nd Month Forever", startUTC=createDateTime(2016,12,03,15,00,00), endUTC=createDateTime(9999,12,31,09,00,00), userid=1, duration=120,
		    			buildingid=2, roomid=3, isapproved=1, approvedby=1, isrepeat=1, repeatpattern="RRULE:FREQ=MONTHLY;INTERVAL=2;BYMONTHDAY=2", adminnotes="Added via DB Migration", createdAt=now());
				addRecord(table='bookings', title="Pending Approval", startUTC=dateAdd('d', 12, now()), endUTC=dateAdd('n', 120, dateAdd('d', 12, now())), userid=1, duration=120,
		    			buildingid=2, roomid=3, isapproved=0, isrepeat=0, adminnotes="Added via DB Migration", createdAt=now());
				addRecord(table='bookings', title="GnR", startUTC=dateAdd('d', 12, now()), endUTC=dateAdd('d', 42, dateAdd('d', 12, now())), userid=1, duration=(30*1440),
		    			buildingid=0, roomid=61, isapproved=0, isAllDay=1, isrepeat=0, adminnotes="Added via DB Migration", createdAt=now());		addRecord(table='bookings', title="GnR", startUTC=dateAdd('d', 24, now()), endUTC=dateAdd('d', 42, dateAdd('d', 24, now())), userid=1, duration=(30*1440),
		    			buildingid=0, roomid=62, isapproved=0, isAllDay=1, isrepeat=0, adminnotes="Added via DB Migration", createdAt=now());		addRecord(table='bookings', title="GnR", startUTC=dateAdd('d', 12, now()), endUTC=dateAdd('d', 42, dateAdd('d', 12, now())), userid=1, duration=(30*1440),
		    			buildingid=0, roomid=63, isapproved=0, isAllDay=1, isrepeat=0, adminnotes="Added via DB Migration", createdAt=now());
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
	    		removeRecord(table='bookings');
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


