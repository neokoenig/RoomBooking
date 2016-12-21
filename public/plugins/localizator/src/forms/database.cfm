<cfoutput>
	<div class="col-sm-12">
		<h1>Editor (Database and localization files)</h1>
	</div>

	<div class="col-sm-6">
		<div class="well">
			<!--- DATABASE FORM --->
			<form action="#loc.config.url###edit" method="post" name="localizationForm">
				<cfif localizationForm.isNew()>
					<input type="hidden" name="type" value="add">
					<cfset txtButton = "Add">
				
				<cfelse>
					<input type="hidden" name="type" value="update">
					<input type="hidden" name="localizationForm[key]" value="#localizationForm.id#">
					<cfset txtButton = "Update">
				</cfif>
				
				<div class="form-group">
					<label>Text</label>
					
					<cfif localizationForm.isNew()>
						<input type="text" class="form-control" name="localizationForm[text]" value="#isDefined('localizationForm.text') ? localizationForm.text : ''#" />
					
					<cfelse>
						<input type="hidden" name="localizationForm[text]" value="#isDefined('localizationForm.text') ? localizationForm.text : ''#">
						<input type="text" class="form-control" name="bogus" value="#isDefined('localizationForm.text') ? localizationForm.text : ''#" disabled />
					</cfif>
				</div>

				<cfif ListLen("loc.config.settings.languages.database")>
					<cfloop list="#loc.config.settings.languages.database#" index="loc.language">
						<div class="form-group">
							<label>#GetLocaleDisplayName(loc.language, getLocale())#</label>

							<input type="text" class="form-control" name="localizationForm[#loc.language#]" value="#isDefined('localizationForm.#loc.language#') ? localizationForm[loc.language] : ''#" />
							
							<cfif loc.language EQ ListLast(loc.config.settings.languages.database)>
								<input type="submit" value="#txtButton#" class="btn btn-default" style="margin-top:20px;">

								<cfif !localizationForm.isNew()>
									<input type="button" value="Cancel" class="btn btn-default" style="margin-top:20px;" />
								</cfif>
							</cfif>
						</div>
					</cfloop>
				</cfif>
			</form>
		</div>
		
		<cfinclude template="languages.cfm">
	</div>
	
	<cfinclude template="list.cfm">
</cfoutput>