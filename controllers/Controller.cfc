//================= Room Booking System / https://github.com/neokoenig =======================--->
component extends="Wheels" hint="Global Controller"
{
	/**
	 * @hint Constructor.
	 */
	public void function init() {
		// Deny everything by default
		filters(through="checkPermissionAndRedirect", permission="accessapplication");
		// Log everything by default
		filters(through="logFlash", type="after");
	}

/******************** Custom Fields***********************/
	/**
	*  @hint Get Custom fields for any model
	*/
	public query function getCustomFields(required string objectname, required string key) {
		var result="";
		// This is a silly query which I would have never have worked out unless Stackoverflow existed.
		// Makes you realise how lazy ORM makes you sometimes.
		// The reason this is breaking out of wheels CRM is that we need to get the custom field definitions,
		// but still give null values if the fields on the 'right side' don't exist.
		result = queryExecute("
		SELECT
		    customfields.id,
		    customfields.`name`,
		    customfields.parentmodel,
		    customfields.type,
		    customfields.`options`,
		    customfields.class,
		    customfields.description,
		    customfields.required,
		    customfieldjoins.customfieldsid,
		    customfieldjoins.customfieldchildid,
		    customfieldjoins.customfieldvalueid,
		    customfieldvalues.id,
		    customfieldvalues.`value`
		FROM
		    customfields
		LEFT JOIN customfieldjoins ON customfieldjoins.customfieldsid = customfields.id AND customfieldjoins.customfieldchildid = ?
		LEFT JOIN customfieldvalues ON customfieldjoins.customfieldvalueid = customfieldvalues.id
		WHERE
		    customfields.parentmodel = ?
		",
		[arguments.key,
		 arguments.objectname],
		{
			datasource    =application.wheels.datasourcename
		});
		return result;
	}

	/**
	*  @hint Get Custom fields for any model
	*/
	public query function getBlankCustomFields(required string objectname) {
		var result="";
		result = queryExecute("
		SELECT
		    customfields.id,
		    customfields.`name`,
		    customfields.parentmodel,
		    customfields.type,
		    customfields.`options`,
		    customfields.class,
		    customfields.description
		FROM
		    customfields
		WHERE
		    customfields.parentmodel = ?
		",
		[arguments.objectname],
		{
			datasource    =application.wheels.datasourcename
		});
		return result;
	}

	/**
	*  @hint Update Custom Fields for any model
	*/
	public void function updateCustomFields(required string objectname, required numeric key, required struct customfields) {

	 	for(field in arguments.customfields){
	 		checkValue=model("customfieldjoin").findOne(where="customfieldsid=#field# AND customfieldchildid = #arguments.key#");
	 		if(isObject(checkValue)){
	 			updateValue=model("customfieldvalue").findOne(where="id = #checkValue.customfieldvalueid#");
	 			updateValue.update(value=arguments.customfields[field]);
	 		} else {
	 			newValue=model("customfieldvalues").create(value=arguments.customfields[field]);
	 			newJoin=model("customfieldjoin").create(
	 				customfieldsid=field,
	 				customfieldchildid=arguments.key,
	 				customfieldvalueid=newValue.key());
	 		}
	 	}
	}



/******************** Global Filters***********************/
 	/**
 	*  @hint Return all room locations
 	*/
 	public void function _getLocations() {
 		locations=model("location").findAll(order="building,name");
 	}

 	/**
 	*  @hint Return all settings
 	*/
 	public void function _getSettings() {
 		settings=model("setting").findAll(order="category,id");
 	}

 	/**
 	*  @hint Return All Resources
 	*/
 	public void function _getResources() {
 		resources=model("resource").findAll(order="type,name");
 	}

 	/**
 	*  @hint Check is valid ajax request in filter
 	*/
 	public void function _isValidAjax() {
 		if(!isAjax()){
 			abort;
 		}
 	}
}