<cfoutput>
	<div class="col-sm-12">
		<h1>Editor (Localization files only)</h1>
	</div>
	
	<div class="col-sm-6">
		<div class="well">
			<form action="#loc.config.url###edit" method="post" name="localizationForm">
				<cfif isDefined("localizationForm.update")>
					<input type="hidden" name="type" value="update">
					<cfset txtButton = "Update">
				
				<cfelse>
					<input type="hidden" name="type" value="add">
					<cfset txtButton = "Add">
				</cfif>
				
				<div class="form-group">
					<label>Text</label>
					
					<cfif isDefined("localizationForm.update")>
						<input type="hidden" name="localizationForm[text]" value="#isDefined('localizationForm.text') ? localizationForm.text : ''#">
						<input type="text" class="form-control" class="form-control" name="bogus" value="#isDefined('localizationForm.text') ? localizationForm.text : ''#" disabled />
					
					<cfelse>
						<input type="text" class="form-control" name="localizationForm[text]" value="#isDefined('localizationForm.text') ? localizationForm.text : ''#" />
					</cfif>
				</div>

				<cfif ListLen("loc.config.settings.languages.locales")>
					<cfloop list="#loc.config.settings.languages.locales#" index="loc.language">
						<div class="form-group">
							<label>#GetLocaleDisplayName(loc.language, getLocale())#</label>
							
							<input type="text" class="form-control" name="localizationForm[#loc.language#]" value="#isDefined('localizationForm.#loc.language#') ? localizationForm[loc.language] : ''#" />
							
							<cfif loc.language EQ ListLast(loc.config.settings.languages.locales)>
								<input type="submit" value="#txtButton#" class="btn btn-default" style="margin-top:20px;">
								
								<cfif isDefined("localizationForm.update")>
									<input type="button" value="Cancel" class="btn btn-default" style="margin-top:20px;" />
								</cfif>
							</cfif>
						</div>
					</cfloop>
				
				<cfelse>
					<input type="submit" value="#txtButton#" class="btn btn-default" style="margin-top:20px;">
				</cfif>
			</form>
		</div>
		
		<cfinclude template="languages.cfm">
	</div>
	
	<cfinclude template="list.cfm">
</cfoutput>