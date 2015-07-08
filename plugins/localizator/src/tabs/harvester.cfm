<cfoutput>
	<div class="tab-pane" id="Harvester">
		<div class="pad">
			<ul class="list-custom">
				<li>The "Harvester" only work in design/development mode.</li>
				<li>The plugin will grab the text passed by the "<strong>localizeme</strong>" or "<strong>l</strong>" function.</li>
				<li>When you execute the code the plugin will:
					<ol>
						<li>Save the text to your database.<br />Be sure to configure your localization table with at least these columns:
							<ul>
								<li><em>id</em> (int Primary Key).</li>
								<li><em>text</em> (VarChar(MAX)).</li>
								<li>Your default language <em>en_US</em>, <em>en_CA</em> (VarChar(MAX)) or other Locale ID.</li>
							</ul>
						</li>
						<li>Fill the main repository.cfm file.<br />--> /plugins/localizator/repository/repository.cfm</li>
						<li>Fill the default language file, based on the default language you have configured. The file will be named with the Locale ID (en_US.cfm, en_CA.cfm, fr_CA.cfm). <br />--> /plugins/localizator/locales/en_US.cfm</li>
						<li>Fill all localization files you have created in the locales folder. <br />--> /plugins/localizator/locales/
							<ul>
								<li>You can add any number of localization files. Create "blank" .cfm pages named with the Locale ID (en_US.cfm, en_CA.cfm, fr_CA.cfm) in the locales folder.</li>
							</ul>
						</li>
					</ol>
				</li>
				<li>The plugin prevent duplicate entries.</li>
				<li>Once you have finished harvesting your site, open the localization files and put your transaltion in.</li>
			</ul>
		</div>
	</div>
</cfoutput>