<cfparam name="allbuildings">
<cfoutput>
#linkTo(route="newAdminBuilding", class="btn btn-primary", text="<i class='fa fa-plus'></i> " & l("Create New Building") )#
<hr />

<cfif allbuildings.recordcount>
#box(title="Buildings")#
<table id="buildingstable" class="table table-bordered table-striped">
	<thead>
	<tr>
		<th>#l("Name")#</th>
		<th>#l("Actions")#</th>
	</tr>
	</thead>
	<tbody>
	<cfloop query="allbuildings" group="id">
		<tr>
			<td><i class='fa #icon#' style="color:###hexcolour#;"></i> #title#<br /><small>#description#</small></td>
			<td>#linkTo(route="editAdminBuilding", key=id, text="<i class='fa fa-edit'></i> " & l("Edit"), class="btn btn-xs btn-flat btn-primary")#
		</tr>
	</cfloop>
	</tbody>
	</table>
#boxEnd()#
<cfelse>
	#alert(title="No Buildings Found", content="There aren't any buildings yet. Maybe create some?")#
</cfif>

</cfoutput>
