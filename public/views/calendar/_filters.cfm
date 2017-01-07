<cfparam name="locations">
<cfoutput>
<div class="box box-default">
	<div class="box-body ">
		<div id="filters">
        	<!--- All --->
        	<button type="button" class="btn btn-xs btn-default locationfilter" title="All" data-filtertype="none" data-id=0>#l('All')#</button>
		 	<!--- Buildings & Rooms--->
			<div class="btn-group">
				<cfloop from="1" to="#arraylen(locations)#" index="i">
					<cfif locations[i]["type"] == "building">
						<div class="btn-group">
							<button href=""  class="btn btn-xs  btn-default  locationfilter" title="#locations[i]['description']#" data-filtertype="#locations[i]['type']#" data-id="#locations[i]['id']#">
								<i style="color:###locations[i]['hexcolour']#" class="fa #locations[i]['icon']#"></i> #locations[i]['title']#
							</button>
							<button type="button" class="btn btn-xs btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
			                    <span class="caret"></span>
			                    <span class="sr-only">Toggle Dropdown</span>
			                </button>
				            <ul class="dropdown-menu" role="menu">
								<cfif structKeyExists(locations[i], "floors") && !structIsEmpty(locations[i]["floors"])>
								 <cfloop collection="#locations[i]["floors"]#" item="floor">
								 	<cfif floor != "0">
										<li class="" style="padding:5px;">#floor#</li>
										<li class="divider"></li>
									</cfif>
									<cfloop from="1" to="#arraylen(locations[i]["floors"][floor])#" index="r">
										<li><a href="" title="#locations[i]['floors'][floor][r]['description']#" class="locationfilter" data-filtertype="#locations[i]["floors"][floor][r]['type']#" data-id="#locations[i]["floors"][floor][r]['id']#">
											<i class="fa #locations[i]["floors"][floor][r]['icon']#" style="color:###locations[i]["floors"][floor][r]['hexcolour']#"></i> #locations[i]["floors"][floor][r]['title']#
										</a></li>
									</cfloop>
								 </cfloop>
								</cfif>
							</ul>
						</div>
					<cfelse>
						<!--- Orphaned Rooms --->
						<button type="button" class="btn btn-xs btn-default locationfilter" title="#locations[i]['description']#" data-filtertype="#locations[i]['type']#" data-id="#locations[i]['id']#">
							<i class="fa #locations[i]['icon']#" style="color:###locations[i]['hexcolour']#"></i> #locations[i]['title']#
						</button>
					</cfif>
				</cfloop>
			</div>
		</div>
	</div><!-- /.box-body -->
</div><!-- /. box -->
</cfoutput>
