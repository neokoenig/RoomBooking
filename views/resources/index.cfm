<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Resources --->
<cfparam name="resources">
<cfoutput>
	#panel(title=l("All Resources"))#
	#linkTo(Text="<i class='glyphicon glyphicon-plus'></i> " & l("Create New Resource"), class="btn btn-primary", action="add")#
	<cfif resources.recordcount>
		<table class="table">
			<thead>
				<tr>
					<th>#l("ID")#</th>
					<th>#l("Name")#</th>
					<th>#l("Type")#</th>
					<th>#l("Restricted")#?</th>
					<th>#l("Unique")#?</th>
					<th>#l("Actions")#</th>
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
									#linkTo(text="<i class='glyphicon glyphicon-edit'></i> " & l("Edit"), class="btn btn-xs btn-info", action="edit", key=id)#
									#linkTo(text="<i class='glyphicon glyphicon-trash'></i> " & l("Delete"), class="btn btn-xs btn-danger", action="delete", key=id, confirm=l('Are you Sure?'))#
								</div>
							</td>
						</tr>
					</cfoutput>
				</cfloop>

			</tbody>
		</table>
		<cfelse>
			<p>#l("No Resources available yet")#</p>
		</cfif>
	#panelEnd()#
</cfoutput>