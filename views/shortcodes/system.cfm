<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- System field Shortcode --->
<cfscript>
	param name="class"		default="";
	param name="description"	default="";
	param name="name"		default=attr.id;
	param name="options" 	default="";
	param name="type"		default="";
	param name="required"   default=0;
	param name="label"   	default="";
	param name="placeholder" default="";

	for(f in variables["#request.modeltype#"]["systemfields"]){
        temp=StructFindValue(f, attr.id);
        if(arrayLen(temp) EQ 1){
        	class=f.class;
        	description=f.description;
        	name=f.name;
        	options=f.options;
        	type=f.type;
        	required=f.required;
        	placeholder=f.placeholder;
        	if(!structKeyExists(attr, "label")){
        		label=Titleize(f.name);
        	}
        	if(required){
        		label=label & " *";
        	}
        }
     }
</cfscript>

	<!--- System Field Outputs--->
	<cfoutput>
	<!-- System field #attr.id# -->
	<div class="#class# append">
		<cfswitch expression="#type#">
			<cfdefaultcase>
				<p>Incorrect Field Type Specified</p>
			</cfdefaultcase>
			<cfcase value="datepicker">
				#textField(objectname=request.modeltype, required=required, property=name, data_date_format="DD MMM YYYY HH:mm", label=label)#
			</cfcase>
			<cfcase value="colourpicker">
			#textField(objectname=request.modeltype, required=required, property=name,    data_bv_hexcolor_message="The color code is not valid",  class="form-control bscp", label=label, placeholder="e.g ##FF6600")#
			</cfcase>
			<cfcase value="textfield">
				#textField(objectname=request.modeltype, required=required, property=name, placeholder=placeholder, label=label)#
			</cfcase>
			<cfcase value="select">
				#select(objectname=request.modeltype, required=required, property=name, label=label, options=deserializeJSON(options))#
			</cfcase>
			<cfcase value="textarea">
				#textArea(objectname=request.modeltype, required=required, property=name, placeholder=placeholder,label=label)#
			</cfcase>
			<cfcase value="radio">
				<cfset tempArray=deserializeJSON(options)>
				<label>#label#</label>
				<cfloop from="1" to="#arraylen(tempArray)#" index="i">
			  	#radioButton(objectname=request.modeltype, name=name, value=structkeylist(tempArray[i]), label=tempArray[i][structkeylist(tempArray[i])], checked=iif(structkeylist(tempArray[i]) EQ value, "true", "false"))#
				</cfloop>
				<cfset tempArray="">
			</cfcase>
			<cfcase value="checkbox">
				<cfset tempArray=deserializeJSON(options)>
				<label>#label#</label>
				#checkBoxTag(objectname=request.modeltype, name=name, value=structkeylist(tempArray[1]), label=tempArray[1][structkeylist(tempArray[1])])#
			</cfcase>
		</cfswitch>
		<cfif len(description)>
			<p class="help-block">#h(description)#</p>
		</cfif>
	</div>
	<!-- /System field #attr.id# -->
</cfoutput>