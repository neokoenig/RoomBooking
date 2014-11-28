<!---================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Model" hint="Main Event Object"
{
	/**
	 * @hint Constructor
	 */
	public void function init() {
		// Assocations
		belongsTo("location");
		hasMany("eventresources");
		nestedproperties(associations="eventresources", allowDelete=true);
		// Validation
		validate("checkDates");
		afterFind("formatDates");
	}

	/**
	*  @hint If there's no end date, add a default end date 1hour into future
	*/
	public void function checkDates() {
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
	}

	/**
	*  @hint Formats Date for DateTime Picker
	*/
	public void function formatDates() {
		if(structKeyExists(this, "start")){
			this.start=dateFormat(this.start, "DD MMM YYYY") & ' ' & timeFormat(this.start, "HH:mm");
		}
		if(structKeyExists(this, "end")){
			this.end=dateFormat(this.end, "DD MMM YYYY") & ' ' & timeFormat(this.end, "HH:mm");
		}
	}
}