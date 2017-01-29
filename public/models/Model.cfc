component extends="Wheels"
{
	function init() {
		afterCreate("modelTriggerAfterCreate");
		afterDelete("modelTriggerAfterDelete");
		afterInitialization("modelTriggerAfterInitialization");
		afterNew("modelTriggerAfterNew");
		afterSave("modelTriggerAfterSave");
		afterUpdate("modelTriggerAfterUpdate");
		afterValidation("modelTriggerAfterValidation");
		afterValidationOnCreate("modelTriggerAfterValidationOnCreate");
		afterValidationOnUpdate("modelTriggerAfterValidationOnUpdate");
		beforeCreate("modelTriggerBeforeCreate");
		beforeDelete("modelTriggerBeforeDelete");
		beforeSave("modelTriggerBeforeSave");
		beforeUpdate("modelTriggerBeforeUpdate");
		beforeValidation("modelTriggerBeforeValidation");
		beforeValidationOnCreate("modelTriggerBeforeValidationOnCreate");
		beforeValidationOnUpdate("modelTriggerBeforeValidationOnUpdate");
	}

	function getDefaultModelName(){
		return replace(getMetaData(this)['fullname'], "wheelsMapping....", "", "all");
	}
	function modelTriggerAfterCreate(){
		fireTrigger(name=getDefaultModelName(), when="AfterCreate");
	}
	function modelTriggerAfterDelete(){
		fireTrigger(name=getDefaultModelName(), when="AfterDelete");
	}
	function modelTriggerAfterInitialization(){
		fireTrigger(name=getDefaultModelName(), when="AfterInitialization");
	}
	function modelTriggerAfterNew(){
		fireTrigger(name=getDefaultModelName(), when="AfterNew");
	}
	function modelTriggerAfterSave(){
		fireTrigger(name=getDefaultModelName(), when="AfterSave");
	}
	function modelTriggerAfterUpdate(){
		fireTrigger(name=getDefaultModelName(), when="AfterUpdate");
	}
	function modelTriggerAfterValidation(){
		fireTrigger(name=getDefaultModelName(), when="AfterValidation");
	}
	function modelTriggerAfterValidationOnCreate(){
		fireTrigger(name=getDefaultModelName(), when="AfterValidationOnCreate");
	}
	function modelTriggerAfterValidationOnUpdate(){
		fireTrigger(name=getDefaultModelName(), when="AfterValidationOnUpdate");
	}
	function modelTriggerBeforeCreate(){
		fireTrigger(name=getDefaultModelName(), when="BeforeCreate");
	}
	function modelTriggerBeforeDelete(){
		fireTrigger(name=getDefaultModelName(), when="BeforeDelete");
	}
	function modelTriggerBeforeSave(){
		fireTrigger(name=getDefaultModelName(), when="BeforeSave");
	}
	function modelTriggerBeforeUpdate(){
		fireTrigger(name=getDefaultModelName(), when="BeforeUpdate");
	}
	function modelTriggerBeforeValidation(){
		fireTrigger(name=getDefaultModelName(), when="BeforeValidation");
	}
	function modelTriggerBeforeValidationOnCreate(){
		fireTrigger(name=getDefaultModelName(), when="BeforeValidationOnCreate");
	}
	function modelTriggerBeforeValidationOnUpdate(){
		fireTrigger(name=getDefaultModelName(), when="BeforeValidationOnUpdate");
	}
}


