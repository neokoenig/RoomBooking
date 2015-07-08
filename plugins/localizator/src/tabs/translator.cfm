<cfoutput>
	<div class="tab-pane" id="Translator">
		<div class="pad">
			<ul class="list-custom">
				<li>Pass in the text you wish to translate in the "<strong>localizeme</strong>" or&nbsp;"<strong>l</strong>" function.
					<ul>
						<li>##localizeme("Thi is a static string")##</li>
						<li>##l("Thi is a dynamic string {##LsDateFormat(Now())##}")##</li>
						<li>If no translation is found, the original text is return.</li>
					</ul>
				</li>
				
				<li>For dynamic text, simply pass the variable in curly bracket.
					<ul>
						<li>##localizeme("Hi {##user.fullname##},")##</li>
						<li>##l("Next appointment is {##LSDateFormat(appointment.date))##}")##</li>
					</ul>
				</li>

				<li>You can specify the language you want by passing the Locale ID with the "<strong>localizeme</strong>" or&nbsp;"<strong>l</strong>" function.
					<ul>
						<li>##localizeme("This string will be transalted in French (Canadian)", "fr_CA")##</li>
						<li>##l("This string will be transalted in Icelandic (Iceland)", "is_IS")##</li>
					</ul>
				</li>
				
				<li>If no language is passed via the "<strong>localizeme</strong>" or&nbsp;"<strong>l</strong>" function, the plugin will:
					<ol>
						<li>check for a Locale ID in the session scope (e.g. a user session).</li>
						<li>or get the default Locale ID.</li>
					</ol>
				</li>
				<li>If no translation is found, the original text is return.</li>
			</ul>
		</div>
	</div>
</cfoutput>