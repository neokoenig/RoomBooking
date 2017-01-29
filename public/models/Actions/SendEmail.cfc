component extends="models.Model"
{
	function init() {
		table(false);
		property(name="email", defaultValue="");
		property(name="subject", defaultValue="");
		property(name="template", defaultValue="");
		property(name="message", defaultValue="");

		validatesFormatOf(property="email", format="email");
		validatesPresenceOf("subject,template,message");
	}
	function describe(){
		return [
			{
				"name": "email",
				"type": "text",
				"validate": "email",
				"description": "Email Address to Send To",
				"required": true
			},
			{
				"name": "subject",
				"type": "text",
				"description": "Subject Line",
				"required": true
			},
			{
				"name": "template",
				"type": "select",
				"options": ["one","two","three"],
				"description": "Email Template to Use",
				"required": true
			},
			{
				"name": "message",
				"type": "textarea",
				"description": "The Main Message",
				"required": true
			}
		];
	}
	function save(){

	}
}
