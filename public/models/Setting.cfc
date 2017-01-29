component extends="Model"
{
	function init() {
		// Inherit Triggers
		super.init();
		validatesUniquenessOf("name");
	}
}
