<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Locations --->
<cfparam name="locations">
<Cfoutput>
#panel(title="All Locations")#
#linkTo(Text="<i class='glyphicon glyphicon-plus'></i> Create New Location", class="btn btn-primary", action="add")#
<cfif locations.recordcount>

<table class="table">
	<thead>
		<tr>
			<th>ID</th>
			<th>Building</th>
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
			<td>#building#</td>
			<td>#name#</td>
			<td>#description#</td>
			<td>
				<div class="btn-group">
					#linkTo(text="<i class='glyphicon glyphicon-eye-open'></i> View", class="btn btn-xs btn-primary", action="view", key=id)#
					#linkTo(text="<i class='glyphicon glyphicon-edit'></i> Edit", class="btn btn-xs btn-info", action="edit", key=id)#
					#linkTo(text="<i class='glyphicon glyphicon-trash'></i> Delete", class="btn btn-xs btn-danger", action="delete", key=id, confirm='Are you Sure?')#
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