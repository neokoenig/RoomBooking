<cfoutput>
	<div class="tab-pane" id="Editor">
		<div class="pad">
			<ul class="list-custom">
				<li>The editor let you enter text with their translation.</li>
				<li>The text is saved to your database and/or localization files.</li>
				<li>You can add, edit or delete text entries. This will update your database and your localization files.</li>
				<li>You can add dynamic content in your text by adding "{variable}" as a placeholder.
					<dl class="well">
						<dt>In your database or localization files, this text entry:</dt>
						<dd>Hi {variable}!</dd>
						<dt style="margin-top:10px;">Once used with the plugin function:</dt>
						<dd>##localizeme("Hi {##user.firstname##}!")##</dd>
						<dt style="margin-top:10px;">Will result in this:</dt>
						<dd>Hi Bob!</dd>
					</dl>
				</li>
			</ul>
			<ul class="list-custom">
				<li>Add/delete language to your database table and locales folder simply by using the form below. This will add the proper column to your database table and create the proper localization file filled with the repository file text.</li>
				<li style="list-style:none;"><strong>OR</strong></li>
				<li>To use the editor with a database:
					<ul>
						<li>Configure your localization table with at least these columns:
							<ul>
								<li><em>id</em> (int Primary Key).</li>
								<li><em>text</em> (VarChar(MAX)).</li>
								<li>Your default language <em>en_US</em>, <em>en_CA</em> (VarChar(MAX)) or other Locale ID.</li>
							</ul>
						</li>
						<li>To add form fields for other languages, simply add new columns, named with the Locale ID, <em>en_US</em>, <em>en_CA</em>, <em>fr_CA</em> (VarChar(MAX)) or other Locale ID, to your localization table.</li>
					</ul>
				</li>
				<li>To use the editor with localizations files:
				<ul>
					<li>Create "blank" .cfm pages named with the Locale ID (<em>en_US</em>.cfm, <em>en_CA</em>.cfm, <em>fr_CA</em>.cfm) in the locales folder. <br />--> /plugins/localizator/locales/</li>
					<li>To add form fields for other languages, create other "blank" .cfm pages  named with the Locale ID (<em>en_US</em>.cfm, <em>en_CA</em>.cfm, <em>fr_CA</em>.cfm) in the locales folder. <br />--> /plugins/localizator/locales/</li>
				</ul>
			</ul>
		</div>
	</div>
</cfoutput>