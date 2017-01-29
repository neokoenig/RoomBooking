component extends="tests.Test" {

	function setup() {

	  // create an instance of our model
	  workflow = model("workflow").new();
	  properties = {
	      title="Test workflow"
	  };
	}
	function teardown() {}

	function Test_workflow_passes_validation(){
		workflow.setProperties(properties);
		workflow.valid();
	    actual = workflow.allErrors();
	    assert("!arraylen(actual)");
	}
	function Test_workflow_fails_validation(){
		workflow.setProperties({});
		workflow.valid();
	    actual = workflow.allErrors();
	    assert("arraylen(actual)");
	}


}
