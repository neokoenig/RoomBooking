<cfoutput>
<div class="btn-group btn-group-justified">
	<cfif hasPermission("admin.booking.edit")>
		<cfif booking.isRepeat && len(booking.repeatpattern)>
		<!--- Edit instance/all/just future? --->
		#linkTo(route="editadminBooking", key=booking.key(), text="<i class='fa fa-edit'></i> Edit", class="btn btn-flat btn-xs btn-primary")#
		<cfelse>
		#linkTo(route="editadminBooking", key=booking.key(), text="<i class='fa fa-edit'></i> Edit", class="btn btn-flat btn-xs btn-primary")#
		</cfif>
	</cfif>
	<cfif hasPermission("admin.booking.view")>
	#linkTo(route="editadminBooking", key=booking.key(), text="<i class='fa fa-eye'></i> View", class="btn btn-flat btn-xs btn-info")#
	</cfif>
	<cfif hasPermission("admin.booking.clone")>
	#linkTo(route="adminbooking", key=booking.key(), text="<i class='fa fa-clone'></i> Clone", class="btn btn-flat btn-xs btn-warning")#
	</cfif>
</div>
<div style="padding:10px;">
	<h3>#booking.title#</h3>
	<p>#LSDateFormatDuration(booking.startUTC, booking.endUTC, booking.duration)#</p>
	<p>#l("Status")#: <cfif booking.isapproved>#l("Approved")#<cfelse>#l("Pending Approval")#</cfif></p>
	<p>#l("Duration")#: <cfif booking.isallDay>#l("All Day")#<cfelse>#LSdurationString(booking.duration)#</cfif></p>
	<cfif booking.isRepeat && len(booking.repeatpattern)>
	<p>#l("Repeats")#: #booking.repeatpattern#</p>
	</cfif>
</div>
<div class="btn-group  btn-group-justified">
	<cfif !booking.isapproved && hasPermission("admin.booking.approve")>
	#linkTo(route="editadminBooking", key=booking.key(), text="<i class='fa fa-check'></i> Approve", class="btn btn-flat btn-xs btn-success")#
	#linkTo(route="editadminBooking", key=booking.key(), text="<i class='fa fa-trash-o'></i> Deny", class="btn btn-flat btn-xs btn-warning")#
	</cfif>
	<cfif hasPermission("admin.booking.delete")>
	#linkTo(route="adminbooking", key=booking.key(), text="<i class='fa fa-trash-o'></i> Delete", class="btn btn-flat btn-xs btn-danger")#
	</cfif>
</div>
</cfoutput>
