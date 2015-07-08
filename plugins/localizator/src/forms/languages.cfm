<cfoutput>
	<div class="well">
		<div class="row">
			<div class="col-sm-6">
				<h4>Add new language</h4>

				<form action="#loc.config.url###addLanguage" method="post" name="addLanguage">
					<input type="hidden" name="type" value="addLanguage">

					<div class="form-group">
						#selectTag(name="locales[localeid]", options=localizatorGetAvailableLocaleid(), class="form-control")#
					</div>

					<input type="submit" value="Add" class="btn btn-default pull-right">
				</form>
			</div>

			<div class="col-sm-6">
				<h4>Delete language</h4>
				
				<form action="#loc.config.url###deleteLanguage" method="post" name="deleteLanguage">
					<input type="hidden" name="type" value="deleteLanguage">

					<div class="form-group">
						#selectTag(name="locales[localeid]", options=localizatorGetLanguages(), class="form-control")#
					</div>

					<input type="submit" value="Delete" class="btn btn-default pull-right">
				</form>
			</div>
		</div>
	</div>
</cfoutput>