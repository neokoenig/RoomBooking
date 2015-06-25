<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Agenda Filter --->

<cfoutput>
	#panel(title="Filter", class="hidden-print panel-primary")#
		#startFormTag(action="list", method="post", name="listfilter")#
		#hiddenFieldTag(name="filterActive", value=1)#
		<div class="row">
			<div class="col-md-2">
				#textFieldTag(name="datefrom", 	  value=params.datefrom, 	label="From")#
			</div>
			<div class="col-md-2">
				#textFieldTag(name="dateto",   value=params.dateto, 	label="To")#
			</div>
			<div class="col-md-3">
				#selectTag(name="location", multiple=true, options=locations, label="Locations", selected=params.location, includeBlank="[All Locations]")#
				<p class="help-block">Ctrl+click to select multiple locations</p>
			</div>

			<div class="col-md-2">
				#selectTag(name="status", includeBlank="&lt;any&gt;",  options="pending,approved,denied", 	label="Status")#
			</div>
			<div class="col-md-1">
				#submitTag(Value="Go", class="btn btn-primary filter-pushdown")#
			</div>
		</div>
		#endFormTag()#
	#panelEnd()#
</cfoutput>