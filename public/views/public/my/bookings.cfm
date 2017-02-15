<cfparam name="bookings">
<cfoutput>
#includePartial("header")#

#box(title=l("My Bookings"))#
	<cfif bookings.recordcount>
		#paginationLinks(route="myBookings")#
		<table id="bookingstable" class="table table-bordered table-striped table-condensed">
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
			<td class='#iif(isapproved, "'success'", "'danger'")#'>
				#tickorcross(isapproved)#
			</td></td>
			<td><div class="btn-group">
			<cfif hasPermission("admin.bookings.edit")>
				#linkTo(route="editAdminBooking", key=id, title=l("Edit"), text="<i class='fa fa-edit'></i> " & l("Edit"), class="btn btn-xs btn-flat btn-primary")#
			</cfif>
			<cfif hasPermission("admin.bookings.delete")>
				#linkTo(href=adminBookingPath(id), method="delete", title=l("Delete"), text="<i class='fa fa-trash-o'></i>", class="btn btn-xs btn-flat btn-danger", confirm=l("Delete This Booking?"))#
			</cfif>
			</div>
			</td>
			</tr>
		</cfloop>
		</tbody>
		</table>
		#paginationLinks(route="myBookings")#
	<cfelse>
		<p>#l("No bookings available")#</p>
	</cfif>
#boxEnd()#
</cfoutput>
