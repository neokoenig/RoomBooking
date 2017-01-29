<cfparam name="alltriggers">
<cfoutput>
#linkTo(route="newAdminTrigger", class="btn btn-primary btn-flat", text="<i class='fa fa-plus'></i> " & l("Create New Trigger") )#
<hr />

<cfif alltriggers.recordcount>
#box(title="Triggers")#
<table id="triggerstable" class="table table-bordered table-striped table-condensed">

		<thead>
	<tr>
		<th>#l("title")#</th>
		<th>#l("type")#</th>
		<th>#l("on")#</th>
		<th>#l("when")#</th>
	</tr>
	</thead>
		<tbody>
	<cfloop query="alltriggers">
			<tr>
				<td>#title#</td>
				<td>#triggertype#</td>
				<td>#triggeron#</td>
				<td>#triggerwhen#</td>

				<td>
					<div class="btn-group">
						<cfif hasPermission("admin.triggers.edit")>
							#linkTo(route="editAdminTrigger", key=id, title=l("Edit"),
								text="<i class='fa fa-edit'></i> " & l("Edit"),
								class="btn btn-xs btn-flat btn-primary")#
						</cfif>
						<cfif hasPermission("admin.triggers.delete")>
							#linkTo(href=adminTriggerPath(id), method="delete", title=l("Delete"),
							text="<i class='fa fa-trash-o'></i>", class="btn btn-xs btn-flat btn-danger",
							confirm=l("Delete This Trigger?"))#
						</cfif>
					</div>
				</td>


			</tr>
		</cfloop>
		</tbody>
	</table>
#boxEnd()#
<cfelse>
	#alert(title="No Triggers Found", content="There aren't any triggers yet. Maybe create some?")#
</cfif>

</cfoutput>

