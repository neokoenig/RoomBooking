<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Permissions --->
<cfparam name="permissions">
<Cfoutput>
#panel(title="Permissions")#

<cfif permissions.recordcount>

		<table class="table table-condensed">
			<thead>
				<tr>
					<th>Permission</th>
					<th>Admin</th>
					<th>Editor</th>
					<th>User</th>
					<th>Guest</th>
				</tr>
			</thead>
			<tbody>
			<cfloop query="permissions">
				<tr>
					<td><strong>#h(id)#</strong><br /><small>#h(autolink(notes))#</small></td>
					<td>#tickorcross(admin)#</td>
					<td>#tickorcross(editor)#</td>
					<td>#tickorcross(user)#</td>
					<td>#tickorcross(guest)#</td>
					<td>
						<div class="btn-group">
								#linkTo(text="<i class='glyphicon glyphicon-edit'></i> Edit", class="btn btn-xs btn-info", action="edit", key=id)#
						</div>
					</td>
				</tr>
			</cfloop>
			</tbody>
		</table>


<cfelse>
	<p>No permissions available yet</p>
</cfif>
#panelEnd()#
</Cfoutput>
