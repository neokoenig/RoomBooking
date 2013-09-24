# Room Booking System

This is an open source application for booking rooms via a web based calendar, using cfWheels, Bootstrap3, jQuery, FullCalendar.js, and other bits.

Author: Tom King - http://www.oxalto.co.uk / https://github.com/Neokoenig / @neokoenig

## Demo

You can find a demo at [roombooking.oxalto.co.uk][12]

## Requirements

 1. A server capable of running a cfWheels application -  Adobe Coldfusion (8.x upwards) or Railo (4.x upwards), preferably with URL rewriting
 2. Database - one of MySQL / Microsoft SQL Server / Oracle / PostgreSQL - whilst this should work on any of those, it's been tested on mySQL 5.x.

## Installation

 1. Download https://github.com/OxfordMartinSchool/RoomBooking/archive/master.zip
 2. Unzip the contents of RoomBooking-master into your web root
 3. Create a datasource in Railo/ColdFusion administrator called 'roombooking' (this is the default, and changeable in config/settings.cfm);
 4. Visit the following URL: http://yourdomain.com/rewrite.cfm?controller=wheels&action=wheels&view=plugins&name=dbmigrate 
 5. Select "All non-migrated" from the migrate dropdown and click "Get Migrating!" - this will populate your database with the default tables and default configuration
 6. Now reload your application by visiting http://yourdomain.com/?reload=design&password=roombooking - you'll see some default locations have been set up.
 7. Go to Settings > Configuration from the dropdown menu on the top right corner and configure each setting appropriately. In particular, make sure you update the error & site email addresses.
 8. Go to Settings > Locations, and delete the locations there if they aren't appropriate. They're there to give you a starting point. In order for events to display, you'll need at least one location.
 9. Lastly, you probably want to change the reloadpassword in config/settings.cfm, and when you're happy with how it's running, change the environment from design to production in config/environment.cfm

## Notes
 
 This application uses the following plugins and 3rd party code:

 1. [ColdFusion on Wheels][1]
 2. [jQuery][2]
 3. [jQueryUI][3]
 4. [Bootstrap3] [4]
 5. [Bootswatch Themes][5]
 6. [FullCalendar][6]
 7. [TimePicker][7]
 8. [MomentJS][8]
 9. [Colorpicker for Twitter Bootstrap][9]
 10: [cfWheels DBMigrate Plugin][10] 
 11: [cfWheels FlashWrapper Plugin][11] 

[1]: http://cfwheels.org/
[2]: http://jquery.com/
[3]: http://jqueryui.com/
[4]: http://getbootstrap.com/
[5]: http://bootswatch.com/
[6]: http://arshaw.com/fullcalendar/
[7]: http://trentrichardson.com/examples/timepicker/
[8]: http://momentjs.com/
[9]: http://mjaalnir.github.io/bootstrap-colorpicker/
[10]: http://cfwheels.org/plugins/listing/28
[11]: https://github.com/gregstallings/cfwheels-flash-wrapper
[12]: http://roombooking.oxalto.co.uk

## License

Room Booking System is released under the Apache License Version 2.0.


 