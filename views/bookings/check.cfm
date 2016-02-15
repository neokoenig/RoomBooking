<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Remote Concurrency Check --->
<cfoutput> 
	<cfif arrayLen(eCheck)>
	<div class="alert alert-danger">
		<strong>#l('Potential Clash')#!</strong>
		<p>#l("We've identified {#arrayLen(eCheck)#} event(s) which may clash with your selected time in that location")#:</p>

		<cfif arraylen(eCheck) LT 20> 
		<ul>
			<cfloop from="1" to="#arraylen(eCheck)#" index="i">
				<li>#eCheck[i]['title']# - (#_formatDateRange(eCheck[i]['start'], eCheck[i]['end'], eCheck[i]['allday'])#)</li>
			</cfloop>
		</ul>
		<cfelse>
			<p>&hellip;</p>
		</cfif>
	</div>
</cfif>
</cfoutput>
