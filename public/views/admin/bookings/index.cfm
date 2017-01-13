<cfparam name="bookings">
<cfoutput>
<cfif hasPermission("admin.bookings.new")>
#linkTo(route="newAdminBooking", class="btn btn-primary", text="<i class='fa fa-plus'></i> " & l("Create New Booking") )#
</cfif>
<hr />

<cfif bookings.recordcount>
	#box(title="Bookings")#

	#paginationLinks()#
	<table id="bookingstable" class="table table-bordered table-striped">
	<thead>
	<tr>
		<th>#l("ID")#</th>
		<th>#l("Name")#</th>
		<th>#l("Date")#</th>
		<th>#l("Approved")#</th>
		<th>#l("Actions")#</th>
	</tr>
	</thead>
	<tbody>
	<cfloop query="bookings">
		<tr>
			<td>#ID#</td>
			<td>#title# <cfif isRepeat && len(repeatpattern)><i class="fa fa-refresh pull-right"></i></cfif></td>
			<th>#LSDateFormat(startUTC)#
			<cfif isallDay>(#l("All Day")#)<Cfelse>#LSTimeFormat(startUTC)#</cfif></th>
			<th>#tickorcross(isapproved)#</th>
			<td><div class="btn-group">
			<cfif hasPermission("admin.bookings.edit")>
				#linkTo(route="editAdminBooking", key=id, title=l("Edit"), text="<i class='fa fa-edit'></i> " & l("Edit"), class="btn btn-xs btn-flat btn-primary")#
			</cfif>
			<cfif hasPermission("admin.bookings.delete")>
				#linkTo(href=adminBookingPath(id), method="delete", title=l("Delete"), text="<i class='fa fa-trash-o'></i>", class="btn btn-xs btn-flat btn-danger", confirm=l("Delete This Booking?"))#
			</cfif>
			</div>
		</tr>
	</cfloop>
	</tbody>
	</table>
	#paginationLinks()#
	#boxEnd()#
<cfelse>
	#alert(title="No Bookings Found", content="There aren't any bookings yet. Maybe create some?")#
</cfif>

</cfoutput>
