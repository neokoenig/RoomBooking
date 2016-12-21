<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Location List ---->
<cfoutput>
#panel(title=l("Available Locations"))#
<cfif locations.recordcount>
	<table class="table">
		<thead>
			<tr>
				<th>#l("Name")#</th>
				<th>#l("Description")#</th>
				<th>#l("Actions")#</th>
			</tr>
		</thead>
		<tbody>
		<cfloop query="locations">
			<cfoutput>
			<tr>
				<td>#name#</td>
				<td>#description#</td>
				<td>
					<div class="btn-group">
						#linkTo(text="<i class='glyphicon glyphicon-eye-open'></i> " & l("More Information"), class="btn btn-xs btn-primary", action="view", key=id)#
					</div>
				</td>
			</tr>
			</cfoutput>
		</cfloop>

		</tbody>
	</table>
<cfelse>
	<p>#l("No Locations available yet")#</p>
</cfif>
#panelEnd()#
</cfoutput>