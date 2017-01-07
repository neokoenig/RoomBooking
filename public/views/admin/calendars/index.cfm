<cfparam name="allcalendars">
<cfoutput>
#linkTo(route="newAdminCalendar", class="btn btn-primary", text="<i class='fa fa-plus'></i> " & l("Create New Calendar") )#
<hr />

<cfif allcalendars.recordcount>
#box(title="Calendars")#
<table id="calendartable" class="table table-bordered table-striped">
	<thead>
	<tr>
		<th>#l("Name")#</th>
		<th>#l("Actions")#</th>
	</tr>
	</thead>
	<tbody>
	<cfloop query="allcalendars" group="id">
		<tr>
			<td><i class='fa #icon#'></i> #title#<br /><small>#description#</small></td>
			<td>#linkTo(route="editAdminCalendar", key=id, text="<i class='fa fa-edit'></i> " & l("Edit"), class="btn btn-xs btn-flat btn-primary")#
		</tr>
	</cfloop>
	</tbody>
	</table>
#boxEnd()#
<cfelse>
	#alert(title="No Calendars Found", content="There aren't any calendars yet. Maybe create one?")#
</cfif>

</cfoutput>
