# DBMigrate

## What is it?

This is a plugin for the ColdFusion on Wheels framework that provides support for database migrations.  Migrations are a convenient way for you to alter your database in a structured and organized manner.  This plugin tracks which migrations have already been run so all you have to do is update the database by clicking a button!  Also these migrations are database independent

## The Latest Version
The latest version of this script can always be found at the
Github project page which is located at https://github.com/tdm00/cfwheels-dbmigrate-plugin

## Documentation
Additional documentation for this project can be found at https://github.com/tdm00/cfwheels-dbmigrate-plugin/wiki

## Issues
Problems or issues with this software, as well as new features or enhancements to existing features, can be found at https://github.com/tdm00/cfwheels-dbmigrate-plugin/issues

## Versioning
I will be maintaining this application using the following release numbering format:
<major>.<minor>.<patch>
And constructed with the following guidelines:
* Breaking backwards compatibility bumps the major
* New additions without breaking backwards compatibility bumps the minor
* Bug fixes and misc changes bump the patch

## Requirements
ColdFusion on Wheels framework 1.1.3+
I have tested this plugin on the following CFML Engines:

* Adobe ColdFusion 9.0 Standard
* Adobe ColdFusion 9.0 Enterprise
* Railo 3.2.3+

## Installation
There are two ways to install this plugin with your CFWheels application.

1. Download the latest release of this plugin as a ZIP file from https://github.com/tdm00/cfwheels-dbmigrate-plugin/releases/. Unzip this ZIP file and rename the directory `dbmigrate`. Move the directory to the `/plugins` directory of your application. After you've done this correctly you should have the path `/plugins/dbmigrate/Base.cfc` for example.

2. Clone this project into a `dbmigrate` directory within your applications `/plugins` directory. From a Mac / Linux command line change to the `/plugins` directory and then execute `git clone git@github.com:tdm00/cfwheels-dbmigrate-plugin.git dbmigrate`. 

## Special Thanks
Just want to acknowledge, and thanks, everyone that's helped with this plugin.  While I don't have a complete list of names, I did want to mention:

* Ryan Hoppitt
* Chris Peters
* Raúl Reira
* Tom Hoen
* Adam Michel
* James Gibson
* Samson Quaye
* Jeremy Keczan
* Everyone who has submitted bugs on the issue tracker

## License
Since this is a fork of the existing DBMigrate plugin found at http://code.google.com/p/cfwheels-dbmigrate/ I'm including the license information used for that project.
(The MIT License)

Copyright (c) 2010 Ryan Hoppitt

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
