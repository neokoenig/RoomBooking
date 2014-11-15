<cfoutput>
<div class="btn-group btn-group-justified">
#linkTo(text="<i class='glyphicon glyphicon-chevron-left'></i> Prev", params="y=#year(day.yesterday)#&m=#month(day.yesterday)#&d=#day(day.yesterday)#", class="btn btn-info")#
	 	<div class="btn btn-default">
		 	#dateFormat(day.thedate, "dddd dd mmm yyyy")#
		 	<cfif isToday>
				<small>(Today)</small>
		 	</cfif>
		</div>

#linkTo(text="Next <i class='glyphicon glyphicon-chevron-right'></i>", params="y=#year(day.tomorrow)#&m=#month(day.tomorrow)#&d=#day(day.tomorrow)#", class="btn btn-info")#
</div>
</cfoutput>