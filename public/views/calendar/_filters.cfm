<cfprocessingdirective suppressWhitespace="true">
<cfparam name="locations">
<cfoutput>
<div id="filterbar">
<div id="filters" class="box box-default">
<div class="box-body ">
<button type="button" class="btn btn-xs btn-default locationfilter btn-flat" title="All" data-filtertype="none" data-id="0">
All</button>
<div class="btn-group"></div>
</div><!--/box-body-->
</div><!--/filters-->
</div><!--/filterbar-->
<!---div id="filters" class="box box-default">
	<div class="box-body ">
        	<!--- All --->
        	<button type="button" class="btn btn-xs btn-default locationfilter btn-flat" title="All" data-filtertype="none" data-id=0>#l('All')#</button>
		 	<!--- Buildings & Rooms--->
			<div class="btn-group">
				<cfloop from="1" to="#arraylen(locations)#" index="i">
					<cfif locations[i]["type"] EQ "building">
						<div class="btn-group">
							<button href=""  class="btn btn-xs  btn-default  btn-flat  locationfilter" title="#locations[i]['description']#" data-filtertype="#locations[i]['type']#" data-id="#locations[i]['id']#">
								<i style="color:###locations[i]['hexcolour']#" class="fa #locations[i]['icon']#"></i> #locations[i]['title']#
							</button>
							<button type="button" class="btn btn-xs  btn-flat btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
			                    <span class="caret"></span>
			                    <span class="sr-only">Toggle Dropdown</span>
			                </button>
				            <ul class="dropdown-menu" role="menu">
								<cfif structKeyExists(locations[i], "groupby") && !structIsEmpty(locations[i]["groupby"])>
								 <cfloop collection="#locations[i]["groupby"]#" item="floor">
								 	<cfif floor NEQ "0">
										<li class="dropdown-header">#floor#</li>
										<li class="divider"></li>
									</cfif>
									<cfloop from="1" to="#arraylen(locations[i]["groupby"][floor])#" index="r">
										<li><a href="" title="#locations[i]['groupby'][floor][r]['description']#" class="locationfilter" data-filtertype="#locations[i]["groupby"][floor][r]['type']#" data-id="#locations[i]["groupby"][floor][r]['id']#">
											<i class="fa #locations[i]["groupby"][floor][r]['icon']#" style="color:###locations[i]["groupby"][floor][r]['hexcolour']#"></i> #locations[i]["groupby"][floor][r]['title']#
										</a></li>
									</cfloop>
								 </cfloop>
								</cfif>
							</ul>
						</div>
					<cfelse>
						<!--- Orphaned Rooms --->
						<button type="button" class="btn btn-xs btn-default  btn-flat locationfilter" title="#locations[i]['description']#" data-filtertype="#locations[i]['type']#" data-id="#locations[i]['id']#">
							<i class="fa #locations[i]['icon']#" style="color:###locations[i]['hexcolour']#"></i> #locations[i]['title']#
						</button>
					</cfif>
				</cfloop>
			</div>
	</div><!-- /.box-body -->
</div---><!-- /. box -->
</cfoutput>
</cfprocessingdirective>
