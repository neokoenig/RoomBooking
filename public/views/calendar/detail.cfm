<cfoutput>
<div class="btn-group btn-group-justified">
	<cfif booking.isRepeat && len(booking.repeatpattern)>
	<!--- Edit instance/all/just future? --->
	#linkTo(route="editadminBooking", key=booking.key(), text="<i class='fa fa-edit'></i> Edit", class="btn btn-flat btn-xs btn-primary")#
	<cfelse>
	#linkTo(route="editadminBooking", key=booking.key(), text="<i class='fa fa-edit'></i> Edit", class="btn btn-flat btn-xs btn-primary")#
	</cfif>
	#linkTo(route="editadminBooking", key=booking.key(), text="<i class='fa fa-eye'></i> View", class="btn btn-flat btn-xs btn-info")#
	#linkTo(route="adminbooking", key=booking.key(), text="<i class='fa fa-clone'></i> Clone", class="btn btn-flat btn-xs btn-warning")#
</div>
<div style="padding:10px;">
<h3>#booking.title#</h3>
<p>#LSDateFormatDuration(booking.startUTC, booking.endUTC, booking.duration)#</p>
<p>Status: #booking.isapproved#</p>
<p>Duration: #LSdurationString(booking.duration)#</p>
</div>
<div class="btn-group  btn-group-justified">
	<cfif !booking.approved>
	#linkTo(route="editadminBooking", key=booking.key(), text="<i class='fa fa-check'></i> Approve", class="btn btn-flat btn-xs btn-success")#
	#linkTo(route="editadminBooking", key=booking.key(), text="<i class='fa fa-trash-o'></i> Deny", class="btn btn-flat btn-xs btn-warning")#
	</cfif>
	#linkTo(route="adminbooking", key=booking.key(), text="<i class='fa fa-trash-o'></i> Delete", class="btn btn-flat btn-xs btn-danger")#
</div>


</cfoutput>

