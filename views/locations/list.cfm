<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Location List ---->
<cfoutput>
#panel(title="Available Locations")#
<cfif locations.recordcount>
	<table class="table">
		<thead>
			<tr>
				<th>Name</th>
				<th>Description</th>
				<th>Actions</th>
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
						#linkTo(text="<i class='glyphicon glyphicon-eye-open'></i> More Information", class="btn btn-xs btn-primary", action="view", key=id)#
					</div>
				</td>
			</tr>
			</cfoutput>
		</cfloop>

		</tbody>
	</table>
<cfelse>
	<p>No Locations available yet</p>
</cfif>
#panelEnd()#
</cfoutput>