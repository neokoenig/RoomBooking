//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Model" hint="Locations Model"
{
	/**
	 * @hint Constructor
	 */
	public void function init() {
		// Associations
		hasMany("events");
		afterInitialization("registerSystemFields");
	}

	/**
	*  @hint
	*/
	public void function registerSystemFields() {
		this.systemfields=[
			{
				name: "name",
				type: "textfield",
				options: "",
				class: "",
				description: "The Main room name, i.e Seminar Room 1",
				placeholder: "",
				required: 1
			},
			{
				name: "class",
				type: "textfield",
				options: "",
				class: "",
				description: "Classname used to assign a colour, should be unique to this location",
				placeholder: "",
				required: 1
			},
			{
				name: "colour",
				type: "colourpicker",
				options: "",
				class: "",
				description: "The colour assigned to this location",
				placeholder: "",
				required: 1
			},
			{
				name: "description",
				type: "textfield",
				options: "",
				class: "",
				description: "Might be a building location or floor",
				placeholder: "",
				required: 0
			}
		]
	}

}