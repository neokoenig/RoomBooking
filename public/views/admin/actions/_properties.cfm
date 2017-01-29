<cfscript>
	// Get Form Fields from the model specified in theaction
	formvalues={};
	formfields=model('Actions.' & params.componentcfc).describe();

	// Have we got any JSON set already?
	if(structKeyExists(theaction, "propertiesjson") && !structIsEmpty(theaction.propertiesjson)){
		formvalues=theaction.propertiesjson;
	} else {
	// Else set defaults
		temp=model('Actions.' & params.componentcfc).new()
		formvalues=temp.properties();
	}
 </cfscript>

<cfoutput>

	<cfif arraylen(formfields)>
		<cfloop array="#formfields#" index="field">
			<cfswitch expression="#field.type#">
				<cfcase value="textarea">
					#textAreaTag(name="actionproperties[" & field.name & "]", label=titleize(field.name), required=field.required, content=formvalues[field.name])#
				</cfcase>
				<cfcase value="checkbox">
					#checkboxTag(name="actionproperties[" & field.name & "]", label=titleize(field.name),  required=field.required, value=formvalues[field.name])#
				</cfcase>
				<cfcase value="select">
					#selectTag(name="actionproperties[" & field.name & "]", label=titleize(field.name), options=field.options, required=field.required, value=formvalues[field.name])#
				</cfcase>
				<cfdefaultcase>
					#textFieldTag(name="actionproperties[" & field.name & "]", label=titleize(field.name), required=field.required, value=formvalues[field.name])#
				</cfdefaultcase>
			</cfswitch>
			<cfif structKeyExists(field, "description") && len(field.description)>
				<p class="help-block">#field.description#</p>
			</cfif>
		</cfloop>
	<cfelse>
		#l("No Properties can be set on this action")#
	</cfif>
</cfoutput>
