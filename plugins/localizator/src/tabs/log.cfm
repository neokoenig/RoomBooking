<cfoutput>
	<div class="tab-pane" id="Log">
		<div class="pad">
			<dl class="dl-horizontal">
				<dt>Version 2.6.1</dt>
				<dd>August 26, 2014
					<ul>
						<li>Redirection option added to addTranslation(), updateTranslation() and deleteTranslation() functions.</li>
					</ul>
				</dd>
				<dt>Version 2.6</dt>
				<dd>August 11, 2014
					<ul>
						<li>Now compatible with Wheels 1.3</li>
						<li>Bug fixes</li>
						<li>Remove Lobot plugin support</li>
						<li>Add localizatorGetPluginSettings function</li>
						<li>Add localizatorValidateLanguagesList function</li>
					</ul>
				</dd>
				<dt>Version 2.5</dt>
				<dd>October 10, 2013
					<ul>
						<li>You can add translation from your locales files to your localization table</li>
					</ul>
				</dd>
				<dt>Version 2.4</dt>
				<dd>October 9, 2013
					<ul>
						<li>Now compatible with Lobot plugin<br />
						<a href="https://github.com/ellor1138/Lobot" target="_blank">https://github.com/ellor1138/Lobot</a><br />
						<a href="http://cfwheels.org/plugins/listing/95" target="_blank">http://cfwheels.org/plugins/listing/95</a>
						</li>
					</ul>
				</dd>
				<dt>Version 2.3</dt>
				<dd>September 20, 2013
					<ul>
						<li>Add localizatorGetAvailableLocaleid function</li>
						<li>Add localizatorAddLocaleid function</li>
						<li>Add localizatorDeleteLocaleid function</li>
						<li>Update the Editor to add/delete new language</li>
					</ul>
				</dd>
				<dt>Version 2.2</dt>
				<dd>August 27, 2013
					<ul>
						<li>Add localizatorCheckForErrors function</li>
					</ul>
				</dd>
				<dt>Version 2.1</dt>
				<dd>July 22, 2013
					<ul>
						<li>Add localizatorGetLanguages function</li>
					</ul>
				</dd>
				<dt>Version 2.0</dt>
				<dd>January 14, 2013
					<ul>
						<li>Plugin re-written from scratch</li>
						<li>Plugin settings and detection are set when you reload the application</li>
						<li>Major speed improvement with database and localization file(s)</li>
						<li>Addition of plugin unit test scripts</li>
					</ul>
				</dd>
				<dt>Version 1.3</dt>
				<dd>December 21, 2012
					<ul>
						<li>New setting: You can force the plugin to get translation from the localization files instead of the database.</li>
						<li>Speed improvement: Database/table detection happens only when you reload the application.</li>
					</ul>
				</dd>
				<dt>Version 1.2</dt>
				<dd>December 20, 2012
					<ul>
						<li>Test with ColdFusion 10</li>
						<li>Test with MySQL 5.5</li>
						<li>Fix bug with datasource/table detection (MySQL)</li>
						<li>Validate passed Locale ID against available server Locale ID</li>
					</ul>
				</dd>
				<dt>Version 1.1</dt>
				<dd>December 19, 2012
					<ul>
						<li>Fix bug with session</li>
					</ul>
				</dd>
				<dt>Version 1.0</dt>
				<dd>December 19, 2012
					<ul>
						<li>First commit</li>
					</ul>
				</dd>
			</dl>
		</div>
	</div>
</cfoutput>