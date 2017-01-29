component extends="Model"
{
	function init() {
		// Inherit Triggers
		super.init();
		property(name="componentcfc", defaultValue="Abort");
		// Associations
		hasMany(name="triggeractions", jointype="left");
		beforeValidation(methods="serializeAdditionalProperties");
		afterInitialization(methods="deserializeAdditionalProperties");
	}

	function serializeAdditionalProperties() {
		if(structKeyExists(this, "propertiesjson")){
			this.propertiesjson=serializeJSON(this.propertiesjson);
		}
	}

	function deserializeAdditionalProperties() {
		if(structKeyExists(this, "propertiesjson") && !isStruct(this.propertiesjson)){
			this.propertiesjson=deserializeJSON(this.propertiesjson);
		}
	}
}
