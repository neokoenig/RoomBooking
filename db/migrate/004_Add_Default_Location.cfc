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
<cfcomponent extends="plugins.dbmigrate.Migration" hint="Add Default Location">
  <cffunction name="up">
    <cfscript>
      addRecord(table='locations', name="Lecture Theatre", description="First Floor", class="lt", colour="##cc0000"); 
      addRecord(table='locations', name="Seminar Room 1", description="Ground Floor", class="sm1", colour="##2c86ff"); 
      addRecord(table='locations', name="Seminar Room 2", description="Ground Floor", class="sm2", colour="##a1a100"); 
      addRecord(table='locations', name="Conference Room", description="Ground Floor", class="gfcr", colour="##FF6600"); 
      addRecord(table='locations', name="Café", description="First Floor", class="cafe", colour="##800080"); 
      addRecord(table='locations', name="AV Suite", description="Basement", class="avsuite", colour="##167362"); 
    </cfscript>
  </cffunction>
  <cffunction name="down">
    <cfscript>
		removeRecord(table='locations');
    </cfscript>
  </cffunction>
</cfcomponent>
