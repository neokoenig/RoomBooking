<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfparam name="events">

<cfoutput>
	#includePartial(partial = "list/filter")#
	#panel(title=l("Events ({#arrayLen(events)#}) records"))#
 <cfif arrayLen(events)>
 <cfif application.rbs.setting.showlocationcolours>
	<style>
	<cfloop query="locations"><cfif len(colour)>.#class# {border-left: 6px solid #colour#; }</cfif>
	</cfloop>
	</style>
</cfif>

<table class="table table-condensed table-striped">
	<thead>
		<tr>
			<th colspan=2>#l("Date")#</th>
			<th>#l("Location")#</th>
			<th>#l("Title")#</th>
			<th>#l("Layout")#</th>
			<th colspan=2>#l("Actions")#</th>
		</tr>
	</thead>
	<tbody>

	<!---
		For date output, we want to hide the date if the event after this one is on the same day and only show the time
		currentLoopDate is compared to current rows start date and uses alternative formatting if required
	--->
	<cfset currentLoopDate=_formatDate(events[1]["start"])>
	<cfset isDateRow=1>

	<cfloop from="1" to="#arraylen(events)#" index="i">
		<cfif len(events[i]["id"])>
			<cfif currentLoopDate NEQ _formatDate(events[i]["start"])>
				<cfset isDateRow=1>
			</cfif>
			<tr class="<cfif isDateRow>header-row</cfif>">
			<td width=100>
				<cfif isDateRow>
				#_formatDate(events[i]["start"])#
				</cfif>
			</td>
			<td width=100><cfif !events[i]["allDay"]>#_formatTime(events[i]["start"])# 
				<cfelse>#l("All Day")#
			</cfif></td>
			<td width=150 class="#events[i]["class"]#"><cfif len(events[i]["building"])>
				<small>#events[i]["building"]#</small><br />
			</cfif> #events[i]["name"]#<br /><small><!---#events[i]["locationdescription"]#---> loc desc?</small></td>
			<td class="#events[i]["className"]#"> 
				<cfif len(params.q)>
					#highlight(text=events[i]["title"], phrases=params.q)#
				<cfelse>
					#events[i]["title"]#
				</cfif>
			</td>

			<td>#events[i]["layoutstyle"]#</td>
			<td>
			<cfif len(events[i]["description"])>
				<cfif len(params.q)>
					#highlight(text=events[i]["description"], phrases=params.q)#
				<cfelse>
					#events[i]["description"]#
				</cfif><br />
			</cfif>
			<small>
			<!---cfif len(events[i]["contactemail"]) AND len(events[i]["contactname"])>
				#l("Contact")#: <a href="mailto:#events[i]["contactemail"]#">#events[i]["contactname"]#</a>
			<cfelseif len(events[i]["contactname"])>
				#l("Contact")#: #events[i]["contactname"]#
			</cfif>
			<cfif len(events[i]["contactno"])>
				(#events[i]["contactno"]#)
			</cfif--->
		</small></td>
		<td>
			<cfif checkPermission("allowRoomBooking")>
				<div class="btn-group">
				#linkTo(action="view", key=events[i]["id"], text="<span class='glyphicon glyphicon-eye-open'></span>", controller="bookings", class="btn btn-primary btn-xs")#
				#linkTo(action="edit", key=events[i]["id"], text="<span class='glyphicon glyphicon-pencil'></span>", controller="bookings", class="btn btn-info btn-xs")#

				</div>
			</cfif></td>
		</tr>
		</cfif>
		<cfset currentLoopDate=_formatDate(events[i]["start"])>
		<cfset  isDateRow=0>
	</cfloop>

		 
	</tbody>
</table>
<cfelse>
<div class="alert alert-danger"><strong>#l("Sorry!")#</strong>, #l("No events returned for that date range")#.</div>
 </cfif>
 #panelEnd()#
</cfoutput>
