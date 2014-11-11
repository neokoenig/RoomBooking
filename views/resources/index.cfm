<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Resources --->
<cfparam name="resources">
<Cfoutput>


#panel(title="All Resources")#
#linkTo(Text="Create New Resource", class="btn btn-primary", action="add")#
<cfif resources.recordcount>

<table class="table">
	<thead>
		<tr>
			<th>ID</th>
			<th>Name</th>
			<th>Type</th>
			<th>Restricted?</th>
			<th>Unique?</th>
			<th>Actions</th>
		</tr>
	</thead>
	<tbody>
	<cfloop query="resources">
		<cfoutput>
		<tr>
			<td>#id#</td>
			<td>#h(name)#<br /><small>#h(description)#</small></td>
			<td>#h(type)#</td>
			<td>#tickorcross(len(restrictlocations))#</td>
			<td>#tickorcross(isunique)#</td>
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
		<p>No Resources available yet</p>
</cfif>
#panelEnd()#

</Cfoutput>