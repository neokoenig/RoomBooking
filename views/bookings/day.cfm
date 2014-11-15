<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Alternative Day view a la MRBS --->
<cfparam name="locations">
<cfparam name="events">
<cfparam name="m" type="array">
<cfparam name="day" type="struct">
<cfparam name="isToday" default="false">
<cfif dateFormat(day.thedate, "yyyymmdd") EQ dateFormat(now(), "yyyymmdd")>
	<cfset isToday=true>
</cfif>
<cfif application.rbs.setting.showlocationcolours>
	<style>
	<cfloop query="locations"><cfoutput>
	<cfif len(colour)>
		.table-day th.#class# {background: #colour#; border-color: #colour#; color:white; font-weight:normal; font-size:80%;}
		.table-day tr td.#class# a {color: #colour#;}
		.table-day tr td.#class#.booked {border-right:1px solid #colour#; border-left:1px solid #colour#;}
		.table-day tr td.#class#.first {border-top:4px solid #colour#; font-size: 80%; border-bottom:2px solid #colour#;}
		 .table-day tr td.#class#.allday {font-size: 80%; border-bottom:2px solid #colour#;}
	</cfif>
	</cfoutput>
	</cfloop>
	.table-day tbody>tr>th, .table-day tfoot>tr>th, .table-day thead>tr>td, .table-day tbody>tr>td, .table-day tfoot>tr>td {padding:0;}
	.table-day tbody tr td.booked {border-top:none; border-width:0; background: #f4f4f4; padding:5px;}
	.table-day tr.hour {border-top:2px solid #ccc;}
	.table-day tr.hour.current {border-top:2px solid red;}
	.table-day tr td.free {border-right:1px dotted #ddd; }
	.table-day .label {font-size:100%;}
	.table-day .allday {padding:5px;}
	.table-day .lower-op {opacity:0.5;}
	</style>
</cfif>
<cfoutput>
#includePartial("day/header")#
<table class="table table-day">
	<thead>
		<tr>
			<th>Time</th>
			<cfloop query="locations">
				<cfquery dbtype="query" name="locationEventsC">
				SELECT * FROM events WHERE locationid = <cfqueryparam cfsqltype="cf_sql_numeric" value="#id#">;
				</cfquery>
				<cfoutput>
				<th class="#class# #iif(!locationEventsC.recordcount, '"lower-op"', '')#">
					#h(name)# (#locationEventsC.recordcount#)
				</th>
				</cfoutput>
			</cfloop>
		</tr>
		<tr>
			<th>All Day</th>
			<cfloop query="locations">
				<cfquery dbtype="query" name="locationEventsAllDay">
				SELECT * FROM allDay WHERE locationid = <cfqueryparam cfsqltype="cf_sql_numeric" value="#id#">;
				</cfquery>
				<cfoutput>
				<cfif locationEventsAllDay.recordcount>
					<td class="booked #class# allday">
						<cfloop query="locationEventsAllDay">
							#linkTo(controller='bookings', action='edit', key=locationEventsAllDay.id, text=h(title))#
						</cfloop>
					</td>
					<cfelse>
						<td>&nbsp;</td>
				</cfif>
				</cfoutput>
			</cfloop>
		</tr>
	</thead>
	<tbody>
		<cfset counter=1>
		<cfloop from="#day.starttime#" to="#day.endtime#" index="i" step="#CreateTimeSpan(0,0,application.rbs.setting.calendarSlotMinutes,0)#">
  			<cfoutput>
 				<cfif timeFormat(i, "MM") EQ "00">
 					<tr class="hour #iif(isToday AND (timeFormat(i, 'HH') EQ timeformat(now(), 'HH')), '"current"', '""')#">
	 				<th><strong>#timeFormat(i, "HH:MM")#</strong></th>
				<cfelse>
					<tr>
 					<th  class=""><small>#timeFormat(i, "HH:MM")#</small></th>
 				</cfif>
 				<cfloop from="1" to="#arraylen(m)#" index="z">
 					<cfoutput>
 					<cfif m[z][counter]["rowspan"] NEQ 0>
 						<td rowspan=#m[z][counter]["rowspan"]# class="#m[z][counter]['class']#">#m[z][counter]["content"]#</td>
 					</cfif>
 					</cfoutput>
 				</cfloop>
 			</tr>
	 		</cfoutput>
	 		<cfset counter++>
 		</cfloop>
	</tbody>
</table>
</cfoutput>