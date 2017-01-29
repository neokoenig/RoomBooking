<cfparam name="allactions">
<cfparam name="availableCFCs">
<cfoutput>
#linkTo(route="newAdminAction", class="btn btn-primary btn-flat", text="<i class='fa fa-plus'></i> " & l("Create New Action") )#
<hr />
<cfif allactions.recordcount>
#box(title="Actions")#
<table id="actionstable" class="table table-bordered table-striped table-condensed">

		<thead>
	<tr>
		<th>#l("title")#</th>
		<th>#l("desc")#</th>
		<th>#l("Uses")#</th>
	</tr>
	</thead>
		<tbody>
	<cfloop query="allactions">
			<tr>
				<td>#title#</td>
				<td>#description#</td>
				<td>#componentcfc#</td>
				<td>
					<div class="btn-group">
						<cfif hasPermission("admin.actions.edit")>
							#linkTo(route="editAdminAction", key=id, title=l("Edit"), text="<i class='fa fa-edit'></i> " & l("Edit"), class="btn btn-xs btn-flat btn-primary")#
						</cfif>
						<cfif hasPermission("admin.actions.delete")>
							#linkTo(href=adminActionPath(id), method="delete", title=l("Delete"), text="<i class='fa fa-trash-o'></i>", class="btn btn-xs btn-flat btn-danger", confirm=l("Delete This Action?"))#
						</cfif>
					</div>
				</td>

			</tr>
		</cfloop>
		</tbody>
	</table>
#boxEnd()#
<cfelse>
	#alert(title="No Actions Found", content="There aren't any actions yet. Maybe create some?")#
</cfif>
#box(title=l("Available CFCs"))#
<cfloop array="#availableCFCs.actions#" index="i">
#i#<br />
</cfloop>
#boxEnd()#

</cfoutput>

