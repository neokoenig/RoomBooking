//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Model" hint="Main Event Object"
{
	/*
	 * @hint Constructor
	 */
	public void function init() {
		// Assocations
		belongsTo(name="location");
		hasMany(name="eventresources", dependent="delete");
		hasMany(name="eventexceptions", dependent="delete");
		nestedproperties(associations="eventresources", allowDelete=true);
		// Validation
		//validate("checkDates");
		//afterFind("formatDates");
		afterInitialization("registerSystemFields");
		beforeSave("setCronExpression");
		beforeCreate("checkApproval");
		validate("requiresEndCondition");
		validate("requiresRepeatStart");
		property(name="duration", sql="TIMESTAMPDIFF(MINUTE,events.startsat,events.endsat)");
	}

	/*
	 * @hint Sets a default status - if approval is on, set to pending, otherwise autoapprove
	*/
	public void function checkApproval() {
		if(application.rbs.setting.approveBooking){
			this.status="pending";
		} else {
			this.status="approved";
		}
	}

	/*
	 * @hint If there's no end date, add a default end date 1hour into future
	*/
	public void function checkDates() {
		//this.start = LSParseDateTime(this.start);
		//this.end   = LSParseDateTime(this.end);
		// Convert locale specific format to 2015-07-08 10:30:41

			//this.start=LSParseDateTime(LSDateFormat(this.start));
			//this.end=LSParseDateTime(LSDateFormat(this.end));



		// Have a double check for a start date
		//if(!LSisDate(this.start)){
		//	this.start=now();
		//}
    	//if(!LSisDate(this.end)){
    	//	// Bookings are for 1 hour by default, so increment if not passed in
    	//	this.end=dateAdd("h", 1, this.start);
    	//}
    	// Don't allow end date to be before start date
    	// We check for -1 to allow for end dates on the same day
    	//if((LSDateCompare("#this.end#", "#this.start#")) EQ -1 ){
		//	 addError(property="end", message="End Date can not be before Start Date.");
		//}
	}

	/*
	 * @hint Formats Date for DateTime Picker
	*/
	public void function formatDates() {
		//if(structKeyExists(this, "start")){
		//	this.start=LSdateFormat(this.start, "YYYY-MM-DD") & ' ' & LStimeFormat(this.start, "HH:MM");
		//}
		//if(structKeyExists(this, "end")){
		//	this.end=LSdateFormat(this.end, "YYYY-MM-DD") & ' ' & LStimeFormat(this.end, "HH:MM");
		//}
	}

	/*
	 * @hint Save the provided repeat rule arguments as a cron expression
	*/
	public void function setCronExpression() {
		if(structKeyExists(this, "type") && len(this.type)){
			this.cronexpression=generateCronExpression(
				date=this.startsat,
				type=this.type,
				every=this.repeatevery,
				dow=this.repeaton
			);
		} else {
			this.cronexpression="";
		}
	}

	/*
	 * @hint
	*/
	public void function requiresRepeatStart() {
		if(!structKeyExists(this, "repeatstartsat") OR !isDate(this.repeatstartsat)){
			this.repeatstartsat=this.startsat;
		}
		if(!structKeyExists(this, "repeatevery")){
			this.repeatevery=1;
		}
	}
	/*
	 * @hint Repeat rule requires at least one ending condition
	*/
	public void function requiresEndCondition() {
		if(!structkeyexists(this, "isNever") && structKeyExists(this, "repeatendsAfter") && !len(this.repeatendsAfter) && !len(this.repeatendsOn)){
			// Set a default of 10 repeats
			this.repeatendsAfter = 10;
		}
	}

	/*
	 * @hint NB, these can be localised, as the output has the l() wrapper
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
				name: "startsat",
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
				name: "endsat",
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
