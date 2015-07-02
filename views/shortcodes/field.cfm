<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!---

=================
[field] shortcode
=================

Usage: [field id=1 ] or [field id="name"]

--->
<cfscript>
	// Switches
	param name="attr.field"			default="system";
	param name="attr.fieldtype"		default="";
	param name="attr.modeltype"		default="#request.modeltype#";

	param name="attr.class"			default="";
	param name="attr.type"			default="";
	param name="attr.description"	default="";

	// Placeholders
	param name="attr.temp"			default="";

	// Is it a Custom or a system field?
	if(isnumeric(attr.id)){
		attr.field="custom";
	}

	if(attr.field EQ "custom"){
		cfQ = new Query();
		cfQ.setDBType('query');
		cfQ.setAttributes(rs=customfields); // needed for QoQ
		cfQ.addParam(name='id', value=attr.id, cfsqltype='cf_sql_numeric');
		cfQ.setSQL('SELECT * FROM rs where id = :id');
		cfQ.setMaxRows(1); // limit max rows, if desired
		customfield = cfQ.execute().getResult();
 		attr={
			id=customfield.id,
    		class=customfield.class,
        	fieldtype="custom",
        	modeltype=attr.modeltype,
        	//add to cf definiton
        	required=customfield.required,
        	type=customfield.type,
    		description=customfield.description,
			fieldValues={
				name="customfields[#customfield.id#]",
	        	//options=deserializeJSON(customfield.options),
	        	//add to cf definiton
	        	placeholder="",
	        	label=customfield.name,
	        	//type=customfield.type,
	        	//selected=customfield.value,
	        	//content=customfield.value
	        	value=customfield.value
			}
    	};
    	//if(isJson(customfield.options)){
    	//	fieldValues.options=deserializeJSON(customfield.options);
    	//}
	} else {
		// Merge system field data from model
		if(structKeyExists(variables["#attr.modeltype#"], "systemfields")){
			t=arrayFind(variables["#attr.modeltype#"]["systemfields"], attr.id);
			for(f in variables["#attr.modeltype#"]["systemfields"]){
			        attr.temp=StructFindValue(f, attr.id);
			        if(arrayLen(attr.temp) EQ 1){
						attr={
							id=attr.id,
			        		class=f.class,
				        	fieldtype=attr.fieldtype,
				        	modeltype=attr.modeltype,
				        	required=f.required,
				        	type=f.type,
			        		description=f.description,
							fieldValues={
								objectname=attr.modeltype,
				        		property=f.name,
					        	options=f.options,
					        	placeholder=f.placeholder,
					        	label=f.label
							}
			        	};
						/*if(isJson(f.options)){
							fieldValues.options=deserializeJSON(f.options);
						} else {
							fieldValues.options=evaluate(f.options);
						}*/
		        	}
		        structDelete(attr, "temp");
		     }

		} else {
			attr.msg="No System Fields have been defined on this model";
		}
	}

	if(attr.required){
		attr.fieldValues.label=attr.fieldValues.label & " *";
		attr.fieldValues.required=true;
	} else {
		// Gotta delete this, otherwise the validation kicks in
		structDelete(attr.fieldValues, "required");
	}
</cfscript>
<cfoutput>
<div class="#attr.class# append">
	<cfif attr.fieldtype EQ "custom">
		<cfswitch expression="#attr.type#">
			<cfcase value="textfield">
				#textFieldTag(argumentCollection=attr.fieldValues)#
			</cfcase>
			<cfcase value="select">
				<cfset attr.fieldValues.selected=attr.fieldValues.value>
				#selectTag(argumentCollection=attr.fieldValues)#
			</cfcase>
			<cfcase value="textarea">
				<cfset attr.fieldValues.content=attr.fieldValues.value>
				#textareaTag(argumentCollection=attr.fieldValues)#
			</cfcase>
			<cfcase value="radio">
				<!--- There's probably a better/easier way to do this...--->
				<cfset tempArray=attr.fieldValues.options>
				<label>#attr.fieldValues.label#</label>
				<cfloop from="1" to="#arraylen(tempArray)#" index="i">
					#radioButtonTag(name=attr.fieldValues.name, value=structkeylist(tempArray[i]), label=tempArray[i][structkeylist(tempArray[i])], checked=iif(structkeylist(tempArray[i]) EQ attr.fieldValues.value, "true", "false"))#
				</cfloop>
				<cfset tempArray="">
			</cfcase>
			<cfcase value="checkbox">
				<label>#attr.fieldValues.label#</label>
				<cfset attr.fieldValues.label=attr.fieldValues.options[1][structkeylist(attr.fieldValues.options[1])]>
				<cfset attr.fieldValues.checked=iif(structkeylist(attr.fieldValues.options[1]) EQ attr.fieldValues.value, "true", "false")>
				<cfset attr.fieldValues.uncheckedValue=0>
				<cfset attr.fieldValues.value=structkeylist(attr.fieldValues.options[1])>
				<cfset structDelete(attr.fieldValues, "options")>
				#checkBoxTag(argumentCollection=attr.fieldValues)#
			</cfcase>
			<cfdefaultcase><p>Incorrect Field Type Specified</p></cfdefaultcase>
		</cfswitch>
	<cfelse>
		<cfswitch expression="#attr.type#">
			<cfcase value="textfield">
				#textField(argumentCollection=attr.fieldValues)#
			</cfcase>
			<cfcase value="select">
				<!--- Stupid CF10
				#select(argumentCollection=attr.fieldValues)#--->
				 #select(objectName=attr.fieldValues.objectname, options=evaluate(attr.fieldValues.options), property=attr.fieldvalues.property, label=attr.fieldValues.label)#
			</cfcase>
			<cfcase value="textarea">
				#textArea(argumentCollection=attr.fieldValues)#
			</cfcase>
			<cfcase value="datepicker">
				<cfset attr.fieldValues["data-date-format"]="DD MMM YYYY HH:mm">
				#textfield(argumentCollection=attr.fieldValues)#
			</cfcase>
			<cfcase value="colourpicker">
				<cfset attr.fieldValues["data_bv_hexcolor_message"]="The color code is not valid">
				<cfset attr.fieldValues["class"]="form-control bscp">
				#textField(argumentCollection=attr.fieldValues)#
			</cfcase>
			<cfcase value="checkbox">
				<label></label>
				<cfset attr.fieldValues.options=deserializeJSON(attr.fieldValues.options)>
				<cfset attr.fieldValues.label=attr.fieldValues.options[1][structkeylist(attr.fieldValues.options[1])]>
				<cfset structDelete(attr.fieldValues, "options")>

				#checkBox(objectName=attr.fieldValues.objectname, property=attr.fieldvalues.property, label=attr.fieldValues.label)#
			</cfcase>
			<cfcase value="radio">
				<!--- Need to test this one--->
				<cfloop from="1" to="#arraylen(attr.fieldValues.options)#" index="i">
			  	#radioButton(argumentCollection=attr.fieldValues)#
				</cfloop>
			</cfcase>
			<cfdefaultcase><p>Incorrect Field Type Specified</p></cfdefaultcase>
		</cfswitch>
	</cfif>
	<cfif len(attr.description)>
		<p class="help-block">#h(attr.description)#</p>
	</cfif>
</div>
</cfoutput>
<cfset structDelete(variables, "attr")>