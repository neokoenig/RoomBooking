component extends="models.Model"
{
	function init() {
		table(false);
		property(name="type", defaultValue="info");
		property(name="message", defaultValue="");

		validatesPresenceOf(properties="type,message");
	}
	function describe(){
		return [
			{
				"name": "type",
				"type": "select",
				"options": "information,warning,error,success",
				"required": true
			},
			{
				"name": "message",
				"type": "textarea",
				"required": true
			}
		];
	}
	function save(){
		session.flash[this.type]=this.message;
		return true;
	}
}
