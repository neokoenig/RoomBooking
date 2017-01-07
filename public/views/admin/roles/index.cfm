<cfparam name="allroles">
<cfoutput>
#box(title="Roles")#
<table id="rolestable" class="table table-bordered table-striped">
	<thead>
	<tr>
		<th>#l("ID")#</th>
		<th>#l("Name")#</th>
		<th>#l("Actions")#</th>
	</tr>
	</thead>
	<tbody>
	<cfloop query="allroles">
		<tr>
			<td>#id#</td>
			<td>#titleize(name)#</td>
			<td>#linkTo(route="editAdminRole", key=id, text="<i class='fa fa-edit'></i> " & l("Edit"), class="btn btn-xs btn-primary")#</td>
		</tr>
	</cfloop>
	</tbody>
	</table>
#boxEnd()#
</cfoutput>
