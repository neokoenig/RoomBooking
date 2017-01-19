<cfparam name="allroles">
<cfoutput>
#linkTo(route="newAdminRole", class="btn btn-primary btn-flat", text="<i class='fa fa-plus'></i> " & l("Create New Role") )#
<hr />
#box(title="Roles")#
<table id="rolestable" class="table table-bordered table-striped table-condensed">
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
			<td>#titleize(name)# <cfif id EQ 1 OR id EQ 6><i class="fa fa-lock text-muted"></i></cfif></td>
			<td>
			<div class="btn-group">
				#linkTo(route="editAdminRole", key=id, text="<i class='fa fa-edit'></i> " & l("Edit"), class="btn btn-xs btn-flat btn-primary")#
				<cfif id EQ 1 OR id EQ 6>
				<cfelse>
				#linkTo(href=adminRolePath(id), method="delete", title=l("Delete"), text="<i class='fa fa-trash-o'></i>", class="btn btn-xs btn-flat btn-danger", confirm=l("Delete This Role?"))#
				</cfif>
			</div></td>
		</tr>
	</cfloop>
	</tbody>
	</table>
#boxEnd()#
</cfoutput>
