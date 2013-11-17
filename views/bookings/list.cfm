<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<cfparam name="events">
<cfoutput>
	#includePartial(partial = "list/filter")# 
	#panel(title="Events")# 
 <cfif events.recordcount>
 <cfif application.rbs.setting.showlocationcolours> 
<style>
.header-row {border-top:2px solid ##222;}
<cfloop query="locations"><cfif len(colour)>.#class# {border-left: 6px solid #colour#; }</cfif>
</cfloop>
</style>
</cfif>
<table class="table table-condensed   table-striped">
	<thead>
		<tr> 
			<th colspan=2>Date</th> 
			<th>Location</th>     
			<th>Title</th>
			<th>Layout</th>  
			<th>Description</th>  
		</tr>
	</thead>
	<tbody>

	<!--- 
		For date output, we want to hide the date if the event after this one is on the same day and only show the time
		currentLoopDate is compared to current rows start date and uses alternative formatting if required
	--->	
	<cfset currentLoopDate=_formatDate(events.start)>
	<cfset isDateRow=1>

	<cfloop query="events">
	
		<cfif len(eventid)>
			<cfif currentLoopDate NEQ _formatDate(start)> 
				<cfset isDateRow=1>
			</cfif>
			<tr class="<cfif isDateRow>header-row</cfif>">  
			<td width=100> 
				<cfif isDateRow>  
				#_formatDate(start)#
				</cfif>
			</td> 
			<td width=100>#_formatTime(start)# - #_formatTime(end)#</td>
			<td width=150 class="#class#">#name#<br /><small>#description#</small></td> 
			<td>#title#</td>
			<td>#layoutstyle#</td> 
			<td>
			<cfif len(eventdescription)>
				#eventdescription#<br />
			</cfif>
			<small>
			<cfif len(contactemail) AND len(contactname)>
				Contact: <a href="mailto:#contactemail#">#contactname#</a> 
			<cfelseif len(contactname)>
				Contact: #contactname# 
			</cfif>
			<cfif len(contactno)>
				(#contactno#)
			</cfif>
		</small></td>  
		</tr>
		</cfif>
		<cfset currentLoopDate=_formatDate(start)>
		<cfset  isDateRow=0>
	</cfloop>
	</tbody>
</table>
<cfelse>
<div class="alert alert-danger"><strong>Sorry!</strong>, No events returned for that month</div>	
 </cfif>
 #panelEnd()#
</cfoutput>
