component extends="models.Model"
{
	function init() {
		table(false);
		property(name="name", defaultValue="testvar");
		property(name="to", defaultValue="Foo");
		validatesPresenceOf(properties="name,to");
	}
	function describe(){
		return [
			{
				"name": "name",
				"type": "text",
				"required": true
			},
			{
				"name": "to",
				"type": "text",
				"required": true
			}
		];
	}
	function save(){
		var root="request.wheels.params"
		var str= '#root#.#this.name#';
			'#str#' = this.to;
		return true;
	}
}
