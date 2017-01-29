<cfparam name="allworkflows">
<cfoutput>
#linkTo(route="newAdminWorkflow", class="btn btn-primary btn-flat", text="<i class='fa fa-plus'></i> " & l("Create New Workflow") )#
<hr />

<cfif allworkflows.recordcount>
#box(title="Workflows")#
<table id="workflowstable" class="table table-bordered table-striped table-condensed">
	<thead>
	<tr>
		<th>#l("Name")#</th>
		<th>#l("Active")#</th>
		<th>#l("Actions")#</th>
	</tr>
	</thead>
	<tbody>
	<cfloop query="allworkflows" group="id">
		<tr>
			<td>#title#</td>
			<td>#tickorcross(isactive)#</td>
			<td>

						<cfif hasPermission("admin.workflowtriggers.index")>
			#linkTo(route="adminWorkflowtriggersIndex", key=id, text="<i class='fa fa-edit'></i> " & l("View Triggers"), class="btn btn-xs btn-flat btn-info")#

						</cfif>
					<div class="btn-group">
						<cfif hasPermission("admin.workflows.edit")>
							#linkTo(route="editAdminWorkflow", key=id, title=l("Edit"), text="<i class='fa fa-edit'></i> " & l("Edit"), class="btn btn-xs btn-flat btn-primary")#
						</cfif>
						<cfif hasPermission("admin.workflows.delete")>
							#linkTo(href=adminWorkflowPath(id), method="delete", title=l("Delete"), text="<i class='fa fa-trash-o'></i>", class="btn btn-xs btn-flat btn-danger", confirm=l("Delete This Workflow?"))#
						</cfif>
					</div>
			</td>
		</tr>
	</cfloop>
	</tbody>
	</table>
#boxEnd()#
<cfelse>
	#alert(title="No Workflows Found", content="There aren't any workflows yet. Maybe create some?")#
</cfif>

</cfoutput>
