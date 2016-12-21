<cfoutput>
	<div class="#loc.config.settings.isDB EQ true ? 'tab-pane active' : 'tab-pane'#" id="Database">
		<div class="pad">
			<cfif loc.config.settings.isDB>
				<div class="alert alert-success" style="margin:0;">
					<h4>Datasource found!</h4>
					<ul>
						<li>#loc.config.settings.dataSource#</li>
					</ul>

					<h4 style="margin-top:20px;">Localization table found!</h4>
					<ul>
						<li>#loc.config.settings.localizationtable#</li>
						
						<cfif isDefined("loc.config.settings.languages.database") AND ListLen(loc.config.settings.languages.database)>
							<li>#pluralize(word="Language", count=ListLen(loc.config.settings.languages.database), returnCount=false)# configured:
								<ul>
									<cfloop list="#loc.config.settings.languages.database#" index="loc.langue">
										<li>#GetLocaleDisplayName(loc.langue, getLocale())#</li>
									</cfloop>
								</ul>
							</li>
						</cfif>
					</ul>
					
					<cfif !loc.fromFile && isDefined("loc.localizations.texts") AND loc.localizations.texts.recordCount AND isDefined("loc.config.settings.languages.locales") AND ListLen(loc.config.settings.languages.locales)>
						<hr />
						
						<p style="text-align:center;">There is #pluralize(word="entry", count=loc.countDatabase)# in the localizaton table.</p>
						
						<div style="text-align:center; margin:20px 0 0;">
							<form action="#loc.config.url###tofile" method="post">
								<input type="hidden" name="type" value="tofile">
								<input type="submit" value="Generate localization file(s)" class="btn btn-default">
							</form>
						</div>
					</cfif>
				</div>
				
			<cfelseif !loc.config.settings.isAvailableDatabase>
				<div class="alert alert-danger" style="margin-bottom:0;">
					<h4>Datasource <strong style="color:##F30;">not found</strong></h4>
					<hr>
					<ol>
						<li>Create a new datasource and add it to config/environment/localizator.cfm</li>
						<li>Reload your application.</li>
					</ol>
				</div>

			<cfelseif !loc.config.settings.isAvailableDatabaseTable>
				<div class="alert alert-danger" style="margin-bottom:0;">
					<h4>Table <strong style="color:##F30;">not found</strong></h4>
					<hr>
					<ol>
						<li>Create a new table called "localizations" with these columns:
							<ul>
								<li>id (int Primary Key)</li>
								<li>text (VarChar(MAX))</li>
								<li>Your default language <em>en_US</em>, <em>en_CA</em> (VarChar(MAX)) or other Locale ID</li>
								<li>Other languages <em>en_CA</em>, <em>fr_CA</em> (VarChar(MAX)) or other Locale ID</li>
							</ul>
						</li>
						<li>Reload your application.</li>
					</ol>

					<div class="well" style="margin-bottom:0; background:##fff;">
						<small>You can give any name to your table. Just set <abbr title='localizatorLanguageTable="YourTableName"'>localizatorLanguageTable</abbr> with your table name..</small>
					</div>
				</div>
			</cfif>
		</div>
	</div>
</cfoutput>