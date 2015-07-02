//================= Room Booking System / https://github.com/neokoenig =======================--->
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
		afterInitialization("registerSystemFields");
		beforeCreate("checkApproval");
	}

	/**
	*  @hint Sets a default status - if approval is on, set to pending, otherwise autoapprove
	*/
	public void function checkApproval() {
		if(application.rbs.setting.approveBooking){
			this.status="pending";
		} else {
			this.status="approved";
		}
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

	/**
	*  @hint
	*/
	public void function registerSystemFields() {

		this.systemfields=[
			{
				name: "title",
				label: "Event Title",
				type: "textfield",
				options: "",
				class: "",
				description: "",
				placeholder: "e.g My Meeting",
				required: 1
			},
			{
				name: "start",
				label: "Starts",
				type: "datepicker",
				options: "",
				class: "",
				description: "",
				placeholder: "",
				required: 1
			},
			{
				name: "status",
				label: "Status",
				type: "select",
				options: "{pending: 'Pending', denied: 'Denied', approved: 'Approved'}",
				class: "",
				description: "",
				placeholder: "",
				required: 0
			},
			{
				name: "end",
				label: "Ends",
				type: "datepicker",
				options: "",
				class: "",
				description: "",
				placeholder: "",
				required: 1
			},
			{
				name: "allday",
				label: "",
				type: "checkbox",
				options: '[{"1": "This is an all day event"}]',
				class: "",
				description: "",
				placeholder: "",
				required: 0
			},
			{
				name: "description",
				label: "Description",
				type: "textarea",
				options: "",
				class: "",
				description: "",
				placeholder: "Optional Notes about this event",
				required: 0
			},
			{
				name: "locationid",
				label: "Location",
				type: "select",
				options: "locations",
				class: "",
				description: "",
				placeholder: "",
				required: 1
			},
			{
				name: "layoutstyle",
				label: "Layout",
				type: "select",
				options: "application.rbs.setting.roomlayouttypes",
				class: "",
				description: "",
				placeholder: "",
				required: 0
			},
			{
				name: "contactname",
				label: "Contact Name",
				type: "textfield",
				options: "",
				class: "",
				description: "",
				placeholder: "e.g Joe Bloggs",
				required: 0
			},
			{
				name: "contactemail",
				label: "Email",
				type: "textfield",
				options: "",
				class: "",
				description: "",
				placeholder: "e.g Joe@blogs.com",
				required: 0
			},
			{
				name: "contactno",
				label: "Tel No.",
				type: "textfield",
				options: "",
				class: "",
				description: "",
				placeholder: "e.g 123123123",
				required: 0
			},
			{
				name: "emailcontact",
				label: "",
				type: "checkbox",
				options: '[{"1": "Send Confirmation Email to Contact"}]',
				class: "",
				description: "",
				placeholder: "",
				required: 0
			}
		];
	}
}