<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Locations --->
<cfparam name="locations">
<Cfoutput>
	

#panel(title="All Locations")#
#linkTo(Text="Create New Location", class="btn btn-primary", action="add")#
<cfif locations.recordcount>
	
<table class="table">
	<thead>
		<tr>
			<th>ID</th>
			<th>Name</th>
			<th>Description</th>
			<th>Actions</th>
		</tr>
	</thead>
	<tbody>
	<cfloop query="locations">
		<cfoutput>
		<tr>
			<td>#id#</td>
			<td>#name#</td>
			<td>#description#</td>
			<td>
				<div class="btn-group">
					#linkTo(text="Edit", class="btn btn-sm btn-info", action="edit", key=id)#
					#linkTo(text="Delete", class="btn btn-sm btn-danger", action="delete", key=id, confirm='Are you Sure?')#
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

</Cfoutput>