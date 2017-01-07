<cfparam name="allroles">
<cfoutput>
#linkTo(route="newAdminRole", class="btn btn-primary", text="<i class='fa fa-plus'></i> " & l("Create New Role") )#
<hr />

#box(title="Permissions")#
<table id="permissionstable" class="table table-bordered table-striped">
	<thead>
	<tr>
		<th>#l("Name")#</th>
		<cfloop query="allroles">
			<th>#name#</th>
		</cfloop>
	</tr>
	</thead>
	<tbody>
	<cfloop query="permissions" group="id">
		<tr>
			<td>#name#<br /><small>#description#</small></td>
			<cfloop>
				<td>#checkBoxTag(name="p", checked=value)#</td>
			</cfloop>
		</tr>
	</cfloop>
	</tbody>
	</table>
#boxEnd()#

</cfoutput>
