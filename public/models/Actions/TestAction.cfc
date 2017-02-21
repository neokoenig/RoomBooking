component extends="app.models.Model"
{
	// Tableless model as template for an action
	// All ACTIONS must have init() to declare their properties (if any)
	// The save() command is then the "doing" action called

	// This is a test action. It doesnt' actually do anything of note.
	function init() {

		// All Actions must be tableless
		table(false);

		// Set default properties
		property(name="name", defaultValue="");
		property(name="email", defaultValue="");

		// Set any required validation
		validatesFormatOf(property="email", format="email");
		validatesPresenceOf("name");
	}

	// Describe is used to return the data needed for dynamic form fields
	function describe(){
		return [
			{
				"name": "name",
				"type": "text",
				"required": false
			},
			{
				"name": "email",
				"type": "text",
				"validate": "email",
				"required": false
			}
		];
	}

	// The main executed function
	function save(){
		// I don't actually do anything as I'm a test action
		return true;
	}
}
