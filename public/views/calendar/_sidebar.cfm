<cfoutput>
	#box(title="Filter By Location")#


             <!-- checkbox -->
              <div class="form-group">
                <label>
                  <input type="checkbox" class="minimal" checked>
                </label>
                <label>
                  <input type="checkbox" class="minimal">
                </label>
                <label>
                  <input type="checkbox" class="minimal" disabled>
                  Minimal skin checkbox
                </label>
              </div>

		<ul>
			<li><a href="">All</a>
			<li><a href="">Building One</a>
				<ul>
					<li><a href="">Room One</a></li>
					<li><a href="">Room Two</a></li>
					<li><a href="">Room Three</a></li>
					<li><a href="">Room Four</a></li>
				</ul>
			</li>
			<li><a href="">Building Two</a>
				<ul>
					<li><a href="">Room One</a></li>
					<li><a href="">Room Two</a></li>
					<li><a href="">Room Three</a></li>
					<li><a href="">Room Four</a></li>
				</ul>
			</li>
		</ul>
	#boxEnd()#
	#box(title="External Calendars")#
		<ul>
			<li><a href="">Test</a></li>
		</ul>
	#boxEnd()#
</cfoutput>
