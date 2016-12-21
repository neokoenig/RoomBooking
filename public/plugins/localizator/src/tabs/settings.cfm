<cfoutput>
	<div class="tab-pane active" id="Settings">
		<div class="pad">
			<div class="alert alert-danger">
				<span class="label label-danger">Important</span> &nbsp;&nbsp;All the plugin settings should be place in your config/settings.cfm files.
			</div>

			<dl>
				<dt>Default language</dt>
				<dd>The plugin use the default server Locale ID as the default language. You can use a different Locale ID by using this setting.
					<ul>
						<li><u>set(localizatorLanguageDefault="Locale ID")</u></li>
					</ul>
				</dd>

				<dt>Session variable</dt>
				<dd>The plugin can retrieve the language (Locale ID) from the session scope (e.g. from a user session). Just set the structure/key where the plugin should go check for the Locale ID.
					<ul>
						<li><u>set(localizatorLanguageSession="currentuser.language")</u></li>
					</ul>
				</dd>

				<dt>Localization table</dt>
				<dd>The default name of the localization table is... drum roll... "localizations". To use a different table name, just set it like this:
					<ul>
						<li><u>set(localizatorLanguageTable="MyTableName")</u></li>
					</ul>
				</dd>

				<dt>Localization file(s)</dt>
				<dd>You can force the plugin to get translation from localization files instead of the database.
					<ul>
						<li><u>set(localizatorGetLocalizationFromFile=true)</u></li>
					</ul>
				</dd>

				<dt>Harvester</dt>
				<dd>To activate the "Harvester" during design/development mode, simply set it to TRUE. No translations occurs when the "Harvester" is on.
					<ul>
						<li><u>set(localizatorLanguageHarvest=true)</u></li>
					</ul>
				</dd>
			</dl>

			<hr />
			
			<div class="alert alert-success" style="text-align:center; margin-bottom:0;">
				<p><span class="label label-success">Important</span> &nbsp;This plugin use the standard Java locale names (Locale ID).</p>
				<p><a href="http://docs.oracle.com/javase/1.4.2/docs/guide/intl/locale.doc.html" target="_blank">http://docs.oracle.com/javase/1.4.2/docs/guide/intl/locale.doc.html</a></p>
			</div>
		</div>
	</div>
</cfoutput>