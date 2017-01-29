component extends="models.Model"
{
	function init() {
		table(false);
	}
	function describe(){
		return [];
	}
	function save(){
		writeOutput("Request Aborted by Application");
		abort;
	}
}
