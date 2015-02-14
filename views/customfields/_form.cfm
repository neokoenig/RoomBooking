<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Custom field Form --->
<cfoutput>
	<div class="row">
		<div class="col-sm-4">
			#textField(objectname="customfield", property="name", label="Field Name")#
			<p class="help-block">Main Name, used in label outputs etc</p>
		</div>
		<div class="col-sm-4">
			#select(objectname="customfield", property="type", label="Type", options="textfield,select,textarea,radio,checkbox")#
			<p class="help-block">Custom Field Type</p>
		</div>
		<div class="col-sm-4">
			#select(objectname="customfield", property="parentmodel", label="Model", options=application.rbs.modeltypes)#
			<p class="help-block">Model to attach this field toc</p>
		</div>
	</div>

	#textField(objectname="customfield", property="description", label="Description")#
	<p class="help-block">Appears below the form helper for this custom field. Indeed, like this text.</p>


	#hiddenField(objectname="customfield", property="options")#
	<label>Options</label>
	<div id="editor">
		<cfif params.action NEQ "add">
			#customfield.options#
		</cfif></div>
		<p class="help-block">If Select, array of key value pairs: i.e</p>
<div class="row">
	<div class="col-sm-4">
<p>If Radio, array of key value pairs: i.e</p>
<pre>
[
	{"key1": "value1"},
	{"key2": "value2"},
	{"key3": "value3"}
]
</pre>
	</div>
	<div class="col-sm-4">
<p>If Select, can include a blank:</p>
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
<p>If Checkbox, single array of key value pairs: i.e</p>
<pre>
[
	{"MyValue": "My Thing"}
]
</pre>
	</div>
</div>


		<div class="row">
			<div class="col-sm-4">
				#textField(objectname="customfield", property="class", label="Additional Class")#
				<p class="help-block">Additional Optional Wrapper CSS Class</p>
			</div>
			<div class="col-sm-2">
				#textField(objectname="customfield", property="sortorder", label="Sortorder")#
				<p class="help-block">Optional Numeric Sortorder for default listings</p>

			</div>
			<div class="col-sm-4">
				#checkbox(objectname="customfield", property="required", label="Required?")#
				<p class="help-block">Required Field</p>
			</div>
		</div>
		<cfsavecontent variable="request.js.ace">
			#javascriptIncludeTag("https://cdnjs.cloudflare.com/ajax/libs/ace/1.1.3/ace.js")#
			<script>
			var editor = ace.edit("editor");
			editor.setTheme("ace/theme/chrome");
			editor.getSession().setMode("ace/mode/json");

			$("##customfieldSubmit").on("click", function(e){
				e.preventDefault();
				var code = editor.getSession().getValue();
				$("##customfield-options").val(code);
				$(this).parent().submit();
			});
			</script>
		</cfsavecontent>

	</cfoutput>