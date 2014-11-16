<cfoutput>
<div class="row">
		<div class="col-sm-2">
	<!--- Prev --->
	#linkTo(text="<i class='glyphicon glyphicon-chevron-left'></i> Prev", params="y=#year(day.yesterday)#&m=#month(day.yesterday)#&d=#day(day.yesterday)#", class="btn btn-info btn-block hidden-print")#
		</div>
		<div class="col-sm-8">
		#startFormTag()#
			#textFieldTag(name="thedate", value=dateFormat(day.thedate, "dddd dd mmm yyyy"), label="Foo", labelClass="hide")#
		#endFormTag()#
		</div>
		<div class="col-sm-2">
	<!--- Next --->
	#linkTo(text="Next <i class='glyphicon glyphicon-chevron-right'></i>", params="y=#year(day.tomorrow)#&m=#month(day.tomorrow)#&d=#day(day.tomorrow)#", class="btn btn-info btn-block hidden-print")#
		</div>
</div>
</cfoutput>