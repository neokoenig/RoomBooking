<cfparam name="rooms">
<cfoutput>
#linkTo(route="newAdminRoom", class="btn btn-primary", text="<i class='fa fa-plus'></i> " & l("Create New Room") )#
<hr />

<cfif rooms.recordcount>
#box(title="Rooms")#
<table id="roomstable" class="table table-bordered table-striped">

	<cfloop query="rooms" group="buildingid">
		<thead>
	<tr>
		<th colspan="4"><cfif len(buildingtitle)><i class='fa #buildingicon#' style="color:###buildinghexcolour#;"></i> #buildingtitle#<cfelse>
		#l("Standalone Rooms")#</cfif></th>

	</tr>
	</thead>
		<tbody>
		<cfloop>
			<tr>
			<td width="25"></td>
			<td><i class='fa #icon#' style="color:###hexcolour#;"></i> #title#</td>
			<td><small>#description#</small></td>
				<td>#linkTo(route="editAdminRoom", key=id, text="<i class='fa fa-edit'></i> " & l("Edit"), class="btn btn-xs btn-flat btn-primary")#</td>

			</tr>
		</cfloop>
		</tbody>
	</cfloop>
	</table>
#boxEnd()#
<cfelse>
	#alert(title="No Rooms Found", content="There aren't any rooms yet. Maybe create some?")#
</cfif>

</cfoutput>

