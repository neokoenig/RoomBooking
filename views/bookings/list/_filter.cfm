<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Agenda Filter --->
<cfparam name="params.m">
<cfparam name="params.y">
<cfparam name="params.location" default="">

<cfoutput>
	#panel(title="Filter", class="hidden-print panel-primary")#
		#startFormTag(action="list", method="get")#
		#hiddenFieldTag(name="filterActive", value=1)#
		<div class="row">
			<div class="col-md-2">
				#selectTag(name="m", options="#_monthList()#", append="", prepend="", selected=params.m, textField="v", valueField="k")#
			</div>
			<div class="col-md-2">
				#selectTag(name="y", options="#_yearList()#", append="", prepend="", selected=params.y)#
			</div>
			<div class="col-md-2">
				#selectTag(name="location", options=locations, append="", prepend="", selected=params.location, includeBlank="[All Locations]")#
			</div>
			<div class="col-md-1">
				#submitTag(Value="Go", class="btn btn-primary filter-pushdown")#
			</div>
		</div>
		#endFormTag()#
	#panelEnd()#
</cfoutput>