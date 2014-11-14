<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Alternative Day view a la MRBS --->
<cfparam name="locations">
<cfparam name="events">
<cfscript>
day={}
day.thedate=createDate(params.y, params.m, params.d);
day.starttime=CreateTime(_timeParse(application.rbs.setting.calendarMinTime), 0, 0);
day.endtime=CreateTime(_timeParse(application.rbs.setting.calendarMaxTime), 59, 0);

m=[];
e=[];
</cfscript>

 	<cfloop query="locations">
 		<cfoutput>
 		<cfloop from="#day.starttime#" to="#day.endtime#" index="i" step="#CreateTimeSpan(0,0,application.rbs.setting.calendarSlotMinutes,0)#">
 			<cfscript>
		 	t={};
 			t.timeslot=createDateTime(year(day.thedate), month(day.thedate), day(day.thedate), TimeFormat(i, "H"), TimeFormat(i, "m"), 0);
 			</cfscript>
		 	<cfquery dbtype="query" name="locationEvents">
			SELECT * FROM events WHERE locationid = <cfqueryparam cfsqltype="cf_sql_numeric" value="#id#">
			AND start <= #t.timeSlot# AND end > #t.timeslot#;
			</cfquery>
			<cfscript>
				if(locationEvents.recordcount){
					if(locationEvents.start EQ t.timeSlot){
						t.content=h(locationEvents.title);
						t.class="booked first #class#" ;
					} else {
						t.content=h(locationEvents.start);

						t.class="booked #class#";
					}
				} else {
					t.class="free"
					t.content="";
				}
			arrayAppend(e, t);
			</cfscript>

 	</cfloop>
 	<cfset arrayAppend(m, e)>
 	<cfset e=[]>
 	</cfoutput>
</cfloop>

<cfif application.rbs.setting.showlocationcolours>
	<style>
	<cfloop query="locations"><cfoutput>
	<cfif len(colour)>
		th.#class# {background: #colour#; border-color: #colour#; color:white; font-weight:normal;}
		td.#class#.booked {border-left:4px solid #colour#;}
		td.#class#.first {border-top:4px solid #colour#; font-size: 80%;}
		td.#class#.free {}
	</cfif>
	</cfoutput>
	</cfloop>
	table tbody tr td.booked {border-top:none; border-width:0; background: #f4f4f4}
	tr.hour {border-top:2px solid #ccc;}
	</style>
</cfif>

<table class="table table-condensed">
	<thead>
		<tr>
			<th>Time</th>
			<cfloop query="locations">
				<cfquery dbtype="query" name="locationEvents">
				SELECT * FROM events WHERE locationid = <cfqueryparam cfsqltype="cf_sql_numeric" value="#id#">;
				</cfquery>
				<cfoutput>
				<th class="#class#">
					#name#
				</th>
				</cfoutput>
			</cfloop>
		</tr>
	</thead>
	<tbody>
		<cfset counter=1>
		<cfloop from="#day.starttime#" to="#day.endtime#" index="i" step="#CreateTimeSpan(0,0,application.rbs.setting.calendarSlotMinutes,0)#">
  			<cfoutput>

 				<cfif timeFormat(i, "MM") EQ "00">
 					<tr class="hour">
	 				<th><strong>#timeFormat(i, "HH:MM")#</strong></th>
				<cfelse>
					<tr>
 					<th  class=""><small>#timeFormat(i, "HH:MM")#</small></th>
 				</cfif>
 				<cfloop from="1" to="#arraylen(m)#" index="z">
 					<cfoutput>
 					<td class="#m[z][counter]['class']#">#m[z][counter]["content"]#</td>
 					</cfoutput>
 				</cfloop>
 			</tr>
	 		</cfoutput>
	 		<cfset counter++>
 		</cfloop>
	</tbody>
</table>

<cffunction name="_timeParse" hint="Must be a better way of doing this...">
	<cfargument name="string">
	<cfset var r="">
	<cfset r=replaceNoCase(arguments.string, "am", "", "all")>
	<cfset r=replaceNoCase(r, "pm", "", "all")>
	<cfif arguments.string CONTAINS "pm">
		<cfset r=(r + 12)>
	</cfif>
	<cfreturn r>
</cffunction>