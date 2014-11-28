<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Resources --->
<cfparam name="resources">
<Cfoutput>


#panel(title="All Resources")#
#linkTo(Text="<i class='glyphicon glyphicon-plus'></i> Create New Resource", class="btn btn-primary", action="add")#
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
			<td><code>#h(type)#</code></td>
			<td>#tickorcross(len(restrictlocations))#</td>
			<td>#tickorcross(isunique)#</td>
			<td>
				<div class="btn-group">
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
		<p>No Resources available yet</p>
</cfif>
#panelEnd()#

</Cfoutput>