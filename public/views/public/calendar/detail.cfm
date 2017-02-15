<cfprocessingdirective suppressWhitespace="true">
<cfoutput>
	<p>
		<i class='fa fa-calendar'></i> #LSDateFormatDuration(booking.startUTC, booking.endUTC, booking.isallday)#

		<cfif len(booking.building.title)>
			<br /><cfif len(booking.building.icon)><i class="fa #booking.building.icon#"></i> </cfif>#booking.building.title#
		</cfif>
		<cfif len(booking.room.title)>
			<br /><cfif len(booking.room.icon)><i class="fa #booking.room.icon#"></i> </cfif>#booking.room.title#
		</cfif>

		<br /><i class='fa fa-clock-o'></i> <cfif booking.isallDay>#l("All Day")#<cfelse>#LSdurationString(booking.duration)#</cfif>

		<cfif booking.isRepeat && len(booking.repeatpattern)>
			<br /><small>#l("Repeats")#: #booking.repeatpattern#</small>
		</cfif>
	</p>
<div class="btn-group btn-group-justified">
	<cfif hasPermission("admin.bookings.edit")>
		<cfif booking.isRepeat && len(booking.repeatpattern)>
			<!--- Edit instance/all/just future? --->
			#linkTo(route="editadminBooking", key=booking.key(), text="<i class='fa fa-edit'></i> Edit", class="btn btn-flat btn-xs btn-primary")#
		<cfelse>
			#linkTo(route="editadminBooking", key=booking.key(), text="<i class='fa fa-edit'></i> Edit", class="btn btn-flat btn-xs btn-primary")#
		</cfif>
	</cfif>
	<cfif hasPermission("admin.bookings.view")>
		#linkTo(route="editadminBooking", key=booking.key(), text="<i class='fa fa-eye'></i> View", class="btn btn-flat btn-xs btn-info")#
	</cfif>
	<!---cfif hasPermission("admin.bookings.clone")>
	#linkTo(route="adminbooking", key=booking.key(), text="<i class='fa fa-clone'></i> Clone", class="btn btn-flat btn-xs btn-warning")#
	</cfif--->
</div>
<div class="btn-group  btn-group-justified">
	<cfif !booking.isapproved && hasPermission("admin.bookings.approve")>
		#linkTo(route="editadminBooking", key=booking.key(), text="<i class='fa fa-check'></i> Approve", class="btn btn-flat btn-xs btn-success")#
		#linkTo(route="editadminBooking", key=booking.key(), text="<i class='fa fa-trash-o'></i> Deny", class="btn btn-flat btn-xs btn-danger")#
	</cfif>
	<!---cfif hasPermission("admin.bookings.delete")>
	#linkTo(route="adminbooking", key=booking.key(), text="<i class='fa fa-trash-o'></i> Delete", class="btn btn-flat btn-xs btn-danger")#
	</cfif--->
</div>
</cfoutput>
</cfprocessingdirective>
