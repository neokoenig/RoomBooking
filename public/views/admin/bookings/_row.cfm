<cfoutput>
<tr>
<td>#booking.ID#</td>
<td>#booking.title# <cfif booking.isRepeat && len(booking.repeatpattern)><i class="fa fa-refresh pull-right"></i></cfif></td>
<th>#LSDateFormat(booking.startUTC)#
<cfif booking.isallDay>(#l("All Day")#)<Cfelse>#LSTimeFormat(booking.startUTC)#</cfif></th>
<th>#tickorcross(booking.isapproved)#</th>
<td><div class="btn-group">
<cfif hasPermission("admin.bookings.edit")>
	#linkTo(route="editAdminBooking", key=booking.id, title=l("Edit"), text="<i class='fa fa-edit'></i> " & l("Edit"), class="btn btn-xs btn-flat btn-primary")#
</cfif>
<!---cfif hasPermission("admin.bookings.delete")>
	#linkTo(href=adminBookingPath(booking.id), method="delete", title=l("Delete"), text="<i class='fa fa-trash-o'></i>", class="btn btn-xs btn-flat btn-danger", confirm=l("Delete This Booking?"))#
</cfif--->
</div>
</td>
</tr>
</cfoutput>
