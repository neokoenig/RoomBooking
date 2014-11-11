<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Events --->
<cfcomponent extends="Model">
	<cffunction name="init">
		<cfscript>
			// Associations
			belongsTo("location");
			hasMany("eventresources");
			nestedproperties(associations="eventresources", allowDelete=true);
			// Validation
			validate("checkDates");
			afterFind("formatDates");

		</cfscript>
	</cffunction>

	<cffunction name="checkDates" hint="If there's no end date, add a default end date 1hour into future">
		<cfscript>
		// Have a double check for a start date
		if(!isDate(this.start)){
			this.start=now();
		}
    	if(!isDate(this.end)){
    		// Bookings are for 1 hour by default, so increment if not passed in
    		this.end=dateAdd("h", 1, this.start);
    	}
    	// Don't allow end date to be before start date
    	// We check for -1 to allow for end dates on the same day
    	if((DateCompare("#this.end#", "#this.start#")) EQ -1 ){
			 addError(property="end", message="End Date can not be before Start Date.");
		}
		</cfscript>
	</cffunction>

	<cffunction name="formatDates" hint="Formats Date for DateTime Picker">
		<cfscript>
			//09/22/2013 14:57 +0100
		if(structKeyExists(this, "start")){
			this.start=dateFormat(this.start, "yyyy-mm-dd") & ' ' & timeFormat(this.start, "HH:MM");
		}
		if(structKeyExists(this, "end")){
			this.end=dateFormat(this.end, "yyyy-mm-dd") & ' ' & timeFormat(this.end, "HH:MM");
		}
		</cfscript>
	</cffunction>
</cfcomponent>