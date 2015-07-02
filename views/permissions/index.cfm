<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Permissions --->
<cfparam name="permissions">
<cfoutput>
#panel(title="Permissions")#

<cfif permissions.recordcount>

		<table class="table table-condensed">
			<thead>
				<tr>
					<th>Permission</th>
					<cfloop list="#application.rbs.roles#" index="i">
						<th>#i#</th>
					</cfloop>
				</tr>
			</thead>
			<tbody>
			<cfloop query="permissions">
				<tr>
					<td><strong>#h(id)#</strong><br /><small>#h(autolink(notes))#</small></td>
					<cfloop list="#application.rbs.roles#" index="i">
						<td>#tickorcross(permissions[i])#</td>
					</cfloop>
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
</cfoutput>
