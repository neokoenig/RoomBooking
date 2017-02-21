component extends="app.models.Model"
{
	function init() {
		table(false);
		property(name="modelname", defaultValue="");
		validatesPresenceOf(properties="modelname");
	}
	function describe(){
		return [
			{
				"name": "modelname",
				"type": "text",
				"required": true
			}
		];
	}
	function save(){
		writeDump(request);
		//writeDump(evaluate(this.modelname));
		//writeDump(this.modelname);
		abort;
	}
}
