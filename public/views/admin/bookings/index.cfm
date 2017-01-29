<cfparam name="bookings">
<cfoutput>
<cfif hasPermission("admin.bookings.new")>
#linkTo(route="newAdminBooking", class="btn btn-primary btn-flat", text="<i class='fa fa-plus'></i> " & l("Create New Booking") )#
</cfif>
<hr />
#includePartial("filter")#
<cfif arrayLen(bookings)>
	#box(title="Bookings (" & arrayLen(bookings) & ")")#
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
	<cfloop from="1" to="#arrayLen(bookings)#" index="i">
		#includePartial(partial="row", booking=bookings[i])#
	</cfloop>
	</tbody>
	</table>
	#boxEnd()#
<cfelse>
	#alert(title="No Bookings Found", content="There aren't any bookings yet. Maybe create some?")#
</cfif>

</cfoutput>
