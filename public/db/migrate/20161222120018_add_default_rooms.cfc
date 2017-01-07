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
				addRecord(table='rooms', userid=1, description="Main Lecture Theatre, seating up to 210", icon="fa-mortar-board", hexcolour="0E9E63", title='Lecture Theatre', floor="Ground", buildingid=1);
				addRecord(table='rooms', userid=1, description="Large meeting room seating up to 25", icon="fa-square", hexcolour="0E1B9E", title='Large Meeting Room', floor="Basement", buildingid=1);
				addRecord(table='rooms', userid=1, description="Small meeting room seating up to 8", icon="fa-square", hexcolour="9E0E3C", title='Glass Meeting Room', floor="0", buildingid=2);
				addRecord(table='rooms', userid=1, description="Polycom Realsize VC unit available", icon="fa-video-camera", hexcolour="9E5F0E", title='Video Conference Suite', floor="0", buildingid=2);
				addRecord(table='rooms', userid=1, description="Available to both 58 & 60 Wall St", icon="fa-car", hexcolour="B513BD", title='Executive Parking Spot', floor="0");

				addRecord(table='rooms', userid=1, description="DeLuxe Queen Double Room with Disabled Access", icon="fa-wheelchair", hexcolour="8C6201", title='101 Deluxe Queen', floor="First", buildingid=3);
				addRecord(table='rooms', userid=1, description="DeLuxe Queen Double Room with Disabled Access", icon="fa-wheelchair", hexcolour="8C6201", title='102 Deluxe Queen', floor="First", buildingid=3);
				addRecord(table='rooms', userid=1, description="DeLuxe King Double Room with Disabled Access", icon="fa-wheelchair", hexcolour="BD8A13", title='103 Deluxe King', floor="First", buildingid=3);
				addRecord(table='rooms', userid=1, description="DeLuxe King Double Room with Disabled Access", icon="fa-wheelchair", hexcolour="BD8A13", title='104 Deluxe King', floor="First", buildingid=3);
				addRecord(table='rooms', userid=1, description="DeLuxe King Double Room", icon="fa-bed", hexcolour="0B63B7", title='105 Deluxe King', floor="First", buildingid=3);
				addRecord(table='rooms', userid=1, description="DeLuxe King Double Room", icon="fa-bed", hexcolour="0B63B7", title='106 Deluxe King', floor="First", buildingid=3);
				addRecord(table='rooms', userid=1, description="DeLuxe King Double Room", icon="fa-bed", hexcolour="0B63B7", title='107 Deluxe King', floor="First", buildingid=3);
				addRecord(table='rooms', userid=1, description="DeLuxe King Double Room", icon="fa-bed", hexcolour="0B63B7", title='108 Deluxe King', floor="First", buildingid=3);
				addRecord(table='rooms', userid=1, description="DeLuxe King Double Room", icon="fa-bed", hexcolour="0B63B7", title='109 Deluxe King', floor="First", buildingid=3);
				addRecord(table='rooms', userid=1, description="DeLuxe King Double Room", icon="fa-bed", hexcolour="0B63B7", title='110 Deluxe King', floor="First", buildingid=3);
				addRecord(table='rooms', userid=1, description="DeLuxe King Double Room", icon="fa-bed", hexcolour="0B63B7", title='111 Deluxe King', floor="First", buildingid=3);
				addRecord(table='rooms', userid=1, description="DeLuxe King Double Room", icon="fa-bed", hexcolour="0B63B7", title='112 Deluxe King', floor="First", buildingid=3);
				addRecord(table='rooms', userid=1, description="Junior Suite", icon="fa-bed", hexcolour="0BB747", title='201 Jun. Suite', floor="Second", buildingid=3);
				addRecord(table='rooms', userid=1, description="Junior Suite", icon="fa-bed", hexcolour="0BB747", title='202 Jun. Suite', floor="Second", buildingid=3);
				addRecord(table='rooms', userid=1, description="Junior Suite", icon="fa-bed", hexcolour="0BB747", title='203 Jun. Suite', floor="Second", buildingid=3);
				addRecord(table='rooms', userid=1, description="Junior Suite", icon="fa-bed", hexcolour="0BB747", title='204 Jun. Suite', floor="Second", buildingid=3);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='205 Sup. Double', floor="Second", buildingid=3);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='206 Sup. Double', floor="Second", buildingid=3);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='207 Sup. Double', floor="Second", buildingid=3);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='208 Sup. Double', floor="Second", buildingid=3);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='209 Sup. Double', floor="Second", buildingid=3);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='210 Sup. Double', floor="Second", buildingid=3);
				addRecord(table='rooms', userid=1, description="Royal Suite", icon="fa-bed", hexcolour="470E9E", title='211 Royal Suite', floor="Second", buildingid=3);
				addRecord(table='rooms', userid=1, description="Presidential Suite", icon="fa-bed", hexcolour="9E0E58", title='212 Pres. Suite', floor="Second", buildingid=3);

				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='101', floor="Ground", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='102', floor="Ground", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='103', floor="Ground", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='104', floor="Ground", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='105', floor="Ground", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='106', floor="Ground", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='107', floor="Ground", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='108', floor="Ground", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='109', floor="Ground", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='110', floor="Ground", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='111', floor="Ground", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='112', floor="Ground", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='201', floor="First", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='202', floor="First", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='203', floor="First", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='204', floor="First", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='205', floor="First", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='206', floor="First", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='207', floor="First", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='208', floor="First", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='209', floor="First", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='210', floor="First", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='211', floor="First", buildingid=4);
				addRecord(table='rooms', userid=1, description="Superior King Double Room", icon="fa-bed", hexcolour="297DCD", title='212', floor="First", buildingid=4);

				addRecord(table='rooms', userid=1, description="Basement Lab 1", icon="fa-flask", hexcolour="0E1B9E", title='Lab 1', floor="0", buildingid=5);
				addRecord(table='rooms', userid=1, description="Ground Floor Lab 2a", icon="fa-flask", hexcolour="9E0E3C", title='Lab 2a', floor="0", buildingid=5);
				addRecord(table='rooms', userid=1, description="Ground Floor Lab 2b", icon="fa-flask", hexcolour="9E5F0E", title='Lab 2b', floor="0", buildingid=5);

				addRecord(table='rooms', userid=1, description="Rocket Science Lab", icon="fa-space-shuttle", hexcolour="0E1B9E", title='Rocket Science Lab', floor="Public", buildingid=6);
				addRecord(table='rooms', userid=1, description="Jet Propulsion Lab", icon="fa-space-shuttle", hexcolour="9E0E3C", title='Jet Propulsion Lab', floor="Public", buildingid=6);
				addRecord(table='rooms', userid=1, description="Secret Dexter Lab", icon="fa-space-shuttle", hexcolour="9E5F0E", title='Secret Dexter Lab', floor="Secret", buildingid=6);

				addRecord(table='rooms', userid=1, description="Large Recording Studio with seperate live room and vocal booth", icon="fa-microphone", hexcolour="0E1B9E", title='Studio A', floor="0");
				addRecord(table='rooms', userid=1, description="Mid sized live room", icon="fa-microphone", hexcolour="9E0E3C", title='Studio B', floor="0");
				addRecord(table='rooms', userid=1, description="Mastering suite with protools and Dolby 7.1", icon="fa-microphone", hexcolour="9E5F0E", title='Studio C', floor="0");
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
				removeRecord(table='rooms');
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


