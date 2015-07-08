<cfoutput>
	<div class="tab-pane" id="Credits">
		<div class="pad">
			<dl class="dl-horizontal">
				<dt>Author</dt>
				<dd>#loc.config.settings.plugin.author#</dd>
				<dt>Plugin name</dt>
				<dd>#capitalize(loc.config.settings.plugin.name)#</dd>
				<dt>Plugin version</dt>
				<dd>#loc.config.settings.plugin.version#</dd>
				<dt>Wheels compatibility</dt>
				<dd>#loc.config.settings.plugin.compatibility#</dd>
				<dt>First release date</dt>
				<dd>December 2012</dd>
				<dt>Project home</dt>
				<dd><a href="#loc.config.settings.plugin.project#" target="_blank">#loc.config.settings.plugin.project#</a></dd>
				<dt>Documentation</dt>
				<dd><a href="#loc.config.settings.plugin.documentation#" target="_blank">#loc.config.settings.plugin.documentation#</a></dd>
				<dt>Find any bugs?</dt>
				<dd>You can file an issue here:<br /><a href="#loc.config.settings.plugin.issues#" target="_blank">#loc.config.settings.plugin.issues#</a></dd>
				<dt>License</dt>
				<dd>#capitalize(loc.config.settings.plugin.name)# is licensed under the Apache License, Version 2.0.<br /><a href="http://www.apache.org/licenses/LICENSE-2.0" target="_blank">http://www.apache.org/licenses/LICENSE-2.0</a></dd>
			</dl>
			<div class="alert alert-info" style="margin-bottom:0;">Largely inspired by Raúl Riera's Localizer plugin. <a href="http://github.com/raulriera/Localizer" target="_blank">http://github.com/raulriera/Localizer</a></div>
		</div>
	</div>
</cfoutput>