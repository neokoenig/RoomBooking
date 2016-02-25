<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Custom field Form --->
<cfoutput>
	<div class="row">
		<div class="col-sm-4">
			#textField(objectname="customfield", property="name", label=l("Field Name"))#
			<p class="help-block">#l("Main Name, used in label outputs")#</p>
		</div>
		<div class="col-sm-4">
			#select(objectname="customfield", property="type", label=l("Type"), options="textfield,select,textarea,radio,checkbox")#
			<p class="help-block">#l("Custom Field Type")#</p>
		</div>
		<div class="col-sm-4">
			#select(objectname="customfield", property="parentmodel", label=l("Model"), options=application.rbs.modeltypes)#
			<p class="help-block">#l("Model to attach this field to")#</p>
		</div>
	</div>

	#textField(objectname="customfield", property="description", label=l("Description"))#
	<p class="help-block">#l("Appears below the form helper for this custom field")#</p>


	#hiddenField(objectname="customfield", property="options")#
	<label>#l("Options")#</label>
	<div id="editor">
		<cfif params.action NEQ "add">
			#customfield.options#
		</cfif></div>
		<p class="help-block">#l("If Select, array of key value pairs")#: i.e</p>
<div class="row">
	<div class="col-sm-4">
<p>#l("If Radio, array of key value pairs")#: i.e</p>
<pre>
[
	{"key1": "value1"},
	{"key2": "value2"},
	{"key3": "value3"}
]
</pre>
	</div>
	<div class="col-sm-4">
<p>#l("If Select, can include a blank")#:</p>
<pre>
[
	{"": "..Please Select..."},
	{"key1": "value1"},
	{"key2": "value2"},
	{"key3": "value3"}
]
</pre>
	</div>
	<div class="col-sm-4">
<p>#l("If Checkbox, single array of key value pairs")#: i.e</p>
<pre>
[
	{"MyValue": "My Thing"}
]
</pre>
	</div>
</div>


		<div class="row">
			<div class="col-sm-4">
				#textField(objectname="customfield", property="class", label=l("Additional Class"))#
				<p class="help-block">#l("Additional Optional Wrapper CSS Class")#</p>
			</div>
			<div class="col-sm-2">
				#textField(objectname="customfield", property="sortorder", label=l("Sortorder"))#
				<p class="help-block">#l("Optional Numeric Sortorder for default listings")#</p>

			</div>
			<div class="col-sm-4">
				#checkbox(objectname="customfield", property="required", label=l("Required") & "?")#
				<p class="help-block">#l("Required Field")#</p>
			</div>
		</div>
		<cfsavecontent variable="request.js.ace">
			#javascriptIncludeTag("https://cdnjs.cloudflare.com/ajax/libs/ace/1.1.3/ace.js")#
			<script>
			var editor = ace.edit("editor");
				editor.setTheme("ace/theme/chrome");
				editor.getSession().setMode("ace/mode/json"); 
			</script>
		</cfsavecontent>

	</cfoutput>