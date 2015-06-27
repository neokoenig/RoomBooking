<!--- Remote Concurrency Check --->
<cfoutput>
	<cfif eCheck.recordcount>
	<div class="alert alert-danger">
		<strong>Potential Clash!</strong>
		<p>We've identified #eCheck.recordcount# event(s) which may clash with your selected time in that location:</p>
		<ul>
			<cfloop query="eCheck">
				<li>#title# - (#_formatDateRange(start, end, allday)#)</li>
			</cfloop>
		</ul>
	</div>
</cfif>
</cfoutput>
