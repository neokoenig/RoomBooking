<!---================= Room Booking System / https://github.com/neokoenig =======================--->
<!--- Agenda Filter --->

<cfoutput>
	#panel(title=l("Filter"), class="hidden-print panel-primary")#
		#startFormTag(action="list", method="get", name="listfilter")#
		#hiddenFieldTag(name="filterActive", value=1)#
		#hiddenFieldTag(name="controller", value=params.controller)#
		#hiddenFieldTag(name="action", value=params.action)#
		<div class="row">
			<div class="col-md-4">
				<div class="row">
					<div class="col-md-6">
						#textFieldTag(name="datefrom", 	  value=params.datefrom, 	label=l("From"))#
					</div>
					<div class="col-md-6">
						#textFieldTag(name="dateto",   value=params.dateto, 	label=l("To"))#
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						#textFieldTag(name="q",   value=params.q, 	label=l("Keyword"))#
					</div>
				</div>
			</div>
			<div class="col-md-3">
				#selectTag(name="location", multiple=true, options=locations, label=l("Locations"), selected=params.location, includeBlank="["&l("All Locations") & "]")#
				<p class="help-block">#l("Ctrl+click to select multiple locations")#</p>
			</div>

			<div class="col-md-2">
				#selectTag(name="status", includeBlank="&lt;" & l("any") & "&gt;",  options="pending,approved,denied", 	label="Status")#
			</div>
			<div class="col-md-1">
				#submitTag(Value="Go", class="btn btn-primary filter-pushdown")#
			</div>
		</div>
		#endFormTag()#
	#panelEnd()#
</cfoutput>