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
	    	c=1;
			addRecord(table='permissions', name='admin', description='Required to access anything in admin');
			addRecord(table='rolepermissions', roleid=1, permissionid=c);
			addRecord(table='rolepermissions', roleid=2, permissionid=c);
			addRecord(table='rolepermissions', roleid=3, permissionid=c);
				c++;
				addRecord(table='permissions', name='admin.admin', description='Allow General Access to Admin Dashboard');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
				addRecord(table='rolepermissions', roleid=2, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.admin.index', description='Access Admin Dashboard');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
				c++;
				addRecord(table='permissions', name='admin.bookings', description='Allow Administrative Access to Bookings');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
				addRecord(table='rolepermissions', roleid=2, permissionid=c);
				addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.bookings.index', description='List Bookings');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.bookings.new', description='New Booking');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.bookings.create', description='Create Booking');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.bookings.edit', description='Edit Booking');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.bookings.update', description='Update Booking');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.bookings.delete', description='Delete Booking');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.bookings.approve', description='Approve Booking');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.bookings.clone', description='Clone Booking');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
				c++;
				addRecord(table='permissions', name='admin.buildings', description='Allow General Administrative Access to Buildings');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
				addRecord(table='rolepermissions', roleid=2, permissionid=c);
				addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.buildings.index', description='List Buildings');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.buildings.new', description='New Building');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.buildings.create', description='Create Building');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.buildings.edit', description='Edit Building');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.buildings.update', description='Update Building');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.buildings.delete', description='Delete Building');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
				c++;
				addRecord(table='permissions', name='admin.calendars', description='Allow General Access to administer the Calendars');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
				addRecord(table='rolepermissions', roleid=2, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.calendars.index', description='List Calendars');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.calendars.new', description='New Calendar');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.calendars.create', description='Create Calendar');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.calendars.edit', description='Edit Calendar');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.calendars.update', description='Update Calendar');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.calendars.delete', description='Delete Calendar');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
				c++;
				addRecord(table='permissions', name='admin.dump', description='Allow General Administrative Access to DUMP');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
				addRecord(table='rolepermissions', roleid=2, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.dump.index', description='View DUMP');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
				c++;
				addRecord(table='permissions', name='admin.logs', description='Allow General Administrative Access to Logs');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
				addRecord(table='rolepermissions', roleid=2, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.logs.index', description='View Logs');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
				c++;
				addRecord(table='permissions', name='admin.permissions', description='Allow General Administrative Access to Permissions');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.permissions.index', description='List Permissions');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.permissions.edit', description='Edit Permission');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.permissions.update', description='Update Permission');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
				c++;
				addRecord(table='permissions', name='admin.settings', description='Allow General Administrative Access to Settings');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
				addRecord(table='rolepermissions', roleid=2, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.settings.index', description='List Settings');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.settings.edit', description='Edit Setting');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.settings.update', description='Update Setting');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
				c++;
				addRecord(table='permissions', name='admin.users', description='Allow General Administrative Access to Users');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.users.index', description='List Users');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.users.new', description='New User');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.users.create', description='Create User');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.users.edit', description='Edit User');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.users.update', description='Update User');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.users.delete', description='Delete User');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.users.recover', description='Recover User');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.users.show', description='View User');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.users.assume', description='Assume Users (Grant only to sysadmins)');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
				c++;
				addRecord(table='permissions', name='admin.resources', description='Allow General Administrative Access to Resources');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
				addRecord(table='rolepermissions', roleid=2, permissionid=c);
				addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.resources.index', description='List Resources');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.resources.new', description='New Resource');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.resources.create', description='Create Resource');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.resources.edit', description='Edit Resource');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.resources.update', description='Update Resource');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.resources.delete', description='Delete Resource');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
				c++;
				addRecord(table='permissions', name='admin.roles', description='Allow General Administrative Access to Roles');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.roles.index', description='List Roles');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.roles.new', description='New Role');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.roles.create', description='Create Role');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.roles.edit', description='Edit Role');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.roles.update', description='Update Role');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.roles.delete', description='Delete Role');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
				c++;
				addRecord(table='permissions', name='admin.workflows', description='Allow General Administrative Access to workflows');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.workflows.index', description='List workflows');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.workflows.new', description='New Workflow');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.workflows.create', description='Create Workflow');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.workflows.edit', description='Edit Workflow');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.workflows.update', description='Update Workflow');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.workflows.delete', description='Delete Workflow');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
				c++;
				addRecord(table='permissions', name='admin.workflowtriggers', description='Allow General Administrative Access to workflowtriggers');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.workflowtriggers.index', description='View Workflow Triggers');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.workflowtriggers.delete', description='Remove Workflow Trigger');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.workflowtriggers.create', description='Add Workflow Trigger');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
				c++;
				addRecord(table='permissions', name='admin.triggers', description='Allow General Administrative Access to Triggers');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.triggers.index', description='List triggers');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.triggers.new', description='New Trigger');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.triggers.create', description='Create Trigger');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.triggers.edit', description='Edit Trigger');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.triggers.update', description='Update Trigger');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.triggers.delete', description='Delete Trigger');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
				c++;
				addRecord(table='permissions', name='admin.actions', description='Allow General Administrative Access to Actions');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.actions.index', description='List actions');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.actions.new', description='New Action');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.actions.create', description='Create Action');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.actions.edit', description='Edit Action');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.actions.update', description='Update Action');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.actions.delete', description='Delete Action');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.actions.properties', description='Get CFC Action Properties');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
				c++;
				addRecord(table='permissions', name='admin.rooms', description='Allow General Administrative Access to Rooms');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
				addRecord(table='rolepermissions', roleid=2, permissionid=c);
				addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.rooms.index', description='List Rooms');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.rooms.new', description='New Room');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.rooms.create', description='Create Room');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.rooms.edit', description='Edit Room');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.rooms.update', description='Update Room');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					c++;
					addRecord(table='permissions', name='admin.rooms.delete', description='Delete Room');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
				c++;
				addRecord(table='permissions', name='bookings.new', description='New Booking Form');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
				addRecord(table='rolepermissions', roleid=2, permissionid=c);
				addRecord(table='rolepermissions', roleid=3, permissionid=c);
				addRecord(table='rolepermissions', roleid=4, permissionid=c);
				addRecord(table='rolepermissions', roleid=5, permissionid=c);
				c++;
				addRecord(table='permissions', name='bookings.create', description='Create a booking');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
				addRecord(table='rolepermissions', roleid=2, permissionid=c);
				addRecord(table='rolepermissions', roleid=3, permissionid=c);
				addRecord(table='rolepermissions', roleid=4, permissionid=c);
				addRecord(table='rolepermissions', roleid=5, permissionid=c);
				c++;
				addRecord(table='permissions', name='test.test', description='Test Permission');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
				addRecord(table='rolepermissions', roleid=2, permissionid=c);
				addRecord(table='rolepermissions', roleid=3, permissionid=c);
				c++;
				addRecord(table='permissions', name='my', description='Allow General Access to Own Profile/Booking Listings');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
				addRecord(table='rolepermissions', roleid=2, permissionid=c);
				addRecord(table='rolepermissions', roleid=3, permissionid=c);
				addRecord(table='rolepermissions', roleid=4, permissionid=c);
				addRecord(table='rolepermissions', roleid=5, permissionid=c);
					c++;
					addRecord(table='permissions', name='my.account', description='View Own Account');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					addRecord(table='rolepermissions', roleid=4, permissionid=c);
					addRecord(table='rolepermissions', roleid=5, permissionid=c);
					c++;
					addRecord(table='permissions', name='my.accountupdate', description='Update Own Account');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					addRecord(table='rolepermissions', roleid=4, permissionid=c);
					addRecord(table='rolepermissions', roleid=5, permissionid=c);
					c++;
					addRecord(table='permissions', name='my.bookings', description='View Own Bookings');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					addRecord(table='rolepermissions', roleid=4, permissionid=c);
					addRecord(table='rolepermissions', roleid=5, permissionid=c);
				c++;
				addRecord(table='permissions', name='bookings', description='Allow Booking Request Access');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
				addRecord(table='rolepermissions', roleid=2, permissionid=c);
				addRecord(table='rolepermissions', roleid=3, permissionid=c);
				addRecord(table='rolepermissions', roleid=4, permissionid=c);
				addRecord(table='rolepermissions', roleid=5, permissionid=c);
				addRecord(table='rolepermissions', roleid=6, permissionid=c);
					c++;
					addRecord(table='permissions', name='bookings.wizard', description='Allow user to access the booking wizard');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					addRecord(table='rolepermissions', roleid=4, permissionid=c);
					addRecord(table='rolepermissions', roleid=5, permissionid=c);
					addRecord(table='rolepermissions', roleid=6, permissionid=c);
				c++;
				addRecord(table='permissions', name='calendar', description='Allow General Calendar Access');
				addRecord(table='rolepermissions', roleid=1, permissionid=c);
				addRecord(table='rolepermissions', roleid=2, permissionid=c);
				addRecord(table='rolepermissions', roleid=3, permissionid=c);
				addRecord(table='rolepermissions', roleid=4, permissionid=c);
				addRecord(table='rolepermissions', roleid=5, permissionid=c);
				addRecord(table='rolepermissions', roleid=6, permissionid=c);
					c++;
					addRecord(table='permissions', name='calendar.index', description='Allow User to view the Main Calendar');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					addRecord(table='rolepermissions', roleid=4, permissionid=c);
					addRecord(table='rolepermissions', roleid=5, permissionid=c);
					addRecord(table='rolepermissions', roleid=6, permissionid=c);
					c++;
					addRecord(table='permissions', name='calendar.show', description='Allow User to View Calendars');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					addRecord(table='rolepermissions', roleid=4, permissionid=c);
					addRecord(table='rolepermissions', roleid=5, permissionid=c);
					addRecord(table='rolepermissions', roleid=6, permissionid=c);
					c++;
					addRecord(table='permissions', name='calendar.fullcalendardata', description='Required for Full Calendar to get remote data');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					addRecord(table='rolepermissions', roleid=4, permissionid=c);
					addRecord(table='rolepermissions', roleid=5, permissionid=c);
					addRecord(table='rolepermissions', roleid=6, permissionid=c);
					c++;
					addRecord(table='permissions', name='calendar.fullcalendarfilters', description='Required for Full Calendar to get remote filters');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					addRecord(table='rolepermissions', roleid=4, permissionid=c);
					addRecord(table='rolepermissions', roleid=5, permissionid=c);
					addRecord(table='rolepermissions', roleid=6, permissionid=c);
					c++;
					addRecord(table='permissions', name='calendar.fullcalendarresources', description='Required for Full Calendar to get remote locations');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					addRecord(table='rolepermissions', roleid=4, permissionid=c);
					addRecord(table='rolepermissions', roleid=5, permissionid=c);
					addRecord(table='rolepermissions', roleid=6, permissionid=c);
					c++;
					addRecord(table='permissions', name='calendar.yearcalendardata', description='Required for Year Calendar to get remote data');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					addRecord(table='rolepermissions', roleid=4, permissionid=c);
					addRecord(table='rolepermissions', roleid=5, permissionid=c);
					addRecord(table='rolepermissions', roleid=6, permissionid=c);

					c++;
					addRecord(table='permissions', name='calendar.detail', description='View Booking Details in Calendar Sidepanel');
					addRecord(table='rolepermissions', roleid=1, permissionid=c);
					addRecord(table='rolepermissions', roleid=2, permissionid=c);
					addRecord(table='rolepermissions', roleid=3, permissionid=c);
					addRecord(table='rolepermissions', roleid=4, permissionid=c);
					addRecord(table='rolepermissions', roleid=5, permissionid=c);
					addRecord(table='rolepermissions', roleid=6, permissionid=c);

				c++;
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


