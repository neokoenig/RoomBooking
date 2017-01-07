component extends="Model"
{
	function init() {
		validatesUniquenessOf("name");
	}
}
