<!---
    |-------------------------------------------------------------------------------------------|
	| Parameter     | Required | Type    | Default | Description                                |
    |-------------------------------------------------------------------------------------------|
	| table         | Yes      | string  |         | Name of table to add record to             |
	| columnNames   | Yes      | string  |         | Use column name as argument name and value |
    |-------------------------------------------------------------------------------------------|

    EXAMPLE:
      addRecord(table='members',id=1,username='admin',password='#Hash("admin")#');
 
--->
<cfcomponent extends="plugins.dbmigrate.Migration" hint="Add Default Permissions">
  <cffunction name="up">
    <cfscript>
	    addRecord(table='permissions', id='accessApplication',    admin=1, editor=1, user=1, guest=1, notes='Allow access to the application');
      addRecord(table='permissions', id='accessCalendar',       admin=1, editor=1, user=1, guest=1, notes='Allow access to the calendar');
      addRecord(table='permissions', id='viewRoomBooking',      admin=1, editor=1, user=1, guest=1, notes='View Room Booking Details'); 
      addRecord(table='permissions', id='allowAPI',             admin=1, editor=1, user=1, guest=1, notes='Reserved for future use');
      addRecord(table='permissions', id='allowiCal',            admin=1, editor=1, user=1, guest=1, notes='Reserved for future use');     
      addRecord(table='permissions', id='allowRSS',             admin=1, editor=1, user=1, guest=1, notes='Reserved for future use');

      addRecord(table='permissions', id='allowRoomBooking',     admin=1, editor=1, user=1, guest=0, notes='Allow Facility to create events');
      addRecord(table='permissions', id='updateOwnAccount',     admin=1, editor=1, user=1, guest=0, notes='Allows a user to update their own details');
      addRecord(table='permissions', id='accessLocations',      admin=1, editor=1, user=0, guest=0, notes='Allow access to Locations Editing');
      addRecord(table='permissions', id='accessSettings',       admin=1, editor=1, user=0, guest=0, notes='Allow access to Settings');
      addRecord(table='permissions', id='accessLogfiles',       admin=1, editor=0, user=0, guest=0, notes='Allow access to Logfiles');
      addRecord(table='permissions', id='accessPermissions',    admin=1, editor=0, user=0, guest=0, notes='Allow access to Permissions');
      addRecord(table='permissions', id='accessUsers',          admin=1, editor=0, user=0, guest=0, notes='Allow access to User Accounts');

      
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
		removeRecord(table='permissions',where='');
    </cfscript>
  </cffunction>
</cfcomponent>
