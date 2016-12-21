# OxAlto Room Booking System

This is an open source application for booking rooms via a web based calendar, using cfWheels, Bootstrap3, jQuery, FullCalendar.js, and other bits.

Author: Tom King - http://www.oxalto.co.uk / https://github.com/Neokoenig / @neokoenig

## Demo

You can find a demo at [roombooking.oxalto.co.uk](http://roombooking.oxalto.co.uk)

## Version

Current version is 2.0 [release notes](http://roombooking.readme.io/v2.0/)

2.0 is a breaking release with minimal backwards compatibility.

TODO
 [ ] Full TDD From the start
 [ ] Drop CF10 Compatibility
 [ ] Add CI for lucee 4.5x and lucee 5.1.x + mySQL
 [ ] User password hashing moved to bCrypt
 [ ] Store all timestamps as UTC
 [ ] Add Repeating Rules Logic
 [ ] Localisation
 [ ] TimeZones
 [ ] Add Full JSONApi spec (http://jsonapi.org/) API
 [ ] New Install Process
 [ ] Add DBMigrate
 [ ] FullCalendar JS-> 3.x
 [ ] New Theme?

 Breaking Changes

 [x] `/public/` is now the webroot (to help with docker images etc)

 Framework

 [x] CFWheels upgraded to 1.4.5
 [x] Routing Now Via ColdRoute
 [x] Response Codes Plugin for wheels 2.x -> backport of custom codes


## Documentation

All documentation lives at [roombooking.readme.io](http://roombooking.readme.io)

## Installation & Upgrading

Please see the [roombooking.readme.io](http://roombooking.readme.io) for all documentation including installation and upgrade notes.

## License

Room Booking System is released under the Apache License Version 2.0.
