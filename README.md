# Room Booking System

This is an open source application for booking rooms via a web based calendar, using cfWheels, Bootstrap3, jQuery, FullCalendar.js, and other bits.

## Requirements

 1. A server capable of running a cfWheels application -  Adobe Coldfusion (8.x upwards) or Railo (4.x upwards), preferably with URL rewriting
 2. Database - one of MySQL / Microsoft SQL Server / Oracle / PostgreSQL - whilst this should work on any of those, it's been tested on mySQL 5.x.

## Installation

 1. Download https://github.com/OxfordMartinSchool/RoomBooking/archive/master.zip
 2. Unzip the contents of RoomBooking-master into your web root
 3. Create a datasource in Railo/ColdFusion administrator called 'roombooking' (this is the default, and changeable in config/settings.cfm);
 4. Visit the following URL: http://yourdomain.com/rewrite.cfm?controller=wheels&action=wheels&view=plugins&name=dbmigrate 
 5. Select "All non-migrated" from the migrate dropdown and click "Get Migrating!" - this will populate your database with the default tables and default configuration
 6. Now reload your application by visiting http://yourdomain.com/?reload=design&password=roombooking
 7. Lastly, you probably want to change the reloadpassword in config/settings.cfm

 