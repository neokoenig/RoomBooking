<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Custom Field Outputs--->
<cfoutput>
<div class="#class# append">
	<cfswitch expression="#type#">
		<cfdefaultcase>
			<p>Incorrect Field Type Specified</p>
		</cfdefaultcase>
		<cfcase value="textfield">
			#textFieldTag(name="customfields[#id#]", label=name, value=value)#
		</cfcase>
		<cfcase value="select">
			#selectTag(name="customfields[#id#]", label=name, options=deserializeJSON(options), selected=value)#
		</cfcase>
		<cfcase value="textarea">
			#textareaTag(name="customfields[#id#]", label=name, content=value)#
		</cfcase>
		<cfcase value="radio">
			<cfset tempArray=deserializeJSON(options)>
			<label>#name#</label>
			<cfloop from="1" to="#arraylen(tempArray)#" index="i">
		  	#radioButtonTag(name="customfields[#id#]", value=structkeylist(tempArray[i]), label=tempArray[i][structkeylist(tempArray[i])], checked=iif(structkeylist(tempArray[i]) EQ value, "true", "false"))#
			</cfloop>
			<cfset tempArray="">
		</cfcase>
		<cfcase value="checkbox">
			<cfset tempArray=deserializeJSON(options)>
			<label>#name#</label>
			#checkBoxTag(name="customfields[#id#]", value=structkeylist(tempArray[1]), label=tempArray[1][structkeylist(tempArray[1])])#
		</cfcase>
	</cfswitch>
	<cfif len(description)>
		<p class="help-block">#h(description)#</p>
	</cfif>
</div>
</cfoutput>
