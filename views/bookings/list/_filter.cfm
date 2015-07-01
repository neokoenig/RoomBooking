<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Agenda Filter --->

<cfoutput>
	#panel(title="Filter", class="hidden-print panel-primary")#
		#startFormTag(action="list", method="get", name="listfilter")#
		#hiddenFieldTag(name="filterActive", value=1)#
		#hiddenFieldTag(name="controller", value=params.controller)#
		#hiddenFieldTag(name="action", value=params.action)#
		<div class="row">
			<div class="col-md-4">
				<div class="row">
					<div class="col-md-6">
						#textFieldTag(name="datefrom", 	  value=params.datefrom, 	label="From")#
					</div>
					<div class="col-md-6">
						#textFieldTag(name="dateto",   value=params.dateto, 	label="To")#
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						#textFieldTag(name="q",   value=params.q, 	label="Keyword")#
					</div>
				</div>
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