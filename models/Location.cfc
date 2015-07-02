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
				label: "Name",
				type: "textfield",
				options: "",
				class: "",
				description: "The Main room name, i.e Seminar Room 1",
				placeholder: "",
				required: 1
			},
			{
				name: "class",
				label: "CSS Class",
				type: "textfield",
				options: "",
				class: "",
				description: "Classname used to assign a colour, should be unique to this location",
				placeholder: "",
				required: 1
			},
			{
				name: "colour",
				label: "HEX Colour",
				type: "colourpicker",
				options: "",
				class: "",
				description: "The colour assigned to this location",
				placeholder: "",
				required: 1
			},
			{
				name: "description",
				label: "Description",
				type: "textfield",
				options: "",
				class: "",
				description: "Might be a floor or other description",
				placeholder: "",
				required: 0
			},
			{
				name: "building",
				label: "Building",
				type: "textfield",
				options: "",
				class: "",
				description: "Parent Building (optional)",
				placeholder: "",
				required: 0
			},

			{
				name: "layouts",
				label: "Layouts",
				type: "textfield",
				options: "",
				class: "",
				description: "List of possible layouts (optional)",
				placeholder: "i.e boardroom,lecture",
				required: 0
			}
		];
	}

}